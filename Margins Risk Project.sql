--Tables located in Sullivan Donahue Database

CREATE TABLE ClientTradeData (
	CustID INT PRIMARY KEY Identity (10,1),
	CashAvail INT,
	MGNonFile VARCHAR(10),
	Retireacct VARCHAR(10),
	Cashreqmt INT,
	ITM VARCHAR(10),
	OpenOrder varchar(10),
	Numofcontracts INT
	);

Drop table clienttradedata;

ALTER TABLE ClientTradeData ADD RiskExp AS (CashAvail-Cashreqmt);
select * from ClientTradeData;

INSERT INTO ClientTradeData VALUES (20000, 'YES', 'YES', 50000, 'YES', 'YES', 2);
INSERT INTO ClientTradeData VALUES (60000, 'NO', 'YES', 100000, 'NO', 'NO', 3);
INSERT INTO ClientTradeData VALUES (30000, 'YES', 'NO', 70000, 'NO', 'NO', 2);
INSERT INTO ClientTradeData VALUES (50000, 'YES', 'NO', 10000, 'YES', 'YES', 4);
INSERT INTO ClientTradeData VALUES (70000, 'YES', 'YES', 50000, 'YES', 'YES', 4);
INSERT INTO ClientTradeData VALUES (90000, 'YES', 'NO', 40000, 'YES', 'NO', 3);
INSERT INTO ClientTradeData VALUES (60000, 'YES', 'NO', 30000, 'NO', 'YES', 3);
INSERT INTO ClientTradeData VALUES (20000, 'YES', 'YES', 50000, 'NO', 'YES', 5);
INSERT INTO ClientTradeData VALUES (40000, 'NO', 'YES', 50000, 'YES', 'YES', 4);
INSERT INTO ClientTradeData VALUES (70000, 'NO', 'NO', 120000, 'YES', 'YES', 6);
INSERT INTO ClientTradeData VALUES (80000, 'YES', 'NO', 50000, 'YES', 'NO', 3);
INSERT INTO ClientTradeData VALUES (50000, 'YES', 'NO', 100000, 'NO', 'YES', 4);
INSERT INTO ClientTradeData VALUES (80000, 'YES', 'NO', 50000, 'YES', 'YES', 4);
INSERT INTO ClientTradeData VALUES (30000, 'YES', 'NO', 158000, 'YES', 'NO', 3);
INSERT INTO ClientTradeData VALUES (45000, 'NO', 'NO', 121000, 'YES', 'YES', 5);
INSERT INTO ClientTradeData VALUES (48000, 'NO', 'NO', 143000, 'YES', 'NO', 8);
INSERT INTO ClientTradeData VALUES (38000, 'YES', 'YES', 167000, 'NO', 'YES', 3);


TRUNCATE TABLE ClientTradeData;

drop table clientinfo;

CREATE TABLE ClientInfo (
	Social VARCHAR(50) PRIMARY KEY,
	CustID INT Identity (10, 1) REFERENCES ClientTradeData(CustID),
	First_Name varchar(50),
	Last_Name varchar(50),
	Email varchar(50),
	phone varchar(50),
	);
	



