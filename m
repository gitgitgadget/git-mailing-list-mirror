Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B8FB1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 14:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeK1Bsx (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 20:48:53 -0500
Received: from mail-eopbgr60118.outbound.protection.outlook.com ([40.107.6.118]:11958
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbeK1Bsx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 20:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hiboxsystems.onmicrosoft.com; s=selector1-hibox-tv;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtyH7amER8sbfe/7guau+s90A60LvGDZY6L9qhs30p4=;
 b=htWB30ZgeFcPeyEWs9+9kTKZXpiTR/2u+xYINDWkCb2LZCF0Zh/YrYrLwS6kf72lPKPhHGC7X4BYCPL+PdaW0UdW2owlZe3PuSfIdaTfpdBEE2x2lJlJP0s1AaGwKnRO9WVlqeUjGCSzGtV458+9s+P0vNgyeyi2POtPBfjxc8s=
Received: from HE1PR08MB1066.eurprd08.prod.outlook.com (10.166.125.152) by
 HE1PR08MB2684.eurprd08.prod.outlook.com (10.170.248.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 14:50:34 +0000
Received: from HE1PR08MB1066.eurprd08.prod.outlook.com
 ([fe80::d031:2999:9b30:99ec]) by HE1PR08MB1066.eurprd08.prod.outlook.com
 ([fe80::d031:2999:9b30:99ec%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 14:50:34 +0000
From:   Per Lundberg <per.lundberg@hibox.tv>
To:     Jacob Keller <jacob.keller@gmail.com>
CC:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git mailing list <git@vger.kernel.org>,
        "jost@tcs.ifi.lmu.de" <jost@tcs.ifi.lmu.de>,
        "jjensen@workspacewhiz.com" <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        "drizzd@gmx.net" <drizzd@gmx.net>,
        "hellmuth@ira.uka.de" <hellmuth@ira.uka.de>,
        "kevin@sb.org" <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
Thread-Topic: [RFC PATCH] Introduce "precious" file concept
Thread-Index: AQHUebrNrQJxbaGKnUecpgicPjXQo6VMyZuAgBU5qgCAAEIxAIAAAgwAgAAB1gCAAAHGgIAAAkGAgAFL8ACAABRGAIAAIAwA
Date:   Tue, 27 Nov 2018 14:50:34 +0000
Message-ID: <56ffc52f-644c-2c1d-6a16-c1005b064385@hibox.tv>
References: <20181111095254.30473-1-pclouds@gmail.com>
 <875zxa6xzp.fsf@evledraar.gmail.com> <871s7r4wuv.fsf@evledraar.gmail.com>
 <20181112232209.GK890086@genre.crustytoothpaste.net>
 <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv>
 <CACsJy8AzmgkCm=_pJpcXY4xwujnfx9vFKJgbJ_BB__4UybACTQ@mail.gmail.com>
 <87sgznzwcp.fsf@evledraar.gmail.com>
 <CACsJy8C4deg=M+sjmTBM-qs_=zZ9KarND3MNaR6-MqxukBJoSA@mail.gmail.com>
 <87pnurzvr6.fsf@evledraar.gmail.com>
 <CACsJy8Ck7CZ7JWaN6ark=wrAngywJJh76y-FvJ87gE2ckVS8pg@mail.gmail.com>
 <f6aad4a2-8cb4-acc2-af9b-9c9c82059b89@hibox.tv>
 <CA+P7+xri1=peNpEiZCE802HwCXhojyp2BDvOR+6BBSoRtsZyzA@mail.gmail.com>
In-Reply-To: <CA+P7+xri1=peNpEiZCE802HwCXhojyp2BDvOR+6BBSoRtsZyzA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::16) To HE1PR08MB1066.eurprd08.prod.outlook.com
 (2a01:111:e400:c524::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=per.lundberg@hibox.tv; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.94.0.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR08MB2684;6:22j/w5A11uH5+Rjz6bZkxCXhA/fQJt/jkrERB3VgOnS/gGAUC848TqeiIMIoNS6H8MLhXSjgDv9jaC9bSzTF1TOK1aGxUjfTPYSNKR6es52iQudxJ3GU3EmhvIscZo9rrLWB9/9EfIlNxoeEOJUUwSoOILPi0opvXKYjG8hBz1BMsNBpV+nR2/AoA7b3hwfGxI809+x/fgkj7BfEeyFI8nN+GTfHr2kTDMvX/56eMyPxfzC8JzvFyspab0MxzzCz88XVU8yUZSPx/C0UFBUHXmX/h1EERfkfg6vHn7lgcB99Tg/i/gf6Wec9kn7dbhJgxqWyZ1azXt/3ob5xvjMdfb0xjIzH8jasWNabuoSmFxCnEknMr+VVbDR2VnaRPpXfgLHvBGs00QaePMHDazTp/VubfL7hJ3EUn7dgjDslYoxognEWCv3h08/oR23fugzV/rIYJJ0Sz8lZmGmB36GdeA==;5:MbTsh3wvpWp5q3xShISGtgRyDWDlyezPZXiXRwtnZAZD/Ev30mPEBVZKZ44Bio/+ROMtffdBYvSDF6znZGTelzkotH3KkBVJ/AjPQBiVTspVP6zUWnylyIxwVGf5QJAlQW43MDl5/9S8S1EhFsYzfJ5WuBYjsk6XNdwh713tRDE=;7:R0f2/9evtMeT/8K/8dBRKQC1bpAH4k1c+uFcPPvMqwQ2u12EyfUxsTVSjs8tfaIJduy4RJERTJGkyg2uRNj9tLXOKE4+U+aL5hX5O7hYH8KFmNcbgyuFdhNAx9e+/0UQ3fGbMuqG9Tpjy8XQWNkiOg==
x-ms-office365-filtering-correlation-id: 4a2c8e1c-9944-415d-2af9-08d65477af84
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR08MB2684;
x-ms-traffictypediagnostic: HE1PR08MB2684:
x-microsoft-antispam-prvs: <HE1PR08MB2684AC0EE2363989B01FE319EAD00@HE1PR08MB2684.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231443)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:HE1PR08MB2684;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB2684;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39830400003)(189003)(199004)(305945005)(5660300001)(256004)(7736002)(53936002)(71190400001)(71200400001)(6512007)(74482002)(39060400002)(6246003)(4326008)(6916009)(186003)(44832011)(66066001)(6486002)(7416002)(14444005)(68736007)(86362001)(36756003)(31696002)(6436002)(229853002)(2906002)(508600001)(8936002)(31686004)(52116002)(105586002)(25786009)(2616005)(102836004)(3846002)(97736004)(446003)(99286004)(26005)(6116002)(386003)(6506007)(54906003)(76176011)(316002)(53546011)(8676002)(476003)(93886005)(81156014)(106356001)(81166006)(14454004)(486006)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB2684;H:HE1PR08MB1066.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: hibox.tv does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rmpG7JqFtfEtVFrSYgi3ggByHVSPVSThodnwL1IzHeh6SiCx2vALupxH4TNAK1jnLfl1lnWI5cMlCJ2ng73Ilg8Jxy2cE3jBKRWk9bCRSqZzR0EdcCZCsMlEuiwTupP84TOraCcSAK/MR9BJlqxvnYn+ANpQ1cTNdE9MVUeUK12KwLwTgmwibfJ7nAG4IpKf4uaGTyEeJz35j6EsH9U29MnW7pkqx4z0J/UXY3fAr4Khw7MaTgVwehpJ0MecQ8ZBjfVDKmWGIF9lEfeXt0x9U6ugliCtAE0N3XoTv9zRI+O/3zgkQ0J8JhzZu0G5lENNBKSMx7g0RFj9jIBgoFC81bnIKDYOCmWHf4TIUaz7W+8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D48D4DE195447478C4AB7729CE99956@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hibox.tv
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2c8e1c-9944-415d-2af9-08d65477af84
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 14:50:34.4988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eec7d2e0-55d2-4f5e-ac15-00bd4e779ed6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2684
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gMTEvMjcvMTggMjo1NSBQTSwgSmFjb2IgS2VsbGVyIHdyb3RlOg0KDQo+IFBlcnNvbmFsbHks
IEkgd291bGQgcmF0aGVyIGVyciBvbiB0aGUgc2lkZSB3aGljaCByZXF1aXJlcyB0aGUgbGVhc3QN
Cj4gaW50ZXJhY3Rpb24gZnJvbSB1c2VycyB0byBhdm9pZCBzaWxlbnRseSBjbG9iYmVyaW5nIGFu
IGlnbm9yZWQgZmlsZS4NCj4gDQogPiBbLi4uXQ0KPiANCj4gSSBkb24ndCBsaWtlIHRoZSBpZGVh
IG9mIHByZWNpb3VzIGJlY2F1c2UgaXQgbWVhbnMgcGVvcGxlIGhhdmUgdG8ga25vdw0KPiBhbmQg
cmVtZW1iZXIgdG8gb3B0IGluLCBhbmQgaXQncyBxdWl0ZSBwb3NzaWJsZSB0aGV5IHdpbGwgbm90
IGRvIHNvDQo+IHVudGlsIGFmdGVyIHRoZXkndmUgbG9zdCByZWFsIGRhdGEuDQoNCkkgYWdyZWUg
c3Ryb25nbHkgd2l0aCB0aGlzIHBlcnNvbmFsbHk7IGlmIHdlIG11c3QgY2hvb3NlIGJldHdlZW4g
Im1pZ2h0IA0KYnJlYWsgYXV0b21hdGlvbiIgYW5kICJtaWdodCBkZWxldGUgbm9uLWdhcmJhZ2Ug
ZmlsZXMiLCBJIHdvdWxkIHNheSB0aGUgDQpmb3JtZXIgaXMgdGhlIGxlc3NlciBldmlsIG9mIHRo
ZSB0d28uDQoNCkJ1dCwgaWYgSSBoYWQgMTAgMDAwIDAwMCBzZXJ2ZXJzIHNldCB1cCB1c2luZyBh
dXRvbWF0ZWQgc2NyaXB0cyB0aGF0IA0Kd291bGQgYnJlYWsgYmVjYXVzZSBvZiB0aGlzLCBJIG1p
Z2h0IHRoaW5rIGRpZmZlcmVudGx5LiBRdWl0ZSBsaWtlbHkgc28sIA0KaW4gZmFjdC4NCg0KV2hh
dCBhcmUgdGhlc2UgYXV0b21hdGlvbiBzY2VuYXJpb3MgX21vcmUgc3BlY2lmaWNhbGx5Xz8gSnVu
aW8gb3IgQnJpYW4sIA0Kd291bGQgeW91IGNhcmUgdG8gZWxhYm9yYXRlPyBJcyBpdCBmb3IgYnVp
bGQgc2VydmVycyB3aGVyZSB5b3Ugd2FudCAiZ2l0IA0KY2xlYW4gLWRmeCIgdG8gYWx3YXlzIHJl
c2V0IHRoZSB3b3JraW5nIGNvcHkgdG8gYSBwcmlzdGluZSBzdGF0ZSBvciBhcmUgDQp3ZSB0YWxr
aW5nIGFib3V0IHNvbWUgb3RoZXIgc2NlbmFyaW9zPw0KDQo+IEknZCBvbmx5IGhhdmUgdHJhc2hh
YmxlIGFwcGx5IGluIHRoZSBjYXNlIHdoZXJlIGl0IHdhcyBpbXBsaWNpdC4gaS5lLg0KPiBnaXQg
Y2xlYW4gLWZkeCB3b3VsZCBzdGlsbCBkZWxldGUgdGhlbSwgYXMgdGhpcyBpcyBhbiBleHBsaWNp
dA0KPiBvcGVyYXRpb24gdGhhdCAoaG9wZWZ1bGx5PykgdXNlcnMga25vdyB3aWxsIGRlbGV0ZSBk
YXRhLg0KDQpUaGlzIGlzIG9uZSBvZiB0aGUgdG91Z2hlciBjYWxscywgdW5mb3J0dW5hdGVseS4N
Cg0KSWYgSSB3YXMgYSB1c2VyICh3aGljaCBJIGFtKSwgYW5kIEkgd2FzIHR5cGluZyAiZ2l0IGNs
ZWFuIC1kZngiLCB3aGF0IA0Kd291bGQgSSBleHBlY3Q/DQoNClRoZSBoZWxwIHRleHQgKGN1cnJl
bnRseSkgc3RhdGVzICIteCAgIHJlbW92ZSBpZ25vcmVkIGZpbGVzLCB0b28iLg0KDQpXb3VsZCBp
dCBiZSBzYWZlIHRvIGFzc3VtZSB0aGF0IHBlb3BsZSB3b3VsZCB1bmRlcnN0YW5kIHRoYXQgImln
bm9yZWQgDQpfZG9lcyBub3RfIG1lYW4gdHJhc2hhYmxlIHdoZW4gZG9pbmcgImdpdCBjaGVja291
dCBzb21lLXJlZiIgQlVUIGl0IA0KX2RvZXNfIG1lYW4gdHJhc2hhYmxlIGluIHRoZSAiZ2l0IGNs
ZWFuIC1kZngiIGNvbnRleHQiPyBJJ20gbm90IHNvIA0KY2VydGFpbi4gSXQgd291bGQgYmUgb25l
IG9mIHRob3NlIHBlcmNlaXZlZCBpbmNvbnNpc3RlbmNpZXMgdGhhdCB3b3VsZCANCm1ha2UgcGVv
cGxlIHNjcmVhbSBpbiBhbmdlciBiZWNhdXNlIHRoZXkgX3ByZXN1bWVkXyB0aGF0IHdpdGggdGhl
IG5ldyANCiJ0cmFzaGFibGUiIGNvbmNlcHQsICJnaXQgY2xlYW4gLWRmeCIgd291bGQgbm8gbG9u
Z2VyIGhpdCB0aGVtIGluIHRoZSBsZWcuDQoNCkFuZCB0aGUgb3RoZXIgd2F5IGFyb3VuZDogaWYg
d2UgY2hhbmdlICJnaXQgY2xlYW4gLWRmeCIgdG8gX25vdF8gdHJlYXQgDQoiaWdub3JlZCA9PSB0
cmFzaGFibGUiLCBpdCBpcyBsaWtlbHkgdG8gImhvc2UgYXV0b21hdGlvbiIgYXMgaXQgaGFzIGJl
ZW4gDQpwcmV2aW91c2x5IHN0YXRlZC4gUGVvcGxlIHdobyBtaWdodCBiZSB1c2luZyB0aGlzIHN5
bnRheCBhbmQgX3dhbnRfIGl0IA0KdG8gcmVtb3ZlIGlnbm9yZWQgZmlsZXMgd291bGQgYmUgdXBz
ZXQsIGFuZCByaWdodGZ1bGx5IHNvLg0KDQpTbyBpbiBteSBQT1YsIGl0J3MgYSB0b3VnaCBkZWNp
c2lvbiBiZXR3ZWVuIHR3bywgbGVzcy10aGFuLW9wdGltYWwgDQphbHRlcm5hdGl2ZXMuDQoNCkJ1
dCBJIHdvdWxkIHBlcmhhcHMgYmUgYWJsZSB0byBsaXZlIHdpdGggdGhlIGN1cnJlbnQgc2VtYW50
aWNzIGZvciAiZ2l0IA0KY2xlYW4gLWRmeCIgX2FzIGxvbmcgYXMgd2UgdXBkYXRlIHRoZSBoZWxw
IHRleHRfIHNvIHRoYXQgIi14IiBpbmRpY2F0ZXMgDQptb3JlIGNsZWFybHkgdGhhdCBub24tdHJh
c2hhYmxlIGZpbGVzIGNhbiBiZSBkZWxldGVkLiBJdCBkb2Vzbid0IG1ha2UgDQp0aGluZ3MgX3dv
cnNlXyB0aGFuIHRoZXkgY3VycmVudGx5IGFyZSBhbmQgaWYgdGhpcyBpcyB3aGF0IGl0IHRha2Vz
IHRvIA0KZ2V0IHRoZSB0cmFzaGFibGUgY29uY2VwdCBpbXBsZW1lbnRlZCBhbmQgYWNjZXB0ZWQg
YnkgdGhlIGNvbW11bml0eSwgDQppdCdzIGEgY29tcHJvbWlzZSBJJ2QgYmUgd2lsbGluZyB0byBt
YWtlLg0KLS0NClBlciBMdW5kYmVyZw0KDQo=
