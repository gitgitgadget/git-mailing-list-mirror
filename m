Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BF6C43460
	for <git@archiver.kernel.org>; Wed, 12 May 2021 15:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EF161C76
	for <git@archiver.kernel.org>; Wed, 12 May 2021 15:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhELPW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 11:22:28 -0400
Received: from smtppost.atos.net ([193.56.114.177]:11278 "EHLO
        smarthost2.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234698AbhELPU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 11:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1620832758; x=1652368758;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=pCDH7NQ4jty/xoiACGxIk2nBVVIZfFHmDUAUiQq7qAg=;
  b=n3uZVAf7mkcbpbvAYHC+q3nsfnOHGj/25R36xjxk7Jec4aulzYtGmPAV
   gqC7a3eHnWaR70SkKldvsWWWcdjaSwaIDWZi19w4XswswyIzeR26n4dcH
   h7GCRyy2RYBabaqRHQym5AzG0WvlVtrd2jg36kzNo8OOwg+EXw2no+q2n
   E=;
X-IronPort-AV: E=Sophos;i="5.82,293,1613430000"; 
   d="scan'208";a="204351075"
X-MGA-submission: =?us-ascii?q?MDEDEybPjme6dmPR4zCeJZUQ+g3jTVqI7hlKre?=
 =?us-ascii?q?Y6mv25kTIOC34WtvAbhjpAh8T6nW/niz0kGt+VEdBkCLZbtrDsLh1OV4?=
 =?us-ascii?q?HbkR+IpV9TCy0NT2pzYQJm/fl+yLOqGQPJrr64LsHnKlajLbvrzhC59N?=
 =?us-ascii?q?Bg?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB23.ww931.my-it-solutions.net) ([10.89.29.133])
  by smarthost2.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 12 May 2021 17:19:15 +0200
Received: from GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) by
 GITEXCPRDMB23.ww931.my-it-solutions.net (10.89.29.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 12 May 2021 17:19:15 +0200
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (172.16.214.170)
 by GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2 via Frontend Transport; Wed, 12 May 2021 17:19:15 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpqzMfQ8lBpjYYZSQbNElFTC+0G312uxzEvs3GqIu4YuwyhBIvPB4/6NZzUvOkaASeI1tk4E8ax0uT7lnvDfL72OisR4zr2pi0c140SbqCRVlABT8DxM460qVvnYuc+6urzZR8YXJC4canOaRRngUOuayIR1bo+150Inv+lnwvcjcMMU21IzEcLSULo3wYsnUV3taa0wu985IBgMDp27jXqqqWXAjxTW5xa5zipWaC3joq60KjOGhh4KnQtbDq77e7EofCsFtHuA0txTqzbG3LwSM16d+spSOvNPil3GpXfcVnoJHjHtdQxyGoFQrPoVnL83ttAFRfYnt/WXwM+vOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCDH7NQ4jty/xoiACGxIk2nBVVIZfFHmDUAUiQq7qAg=;
 b=nO3IIturek2m4Fvw9vH/X3OF3hjtT7m0n7A4ubkLswuwExAp0pFClhuTlJAx/HtXr++qPINVpwYAwZjWwuBsFhX0iu4c9X9758dROUn0rd5dptx6UkZ04yDE92tN6p2PnqEaiticFyzPf+wFhvnAXBCJPLGiq7G9AtHHzXJmNtsT/BsAhSlXxNC0ZxWboZ2D5Bh737cw9QnqtR0BS24ERSQq+m/zWhWbu91GuL1kHAZ3/WkQXcVhIfEi3crmrykQTBDv17qA2FYfjjMaVcs+PAQkkN90B5HzAZDW9fjfEOmgO2ptainP+6XSLVyIiYtRV40m6bWzJjUSzOFXi5mDLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by AS8PR02MB6822.eurprd02.prod.outlook.com (2603:10a6:20b:25a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Wed, 12 May
 2021 15:19:15 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::90a7:5df7:6e31:ecfb]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::90a7:5df7:6e31:ecfb%3]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 15:19:15 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Thread-Topic: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Thread-Index: AQHXKmWSvab880CUIUe7gW1qZ61pi6qnOIsAgACq74CANwgLAIAAByAAgAAUjACAAGYAAIAABzUAgAARzACAABphgIAAJvIAgAARUYCAAA/SAIAABFGAgAAGu4CAADngEA==
