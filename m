Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAC0C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 14:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA57221974
	for <git@archiver.kernel.org>; Sat,  2 May 2020 14:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abnfrC0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgEBOby (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 10:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgEBObx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 10:31:53 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C50C061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 07:31:52 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z90so10202205qtd.10
        for <git@vger.kernel.org>; Sat, 02 May 2020 07:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmTNHI+C4ulJvgQD5Bqvcya00DrmCVvRHOMGCs7tSYs=;
        b=abnfrC0VFMGXxxKgNwD0JBdjmxgHNZ1AuiaYeI8hrkUx2Va3Pyu/4QSL96EyRDlJ0h
         4GSUeS/Km6kUuYbMT7tgnBrOP/aWLkg8Lh2xK0Tmk7R4gc9piE6P9pPmPo0lnuD8IPan
         8VXaQ1QCbfxJD5E/W74ojjkDbOZbaqJWwqBlKlbHN+Hjr3/gVIRoTP3qo5xwGYrArBME
         gxFhMmFLjAG3YEbDp/aEJ2oDMIck/oNBE5AMTRBX5nz9szGUwuN4lES0Z0knbeQE6fjn
         WuKNeQXqo4f+mcW06DMKbW8EiRf+WHXV7FGRcVkENoQohAXm12J6mx/Cnq4hUqp6avRr
         mArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmTNHI+C4ulJvgQD5Bqvcya00DrmCVvRHOMGCs7tSYs=;
        b=uOPdTb8EbAC8zyGIhOpnF3UdY06CLdP7vrL00DdkdxKFzWM0NSwgdOABIgw5IkUFMK
         V0wxo2+y/Dp/6VRCqeKpMNfrIigBZpHDulGYSxzH10iSaY3MngO92QSOnvftMJF8mEAA
         qIshcfNm3dmbGJPUaft1OkOq/fzetkOkIxcYT0nUUZGIqhNCfkjCBG0OnU3prZ5ktvmP
         0a1VOzPJEUyTwgbeDKpiLkgUbEHQdlTriUbhks7awzUhEyVDqud6M4iky7bLfZ8vTFEG
         ut3LVqGMWAAzr++6smQ3dUiXIh7850lvAzDKlWQeWv6YpWdJAH8GDLFO5E7Mf8e77/hm
         lZFQ==
X-Gm-Message-State: AGi0Pubp19nrp0oAEV59xKOcYfuEQsijdZRFA6f7NrjtnDQklQqfujkt
        fyklvUB5qX/la6JROn80sjXqI9vJhW4N6SxjS+g=
X-Google-Smtp-Source: APiQypLfye1v9Qm5mG6h7WzWPNWbWaSraUwR88YdAUPz4Kuo5dgSCi9PvBKwLpm+tUR2q7qhwdFbDqXJ8L4zYm7REx0=
X-Received: by 2002:ac8:65d4:: with SMTP id t20mr8717391qto.358.1588429911523;
 Sat, 02 May 2020 07:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net> <20200427201228.GD1728884@coredump.intra.peff.net>
 <20200428135222.GB31366@danh.dev> <20200428210750.GE4000@coredump.intra.peff.net>
 <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com> <nycvar.QRO.7.76.6.2005012130010.18039@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2005012130010.18039@tvgsbejvaqbjf.bet>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 2 May 2020 20:01:39 +0530
Message-ID: <CAKiG+9UvnLtF7eS9FsPLyRR4ZPNSnakZwyYy3dO7WoAnRpvoMA@mail.gmail.com>
Subject: Re: [PATCH 0/8] CMake build system for git
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 2, 2020 at 1:02 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Sibi,
>
> [please avoid top-posting on this list, but do reply inline instead, that
> is much preferred.]
>
> On Wed, 29 Apr 2020, Sibi Siddharthan wrote:
>
> > Adding the CMake script to contrib/buildsystem is a good option.
>
> I'd actually prefer it to live in a different subdirectory: what is in
> contrib/buildsystem/ uses the technique of running `make` in a dry-run
> mode, parsing the output, and then generating project files. But that is
> not what CMakeLists.txt is about.
>
> How about contrib/cmake/?
>

The CMakeLists.txt will be non-functional if it in any other directory except
the root source directory. To help users we can,
add some instructions in INSTALL on how to use the script.
OR
create a dummy CMakeLists.txt in the root directory which just
says
`message("Copy and Replace the CMakeLists from `whatever-folder` to here")`
along with some instructions if necessary. This is what LLVM does for autoconf.

Thank You,
Sibi Siddharthan

> > Is there any changes (apart from the CMakeLists.txt critique and) that
> > I have to do on my part?
>
> No, I think that's it!
>
> Thanks,
> Dscho
>
> >
> > Thank You,
> > Sibi Siddharthan
> >
> > On Wed, Apr 29, 2020 at 2:37 AM Jeff King <peff@peff.net> wrote:
> > >
> > > On Tue, Apr 28, 2020 at 08:52:37PM +0700, Danh Doan wrote:
> > >
> > > > On 2020-04-27 16:12:28-0400, Jeff King <peff@peff.net> wrote:
> > > > > On Mon, Apr 27, 2020 at 04:08:52PM -0400, Jeff King wrote:
> > > > >
> > > > > > Skimming the patches, I do wish I didn't see so much repetition with the
> > > > > > existing Makefile. I know that some of the logic will just have to be
> > > > > > ported manually, but surely we could be pulling things like the list of
> > > > > > libgit_SOURCES from the Makefile as the single source of truth?
> > > > >
> > > > > Thinking I surely couldn't be the only one to think of this, I dug
> > > > > further into some of the sub-threads. And indeed, it seems like you are
> > > > > on the same page here.
> > > > >
> > > > > IMHO it is worth making the cmake file depend as much as possible on
> > > > > what's in the Makefile.
> > > >
> > > > Please correct me if I were wrong (I recall this from my memory
> > > > without checking anything).
> > > >
> > > > The worst thing about CMake is we can't override (Make's) variable
> > > > in Makefile generated by CMake.
> > >
> > > I really don't know enough about cmake to say one way or the other. I
> > > can well believe there are parts of the Makefile that will need to be
> > > manually translated, and that it may not ever hit full parity.
> > >
> > > But as long as it just a tool for people using Visual Studio, and if
> > > they are happier being able to use that tool, even with a few
> > > deficiencies, then it may still be worth doing.
> > >
> > > -Peff
> >
