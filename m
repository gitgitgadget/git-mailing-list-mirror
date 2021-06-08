Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97228C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 08:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7530861153
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 08:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhFHIya (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 04:54:30 -0400
Received: from smtppost.atos.net ([193.56.114.176]:10048 "EHLO
        smarthost1.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229507AbhFHIy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 04:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1623142357; x=1654678357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MDcOt87h8PdVm0XtzORNGk6ceVmlRqhWrsb1G9Nr6Ww=;
  b=YPds+dUwxrJlsx7FE0mI9Ue7qIWld+YMK4Z0AElBpGNHB42QSfbWrJs7
   wZ9B2iaDSlVNqepS0N50V5rKAjx9Y0X4dAAzPPCNymuuXbpGcq/cyyEt+
   qkRdJnF1xbQfruYsdLJ+Sase4yyzXA5o7s2+O/VXIRJIvcTVLgHRdx4Tm
   Y=;
X-IronPort-AV: E=Sophos;i="5.83,257,1616454000"; 
   d="scan'208";a="246404160"
X-MGA-submission: =?us-ascii?q?MDG0ceaAMMCnCs8uPLWMASMBggxyNvCWLLTc31?=
 =?us-ascii?q?LhameQzEaOU6OqaC6fyKMojn7fw//bH1jpCQSMYS8eQ8+S1clrXl6Nrl?=
 =?us-ascii?q?mD3rkxVm3DO7KobGBhO6tqFCYRR9r7GtSoFwDwn5SSm1+5FYzRmrb1fk?=
 =?us-ascii?q?2X?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB21.ww931.my-it-solutions.net) ([10.89.29.131])
  by smarthost1.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 08 Jun 2021 10:52:34 +0200
Received: from GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) by
 GITEXCPRDMB21.ww931.my-it-solutions.net (10.89.29.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 8 Jun 2021 10:51:53 +0200
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (172.16.214.168)
 by GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 8 Jun 2021 10:51:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyVg5RLEk5OD20SJEAjer75SZpKb27dl+04i+TPfXvzLEsWiE8YI4I2+vXJZzeH+qTo5yx5U4P71S6dZYuQarP6H+oNfEVP7rqdkSgt1FADRf7YswhF3L9+Y0KyEPf+BylPJ58CYQZHMOXDG5V/Ip6JOYho6LxuUXTrBbJXiwIZFMdAIOMSjgIA6ZGJJe+JC1x2R02eD9c6Tji0gN54K7RxRkIMCyHtpymAB9soVkbDU0XysshV39KhGr4B9wRwjHvFBpxwehUO6dRDc+TY+HBxzlolV76NOWlxku3TbJ4nATlzemDC7XV6r4RRwW0RRE5yRULQ5MTVyMCJnUQfJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDcOt87h8PdVm0XtzORNGk6ceVmlRqhWrsb1G9Nr6Ww=;
 b=Dz+YiJdqHZc1nrBTswCL1NQier1jhYz3zZwR0WKcS4ITot5bGV9La4xJlxOlj1v9RUacOf0IA7cE/1EBfwvAVV9oiPNMjwSIdxortXHpGHiPnMkrHPwZNVfD061QJQb6iUslNM4Q6KUbv84czP4qyJkVzbuo9mDH0xEKhO0mR1nLkow7ZiQPadu6Fu7OehpQ5DPIlb7kS7bSsCar9NEgEA34FrBCzpNm+9od454/YBb6XexepHAKA39nHpYLwRtYVGanOHOrEWMoteyxo0cQVKid1TuQEhYxVOXoGv+OMDBb9ZqR7/Bt5R5RumNLy+qVWfP+hHZ0OCUAdDLbBWW+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by AM5PR0201MB2322.eurprd02.prod.outlook.com (2603:10a6:203:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Tue, 8 Jun
 2021 08:51:52 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::ed80:b8f7:efc7:e147]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::ed80:b8f7:efc7:e147%6]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 08:51:52 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        "emilyshaffer@google.com" <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: RE: [PATCH 1/4] Documentation: use singular they when appropriate
