Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03720C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 10:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACFD06023C
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 10:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhBXKMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 05:12:35 -0500
Received: from smtppost.atos.net ([193.56.114.176]:25964 "EHLO
        smarthost3.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234861AbhBXKMH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 05:12:07 -0500
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Feb 2021 05:12:05 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1614161526; x=1645697526;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=fRRB73u01bqs17KUukHwkE+TOM//xlt5dHESWTngTM0=;
  b=bORct9pdol8bR8hj6rM97GyO/5n0skAC/5BzlztNFABGqKuF3A7uKghN
   s+awX62D1jn/15FNO5cN6pgpPcFT1yFnub8qvqQIXnASxvt+RcO1JIV0Z
   KVt/4duwGbtHxXzNrr3UnO1myp8bZYnMY7ptqRK/74e/58o3h2d6MLnIt
   M=;
X-IronPort-AV: E=Sophos;i="5.81,202,1610406000"; 
   d="scan'208";a="165303973"
X-MGA-submission: =?us-ascii?q?MDFi4a5bsn2NYxIfkqc/2toBQ10CGH/p+IZRzE?=
 =?us-ascii?q?W9xqDH/cre50NwzVTwEbD1bfI2mELsbJbcOsxzS6nbMYfb2Bib0Teq+j?=
 =?us-ascii?q?dNJwS1JWaOQ9/ntIqNW7F4scYNsLWu4UJSV5zgJctveAqWGMfpHcf0L0?=
 =?us-ascii?q?Fa?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB13.ww931.my-it-solutions.net) ([10.89.28.143])
  by smarthost3.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2021 11:05:16 +0100
Received: from GITEXCPRDMB14.ww931.my-it-solutions.net (10.89.28.144) by
 GITEXCPRDMB13.ww931.my-it-solutions.net (10.89.28.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Feb 2021 11:05:16 +0100
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (172.16.214.172)
 by GITEXCPRDMB14.ww931.my-it-solutions.net (10.89.28.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2 via Frontend Transport; Wed, 24 Feb 2021 11:05:16 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lppLH2r42d8PoJa+FyZBYopgWpG0mwAFTrhBiqyZ0s0g8/XfFUe7rtGbRF2h6cdnkwP+B7+KNpqBbpw4QO24oIoVrCwNfC6Hix67mfwL7btvqbEewPmSB37OihzZBoOFg4rgPLjsHm5E8CvcUP4c6EgMda6qSTgLninf1VZ/6eumMF1sMXDyH620yI3gjSdVbtrhsJpeaPBdqOXsPMeTvqtBmDpKNwSjSfgk9nzrUz1w8ReJfchNMRiHIV5T2zI334GMjqNReZtYJy6XQX1OKZOVpa4qE4dKEHrP7e1f6/djzMrUHxjIH4mkxzDD9wtVf1b8/6U0WKWZer7JUB3VJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRRB73u01bqs17KUukHwkE+TOM//xlt5dHESWTngTM0=;
 b=ljR9dQANGfTxZ5S9PbiC9TXZCoWEyh7k4Z2sF86l/47nAanguHoIcWn/bGBebDx7avbSdtoNuUwCeLfnmbjGOuJuTIMpTzKgESXZ0zMRGIoJIBvMRvlFQXCzpGXhmJh942qh9y5NiFPoSsQdgZZsQtPhEoEypt61Ifnc9uQhmxzycNOq88Jp5bx03rBLhFDZvaIxZr6sokvdjhWMr7A9okfgjpAO+/OLCUFQ/pWoFcYt0Oz8pn5m1832PZTYg88Ed9yhcJbdNhxWtQo09rubz3v66Py+lo+jKChxyzQqE1ZvcHIQpMpg+ZxWH57FY2N14SbQs+9DjG35/CSPtNoMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com (2603:10a6:208:df::14)
 by AM0PR02MB4084.eurprd02.prod.outlook.com (2603:10a6:208:d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 10:05:12 +0000
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::3133:520c:60b:b18]) by AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::3133:520c:60b:b18%6]) with mapi id 15.20.3868.029; Wed, 24 Feb 2021
 10:05:12 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Ort-merge: What does "ort" mean?
