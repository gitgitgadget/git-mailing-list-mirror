Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C28D1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 01:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfBEBgh (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 20:36:37 -0500
Received: from mail-eopbgr660135.outbound.protection.outlook.com ([40.107.66.135]:29807
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbfBEBgg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 20:36:36 -0500
Received: from YQXPR0101MB0982.CANPRD01.PROD.OUTLOOK.COM (52.132.76.159) by
 YQXPR0101MB2181.CANPRD01.PROD.OUTLOOK.COM (52.132.79.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 5 Feb 2019 01:36:34 +0000
Received: from YQXPR0101MB0982.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9d8c:8e72:e4c5:9735]) by YQXPR0101MB0982.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9d8c:8e72:e4c5:9735%3]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 01:36:34 +0000
From:   Dan McGregor <dkm560@usask.ca>
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
CC:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "McGregor, Dan" <dan.mcgregor@usask.ca>,
        Git Mailing List <git@vger.kernel.org>,
        Masaya Suzuki <masayasuzuki@google.com>
Subject: Re: [PATCH] http: cast result to FILE *
Thread-Topic: [PATCH] http: cast result to FILE *
Thread-Index: AQHUumSeadjFf7YR50CzHy93S2cl/KXLcj9agADrwwCAAytJAIAAB+MAgABj/XKAAHx8gA==
Date:   Tue, 5 Feb 2019 01:36:34 +0000
Message-ID: <49B9198C-53E5-42BD-8834-B1EDEB3332CB@usask.ca>
References: <20190201193004.88736-1-dan.mcgregor@usask.ca>
 <xmqqr2crxl7o.fsf@gitster-ct.c.googlers.com>
 <CACsJy8B_=qbeimp5=RS-r2gwEjVV9rDE_2_tk_DDqz6rJazvFw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1902041243220.41@tvgsbejvaqbjf.bet>
 <CACsJy8BtaxMRTG4-r3iJfUuR9k-=r=4QTRxCkFt3k3p7826Z9A@mail.gmail.com>
 <xmqq1s4nwhjl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1s4nwhjl.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::19) To YQXPR0101MB0982.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dan.mcgregor@usask.ca; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [207.195.86.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YQXPR0101MB2181;6:n4mBG3otP8MIZDMtt3W1U12oB6D+zg04bKvkuSeNe16EAzJ69o9HbYZM6PxEHKFg271NCSbq+fFdW2GKGh24ZUvzxTgy23xD+XQU/lTCgAdUybm6qR8tiStz5ELiuRCeWzc54LhFT1NLPB6jrecumX05uyvWHwYZRH21LvT1JHEVyU0h6V+lyN8VQ9+0C60IOn0y2hajq0t4FyRwz267uFpJ5LOr9TEjRkVK+qTvW/H2+ZRxIIZ6HRIHw2ZHsZ9/oLd5aFH4gB7jRAfNYXjK3N1nPovOoxZh/sNd2LrmIHoXODcoi+JqpK0KfuvW478ogRaQuPONfY2ohn7LPuny/AnNoxZ/4iPcT0ldHZ8/aMa26m5P9FrFMtU03btuft5wqB5v9uMHBFYpP8wHflxqEq6Ycp4Ycv3IqssaFdTj7X62xpubd8HZEoDJF4dT/NyRhiMzSEfI0kRRJb/9jk/U5g==;5:jduGynYoFFfKsQZGeFZqsOt3aY2WjMHLQd3XACn+PB1CptFHtrPkg86cREgJ0vBt5nylaX7BiWjlEL2kEKhPxA1ubFLPIDDQe+OvkELv2Qj/fH3UacJoooYcSGV/vKPmzcZB9f7gBBshJdNW3Mdh8GYGbSFz3wvqnYSCY15lUPaOzetYqp36C08/hDei5/dLCJS4yRkqaP4XsH5WQ9TsOA==;7:5Q5S8d0EPgEC5PPrdom6UM+3nbCHm7knU0HNuGN6m3vmlEq0UuCfiZ9DocK6JlcEWQ8Sekf7xlNmX2/+19mvftawLrNXSFMpiAnXpaBPV65eJ73JfkrRmiHIMRZ/KxfTXFKHuaT3SEk83T0oz9MyAw==
x-ms-office365-filtering-correlation-id: 9f32b9d1-e26d-4bce-6803-08d68b0a5cc8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:YQXPR0101MB2181;
x-ms-traffictypediagnostic: YQXPR0101MB2181:
x-uofs-origin: Internal
x-microsoft-antispam-prvs: <YQXPR0101MB21811F22EDE82A5258DD606AE86E0@YQXPR0101MB2181.CANPRD01.PROD.OUTLOOK.COM>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(376002)(39860400002)(396003)(199004)(189003)(106356001)(83716004)(82746002)(71190400001)(6486002)(4326008)(71200400001)(25786009)(478600001)(66066001)(6512007)(6436002)(229853002)(105586002)(14454004)(33656002)(93886005)(6506007)(486006)(8936002)(74482002)(6246003)(110136005)(81166006)(8676002)(54906003)(68736007)(786003)(53936002)(2616005)(476003)(446003)(26005)(256004)(186003)(316002)(11346002)(52116002)(36756003)(2906002)(305945005)(386003)(6116002)(102836004)(3846002)(76176011)(81156014)(7736002)(97736004)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:YQXPR0101MB2181;H:YQXPR0101MB0982.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: usask.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nbUbqRSyftyRRQ2yTiODtHsApcFsxQ1yZp+4zwdhIYKT8RylrDClXKrE2erdIpWexq93Bl6hXwLtJwrzXM8OaIImgS+ufSnRDNazgjTr37cp25DjMwk70Gcyt6EE95T7T1Kdyc8I1RGrFYlrEb4Xz6iVmp5XlyQFLLkalDoChkTmY5xtr4Gn+Kr6T5845N286n6MM/n1pD/XhzYUnY5FBxF8sxrs3/fnuJYL6Akd2a33C0uqMcKrTCAphORVJLL+hK8yQN0eDxVRGxMUa3Vc8bTX51UqAqarTqAMyoH4fcO63f87UA3Frq/BBr5WA/XPbUxJROaABJqRHdyV1hkNNgdDc8qsXLvvue8D1ylvFMmRz8NCD7wbdQvDtibhArcu12cxByZJsI48tGjXZHGvGclaRb7G+P4Uay6omcfN8Oc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD8BA715E2B2F941A8BD1BF5B70B7078@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: usask.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f32b9d1-e26d-4bce-6803-08d68b0a5cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 01:36:33.9483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 24ab6cd0-487e-4722-9bc3-da9c4232776c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB2181
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCk9uIEZlYnJ1YXJ5IDQsIDIwMTkgMTI6MTA6NTQgcC5tLiBDU1QsIEp1bmlvIEMgSGFtYW5v
IDxnaXRzdGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+RHV5IE5ndXllbiA8cGNsb3Vkc0BnbWFpbC5j
b20+IHdyaXRlczoNCj4NCj4+PiBUaGUgZGlzYWR2YW50YWdlLCBvZiBjb3Vyc2UsIHdvdWxkIGJl
IHRoYXQgb3RoZXIgY2FsbCBzaXRlcyB3b3VsZA0KPm5vdA0KPj4+IGJlbmVmaXQgZnJvbSBhIG1h
bnVhbCBhdWRpdGluZyB3aGV0aGVyIHRoZSBhcmd1bWVudCBoYXMgc2lkZSBlZmZlY3RzDQo+KGFu
ZA0KPj4+IHRodXMsIHdoZXRoZXIgYSBtYWNybyB1c2luZyB0aGUgYXJndW1lbnQgbXVsdGlwbGUg
dGltZXMgd291bGQgcmVzdWx0DQo+aW4NCj4+PiB2ZXJ5IHVuZXhwZWN0ZWQgbXVsdGlwbGUgc2lk
ZSBlZmZlY3RzKS4NCj4+DQo+PiBUaGF0J3MganVzdCBhIGJldHRlciByZWFzb24gdG8gImZpeCIg
aXQgaW4gY29tcGF0Ly4gSWYgeW91IGRlZmluZSBhDQo+PiBnaXRfZmlsZW5vKCkgZnVuY3Rpb24g
YW5kIG1hcCBmaWxlbm8gdG8gaXQsIHRoZW4geW91IHdvbid0IGhhdmUgdG8NCj4+IGRlYWwgd2l0
aCBzaWRlIGVmZmVjdHMgb2YgRnJlZUJTRCdzIGZpbGVubygpIG1hY3JvLiBBbGwgZXZhbHVhdGlv
bg0KPj4gaGFwcGVucyBiZWZvcmUgZ2l0X2ZpbGVubygpIGlzIGNhbGxlZC4NCj4NCj5IbXBoLCBz
byB0aGUgaWRlYSBpcyB0byBoYXZlDQo+DQo+CS8qIGRvIG5vdCBpbmNsdWRlIGdpdC1jb21wYXQt
dXRpbC5oIGhlcmUgKi8NCj4JaW50IHdyYXBwZWRfZmlsZW5vKEZJTEUgKmYpDQo+CXsNCj4JCXJl
dHVybiBmaWxlbm8oZik7DQo+CX0NCj4NCj5pbiBjb21wYXQvZmlsZW5vLmMgYW5kIHRoZW4gZG8g
c29tZXRoaW5nIGxpa2UgdGhpcw0KPg0KPgkjaWZkZWYgZmlsZW5vDQo+CSN1bmRlZiBmaWxlbm8N
Cj4JI2RlZmluZSBmaWxlbm8oeCkgd3JhcHBlZF9maWxlbm8oeCkNCj4JI2VuZGlmDQo+DQo+Zm9y
IEZyZWVCU0QgaW4gZ2l0LWNvbXBhdC11dGlsLmggb3Igc29tZXRoaW5nIGxpa2UgdGhhdD8NCj4N
Cj5JIHRoaW5rIEkgY2FuIGJ1eSB0aGF0Lg0KDQpXb3JrcyBmb3IgbWUgdG9vLiBGcmVlQlNEJ3Mg
bm90IGFsb25lIGluIHRoaXMsIGVpdGhlci4gSXQgbG9va3MgbGlrZSBOZXRCU0QgZG9lcyB0aGUg
c2FtZSB0aGluZy4NCkknbGwgc2VuZCBhIHYyIHRvbW9ycm93Lg0K
