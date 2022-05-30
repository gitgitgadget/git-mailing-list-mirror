Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5BCC433F5
	for <git@archiver.kernel.org>; Mon, 30 May 2022 09:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiE3Ju2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 05:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiE3JuC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 05:50:02 -0400
Received: from smarthost4.atos.net (smtppost.atos.net [193.56.114.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF4F35DD5
        for <git@vger.kernel.org>; Mon, 30 May 2022 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail2022;
  t=1653904201; x=1685440201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PVkOnIQjH7nMt3pjDDNjBGfViYj+G/Q7Ip9rCxbcRGA=;
  b=NwgIS0IMViTlsu5XKc+U3IcE0H8794lcXE9jH3Ldkrw1dY2MjJvZ0Ns6
   iDkyWxTV58eUiRXZ0EVBtILkWz66UsllVRAXRJf3a9I1jB0C4hBDBRiEQ
   xXlRK4LexNkVwO862lLxVa1WT1acn9oZur0pXnO1CkJFBSkpCP/bKIKHm
   f8atoTuUQ3JaUtmCupJHi4+QrsbkYyDftbk77nnoNKB0+ebD4/6TqnpYU
   /wlVphrdSPbrTdKTN68aBzitiHnqGWJxrri/tr9Ek1rzOdyJC9xbPUPFg
   OzvyCm12STw1z/D2aiOLMFvLWF8qhIYR0R1q882MfzPktcE9VpTDMc976
   w==;
X-IronPort-AV: E=Sophos;i="5.91,262,1647298800"; 
   d="scan'208";a="363312771"
X-MGA-submission: =?us-ascii?q?MDEDaVVeNCwTeejbgdEQ/Io2S565YjfP4L66KP?=
 =?us-ascii?q?114wzL2mCi9/hvg9WSqCtCpZ6h5jEVeEoqNhHBKoUKie10rDzpfiQ1wD?=
 =?us-ascii?q?N73R9VpGgN92zwO2weJ4N2s810UFlF4DXBbPubvCL7aqxCWhWVecTKLZ?=
 =?us-ascii?q?8b?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB22.ww931.my-it-solutions.net) ([10.89.29.132])
  by smarthost4.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2022 11:49:59 +0200
Received: from GITEXCPRDMB23.ww931.my-it-solutions.net (10.89.29.133) by
 GITEXCPRDMB22.ww931.my-it-solutions.net (10.89.29.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 11:49:59 +0200
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (172.16.214.169)
 by GITEXCPRDMB23.ww931.my-it-solutions.net (10.89.29.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Mon, 30 May 2022 11:49:59 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cudl/DYGv/VB49HlYLZoEJSMLeFjw6bF/5AnNO0t3BkgjiHTXiPQLPJldTVpGBNlPDmeZNg5AGAfq+ak3lw/gomC7P85yluoZ1gl6MXKvPYpi78F9XkIE1SjA+lkmIuHINjNZ03JnlHEzhYenNXgG+d2QnGfZlF6cQB/InnwV8yuW1LmswHzXedlgEVOzIEF1y6j5i6EJq3iEqXJcJfsja5bb0oi6fRXXaUQJI46jhxIDV5DIMFQZN5crtT7JpD48voMEOb/lBD7L23GvO88j7iRngLCTaD3QA599Y/nXxKQJCsX1S1im7TkvZPYxOd1CR2awYSIPEjJ6LRD4gDrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVkOnIQjH7nMt3pjDDNjBGfViYj+G/Q7Ip9rCxbcRGA=;
 b=kV2Zr2qvBWw/Q7sD3GdpJE1e0b1BvXOwd01ErXJUi/C6Zfbki5IpxKbZEAN/rBwHwp5wWDBK04md9r3AbUhAYuIo/b/9T1HxQvUVisOUOr3qfEDlbC6Hu2PX7z7BzaoDrJqsu10uyj8+0HP2tb9VQNm/UwGfplSSOdX8kL5vQ4Xx0HvqqvU6sPYJ7moZrv34VKuHDfUuBH9CANu57ZniYw3JeR8kYq3OgzmUVBcOo9mEJ7WzSCQ2VzPTRyuD5qqSxLFRuJhtW7hqY8DWBg76SpFJS3JTsahofdjr7lCnxkXDiaeO3IQtkxFmv8HJBDbdRh0cWOQDBhBFZ81oM1jsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by AM0PR02MB5684.eurprd02.prod.outlook.com (2603:10a6:208:164::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 09:49:58 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::75d2:ba70:2c4c:4aff]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::75d2:ba70:2c4c:4aff%7]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 09:49:57 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Philip Oakley <philipoakley@iee.email>,
        Aman <amanmatreja@gmail.com>
CC:     Git List <git@vger.kernel.org>,
        "git-vger@eldondev.com" <git-vger@eldondev.com>
Subject: RE: About GIT Internals
Thread-Topic: About GIT Internals
Thread-Index: AQHYcFJeSlQVuDSUyE+Bj+ahqalDva0wP0IAgACamYCAAfU7l4AEYLEQ
Date:   Mon, 30 May 2022 09:49:57 +0000
Message-ID: <AS8PR02MB730274D473C2BC3846D9FA3F9CDD9@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
 <Yo68+kjAeP6tnduW@invalid> <8adba93c-7671-30d8-5a4c-4ad6e1084a22@iee.email>
 <CACMKQb3exv13sYN5uEP_AG-JYu1rmVj4HDxjdw8_Y-+maJPwGg@mail.gmail.com>
 <0201db28-d788-4458-e31d-c6cdedf5c9cf@iee.email>
In-Reply-To: <0201db28-d788-4458-e31d-c6cdedf5c9cf@iee.email>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2022-05-30T09:49:56Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=ae3cbb81-2b12-4992-8a89-25c27118c3d7;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb73cd09-857a-427c-3f5c-08da4221c1cf
x-ms-traffictypediagnostic: AM0PR02MB5684:EE_
x-microsoft-antispam-prvs: <AM0PR02MB5684B4D0DDA35C66EBDA788C9CDD9@AM0PR02MB5684.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F/ZkGcaqoXEOazb8R32Dy5jO0QTBF+UoXfMaSPhNvx6GcXIV147bFWsqfr4uV5iOnCbyxxI92Da64i9EtuvfNaiXsJ6UUS4mMAM3KHpgldnbD5SarKqCp0Fo3SJ9sR30vw99U5GXL4Lfq3fMe//b+2zh7yym9/EwsjgCEcWSUOvSXc1N6WvCforqcL+G9Ljh+kc0RKU/+bE6CXa73WOz1Pvn5dgfY58B11RbCx/V02CV6V2/wOBEp/Zav61RXwGIzZ9surq3ICXK4X1/KJ4QQuW38k3Q50bHh1AglW6ddmW1nUsEAI4QpVtWxMzTrdZ/cWZHS/VYAjg4hoDSX2PMv7UMR+Iww6NcwZUflIGUwyMfNuNQC2QClGHjJ1XLKw2wiYR+nU+/YH0uWzIGaltJUzRYEjxIfUAAyLCOwJq9FWyCcAWEfbv6OF4jDlEGDLQ2x+DK4cVWN+zR9RpZstqI5EhG6fV/jy9AJyjnoovr2jL2S5trmKNLAAq/ro95bw66m2O+6HZI/G+i1G79wZbCM3fweaQdVfVpsnyNYEOTQL5F21zv0IZvi+EipKfbL57CvWXzLnx3Sf/dK0H2Q3AMt4urzd0OIt+FDet/fnEBy9voByKJs2wzZAF+mA0fXjQgTcdxAJ//GVFk2sKdKm4oasQCbOCWZnfFUyF0nxFRFvQcfSgvsTxiVRuPoMsN1Xl9IukWDALM07E4xqi6JkGW7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(5660300002)(33656002)(64756008)(53546011)(52536014)(66556008)(66946007)(8936002)(7696005)(6506007)(86362001)(55236004)(9686003)(26005)(2906002)(71200400001)(82960400001)(3480700007)(122000001)(38100700002)(55016003)(186003)(38070700005)(83380400001)(110136005)(316002)(54906003)(4326008)(7116003)(8676002)(66446008)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eiXANmkWOqDuqgS4cRWaAX8M21ox+/MITOhluEAF/NWMVNSEwhQQJAhuD/3e?=
 =?us-ascii?Q?3Xd+IYLRms6Nx8zLcUjN9lzrScQ8LL0TOTvp5Ya9wSAF6U/yoXS3LzrsFs+b?=
 =?us-ascii?Q?n0/lz6CxfwLnGr3T+j3aa1779grjBtuFfRnrLaQa2JF55+wxNC+vqrqCad1/?=
 =?us-ascii?Q?WbC3iPbQ226UA4hDcecJIZl4XEqtXAQAEunp5HjhblxcWdnxj0XlzN9buFJG?=
 =?us-ascii?Q?ZvmFk/nhaCgJRhkbFp4URBdyUDbk7dVD2VLaB2k2+Vw0Q+eZsdm/Z0mIQCae?=
 =?us-ascii?Q?Ao4GQCQ3W10FbqkI3xDoxNZG6aymRvZh7o7f3wLe+p5nS6D0gfm2Ogt9AVL5?=
 =?us-ascii?Q?nlzyZneVJ2fEy6wJkDTdsucFFU6ne0IrF/KgujHKkm/FjufW2J2Wc7KHvOBU?=
 =?us-ascii?Q?s0wOAWIc+ctuygglfBtfV/3JNoDglwRMa7o4VCrXOCWfQ/9PFNs4OQpwZGGD?=
 =?us-ascii?Q?68WF2muENNH51CrKBTZe2gEg658oAAjkxGe9O+k8a/aKL/oFZCtIKKd7wXhJ?=
 =?us-ascii?Q?M41DlnQkuGEaPuAnmfXRDqGoo9ZvShIQZdcJKP+zBYbo+TWBpfGxRmtshYCp?=
 =?us-ascii?Q?60ZWh8jPBqdZ/tE33s0cXYEBC53DDFaFIwWMn0cZYFsbjGKI6v4eyPQ+hfbA?=
 =?us-ascii?Q?2Hk90z38ErNM2xaVMJ88vcfgKZINV6oCjYQ6ltyh2ipkxfvk+ZyrbshIPGqe?=
 =?us-ascii?Q?n7cCBLQKRoZvlRBPX7MC0c8FQLxqAvWDELj695xqIYOg7tNoVSwKzykqNty3?=
 =?us-ascii?Q?QM7cv8hiFPld9b4Z7krsHn7xbEWu8vwGT8dIC3L56njq5P7roRtTMpnBzWsj?=
 =?us-ascii?Q?seDOR0cx4LcBCdewbd4Hb/cQEsXAfTEkkp/opYuXMn3yG3Bx7TOBp6h3Jleb?=
 =?us-ascii?Q?tLZAz1RYpURPt+st2tVF3gEreohgg+01exNXK3m7sPgUAVFjHL5zyPemOhcG?=
 =?us-ascii?Q?f+Ch0d2Q7EjO6J6Sz507p3x+gQL6j/OaW4pfJMQUEYSyqHVs432cj9MHbFdn?=
 =?us-ascii?Q?qDcN6bXHvnFXmTyCIAXoPIrBfWbV3nXxm81dx9GvQa5jzoLYC53iXL5AbxFZ?=
 =?us-ascii?Q?T5T9EJ9NdHUi/iGoiC2ZfRWldRemWEcUM3X3kLBm0v1/GflcywMdfzQ23hFT?=
 =?us-ascii?Q?mFrb4LF0srToIZcBc+Y1HOgr1LDabi7irbjRXZq/tdssHdwvrQcL8RhqZHAw?=
 =?us-ascii?Q?1SKyw7gsxFY7hfoXzMdXVrmMbfkkxeK+G8NjeWGlth5mEwCsedTgwI4Fmr8p?=
 =?us-ascii?Q?qZE7KPfK3UTlr5f1sDLmsOpbEGXZ+Lpo2QpHAsRDku6CdBqfTR+y2t3SY08F?=
 =?us-ascii?Q?7GHJAfXbSVgha1ujpauzL/ILSTJ+P2g68opE4GLjV+tjErW37nL32kU/sYgH?=
 =?us-ascii?Q?dAdz5Z8ST9HShs2iFcyKTRsNEjdxMSSUtofR0+0hZRPovn2qqjv0mf18TCdR?=
 =?us-ascii?Q?Zq/xk/S04fa1lGZC0b8C5lXNPVL4WzrjAWEmAGCHMYLohcvsY8qtSmAVObe/?=
 =?us-ascii?Q?tihsE3wVoENRn5vHqEwGH2fpjCwowxVr7wuWEgAZjpglbgwYIl3tSec3JY0T?=
 =?us-ascii?Q?rA7684oHTNZo9RfGw4JIqddHAgywFibjO/l2aJxejEeK/rgUyMnwPRSJiKcv?=
 =?us-ascii?Q?z2m+2+52034oHaLEhO1YqGUn4vH3L52eqC+q/+RUacgeMKPWNxwbRaDWObPf?=
 =?us-ascii?Q?IUNdKjCWw8+AbfdoYs583DKJMMOASmvAnViWM7KMMIwP9qaxu04DpkmVMjvP?=
 =?us-ascii?Q?eisQUpP83g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb73cd09-857a-427c-3f5c-08da4221c1cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 09:49:57.9129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: baw/4+Xymm/v0TDTTroR1BfTaDZtnPSpPIwaY/NHffzdA3QMIK2l8Kzl43ogb8vD4BRAja541PHy0wKY30HPxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5684
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Philip Oakley <philipoakley@iee.email>
> Sent: 27 May 2022 15:40
> To: Aman <amanmatreja@gmail.com>
> Cc: Git List <git@vger.kernel.org>; git-vger@eldondev.com
> Subject: Re: About GIT Internals
>=20
> > Just a  follow up questions- if you don't mind:
> >
> > 1. I haven't had the experience of working with other (perhaps even
> > older) version control systems, like subversion. So when refering to
> > the "control" aspect,
>=20
> The "control" aspect was from whoever was the 'manager' that limited
> access to the version system (i.e. acting like a museum curator), and dec=
iding
> if your masterpiece was worthy of inclusion as a significant example of y=
our
> craft, whether that was an engineering drawing or some software code.

I'm not sure I get that idea.  I worked using server-based Version Control =
systems from the mid 80s until about 5 years ago when the team moved from S=
ubversion to Git.  There was never a "curator" who controlled what went int=
o VC.  You did your work, developed files, and committed when you thought i=
t necessary.  When a build was to be done there would then be some consider=
ation of what from VC would go into the build.
That is all still there nowadays using a distributed system (ie Git).  Thos=
e doing Open source work might operate a bit differently, as there is of ne=
cessity distribution of control of what gets into a release. But those of u=
s who are developing proprietary software are still going through the same =
sort of release process.  And that's even if there isn't actually a separat=
e person actively manipulating the contents of a release, it's just up to y=
ou to do what's necessary (actually there are others involved in dividing w=
hat will be in, but in our case they don't actively manipulate a repository=
).


