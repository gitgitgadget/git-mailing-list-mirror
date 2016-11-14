Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 572A9203C1
	for <e@80x24.org>; Mon, 14 Nov 2016 23:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938725AbcKNXZd (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 18:25:33 -0500
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:51772 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753048AbcKNXZc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 18:25:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id E1A53100062;
        Mon, 14 Nov 2016 23:25:30 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1-vk8qRoKSxN; Mon, 14 Nov 2016 23:25:30 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (exmbdft7.ad.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id D09E88002E;
        Mon, 14 Nov 2016 23:25:30 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Mon, 14 Nov 2016 23:25:30 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Mon, 14 Nov 2016 23:25:30 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "spearce@spearce.org" <spearce@spearce.org>
Subject: RE: [PATCH] remote-curl: don't hang when a server dies before any
 output
Thread-Topic: [PATCH] remote-curl: don't hang when a server dies before any
 output
Thread-Index: AQHSPqRXYl8XykiMv0OTBeEAHSKu4qDY4LeAgAA9QGA=
Date:   Mon, 14 Nov 2016 23:25:30 +0000
Message-ID: <a57cc9c4a0a840baab5b8123fac9388b@exmbdft7.ad.twosigma.com>
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
 <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
 <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
In-Reply-To: <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.14]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZWZmIEtpbmcgW21haWx0bzpw
ZWZmQHBlZmYubmV0XQ0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDE0LCAyMDE2IDI6NDEgUE0N
Cj4gVG86IERhdmlkIFR1cm5lcg0KPiBDYzogZ2l0QHZnZXIua2VybmVsLm9yZzsgc3BlYXJjZUBz
cGVhcmNlLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSByZW1vdGUtY3VybDogZG9uJ3QgaGFu
ZyB3aGVuIGEgc2VydmVyIGRpZXMgYmVmb3JlIGFueQ0KPiBvdXRwdXQNCj4gDQo+IE9uIE1vbiwg
Tm92IDE0LCAyMDE2IGF0IDAxOjI0OjMxUE0gLTA1MDAsIEplZmYgS2luZyB3cm90ZToNCj4gDQo+
ID4gICAyLiBIYXZlIHJlbW90ZS1jdXJsIHVuZGVyc3RhbmQgZW5vdWdoIG9mIHRoZSBwcm90b2Nv
bCB0aGF0IGl0IGNhbg0KPiA+ICAgICAgYWJvcnQgcmF0aGVyIHRoYW4gaGFuZy4NCj4gPg0KPiA+
ICAgICAgSSB0aGluayB0aGF0J3MgZWZmZWN0aXZlbHkgdGhlIGFwcHJvYWNoIG9mIHlvdXIgcGF0
Y2gsIGJ1dCBmb3Igb25lDQo+ID4gICAgICBzcGVjaWZpYyBjYXNlLiBCdXQgY291bGQgd2UsIGZv
ciBleGFtcGxlLCBtYWtlIHN1cmUgdGhhdCBldmVyeXRoaW5nDQo+ID4gICAgICB3ZSBwcm94eSBp
cyBhIGNvbXBsZXRlIHNldCBvZiBwa3RsaW5lcyBhbmQgZW5kcyB3aXRoIGEgZmx1c2g/IEFuZA0K
PiA+ICAgICAgaWYgbm90LCB0aGVuIHdlIGhhbmcgdXAgb24gZmV0Y2gtcGFjay4NCj4gPg0KPiA+
ICAgICAgSSBfdGhpbmtfIHRoYXQgd291bGQgd29yaywgYmVjYXVzZSBldmVuIHRoZSBwYWNrIGlz
IGFsd2F5cyBlbmNhc2VkDQo+ID4gICAgICBpbiBwa3RsaW5lcyBmb3Igc21hcnQtaHR0cC4NCj4g
DQo+IFNvIHNvbWV0aGluZyBsaWtlIHRoaXMuIEl0IHR1cm5lZCBvdXQgdG8gYmUgYSBsb3QgdWds
aWVyIHRoYW4gSSBoYWQgaG9wZWQNCj4gYmVjYXVzZSB3ZSBnZXQgZmVkIHRoZSBkYXRhIGZyb20g
Y3VybCBpbiBvZGQtc2l6ZWQgY2h1bmtzLCBzbyB3ZSBuZWVkIGENCj4gc3RhdGUgbWFjaGluZS4N
Cj4gDQo+IEJ1dCBpdCBkb2VzIHNlZW0gdG8gd29yay4gQXQgbGVhc3QgaXQgZG9lc24ndCBzZWVt
IHRvIGJyZWFrIGFueXRoaW5nIGluDQo+IHRoZSB0ZXN0IHN1aXRlLCBhbmQgaXQgZml4ZXMgdGhl
IG5ldyB0ZXN0cyB5b3UgYWRkZWQuIEknZCB3b3JyeSB0aGF0DQo+IHRoZXJlJ3Mgc29tZSBvYnNj
dXJlIGNhc2Ugd2hlcmUgdGhlIHJlc3BvbnNlIGlzbid0IHBhY2tldGl6ZWQgaW4gdGhlIHNhbWUN
Cj4gd2F5Lg0KDQpPdmVyYWxsLCB0aGlzIGxvb2tzIGdvb2QgdG8gbWUuICBUaGUgc3RhdGUgbWFj
aGluZSBpcyBwcmV0dHkgY2xlYW4uIEkgdGhpbmsgSSB3b3VsZCBoYXZlIHVzZWQgYSB0aW55IGJ1
ZmZlciBmb3IgdGhlIGxlbmd0aCBmaWVsZCwgYW5kIHRoZW4gSSB3b3VsZCBoYXZlIHJlZ3JldHRl
ZCBpdC4gIFlvdXIgd2F5IGxvb2tzIG5pY2VyIHRoYW4gbXkgdW53cml0dGVuIHBhdGNoIHdvdWxk
IGhhdmUgbG9va2VkLg0KDQo+ICsjZGVmaW5lIFJFQURfT05FX0hFWChzaGlmdCkgZG8geyBcDQo+
ICsJaW50IHZhbCA9IGhleHZhbChidWZbMF0pOyBcDQo+ICsJaWYgKHZhbCA8IDApIHsgXA0KPiAr
CQl3YXJuaW5nKCJlcnJvciBvbiAlZCIsICpidWYpOyBcDQo+ICsJCXJwYy0+cGt0bGluZV9zdGF0
ZSA9IFJQQ19QS1RMSU5FX0VSUk9SOyBcDQo+ICsJCXJldHVybjsgXA0KPiArCX0gXA0KPiArCXJw
Yy0+cGt0bGluZV9sZW4gfD0gdmFsIDw8IHNoaWZ0OyBcDQoNCk5pdDogcGFyZW50aGVzaXplIHNo
aWZ0IGhlcmUsIHNpbmNlIGl0IGlzIGEgcGFyYW1ldGVyIHRvIGEgbWFjcm8uDQoNCg==
