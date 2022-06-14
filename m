Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5775EC433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 19:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbiFNTWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiFNTWC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 15:22:02 -0400
X-Greylist: delayed 603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 12:22:00 PDT
Received: from mx-out2.deshaw.net (mx-out2.deshaw.net [149.77.95.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D0C29C86
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 12:22:00 -0700 (PDT)
Received: from mx-relay2.deshaw.net (localhost [127.0.0.1])
        by mx-out2.deshaw.net (Postfix) with ESMTPS id A4DBF80CB3A;
        Tue, 14 Jun 2022 15:11:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deshaw.com; s=k001;
        t=1655233916; bh=k3AZ6l2xzY5xH7+SUL8MUE4YhxQ/kdyg53Fv1oHL9jE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lI51xhoZUCvKUzVmnE9grBReuSvo09F9BEjpwJ9y3fqgvUvA1WubSxa8QIk9Pyi9G
         Mxb5w6HlzZcPn3UJUbp2eapiI2vbM04SeUNRi9sug0S9qidzpOddSbH5MXU10dLmLL
         KhFDnOHJtCPIyderQzUVREcwOlqcBDvGNlapBUpI=
Received: from deshaw.com (mail-multi.nyc.deshaw.com [10.219.243.66])
        by mx-relay2.deshaw.net (Postfix) with ESMTPS id 9F8DE1408400;
        Tue, 14 Jun 2022 15:11:56 -0400 (EDT)
Received: from exchmbxtoa1b.deshaw.com (exchmbxtoa1b.deshaw.com [10.219.74.15])
        by mail-multi.nyc.deshaw.com (Postfix) with ESMTPS id 97A9A177;
        Tue, 14 Jun 2022 15:11:56 -0400 (EDT)
Received: from exchmbxtoa1b.deshaw.com (10.219.74.15) by
 exchmbxtoa1b.deshaw.com (10.219.74.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 15:11:56 -0400
Received: from exchmbxtoa1b.deshaw.com ([fe80::b55e:2430:4455:ec8c]) by
 exchmbxtoa1b.deshaw.com ([fe80::b55e:2430:4455:ec8c%8]) with mapi id
 15.01.2308.027; Tue, 14 Jun 2022 15:11:56 -0400
From:   "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>
To:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
CC:     "Udoff, Marc" <Marc.Udoff@deshaw.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git filter bug
Thread-Topic: git filter bug
Thread-Index: Adh9GBnXLc9Gl6ZqSU6yhtlNhZ2wRwAcFQIAAJqMoXIAAMa8sA==
Date:   Tue, 14 Jun 2022 19:11:56 +0000
Message-ID: <d8ae6210ddf146d7bbd9c78d170fb803@deshaw.com>
References: <101027c97a9b40ce97192b1cee203b07@deshaw.com>
 <442e3166-4f18-3ee0-e3bc-d24687471d5c@kdbg.org> <xmqqsfo879r7.fsf@gitster.g>
 <c2f49b4f-8588-bae1-97cf-91a36b3f16f9@kdbg.org>
In-Reply-To: <c2f49b4f-8588-bae1-97cf-91a36b3f16f9@kdbg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.219.66.97]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Content-Scanned: Fidelis Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVyZSdzIHRoZSBiZWhhdmlvciB0aGF0IEkgb2JzZXJ2ZToNCi0gSWYgdGhlIG10aW1lIG9mIHRo
ZSBub3JtYWwgZmlsZSBjaGFuZ2VzIGZyb20gd2hhdCdzIGluIHRoZSBpbmRleCBidXQgdGhlIGNv
bnRlbnQgZG9lc24ndCBjaGFuZ2UsICJnaXQgc3RhdHVzIiB1cGRhdGVzIHRoZSBpbmRleCB3aXRo
IHRoZSBsYXRlc3QgdGltZXN0YW1wIG9mIHRoZSBmaWxlLg0KLSBJZiB0aGUgZmlsdGVyZWQgZmls
ZSBjaGFuZ2VzLCBidXQgdGhlIHNpemUgc3RheXMgdGhlIHNhbWUsIGdpdCBzdGF0dXMgYWxzbyB0
cmlnZ2VycyBhbiBpbmRleCB1cGRhdGUuDQotIEJVVCBpZiB0aGUgc2l6ZSBvZiB0aGUgZmlsdGVy
ZWQgZmlsZSBjaGFuZ2VzLCB0aGVuIHRoZSBpbmRleCBkb2VzIE5PVCBnZXQgdXBkYXRlZCBhbmQg
dGhlIGZpbGUgYXBwZWFycyBtb2RpZmllZCBvbiBldmVyeSBnaXQgc3RhdHVzIHJ1biB1bnRpbCB5
b3UgZXhwbGljaXRseSBydW4gImdpdCBhZGQgPGZpbGVuYW1lPiIgYWdhaW4uIFRoaXMgaXMgdHJ1
ZSBldmVuIGlmIHRoZSBwb3N0LWNsZWFuIGZpbHRlciBjb250ZW50IGlzIHRoZSBzYW1lIGFzIHdo
YXQncyBjdXJyZW50bHkgaW4gdGhlIGluZGV4Lg0KLSBUaGUgY2xlYW4gZmlsdGVyIHJ1bnMgb24g
ZXZlcnkgImdpdCBzdGF0dXMiIGNhbGwgYW55d2F5LCBzbyB0aGlzIGJlaGF2aW9yIGRvZXMgbm90
IGFwcGVhciB0byBiZSBhbiBvcHRpbWl6YXRpb24uDQoNClNvIGlmIGEgZmlsZSBpcyBtb2RpZmll
ZCBzdWNoIHRoYXQgdGhlIHBvc3QtY2xlYW4gZmlsdGVyIGNvbnRlbnQgaXMgdGhlIHNhbWUgYXMg
d2hhdCdzIGluIHRoZSBpbmRleCwgImdpdCBzdGF0dXMiIHdpbGwgc2hvdyB0aGUgZmlsZSBhcyBt
b2RpZmllZCBvbmx5IGlmIHRoZSBmaWxlIHNpemUgaGFzIGFsc28gY2hhbmdlZC4gSXQgc2VlbXMg
dGhhdCBwZXJoYXBzICJnaXQgc3RhdHVzIiBpcyBjb21wYXJpbmcgZmlsZSBzaXplcyBiZWZvcmUg
YXBwbHlpbmcgdGhlIGNsZWFuIGZpbHRlciB0byBzZWUgaWYgdGhlIGluZGV4IGVudHJ5IG5lZWRz
IHRvIGJlIHJlZnJlc2hlZD8gDQoNClZpdGFseQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogSm9oYW5uZXMgU2l4dCA8ajZ0QGtkYmcub3JnPiANClNlbnQ6IE1vbmRheSwgSnVu
ZSAxMywgMjAyMiA1OjE1IFBNDQpUbzogSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29t
Pg0KQ2M6IFVkb2ZmLCBNYXJjIDxNYXJjLlVkb2ZmQGRlc2hhdy5jb20+OyBTaHVwYWssIFZpdGFs
eSA8Vml0YWx5LlNodXBha0BkZXNoYXcuY29tPjsgZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVj
dDogUmU6IGdpdCBmaWx0ZXIgYnVnDQoNClRoaXMgbWVzc2FnZSB3YXMgc2VudCBieSBhbiBleHRl
cm5hbCBwYXJ0eS4NCg0KDQpBbSAxMy4wNi4yMiB1bSAxOToyOSBzY2hyaWViIEp1bmlvIEMgSGFt
YW5vOg0KPiBKb2hhbm5lcyBTaXh0IDxqNnRAa2RiZy5vcmc+IHdyaXRlczoNCj4NCj4+IGdpdCBz
dGF0dXMgZG9lcyBub3QgY29tcHV0ZSBkaWZmZXJlbmNlczsgaXQgb25seSBsb29rcyBhdCB0aGUg
c3RhdCANCj4+IGluZm9ybWF0aW9uLCBhbmQgdGhhdCBpcyBieSBkZXNpZ24gZm9yIHBlcmZvcm1h
bmNlIHJlYXNvbnMuIFNvLCBJTU8sIA0KPj4gdGhpcyBpcyB3b3JraW5nIGFzIGRlc2lnbmVkIGFu
ZCBub3QgYSBidWcuDQo+DQo+IEhtcGgsIGlzIHRoYXQgdHJ1ZT8gIEkgdGhvdWdodCAiZ2l0IHN0
YXR1cyIgZGlkIGFuIGVxdWl2YWxlbnQgb2YgDQo+IGRpZmYuYXV0b1JlZnJlc2hJbmRleCBqdXN0
IGxpa2Ugb3RoZXIgY29tbWFuZHMgbGlrZSAiZ2l0IGRpZmYiIGF0IHRoZSANCj4gUG9yY2VsYWlu
IGxldmVsLg0KDQpJcyBpdCB0cnVlPyBJIGRvbid0IGtub3c7IHlvdSB0ZWxsIG1lIDspIGdpdCBz
dGF0dXMgY2VydGFpbmx5IGRvZXMgYXV0b1JlZnJlc2hJbmRleCwgYnV0IGlzIHRoYXQgYmFzZWQg
b24gYSBkaWZmIGNvbXB1dGF0aW9uPyBJIHRob3VnaHQgZ2l0IHN0YXR1cyBsb29rcyBvbmx5IGF0
IHN0YXQgaW5mb3JtYXRpb24uDQoNCj4gSXMgdGhpcyBtb3JlIGxpa2UgdGhlIGNvbW1vbmx5IHNl
ZW4gImFmdGVyIHlvdSBmdXR6ZWQgdGhlIGF0dHJpYnV0ZXMgDQo+IHRvIGFmZmVjdCBub3JtYWxp
emF0aW9uLCAiLS1yZW5vcm1hbGl6ZSIgaXMgbmVlZGVkIHRvIGZvcmNlIHRoZSBpbmRleCANCj4g
dG8gbWF0Y2ggdGhlIGNsZWFuZWQgdmVyc2lvbiBvZiB3b3JraW5nIHRyZWUgdW5kZXIgdGhlIG5l
dyBjbGVhbiANCj4gZmlsdGVyIHJ1bGVzIiwgSSB3b25kZXI/DQoNCk5vdCBpbiB0aGlzIGNhc2Uu
IFRoZSBtb2RpZmllZCBmaWxlIHRoYXQgZ2l0IHN0YXR1cyByZXBvcnRzIGhhcHBlbnMgbG9uZyBh
ZnRlciBnaXQgY29tbWl0IC1hIGhhcyBhbHJlYWR5IGFwcGxpZWQgdGhlIG5ldyBmaWx0ZXIuDQoN
Ci0tIEhhbm5lcw0K
