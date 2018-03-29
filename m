Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3BA31F404
	for <e@80x24.org>; Thu, 29 Mar 2018 17:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeC2RZH (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 13:25:07 -0400
Received: from alln-iport-4.cisco.com ([173.37.142.91]:13218 "EHLO
        alln-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeC2RZG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 13:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=6718; q=dns/txt; s=iport;
  t=1522344306; x=1523553906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KStfGmFQNaYi1w2DRX3TzBxO3RFDxpB7xsgG7o2NXgE=;
  b=bVrLrTkUQqPBLvqhCXz30/Uh52p91yV+fKdRsozD04B5DSE3CIcO7PC7
   o4Hj6s++URapkzUiGe22zl2m+BWJlI8lA3Be9dfaua8zTCs97BtkKuke1
   BRoi2459IlQjvQXfyGMdO3vVUzUgb43AZ0Wkmvq3Jp+9MnP5ZHzmC9ybu
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DgAADjIL1a/4kNJK1eGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYMXK2FvKAqDUogAjQKBdIEPklEUgWYLG4RpAhqEACE0GAE?=
 =?us-ascii?q?CAQEBAQEBAmsohSUBAQEDASMRRRACAQgOCQMCFBICAgIdExUICAIEDgWFBQi?=
 =?us-ascii?q?tLYIchFWDaIIlBYEIhDyCGoITgS6CYoQ8ARIBB2aCMjCCJAKQQoZxCAIYhTe?=
 =?us-ascii?q?IW4Evhi+EVI9TAhETAYEkARw4YXFwFWQBghiCIBd6AQIGAY0Sb4xAFoEKgRc?=
 =?us-ascii?q?BAQ?=
X-IronPort-AV: E=Sophos;i="5.48,378,1517875200"; 
   d="scan'208";a="91326302"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by alln-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2018 17:25:06 +0000
Received: from XCH-RTP-018.cisco.com (xch-rtp-018.cisco.com [64.101.220.158])
        by alln-core-4.cisco.com (8.14.5/8.14.5) with ESMTP id w2THP5xp018894
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 29 Mar 2018 17:25:06 GMT
Received: from xch-rtp-020.cisco.com (64.101.220.160) by XCH-RTP-018.cisco.com
 (64.101.220.158) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 29 Mar
 2018 13:25:05 -0400
Received: from xch-rtp-020.cisco.com ([64.101.220.160]) by
 XCH-RTP-020.cisco.com ([64.101.220.160]) with mapi id 15.00.1320.000; Thu, 29
 Mar 2018 13:25:04 -0400
From:   "Erik Brady -X (brady - ROBERT HALF INTERNATIONAL INC at Cisco)" 
        <brady@cisco.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] credential: cred helper fast exit can cause SIGPIPE,
 crash
Thread-Topic: [PATCH] credential: cred helper fast exit can cause SIGPIPE,
 crash
Thread-Index: AQHTxuMUwLGE7nMRE0CaWOc3nJrwUqPnVNKA///w3QA=
Date:   Thu, 29 Mar 2018 17:25:04 +0000
Message-ID: <330BFBFA-6B9E-456D-A9B3-2D0EF5383A57@cisco.com>
References: <20180328222051.23684-1-brady@cisco.com>
 <20180329111915.GA30797@sigill.intra.peff.net>
In-Reply-To: <20180329111915.GA30797@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.24.61.214]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D3E3559574A9E43ADF73A9DEC7E37A8@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIEplZmYuDQoNCk9LLCB3aWxsIHJldHJ5IG9uIHRoZSBjb21tZW50LiAgSSBndWVzcyBJ
IG1pc3VuZGVyc3Rvb2QgdGhlIGd1aWRlbGluZXMgYSBiaXQgb24gdGhlIHNpZ25vZmYgYXMgd2Vs
bCAoaWU6IG5vbi1vcHRpb25hbCksIGFwb2xvZ2llcy4gIFdpbGwgcmVzdWJtaXQgdmlhICdnaXQg
c2VuZC1lbWFpbCcgYWZ0ZXIgYWRqdXN0aW5nIHRoZSBjb21tZW50IGFuZCByZWNvbW1pdHRpbmcg
d2l0aCB0aGUgLXMgb3B0aW9uLiAgRmlyc3QgdGltZSBmb3IgZXZlcnl0aGluZyBJIHN1cHBvc2Us
IGRvaC4NCg0KQXMgdG8geW91ciBjb21tZW50IHN1Z2dlc3Rpb24sIGFwcHJlY2lhdGVkLCBsb29r
cyBnb29kLiAgSSBtaWdodCByZXdvcmQgdGhlICMxIGl0ZW0geW91IGhhdmUganVzdCBhIGJpdCAo
SSByZW1vdmVkIHRoZSBob3N0IHNwZWNpZmljIHN0dWZmIHNpbmNlIEkgdGhpbmsgdGhlIHJhY2Ug
Y2FuIG9jY3VyIHJlZ2FyZGxlc3Mgb2YgaG9zdCBzcGVjaWZpYyBvciBub3QuLi4gYnV0IEkgbWln
aHQgYmUgbWlzc2luZyBzb21ldGhpbmcgdGhlcmU/KS4gIEFueWhvdywgaG93IGFib3V0IHNvbWV0
aGluZyBsaWtlIHRoaXM6DQoNCi0tDQpTdWJqZWN0OiBjcmVkZW50aWFsOiBpZ25vcmUgU0lHUElQ
RSB3aGVuIHdyaXRpbmcgdG8gY3JlZGVudGlhbCBoZWxwZXJzDQoNClRoZSBjcmVkZW50aWFsIHN1
YnN5c3RlbSBjYW4gdHJpZ2dlciBTSUdQSVBFIHdoZW4gd3JpdGluZyB0byBhbg0KZXh0ZXJuYWwg
aGVscGVyIGlmIHRoYXQgaGVscGVyIGNsb3NlcyBpdHMgc3RkaW4gYmVmb3JlIHJlYWRpbmcgdGhl
DQp3aG9sZSBpbnB1dC4gTm9ybWFsbHkgdGhpcyBpcyByYXJlLCBzaW5jZSBoZWxwZXJzIHdvdWxk
IG5lZWQgdG8gcmVhZA0KdGhhdCBpbnB1dCB0byBtYWtlIGEgZGVjaXNpb24gYWJvdXQgaG93IHRv
IHJlc3BvbmQsIGJ1dDoNCg0KMS4gSXQncyByZWFzb25hYmxlIHRvIGNvbmZpZ3VyZSBhIGhlbHBl
ciB3aGljaCBvbmx5IGhhbmRsZXMgImdldCINCiAgICB3aGlsZSBpZ25vcmluZyAic3RvcmUiLiAg
U3VjaCBhIGhhbmRsZXIgbWlnaHQgbm90IHJlYWQgc3RkaW4gDQogICAgZm9yICJzdG9yZSIsIHRo
ZXJlYnkgcmFwaWRseSBjbG9zaW5nIHN0ZGluIHVwb24gaGVscGVyIGV4aXQuDQoNCjIuIEEgYnJv
a2VuIG9yIG1pc2JlaGF2aW5nIGhlbHBlciBtaWdodCBleGl0IGltbWVkaWF0ZWx5LiBUaGF0J3Mg
YW4NCiAgICAgZXJyb3IsIGJ1dCBpdCdzIG5vdCByZWFzb25hYmxlIGZvciBpdCB0byB0YWtlIGRv
d24gdGhlIHBhcmVudCBHaXQNCiAgICAgcHJvY2VzcyB3aXRoIFNJR1BJUEUuDQogICAgDQpFdmVu
IHdpdGggc3VjaCBhIGhlbHBlciwgc2VlaW5nIHRoaXMgcHJvYmxlbSBzaG91bGQgYmUgcmFyZS4g
R2V0dGluZw0KU0lHUElQRSByZXF1aXJlcyB0aGUgaGVscGVyIHJhY2lseSBleGl0aW5nIGJlZm9y
ZSB3ZSd2ZSB3cml0dGVuIHRoZQ0KZmFpcmx5IHNtYWxsIGNyZWRlbnRpYWwgb3V0cHV0Lg0KLS0N
Cg0KQXMgdG8gdGVzdGluZywgeWVzLCB0aGF0IHdhcyBteSB0aG91Z2h0IGFzIHdlbGwuICBBbnlo
b3csIEkgd2lsbCB0cnkgdGhlIGFib3ZlIHVubGVzcyB5b3Ugc2VlIGEgcHJvYmxlbSBvciB3b3Vs
ZCBsaWtlIGFueSBmdXJ0aGVyIGNoYW5nZSAoPykuDQoNClRoYW5rcywNCkVyaWsNCg0K77u/T24g
My8yOS8xOCwgNDoxOSBBTSwgIkplZmYgS2luZyIgPHBlZmZAcGVmZi5uZXQ+IHdyb3RlOg0KDQog
ICAgT24gV2VkLCBNYXIgMjgsIDIwMTggYXQgMDM6MjA6NTFQTSAtMDcwMCwgRXJpayBFIEJyYWR5
IHdyb3RlOg0KICAgIA0KICAgID4gU3ViamVjdDogUmU6IFtQQVRDSF0gY3JlZGVudGlhbDogY3Jl
ZCBoZWxwZXIgZmFzdCBleGl0IGNhbiBjYXVzZSBTSUdQSVBFLCBjcmFzaA0KICAgIA0KICAgIFRo
YW5rcyBmb3Igc2VuZGluZyB0aGlzLiBUaGUgcGF0Y2ggaXRzZWxmIGxvb2tzIGdvb2QgdG8gbWUs
IGJ1dCBJIGhhdmUgYQ0KICAgIGZldyBuaXRzIHdpdGggeW91ciBjb21taXQgbWVzc2FnZS4NCiAg
ICANCiAgICBXZSB1c3VhbGx5IHdyaXRlIGNvbW1pdCBtZXNzYWdlcyBpbiB0aGUgaW1wZXJhdGl2
ZSwgd2l0aCB0aGUgc3ViamVjdA0KICAgIHN1bW1hcml6aW5nIHRoZSBjaGFuZ2UuIFNvOg0KICAg
IA0KICAgICAgU3ViamVjdDogY3JlZGVudGlhbDogaWdub3JlIFNJR1BJUEUgd2hlbiB3cml0aW5n
IHRvIGNyZWRlbnRpYWwgaGVscGVycw0KICAgIA0KICAgIG9yIHNpbWlsYXIuDQogICAgDQogICAg
PiBjcmVkZW50aWFsLmMsIHJ1bl9jcmVkZW50aWFsX2hlbHBlcigpOiBub3cgaWdub3JlcyBTSUdQ
SVBFDQogICAgPiB3aGVuIHdyaXRpbmcgdG8gY3JlZGVudGlhbCBoZWxwZXIuICBBdm9pZHMgcHJv
YmxlbSB3aXRoIHJhY2UNCiAgICA+IHdoZXJlIGNyZWQgaGVscGVyIGV4aXRzIHZlcnkgcXVpY2ts
eSBhbmQsIGFmdGVyLCBnaXQgdHJpZXMNCiAgICA+IHRvIHdyaXRlIHRvIGl0LCBnZW5lcmF0aW5n
IFNJR1BJUEUgYW5kIGNyYXNoaW5nIGdpdC4gIFRvDQogICAgPiByZXByb2R1Y2UgdGhpcyB0aGUg
Y3JlZCBoZWxwZXIgbXVzdCBub3QgcmVhZCBmcm9tIFNURElOLg0KICAgIA0KICAgIFdlIGNhbiBz
dG9wIGJlaW5nIHRlcnNlIG91dHNpZGUgb2YgdGhlIHN1YmplY3QgbGluZS4gOikgSSdkIHByb2Jh
Ymx5DQogICAgd3JpdGUgc29tZXRoaW5nIGxpa2U6DQogICAgDQogICAgICBUaGUgY3JlZGVudGlh
bCBzdWJzeXN0ZW0gY2FuIHRyaWdnZXIgU0lHUElQRSB3aGVuIHdyaXRpbmcgdG8gYW4NCiAgICAg
IGV4dGVybmFsIGhlbHBlciBpZiB0aGF0IGhlbHBlciBjbG9zZXMgaXRzIHN0ZGluIGJlZm9yZSBy
ZWFkaW5nIHRoZQ0KICAgICAgd2hvbGUgaW5wdXQuIE5vcm1hbGx5IHRoaXMgaXMgcmFyZSwgc2lu
Y2UgaGVscGVycyB3b3VsZCBuZWVkIHRvIHJlYWQNCiAgICAgIHRoYXQgaW5wdXQgdG8gbWFrZSBh
IGRlY2lzaW9uIGFib3V0IGhvdyB0byByZXNwb25kLCBidXQ6DQogICAgDQogICAgICAgIDEuIEl0
J3MgcmVhc29uYWJsZSB0byBjb25maWd1cmUgYSBoZWxwZXIgd2hpY2ggYmxpbmRseSBhICJnZXQi
DQogICAgICAgICAgIGFuc3dlciwgYW5kIHRyaWdnZXIgaXQgb25seSBmb3IgY2VydGFpbiBob3N0
cyB2aWEgY29uZmlnIGxpa2U6DQogICAgDQogICAgICAgICAgICAgW2NyZWRlbnRpYWwgImh0dHBz
Oi8vZXhhbXBsZS5jb20iXQ0KICAgIAkgaGVscGVyID0gIiFnZXQtZXhhbXBsZS1wYXNzd29yZCIN
CiAgICANCiAgICAgICAgMi4gQSBicm9rZW4gb3IgbWlzYmVoYXZpbmcgaGVscGVyIG1pZ2h0IGV4
aXQgaW1tZWRpYXRlbHkuIFRoYXQncyBhbg0KICAgICAgICAgICBlcnJvciwgYnV0IGl0J3Mgbm90
IHJlYXNvbmFibGUgZm9yIGl0IHRvIHRha2UgZG93biB0aGUgcGFyZW50IEdpdA0KICAgICAgICAg
ICBwcm9jZXNzIHdpdGggU0lHUElQRS4NCiAgICANCiAgICAgIEV2ZW4gd2l0aCBzdWNoIGEgaGVs
cGVyLCBzZWVpbmcgdGhpcyBwcm9ibGVtIHNob3VsZCBiZSByYXJlLiBHZXR0aW5nDQogICAgICBT
SUdQSVBFIHJlcXVpcmVzIHRoZSBoZWxwZXIgcmFjaWx5IGV4aXRpbmcgYmVmb3JlIHdlJ3ZlIHdy
aXR0ZW4gdGhlDQogICAgICBmYWlybHkgc21hbGwgY3JlZGVudGlhbCBvdXRwdXQuDQogICAgDQog
ICAgRmVlbCBmcmVlIHRvIHN0ZWFsIG9yIGFkYXB0IGFueSBvZiB0aGF0IGFzIHlvdSBzZWUgZml0
Lg0KICAgIA0KICAgID4gVGhpcyB3YXMgc2VlbiB3aXRoIGEgY3VzdG9tIGNyZWRlbnRpYWwgaGVs
cGVyLCB3cml0dGVuIGluDQogICAgPiBHbywgd2hpY2ggaWdub3JlZCB0aGUgc3RvcmUgY29tbWFu
ZCAoU1RESU4gbm90IHJlYWQpIGFuZA0KICAgID4gdGhlbiBkaWQgYSBxdWljayBleGl0LiAgRXZl
biB3aXRoIHRoaXMgZmFzdCBoZWxwZXIgdGhlIHJhY2UNCiAgICA+IHdhcyBwcmV0dHkgcmFyZSwg
aWU6IHdhcyBvbmx5IHNlZW4gb24gc29tZSBvZiBvdXIgb2xkZXIgVk0ncw0KICAgID4gcnVubmlu
ZyAyLjYuMTgtNDE2LmVsNSAjMSBTTVAgbGludXggZm9yIHdoYXRldmVyIHJlYXNvbi4gIE9uDQog
ICAgPiB0aGVzZSBWTSdzIGl0IG9jY3VycmVkIG9ubHkgb25jZSBldmVyeSBmZXcgaHVuZHJlZCBn
aXQgY21kcy4NCiAgICA+IC0tLQ0KICAgIA0KICAgIE1pc3Npbmcgc2lnbm9mZi4gU2VlIERvY3Vt
ZW50YXRpb24vU3VibWl0dGluZ1BhdGNoZXMsIGVzcGVjaWFsbHkgdGhlDQogICAgJ3NpZ24tb2Zm
JyBhbmQgJ2Rjbycgc2VjdGlvbnMuDQogICAgDQogICAgPiAgY3JlZGVudGlhbC5jIHwgMyArKysN
CiAgICA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQogICAgDQogICAgTm8gdGVz
dCwgYnV0IEkgdGhpbmsgdGhhdCdzIGZpbmUgaGVyZS4gQW55IHN1Y2ggdGVzdCB3b3VsZCBiZSBp
bmhlcmVudGx5DQogICAgcmFjeS4NCiAgICANCiAgICA+IEBAIC0yMjcsOCArMjI4LDEwIEBAIHN0
YXRpYyBpbnQgcnVuX2NyZWRlbnRpYWxfaGVscGVyKHN0cnVjdCBjcmVkZW50aWFsICpjLA0KICAg
ID4gIAkJcmV0dXJuIC0xOw0KICAgID4gIA0KICAgID4gIAlmcCA9IHhmZG9wZW4oaGVscGVyLmlu
LCAidyIpOw0KICAgID4gKwlzaWdjaGFpbl9wdXNoKFNJR1BJUEUsIFNJR19JR04pOw0KICAgID4g
IAljcmVkZW50aWFsX3dyaXRlKGMsIGZwKTsNCiAgICA+ICAJZmNsb3NlKGZwKTsNCiAgICA+ICsJ
c2lnY2hhaW5fcG9wKFNJR1BJUEUpOw0KICAgIA0KICAgIFRoaXMgbG9va3MgbGlrZSB0aGUgcmln
aHQgcGxhY2UgdG8gcHV0IHRoZSBwdXNoL3BvcCAoYXMgeW91IG5vdGVkDQogICAgYmVmb3JlLCB3
ZSBtYXkgbm90IHdyaXRlIHVudGlsIGZjbG9zZSBmbHVzaGVzLCBzbyBpdCBkZWZpbml0ZWx5IGhh
cyB0bw0KICAgIGdvIGFmdGVyIHRoYXQpLg0KICAgIA0KICAgIFRoYW5rcyBhZ2FpbiBmb3IgZGln
Z2luZyB0aGlzIHVwLiBJdCdzIHByZXR0eSBzdWJ0bGUuIDopDQogICAgDQogICAgLVBlZmYNCiAg
ICANCg0K
