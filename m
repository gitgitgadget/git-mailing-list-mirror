Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08AA1A5A4
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rdt.co.uk header.i=@rdt.co.uk header.b="k4W/u8ry"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2062.outbound.protection.outlook.com [40.107.121.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2697EDF
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 04:00:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZ4g4IDw7O1X7mV2PGmxb9geg8yTM4ebdsF0JbAoX5ybaWaaXwXYpxh2FC5fZcUU7UnA/GEs5Znm7gVbuYWAun+m0xU/7BURC8RCrGY7+7Up9XXqBB+Z+KoGyc4bHzEJtxMZ/V3q7fdkTK/X+Pe8Kux+henq38CESWgGODXG1aVfA8Ewi5BvYUbZjSSCPnbpbPbhVrLXAPkoZLwDfpmkNJ8gx8AY8a2hj1idfU8vJbLumE8x+Bm3iG/Z1Wm1+ffMkdIJTqM/xOfqrkTwMFN2OaVb2lsabQDDtS084HWrNfHg1RNzWVZvCQjvj1RILhyY9Saohryctz0XOAopsJ1RQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ztwzZf9P+rcxDTD4JipiV3wTKdV0M9dTF6qzSPRl5E=;
 b=TpdthhDZordXF3wY+6CzI/i91PnS6dIwHCOodtjqELb9md3LX0Ot8+7FFdSpuB7f4lFzFL45q+CXwLkbxqPI3zs0picABqZgFEztgp3VuSndBr+cA6lrYcvrKhDY0ofdUzB96WsMXgXs3Oh7EG7qRaVL9gxW7XwydJ/6S6rAQWwU7Cqi8sHdqHCr5ekXqjCKqsysK12Y5tdU83ac70OHIwgvlUVSuwsjp4DpAem8LD3e75rNSxG28fmd72BWBYtft//T0JovP6v3qFMiVE97hqwO++4YYYe3/9aEzaDQJfIH1K6wK1q7Vvbwp0fT8frneUEiZdVlPxUSgPXKLIcl4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rdt.co.uk; dmarc=pass action=none header.from=rdt.co.uk;
 dkim=pass header.d=rdt.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rdt.co.uk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ztwzZf9P+rcxDTD4JipiV3wTKdV0M9dTF6qzSPRl5E=;
 b=k4W/u8ry6oXQzAO4276BA1GAcoYSK3jyHt84z+7ns2+w+m2cJ076IMb55HldZ7ggFThbPrJyJk3RDGu+dlWwR90G3AOqePcXQCjiL18CP7S5Ila2MbLMfXHvfFxnEFZDYEbWKfzdXnGqqfRErCXJLkm2++94C6FUDwa5aGb9LRU=
Received: from LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2fa::11)
 by LO4P265MB6447.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 12:00:53 +0000
Received: from LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e490:75a2:85fd:8182]) by LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e490:75a2:85fd:8182%3]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 12:00:53 +0000
From: Jeremy Pridmore <jpridmore@rdt.co.uk>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: Paul Baumgartner <pbaumgartner@rdt.co.uk>
Subject: Git Rename Detection Bug
Thread-Topic: Git Rename Detection Bug
Thread-Index: AQHaEKezuvJpERqqjUCGcKSXk4fi+Q==
Date: Mon, 6 Nov 2023 12:00:53 +0000
Message-ID:
 <LO6P265MB6736043BE8FB607DB671D21EFAAAA@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rdt.co.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO6P265MB6736:EE_|LO4P265MB6447:EE_
