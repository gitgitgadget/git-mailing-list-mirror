From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Tue, 17 Feb 2015 23:05:41 +0000
Message-ID: <CA01B76E-F3D4-40AC-B524-32BFBA930108@cisco.com>
References: <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
 <1420676960-492860-1-git-send-email-sandals@crustytoothpaste.net>
 <7930FE25-8206-43A8-9678-C56D789E09CE@cisco.com>
 <xmqqk30hyock.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 00:05:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNrDA-0002rN-Q5
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 00:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbbBQXFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 18:05:44 -0500
Received: from alln-iport-5.cisco.com ([173.37.142.92]:2423 "EHLO
	alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbbBQXFo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 18:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1356; q=dns/txt; s=iport;
  t=1424214344; x=1425423944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e8T6vGsUcWN2L+UkNh4U1//FSLhFGtC3hzZCHg00BC0=;
  b=DzDfegMgmeqvbAg/ojxRv7PdosHQYAMOeJFj3r1n5XhzjABOw1TsE5wB
   5w2NciG3NyU+F0+2OshCNFASmx0TjYUiNkC22FuN4TJFrdV+JYlzKeB/M
   CiZWTpQ+6Z7Hju+Tr+fbol0QD7s0yiZMKF1YYkShnWV2w6PzOn5dtjjQT
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A0CFBQDqyONU/4UNJK1bgwZSWgSCf79QhTY5Ahx+QwEBAQEBAXyEDAEBAQMBIxFFBQsCAQgYAgImAgICMBUQAgQOBYgnCA25QJdxAQEBAQEBAQEBAQEBAQEBAQEBAQEBEwSBIYluhDszB4JoLoEUBY84g1eFYIEYjjeDPiKCAhyBUG8FgT9/AQEB
X-IronPort-AV: E=Sophos;i="5.09,595,1418083200"; 
   d="scan'208";a="124500748"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by alln-iport-5.cisco.com with ESMTP; 17 Feb 2015 23:05:42 +0000
Received: from xhc-rcd-x10.cisco.com (xhc-rcd-x10.cisco.com [173.37.183.84])
	by alln-core-11.cisco.com (8.14.5/8.14.5) with ESMTP id t1HN5gKC026678
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 17 Feb 2015 23:05:42 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.147]) by
 xhc-rcd-x10.cisco.com ([173.37.183.84]) with mapi id 14.03.0195.001; Tue, 17
 Feb 2015 17:05:42 -0600
Thread-Topic: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Thread-Index: AQHQNRBRFAV48lOUvEGHDNPe7JHDHZz2BsKA
In-Reply-To: <xmqqk30hyock.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [64.100.213.185]
Content-ID: <7E4984560D814D49BEFAC1D30D016BAE@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263997>

PiBPbiBKYW4gMjAsIDIwMTUsIGF0IDc6MjIgUE0sIEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBv
Ym94LmNvbT4gd3JvdGU6DQo+IA0KPiAiRGFuIExhbmdpbGxlIChkYWxhbmdpbCkiIDxkYWxhbmdp
bEBjaXNjby5jb20+IHdyaXRlczoNCj4gDQo+PiBJIGRpZCBub3QgdGVzdCB0aGlzIHBhdGNoLiAg
SXMgdGhhdCBob2xkaW5nIHVwIGEgY29tbWl0Pw0KPiANCj4gSSBhbSBob3BpbmcgdGhhdCB5b3Ug
cmVidWlsdCB0aGUgR2l0IHlvdSB1c2Ugd2l0aCB0aGlzIHBhdGNoIGJ5IHRoZQ0KPiB0aW1lIHlv
dSB3cm90ZSB0aGUgbWVzc2FnZSBJIGFtIHJlc3BvbmRpbmcgdG8gYW5kIGhhdmUgYmVlbiB1c2lu
ZyBpdA0KPiBmb3IgeW91ciBkYWlseSBHaXQgbmVlZHMgOy0pDQo+IA0KPiBJIGJlbGlldmUgaXQg
aXMgcXVldWVkIG9uIHRoZSAnbmV4dCcgYnJhbmNoIHNvIHRoYXQgb3RoZXJzIGxpa2UgeW91DQo+
IHdobyBuZWVkIHRoZSBjaGFuZ2UgY2FuIHZlcmlmeSB0aGUgaW1wcm92ZW1lbnRzLCBhbmQgb3Ro
ZXJzIHVubGlrZQ0KPiB5b3Ugd2hvIGRvIG5vdCBuZWVkIHRoZSBjaGFuZ2UgY2FuIG1ha2Ugc3Vy
ZSB0aGUgY2hhbmdlIGRvZXMgbm90DQo+IGNhdXNlIHVuaW50ZW5kZWQgY29uc2VxdWVuY2VzLg0K
DQpJcyB0aGlzIHRoZSBwYXRjaCBpbiBxdWVzdGlvbj8NCg0KIGh0dHBzOi8vZ2l0aHViLmNvbS9n
aXQvZ2l0L2NvbW1pdC80ZGJlNjY0NjRiNGZkNjk1YzU5ODljYzI3MmZhMGVkZDY0NzUwMzdjDQoN
CkkgYXNrIGJlY2F1c2UgcHJldmlvdXMgdmVyc2lvbnMgb2YgdGhlIHBhdGNoIGFjdGVkIGFnYWlu
c3QgaHR0cC5oIGFzIHdlbGwgYW5kIG15IGZhaWx1cmUgd2l0aCBpdC4NCg0KQ291bGQgSSBleHBl
Y3QgdGhhdCBwYXRjaCB3b3JrIGFnYWluc3QgMi4zLjA/DQoNCkl0IGFwcGxpZXMgY2xlYW5seSwg
Y29tcGlsZXMsIGJ1dCBjb3JlcyB3aGVuIEkgdHJ5IGEg4oCYZ2l0IGNsb25l4oCZLiAgVW5tYXRj
aGVkIDIuMy4wIHN1Y2NlZWRzLg==
