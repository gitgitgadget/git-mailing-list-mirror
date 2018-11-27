Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8DD1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 09:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbeK0Ukm (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 15:40:42 -0500
Received: from mail-eopbgr40102.outbound.protection.outlook.com ([40.107.4.102]:18449
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728348AbeK0Ukm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 15:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hiboxsystems.onmicrosoft.com; s=selector1-hibox-tv;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AmVcEDtLioEVJinH+AVxUF3zocy/JV1j+3dhwP/kc4=;
 b=K7nu+gA6r1VM1RgyXSesQRBS3TbuOqEJ62ERaPkZeakzZiBXiH9KbHFDKfdVlQziRrdqSgTd9BjTcxfd8P/FKhRRWrBAKOG1jGtyrbiy5W22a9oo/ffNI+30/jzQHgwSL8csykw3SaQudD8PCfrWzjpTBacVyJGANQtn/dnJBts=
Received: from HE1PR08MB1066.eurprd08.prod.outlook.com (10.166.125.152) by
 HE1PR08MB0572.eurprd08.prod.outlook.com (10.161.121.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Tue, 27 Nov 2018 09:43:17 +0000
Received: from HE1PR08MB1066.eurprd08.prod.outlook.com
 ([fe80::d031:2999:9b30:99ec]) by HE1PR08MB1066.eurprd08.prod.outlook.com
 ([fe80::d031:2999:9b30:99ec%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 09:43:17 +0000
From:   Per Lundberg <per.lundberg@hibox.tv>
To:     Duy Nguyen <pclouds@gmail.com>
CC:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        "jost@tcs.ifi.lmu.de" <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@matthieu-moy.fr" <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
Thread-Topic: [RFC PATCH] Introduce "precious" file concept
Thread-Index: AQHUebrNrQJxbaGKnUecpgicPjXQo6VMyZuAgBU5qgCAAEIxAIAAAgwAgAAB1gCAAAHGgIAAAkGAgAEqaQA=
Date:   Tue, 27 Nov 2018 09:43:17 +0000
Message-ID: <f6aad4a2-8cb4-acc2-af9b-9c9c82059b89@hibox.tv>
References: <20181111095254.30473-1-pclouds@gmail.com>
 <875zxa6xzp.fsf@evledraar.gmail.com> <871s7r4wuv.fsf@evledraar.gmail.com>
 <20181112232209.GK890086@genre.crustytoothpaste.net>
 <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv>
 <CACsJy8AzmgkCm=_pJpcXY4xwujnfx9vFKJgbJ_BB__4UybACTQ@mail.gmail.com>
 <87sgznzwcp.fsf@evledraar.gmail.com>
 <CACsJy8C4deg=M+sjmTBM-qs_=zZ9KarND3MNaR6-MqxukBJoSA@mail.gmail.com>
 <87pnurzvr6.fsf@evledraar.gmail.com>
 <CACsJy8Ck7CZ7JWaN6ark=wrAngywJJh76y-FvJ87gE2ckVS8pg@mail.gmail.com>
In-Reply-To: <CACsJy8Ck7CZ7JWaN6ark=wrAngywJJh76y-FvJ87gE2ckVS8pg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0055.eurprd09.prod.outlook.com
 (2603:10a6:7:15::44) To HE1PR08MB1066.eurprd08.prod.outlook.com
 (2a01:111:e400:c524::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=per.lundberg@hibox.tv; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.94.0.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR08MB0572;6:4t5jkMOWr0ys6YiY/7rVSvkXGRidoJFlsiXyrqUUqF+zdjXdNSUEHB/2BqlfkEAZO+UO8rosKSO2z0B0jnsn/0a8Z4ijmQPuLNCps9OhTmNkgU8IZ6pjAiRp+4P1O0IC0/TcnFxATTyZwPwSFvlVMeSWJJBeYYC6s4lCWsjhLy9C1m2BQh3pFfUPMjEC95JoX1C74tQoyrot7WmW0gwlgVE+27hoaO3svJJCuM3TMsDt6oM3Cr+Sf9w03R3UhfogSSEMxClIClGCEfqH8DxeIiJPq7lgkQBX9iTtBYK6iKlGqMbM6Q3SzjnDSmCj+uTW/XlFDWV/MEcIztcq087XYzPidyjiKqGUaTfmDr+Bva0u4kx364Ydnj9yqaDi0Xuj9lZ/bU3hsr5VtvRRiEky2wd13GGoC4eDQG0abomy4vTxi7QB6fB7xxwRsDRyKtRS+970T5DC6QYktRjh4l0I7g==;5:CFvnz40FDAPvQmKncaOSR0Jaze2l5ldPjvjaomAd4LUQpD0JHQKJJsSM2KPwOaLtr3PwrcU/LnlrWZfACG0BbYLRWBUYNTfkjNBWuD9KnFWG/IZQTPtbzT3UR6HA3rYI2OvkObLq0ogUSGjKItezzOYcHHApXceclLgl3MaWbbs=;7:z+s4dXWnEvhkBs5fURiotY+8nAmfxMTm7nIcMIaoXHg/tL0l1wOCROKpcgFCvAWOhLm6Md3yM9DS9hI3Wq3XpK4ZS4M7kLOawVpaJdfbQqM8ytRDaMnHL3KqHgTMd9xvxxkcxY3sTKt5EyxvJDFX1w==
x-ms-office365-filtering-correlation-id: 5369e07f-9323-4bee-b13d-08d6544cc237
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR08MB0572;
x-ms-traffictypediagnostic: HE1PR08MB0572:
x-microsoft-antispam-prvs: <HE1PR08MB0572BFBE68A49045C1604281EAD00@HE1PR08MB0572.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:HE1PR08MB0572;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB0572;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(396003)(376002)(366004)(346002)(199004)(189003)(39060400002)(26005)(386003)(2616005)(102836004)(93886005)(1411001)(76176011)(446003)(71190400001)(7416002)(71200400001)(11346002)(81156014)(305945005)(3846002)(6506007)(66066001)(486006)(6116002)(52116002)(256004)(14454004)(229853002)(7736002)(53936002)(6916009)(81166006)(53546011)(6486002)(31696002)(54906003)(86362001)(6436002)(476003)(99286004)(6512007)(31686004)(74482002)(36756003)(4326008)(2906002)(186003)(44832011)(8936002)(508600001)(68736007)(8676002)(106356001)(97736004)(316002)(25786009)(105586002)(6246003)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB0572;H:HE1PR08MB1066.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hibox.tv does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3cljLWsOCnVt5AutE6ty+oBux75OMDhA5H2NgsoLX7T1BGBi+FsHgSlavBe1K4e7OrHi/bSWBisVUAEQNE2S1V9/kzgzXL2LFeM7HIiQm7vO7YYJGUhp2jiwzgVtQHz3UgAxKDlVW6LjPSgvIc+8w6eGDET5ti3+yKuNUsEEaoDPVqvg4+icGYwYHU07FxsufI2Qs2jy0RYjru7xA8h3HJ1mDIOGf4vTikFOBSHl6N+bsPHRLGKP3t284jXfZWGGvJoX8P7yiWj7/hfQK/PP+nt6d8l4AGYw+uDs5OzFfKJdsgOiwU6V/mOAmpckx10qEkCaoVqAoQdnZSAWBg4O5vBmZcUaaPlwyrmt9CRefEg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <60040413589D5842867D9FBA1D66E19E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hibox.tv
X-MS-Exchange-CrossTenant-Network-Message-Id: 5369e07f-9323-4bee-b13d-08d6544cc237
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 09:43:17.6400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eec7d2e0-55d2-4f5e-ac15-00bd4e779ed6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB0572
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gMTEvMjYvMTggNTo1NSBQTSwgRHV5IE5ndXllbiB3cm90ZToNCj4gT24gTW9uLCBOb3YgMjYs
IDIwMTggYXQgNDo0NyBQTSDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbg0KPiA8YXZhcmFiQGdt
YWlsLmNvbT4gd3JvdGU6DQo+PiBTb21lIG9mIHRoZSBzb2x1dGlvbnMgb3ZlcmxhcCB3aXRoIHRo
aXMgdGhpbmcgeW91IHdhbnQsIGJ1dCBJIHRoaW5rIGl0J3MNCj4+IHdvcnRoIGtlZXBpbmcgdGhl
IGRpc3RpbmN0aW9uIGJldHdlZW4gdGhlIHR3byBpbiBtaW5kLg0KPiANCj4gT24gdGhlIG90aGVy
IGhhbmQgYWxsIHVzZSBjYXNlcyBzaG91bGQgYmUgY29uc2lkZXJlZC4gSXQncyBnb2luZyB0byBi
ZQ0KPiBhIG1lc3MgdG8gaGF2ZSAidHJhc2hhYmxlIiBhdHRyaWJ1dGUgdGhhdCBhcHBsaWVzIHRv
IHNvbWUgY29tbWFuZHMNCj4gd2hpbGUgInByZWNpb3VzIiB0byBzb21lIG90aGVycyAoYW5kIGV2
ZW4gd29yc2Ugd2hlbiB0aGV5IG92ZXJsYXAsDQo+IGltYWdpbmUgaGF2aW5nIHRvIGRlZmluZSBi
b3RoIGluIC5naXRhdHRyaWJ1dGVzKQ0KDQpBZ3JlZSAtIEkgdGhpbmsgaXQgd291bGQgYmUgYSB2
ZXJ5IGJhZCBpZGVhIHRvIGhhdmUgYSAibWl4IiBvZiBib3RoIA0KdHJhc2hhYmxlIGFuZCBwcmVj
aW91cy4gSU1PLCB3ZSBzaG91bGQgdHJ5IHRvIGZpbmQgd2hpY2ggb25lIG9mIHRoZXNlIA0KY29u
Y2VwdHMgc3VpdHMgbW9zdCBnZW5lcmFsIHVzZSBjYXNlcyBiZXN0IGFuZCBjYXVzZXMgbGVzcyBj
aHVybiBmb3IgDQpleGlzdGluZyBzY3JpcHRzL3VzZXJzJyBleGlzdGluZyAic2VtYW50aWMgZXhw
ZWN0YXRpb25zIiwgYW5kIHBpY2sgdGhhdCBvbmUuDQotLQ0KUGVyIEx1bmRiZXJnDQo=