Date:   Wed, 12 May 2021 15:19:15 +0000
Message-ID: <AS8PR02MB7302003EB585EBAA0AB4C6E39C529@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <609ae224aa509_6064920851@natae.notmuch>
 <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch>
 <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz>
 <609b9ab0b1120_6e4e9208cc@natae.notmuch>
 <20210512100855.GA8544@kitsune.suse.cz>
 <609bb67c96463_70eac2089d@natae.notmuch>
 <20210512112059.GD8544@kitsune.suse.cz>
 <8e353a57-8abd-74d0-8b42-488b166e58a2@crashcourse.ca>
In-Reply-To: <8e353a57-8abd-74d0-8b42-488b166e58a2@crashcourse.ca>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-05-12T15:18:05Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=358c7f2f-06c7-40fc-8b1e-2be480df2bae;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=atos.net;
x-originating-ip: [165.225.197.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37553fda-de87-43bd-b492-08d915594dcb
x-ms-traffictypediagnostic: AS8PR02MB6822:
x-microsoft-antispam-prvs: <AS8PR02MB682259517B9E451AC1EB04029C529@AS8PR02MB6822.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tIUK1eMxT8HbgOrUs0h8/A+e574AMMIwsUWBmVpbMW9CUmhJVSiS1FcWCIPJHEY9ULciJohKwHqoL+RoH4wHfmMR5ynDWqHMenAt6F3H6OfoDiFx/RlThO2mrPiXSOa/D9/jYlB8p39aLbtQ0we8OurjrmClTuEmyzweKNHT2QFVGoHnY8T3n/XV+WVe45FhtYKIhlC4aIGhGB8AEGY2h891RgHucH09aSpTwz+n3TtFegtp30xNt5lGs4QlY3KzBvTB/Gr/Ae4tU3ofd4riLdbFYI3UkWlIoOQDKkgxQVT+f6IwgyAijgQ56tsjncIzTY4yE5FQexWZuv1HJmDJcQhjG+67ayZY1RMxyY8jjxG3jpB0bgiJ0jwNV2pf089bk0cMC5c2nSzLKgjq8GVIrpKQjr4ShybBitFDRirzUQuci/wPgfHE4uiwGR0K6XPGLNzduwZK5MH9NHsuPlXPdhkri5PgunL/FysGBZcVl56r1sukgAyy+T/ncXlPIxOKureWNeR8+CEdJW7V1VsTdz0ptnppVecSWWlJWPlIUai0ZkiMbjOCnAqBMBP/8q6iWJFEwH9Vbnx05nn1Fc/nVRzgIiqJBLRCjhQepbmv61E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(55016002)(316002)(33656002)(83380400001)(8936002)(8676002)(9686003)(71200400001)(7696005)(122000001)(38100700002)(53546011)(86362001)(6506007)(26005)(478600001)(45080400002)(2906002)(64756008)(66946007)(66446008)(76116006)(186003)(66476007)(52536014)(5660300002)(6916009)(55236004)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l9XaeTZ6EiiI9WSxpWXyUmJ/ZYVKb2kBs5KOkW6eP+E5Srg7goSwILbOMw?=
 =?iso-8859-1?Q?z5RKK5oRAPqqflLsCw57vrVuXKX3HL+iZ8IBmfB6Gqs3AG5CxKye+nciRX?=
 =?iso-8859-1?Q?qSQmwwWHVsVq0hDfeWaxyv9QvtzqVjQOTl4YygO7KGSzTTRiuwtdURy7qf?=
 =?iso-8859-1?Q?Q9lxvaCAYjALCNUiC6D12y06LyD/7kRb7MgUy+9N6jtlAClk7ZmtnA7EEL?=
 =?iso-8859-1?Q?7AyglmmPhwyuxmKglHGG0VzKwk2ZLyx4i3hogc9d3VyNuZAeikpbGjc7/C?=
 =?iso-8859-1?Q?JAeIP4QTBPF6VgTOzAu0O2j/6KnpsQruP1VCfdHVlh3jrApLZmbAZibj2j?=
 =?iso-8859-1?Q?NyYeg6poolQ8oNL9X3Vz5F96fqJJfwR+WMCM/Nzk7mKJU25ISNld09DlM1?=
 =?iso-8859-1?Q?rJD06JDbDFY9onzJ6Y8/o3tNFTvL3Ce2FS85Wmi+AVxDzLC+NOcKrN/uHb?=
 =?iso-8859-1?Q?yYp3Za+gJZwLdw5zb5N+fnB/zk3+rqvfbGpobGHKGjuuWYPmmSUE3TmVhd?=
 =?iso-8859-1?Q?m0YB+h0YVN6B7n1FsDV+Y9Owgf0oseYiKzyIFS7520+uck/wLZXtbhroak?=
 =?iso-8859-1?Q?BMwvw+h11Wfq1c0uhtHN/BwAm5yV1Uo4Fsvk13AYWybEC20kwXn5Frsft8?=
 =?iso-8859-1?Q?W+6v3gx8zCIqeANbXsJ2aE8sGzQnjrZlTmwQtnyHvjYv6UWhbcJov0HXw8?=
 =?iso-8859-1?Q?twWMVzFxnaV3CVqqUYKJtMhhWP7q4anBycaz4GbbgOWJjNnqqbbF8zRv+c?=
 =?iso-8859-1?Q?iuIwJip3yM7xAiFJB7EE0h99PetlA8GnUIrt3fkc/50LBdSHw967g+G5mF?=
 =?iso-8859-1?Q?9nBisl69GCoC844Y1zd9rdmXT8mMSg7M3WsOa7XDbG/OPevcHJmvyjvv2x?=
 =?iso-8859-1?Q?Zh7Z1rB5KUAccN8Bs36mQGtwnx6EaEnEkZIQiG0TLy8MkGhE5mEq/zv58Z?=
 =?iso-8859-1?Q?C6W6q8zR+OuOR8Pz3SiglXQvGvinSNyCHIAgGbKKCa5gAwRkc6Ta+ZIttz?=
 =?iso-8859-1?Q?XrXAKwK5MqP3ZXpBexZFlOHf2yzAjT0usDpqReM0nLozeKo+T8Kd745O8D?=
 =?iso-8859-1?Q?uJPDMKzN+BI1J7Y80kzavv530nHUX+6oE5oKzFRUvCSWrdUO13hcAuoxlD?=
 =?iso-8859-1?Q?tzODZ8nWlvpbH/0xXbqvdzBIx0/nvFA5DTBBk0WLmU1/al/icnO1AWN3jj?=
 =?iso-8859-1?Q?P/7WzyQ2Di9GoKCOO/eytmWCxCal9/gMReaLKxXMRFf4PIMC1gFBJD64D6?=
 =?iso-8859-1?Q?SZA2PNr/psODOopPTiYnkDrhR3YnST02GQNM/UQ16s0+LnSUGSL26Wj9jm?=
 =?iso-8859-1?Q?0/VmUXp+K7/se7lsQjMS6dEQR/ffVS8hVbgZhCurlaW8hYE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37553fda-de87-43bd-b492-08d915594dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 15:19:15.0228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CN0G+Mpq6OkhdMwALtrvgdtC32nfyUTqKqAr/8Ta7LVrN+mtXd0sEByzICIKGqakOqwaz/8csZ+kRqbfZugE2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6822
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Speaking as a native (British) English speaker I don't have the slightest p=
roblem with the word "impact" being used in this context.

Remember English is not one of those languages with an Academy or committee=
 that defines what is correct.

It might be a different matter for non-native, or non-British speakers.  I =
suppose the question is whether this a matter of preference or comprehensib=
ility.  It seems to me to be the former.



Regards,
Richard.

Ps.  Sorry about top-posting.  Not sure if I can get Outlook to do a nice s=
et-up for anything else.


-----Original Message-----
From: Robert P. J. Day <rpjday@crashcourse.ca>=20
Sent: 12 May 2021 12:45
To: Michal Such=E1nek <msuchanek@suse.de>
Cc: Felipe Contreras <felipe.contreras@gmail.com>; Varun Varada <varuncvara=
da@gmail.com>; git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affec=
t"

Caution! External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.

On Wed, 12 May 2021, Michal Such=E1nek wrote:

> On Wed, May 12, 2021 at 06:05:32AM -0500, Felipe Contreras wrote:
> > Michal Such=E1nek wrote:
> > > On Wed, May 12, 2021 at 04:06:56AM -0500, Felipe Contreras wrote:
> > > > So... Can you answer my question?
> > > >
> > > > Do you have anything against the word "affect" in *any* instance?
> > >
> > > Yss, the Merriam-Webster dictionary also lists the meaning "to=20
> > > cause illness, symptoms, etc."
> >
> > I did not ask you if you could list one definition contrary to the=20
> > intended purpose of the word "affect".
> >
> > I asked you if you have something againt the word "affect".
> >
> > We can use your same logic to find one definition for the word "impact"
> > contrary to your intended purpose.
>
> That's exactly the point you have been making, though.

  y'all realize that linus torvalds wrote an entire version control system =
in less time than it's taken you to argue about what two words mean, right?

rday
