Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05471F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeFDQwP (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:52:15 -0400
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:6380
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751042AbeFDQwO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqUV5En1HG1NdCNQ/vw5hQUWz87mbZ8UdhqpAvgkMtk=;
 b=FaHmw1OLd3QFUkJnJop+7pr4ySioWCegk1wLVb1NXL5yTKPaDNg/OYUql3EmWGQjN7FtHts8vESzay2Ku98l4bdM5h19kil9eCphn/m4riZh+V8GQCZJBcYkbTxgIdYBrpvkBBWyBGsRGgNldKVeyhWihD/BjVmqCZYP1EIEscI=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB0923.namprd21.prod.outlook.com (52.132.152.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.7; Mon, 4 Jun 2018 16:52:12 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:12 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 00/21] Integrate commit-graph into 'fsck' and 'gc'
Thread-Topic: [PATCH v4 00/21] Integrate commit-graph into 'fsck' and 'gc'
Thread-Index: AQHT/CRhvmwEhBv+C0inkOEGVgSDcw==
Date:   Mon, 4 Jun 2018 16:52:12 +0000
Message-ID: <20180604165200.29261-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:404:5f::25) To MW2PR2101MB1020.namprd21.prod.outlook.com
 (2603:10b6:302:9::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0923;7:6ZPiwTlpWAoOink9abFv1y9LuirTR1p+j0+sg/w0QmHZEb2R9VlvNfyfkW6/eNxWqgmyaWmehJVxinQp8oE+G0q7PZOVRY46epAZ8gYx+X4jwNA05tJcA+H91XpiCPUKHMjeuYtrLHEIVC6folYN76dXblBr9+oeARyCa3Upo+YaxN7S47rFg6zbZ0buoSlwSmb9RTF1KsrTzedeo09TTS0AkPU8O2IfJeSuLN2xco/Hhc4xDr2Y+TcdqSYMrVd9;20:ulnc0WTDHTSS0luESRYe0bSFRXyvJoUWgvLeYWpygwMXhvkTPQz/XFsEsAZEOUPL0Ja4oYqncRFRz7WtuE2XgGr2oRnLqt17Ae5sGWF99qVshqHIAmMybU7uts/6GF+TPI3Sxwcci9oesEmv7FBIuMib8iJmGm9Rnm4zomwwsHE=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB0923;
x-ms-traffictypediagnostic: MW2PR2101MB0923:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB09232700EB88AC83D14CE63DA1670@MW2PR2101MB0923.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB0923;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0923;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(51914003)(189003)(199004)(22452003)(81156014)(305945005)(86362001)(5660300001)(86612001)(6916009)(6116002)(6486002)(6436002)(2900100001)(1076002)(5640700003)(7736002)(81166006)(486006)(8656006)(105586002)(102836004)(316002)(6506007)(8676002)(106356001)(46003)(1730700003)(476003)(186003)(52116002)(54906003)(8936002)(59450400001)(99286004)(2616005)(386003)(6512007)(14454004)(97736004)(478600001)(53936002)(39060400002)(107886003)(25786009)(4326008)(10290500003)(3660700001)(5250100002)(3280700002)(2501003)(2351001)(2906002)(10090500001)(68736007)(36756003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0923;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SmXTbuLev5iLHVNIH3D54y2v1lSboo7Z6alTa6NDhEqijm5e8EPa8wroC60O1TGoAxkKP5vvAq843C+Gwa46Aj7zldgUR9mfeZzvZXmq4+xRI662wXU1QiwdExXrQCcq/GlbL/K3np3x1Td53SjsQkQkm6c0skZzWn7xgpHe/gRSlldGBjv78Qmtt6w2e7oY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEBB44F55EE56A4D9E559EF5ACCEC8EC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e61b899c-9cc1-447f-5486-08d5ca3b8433
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61b899c-9cc1-447f-5486-08d5ca3b8433
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:12.0444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0923
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGZvciB0aGUgZmVlZGJhY2sgb24gdjMuIFRoZXJlIHdlcmUgc2V2ZXJhbCBzbWFsbCBj
bGVhbnVwcywgYnV0DQpwZXJoYXBzIHRoZSBiaWdnZXN0IGNoYW5nZSBpcyB0aGUgYWRkaXRpb24g
b2YgImNvbW1pdC1ncmFwaDogdXNlDQpzdHJpbmctbGlzdCBBUEkgZm9yIGlucHV0IiB3aGljaCBt
YWtlcyAiY29tbWl0LWdyYXBoOiBhZGQgJy0tcmVhY2hhYmxlJw0Kb3B0aW9uIiBtdWNoIHNpbXBs
ZXIuDQoNClRoZSBpbnRlci1kaWZmIGlzIHN0aWxsIHJlYXNvbmFibHkgbGFyZ2UsIGJ1dCBJJ2xs
IHNlbmQgaXQgaW4gYQ0KZm9sbG93LXVwIFBSLg0KDQpUaGFua3MsDQotU3RvbGVlDQoNCkRlcnJp
Y2sgU3RvbGVlICgyMSk6DQogIGNvbW1pdC1ncmFwaDogVU5MRUFLIGJlZm9yZSBkaWUoKQ0KICBj
b21taXQtZ3JhcGg6IGZpeCBHUkFQSF9NSU5fU0laRQ0KICBjb21taXQtZ3JhcGg6IHBhcnNlIGNv
bW1pdCBmcm9tIGNob3NlbiBncmFwaA0KICBjb21taXQ6IGZvcmNlIGNvbW1pdCB0byBwYXJzZSBm
cm9tIG9iamVjdCBkYXRhYmFzZQ0KICBjb21taXQtZ3JhcGg6IGxvYWQgYSByb290IHRyZWUgZnJv
bSBzcGVjaWZpYyBncmFwaA0KICBjb21taXQtZ3JhcGg6IGFkZCAndmVyaWZ5JyBzdWJjb21tYW5k
DQogIGNvbW1pdC1ncmFwaDogdmVyaWZ5IGNhdGNoZXMgY29ycnVwdCBzaWduYXR1cmUNCiAgY29t
bWl0LWdyYXBoOiB2ZXJpZnkgcmVxdWlyZWQgY2h1bmtzIGFyZSBwcmVzZW50DQogIGNvbW1pdC1n
cmFwaDogdmVyaWZ5IGNvcnJ1cHQgT0lEIGZhbm91dCBhbmQgbG9va3VwDQogIGNvbW1pdC1ncmFw
aDogdmVyaWZ5IG9iamVjdHMgZXhpc3QNCiAgY29tbWl0LWdyYXBoOiB2ZXJpZnkgcm9vdCB0cmVl
IE9JRHMNCiAgY29tbWl0LWdyYXBoOiB2ZXJpZnkgcGFyZW50IGxpc3QNCiAgY29tbWl0LWdyYXBo
OiB2ZXJpZnkgZ2VuZXJhdGlvbiBudW1iZXINCiAgY29tbWl0LWdyYXBoOiB2ZXJpZnkgY29tbWl0
IGRhdGUNCiAgY29tbWl0LWdyYXBoOiB0ZXN0IGZvciBjb3JydXB0ZWQgb2N0b3B1cyBlZGdlDQog
IGNvbW1pdC1ncmFwaDogdmVyaWZ5IGNvbnRlbnRzIG1hdGNoIGNoZWNrc3VtDQogIGZzY2s6IHZl
cmlmeSBjb21taXQtZ3JhcGgNCiAgY29tbWl0LWdyYXBoOiB1c2Ugc3RyaW5nLWxpc3QgQVBJIGZv
ciBpbnB1dA0KICBjb21taXQtZ3JhcGg6IGFkZCAnLS1yZWFjaGFibGUnIG9wdGlvbg0KICBnYzog
YXV0b21hdGljYWxseSB3cml0ZSBjb21taXQtZ3JhcGggZmlsZXMNCiAgY29tbWl0LWdyYXBoOiB1
cGRhdGUgZGVzaWduIGRvY3VtZW50DQoNCiBEb2N1bWVudGF0aW9uL2NvbmZpZy50eHQgICAgICAg
ICAgICAgICAgIHwgIDEwICstDQogRG9jdW1lbnRhdGlvbi9naXQtY29tbWl0LWdyYXBoLnR4dCAg
ICAgICB8ICAxNCArLQ0KIERvY3VtZW50YXRpb24vZ2l0LWZzY2sudHh0ICAgICAgICAgICAgICAg
fCAgIDMgKw0KIERvY3VtZW50YXRpb24vZ2l0LWdjLnR4dCAgICAgICAgICAgICAgICAgfCAgIDQg
Kw0KIERvY3VtZW50YXRpb24vdGVjaG5pY2FsL2NvbW1pdC1ncmFwaC50eHQgfCAgMjIgLS0NCiBi
dWlsdGluL2NvbW1pdC1ncmFwaC5jICAgICAgICAgICAgICAgICAgIHwgIDk4ICsrKysrKy0tLQ0K
IGJ1aWx0aW4vZnNjay5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjEgKysNCiBidWls
dGluL2djLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICsNCiBjb21taXQtZ3Jh
cGguYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjQ4ICsrKysrKysrKysrKysrKysrKysr
Ky0tDQogY29tbWl0LWdyYXBoLmggICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMCArLQ0K
IGNvbW1pdC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKy0NCiBjb21t
aXQuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiB0L3Q1MzE4LWNv
bW1pdC1ncmFwaC5zaCAgICAgICAgICAgICAgICAgIHwgMjAxICsrKysrKysrKysrKysrKysrKw0K
IDEzIGZpbGVzIGNoYW5nZWQsIDU2OSBpbnNlcnRpb25zKCspLCA3OCBkZWxldGlvbnMoLSkNCg0K
LS0gDQoyLjE4LjAucmMxDQoNCg==
