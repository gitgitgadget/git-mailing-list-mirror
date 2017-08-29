Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5C5208DB
	for <e@80x24.org>; Tue, 29 Aug 2017 15:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbdH2P6D (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 11:58:03 -0400
Received: from mail-sn1nam01on0131.outbound.protection.outlook.com ([104.47.32.131]:60544
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752195AbdH2P6C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 11:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=g/vY5VB7V/mDWtOSnDL9ceuNwkBuUx3zPwW673OIJPE=;
 b=nVDz1wjYic/289JZqD4GZQT6HTlwJnE6ZKyX0aRjBC5a6Cip+tZ7+REWssF0fXY4nwNjEu2qcbFGsGGsYPgtgVu9nyO/RzRkuyW/Tzo5p0+ygR2aZB1t9I7DRRLOmJg0HcVwtftoFHdZ1Nmh8kfLuSxWJiLCICvT4C77e3LFN4c=
Received: from DM2PR21MB0041.namprd21.prod.outlook.com (10.161.140.19) by
 DM2PR21MB0041.namprd21.prod.outlook.com (10.161.140.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.13.0; Tue, 29 Aug 2017 15:58:00 +0000
Received: from DM2PR21MB0041.namprd21.prod.outlook.com
 ([fe80::bcf3:638e:5a6c:7b71]) by DM2PR21MB0041.namprd21.prod.outlook.com
 ([fe80::bcf3:638e:5a6c:7b71%14]) with mapi id 15.20.0013.006; Tue, 29 Aug
 2017 15:58:00 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: RE: [PATCH 2/3] merge-recursive: remove return value from
 get_files_dirs
Thread-Topic: [PATCH 2/3] merge-recursive: remove return value from
 get_files_dirs
Thread-Index: AQHTIDxhRhSD3SDfDEuSwdUmXi5caqKa/iUAgAB3dZA=
Date:   Tue, 29 Aug 2017 15:58:00 +0000
Message-ID: <DM2PR21MB0041575B6D9EE53A07C7D3EDB79F0@DM2PR21MB0041.namprd21.prod.outlook.com>
References: <20170828202829.3056-1-kewillf@microsoft.com>
 <20170828202829.3056-3-kewillf@microsoft.com>
 <20170829081752.nq5r776rjyf2amzh@sigill.intra.peff.net>
In-Reply-To: <20170829081752.nq5r776rjyf2amzh@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kewillf@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-08-29T09:57:58.5672277-06:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [174.126.250.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR21MB0041;6:bbIqCCh1qlM+YtbeAnU1Q5kqP7Z92ua5nLp9OC3obRXk43nIAa3j6uOmQlxPgAXNytCF3bDLBNIfPvZXXcEk9ry54pg0uVY9M1mcpDR+P1qK0OuwBPYzaISvYIxdtz820MIupXXkBJhZ8ssbYoX9rjZ+KDqAJQFe0oHkL+GDqRyGGrCazmkoB9bRQL7Dpd1m+b7PxKDd5qu6vsZKYDmDeSYFBbHTatSiSjTR34GqycGm7M8XjLZPCarYKhFmUrpouOTR/CSr6hLWWN2jBYPBGXmC4YIyXIVu0sCFyslyljnv+VdixgYurL/K73ROfcN8zXLlWnAvS9Cezb52/APOEA==;5:sXxFCcY4/1bmNcHckQn9FrMOyclfPDD+DkEF8dYMDvDO2T8Uumogyd0y1pcDzt7bpodKV9eQR5xPE/0+oSbejySVgsSj/3YC0j9bCm8Gx2TaP0+Kk9Vgl4JW7JV9C7hWH7Il2uNxEELCjqd2SlcmuQ==;24:1uyXaQyCmtq8Gcf8hPrAYvTDGkw58y7zVFHiNKsa5uMXswS/qVq39cqwxTrpZlimWPYBW20+ptbX2qd1CnL6lxvlNJvIII6WFdvuKV1eOG4=;7:BNzRdS1v1iH9ZCAK6KJf2hBnpYjdicIrLchXdf4EIrapJxYfJJl7FdQpi+57ge1d4ymPe2Z4w1yP04/TrCOJwl3q1YutpZwGvzTWPgs1NSbZrJDJDyJgkAAS7hcEbCYQ7wCg/OXd3dc4n4jbzQRaKM9wWo/yxUU2cQYuTYWvfmSwIOZ1nd82Yc75TjMAt6v0jElpChv+vCmZ/A+EGoteFQh+VwGtLgTDcOzkeI4u5xI=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 462d6267-1bf1-4297-e892-08d4eef6b970
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM2PR21MB0041;
x-ms-traffictypediagnostic: DM2PR21MB0041:
x-exchange-antispam-report-test: UriScan:;
x-microsoft-antispam-prvs: <DM2PR21MB0041CAD0AB6B2B702C4F7D15B79F0@DM2PR21MB0041.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123562025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM2PR21MB0041;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM2PR21MB0041;
x-forefront-prvs: 0414DF926F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(47760400005)(189002)(199003)(24454002)(99286003)(76176999)(68736007)(7696004)(53936002)(8936002)(3660700001)(110136004)(2906002)(81166006)(8676002)(81156014)(5250100002)(50986999)(54356999)(305945005)(7736002)(3280700002)(33656002)(101416001)(5005710100001)(6246003)(8990500004)(5660300001)(8656003)(54906002)(55016002)(14454004)(6436002)(478600001)(6506006)(97736004)(4326008)(10290500003)(66066001)(25786009)(102836003)(3846002)(6116002)(189998001)(74316002)(106356001)(105586002)(86362001)(9686003)(229853002)(86612001)(2900100001)(2950100002)(6916009)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR21MB0041;H:DM2PR21MB0041.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2017 15:58:00.5070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR21MB0041
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiANCj4gT24gTW9uLCBBdWcgMjgsIDIwMTcgYXQgMDI6Mjg6MjhQTSAtMDYwMCwgS2V2aW4gV2ls
bGZvcmQgd3JvdGU6DQo+IA0KPiA+IFRoZSByZXR1cm4gdmFsdWUgb2YgdGhlIGdldF9maWxlc19k
aXJzIGNhbGwgaXMgbmV2ZXIgYmVpbmcgdXNlZC4NCj4gPiBMb29raW5nIGF0IHRoZSBoaXN0b3J5
IG9mIHRoZSBmaWxlIGFuZCBpdCB3YXMgb3JpZ2luYWxseSBvbmx5DQo+ID4gYmVpbmcgdXNlZCBm
b3IgZGVidWcgb3V0cHV0IHN0YXRlbWVudHMuICBBbHNvIHdoZW4NCj4gPiByZWFkX3RyZWVfcmVj
dXJzaXZlIHJldHVybiB2YWx1ZSBpcyBub24gemVybyBpdCBpcyBjaGFuZ2VkIHRvDQo+ID4gemVy
by4gIFRoaXMgbGVhZHMgbWUgdG8gYmVsaWV2ZSB0aGF0IGl0IGRvZXNuJ3QgbWF0dGVyIGlmDQo+
ID4gcmVhZF90cmVlX3JlY3Vyc2l2ZSBnZXRzIGFuIGVycm9yLg0KPiANCj4gT3IgdGhhdCB0aGUg
ZnVuY3Rpb24gaXMgYnVnZ3kuIDopDQoNClRoYXQgd2FzIG9uZSBvZiBteSBxdWVzdGlvbnMgYXMg
d2VsbC4gIFNob3VsZCByZWFkX3RyZWVfcmVjdXJzaXZlDQpiZSBwcm9wYWdhdGluZyBhIC0xIGFu
ZCBtZXJnZV90cmVlcyBiZSBjaGVja2luZyBmb3IgdGhhdCBhbmQgYmFpbA0Kd2hlbiB0aGUgY2Fs
bCB0byBnZXRfZmlsZXNfZGlycyByZXR1cm4gaXMgPCAwPyAgSSBtYWRlIGEgY29tbWl0IHdpdGgN
CnRoaXMgY2hhbmdlIGFuZCByYW4gdGhlIHRlc3RzIGFuZCB0aGV5IGFsbCBzdGlsbCBwYXNzZWQg
c28gZWl0aGVyIHRoaXMNCnJldHVybiByZWFsbHkgZG9lc24ndCBtYXR0ZXIgb3IgdGhlcmUgYXJl
IG5vdCBzdWZmaWNpZW50IHRlc3RzIGNvdmVyaW5nDQppdC4NCg0KSSB3ZW50IHdpdGggdGhpcyBj
aGFuZ2UgYmVjYXVzZSBpdCB3YXMgbm90IGNoYW5naW5nIGFueSBvZiB0aGUNCmN1cnJlbnQgZnVu
Y3Rpb25hbGl0eSBhbmQgaWYgd2UgZmluZCBhIGNhc2Ugd2hlcmUgaXQgbWF0dGVycyB0aGF0DQpy
ZWFkX3RyZWVfcmVjdXJzaXZlIGZhaWxzIGR1ZSB0byBiYWQgdHJlZSBvciBzb21ldGhpbmcgZWxz
ZSB3ZQ0KY2FuIGFkZHJlc3MgaXQgdGhlbi4NCg0KPiANCj4gSSdtIHRlbXB0ZWQgdG8gc2F5IHRo
YXQgd2Ugc2hvdWxkIHByb2JhYmx5IGRpZSgpIHdoZW4NCj4gcmVhZF90cmVlX3JlY3Vyc2l2ZSBm
YWlscy4gVGhpcyBzaG91bGQgb25seSBoYXBwZW4gaWYgd2UgZmFpbCB0byBwYXJzZQ0KPiB0aGUg
dHJlZSwgb3IgaWYgb3VyIGNhbGxiYWNrIChzYXZlX2ZpbGVzX2RpcnMgaGVyZSkgcmV0dXJucyBm
YWlsdXJlLCBhbmQNCj4gdGhlIGxhdHRlciBsb29rcyBsaWtlIGl0IG5ldmVyIGhhcHBlbnMuDQo+
IA0KPiA+IFNpbmNlIHRoZSBkZWJ1ZyBvdXRwdXQgaGFzIGJlZW4gcmVtb3ZlZCBhbmQgdGhlIGNh
bGxlciBpc24ndA0KPiA+IGNoZWNraW5nIHRoZSByZXR1cm4gdmFsdWUgdGhlcmUgaXMgbm8gcmVh
c29uIHRvIGtlZXAgY2FsdWxhdGluZw0KPiA+IGFuZCByZXR1cm5pbmcgYSB2YWx1ZS4NCj4gDQo+
IEFncmVlZCwgYW5kIEknbSBoYXBweSB0byBzZWUgZGVhZCBjb2RlIGdvLg0KPiANCj4gTWlub3Ig
bml0OiBzL2NhbHVsYXRpbmcvY2FsY3VsYXRpbmcvIGluIHlvdXIgY29tbWl0IG1lc3NhZ2UuDQoN
CldoZW4gd2lsbCB0aGF0IHNwZWxsIGNoZWNrZXIgZm9yIGdpdCBtZXNzYWdlcyBiZSByZWFkeT8g
OykNCg0KPiANCj4gLVBlZmYNCg==
