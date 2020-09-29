Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFC6C4727D
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 23:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0392158C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 23:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Id5wrCP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgI2XHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 19:07:13 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:56668 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgI2XHM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 19:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601420832; x=1632956832;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=DMrLU58AXF+W/Yx/0m04Qr8Wk56Y6CQ6EOYf2GOL6A8=;
  b=Id5wrCP9CfcutRE5Pb3tern2lNDKPg29oe6Z/4j+HcMEq4D+S32cjCux
   lGyKOgjCcuDtB4Gvyhm02GRUmv8n5rAehZnVlS1f5ATZ3kG/m+BSTQizE
   rGv54BoDPRlGgBDCvNytK/XL9u7785aJvHp5kZZUDV+p52Im2t6fS1vj9
   Y=;
X-IronPort-AV: E=Sophos;i="5.77,320,1596499200"; 
   d="scan'208";a="79068702"
Subject: Re: Question About Git V2 Protocol & SHA256
Thread-Topic: Question About Git V2 Protocol & SHA256
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 29 Sep 2020 23:07:09 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id 3FE95A1F00;
        Tue, 29 Sep 2020 23:07:07 +0000 (UTC)
Received: from EX13D20UWA001.ant.amazon.com (10.43.160.34) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 29 Sep 2020 23:07:06 +0000
Received: from EX13D20UWA003.ant.amazon.com (10.43.160.97) by
 EX13D20UWA001.ant.amazon.com (10.43.160.34) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 29 Sep 2020 23:07:06 +0000
Received: from EX13D20UWA003.ant.amazon.com ([10.43.160.97]) by
 EX13D20UWA003.ant.amazon.com ([10.43.160.97]) with mapi id 15.00.1497.006;
 Tue, 29 Sep 2020 23:07:06 +0000
From:   "Wu, Zhichen" <zhwu@amazon.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Thread-Index: AQHWlf5ecO6oUvIkOE6Oo7T8lc6CpKmAL3KAgAAImAD//5EfgA==
Date:   Tue, 29 Sep 2020 23:07:06 +0000
Message-ID: <D510F2C4-1BCB-4DF7-9F36-17EA93FB7F99@amazon.com>
References: <9FC3DDB4-DE6F-45B3-95F9-1048991713A4@amazon.com>
 <20200929221311.GA15129@coredump.intra.peff.net>
 <20200929224356.GH1392312@camp.crustytoothpaste.net>
