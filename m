Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383D0C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1349E611AB
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbhETPPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:15:38 -0400
Received: from smtppost.atos.net ([193.56.114.176]:25812 "EHLO
        smarthost3.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232067AbhETPPh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1621523656; x=1653059656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K0qHjhvclA7wAaZOvI6VQM/4vZXO2y5oXAaVKDqVeA0=;
  b=gU7qVUmn9RGx7yl2TQl7niIclixwCI9Y0Ga9dBWFq7MgKQoVgnz6YqTk
   6MWIT4A4Knj3HviugMsiRoG+Bwgo6jSyNw3SE5pY3YCcGUvoqV5Dl/VUb
   J0LHihYSMTqvjfPwLbMS0qvafNqm3cl8xv/rCIT43C8xMZlAj3YubBgoY
   4=;
X-IronPort-AV: E=Sophos;i="5.82,313,1613430000"; 
   d="scan'208";a="203087440"
X-MGA-submission: =?us-ascii?q?MDGrnoLH+wbGB5BerjxTAp4+THsoI3hyhwPuqR?=
 =?us-ascii?q?4s+zP2/EZTxoVmo+RE9OOm4E5dUFCmQskol4lKmjX0lie7unZYDiSsLe?=
 =?us-ascii?q?0Trx1qyDe+U880Iu317G5uRC5vldM7kf9YhH3MmGr9K3Nj9l4MjjNBn6?=
 =?us-ascii?q?Ge?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB23.ww931.my-it-solutions.net) ([10.89.29.133])
  by smarthost3.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 20 May 2021 17:14:12 +0200
