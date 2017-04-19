Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0948B1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 19:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969182AbdDSTIj (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 15:08:39 -0400
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:54486 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755795AbdDSTIi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 15:08:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id D800110008B;
        Wed, 19 Apr 2017 19:08:36 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y_f9bZLNkCEI; Wed, 19 Apr 2017 19:08:36 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id C802A8002E;
        Wed, 19 Apr 2017 19:08:36 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Wed, 19 Apr 2017 19:08:36 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Wed, 19 Apr 2017 19:08:36 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     =?utf-8?B?J1JlbsOpIFNjaGFyZmUn?= <l.s.r@web.de>,
        Jonathan Nieder <jrnieder@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Subject: RE: [PATCH v3 1/2] use HOST_NAME_MAX to size buffers for
 gethostname(2)
Thread-Topic: [PATCH v3 1/2] use HOST_NAME_MAX to size buffers for
 gethostname(2)
Thread-Index: AQHSuKxPA6CLmLZTT0aU/XCrNvIBAqHM81+AgAAWLHA=
Date:   Wed, 19 Apr 2017 19:08:36 +0000
Message-ID: <b7a3844946934ecda1ba1ac5b972ff9d@exmbdft7.ad.twosigma.com>
References: <20170418215743.18406-1-dturner@twosigma.com>
 <20170418215743.18406-2-dturner@twosigma.com>
 <20170419012824.GA28740@aiede.svl.corp.google.com>
 <c0333c81-d3b2-ca2d-a553-75642d8fb949@web.de>
In-Reply-To: <c0333c81-d3b2-ca2d-a553-75642d8fb949@web.de>
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

PiBJIGhhZCBhbm90aGVyIGxvb2sgYXQgdGhpcyBsYXN0IG5pZ2h0IGFuZCBjb29rZWQgdXAgdGhl
IGZvbGxvd2luZyBwYXRjaC4gIE1pZ2h0DQo+IGhhdmUgZ29uZSBvdmVyYm9hcmQgd2l0aCBpdC4u
DQo+IA0KPiAtLSA+OCAtLQ0KPiBTdWJqZWN0OiBbUEFUQ0hdIGdjOiBzdXBwb3J0IGFyYml0cmFy
eSBob3N0bmFtZXMgYW5kIHBpZHMgaW4gbG9ja19yZXBvX2Zvcl9nYygpDQo+IA0KPiBnaXQgZ2Mg
d3JpdGVzIGl0cyBwaWQgYW5kIGhvc3RuYW1lIGludG8gYSBwaWRmaWxlIHRvIHByZXZlbnQgY29u
Y3VycmVudCBnYXJiYWdlDQo+IGNvbGxlY3Rpb24uICBSZXBvc2l0b3JpZXMgbWF5IGJlIHNoYXJl
ZCBiZXR3ZWVuIHN5c3RlbXMgd2l0aCBkaWZmZXJlbnQgbGltaXRzDQo+IGZvciBob3N0IG5hbWUg
bGVuZ3RoIGFuZCBkaWZmZXJlbnQgcGlkIHJhbmdlcy4gIFVzZSBhIHN0cmJ1ZiB0byBzdG9yZSB0
aGUgZmlsZQ0KPiBjb250ZW50cyB0byBhbGxvdyBmb3IgYXJiaXRyYXJpbHkgbG9uZyBob3N0bmFt
ZXMgYW5kIHBpZHMgdG8gYmUgc2hvd24gdG8gdGhlDQo+IHVzZXIgb24gZWFybHkgYWJvcnQuDQoN
ClRoaXMgaXMgcHJldHR5IHBhcmFub2lkLCBidXQgbWF5YmUgdGhlIHJlbW90ZSBob3N0IGhhcyBh
IGxvbmdlciBwaWRfdCB0aGFuIHdlIA0KZG8sIHNvIHdlIHNob3VsZCBiZSB1c2luZyBpbnRtYXhf
dCB3aGVuIHJlYWRpbmcgdGhlIHBpZCwgYW5kIG9ubHkgY2hlY2sgaXRzIA0Kc2l6ZSAgYmVmb3Jl
IHBhc3NpbmcgaXQgdG8ga2lsbD8NCg0KKFBlcnNvbmFsbHksIEkgdGhpbmsgdGhpcyB3aG9sZSBw
YXRjaCBpcyBraW5kIG9mIG92ZXJraWxsLCBidXQgc29tZSBmb2xrcyBwcm9iYWJseQ0KdGhpbmsg
dGhlIHNhbWUgYWJvdXQgbXkgb3JpZ2luYWwgcGF0Y2hlcywgc28gSSdtIGhhcHB5IHRvIGxpdmUg
YW5kIGxldCBsaXZlKS4NCg==
