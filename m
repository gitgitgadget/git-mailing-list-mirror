Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD13C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7146F2078D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JdpNVSEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgJEMZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:25:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:39493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJEMZn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601900733;
        bh=/Qg/68nKHsW19M4pNKW2djSMgooB0UlRfl+3/oPiT8c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JdpNVSEIiDPtW+qi2qjdB3vphOM5a1azircKd/56RgWiRHSSllQuxu5NKVPnjpXLM
         xFor2+tEZNNLb95Lw6lPVogdHhCiP34IprPhFXx1tNwizbppShSvdIAE3dPdQzkq7l
         KWOiLPw/b0kBcgBIwb3KSBCtIJgqU1/1An147KJ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.214.27]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Ue3-1kIWrU2wPp-006zw2; Mon, 05
 Oct 2020 14:25:33 +0200
Date:   Sun, 4 Oct 2020 20:35:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Carlo Arenas <carenas@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
In-Reply-To: <xmqq4knca7c6.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010042034220.50@tvgsbejvaqbjf.bet>
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com> <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org> <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com> <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org> <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
 <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com> <nycvar.QRO.7.76.6.1907151647110.47@tvgsbejvaqbjf.bet> <xmqq4knca7c6.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fyAJ+V5v4LyMP4w5AcZ7mgPjMdjE2stcI4J/dlvbdpYHdnhD1Ch
 lBeqbbHPuu+2g7f2ZnmIwF60gwWzz5P+Wv8ayLpBjL2sVGhCViuRL9BajNkiATtsyaigbHX
 dfN2amm7lsKRJSEu6HHjKFXnv8hZAYWugoiQhiqI0TqxI0sxyTJyCDk59KDZ8FHyysdyOyO
 zaC3p9KVeHnVHYSkWHpIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DAr/zbnBtJ8=:c0E4T0v2oD5rgyp9UFuRPG
 Vpv+H+LzqAF1MPpCzGIa6Tt140wVuxIKLoIM1zANJbyDMn8blqz8jRZwBe1jO7eKHmde3iYwU
 HjyyjB01qKjsopj/CXyCH7wPwE9z5ZAruLwj9Qw9iYhtVlXj1xylncFqBOEpSXdrIUsmH4Uug
 JrnXrbtpRiLn9Bii6triAmuw5123bVYxcocjNQ5+WfFKsEWih7btNamsqR4EQfkD8Ldfd4dqU
 cC1bG0lgtozd3l0dJOkScl16czDtGwQMHW1JtjhEagbgMUDsubWSaM4JyuXCbEqpi2ON7e3fR
 qi9PbddD4gMl936t/RoJg283eaze4LMqAvFP1qJDsiFxXFE7XoCU8o3cqbUhYRyGfnLCs+fwa
 0L0tvprOf4D57//KlcyjfdRm4N539JeFdeXCF5AGllsnRvN0IwVcabXjMAFipgAc9PlbBywqO
 9AORHgDi9eIYUfpAYGx52WuFuqkQ9YHLhF+xu6clCez3ZmOaxD6uR7fY6dPO6RLgNkverrL2P
 vJYfhTvI2KgHr06BA7SBziEvN6Vg5zo1Vz7KHOW8Gpx6l02/eQF7/fIfre8nZQi79KCOlFR13
 sAzfHcHsTV7zCo5qkWga4ihoV9BahuVJDJH6MxavNo8nRWEyxjMf1ZkCBOt1msT+GBYAbuWNI
 d07XsTjxih75MinFUYZqofIEzpwDuGZn0VCyV62nbrg3OjhGQJ5jIRVCFX5AZeKbDq47d5iUI
 GYswmjyjl6afBLBVluddcDlavCBvoiCyX8SxZhLE44WzvrHDe833IVhWY1AxuUYm1nOOkN3KC
 i31r3OUCviBdDJHBBSLgS1OabagBuIniqnj2s3GGLOL7CdtYe6O8MRe10KrrrROlzi6azGSZQ
 Ouv0A7aVK6UMaZbPFaUCL6k2KDQ1OoORDKoImqb7bDe1A2qXT9XAXuYTIc332zSkBVLTDEfUu
 cgD2E0sDwubn3r69VQAKReb1P3crvoQNV140xyGfPbtJS6Uv9oYeGauhabtstkqtBjMOPv4Tz
 lLMb2f7i3OZyOV9FG0IoWpH6GbXtYvH5iQfYl14trz5MS2ImX26qD6lLjxP5eBRZW9zbn61gv
 A5VA2uUiRd8iV1ejIWksiH5hxIEkZN58f4YdnQR9v+gFHe4VcMfbxKy2XJPT1gAMl/n2g0Glw
 MOsKHFr548EIA1a677YPTrIEJqBoJZwyTGCGWGcvykbAX9V8ZAiey8HT8jweKWFNmmY8QPuYj
 dhf+TqE2cemk5xPpF6fEHkZeUnUUqH//0p9h7oQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 2 Oct 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Sat, 13 Jul 2019, Carlo Arenas wrote:
> >
> >> On Sat, Jul 13, 2019 at 2:29 PM Junio C Hamano <gitster@pobox.com> wr=
ote:
> >> >
> >> > I wish if we could say
> >> >
> >> >         struct patch patch =3D {};
> >>
> >> that is actually a GNU extension that is supported by gcc and clang (=
at least)
> >> and that sparse also recognizes as valid; it is also valid C++ so it =
might be
> >> even supported by MSVC.
> >
> > It seems to be supported by MSVC, at least as of VS2019.
>
> In <nycvar.QRO.7.76.6.2010021555290.50@tvgsbejvaqbjf.bet> on Fri, 2
> Oct 2020 15:57:45 +0200 (CEST), it was said:
>
> > Before you further split it up, I encourage you to include these patch=
es
> > without which the CI builds will continue to fail (Junio, could I ask =
you
> > to either cherry-pick them from https://github.com/git-for-windows/git=
's
> > shears/seen branch, or apply them from the mbox?):
> >
> > -- snipsnap --
> > From e485e006f34922439f2e971a1c5c38b8ca56c011 Mon Sep 17 00:00:00 2001
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Date: Wed, 30 Sep 2020 14:46:59 +0200
> > Subject: [PATCH 1/3] fixup??? reftable: rest of library
> >
> > 	struct abc x =3D {}
> >
> > is a GNUism.
>
> Perhaps VS2020 no longer allows it?
>
> ;-)

I suspect that it does allow it, but only when compiling C++, not when
compiling C. At least in my hands, it failed to compiler that construct.

> Jokes aside, I think we agreed in that old thread I am responding to
> that "=3D { 0 }" was the way to go, so let's keep doing so.

Yep, we're on the same page.

Ciao,
Dscho