Thread-Topic: Ort-merge: What does "ort" mean?
Thread-Index: Adbz+b9oxFMKzk2wSyekhffCwvCD2Q==
Date:   Wed, 24 Feb 2021 10:05:12 +0000
Message-ID: <AM0PR02MB4081D3C17C53DB5CD9021C5E9C9F9@AM0PR02MB4081.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Enabled=True;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Owner=richard.kerry@atos.net;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SetDate=2021-02-24T10:05:09.4065258Z;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Name=Atos For Internal Use;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_ActionId=9b7b1ec8-6619-410c-aef9-d17d36695aa3;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Extended_MSFT_Method=Automatic;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=True;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Owner=richard.kerry@atos.net;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-02-24T10:05:09.4065258Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=Atos For Internal Use -
 All Employees;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=9b7b1ec8-6619-410c-aef9-d17d36695aa3;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Parent=112e00b9-34e2-4b26-a577-af1fd0f9f7ee;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Extended_MSFT_Method=Automatic
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=atos.net;
x-originating-ip: [165.225.199.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 021fab29-25a9-44c3-5e74-08d8d8abad2c
x-ms-traffictypediagnostic: AM0PR02MB4084:
x-microsoft-antispam-prvs: <AM0PR02MB40840C30C78468B4356BF6299C9F9@AM0PR02MB4084.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ABvs+T9D+NzvSJCbxZt8SpYVYZFpvZApkShFZZSMqDe8V+oABxPVpuDgTJB0V88+fUPiS/k9fXKQWGpFOuiOoswiIjY1a30mg8ok8mKwrVD9luxXp6Mp4Z+DUrKsML7I30tOj6gKh6Mq18eTTAYfeXI5BlP0v5yqGMnOi+Dmr8U5HASVClnqVqCHYkdShI1DynS+wBEAMhX/cEKSeWLN0K7Nffxp9455+CZeT59hrjhyauBGU8dX91EaD5WlaOLfFoWVsjDxaVAn4y/NiGvIYv7dQ+bV/ZtnELMZnxwGIJ2ucXqIHd/MJiC3NgEHVy7IpClKE+FfDSkVdX6umS39OfM12wkiNWwsScqUW8N82QsK+Tm42SGBa8YfzQwjDov4jj6TOPlvzJ6WJ1+4d4c3I70os2kN6E1yzs4RIyjtaMDvYa6Uyw/D0ABRB8+7aCtDaZsMRHBZbWKVu/dIAYalCArBXLzWZNS9B0dtYvIUbZdCSJsTMoSbctqRWsRwQD2XumBHXBZ3nHxYP0WNtMCnmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4081.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(71200400001)(8676002)(8936002)(316002)(7696005)(9686003)(55236004)(33656002)(64756008)(86362001)(66946007)(66476007)(26005)(66446008)(6506007)(52536014)(5660300002)(76116006)(2906002)(6916009)(66556008)(478600001)(55016002)(4744005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?clpJmWhNqJMdQtZFnXI4ebveLwqNeU+3hZOMJya9UsIIESqqG1/OVZkBzCGw?=
 =?us-ascii?Q?voywPhXltyJ97T2GF3Kn4OVtjoEmBcxM9DHRsJQT99Jtrlip9hLgrXZn8qmG?=
 =?us-ascii?Q?lPsiEQsVkig4sCYbqFoDzHm4slmCiLrlj0+fuugItzJ/LCaA+3bqEfQcgDFN?=
 =?us-ascii?Q?eeKXjBE49la3IZ9abc0ye4exEpSETrI2x0zuOkAfEoj7WdLVgyPaaNXNdfWd?=
 =?us-ascii?Q?tWCgRbk3fCHALL7qNgCD1Bm21JD0SkRhE0JLZz6/lWTykxDyRhG1yP+dOHaW?=
 =?us-ascii?Q?uUn8MeYnyK4RkNAMUEWdWtsw+pxL4atCV9b8sQ1mV+eaKIs7awQJDteP8PJ1?=
 =?us-ascii?Q?z0MmP67z25bUGMNqZhzaANlEq2MDCg0f5rTiF7JSOITfRYnhS0gzIi5h7LGp?=
 =?us-ascii?Q?/tdy5GxBLzUrlhdiKSi9i+F+ytrtw6S7qBmOEihm++vDDJQ32V+tsIsxH0/w?=
 =?us-ascii?Q?fe5r6/5/Zs8xJSW1QtCyKv1qJ9Swfl0qzi9V2XDevfcyGDdwGAqGMM8Wkk4U?=
 =?us-ascii?Q?IFzbuJfQvvU0kfqhe74/zMmArE6vlGC9IFlh39ovnGr3Z6GrG7V8801WQiA7?=
 =?us-ascii?Q?eR3t5KUP4ys0tu+T+R5kI0NEyZm8Hw+xSZOxweuUMRbfE4x2cu1Jqn4udkL2?=
 =?us-ascii?Q?tiXSQ+ZrxwZas2LTTC+q90Ee00coU5bjYmakwIvjGYaHOFdtbJc8dXcgQoOB?=
 =?us-ascii?Q?YJduSK1Im+3gpsuuoWV9ycrmdrbuDyouEXpMd9rsY+NdXANTJEy5wUviHMIj?=
 =?us-ascii?Q?ydOkEDofhaYN6aZmpiuEM1eoTXJStPHBktfYkbNl5FRUq+y9WqzogoRx0mHy?=
 =?us-ascii?Q?i8Q9L/mpv5dcNMKHaG/bYjjbYvhWPqjBu7mEw7xPCXoJ+nI1ysIDBXSs2xc5?=
 =?us-ascii?Q?BweJreWWiSjuXbtR5noUuvSuvE3Q92S3xV9iQ1XJYYZmTKkzHIcRmeZ10Tp6?=
 =?us-ascii?Q?h0MxGZork1wJVsWuAJahG3tYHWLOTxIXYMGllSruhxz1VjjzDmOHdXA+gQHm?=
 =?us-ascii?Q?LtdE5pHUwbw65JcOwA/Z0xiiGE1qXyXX4MwxccxitSm5BgKTSgLhIowDAfA4?=
 =?us-ascii?Q?C7tKrzZf9RzYLBzm+iRc0zRBMs+oVUVwwliQMqC78fuRMBba7yOrBHjcAVI+?=
 =?us-ascii?Q?HI97JuQFljYg84J/qPCJJ7DAm/l8c4AzfKdkkKes25fI2++Ompj6zucqKA4p?=
 =?us-ascii?Q?5HQe9cXPx2ggTQOK1WZeQe3CHNdFWEcTe6+pC6uv/2e+BmNiY5LmJSGjXrf3?=
 =?us-ascii?Q?8abaPYGRkA/n8GmWhsULMDIy+XpkRsajgfdx0NuLu9PTGS9M7529HAUT7iee?=
 =?us-ascii?Q?IHcD6umxyfsfa7VKSLSq/F5J?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4081.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021fab29-25a9-44c3-5e74-08d8d8abad2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 10:05:12.8499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovcza6NOUx+RlsVYvJgkV8M+whSusn/ac1wTpaqMzMiUgmToifaWYgUiFrCiF5yx5E73EjLccb6537d27vvV7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4084
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


It's now been quite a few weeks, probably months, since the "ort-merge" wor=
k has been going one.  However, I don't think I've ever seen an explanation=
 of what "ort" means.  I know it means "place" in German, but that seems an=
 unlikely usage because git project generally works in English.  I don't kn=
ow of it as a word in English.  So maybe it's an acronym - ORT.  But what d=
oes that mean?

So, can someone please say what "ort" means?

Regards,
Richard.

