Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B51211F731
	for <e@80x24.org>; Wed, 31 Jul 2019 13:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfGaNxi (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 09:53:38 -0400
Received: from mail-eopbgr700089.outbound.protection.outlook.com ([40.107.70.89]:21249
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726592AbfGaNxi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 09:53:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcBezojF+xUt1++JkmCKCC5jMzYuNmZf6izCkrA171xhK1l1gFKcoJ7fodiZdx5VenZoYFdLV56qNzW8gV38ncfVZteyM9swIqJvVZj+9p0jQcG7w35GpGfpKfj17U+8hzbMaSB0JHb5c7P89iqilQ/8/ZRa0mpjNh3fzcskknlXF8b5JCd76836+gEhEqg/+Oa8F2jU5KLxPunDwDll6A6C4A72CWyw/yhsNSxp32ShKee9Hd4Lb4War4cAg1oNOhG12Ng9TH4W2osCOQcMiRMRceo54PHdaKRsDND4I/7PWulzCM3dhxhPJ7WS5oxQdKrRH0Rtm29Pah+esjYcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGhFOPeajzG8ATtpeX2nB2OyQVCQBNbI2dSDXlu2Tyo=;
 b=J+FjT5FBwia7dgcLtAOmP3IhqOHT3TUS7H4dpomjOm+ezro4W+iI0gLWOR/hidEt7Jo+2mEL35GibJ7WTYEAaVt6FEx8TaioyWjpK2t51JGQsE2DXTgSz2OhBl1KDMUuj4/E1dEvFFYn+60mTFZJNWYLQP0yewppY9tUyh1flRqcCtEKhCRE4QH/c+OjsUu5ET40mwj7y58dZJ7PoplmocMn9ZfPuvWM5YRdvb8yDP+oVezI7Q8kJLPwwwaZ3RST5F9o8Kem+GAi4re8Vf+ptU6sxDWGB+2Il6cbYDecD1oxl0jEFYsg6zyqyhJoF5d9/QglgF1uA7O2FSWgSpZLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bentley.com;dmarc=pass action=none
 header.from=bentley.com;dkim=pass header.d=bentley.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bentley.onmicrosoft.com; s=selector2-bentley-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGhFOPeajzG8ATtpeX2nB2OyQVCQBNbI2dSDXlu2Tyo=;
 b=kj5NuNt1wE0DgYgkxmroa/Ya9wuVEQheu5+9uhakSqCqj4CXRUgKcXMXFZ14Fq7JvfdfnO1naQdfsH4dAauThqMnaGwtg6+P41FDlJ6KfPcBHKUwyqWzFhoFMNPXKcJ+GpIAL+GgAo28JPGwQFWXysOTS/rLTqaKP9Ijmwm0lPo=
Received: from BL0PR1901MB2097.namprd19.prod.outlook.com (52.132.22.19) by
 BL0PR1901MB2212.namprd19.prod.outlook.com (52.132.19.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 13:53:35 +0000
Received: from BL0PR1901MB2097.namprd19.prod.outlook.com
 ([fe80::2d4f:f059:cf4f:8f7b]) by BL0PR1901MB2097.namprd19.prod.outlook.com
 ([fe80::2d4f:f059:cf4f:8f7b%4]) with mapi id 15.20.2094.017; Wed, 31 Jul 2019
 13:53:35 +0000
From:   Philip McGraw <Philip.McGraw@bentley.com>
To:     "ahippo@yandex.ru" <ahippo@yandex.ru>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "luke@diamand.org" <luke@diamand.org>
Subject: RE: [PATCH] git-p4: close temporary file before removing
Thread-Topic: [PATCH] git-p4: close temporary file before removing
Thread-Index: AdVG9CjdiOqwVlefRbaG5Wv1p1dyogATdS2AABidORA=
Date:   Wed, 31 Jul 2019 13:53:35 +0000
Message-ID: <BL0PR1901MB2097EA8851C2743D46210D38FFDF0@BL0PR1901MB2097.namprd19.prod.outlook.com>
References: <BL0PR1901MB209738ADDF9D931253E8C317FFDC0@BL0PR1901MB2097.namprd19.prod.outlook.com>
 <1955471564537683@vla1-53bffb0b04ed.qloud-c.yandex.net>
In-Reply-To: <1955471564537683@vla1-53bffb0b04ed.qloud-c.yandex.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Philip.McGraw@bentley.com; 
x-originating-ip: [64.90.224.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 570f4c75-6b97-4342-190a-08d715be7b7e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR1901MB2212;
x-ms-traffictypediagnostic: BL0PR1901MB2212:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR1901MB22120ACA47B63EE651806A42FFDF0@BL0PR1901MB2212.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(199004)(189003)(186003)(74316002)(71190400001)(5640700003)(71200400001)(476003)(8676002)(1730700003)(2351001)(81166006)(81156014)(55016002)(11346002)(7696005)(6506007)(54906003)(446003)(14444005)(76176011)(6916009)(229853002)(256004)(86362001)(99286004)(26005)(486006)(68736007)(6436002)(316002)(8936002)(305945005)(7736002)(1361003)(102836004)(6246003)(9686003)(53936002)(66946007)(33656002)(66476007)(76116006)(6306002)(66556008)(64756008)(66446008)(5660300002)(52536014)(14454004)(966005)(2501003)(66066001)(3846002)(25786009)(4326008)(2906002)(6116002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2212;H:BL0PR1901MB2097.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bentley.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qQ3r9grICFJ9sekH9QpNv1Jq6tdP75F88jDEvjggCcFwIOG4A18J31iDwnH5969U5ezbium4h7YlBJL/G65EQFiaYwKEzSzksC02PtlbSCc2D4wHcG22w4PMbd+RHxK5XDoTQyIC8FdeUU3Rdt9bApYpaOjZL/gEBL+29nly0Htn2j/TSXL0efzgzG+DYZiAB8WHWyZ1z/NZ0jYw2Z6kV67l3mF5tx9cAx9VPM759p54p0rUXGEQQ8TVeWre73oxpirCT5n5tacCbMpAyrhl5SXKnWMtBtpSfZkGBk+ZpOsdBI6u6XTwoZ/RfoTn1MLM/ap7GqRYSLKG0WMvwTJY8qmrWsK3pDdQU+3vP1m2FxWE7jSOjZtq18i5JTsqh68T53ty4XoHcpecVgf6K/+0PjxY6NGsVqSBad/y3w/Zluk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bentley.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570f4c75-6b97-4342-190a-08d715be7b7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 13:53:35.4726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 067e9632-ea4c-4ed9-9e6d-e294956e284b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Philip.McGraw@bentley.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2212
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAzMC4wNy4yMDE5LCAxMzozNywgIlBoaWxpcCBNY0dyYXciIDxwaGlsaXAubWNncmF3QGJlbnRs
ZXkuY29tPjoNCj4gPiBweXRob24gb3MucmVtb3ZlKCkgdGhyb3dzIGV4Y2VwdGlvbnMgb24gV2lu
ZG93cyBwbGF0Zm9ybSB3aGVuIGF0dGVtcHRpbmcNCj4gPiB0byByZW1vdmUgZmlsZSB3aGlsZSBp
dCBpcyBzdGlsbCBvcGVuLiBOZWVkIHRvIGdyYWIgZmlsZW5hbWUgd2hpbGUgZmlsZSBvcGVuLA0K
PiA+IGNsb3NlIGZpbGUgaGFuZGxlLCB0aGVuIHJlbW92ZSBieSBuYW1lLiBBcHBhcmVudGx5IG90
aGVyIHBsYXRmb3JtcyBhcmUgbW9yZQ0KPiA+IHBlcm1pc3NpdmUgb2YgcmVtb3ZpbmcgZmlsZXMg
d2hpbGUgYnVzeS4NCj4gPiByZWZlcmVuY2U6IGh0dHBzOi8vZG9jcy5weXRob24ub3JnLzMvbGli
cmFyeS9vcy5odG1sI29zLnJlbW92ZQ0KPiA+IC0tLQ0KPiA+IMKgZ2l0LXA0LnB5IHwgNCArKyst
DQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZ2l0LXA0LnB5IGIvZ2l0LXA0LnB5DQo+ID4gaW5kZXggYzcx
YTY4MzJlMi4uNmI5ZDJhODMxNyAxMDA3NTUNCj4gPiAtLS0gYS9naXQtcDQucHkNCj4gPiArKysg
Yi9naXQtcDQucHkNCj4gPiBAQCAtMTE2MSwxMiArMTE2MSwxNCBAQCBkZWYgZXhjZWVkc0xhcmdl
RmlsZVRocmVzaG9sZChzZWxmLCByZWxQYXRoLCBjb250ZW50cyk6DQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBGYWxzZQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgY29udGVudFRlbXBGaWxlID0gc2VsZi5nZW5lcmF0ZVRlbXBGaWxlKGNvbnRlbnRz
KQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcHJlc3NlZENvbnRlbnRGaWxlID0g
dGVtcGZpbGUuTmFtZWRUZW1wb3JhcnlGaWxlKHByZWZpeD0nZ2l0LXA0LWxhcmdlLWZpbGUnLCBk
ZWxldGU9RmFsc2UpDQo+ID4gKyBjb21wcmVzc2VkQ29udGVudEZpbGVOYW1lID0gY29tcHJlc3Nl
ZENvbnRlbnRGaWxlLm5hbWUNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHpmID0gemlw
ZmlsZS5aaXBGaWxlKGNvbXByZXNzZWRDb250ZW50RmlsZS5uYW1lLCBtb2RlPSd3JykNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHpmLndyaXRlKGNvbnRlbnRUZW1wRmlsZSwgY29tcHJl
c3NfdHlwZT16aXBmaWxlLlpJUF9ERUZMQVRFRCkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHpmLmNsb3NlKCkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXByZXNzZWRD
b250ZW50c1NpemUgPSB6Zi5pbmZvbGlzdCgpWzBdLmNvbXByZXNzX3NpemUNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoG9zLnJlbW92ZShjb250ZW50VGVtcEZpbGUpDQo+ID4gLSBvcy5y
ZW1vdmUoY29tcHJlc3NlZENvbnRlbnRGaWxlLm5hbWUpDQo+ID4gKyBjb21wcmVzc2VkQ29udGVu
dEZpbGUuY2xvc2UoKQ0KPiA+ICsgb3MucmVtb3ZlKGNvbXByZXNzZWRDb250ZW50RmlsZU5hbWUp
DQo+IA0KPiBJJ20gbm90IHN1cmUgd2h5IE5hbWVkVGVtcG9yYXJ5RmlsZSgpIGlzIGNhbGxlZCB3
aXRoIGRlbGV0ZT1GYWxzZSBhYm92ZSwNCj4gYnV0IGl0IGFwcGVhcnMgdG8gbWUgdGhhdCBpdCBj
YW4gaGF2ZSBkZWxldGU9VHJ1ZSBpbnN0ZWFkLA0KPiBzbyB0aGF0IHRoZXJlIGlzIG5vIG5lZWQg
dG8gY2FsbCBvcy5yZW1vdmUoKSBleHBsaWNpdGx5DQo+IGFuZCB0aHVzIHdvcnJ5IGFib3V0IHJl
bW92ZSB2cyBjbG9zZSBvcmRlcmluZyBhdCBhbGwuDQo+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaWYgY29tcHJlc3NlZENvbnRlbnRzU2l6ZSA+IGdpdENvbmZpZ0ludCgnZ2l0LXA0
LmxhcmdlRmlsZUNvbXByZXNzZWRUaHJlc2hvbGQnKToNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIFRydWUNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
RmFsc2UNCj4gPiAtLQ0KPiA+IDIuMjEuMC53aW5kb3dzLjENCj4gDQo+IFRoYW5rIHlvdSwNCj4g
QW5kcmV5Lg0KDQpUaGFua3MgQW5kcmV5OyBzaW1wbGVyIGlzIGNlcnRhaW5seSBiZXR0ZXIhICBJ
IHdpbGwgdGVzdCBhbmQgcmUtc3VibWl0IHYyIG9mIHBhdGNoIHdpdGggdGhhdCBhcHByb2FjaC4N
Cg0K