In-Reply-To: <20200929224356.GH1392312@camp.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <48890B3492D77B48AC362EA57C34CE32@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgQnJpYW4sDQoNClRoYW5rcyBmb3IgdGhlIGRldGFpbHMhDQoNCk5vdyBpdCBzb3VuZHMgbGlr
ZSBhbHRob3VnaCBTSEExL1NIQTI1NiBhbmQgdjEvdjIgYXJlIHNlcGFyYXRlIGZlYXR1cmVzLCB2
MiBjYXBhYmlsaXR5IGlzIHRoZSBvbmx5IHdheSBmb3IgdGhlIGNsaWVudCBhbmQgc2VydmVyIHRv
IG5lZ290aWF0ZSB0aGUgb2JqZWN0IGZvcm1hdCBzbyB0aGF0IHRoZXkgd29uJ3Qgc2VuZCBvdXQg
c29tZXRoaW5nIHRoYXQgaXMgbm90IHVuZGVyc3RhbmRhYmxlIGJ5IHRoZSBvdGhlciBwYXJ0eS4N
Cg0KSW4gdGhhdCBjYXNlLCBJIHRoaW5rIGl0J3Mgc3RpbGwgdmFsaWQgdGhhdCB2MiBuZWVkcyB0
byBiZSBzdXBwb3J0ZWQgZmlyc3Qgc28gdGhhdCBTSEEyNTYgY2FuIGxhdGVyIGJlIHN1cHBvcnRl
ZCB3aXRoIGVub3VnaCBmbGV4aWJpbGl0eS4NCg0KQmVzdHMsDQpaaGljaGVuDQoNCg0K77u/T24g
OS8yOS8yMCwgMzo0NSBQTSwgImJyaWFuIG0uIGNhcmxzb24iIDxzYW5kYWxzQGNydXN0eXRvb3Ro
cGFzdGUubmV0PiB3cm90ZToNCg0KICAgIE9uIDIwMjAtMDktMjkgYXQgMjI6MTM6MTEsIEplZmYg
S2luZyB3cm90ZToNCiAgICA+IE9uIFR1ZSwgU2VwIDI5LCAyMDIwIGF0IDAxOjE3OjU5QU0gKzAw
MDAsIFd1LCBaaGljaGVuIHdyb3RlOg0KICAgID4gPiAyLiBJIHNlZSB2MiBoYXMgYSBjYXBhYmls
aXR5IGNhbGxlZCDigJxvYmplY3QtZm9ybWF04oCdIHRoYXQgcHJvdmlkZXMgU0hBMQ0KICAgID4g
PiAgICBvcHRpb24uIEnigJltIHdvbmRlcmluZyBpZiB0aGF0IGNhcGFiaWxpdHkgd2lsbCBiZSB0
aGUgb25seSB3YXkgZm9yDQogICAgPiA+ICAgIGNsaWVudCBhbmQgc2VydmVyIHRvIHN0YXJ0IHVz
aW5nIFNIQTI1Nj8gT3IgcHV0IGl0IGFzIGFub3RoZXIgd29yZCwNCiAgICA+ID4gICAgd2lsbCB2
MiBwcm90b2NvbCBiZSB0aGUgcHJlcmVxdWlzaXRlIG9mIFNIQTI1Nj8NCiAgICA+IA0KICAgID4g
SSB0aGluayBpdCB3b3VsZCBiZSBpbXBvc3NpYmxlIHRvIGhhbmRsZSBvYmplY3QtZm9ybWF0IHZp
YSB2MSwgYmVjYXVzZQ0KICAgID4gdGhlIHYxIHByb3RvY29sIHdyaXRlcyB0aGUgcmVmIGFkdmVy
dGlzZW1lbnQgYmVmb3JlIGFueSBjYXBhYmlsaXRpZXMgYXJlDQogICAgPiBuZWdvdGlhdGVkLiBT
byBJIHRoaW5rIHYxIG11c3QgaW1wbGljaXRseSByZW1haW4gc2hhMS1vbmx5IChhbmQgYSBzaGEy
NTYNCiAgICA+IHJlcG9zaXRvcnkgb24gdGhlIHNlcnZlciBzaWRlIHdvdWxkIG5lZWQgdG8gZWl0
aGVyIHJlamVjdCBhIHYxIGNsaWVudCwNCiAgICA+IG9yIGJhY2stdHJhbnNsYXRlIGFzIGl0IHdv
dWxkIGZvciBhIHYyIGNsaWVudCB3aGljaCBhc2tzIGZvciBzaGExKS4NCg0KICAgIEkgZG9uJ3Qg
dGhpbmsgdGhhdCdzIHRoZSBjYXNlLiAgWW91IGNhbiBpbmRlZWQgdXNlIHYxIHdpdGggU0hBLTI1
NiwgYnV0DQogICAgaWYgeW91IGhhdmUgYSBTSEEtMS1vbmx5IEdpdCwgaXQgd2lsbCBjaG9rZSBi
ZWNhdXNlIHRoZSBvYmplY3QgSUQgaXMNCiAgICBsb25nZXIgdGhhbiBpdCBleHBlY3RzLiAgSWYg
eW91IHdhbnQgdG8gbmVnb3RpYXRlIHRoZSBhbGdvcml0aG0gd2hlbiB3ZQ0KICAgIHN1cHBvcnQg
Ym90aCBhbmQgdGhlIGNsaWVudCBjYW4ndCBkZWFsIHdpdGggdHJhbnNsYXRpbmcgdGhlIGluaXRp
YWwgcmVmDQogICAgYWR2ZXJ0aXNlbWVudCwgdGhlbiB5ZXMsIHlvdSdsbCBuZWVkIHYyLg0KDQog
ICAgV2UgZXZlbiBzdXBwb3J0IFNIQS0yNTYgdmlhIGJ1bmRsZXMgYW5kIHRoZSBEQVYtYmFzZWQg
SFRUUCBwcm90b2NvbCwgYnV0DQogICAgdGhlIGxhdHRlciB3aWxsIG5ldmVyIHN1cHBvcnQgbmVn
b3RpYXRpb24gb2YgaGFzaCBhbGdvcml0aG1zIGJlY2F1c2UNCiAgICBpdCdzIGJhc2VkIG9uIHN0
YXRpYyBmaWxlcy4NCg0KICAgIEl0IGlzIHJlcXVpcmVkIHRoYXQgeW91IHVuZGVyc3RhbmQgdGhl
IG9iamVjdC1mb3JtYXQgY2FwYWJpbGl0eSBvbiB0aGUNCiAgICBjbGllbnQgc2lkZSB0byBzdXBw
b3J0IFNIQS0yNTYsIHNpbmNlIGlmIHlvdSBmYWlsIHRvIGFubm91bmNlIGl0LCB0aGUNCiAgICBk
ZWZhdWx0IGlzIFNIQS0xLCBhbmQgcmlnaHQgbm93LCB0aGUgc2VydmVyIHNpZGUgd2lsbCBwcm9k
dWNlIGFuIGVycm9yDQogICAgaWYgdGhlIGNsaWVudCBkb2Vzbid0IGFubm91bmNlIGl0IChvciBz
ZW5kcyBTSEEtMSBkYXRhKS4NCiAgICAtLSANCiAgICBicmlhbiBtLiBjYXJsc29uOiBIb3VzdG9u
LCBUZXhhcywgVVMNCg0K
