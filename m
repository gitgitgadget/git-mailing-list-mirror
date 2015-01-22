From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Thu, 22 Jan 2015 14:47:21 +0000
Message-ID: <00E4CEA7-3ECC-41CD-A9BC-D7EAF56DCFDE@cisco.com>
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
X-From: git-owner@vger.kernel.org Thu Jan 22 15:47:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEJ2e-000484-Jo
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 15:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbbAVOrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 09:47:25 -0500
Received: from alln-iport-4.cisco.com ([173.37.142.91]:2373 "EHLO
	alln-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbbAVOrX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 09:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1170; q=dns/txt; s=iport;
  t=1421938044; x=1423147644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V8nFyECtlpszTM25jJs/FzcOSZ+00FYnmYMFawMjoRQ=;
  b=gz8+W8OHjz+ftwgK0XwTfAaW/mGozSoYFLcdpcm7C7N848QS3oyIIl4K
   2VCO6xOA0oyspIKmyN5aLpTpy158ZS05ZsNARxVSs5jcpCpiA68m9VDuY
   km3jyvqpzuNwV/QEsYe88BK2XjuPxNlS9xy1VWHdJfE2V7avss7F4NP3B
   A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmEFAL8MwVStJV2b/2dsb2JhbABagwaBKgSDAMkyAhx4QwEBAQEBfYQMAQEBAwEjEUUFCwIBCBgCAiYCAgIwFRACBA4FiCQIviuUVQEBAQEBAQEBAQEBAQEBAQEBAQEBAReBIY4lMweCaC6BEwEEjQaBYIkZgRSNZIM9IoNub4FFfgEBAQ
X-IronPort-AV: E=Sophos;i="5.09,449,1418083200"; 
   d="scan'208";a="116597847"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by alln-iport-4.cisco.com with ESMTP; 22 Jan 2015 14:47:22 +0000
Received: from xhc-rcd-x07.cisco.com (xhc-rcd-x07.cisco.com [173.37.183.81])
	by rcdn-core-4.cisco.com (8.14.5/8.14.5) with ESMTP id t0MElMjV003416
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 22 Jan 2015 14:47:22 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.219]) by
 xhc-rcd-x07.cisco.com ([173.37.183.81]) with mapi id 14.03.0195.001; Thu, 22
 Jan 2015 08:47:21 -0600
Thread-Topic: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Thread-Index: AQHQNRBRFAV48lOUvEGHDNPe7JHDHZzMnxwA
In-Reply-To: <xmqqk30hyock.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.82.250.33]
Content-ID: <0FD90355E2E4924F8073468013E3CA3F@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262838>

PiBPbiBKYW4gMjAsIDIwMTUsIGF0IDc6MjIgUE0sIEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBv
Ym94LmNvbT4gd3JvdGU6DQo+IA0KPiAiRGFuIExhbmdpbGxlIChkYWxhbmdpbCkiIDxkYWxhbmdp
bEBjaXNjby5jb20+IHdyaXRlczoNCj4gDQo+PiBJIGRpZCBub3QgdGVzdCB0aGlzIHBhdGNoLiAg
SXMgdGhhdCBob2xkaW5nIHVwIGEgY29tbWl0Pw0KPiANCj4gSSBhbSBob3BpbmcgdGhhdCB5b3Ug
cmVidWlsdCB0aGUgR2l0IHlvdSB1c2Ugd2l0aCB0aGlzIHBhdGNoIGJ5IHRoZQ0KPiB0aW1lIHlv
dSB3cm90ZSB0aGUgbWVzc2FnZSBJIGFtIHJlc3BvbmRpbmcgdG8gYW5kIGhhdmUgYmVlbiB1c2lu
ZyBpdA0KPiBmb3IgeW91ciBkYWlseSBHaXQgbmVlZHMgOy0pDQoNClBhdGNoIHYyIGhhcyBiZWVu
IHVzZWQgaW4gb3VyIHRlc3QgZW52aXJvbm1lbnQgd2l0aCBzdWNjZXNzLiAgSSBnb3QgZGl2ZXJ0
ZWQgdG8gb3RoZXIgcHJvamVjdHMgYmVmb3JlIEkgY291bGQgdGVzdCBQYXRjaCB2My4NCg0KPiBJ
IGJlbGlldmUgaXQgaXMgcXVldWVkIG9uIHRoZSAnbmV4dCcgYnJhbmNoIHNvIHRoYXQgb3RoZXJz
IGxpa2UgeW91DQo+IHdobyBuZWVkIHRoZSBjaGFuZ2UgY2FuIHZlcmlmeSB0aGUgaW1wcm92ZW1l
bnRzLCBhbmQgb3RoZXJzIHVubGlrZQ0KPiB5b3Ugd2hvIGRvIG5vdCBuZWVkIHRoZSBjaGFuZ2Ug
Y2FuIG1ha2Ugc3VyZSB0aGUgY2hhbmdlIGRvZXMgbm90DQo+IGNhdXNlIHVuaW50ZW5kZWQgY29u
c2VxdWVuY2VzLg0KDQpUaGFuayB5b3UuDQoNCuKAlCANCkRhbiBMYW5naWxsZQ0KSW5mcmFzdHJ1
Y3R1cmUgJiBPcGVyYXRpb25zDQpUYWxvcyBHcm91cA0KU291cmNlZmlyZSwgSW5jLg0KDQoNCg==
