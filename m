Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04732C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 22:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F13423A33
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 22:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394651AbgLKVYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 16:24:32 -0500
Received: from mx-out1.deshaw.net ([149.77.95.27]:38638 "EHLO
        mx-out1.deshaw.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392903AbgLKVYG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 16:24:06 -0500
Received: from mx-relay1.deshaw.net (localhost [127.0.0.1])
        by mx-out1.deshaw.net (Postfix) with ESMTPS id 90F49C1B1A4;
        Fri, 11 Dec 2020 16:23:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deshaw.com; s=k001;
        t=1607721803; bh=V2phEmMLY5BrM13eJPcKGquLKzYkPqK0vZUXS4MPA08=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=pDNWN/q0q+pcAHmp5UAL86I3KOt7Ye63oYySZ5ufBORwZznDKrDyvQuEeGBU1Vy3C
         4IqwgkS4D/6zXSCkeMxJWXik/HXNYlER0/gDY5dtmn52cFDLxWuUbt0ic7BNQoQ//r
         vU71NRmAwCn513tBHi02itqiNqp6uDgXFNIXnX60=
Received: from deshaw.com (mail-multi.dr.deshaw.com [10.218.243.33])
        by mx-relay1.deshaw.net (Postfix) with ESMTPS id 8C624120731A;
        Fri, 11 Dec 2020 16:23:23 -0500 (EST)
Received: from exchmbxpsc1a.deshaw.com (exchmbxpsc1a.deshaw.com [10.218.74.16])
        by mail-multi.dr.deshaw.com (Postfix) with ESMTPS id 870E26000137;
        Fri, 11 Dec 2020 16:23:23 -0500 (EST)
Received: from exchmbxtoa1b.deshaw.com (10.219.74.15) by
 exchmbxpsc1a.deshaw.com (10.218.74.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Fri, 11 Dec 2020 16:23:23 -0500
Received: from exchmbxtoa1b.deshaw.com ([fe80::b55e:2430:4455:ec8c]) by
 exchmbxtoa1b.deshaw.com ([fe80::b55e:2430:4455:ec8c%8]) with mapi id
 15.01.2044.006; Fri, 11 Dec 2020 16:23:23 -0500
From:   "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Why does "git pull --rebase" require a clean git directory?
Thread-Topic: Why does "git pull --rebase" require a clean git directory?
Thread-Index: AdbPP61Cqd2qDGLkQBqcxA5WNQltwgAWd2QAABpDkTA=
Date:   Fri, 11 Dec 2020 21:23:23 +0000
Message-ID: <f5b5b94830ca45b69440c0ebc1de5e69@deshaw.com>
References: <ea1e654cec62411884e2c260524fb05a@deshaw.com>
 <X9LqnolNcWZvA7Bm@camp.crustytoothpaste.net>
In-Reply-To: <X9LqnolNcWZvA7Bm@camp.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.219.66.99]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Content-Scanned: Fidelis Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24uIEl0IHNlZW1zIGxpa2Ugc29tZSBvcHRpbWl6YXRp
b25zIG1heSBzdGlsbCBiZSBwb3NzaWJsZS4gRm9yIGV4YW1wbGUsIGlmIHRoZSBwdWxsIGNvdWxk
IGJlIGRvbmUgd2l0aCBhIGZhc3QtZm9yd2FyZCBtZXJnZSwgdGhlbiB5b3UgZG9uJ3QgbmVlZCB0
byByZWJhc2UgYXQgYWxsLiBUaGlzIGNvdWxkIGJlIGFuIG9wdGlvbiBsaWtlIHB1bGwucmViYXNl
PW5vZmZvbmx5Lg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYnJpYW4gbS4g
Y2FybHNvbiA8c2FuZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldD4gDQpTZW50OiBUaHVyc2RheSwg
RGVjZW1iZXIgMTAsIDIwMjAgMTA6NDIgUE0NClRvOiBTaHVwYWssIFZpdGFseSA8Vml0YWx5LlNo
dXBha0BkZXNoYXcuY29tPg0KQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBX
aHkgZG9lcyAiZ2l0IHB1bGwgLS1yZWJhc2UiIHJlcXVpcmUgYSBjbGVhbiBnaXQgZGlyZWN0b3J5
Pw0KDQpPbiAyMDIwLTEyLTEwIGF0IDIyOjE1OjExLCBTaHVwYWssIFZpdGFseSB3cm90ZToNCj4g
SGksDQo+IA0KPiAiZ2l0IHB1bGwgLS1yZWJhc2UiIHJlcXVpcmVzIGhhdmluZyBOTyB1bmNvbW1p
dHRlZCBjaGFuZ2VzLCBldmVuIGlmIA0KPiB0aGUgbG9jYWxseSBtb2RpZmllZCBmaWxlcyBoYXZl
bid0IGJlZW4gdXBkYXRlZCB1cHN0cmVhbSwgb3IgZXZlbiBpZiANCj4gdGhlcmUgYXJlIG5vIGNo
YW5nZXMgdG8gdXBzdHJlYW0gYXQgYWxsLiBJIGtub3cgSSBjb3VsZCB1c2UgDQo+IC0tYXV0b3N0
YXNoLCBidXQgdGhhdCdzIGluZWZmaWNpZW50IGFuZCBtYXkgYmUgdW5kZXNpcmFibGUgaWYgaXQg
d291bGQgDQo+IGNyZWF0ZSBhIGNvbmZsaWN0Lg0KPiANCj4gV291bGQgaXQgYmUgcG9zc2libGUg
dG8gY2hhbmdlIHRoZSBiZWhhdmlvciBvZiAiZ2l0IHB1bGwgLS1yZWJhc2UiIHNvIA0KPiB0aGF0
IGl0IG9ubHkgZmFpbHMgaWYgdGhlIGxvY2FsbHkgbW9kaWZpZWQgZmlsZXMgY29uZmxpY3Qgd2l0
aCB0aGUgDQo+IGZpbGVzIG1vZGlmaWVkIHVwc3RyZWFtIChzaW1pbGFyIHRvIHRoZSBkZWZhdWx0
IGdpdCBwdWxsIGJlaGF2aW9yIA0KPiB3aXRob3V0IC0tcmViYXNlKT8NCg0KSSBzdXNwZWN0IHRo
ZSByZWFzb24gZm9yIHRoZSBkaWZmZXJlbmNlIGlzIGluIGhvdyB0aGUgdHdvIHBpZWNlcyBvZiBj
b2RlIHdvcmsuICBBIG1lcmdlIGluIGdlbmVyYWwgY2FuIHdvcmsgaW4gYSBkaXJ0eSB0cmVlIHdo
ZXJlYXMgYSByZWJhc2UgY2Fubm90LiAgVGhhdCwgaW4gdHVybiwgaXMgYmVjYXVzZSB0aGUgbWVy
Z2UgY29kZSBtZXJnZXMgdHdvIGZpbGVzIGludGVybmFsbHkgYW5kIHRoZW4gd3JpdGVzIHRoZW0g
b3V0IHRvIHRoZSB3b3JraW5nIHRyZWUsIHdoZXJlYXMgdGhlIHJlYmFzZSBjb2RlLCBhdCBsZWFz
dCBpbiBzb21lIGNhc2VzLCBkb2Vzbid0IGNvbnRhaW4gdGhlIHNhbWUgcHJlY2F1dGlvbnMgbm90
IHRvIG1vZGlmeSB0aGUgd29ya2luZyB0cmVlLg0KDQpNb3Jlb3ZlciwgYSBtZXJnZSBpcyBhIHNp
bmdsZSBvcGVyYXRpb24sIHNvIGl0J3Mgc2FmZSB0byBvcGVyYXRlIG9uIGEgY29tbWl0IGFuZCB0
aGVuIGdpdmUgdXAuICBBIHJlYmFzZSBjb25zaXN0cyBvZiBtdWx0aXBsZSBvcGVyYXRpb25zLCBz
byB3ZSdkIGhhdmUgdG8gZXZhbHVhdGUgZWFjaCBvcGVyYXRpb24gYW5kIHN5bnRoZXNpemUgaXQs
IGludGVybmFsbHkgcGVyZm9ybWluZyB0aGUgbWVyZ2UgKG9yIGFwcGx5KSB0aGF0J3MgYSBwYXJ0
IG9mIGl0LCBpbiBvcmRlciB0byBkZXRlcm1pbmUgaWYgaXQgd291bGQgY29uZmxpY3QuICBPdGhl
cndpc2UsIHdlJ2QgaGF2ZSB0byBqdXN0IHRyeSBpdCBhbmQgc29tZWhvdyBhYm9ydCBjbGVhbmx5
IGluIHRoZSBtaWRkbGUgd2l0aG91dCBvdGhlcndpc2UgZGlydHlpbmcgdGhlIHdvcmtpbmcgdHJl
ZS4gIFJpZ2h0IG5vdywgdGhhdCBhYm9ydCBzdGVwIGludm9sdmVzIGEgcmVzZXQgLS1oYXJkLCB3
aGljaCBpcyBnb2luZyB0byBibG93IGF3YXkgeW91ciBkYXRhLg0KDQpTbyBpcyBpdCBwb3NzaWJs
ZSB0byBkbz8gIFN1cmUuICBJcyBpdCBlYXN5PyAgTm90IGVzcGVjaWFsbHkgd2l0aCB0aGUgY3Vy
cmVudCBjb2RlLiAgU28gY2VydGFpbmx5IGl0IGNvdWxkIGJlIGRvbmUgaWYgaXQgd2VyZSBpbXBv
cnRhbnQgdG8gc29tZW9uZSwgYnV0IGl0IHdpbGwgbGlrZWx5IGJlIGEgZ29vZCBiaXQgb2Ygd29y
ay4NCg0KU29ycnkgdGhpcyB3YXNuJ3QgdGhlIG5ld3MgeW91IHdlcmUgaG9waW5nIGZvci4gIEkn
ZCBsb3ZlIHRvIGhhdmUgc29tZSBlYXN5IHNvbHV0aW9uIHRoYXQgSSBjb3VsZCBvZmZlciB0byBz
ZW5kIGluIGEgcGF0Y2ggZm9yIHRoaXMgd2Vla2VuZCB0byBzb2x2ZSB0aGlzLCBidXQgdW5mb3J0
dW5hdGVseSBpdCdzIG5vdCB0aGF0IGVhc3kuDQotLQ0KYnJpYW4gbS4gY2FybHNvbiAoaGUvaGlt
IG9yIHRoZXkvdGhlbSkNCkhvdXN0b24sIFRleGFzLCBVUw0K
