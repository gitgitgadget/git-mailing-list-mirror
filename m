Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FECC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 11:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3227660FEA
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 11:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhFHLeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 07:34:15 -0400
Received: from smtppost.atos.net ([193.56.114.177]:26746 "EHLO
        smarthost2.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231630AbhFHLeP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 07:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1623151943; x=1654687943;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f3Ujf8E2hYlBpFXhIFGhsm4hgnPSBap4bHXrPqfRWxg=;
  b=Le0V/jogKfKlvN7zVOpcSltkmjkDoCIzf4TW3OTpGMUy+AGcCsY6H6oI
   BFKvmjU58e12rHcPBMYJ1REE52zjtCWC9FPXBXXQmBAgQ5eteFKpwOxdj
   AiA6tWqGMvDjWPESmC1B3864Ig/1Yp0mESeZjzxdOoun3B6dyq77QNrX7
   o=;
X-IronPort-AV: E=Sophos;i="5.83,257,1616454000"; 
   d="scan'208";a="215999927"
X-MGA-submission: =?us-ascii?q?MDGDfZIgsM4mzlNsmNFpsPLzwyXtzTK/mGU5WH?=
 =?us-ascii?q?iikpzkmaASaK7ciskmAbTGnW75H9KPgZKX0r4xLozC/Pk3vzmOBEerX7?=
 =?us-ascii?q?WJg8fW2TFlcASuLZ9A25ZQ+PCDwhtTllYbzZolRbwLi22/SrRuXoATZC?=
 =?us-ascii?q?3S?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB14.ww931.my-it-solutions.net) ([10.89.28.144])
  by smarthost2.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 08 Jun 2021 13:32:21 +0200
