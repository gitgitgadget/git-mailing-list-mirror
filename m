Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B931F404
	for <e@80x24.org>; Wed, 15 Aug 2018 08:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeHOLbC (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 07:31:02 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:16343
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726193AbeHOLbC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 07:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3aERVHUOGTPrBlSlMgk2U8NAfoOwCNtQ1wD9L4oWEY=;
 b=Q/E9O6j7pW8tXQyZ+E6v+DSlBKGYY8wTNfCrQ2EXw19B9mMj5zqKQliGewj+ym+OriD/ZMuirasGIdEOr7nHfQxSnguVDnBb9NLdUJKPb17rUMK/xhV/IZI8rzGTQWFdBKy4PiOUlZXre77l4jtAiWrV3/cDMbY7/wwWic63C2Q=
Received: from SN1PR10MB0736.namprd10.prod.outlook.com (10.163.206.15) by
 SN1PR10MB0670.namprd10.prod.outlook.com (10.163.135.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Wed, 15 Aug 2018 08:39:05 +0000
Received: from SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::488b:a298:2f2c:9855]) by SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::488b:a298:2f2c:9855%4]) with mapi id 15.20.1038.025; Wed, 15 Aug 2018
 08:39:05 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "gitster@pobox.com" <gitster@pobox.com>,
        "sbeller@google.com" <sbeller@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>
Subject: Re: [PATCH 1/2] store submodule in common dir
Thread-Topic: [PATCH 1/2] store submodule in common dir
Thread-Index: AQHUNB+F28APmVvAWkyTFldzDSujH6S/3iE+gAAEbD6AAJkfAIAAAuoA
Date:   Wed, 15 Aug 2018 08:39:05 +0000
Message-ID: <3bd471a5a970adf18cf279c4db217e352eea2506.camel@infinera.com>
References: <95e4f9df528a40bf3f3e648318904500343abf9a.camel@infinera.com>
         <20180814223820.123723-1-sbeller@google.com>
         <xmqqo9e4y2gr.fsf@gitster-ct.c.googlers.com>
         <xmqqk1osy1qo.fsf@gitster-ct.c.googlers.com>
         <676a61f0e87742fe591eb91fcf3509b75645e030.camel@infinera.com>
