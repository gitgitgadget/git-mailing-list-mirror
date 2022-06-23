Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C873C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 12:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiFWMNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 08:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiFWMNq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 08:13:46 -0400
Received: from mx-out1.deshaw.net (mx-out1.deshaw.net [149.77.95.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A121A5
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 05:13:43 -0700 (PDT)
Received: from mx-relay1.deshaw.net (localhost [127.0.0.1])
        by mx-out1.deshaw.net (Postfix) with ESMTPS id 0108DC1B1AA;
        Thu, 23 Jun 2022 08:13:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deshaw.com; s=k001;
        t=1655986422; bh=BXj4+hg+TkdC0KTh5EeIWXL2450VOHuen+xwLf0gST8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=V8XZXSPcu0wcEaZ//9T1SjjRH4geHYRMXmRKt3i5O7Cnmej7nDtuFWdFrV4H0A5Kj
         0MDD7tax7Wi6WTiusgu9027BM5iCe7eQV3Nau0maDnciSfP10FStCfLsSN6JVWdOIq
         hubwZOB6HPlbyuaM8YqmCt2vvgXe+07t3I7/GahY=
Received: from deshaw.com (mail-multi.nyc.deshaw.com [10.219.243.66])
        by mx-relay1.deshaw.net (Postfix) with ESMTPS id ED33C1207319;
        Thu, 23 Jun 2022 08:13:41 -0400 (EDT)
Received: from exchmbxtoa1a.deshaw.com (exchmbxtoa1a.deshaw.com [10.219.74.16])
        by mail-multi.nyc.deshaw.com (Postfix) with ESMTPS id E8B8A459;
        Thu, 23 Jun 2022 08:13:41 -0400 (EDT)
Received: from exchmbxpsc1c.deshaw.com (10.218.74.18) by
 exchmbxtoa1a.deshaw.com (10.219.74.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.6; Thu, 23 Jun 2022 08:13:41 -0400
Received: from exchmbxpsc1c.deshaw.com ([fe80::a151:8073:ccf0:c19e]) by
 exchmbxpsc1c.deshaw.com ([fe80::a151:8073:ccf0:c19e%4]) with mapi id
 15.01.2507.006; Thu, 23 Jun 2022 08:13:41 -0400
From:   "Udoff, Marc" <Marc.Udoff@deshaw.com>
To:     "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git filter bug
Thread-Topic: git filter bug
Thread-Index: Adh9GBnXLc9Gl6ZqSU6yhtlNhZ2wRwAcFQIAAJqMoXIAAMa8sAGm3RCQ
Date:   Thu, 23 Jun 2022 12:13:41 +0000
Message-ID: <1d01a877d86f4e0583e1bc617349b48a@deshaw.com>
References: <101027c97a9b40ce97192b1cee203b07@deshaw.com>
 <442e3166-4f18-3ee0-e3bc-d24687471d5c@kdbg.org> <xmqqsfo879r7.fsf@gitster.g>
 <c2f49b4f-8588-bae1-97cf-91a36b3f16f9@kdbg.org>
 <d8ae6210ddf146d7bbd9c78d170fb803@deshaw.com>
In-Reply-To: <d8ae6210ddf146d7bbd9c78d170fb803@deshaw.com>
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

QmFzZWQgb24gdGhlIGNvbnZlcnNhdGlvbiBiZWxvdywgSSdtIG5vdCBxdWl0ZSBzdXJlIGlmIHRo
ZXJlIGlzIGNvbnNlbnN1cyB0aGlzIGlzIGEgYnVnIGFuZCBub3QgYSBmZWF0dXJlLiBJZiB0aGlz
IGlzIGEgYnVnLCB3aGF0IGFyZSB0aGUgbmV4dCBzdGVwcyB0byBnZXR0aW5nIGl0IGZpeGVkPyBJ
ZiB0aGlzIGlzIHNvbWV0aGluZyB0aGF0IHNvbWVvbmUgd2l0aCBtaW5pbWFsIGNvZGViYXNlIGV4
cGVyaWVuY2UgY2FuIGZpeCwgd2UnZCBiZSBoYXBweSB0byBzdWJtaXQgYSBQUiBpZiB5b3UgY291
bGQgZ2l2ZSB1cyBhIGZldyBwb2ludGVycy4NCg0KVGhhbmtzIQ0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogU2h1cGFrLCBWaXRhbHkgPFZpdGFseS5TaHVwYWtAZGVzaGF3LmNv
bT4gDQpTZW50OiBUdWVzZGF5LCBKdW5lIDE0LCAyMDIyIDM6MTIgUE0NClRvOiBKb2hhbm5lcyBT
aXh0IDxqNnRAa2RiZy5vcmc+OyBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+DQpD
YzogVWRvZmYsIE1hcmMgPE1hcmMuVWRvZmZAZGVzaGF3LmNvbT47IGdpdEB2Z2VyLmtlcm5lbC5v
cmcNClN1YmplY3Q6IFJFOiBnaXQgZmlsdGVyIGJ1Zw0KDQpIZXJlJ3MgdGhlIGJlaGF2aW9yIHRo
YXQgSSBvYnNlcnZlOg0KLSBJZiB0aGUgbXRpbWUgb2YgdGhlIG5vcm1hbCBmaWxlIGNoYW5nZXMg
ZnJvbSB3aGF0J3MgaW4gdGhlIGluZGV4IGJ1dCB0aGUgY29udGVudCBkb2Vzbid0IGNoYW5nZSwg
ImdpdCBzdGF0dXMiIHVwZGF0ZXMgdGhlIGluZGV4IHdpdGggdGhlIGxhdGVzdCB0aW1lc3RhbXAg
b2YgdGhlIGZpbGUuDQotIElmIHRoZSBmaWx0ZXJlZCBmaWxlIGNoYW5nZXMsIGJ1dCB0aGUgc2l6
ZSBzdGF5cyB0aGUgc2FtZSwgZ2l0IHN0YXR1cyBhbHNvIHRyaWdnZXJzIGFuIGluZGV4IHVwZGF0
ZS4NCi0gQlVUIGlmIHRoZSBzaXplIG9mIHRoZSBmaWx0ZXJlZCBmaWxlIGNoYW5nZXMsIHRoZW4g
dGhlIGluZGV4IGRvZXMgTk9UIGdldCB1cGRhdGVkIGFuZCB0aGUgZmlsZSBhcHBlYXJzIG1vZGlm
aWVkIG9uIGV2ZXJ5IGdpdCBzdGF0dXMgcnVuIHVudGlsIHlvdSBleHBsaWNpdGx5IHJ1biAiZ2l0
IGFkZCA8ZmlsZW5hbWU+IiBhZ2Fpbi4gVGhpcyBpcyB0cnVlIGV2ZW4gaWYgdGhlIHBvc3QtY2xl
YW4gZmlsdGVyIGNvbnRlbnQgaXMgdGhlIHNhbWUgYXMgd2hhdCdzIGN1cnJlbnRseSBpbiB0aGUg
aW5kZXguDQotIFRoZSBjbGVhbiBmaWx0ZXIgcnVucyBvbiBldmVyeSAiZ2l0IHN0YXR1cyIgY2Fs
bCBhbnl3YXksIHNvIHRoaXMgYmVoYXZpb3IgZG9lcyBub3QgYXBwZWFyIHRvIGJlIGFuIG9wdGlt
aXphdGlvbi4NCg0KU28gaWYgYSBmaWxlIGlzIG1vZGlmaWVkIHN1Y2ggdGhhdCB0aGUgcG9zdC1j
bGVhbiBmaWx0ZXIgY29udGVudCBpcyB0aGUgc2FtZSBhcyB3aGF0J3MgaW4gdGhlIGluZGV4LCAi
Z2l0IHN0YXR1cyIgd2lsbCBzaG93IHRoZSBmaWxlIGFzIG1vZGlmaWVkIG9ubHkgaWYgdGhlIGZp
bGUgc2l6ZSBoYXMgYWxzbyBjaGFuZ2VkLiBJdCBzZWVtcyB0aGF0IHBlcmhhcHMgImdpdCBzdGF0
dXMiIGlzIGNvbXBhcmluZyBmaWxlIHNpemVzIGJlZm9yZSBhcHBseWluZyB0aGUgY2xlYW4gZmls
dGVyIHRvIHNlZSBpZiB0aGUgaW5kZXggZW50cnkgbmVlZHMgdG8gYmUgcmVmcmVzaGVkPyANCg0K
Vml0YWx5DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKb2hhbm5lcyBTaXh0
IDxqNnRAa2RiZy5vcmc+DQpTZW50OiBNb25kYXksIEp1bmUgMTMsIDIwMjIgNToxNSBQTQ0KVG86
IEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT4NCkNjOiBVZG9mZiwgTWFyYyA8TWFy
Yy5VZG9mZkBkZXNoYXcuY29tPjsgU2h1cGFrLCBWaXRhbHkgPFZpdGFseS5TaHVwYWtAZGVzaGF3
LmNvbT47IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBnaXQgZmlsdGVyIGJ1Zw0K
DQpUaGlzIG1lc3NhZ2Ugd2FzIHNlbnQgYnkgYW4gZXh0ZXJuYWwgcGFydHkuDQoNCg0KQW0gMTMu
MDYuMjIgdW0gMTk6Mjkgc2NocmllYiBKdW5pbyBDIEhhbWFubzoNCj4gSm9oYW5uZXMgU2l4dCA8
ajZ0QGtkYmcub3JnPiB3cml0ZXM6DQo+DQo+PiBnaXQgc3RhdHVzIGRvZXMgbm90IGNvbXB1dGUg
ZGlmZmVyZW5jZXM7IGl0IG9ubHkgbG9va3MgYXQgdGhlIHN0YXQgDQo+PiBpbmZvcm1hdGlvbiwg
YW5kIHRoYXQgaXMgYnkgZGVzaWduIGZvciBwZXJmb3JtYW5jZSByZWFzb25zLiBTbywgSU1PLCAN
Cj4+IHRoaXMgaXMgd29ya2luZyBhcyBkZXNpZ25lZCBhbmQgbm90IGEgYnVnLg0KPg0KPiBIbXBo
LCBpcyB0aGF0IHRydWU/ICBJIHRob3VnaHQgImdpdCBzdGF0dXMiIGRpZCBhbiBlcXVpdmFsZW50
IG9mIA0KPiBkaWZmLmF1dG9SZWZyZXNoSW5kZXgganVzdCBsaWtlIG90aGVyIGNvbW1hbmRzIGxp
a2UgImdpdCBkaWZmIiBhdCB0aGUgDQo+IFBvcmNlbGFpbiBsZXZlbC4NCg0KSXMgaXQgdHJ1ZT8g
SSBkb24ndCBrbm93OyB5b3UgdGVsbCBtZSA7KSBnaXQgc3RhdHVzIGNlcnRhaW5seSBkb2VzIGF1
dG9SZWZyZXNoSW5kZXgsIGJ1dCBpcyB0aGF0IGJhc2VkIG9uIGEgZGlmZiBjb21wdXRhdGlvbj8g
SSB0aG91Z2h0IGdpdCBzdGF0dXMgbG9va3Mgb25seSBhdCBzdGF0IGluZm9ybWF0aW9uLg0KDQo+
IElzIHRoaXMgbW9yZSBsaWtlIHRoZSBjb21tb25seSBzZWVuICJhZnRlciB5b3UgZnV0emVkIHRo
ZSBhdHRyaWJ1dGVzIA0KPiB0byBhZmZlY3Qgbm9ybWFsaXphdGlvbiwgIi0tcmVub3JtYWxpemUi
IGlzIG5lZWRlZCB0byBmb3JjZSB0aGUgaW5kZXggDQo+IHRvIG1hdGNoIHRoZSBjbGVhbmVkIHZl
cnNpb24gb2Ygd29ya2luZyB0cmVlIHVuZGVyIHRoZSBuZXcgY2xlYW4gDQo+IGZpbHRlciBydWxl
cyIsIEkgd29uZGVyPw0KDQpOb3QgaW4gdGhpcyBjYXNlLiBUaGUgbW9kaWZpZWQgZmlsZSB0aGF0
IGdpdCBzdGF0dXMgcmVwb3J0cyBoYXBwZW5zIGxvbmcgYWZ0ZXIgZ2l0IGNvbW1pdCAtYSBoYXMg
YWxyZWFkeSBhcHBsaWVkIHRoZSBuZXcgZmlsdGVyLg0KDQotLSBIYW5uZXMNCg==