Received: from GITEXCPRDMB13.ww931.my-it-solutions.net (10.89.28.143) by
 GITEXCPRDMB14.ww931.my-it-solutions.net (10.89.28.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 8 Jun 2021 13:32:20 +0200
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (172.16.214.171)
 by GITEXCPRDMB13.ww931.my-it-solutions.net (10.89.28.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 8 Jun 2021 13:32:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6i7Wayrn4RPstod7u7gYIjTdMiStG6ZDO8alha4B5xgZflXGPNO3MbDZf4LwPDE45VI5kHAjjms1H2j16u77gIr2hsH1jsgmqwUIIlMJmVX54/JzabT4OUI7bnlP0yLhLAw+vN5j8UR3yo5ZjKj8zCW5q3hVt4imbI4msgCe1GxElhPBXZ+f8w3H3xtltcuKtIeZDSk7Z9hGMZMX5Dsd8QeTvz3YIKB7J4gDLVi2mC+a3gBtzC+q2MX19d78Bk5sPiMrtzSoeamEctCk5GCTQOB4GVEgc0djiatyGKJMGRzcl13uFK+7HHwCTfuHO2yATmCgHZUh80tl1SpsVCjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3Ujf8E2hYlBpFXhIFGhsm4hgnPSBap4bHXrPqfRWxg=;
 b=GJZQENDVogG/cECwx4JxU9Igv2OACjlCUMbdjzpzihcnz91IzV/Ie4gerr6oboNMbT1oMZboim967wUa7zJczQV6W64sg8Fi4eyHXVh2fdt5H3weZrwu+0oaUiLHxaPv/3j6TxS3mQ2T9Q6z8B6VZdFTIa5CNl4UIpfJQUoVCOxgknbGBzNPTemXZCv6CCKxn2uki5sN0GSpTPxlhsUu/HLH7Tsy+1DUNSU49bSxq5ZNwUme/swYByg6WpZIocPULgb3PIBJFChw0bhWWM6oGIG1BXeyVrcGI42/DORrpzVz1pl+GPLmaBYpBMKBIk8ObpK3XDjVZ7po+jtUEo6vUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by AM6PR02MB5206.eurprd02.prod.outlook.com (2603:10a6:20b:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 11:32:19 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::ed80:b8f7:efc7:e147]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::ed80:b8f7:efc7:e147%6]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 11:32:19 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>
CC:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: RE: [PATCH] branch: make -v useful
Thread-Topic: [PATCH] branch: make -v useful
Thread-Index: AQHXWag/WYe07QB2/0W9Ak5Qtje+gasF3IIAgAAmXoCAArWBAIAA7xwAgAAR8YCAAB1uAIAABZAAgAAhDMA=
Date:   Tue, 8 Jun 2021 11:32:18 +0000
Message-ID: <AS8PR02MB7302955796AAEF8B9063505E9C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
 <YLv8NWL7WfBRkiGe@coredump.intra.peff.net>
 <60be41f6473e2_39c0a208f6@natae.notmuch>
 <YL8KiiGXF8LdGmQ2@coredump.intra.peff.net>
 <60bf1997b1a72_1a2ac520865@natae.notmuch>
 <AS8PR02MB7302DF058D13CAE11A1086FD9C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <60bf36f24d2e2_1a848720836@natae.notmuch>
In-Reply-To: <60bf36f24d2e2_1a848720836@natae.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-06-08T11:32:17Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=4d20efe6-be43-44a3-b3c8-22fcf5324869;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=atos.net;
x-originating-ip: [165.225.199.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3182980c-535e-47bd-5a43-08d92a711324
x-ms-traffictypediagnostic: AM6PR02MB5206:
x-microsoft-antispam-prvs: <AM6PR02MB5206AD6F4CA82D55EFBE6EDE9C379@AM6PR02MB5206.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/xBlBpt+2kEN8UqD7OC9vQY6ND7BUucOEtgTpMvPaz3gQyvGK2WHpi2SqEDHT9UVI4pDBH961BGT8q3RxRxViDp8gLHO/S/OKC4LUvBBid/qFYKxMgazjgCP5hr2oeC1j9A28P+yJj1C95ShKxFu8ViWdL/FMH8AzJdrSXh7NXv8fBvVfJmoylFPMb6ZZx0TY2rcKPvemt0Z8DTse3QSm0rnqn+zBj6PDJOU1ssA665vDBncGP/f8OBiqjPUHdDW0uQplMkRflNcrm7PJsL1mH1ylkzevwT/HSkfKTFySiejEi4puD41bXMn2D9RsRm293DaEG/e6MM9S+TF+gbUYpn9FALC+SnS5BWmF2N3e9yX+GUQLKcBlLm1rNmKy+XIt34my0tL/UxPgb7Sl91rU7eT2fWE+QpDhK+mnqXErmgiFk0DrA9vWH00Np2xAXUZY5Dr2Pt2DSg1DB4JxlU+7kMenNUBgeXmHg+CrR/k2WWIy/cPoke+/TVlZuvbtuau70aTntQaicqOAO4NYwbmle+KuSrRKw4hueWiHls+0GbuzKR02Rv1ADSf9qVm0dGh96dqNrEp9JmAhzSjhwzxK7VbgACLd80++OqYD+l4mc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(55016002)(4326008)(54906003)(122000001)(66574015)(8936002)(9686003)(76116006)(38100700002)(33656002)(66556008)(66476007)(64756008)(71200400001)(66446008)(66946007)(186003)(8676002)(53546011)(7696005)(26005)(5660300002)(478600001)(2906002)(6506007)(55236004)(83380400001)(52536014)(86362001)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3VBbFM3YVdqUW5lWGlFT0lyV0Y2SU5rc2JkaThqRDk3aDkyYXBMdFU4V1Na?=
 =?utf-8?B?ZFRBWnBhN3ZINFROTExsWnAvQThYSTdSeUtnMCtrMlgxV1pjSVVaNWszcTl1?=
 =?utf-8?B?c2lwbkcvaWJPcCtjV1VNM1ArY21pNU10a2ZqZkl6b0N0SjZzUTlDUmx6Y2c1?=
 =?utf-8?B?eVZOZXoxTGp0cU4yWS80MDcwK2FXWFpGU041RmpVYXNjazFESjBlUEplQWlw?=
 =?utf-8?B?T1M2OEtqdWxLb0lsZ1NGMFZCRVFkWkgyYmptSUpEczcwTVF4ZjlVbnJ6Njcx?=
 =?utf-8?B?c1d3L2JxSnNmUytwQ0pLS1hpbTYxcUlRNjF0REdqZjd0TGlzbVlDakJJU3Bu?=
 =?utf-8?B?TjZabFNySXBkWUJnSDExVUUybU82bXlCYk5SZEhGZmVwcktXZnRNVHpXcTJZ?=
 =?utf-8?B?clFNQnQxMkRtWXl6bjBnK0RqMVNzK0krOHZNemdsQWlPcEpaSXFjOU9wRUc2?=
 =?utf-8?B?SWwvL0Q1RW5kRVp0Ulp2SCtzSHB0dnFEVDB6RXNSejVXMEFibnRPbTYxQ2Ju?=
 =?utf-8?B?KzJyMy9IRnZSSDAxSFMzS256NmRhWFB6bzk2bStSN1ljb05Bb2VoZHV1Mndo?=
 =?utf-8?B?V2w5TDBDdHVqeFJGb0hXREVWZnQxWjJOci9DS0U0eUgyV2ZKTmNZQkswMkFH?=
 =?utf-8?B?LzNRUVpEK253ZlJBVmhDOUNQUk1GdHYraEl1RGk5cWk5RWlVUE14UndaUk94?=
 =?utf-8?B?S21IYnN4TE0xd2xwbUUyV3hScnhQV3Z6cSt2VytaWEp5KzIvWVVWUlBwc3Qx?=
 =?utf-8?B?MjNid3BZQzhQQVNyai9iNHQ1QytjREZOcTdOVEtIeis4Nmlnb0FCRGdFQW05?=
 =?utf-8?B?MEp6SHRweUpTSmVUVnduODJ3c1RaS1V0WnBoVkI5ZnpYTVRMQ2Z4YzhkbkhI?=
 =?utf-8?B?VTREeEN0OW9SdjZ3VVlHeGZTYkdVOFFVbFdmSjFqaGNmcjFJWFVSbk9Ob3VU?=
 =?utf-8?B?TTQvemwwRE4rU1F3d21Ha2tXZExINWxjRkRMNDVlQ2FMdlZGbm9CVVlsK1hy?=
 =?utf-8?B?YloyeElwM1JwSDhxK21CUUpMUTV4VDdJU2lSaXNwQjRqZzZXcGVXL0kzQ0Zx?=
 =?utf-8?B?S2ZGVk5WNHZvVk9HaHYyYnVMb2VUdGZPTVVUTTUyVWxPZHBqMEhvZkxvYUxY?=
 =?utf-8?B?d0pWS1dMWW1Hb2l1ZWVTcm5ZR05kM01xTHhrUkMvTHc4LzZkYnFTeXMyQVNM?=
 =?utf-8?B?S3lVVXRuaTJNY0dOeDhGOHRMc2dxckFDaHhOSzFnM2ZIbTlPVm13VCs1Rk5v?=
 =?utf-8?B?MDhGS0FtVUF0eHBhOUczeFZpYXZTM2VaelhBejFTV1h1R0RHNEppZlFScFJU?=
 =?utf-8?B?dkNhTFAxc2s2bXJNY2pZZ1I2WTdGaVBQeU1LUFdOWHM3Z2pTTnN0Nkp3Y2Uw?=
 =?utf-8?B?ZlZNcnkwZnYxYjR3Y2dSNlJUdWxYSUtpVUlpeUNOc01YZmZCdUg5VytYeG1B?=
 =?utf-8?B?SVV1Z0ZKYU1ZQ2REcFdjTGgyV1V0RzhsQzlzSGdaMWJKa3VwMjJET0dyUzUr?=
 =?utf-8?B?RnNkZkNjL01yZGM4c2FuS1JuU1JnOHJtalBTZ0ZFT0I3czd2OGZyZnBmSm5Y?=
 =?utf-8?B?SWhxN3VlM1RrU2paaFRneG1hL2xkNGxMeTJ4VGRmdU5wVGhKZWEzUHdTSng0?=
 =?utf-8?B?KzBQUzluakNxSWIxclRUV3htSG56ditML2RkSzJDUXl0Rmg1Ry94OHZJaWxi?=
 =?utf-8?B?ZEFxZTlnT2ZCVjM3U3ZzVXBtSTkzWkppNUo1ckxwcndOOFlIempYVkc5dkpz?=
 =?utf-8?Q?rWyDXkDaqJ13UqCe36ik/RdYyiGrkqOcTnLI967?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3182980c-535e-47bd-5a43-08d92a711324
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 11:32:19.0028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCjuRVdusV7S0fxdwxi7eeY5wOsrxgYxoe1GEXmugzTb801aPIB18dB2uUm7oJfe7ESUjH04Kf1T7ON+E3IFYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5206
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBGZWxpcGUgQ29udHJlcmFzIDxm
ZWxpcGUuY29udHJlcmFzQGdtYWlsLmNvbT4gDQpTZW50OiAwOCBKdW5lIDIwMjEgMTA6MjMNClRv
OiBLZXJyeSwgUmljaGFyZCA8cmljaGFyZC5rZXJyeUBhdG9zLm5ldD47IEZlbGlwZSBDb250cmVy
YXMgPGZlbGlwZS5jb250cmVyYXNAZ21haWwuY29tPjsgSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0
Pg0KQ2M6IMOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIDxhdmFyYWJAZ21haWwuY29tPjsgZ2l0
QHZnZXIua2VybmVsLm9yZzsgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPg0KU3Vi
amVjdDogUkU6IFtQQVRDSF0gYnJhbmNoOiBtYWtlIC12IHVzZWZ1bA0KDQpDYXV0aW9uISBFeHRl
cm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVz
cyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUuDQoNCktlcnJ5LCBSaWNoYXJkIHdyb3RlOg0KPiANCj4gID4gR2l0IGlz
IGEgZGlzdHJpYnV0ZWQgVkNTLCBtb3N0IHBlb3BsZSBkb24ndCBoYXZlIGNvbW1pdCBhY2Nlc3Mg
dG8gIA0KPiA+IHRoZSBvcmlnaW5hbCByZXBvc2l0b3J5LCB0aGVyZWZvcmUgdGhleSBwdXNoIHRv
IHRoZWlyIHBlcnNvbmFsICA+IA0KPiByZXBvc2l0b3J5IChlLmcuIGdpdGh1YiBmb3JrKS4NCj4g
DQo+IFtSS10gV2hlbiB5b3Ugc2F5ICJtb3N0IHBlb3BsZSIsIGRvIHlvdSBtZWFuICJtb3N0IHBl
b3BsZSB3aG8gYXJlIA0KPiB3b3JraW5nIG9uIG9wZW4gc291cmNlIHByb2plY3RzIj8NCg0KQm90
aC4NCg0KVHdvLXdheSB3b3JrZmxvd3MgYXJlIHByZXNlbnQgYm90aCBpbiBvcGVuIHNvdXJjZSBw
cm9qZWN0cyBhbmQgcHJpdmF0ZSBwcm9qZWN0cy4NCg0KVHJpYW5ndWxhciB3b3JrZmxvd3MgYXJl
IHByZXNlbnQgYm90aCBpbiBvcGVuIHNvdXJjZSBwcm9qZWN0cyBhbmQgcHJpdmF0ZSBwcm9qZWN0
Lg0KDQo+IFtSS10gSSdtIHdvcmtpbmcgdXNpbmcgR2l0IGV2ZXJ5IGRheSwgYW5kIEkgcHVsbCBm
cm9tIHRoZSBvcmlnaW5hbCANCj4gcmVwb3NpdG9yeSBhbmQgcHVzaCBiYWNrIHRvIGl0LiBJIGFt
IHdvcmtpbmcgb24gY2xvc2VkIHNvdXJjZSBjb21wYW55IA0KPiBwcm9qZWN0cy4NCg0KVGhlIHRy
aWFuZ3VsYXJpdHkgSSdtIHJlZmVycmluZyB0byBpcyBub3QgcGVyIHJlcG9zaXRvcnksIGl0J3Mg
cGVyIGJyYW5jaC4NCg0KRG8geW91IGFsd2F5cyBwdXNoIHRvIHRoZSBzYW1lIHJlbW90ZSBicmFu
Y2ggeW91IHB1bGwgZnJvbT8NCltSS10gWWVzLiAgVGhlcmUgYXJlIHR3byBwZW9wbGUgZG9pbmcg
bW9zdCBvZiB0aGUgd29yayAsIG1lIGFuZCBvbmUgb3RoZXIuICBXZSBlYWNoIG1vc3RseToNCltS
S10gIDEuICBBcmUgbm90IHdvcmtpbmcgb24gdGhlIHNhbWUgdGhpbmdzLiAgSWUgd2UgZG9uJ3Qg
Z2VuZXJhdGUgbWFueSBjb25mbGljdHMNCltSS10gIDIuICBQdWxsIGFuZCBwdXNoIHRvIHRoZSBz
YW1lIGJyYW5jaC4gIEllIGVhY2ggb2YgdXMgaGFzIGEgYnJhbmNoIHRoYXQgd2Ugd29yayBvbi4g
IEhlIHVzZXMgIm1hc3RlciIsIEkgaGF2ZSBteSBvd24gKEl0IGlzIGEgc2luZ2xlIHZlcnkgbG9u
Zy1saXZlZCBicmFuY2ggLSBJIGtub3cgdGhhdCBpc24ndCBhIHJlY29tbWVuZGVkIHdvcmtmbG93
IGJ1dCB0aGF0J3Mgd2hlcmUgd2UgYXJlIGZvciB0aGUgbW9tZW50KQ0KDQpIb3cgYWJvdXQgcmVi
YXNpbmcgb3IgbWVyZ2luZz8gRG8geW91IHVzZSB0aGUgc2FtZSByZW1vdGUgYnJhbmNoPw0KW1JL
XSBNZXJnZXMgYXJlIGluZnJlcXVlbnQsIGJ1dCBiZWNhdXNlIHdlIGFyZSB3b3JraW5nIGluIGRp
ZmZlcmVudCBhcmVhcywgd2UgbWVyZ2UgdG8gIm91ciBvd24iIGJyYW5jaCAoZmV3IGNvbmZsaWN0
cywgdXN1YWxseSkgYW5kIHB1c2ggdG8gaXRzIHJlbW90ZS4NCltSS10gSSBoYXZlIG5ldmVyIHll
dCBkb25lIGEgcmViYXNlLCBidXQgbmVlZCB0byBkbyBzbyBzb29uIGFzIHRoZXJlIGlzIHdvcmsg
aW4gYW4gYXJlYSB0aGF0IHdlIGhhdmUgYm90aCB3b3JrZWQgb24uICBUaGVuIGl0IHdpbGwgYmUg
cHVzaGVkIHRvIHRoZSB1c3VhbCBwbGFjZSAtIGllIHRoZSB0d28gYnJhbmNoZXMgbWVudGlvbmVk
IGFib3ZlLg0KDQpbUktdIFNvIGJhc2ljYWxseSwgbm8sIG5vdCB0cmlhbmd1bGFyIGF0IGFsbCwg
aWYgSSB1bmRlcnN0YW5kIHRoZSBtZWFuaW5nIG9mIHRyaWFuZ3VsYXIgKHB1bGwgYW5kIHB1c2gg
dG8gZGlmZmVyZW50IHJlbW90ZXMpLg0KDQpDaGVlcnMuDQoNCi0tDQpGZWxpcGUgQ29udHJlcmFz
DQo=
