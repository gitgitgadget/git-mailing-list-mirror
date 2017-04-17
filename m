Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71E91FA26
	for <e@80x24.org>; Mon, 17 Apr 2017 23:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbdDQX3X (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 19:29:23 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:46797 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932233AbdDQX3U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 19:29:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id A15301000B2;
        Mon, 17 Apr 2017 23:29:18 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fo0F8vLUwDYv; Mon, 17 Apr 2017 23:29:18 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (exmbdft7.ad.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id 906B08002E;
        Mon, 17 Apr 2017 23:29:18 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Mon, 17 Apr 2017 23:29:18 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Mon, 17 Apr 2017 23:29:18 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "mfick@codeaurora.org" <mfick@codeaurora.org>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: RE: [PATCH] repack: respect gc.pid lock
Thread-Topic: [PATCH] repack: respect gc.pid lock
Thread-Index: AQHStVYFs4jQpN8FG0CoCGa3r9IKNaHJsErw
Date:   Mon, 17 Apr 2017 23:29:18 +0000
Message-ID: <c6dd37238f154ccea56dda9b43f3277a@exmbdft7.ad.twosigma.com>
References: <20170413202712.22192-1-dturner@twosigma.com>
 <20170414193341.itr3ybiiu2brt63b@sigill.intra.peff.net>
In-Reply-To: <20170414193341.itr3ybiiu2brt63b@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.13]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEplZmYgS2luZyBbbWFpbHRv
OnBlZmZAcGVmZi5uZXRdDQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMTQsIDIwMTcgMzozNCBQTQ0K
PiBUbzogRGF2aWQgVHVybmVyIDxEYXZpZC5UdXJuZXJAdHdvc2lnbWEuY29tPg0KPiBDYzogZ2l0
QHZnZXIua2VybmVsLm9yZzsgY2hyaXN0aWFuLmNvdWRlckBnbWFpbC5jb207IG1maWNrQGNvZGVh
dXJvcmEub3JnOw0KPiBqYWNvYi5rZWxsZXJAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIHJlcGFjazogcmVzcGVjdCBnYy5waWQgbG9jaw0KPiANCj4gT24gVGh1LCBBcHIgMTMsIDIw
MTcgYXQgMDQ6Mjc6MTJQTSAtMDQwMCwgRGF2aWQgVHVybmVyIHdyb3RlOg0KPiANCj4gPiBHaXQg
Z2MgbG9ja3MgdGhlIHJlcG9zaXRvcnkgKHVzaW5nIGEgZ2MucGlkIGZpbGUpIHNvIHRoYXQgb3Ro
ZXIgZ2NzDQo+ID4gZG9uJ3QgcnVuIGNvbmN1cnJlbnRseS4gTWFrZSBnaXQgcmVwYWNrIHJlc3Bl
Y3QgdGhpcyBsb2NrLg0KPiA+DQo+ID4gTm93IHJlcGFjaywgYnkgZGVmYXVsdCwgd2lsbCByZWZ1
c2UgdG8gcnVuIGF0IHRoZSBzYW1lIHRpbWUgYXMgYSBnYy4NCj4gPiBUaGlzIGZpeGVzIGEgY29u
Y3VycmVuY3kgaXNzdWU6IGEgcmVwYWNrIHdoaWNoIGRlbGV0ZWQgcGFja3Mgd291bGQNCj4gPiBt
YWtlIGEgY29uY3VycmVudCBnYyBzYWQgd2hlbiBpdHMgcGFja3Mgd2VyZSBkZWxldGVkIG91dCBm
cm9tIHVuZGVyDQo+ID4gaXQuICBUaGUgZ2Mgd291bGQgZmFpbCB3aXRoOiAiZmF0YWw6IC4vb2Jq
ZWN0cy9wYWNrL3BhY2stJHNoYS5wYWNrDQo+ID4gY2Fubm90IGJlIGFjY2Vzc2VkIi4gIFRoZW4g
aXQgd291bGQgZGllLCBwcm9iYWJseSBsZWF2aW5nIGEgbGFyZ2UgdGVtcA0KPiA+IHBhY2sgaGFu
Z2luZyBhcm91bmQuDQo+ID4NCj4gPiBHaXQgcmVwYWNrIGxlYXJucyAtLW5vLWxvY2ssIHNvIHRo
YXQgd2hlbiBydW4gdW5kZXIgZ2l0IGdjLCBpdCBkb2Vzbid0DQo+ID4gYXR0ZW1wdCB0byBtYW5h
Z2UgdGhlIGxvY2sgaXRzZWxmLg0KPiANCj4gVGhpcyBhbHNvIG1lYW5zIHRoYXQgdHdvIHJlcGFj
ayBpbnZvY2F0aW9ucyBjYW5ub3QgcnVuIHNpbXVsdGFuZW91c2x5LCBiZWNhdXNlDQo+IHRoZXkg
d2FudCB0byB0YWtlIHRoZSBzYW1lIGxvY2suICBCdXQgZGVwZW5kaW5nIG9uIHRoZSBvcHRpb25z
LCB0aGUgdHdvIGRvbid0DQo+IG5lY2Vzc2FyaWx5IGNvbmZsaWN0LiBGb3IgZXhhbXBsZSwgdHdv
IHNpbXVsdGFuZW91cyBpbmNyZW1lbnRhbCAiZ2l0IHJlcGFjayAtZCINCj4gaW52b2NhdGlvbnMg
c2hvdWxkIGJlIGFibGUgdG8gY29tcGxldGUuDQo+IA0KPiBEbyB3ZSBrbm93IHdoZXJlIHRoZSBl
cnJvciBtZXNzYWdlIGlzIGNvbWluZyBmcm9tPyBJIGNvdWxkbid0IGZpbmQgdGhlIGVycm9yDQo+
IG1lc3NhZ2UgeW91J3ZlIGdpdmVuIGFib3ZlOyBncmVwcGluZyBmb3IgImNhbm5vdCBiZSBhY2Nl
c3NlZCINCj4gc2hvd3Mgb25seSBlcnJvciBtZXNzYWdlcyB0aGF0IHdvdWxkIGhhdmUgInBhY2tm
aWxlIiBhZnRlciB0aGUgImZhdGFsOiIuDQo+IElzIGl0IGEgY29weS1wYXN0ZSBlcnJvcj8NCg0K
WWVzLCBpdCBpcy4gIFNvcnJ5Lg0KDQpXZSBzYXcgdGhpcyBmYWlsdXJlIGluIHRoZSBsb2dzIG11
bHRpcGxlICB0aW1lcyAod2l0aCB0aHJlZSBkaWZmZXJlbnQNCnNoYXMsIHdoaWxlIGEgZ2Mgd2Fz
IHJ1bm5pbmcpOg0KQXByaWwgMTIsIDIwMTcgMDY6NDUgLT4gRVJST1IgLT4gJ2dpdCAtYyByZXBh
Y2sud3JpdGVCaXRtYXBzPXRydWUgcmVwYWNrIC1BIC1kIC0tcGFjay1rZXB0LW9iamVjdHMnIGlu
IFtyZXBvXSBmYWlsZWQ6DQpmYXRhbDogcGFja2ZpbGUgLi9vYmplY3RzL3BhY2svcGFjay1bc2hh
XS5wYWNrIGNhbm5vdCBiZSBhY2Nlc3NlZA0KUG9zc2libHkgc29tZSBvdGhlciByZXBhY2sgd2Fz
IGFsc28gcnVubmluZyBhdCB0aGUgdGltZSBhcyB3ZWxsLg0KDQpNeSBjb2xsZWFndWUgYWxzbyBz
YXcgaXQgd2hpbGUgbWFudWFsbHkgZG9pbmcgZ2MgKGFnYWluIHdoaWxlIA0KcmVwYWNrcyB3ZXJl
IGxpa2VseSB0byBiZSBydW5uaW5nKToNCiQgZ2l0IGdjIC0tYWdncmVzc2l2ZQ0KQ291bnRpbmcg
b2JqZWN0czogMTM4MDAwNzMsIGRvbmUuDQpEZWx0YSBjb21wcmVzc2lvbiB1c2luZyB1cCB0byA4
IHRocmVhZHMuDQpDb21wcmVzc2luZyBvYmplY3RzOiAgOTklICgxMTQ2NTg0Ni8xMTQ2NTk3MSkg
ICANCkNvbXByZXNzaW5nIG9iamVjdHM6IDEwMCUgKDExNDY1OTcxLzExNDY1OTcxKSwgZG9uZS4N
CmZhdGFsOiBwYWNrZmlsZSBbcmVwb10vb2JqZWN0cy9wYWNrL3BhY2stW3NoYV0ucGFjayBjYW5u
b3QgYmUgYWNjZXNzZWQNCg0KKHllcywgSSBrbm93IHRoYXQgLS1hZ2dyZXNzaXZlIGlzIHVzdWFs
bHkgbm90IGRlc2lyYWJsZSkNCg0KPiBJZiB0aGF0J3MgdGhlIGNhc2UsIHRoZW4gaXQncyB0aGUg
b25lIGluIHVzZV9wYWNrKCkuIERvIHdlIGtub3cgd2hhdA0KPiBwcm9ncmFtL29wZXJhdGlvbiBp
cyBjYXVzaW5nIHRoZSBlcnJvcj8gSGF2aW5nIGEgc2ltdWx0YW5lb3VzIGdjIGRlbGV0ZSBhDQo+
IHBhY2tmaWxlIGlzIF9zdXBwb3NlZF8gdG8gd29yaywgdGhyb3VnaCBhIGNvbWJpbmF0aW9uIG9m
Og0KPiANCj4gICAxLiBNb3N0IHNoYTEtYWNjZXNzIG9wZXJhdGlvbnMgY2FuIHJlLXNjYW4gdGhl
IHBhY2sgZGlyZWN0b3J5IGlmIHRoZXkNCj4gICAgICBmaW5kIHRoZSBwYWNrZmlsZSB3ZW50IGF3
YXkuDQo+IA0KPiAgIDIuIFRoZSBwYWNrLW9iamVjdHMgcnVuIGJ5IGEgc2ltdWx0YW5lb3VzIHJl
cGFjayBpcyBzb21ld2hhdCBzcGVjaWFsDQo+ICAgICAgaW4gdGhhdCBvbmNlIGl0IGZpbmRzIGFu
ZCBjb21taXRzIHRvIGEgY29weSBvZiBhbiBvYmplY3QgaW4gYSBwYWNrLA0KPiAgICAgIHdlIG5l
ZWQgdG8gdXNlIGV4YWN0bHkgdGhhdCBwYWNrLCBiZWNhdXNlIHdlIHJlY29yZCBpdHMgb2Zmc2V0
LA0KPiAgICAgIGRlbHRhIHJlcHJlc2VudGF0aW9uLCBldGMuIFVzdWFsbHkgdGhpcyB3b3JrcyBi
ZWNhdXNlIHdlIG9wZW4gYW5kDQo+ICAgICAgbW1hcCB0aGUgcGFja2ZpbGUgYmVmb3JlIG1ha2lu
ZyB0aGF0IGNvbW1pdG1lbnQsIGFuZCBvcGVuIHBhY2tmaWxlcw0KPiAgICAgIGFyZSBvbmx5IGNs
b3NlZCBpZiB5b3UgcnVuIG91dCBvZiBmaWxlIGRlc2NyaXB0b3JzICh3aGljaCBzaG91bGQNCj4g
ICAgICBvbmx5IGhhcHBlbiB3aGVuIHlvdSBoYXZlIGEgaHVnZSBudW1iZXIgb2YgcGFja3MpLg0K
DQpXZSBoYXZlIGEgcmVhc29uYWJsZSBybGltaXQgKDY0ayBzb2Z0IGxpbWl0KSwgc28gdGhhdCBm
YWlsdXJlIG1vZGUgaXMgcHJldHR5IA0KdW5saWtlbHkuICBJICB0aGluayB3ZSBzaG91bGQgaGF2
ZSBoYWQgMjAgb3Igc28gcGFja3MgLS0gbm90IHRlbnMgb2YgdGhvdXNhbmRzLg0KDQo+IFNvIEkn
bSB3b3JyaWVkIHRoYXQgdGhpcyByZXBhY2sgbG9jayBpcyBnb2luZyB0byByZWdyZXNzIHNvbWUg
b3RoZXIgY2FzZXMgdGhhdCBydW4NCj4gZmluZSB0b2dldGhlci4gQnV0IEknbSBhbHNvIHdvcnJp
ZWQgdGhhdCBpdCdzIGEgYmFuZC1haWQgb3ZlciBhIG1vcmUgc3VidGxlDQo+IHByb2JsZW0uIElm
IHBhY2stb2JqZWN0cyBpcyBub3QgYWJsZSB0byBydW4gYWxvbmdzaWRlIGEgZ2MsIHRoZW4geW91
J3JlIGFsc28gZ29pbmcNCj4gdG8gaGF2ZSBwcm9ibGVtcyBzZXJ2aW5nIGZldGNoZXMsIGFuZCBv
YnZpb3VzbHkgeW91IHdvdWxkbid0IHdhbnQgdG8gdGFrZSBhDQo+IGxvY2sgdGhlcmUuDQoNCkkg
c2VlIHlvdXIgcG9pbnQuICBJIGRvbid0IGtub3cgaWYgaXQncyBwYWNrLW9iamVjdHMgdGhhdCdz
IHNlZWluZyB0aGlzLCBhbHRob3VnaCBtYXliZSANCnRoYXQncyB0aGUgb25seSByZWFzb25hYmxl
IGNvZGVwYXRoLg0KDQpJIGRpZCBzb21lIHRyYWNpbmcgdGhyb3VnaCB0aGUgY29kZSwgYW5kIGNv
dWxkbid0IGZpZ3VyZSBvdXQgaG93IHRvIHRyaWdnZXIgdGhhdCANCmVycm9yIG1lc3NhZ2UuICBJ
dCBhcHBlYXJzIGluIHR3byBwbGFjZXMgaW4gdGhlIGNvZGUsIGJ1dCBvbmx5IHdoZW4gdGhlIHBh
Y2sgaXMgbm90IA0KaW5pdGlhbGl6ZWQuICBCdXQgdGhlIHBhY2tzIGFsd2F5cyBzZWVtIHRvIGJl
IHNldCB1cCBieSB0aGF0IHBvaW50IGluIG15IHRlc3QgcnVucy4gIA0KSXQncyB3b3J0aCBub3Rp
bmcgdGhhdCBJJ20gbm90IHRlc3Rpbmcgb24gdGhlIGdpdGxhYiBzZXJ2ZXI7IEknbSB0ZXN0aW5n
IG9uIG15IGxhcHRvcCB3aXRoDQphIGNvbXBsZXRlbHkgZGlmZmVyZW50IHJlcG8uICBCdXQgSSd2
ZSB0cmllZCB2YXJpb3VzIHdheXMgdG8gcmVwcm8gdGhpcyAtLSBvciBldmVuIHRvIA0KZ2V0IHRv
IGEgcG9pbnQgd2hlcmUgdGhvc2UgZXJyb3JzIHdvdWxkIGhhdmUgYmVlbiB0aHJvd24gZ2l2ZW4g
YSBtaXNzaW5nIHBhY2sgLS0gDQphbmQgSSBoYXZlIG5vdCBiZWVuIGFibGUgdG8uDQoNCkRvIHlv
dSBoYXZlIGFueSBpZGVhIHdoeSB0aGlzIHdvdWxkIGJlIGhhcHBlbmluZyBvdGhlciB0aGFuIHRo
ZSBybGltaXQgdGhpbmc/DQoNCg==
