From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Tue, 24 Feb 2015 21:03:32 +0000
Message-ID: <ABA76895-9BD2-4EA8-B765-0F9DE71A2CEC@cisco.com>
References: <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
 <1420676960-492860-1-git-send-email-sandals@crustytoothpaste.net>
 <7930FE25-8206-43A8-9678-C56D789E09CE@cisco.com>
 <xmqqk30hyock.fsf@gitster.dls.corp.google.com>
 <CA01B76E-F3D4-40AC-B524-32BFBA930108@cisco.com>
 <xmqqa90cxg89.fsf@gitster.dls.corp.google.com>
 <1B14107C-FC87-4F69-AEBE-9EA1BAF50A17@cisco.com>
 <20150219203556.GC5021@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 22:03:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQMdo-0001fM-Gf
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 22:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbbBXVDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 16:03:36 -0500
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:3188 "EHLO
	rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbbBXVDf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 16:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1478; q=dns/txt; s=iport;
  t=1424811815; x=1426021415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uFC+bloXxVdz2vQCFtUkHh7loJmT8aApF5gSjtwyT0o=;
  b=jkuyvCuF2LR6RUwvwT/8eD8MHdlEM3tJSZloLY2kWggq689GdrFuqH0w
   Ez/JWMBqHPLjGCNqIBlxSjxQLETJPJK5vDDhWGd/qgQqYRE6lsB5xAw4y
   ZREWF1pbnI3INCkNTcEOJxUL72v6wUMoFDnyAmL8TwKNLb8Ye96dICCXZ
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A0CQBQCX5uxU/5JdJa1bgwZSWgSDBLomhW6FdAIcgRNDAQEBAQEBfIQPAQEBAwEjEUUFCwIBCBgCAiYCAgIwFRACBA4FiCcIvAWYfQEBAQEBAQEBAQEBAQEBAQEBAQEBARMEgSGJcoQ7MweCaC+BFAEEj1uDYIVlkzsig25vgUR/AQEB
X-IronPort-AV: E=Sophos;i="5.09,641,1418083200"; 
   d="scan'208";a="398860099"
Received: from rcdn-core-10.cisco.com ([173.37.93.146])
  by rcdn-iport-4.cisco.com with ESMTP; 24 Feb 2015 21:03:34 +0000
Received: from xhc-aln-x15.cisco.com (xhc-aln-x15.cisco.com [173.36.12.89])
	by rcdn-core-10.cisco.com (8.14.5/8.14.5) with ESMTP id t1OL3Xm1001209
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 24 Feb 2015 21:03:34 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.147]) by
 xhc-aln-x15.cisco.com ([173.36.12.89]) with mapi id 14.03.0195.001; Tue, 24
 Feb 2015 15:03:33 -0600
Thread-Topic: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Thread-Index: AQHQSwqcFAV48lOUvEGHDNPe7JHDHZz2+1uAgAHaeICAB+NbAA==
In-Reply-To: <20150219203556.GC5021@vauxhall.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [64.100.213.175]
Content-ID: <21F77231B57D1F42BE825FEBA593A3CA@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264347>

PiBPbiBGZWIgMTksIDIwMTUsIGF0IDM6MzUgUE0sIGJyaWFuIG0uIGNhcmxzb24gPHNhbmRhbHNA
Y3J1c3R5dG9vdGhwYXN0ZS5uZXQ+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBGZWIgMTgsIDIwMTUg
YXQgMDQ6MTc6NDZQTSArMDAwMCwgRGFuIExhbmdpbGxlIChkYWxhbmdpbCkgd3JvdGU6DQo+PiBJ
IGp1c3QgYnVpbHQgZnJvbSDigJhtYXN0ZXLigJksIG9uIEZyZWVCU0QgOS4zOg0KPj4gDQo+PiBj
ZCB+L3NyYw0KPj4gZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHViLmNvbS9naXQvZ2l0LmdpdA0KPj4g
Y2QgZ2l0DQo+PiBnbWFrZQ0KPj4gDQo+PiBUaGVuIHRyaWVkIH4vc3JjL2dpdC9naXQgY2xvbmUg
aHR0cHM6Ly9PVVJfUkVQTw0KPj4gDQo+PiBJdCBjb3JlcyB0b28sIGFuZCBJIHNlZTogZ2l0LXJl
bW90ZS1odHRwcy5jb3JlDQo+IA0KPiBDYW4geW91IGNvbXBpbGUgd2l0aCBkZWJ1Z2dpbmcgc3lt
Ym9scyBhbmQgcHJvdmlkZSBhIGJhY2t0cmFjZT8gIEknbSBub3QgDQo+IHNlZWluZyBhbnkgc3Vj
aCBiZWhhdmlvciBvbiBteSBlbmQsIGFuZCBJJ20gbm90IHN1cmUgd2hldGhlciBpdCdzIG15IA0K
PiBwYXRjaCBvciBzb21ldGhpbmcgZWxzZSB0aGF0IG1pZ2h0IGJlIHByZXNlbnQgaW4gbWFzdGVy
Lg0KDQpUaGUgcHJvYmxlbSBvcmlnaW5hbGx5IG9jY3VycmVkIHVuZGVyIFZNd2FyZSBGdXNpb24g
YW5kIEnigJltIHVuYWJsZSB0byBnZXQgYSBiYWNrdHJhY2UgZnJvbSBpdC4NCkkgc3VzcGVjdCBt
ZW1vcnkgY29uc3RyYWludHMgYXJlIGEgZmFjdG9yLiAgVGhlcmXigJlzIG9ubHkgNUdCIFJBTSBh
dmFpbGFibGUgdG8gdGhpcyBWTS4NCg0KSSBoYXZlIHRyaWVkIGluIGFub3RoZXIgVk0gYW5kIHRo
YXQgc3VjY2VlZHMuICBBbGwgZ29vZCB0aGVyZS4gSXQgaGFzIDQwR0IgUkFNLg0KDQpJIGFtIGdv
aW5nIHRvIHRyeSB0aGlzIG9uIGEgdGhpcmQgc3lzdGVtLiBBdCBwcmVzZW50LCB3ZeKAmXJlIGp1
c3QgNTAvNTAgb24gc3VjY2Vzcy4NCg0K4oCUIA0KRGFuIExhbmdpbGxlDQpJbmZyYXN0cnVjdHVy
ZSAmIE9wZXJhdGlvbnMNClRhbG9zIEdyb3VwDQpTb3VyY2VmaXJlLCBJbmMuDQoNCg0KDQo=
