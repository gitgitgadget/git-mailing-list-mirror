Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02052C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 05:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9ACE2072B
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 05:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnI1hYyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfLQF0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 00:26:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37850 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfLQF0j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 00:26:39 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so12197031otn.4
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 21:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scONRPggtWFZXO5FVT/1mitHsTYA5+dY68By46sboRI=;
        b=nnI1hYyGTIMw6Qo3PnfrOtT3tNjQHedh4jQjVrItPhw3mybyb7jSp2UzNwQnD5bCFh
         iF4yHaJKpAxwBEDTPioXSJWuxq80j8RumU/80Ywf7XMq/ETy+ahi0y7I1PlNSqSnzJ3y
         h/Na34wZFQvjiHZwDLqh06/B0bdm5U04077eSo7Ne7iICrBhXHQResohM0lAfkDXaUzD
         4xsdRDa3SzjVXD90qlm5ss9Gg+86+pSt6FLDykqZm4dP383myX1qafhIjpRu3tEsN6me
         P98ZskoMLiTSVDJcgpIBmBmG3tnWKxwtXfeY15lPzjlZc3BVLCJXcF6iDLmOuuPotmCI
         o0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scONRPggtWFZXO5FVT/1mitHsTYA5+dY68By46sboRI=;
        b=AnWd54jP0mPCES9lLBH3xWMmoaplgb2LusD+/pl3Vxh386XF0JG2DsJwzw8DI2+Zsq
         jWwy7sXAQbdMeCOYeW/03CED5kQeRiyEc9psDvpNdjQ+oL+ftj/xu6B8zzarlQu5FWCF
         Rdxk1tnChGJx7axG1RfUs/qIsFGODSoqnyozCdHB4nvFKAR2B0fgSWxI34FR/dZtBef2
         1LSqE8k4uavgR7QIrZXuStA7+GrZ5UdhGt7LN4jcDnp2Hzw7A3JcUhhxuh54pa7fwId3
         x2Y9evQadWc27bsOQFpEJi6tt4wxruHZd8JreaKAwjPrpA8SgG9x0ispLNS9dkz97y5G
         Pi9Q==
X-Gm-Message-State: APjAAAXFyB/P9TKAgSexu7vbIAWVoSz1Jjcj4wYXee2FM4ibQr619QsB
        3Q2sLMwFDQJiAf0+2p8ZY6+oZrI42OLHC46OV5s=
X-Google-Smtp-Source: APXvYqzXExbVQVtlBZDWsFEDG09/mZE81D2Y8PHq/rpjFmw6b97eISAVRdTsD/2Au/psgCuTmyNF0+o1pAZfgOcUVc0=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr16080640otp.316.1576560398390;
 Mon, 16 Dec 2019 21:26:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
 <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com> <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1912151126030.46@tvgsbejvaqbjf.bet> <CABPp-BE04=A9wx1VfWsghn6scy8aaVFoENxV6YiW2AxgM2jhjQ@mail.gmail.com>
 <CABPp-BGoC_D6LzzMNyf30wFssTU2WA1kTLmFvJ2Do+Tfg4+YQA@mail.gmail.com> <nycvar.QRO.7.76.6.1912170101230.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1912170101230.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Dec 2019 21:26:27 -0800
Message-ID: <CABPp-BGFRMNAgeyTvDQ3F5nH36ERn+ndjrwaXuLUE-Uto_RBdQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] dir: fix checks on common prefix directory
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Junio C Hamano <gitster@pobox.com>,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Mon, Dec 16, 2019 at 4:04 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 16 Dec 2019, Elijah Newren wrote:
> > On Mon, Dec 16, 2019 at 5:51 AM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > On Sun, Dec 15, 2019 at 2:29 AM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > Hi Elijah,
> > > >
> > > > I have not had time to dive deeply into this, but I know that it _does_
> > > > cause a ton of segmentation faults in the `shears/pu` branch (where all of
> > > > Git for Windows' patches are rebased on top of `pu`):
> > >
> > > Weird.  If it's going to cause segmentation faults at all, it would
> > > certainly do it all over the place, but I tested the patches on the
> > > major platforms using your Azure Pipelines setup on git.git so it
> > > should be good on all the platforms.  Did your shears/pu branch make
> > > some other changes to the setup?
>
> Not really.
>
> >
> > Actually, it looks like I looked up the definition of dirent
> > previously and forgot by the time you emailed.  On linux, from
> > /usr/include/bits/dirent.h:
...
> > and from compat/win32/dirent.h defines it as:
> >
> > struct dirent {
> >         unsigned char d_type;      /* file type to prevent lstat after
> > readdir */
> >         char d_name[MAX_PATH * 3]; /* file name (* 3 for UTF-8 conversion) */
> > };
...
>
> If you care to look at our very own `compat/win32/dirent.h`, you will see
> this:

Interesting, we both brought up compat/win32/dirent.h and quoted from
it in our emails...

> struct dirent {
>         unsigned char d_type; /* file type to prevent lstat after readdir */
>         char *d_name;         /* file name */
> };

...but the contents were different?  Looks like git-for-windows forked
compat/win32/dirent.h, possibly in a way that violates POSIX as
pointed out by Junio.  Any reason those changes weren't sent back
upstream, by chance?  Feels odd having a compat/win32/ directory that
our downstream windows users aren't actually using.  It also means the
testing I'm getting from gitgitgadget and your Azure setup (which all
is really, really nice by the way), is far less reassuring and helpful
than I hoped.

> And looking at
> https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dirent.h.html, I
> do not see any guarantee of that `[256]` at all:
>
> The <dirent.h> header shall [...] define the structure dirent which shall
> include the following members:
>
> [XSI][Option Start]
> ino_t  d_ino       File serial number.
> [Option End]
> char   d_name[]    Filename string of entry.
>
> You will notice that not even `d_type` is guaranteed.

Doh, yeah, I messed that up too.

Anyway, as I mentioned to Junio, I'll resubmit after gutting the
series.  I'll still include a fix for the issue that a real world user
reported, but all the other ancillary bugs I found that have been
around for over a decade aren't important enough to merit a major
refactor, IMO.

Elijah
