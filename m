Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3211F5FB
	for <e@80x24.org>; Wed,  1 Mar 2017 08:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbdCAI50 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 03:57:26 -0500
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:3680
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751560AbdCAI5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 03:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GWeJpW1zwK0zIx3EOUh1w7XrH2kn5gclgB/d1xXo574=;
 b=QXOkvpQm/Q7V2YRyLLuX1nZLaxd8OYKCsByfcpTpK7WjDtH1GXjXUkSsBR8u9zseH40hbSuMikZkfCCUaE6ALdNokC0ossPkq+8X3ipCrKj00WI+IZiuWahCv4dW8fQOm+X+gOY7fq6MzoNqt+sHiVU/6mA3FIwa8eEJcAXtsQA=
Received: from CY1PR0301MB2107.namprd03.prod.outlook.com (10.164.2.153) by
 CY1PR0301MB2107.namprd03.prod.outlook.com (10.164.2.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Wed, 1 Mar 2017 08:57:21 +0000
Received: from CY1PR0301MB2107.namprd03.prod.outlook.com ([10.164.2.153]) by
 CY1PR0301MB2107.namprd03.prod.outlook.com ([10.164.2.153]) with mapi id
 15.01.0933.020; Wed, 1 Mar 2017 08:57:21 +0000
From:   Dan Shumow <danshu@microsoft.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: RE: SHA1 collisions found
Thread-Topic: SHA1 collisions found
Thread-Index: AQHSkffFO/OFlfJrmU2TJcJuGQpvwaF/rZlg
Date:   Wed, 1 Mar 2017 08:57:21 +0000
Message-ID: <CY1PR0301MB210787306B549D00238FD37FC4290@CY1PR0301MB2107.namprd03.prod.outlook.com>
References: <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
 <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
 <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net>
 <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
 <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net>
 <alpine.LFD.2.20.1702231428540.30435@i7.lan>
 <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net>
 <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
 <xmqqefyikvin.fsf@gitster.mtv.corp.google.com>
 <xmqq60jukubq.fsf@gitster.mtv.corp.google.com>
 <20170228192044.cn56puazsa3wtlkd@sigill.intra.peff.net>
In-Reply-To: <20170228192044.cn56puazsa3wtlkd@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: peff.net; dkim=none (message not signed)
 header.d=none;peff.net; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [76.121.229.23]
x-ms-office365-filtering-correlation-id: 4afda082-e8b8-436c-1c82-08d46080f8db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081);SRVR:CY1PR0301MB2107;
x-microsoft-exchange-diagnostics: 1;CY1PR0301MB2107;7:WNydiYpHpaSXja1Ixl9XyTs+48H/2Sj3FlwGJF99p2v4yobun7IAlEE5pyI8TjgAw45B/zXn+fYpzU0KvFuyNp3kshKIMZWkOosI2vde68T03gbVOzKgxppoMHVH2ZLKwNIfxj+0VTbUJCEGi4TEkfdq9VVyXML+ccdELBaKfWUbUZN8T+ELgJxy///yvFEoImVTSAIVdF9Ao2C4Ub28JiXgFtrDVgK/oetCC+ilo9gBtZkMEY3h8Fdc5B2I6cKeTh0eJjwuPAvph0NMR5m/JWZ38INyo40H3GxMTPVGenr491NiyeEoo1d5DLYRotJQeCbO7FQDPCxhU42d1/XlWME2mthTjm+ru5XwJ0bKA5c=
x-microsoft-antispam-prvs: <CY1PR0301MB2107985265B84CD7299AD359C4290@CY1PR0301MB2107.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123558025)(20161123555025)(20161123564025)(20161123560025)(6072148)(6042181);SRVR:CY1PR0301MB2107;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB2107;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(106116001)(81166006)(8676002)(7116003)(54906002)(5660300001)(5005710100001)(77096006)(55016002)(99286003)(2950100002)(74316002)(10290500002)(8656002)(25786008)(92566002)(6506006)(10090500001)(4326008)(6436002)(3660700001)(8990500004)(3280700002)(8936002)(38730400002)(53936002)(6246003)(33656002)(9686003)(229853002)(2906002)(7736002)(189998001)(93886004)(305945005)(122556002)(2900100001)(102836003)(66066001)(3846002)(50986999)(6116002)(7696004)(86362001)(54356999)(76176999)(473944003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0301MB2107;H:CY1PR0301MB2107.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2017 08:57:21.1553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB2107
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAgIC0gRGFuIHRpbWVkIHRoZSBzaGExZGMgaW1wbGVtZW50YXRpb24gd2l0aCBhbmQgd2l0aG91
dCB0aGUgY29sbGlzaW9uDQo+ICAgICBkZXRlY3Rpb24gZW5hYmxlZC4gVGhlIHNoYTEgaW1wbGVt
ZW50YXRpb24gaXMgb25seSAxLjMzeCBzbG93ZXIgdGhhbg0KPiAgICBibG9jay1zaGExIChmb3Ig
cmF3IHNoYTEgdGltZSkuIEFkZGluZyBpbiB0aGUgZGV0ZWN0aW9uIG1ha2VzIGl0DQo+ICAgIDIu
Nnggc2xvd2VyLg0KDQogPiAgICBTbyB0aGVyZSdzIHNvbWUgcG90ZW50aWFsIGdhaW4gZnJvbSBv
cHRpbWl6aW5nIHRoZSBzaGExDQogPiAgICBpbXBsZW1lbnRhdGlvbiwgYnV0IHVsdGltYXRlbHkg
d2UgbWF5IGJlIGxvb2tpbmcgYXQgYSAyeCBzbG93ZG93biB0bw0KID4gICAgIGFkZCBpbiB0aGUg
Y29sbGlzaW9uIGRldGVjdGlvbi4NCg0KSSByZWFycmFuZ2VkIG91ciBjb2RlIGEgbGl0dGxlIGJp
dCBhbmQgaW50ZXJsZWF2ZWQgdGhlIG1lc3NhZ2UgZXhwYW5zaW9uIGFuZCByb3VuZHMuICBUaGlz
IGJyaW5nIG91ciByYXcgU0hBLTEgaW1wbGVtZW50YXRpb24gKHdpdGhvdXQgY29sbGlzaW9uIGRl
dGVjdGlvbikgZG93biB0byAxLjExeCBzbG93ZXIgdGhhbiB0aGUgYmxvY2stc2hhMSBpbXBsZW1l
bnRhdGlvbiBpbiBHaXQuICBBZGRpbmcgdGhlIGNvbGxpc2lvbiBkZXRlY3Rpb24gYnJpbmdzIHVz
IHRvIDIuMTJ4IHNsb3dlciB0aGFuIHRoZSBibG9jay1zaGExIGltcGxlbWVudGF0aW9uLiAgVGhp
cyB3YXMgYmFzaWNhbGx5IGF0dGFja2luZyB0aGUgbG93IGhhbmdpbmcgZnJ1aXQgaW4gb3B0aW1p
emluZyBvdXIgaW1wbGVtZW50YXRpb24uICBUaGVyZSBhcmUgc29tZSB0aGluZ3MgdGhhdCBJIGhh
dmVuJ3QgbG9va2VkIGludG8geWV0LCBidXQgSSdtIGJhc2ljYWxseSBhdCB0aGUgcG9pbnQgb2Yg
c3RhcnRpbmcgdG8gY29tcGFyZSB0aGUgZ2VuZXJhdGVkIGFzc2VtYmxlciB0byBzZWUgd2hhdCdz
IGRpZmZlcmVudCBiZXR3ZWVuIG91ciBpbXBsZW1lbnRhdGlvbnMuDQoNCk9wZW5TU0wncyBTSEEx
IGltcGxlbWVudGF0aW9uIGlzIGltcGxlbWVudGVkIGluIGFzc2VtYmxlciwgc28gdGhlcmUncyBu
byB3YXkgd2UncmUgZ29pbmcgdG8gZ2V0IGNsb3NlIHRvIHRoYXQgd2l0aCBqdXN0IEMgbGV2ZWwg
Y29kaW5nLg0KDQpUaGFua3MsDQpEYW4NCg==
