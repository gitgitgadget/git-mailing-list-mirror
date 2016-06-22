Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 525ED1FE4E
	for <e@80x24.org>; Wed, 22 Jun 2016 09:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbcFVJ0q (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 05:26:46 -0400
Received: from mail-by2on0099.outbound.protection.outlook.com ([207.46.100.99]:11170
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751741AbcFVJ0e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 05:26:34 -0400
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.onmicrosoft.com;
 s=selector1-roku-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6/ibaWqjx4p+fr63gaEATc2vJhl2vhYHe9r+vRDqIHU=;
 b=JaByuf/S13qAUs0Jl92CHC7Q0Qkmpayad9Np+8fugyrbiFe0Zsgs4xOtiHpjP7ROoWaYBmePb55pnhIGDKOHztJTz7MrBMb81XWqJ0AEgUk/8eVzH55QgwlDuTL3LlHhGVy3oadXwXex3K0AnAWKjxwB0aVR409uyDGDmgHM7cE=
Authentication-Results:	spf=none (sender IP is )
 smtp.mailfrom=aoakley@roku.com; 
Received: from [10.20.24.94] (81.145.207.254) by
 SN2PR01MB2080.prod.exchangelabs.com (10.166.208.143) with Microsoft SMTP
 Server (TLS) id 15.1.523.12; Wed, 22 Jun 2016 09:26:31 +0000
Subject: Re: [PATCH 1/1] git-p4: correct hasBranchPrefix verbose output
To:	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>
References: <1466517222-12600-1-git-send-email-aoakley@roku.com>
 <C471957C-3FEE-4CEB-8940-624F73784355@gmail.com>
 <xmqqbn2uqufj.fsf@gitster.mtv.corp.google.com>
CC:	<git@vger.kernel.org>, <luke@diamand.org>
From:	Andrew Oakley <aoakley@roku.com>
Message-ID: <576A595E.9040704@roku.com>
Date:	Wed, 22 Jun 2016 10:24:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqbn2uqufj.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [81.145.207.254]
X-ClientProxiedBy: AM3PR06CA043.eurprd06.prod.outlook.com (10.141.192.161) To
 SN2PR01MB2080.prod.exchangelabs.com (10.166.208.143)
X-MS-Office365-Filtering-Correlation-Id: c596d17e-9bb2-4631-47b5-08d39a7f4c71
X-Microsoft-Exchange-Diagnostics: 1;SN2PR01MB2080;2:2+zBDS699/TUfG5vDXf7/lIKjcLJd7GsYV9x3aAct0fhfMwT7u+/VXllK20XuWrAZY3H/A7pGez/ZVRySdrRWbGnqhvi9t9DO254AAaJWxV8UpWhygc8kNsToAhM7BDP+0UkWo2gcEqKR2UakaTqMLrU7z5z3RjL13uKdjQhepstB+o/59Ku0PdrFs7UEMaM;3:30N3DM8sv3WqfqQ9yOqfWHNOM2PXoy1xr5+Ba5GhK+0xJkIx3j9lEPa61b4MdmM402eNPUUFrDcvb3rHk2As1yuCMs82S7vsxSAfeely4Dce82BF/fWbxNttAyE0S8vq
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:SN2PR01MB2080;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR01MB2080;25:BvsA8CK9XdMKMWTae18NmgmHZf/iwFSQkX8OsvehnVruy8TuOQQKR/nTfgGj79UnfewE7MxqJ0M4xfTq2U8Xqq3/n5FiCAKCAPOVzna5eG1xNmc2frGKolR+GKjF/gsxLD7m/bXzGUFfIcJE96RMSWRN0T6RvgzsRfMWgivC6QPrwu2hBDOP9S9xjtOJ/tfcaMzSqBMEkSEAJDoNyEnas5QXIda8LYiyTt/E7VzjXZQkJzt1OvIwuY8INLz9ZMYSnu5MOLKg88kHOUI6pRkXMuNPzImaDReoOpJPzDAQaBaE1BIbpLUu9R4AIzW6WNXZwznBCnyFQS5rTZQ8DFYFVNpr5KtF14l3vqXL9aq1pnP5UzL46LZ8acxq2gN0GZIfMS+qXpyMX6Ylqshl3x6B1E3Vhs5lDn0mtS3ZDR+cvBUg2iAmtYjRVfWeKSw9XylXOYQ+LhX9m5+bXL7SWZA6kCuqnA18VMTFdtYjeuCMuUUUG6jT//Bf0y5C43nbbSX/8Zjx5GoCsiQOVsyTnuv3tDjEVEDn+hp5xzuu95jE6FAmcv+VVUqoy2RtFJf1WGS36N8qb7hEvQQuEmMKdY7ybTo6bqo0M5cqj7W4ht2aBuS/gG3QSIsVhEH/8rJSHHx3NkggX/uzu5lY/o9MpmtE1QQ40+02627LgpkArMbtSjzm/OAoQPQult1OSsIuQn2PmTBZQ7rgU2npZ+xB8HEOmoihP2KpTd1a5ykZ0ebH7F4=
X-Microsoft-Antispam-PRVS: <SN2PR01MB2080EDD5F80888BFB47F73B9C22C0@SN2PR01MB2080.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:SN2PR01MB2080;BCL:0;PCL:0;RULEID:;SRVR:SN2PR01MB2080;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR01MB2080;4:v8QSf56/m9/SibbfaVY4weljgdiQVFRzc8G+A9fOg8S7yK86DNyFZsBVQ8XnXrVWJ7ByxkbTEOd/DJuwtDuj/1+gos87Nc9kUHyQEcN+xtHRNYgfsVUl3Nm64/mJt4Q73Hx4Zlqj+XE3T5TlOUqjzT2abO+O2fJRRz4SWBb0Lv+tz6/CYPW1qCGXpzgQwlMske3RKMGfgVNVNRkRYaGCqTDuYzOWalS352Q7L9cid+ZxYkV/XR+PR6+rngfxq5y/hEF9xMgIvuvz8V8XR1qWZUHqApVUNIUGknH6K3QYYF3ClF2FbdoGQCQpR7uilpol2ELoLX8VTwzsoO8W1/N2TAuHLYps91NZrDDNwv+qk3E=
X-Forefront-PRVS: 0981815F2F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(199003)(24454002)(189002)(65816999)(50986999)(76176999)(87266999)(64126003)(5001770100001)(80316001)(54356999)(2950100001)(83506001)(77096005)(68736007)(50466002)(101416001)(7736002)(92566002)(47776003)(66066001)(65956001)(97736004)(65806001)(106356001)(86362001)(36756003)(4001350100001)(2906002)(59896002)(189998001)(33656002)(230700001)(42186005)(23746002)(6116002)(81156014)(81166006)(586003)(8666005)(4326007)(7846002)(558084003)(3846002)(105586002)(8676002)(3076002)(7059030);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR01MB2080;H:[10.20.24.94];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: roku.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN2PR01MB2080;23:cGJETc+bOJuy43DRQEIH8hhwbDNcA/aNVjRam?=
 =?Windows-1252?Q?Y1eNujQX5QD+6+1Obw9V/y859Urz8i/oG/N+7h+nvetYjiQBa5uoBWhL?=
 =?Windows-1252?Q?GzNbYKhcxD3Xe/8gMr7SQevICe1+7Z47daOq1SS8JxCfJDmx9YsR8keo?=
 =?Windows-1252?Q?oiPOf8rzBSM9UpNLn59oHpP9L3mgyKRAapVgmIM5++2Nna21KAoakqTX?=
 =?Windows-1252?Q?T5Lpvrdga8s2t5I4dukSBIfAHV7YSW8zROKWFTahN9HPltHgjixOLtLh?=
 =?Windows-1252?Q?nBjovQizrhIFaHPUV2frXTRkC/6WcpNrW+Ow0/8tvteYi18hou1wdAXz?=
 =?Windows-1252?Q?9WwQ+lGwiW5cSeN45h2+cXeHlxDwhIROxEk2Az2hq+IIMZ4nbayfkdhT?=
 =?Windows-1252?Q?VAXs5/OW3DZaLXH6g6XozkSoFBtAuPS1C4g9TCphxbvFPkGtlcxhnpOT?=
 =?Windows-1252?Q?FBLZPkHR+3894fpJjT510TES+aLzIWgW+h4zaNPEu289zaowqoDH3KKj?=
 =?Windows-1252?Q?uiDDrcmzBKlxi8df406zciq64qaKDRgCldUC7UZ79X7GRZFXPvmx1/MD?=
 =?Windows-1252?Q?f1D94zuqj2oh4DKeUUTNhGBvY5A4CF8Afhb2sNor2Wi7RrlmVe45L3d3?=
 =?Windows-1252?Q?CejOC+vecpvYjGcYG2xOfoBC2+DNQAUy0oafgJZh2496yz7fR3zJf5QC?=
 =?Windows-1252?Q?9Zo7QBk2w1umtQQCSXZq58diyLM8HHQ5JAOA5wGno5oAb4XuL378JYtk?=
 =?Windows-1252?Q?kAez1Mr83GP9lg4TTzep+0MOPEbGb6IYc9S98ocl6Y9NOOR10dYYfMs1?=
 =?Windows-1252?Q?2oOgE3BsuqN1U8vym7RxzzibtC4V3dHjiJkVZf4RSs2CBXH7UMfi0dWy?=
 =?Windows-1252?Q?woW6bNe2IXNhbNiYCBp7+ZsYZboBdmTtvqeHmaUv+uVQn/nA4Yk2K4PD?=
 =?Windows-1252?Q?1AB2mbP8jDK+w4p8iQUpN/uGSLDXOw9WC7/R9hLZkKqauqO0GswC2Brr?=
 =?Windows-1252?Q?VNfEvs2t29lxN1guo+Gs/5wHC+RWqGkGpwo5VcFLzyPVTzx/efBgTEQF?=
 =?Windows-1252?Q?VFtF4bEzyz/k5+hhiJlOxCEr68phUDHxlAblYKntG5XxkxaC2FIomb3G?=
 =?Windows-1252?Q?OpcfHYMRvozYlTLgd+4GHGG2/H/uESVjxd1csZCZAKvwhO+XQbdczdcO?=
 =?Windows-1252?Q?vyVoZNas6D73F9JBVvsRvG8yJAs/Quee1ssRQdeRWi5uwCyxeo1vc1TN?=
 =?Windows-1252?Q?TN74rEhueCKB5D2fDPIZOslK8RaEeExDJsS8mJPBsIecs5U3SvfZxZX1?=
 =?Windows-1252?Q?SsPE8gdLZts1HqsBgLylownLEeqP/gb9BtCKgb03sWIBkm9/gVvuVmuH?=
 =?Windows-1252?Q?kGKhh+MLOXN?=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR01MB2080;6:I4uigoDsrYTBSFc0exl6XuSyfJXd+9eqO2DcpQBpLXRh5qrH4P7j3ivZp0qhPduUTPKpb3g81Vqx+xzLaT11uFZnbcPhumqULRNnoWoqnBFkZKyJwl18wXFglk+AzsAyASIbf6BDVjDn5YOfgn4PWesgTd10XrrgOYoHt6zlDSdBhH3OH3/VDC311kj1tlhp8B70y0LwDFvyb/Z97M0h7IPrvwEoaHwA/aIU0LA81rX//fKpT9QFy5JpBvEHBOUid5IOPyZTFTuUQkqR63tN6T4/14WSM7swcqGpyfpAw9XIG4Sh/6EqRLM//aG/7oqK;5:LnqlVzRJMRhuVS3XMyJoIg1Xd7JuY4Pf/jvZaLgeGxhnk45nPgFw8RspZlBKS3eHWweEjV8BV7yTqUHekXS8t1uyaAR3/5agmSUeS+k/E8s9z675bcVJ66+dPPU8mA1sssV0cAFiX45dE5XzKSGnnA==;24:to/CleWlwQ0yc4JhdgqPVArJHPJXQJUvccgza1/Z61dl3M6fxvxA7azHZvPrmfcw09yTaslNlQtUQrnYYvLcplzcU0XP4eXDDYZfrvV0Yro=;7:L5sgv7QAdO7v0jMks6q/DcfrwYiDlO3Bxfe25KkslfToUrcDp0S6XB5i6SgOzw27q+YAa7Mv3Mzm3aGslZ3cj5Wk5ERYlqhKV9VWC9/TBrc6ypLy2m5HKF28lYg5ydOmx9xTmTNUJp9n7R/KCG4t3wLvCJjU1owuGtCSTxZiS3TYBLtUoSi/N4iW+aoBl6OCvpmH1BsDjikcJJ6iPEGzieunfJFVzeSe5/h1l98FoC4ksl8auYUnQ6xC9B5ZG3iOdGmr1/B/LKkntfp6hdMPTA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata:	NSPM
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2016 09:26:31.5631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR01MB2080
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 21/06/16 19:16, Junio C Hamano wrote:
> Thanks.  This needs sign-off, though.

Sorry, didn't realise I needed to do that!  Will resend with sign off.

Thanks
