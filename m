Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C39C1F406
	for <e@80x24.org>; Fri, 11 May 2018 21:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeEKVP0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 17:15:26 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:6848
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751012AbeEKVPX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 17:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DV/+AJTXvTIywVZwqReCMgU8y+cBu1BYd7kP+aGZQc0=;
 b=Hrg/M2/+QTLeab+5ccwj6PfgI8Cg/qyEitPDYt2InZ3NBrJC7Y+Gv9ZU5L1ibk2msUp8yteDpmL5RGRtzP7D/R+V+VcTbov2deQ8g6lVS2Oq44XsUVwr0eWvTAye9XfDIblZ3V0uXNb8gBims9Uyo2vLNhjfeqTfRNatPcMUWTk=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Fri, 11 May 2018 21:15:17 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Fri, 11 May 2018
 21:15:17 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 03/12] commit-graph: test that 'verify' finds corruption
Thread-Topic: [PATCH v2 03/12] commit-graph: test that 'verify' finds
 corruption
Thread-Index: AQHT6W0o7RjPxMtQekyB4AeUY5SJng==
Date:   Fri, 11 May 2018 21:15:17 +0000
Message-ID: <20180511211504.79877-4-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com>
 <20180511211504.79877-1-dstolee@microsoft.com>
In-Reply-To: <20180511211504.79877-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:404:8e::30) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:MdjGdcf3futAFuC0liMPpgsd8B/uwTos/TrBMcQvrzNcGW5zvxqO1LXlFpDg/7ZKncXePUWERHgTkBGNRNrnxJGxMVtnGQsUHiCWnVlKRcaVxHj/TRWCZLIlJMCOktzCK0XSkQ3yNHgfq+y4sccSthBxfqaYPd6FyiKIcUgBIekkDqTY0OmzFpRx19dec8nbJHaWZmZXXqDlGo8WLmvuJHTkKEr14H50R//MihhuddbOMoK4CDImduviMWD1NH2n;20:5y5uFBi0Rf267bZ2r32AqyQcAL2iFt+t62F/HiIoXHd/CyamjsQiv9eHZMymhZxBdukWwQ4VBAtmdz+h+y4ztoGqTHq1PoaZR6t7w0lDoSq+0mfQ2d0WR09rgB3dYJApSkHHOGx0EGbrTRqDTNr2LMT7cvyxniOgOtWp0FkXVxk=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
x-microsoft-antispam-prvs: <BL0PR2101MB1091F3FAA3391D2028B59C85A19F0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(22452003)(39060400002)(53936002)(6116002)(305945005)(107886003)(68736007)(7736002)(46003)(2900100001)(97736004)(4326008)(3660700001)(36756003)(86362001)(15650500001)(3280700002)(10090500001)(8936002)(1730700003)(81156014)(6512007)(316002)(8676002)(86612001)(1076002)(25786009)(54906003)(99286004)(81166006)(106356001)(10290500003)(2616005)(5640700003)(476003)(102836004)(6346003)(446003)(486006)(59450400001)(5250100002)(6916009)(478600001)(6486002)(2351001)(386003)(6506007)(11346002)(76176011)(5660300001)(14454004)(6436002)(52116002)(2906002)(105586002)(186003)(2501003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: HzT4/q/q3z85JyFNCNAEGa11TKOzCq8B35Gb+UHKXtq5EwytSpL3pv4AgD5JI7OkzzmHHMVUHJGGn7OOwCS2KoiU+cYTDRsqwNIQRbXRBKbJXRS0xvu3xLTMQD/uuiv12c+hHM43sjm1lTc0HGYlDgbwSKACTWw/ZzbS4h8t6GTMv+oLWhaJOkKK3Gh3QXdJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF3844C51F22C642B0DCFCA0CF32681C@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fbb0d40e-672c-41a8-7fb8-08d5b7844b19
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb0d40e-672c-41a8-7fb8-08d5b7844b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 21:15:17.2565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QWRkIHRlc3QgY2FzZXMgdG8gdDUzMTgtY29tbWl0LWdyYXBoLnNoIHRoYXQgY29ycnVwdCB0aGUg
Y29tbWl0LWdyYXBoDQpmaWxlIGFuZCBjaGVjayB0aGF0IHRoZSAnZ2l0IGNvbW1pdC1ncmFwaCB2
ZXJpZnknIGNvbW1hbmQgZmFpbHMuIFRoZXNlDQp0ZXN0cyB2ZXJpZnkgdGhlIGhlYWRlciBhbmQg
Y2h1bmsgaW5mb3JtYXRpb24gaXMgY2hlY2tlZCBjYXJlZnVsbHkuDQoNCkhlbHBlZC1ieTogTWFy
dGluIMOFZ3JlbiA8bWFydGluLmFncmVuQGdtYWlsLmNvbT4NClNpZ25lZC1vZmYtYnk6IERlcnJp
Y2sgU3RvbGVlIDxkc3RvbGVlQG1pY3Jvc29mdC5jb20+DQotLS0NCiB0L3Q1MzE4LWNvbW1pdC1n
cmFwaC5zaCB8IDUzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
dC90NTMxOC1jb21taXQtZ3JhcGguc2ggYi90L3Q1MzE4LWNvbW1pdC1ncmFwaC5zaA0KaW5kZXgg
NmNhNDUxZGZkMi4uMGNiODgyMzJmYSAxMDA3NTUNCi0tLSBhL3QvdDUzMTgtY29tbWl0LWdyYXBo
LnNoDQorKysgYi90L3Q1MzE4LWNvbW1pdC1ncmFwaC5zaA0KQEAgLTI0MCw0ICsyNDAsNTcgQEAg
dGVzdF9leHBlY3Rfc3VjY2VzcyAnZ2l0IGNvbW1pdC1ncmFwaCB2ZXJpZnknICcNCiAJZ2l0IGNv
bW1pdC1ncmFwaCB2ZXJpZnkgPm91dHB1dA0KICcNCiANCisjIHVzYWdlOiBjb3JydXB0X2RhdGEg
PGZpbGU+IDxwb3M+IFs8ZGF0YT5dDQorY29ycnVwdF9kYXRhKCkgew0KKwlmaWxlPSQxDQorCXBv
cz0kMg0KKwlkYXRhPSIkezM6LVwwfSINCisJcHJpbnRmICIkZGF0YSIgfCBkZCBvZj0iJGZpbGUi
IGJzPTEgc2Vlaz0iJHBvcyIgY29udj1ub3RydW5jDQorfQ0KKw0KK3Rlc3RfZXhwZWN0X3N1Y2Nl
c3MgJ2RldGVjdCBiYWQgc2lnbmF0dXJlJyAnDQorCWNkICIkVFJBU0hfRElSRUNUT1JZL2Z1bGwi
ICYmDQorCWNwICRvYmpkaXIvaW5mby9jb21taXQtZ3JhcGggY29tbWl0LWdyYXBoLWJhY2t1cCAm
Jg0KKwl0ZXN0X3doZW5fZmluaXNoZWQgbXYgY29tbWl0LWdyYXBoLWJhY2t1cCAkb2JqZGlyL2lu
Zm8vY29tbWl0LWdyYXBoICYmDQorCWNvcnJ1cHRfZGF0YSAkb2JqZGlyL2luZm8vY29tbWl0LWdy
YXBoIDAgIlwwIiAmJg0KKwl0ZXN0X211c3RfZmFpbCBnaXQgY29tbWl0LWdyYXBoIHZlcmlmeSAy
PmVyciAmJg0KKwlncmVwIC12ICJeXCsiIGVyciA+IHZlcmlmeS1lcnJvcnMgJiYNCisJdGVzdF9s
aW5lX2NvdW50ID0gMSB2ZXJpZnktZXJyb3JzICYmDQorCWdyZXAgImdyYXBoIHNpZ25hdHVyZSIg
dmVyaWZ5LWVycm9ycw0KKycNCisNCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdkZXRlY3QgYmFkIHZl
cnNpb24gbnVtYmVyJyAnDQorCWNkICIkVFJBU0hfRElSRUNUT1JZL2Z1bGwiICYmDQorCWNwICRv
YmpkaXIvaW5mby9jb21taXQtZ3JhcGggY29tbWl0LWdyYXBoLWJhY2t1cCAmJg0KKwl0ZXN0X3do
ZW5fZmluaXNoZWQgbXYgY29tbWl0LWdyYXBoLWJhY2t1cCAkb2JqZGlyL2luZm8vY29tbWl0LWdy
YXBoICYmDQorCWNvcnJ1cHRfZGF0YSAkb2JqZGlyL2luZm8vY29tbWl0LWdyYXBoIDQgIlwwMiIg
JiYNCisJdGVzdF9tdXN0X2ZhaWwgZ2l0IGNvbW1pdC1ncmFwaCB2ZXJpZnkgMj5lcnIgJiYNCisJ
Z3JlcCAtdiAiXlwrIiBlcnIgPiB2ZXJpZnktZXJyb3JzICYmDQorCXRlc3RfbGluZV9jb3VudCA9
IDEgdmVyaWZ5LWVycm9ycyAmJg0KKwlncmVwICJncmFwaCB2ZXJzaW9uIiB2ZXJpZnktZXJyb3Jz
DQorJw0KKw0KK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2RldGVjdCBiYWQgaGFzaCB2ZXJzaW9uJyAn
DQorCWNkICIkVFJBU0hfRElSRUNUT1JZL2Z1bGwiICYmDQorCWNwICRvYmpkaXIvaW5mby9jb21t
aXQtZ3JhcGggY29tbWl0LWdyYXBoLWJhY2t1cCAmJg0KKwl0ZXN0X3doZW5fZmluaXNoZWQgbXYg
Y29tbWl0LWdyYXBoLWJhY2t1cCAkb2JqZGlyL2luZm8vY29tbWl0LWdyYXBoICYmDQorCWNvcnJ1
cHRfZGF0YSAkb2JqZGlyL2luZm8vY29tbWl0LWdyYXBoIDUgIlwwMiIgJiYNCisJdGVzdF9tdXN0
X2ZhaWwgZ2l0IGNvbW1pdC1ncmFwaCB2ZXJpZnkgMj5lcnIgJiYNCisJZ3JlcCAtdiAiXlwrIiBl
cnIgPiB2ZXJpZnktZXJyb3JzICYmDQorCXRlc3RfbGluZV9jb3VudCA9IDEgdmVyaWZ5LWVycm9y
cyAmJg0KKwlncmVwICJoYXNoIHZlcnNpb24iIHZlcmlmeS1lcnJvcnMNCisnDQorDQordGVzdF9l
eHBlY3Rfc3VjY2VzcyAnZGV0ZWN0IHRvbyBzbWFsbCBjaHVuay1jb3VudCcgJw0KKwljZCAiJFRS
QVNIX0RJUkVDVE9SWS9mdWxsIiAmJg0KKwljcCAkb2JqZGlyL2luZm8vY29tbWl0LWdyYXBoIGNv
bW1pdC1ncmFwaC1iYWNrdXAgJiYNCisJdGVzdF93aGVuX2ZpbmlzaGVkIG12IGNvbW1pdC1ncmFw
aC1iYWNrdXAgJG9iamRpci9pbmZvL2NvbW1pdC1ncmFwaCAmJg0KKwljb3JydXB0X2RhdGEgJG9i
amRpci9pbmZvL2NvbW1pdC1ncmFwaCA2ICJcMDEiICYmDQorCXRlc3RfbXVzdF9mYWlsIGdpdCBj
b21taXQtZ3JhcGggdmVyaWZ5IDI+ZXJyICYmDQorCWdyZXAgLXYgIl5cKyIgZXJyID4gdmVyaWZ5
LWVycm9ycyAmJg0KKwl0ZXN0X2xpbmVfY291bnQgPSAyIHZlcmlmeS1lcnJvcnMgJiYNCisJZ3Jl
cCAibWlzc2luZyB0aGUgT0lEIExvb2t1cCBjaHVuayIgdmVyaWZ5LWVycm9ycyAmJg0KKwlncmVw
ICJtaXNzaW5nIHRoZSBDb21taXQgRGF0YSBjaHVuayIgdmVyaWZ5LWVycm9ycw0KKycNCisNCiB0
ZXN0X2RvbmUNCi0tIA0KMi4xNi4yLjMyOS5nZmI2MjM5NWRlNg0KDQo=
