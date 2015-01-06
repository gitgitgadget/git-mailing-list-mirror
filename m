From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: [PATCH v2] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Tue, 6 Jan 2015 15:31:29 +0000
Message-ID: <3FBC0B0E-BB54-4BD5-AE7D-C82BA9FBA1C1@cisco.com>
References: <1419652893-477694-1-git-send-email-sandals@crustytoothpaste.net>
 <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
 <F91CD1B2-262C-4ED6-AE46-31B1333E0350@cisco.com>
 <20150105235308.GC1025060@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jan 06 16:33:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8W6i-0003iw-UT
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 16:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747AbbAFPbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 10:31:34 -0500
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:62535 "EHLO
	rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739AbbAFPbc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 10:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4968; q=dns/txt; s=iport;
  t=1420558292; x=1421767892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ki6lcdNH1EWF8/p59ghSFLtv9YIPiv2d9M5eM4gsoFI=;
  b=APq6JYakDisz7G4dSKy5/dn9EjyQbHMFajiEDAvlDN9hFKIXQOHuch7L
   ekXQ1bh9qStRUmXJCuyVdX/hUW5tBFcTMVPlTD8mCWq58sFeLNaxxSL43
   oDKL5uRAosn6bCErwliykVbEmHoLaYum1ZhoSY0znJN8UlE8Nwgm96WKL
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArUFAPH+q1StJA2H/2dsb2JhbABcgwZSWASDAcM7hXcCHHIWAQEBAQF9hAwBAQEDASMRRQULAgEIGAICEgETAgICMBUQAgQOBYgkCK4ElAIBAQEBAQEBAQEBAQEBAQEBAQEBAQEXgSGOPBsHBA4BglUugRMFhSuGfoF3g0CBf4E4gX6RWSKDbm+BBQcXIn4BAQE
X-IronPort-AV: E=Sophos;i="5.07,708,1413244800"; 
   d="scan'208";a="384747406"
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by rcdn-iport-3.cisco.com with ESMTP; 06 Jan 2015 15:31:31 +0000
Received: from xhc-aln-x02.cisco.com (xhc-aln-x02.cisco.com [173.36.12.76])
	by alln-core-2.cisco.com (8.14.5/8.14.5) with ESMTP id t06FVUD5018991
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 6 Jan 2015 15:31:30 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.219]) by
 xhc-aln-x02.cisco.com ([173.36.12.76]) with mapi id 14.03.0195.001; Tue, 6
 Jan 2015 09:31:30 -0600
Thread-Topic: [PATCH v2] remote-curl: fall back to Basic auth if Negotiate
 fails
Thread-Index: AQHQJf0bER2Pnky56Uqguh0whTd+7JyydFEAgAApzYCAAQYrgA==
In-Reply-To: <20150105235308.GC1025060@vauxhall.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.82.241.248]
Content-ID: <565B6C23BFFEDB4BA51AB1C54B5C34E5@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262070>

