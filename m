Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5DCC433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 00:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240919AbiEFA1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 20:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiEFA1a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 20:27:30 -0400
Received: from us-smtp-delivery-104.mimecast.com (us-smtp-delivery-104.mimecast.com [170.10.129.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E5C45DA28
        for <git@vger.kernel.org>; Thu,  5 May 2022 17:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globalfinishing.com;
        s=mimecast20180829; t=1651796625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TIZu7o2Be7I/fr2gJhw5/xT6gdEUGILq7BXzWcqkfAM=;
        b=YjUDHs1XZ/H1CS4Iw86YlXobKjfnxpaLPBJ8Ep8SldkM69K3o8701zIrTuMMBpoiLDAE8t
        SK8+Z841rFFHfNd/BZPdoYFlM2L44PVAZggLynOeD+ep7GfeitLcQedh+in+jHIGVqbEqX
        rFt8bJ5wLzK/RCK9ssGbFJC4AS/ruuY=
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-9xHJFl7KMUeVfrciS9JDmw-1; Thu, 05 May 2022 20:22:39 -0400
X-MC-Unique: 9xHJFl7KMUeVfrciS9JDmw-1
Received: from CY4PR16MB1655.namprd16.prod.outlook.com (2603:10b6:910:6d::10)
 by CY4PR16MB0088.namprd16.prod.outlook.com (2603:10b6:903:d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Fri, 6 May
 2022 00:22:37 +0000
Received: from CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6d76:e92c:8b8c:10ea]) by CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6d76:e92c:8b8c:10ea%4]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 00:22:37 +0000
From:   Jason Hatton <jhatton@globalfinishing.com>
To:     Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>
Subject: RE: [Email External to GFS] Re: Git status extremely slow if any file
 is a multiple of 8GBi
Thread-Topic: [Email External to GFS] Re: Git status extremely slow if any
 file is a multiple of 8GBi
Thread-Index: Adhf2MbMFWSTh1oNQ/ePfRxjcwYZoAA6t9eAAAPjsoAAArTSEA==
Date:   Fri, 6 May 2022 00:22:36 +0000
Message-ID: <CY4PR16MB165558026798A6E51E6A005FAFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
References: <CY4PR16MB16558FE8E69B2045435AD59DAFC39@CY4PR16MB1655.namprd16.prod.outlook.com>
 <0d78c98a-841e-719b-add3-acc7a7a2d7c6@web.de>
 <9b6b7ad0-df90-62e0-abb1-c23862ded4ac@iee.email>