In-Reply-To: <676a61f0e87742fe591eb91fcf3509b75645e030.camel@infinera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR10MB0670;6:a8NeZzaA14/pHfnK7VYLtXjnMqK37NjRofJV7f6cp/CX17V/ct9r1d680gqpFxPMtf/XVdEsquhcE3LwdINPerd8rKoZHn9wjXQajow9v5B58u9YHIJ2Pv3ppO5CIPniK9ydJY86c+vVLw8nm618HQoGSpxx/yNkqzceBP3roCP5/xl9iiWksb1W3xW7BQLcOlXGhEzPyA9sOUYTiJ2jdM9J0KJR4+ng66r35s2CRSIm9PXGoJDSaOYF+OAPAY0AnGUNgngSeSfonbfZubPswO/7T4VEDr2rvECFlWkujcwNSB0d+tkl2Uow67bwsWIzxQWAIlC4rehKwlG6XDMplxW11H5U2wBizNG5UD50w4xuylt21dpg+1Pw+0Uv/K82/9yZJubf+H4u24h0mcuac/rE4E8F9ZCl/2+eb3Ga+iaU9wWjp5V1qp6ZwIv6b9kF+QQ76+AtLX+R6yLCzWt4hQ==;5:+z5qHfakvcFlyaqQiCoH3vy0ChvIRWC15cjFJ0qefqQJo2Z0a5ZV9gnNiLa2RC2nwrUEzZY78O8YA+mVAuy8T6DiI+/QOa5NxMg1avxO+Mp3oih4WpzydBSIEr8ilFAuNVZltM09B4XrYgxqpsfgUkuWfY/zaFqaiGpJuwMvQxI=;7:VZaYAuLnN+vIu91MLx6+Q9NQnX6Tw8Ihv5AdmL3TspLzhqxCKuF2yZpOiMdZHTwst6XklBDXmzwS/3JqbJmBE6zzc8HvHTuzf1NkFF8sT/PME405RF7p/iikwJqbLtTV5zbSJnZ9wZBN+b42g56sotmrRkQFAVw3eFIjOtxkXtSnfSGRFcVGcvU7NT0UNUpUIsT3CFrJsJ8WTPsUzGRAh9HUEb79+isgpl1HAOovgxI7GwlFdoMbuWCdcPTieDZF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c73037fa-afd9-4b96-06d2-08d6028a8f85
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR10MB0670;
x-ms-traffictypediagnostic: SN1PR10MB0670:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-microsoft-antispam-prvs: <SN1PR10MB0670AC300F9F7232D16B0FBEF43F0@SN1PR10MB0670.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(100324003535756);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR10MB0670;BCL:0;PCL:0;RULEID:;SRVR:SN1PR10MB0670;
x-forefront-prvs: 07658B8EA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(199004)(189003)(2616005)(99286004)(6486002)(6436002)(229853002)(53936002)(11346002)(486006)(66066001)(25786009)(2900100001)(476003)(5660300001)(2906002)(118296001)(305945005)(7736002)(8936002)(6512007)(76176011)(6116002)(3846002)(5250100002)(2501003)(5024004)(4326008)(26005)(68736007)(478600001)(102836004)(316002)(39060400002)(186003)(6506007)(14454004)(110136005)(54906003)(256004)(72206003)(6246003)(97736004)(106356001)(446003)(93886005)(86362001)(105586002)(8676002)(36756003)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR10MB0670;H:SN1PR10MB0736.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ykBfw0gaMViCaiPE+434sy2PvVSg8G7KdOxItLaXTZyJ/e7uKJM0NEBi9F3yQDlZ7Z1MvIOs7R1sb/Ydgcl0d/6FUPj3hxJdLFXjsseEk5xhXgg8LIjZhemm36ttSHAsT3xzCyXUBtEk+9X76mx4wYG5yZTZ6m321sOyH5T32Qr/hgXTLhUBR+6/JDpZfdJssv2ULg0J/ji2nNFsYWfp652n4MyzOeGd5tD6fo24RbkIW9//2Ao5M+Z96jkT03cOHpFH4OCmCxoXhXn8cSZwLe843yplBrXZV7FM8X36AiMZoYQZg3/XX+8BvBeGMWaCnCy5aH1w0iNa+4hysGS+chBQoCkNk9M01o7tRkx74cU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8623C351261AF1448820889FE0DFCDDC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73037fa-afd9-4b96-06d2-08d6028a8f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2018 08:39:05.5481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR10MB0670
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gV2VkLCAyMDE4LTA4LTE1IGF0IDEwOjI4ICswMjAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3Rl
Og0KPiBPbiBUdWUsIDIwMTgtMDgtMTQgYXQgMTY6MjAgLTA3MDAsIEp1bmlvIEMgSGFtYW5vIHdy
b3RlOg0KPiA+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2Yg
dGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBz
YWZlLg0KPiA+IA0KPiA+IA0KPiA+IEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT4g
d3JpdGVzOg0KPiA+IA0KPiA+ID4gTXkgdW5kZXJzdGFuZGluZyBvZiB3aGF0IEpvYWtpbSB3YW50
cyB0byBkbyBpcyB0byBoYXZlIGEgdG9wLWxldmVsDQo+ID4gPiBwcm9qZWN0IHRoYXQgaGFzIHRo
cmVlIHN1YmRpcmVjdG9yaWVzLCBlLmcuIGtlcm5lbC92Mi4yLCBrZXJuZWwvdjIuNA0KPiA+ID4g
YW5kIGtlcm5lbC92Mi42LCBlYWNoIG9mIHdoaWNoIGlzIGEgc3VibW9kdWxlIHRoYXQgaG91c2Vz
IHRoZXNlDQo+ID4gPiB2ZXJzaW9ucyBvZiBMaW51eCBrZXJuZWwgc291cmNlLCBidXQgb25seSBj
bG9uZSBMaW51cydzIHJlcG9zaXRvcnkNCj4gPiA+IChhcyB0aGUgdXAtdG8tbGF0ZSB0cmVlIGhh
cyBhbGwgdGhlIG5lY2Vzc2FyeSBoaXN0b3J5IHRvIGNoZWNrIG91dA0KPiA+ID4gdGhlc2UgcGFz
dCBkZXZlbG9wbWVudCB0cmFja3MpLiAgQW5kIHRoYXQgc2hvdWxkIGJlIGRvYWJsZSB3aXRoDQo+
ID4gPiBqdXN0IHRoZSBtYWluIGNoZWNrb3V0LCB3aXRob3V0IGFueSBhZGRpdGlvbmFsIHdvcmt0
cmVlIChpdCdzIGp1c3QNCj4gPiA+IHRoZSBtYXR0ZXIgb2YgaGF2aW5nIC5naXQvbW9kdWxlcy9r
ZXJuZWwlMmZ2Mi42LyBkaXJlY3RvcnkgcG9pbnRlZA0KPiA+ID4gYnkgdHdvIHN5bWxpbmtzIGZy
b20gLmdpdC9tb2R1bGVzL2tlcm5lbCUyZnYyLlsyNF0sIG9yIHNvbWV0aGluZw0KPiA+ID4gbGlr
ZSB0aGF0KS4NCj4gPiANCj4gPiBBY3R1YWxseSBJIHRha2UgdGhlIGxhc3QgcGFydCBvZiB0aGF0
IGJhY2suICBXaGVuIHRob3VnaHQgbmFpdmVseQ0KPiA+IGFib3V0LCBpdCBtYXkgYXBwZWFyIHRo
YXQgaXQgc2hvdWxkIGJlIGRvYWJsZSwgYnV0IGJlY2F1c2UgZWFjaCBvZg0KPiA+IHRoZSBtb2R1
bGVzLyogZGlyZWN0b3J5IGluIHRoZSB0b3AtbGV2ZWwgcHJvamVjdCBoYXMgdG8gc2VydmUgYXMg
dGhlDQo+ID4gJEdJVF9ESVIgZm9yIGVhY2ggc3VibW9kdWxlIGNoZWNrb3V0LCBhbmQgdGhlIGRl
c2lyZSBpcyB0byBoYXZlDQo+ID4gdGhlc2UgdGhyZWUgZGlyZWN0b3JpZXMgdG8gaGF2ZSBjaGVj
a291dCBvZiB0aHJlZSBkaWZmZXJlbnQNCj4gPiBicmFuY2hlcywgYSBzaW5nbGUgZGlyZWN0b3J5
IHVuZGVyIG1vZHVsZXMvLiB0aGF0IGlzIHNoYXJlZCBhbW9uZw0KPiA+IHRocmVlIHN1Ym1vZHVs
ZXMgd291bGQgKm5vdCogd29yay0tLXRoZXkgbXVzdCBoYXZlIHNlcGFyYXRlIGluZGV4LA0KPiA+
IEhFQUQsIGV0Yy4NCj4gPiANCj4gPiBUaGVvcmV0aWNhbGx5IHdlIHNob3VsZCBiZSBhYmxlIHRv
IG1ha2UgbW9kdWxlcy9rZXJuZWwlMmZ2Mi5bMjRdDQo+ID4gYWRkaXRpb25hbCAid29ya3RyZWUi
cyBvZiBtb2R1bGVzL2tlcm5lbCUyZnYyLjYsIGJ1dCBnaXZlbiB0aGF0DQo+ID4gdGhlc2UgYXJl
IGFsbCAiYmFyZSIgcmVwb3NpdG9yaWVzIHdpdGhvdXQgYW4gYXR0YWNoZWQgd29ya2luZyB0cmVl
LA0KPiA+IEkgYW0gbm90IHN1cmUgaG93IHRoYXQgd291bGQgc3VwcG9zZWQgdG8gd29yay4gIFRo
aW5raW5nIGFib3V0DQo+ID4gaGF2aW5nIG11bHRpcGxlIHdvcmt0cmVlcyBvbiBhIHNpbmdsZSBi
YXJlIHJlcG9zaXRvcnkgbWFrZXMgbWUgaGVhZA0KPiA+IHNwaW4gYW5kIGFjaGUgWC08Oy0pDQo+
IA0KPiBZb3UgbmFpbGVkIGl0ICEgOikNCj4gTXkgaGVhZCBzcGlucyBqdXN0IHJlYWRpbmcgdGhp
cyBzbyBJIHRoaW5rIEkgZ290IG15IGFuc3dlci4gSSBjYW4gYmUgZG9uZQ0KPiBidXQgd2lsbCBi
ZSB0cmlja3kgdG8gaW1wbC4gDQo+IEkgd2lsbCBrZWVwIGFuIGV5ZSBvbiBob3cgc3VibW9kdWxl
cyBkZXZlbG9wcywgc3VyZSB3b3VsZCBiZSBhIHdlbGNvbWUgZmVhdHVyZS4NCj4gDQo+ICBKb2Nr
ZQ0KDQpPbiBhIHJlbGF0ZWQgbm90ZSwgaXQgd291bGQgYmUgZ3JlYXQgaWYgZ2l0IGNvdWxkIHN1
cHBvcnQgc3BhcnNlIGNoZWNrb3V0L2Nsb25lDQpmb3Igc3VibW9kdWxlcywgbm93IG9uZSBoYXZl
IHRvIG1hbnVhbGx5IGFkZCAuZ2l0L2luZm8vc3BhcnNlLWNoZWNrb3V0Lg0KSWYgc3BhcnNlIGNs
b25lIGFuZCBzcGFyc2UgY2hlY2tvdXQgY291bGQgYmUgc2F2ZWQgaW4gdGhlIHN1Ym1vZHVsZSwg
dGhlbiB0aGVyZQ0Kd291bGQgYmUgbm8gcHJvYmxlbSB3aXRoIDMgY29waWVzIG9mIHRoZSBzYW1l
IHJlcG8gaW4gbXkgc3VibW9kdWxlcy4NCg0KIEpvY2tlDQo=
