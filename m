Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4135B1F461
	for <e@80x24.org>; Sun,  8 Sep 2019 14:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfIHOSW (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 10:18:22 -0400
Received: from mail-eopbgr680041.outbound.protection.outlook.com ([40.107.68.41]:49862
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727006AbfIHOSW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 10:18:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExZpC0dGqZhavGE8hWBwC2DW6ciH46Byjse4WZp/SQFoBK0mEIFKa7zrnJ0pDqMtHcIefsU5HOS+JmUh1gU11PfAEJvUZd11LqKx1AwT7k6WwMn6VBOV/Uhg3JgJHpOOrdL4gB5nJ3lib8R1N1crxWE8MyINoCghpmTErRQI9K5iPKYPQv8mmNSNRPr5YtISTZaQGJiNrrHOzdnmt6ypPc+lgd5DeGV+dYUyeGgGw3Vz4xc6kl3gBz8xewXJyI1J5ynQR69MToH5sU//1XKg3RLaAPxmWQtNn/WilQUSr2yL9ej9XhqP+J4ZUzmlsRuM/NGjfIvZkwJ6AaQ1SPw50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzuJExVw20L2ULHAUX0/YyajYrXHQb+2NmY9w3FqnzM=;
 b=E3U8RdrQBjjof8MLtfmKR3eMMoq0UcQYGgOS3TgpM+0ophUXRu819Q+ArJErYeTZ535Q0FvrCaLk7IVvxIdeoYwCU4PpgSCPjdyaOj23sqYJehtXCaks+jIZx3jU8e5QKcVRRNigO7clSJgWFLVacgRdbuluAzr5Y11R3aPU1cIx4KYMrjBZ226zo/yatBUd1jgyp7mXWqDykM5ej9jfLrDb0Naa77OOc2WWV2duw6WOIHUfAoz2WYcZLvBWn4oCPcMrkc13LkpOPiuwoJOM7mlyS/hhi7v8gmx5eK1BtYdmrjUFHbIvhF2jE73xBezSXJYc1p3kGIjbnW3pehQOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzuJExVw20L2ULHAUX0/YyajYrXHQb+2NmY9w3FqnzM=;
 b=lc3G0Dl2BjtBIh9ZgSFS6U3mutBZCbK4bFVkVBHEOH0uHxmDnoTSDOOhipfqBJGYH0179O0Zon7phPJRC42dc0bc2c/9mixf+3HtwTU1oPrCwYbs64JZ+HPObFEc4hUsHEXCX0KF+fF3BIy6SqPflALwSrxVLow1hZLGrn32wV8=
Received: from BN8PR15MB3025.namprd15.prod.outlook.com (20.178.219.157) by
 BN8PR15MB3250.namprd15.prod.outlook.com (20.179.74.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Sun, 8 Sep 2019 14:18:16 +0000
Received: from BN8PR15MB3025.namprd15.prod.outlook.com
 ([fe80::e8c3:511d:a644:8789]) by BN8PR15MB3025.namprd15.prod.outlook.com
 ([fe80::e8c3:511d:a644:8789%7]) with mapi id 15.20.2241.018; Sun, 8 Sep 2019
 14:18:16 +0000
From:   Douglas Graham <douglas.graham@ericsson.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: O_NONBLOCK: should I blame git or ssh?
Thread-Topic: O_NONBLOCK: should I blame git or ssh?
Thread-Index: AdVl0BxXRbD448LvQ7CYoSk6Z4FLzQAYBIIAAAXk0/A=
Date:   Sun, 8 Sep 2019 14:18:15 +0000
Message-ID: <BN8PR15MB302520248BB1AD49B28C3AB3F0B40@BN8PR15MB3025.namprd15.prod.outlook.com>
References: <BN8PR15MB302515278334F3BD7B63D519F0B50@BN8PR15MB3025.namprd15.prod.outlook.com>
 <20190908102839.GC15641@sigill.intra.peff.net>
In-Reply-To: <20190908102839.GC15641@sigill.intra.peff.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=douglas.graham@ericsson.com; 
x-originating-ip: [142.112.214.127]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db9ec43b-27a7-4b9f-4b58-08d734676411
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB3250;
x-ms-traffictypediagnostic: BN8PR15MB3250:
x-microsoft-antispam-prvs: <BN8PR15MB325023BAE3A78D17FA528C7EF0B40@BN8PR15MB3250.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0154C61618
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(136003)(366004)(376002)(346002)(189003)(199004)(54094003)(102836004)(25786009)(66066001)(76116006)(52536014)(71190400001)(71200400001)(11346002)(446003)(76176011)(6436002)(55016002)(99286004)(66946007)(7736002)(81156014)(81166006)(8936002)(6246003)(14454004)(6506007)(66476007)(66556008)(8676002)(7696005)(74316002)(476003)(305945005)(316002)(6916009)(53936002)(4326008)(186003)(44832011)(229853002)(2906002)(6116002)(3846002)(14444005)(256004)(64756008)(66446008)(33656002)(486006)(9686003)(86362001)(5660300002)(478600001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR15MB3250;H:BN8PR15MB3025.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6bdP0cVu4i7gw3eolq8P7DN4q7Kb0Wbz3P02OM8h/ZjVn2PIhDz+VAzGJXZ/BkHM5hzG4PpWyuQrmaEya5osBksKSwyyKaIGsBbZrAGaVB783rjq8pRoc1zkYWNgTx+XAdy8781vM1eu/iRyo82P5wRYL5uNBeK04of5vg9qrU9z1VcJn8BVXc2/CZu3vH672PqdxwxxBPok3ahlENp7lZxnIitAQC9Xr122SD9A5U88P0fyoNKDGpobpkzE+2JiwpmrZBauwm9RalTVjqVJs7wxkJuT98NRgqlYMOqAodh5GfHQGtvFSmj0XYxbsKybLakZwvuMAcwLin0pRM1SV2s9HLreA/Yvehq2qYilDOCrMv7a/JoGqh4xdiizxBmVIHMYy24D1e1/p+9fQqruWHvM8qstHcd78d3XyuijTiA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9ec43b-27a7-4b9f-4b58-08d734676411
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2019 14:18:15.6328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UDQ3pdR5ohhPe9UqFXVvLt8XwH6JDoSv4phoQUgAWuOqT/b+geyzApgHNJyYQvzM1kZJZsIDADuZeGzqbfQ0Xj2ly3kGz8YBAjqkZnXej8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3250
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGZvciBnaXZpbmcgdGhpcyBzb21lIHRob3VnaHQuDQoNCj4gSSBkb24ndCB0aGluayB0
aGlzIGNhbiBkaXJlY3RseSBiZSB0aGUgY3VscHJpdCwgYmVjYXVzZSB0aGF0IHNzaCdzIHN0ZG91
dCB3aWxsIGJlDQo+IGhvb2tlZCB0byBhIHBpcGUgdGFsa2luZyB0byBHaXQsIG5vdCB0byB0aGUg
b3JpZ2luYWwgc3Rkb3V0IG9mICJnaXQgZmV0Y2giLiBJdA0KPiBzaG91bGQgbm90IGhhdmUgZXZl
biByZWNlaXZlZCBhIGRlc2NyaXB0b3IgdGhhdCBpcyBhIGNvcHkgb2YgdGhlIG9yaWdpbmFsDQo+
IHN0ZG91dCAobm9yIHN0ZGluKSwgc2luY2UgdGhvc2Ugd291bGQgaGF2ZSBiZWVuIGNsb3NlZCBh
cyBwYXJ0IG9mIHRoZQ0KPiBmb3JrK2V4ZWMuDQo+IA0KPiBUaGUgY2hpbGQgc3NoIF9kb2VzXyBo
YXZlIGFjY2VzcyB0byB0aGUgb3JpZ2luYWwgc3RkZXJyLCB3aGljaCBjb3VsZCBwbGF1c2libHkN
Cj4gYmUgYSBkdXAgb2YgdGhlIG9yaWdpbmFsIHN0ZG91dC4gQnV0IHlvdXIgc3RyYWNlIHNob3dz
IHNzaCBzZXR0aW5nIHRoZSBmbGFnDQo+IG9ubHkgZm9yIHN0ZGluL3N0ZG91dC4NCg0KSSB3b25k
ZXJlZCBhYm91dCB0aGF0IHRvby4gIEkgYWxzbyB3b25kZXJlZCB3aHkgd2Ugb25seSBoYXZlIHRo
aXMgcHJvYmxlbQ0Kd2hlbiBkb2luZyBidWlsZHMgd2l0aCBKZW5raW5zLiAgVGhlIHNhbWUgZXJy
b3IgaGFzIG5ldmVyIGhhcHBlbmVkIHdoZW4gZG9pbmcNCmJ1aWxkcyBtYW51YWxseSBhcyBmYXIg
YXMgSSBrbm93LiAgSG93ZXZlciwgc3RyYWNpbmcgdGhlIGJ1aWxkIHdoaWxlIGl0IGlzDQpydW5u
aW5nIHVuZGVyIEplbmtpbnMgaXMgZGlmZmljdWx0LCBzbyBteSBzdHJhY2Ugb3V0cHV0IGlzIGZy
b20gYSBtYW51YWwgcnVuLg0KSXQgdHVybnMgb3V0IHRoYXQgc3NoIG9ubHkgc2V0cyBub24tYmxv
Y2tpbmcgbW9kZSBvbiBhIGRlc2NyaXB0b3IgaWYgdGhhdA0KZGVzY3JpcHRvciBkb2VzIG5vdCBy
ZWZlciB0byBhIFRUWS4gIFRoZSBjb2RlIGluIGZ1bmN0aW9uIHNzaF9zZXNzaW9uMl9vcGVuKCkN
Cmxvb2tzIGxpa2U6DQoNCiAgICAgICAgaWYgKHN0ZGluX251bGxfZmxhZykgew0KICAgICAgICAg
ICAgICAgIGluID0gb3BlbihfUEFUSF9ERVZOVUxMLCBPX1JET05MWSk7DQogICAgICAgIH0gZWxz
ZSB7DQogICAgICAgICAgICAgICAgaW4gPSBkdXAoU1RESU5fRklMRU5PKTsNCiAgICAgICAgfQ0K
ICAgICAgICBvdXQgPSBkdXAoU1RET1VUX0ZJTEVOTyk7DQogICAgICAgIGVyciA9IGR1cChTVERF
UlJfRklMRU5PKTsNCg0KICAgICAgICAvKiBlbmFibGUgbm9uYmxvY2tpbmcgdW5sZXNzIHR0eSAq
Lw0KICAgICAgICBpZiAoIWlzYXR0eShpbikpDQogICAgICAgICAgICAgICAgc2V0X25vbmJsb2Nr
KGluKTsNCiAgICAgICAgaWYgKCFpc2F0dHkob3V0KSkNCiAgICAgICAgICAgICAgICBzZXRfbm9u
YmxvY2sob3V0KTsNCiAgICAgICAgaWYgKCFpc2F0dHkoZXJyKSkNCiAgICAgICAgICAgICAgICBz
ZXRfbm9uYmxvY2soZXJyKTsNCg0KV2hlbiBJIGNvbGxlY3RlZCB0aGF0IHN0cmFjZSBvdXRwdXQs
IEkgaGFkIHN0ZG91dCByZWRpcmVjdGVkIHRvIGEgcGlwZSB0byBteQ0Kd29ya2Fyb3VuZCBwcm9n
cmFtLCBidXQgSSBkaWQgbm90IHJlZGlyZWN0IHN0ZGVyci4gIFNvIHNzaCBtYWRlIHN0ZG91dCBu
b24tYmxvY2tpbmcsDQpidXQgc2luY2Ugc3RkZXJyIHdhcyBzdGlsbCBjb25uZWN0ZWQgdG8gbXkg
dGVybWluYWwsIGl0IGRpZG4ndCB0b3VjaCB0aGF0LiBCdXQgd2hlbg0KdGhpcyBidWlsZCBpcyBy
dW4gdW5kZXIgSmVua2lucywgYm90aCBzdGRvdXQgYW5kIHN0ZGVyciBhcmUgY29ubmVjdGVkIHRv
IGEgcGlwZSB0aGF0DQpKZW5raW5zIGNyZWF0ZXMgdG8gY29sbGVjdCBvdXRwdXQgZnJvbSB0aGUg
YnVpbGQuIEkgYXNzdW1lIHRoYXQgd2hlbiBnaXQgcnVucyBzc2gsIGl0DQpkb2VzIG5vdCByZWRp
cmVjdCBzc2gncyBzdGRlcnIgdG8gaXRzIG93biBwaXBlLCBpdCBvbmx5IHJlZGlyZWN0cyBzdGRv
dXQuIFNvIEkgdGhpbmsNCnNzaCB3aWxsIGJlIG1lc3Npbmcgd2l0aCBib3RoIHBpcGVzIHdoZW4g
dGhpcyBidWlsZCBpcyBydW4gdW5kZXIgSmVua2lucy4NCg0KTm93IHRoYXQgSSBoYXZlIGEgZmFp
cmx5IGdvb2QgdW5kZXJzdGFuZGluZyBvZiB3aGF0J3MgaGFwcGVuaW5nLCBJIHRoaW5rIEkgY2Fu
IHdvcmsNCmFyb3VuZCB0aGlzIG9jY2FzaW9uYWwgZXJyb3IgYnkgcmVkaXJlY3RpbmcgZ2l0J3Mg
c3RkZXJyIHRvIGEgZmlsZSBvciBzb21ldGhpbmcgbGlrZQ0KdGhhdCwgYnV0IGl0J3MgdGFrZW4g
dXMgYSBsb25nIHRpbWUgdG8gZmlndXJlIHRoaXMgb3V0LCBzbyBJIHdvbmRlciBpZiBhIG1vcmUg
cGVybWFuZW50DQpmaXggc2hvdWxkbid0IGJlIGltcGxlbWVudCwgc28gb3RoZXJzIGRvbid0IHJ1
biBpbnRvIHRoZSBzYW1lIHByb2JsZW0uICBBIGdvb2dsZSBmb3INCiJtYWtlOiB3cml0ZSBlcnJv
ciIgaW5kaWNhdGVzIHRoYXQgd2UncmUgbm90IHRoZSBmaXJzdCB0byBoYXZlIHRoaXMgcHJvYmxl
bSB3aXRoDQpwYXJhbGxlbCBidWlsZHMsIGFsdGhvdWdoIGluIHRoZSBvdGhlciBjYXNlcyBJJ3Zl
IGZvdW5kLCBhIHNwZWNpZmljIHZlcnNpb24gb2YgdGhlDQpMaW51eCBrZXJuZWwgd2FzIGJlaW5n
IGJsYW1lZC4gIE1heWJlIHRoYXQgd2FzIGEgZGlmZmVyZW50IHByb2JsZW0uDQoNCkkgZ3Vlc3Mg
Z2l0IGNvdWxkIHdvcmthcm91bmQgdGhpcyBieSByZWRpcmVjdGluZyBzdGRlcnIsIGJ1dCB0aGUg
cmVhbCBwcm9ibGVtIGlzIHByb2JhYmx5DQp3aXRoIHNzaCwgYWx0aG91Z2ggaXQncyBub3QgY2xl
YXIgdG8gbWUgd2hhdCBpdCBzaG91bGQgZG8gZGlmZmVyZW50bHkuIEl0IGRvZXMgc29tZQ0Kc29t
ZWhvdyBiYWNrd2FyZHMgdG8gbWUgdGhhdCB0aGF0IGl0IG9ubHkgbWFrZXMgYSBkZXNjcmlwdG9y
IG5vbi1ibG9ja2luZyBpZiBpdCBkb2Vzbid0DQpyZWZlciB0byBhIFRUWSwgYnV0IGl0IGRvZXMg
dGhlIHNhbWUgdGhpbmcgaW4gYXQgbGVhc3QgdGhyZWUgZGlmZmVyZW50IHBsYWNlcyBzbyBJIGd1
ZXNzDQp0aGF0J3MgIG5vdCBhIG1pc3Rha2UuDQo=