INSERT INTO ClientInfo VALUES ('429-32-4823', 'Bob', 'Evans', 'BobEvans@gmail.com', '630-877-1245');
INSERT INTO ClientInfo VALUES ('039-35-4623', 'Rick', 'Sanchez', 'RS@gmail.com', '630-905-6494');
INSERT INTO ClientInfo VALUES ('594-49-4821', 'Mike', 'Schwartz', 'MS@gmail.com', '630-868-7886');
INSERT INTO ClientInfo VALUES ('397-56-4824', 'Peter', 'Parker', 'PP@gmail.com', '630-564-2456');
INSERT INTO ClientInfo VALUES ('287-44-4827', 'Jake', 'Luffy', 'JL@gmail.com', '630-434-6424');
INSERT INTO ClientInfo VALUES ('490-77-4824', 'Peter', 'Quill', 'PQ@gmail.com', '630-999-6432');
INSERT INTO ClientInfo VALUES ('478-79-4822', 'Sara', 'Roberts', 'SR@gmail.com', '630-244-2451');
INSERT INTO ClientInfo VALUES ('499-34-4828', 'Lois', 'Lane', 'LL@gmail.com', '630-564-1212');
INSERT INTO ClientInfo VALUES ('364-18-4829', 'Scarlett', 'Rogers', 'SR@gmail.com', '630-689-1245');
INSERT INTO ClientInfo VALUES ('429-15-4825', 'Mike', 'Jacobs', 'MJ@gmail.com', '630-345-1242');
INSERT INTO ClientInfo VALUES ('908-04-4825', 'Alan', 'Jeffries', 'AJ@gmail.com', '630-425-1245');
INSERT INTO ClientInfo VALUES ('665-03-4876', 'Steve', 'Smith', 'SSP@gmail.com', '630-423-1289');
INSERT INTO ClientInfo VALUES ('429-23-4809', 'Lillian', 'James', 'Lily@gmail.com', '630-425-1245');
INSERT INTO ClientInfo VALUES ('469-49-4852', 'Paul', 'Allen', 'PA@gmail.com', '630-786-1245');
INSERT INTO ClientInfo VALUES ('529-46-4839', 'Patrick', 'Bateman', 'PB@gmail.com', '630-428-6745');
INSERT INTO ClientInfo VALUES ('929-89-4806', 'Bruce', 'Wayne', 'BW@gmail.com', '630-428-9045');
INSERT INTO ClientInfo VALUES ('329-67-4844', 'Kent', 'Clark', 'KC@gmail.com', '630-428-1287');

drop table Clientinfo;
Truncate Table ClientInfo;

select * from ClientInfo; 

select * from ClientTradeData 
where CashAvail < Cashreqmt;

select * from clientTradeData WHERE EXISTS (select 5);


--show client info with risk exposure----------------------------------------------------------------------------------------------------------------

select a.custID, RiskExp AS Potential_Margin_Balance, numofcontracts, first_name, last_name, Email, Phone, social  FROM ClientTradeData a
INNER JOIN ClientInfo b ON b.CustID = a.CustID
Where RiskExp < 0
Group by a.custID, first_name, last_name, Email, phone, RiskExp, numofcontracts, social
order by Potential_Margin_Balance;



--show client info with risk exposure and number of contracts above 3-----------------------------------------------------------------------------------

select a.custID, RiskExp AS Potential_Margin_Balance, numofcontracts, first_name, last_name, Email, Phone, social  FROM ClientTradeData a
INNER JOIN ClientInfo b ON b.CustID = a.CustID
Where RiskExp < 0
Group by a.custID, first_name, last_name, Email, phone, RiskExp, numofcontracts, social
having avg(numofcontracts) > 3
order by Potential_Margin_Balance;






-----show client info with risk exposure that is higher than the average risk exposure --------------------------------------------------------------------

select custID, Riskexp from ClientTradeData 
Where RiskEXP < (

select avg(RiskExp) AS average_risk_exposure FROM ClientTradeData
WHERE RiskExp < 0

)
group by custID, Riskexp
order by Riskexp;
----------------------------------------------------------------------------------------------------------------------------------------------------------

select * from ClientTradeData 
Where RiskEXP < 0 AND RiskExp 


select * from ClientINFO a inner join ClientTradeData b
ON a.CustID = b.CustID
order by a.custID; 



--User Defined Function to locate information on client that may need to be called out to, function allows for easy streamline to find data on a specific client based on using custID as input. --------------------------------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION FN_GetClientData (@CustID INT)
Returns TABLE
	AS
	Return 
		(
		select a.CustID, First_Name, Last_Name, RiskExp, Email, phone FROM ClientTradeData a INNER JOIN ClientInfo b
		ON a.custID = b.CustID
		WHERE a.CustID = @CustID
		);

select * from FN_GetClientData (14);

select a.CustID, First_Name, Last_Name, RiskExp, Email, phone FROM ClientTradeData a INNER JOIN ClientInfo b
		ON a.custID = b.CustID
		WHERE a.CustID = 14; --checks out.



--VIEW STATEMENT-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- creating a view statement allows certain data pieces to be seen without anything unecessary or privacy concerning such as social security number. Your teammates can reference this table without having to
--see anything additional unecessary details as far as privacy is concerned.

CREATE VIEW vw_AtRiskClients
AS

	select a.custID, RiskExp AS Potential_Margin_Balance, numofcontracts, first_name, last_name, Email, Phone FROM ClientTradeData a INNER JOIN ClientInfo b 
	ON b.CustID = a.CustID Where RiskExp < 0 Group by a.custID, first_name, last_name, Email, phone, RiskExp, numofcontracts;

	select * from vw_AtRiskClients;


