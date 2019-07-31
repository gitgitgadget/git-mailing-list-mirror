Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EB891F731
	for <e@80x24.org>; Wed, 31 Jul 2019 21:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfGaVv1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 17:51:27 -0400
Received: from mail-eopbgr810045.outbound.protection.outlook.com ([40.107.81.45]:53033
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727987AbfGaVv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 17:51:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejVR1uAhOaxD/zQA27LLRWrfDwtRiqof273LfiCzsyzJtGFruyok7slsKAUGwR8hOq+Is14asZz6i1ay+RJ1dkTk9/bKpzSQnf/GAeOjCCvPvzUVAigeu/1mYFCYnn+ovUOF0peMx9IdPdsdFV0moHqm86eH6dXajCjODPfzxeOvC8f4C0N6HrLyR7xpTtmsGnBwXwEXm2MXwnia7DtidTuyav7zCNX/VUVuMbKanXAklyrUFR7r5gqrlGwCWvaDyzwAuVgdKY+KCmNMUnjyoxrTxyEs3ocOhcGbyLEyPfAIF7ONRT9SJQtrTJ6p/rRS2jYE1EE6g0X5pnpmIWMPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwA85WRcsap8zEHWTOdtHkfVFukrSQTv3L7lKvRHw2M=;
 b=RoHxL3VHAU44bsEgecSKtbdJbxhwBEqRPq6/1guPjLUoIu6bCsgd2Wa4o09/dqfrv0h/fIne/zJMo0CNJmCgHLiWo5cR/MM92I507y5G64L/BPD72zvIGFIM2UzJHddKnuHQQuGyx26p5sZPIBXyLsmy/A73kY5zNJjTSPd/4xHAi1TrXIeoP8+GA8GkUJ3BooFC6FN5lkrebFMNHfgKapjrKBcE9CmD+FZ90v5qkA10PgpHzmysOZzLg27Pu5mcmBlmhTbZ0BvGWaYTNHEqkd5t32omW0SbfQkNwTze21sLCcFiNxxt943RGFpiZWHgHEzUS9o9SY5HgtdRqydanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bentley.com;dmarc=pass action=none
 header.from=bentley.com;dkim=pass header.d=bentley.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bentley.onmicrosoft.com; s=selector2-bentley-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwA85WRcsap8zEHWTOdtHkfVFukrSQTv3L7lKvRHw2M=;
 b=NE4nZZFYZo30G5loBpPzLYj4yeFHU5TJryDKJKRlUCSxndKDzShYvZS56FFzBpBxsoJruA+eqbHjkJHsBeS5eCyg2zFsWiBTOz6g9uEFLi9KsV8pbVftmXAKrJ466SEPQiDUbbXicmqFQsCA4ss72RuIH7RbGXJV74Yp4BPpTvg=
Received: from BL0PR1901MB2097.namprd19.prod.outlook.com (52.132.22.19) by
 BL0PR1901MB2129.namprd19.prod.outlook.com (52.132.23.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Wed, 31 Jul 2019 21:51:22 +0000
Received: from BL0PR1901MB2097.namprd19.prod.outlook.com
 ([fe80::2d4f:f059:cf4f:8f7b]) by BL0PR1901MB2097.namprd19.prod.outlook.com
 ([fe80::2d4f:f059:cf4f:8f7b%4]) with mapi id 15.20.2094.017; Wed, 31 Jul 2019
 21:51:22 +0000
From:   Philip McGraw <Philip.McGraw@bentley.com>
To:     "ahippo@yandex.ru" <ahippo@yandex.ru>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "luke@diamand.org" <luke@diamand.org>
Subject: RE: [PATCH] git-p4: close temporary file before removing
Thread-Topic: [PATCH] git-p4: close temporary file before removing
Thread-Index: AdVG9CjdiOqwVlefRbaG5Wv1p1dyogATdS2AABidORAAAUXFAAAPDdMA
Date:   Wed, 31 Jul 2019 21:51:22 +0000
Message-ID: <BL0PR1901MB209790A0A8F5F9C8EFB8B3F0FFDF0@BL0PR1901MB2097.namprd19.prod.outlook.com>
References: <BL0PR1901MB209738ADDF9D931253E8C317FFDC0@BL0PR1901MB2097.namprd19.prod.outlook.com>
         <1955471564537683@vla1-53bffb0b04ed.qloud-c.yandex.net>
 <BL0PR1901MB2097EA8851C2743D46210D38FFDF0@BL0PR1901MB2097.namprd19.prod.outlook.com>
 <2835251564582156@myt6-4218ece6190d.qloud-c.yandex.net>
In-Reply-To: <2835251564582156@myt6-4218ece6190d.qloud-c.yandex.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Philip.McGraw@bentley.com; 
x-originating-ip: [64.90.224.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 166f54a5-f427-4fb3-2ed0-08d716013a8f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR1901MB2129;
x-ms-traffictypediagnostic: BL0PR1901MB2129:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR1901MB2129DA19F12B38CB81E5B5CCFFDF0@BL0PR1901MB2129.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(74316002)(81166006)(446003)(1361003)(53936002)(11346002)(8676002)(1730700003)(81156014)(476003)(305945005)(76176011)(26005)(6916009)(7736002)(66066001)(99286004)(76116006)(66946007)(5640700003)(2501003)(102836004)(478600001)(6506007)(7696005)(6436002)(54906003)(14454004)(8936002)(2906002)(316002)(66556008)(66446008)(14444005)(4326008)(55016002)(68736007)(64756008)(9686003)(6306002)(256004)(52536014)(186003)(25786009)(86362001)(33656002)(6116002)(3846002)(66476007)(229853002)(2351001)(486006)(71200400001)(71190400001)(6246003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2129;H:BL0PR1901MB2097.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bentley.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nCzRsJZkhWLTG8VdrFNZJ3HILU5Xq5kUkApTsRfv9KCBznZJfu6TlSebgNqLsFL1zNj1zOxKjH5KP/4EfcDYFHjih/Cje/WTa5Dnmcl5N1lcp/0joyhlQwG9UjkQqmtSlIaDBUPp0UXD3KUndfMy2vB36GnbjlQCLnzrHKWaTm9ccPO7hZsNI0zXWzMxojyuFhR7AzUi7fdcZ6zFg6Dg8UOaTnzvbdblbAdYdIlREZ2mldXI3UgJjNfJaPr9G5Qk/YDgPVmAViegg+lzXPRE5hdwBgGGAlvKw3Fb+p6cmVhBYYX/Wufx4n3itWbqoZYBWR6+S4rAS2kd4Y/rWjjwUZGcdcEQSdN24cmNgDEjZOBSZt2D0MaNUVv8OVs6lR5I23sKGLRmUSdqTxj89O9O2N9onLRTq7zON2r8Ucr6Fvk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bentley.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166f54a5-f427-4fb3-2ed0-08d716013a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 21:51:22.7706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 067e9632-ea4c-4ed9-9e6d-e294956e284b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Philip.McGraw@bentley.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2129
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MjAxOS4wNy4zMSAxMDowOSBBbmRyZXkgPGFoaXBwb0B5YW5kZXgucnU+IA0KPjMxLjA3LjIwMTks
IDA5OjUzLCAiUGhpbGlwIE1jR3JhdyIgPHBoaWxpcC5tY2dyYXdAYmVudGxleS5jb20+Og0KPj4+
IMKgMzAuMDcuMjAxOSwgMTM6MzcsICJQaGlsaXAgTWNHcmF3IiA8cGhpbGlwLm1jZ3Jhd0BiZW50
bGV5LmNvbT46DQo+Pj4gwqA+IHB5dGhvbiBvcy5yZW1vdmUoKSB0aHJvd3MgZXhjZXB0aW9ucyBv
biBXaW5kb3dzIHBsYXRmb3JtIHdoZW4gYXR0ZW1wdGluZw0KPj4+IMKgPiB0byByZW1vdmUgZmls
ZSB3aGlsZSBpdCBpcyBzdGlsbCBvcGVuLiBOZWVkIHRvIGdyYWIgZmlsZW5hbWUgd2hpbGUgZmls
ZSBvcGVuLA0KPj4+IMKgPiBjbG9zZSBmaWxlIGhhbmRsZSwgdGhlbiByZW1vdmUgYnkgbmFtZS4g
QXBwYXJlbnRseSBvdGhlciBwbGF0Zm9ybXMgYXJlIG1vcmUNCj4+PiDCoD4gcGVybWlzc2l2ZSBv
ZiByZW1vdmluZyBmaWxlcyB3aGlsZSBidXN5Lg0KPj4+IMKgPiByZWZlcmVuY2U6IA0KPj4+IMKg
PiAtLS0NCj4+PiDCoD4gwqBnaXQtcDQucHkgfCA0ICsrKy0NCj4+PiDCoD4gwqAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4gwqA+DQo+Pj4gwqA+IGRp
ZmYgLS1naXQgYS9naXQtcDQucHkgYi9naXQtcDQucHkNCj4+PiDCoD4gaW5kZXggYzcxYTY4MzJl
Mi4uNmI5ZDJhODMxNyAxMDA3NTUNCj4+PiDCoD4gLS0tIGEvZ2l0LXA0LnB5DQo+Pj4gwqA+ICsr
KyBiL2dpdC1wNC5weQ0KPj4+IMKgPiBAQCAtMTE2MSwxMiArMTE2MSwxNCBAQCBkZWYgZXhjZWVk
c0xhcmdlRmlsZVRocmVzaG9sZChzZWxmLCByZWxQYXRoLCBjb250ZW50cyk6DQo+Pj4gwqA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gRmFsc2UNCj4+PiDCoD4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb250ZW50VGVtcEZpbGUgPSBzZWxmLmdlbmVyYXRlVGVt
cEZpbGUoY29udGVudHMpDQo+Pj4gwqA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcHJl
c3NlZENvbnRlbnRGaWxlID0gdGVtcGZpbGUuTmFtZWRUZW1wb3JhcnlGaWxlKHByZWZpeD0nZ2l0
LXA0LWxhcmdlLWZpbGUnLCBkZWxldGU9RmFsc2UpDQo+Pj4gwqA+ICsgY29tcHJlc3NlZENvbnRl
bnRGaWxlTmFtZSA9IGNvbXByZXNzZWRDb250ZW50RmlsZS5uYW1lDQo+Pj4gwqA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgemYgPSB6aXBmaWxlLlppcEZpbGUoY29tcHJlc3NlZENvbnRlbnRG
aWxlLm5hbWUsIG1vZGU9J3cnKQ0KPj4+IMKgPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHpm
LndyaXRlKGNvbnRlbnRUZW1wRmlsZSwgY29tcHJlc3NfdHlwZT16aXBmaWxlLlpJUF9ERUZMQVRF
RCkNCj4+PiDCoD4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB6Zi5jbG9zZSgpDQo+Pj4gwqA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcHJlc3NlZENvbnRlbnRzU2l6ZSA9IHpmLmlu
Zm9saXN0KClbMF0uY29tcHJlc3Nfc2l6ZQ0KPj4+IMKgPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoG9zLnJlbW92ZShjb250ZW50VGVtcEZpbGUpDQo+Pj4gwqA+IC0gb3MucmVtb3ZlKGNvbXBy
ZXNzZWRDb250ZW50RmlsZS5uYW1lKQ0KPj4+IMKgPiArIGNvbXByZXNzZWRDb250ZW50RmlsZS5j
bG9zZSgpDQo+Pj4gwqA+ICsgb3MucmVtb3ZlKGNvbXByZXNzZWRDb250ZW50RmlsZU5hbWUpDQo+
Pj4NCj4+PiDCoEknbSBub3Qgc3VyZSB3aHkgTmFtZWRUZW1wb3JhcnlGaWxlKCkgaXMgY2FsbGVk
IHdpdGggZGVsZXRlPUZhbHNlIGFib3ZlLA0KPj4+IMKgYnV0IGl0IGFwcGVhcnMgdG8gbWUgdGhh
dCBpdCBjYW4gaGF2ZSBkZWxldGU9VHJ1ZSBpbnN0ZWFkLA0KPj4+IMKgc28gdGhhdCB0aGVyZSBp
cyBubyBuZWVkIHRvIGNhbGwgb3MucmVtb3ZlKCkgZXhwbGljaXRseQ0KPj4+IMKgYW5kIHRodXMg
d29ycnkgYWJvdXQgcmVtb3ZlIHZzIGNsb3NlIG9yZGVyaW5nIGF0IGFsbC4NCj4+Pg0KPj4+IMKg
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIGNvbXByZXNzZWRDb250ZW50c1NpemUgPiBn
aXRDb25maWdJbnQoJ2dpdC1wNC5sYXJnZUZpbGVDb21wcmVzc2VkVGhyZXNob2xkJyk6DQo+Pj4g
wqA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gVHJ1ZQ0KPj4+IMKg
PiDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gRmFsc2UNCj4+PiDCoD4gLS0NCj4+PiDCoD4gMi4y
MS4wLndpbmRvd3MuMQ0KPj4+DQo+Pj4gwqBUaGFuayB5b3UsDQo+Pj4gwqBBbmRyZXkuDQo+Pg0K
Pj4gVGhhbmtzIEFuZHJleTsgc2ltcGxlciBpcyBjZXJ0YWlubHkgYmV0dGVyISBJIHdpbGwgdGVz
dCBhbmQgcmUtc3VibWl0IHYyIG9mIHBhdGNoIHdpdGggdGhhdCBhcHByb2FjaC4NCj4NCj5UaGFu
ayB5b3UsIHRoYXQgd291bGQgYmUgZ3JlYXQhDQo+DQo+LS0gDQo+QW5kcmV5Lg0KDQpVbmZvcnR1
bmF0ZWx5IGl0IHdhc24ndCBhcyBzaW1wbGUgaXQgc2VlbWVkOiB1cG9uIHRlc3Rpbmcgd2l0aCBv
bmx5IGNoYW5naW5nIGRlbGV0ZT1UcnVlLCANCmZvdW5kIHRoYXQgdGhlIHByb2JsZW0gd2FzIG5v
dCBzb2x2ZWQuICBVcG9uIGZ1cnRoZXIgZGVidWdnaW5nLCByZWNvZGVkL3JlZmFjdG9yZWQgc2xp
Z2h0bHkgYWRkaW5nIA0KYWxsb2NhdGVUZW1wRmlsZU5hbWUoKSBsb2NhbGx5IHNjb3BlZCBmdW5j
dGlvbiB0byB0cnkgdG8gY2xhcmlmeSBob3cgdGhlIE5hbWVkVGVtcG9yYXJ5RmlsZSgpDQp3YXMg
YWN0dWFsbHkgYmVpbmcgdXNlZC4NCg0KV2UgY2FuJ3QgZGVwZW5kIG9uIHRoZSBkZWxldGUtb24t
Y2xvc2UgYmVjYXVzZSB0aGUgTmFtZWRUZW1wb3JhcnlGaWxlKCkgaXMgbWVyZWx5IGFsbG9jYXRp
bmcgDQphIHRlbXBvcmFyeSBuYW1lIGZvciByZWFsIHVzZSBieSB0aGUgemlwZmlsZSBvcGVuLWZv
ci13cml0ZSB3aGljaCBmYWlscyAob24gV2luZG93cykgaWYgZmlsZQ0Kd2FzIG5vdCBleHBsaWNp
dGx5IGNsb3NlZCBmaXJzdC4gIA0KDQpIb3BlZnVsbHkgdGhlIG5ldyBwYXRjaCAoaHR0cHM6Ly9n
aXRodWIuY29tL2dpdGdpdGdhZGdldC9naXQvcHVsbC8zMDEpIHdpbGwgbWFrZSB0aGlzIG1vcmUg
Y2xlYXIuDQoNCk9wZW4gdG8gb3RoZXIgc3VnZ2VzdGlvbnMgaWYgc3RpbGwgbm90IGNsZWFyLg0K
DQpUaGFua3MgYWdhaW4sDQpQaGlsaXANCg0K
