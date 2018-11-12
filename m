Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FA8B1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 07:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeKLR1t (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 12:27:49 -0500
Received: from mail-eopbgr60101.outbound.protection.outlook.com ([40.107.6.101]:27072
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbeKLR1s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 12:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hiboxsystems.onmicrosoft.com; s=selector1-hibox-tv;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn5R1zyWOoXk+lN8FOuzCFhAod139hUcxaUd5Li6Q4U=;
 b=Kb8SwM3AxSfBS+K7JA4DlFSbESyJ/d9TMB3lkRmumTDbS//KpPZSzMu9A0mOTYxuO7wU5Zsls9jCCeU8Qus6MG5viDuPzoZbNGmHTi4YHjbxgKzRPw6QVqqVm2V9Pnv3TuoxoJfMO4aAGrOe+XHY8g8ESDO4L3W0taNnUT2n8wg=
Received: from HE1PR08MB1066.eurprd08.prod.outlook.com (10.166.125.152) by
 HE1PR08MB2906.eurprd08.prod.outlook.com (10.170.245.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Mon, 12 Nov 2018 07:35:29 +0000
Received: from HE1PR08MB1066.eurprd08.prod.outlook.com
 ([fe80::7d85:23d9:3be5:6345]) by HE1PR08MB1066.eurprd08.prod.outlook.com
 ([fe80::7d85:23d9:3be5:6345%7]) with mapi id 15.20.1294.044; Mon, 12 Nov 2018
 07:35:29 +0000
From:   Per Lundberg <per.lundberg@hibox.tv>
To:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>,
        "jost@tcs.ifi.lmu.de" <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@matthieu-moy.fr" <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
Thread-Topic: [RFC PATCH] Introduce "precious" file concept
Thread-Index: AQHUebrNrQJxbaGKnUecpgicPjXQo6VKtoSAgAEKlYA=
Date:   Mon, 12 Nov 2018 07:35:29 +0000
Message-ID: <591ab1f7-ef39-13e5-83b8-76fe372ecc2c@hibox.tv>
References: <875zxa6xzp.fsf@evledraar.gmail.com>
 <20181111095254.30473-1-pclouds@gmail.com>
 <871s7r4wuv.fsf@evledraar.gmail.com>
 <CACsJy8CYpuc7-CZhk7kQQVQFxOfLFZu4TVpG=b0a7j8P1J394Q@mail.gmail.com>
In-Reply-To: <CACsJy8CYpuc7-CZhk7kQQVQFxOfLFZu4TVpG=b0a7j8P1J394Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0003.eurprd03.prod.outlook.com
 (2603:10a6:3:76::13) To HE1PR08MB1066.eurprd08.prod.outlook.com
 (2a01:111:e400:c524::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=per.lundberg@hibox.tv; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.94.0.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR08MB2906;6:w/PZ1i3+9EboCrSciit3TutqqEvvZO+Ofk5ZZQWL0WTsibUaOvOa1SyPoEAfNJhTrE+ndfHiWD/uHsHc2j1OGIZBkiu6TCU1Y2hmDY8sVxLC+TF3lWPATKN2cRgB/Ww8cCjA2iXgU/cVVP3TaAYyaG/LpuKF6OYlD32sQ4npaklP6jTXn4nXZicGTSX68sTrIYxVO+x9dYo640cRfgZzyqAOViBgtpqYgmplHRQwYuHSQDjcc7nGMPWljFgNI5msXsen2NVOHXmgpHf5cEuy9DnH1kEpK5bGTgISKjnOXbFow/PZZkKv36RUzOrrtWgaz5ZR7kHfp/mklQHkEMl7UjCJXyLCToRNmKw5EeHLj5QqeizjQblLpOKkLpgg1NUFg4M74/fHqNAMWJWRWbDwsgwmIVovWV/AUm4Se5jK50YHljSedx3gXemeeA0HGwaj9HyikB4uw03pNTSZ5CaDjg==;5:CQ1VnywMfVaTexQmR5iY7g/9qvasyvcFixyVNMIWOcENpA4Xnx2LaXM+xcEkz82qPRbDtn5pLyYV1UC7tFtnVPCawgZaQUakW2IdCpXJwLoMr68xAPsk58SBVfDdqPC75azjToOFvyYNFZJKADgiNwyc3VlREfm3DUnukB/cJ1w=;7:utKse1SG7HALW/IvF7LxOn1QucaLCj3HQbvkZB3L1dIr7wlPSFYKG01j9L/JtFK2r80R/rH8zQnWDgTGxO/7tH+hX+3z0yLzilGoU80/PwEipDsNvRpdgEsiu1luumEaa+2+8qytt6XirpRUaqbhWQ==
x-ms-office365-filtering-correlation-id: 2fdf6c92-bfb0-4f85-df29-08d648716b2a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR08MB2906;
x-ms-traffictypediagnostic: HE1PR08MB2906:
x-microsoft-antispam-prvs: <HE1PR08MB29066D6B00844000F5355115EAC10@HE1PR08MB2906.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231382)(944501410)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:HE1PR08MB2906;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB2906;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39830400003)(376002)(346002)(189003)(199004)(8676002)(26005)(5660300001)(6246003)(186003)(102836004)(2900100001)(3846002)(386003)(6116002)(6506007)(305945005)(2906002)(7736002)(53546011)(106356001)(105586002)(81166006)(68736007)(6486002)(508600001)(53936002)(39060400002)(81156014)(6436002)(486006)(71200400001)(7416002)(25786009)(31686004)(6512007)(446003)(86362001)(36756003)(14454004)(8936002)(4326008)(52116002)(11346002)(93886005)(110136005)(97736004)(31696002)(71190400001)(229853002)(256004)(44832011)(66574009)(76176011)(14444005)(2616005)(54906003)(476003)(74482002)(99286004)(316002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB2906;H:HE1PR08MB1066.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: hibox.tv does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5pl0kqApcX0E5NKoIspwb9usR3e2jW4qG2cI/DvQgBprQNZUB2mzmsNCIG8wqD0/5fKuyLOX7K1aJvFtbGvgNgWoxwhltUgAWfMFGbk5REVnLZD91IHgzP5c431LZxbEvMh65OAtHUAr2j0lvckkeWXZbKv3F5xVdMXzRoZtYpDxTIY6kcSljUcD85GyT3VaIsm8j4hIaGRiqfWDvNpWw48C7ZgZHnxmXDB9gqtGnwD6HwjVLGcv9JyB/x4KnJDlu+uldpf8510sZKRo6AkTLJGuo/Q3Dmk6dQuEHipL13ivHAOPG8lD7zMM4z27v8W8KPi5rvCBu6juvCDP1oTM8oFBJnP4o3g9WyNN4o+dJ74=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <954D63ED06CDDD49832A7C63B7966C07@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hibox.tv
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdf6c92-bfb0-4f85-df29-08d648716b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 07:35:29.1334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eec7d2e0-55d2-4f5e-ac15-00bd4e779ed6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2906
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gMTEvMTEvMTggNTo0MSBQTSwgRHV5IE5ndXllbiB3cm90ZToNCj4gT24gU3VuLCBOb3YgMTEs
IDIwMTggYXQgMTozMyBQTSDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbg0KPiA8YXZhcmFiQGdt
YWlsLmNvbT4gd3JvdGU6DQogPg0KPj4gVGhhdCB3aWxsIGxvc2Ugbm8gZGF0YSwgYW5kIGluIHRo
ZSB2ZXJ5IHJhcmUgY2FzZXMgd2hlcmUgYSBjaGVja291dCBvZg0KPj4gdHJhY2tlZCBmaWxlcyB3
b3VsZCBvdmVyd3JpdGUgYW4gaWdub3JlZCBwYXR0ZXJuLCB3ZSBjYW4ganVzdCBlcnJvciBvdXQN
Cj4+IChhcyB3ZSBkbyB3aXRoIHRoZSAiT2sgdG8gb3ZlcndyaXRlIiBicmFuY2ggcmVtb3ZlZCkg
YW5kIHRlbGwgdGhlIHVzZXINCj4+IHRvIGRlbGV0ZSB0aGUgZmlsZXMgdG8gcHJvY2VlZC4gDQo+
IFRoZXJlJ3MgYWxzbyB0aGUgb3RoZXIgc2lkZSBvZiB0aGUgY29pbi4gSWYgdGhpcyByZWZ1c2Ug
dG8gb3ZlcndyaXRlDQo+IHRyaWdnZXJzIHRvbyBvZnRlbiwgaXQgY2FuIGJlY29tZSBhbiBhbm5v
eWFuY2UuDQoNClN1cmUsIGJ1dCBkb2luZyAiZ2l0IGNoZWNrb3V0IC1mIHNvbWVfcmVmIiBpbnN0
ZWFkIG9mICJnaXQgY2hlY2tvdXQgDQpzb21lX3JlZiIgaXNuJ3QgcmVhbGx5IF90aGF0XyBhbm5v
eWluZywgaXMgaXQ/IEkgdGhpbmssIHBlb3BsZSAoYmVjYXVzZSANCm9mIG5vdCBoYXZpbmcgcmVh
ZC9zdHVkaWVkIHRoZSAuZ2l0aWdub3JlIHNlbWFudGljcyB3ZWxsIGVub3VnaCkgaGF2aW5nIA0K
dGhlaXIgZmlsZXMgYmVpbmcgb3ZlcndyaXR0ZW4gX3dpdGhvdXQgcmVhbGl6aW5nIGl0XyBpcyBh
IGJpZ2dlciBkYW5nZXIuIA0KQnV0IG9idmlvdXNseSB0aGVyZSBpcyBhIGJpdCBvZiB0cmVhZGlu
ZyBhIHRoaW4gbGluZSBoZXJlLg0KDQpJZiB3ZSBmZWVsIHRocmFzaGFibGUgaXMgc3RyZXRjaGlu
ZyBpdCB0b28gZmFyICh3aGljaCBJIGRvbid0IHRoaW5rIGl0IA0KaXMpLCB3ZSBjb3VsZCBhZGQg
YSAiY29yZS5pZ25vcmVfZmlsZXNfYXJlX3RyYXNoYWJsZSIgc2V0dGluZyB0aGF0IA0KYnJpbmdz
IGJhY2sgdGhlIG9sZCBzZW1hbnRpY3MsIGZvciB0aG9zZSB3aG8gaGF2ZSBhIHN0cm9uZyBmZWVs
aW5nIGFib3V0IGl0Lg0KDQpJdCdzIGFsc28gcXVpdGUgcG9zc2libGUgdG8gZG8gaXQgdGhlIG90
aGVyIHdheSBhcm91bmQgLSBpLmUuIHNldCANCiJjb3JlLmlnbm9yZV9maWxlc19hcmVfdHJhc2hh
YmxlIiB0byB0cnVlIGJ5IGRlZmF1bHQsIGFuZCBsZXQgdGhlICJuZXciIA0KYmVoYXZpb3IgYmUg
b3B0LWluLiBIb3dldmVyLCB0aGlzIG1pZ2h0ICJtaXNzIHRoZSBtYXJrIiBpbiB0aGF0IHRob3Nl
IA0KcGVvcGxlIHdobyB3b3VsZCByZWFsbHkgYmVuZWZpdCBmcm9tIHRoZSBuZXcgc2VtYW50aWNz
IG1pZ2h0IG1pc3MgdGhpcyANCnNldHRpbmcsIGp1c3QgbGlrZSB0aGV5IGNvdWxkIHJpc2sgbWlz
c2luZyB0aGUgInByZWNpb3VzIiBzZXR0aW5nLg0KDQooSSBhbHNvIHRoaW5rICJ0cmFzaGFibGUi
IHNvdW5kcyBiZXR0ZXIgYW5kIGlzIG1vcmUgY2xlYXIgJiBwcmVjaXNlIHRoYW4gDQoicHJlY2lv
dXMiLCBmb3Igd2hhdGV2ZXIgdGhhdCBpcyB3b3J0aC4pDQotLQ0KUGVyIEx1bmRiZXJnDQo=