-- function using a view inside. 
--Without having to go back and query the whole database, you can create a function using the view you just created above. This helps with efficiency, and whoever is requesting info on a particular client, they can
--reference this table here. 

CREATE FUNCTION FN_GetClientDatastuff (@CustID INT)
Returns TABLE
	AS
	Return 
		(
		select CustID, First_Name, Last_Name, Potential_Margin_Balance, Email, phone FROM vw_AtRiskClients
		WHERE CustID = @CustID
		);

select * from FN_GetClientDatastuff (10);


------ Temporary Table --------------------------------------

SELECT * INTO #ClientTradeData From ClientTradeData
SELECT * INTO #ClientInfo FROM clientInfo

select a.custID, RiskExp AS Potential_Margin_Balance, numofcontracts, first_name, last_name, Email, Phone, social  FROM #ClientTradeData a
INNER JOIN #ClientInfo b ON b.CustID = a.CustID
Where RiskExp < 0
Group by a.custID, first_name, last_name, Email, phone, RiskExp, numofcontracts, social
order by Potential_Margin_Balance;


------- Stored Procedure---------------------------------------

CREATE PROCEDURE proc_ClientDatainfo
	@CustID INT

	AS 
	BEGIN
		SET NOCOUNT ON;
		select CustID, First_Name, Last_Name, Potential_Margin_Balance, Email, phone FROM vw_AtRiskClients
		WHERE CustID = @CustID

	END

	EXEC proc_ClientDatainfo 11;











------- Variable---------------------------------------------------- Note that variable tables cannot include an identity in them, so we created a new table with manual entries of new custIDs. 
select * from ClientTradingData;


CREATE TABLE ClientTradingData (
	CustID INT PRIMARY KEY,
	CashAvail INT,
	MGNonFile VARCHAR(10),
	Retireacct VARCHAR(10),
	Cashreqmt INT,
	ITM VARCHAR(10),
	OpenOrder varchar(10),
	Numofcontracts INT
	);

ALTER TABLE ClientTradingData ADD RiskExp AS (CashAvail-Cashreqmt);


INSERT INTO ClientTradingData VALUES (587, 20000, 'YES', 'YES', 50000, 'YES', 'YES', 2);
INSERT INTO ClientTradingData VALUES (624, 60000, 'NO', 'YES', 100000, 'NO', 'NO', 3);
INSERT INTO ClientTradingData VALUES (879, 30000, 'YES', 'NO', 70000, 'NO', 'NO', 2);
INSERT INTO ClientTradingData VALUES (889, 50000, 'YES', 'NO', 10000, 'YES', 'YES', 4);
INSERT INTO ClientTradingData VALUES (646, 70000, 'YES', 'YES', 50000, 'YES', 'YES', 4);
INSERT INTO ClientTradingData VALUES (793, 90000, 'YES', 'NO', 40000, 'YES', 'NO', 3);
INSERT INTO ClientTradingData VALUES (132, 60000, 'YES', 'NO', 30000, 'NO', 'YES', 3);
INSERT INTO ClientTradingData VALUES (123, 20000, 'YES', 'YES', 50000, 'NO', 'YES', 5);
INSERT INTO ClientTradingData VALUES (445, 40000, 'NO', 'YES', 50000, 'YES', 'YES', 4);
INSERT INTO ClientTradingData VALUES (655, 70000, 'NO', 'NO', 120000, 'YES', 'YES', 6);
INSERT INTO ClientTradingData VALUES (731, 80000, 'YES', 'NO', 50000, 'YES', 'NO', 3);
INSERT INTO ClientTradingData VALUES (578, 50000, 'YES', 'NO', 100000, 'NO', 'YES', 4);
INSERT INTO ClientTradingData VALUES (648, 80000, 'YES', 'NO', 50000, 'YES', 'YES', 4);
INSERT INTO ClientTradingData VALUES (189, 30000, 'YES', 'NO', 158000, 'YES', 'NO', 3);
INSERT INTO ClientTradingData VALUES (155, 45000, 'NO', 'NO', 121000, 'YES', 'YES', 5);
INSERT INTO ClientTradingData VALUES (277, 48000, 'NO', 'NO', 143000, 'YES', 'NO', 8);
INSERT INTO ClientTradingData VALUES (323, 38000, 'YES', 'YES', 167000, 'NO', 'YES', 3);



