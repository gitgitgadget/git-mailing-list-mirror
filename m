From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Wed, 11 Mar 2015 19:33:05 +0000
Message-ID: <68DFACB3-5EA7-4414-9B74-B4E6F6A417B9@cisco.com>
References: <1420676960-492860-1-git-send-email-sandals@crustytoothpaste.net>
 <7930FE25-8206-43A8-9678-C56D789E09CE@cisco.com>
 <xmqqk30hyock.fsf@gitster.dls.corp.google.com>
 <CA01B76E-F3D4-40AC-B524-32BFBA930108@cisco.com>
 <xmqqa90cxg89.fsf@gitster.dls.corp.google.com>
 <1B14107C-FC87-4F69-AEBE-9EA1BAF50A17@cisco.com>
 <20150219203556.GC5021@vauxhall.crustytoothpaste.net>
 <ABA76895-9BD2-4EA8-B765-0F9DE71A2CEC@cisco.com>
 <3E5DD2BE-1E44-4D0A-89A1-627A1239C72A@cisco.com>
 <E53D99DB-E894-4FA8-9351-39E23FFD677E@cisco.com>
 <20150310222907.GA36141@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 20:33:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVmNc-0008FX-HU
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 20:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbbCKTdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 15:33:14 -0400
Received: from alln-iport-3.cisco.com ([173.37.142.90]:60048 "EHLO
	alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbbCKTdH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 15:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2682; q=dns/txt; s=iport;
  t=1426102387; x=1427311987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aFH6D9VUIyrmRMy3bHSGh6fC59VWFH8anQo7vY6KKks=;
  b=mSumLoysDkMpPF/94Cnv6ffbV/cMy3dP/f94i2DkS81OUN3vIdFqk58C
   YEgim0kZnMxVuy0qM0Mf4Zd2+HGNInUmy3YR/a8Q4itubdt2YJxjRB7Hs
   63Tq400mbPQACW76CL8rcNa/o+/wF5eLQC/G5HeNu+ysVmFdQNjMKrRyr
   U=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A0D+CAAOmABV/4MNJK1cgwZSWgSDB7pdhX+FcAIcgSBMAQEBAQEBfYQPAQEBAwEjEUUFCwIBCBgCAhQSAgICMBUQAgQOBYgnCA2tfZskAQEBAQEBAQEBAQEBAQEBAQEBAQEBEwSBIYl2gmGBSxIzBxiCUC+BFgWOGYIDg2iFdYEajxqDRSOCAhyBUG8BgUN/AQEB
X-IronPort-AV: E=Sophos;i="5.11,383,1422921600"; 
   d="scan'208";a="131100748"
Received: from alln-core-1.cisco.com ([173.36.13.131])
  by alln-iport-3.cisco.com with ESMTP; 11 Mar 2015 19:33:07 +0000
Received: from xhc-rcd-x03.cisco.com (xhc-rcd-x03.cisco.com [173.37.183.77])
	by alln-core-1.cisco.com (8.14.5/8.14.5) with ESMTP id t2BJX6pS022545
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 11 Mar 2015 19:33:06 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.151]) by
 xhc-rcd-x03.cisco.com ([173.37.183.77]) with mapi id 14.03.0195.001; Wed, 11
 Mar 2015 14:33:06 -0500
Thread-Topic: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Thread-Index: AQHQSwqcFAV48lOUvEGHDNPe7JHDHZz2+1uAgAHaeICAB+NbAIABkSyAgBQtCoCAAEmXAIABYSQA
In-Reply-To: <20150310222907.GA36141@vauxhall.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [64.100.213.143]
Content-ID: <841AE1D99EFDD449A25538423978BD58@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265332>