In-Reply-To: <9b6b7ad0-df90-62e0-abb1-c23862ded4ac@iee.email>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c684fdc6-2b75-486e-c58d-08da2ef685de
x-ms-traffictypediagnostic: CY4PR16MB0088:EE_
x-microsoft-antispam-prvs: <CY4PR16MB00883A5949BFDD6FF30F4098AFC59@CY4PR16MB0088.namprd16.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: iLtuPmDhtqSHmrLLdaEItleFiN8xTvVW9EylnDX6HsSLHQ4pVsIxEa15xE243vCjlHtBkismKGUjRpphj0bZmQoqW0+9I7Fl3mw3LKDUszhsm0mUCVxjw5L4LBsA0DXNdBOIRDomVRo3GWB21EJAKTPNbvXR7PTJrxaGP70BD2C+zmEGkfk57KqCA4/iUpmRXXGZPIepPutrkYONjIuzNK2QU+eu8UEYTzxWowUhYE6bCwAi3EmmmiEujUJM0mUrKalVob4Ug5Q1oizta46Vm6y5iwTMtYoDbxbQWyv6rF0a122nTduPjIrTiCQqSlfiJOt2exy9OkYp1QZzhp5X65fwzsqcJ6loOmGqbcew++/tmPcETI3jdQBiutrt+VDZ0eJwmv4xWbUiSQSq9owN1D/xiaVJ9/1BEd+fanW0mQwsch2oYDcj8jKLJbn3xCCm4E96nbSEEvTrHaUjdgA1hyenFBWr3XNlNq5wQEYVBj4dzMKYJUp/luUDetoCjibxlUP1mM6GBx7RL8nJk4X5zWUTWTlF5iM3rpgzSgshkMM5C49OOtyIa4Ld8mH7BEb4WQAohnEdb0lqy4MZecj8yO4lg6chN45xmQq9VAPyWd+a6xf/l/54FqtcssFj0rXCWH3XI74Qmk+GgNaOov9/KMhd8wMZmaCq6LLr6zKzyJabz/ImHZc+bRYF6j1tyOj1XkGMjRZUvrKsERGQvykmIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR16MB1655.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(38100700002)(2906002)(38070700005)(8936002)(86362001)(122000001)(508600001)(52536014)(316002)(45080400002)(8676002)(66446008)(7696005)(64756008)(9686003)(66476007)(6506007)(33656002)(4326008)(66556008)(76116006)(26005)(66946007)(186003)(83380400001)(110136005)(55016003)(71200400001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTF4YjhNWXhPbGkzVWNXRmVRWnB2ZEowWGtBV2FadHNRVFNhU01KdzZaTUZI?=
 =?utf-8?B?amsxTjRIZFRNaUJ5NGlIWUtYcU1WOUZKR2xWWkgwZlpCS1NDUTR5VTlJYk42?=
 =?utf-8?B?dUN4ZzZkQTl5dy9XNXhpeGlsZVJsOVY3TjcwS3lNZERncDJzemFCQWVWZWY2?=
 =?utf-8?B?S04zckFvWXV2dXR0VkNyOWRPVllBQzhaVzFzUnpZOU9vdVZtWW1VOVBGbWQy?=
 =?utf-8?B?REhsZUlxaUhSWnlydVh3Ty94UFBPcVRPZko1MEtWbVlCSHJJM0tsditNK2xY?=
 =?utf-8?B?ZzRMcmFFQllDbk9sSjljaDhCWGNZRzVDT0w2bnFPdU1XSHVQS3laZXhHRDls?=
 =?utf-8?B?TjZQZHZmeHU5TC9pQTFUS25Zcyt1ZnNpaTd4NzNCQ0xPVkRBVXNWaFJhYXNI?=
 =?utf-8?B?dTBGamk0TGJnQ09KUXhDM3ZOUDUxSUh5cmpJaDV5d0FpRHZUaVF2eEhHeTdJ?=
 =?utf-8?B?UmlzVkthTlNVTnA2MksxZjNCZGJTcndxTkZYRlg0eUZQZGlwUHh5QmVPZm5y?=
 =?utf-8?B?VlljajlPREpXL29iam1kVWdOTUFzdVhSa1FTYnpRQzFXK0p5SGwvZnlxQ1o0?=
 =?utf-8?B?d2w4VkZuZFRNekFYczFHVTd2T05OdHJDcTJVaVo5bzBqU2xxOGkyUVRBL3VB?=
 =?utf-8?B?STZ1OVIxeGNQT0xQOXZNNVlxV1hKSEZwZ2xaVmVUODNxT0VnZTc0Mkk1V3Bv?=
 =?utf-8?B?MThXcmhhMTZnc2o2ZU1GVlptNVBnRHU1TDdCVERQTGFURVg3K2NDZEorYWcr?=
 =?utf-8?B?SjBGR0F4Mzl3UUhTemFuNFlSTjlRenJ3c3kxbkdscmlRdkxHSk9XUVVVeTFJ?=
 =?utf-8?B?QzFvd3NqbE1jSU1JUXdIZktGVDNycCtjVzl4aXdnaFp2U0pXSnYrMUk0NlNo?=
 =?utf-8?B?K0xMRjlaOXVJQWRFY3VhcmM2RHhEcWdhZExYeWdxTHY1S21haUEyd3dxTTZU?=
 =?utf-8?B?Q2p4Z1F3Y1dLUVVXSTRGUzhuOVAxVmNDZkN2R3JzRHBsK2FjUlQzVksxZkx4?=
 =?utf-8?B?M25XTTZ6MnMyazArQ2lxdkkzSEduZjZsUWtBWFMxQWwycVdkeVpoVWphRGxa?=
 =?utf-8?B?RkNUNFdtelg4VStOaUlkMWJRNVZaVXV3SHB2SDJJVUx5U2tHVFN1Y0taSDRM?=
 =?utf-8?B?ZUJPcjNjM0R3SU9KTzJNVjE4QVRKZFdibFdINmdNR29rY1JyVElCQ1g4Y2l2?=
 =?utf-8?B?VDdyZ1JkNWFSY2xqdjdOTXhMYkJuVTM5ZHJ5NjduVFV2amk2RWo4ajJ6dk9K?=
 =?utf-8?B?MEN3VkhGMXNrY3ZDVXcrUE0wK2ovYnNlcVU1UGo5cE9PMW8yOTBscGxhNHlD?=
 =?utf-8?B?VUxPb2t4d1lPUmZJVHVpbkhqVnVsWW9IZVBBTUU2YTVRR2ZaWS9ZdnIzbjUz?=
 =?utf-8?B?NUZwUGpLNStqa2tKMUQ4ZkUzbGlzMmpwWW5RTU9UdlVHeUFpemdFUmVRUUZx?=
 =?utf-8?B?WjNncEF3bzFlMzVuTzdhRUVhV1RIZEVUNy9CeDk1M0I2ektzWWE1Mi9ibTJ2?=
 =?utf-8?B?M2RRZ3o3OWwyOHo0bUxZcC9uT1kzR2F4bWhCaC9jMWNqNUZlcXpnL093TUlB?=
 =?utf-8?B?RTNKNmtQM21aM2ZFdTdySURGdGU2TDJadFl3TnpqQzEyeU9vYkszOHpwRlRU?=
 =?utf-8?B?K2FJWm9RdDc5bnlmY0doTklVMEpKZ1ZMN1Z1bDc4ZXZIVVlRMmFWUVprMGJr?=
 =?utf-8?B?UWZiZHJKZVJtTE1TaDFLK3U0WHVpTDVwazJhbmJMemhUS2xGSTZ1cUNBZnNO?=
 =?utf-8?B?VGg0SWwvMmZXUVpNY2xIdHBlRUhzU3p3UVEvREhiSjMwbEdXSzdQeE5nTlc5?=
 =?utf-8?B?cFBlOGM2VlZhSEQ4VjBFRk9ZNGFBc3ZiRDlwNWwzd0FSbWpWYnZxRVNXWlQw?=
 =?utf-8?B?WFpGcGdYQzNNWlZlN2g3eUpBaUNUWEFWTGNxYk0rcEh0NkVDZDZuUW02bFpG?=
 =?utf-8?B?bzI4RUlqRENTVEZ5cml5QnQ0djU4YUZlSWxqd05YYnpvS0llOCt1cVV4QmdL?=
 =?utf-8?B?eHhHOWhock1kbUNBM1FEeThLeVliT2RkVGZmNXNGZHFyYXg5bDJCYW8vdS9Y?=
 =?utf-8?B?aEsrbmV4Ty9tTlQrdCswYThmTWVnV0xjMUYzT1dBdmNyc1JJeDZiVGFiNjlj?=
 =?utf-8?B?VFEydG9jbjIyaHoxcGNKczFVQ09LL3FxMzNzdkFuQlBCSEs1cEp6OERpZWpY?=
 =?utf-8?B?TGpBeE40Q0dzcmtOdG9rTFhjOGxiUGpNazhKMVgyc1k1NllsS1kwZjIzbDRt?=
 =?utf-8?B?dmNNSW9SeU82cFFIbngrYTV6Z3pLTEwwT1I1dDBOaWNWRmNETnc0MEwyODU4?=
 =?utf-8?B?S3F0YjdJREFiUVZ1dHdneFloY2E3R3MxeTdGeHFaeWxMUU1kMmhKWEZKWHND?=
 =?utf-8?Q?G/eh+hwDMryFpxMY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: globalfinishing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR16MB1655.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c684fdc6-2b75-486e-c58d-08da2ef685de
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 00:22:36.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41026ff0-b4fb-4e53-ada8-a2e2e3e9ec4d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgsYq1B0ebcK1yeaQxGz3fD6u67F0f22Cqh3dk/wlgqV9jQud5M6xdMpbG0sQux0O+DFOn0+mNqGYOoq/lz7ZqcyYB6INTeOTLwQMOAsY4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR16MB0088
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA104A295 smtp.mailfrom=jhatton@globalfinishing.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: globalfinishing.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pk9uIDA1LzA1LzIwMjIgMjI6MDQsIFJlbsOpIFNjaGFyZmUgd3JvdGU6DQo+PiBBbSAwNC4wNS4y
MiB1bSAxOTo0NyBzY2hyaWViIEphc29uIEhhdHRvbjoNCj4+Pj4+IFRoZSBjb25kaXRpb24gc2Rf
c2l6ZT09MCBpcyB1c2VkIGFzIGEgc2lnbmFsIGZvciAibm8sIHdlIHJlYWxseSBuZWVkDQo+Pj4+
PiB0byBjb21wYXJlIHRoZSBjb250ZW50cyIsIGFuZCBjYXVzZXMgdGhlIGNvbnRlbnRzIHRvIGJl
IGhhc2hlZCwgYW5kDQo+Pj4+PiBpZiB0aGUgY29udGVudHMgbWF0Y2ggdGhlIG9iamVjdCBuYW1l
IHJlY29yZGVkIGluIHRoZSBpbmRleCwgdGhlDQo+Pj4+PiBvbi1kaXNrIHNpemUgaXMgc3RvcmVk
IGluIHNkX3NpemUgYW5kIHRoZSBlbnRyeSBpcyBtYXJrZWQgYXMNCj4+Pj4+IENFX1VQVE9EQVRF
LiAgQWxhcywgaWYgdGhlIHRydW5jYXRlZCBzdF9zaXplIGlzIDAsIHRoZSByZXN1bHRpbmcNCj4+
Pj4+IGVudHJ5IHdvdWxkIGhhdmUgc2Rfc2l6ZT09MCBhZ2Fpbiwgc28gYSB3b3JrYXJvdW5kIGxp
a2Ugd2hhdCB5b3UNCj4+Pj4+IG91dGxpbmVkIGlzIG5lZWRlZC4NCj4+Pj4gSnVuaW8gQyBIYW1h
bm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cml0ZXM6DQo+Pj4+DQo+Pj4+IFRoaXMgaXMgb2Ygc2Vj
b25kYXJ5IGltcG9ydGFuY2UsIGJ1dCB0aGUgZmFjdCB0aGF0IEphc29uIG9ic2VydmVkDQo+Pj4+
IDhHQmkgZmlsZXMgZ2V0cyBoYXNoZWQgb3ZlciBhbmQgb3ZlciB1bm5lY2Vzc2FyaWx5IG1lYW5z
IHRoYXQgd2UNCj4+Pj4gd291bGQgZG8gdGhlIHNhbWUgZm9yIGFuIGVtcHR5IGZpbGUsIG9wZW5p
bmcsIHJlYWRpbmcgMC1ieXRlcywNCj4+Pj4gaGFzaGluZywgYW5kIGNsb3NpbmcsIHdpdGhvdXQg
dGFraW5nIGFkdmFudGFnZSBvZiB0aGUgZmFjdCB0aGF0DQo+Pj4+IENFX1VQVE9EQVRFIGJpdCBz
YXlzIHRoZSBmaWxlIGNvbnRlbnRzIHNob3VsZCBiZSB1cC10by1kYXRlIHdpdGgNCj4+Pj4gcmVz
cGVjdCB0byB0aGUgY2FjaGVkIG9iamVjdCBuYW1lLCBkb2Vzbid0IGl0Pw0KPj4+Pg0KPj4+PiBP
ciBkbyB3ZSBoYXZlICJpZiBzdF9zaXplID09IDAgYW5kIHNkX3NpemUgPT0gMCB0aGVuIHdlIGtu
b3cgd2hhdCBpdA0KPj4+PiBoYXNoZXMgdG8gKGkuZS4gRU1QVFlfQkxPQl9TSEEqKSBhbmQgdGhl
cmUgaXMgbm8gbmVlZCB0byBkbyB0aGUNCj4+Pj4gdXN1YWwgb3Blbi1yZWFkLWhhc2gtY2xvc2Ug
ZGFuY2UiIGxvZ2ljIChJIGRpZG4ndCBjaGVjayk/DQo+Pj4gSnVuaW8gQyBIYW1hbm8NCj4+Pg0K
Pj4+IEFzIGJlc3QgYXMgSSBjYW4gdGVsbCwgaXQgcmVjaGVja3MgdGhlIHplcm8gc2l6ZWQgZmls
ZXMuIE15IExpbnV4IGJveCBjYW4gcnVuDQo+Pj4gZ2l0IGxzIGluIC4wMDYgc2Vjb25kcyB3aXRo
IDEwMDAgemVybyBzaXplZCBmaWxlcyBpbiB0aGUgcmVwby4gUmVoYXNoaW5nIGV2ZXJ5DQo+Pj4g
ZmlsZSB0aGF0IGlzIGEgbXVsdGlwbGUgb2YgMl4zMiB3aXRoIGV2ZXJ5ICJnaXQgbHMiIG9uIHRo
ZSBvdGhlciBoYW5kLi4uDQo+Pj4NCj4+PiBJIG1hbmFnZWQgdG8gYWN0dWFsbHkgY29tcGlsZSBn
aXQgd2l0aCB0aGUgcHJvcG9zZWQgY2hhbmdlcy4NCj4+IE1lYW5pbmcgdGhhdCBmaWxlIHNpemVz
IG9mIG4gKiAyXjMyIGJ5dGVzIGdldCByZWNvcmRlZCBhcyAxIGJ5dGUgaW5zdGVhZA0KPj4gb2Yg
MCBieXRlcz8gIFdoeSAxIGFuZCBub3QgZS5nLiAyXjMyLTEgb3IgMl4zMSAob3IgNDIpPw0KPg0K
Pk15IHRob3VnaHQgb24gdGhpcy4gYWZ0ZXIgY29uc2lkZXJpbmcgYSBmZXcgb3B0aW9ucywgd291
bGQgYmUgdGhhdCB0aGUNCj4nc2lnbiBiaXQnIG9mIHRoZSB1aW50MzJfdCBzaXplIHNob3VsZCBi
ZSBzZXQgdG8gMSB3aGVuIHRoZSBoaWdoIHdvcmQgb2YNCj50aGUgNjQgYml0IGZpbGVzaXplIHZh
bHVlIGlzIG5vbiB6ZXJvLg0KPg0KPlRoaXMgd291bGQgcmVzdWx0IGluIGZpbGUgc2l6ZXMgb2Yg
MCB0byA0R2lCLTEgcmV0YWluaW5nIHRoZWlyIGV4aXN0aW5nDQo+dmFsdWVzLCBhbmQgdGhvc2Ug
ZnJvbSA0R2lCIG9ud2FyZCBwcm9kdWNlcyBhIGRvd24tZm9sZGVkIDJHaUIgdG8gNEdpQi0xDQo+
dmFsdWVzLg0KDQpJIGJlbGlldmUgaXQgd291bGQgYmUgYmVzdCB0byBvbmx5IGNoYW5nZSB0aGUg
YmVoYXZpb3Igb2YgZmlsZXMgdGhhdCBhcmUNCm11bHRpcGxlcyBvZiAyXjMyIGV4YWN0bHkuIENo
YW5naW5nIHRoZSBiZWhhdmlvciBvZiBhbGwgZmlsZXMgbGFyZ2VyIHRoYW4NCjRHQmkgbWF5IG5v
dCBiZSBnb29kLiBJIGxpa2UgdGhlIGlkZWEgb2YgdXNpbmcgMHg4MDAwMDAwMCBpbnN0ZWFkIG9m
IDEuDQoNCj5UaGlzIHdvdWxkIG1lYW4sIFRoYXQgd2UgYXJlIGFibGUgdG8gZGV0ZWN0IGFsbW9z
dCBhbGwgaW5jcmVtZW50YWwgYW5kDQo+ZGVjcmVtZW50YWwgY2hhbmdlcyBpbiBmaWxlc2l6ZXMs
IGFzIHdlbGwgYXMgcmV0YWluaW5nIHRoZSAnemVybyBpcw0KPnJhY3knIGZsYWcgYXNwZWN0Lg0K
Pj4+IEl0IHNlZW1zIHRvIGNvcnJlY3QNCj4+PiB0aGUgcHJvYmxlbSBhbmQgIm1ha2UgdGVzdCIg
cGFzc2VzLiBJZiB1cGdyYWRpbmcgdG8gdGhlIHBhdGNoZWQgdmVyc2lvbiBpZiBnaXQsDQo+Pj4g
Z2l0IHdpbGwgcmVoYXNoIHRoZSA4R0JpIGZpbGVzIG9uY2UgYW5kIHdvcmsgbm9ybWFsbHkuIElm
IGRvd25ncmFkaW5nIHRvIGFuDQo+Pj4gdW5wYXRjaGVkIHZlcnNpb24sIGdpdCB3aWxsIHBlcmNl
aXZlIHRoYXQgdGhlIDhHQmkgZmlsZXMgaGF2ZSBjaGFuZ2VzLiBUaGlzDQo+Pj4gbmVlZHMgdG8g
YmUgY29ycmVjdGVkIHdpdGggImdpdCBhZGQiIG9yICJnaXQgY2hlY2tvdXQiLg0KPj4gTm90IG5p
Y2UsIGJ1dCBzYWZlLiAgQ2FuIHRoZXJlIGJlIGFuIHVuc2FmZSBzY2VuYXJpbyBhcyB3ZWxsPyAg
TGlrZSBpZiBhDQo+PiA0R2lCIGZpbGUgZ2V0cyBhZGRlZCB0byB0aGUgaW5kZXggYnkgdGhlIG5l
dyB2ZXJzaW9uLCB3aGljaCByZWNvcmRzIGENCj4+IHNpemUgb2YgMSwgdGhlbiB0aGUgZmlsZSBp
cyBleHRlbmRlZCBieSBvbmUgYnl0ZSB3aGlsZSBtdGltZSBzdGF5cyB0aGUNCj4+IHNhbWUgYW5k
IHRoZW4gYW4gb2xkIGdpdCB3b24ndCBkZXRlY3QgdGhlIGNoYW5nZT8NCj4NCj5UaGVyZSBpcyBz
dGlsbCBzb21lIHBvdGVudGlhbCBmb3IgZGlmZmVyZW50IEdpdCB2ZXJzaW9ucyB0byBiZQ0KPidj
b25mdXNlZCcgZm9yIHRoZXNlIHZlcnkgbGFyZ2UgZmlsZXMsIGJ1dCBJIGZlZWwgdGhhdCBpdCdz
IHJlbGF0aXZlbHkNCj5zYWZlIChubyB3b3JzZSB0aGFuIHRoZSAnc2V0IHRvIHVuaXR5JyBpZGVh
KS4gRm9yIGxhcmdlIGZpbGVzIHdlIHdpbGwNCj5hbHdheXMgaGF2ZSB0aGF0IGxvc3Mgb2YgcHJl
Y2lzaW9uIGF0IHRoZSAzMmJpdCByb2xsb3Zlci4gSXQganVzdCBhIGNhc2UNCj5vZiBjaG9vc2lu
ZyBhIGxlYXN0IHdvcnN0Lg0KPg0KPkkgaGF2ZW4ndCBjb25zaWRlcmVkIGlmIG15IHByb3Bvc2Vk
ICd0cnVuY2F0aW9uJyBvdmVyaGVhZCB3b3VsZCBiZSBmYXN0DQo+Y29kZS4NCj4NCj4+PiBJZiB5
b3UgcGVvcGxlIGFyZQ0KPj4+IGludGVyZXN0ZWQsIEkgbWF5IGJlIGFibGUgdG8gZmluZCBhIHdh
eSB0byBzZW5kIGEgcGF0Y2ggdG8gdGhlIGxpc3Qgb3IgcHV0IGl0DQo+Pj4gb24gZ2l0aHViLg0K
Pj4gUGF0Y2hlcyBhcmUgYWx3YXlzIHdlbGNvbWUsIHRoZXkgbWFrZSBkaXNjdXNzaW9ucyBhbmQg
dGVzdGluZyBlYXNpZXIuDQo+Pg0KPj4gUmVuw6kNCj5QaGlsaXANCg0KSSBoYXZlIGEgcGF0Y2gg
ZmlsZSwgYnV0IEknbSBub3Qgc3VyZSBob3cgdG8gYWN0dWFsbHkgc3VibWl0IGl0LiBJJ20gZ29p
bmcgdG8NCmF0dGVtcHQgdXNpbmcgb3V0bG9vay4NCg0KSmFzb24NCg0K