Received: from GITEXCPRDMB22.ww931.my-it-solutions.net (10.89.29.132) by
 GITEXCPRDMB23.ww931.my-it-solutions.net (10.89.29.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 17:14:11 +0200
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (172.16.214.168)
 by GITEXCPRDMB22.ww931.my-it-solutions.net (10.89.29.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2 via Frontend Transport; Thu, 20 May 2021 17:14:11 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHjOrebU/UrC+KmQYkCEpayKaLF9nyMlxV/Uvbui4yM4GvJgZAENlYkPo+PWj3s+adLRckayi7GlIeJByVJpiyXYdj6hQ1ykXvdNxLmItbCqDlEdD72dKnVrKHInrlIMN5sXrdi7jvwM0ai4MtoZwTjURoNuvfM0nwxaVXLz2nOMdeqsa0xomLSDSdcXx2xXUGPFlpzfwgD2MzpIQntmNxr2issc4azSSfcDqdTs2h6Lxw1CXHegGgDc45WUXtQhM5ieujTYG7ijwDOhzItaRukos0k21qlZ6PAheUKiH5QpkfNWVlCLlDPz50Rl4uV0+D87dv9vO4SO9isBEJZbyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0qHjhvclA7wAaZOvI6VQM/4vZXO2y5oXAaVKDqVeA0=;
 b=m2kZuj9qe1BJ8+oEh9NNBeHvbHyV5JC+OAl68XPaV91IKtafQzRhNLkr87zePniL7/Xh+TME7cJo9qeo+ux3yiZsc9L8XiiHb0gs+xURL9ob9h/cB1AubGzq9GB6IeczsNWCvtN+vqK2OUon/lS225VJkrqAC/y4bS6LmgAJN0HUoCEc/3llE57CThSbYoRx36MNocVzImzU/dO2vVgHrYDC43AWOBVaeES0LOE4ZwyGMg2YHG8ZtlNDccxReP2DhXvuBGrhunYBMuv8VC9FdLp+avVJuttfKJIKKoMcox/byiBVK9wrDG1N+DU23D1UYGQBc8xIUQFiHRxW2VL97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by AS8PR02MB6725.eurprd02.prod.outlook.com (2603:10a6:20b:254::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Thu, 20 May
 2021 15:14:10 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::90a7:5df7:6e31:ecfb]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::90a7:5df7:6e31:ecfb%3]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 15:14:10 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: RE: [PATCH v3 02/13] Documentation/technical: describe remembering
 renames optimization
Thread-Topic: [PATCH v3 02/13] Documentation/technical: describe remembering
 renames optimization
Thread-Index: AQHXTT7VtIRHXZuNuk6KdX07+AdVWKrsPTMAgAA87aA=
Date:   Thu, 20 May 2021 15:14:10 +0000
Message-ID: <AS8PR02MB73026048813DC055FB8DC30E9C2A9@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
 <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
 <4246d0193fed5ff522fb2c442bd779973701c078.1621490982.git.gitgitgadget@gmail.com>
 <ef450bbd-0cbb-a512-d88e-eca6638358aa@gmail.com>
In-Reply-To: <ef450bbd-0cbb-a512-d88e-eca6638358aa@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-05-20T15:13:30Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=bc50dd87-9583-4f27-8ffa-ee6314f61f12;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=atos.net;
x-originating-ip: [165.225.197.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5213da96-f705-409a-a932-08d91ba1eb72
x-ms-traffictypediagnostic: AS8PR02MB6725:
x-microsoft-antispam-prvs: <AS8PR02MB6725B86E47FEF2FBD72A73619C2A9@AS8PR02MB6725.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a0U6FPWxK6QqALrsUp/UWOBT7XOWwv0qSiVBFOPdy2xtwwMeIWXoygPlbR+FfYc6GxQE7cVZTQsKUdOXTIj1SE6zposc628YTz9YWotpj0+rU5prnuKESoPHV+ij+Yfx5NyAq8ydzulJjzul8awYD8SA1FGHKnEk9IQtOXYCIeDh1Yy5AcXKzJO9mrDilK6s54FBFngif7iUxxo4rdYx8lQDIqmWp6BwTRafIqN3PfQ1aHCePyrqQxFNUhRYuLtnUIilcAjXlxSfz4JlR3CDDZ7f/SztMQPkcyVAK7LdIUGZlZOnloEfsMtZ5UE93vXnHs3DGs+ykGf8xFWN/fMoZ9v4bKvHC+DEQBKJGkrRfWL6ZMxPvlT/bkyzJW9eKYY05sSXIdq1gK2MR4CgnlSFVQp2g64NhYMnKoLJHlq1uZI9MxMXAND+SsMn6V2acFWzyLTqhjqlEFuqabHRuO77f9EWAwrCegrMEstkifsmS8+zrHlhFNPxvOagXHj8CbO6+wy6l/OKEnAKFzvkCLu9IrDxJHqSGg2xk5VPWFVrssjd+PmenfE7HSPUmKpeTT2qEmoYt6y/tRVPVDU8vftRApWOwK3fgMXnqp22zIsRrPQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39850400004)(55016002)(66946007)(66476007)(76116006)(66446008)(64756008)(71200400001)(55236004)(186003)(2906002)(33656002)(53546011)(66556008)(4326008)(26005)(8936002)(6506007)(8676002)(122000001)(52536014)(9686003)(38100700002)(83380400001)(7696005)(478600001)(316002)(86362001)(54906003)(110136005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEk5Q1RCNENmcEtmaklOOGZjMkdFZWgxSVc4dFh4d1lkdzcwVG5PSjlkVFov?=
 =?utf-8?B?V2k2RkVvbHZLV2ZvVU4rbThFU0ZlREt6dGdEdHNIeDVaeklYeVoxN3pveFBV?=
 =?utf-8?B?WllRemR0dFMyclZFaFhmRkQvbkFNd3laY1kyR21HdGM3NGRTSEVDMk1SaU9q?=
 =?utf-8?B?eURkdXUxUktXZ3FxSW1yWURXZ0NEY09IK3ZwMkhTK0VWd0dKWFpGbUg4eWRX?=
 =?utf-8?B?WG05VGJsdFplMHhvdG9ESmw5ajJjc2Fjcm9rRUJDYVJHM2h3bGoyYUFpcjZ4?=
 =?utf-8?B?SEpoSElkYjY3bm42dVE2SW9qTDdKekV1VDVOVEtMelBKY0l6SVpXSGZURGx5?=
 =?utf-8?B?aDBOaklXQWFmSzZRSkRBUkpXaDFGc3pFNzNDZWpTeldPczZsWDlPbCtNcUUw?=
 =?utf-8?B?S3I1Zlg0bW8xYVQ4UGZlR0NjaFl5a3luRGZTdTZibERZTFJXc2ZnT1czWDBj?=
 =?utf-8?B?N3FDdksyUFZmZ2NsdUIwVnM3UU8rV29IYlI0eGUxQzE4cjgrVVF0K05SaGVr?=
 =?utf-8?B?dFNwcnMvK2o1OWUwRFhNWmVkQlJIQVYvQ2RCWnV3cGFYZHU5ZXpNdkVCOW0x?=
 =?utf-8?B?T290WFhWaVpnMUY1MmpmUDFUR0ZKRHVnT0E3clJsU002bmRlT05PQzZ6Vi9X?=
 =?utf-8?B?c1BJcXpzYmdpR1N5VUlkWWV3VHdTdFdjN3g0b2FoRVBNQy9xZ0tTbFBhUVNK?=
 =?utf-8?B?amRjZms2TjZndHIxZW4yOGgyajFlMk8yT0ZjQm9yd1pnN3JycU5hZ2pHNkYv?=
 =?utf-8?B?N0pPemswazNqMjMvYzYrSDdpZU9NRnF1M3Z5ZFQxNGNxZTV0VXVRRFlzN3Ji?=
 =?utf-8?B?dCs0ZXQzOXF4R0pLaWlFNzkvUnJMQjRXTU5LRCtFZnNkd2gwV0xhRjY3S3Za?=
 =?utf-8?B?VkJSWkdKOThFRUVWdEZJTWxtM2o3OGs0S3UwWnBid0orM3B3RkFSSEp2ZkM1?=
 =?utf-8?B?MzNkazl4Z21OS214L29lVVQ3QTlCQ0RnL0NxRWlGd1ZlYjhjNCtvUmRkWTJy?=
 =?utf-8?B?a3RBUGM4K01zcWIwaUVkODh3SmVvRjhYWEJqZFplNENKTU5kTHc3U3AxZE9I?=
 =?utf-8?B?NkpKRERDYVBuMTBXUXlqRUczUXBLcjJuWWozaTF1ZzdORnc5d21LclYxVmcv?=
 =?utf-8?B?TmNmeWwrSnF3a3JPQk9yOHVWNG9pRVI4TXliR0llaXFDdjBybFRnNmFSY1dT?=
 =?utf-8?B?RlJmZ25SMnBPYTlGMzd5T2tSZVVaOFRLbDhReG8rZCtsREt4Vno4T2dLQkE1?=
 =?utf-8?B?R3M5TTNuV3ZlT3dkaEwyRVM1ODRYNWNwRWFMSGtZQkozT1VBTEpMcmJoaW8w?=
 =?utf-8?B?ZlUxb0FhRVFyZUtIZFl6SXJYVi9ocEw3N3VZNFFmQTVSVDN1d1FGanVMS01l?=
 =?utf-8?B?L3Q1dU54clJxNndpYmRDbmdnRXpFdzd6cVE1bTYySWFiT2NvVTlkZy9XTHcy?=
 =?utf-8?B?TW9ESDk4VGhRakJpaVRQTkpkMUdJZnlsdURONzgrU3QwQTFuV2RmazUrMlFm?=
 =?utf-8?B?bVV0aXdJSTl1UUxUSXVwNHhhQWpUdmdZSnFJMzJYZEtKRTMzYUh3Qzg5QUN6?=
 =?utf-8?B?bDRtMkluN1Njd20wRU83TUFLMmxGMlpZZ21lb2ZCRjlXL1NNMno5dFBsOHZh?=
 =?utf-8?B?SWRMdGdTemlxYmRqbHJDYVpnRlJWS0RTRzVFUUd4UU13dEovcVVXTFlDZjky?=
 =?utf-8?B?TGk4R2lSU2dJc1gxc1FNRnVFd2VCR21qWngvK3VYNitUTnd2OVV6TXVJSTlC?=
 =?utf-8?Q?ZEkuc+s6RJPQWRHxOvFOvNNAYIIpNwIFfcNq5do?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5213da96-f705-409a-a932-08d91ba1eb72
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 15:14:10.2534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWs0Xfzwoz7NPGgiBoG0vLfPjm/7f4gPqnw6Ih9Qa8x9xFAw2TdzPmS4UglVJXx6XZiQkoi+wk/x13OqeSFasA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6725
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCkZyb206IEJhZ2FzIFNhbmpheWEgPGJhZ2FzZG90bWVAZ21haWwuY29tPiANClNlbnQ6IDIw
IE1heSAyMDIxIDEyOjMzDQpTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAyLzEzXSBEb2N1bWVudGF0
aW9uL3RlY2huaWNhbDogZGVzY3JpYmUgcmVtZW1iZXJpbmcgcmVuYW1lcyBvcHRpbWl6YXRpb24N
Cg0KT24gMjAvMDUvMjEgMTMuMDksIEVsaWphaCBOZXdyZW4gdmlhIEdpdEdpdEdhZGdldCB3cm90
ZToNCj4gK091dGxpbmU6DQo+ICsNCj4gKyAgMC4gQXNzdW1wdGlvbnMNCj4gKw0KPiArICAxLiBI
b3cgcmViYXNpbmcgYW5kIGNoZXJyeS1waWNraW5nIHdvcmsNCj4gKw0KPiArICAyLiBXaHkgdGhl
IHJlbmFtZXMgb24gTUVSR0VfU0lERTEgaW4gYW55IGdpdmVuIHBpY2sgYXJlICphbHdheXMqIGEN
Cj4gKyAgICAgc3VwZXJzZXQgb2YgdGhlIHJlbmFtZXMgb24gTUVSR0VfU0lERTEgZm9yIHRoZSBu
ZXh0IHBpY2suDQo+ICsNCj4gKyAgMy4gV2h5IGFueSByZW5hbWUgb24gTUVSR0VfU0lERTEgaW4g
YW55IGdpdmVuIHBpY2sgaXMgX2FsbW9zdF8gYWx3YXlzIGFsc28NCj4gKyAgICAgYSByZW5hbWUg
b24gTUVSR0VfU0lERTEgZm9yIHRoZSBuZXh0IHBpY2sNCj4gKw0KPiArICA0LiBBIGRldGFpbGVk
IGRlc2NyaXB0aW9uIG9mIHRoZSB0aGUgY291bnRlci1leGFtcGxlcyB0byAjMy4NCj4gKw0KPiAr
ICA1LiBXaHkgdGhlIHNwZWNpYWwgY2FzZXMgaW4gIzQgYXJlIHN0aWxsIGZ1bGx5IHJlYXNvbmFi
bGUgdG8gdXNlIHRvIHBhaXINCj4gKyAgICAgdXAgZmlsZXMgZm9yIHRocmVlLXdheSBjb250ZW50
IG1lcmdpbmcgaW4gdGhlIG1lcmdlIG1hY2hpbmVyeSwgYW5kIHdoeQ0KPiArICAgICB0aGV5IGRv
IG5vdCBhZmZlY3QgdGhlIGNvcnJlY3RuZXNzIG9mIHRoZSBtZXJnZS4NCj4gKw0KPiArICA2LiBJ
bnRlcmFjdGlvbiB3aXRoIHNraXBwaW5nIG9mICJpcnJlbGV2YW50IiByZW5hbWVzDQo+ICsNCj4g
KyAgNy4gQWRkaXRpb25hbCBpdGVtcyB0aGF0IG5lZWQgdG8gYmUgY2FjaGVkDQo+ICsNCj4gKyAg
OC4gSG93IGRpcmVjdG9yeSByZW5hbWUgZGV0ZWN0aW9uIGludGVyYWN0cyB3aXRoIHRoZSBhYm92
ZSBhbmQgd2h5IHRoaXMNCj4gKyAgICAgb3B0aW1pemF0aW9uIGlzIHN0aWxsIHNhZmUgZXZlbiBp
ZiBtZXJnZS5kaXJlY3RvcnlSZW5hbWVzIGlzIHNldCB0bw0KPiArICAgICAidHJ1ZSIuDQo+ICsN
Cg0KRm9yIGl0ZW0gMSwgMiwgMywgNSwgOCwgaXQgc2VlbXMgdGhhdCB5b3UgZm9ybSBxdWVzdGlv
biBzZW50ZW5jZXMgYnV0IGVuZGVkIHdpdGggZG90LCBpbnN0ZWFkIG9mIHF1ZXN0aW9uIG1hcmsg
KD8pLiBBcmUgdGhlc2UgcXVlc3Rpb24gc2VudGVuY2VzIG9yIGRlc2NyaXB0aXZlIHNlbnRlbmNl
cz8NCg0KW1JLXSBOb3Qgc28uICANCltSS10gVGhlc2UgYXJlIGFsbCAiSG93IHRoZSBsZW9wYXJk
IGNoYW5nZWQgaGlzIHNwb3RzLg0KW1JLXSBOb3QgIkhvdyBkZCB0aGUgbGVvcGFyZCBjaGFuZ2Ug
aGlzIHNwb3RzID8iICB3aGljaCBvZiBjb3Vyc2UgZG9lcyBuZWVkIHRoZSBxdWVzdGlvbiBtYXJr
Lg0KW1JLXSBUaGV5IGFyZSBub3Qgc2VudGVuY2VzLCBidXQgaGVhZGluZ3MuDQoNCg==
