Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFCC42047F
	for <e@80x24.org>; Mon, 18 Sep 2017 13:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755265AbdIRNck (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 09:32:40 -0400
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:53370 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbdIRNci (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 09:32:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 6720B100043;
        Mon, 18 Sep 2017 13:32:37 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yqplI_uDPeHq; Mon, 18 Sep 2017 13:32:37 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 553228002E;
        Mon, 18 Sep 2017 13:32:37 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Mon, 18 Sep 2017 13:32:37 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Mon, 18 Sep 2017 13:32:36 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Ben Peart' <peartben@gmail.com>,
        'Ben Peart' <benpeart@microsoft.com>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v6 04/12] fsmonitor: teach git to optionally utilize a
 file system monitor to speed up detecting new or changed files.
Thread-Topic: [PATCH v6 04/12] fsmonitor: teach git to optionally utilize a
 file system monitor to speed up detecting new or changed files.
Thread-Index: AQHTLlfZ9UY7A3HP7kmYSR3gNLzDdaK2XgUAgARDbYCAAALpAA==
Date:   Mon, 18 Sep 2017 13:32:36 +0000
Message-ID: <1f095732aec2469f86a7018aa9f1f8ec@exmbdft7.ad.twosigma.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-5-benpeart@microsoft.com>
 <850c2ad20acc4c14be87a767af851b19@exmbdft7.ad.twosigma.com>
 <3e0d003e-0643-0359-35fd-a5ecf9b751c3@gmail.com>
In-Reply-To: <3e0d003e-0643-0359-35fd-a5ecf9b751c3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCZW4gUGVhcnQgW21haWx0bzpw
ZWFydGJlbkBnbWFpbC5jb21dDQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE4LCAyMDE3IDk6
MDcgQU0NCj4gVG86IERhdmlkIFR1cm5lciA8RGF2aWQuVHVybmVyQHR3b3NpZ21hLmNvbT47ICdC
ZW4gUGVhcnQnDQo+IDxiZW5wZWFydEBtaWNyb3NvZnQuY29tPg0KPiBDYzogYXZhcmFiQGdtYWls
LmNvbTsgY2hyaXN0aWFuLmNvdWRlckBnbWFpbC5jb207IGdpdEB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGdpdHN0ZXJAcG9ib3guY29tOyBqb2hhbm5lcy5zY2hpbmRlbGluQGdteC5kZTsgcGNsb3Vkc0Bn
bWFpbC5jb207DQo+IHBlZmZAcGVmZi5uZXQNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwNC8x
Ml0gZnNtb25pdG9yOiB0ZWFjaCBnaXQgdG8gb3B0aW9uYWxseSB1dGlsaXplIGEgZmlsZQ0KPiBz
eXN0ZW0gbW9uaXRvciB0byBzcGVlZCB1cCBkZXRlY3RpbmcgbmV3IG9yIGNoYW5nZWQgZmlsZXMu
DQo+IA0KPiBUaGFua3MgZm9yIHRha2luZyB0aGUgdGltZSB0byByZXZpZXcvcHJvdmlkZSBmZWVk
YmFjayENCj4gDQo+IE9uIDkvMTUvMjAxNyA1OjM1IFBNLCBEYXZpZCBUdXJuZXIgd3JvdGU6DQo+
ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEJlbiBQZWFydCBbbWFp
bHRvOmJlbnBlYXJ0QG1pY3Jvc29mdC5jb21dDQo+ID4+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVy
IDE1LCAyMDE3IDM6MjEgUE0NCj4gPj4gVG86IGJlbnBlYXJ0QG1pY3Jvc29mdC5jb20NCj4gPj4g
Q2M6IERhdmlkIFR1cm5lciA8RGF2aWQuVHVybmVyQHR3b3NpZ21hLmNvbT47IGF2YXJhYkBnbWFp
bC5jb207DQo+ID4+IGNocmlzdGlhbi5jb3VkZXJAZ21haWwuY29tOyBnaXRAdmdlci5rZXJuZWwu
b3JnOyBnaXRzdGVyQHBvYm94LmNvbTsNCj4gPj4gam9oYW5uZXMuc2NoaW5kZWxpbkBnbXguZGU7
IHBjbG91ZHNAZ21haWwuY29tOyBwZWZmQHBlZmYubmV0DQo+ID4+IFN1YmplY3Q6IFtQQVRDSCB2
NiAwNC8xMl0gZnNtb25pdG9yOiB0ZWFjaCBnaXQgdG8gb3B0aW9uYWxseSB1dGlsaXplDQo+ID4+
IGEgZmlsZSBzeXN0ZW0gbW9uaXRvciB0byBzcGVlZCB1cCBkZXRlY3RpbmcgbmV3IG9yIGNoYW5n
ZWQgZmlsZXMuDQo+ID4NCj4gPj4gK2ludCBnaXRfY29uZmlnX2dldF9mc21vbml0b3Iodm9pZCkN
Cj4gPj4gK3sNCj4gPj4gKwlpZiAoZ2l0X2NvbmZpZ19nZXRfcGF0aG5hbWUoImNvcmUuZnNtb25p
dG9yIiwgJmNvcmVfZnNtb25pdG9yKSkNCj4gPj4gKwkJY29yZV9mc21vbml0b3IgPSBnZXRlbnYo
IkdJVF9GU01PTklUT1JfVEVTVCIpOw0KPiA+PiArDQo+ID4+ICsJaWYgKGNvcmVfZnNtb25pdG9y
ICYmICEqY29yZV9mc21vbml0b3IpDQo+ID4+ICsJCWNvcmVfZnNtb25pdG9yID0gTlVMTDsNCj4g
Pj4gKw0KPiA+PiArCWlmIChjb3JlX2ZzbW9uaXRvcikNCj4gPj4gKwkJcmV0dXJuIDE7DQo+ID4+
ICsNCj4gPj4gKwlyZXR1cm4gMDsNCj4gPj4gK30NCj4gPg0KPiA+IFRoaXMgZnVuY3Rpb25zIHJl
dHVybiB2YWx1ZXMgYXJlIGJhY2t3YXJkcyByZWxhdGl2ZSB0byB0aGUgcmVzdCBvZiB0aGUNCj4g
Z2l0X2NvbmZpZ18qIGZ1bmN0aW9ucy4NCj4gDQo+IEknbSBjb25mdXNlZC4gIElmIGNvcmUuZnNt
b25pdG9yIGlzIGNvbmZpZ3VyZWQsIGl0IHJldHVybnMgMS4gSWYgaXQgaXMgbm90DQo+IGNvbmZp
Z3VyZWQsIGl0IHJldHVybnMgMC4gSSBkb24ndCBtYWtlIHVzZSBvZiB0aGUgLTEgLyogZGVmYXVs
dCB2YWx1ZSAqLyBvcHRpb24NCj4gYXMgSSBkaWRuJ3Qgc2VlIGFueSB1c2UvdmFsdWUgaW4gdGhp
cyBjYXNlLiBXaGF0IGlzIGJhY2t3YXJkcz8NCg0KVGhlIG90aGVyIGdpdF9jb25maWdfKiBmdW5j
dGlvbnMgcmV0dXJuIDEgZm9yIGVycm9yIGFuZCAwIGZvciBzdWNjZXNzLg0KDQo+ID4gW3NuaXBd
DQo+ID4NCj4gPiArPgkvKg0KPiA+ICs+CSAqIFdpdGggZnNtb25pdG9yLCB3ZSBjYW4gdHJ1c3Qg
dGhlIHVudHJhY2tlZCBjYWNoZSdzIHZhbGlkIGZpZWxkLg0KPiA+ICs+CSAqLw0KPiA+DQo+IA0K
PiBEaWQgeW91IGludGVuZCB0byBtYWtlIGEgY29tbWVudCBoZXJlPw0KDQpTb3JyeS4gIEkgd2Fz
IGdvaW5nIHRvIG1ha2UgYSBjb21tZW50IHRoYXQgSSBkaWRuJ3Qgc2VlIGhvdyB0aGF0IGNvdWxk
IHdvcmsgDQpzaW5jZSB3ZSB3ZXJlbid0IHRvdWNoaW5nIHRoZSB1bnRyYWNrZWQgY2FjaGUgaGVy
ZSwgYnV0IHRoZW4gSSBzYXcgdGhlIGJpdCANCmZ1cnRoZXIgZG93bi4gICBJJ20gc3RpbGwgbm90
IHN1cmUgaXQgd29ya3MgKHNlZSBjb21tZW50IG9uIDEwLzEyKSwgYnV0IGF0DQpsZWFzdCBpdCBj
b3VsZCBpbiB0aGVvcnkgd29yay4NCiANCg0K
