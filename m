Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B728C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 22:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE40D22B2B
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 22:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbhAMWzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 17:55:36 -0500
Received: from esa12.hc232-33.ap.iphmx.com ([139.138.43.250]:52956 "EHLO
        esa12.hc232-33.ap.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729429AbhAMWmg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Jan 2021 17:42:36 -0500
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2021 17:42:33 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=nab.com.au; s=oct2020; t=1610577753; x=1642113753;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=h6V5GIrIVJBnmWd+4CnT8GU28K26FtAu+4vh9AJYd0I=;
  b=D6D8XHdze1RhFhdrQ1McPpzU+E7naCHcMN1h+spvU+06P0arBCQL+sn/
   gtLs2bAKNL6sw6Kh6Ho8hVoz496XoosB/p81AyGaaPy3lpBcWFhYGymsE
   7rhZKfZ/bfJcQ525Rg9s42XpEzRM+b/nY1HqqmwfU9Qg0/AgKrs1xWiPs
   c=;
IronPort-SDR: uHsKuGi3FCKN9iAbbmPGRxphnx4Hjto0uq0pC+GQ19JZn4Jf0Jo0ghF9ac8aQwY0+Tu7T/wvxv
 W05SS+Ks4d3zI7QL0I2rDzQ/PDK8eZMxeemofKtBX5TzG4ymkCuH1Dhw2Kv3o2b3FY6jLMFc8W
 mLDLCtxpx6v+JHMN5VGivLJ+JJGjlzUbnNHYhSRK87L5tZmWvG3t8SPoVH1IjcXAlnIZdDiFlF
 nn9huOO+GGKmjGhFCx/4HODckLc9hr7Yt4yJNaUfLLynyNYQUOkzfkH1XcquM3bqrzcKo9SKqv
 75w=
X-IPAS-Result: =?us-ascii?q?A2EEAAD0dP9fkIjrNaRKGBoBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUAHgTQFAQEBAQsBgVJRgVdeCod9A4RZhweCF5pDFIEsPAsBA?=
 =?us-ascii?q?QEBAQEBAQEHAi0CBAEBAoRIAoFuASU0CQ4CAwEBAQMCAwEBAQEBBQEBAQEBA?=
 =?us-ascii?q?QUDAQEBAhABAQEBAQGFfzkBC4I4IntQNwEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBDwJtPQEBNQEuAQERJxEBFR4CSxcBDgEEGxqDBIMHAZw5AYR8AYEoP?=
 =?us-ascii?q?gIjAUABAQQBBoEIhDWEXXSBNBoCgmcBAQEGhiCBOQkJAYEuAY1XD4FNP4FUg?=
 =?us-ascii?q?xRpgw4CEAELBwEjPYMNJIIIgVgGajAXBhMYEwECeDQUNxcac48mP4wAnAEsB?=
 =?us-ascii?q?4FJgTEEgRgLmlyDKoovhUgDjz6UFqFFAgQCBAUCDgEBBjaBIIEicDMaH4M9U?=
 =?us-ascii?q?BcCji4MDgmCCIweQzE3AgYKAQEDCXyLNIE1ATFfAQE?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.79,345,1602507600"; 
   d="scan'208";a="33406582"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO smtp.nab.com.au) ([164.53.235.136])
  by esa12.hc232-33.ap.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 14 Jan 2021 09:33:33 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nab.com.au;
        s=may2013; t=1610577209; h=From:Subject:Date:Message-ID:To:MIME-Version
        :Content-Type:Content-Transfer-Encoding; bh=h6V5GIrIVJBnmWd+4CnT8GU28K26F
        tAu+4vh9AJYd0I=; b=dMYS2XFmCv1ZYhEXFt/ncmdg/N+O8MuGe3KLM1nLTOkC3V8TsW1+RQ
        0sg/HITaObAqqm6X/SsUCk1xLnxVvLrGTtonJKKEfYljhV04pstaqg2Ko0VoviqAtAfV+ytlR
        1/U10jw86W1bg+t2lJRMQKtHjLsRYiuUAfDler+KzzLE=;