PiBPbiBNYXIgMTAsIDIwMTUsIGF0IDY6MjkgUE0sIGJyaWFuIG0uIGNhcmxzb24gPHNhbmRhbHNA
Y3J1c3R5dG9vdGhwYXN0ZS5uZXQ+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBNYXIgMTAsIDIwMTUg
YXQgMDY6MDU6NDZQTSArMDAwMCwgRGFuIExhbmdpbGxlIChkYWxhbmdpbCkgd3JvdGU6DQo+Pj4g
V2UgaGF2ZSBtYWRlIHByb2dyZXNzIEkgdGhpbmsuDQo+Pj4gDQo+Pj4gV2l0aCBzdG9jayBnaXQ6
DQo+Pj4gDQo+Pj4gdGw7ZHI6IDEgLSB3aXRoIGEgdGlja2V0LCB5b3UgZ2V0IHByb21wdGVkLCBi
dXQgaGl0dGluZyBFTlRFUiBzdWNjZWVkcy4NCj4+PiAgICAgIDIgLSB3aXRob3V0IGEgdGlja2V0
LCBub3RoaW5nIHdvcmtzDQo+Pj4gDQo+Pj4gDQo+Pj4gV2l0aCBwYXRjaGVkIGdpdDoNCj4+PiAN
Cj4+PiB0bDtkcjogMSAtIHdpdGggYSB0aWNrZXQsICAgIGVudGVyaW5nIGNyZWRlbnRpYWxzLCBT
VUNDRUVEUzsganVzdCBoaXQgZW50ZXIsIGZhaWx1cmUNCj4+IA0KPj4gSWYgSSBoYXZlIGEgdmFs
aWQgdGlja2V0LCB3aHkgYW0gSSBiZWluZyBwcm9tcHRlZCBmb3IgY3JlZGVudGlhbHM/DQo+IA0K
PiBsaWJjdXJsIHdvbid0IGV2ZW4gYXR0ZW1wdCBhdXRoZW50aWNhdGlvbiBpZiB5b3UgZG9uJ3Qg
aGF2ZSBhIHVzZXJuYW1lDQo+IHNwZWNpZmllZC4gIEkga25vdyB0aGF0IHRoZSB3ZWIgc2VydmVy
IHNob3VsZCBiZSBhYmxlIHRvIGZpZ3VyZSBpdCBvdXQNCj4gZnJvbSB5b3VyIGNyZWRlbnRpYWxz
LCBzbyBpdCBzaG91bGRuJ3QgbWF0dGVyIHdoYXQgdXNlcm5hbWUgeW91IHByb3ZpZGUuDQo+IFRo
aXMgaXMgYW4gdW5mb3J0dWF0ZSBxdWlyayBvZiBsaWIgY3VybC4NCg0KSSB1bmRlcnN0YW5kLg0K
DQo+IEFsc28sIGFyZSB5b3UgdXNpbmcgMi4zLjAsIG9yIG9uZSBvZiB0aGUgZWFybGllciBwYXRj
aGVkIHZlcnNpb25zPyAgVGhhdA0KPiBtaWdodCBhZmZlY3QgaG93IGl0IHdvcmtzLg0KDQpJIGFt
IHVzaW5nIGdpdC0yLjMuMA0KDQo+PiBJdCBhcHBlYXJzIHBhdGNoZWQgZ2l0IGFsd2F5cyB3YW50
cyBjcmVkZW50aWFscyBlbnRlcmVkIGFuZCBpZ25vcmVzIHRoZQ0KPj4gdmFsaWQgdGlja2V0Lg0K
PiANCj4gU28gd2hhdCBJIHRoaW5rIGlzIGhhcHBlbmluZyBpcyB0aGF0IHlvdSBkaWRuJ3Qgc3Bl
Y2lmeSBhIHVzZXJuYW1lLCBidXQNCj4gZ2l0IGdvdCBhIDQwMSwgc28gaXQgcHJvbXB0ZWQuICBO
b3cgaXQgYWN0dWFsbHkgYXR0ZW1wdHMgdG8gdXNlIHRoZQ0KPiBwYXNzd29yZCB5b3UgcHJvdmlk
ZWQsIHdoZXJlYXMgYmVmb3JlIGl0IGRpZCBub3QuDQo+IA0KPiBEb2VzIGl0IHdvcmsgd2l0aCBh
IHRpY2tldCBpZiB5b3Ugc3BlY2lmeSBhIHVzZXJuYW1lLCBhcyBpbiB0aGUNCj4gZm9sbG93aW5n
IFVSTD8NCj4gaHR0cHM6Ly9ibWNAZ2l0LmNydXN0eXRvb3RocGFzdGUubmV0L2dpdC9ibWMvaG9t
ZWRpci5naXQNCg0KWWVzLCB0aGF0IGRvZXMgd29yay4gIE91ciBwcm9qZWN0IGlzIDk4JSBvZiB0
aGUgd2F5IHRoZXJlIG5vdy4gDQoNCkkgbG9va2VkIGF0IGJvdGggbGliY3VybCBhbmQgZ2l0IGVu
dmlyb25tZW50IHZhcmlhYmxlcyB0byBzZWUgaWYgdGhlcmUNCndhcyBhIHdheSB0byBzcGVjaWZ5
IHRoZSB1c2VyIHdpdGhvdXQgcHV0dGluZyBpdCBpbiB0aGUgVVJMLiAgSSBkaWRu4oCZdCBzZWUg
b25lLg0KDQpNeSBuZXh0IHN0ZXAgaXMgdGhlIGdpdCBjb25maWd1cmF0aW9uLCBlaXRoZXIgc2Vy
dmVyIG9yIGNsaWVudC4gIERvIHlvdSBrbm93IA0KaWYgSSBzaG91bGQgc3RvcCBsb29raW5nIG5v
dyBiZWNhdXNlIGl04oCZcyBub3QgdGhlcmU/DQoNClRoYW5rIHlvdSBmb3IgeW91ciBoZWxwIGlu
IGdldHRpbmcgdXMgdGhpcyBmYXIuICBUaGlzIGhlbHBzIHVzIHRyZW1lbmRvdXNseS4NCg0K4oCU
IA0KRGFuIExhbmdpbGxlDQpJbmZyYXN0cnVjdHVyZSAmIE9wZXJhdGlvbnMNClRhbG9zIEdyb3Vw
DQpTb3VyY2VmaXJlLCBJbmMuDQo=
