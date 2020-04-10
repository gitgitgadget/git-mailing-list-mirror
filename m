Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170CBC2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 14:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D401920753
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 14:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cIu5fEDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDJOj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:39:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:37505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgDJOj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 10:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586529565;
        bh=+K1fpCMBSJxdpm7ivSKB6mhW5+sX6EE+qX2+Dmmh19o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cIu5fEDe1WGRsueUQMqmwhPaFVxwmvmec5FbjT6OOm0zeBZSBdnvoyCLPwGJROUoo
         kTPcCSG+E9+H2g3zq3LAa9DHoA1S7hqD2uUQ2Nh25PPpEnyabLdJVqyxOf1WtnfMa1
         ZD0T4ttg/Z8EydvqrUGuUD317jjD/wKnzoEvu4fo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.215.97]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1McH5Q-1iqsuf1P4u-00ceaU; Fri, 10 Apr 2020 16:39:25 +0200
Date:   Fri, 10 Apr 2020 16:39:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH] mingw: use modern strftime implementation if possible
In-Reply-To: <xmqqblo1pz7b.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004101638420.46@tvgsbejvaqbjf.bet>
References: <pull.753.git.git.1586368729890.gitgitgadget@gmail.com> <xmqqblo1pz7b.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-990792017-1586529566=:46"
X-Provags-ID: V03:K1:8RlTvMB5tdv1aEySEumy9XB2lk1vOpkoDBsRd+DcgzBW1CwY+q9
 xDzQXL2HemyJ3Km9pBfS16sXs4Egh0TrOPIMUWLXPqNP3RdmSVk84fqEsqjsn/FPTHnjS0D
 /RlHT396jCQnMGSadLcIMij0FCnhFW/He8MN2prT+N/arZ46mnCxes8USHtK4yRuKsBPq9H
 IAcjaOm/pX81m+hZz60KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GpygIPGFUJQ=:fkHuCgGPJdznt56hLPf8AJ
 x109lyEainbL0yDpp2DoZzr34T8c8k1KlidR1vlb06+qw7s28NxSiSry1NjDZHvALSyRS+ujv
 zmrHVjkb7ZOuHVrQ9nk6HeAHjsSee5sj3r5EqNL1oHXBTdHWcPxgdvq0NNUZ+xA+nm5WxFdsS
 9X8zG+jZHKdLgIbPfajoZLu4r4OLho95mAo2D++tGnBWjOWKeujMl8zk1sEDXJ1JPXNBoCguz
 p+us4FRnUODTRZzqFnQhoXoxwXhI7sxGD7MgIT36boIoR5R4INGJrRDR0G8LvPQ8h3gw6EUdu
 rdqvgSwcVfmZ3RIXRWQR1lKpYEZmt5JX2uHsqKoagdWNWg9cg542dZTmLrV4kNuOHvfw5LcVT
 BlXGtlwmZif5qgfqx77fhVDVmfXdSN+S6cLrD1t6lWTJj15KxqlaHbhULpgBOa3L1bsBYtpvC
 na2Imj2GJWmKwQpMZO/AUohsVOoYTTZA4tZwPEqrg7AEhb6V7+LicGF9ehIguiomY/u+SNCsm
 kSmamhDrmyrORmhKRdpy3Is++hdvSsuBQp7h7BaE8dNvAVxWjRAhJZyRAkgog7NU1lg876WD5
 JNdJ2gquPE+t9FrxbNR54119/Laf5BJ+iWPwGckxAgAPaOLcH8q3n8jTMSLh5t5UTvNnKbzLr
 UNZytz1iAZG4l5koeYtfabHIokk69d5onmtBZcc8fbmaMyA9iZ0f30BCToMUAsXr4Jz90Hyr7
 KiQrz7F7nqZFrq0SeQY4sx/r97kKNp0tPhCLElSDgWM1hk0PS+dRLSd788NyQdUhO2aQneD9U
 inHDsYrlCAIulCnae9l1CitogMd/fRclVtAHpV5VyxADq/0ymXZb3fmMNjNYKBszhlWMZwz69
 VZQfHMwjNcOcATTveI1Q9qfQepSU//rvqtWrGJHs1fXkShqjE6T3E4YKvPwAgSFHAQZv/OWw1
 LdjNo6876qWNCT3j/niKDdn+N5WDwlTIsGhxcTBp5pVPYjuvRqx6/2wUfdMseXpNnF9kmDtQh
 jL++rOU7cgafmeiAA8dlaS8gnq5bvdO6wvZx+dGtzF4ik1XC2RmlW27W60dO6cpp5TvgYQObi
 gRo+P/k6nnoj/34PE5lIGulTFM3grpq1/8bNz6vITuRvYMBhSuG1DCwJTIx//SKxA+ZuwJK/G
 EnR4IswBTtqokn+XPhSv93pjADFZ3NcIrgNEsVQ6AAf5Cb3GHNqLw9RoycYQgMsQ1IfQj9HNz
 iNWnraLSafHmIKUPe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-990792017-1586529566=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 8 Apr 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>
> >
> > Microsoft introduced a new "Universal C Runtime Library" (UCRT) with
> > Visual Studio 2015. The UCRT comes with a new strftime() implementatio=
n
> > that supports more date formats. We link git against the older
> > "Microsoft Visual C Runtime Library" (MSVCRT), so to use the UCRT
> > strftime() we need to load it from ucrtbase.dll using
> > DECLARE_PROC_ADDR()/INIT_PROC_ADDR().
> >
> > Most supported Windows systems should have recieved the UCRT via Windo=
ws
> > update, but in some cases only MSVCRT might be available. In that case
> > we fall back to using that implementation.
> >
> > With this change, it is possible to use e.g. the `%g` and `%V` date
> > format specifiers, e.g.
> >
> > 	git show -s --format=3D%cd --date=3Dformat:=E2=80=98%g.%V=E2=80=99 HE=
AD
> >
> > Without this change, the user would see this error message on Windows:
> >
> > 	fatal: invalid strftime format: '=E2=80=98%g.%V=E2=80=99'
> >
> > This fixes https://github.com/git-for-windows/git/issues/2495
> >
> > Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     Use a modern strftime() on Windows when available
> >
> >     This is another contribution that came in via Git for Windows.
>
> Sure.  It would be very surprising if contribution to compat/mingw.c
> came in via Git on Macintosh ;-)

What I mean to say with this is that the patches have seen some real-life
testing.

> Will apply, together with the other one.  Thanks.

Thanks,
Dscho

--8323328-990792017-1586529566=:46--