Received: from AUP22EE000NABWE.aur.national.com.au (10.46.39.14) by
 smtp.nab.com.au (10.46.12.15) with Microsoft SMTP Server (TLS) id 14.3.487.0;
 Thu, 14 Jan 2021 09:33:29 +1100
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (10.46.48.2) by
 smtpmsin.nab.com.au (10.46.38.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Thu, 14 Jan 2021 09:32:20 +1100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKOJAxN4AI7CBcTNKaGzJfVPn9xb57pWHBFyAkXvhkEuGmZUzF4fyCSy1PBIHlJgW75sKtjTP1Vw2SmvhQJyreXtbdJl4WGyg+9GWJJavGYLzXmfHC2Ha0AJ12bbjkx/0yYLicEwCkQ8bA9YCDAOV2snt1KrqqcvafgbN64GSZQlLCKFdCVPrYmxHkiuMcudAS/E6QgoidUuin3sHVjhaHJeZar5Utr9udoujxBo42GbW7RhHXOr1VTttaESTRnkQx75JA6SZQ6Qsjvghtc9T7RQGoYHp4Q4XtR31CyAj+Xxa4gNpVK51cWAfDbqHxcomDX1JwhKfO5JKAtfMiK6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaexhkeLztWM5MoMU9XiyMMgHfruE+1bMbVQ9KhZGSc=;
 b=YiCdM5IMJQpwQqov7yKUVUt9s0MEw75RpSVFxknIA9DlnYqAVaJRI9DLtngv+hA3+eN9K0eTXPbgMGYXTK/PlFfrDl5Xy2/4D6YZiHa3Tcy+4H+ZFleuhkxqD1j6QQR8ItyvZvXhnMoEpCt2ZljZUZdbCZmuUFh+RITlKeM4cgtTS1qMQrrA+Yue9wtlbCEVlFxO1r98rOcc8DIpSBCN6iKBfQDE6IVz2FtT5OLuUeJy1fqqeyr+9X6f0LRgwGHIcgtNxWAKT8YL8Gufr2JqoXp33gAWTWkarutoIuw9oA4UwkQzYxr4UVJor7ZQlxDLR3fDbsEd199GQU4aLsj3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nab.com.au; dmarc=pass action=none header.from=nab.com.au;
 dkim=pass header.d=nab.com.au; arc=none
Received: from ME2PR01MB3249.ausprd01.prod.outlook.com (2603:10c6:220:30::9)
 by MEAPR01MB2408.ausprd01.prod.outlook.com (2603:10c6:201:8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 13 Jan
 2021 22:32:45 +0000
Received: from ME2PR01MB3249.ausprd01.prod.outlook.com
 ([fe80::c884:41e7:506a:65fc]) by ME2PR01MB3249.ausprd01.prod.outlook.com
 ([fe80::c884:41e7:506a:65fc%5]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 22:32:45 +0000
From:   Anthony Miles <Anthony.Miles@nab.com.au>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug report: git checkout introduces local changes
Thread-Topic: Bug report: git checkout introduces local changes
Thread-Index: Adbp+/8uYeTMycRhQOuy1mz2iSbSYw==
Date:   Wed, 13 Jan 2021 22:32:45 +0000
Message-ID: <ME2PR01MB32490F1D7657C6B6854A3B82D9A90@ME2PR01MB3249.ausprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nab.com.au;
x-originating-ip: [164.53.26.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47086be1-36d8-447a-7afb-08d8b8132639
x-ms-traffictypediagnostic: MEAPR01MB2408:
x-microsoft-antispam-prvs: <MEAPR01MB2408B4957ABE581115067EC0D9A90@MEAPR01MB2408.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jnhmd9nex/e84r8rdrqE/e59JkioH/yVJuw5cB0OyriIPMJX//rBGeV5BumcBVAWX8oHK9zI1qzDopGBrazW1rdZ56Fit+2Omm0eufLR0BXxJU992TwNvfCe0MzySyQdWjw5chNjOLgzCLPXUcpW2kbiVtD2q1EXjnGKAyrwHX+HBZJDvxKJHXglCpcjkfUFS5WhVLQ3RV343oGl3vHk5uv7NcSgY94Vgok5S2mR9pm+rA/lXzaxCZ1H6mSYt81TiE9yBwPMuwuhE1pyrvIX5e9ez8avOl1CrFZWW5dSHGIVQ9dNiu/aEXrhaEE7GVJ4X9NiFJLG0pYGAyIh6j+02QD4GKdRdCQ6Z7n2oRHHdBa9MHamk0TsMBpJtfuS3Ys2UiROWbhFOGo5cw2SzGgsurKLk9qVBQg4r3vKmQwooDCtv+A9tML4uZcblnMO89aG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME2PR01MB3249.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(39860400002)(136003)(478600001)(33656002)(86362001)(71200400001)(6916009)(2906002)(9686003)(5660300002)(8936002)(10290500003)(55016002)(4744005)(66946007)(26005)(186003)(6506007)(10310500001)(76116006)(8676002)(316002)(52536014)(66556008)(66476007)(83380400001)(7696005)(66446008)(64756008)(460985005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?SLwp62CSdofVkXXrbhVbuvK0pvaK91v/s/MtUiZgb/eFukULYWe+wO8KR8?=
 =?iso-8859-1?Q?du+YW7FCcjaHEslpd+S7Yyr6TQLClXb6DMsW9kg1ffmnC21So9jQwZvGQ+?=
 =?iso-8859-1?Q?eMmjFx0uokB0l7W47TMsNk1DC978cW3Ca0zJ1PLx1dFZFI/llChUUtey6r?=
 =?iso-8859-1?Q?hAEZy/QP60BsHww0F68KkHpAihnDTt75Nw1g3awQfklFNR1PgEVtGGEm2m?=
 =?iso-8859-1?Q?4RZifC3vWjrRVs+Qx/sq4UVK9XsHygTJDEsSmWKLx0UMgensZYCtdHsbbs?=
 =?iso-8859-1?Q?6Qf2NVYGvB1lkAczZonppCBw0SAiFnvRtGWFF0vOKx8AHPCxCaMAw+3sa4?=
 =?iso-8859-1?Q?fL/ngPjihr0ocxrybw9E84DFBzjIsG46BB2bV/OcP3Rcj6jljMoi6HR64n?=
 =?iso-8859-1?Q?dOMDtXz2QLIgW95z/AuwFY903roooUCmFyJC2eMSEYRFTB0mh4Qzv7Xj14?=
 =?iso-8859-1?Q?5YzlupjkrbIYEexnZGoO4/dc5SUgzyZKfL3wAoOnvHeEA1G9OA3jqW7bEK?=
 =?iso-8859-1?Q?UJc76GaDphdretw/g/lUtQJoB/TEWWDCGJoPFqltyn1b3BUkXIGApZF0c0?=
 =?iso-8859-1?Q?Z99Vjq1fUjNe6iJa3TIp7axyDNpW8DiyxSR9eGPmPT5CqU3nn5+HfRoI24?=
 =?iso-8859-1?Q?gK1d+tJDRJqbgZLcgwZ5watGavuO1NfKk+WHenOJZNduhkm+jTxSSbnn9p?=
 =?iso-8859-1?Q?Ttnsxp1vMYoxCRtQrJXusgafMLHvJTVs2ieqtXlOto8ScTcC1oDNp3yNye?=
 =?iso-8859-1?Q?9yaPeY9UyOhM3xnNvY0Q4GoV1iuuLVUoQ/g5BCMppSYTPOhuTAmQqJSyeC?=
 =?iso-8859-1?Q?Flx1AWky0YCBax4Y0U8pNYfYbeyl2Qpsar4FULjMFyksQEd8uDu+2E5O8a?=
 =?iso-8859-1?Q?2Z3yVUCLa5/10WwteN2HfAcFm262qMkPMjeU+QKaKZI0aYW2GOfu5jilpp?=
 =?iso-8859-1?Q?Aogr2FVl4zQmPomgdkL6KjOtbLO0dp4hpG420OUoT570H5jcCRdAuHT4ri?=
 =?iso-8859-1?Q?e5/IRjegCahhXSiEI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME2PR01MB3249.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47086be1-36d8-447a-7afb-08d8b8132639
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 22:32:45.7646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 48d6943f-580e-40b1-a0e1-c07fa3707873
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/7uQwzLMqMGr6BBIe+rXQ2MpqOJ31ljapJqsv0Axq3vWF1pV3GqD46ZG9eB1c4V8S16v14BKlNWDcYZg6eukkHy73zTMcW9uDbGUedj0qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAPR01MB2408
X-NAB-Disclaimer-Agent: 
X-DKIM-Signer: DkimX (v1.31.131)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Background: (from memory)
Branch A had a file X added to it
Branch B had a copy of the file X added to it (in a different location)
Later, Branch B was merged to branch A

Steps:
1. git checkout A
  No local changes
2. git checkout B
  File X is deleted

What did you expect to happen? (Expected behavior)
Checking out a branch should not introduce local changes

What happened instead? (Actual behavior)
Checking out branch B introduced a local change, deleting File X

Additional information:
Switching back from branch B to branch A results in no local changes

[System Info]
git version:
git version 2.29.2.windows.2
cpu: x86_64
built from commit: 3464b98ce6803c98bf8fb34390cd150d66e4a0d3
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
uname: Windows 6.1 7601
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.ex=
e


[Enabled Hooks]
pre-commit
pre-push


The information contained in this email and its attachments may be confiden=
tial.
If you have received this email in error, please notify the sender by retur=
n email,
delete this email and destroy any copy.

Any advice contained in this email has been prepared without taking into
account your objectives, financial situation or needs. Before acting on any
advice in this email, National Australia Bank Limited (NAB) recommends that
you consider whether it is appropriate for your circumstances.
If this email contains reference to any financial products, NAB recommends
you consider the Product Disclosure Statement (PDS) or other disclosure
document available from NAB, before making any decisions regarding any
products.

If this email contains any promotional content that you do not wish to rece=
ive,
please reply to the original sender and write "Don't email promotional
material" in the subject.

