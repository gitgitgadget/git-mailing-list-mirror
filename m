Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C481D1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 15:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfHAPdB (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 11:33:01 -0400
Received: from mail-eopbgr780074.outbound.protection.outlook.com ([40.107.78.74]:23808
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbfHAPdB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 11:33:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2Uz1tTCwh8NiXNulc6MgCNVtOw9eDpnVOiyIqss9aS7gN+SYcsqiIZPao8gQFEUGZRroF+Z6wIM/bKL1efR9T06Ss+PKDl7I9QAoxF3XSFmc+En8AZ3t0EOX+nOl5UpuUYOrAZshLs0Nk4LKF6gN8dZ35CY5D9bJKw4dF8SL5KaVc70v2htYl5Fz398t2cjaShmf0inFccP6PSA9VLSC+iVjJn20kMMHp7lnV3Ge37CRnR1B2NUKhDAqiE7N5onhs+FaxqMiooWyqkPUYVgkx9wAwt2Q8ARMNexb8EDg9dlkzRZRe2oxxski0ZRtJXz7n6zdQqQvpBZEMbPFvMpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmyEDxOg1oct4qPI7zl2i/Ylbqjek+CfEnrxHxGgTvc=;
 b=PBCJ6XqSyH49/kpbyQvSaNUXW47Q0o3VJWHdxCfqRAdj8LPrJgn4WSxUbTDjvsiJcVLsgOjzrvfN/qyJXJQbNTlMazR1zu7i0eOHvv3HGktDYtmqmyOwJzanuK/QWH9lrnc8P0L2HXdvIo9apqhB4HuxHrPF21nWHBBBkYKSMF+Vmc9r472SCM2iwGkHZtXa0TdjDVkgAXmmSo+o5U64nnXH3GPQPsiW/M8e7yJuXrQgTMRS95H+5tb2oeGTHHXGGhJrrEjeTmJIHEmRvDZIN1feBEnUOO4tEc7BgAfLEQh7LG2FVeTNYyz+LTlfAY5Vwj1FDRZas74YrwWH35/Opg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bentley.com;dmarc=pass action=none
 header.from=bentley.com;dkim=pass header.d=bentley.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bentley.onmicrosoft.com; s=selector2-bentley-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmyEDxOg1oct4qPI7zl2i/Ylbqjek+CfEnrxHxGgTvc=;
 b=fl1SadKh0Y/hh7bWQtRNdHrwfUBtSsaoV8WuL+GGyicorC1dcTgGzG+fkapEQ8kO5k+SmjQL9h4wm0icJXXZp5lsoLDQ3AqyCj/UJ/cQ+4Ug9Lx4UfD2JRYWkLqxrW2/lUPnbuBKS79SBc7mQQd3ORZQWHacDmx9hyhvDm/gvrA=
Received: from BL0PR1901MB2097.namprd19.prod.outlook.com (52.132.22.19) by
 BL0PR1901MB2050.namprd19.prod.outlook.com (52.132.25.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Thu, 1 Aug 2019 15:30:19 +0000
Received: from BL0PR1901MB2097.namprd19.prod.outlook.com
 ([fe80::2d4f:f059:cf4f:8f7b]) by BL0PR1901MB2097.namprd19.prod.outlook.com
 ([fe80::2d4f:f059:cf4f:8f7b%4]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 15:30:19 +0000
From:   Philip McGraw <Philip.McGraw@bentley.com>
To:     "ahippo@yandex.ru" <ahippo@yandex.ru>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "luke@diamand.org" <luke@diamand.org>
Subject: RE: [PATCH] git-p4: close temporary file before removing
Thread-Topic: [PATCH] git-p4: close temporary file before removing
Thread-Index: AdVG9CjdiOqwVlefRbaG5Wv1p1dyogATdS2AABidORAAAUXFAAAPDdMAAAjilIAAG3pVMA==
Date:   Thu, 1 Aug 2019 15:30:18 +0000
Message-ID: <BL0PR1901MB2097141B412696422CE957F4FFDE0@BL0PR1901MB2097.namprd19.prod.outlook.com>
References: <BL0PR1901MB209738ADDF9D931253E8C317FFDC0@BL0PR1901MB2097.namprd19.prod.outlook.com>
         <1955471564537683@vla1-53bffb0b04ed.qloud-c.yandex.net>
         <BL0PR1901MB2097EA8851C2743D46210D38FFDF0@BL0PR1901MB2097.namprd19.prod.outlook.com>
         <2835251564582156@myt6-4218ece6190d.qloud-c.yandex.net>
 <BL0PR1901MB209790A0A8F5F9C8EFB8B3F0FFDF0@BL0PR1901MB2097.namprd19.prod.outlook.com>
 <2717551564623283@vla1-822b1b47a947.qloud-c.yandex.net>
In-Reply-To: <2717551564623283@vla1-822b1b47a947.qloud-c.yandex.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Philip.McGraw@bentley.com; 
x-originating-ip: [64.90.224.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de1df10c-6fbb-417f-1580-08d716952902
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR1901MB2050;
x-ms-traffictypediagnostic: BL0PR1901MB2050:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR1901MB205036AB1744A1B1F6C05918FFDE0@BL0PR1901MB2050.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(199004)(189003)(476003)(486006)(7736002)(305945005)(6506007)(53546011)(66476007)(66446008)(64756008)(26005)(446003)(11346002)(66556008)(66946007)(74316002)(478600001)(14454004)(6246003)(25786009)(186003)(4326008)(76176011)(102836004)(86362001)(68736007)(76116006)(2351001)(33656002)(19627235002)(2906002)(3846002)(2501003)(6116002)(52536014)(229853002)(7696005)(14444005)(66066001)(256004)(71190400001)(71200400001)(54906003)(55016002)(1361003)(5660300002)(6436002)(316002)(6916009)(53936002)(8936002)(5640700003)(81156014)(1730700003)(6306002)(99286004)(9686003)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2050;H:BL0PR1901MB2097.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bentley.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u5TYGcYDRJitGr1SFrRBdl3F+joOrK8TibaECi2aTBCTnTainLr+oHN4vGYSUEB89tRj2feL13MpQM0kneKs5RhnDAPH6RzEVLZ8Z/NqBzOdJfhsBmioBzEpLOy3R5cNCb2L1bYyER4xFutrbBHCn/KvZosoyIAuwNjKlMz+0W+1bjTwbYyhDeXn1t9fYgCV9SBoUMI0litCSJxcjt4lyARcAPJ2EFO1/3NVtoIBiSyHMHvDyjIiKYVdw8XheuwLVKr3LtmTvSKErCPWVqlhF+nsqxY6r+uWGS4rT3ckheQmbKb9XENpREvwSGJcXiNSiWl1eiCm0oQrvx1SdzCh3gUpMrtuNStuQNK0l0pjAilImSFRnEO3zrUn/NLmZ0RYRwe5rEh4jcEQxQFSXbKrtldjLj5r0HiW+IEVbxAlv60=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bentley.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1df10c-6fbb-417f-1580-08d716952902
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 15:30:18.8905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 067e9632-ea4c-4ed9-9e6d-e294956e284b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Philip.McGraw@bentley.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2050
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBGcm9tOiBBbmRyZXkgPGFoaXBwb0B5YW5kZXgucnU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgMzEg
SnVseSwgMjAxOSAyMTozNQ0KPiBUbzogUGhpbGlwIE1jR3JhdyA8UGhpbGlwLk1jR3Jhd0BiZW50
bGV5LmNvbT4NCj4gQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmc7IGx1a2VAZGlhbWFuZC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gZ2l0LXA0OiBjbG9zZSB0ZW1wb3JhcnkgZmlsZSBiZWZvcmUg
cmVtb3ZpbmcNCj4gDQo+IDMxLjA3LjIwMTksIDE3OjUyLCAiUGhpbGlwIE1jR3JhdyIgPHBoaWxp
cC5tY2dyYXdAYmVudGxleS5jb20+Og0KPiA+IDIwMTkuMDcuMzEgMTA6MDkgQW5kcmV5IDxhaGlw
cG9AeWFuZGV4LnJ1Pg0KPiA+PiAzMS4wNy4yMDE5LCAwOTo1MywgIlBoaWxpcCBNY0dyYXciIDxw
aGlsaXAubWNncmF3QGJlbnRsZXkuY29tPjoNCj4gPj4+PiDCoMKgMzAuMDcuMjAxOSwgMTM6Mzcs
ICJQaGlsaXAgTWNHcmF3IiA8cGhpbGlwLm1jZ3Jhd0BiZW50bGV5LmNvbT46DQo+ID4+Pj4gwqDC
oD4gcHl0aG9uIG9zLnJlbW92ZSgpIHRocm93cyBleGNlcHRpb25zIG9uIFdpbmRvd3MgcGxhdGZv
cm0gd2hlbg0KPiBhdHRlbXB0aW5nDQo+ID4+Pj4gwqDCoD4gdG8gcmVtb3ZlIGZpbGUgd2hpbGUg
aXQgaXMgc3RpbGwgb3Blbi4gTmVlZCB0byBncmFiIGZpbGVuYW1lDQo+IHdoaWxlIGZpbGUgb3Bl
biwNCj4gPj4+PiDCoMKgPiBjbG9zZSBmaWxlIGhhbmRsZSwgdGhlbiByZW1vdmUgYnkgbmFtZS4g
QXBwYXJlbnRseSBvdGhlcg0KPiBwbGF0Zm9ybXMgYXJlIG1vcmUNCj4gPj4+PiDCoMKgPiBwZXJt
aXNzaXZlIG9mIHJlbW92aW5nIGZpbGVzIHdoaWxlIGJ1c3kuDQo+ID4+Pj4gwqDCoD4gcmVmZXJl
bmNlOg0KPiA+Pj4+IMKgwqA+IC0tLQ0KPiA+Pj4+IMKgwqA+IMKgZ2l0LXA0LnB5IHwgNCArKyst
DQo+ID4+Pj4gwqDCoD4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4+Pj4gwqDCoD4NCj4gPj4+PiDCoMKgPiBkaWZmIC0tZ2l0IGEvZ2l0LXA0LnB5
IGIvZ2l0LXA0LnB5DQo+ID4+Pj4gwqDCoD4gaW5kZXggYzcxYTY4MzJlMi4uNmI5ZDJhODMxNyAx
MDA3NTUNCj4gPj4+PiDCoMKgPiAtLS0gYS9naXQtcDQucHkNCj4gPj4+PiDCoMKgPiArKysgYi9n
aXQtcDQucHkNCj4gPj4+PiDCoMKgPiBAQCAtMTE2MSwxMiArMTE2MSwxNCBAQCBkZWYgZXhjZWVk
c0xhcmdlRmlsZVRocmVzaG9sZChzZWxmLA0KPiByZWxQYXRoLCBjb250ZW50cyk6DQo+ID4+Pj4g
wqDCoD4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBGYWxzZQ0KPiA+
Pj4+IMKgwqA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29udGVudFRlbXBGaWxlID0gc2Vs
Zi5nZW5lcmF0ZVRlbXBGaWxlKGNvbnRlbnRzKQ0KPiA+Pj4+IMKgwqA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgY29tcHJlc3NlZENvbnRlbnRGaWxlID0NCj4gdGVtcGZpbGUuTmFtZWRUZW1w
b3JhcnlGaWxlKHByZWZpeD0nZ2l0LXA0LWxhcmdlLWZpbGUnLCBkZWxldGU9RmFsc2UpDQo+ID4+
Pj4gwqDCoD4gKyBjb21wcmVzc2VkQ29udGVudEZpbGVOYW1lID0gY29tcHJlc3NlZENvbnRlbnRG
aWxlLm5hbWUNCj4gPj4+PiDCoMKgPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHpmID0gemlw
ZmlsZS5aaXBGaWxlKGNvbXByZXNzZWRDb250ZW50RmlsZS5uYW1lLA0KPiBtb2RlPSd3JykNCj4g
Pj4+PiDCoMKgPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHpmLndyaXRlKGNvbnRlbnRUZW1w
RmlsZSwNCj4gY29tcHJlc3NfdHlwZT16aXBmaWxlLlpJUF9ERUZMQVRFRCkNCj4gPj4+PiDCoMKg
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHpmLmNsb3NlKCkNCj4gPj4+PiDCoMKgPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXByZXNzZWRDb250ZW50c1NpemUgPQ0KPiB6Zi5pbmZv
bGlzdCgpWzBdLmNvbXByZXNzX3NpemUNCj4gPj4+PiDCoMKgPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoG9zLnJlbW92ZShjb250ZW50VGVtcEZpbGUpDQo+ID4+Pj4gwqDCoD4gLSBvcy5yZW1v
dmUoY29tcHJlc3NlZENvbnRlbnRGaWxlLm5hbWUpDQo+ID4+Pj4gwqDCoD4gKyBjb21wcmVzc2Vk
Q29udGVudEZpbGUuY2xvc2UoKQ0KPiA+Pj4+IMKgwqA+ICsgb3MucmVtb3ZlKGNvbXByZXNzZWRD
b250ZW50RmlsZU5hbWUpDQo+ID4+Pj4NCj4gPj4+PiDCoMKgSSdtIG5vdCBzdXJlIHdoeSBOYW1l
ZFRlbXBvcmFyeUZpbGUoKSBpcyBjYWxsZWQgd2l0aCBkZWxldGU9RmFsc2UNCj4gYWJvdmUsDQo+
ID4+Pj4gwqDCoGJ1dCBpdCBhcHBlYXJzIHRvIG1lIHRoYXQgaXQgY2FuIGhhdmUgZGVsZXRlPVRy
dWUgaW5zdGVhZCwNCj4gPj4+PiDCoMKgc28gdGhhdCB0aGVyZSBpcyBubyBuZWVkIHRvIGNhbGwg
b3MucmVtb3ZlKCkgZXhwbGljaXRseQ0KPiA+Pj4+IMKgwqBhbmQgdGh1cyB3b3JyeSBhYm91dCBy
ZW1vdmUgdnMgY2xvc2Ugb3JkZXJpbmcgYXQgYWxsLg0KPiA+Pj4+DQo+ID4+Pj4gwqDCoD4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiBjb21wcmVzc2VkQ29udGVudHNTaXplID4gZ2l0Q29u
ZmlnSW50KCdnaXQtDQo+IHA0LmxhcmdlRmlsZUNvbXByZXNzZWRUaHJlc2hvbGQnKToNCj4gPj4+
PiDCoMKgPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIFRydWUNCj4g
Pj4+PiDCoMKgPiDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gRmFsc2UNCj4gPj4+PiDCoMKgPiAt
LQ0KPiA+Pj4+IMKgwqA+IDIuMjEuMC53aW5kb3dzLjENCj4gPj4+Pg0KPiA+Pj4+IMKgwqBUaGFu
ayB5b3UsDQo+ID4+Pj4gwqDCoEFuZHJleS4NCj4gPj4+DQo+ID4+PiDCoFRoYW5rcyBBbmRyZXk7
IHNpbXBsZXIgaXMgY2VydGFpbmx5IGJldHRlciEgSSB3aWxsIHRlc3QgYW5kIHJlLXN1Ym1pdA0K
PiB2MiBvZiBwYXRjaCB3aXRoIHRoYXQgYXBwcm9hY2guDQo+ID4+DQo+ID4+IFRoYW5rIHlvdSwg
dGhhdCB3b3VsZCBiZSBncmVhdCENCj4gPj4NCj4gPj4gLS0NCj4gPj4gQW5kcmV5Lg0KPiA+DQo+
ID4gVW5mb3J0dW5hdGVseSBpdCB3YXNuJ3QgYXMgc2ltcGxlIGl0IHNlZW1lZDogdXBvbiB0ZXN0
aW5nIHdpdGggb25seQ0KPiBjaGFuZ2luZyBkZWxldGU9VHJ1ZSwNCj4gPiBmb3VuZCB0aGF0IHRo
ZSBwcm9ibGVtIHdhcyBub3Qgc29sdmVkLiBVcG9uIGZ1cnRoZXIgZGVidWdnaW5nLA0KPiByZWNv
ZGVkL3JlZmFjdG9yZWQgc2xpZ2h0bHkgYWRkaW5nDQo+ID4gYWxsb2NhdGVUZW1wRmlsZU5hbWUo
KSBsb2NhbGx5IHNjb3BlZCBmdW5jdGlvbiB0byB0cnkgdG8gY2xhcmlmeSBob3cgdGhlDQo+IE5h
bWVkVGVtcG9yYXJ5RmlsZSgpDQo+ID4gd2FzIGFjdHVhbGx5IGJlaW5nIHVzZWQuDQo+ID4NCj4g
PiBXZSBjYW4ndCBkZXBlbmQgb24gdGhlIGRlbGV0ZS1vbi1jbG9zZSBiZWNhdXNlIHRoZSBOYW1l
ZFRlbXBvcmFyeUZpbGUoKQ0KPiBpcyBtZXJlbHkgYWxsb2NhdGluZw0KPiA+IGEgdGVtcG9yYXJ5
IG5hbWUgZm9yIHJlYWwgdXNlIGJ5IHRoZSB6aXBmaWxlIG9wZW4tZm9yLXdyaXRlIHdoaWNoIGZh
aWxzDQo+IChvbiBXaW5kb3dzKSBpZiBmaWxlDQo+ID4gd2FzIG5vdCBleHBsaWNpdGx5IGNsb3Nl
ZCBmaXJzdC4NCj4gDQo+IE9oLCBzb3JyeSBmb3IgbWlzZ3VpZGluZyB5b3UhDQo+IEkgZGlkbid0
IHRoaW5rIG9mIHRoaXMgYXNwZWN0Lg0KDQpObyB3b3JyaWVzISBJIHByb2JhYmx5IGp1c3QgbWlz
dW5kZXJzdG9vZCB0aGUgaW1wbGVtZW50YXRpb24gb2YgeW91ciBpZGVhLg0KPiANCj4gPiBIb3Bl
ZnVsbHkgdGhlIG5ldyBwYXRjaA0KPiAoaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29t
L3YyL3VybD91PWh0dHBzLQ0KPiAzQV9fZ2l0aHViLmNvbV9naXRnaXRnYWRnZXRfZ2l0X3B1bGxf
MzAxJmQ9RHdJRGFRJmM9aG1HVExPcGgxcWRfVm5DcWo4MUh6RQ0KPiBXa0RheG1ZZElXUkJkb0Zn
Z3poajgmcj1iMGlrRk1KR3c3eHhoRjN5amV4aVdKcEx1TnhsQWgxU3ZVRHVVSi0NCj4gcEhtRSZt
PTFqR09yVl9JMU1nNWFqa0o3eUZFY05seUxuRDZ6WU5YcVhCOVo1U0lQeUUmcz1UZFQ0V0h5UUNr
NVdadHlfQ3ZhakgNCj4gWGdyWkpibUlPbDFnYk1jbmdtam1BcyZlPSApIHdpbGwgbWFrZSB0aGlz
IG1vcmUgY2xlYXIuDQo+IA0KPiBUaGUgbmV3IGNoYW5nZXNldCBsb29rcyBnb29kIHRvIG1lLg0K
PiAoSSdsbCBwb3N0IGEgcmVwbHkgaW4gdGhhdCB0aHJlYWQgdG9vKQ0KPiANCj4gPiBPcGVuIHRv
IG90aGVyIHN1Z2dlc3Rpb25zIGlmIHN0aWxsIG5vdCBjbGVhci4NCj4gDQo+IEp1c3QgYXMgYSB0
aG91Z2h0LCBaaXBGaWxlKCkgY2FuIHRha2UgYSBmaWxlLWxpa2Ugb2JqZWN0IGluc3RlYWQgb2Yg
YSBmaWxlDQo+IG5hbWUsDQo+IHNvIGNhbiBiZSBwYXNzZWQgdGhlIE5hbWVkVGVtcG9yYXJ5Rmls
ZSgpIG9iamVjdCBkaXJlY3RseSBpbnN0ZWFkIG9mIGl0cw0KPiBmaWxlIG5hbWUuDQo+IFRoaXMg
c2hvdWxkIGhvcGVmdWxseSBhdm9pZCBkb3VibGUtb3BlbiBpc3N1ZSBvbiBXaW5kb3dzLg0KDQpB
bm90aGVyIGV4Y2VsbGVudCBpZGVhIHRoYXQgbWluaW1pemVzIGNoYW5nZXMuICBJIGFtIHRlc3Rp
bmcgdGhpcyBhcHByb2FjaA0Kbm93IGFuZCB3aWxsIHN1Ym1pdCB2MyBvZiB0aGUgcGF0Y2ggc29v
bi4NCj4gDQo+IEhvd2V2ZXIsIEknbSBnb29kIHdpdGggeW91ciBhbGxvY2F0ZVRlbXBGaWxlTmFt
ZSgpIGNoYW5nZXNldCwNCj4gc28gaXQncyB1cCB0byB5b3UgdG8gZ2l2ZSBpdCBhIHRyeSBvciBu
b3QuDQo+IA0KPiA+IFRoYW5rcyBhZ2FpbiwNCj4gPiBQaGlsaXANCj4gDQo+IFRoYW5rIHlvdSwN
Cj4gQW5kcmV5Lg0KDQpUaGFua3MsDQpQaGlsaXANCg==
