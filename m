Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3A41FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 17:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753651AbcKRRFC (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 12:05:02 -0500
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:42008 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752526AbcKRRFB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 12:05:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 8A506100056;
        Fri, 18 Nov 2016 17:04:59 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AbG72mmPdPyd; Fri, 18 Nov 2016 17:04:59 +0000 (GMT)
Received: from EXMBNJE7.ad.twosigma.com (exmbnje7.ad.twosigma.com [172.20.45.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 7626780035;
        Fri, 18 Nov 2016 17:04:59 +0000 (GMT)
Received: from EXMBNJE7.ad.twosigma.com (172.20.45.147) by
 EXMBNJE7.ad.twosigma.com (172.20.45.147) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Fri, 18 Nov 2016 17:04:59 +0000
Received: from EXMBNJE7.ad.twosigma.com ([fe80::a093:116d:d3a6:d7a6]) by
 EXMBNJE7.ad.twosigma.com ([fe80::a093:116d:d3a6:d7a6%17]) with mapi id
 15.00.1156.000; Fri, 18 Nov 2016 17:04:59 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "spearce@spearce.org" <spearce@spearce.org>
Subject: RE: [PATCH] remote-curl: don't hang when a server dies before any
 output
Thread-Topic: [PATCH] remote-curl: don't hang when a server dies before any
 output
Thread-Index: AQHSP2ezYl8XykiMv0OTBeEAHSKu4qDe/BWAgAAAOEA=
Date:   Fri, 18 Nov 2016 17:04:59 +0000
Message-ID: <764305554fa74779ad5fb956aa2b658a@EXMBNJE7.ad.twosigma.com>
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
 <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
 <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
 <20161115004426.unheihlmftlw6ex7@sigill.intra.peff.net>
 <xmqqa8d1v9lo.fsf@gitster.mtv.corp.google.com>
 <20161115035844.e6ehuy7uigqinbnv@sigill.intra.peff.net>
 <xmqqzil0tza6.fsf@gitster.mtv.corp.google.com>
 <20161118170147.g7nbkxpyihwkk6fw@sigill.intra.peff.net>
In-Reply-To: <20161118170147.g7nbkxpyihwkk6fw@sigill.intra.peff.net>
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
ZWZmQHBlZmYubmV0XQ0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDE4LCAyMDE2IDEyOjAyIFBN
DQo+IFRvOiBKdW5pbyBDIEhhbWFubw0KPiBDYzogRGF2aWQgVHVybmVyOyBnaXRAdmdlci5rZXJu
ZWwub3JnOyBzcGVhcmNlQHNwZWFyY2Uub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHJlbW90
ZS1jdXJsOiBkb24ndCBoYW5nIHdoZW4gYSBzZXJ2ZXIgZGllcyBiZWZvcmUgYW55DQo+IG91dHB1
dA0KPiANCj4gT24gVHVlLCBOb3YgMTUsIDIwMTYgYXQgMDk6NDI6NTdBTSAtMDgwMCwgSnVuaW8g
QyBIYW1hbm8gd3JvdGU6DQo+IA0KPiA+ID4+IEhtcGguICBJIHRoaW5rIEkgdHJpZWQgRGF2aWQn
cyBvcmlnaW5hbCB1bmRlciBHSVRfVEVTVF9MT05HIGFuZCBzYXcNCj4gPiA+PiBpdCBnb3Qgc3R1
Y2s7IGNvdWxkIGJlIHRoZSBzYW1lIGlzc3VlLCBJIGd1ZXNzLg0KPiA+ID4NCj4gPiA+IEl0IHdv
cmtzIE9LIGhlcmUuIEkgdGhpbmsgaXQgaXMganVzdCB0aGF0IHRoZSB0ZXN0IGlzIHJlYWxseSBz
bG93DQo+ID4gPiAoYnkgZGVzaWduKS4NCj4gPg0KPiA+IFllYWgsIEkgdGhpbmsgd2hhdCBJIHJl
Y2FsbGVkIHdhcyBteSBvbGQgYXR0ZW1wdCB0byBydW4gdGhlIGZvbGxvdy11cA0KPiA+ICJhbnkg
U0hBLTEiIHBhdGNoIHdpdGhvdXQgdGhpcyBvbmUuDQo+IA0KPiBSaWdodCwgdGhhdCBtYWtlcyBz
ZW5zZS4NCj4gDQo+IFNvIEkgZG9uJ3QgZmVlbCBsaWtlIHdlIGhhdmUgYSBnb29kIHBhdGNoIGZv
ciB0aGUgZ2VuZXJhbCBjYXNlIHlldCwgYW5kDQo+IEknbSBwcm9iYWJseSBub3QgZ29pbmcgdG8g
Z2V0IGFyb3VuZCB0byBpbXBsZW1lbnRpbmcgaXQgYW55dGltZSBzb29uLiANCg0KSSdtIGNvbmZ1
c2VkIC0tIGl0IHNvdW5kcyBsaWtlIHlvdXIgcGF0Y2ggYWN0dWFsbHkgZG9lcyB3b3JrICh0aGF0
IGlzLCB0aGF0IEp1bmlvJ3MgZmFpbHVyZSB3YXMgbm90IGNhdXNlZCBieSB5b3VyIHBhdGNoIGJ1
dCBieSB0aGUgYWJzZW5jZSBvZiBvdXIgcGF0Y2hlcykuIEFuZCB5b3VyIHBhdGNoIGhhbmRsZXMg
bW9yZSBjYXNlcyB0aGFuIG1pbmUuICBTbyB3ZSBzaG91bGQgcHJvYmFibHkgdXNlIGl0IGluc3Rl
YWQgb2YgbWluZS4NCg==
