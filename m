Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0EDC2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91ABF61969
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhFYQzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:55:35 -0400
Received: from smtppost.atos.net ([193.56.114.176]:9405 "EHLO
        smarthost3.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229586AbhFYQze (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1624639993; x=1656175993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wlFfSs9VTpsXxV7pNOV/G2ObqiKpFp096n+aNhwHFq8=;
  b=SpDoZfZMGPwyN/EzWfKvgsOdt0SHmrMsCLi/8Yv/kf7HUqkZ0qUhQxL0
   26i7sEtWsQ9VfM9WnwCHBxL57k+37YgjAoulo+BoSQ6/dviIUtGpNUhwW
   2tv3dtxeLHJMYaasoJlaFFP57CRfzlOBnTEUiiXjX89fJPezF/eAfzYL0
   Q=;
X-IronPort-AV: E=Sophos;i="5.83,299,1616454000"; 
   d="scan'208";a="219242397"
X-MGA-submission: =?us-ascii?q?MDGEtZWvAofIjNgCBnDtF6n4PG03nolZjKE1A4?=
 =?us-ascii?q?4T/CSF+URz+wNaM+wvhNvb8L5wAcJadTLOWj1WDHLrLy0xcNtGJZ61HL?=
 =?us-ascii?q?ggeJ/cHa1fA47lCgoJ1in4ehWDsmGsGpEBpExsrf1lAWV9HAT/bwUcA/?=
 =?us-ascii?q?0h?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB13.ww931.my-it-solutions.net) ([10.89.28.143])
  by smarthost3.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2021 18:53:11 +0200
Received: from GITEXCPRDMB13.ww931.my-it-solutions.net (10.89.28.143) by
 GITEXCPRDMB13.ww931.my-it-solutions.net (10.89.28.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 25 Jun 2021 18:53:11 +0200
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (172.16.214.172)
 by GITEXCPRDMB13.ww931.my-it-solutions.net (10.89.28.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Fri, 25 Jun 2021 18:53:11 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDXu4T9Qen6c4FioaFViIfO0IuJKLWRlswTCAcZA8e51EuogGpP8lOTLBgsofSpJtfAfpR7GfnPgpxy9nDnHNhp3vpafvenaV/GiY1+otfOr5LkjTi5FsGQIrQkh8gnBEg9scFdG7pe8CZl8iCyiKqaXdoRBhbW/IeFXx3/k+tfpZh2YYIodTUX45CnRkeI4YO1NkWGtfnF8w5JRwzXaEFK7ROdRoxerW2YhZzt9QTeDS/ipNKC61ZFydToz2Z3gAR7ePAz15ceIIYHEgoFcTwc6YK9x7ky+E1XCpaAIxaC8DqJZLGcwvAVuI8jeWoA9qsLQIiKmOpVIt776ErfaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlFfSs9VTpsXxV7pNOV/G2ObqiKpFp096n+aNhwHFq8=;
 b=VSGh+bCc4dQm0ke6lFALwnswrKwiFREKOMl80pxQrO2K+DYIz1cCqvR7v24Sw6CcCrPCJRR2vXyEcYxmSVi0aSDYjJ8BhdpBA/EHatKJwsEcdBRBXuKiEHUWSaMQ3qLlRwlzWnTBrzUc2IMIHLjvQ5xbRADtpygSQXTPodvMTkZcNrZY9HxgA0DPQty23mgHDHHmVpYKEnu3/VI0m4Wja7roPIJrcrEu2jOex14sNzz2wjRSr6H0fhrd6NR0p+DfGVayCxkDo6B19YMVMrDTSG7lnf26yD+OcY5dskadONRfDDsj8FrKLrj0QG1A+8wuj/uymN6cJLbBvo7IzDz8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by AM6PR02MB5638.eurprd02.prod.outlook.com (2603:10a6:20b:e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Fri, 25 Jun
 2021 16:53:09 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::ed80:b8f7:efc7:e147]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::ed80:b8f7:efc7:e147%5]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 16:53:09 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
CC:     Philip Oakley <philipoakley@iee.email>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: RE: [PATCH 1/2] doc: pull: explain what is a fast-forward
Thread-Topic: [PATCH 1/2] doc: pull: explain what is a fast-forward
Thread-Index: AQHXZsZ3L+CL4WFvAkWGiyjhnrK9kasjOwGAgAACtwCAACk5AIAAIy0AgAAy8ICAABphAIAAn3yAgAAacACAAANZgIAARg3w
Date:   Fri, 25 Jun 2021 16:53:08 +0000
Message-ID: <AS8PR02MB730230DADF38B6C572CE8DC39C069@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-2-felipe.contreras@gmail.com>
 <b4e612ba-21c7-3bef-d113-0f070449cd87@iee.email>
 <60d49748b8538_2fb2082c@natae.notmuch>
 <c2170f74-b93b-599b-1fb4-45b013c7bff1@iee.email>
 <60d4d75e7622c_242620854@natae.notmuch>
 <93084036-804d-4c52-2836-42efd5deba1c@iee.email>
 <60d5183a9e34d_3a20208b@natae.notmuch> <87im22xpp4.fsf@evledraar.gmail.com>
 <60d5b430f2f13_ba7520890@natae.notmuch> <87czsaxksc.fsf@evledraar.gmail.com>
In-Reply-To: <87czsaxksc.fsf@evledraar.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-06-25T16:53:06Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=8f268bcc-f33e-41a1-a69e-4cd00cd35af0;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=atos.net;
x-originating-ip: [165.225.199.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8dddd6b-adcf-4df5-c36e-08d937f9b62a
x-ms-traffictypediagnostic: AM6PR02MB5638:
x-microsoft-antispam-prvs: <AM6PR02MB5638FFA563F49C86449D23279C069@AM6PR02MB5638.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WIsTPZQ90E523OKl2W+g2JdDrs0gMCedBY2hmpqARkpuk2l0dQM/Vqra7yuARzaFPBgMluQbf+eN85dh3x345+wY1VEBPOK626s7pg9pWcc9Ard1uZOs2ER4eQex3S6uapWNym/5rq7qo4Eb2ei3n52RxTMAiU1fnGwPYoaJulv3Qt4RSueDU9vJIJehk6PNn27nFP5Tr21Dr4RmjaIX5vsZmjd1TmLAfZs/PA5mQ0Ibcfqw3HE6HjH69+HBMvTP81+A35lYH1r+w+gl4tCFk178otglBw7ijQE7aWvRkv6IXwf+wR+jbQIfbhNDhCxlIRpqt88Xn3X1LEMj/c0CkLocUVP0HUuVFZGWG3rYeRrNcqvcRFJ/4MKZ9xKQA07/zWEPiP6ANnCgPGDzI9oJiBF8BATdZHvHmeFTq8bgLPvH2Ma0AGmle+mLPg2f7VTMyb0aWNhL/kAt0cEC/lYoLlld3oIdysIQkyIGxAFTYF7txkXVhptVrnKgdR8twFNsJaPA1GCRTB5MpRFwYXreThE9zc31sy/7GjC8aTJKVCnSnZPNFi5hTE/9C7RubSWpBqNaZpPWmyWIPREJ7W7+ZmOLI7LPXQ0IWavNYcIouMw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6506007)(86362001)(8676002)(71200400001)(83380400001)(66446008)(64756008)(66556008)(66476007)(186003)(5660300002)(26005)(122000001)(7696005)(54906003)(316002)(76116006)(55236004)(110136005)(66946007)(8936002)(9686003)(7416002)(38100700002)(4326008)(478600001)(55016002)(33656002)(66574015)(2906002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFBucVZwdURmbFJFK2ZOWWQ1cGZiUEl5Z0JRTDlNWlo3OFgzNUtMaEh3VjEx?=
 =?utf-8?B?bUNWL0JSMFZkK0hkZDU3R2E4U3dpVWhLOGJsUGg1QUxXVWJHQUJkZWtHY1d4?=
 =?utf-8?B?V1U0VkIwVkI5N1M1NmFnVVFFeGJhY1VvMC94eFBQaWNqbk5XdnlWMThVcW9Y?=
 =?utf-8?B?VElDS1V3dWtIcnVHWU5uYm5abHM1R2V3RXNLOTJ3RHZ2ZkRCOWpIcXc1Q21w?=
 =?utf-8?B?SVlhcGVRYVFsTktqY0pyOUwrNW9wa2Jia3JRTVJQY0M1RUlZdHdnYUgralc4?=
 =?utf-8?B?SGJZUmVKZmhyWnFqNVBGT3Fka2ZGY0IvYmhndk4wby9UeHNkaTBEbkd2aHpi?=
 =?utf-8?B?N0pPVVh5VUdWcFN5d3plWW9pYVIwL1dmNWM2WUVZWmNrbElGbDg3RkFpLy9h?=
 =?utf-8?B?T2JobFpjQld4OVpBbDEzV0RCZ2gyYXFPWCtzV2lsb09ocGoweGFHcUdwWXE2?=
 =?utf-8?B?VUdYUHRRQlBXM3pGQmdlZHVwRW1CQzUvTWszelRFZ2NkaCthd0V1ZTFHSjJ5?=
 =?utf-8?B?dDljK3dqZTZncXZRYWFnQmtwaG5ibldPMEFreWs0cVdyR2RSbEpQcGJzUnhV?=
 =?utf-8?B?Rjd0MktkZGtXVTh5WHhNeXllM05vcFpoNGdhamt6L3BTTE51U1lkQlFwYWw2?=
 =?utf-8?B?UTEvZUFEQmN6TitxejhJZXRtSndPTFkvYkd2VXFIOGRVSmNqdHBFLyt0WFRG?=
 =?utf-8?B?TnZZemNSMFJsTkpFSGtwV2d6aUNtZ1NIaVFsZTNQOUtXbDZTWEV3OVBYZ2FC?=
 =?utf-8?B?VzNtTHp5ZHNVcGlCaE9YRkdpRDVoNmVqeVdHTlZPeGxlZmdobEs1Rnp2OElJ?=
 =?utf-8?B?eCt0bHJRM05qcklDZk9qcHdPMTJPMXlQbVlVUTJuRXQ3UEhudXpkck1DdWE2?=
 =?utf-8?B?VGl3eUhvWnQ0RnRIaXZzSTNDalhGLzY4SEdXTFM5aEswUEU3OVg3UFJsT0hY?=
 =?utf-8?B?cjJuN0dVQ25jdVorcW5xUWhuNTJBSGEvdVh6ekc2Z0RMSUVkRkcwM0FEbjlP?=
 =?utf-8?B?cGxtSUhibjlKVDBhQ2FtYzZKK05HN2dycmhKZWxzL1hUb0ZUQTI4OUp0OXFR?=
 =?utf-8?B?SFJxR1Eyejh6VWdKU2E0VWpMYyt5UlA0OGYxVERxZFRQb3JNWXpadU1VOXRV?=
 =?utf-8?B?cHlrQzVGZ0l2S05wOTZMVmM5bURzTTBoNDdGbzRRcWNQRVgrWHF0Qnd1cDNp?=
 =?utf-8?B?elpQbUNVRTlBYld2OW9XSVRQeGpXVTRaUFNmYWVDOWMrMkQvWldKZzZLcyto?=
 =?utf-8?B?K3JMM1FsRHRlWWp5d3g2UTMyMzVYZS9DcTgvL3dweXZTY1BnVkx3S25CTlBa?=
 =?utf-8?B?UmdWdWNOdE1kUHk5NGkyaE8vOXhkdUNzdXI2UUtTRXFQTTd2bTVWUmVXbGVG?=
 =?utf-8?B?MnMwS0YzbFZtK1IzK1Y4ZEQ4MkpraE9oV1BWN1RDYmRIcVBQeXJKMXI5RzQ3?=
 =?utf-8?B?ZzhzN3U2czlZeXk0L21GRXRLdFpkWkN3M1ZPc2hIUEFOOE5vK2NvNVl1QjlI?=
 =?utf-8?B?VjhKRENWK2tGSHh0L0x1dUxvRVphdnF0bzd2S0dLTmJ4ZEdQUmVMOWxhaWlp?=
 =?utf-8?B?QzlnZmlydVZEem16Z0RxUGZsQVVHMkJuWUp6QVJOZXI5R2FTSTkxYWFGT2h5?=
 =?utf-8?B?MkZzZElVekQ1QU11YmVMSkVmaGsvMkdqUzFJUXpJRFFDQ2hPWm1vL2lWajJm?=
 =?utf-8?B?Mnl3UXg3KzFyeUQ1a2xLdGkxZG14YnEzMkttVjJtUUNkZTUvY09RRWEyZENW?=
 =?utf-8?Q?VIfGW+/wx7yYzUNaTG5upXVKaK27ibCFVTVimlV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dddd6b-adcf-4df5-c36e-08d937f9b62a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 16:53:09.1389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YR63iZIA9KSpcGNEzcY1PdWJbawJhEvavjNpI8D7lGWc4skuBlIG/WXYpI9RjC2a9Km+Xzn82scneMtmaM921Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5638
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQo+IEZyb206IMOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIDxhdmFyYWJAZ21haWwuY29tPg0K
PiBTZW50OiAyNSBKdW5lIDIwMjEgMTE6NTkNCg0KPiA+PiBTbyBJIHRoaW5rIGl0IFBoaWxpcCdz
IHN1Z2dlc3Rpb24gbWFrZXMgc2Vuc2UuIFdlJ3JlIG5vdCB0YWxraW5nDQo+ID4+IGFib3V0IGhv
dyB0byBmYXN0LWZvcndhcmQgYSB0YXBlLCBidXQgd2hhdCBoYXBwZW5zIGluIGdpdCB3aGVuIHdl
IHVzZQ0KPiA+PiB0aGF0IHRlcm0uDQo+ID4NCj4gPiBOby4gSW4gdGhpcyBwYXJ0aWN1bGFyIHNl
bnRlbmNlIHdlIGFyZSB1c2luZyBmYXN0LWZvcndhcmQgKnByZWNpc2VseSoNCj4gPiBpbiB0aGUg
c2FtZSB3YXkgYXMgYSB0YXBlLiBXZSBoYXZlbid0IGV2ZW4gdGFsa2VkIGFib3V0IHdoYXQNCj4g
PiBjb25zdGl0dXRlcyBhICJmYXN0LWZvcndhcmQiIGluIGdpdCBqYXJnb24uDQo+ID4NCj4gPiBT
dWJzdGl0dXRlIHRoZSB3b3JkICJmYXN0LWZvcndhcmQiLCBhbmQgdGhlIG1lYW5pbmcgcmVtYWlu
cyBpbnRhY3Q6DQo+ID4NCj4gPiAgIEFmdGVyIHRoZSByZW1vdGUgY2hhbmdlcyBoYXZlIGJlZW4g
c3luY2hyb25pemVkLCB0aGUgbG9jYWwgYG1hc3RlcmANCj4gPiAgIHdpbGwgYmUgYWR2YW5jZWQg
dG8gdGhlIHNhbWUgY29tbWl0IGFzIHRoZSByZW1vdGUgb25lLCB0aGVyZWZvcmUNCj4gPiAgIGNy
ZWF0aW5nIGEgbGluZWFyIGhpc3RvcnkuDQo+ID4NCj4gPiBBcyBJIGFscmVhZHkgZXhwbGFpbmVk
Lg0KPiANCj4gSSB0aGluayBldmVuIGlmIHlvdSBjYW4gYWNjdXJhdGVseSBzdWJzdGl0dXRlIHRo
ZSBqYXJnb24gaXQncyB3b3J0aCBxdW90aW5nIHRoZQ0KPiBqYXJnb24sIHRvIGNhbGwgb3V0IHRo
YXQgaXQncyBqYXJnb24gd2UncmUgdXNpbmcgcXVvdGVkIHRoYXQgcGxhY2UgYW5kIG90aGVycy4N
Cj4gDQo+IEFueXdheSwgdGhhdCBkb2Vzbid0IGhhdmUgbXVjaCB0byBkbyB3aXRoIHlvdXIgaXNv
bGF0ZWQgY2hhbmdlLCBqdXN0IGENCj4gZ2VuZXJhbCBjb21tZW50IG9uIHF1b3Rpbmcgdi5zLiBu
b3QgcXVvdGluZyBpbnZlbnRlZCB2LnMuIGJvcnJvd2VkL3JldXNlZA0KPiB3b3Jkcy4NCj4gDQo+
ID4+IEFzIGFuIGFzaWRlIGFmdGVyIGhvd2V2ZXIgbWFueSB5ZWFycyBvZiB1c2luZyBnaXQgdGhp
cyBpcyB0aGUgZmlyc3QNCj4gPj4gdGltZSBJIG1hZGUgdGhlIGNvbm5lY3Rpb24gdG8gdGhhdCB1
c2FnZSBvZiB0aGUgdGVybSwgSSB0aG91Z2h0IGl0DQo+ID4+IHdhcyBqYXJnb24gZ2l0IGludmVu
dGVkLiBUaGF0J3MgYWxzbyBzb21ldGhpbmcgdG8gY29uc2lkZXIsDQo+ID4NCj4gPiBJIHdhcyBp
biB5b3VyIGNhbXAsIGJ1dCBhZnRlciB0aGlua2luZyBkZWVwbHkgYWJvdXQgd2hhdCB3b3VsZCBi
ZSBhDQo+ID4gYmV0dGVyIHRlcm0gdGhhbiAiZmFzdC1mb3J3YXJkIiAoYWR2YW5jZSwgZm9yd2Fy
ZCwgYm9vc3QpLCBJIHJlYWxpemVkDQo+ID4gdGhhdCBpbiBmYWN0ICJmYXN0LWZvcndhcmQiIGlz
IHBlcmZlY3RseSBmaW5lIGJlY2F1c2UgaXQgYWxyZWFkeQ0KPiA+IGV4aXN0cyBpbiBFbmdsaXNo
IGFuZCBjb252ZXlzIHByZWNpc2VseSB0aGUgbWVhbmluZyB3ZSB3YW50OiBxdWlja2x5DQo+ID4g
YWR2YW5jZSB0byBhIGRlc2lyZWQgcG9zaXRpb24uDQo+IA0KPiBJIHRoaW5rIHdoYXRldmVyIHRl
cm0gd2UncmUgaW50cm9kdWNpbmcgd2lsbCBuZWVkIGdpdC1zcGVjaWZpYyBleHBsYW5hdGlvbi4N
Cj4gRS5nLiBiZWNhdXNlIGEgInRyZWUiIGlzIGFuIGV2ZXJ5ZGF5IG9iamVjdCBvdXIgdXNlIG9m
IGl0IG5lZWRzIGV4cGxhaW5pbmcuDQo+IA0KPiA+PiBJJ3ZlIGFsc28gYWN0dWFsbHkgc2VlbiBh
biBpbnRlcmFjdGVkIHdpdGggYSB0YXBlIHJlY29yZCBhbmQgVkhTIHRhcGUNCj4gPj4gaW4gbXkg
bGlmZXRpbWUsIGJ1dCBJIHN1c3BlY3QgbWFueSByZWFkZXJzIG9mIHRoaXMgZG9jdW1lbnRhdGlv
biBoYXZlDQo+IG5vdC4NCj4gPg0KPiA+IEJ1dCB0aGV5IGhhdmUgcHJlc3NlZCBmYXN0LWZvcndh
cmQgb24gdGhlaXIgUm9rdSBjb250cm9sLCBvciB3aGF0ZXZlci4NCj4gPg0KPiA+IE5vdCBvbmx5
IGlzIGl0IHBhcnQgb2YgbW9kZXJuIHRlY2hub2xvZ3ksIGJ1dCBpdCdzIGV2ZW4gdXNlZCBpbnNp
ZGUNCj4gPiBmaWxtcywgVFYgc2hvd3MsIGFuZCB2aWRlbyBnYW1lcy4gU2VlIFRWIFRyb3BlcyBm
b3IgZG96ZW5zIG9mIGV4YW1wbGVzDQo+ID4gd2hlcmUgaW5zaWRlIHRoZSBmaWxtIHRoZXkgZmFz
dC1mb3J3YXJkIFsxXS4NCj4gDQo+IFVuZm9ydHVuYXRlbHkgSSBoYXZlbid0IGJlZW4gYWJsZSB0
byBub24tZmFzdC1mb3J3YXJkIHNheSB0aGUgR2FtZSBvZg0KPiBUaHJvbmVzIFRWIHNob3cgaW4g
c3VjaCBhIHdheSB0aGF0IHRoZSBsYXRlc3Qgc2Vhc29ucyBtYWtlcyBhbnkgc2Vuc2UsDQo+IHNp
bmNlIG5vIGFtb3VudCBvZiBidXR0b24gbWFzaGluZyB3aWxsIG1lcmdlIHRoZWlyIHZlcnNpb24g
d2l0aCBtaW5lIDopDQo+IA0KPiBTbyBJIHRoaW5rIGluIHRoZSBjb250ZXh0IG9mIHVzIHVzaW5n
IHRoaXMgamFyZ29uIHRvIGRlc2NyaWJlIGdpdC1zcGVjaWZpYw0KPiBjb25jZXB0cyB0aGUgY29u
bmVjdGlvbiB0byByZWFsaXR5IGlzIHRlbnVvdXMgYXQgYmVzdA0KIA0KDQo+ID4gVGhpcyBpcyBv
bmUgb2YgdGhvc2UgcmFyZSBvY2Nhc2lvbnMgd2hlcmUgSSB0aGluayB0aGUgZ2l0IHByb2plY3QN
Cj4gPiBjaG9zZSB0aGUgcGVyZmVjdCB3b3JkLg0KDQpJIGFncmVlLg0KDQo+IFBlcmhhcHMsIGl0
J3Mgbm90IGxpa2UgSSd2ZSBnb3QgbXVjaCBpbiB0aGUgd2F5IG9mIGEgaG9saXN0aWMgd29ybGQg
dmlldyB3aXRoDQo+IHdoaWNoIHRvIHJlcGxhY2UgaXQuDQo+IA0KPiBJIGRvIHRoaW5rICJwZXJm
ZWN0IiB3b3VsZCBkbyBhIGZldyB0aGluZ3MgaXQgZG9lc24ndCB0aG91Z2gsIGltYWdpbmUgcmVh
ZGluZw0KPiBhYm91dCBpdCBmb3IgdGhlIGZpcnN0IHRpbWUgYW5kIG5vdCBtYWtpbmcgdGhlIGNv
bm5lY3Rpb24gdG8gdGFwZXMuIElzIGl0IGFuDQo+IG9wdGltaXphdGlvbj8gSXMgdGhlcmUgYSBz
bG93LWZvcndhcmQ/IFdoYXQgaWYgdXBzdHJlYW0gcmV3b3VuZCB0aGVyZQ0KPiBicmFuY2ggYW5k
IEkgbWVyZ2UsIGlzIHRoYXQgYSBtZXJnZS1iYWNrd2FyZHM/DQo+IA0KPiBJdCdzIG5vdCBpbW1l
ZGlhdGVseSBvYnZpb3VzIGhvdyByZWJhc2UvbWVyZ2UvZmFzdC1mb3J3YXJkIHJlbGF0ZSBvcg0K
PiBpZi93aGVuIChlLmcuIG1lcmdlIHNvbWV0aW1lcyBiZWluZyBhIG1lcmdlLWZmKSB0aGV5J3Jl
IGluY29tcGF0aWJsZQ0KPiBjb25jZXB0cy4NCg0KT24gdGhlIG9uZSBoYW5kLCBJIHRoaW5rIGZh
c3QtZm9yd2FyZCBpcyBhbiBlbnRpcmVseSBzdWl0YWJsZSB0ZXJtIGZvciBnaXQgdG8gdXNlLCBi
YXNlZCBvbiB3aGF0IGl0IGRvZXMuICBJbnN0YW50YW5lb3VzbHkgbW92aW5nIHRoZSBicmFuY2gg
aGVhZCBwb2ludGVyIGZvcndhcmQgdG8gdGhlIG5ldyBoZWFkDQpPbiB0aGUgb3RoZXIgaGFuZCBJ
IHRoaW5rIGl0IGlzIGRpc3RpbmN0bHkgZGlmZmVyZW50IGZyb20gdGhlIHVzZSB3aXRoIHRyYW5z
cG9ydCBjb250cm9scyBmb3IgbGluZWFyIG1lZGlhIChpZSB0YXBlIC0gdmlkZW8gb3IgYXVkaW8p
Lg0KRm9yIGFsbCBvZiB0aGVtIGZhc3QtZm9yd2FyZCBtb3ZlcyB0aGUgcGxheS9yZWNvcmQgcG9p
bnQgcmVsYXRpdmUgdG8gdGhlIG1lZGlhLCBtYXliZSB0byB0aGUgZW5kIChvciB0byAibm93Iiks
IG1heWJlIG5vdC4gIFRoZXJlIG1heSBvciBtYXkgbm90IGJlIGEgY3VlaW5nIHBsYXkgdGhhdCBo
YXBwZW5zIHdoaWxlIHRoZSB0YXBlIGlzIG1vdmluZy4NCkZvciBhIG1vZGVybiBzdHJlYW0gKGVn
IHBvZGNhc3QpIHBsYXllciwgc3VjaCBhcyBCQkMgU291bmRzICh2aWEgaXRzIHdlYi1zaXRlKSB0
aGVyZSBpcyBubyBmYXN0LWZvcndhcmQgY29udHJvbC4gIFRoZXJlIGlzIHBsYXkvcGF1c2UsICsy
MCBhbmQgLTIwIHNlY29uZHMsIGdvIHRvIHRoZSBzdGFydCBvZiB0aGUgc3RyZWFtIGFuZCAoZm9y
IGxpdmUgYnJvYWRjYXN0cykgZ28gdG8gbm93LiAgVGhlIGxhdHRlciBpcyB2ZXJ5IGNsb3NlIHRv
IEdpdCdzIGZhc3QtZm9yd2FyZCwgYnV0IGlzIG5vdCBsYWJlbGxlZCBhcyBzdWNoLiAgVGhlcmUg
aXMgYWxzbyBhIHRpbWUtbGluZSwgd2hlcmUgdGhlIHVzZXIgY2FuIGdvIHRvIGFuIGFyYml0cmFy
eSBwb2ludCBpbiB0aW1lIGFuZCBwbGF5IGZyb20gdGhlcmUuDQpIYXJkd2FyZSBwbGF5ZXJzIGRv
IGhhdmUgZmFzdC1mb3J3YXJkIGNvbnRyb2xzLCBldmVuIGZvciBzdHJlYW1zLCBvciBmaWxlcy4N
Cg0KU28sIHllcywgdGhlIHRlcm0gaXMgdmVyeSB3aWRlbHkga25vd24gaW4gdGhlIHdpZGVyIHdv
cmxkIChldmVuIGZvciB0aG9zZSB3aG8gZGlkbid0IGdyb3cgdXAgd2l0aCB0YXBlKS4NCkFuZCB5
ZXMsIGlycmVzcGVjdGl2ZSBvZiB0aGUgYWJvdmUsIGl0IG1ha2VzIGNvbXBsZXRlIHNlbnNlIGZv
ciBnaXQncyB1c2FnZS4NCg0KUmVnYXJkcywNClJpY2hhcmQuDQoNCg==