T24gSmFuIDUsIDIwMTUsIGF0IDY6NTMgUE0sIGJyaWFuIG0uIGNhcmxzb24gPHNhbmRhbHNAY3J1
c3R5dG9vdGhwYXN0ZS5uZXQ+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBKYW4gMDUsIDIwMTUgYXQg
MDk6MjM6MzJQTSArMDAwMCwgRGFuIExhbmdpbGxlIChkYWxhbmdpbCkgd3JvdGU6DQo+PiBJIGhh
dmUgdHJpZWQgYm90aCBwYXRjaGVzLiAgTmVpdGhlciBzdWNjZWVkcyBoZXJlLiAgSSBwYXRjaGVk
IGdpdCB2ZXJzaW9uIDIuMi4xIGJ1dCBJIGRvbuKAmXQgdGhpbmsgdGhhdCBhZmZlY3RzIHRoaXMu
DQo+IA0KPiBZb3UgYXJlIHBhdGNoaW5nIHRoZSBjbGllbnQgc2lkZSwgY29ycmVjdD8gIFRoYXQn
cyB0aGUgc2lkZSB0aGF0IG5lZWRzIHBhdGNoaW5nIGhlcmUuDQoNClllcywgSSBhbS4NCg0KPiBK
dXN0IHNvIHRoZSBsaXN0IGtub3dzLCBJIHdpbGwgYmUgc2VuZGluZyBhIHJlcm9sbCB0byB0aGUg
ZXhpc3RpbmcgcGF0Y2gsIGJ1dCB0aGUgcGF0Y2hlcyBJJ3ZlIHBvc3RlZCBkbyBpbmRlZWQgd29y
ayBpbiBteSB0ZXN0aW5nLg0KDQpJIGFwcHJlY2lhdGUgdGhlIHBhdGNoZXMuICBJIGJsYW1lIHNv
bWV0aGluZyBoZXJlLg0KDQpUaGUgcGF0Y2hlcyBkb27igJl0IHQgYXBwbHkgY2xlYW5seSB0byBn
aXQtMi4yLjEgb3IgdG8gdGhlIGxhdGVzdCBnaXQgc291cmNlIEkganVzdCBjbG9uZWQuICBJIGhh
ZCB0byBjb3B5L3Bhc3RlIHNvbWUgdHdvIGNodW5rcyBpbiBodHRwLmMgYW5kIGV2ZXJ5dGhpbmcg
aW4gcmVtb3RlLWN1cmwuYy4NCg0KTG9va2luZyBhdCB0aGUgc291cmNlLCB0aGUgcGxhY2UgdG8g
cGF0Y2ggaXMgdGhlcmUsIGp1c3Qgb24gYSBkaWZmZXJlbnQgbGluZSBudW1iZXIuDQoNCltkdmxA
cG9ydGVyOTMgL3Vzci9wb3J0cy9kZXZlbC9naXQvd29yay9naXQtMi4yLjFdJCBzdWRvIHBhdGNo
IDwgfmR2bC9wYXRjaDIudHh0DQpIbW0uLi4gIExvb2tzIGxpa2UgYSB1bmlmaWVkIGRpZmYgdG8g
bWUuLi4NClRoZSB0ZXh0IGxlYWRpbmcgdXAgdG8gdGhpcyB3YXM6DQotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KfGRpZmYgLS1naXQgYS9odHRwLmMgYi9odHRwLmMNCnxpbmRleCAwNDBmMzYy
Li44MTUxOTRkIDEwMDY0NA0KfC0tLSBhL2h0dHAuYw0KfCsrKyBiL2h0dHAuYw0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NClBhdGNoaW5nIGZpbGUgaHR0cC5jIHVzaW5nIFBsYW4gQS4uLg0K
SHVuayAjMSBzdWNjZWVkZWQgYXQgNjIuDQpIdW5rICMyIHN1Y2NlZWRlZCBhdCA5ODggd2l0aCBm
dXp6IDIuDQpIdW5rICMzIGZhaWxlZCBhdCAxMDQ3Lg0KSHVuayAjNCBmYWlsZWQgYXQgMTE1NC4N
CjIgb3V0IG9mIDQgaHVua3MgZmFpbGVkLS1zYXZpbmcgcmVqZWN0cyB0byBodHRwLmMucmVqDQpI
bW0uLi4gIFRoZSBuZXh0IHBhdGNoIGxvb2tzIGxpa2UgYSB1bmlmaWVkIGRpZmYgdG8gbWUuLi4N
ClRoZSB0ZXh0IGxlYWRpbmcgdXAgdG8gdGhpcyB3YXM6DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KfGRpZmYgLS1naXQgYS9odHRwLmggYi9odHRwLmgNCnxpbmRleCA0NzMxNzliLi43MTk0
M2QzIDEwMDY0NA0KfC0tLSBhL2h0dHAuaA0KfCsrKyBiL2h0dHAuaA0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NClBhdGNoaW5nIGZpbGUgaHR0cC5oIHVzaW5nIFBsYW4gQS4uLg0KSHVuayAj
MSBzdWNjZWVkZWQgYXQgOTggd2l0aCBmdXp6IDIuDQpIdW5rICMyIHN1Y2NlZWRlZCBhdCAxMTQu
DQpIbW0uLi4gIFRoZSBuZXh0IHBhdGNoIGxvb2tzIGxpa2UgYSB1bmlmaWVkIGRpZmYgdG8gbWUu
Li4NClRoZSB0ZXh0IGxlYWRpbmcgdXAgdG8gdGhpcyB3YXM6DQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KfGRpZmYgLS1naXQgYS9yZW1vdGUtY3VybC5jIGIvcmVtb3RlLWN1cmwuYw0KfGlu
ZGV4IGRkNjNiYzIuLjRjYTU0NDcgMTAwNjQ0DQp8LS0tIGEvcmVtb3RlLWN1cmwuYw0KfCsrKyBi
L3JlbW90ZS1jdXJsLmMNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpQYXRjaGluZyBmaWxl
IHJlbW90ZS1jdXJsLmMgdXNpbmcgUGxhbiBBLi4uDQpIdW5rICMxIGZhaWxlZCBhdCA0NjcuDQpI
dW5rICMyIGZhaWxlZCBhdCA1MTMuDQpIdW5rICMzIGZhaWxlZCBhdCA1MzguDQpIdW5rICM0IGZh
aWxlZCBhdCA2MjUuDQo0IG91dCBvZiA0IGh1bmtzIGZhaWxlZC0tc2F2aW5nIHJlamVjdHMgdG8g
cmVtb3RlLWN1cmwuYy5yZWoNCmRvbmUNCg0KDQo+PiBCZWZvcmUgSSBmbG9vZCB0aGUgbGlzdCB3
aXRoIGRlYnVnIHJ1bnMsIEkgd2FudGVkIHRvIG1ha2Ugc3VyZSBJIHdhcyB0ZXN0aW5nIHdpdGgg
YW4gYXBwcm9wcmlhdGUgY29uZmlndXJhdGlvbjoNCj4+IA0KPj4gPExvY2F0aW9uIC9naXQ+DQo+
PiBTU0xPcHRpb25zICtTdGRlbnZWYXJzDQo+PiBPcHRpb25zICtFeGVjQ0dJICtGb2xsb3dTeW1M
aW5rcyArU3ltTGlua3NJZk93bmVyTWF0Y2gNCj4+IA0KPj4gICMgQnkgZGVmYXVsdCwgYWxsb3cg
YWNjZXNzIHRvIGFueW9uZS4NCj4+ICBPcmRlciBhbGxvdyxkZW55DQo+PiAgQWxsb3cgZnJvbSBB
bGwNCj4+IA0KPj4gICMgRW5hYmxlIEtlcmJlcm9zIGF1dGhlbnRpY2F0aW9uIHVzaW5nIG1vZF9h
dXRoX2tlcmIuDQo+PiBBdXRoVHlwZSAgICAgICAgICAgS2VyYmVyb3MNCj4+IEF1dGhOYW1lICAg
ICAgICAgICDigJx1cy5leGFtcGxlLm9yZyINCj4+IEtyYkF1dGhSZWFsbXMgICAgICB1cy5leGFt
cGxlLm9yZw0KPj4gIyBJIGhhdmUgdHJpZWQgYm90aCB3aXRoIGFuZCB3aXRob3V0IHRoZSBmb2xs
b3dpbmcgbGluZToNCj4+IEtyYlNlcnZpY2VOYW1lICAgICBIVFRQL3VzLmV4YW1wbGUub3JnDQo+
PiBLcmI1S2V5dGFiICAgICAgICAgL3Vzci9sb2NhbC9ldGMvYXBhY2hlMjIvcmVwby10ZXN0Lmtl
eXRhYg0KPj4gIEtyYk1ldGhvZE5lZ290aWF0ZSBvbg0KPj4gIEtyYlNhdmVDcmVkZW50aWFscyBv
bg0KPj4gIEtyYlZlcmlmeUtEQyBvbg0KPj4gIEtyYlNlcnZpY2VOYW1lIEFueQ0KPj4gIyBJIGhh
dmUgdHJpZWQgd2l0aCBhbmQgd2l0aG91dCB0aGlzIGxpbmU6DQo+PiBLcmJNZXRob2RrNVBhc3N3
ZCAgb24NCj4+ICBSZXF1aXJlIHZhbGlkLXVzZXINCj4+IDwvTG9jYXRpb24+DQo+IA0KPiBJJ20g
bm90IHN1cmUgd2h5IGl0J3Mgbm90IHdvcmtpbmcgZm9yIHlvdS4gIEhlcmUncyBhIHNuaXBwZXQg
ZnJvbSBteSBjb25maWc6DQo+IA0KPiBTZXRFbnYgR0lUX0hUVFBfRVhQT1JUX0FMTCAxDQo+IFNl
dEVudiBSRU1PVEVfVVNFUiAkUkVESVJFQ1RfUkVNT1RFX1VTRVINCj4gQXV0aFR5cGUgS2VyYmVy
b3MNCj4gQXV0aE5hbWUgIktlcmJlcm9zIExvZ2luIg0KPiBLcmJNZXRob2ROZWdvdGlhdGUgb24N
Cj4gS3JiTWV0aG9kSzVQYXNzd2Qgb2ZmDQo+IEtyYkF1dGhSZWFsbXMgQ1JVU1RZVE9PVEhQQVNU
RS5ORVQNCj4gS3JiNUtleXRhYiAvZXRjL2tyYjUuYXBhY2hlLmtleXRhYg0KPiANCj4gV2hlbiBJ
IHdhcyB0ZXN0aW5nLCBJIHNldCBLcmJNZXRob2RLNVBhc3N3ZCB0byBvbiBhbmQgaXQgZGlkIGlu
IGZhY3Qgd29yay4gIEknbSB1c2luZyBEZWJpYW4ncyBBcGFjaGUgMi40LjEwLTkgd2l0aCBtb2Rf
YXV0aF9rZXJiIDUuNC0yLjIuDQoNClRoYXQgZGlkbuKAmXQgc2VlbSB0byBoZWxwLCBidXQgcGVy
aGFwcyB0aGUgcGF0Y2hpbmcgaXMgdGhlIGlzc3VlLg0KDQoNCg0K
