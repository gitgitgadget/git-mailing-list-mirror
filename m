Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11599C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA72861184
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFHJIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:08:47 -0400
Received: from smtppost.atos.net ([193.56.114.176]:24766 "EHLO
        smarthost3.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229548AbhFHJIr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 05:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1623143214; x=1654679214;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=75BFjIaYWAPislDunHEdZWrBfLPLGs0cxOD8HOhhYYE=;
  b=OpMgWgMskJ0XSBH+HRsLEE7tsyW4bHK0qliLZNDN6NX8n4nBf+dKo7tl
   6nRQJStIWeF5jsUUtHXwHtYxI0y+shCTPQ9SdQbV6u9GFqJ8DhjjrJLF/
   cbAAoKVW+6cfDGEB5TfU3Bx7qSagG795mGL2axoHgaIp9QuGxT9UO5ae3
   4=;
X-IronPort-AV: E=Sophos;i="5.83,257,1616454000"; 
   d="scan'208";a="211284143"
X-MGA-submission: =?us-ascii?q?MDExwmOrttXSUS/wr85wZgtsvBPjJPJno3Xgdi?=
 =?us-ascii?q?DQzhMvxF+myrQxc5NUYpRmLkXg6q3woltE+NFX4Jp4EpCAOYqWVTuYNW?=
 =?us-ascii?q?3yJ4UDwpRM2fDzqCboaWH91C7MzJfz80Zo28xp5oFPDTbAAIiBQNBrtg?=
 =?us-ascii?q?Bm?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB12.ww931.my-it-solutions.net) ([10.89.28.142])
  by smarthost3.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 08 Jun 2021 11:06:53 +0200
