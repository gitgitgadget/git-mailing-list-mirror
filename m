Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6C61F4C1
	for <e@80x24.org>; Tue, 29 Oct 2019 20:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfJ2UME (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:12:04 -0400
Received: from mail-eopbgr750125.outbound.protection.outlook.com ([40.107.75.125]:53668
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbfJ2UMD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:12:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7R9FUEzj7lq5MeZpZHass0uiSEO97t6ryUJbf2o0nmraKL6xCMz8QncYVAgaytfyAZSoSFrbEsQv5kmMJQHUh/mI8pHwn3VP4+r69KufWGS1/3urhGPdAyafTwysGdaAQojz/VyiZW08JjSQytceNNOK1/yDjjYoej4+FvlZDzMjpVWsQD2yAN1u3lxqBdVwgQTHTCDUgoSw2kgnwRH2b1rQWDPqSmHtisbiH01gMnCOsAH4T4O4jOhTpDgKIgZ9i8bS4UelfM0V40KlEVkN1CspjDx/rVxGR1VwwWPf/tefpuHzDtnHJ/AjhZWD1G51b6YuBWjIKUye9W25+mN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0uNDQG3cKJeoGEXhEMnBfxnmAv2b2GzgYxdHF+dIPA=;
 b=lvUCxz8YXY2c1QZ6DHXLBu/G6TyW7jyz5E/Ayh5gDhnmhWrPEZOGeRHBdnVkcB6BRRpDrE+6PtYdddHYgBdDJQ1kModHVxYmQbFM9pyxs4GKa6lZ8KB2D8oz2rt/sr1zR4wTt8sXRP1JVIUUEP/jsrh7gUlRQWNk4kNd5NHqLq7HiHHvOoua1kKdzscHeTIFz/4FHZxMYTWL2jRYbqh6q2zSchQBe/hCtZdWXYAA1JcC7Ntra0OAYrys9J5+3MIwf53NY8GZmlnoDBdJiA6rW5FXME+7H9nGUVRJUs4CLqtW+rUowv9jBJ115iROeu8FVhOPvnNOl+5AN4OGPtZjNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0uNDQG3cKJeoGEXhEMnBfxnmAv2b2GzgYxdHF+dIPA=;
 b=KaV3vaIMpA+nmJacZ9rYrEINN009flwlLoKyfBcLLlwiWqzXys7CztBRnhyfylqYvefrRLtlw51QBcw6D0zoKCKIClaDLhqC94+u8gQocXfc0OrT2OdOaXmVZs3yWTjbqMER3YWDzb8WGtgfM36p6zV4hoeN/7UDoPtbGMV+f5w=
Received: from BN6PR21MB0786.namprd21.prod.outlook.com (10.175.132.14) by
 BN6PR21MB0274.namprd21.prod.outlook.com (10.173.203.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.10; Tue, 29 Oct 2019 20:12:01 +0000
Received: from BN6PR21MB0786.namprd21.prod.outlook.com
 ([fe80::69cd:d7ac:4626:542e]) by BN6PR21MB0786.namprd21.prod.outlook.com
 ([fe80::69cd:d7ac:4626:542e%10]) with mapi id 15.20.2408.016; Tue, 29 Oct
 2019 20:12:01 +0000
From:   Kevin Willford <Kevin.Willford@microsoft.com>
To:     Utsav Shah <utsav@dropbox.com>
CC:     Junio C Hamano <gitster@pobox.com>,
        Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Utsav Shah <ukshah2@illinois.edu>
Subject: RE: [PATCH 1/1] unpack-trees: skip lstat based on fsmonitor
Thread-Topic: [PATCH 1/1] unpack-trees: skip lstat based on fsmonitor
Thread-Index: AQHVi0gsgNXmyMqj80SNyhNb6SenPKdva2/ugAAy9QCAAJf9AIABywOAgAAN5PA=
Date:   Tue, 29 Oct 2019 20:12:00 +0000
Message-ID: <BN6PR21MB078689FFE9ED95A31998F41A91610@BN6PR21MB0786.namprd21.prod.outlook.com>
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
 <609c7c5047719a619ba22425dafc6ecd105e2cda.1572017008.git.gitgitgadget@gmail.com>
 <xmqq8sp5a6cd.fsf@gitster-ct.c.googlers.com>
 <CAPYzU3N9mDfHVogfq=mhJFj6VOjS2z4ui4msnDdK6pOtVBa_QA@mail.gmail.com>
 <BN6PR21MB078676C4FA54391B1954D5F791660@BN6PR21MB0786.namprd21.prod.outlook.com>
 <CAPYzU3NZZ-H_PWcRH_ooXzrYnRNjvF9ayX4_xeMJeMiHB=8fLg@mail.gmail.com>
In-Reply-To: <CAPYzU3NZZ-H_PWcRH_ooXzrYnRNjvF9ayX4_xeMJeMiHB=8fLg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin.Willford@microsoft.com; 
x-originating-ip: [174.126.253.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1b5cee4-2c36-41d8-aad9-08d75cac4236
x-ms-traffictypediagnostic: BN6PR21MB0274:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR21MB0274F3BC3F323B12DD9A13EE91610@BN6PR21MB0274.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(10090500001)(6246003)(26005)(52536014)(966005)(316002)(54906003)(478600001)(22452003)(14444005)(6916009)(476003)(55016002)(5660300002)(8936002)(3846002)(8990500004)(4326008)(10290500003)(2906002)(71200400001)(76116006)(14454004)(6116002)(229853002)(71190400001)(186003)(102836004)(33656002)(11346002)(66066001)(74316002)(6506007)(25786009)(486006)(6436002)(53546011)(66946007)(66446008)(64756008)(86362001)(9686003)(256004)(76176011)(6306002)(7696005)(99286004)(8676002)(446003)(66476007)(81166006)(7736002)(81156014)(66556008)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0274;H:BN6PR21MB0786.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v/QM9HFPhbMVGS7HemdayZOeh7s+AOAzYSJI+lnY4EmeojFoxeQyh0zUx91g0erXhnbcVxEwU/Kd9k8i8KytywuEnDdRdMTSJyr/hzcMbqKJW0iK0lrZleTYbAYdSwh4dXvJXU+HdcE3hbL81v7GjWA8HDM78fdl2opNGNR3j9aXcaA835D19f9mlW4XIJCLRri59ZvOx/SUbI+v34N5cQObCns+xd6jw84KxRxaPzOTn7IQ39P+4U4B0OeQaj0Om7Zll9PTfQ4ua1v+iMEnKjlIstkyJbEetp8pZWEOh6sMpgQenOFk20aI1BtfD7O5ixGEyzgfpLi+H6HnP8qwwz9ATaQ6qOkgcYeNrIkYnPxv5ELVQcQ12g4QOnVv+Cv4H0nYdd+abrwcsZUJV3218zLav75t0K0ozx5+Ij3yafOBmF4HvXSKsXy295IDm0AVdFm9J2hr3Y5FSFsgyww6nVXPVr5HKAbbMm2Y9okf5/w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b5cee4-2c36-41d8-aad9-08d75cac4236
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 20:12:00.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNkZaKzxWpXk71R2qUSGWtBOTUYr2Aq6O9kTi998NVis0YZd8gJXqVMLxu+MxSxkh+IFicZM8lO7+g+BjtCIFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0274
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBPbiBUdWVzZGF5LCBPY3RvYmVyIDI5LCAyMDE5IDE6MDcgUE0gVXRzYXYgU2hhaCA8dXRzYXZA
ZHJvcGJveC5jb20+DQo+IHdyb3RlOg0KPiANCj4gSSdtIGdldHRpbmcgdGhlIHNhbWUgdGVzdCBm
YWlsdXJlcyB3aXRoIG9yIHdpdGhvdXQNCj4gR0lUX1RFU1RfRlNNT05JVE9SPXQvdDc1MTkvZnNt
b25pdG9yLWFsbCBhbmQgY2FsbGluZyByZWZyZXNoX2ZzbW9uaXRvcg0KPiBpbiB0d2Vha19mc21v
bml0b3IuIENvdWxkIHlvdSBzaGFyZSB5b3VyIHBhdGNoPyBJJ20gcHJvYmFibHkgbWVzc2luZw0K
PiBzb21ldGhpbmcgdXAsIGFuZCBJIGNhbiB0cnkgdGFraW5nIGEgbG9vayBhdCBmaXhpbmcgdGVz
dCBjYXNlcyBhcyB3ZWxsLg0KDQpJIGhhdmUgdGhlIHRlc3RzIHBhc3Npbmcgd2l0aCB0aGUgZm9s
bG93aW5nIGNvbW1pdC4NCg0KaHR0cHM6Ly9naXRodWIuY29tL2tld2lsbGZvcmQvZ2l0L2NvbW1p
dC8zYjFmZGY1YTRiMWNkMWQ2NTRiMTczM2NlMDU4ZmFhNGYwODdmNzVmDQoNClRoaW5ncyB0byBu
b3RlOg0KMS4gTm90IHN1cmUgaWYgZnNtb25pdG9yIHdhcyB0ZXN0ZWQgd2l0aCBzcGxpdCBpbmRl
eCBzbyBmb3Igbm93IEkgcmVtb3ZlZCB0aGF0IGZyb20gdGhlDQpjaGVjayBvZiBlbnRyaWVzIGlu
IGZzbW9uaXRvciBiaXRtYXAgdnMgdGhlIG51bWJlciBvZiBjYWNoZSBlbnRyaWVzDQoyLiBXaXRo
IHRoZXNlIGNoYW5nZXMgdXBkYXRlLWluZGV4IHdhcyB0cmlnZ2VyaW5nIHRoZSBwb3N0LWluZGV4
LWNoYW5nZSBob29rIHdpdGggdGhlDQp1cGRhdGVkX3NraXB3b3JrdHJlZSBmbGFnIHNldCB3aGlj
aCBpdCB3YXNuJ3QgYmVmb3JlLg0KMy4gQ29waWVkIHRoZSBmc21vbml0b3JfbGFzdF91cGRhdGUg
dG8gdGhlIHJlc3VsdCBpbmRleCBzbyB0aGUgZnNtb25pdG9yIGRhdGEgd2lsbCBiZSANCmNhcnJp
ZWQgb3ZlciB0byB0aGUgbmV3IGluZGV4IGluIHVucGFja190cmVlcy4gIFRoaXMgaXMgdG8gbWFr
ZSBzdXJlIHRoYXQgdGhlIG5leHQgY2FsbA0KdG8gZ2l0IHdpbGwgaGF2ZSB0aGUgZnNtb25pdG9y
IGRhdGEgdG8gdXNlLiAgV2UgZm91bmQgdGhhdCBydW5uaW5nIGBnaXQgc3RhdHVzYCBhZnRlciBh
bnkNCmNvbW1hbmQgdGhhdCByYW4gdW5wYWNrX3RyZWVzIChjaGVja291dCwgcmVzZXQgLS1oYXJk
LCBldGMuKSB3YXMgdmVyeSBzbG93IHRoZSBmaXJzdA0KY2FsbCBidXQgYW5kIHN1YnNlcXVlbnQg
Y2FsbHMgd2VyZSBmYXN0Lg0KDQpJJ20gc3RpbGwgdGVzdGluZyBhbmQgcmV2aWV3aW5nIHRoZXNl
IGNoYW5nZXMgdG8gbWFrZSBzdXJlIHRoZXJlIGlzbid0IHNvbWV0aGluZyBJDQpoYXZlIG1pc3Nl
ZCBhbmQgdGhhdCBJIG1hZGUgdGhlIHJpZ2h0IGNoYW5nZXMgdG8gdGhlIHRlc3RzIHRoYXQgd2Vy
ZSBmYWlsaW5nLg0KDQpLZXZpbg0K