> >>> Chapter 10 is about git internals. It is important to realize that,
> >>> unlike many other version control systems, git works effectively on
> >>> files locally on your computer, without any server or other shared
> >>> resources to manage. Also, one good way to learn may be to form a
> >>> question that you want to answer first. "How do I ...." or "what
> >>> happens when I ....". Since git works locally, it is possible to
> >>> create a git repo, look at the files contained in the .git
> >>> directory, take action with git, and then look at the files again.
> >>>
> >>>
> >> Another Git feature, compared to older version control systems, is
> >> that it flips the 'control' aspect on its head. (who controls what
> >> you can
> >> store?)

Again, I don't really recognize that.  You store what you want, probably wi=
th some sort of arrangement with the others on the team.  The important bit=
 is determining what will go into the release.  Ie in choosing what, from e=
verything that is stored, will be released.

> >> Hence Git _Distributes Control_ - you no longer need permission to
> >> keep versioned copies of your work. This was, in my mind, a core
> >> element of its success.

Maybe you do.  If you're working with others there will probably be "permis=
sion" in some sense involved.  I can store what I like locally, but then I =
miss out on some protection of my work, against a technical fault locally t=
hat might cause a loss of the whole repository.  If there is a remote serve=
r then I am probably only allowed to store company work to the company serv=
er.

A lot of this discussion seems to be more about the differences between the=
 nature of Git and its client-server rivals.  I thought the original query =
was about how its internals worked, which would seem to be a slightly diffe=
rent question.

Regards,
Richard.
(Not old enough to remember the smell of blue prints, but old enough to kno=
w of the term)