Received: from GITEXCPRDMB11.ww931.my-it-solutions.net (10.89.28.141) by
 GITEXCPRDMB12.ww931.my-it-solutions.net (10.89.28.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 8 Jun 2021 11:06:52 +0200
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (172.16.214.171)
 by GITEXCPRDMB11.ww931.my-it-solutions.net (10.89.28.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 8 Jun 2021 11:06:52 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeoFgWSeI3hgsJSfslEw3Uw1wsdfbelHpJt5qAI5rHe6T7JOcXpmNKnYQ4c9Vm3luiqhrAO0WBEml3HX2jwBby9oGaF2Y5pKO8hjF2bzpLS7xIOix7IkC0FUph6CmSh66mGryPwzFB6Q4gjGpJAek2SBv5WKP9+oc+s0e1m9UtfJFqr5mzx+IUU5vGlc9uxR1NM6QVgpeJlnOIc9d9JHB4z4IsSwNAhJYbE5v8bj8g1H3oQXEgpn5HssHI1f/8Hfvpvpk1ThUWazYLh37Q/wUubHjs/q7ofmFBCq1J4RsP5Bv4ej5VkfO8w6YcvAkbY5WAPvZ2x/ACh6LqTvMwvugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75BFjIaYWAPislDunHEdZWrBfLPLGs0cxOD8HOhhYYE=;
 b=cK+d1Qshbjw5Uk7r5dfb/FEDWbGPWd2NDNdbAmMpeghLc6BFBVNOX7Ss6PN4tsQEuyIqWI40TwXEqvW9ZBPg0ktB3lLAyCJPyFYiQ/iiWaGGYuML6OHfpSU5aeHzzy1QqlG6ca/UXpDIkLhpu+QR1LP2IJOe+RuujRWYaenvIxo265QgWawRhiBPvZsDN080wITHbSNPzBmrr2iM7EVKE9UozMVvG0SwU0fAff+ujrKZ1WzyVymDnD8sKHv7HsOVnM2KaCn5AZBLOS0iNWqS9u3BYhZkMIUh86VeJIGANMfJAh99Azoi4CFD66fWPRz98EI/bQPsrP5xRg4IVot9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by AS8PR02MB6901.eurprd02.prod.outlook.com (2603:10a6:20b:2e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Tue, 8 Jun
 2021 09:06:51 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::ed80:b8f7:efc7:e147]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::ed80:b8f7:efc7:e147%6]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 09:06:51 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>
CC:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: RE: [PATCH] branch: make -v useful
Thread-Topic: [PATCH] branch: make -v useful
Thread-Index: AQHXWag/WYe07QB2/0W9Ak5Qtje+gasF3IIAgAAmXoCAArWBAIAA7xwAgAAR8YCAAB1uAA==
Date:   Tue, 8 Jun 2021 09:06:51 +0000
Message-ID: <AS8PR02MB7302DF058D13CAE11A1086FD9C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
 <YLv8NWL7WfBRkiGe@coredump.intra.peff.net>
 <60be41f6473e2_39c0a208f6@natae.notmuch>
 <YL8KiiGXF8LdGmQ2@coredump.intra.peff.net>
 <60bf1997b1a72_1a2ac520865@natae.notmuch>
In-Reply-To: <60bf1997b1a72_1a2ac520865@natae.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-06-08T09:06:50Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=f62bdbbe-9d05-4d17-a1ab-44db437446a0;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=atos.net;
x-originating-ip: [165.225.199.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fe19ea1-6da0-4535-e80f-08d92a5cc157
x-ms-traffictypediagnostic: AS8PR02MB6901:
x-microsoft-antispam-prvs: <AS8PR02MB6901699A58216A61ECDFE9719C379@AS8PR02MB6901.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wIcHK4lxcV8LkdMaHQw276AVV71ZSv1v0W0er0w4dYFjsz1uvAKfxQbSW0O0yhXE4ZLvt5f2Kkht4L7++Ka4NwUMmjkVvXJGUjxXoBXmfCNyboagf4k2b6pIOWXiOalFWO/ZvxyGirPNOr6ypupemmEpvWa87sARd2yM35nebDIoNS6JR/BHSc66PvZXjtjt6bYdsWcufGfzmDynADaHZJ/h6BIH7LohNEK4UXuiL85jlFOAvhv3WZSuPlC8INkx1WlFjliw02ilHa5TGVDeCJuu3qxCKSyvuKDeEPhM6A1VgT4qDWwkybJwPoZd/3WJiRdZ2G0M+kazg0gvvC13s35G9pEgx7JwMdyLHoMnwl1mo0TANXHu9WqtBFaOiqCp7TgkmOCFMqGNBXZ+/fhi7OrXePyZ+vapX1CjOsRa7E2wMp54+58CSa64CZR9gCRyHXJ2Y3/aFH7Hr8LPyUAEPWw2bNyaNUZw7I2faNbL4GrsPcHKi/TnmD31328MXwpf/zmUUqOuhuiZf9Za8kb9hkdQg+/C+J/iaZUXA2e+kWrqUxfK0wV/xcmSK9oEyLFMcK8FOLp7Hu9+RJ4pbvoorrKM3ulqFEMuT2Yrv2qEeoU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(5660300002)(66946007)(64756008)(66556008)(66476007)(110136005)(66446008)(9686003)(54906003)(186003)(6506007)(83380400001)(76116006)(38100700002)(33656002)(55016002)(86362001)(316002)(52536014)(478600001)(2906002)(71200400001)(55236004)(122000001)(4744005)(7696005)(8936002)(8676002)(4326008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zss4cYEmJHARRupv8Jt0OKfndfvW8ys3zvooZ8UA/eCb616XJC6bbnuv7a?=
 =?iso-8859-1?Q?l4+/0a7+Zsb16M5XzIqg/GAjzBu1lBmlxEZfRGiEKu8bwjOe74ewpthutl?=
 =?iso-8859-1?Q?0UDwvROLTMNYP2hFZLt++hUUZ+R57lgye8KIISUszi5FaG6lZVAlDtfv3T?=
 =?iso-8859-1?Q?3VIMx9FU50xPMVwhd4VPR0D3+N7FL0eGUkGqP2sy5s68vu4PH2Z8UziQal?=
 =?iso-8859-1?Q?NcXVvR4Jcep+ZvG+zA8c0YryyFvjP/FOet0Kt6sShdEGMUuDsNqFpHpgLt?=
 =?iso-8859-1?Q?OtxrIyJDAfomNwnu7eoS7ug/v845ywgCVXHF5v1NL2clazE8+bufajLBM0?=
 =?iso-8859-1?Q?kowHHYyT7yvdoBkxxSLnVScJVkNR6IMrUW+UF3UyCaRn9Px22I3BIT+10i?=
 =?iso-8859-1?Q?SSs8ZBnMSwltuXI4WLB44aTubkQwVqYG0IQ6zsxNw7r6P2/6l3TOojC5BA?=
 =?iso-8859-1?Q?fQjb+2+HbixmBplxt/21S+rpeWaCOVUjdYBJ5Y6DIvjiI1WBNev2x3wkLU?=
 =?iso-8859-1?Q?YfGj591B+WsW+sSXJ4jCMt4PUDWw/VBbXzTtZ/M9Oym4MBYhUZoVjLfMFE?=
 =?iso-8859-1?Q?sgOZXBNTZ8PI4Dyy/ikzpl8oZGaziFeB9KyLp39Pd9bGRylqLxxOiznJv1?=
 =?iso-8859-1?Q?hc3lz4QpqPIjv4JhRwikr54WzhQ8aL0B5fUKSXMYRF9beIl1uh8VkfOH1t?=
 =?iso-8859-1?Q?GItwl0z/XpMBhz9VkRY+HUdTsctdWKEIqwhXtPJLxZvcLanuU1hv3+LCX6?=
 =?iso-8859-1?Q?Km1lmsxqzqJw8Byn8gLsfuR5b9XiwMJtqnuuTGbuREtjl3Vv+6KNF7Ldp2?=
 =?iso-8859-1?Q?MgBUKF7NnRYjORy6WD379MtXKyCzENSJbNNqHJR+QY0QhQT1BqLKqUwsQz?=
 =?iso-8859-1?Q?JYDP/B2NapUG5ZBVYN7uraAV4eFJm0dwJAn3vVxKIgqDuEFoVfmQoUiEsV?=
 =?iso-8859-1?Q?N5xMyG4e6aQkJC1DgaQZsaCAmRtRItk+FADWtZ1E6RAwf3suAdbZvvLHjt?=
 =?iso-8859-1?Q?tM+R4nD6fRbdghr7Y0VKiWgk42hIQd1KDN40/i2y1WZsAjZXmy2QYf41nu?=
 =?iso-8859-1?Q?XbhTY8DHaGqnVODOwgWnj7a5xcXXr/x7BtWfKxa2quHrNvACT8PS0C+DjN?=
 =?iso-8859-1?Q?5H2LNXmscPMMYUH2SEXpyGOAtCV8tkpkB2qvEPyn128JM7QYiIOhNqdFR7?=
 =?iso-8859-1?Q?6FjSHYLnXOqUJCnfitWer4UtQ30wAcHC1hmQghdi1RlZ+lCC/wQjWcWyHj?=
 =?iso-8859-1?Q?00pd44I2yBC3mD4qdM8HiZYMJQZoqPcSSB4tbl+w4ivaFUDsCIvuOcen/z?=
 =?iso-8859-1?Q?FNzqJJrB+M3G5nTt+ON7NdtirNa40cFtNkMQfwDBtfi+xJZ6hbtlX/ApSJ?=
 =?iso-8859-1?Q?FBMwHtePxN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe19ea1-6da0-4535-e80f-08d92a5cc157
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 09:06:51.7622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VY/doLkArk54a4FrqCEtGYrtuI3cVwwVQcynL8geB7h1vgiYxG9ac8nn+r3fPres6LXWjRUbzejSRr9sP5NHmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6901
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



 > Git is a distributed VCS, most people don't have commit access to the or=
iginal repository, therefore they push to their personal repository (e.g. g=
ithub fork).

[RK] When you say "most people", do you mean "most people who are working o=
n open source projects"?

[RK] I'm working using Git every day, and I pull from the original reposito=
ry and push back to it. I am working on closed source company projects.

Regards
Richard.


