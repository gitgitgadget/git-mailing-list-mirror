Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECAD81F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 09:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeKZUYe (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 15:24:34 -0500
Received: from mail-eopbgr60103.outbound.protection.outlook.com ([40.107.6.103]:47537
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726165AbeKZUYd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 15:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hiboxsystems.onmicrosoft.com; s=selector1-hibox-tv;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmpfTN138R6JHtyE7cHe5DwOkC2NPLRCXZF5QMyNngY=;
 b=m+tQR5iLYRjc6vqVpjgTfBIQWVaWI2IQ4TjatldIX4bQHFTwaiVRRW4fwIjrwNB9lH8L0DYBD1JCitC1hBFHNe+SxGFk80MDYaD6JpLSCHHcOPyvtNpK6H6zzfyZK8QAOmnrcjM6/oKbqjTzaS+fMuwNHqxLPDevrv9h8t8Nlfw=
Received: from HE1PR08MB1066.eurprd08.prod.outlook.com (10.166.125.152) by
 HE1PR08MB0394.eurprd08.prod.outlook.com (10.161.116.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 09:30:13 +0000
Received: from HE1PR08MB1066.eurprd08.prod.outlook.com
 ([fe80::d031:2999:9b30:99ec]) by HE1PR08MB1066.eurprd08.prod.outlook.com
 ([fe80::d031:2999:9b30:99ec%5]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 09:30:13 +0000
From:   Per Lundberg <per.lundberg@hibox.tv>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
CC:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
Thread-Topic: [RFC PATCH] Introduce "precious" file concept
Thread-Index: AQHUebrNrQJxbaGKnUecpgicPjXQo6VMyZuAgBUYIwA=
Date:   Mon, 26 Nov 2018 09:30:13 +0000
Message-ID: <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv>
References: <20181111095254.30473-1-pclouds@gmail.com>
 <875zxa6xzp.fsf@evledraar.gmail.com> <871s7r4wuv.fsf@evledraar.gmail.com>
 <20181112232209.GK890086@genre.crustytoothpaste.net>
In-Reply-To: <20181112232209.GK890086@genre.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0007.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::17) To HE1PR08MB1066.eurprd08.prod.outlook.com
 (2a01:111:e400:c524::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=per.lundberg@hibox.tv; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.94.0.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR08MB0394;6:Qp0dmPSmJUxXW4E76LuZzExxtlLCME5ugUilaPTx6OETn4b24LF580+xI6j/u4E2onJp5IV8l5Ons5CB0tR18McDB+0b8v4rJJx4+4rQL/qDzqYKBIGnaAxtMu27hiuA4JYi823lQtM0cVPHIYv4w6Oa6UmXbcI/jX2FRhI9Jmf8INg0brsQ8h/s3dV4AI2h6pxpL5Tjb0NSwLQIdjTKTrVEoZfbMHR5mYKbeFa/tqGTEJBQ+32IsfySr2ohHLfX8aB2Eabow6NxRg4JsGteuwY7H97lOUiazCn5BDclxPzuq0HkloI5eswfwDGNtpZD5s13eQuSXC6EIUVrELsuumU7lU/a1fJtcH9WjTy/eUzl7Y75Qnkx0iYldrnMXW2qQOG/aKlqt3zfbHVX+7kPDpxHCMYijx2p3QwDP9+gCR0Vnlb8ZEKQiYaD8XxO2ixPcM1gFkf0XMeATIzUgNqskQ==;5:8Vo2ARv9fIOITFFNyKp781gFm8SlpkJDUJGR+w0uXnnKgFIvwqNYGoVlR6iK4yt7Jl0ctMEGSQdOlTql8eaEBUb9tWwPXdPRCwncH7W8xeA/Nhl3Wpz3wdtcdpkbz8zipAbsesPQUq9LCUUQYjBXca3BAfkBkxRxX29CcZMjZDA=;7:EAjSQ/9eIHXXBQ0lNHFpCCEajMu0UG3z2N07Nr7sIhl1UTTLZspENww6QSyeLEqo6PCKC1S3fK8nf87DDbZhKimCzFqWYmSlxB4eb8/W3kZf8EV7N5Ij5UA08e6VyHy4perLK/IWamDNVBByHNmWOQ==
x-ms-office365-filtering-correlation-id: 647db617-d914-4830-45c2-08d65381c458
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR08MB0394;
x-ms-traffictypediagnostic: HE1PR08MB0394:
x-microsoft-antispam-prvs: <HE1PR08MB03946D7473B2832D08BEE6C4EAD70@HE1PR08MB0394.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231443)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(2016111802025)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:HE1PR08MB0394;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB0394;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(366004)(136003)(396003)(376002)(199004)(189003)(561944003)(14454004)(229853002)(6436002)(7416002)(36756003)(7736002)(305945005)(256004)(31686004)(5660300001)(102836004)(93886005)(74482002)(2906002)(99286004)(25786009)(4326008)(186003)(26005)(54906003)(6116002)(3846002)(53546011)(508600001)(110136005)(76176011)(316002)(106356001)(105586002)(386003)(6506007)(39060400002)(68736007)(6486002)(86362001)(6246003)(97736004)(31696002)(6512007)(53936002)(476003)(2616005)(486006)(8936002)(446003)(52116002)(2501003)(14444005)(71200400001)(44832011)(71190400001)(8676002)(81166006)(81156014)(66066001)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB0394;H:HE1PR08MB1066.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: hibox.tv does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XEiC4Pdf+7dBQCZGzMYc7nur7ozvHgZyF3cGP2azwZaMNAeG4ytYTjm5msCy/pWqboGcOlivueRpYj3Exns3cHPf4PIiHNR5zvP6ol+Amvi/jflPREYUMx5x8ALq9MlLhQeZoeh0wB3qi2rcDX1zJOxBnz5qCd43RsBM/k6hzx4dV7n54jzI61Jg4XwT368XDL4djY3O3zvxZ+RePQydCTO0v4CQL3K1Lj6DlgEFQYJMqXhtzyFFA+FIvY53AaCmjK9Mx96E6s4KsO2/PyhGY3czPx4asUBzAkTxd0etHGe9SVkmGIQa12nTosShelZo42nXKPagW8vmlC0D8MqfaIPKSmlbcEwqeWBdXyzVTws=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA55BFD65374CB47A49C06A876205880@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hibox.tv
X-MS-Exchange-CrossTenant-Network-Message-Id: 647db617-d914-4830-45c2-08d65381c458
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 09:30:13.3103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eec7d2e0-55d2-4f5e-ac15-00bd4e779ed6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB0394
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gMTEvMTMvMTggMToyMiBBTSwgYnJpYW4gbS4gY2FybHNvbiB3cm90ZToNCj4gVGhpcyBpcyBn
b2luZyB0byB0b3RhbGx5IGhvc2UgYXV0b21hdGlvbi4gIE15IGxhc3Qgam9iIGhhZCBmaWxlcyB3
aGljaA0KPiBtaWdodCBtb3ZlIGZyb20gdHJhY2tlZCB0byB1bnRyYWNrZWQgKGEgZmlsZSB0aGF0
IGhhZCBiZWNvbWUgZ2VuZXJhdGVkKSwNCj4gYW5kIGxvbmctcnVubmluZyBDSSBhbmQgYnVpbGQg
c3lzdGVtcyB3b3VsZCBuZWVkIHRvIGJlIGFibGUgdG8gY2hlY2sgb3V0DQo+IG9uZSBzdGF0dXMg
YW5kIHN3aXRjaCB0byB0aGUgb3RoZXIuICBZb3VyIHByb3Bvc2VkIGNoYW5nZSB3aWxsIHByZXZl
bnQNCj4gdGhvc2Ugc3lzdGVtcyBmcm9tIHdvcmtpbmcsIHdoZXJlYXMgdGhleSBwcmV2aW91c2x5
IGRpZC4NCj4gDQo+IEkgYWdyZWUgdGhhdCB5b3VyIHByb3Bvc2FsIHdvdWxkIGhhdmUgYmVlbiBh
IGJldHRlciBkZXNpZ24gb3JpZ2luYWxseSwNCj4gYnV0IGJyZWFraW5nIHRoZSB3YXkgYXV0b21h
dGVkIHN5c3RlbXMgY3VycmVudGx5IHdvcmsgaXMgcHJvYmFibHkgZ29pbmcNCj4gdG8gYmUgYSBk
ZWFsYnJlYWtlci4NCg0KSG93IGFib3V0IHNvbWV0aGluZyBsaWtlIHRoaXM6DQoNCjEuIEludHJv
ZHVjZSBhIGNvbmNlcHQgd2l0aCAiZ2FyYmFnZSIgZmlsZXMsIHdoaWNoIGdpdCBpcyAicGVybWl0
dGVkIHRvIA0KZGVsZXRlIiB3aXRob3V0IHByb21wdGluZy4NCg0KMi4gUmV0YWluIHRoZSBjdXJy
ZW50IGRlZmF1bHQsIGkuZS4gImlnbm9yZWQgZmlsZXMgYXJlIGdhcmJhZ2UiIGZvciBub3csIA0K
bWFraW5nIHRoZSBuZXcgYmVoYXZpb3IgX29wdCBpbl8gdG8gYXZvaWQgYnJlYWtpbmcgYXV0b21h
dGVkIA0Kc3lzdGVtcy9leGlzdGluZyBzY3JpcHRzIGZvciBhbnlvbmUuIFB1dCB0aGUgc2V0dGlu
ZyBmb3IgdGhpcyBiZWhpbmQgYSANCm5ldyBjb3JlLiogY29uZmlnIGZsYWcuDQoNCjMuIEluIHRo
ZSBwbGFuIGZvciB2ZXJzaW9uIDMuMCAoYSBuZXcgbWFqb3IgdmVyc2lvbiB3aGVyZSBzb21lIGJy
ZWFrYWdlIA0KY2FuIGJlIHRvbGVyYWJsZSwgYWNjb3JkaW5nIHRvIFNlbWFudGljIFZlcnNpb25p
bmcpLCBjaGFuZ2UgdGhlIGRlZmF1bHQgDQpzbyB0aGF0ICJvbmx5IGV4cGxpY2l0IGdhcmJhZ2Ug
aXMgZ2FyYmFnZSIuIEluY2x1ZGUgdmVyeSBjbGVhciBub3RpY2VzIA0Kb2YgdGhpcyBpbiB0aGUg
cmVsZWFzZSBub3Rlcy4gVGhlIGNvbmZpZyBmbGFnIGlzIHJldGFpbmVkLCBidXQgaXRzIA0KZGVm
YXVsdCBjaGFuZ2VzIGZyb20gdHJ1ZS0+ZmFsc2Ugb3IgdmljZSB2ZXJzYS4gUGVvcGxlIHdobyBk
aXNsaWtlIHRoZSANCm5ldyBiZWhhdmlvciBjYW4gZWFzaWx5IGNoYW5nZSBiYWNrIHRvIHRoZSAy
Lnggc2VtYW50aWNzLg0KDQpXb3VsZCB0aGlzIGJlIGEgcmVhc29uYWJsZSBjb21wcm9taXNlIGZv
ciBldmVyeWJvZHk/DQotLSANClBlciBMdW5kYmVyZw0KDQo=