Thread-Topic: [PATCH 1/4] Documentation: use singular they when appropriate
Thread-Index: AQHXW75YcIiaTHB6CUqdN7DKAcvQUasJUQS/gAB9AzA=
Date:   Tue, 8 Jun 2021 08:51:51 +0000
Message-ID: <AS8PR02MB73029EDC4458F233543106D99C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <xmqqh7i9rw5o.fsf@gitster.g>
In-Reply-To: <xmqqh7i9rw5o.fsf@gitster.g>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-06-08T08:51:35Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=c8390b8e-2765-4af8-b187-5eed0dd4b967;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=atos.net;
x-originating-ip: [165.225.199.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd3a5d09-26d6-4008-ca32-08d92a5aa911
x-ms-traffictypediagnostic: AM5PR0201MB2322:
x-microsoft-antispam-prvs: <AM5PR0201MB23228AE0E41B6C5FCA1898D09C379@AM5PR0201MB2322.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QpW4+x2SaPsjXCVp77s8zVBR6+E3AsBkWKc+rePv2Qo9NGzQX6/voK8w625RoyssQcc28ukf+pGkucg4BrS478SRIfB8KhX74n24dOl6fbWUOTGwi6trVcglXdMeaQVVvW1J4ipmchy/Rwi2xzul/7AfoOxizGHreKupRidYA9mBn56twL93ZX6Lu9ZwrqPbICZx95E7jRT6vzHBcOiu8znRwMMzF1FCN2G63MWy0cUepttSZNKQEGoBvgmvzNSS/f/A45rVQh6FnytvAV5GNub+esaubNysGBRqPiCjJgG9BvktVVaJRSsyf6Q+1hkA9Eotb9ts+bHt6aR2vTFAYXHID11Rb6nRpN7og5Rpw68ZjAEhBiUlhcachtW2moe1WnXABUIcDC2EV+AYnXCR/ZItyi0BJSQMhPn6hy0TrIxO4L0mf52N5fHl3pWHiAK6/uccW4WYizfKOexXo/x1zhzEeV+WXUalCIwaU2uhNveLWzXB01/ndAMiwhLyP2Dmnqmfj/o4CqkRnnGIlvKiaWFLGXQ4EqdmlbBvAqZqM+waBuBI3vaU0fMtX5tfINo3LT1YvpzgNbEP7vkGPA1PZYzVGhR5wncWEdlMffw4fdc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(38100700002)(55016002)(33656002)(2906002)(7696005)(186003)(66556008)(9686003)(478600001)(122000001)(76116006)(64756008)(66446008)(55236004)(53546011)(71200400001)(6506007)(66946007)(5660300002)(8676002)(8936002)(83380400001)(110136005)(54906003)(316002)(26005)(86362001)(66476007)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0XkUdWFtZedvPABb5PxvPeiQ8gIxANjLhEZkiRwRUUeNySc2T8MdK6/Mjp9q?=
 =?us-ascii?Q?EzyvfLFLs4myxbxrw+Et50qTIx0sVDtLUsMcUjc1MGdWxBqzG8wb11LKs9Ct?=
 =?us-ascii?Q?tFh0Dh5aRAD8+qeQEHKhDffaSziCrYdSLTeSyFXT/J8/SWC+HseVwwev5xgF?=
 =?us-ascii?Q?pU0RRHuoCl07tYoldYyAwsHFBC/MkYeasWmLmo657WQUg3XysPuA+3F4Bgx0?=
 =?us-ascii?Q?NFgq/jbcdm2mHvafx1HDnaafFuew+RVrD/0pzqlhXPHl4SFaVhVRy0vhT2GW?=
 =?us-ascii?Q?/Y9wedhEiw19hw6qGROc2wy56GlSCQIcyOD3/TL7+vfRBQJ5h/ot31I37097?=
 =?us-ascii?Q?xaGPK7GIYD8A79pkp4DfaHGmmq+yUQVORc6TVsqQdBX31BCfXkGQNIr6+xiP?=
 =?us-ascii?Q?pB7lWbJWmOPYERaquB+CrPq7WTVIAIsGDNsgQ7noDfyzpNmx2Xwk4nq0XgKI?=
 =?us-ascii?Q?EQkEtiHVLkiZPHRHLAuZ0Ksbst2xx3g03tGSiohsW9toPF/b3WJHWcD2izyG?=
 =?us-ascii?Q?JM+sZKI1EekbUki48HSj/GKu+X2iG0gMoEDnd6pO65gJNM5ZujdSyg0Eems2?=
 =?us-ascii?Q?s+wnBzuDfMhyt6bmnj4vhL8pQzCbm9a+NhhUg6PJ06T1JWDFZxx9SBneX3Ok?=
 =?us-ascii?Q?73kTm33k6HgYcHBIvvGl0f8Za0pkXqAMj8lSmKkdweAU0HNeHZuSENCUEpkh?=
 =?us-ascii?Q?haGdxAUMGFTlsnhtTTf/yXAzZYTIUdJJV8tZp3Ehfsyrf09MWh9mqJY69ood?=
 =?us-ascii?Q?IvpUBT+cCiA22GGhkxpUFT06fW/PdDe+tai95htrl490dvLOhIp6eXm0aI/x?=
 =?us-ascii?Q?4sJBMJT4ygpQl+OOxILNkXWEvLlvZ72edqsItZpj9+KzfKpEn7nTu0gh/Ugv?=
 =?us-ascii?Q?gOssm9MVMjAtjg9TnfhZ3GyL/G/wZtG6oFg9IoO9wNBUaZZR6ihHkB++OqjI?=
 =?us-ascii?Q?tuPCMcmIU97DwDQvPQljU1cThcNnN+gxL/ShqRVSt2m0eJ8coUcLqVseTWCm?=
 =?us-ascii?Q?2ipTYgIpj6z/LtbXz5/Owm7pNVoAPrglvT++QbC0j0/Sh9Q+tlDterTtWwCu?=
 =?us-ascii?Q?JVbfOZMqzAcQFjwjJFM0A7odjK4ucEL5YGUVYsANRBB0jaPCUl6Wea7Y2PmM?=
 =?us-ascii?Q?LPsJ6VorNhAKZGfQqa/e5BupDOcq8JAbz+GU4O0fO2m9uEAyOM8BoaTX4aWn?=
 =?us-ascii?Q?jGE4fxJQTRAmTTMBanMRWpUu9v8NYRk7yRrX723EoZJebKjxiM3FXhCd+Mr7?=
 =?us-ascii?Q?89PqU6GoQjZLHAOuNMG8qbouGL1Ldm4JrCvLGAbn6FY2h47pQL1Pm9mDkTjX?=
 =?us-ascii?Q?cYD5DQ3Jxg6nmxMCX2Q/hc7u?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3a5d09-26d6-4008-ca32-08d92a5aa911
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 08:51:52.0090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thbWzuXgcCvZxB0i+3A2nqid67Oq4wJu8PdKlUm2p+iBlaXnUM0hQUaMlByayrbGuJYGcpm+3kzk66ffHq/Jog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2322
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Or:

    `Reviewed-by:`, unlike the other tags, can only be offered by
    a reviewer when they are completely satisfied with
    the patch.  It is offered only after reviews by
    reviewers who are known to be experts in the affected area by
    the community members.

Sentence one uses singular they to refer to one of a pool of reviewers. =20
In the second all items are plural.


Regards,
Richard.

-----Original Message-----
From: Junio C Hamano <gitster@pobox.com>=20
Sent: 08 June 2021 02:19
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org; sandals@crustytoothpaste.net; stolee@gmail.com; jr=
nieder@gmail.com; emilyshaffer@google.com; Derrick Stolee <derrickstolee@gi=
thub.com>; Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate

Caution! External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/SubmittingPatches=20
> b/Documentation/SubmittingPatches index 55287d72e0ef..b518d3157f70=20
> 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -373,7 +373,7 @@ If you like, you can put extra tags at the end:
>  . `Acked-by:` says that the person who is more familiar with the area
>    the patch attempts to modify liked the patch.
>  . `Reviewed-by:`, unlike the other tags, can only be offered by the
> -  reviewer and means that she is completely satisfied that the patch
> +  reviewer and means that they are completely satisfied that the=20
> + patch

All the other changes in this step, including the one that is a quote of pa=
st e-mail sent to the list, didn't sound so awkward and good, but this one =
does sound strange for this non-native speaker.

Granted, the use of "she" here is already awkward (in the sense "why do we =
assume that the reviewer is of certain gender?"), but "they"
looks ungrammatical on top of that awkwardness.

    `Reviewed-by:`, unlike the other tags, can only be offered by
    reviewers themselves when they are completely satisified with
    the patch.  It is offered only after a detailed review by
    reviewers who are known to be experts in the affected area by
    the community members.

perhaps?