DECLARE @TradeData TABLE (
	CustID INT,
	CashAvail INT,
	MGNonFile VARCHAR(10),
	Retireacct VARCHAR(10),
	Cashreqmt INT,
	ITM VARCHAR(10),
	OpenOrder varchar(10),
	Numofcontracts INT,
	RiskExp INT
	);
	
INSERT INTO @TradeData (
	CustID,
	CashAvail,
	MGNonFile,
	Retireacct,
	Cashreqmt,
	ITM,
	OpenOrder,
	Numofcontracts,
	RiskExp
	)

	select * From ClientTradingData Where RiskExp < 0;

	select * from @TradeData
	GO



	CREATE TABLE ClientData (
	Social VARCHAR(50) PRIMARY KEY,
	CustID INT,
	First_Name varchar(50),
	Last_Name varchar(50),
	Email varchar(50),
	phone varchar(50),
	);

INSERT INTO ClientData VALUES ('429-32-4823', 587, 'Bob', 'Evans', 'BobEvans@gmail.com', '630-877-1245');
INSERT INTO ClientData VALUES ('039-35-4623', 624, 'Rick', 'Sanchez', 'RS@gmail.com', '630-905-6494');
INSERT INTO ClientData VALUES ('594-49-4821', 879, 'Mike', 'Schwartz', 'MS@gmail.com', '630-868-7886');
INSERT INTO ClientData VALUES ('397-56-4824', 889, 'Peter', 'Parker', 'PP@gmail.com', '630-564-2456');
INSERT INTO ClientData VALUES ('287-44-4827', 646, 'Jake', 'Luffy', 'JL@gmail.com', '630-434-6424');
INSERT INTO ClientData VALUES ('490-77-4824', 793, 'Peter', 'Quill', 'PQ@gmail.com', '630-999-6432');
INSERT INTO ClientData VALUES ('478-79-4822', 132, 'Sara', 'Roberts', 'SR@gmail.com', '630-244-2451');
INSERT INTO ClientData VALUES ('499-34-4828', 123, 'Lois', 'Lane', 'LL@gmail.com', '630-564-1212');
INSERT INTO ClientData VALUES ('364-18-4829', 445, 'Scarlett', 'Rogers', 'SR@gmail.com', '630-689-1245');
INSERT INTO ClientData VALUES ('429-15-4825', 655, 'Mike', 'Jacobs', 'MJ@gmail.com', '630-345-1242');
INSERT INTO ClientData VALUES ('908-04-4825', 731, 'Alan', 'Jeffries', 'AJ@gmail.com', '630-425-1245');
INSERT INTO ClientData VALUES ('665-03-4876', 578, 'Steve', 'Smith', 'SSP@gmail.com', '630-423-1289');
INSERT INTO ClientData VALUES ('429-23-4809', 648, 'Lillian', 'James', 'Lily@gmail.com', '630-425-1245');
INSERT INTO ClientData VALUES ('469-49-4852', 189, 'Paul', 'Allen', 'PA@gmail.com', '630-786-1245');
INSERT INTO ClientData VALUES ('529-46-4839', 155, 'Patrick', 'Bateman', 'PB@gmail.com', '630-428-6745');
INSERT INTO ClientData VALUES ('929-89-4806', 277, 'Bruce', 'Wayne', 'BW@gmail.com', '630-428-9045');
INSERT INTO ClientData VALUES ('329-67-4844', 323, 'Kent', 'Clark', 'KC@gmail.com', '630-428-1287');

select * from clientdata; 
select CustID, first_Name, Last_Name, Social, Phone, Email From Clientdata;

DECLARE @Clientsdata TABLE (
	Social VARCHAR(50),
	CustID INT,
	First_Name varchar(50),
	Last_Name varchar(50),
	Email varchar(50),
	phone varchar(50)
	);

INSERT INTO @Clientsdata (
	Social,
	CustId,
	First_Name,
	Last_Name,
	Email,
	Phone
	) 

select * from Clientdata where Email like ('%com%');

select * FROM @Clientsdata
GO

--------creating a temporary table using a view statement--------------------

select * from vw_AtRiskClients;

Select * INTO #RiskyClients FROM vw_AtRiskClients;

select * from #RiskyClients

ALTER TABLE #RiskyClients ADD Gender varchar(1) 

--- Above shows us that we can use view statements to be entered in and also created as temporary tables. Could be useful.