x-ms-office365-filtering-correlation-id: 92f15091-7d0f-43b9-0b2e-08dbdec00709
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kw3YFQEulpYriAu7gNVtCcNHLHrBlYbcf6Lli3ewGcUYj9EyLjlaMLYV1k/9zAfgeGja7vdddNVEG2phX7bt5GKJTDeEmvdQ5J+zSbWa+ReIp14/Y71iiM24ifZ3So1w1HRFWe2Z+Nw6FH1i9xxRs/aRqludp77NZt5epjxWxDVi9hQNKSmzJ9eyuJiY1SSTvhpTw9yJ/ZnALRnFvoHHCoi65+iEE26uX7FW1Ik6YU9Tt/MhWKKTg6JxgImAUc4wAfiKRj8vQlke7QtS/I6SBLmrZ+CGdJ2n7pgPfSdFC3CYtQRU2gjzEtNeTPBJVlMQ4kPSWwsGJMsgZoa9ZISqW5PWTI3z7dUXGi/qcJyuHcoV9A0KcPfdWHda67KBRjKhJf1GlOSsioNjv6OF6EAg50+SOJf+R1PYpkBdDni3kJkMljys5yZr9ZJRgV5OK+Lb1X0J0sI3+uMgEifMTz7Mx/qIMfQk6R/Kc0/UsFirndhrCqT7QDcNxLF9TPvEFFs17EVNRYFb1UY4zI30hAuna6gKeJQt8vm5+A1Kst+kxOfq4X8Wmvkv5ch3be0zi8UP1g1Cp1TRwJ9HeCKsRV7j4rFThyXgK2J5nsfMa/sOJGB6SZVwOVQmz5SZ0r8XMDPbBYySo0QknYofqdxcF/SugX5gauh6aC80mkr+XknB89uNma7W+s7qVDgLm6QajxFr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39840400004)(136003)(376002)(396003)(230273577357003)(230173577357003)(230373577357003)(230473577357003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(7696005)(6506007)(9686003)(966005)(71200400001)(83380400001)(26005)(66574015)(30864003)(2906002)(5660300002)(66946007)(91956017)(41300700001)(316002)(66476007)(76116006)(66556008)(66446008)(64756008)(19627235002)(8676002)(4326008)(8936002)(52536014)(6916009)(38070700009)(38100700002)(3480700007)(33656002)(122000001)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/vg4zJjgSpDOdquwv+zyeJ83tiIR1pZ5pqbLH6kLjJxnwMrx1z22ZcM3Ud?=
 =?iso-8859-1?Q?QCCBTNbT5y6oVZD4XhMfvsmUOiEnw54okRA8t9Rlccceup2vWYCki3VkeK?=
 =?iso-8859-1?Q?ANgxZ8smBoCe7g4H8o5A4q4lhln9AqEAmVxoX6VZ5NMipweSxh0lnWiQns?=
 =?iso-8859-1?Q?YgThdPYqyb+B9VSubQ9Ic8tyURISIO/KQfPI+Boph+BGOoMF2IJ9jYeBL+?=
 =?iso-8859-1?Q?7ctdKKZbbEPUjDLbSZ6P+Wg1Is61kGFMrguVm5bfrXMuTn9YmaDmFRZRdL?=
 =?iso-8859-1?Q?oUa3ZXMUSfEgoboLjTcJmEECT6NktWHmVwl/c2yFxcF15bBeW4YPaFUHP3?=
 =?iso-8859-1?Q?7oBBVvg28aTb7XWJQtvheJPpwi4Q+bQLjYCP9Hwg/ZTZjIrUBttynxbvdF?=
 =?iso-8859-1?Q?WxPTLfzZA2ZA46EnbEAFgQZT1t1QIBEIPwci4189HtGtKkh8Uj+26v4Ftr?=
 =?iso-8859-1?Q?N7jp2dHQi80T+lrfylXIXaapnYHybpExvctlHoQvLToU/ZNFca/Z5uWfko?=
 =?iso-8859-1?Q?W2glJinhbBWMTxZTPrtRweCSqj30T3++27H+RJoRt5LMy82FCk74UJiUe2?=
 =?iso-8859-1?Q?ZMNDCG3lY66YGYvD1cbmKNQQhFrsIhXvc14uIu4QruOyOvi/YOhIIjOlK8?=
 =?iso-8859-1?Q?fRGVrN8zoboZ5iYx3fTfhYjEN0oEW4sxI2sjPMuSuBrQMHbhygN1ChnfbR?=
 =?iso-8859-1?Q?2Y0pDjzvV/ueSTT5LmSSkaq/X8DOmz7L6YJFOfGcUxmiH50l4dmTuJNmCB?=
 =?iso-8859-1?Q?NE0MJJfJzdEDjS9MhBStmYi49+pyRM1CfwSlUi28CruQsevDsG7NgvOAZi?=
 =?iso-8859-1?Q?s9I49R4qA8RaDn4Y+vuVK4MAmjFvgmRKIWHMvmIsaBl6wWA4ox273TUb8l?=
 =?iso-8859-1?Q?vp3ow8ctnDnsZAUYndOyt3OR+xMRMTg2NLPlQu5ggETdgDd8w+WaRowLYr?=
 =?iso-8859-1?Q?7GCvKOblY9L+KhHSb101NSsdOh2WbQV0JsO466osb9IOG5IgMsvgcGufBh?=
 =?iso-8859-1?Q?XO+QFEPzh/DOwskjIkT3ve8BjZY7IXzoZPItp3mddsoh4wDM3zXxbfyaK4?=
 =?iso-8859-1?Q?Psa324j3qsKyQwd7/udIDPHErd6ohSNPCC2fFKCHVJghzEONTCGjXXYGrC?=
 =?iso-8859-1?Q?1WCmUxwTQMaPWQvS2i1qYCmhQvvhKN5R3lPIrqOxfJrhvecDmX3WpFsYOm?=
 =?iso-8859-1?Q?eXWSf/HiSnPlOW6DKLd6BSZcHnn6sOHpEi+vUS1PvCyCvPpjFlhjW/ab4+?=
 =?iso-8859-1?Q?fVopwEl5s8FKxjCCgHRyvRiesguLQ+l5tsiIK09lOKRqcOD6VRu3aruIFI?=
 =?iso-8859-1?Q?F06SDbifmu/4jsOwIiJS4CYBeCRcUn5wea6WbuY+X2gS8yNCS5WkSJiE5V?=
 =?iso-8859-1?Q?3Z31JVGcxUztRtqMssSVCgpAx42W6Q0IDcouorZBtFbOLlLUjuVoUDpc4t?=
 =?iso-8859-1?Q?i1cWSK6aHcLLJy1aoU8YQjYCOdVvrESnL+t96YwcYCiwhOHZB8qmPBHYW5?=
 =?iso-8859-1?Q?wHJ0svdjPhqmlD01bm4IQd0qYdpR0MrJ/bbTBIZjGWQmxjG3UvLJxEndzb?=
 =?iso-8859-1?Q?BQzA4UwPKByH7H55V37qaEemEPW/JioEmd1qFFSXG3/xZRIxb8tNrxI35V?=
 =?iso-8859-1?Q?KnXZe1KEEZ82/Hae4oiknmz85Ood0WYIu/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rdt.co.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f15091-7d0f-43b9-0b2e-08dbdec00709
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 12:00:53.6079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8a835d77-0de8-41cb-bba1-a764d00681ac
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69BuqI0i9AqwDCf+1/la++yTc1C0ZqANmfapl2671e0ziXafLwLgPdHpGFodlmVN5b2vOYAw/mZjxPYENhmPhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6447

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I have two GIT repositories (A and B). Both migrated from the same TFS serv=
er using git-tfs tool. I migrated code into A and made lots of changes, inc=
luding moving 50,000+ files from folder "/Landscape" to "/Landscape/src".  =
B contains the same code but with various other changes made since my origi=
nal migration from TFS to A.  All the files in B are still in the "/Landsca=
pe" folder.  I recently needed to merge my changes from A to B, so I added =
A as a remote to B and then performed a number of cherry-picks from A to B,=
 but got stuck when trying to cherry-pick the commit containing the results=
 of moving all files into "/Landscape/src".

What did you expect to happen? (Expected behavior)
I expected the git rename detection to match all files in A "/Landscape" to=
 files in B "/Landscape/src".

What happened instead? (Actual behavior)
Although many files were matched successfully, git mismatched over two doze=
n similarly named files, e.g.

Incorrect path match: Landscape/Services/uiServices/Complaints/Interfaces/I=
AccountsIntegration.vb -> Landscape/src/Complaints/Rdt.Complaints.UI/Interf=
aces/IAccountsIntegration.vb
Incorrect path match: Landscape/Services/uiServices/Complaints/Interfaces/I=
DocumentIntegration.vb -> Landscape/src/Complaints/Rdt.Complaints.UI/Interf=
aces/IDocumentIntegration.vb
Incorrect path match: Landscape/Deployment/PowershellScripts/pre-req/Rdt.Ba=
tchProcessingService.Setup/pre-req.ps1 -> Landscape/src/Deployment/Powershe=
llScripts/pre-req/Landscape.Net/pre-req.ps1
Incorrect path match: Landscape/Deployment/PowershellScripts/pre-req/Workfl=
ow/pre-req.ps1 -> Landscape/src/Deployment/PowershellScripts/pre-req/Rdt.Ba=
tchProcessingService.Setup/pre-req.ps1
Incorrect name match: Landscape/Documentation/Rdt.Documentation.UI/Properti=
es/licenses.licx -> Landscape/src/Deployment/PowershellScripts/pre-req/Work=
flow/pre-req.ps1
Incorrect path match: Landscape/Documentation/uiDocumentation/licenses.licx=
 -> Landscape/src/Documentation/Rdt.Documentation.UI/Properties/licenses.li=
cx
Incorrect path match: Landscape/Import/uiImport/My Project/licenses.licx ->=
 Landscape/src/Documentation/uiDocumentation/licenses.licx
Incorrect path match: Landscape/Main/uiMain.Workflow/My Project/licenses.li=
cx -> Landscape/src/Import/uiImport/My Project/licenses.licx
Incorrect path match: Landscape/Main/uiMain/My Project/licenses.licx -> Lan=
dscape/src/Main/uiMain.Workflow/My Project/licenses.licx
Incorrect path match: Landscape/LandscapeApiService.Setup/Setup/UIContent/R=
DT_Logo.ico -> Landscape/src/Main/uiMain.Workflow/Resources/RDT_Logo.ico
Incorrect path match: Landscape/Policy/Rdt.Policy.UI.Templates/Properties/l=
icenses.licx -> Landscape/src/Main/uiMain/My Project/licenses.licx
Incorrect path match: Landscape/Main/uiMain.Workflow/Resources/RDT_Logo.ico=
 -> Landscape/src/Main/uiMain/Resources/RDT_Logo.ico
Incorrect path match: Landscape/Policy/Rdt.Policy.UI/Properties/licenses.li=
cx -> Landscape/src/Policy/Rdt.Policy.UI.Templates/Properties/licenses.licx
Incorrect path match: Landscape/Rates/uiRates/My Project/licenses.licx -> L=
andscape/src/Policy/Rdt.Policy.UI/Properties/licenses.licx
Incorrect path match: Landscape/Rdt.Claim.UI/Properties/licenses.licx -> La=
ndscape/src/Rates/uiRates/My Project/licenses.licx
Incorrect path match: Landscape/Rdt.Landscape.UI.Templates.Workflow/Propert=
ies/licenses.licx -> Landscape/src/Rdt.Claim.UI/Properties/licenses.licx
Incorrect path match: Landscape/Rdt.Landscape.UI.Templates/Properties/licen=
ses.licx -> Landscape/src/Rdt.Landscape.UI.Templates.Workflow/Properties/li=
censes.licx
Incorrect path match: Landscape/Rdt.Landscape.UI.Workflow/Properties/licens=
es.licx -> Landscape/src/Rdt.Landscape.UI.Templates/Properties/licenses.lic=
x
Incorrect path match: Landscape/Rdt.Landscape.UI/Properties/licenses.licx -=
> Landscape/src/Rdt.Landscape.UI.Workflow/Properties/licenses.licx
Incorrect path match: Landscape/StandardLetters/uiStandardLetters/My Projec=
t/licenses.licx -> Landscape/src/Rdt.Landscape.UI/Properties/licenses.licx
Incorrect path match: Landscape/Complaints/Rdt.Complaints.UI/Interfaces/IDo=
cumentIntegration.vb -> Landscape/src/Services/uiServices/Complaints/Interf=
aces/IDocumentIntegration.vb
Incorrect path match: Landscape/SystemEvents/uiSystemEvents/My Project/lice=
nses.licx -> Landscape/src/StandardLetters/uiStandardLetters/My Project/lic=
enses.licx
Incorrect path match: Landscape/Services/busServices/RDT_Logo.ico -> Landsc=
ape/src/Startup/uiStartup.Workflow/Resources/RDT_Logo.ico
Incorrect path match: Landscape/Startup/uiStartup.Workflow/Resources/RDT_Lo=
go.ico -> Landscape/src/Startup/uiStartup/Resources/RDT_Logo.ico
Incorrect path match: Landscape/Startup/uiStartup/Resources/RDT_Logo.ico ->=
 Landscape/src/Startup/uiStartup32/RDT_Logo.ico
Incorrect path match: Landscape/Startup/uiStartup/Resources/newrdlogogradia=
nt48shad.ico -> Landscape/src/Startup/uiStartup32/newrdlogogradiant48shad.i=
co
Incorrect path match: Landscape/Templates/uiTemplates.Workflow/My Project/l=
icenses.licx -> Landscape/src/SystemEvents/uiSystemEvents/My Project/licens=
es.licx
Incorrect path match: Landscape/Utils/Rdt.Utils.UI/Properties/licenses.licx=
 -> Landscape/src/Templates/uiTemplates.Workflow/My Project/licenses.licx
Incorrect path match: Landscape/Utils/uiUtils/My Project/licenses.licx -> L=
andscape/src/Utils/Rdt.Utils.UI/Properties/licenses.licx
Incorrect name match: Landscape/WebServices/ServiceFabric/Policy/Rdt.Policy=
.Repository.Service.Fabric.Host/PackageRoot/Data/Swagger/Examples/POST_UKST=
asks_Response.json -> Landscape/src/Utils/uiUtils/My Project/licenses.licx


What's different between what you expected and what actually happened?

As you can see, although the filenames (and content) are the same, there ar=
e a few files that have been incorrectly matched to files with teh same nam=
e, but in a different sub folder.  In some cases, it seems that the catalys=
t has been git thinking that a file from B has been deleted from A, when in=
 fact it has not actually been deleted at all.
For example, the file Landscape/Deployment/PowershellScripts/pre-req/Landsc=
ape.Net/pre-req.ps1 has not been deleted in A or B, therefore git should no=
t have attempted to rename Landscape/Deployment/PowershellScripts/pre-req/R=
dt.BatchProcessingService.Setup/pre-req.ps1 to Landscape/Deployment/Powersh=
ellScripts/pre-req/Landscape.Net/pre-req.ps1, especially as it then attempt=
s to rename Landscape/Deployment/PowershellScripts/pre-req/Workflow/pre-req=
.ps1 to Landscape/src/Deployment/PowershellScripts/pre-req/Rdt.BatchProcess=
ingService.Setup/pre-req.ps1 and so on.

Git status contains, for example:
        deleted by them: Landscape/Deployment/PowershellScripts/pre-req/Lan=
dscape.Net/pre-req.ps1
        renamed:    Landscape/Deployment/PowershellScripts/pre-req/Rdt.Batc=
hProcessingService.Setup/pre-req.ps1 -> Landscape/src/Deployment/Powershell=
Scripts/pre-req/Landscape.Net/pre-req.ps1

The correct renames should have been:
git mv "Landscape/Complaints/Rdt.Complaints.UI/Interfaces/IAccountsIntegrat=
ion.vb" "Landscape/src/Complaints/Rdt.Complaints.UI/Interfaces/IAccountsInt=
egration.vb"
git mv "Landscape/Complaints/Rdt.Complaints.UI/Interfaces/IDocumentIntegrat=
ion.vb" "Landscape/src/Complaints/Rdt.Complaints.UI/Interfaces/IDocumentInt=
egration.vb"
git mv "Landscape/Deployment/PowershellScripts/pre-req/Rdt.BatchProcessingS=
ervice.Setup/pre-req.ps1" "Landscape/src/Deployment/PowershellScripts/pre-r=
eq/Rdt.BatchProcessingService.Setup/pre-req.ps1"
git mv "Landscape/Deployment/PowershellScripts/pre-req/Workflow/pre-req.ps1=
" "Landscape/src/Deployment/PowershellScripts/pre-req/Workflow/pre-req.ps1"
git mv "Landscape/Documentation/Rdt.Documentation.UI/Properties/licenses.li=
cx" "Landscape/src/Documentation/Rdt.Documentation.UI/Properties/licenses.l=
icx"
git mv "Landscape/Documentation/uiDocumentation/licenses.licx" "Landscape/s=
rc/Documentation/uiDocumentation/licenses.licx"
git mv "Landscape/Import/uiImport/My Project/licenses.licx" "Landscape/src/=
Import/uiImport/My Project/licenses.licx"
git mv "Landscape/Main/uiMain.Workflow/My Project/licenses.licx" "Landscape=
/src/Main/uiMain.Workflow/My Project/licenses.licx"
git mv "Landscape/Main/uiMain.Workflow/Resources/RDT_Logo.ico" "Landscape/s=
rc/Main/uiMain.Workflow/Resources/RDT_Logo.ico"
git mv "Landscape/Main/uiMain/My Project/licenses.licx" "Landscape/src/Main=
/uiMain/My Project/licenses.licx"
git mv "Landscape/Main/uiMain/Resources/RDT_Logo.ico" "Landscape/src/Main/u=
iMain/Resources/RDT_Logo.ico"
git mv "Landscape/Policy/Rdt.Policy.UI.Templates/Properties/licenses.licx" =
"Landscape/src/Policy/Rdt.Policy.UI.Templates/Properties/licenses.licx"
git mv "Landscape/Policy/Rdt.Policy.UI/Properties/licenses.licx" "Landscape=
/src/Policy/Rdt.Policy.UI/Properties/licenses.licx"
git mv "Landscape/Rdt.Claim.UI/Properties/licenses.licx" "Landscape/src/Rdt=
.Claim.UI/Properties/licenses.licx"
git mv "Landscape/Rdt.Landscape.UI.Templates.Workflow/Properties/licenses.l=
icx" "Landscape/src/Rdt.Landscape.UI.Templates.Workflow/Properties/licenses=
.licx"
git mv "Landscape/Rdt.Landscape.UI.Templates/Properties/licenses.licx" "Lan=
dscape/src/Rdt.Landscape.UI.Templates/Properties/licenses.licx"
git mv "Landscape/Rdt.Landscape.UI.Workflow/Properties/licenses.licx" "Land=
scape/src/Rdt.Landscape.UI.Workflow/Properties/licenses.licx"
git mv "Landscape/Rdt.Landscape.UI/Properties/licenses.licx" "Landscape/src=
/Rdt.Landscape.UI/Properties/licenses.licx"
git mv "Landscape/Services/busServices/RDT_Logo.ico" "Landscape/src/Service=
s/busServices/RDT_Logo.ico"
git mv "Landscape/Services/uiServices/Complaints/Interfaces/IAccountsIntegr=
ation.vb" "Landscape/src/Services/uiServices/Complaints/Interfaces/IAccount=
sIntegration.vb"
git mv "Landscape/Services/uiServices/Complaints/Interfaces/IDocumentIntegr=
ation.vb" "Landscape/src/Services/uiServices/Complaints/Interfaces/IDocumen=
tIntegration.vb"
git mv "Landscape/StandardLetters/uiStandardLetters/My Project/licenses.lic=
x" "Landscape/src/StandardLetters/uiStandardLetters/My Project/licenses.lic=
x"
git mv "Landscape/Startup/uiStartup.Workflow/Resources/RDT_Logo.ico" "Lands=
cape/src/Startup/uiStartup.Workflow/Resources/RDT_Logo.ico"
git mv "Landscape/Startup/uiStartup/Resources/RDT_Logo.ico" "Landscape/src/=
Startup/uiStartup/Resources/RDT_Logo.ico"
git mv "Landscape/SystemEvents/uiSystemEvents/My Project/licenses.licx" "La=
ndscape/src/SystemEvents/uiSystemEvents/My Project/licenses.licx"
git mv "Landscape/Templates/uiTemplates.Workflow/My Project/licenses.licx" =
"Landscape/src/Templates/uiTemplates.Workflow/My Project/licenses.licx"
git mv "Landscape/Utils/Rdt.Utils.UI/Properties/licenses.licx" "Landscape/s=
rc/Utils/Rdt.Utils.UI/Properties/licenses.licx"
git mv "Landscape/Utils/uiUtils/My Project/licenses.licx" "Landscape/src/Ut=
ils/uiUtils/My Project/licenses.licx"


Anything else you want to add:
I can't help but think that this is related to changes made by Palantir:
https://blog.palantir.com/optimizing-gits-merge-machinery-1-127ceb0ef2a1

I have tried to unstage these renames using "git restore --staged <file_nam=
e>" so I can then apply the correct "git mv" commands, but bizzarely, this =
then results in "git status" reporting a different, smaller set of mismatch=
ed names:

Incorrect name match: Landscape/Services/busServices/Service References/Dat=
aCollectorService/busServices.DataCollectorService.GetDataResponse.datasour=
ce -> Landscape/src/Deployment/PowershellScripts/pre-req/Landscape.Net/pre-=
req.ps1
Incorrect name match: Landscape/Services/busServices/Service References/Glo=
balGatewayService/busServices.GlobalGatewayService.OrderResponse.datasource=
 -> Landscape/src/Deployment/PowershellScripts/pre-req/Rdt.BatchProcessingS=
ervice.Setup/pre-req.ps1
Incorrect name match: Landscape/WebServices/ServiceFabric/Policy/Rdt.Policy=
.Repository.Service.Fabric.Host/PackageRoot/Data/Swagger/Examples/POST_UKST=
asks_Response.json -> Landscape/src/Deployment/PowershellScripts/pre-req/Wo=
rkflow/pre-req.ps1
Incorrect path match: Landscape/LandscapeApiService.Setup/Setup/UIContent/R=
DT_Logo.ico -> Landscape/src/Main/uiMain.Workflow/Resources/RDT_Logo.ico
Incorrect path match: Landscape/WebServices/WCFServices/Landscape WCF Servi=
ce/wsWcfLandscapeServices/RDT_Logo.ico -> Landscape/src/Main/uiMain/Resourc=
es/RDT_Logo.ico
Incorrect path match: Landscape/WindowsServices/Rdt.BatchProcessingService/=
Rdt.BatchProcessingService.Integration/RDT_Logo.ico -> Landscape/src/Servic=
es/busServices/RDT_Logo.ico
Incorrect path match: Landscape/WindowsServices/Rdt.BatchProcessingService/=
Rdt.BatchProcessingService.Setup/UIContent/RDT_Logo.ico -> Landscape/src/St=
artup/uiStartup.Workflow/Resources/RDT_Logo.ico
Incorrect path match: Landscape/WindowsServices/Rdt.BatchProcessingService/=
Rdt.BatchProcessingService/RDT_Logo.ico -> Landscape/src/Startup/uiStartup/=
Resources/RDT_Logo.ico
Incorrect path match: Landscape/_Tests/Rdt.BatchProcessingService.Tests/RDT=
_Logo.ico -> Landscape/src/Startup/uiStartup32/RDT_Logo.ico
Incorrect path match: Landscape/Startup/uiStartup/Resources/newrdlogogradia=
nt48shad.ico -> Landscape/src/Startup/uiStartup32/newrdlogogradiant48shad.i=
co
Incorrect path match: Landscape/uiStartup.Setup/Setup/UIContent/RDT_Logo.ic=
o -> Landscape/src/WebServices/WCFServices/Landscape WCF Service/wsWcfLands=
capeServices/RDT_Logo.ico
Incorrect path match: Landscape/wisWorkflow.Setup/Setup/UIContent/RDT_Logo.=
ico -> Landscape/src/WindowsServices/Rdt.BatchProcessingService/Rdt.BatchPr=
ocessingService.Integration/RDT_Logo.ico
Incorrect path match: Landscape/wsXmlLandscapeServices.Setup/Setup/Binary/R=
DT_Logo.ico -> Landscape/src/WindowsServices/Rdt.BatchProcessingService/Rdt=
.BatchProcessingService.Setup/UIContent/RDT_Logo.ico

Notice how "busServices.DataCollectorService.GetDataResponse.datasource" is=
 now renamed to "Landscape.Net/pre-req.ps1", whereas the datasource file wa=
sn't even listed previously?

Please help.  I've been on this for a couple of weeks now and I'm running o=
ut of ideas.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.42.0.windows.2
cpu: x86_64
built from commit: 2f819d1670fff9a1818f63b6722e9959405378e3
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19044
compiler info: gnuc: 13.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
<none>


Regards,

Jeremy Pridmore
Lead Solution Architect

________________________________

DISCLAIMER This email is confidential. It should only be read by those pers=
ons to whom it is addressed. RDT Ltd accept no liability for the consequenc=
es of any person acting, or refraining from acting, on any information cont=
ained within this e-mail or any attached documents prior to the receipt by =
those persons of subsequent written confirmation of that information. If yo=
u think this e-mail may not be intended for you, do not use, pass on or cop=
y the transmission in any way. While all reasonable precautions are taken t=
o minimise the risk of transmitting software viruses we advise you to carry=
 out your own virus checks on any attachment to this message. We cannot acc=
ept liability for any loss or damage caused by software viruses.
