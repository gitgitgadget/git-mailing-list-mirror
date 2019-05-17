Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABDAC1F461
	for <e@80x24.org>; Fri, 17 May 2019 12:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfEQMMB (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 08:12:01 -0400
Received: from mail-eopbgr50139.outbound.protection.outlook.com ([40.107.5.139]:45031
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727221AbfEQMMB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 08:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qt.io; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUJNjFZRSPmFbBbTm/X6QLZ+mNQWtG743kOL2xhC8K8=;
 b=FWsOcRBcTe0Nbm+W2PPSuUOnte/chj0rqYjhZqaOVq9GwO5K5MDhuBEUPlm+VzG3nJZlztZVBrD28ohDVUhrPA9WfcoMoR31vRe+bED1gz2l6gH1TheglqmJm3vDSniAioynKBvLwXJ2ICK+qEHKsiiYeEKiKUohTaVUpC3W2j8=
Received: from DB6PR0202MB2759.eurprd02.prod.outlook.com (10.171.71.145) by
 DB6PR0202MB2742.eurprd02.prod.outlook.com (10.171.78.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Fri, 17 May 2019 12:11:54 +0000
Received: from DB6PR0202MB2759.eurprd02.prod.outlook.com
 ([fe80::1496:f1ea:c027:e906]) by DB6PR0202MB2759.eurprd02.prod.outlook.com
 ([fe80::1496:f1ea:c027:e906%5]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 12:11:54 +0000
From:   Allan Jensen <Allan.Jensen@qt.io>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [Patch] Fixing diff.ignoreSubmodules
Thread-Topic: [Patch] Fixing diff.ignoreSubmodules
Thread-Index: AQHVDKm3QI2E+TzXuk2+CpyodAcUCw==
Date:   Fri, 17 May 2019 12:11:54 +0000
Message-ID: <4489241.31r3eYUQgx@twilight>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::16)
 To DB6PR0202MB2759.eurprd02.prod.outlook.com (2603:10a6:4:a8::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Allan.Jensen@qt.io; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [62.220.2.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c52dc0e0-93df-40aa-4e67-08d6dac0d996
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(49563074)(7193020);SRVR:DB6PR0202MB2742;
x-ms-traffictypediagnostic: DB6PR0202MB2742:
x-microsoft-antispam-prvs: <DB6PR0202MB27429EE5FA04DD2F84C6A7248E0B0@DB6PR0202MB2742.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(39850400004)(346002)(396003)(376002)(136003)(199004)(189003)(6486002)(44832011)(2501003)(305945005)(478600001)(486006)(26005)(33716001)(66066001)(14454004)(476003)(386003)(8936002)(186003)(6436002)(2351001)(86362001)(2906002)(72206003)(7736002)(6506007)(102836004)(5640700003)(6512007)(8676002)(6916009)(3846002)(6116002)(99286004)(81166006)(68736007)(52116002)(81156014)(1730700003)(9686003)(66446008)(66556008)(66476007)(66616009)(64756008)(66946007)(73956011)(74482002)(316002)(25786009)(99936001)(71200400001)(71190400001)(5024004)(53936002)(4744005)(256004)(5660300002)(39026011);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2742;H:DB6PR0202MB2759.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: qt.io does not designate permitted
 sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xlFu9Agdtks0na/rkMtfB+OV1+y/yfCSqD/fEcDtOzNV0AK0aSPJhQBHqnqtVUnRpddMF2kAG7IB4twdNHhILdGnVwJSB52/3EBY3nvd0ZlneJ82p9WuVRD8bxox+Bl3ZIxRBAWckjQjrTFQNRAoiZ3vxq6z4Ciwrs22gTU4N07dH7GDhcg9hqh+mB5KYzbXRh5DTzaCIJEQIi9wjAEXhuwdUf75alqybOq2JttSsHz7oonoJXvQPRaTXprcFZWMY7pMdChjq7bSET/YZ/rBOhmZgNRxuHpdefWI+qvK3x4pNpMhrSnKQwlCN7APJVgtNZ9TGiMjoMb0yDLYP3Mn5gggGCSp8nIfCLvUvqDmYdkQm/wTse8IvtgdD8+c1grwyYDfbPtSqMRuS8Nufy5IxmCvmCHNURiLpZhk58nvZTI=
Content-Type: multipart/mixed; boundary="_002_448924131r3eYUQgxtwilight_"
MIME-Version: 1.0
X-OriginatorOrg: qt.io
X-MS-Exchange-CrossTenant-Network-Message-Id: c52dc0e0-93df-40aa-4e67-08d6dac0d996
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 12:11:54.3600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 20d0b167-794d-448a-9d01-aaeccc1124ac
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2742
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--_002_448924131r3eYUQgxtwilight_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8453570FDDD6741896E711DFC14152F@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

Hi git team

I had trouble getting diff.ignoreSubmodules to work at all in any of my git=
=20
projects, and googling around I found many other people who also couldn't g=
et=20
it to work. I found the source of the issue and attached a patch fixing it,=
=20
though the old non-working behavior seems to have been almost on purpose.
(further details are in the change)

Feel free to apply or rewrite as you want.

Best regards
'Allan=

--_002_448924131r3eYUQgxtwilight_
Content-Type: text/x-patch; name="fix-ignoreSubmodule.diff"
Content-Description: fix-ignoreSubmodule.diff
Content-Disposition: attachment; filename="fix-ignoreSubmodule.diff";
	size=3885; creation-date="Fri, 17 May 2019 12:11:53 GMT";
	modification-date="Fri, 17 May 2019 12:11:53 GMT"
Content-ID: <355E900EAA14DC469E7890CFBA09372C@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64

Y29tbWl0IDQ2MDBiMTZlM2EwOTRhM2IzNTYyOGZjOTU0OTUxMTE3ZDRkNjRhMDYNCkF1dGhvcjog
QWxsYW4gU2FuZGZlbGQgSmVuc2VuIDxhbGxhbi5qZW5zZW5AcXQuaW8+DQpEYXRlOiAgIEZyaSBN
YXkgMTcgMTQ6MDE6NTUgMjAxOSArMDIwMA0KDQogICAgRml4IGRpZmYuaWdub3JlU3VibW9kdWxl
cyB0byBtYXRjaCBkb2N1bWVudGF0aW9uDQogICAgDQogICAgSXQgd2FzIG5vdCBvcGVyYXRpbmcg
YXMgdGhlIGRlZmF1bHQgdmFsdWUgb2YgLS1pZ25vcmUtc3VibW9kdWxlcywNCiAgICBzaW5jZSB1
bmxpa2UgdGhlIGNvbW1hbmQtbGluZSBvcHRpb24gaXQgd2FzIG92ZXJyaWRkZW4gYnkNCiAgICBt
b2R1bGUuWC5pZ25vcmUuIEFuZCBzaW5jZSBtYW55IHByb2plY3RzIHNldCBhIHN1Ym1vYnVsZSBp
Z25vcmUNCiAgICB2YWx1ZSBieSBkZWZhdWx0LCBkaWZmLmlnbm9yZVN1Ym1vZHVsZXMgd2FzIGlu
IG1hbnkgY2FzZXMgbm90DQogICAgd29ya2luZyBhdCBhbGwuDQoNCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2NvbmZpZy9zdWJtb2R1bGUudHh0IGIvRG9jdW1lbnRhdGlvbi9jb25maWcvc3Vi
bW9kdWxlLnR4dA0KaW5kZXggMGExMjkzYjA1MS4uMDhkYWVjYTc1MyAxMDA2NDQNCi0tLSBhL0Rv
Y3VtZW50YXRpb24vY29uZmlnL3N1Ym1vZHVsZS50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vY29u
ZmlnL3N1Ym1vZHVsZS50eHQNCkBAIC00Myw4ICs0Myw4IEBAIHN1Ym1vZHVsZS48bmFtZT4uaWdu
b3JlOjoNCiAJc3VibW9kdWxlcyB0aGF0IGhhdmUgdW50cmFja2VkIGZpbGVzIGluIHRoZWlyIHdv
cmsgdHJlZSBhcyBjaGFuZ2VkLg0KIAlUaGlzIHNldHRpbmcgb3ZlcnJpZGVzIGFueSBzZXR0aW5n
IG1hZGUgaW4gLmdpdG1vZHVsZXMgZm9yIHRoaXMgc3VibW9kdWxlLA0KIAlib3RoIHNldHRpbmdz
IGNhbiBiZSBvdmVycmlkZGVuIG9uIHRoZSBjb21tYW5kIGxpbmUgYnkgdXNpbmcgdGhlDQotCSIt
LWlnbm9yZS1zdWJtb2R1bGVzIiBvcHRpb24uIFRoZSAnZ2l0IHN1Ym1vZHVsZScgY29tbWFuZHMg
YXJlIG5vdA0KLQlhZmZlY3RlZCBieSB0aGlzIHNldHRpbmcuDQorCSItLWlnbm9yZS1zdWJtb2R1
bGVzIiBvcHRpb24sIG9yIHNldHRpbmcgZGlmZi5pZ25vcmVTdWJtb2R1bGVzLg0KKwlUaGUgJ2dp
dCBzdWJtb2R1bGUnIGNvbW1hbmRzIGFyZSBub3QgYWZmZWN0ZWQgYnkgdGhpcyBzZXR0aW5nLg0K
IA0KIHN1Ym1vZHVsZS48bmFtZT4uYWN0aXZlOjoNCiAJQm9vbGVhbiB2YWx1ZSBpbmRpY2F0aW5n
IGlmIHRoZSBzdWJtb2R1bGUgaXMgb2YgaW50ZXJlc3QgdG8gZ2l0DQpkaWZmIC0tZ2l0IGEvZGlm
Zi5jIGIvZGlmZi5jDQppbmRleCA0ZDNjZjgzYTI3Li45YjQ2NWQ1ZjZjIDEwMDY0NA0KLS0tIGEv
ZGlmZi5jDQorKysgYi9kaWZmLmMNCkBAIC01MDc0LDcgKzUwNzQsNiBAQCBzdGF0aWMgaW50IGRp
ZmZfb3B0X2lnbm9yZV9zdWJtb2R1bGVzKGNvbnN0IHN0cnVjdCBvcHRpb24gKm9wdCwNCiAJQlVH
X09OX09QVF9ORUcodW5zZXQpOw0KIAlpZiAoIWFyZykNCiAJCWFyZyA9ICJhbGwiOw0KLQlvcHRp
b25zLT5mbGFncy5vdmVycmlkZV9zdWJtb2R1bGVfY29uZmlnID0gMTsNCiAJaGFuZGxlX2lnbm9y
ZV9zdWJtb2R1bGVzX2FyZyhvcHRpb25zLCBhcmcpOw0KIAlyZXR1cm4gMDsNCiB9DQpkaWZmIC0t
Z2l0IGEvc3VibW9kdWxlLmMgYi9zdWJtb2R1bGUuYw0KaW5kZXggMmNmYWJhMDU5OS4uNGEzY2Zl
N2IzNiAxMDA2NDQNCi0tLSBhL3N1Ym1vZHVsZS5jDQorKysgYi9zdWJtb2R1bGUuYw0KQEAgLTQy
MCw2ICs0MjAsNyBAQCBjb25zdCBjaGFyICpzdWJtb2R1bGVfc3RyYXRlZ3lfdG9fc3RyaW5nKGNv
bnN0IHN0cnVjdCBzdWJtb2R1bGVfdXBkYXRlX3N0cmF0ZWd5DQogdm9pZCBoYW5kbGVfaWdub3Jl
X3N1Ym1vZHVsZXNfYXJnKHN0cnVjdCBkaWZmX29wdGlvbnMgKmRpZmZvcHQsDQogCQkJCSAgY29u
c3QgY2hhciAqYXJnKQ0KIHsNCisJZGlmZm9wdC0+ZmxhZ3Mub3ZlcnJpZGVfc3VibW9kdWxlX2Nv
bmZpZyA9IDE7DQogCWRpZmZvcHQtPmZsYWdzLmlnbm9yZV9zdWJtb2R1bGVzID0gMDsNCiAJZGlm
Zm9wdC0+ZmxhZ3MuaWdub3JlX3VudHJhY2tlZF9pbl9zdWJtb2R1bGVzID0gMDsNCiAJZGlmZm9w
dC0+ZmxhZ3MuaWdub3JlX2RpcnR5X3N1Ym1vZHVsZXMgPSAwOw0KZGlmZiAtLWdpdCBhL3QvdDIw
MTMtY2hlY2tvdXQtc3VibW9kdWxlLnNoIGIvdC90MjAxMy1jaGVja291dC1zdWJtb2R1bGUuc2gN
CmluZGV4IDhmODZiNWY0YjIuLjA1YjBjNzU5YjkgMTAwNzU1DQotLS0gYS90L3QyMDEzLWNoZWNr
b3V0LXN1Ym1vZHVsZS5zaA0KKysrIGIvdC90MjAxMy1jaGVja291dC1zdWJtb2R1bGUuc2gNCkBA
IC00NCwxMSArNDQsMTEgQEAgdGVzdF9leHBlY3Rfc3VjY2VzcyAnImNoZWNrb3V0IDxzdWJtb2R1
bGU+IiBob25vcnMgZGlmZi5pZ25vcmVTdWJtb2R1bGVzJyAnDQogCWdpdCBjb25maWcgZGlmZi5p
Z25vcmVTdWJtb2R1bGVzIGRpcnR5ICYmDQogCWVjaG8geD4gc3VibW9kdWxlL3VudHJhY2tlZCAm
Jg0KIAlnaXQgY2hlY2tvdXQgSEVBRCA+YWN0dWFsIDI+JjEgJiYNCi0JdGVzdF9tdXN0X2JlX2Vt
cHR5IGFjdHVhbA0KKwl0ZXN0X211c3RfYmVfZW1wdHkgYWN0dWFsICYmDQorCWdpdCBjb25maWcg
LS11bnNldCBkaWZmLmlnbm9yZVN1Ym1vZHVsZXMNCiAnDQogDQogdGVzdF9leHBlY3Rfc3VjY2Vz
cyAnImNoZWNrb3V0IDxzdWJtb2R1bGU+IiBob25vcnMgc3VibW9kdWxlLiouaWdub3JlIGZyb20g
LmdpdG1vZHVsZXMnICcNCi0JZ2l0IGNvbmZpZyBkaWZmLmlnbm9yZVN1Ym1vZHVsZXMgbm9uZSAm
Jg0KIAlnaXQgY29uZmlnIC1mIC5naXRtb2R1bGVzIHN1Ym1vZHVsZS5zdWJtb2R1bGUucGF0aCBz
dWJtb2R1bGUgJiYNCiAJZ2l0IGNvbmZpZyAtZiAuZ2l0bW9kdWxlcyBzdWJtb2R1bGUuc3VibW9k
dWxlLmlnbm9yZSB1bnRyYWNrZWQgJiYNCiAJZ2l0IGNoZWNrb3V0IEhFQUQgPmFjdHVhbCAyPiYx
ICYmDQpkaWZmIC0tZ2l0IGEvdC90NDAyNy1kaWZmLXN1Ym1vZHVsZS5zaCBiL3QvdDQwMjctZGlm
Zi1zdWJtb2R1bGUuc2gNCmluZGV4IDlhYThlMmIzOWIuLmU4NDM1OGNhMDIgMTAwNzU1DQotLS0g
YS90L3Q0MDI3LWRpZmYtc3VibW9kdWxlLnNoDQorKysgYi90L3Q0MDI3LWRpZmYtc3VibW9kdWxl
LnNoDQpAQCAtMTE3LDYgKzExNyw3IEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2dpdCBkaWZmIEhF
QUQgd2l0aCBkaXJ0eSBzdWJtb2R1bGUgKHdvcmsgdHJlZSwgcmVmcyBtYXRjaCkNCiAJZ2l0IGNv
bmZpZyBkaWZmLmlnbm9yZVN1Ym1vZHVsZXMgZGlydHkgJiYNCiAJZ2l0IGRpZmYgSEVBRCA+YWN0
dWFsICYmDQogCXRlc3RfbXVzdF9iZV9lbXB0eSBhY3R1YWwgJiYNCisJZ2l0IGNvbmZpZyAtLXVu
c2V0IGRpZmYuaWdub3JlU3VibW9kdWxlcyAmJg0KIAlnaXQgY29uZmlnIC0tYWRkIC1mIC5naXRt
b2R1bGVzIHN1Ym1vZHVsZS5zdWJuYW1lLmlnbm9yZSBub25lICYmDQogCWdpdCBjb25maWcgLS1h
ZGQgLWYgLmdpdG1vZHVsZXMgc3VibW9kdWxlLnN1Ym5hbWUucGF0aCBzdWIgJiYNCiAJZ2l0IGRp
ZmYgSEVBRCA+YWN0dWFsICYmDQpAQCAtMTQzLDcgKzE0NCw2IEBAIHRlc3RfZXhwZWN0X3N1Y2Nl
c3MgJ2dpdCBkaWZmIEhFQUQgd2l0aCBkaXJ0eSBzdWJtb2R1bGUgKHdvcmsgdHJlZSwgcmVmcyBt
YXRjaCkNCiAJdGVzdF9jbXAgZXhwZWN0LmJvZHkgYWN0dWFsLmJvZHkgJiYNCiAJZ2l0IGNvbmZp
ZyAtLXJlbW92ZS1zZWN0aW9uIHN1Ym1vZHVsZS5zdWJuYW1lICYmDQogCWdpdCBjb25maWcgLS1y
ZW1vdmUtc2VjdGlvbiAtZiAuZ2l0bW9kdWxlcyBzdWJtb2R1bGUuc3VibmFtZSAmJg0KLQlnaXQg
Y29uZmlnIC0tdW5zZXQgZGlmZi5pZ25vcmVTdWJtb2R1bGVzICYmDQogCXJtIC5naXRtb2R1bGVz
DQogJw0KIA0K

--_002_448924131r3eYUQgxtwilight_--
