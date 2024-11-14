close all;
clear all;

UWB = [ 5.5,	4.5;
	5.5,	20;
	5.5,	34];

ODB = [ 54,	10.5;
	54, 	16.5;
	54,	24.5;
	54, 	30.5];

Wym = [60,40];

Obiekt = [36, 22.5];

figure;
hold on; xlim([0 Wym(1)]); ylim([0 Wym(2)]); grid on;
set(gca,'xtick',[0:1:Wym(1)]);
set(gca,'ytick',[0:1:Wym(2)]);
scatter( UWB(:,1), UWB(:,2), 'filled');
scatter( ODB(:,1), ODB(:,2), 'filled');
rectangle( 'Position', [Obiekt(1) Obiekt(2) 1 1], 'EdgeColor', 'b', 'FaceColor', 'c','LineWidth', 1);

zablokowane = [];
licznikz = 1;
bezproblemu = [];
licznikb = 1;
for i=1:3
	for j=1:4
		kolorek = 'g';
		xU = UWB(i,1);
		yU = UWB(i,2);
		xO = ODB(j,1);
		yO = ODB(j,2);

		if( wektorsektor( xU, yU, xO, yO, Obiekt(1), Obiekt(2),1,1) == 1)
			kolorek = 'r';
			zablokowane(licznikz,:) = [xU, yU, xO, yO];
			licznikz = licznikz + 1;
		else 
			bezproblemu(licznikb,:) = [xU, yU, xO, yO];
			licznikb = licznikb + 1;
		end

		line( [ xU xO ], [ yU yO ], 'Color', kolorek);
	end
end


figure;
hold on; xlim([0 Wym(1)]); ylim([0 Wym(2)]); grid on;
set(gca,'xtick',[0:1:Wym(1)]);
set(gca,'ytick',[0:1:Wym(2)]);
scatter( UWB(:,1), UWB(:,2), 'filled');
scatter( ODB(:,1), ODB(:,2), 'filled');
for x=0:1:Wym(1)
	for y=0:1:Wym(2)
		if (czyMozliwe(x,y,zablokowane,bezproblemu))
			rectangle( 'Position', [x y 1 1], 'EdgeColor', 'b', 'FaceColor', 'c','LineWidth', 1);
		end
	end
end

for i=1:3
	for j=1:4
		kolorek = 'g';
		xU = UWB(i,1);
		yU = UWB(i,2);
		xO = ODB(j,1);
		yO = ODB(j,2);

		if( wektorsektor( xU, yU, xO, yO, Obiekt(1), Obiekt(2),1,1) == 1)
			kolorek = 'r';
			zablokowane(licznikz,:) = [xU, yU, xO, yO];
			licznikz = licznikz + 1;
		else 
			bezproblemu(licznikb,:) = [xU, yU, xO, yO];
			licznikb = licznikb + 1;
		end

		line( [ xU xO ], [ yU yO ], 'Color', kolorek);
	end
end

% czyMozliwe(36,22,zablokowane,bezproblemu);



function odp = czyMozliwe(xs,ys,z,b)
	zablokowanych = 0;
	for i=1:length(z(:,1))
		x1 = z(i,1);
		y1 = z(i,2);
		x2 = z(i,3);
		y2 = z(i,4);
		zablokowanych = zablokowanych + wektorsektor(x1,y1,x2,y2,xs,ys,1,1);
	end
	odblokowanych = 0;
	for j=1:length(b(:,1))
		x1 = b(j,1);
		y1 = b(j,2);
		x2 = b(j,3);
		y2 = b(j,4);
		odblokowanych = odblokowanych - wektorsektor(x1,y1,x2,y2,xs,ys,1,1);
	end
	odp = (zablokowanych == length(z(:,1)) && odblokowanych == length(b(:,1)));
end