Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ABEC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKDNHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiKDNH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:07:28 -0400
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (mail-dm3gcc02on2134.outbound.protection.outlook.com [40.107.91.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB9B2E6B9
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efyMtVFJsnJlrYQFp3dqMYiLnw6z2NONxEnRVAMISpDStHI8g7Uvsi8DLfsHv+QJ9nMjE6K9u6pUff2LUsp/9nUUXecehltpyFBRCmDmT2nho+90HrQ2FxhCdTjYoIMP2PS0syWYNkoCPtUjWkL6sFmReL1RYAyjE3UPeeSRv/3qN5JHi5vNoPkY/xuf52oBL6aaPjCLuaIGFGS3zJdKk/g8mS8RHFX3F2NACyazlF0gBAnLwIeUpXgTLMSwx3LMkZBmkdXsFsCh2HvyBXY8CWx1jRXaFv2Y2xi6E7Bg07Q7KeyZ1gQp1eE/NeNJTgY4swIza7kw1qBjbEmFGPWfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsbNsYv5EiynFkFOfh/uMdASXDwVa9ZliHZgn46h7Ug=;
 b=UqQ7VFISuSSTd/0pfNLrAK+bwFC4w0/pw+GWTLBez+UNqdpz4zVTrBsj9bDjQbyFuPC4UYRDi991baI2kcwUJsHSgQoKArrM8SHQDpEQc8TwrR4Os6iSf3wPlwO1xK+px72tiivbJeg/HYy8LZedxTRuaseZ1hQXCbpGIzKlyU7nTXTyKdz7RGSzLxAXzo7aYzjAsDPVEldarr7aYg0al24p3/yXWLdisuBmvEvaWh/JTVakFxtU4K4ceI7BEeKwD3t3tbxS9MMSlARTzqz56mPamgHZes3XaU2MHqU/d3zEOjsIDJYYmBEJhqHAC4YE+pNa6RVzhBbLqM+cyIbclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=isdh.in.gov; dmarc=pass action=none header.from=isdh.in.gov;
 dkim=pass header.d=isdh.in.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isdh.in.gov;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsbNsYv5EiynFkFOfh/uMdASXDwVa9ZliHZgn46h7Ug=;
 b=j4bnWNVaCQ3tFa8ywypoDuwH+k4GbMrBvbg//z9elhX160LaBNOvNdGfI85DbKrkZUlT1ibudjRfa6koezsi8jzNhxPcmb+jqZBN7y8/FqJhThVtajhPYmboFmpC6Au0mdJaz5ipbf7Nk6N2obYBtBpdfBk1gsKrGFDXD0GDK/w=
Received: from SA1PR09MB8703.namprd09.prod.outlook.com (2603:10b6:806:175::18)
 by SA0PR09MB7354.namprd09.prod.outlook.com (2603:10b6:806:76::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 13:07:26 +0000
Received: from SA1PR09MB8703.namprd09.prod.outlook.com
 ([fe80::afeb:63b0:f668:a4db]) by SA1PR09MB8703.namprd09.prod.outlook.com
 ([fe80::afeb:63b0:f668:a4db%7]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 13:07:26 +0000
From:   "Simpson, Phyllis" <PSimpson@isdh.IN.gov>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: FW: [PATCH 5/8] submodule API & "absorbgitdirs": remove
 "----recursive" option
Thread-Topic: [PATCH 5/8] submodule API & "absorbgitdirs": remove
 "----recursive" option
Thread-Index: AQHY7pBcpFAJt3GgrEOpUgTSQYElcq4t0QIAgAAvZoCAAL8X0A==
Date:   Fri, 4 Nov 2022 13:07:25 +0000
Message-ID: <SA1PR09MB8703677F86916FC099E2878F903B9@SA1PR09MB8703.namprd09.prod.outlook.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
 <patch-5.8-2b8afd73b9b-20221102T074148Z-avarab@gmail.com>
 <kl6la657odjz.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221104.86fsezze6p.gmgdl@evledraar.gmail.com>
In-Reply-To: <221104.86fsezze6p.gmgdl@evledraar.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=isdh.IN.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR09MB8703:EE_|SA0PR09MB7354:EE_
x-ms-office365-filtering-correlation-id: 54b66824-5b69-41e8-5e53-08dabe65850c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: azUztejGo+tUsDTdF6vdPCfSv5cMY69fmqx/nYxspDUoetK7srakjVAs6AuQCA2AqPibnpo2hqKAHU0DESn++XRfY6kNeRFRRhGA49kQnZ7ApeYf6Mqr1nzB0BLAzWiyUFBZORRZC4Fgjrdg+G19YlhM8OEPaaOcqksVd0vckqxo0Jw6aXo/Be8yKNoWE8kk0cgtoJlLIae/Wbe8j0f3YoYRIkLFoiW6RWaTZ+zreUp2/trV8V1d4pQVfBbq5VmH7Q7y1a4vkljVFDduAPLecB63+kxRA14ZAhWZnMADEmG9Xeds/Rk9OeLEBKSDr1DXdOBEnQ47WG+hEnGwRVmF/nSSAhrEGOUOy1wHQ7X4dFvHKq0pnW2Of1tfiyzBRGEK60sz9Aw2/EB+284KZ2nTrxwkpjrNEuTcs5Yro98zDRoZc2ybAUK9yhyWphHXpqPNmM1nNpZ33Ht5GSuWZkwQavK0BwzaEVigKI2P8xz+9Ll1pwxfanjZNvUIhYEFaTy3T/c0m2JilR6i6kyxtJYOFfRsEmrAgjcIbozdvVPIabDQ20ulhwmj53zbsO8lCuV8SP1T4ArXZWdN4hxKiFMGKh8o+F3UdvPVnC9roqB5rW1INBf8nuwWr2Ni0zuvhWOHQ1b5rKEv7fvL6bB7DtSbCg7y+NBK7EazQZnhp7MJAtRaODfPrB0g6nGNRlEm5zQ/isbictCSpFjKTk0joUt/aF10UYkDluSI2HPwmfB/i/IzV82Q4NYThf/sJK7ZHOuxPpBZBi9GYCXE1w21+Y8+VA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB8703.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(2906002)(66574015)(83380400001)(33656002)(8676002)(64756008)(66556008)(66476007)(66446008)(66946007)(26005)(9686003)(55016003)(38070700005)(86362001)(76116006)(40140700001)(122000001)(38100700002)(52536014)(5660300002)(186003)(8936002)(6506007)(53546011)(7696005)(6916009)(71200400001)(498600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUtFbktSUk95aEZZSjhseVA0Q2hSa2ZGY2xESzBEUVQxMURUb211a2g4UzhG?=
 =?utf-8?B?amk5K3NPc3ZVWVBabDZPeUFCU1Q4V2xnQ2xwb2JFSExRWVZWbFpNbHkzeE1y?=
 =?utf-8?B?M0tyV3U5ODhnK20yeTE4NWZsTFBLbGROMjVMT0NJREZzN0tUczN0YUhqRy9S?=
 =?utf-8?B?RU5uUFh6MVVLTU1aMld2UlNBTWJQaER3elVnS3RWZXN5Y2JHTk9lN0EyVWov?=
 =?utf-8?B?RFFZbTJZZ3RrdlZ1ejQ1bDVCejJucG9zT1p6dmhtaTltYXRwK1Rld2tmeWZ3?=
 =?utf-8?B?TjJMZGF4cnJIWVBNUVpJS1d3QnhuanNJVEl1czBXUkxxZW5SVzRPc1FRcGxp?=
 =?utf-8?B?Ym13VFdjTlhTRG4yVTJDZFQ3RDZQNGp2cE9tSi9qUnYwc0tLYklXUUJkRFIw?=
 =?utf-8?B?QjFZZGpIbC9yL3k0ajVhS3c4a21wL2FCOExwTkgwM1ZtaW9UWGFEOUpkc3cx?=
 =?utf-8?B?SkRBMVl4eFE3VTltcVhOck1vV01NM2RiUUQ5OVM0WjZ3UXdadFYwV1FJdy9k?=
 =?utf-8?B?WnRBbmVOYlNORnFicTZpdkFGRWdWWjJxZUl1VkRhakhENlEzdVE3ZGQ2WVNT?=
 =?utf-8?B?RUk1WjBVRnpXb3F6dUp5SW0vblprUFVDeXFSQXhNVk9samM1M0psbE8vZFdP?=
 =?utf-8?B?a2hRbVZyYTRnOW9YVXBDcXFpU2E3VTQxbG9WVDk0dVBrVytVV3JSNVhjUVR6?=
 =?utf-8?B?ZE8yMk8wcjZ5M2VFbGVtb3pFTDUxTXFzQmpONVBzTi9HNzE4NTUzY1hBRnNp?=
 =?utf-8?B?L2FFL0hlV3FZejFyYnFUcU94MkVQK2tpR0xwNzVZWnVST2ZqYVp1MEFuMVcr?=
 =?utf-8?B?dHEzVWUyU2d2RTY1WmxxcTdtQUpIOGNBQVFlREhTRGFvNXV5NHNpRE5UeVpi?=
 =?utf-8?B?dXBKb29KUi9YOWRUdFZFcnBHanRDSGZTQlppd0hSbU90MW1FQ0swWW9zODdr?=
 =?utf-8?B?OHBBQ3huSWswM3pwQmU3ZldkeGZhWUR4bHpGMVdxZkJnTzJNS01HeEJSdWlO?=
 =?utf-8?B?ZURWRzVNOUx3Wlh1Ulh3aXlGSnNwK3BWZi9WcVYrejNPY1U2L0h4Qk9SZFc3?=
 =?utf-8?B?ajVYVHcxa0JRaHZtaTg0blRYb3ZMT2dHS1duQkxNWEhsN3I3VVI1RUtGWHIv?=
 =?utf-8?B?c3NoQkFPN0tRYlNwSnlQTXFEU0Z6UVU0OHAyUmdwMkU1WU9saXJsbkxzODl3?=
 =?utf-8?B?M3dmZ09vM3hFU3V1V0JVc0hBck9FSm1HMWNacG82OC9GU3VjTFhwRHV3OFNv?=
 =?utf-8?B?NjJPZ0pkd0tPTElUay9mZ3cxVXVRdDB2cENTQVFJU1p1QnUvQXROZmF3S054?=
 =?utf-8?B?RVlWeFBrditMTC9WS2hFMUpDaVJGdGNCVllFN3FsdDlhdjhXc0R4WEJSVnB5?=
 =?utf-8?B?bG4yUnF0YzhSWVROWEdFY3d6dW9xVTN6WVE0SXZhbDVMMmNXZHlyODdTNHRu?=
 =?utf-8?B?RzBLck9FR29sR3o5YTVMYnozdldwQnRKZ1ZhMk9wSk56UUVTL0ZpclFDY083?=
 =?utf-8?B?RndwZHRYRUVMdmpLWGdJcGZhZDFKZWd1aEpma0tFa2JMbHA4VWNtZVl5d1VU?=
 =?utf-8?B?Vnl6WW5qaU8rc1JybUpHS2tQVUpwU1ZkLzMvd0Z6MmRpRzdQdUFrOHVIT0ti?=
 =?utf-8?B?UGc4TzhOMmhWdG1zK3dxNVRDRFl1bDdUWmt4RDNQK3RxWmNXSUU0UU5IUkNz?=
 =?utf-8?B?bFZLOHZ5T2hIc1dXclFrTDdRZFB1TmhSL0NtWWJ0RStxbHdCbXVuK3ZQMXI5?=
 =?utf-8?B?bWtGK0RIR2J1N2Z5VUREdHM3YlRGQ1AxcmpUcFZHWCtoZC9GdnpNZ1l2MTNQ?=
 =?utf-8?B?dXFUTm95T2hqZHZ2by84Vmd1RmhCMUtibTBMYzFtQ1pxMXJFUytRTUJPS0RL?=
 =?utf-8?B?TWYrbC9xVEZKUjMxQmVhdG5JUFFTS3RhUHFPc0IxRlRpMFB1b3g1NXYvYU9o?=
 =?utf-8?B?MzBqczhJUCtWaFNoVzRkRkIyVmxoMkF6QXg3UG1XeVNtSHpJOStkRnRtSS9p?=
 =?utf-8?B?ZmVnN0o3RGdxc1Nhd0Npay8rZG5uZjVHY0J6WWVlSmsrNFBLRFlDU2RYeFdw?=
 =?utf-8?B?M25YNjhaSDJsUGdUVFNBOVJpMVVzUDBCWlpiMjc5TzkydU90d05kZ0UvY1FY?=
 =?utf-8?Q?H/rYGaWt8tHmm3UxR5Vy1HdGn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: isdh.in.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB8703.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b66824-5b69-41e8-5e53-08dabe65850c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 13:07:25.9032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2199bfba-a409-4f13-b0c4-18b45933d88d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR09MB7354
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8uDQoNCkkgZG8gbm90IHdpc2ggdG8gZ2V0IHRoZXNlIG1lc3NhZ2VzIGFueSBsb25nZXIu
DQoNClRoYW5rIHlvdS4NCg0KUGh5bGxpcyANCg0KUCBTaW1wc29uwqAgfMKgIEFwcGxpY2F0aW9u
IFN5c3RlbXMgQW5hbHlzdCBQcm9ncmFtbWVyIC0gSW50DQpPZmZpY2Ugb2YgVGVjaG5vbG9neSAm
IEN5YmVyc2VjdXJpdHkNCm9mZmljZTogMzE3LTIzMy04NDc3DQpwc2ltcHNvbkBoZWFsdGguaW4u
Z292DQpoZWFsdGguaW4uZ292DQrCoMKgwqANCg0KDQoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogw4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24gPGF2YXJhYkBnbWFpbC5j
b20+IA0KU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDMsIDIwMjIgOTo0MyBQTQ0KVG86IEdsZW4g
Q2hvbyA8Y2hvb2dsZW5AZ29vZ2xlLmNvbT4NCkNjOiBnaXRAdmdlci5rZXJuZWwub3JnOyBKdW5p
byBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+OyBFbWlseSBTaGFmZmVyIDxlbWlseXNoYWZm
ZXJAZ29vZ2xlLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggNS84XSBzdWJtb2R1bGUgQVBJICYg
ImFic29yYmdpdGRpcnMiOiByZW1vdmUgIi0tLS1yZWN1cnNpdmUiIG9wdGlvbg0KDQoqKioqIFRo
aXMgaXMgYW4gRVhURVJOQUwgZW1haWwuIEV4ZXJjaXNlIGNhdXRpb24uIERPIE5PVCBvcGVuIGF0
dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzIGZyb20gdW5rbm93biBzZW5kZXJzIG9yIHVuZXhwZWN0
ZWQgZW1haWwuICoqKiogX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KT24gVGh1
LCBOb3YgMDMgMjAyMiwgR2xlbiBDaG9vIHdyb3RlOg0KDQo+IMOGdmFyIEFybmZqw7Zyw7AgQmph
cm1hc29uIDxhdmFyYWJAZ21haWwuY29tPiB3cml0ZXM6DQo+DQo+PiBSZW1vdmUgdGhlICItLS0t
cmVjdXJzaXZlIiBvcHRpb24gdG8gImdpdCBzdWJtb2R1bGUtLWhlbHBlciANCj4+IGFic29yYmdp
dGRpcnMiICh5ZXMsIHdpdGggNCBkYXNoZXMsIG5vdCAyKS4NCj4NCj4gby5PDQo+DQo+IEF0IGxl
YXN0IHRoaXMgbWFrZXMgaXQgcHJldHR5IGVhc3kgdG8gZ3JlcCBmb3IgdXNhZ2UsIGFuZCBpdCBt
YWtlcyANCj4gc2Vuc2UgdGhhdCB3ZSd2ZSBuZXZlciB1c2VkIGl0IChvdGhlcndpc2UgdGhpcyB3
b3VsZCd2ZSBiZWVuIGNhdWdodCkuDQo+DQo+PiBkaWZmIC0tZ2l0IGEvc3VibW9kdWxlLmMgYi9z
dWJtb2R1bGUuYyBpbmRleCBmZTFlM2YwMzkwNS4uOGZhMmFkNDU3YjIgDQo+PiAxMDA2NDQNCj4+
IC0tLSBhL3N1Ym1vZHVsZS5jDQo+PiArKysgYi9zdWJtb2R1bGUuYw0KPj4gQEAgLTIzMzIsOCAr
MjMzMSw3IEBAIHN0YXRpYyB2b2lkIGFic29yYl9naXRfZGlyX2ludG9fc3VwZXJwcm9qZWN0X3Jl
Y3Vyc2UoY29uc3QgY2hhciAqcGF0aCkNCj4+ICAgKiBoYXZpbmcgaXRzIGdpdCBkaXJlY3Rvcnkg
d2l0aGluIHRoZSB3b3JraW5nIHRyZWUgdG8gdGhlIGdpdCBkaXIgbmVzdGVkDQo+PiAgICogaW4g
aXRzIHN1cGVycHJvamVjdHMgZ2l0IGRpciB1bmRlciBtb2R1bGVzLy4NCj4+ICAgKi8NCj4+IC12
b2lkIGFic29yYl9naXRfZGlyX2ludG9fc3VwZXJwcm9qZWN0KGNvbnN0IGNoYXIgKnBhdGgsDQo+
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGZsYWdzKQ0KPj4g
K3ZvaWQgYWJzb3JiX2dpdF9kaXJfaW50b19zdXBlcnByb2plY3QoY29uc3QgY2hhciAqcGF0aCkN
Cj4+ICB7DQo+PiAgICAgIGludCBlcnJfY29kZTsNCj4+ICAgICAgY29uc3QgY2hhciAqc3ViX2dp
dF9kaXI7DQo+PiBAQCAtMjM4MiwxMiArMjM4MCw3IEBAIHZvaWQgYWJzb3JiX2dpdF9kaXJfaW50
b19zdXBlcnByb2plY3QoY29uc3QgY2hhciAqcGF0aCwNCj4+ICAgICAgfQ0KPj4gICAgICBzdHJi
dWZfcmVsZWFzZSgmZ2l0ZGlyKTsNCj4+DQo+PiAtICAgIGlmIChmbGFncyAmIEFCU09SQl9HSVRE
SVJfUkVDVVJTRV9TVUJNT0RVTEVTKSB7DQo+PiAtICAgICAgICAgICAgaWYgKGZsYWdzICYgfkFC
U09SQl9HSVRESVJfUkVDVVJTRV9TVUJNT0RVTEVTKQ0KPj4gLSAgICAgICAgICAgICAgICAgICAg
QlVHKCJ3ZSBkb24ndCBrbm93IGhvdyB0byBwYXNzIHRoZSBmbGFncyBkb3duPyIpOw0KPj4gLQ0K
Pj4gLSAgICAgICAgICAgIGFic29yYl9naXRfZGlyX2ludG9fc3VwZXJwcm9qZWN0X3JlY3Vyc2Uo
cGF0aCk7DQo+PiAtICAgIH0NCj4+ICsgICAgYWJzb3JiX2dpdF9kaXJfaW50b19zdXBlcnByb2pl
Y3RfcmVjdXJzZShwYXRoKTsNCj4+ICB9DQo+DQo+IE1heWJlIEknbSBtaXNyZWFkaW5nLCBidXQg
SSBkb24ndCBmb2xsb3cgdGhpcyBjaGFuZ2UuDQo+DQo+IEJlZm9yZSwgd2UgcmVjdXJzZWQgaW50
byB0aGUgc3VibW9kdWxlIG9ubHkgaWYgdGhlIA0KPiBBQlNPUkJfR0lURElSX1JFQ1VSU0VfU1VC
TU9EVUxFUyBmbGFnIGlzIHNldCAod2hpY2ggd2Ugbm93IGtub3cgaXMgDQo+IG5ldmVyKSwgYnV0
IG5vdyB3ZSB1bmNvbmRpdGlvbmFsbHkgcmVjdXJzZSBpbnRvIHRoZSBzdWJtb2R1bGUuDQoNCk5v
LCBpdCdzIGFsd2F5cyBzZXQuIEkuZS4gLS0tLXJlY3Vyc2l2ZSBkaWQgbm90aGluZywgYnV0IHRo
ZSBkZWZhdWx0IHdhcyB0byBhbHdheXMgc2V0IEFCU09SQl9HSVRESVJfUkVDVVJTRV9TVUJNT0RV
TEVTLCBzbyBpdCB3YXMgbmV2ZXIgbm90LXNldCAoYW5kIHRoZXJlIHdhcyBubyAtLW5vLS0tcmVj
dXJzaXZlIHVzZXIpLg0KDQpTbyB3ZSBzaG91bGQgYmUgdW5jb25kaXRpb25hbGx5IGdvaW5nIG9u
IHRoaXMgcmVjdXJzaXZlIHBhdGguDQo=
