Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E120AC2BA1A
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 04:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B339F2070A
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 04:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKFHUMBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgDZEak (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 00:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgDZEak (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 00:30:40 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5C3C061A0C
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 21:30:38 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id fb4so6827822qvb.7
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 21:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKQfIVRzm4s42Xhu3XzXdHrtEDtlor5hW9hFHLIrN9E=;
        b=jKFHUMBBQDxkV1Ud69PtA2Kuk/IWXVaxbCG0Jp5a781az7l5wKR/x8N4CSPb9dPSWd
         TVV8QCvcxTgfS8D1EgOk5RhDCKpTRpUSkiScCUMoJeQISkb1LKmxxNy/Uo9BIrhRcLe4
         G5ximSmVYfjc+5dtjxm8B96Mo4mHQpRioBi9b1NGqew2Ai8LLqtaKTjoFhv/9KQBqn+5
         9fDA10TeAOTXxjWgQeRLrPQ/AB1s1+ZuNLNLx4NTggXzzLcEbIU/nebuswTVmpEjukkz
         HBrDhLnvbllf/Duu6WlhG1LD90cWfgT/Ilpo8rX3NyvKBrQg3M4ChN3zRQVCHOeEdUIj
         /8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKQfIVRzm4s42Xhu3XzXdHrtEDtlor5hW9hFHLIrN9E=;
        b=UshSkJgJex+kmy1sJGW0ED1ymXSAaWqBZTZY+uOokUYLO2/XydEfYve5T4Rqd/+PeV
         3a9FIinOmThh2F11aIaUPY+Xf3NRDEm5W01EdXUgU/Q+tOLddxvGdt04lcGqEUbzPJ/O
         Od3+fgf6/rUUVgZBUm0i1cIGThejZA7UKDEO6aqq6QHsPc8xy7ZVBMbngnSHLxrdvho5
         NiKMeYVjxE6CeeK804UUuYiZlC3JzOv7miweGQ6x8q/G3q4ycBEPZ00zPVcedgI5mURF
         ypo9QzocHXZKCmaWOF/sAfBj+DNgeEt1y5bZVc2MlG+LMRR11ozen5qDYkhAPHubMVgy
         P1Bw==
X-Gm-Message-State: AGi0PubHqZrXo+te7iTcwpMg65vJKgJoqpZHNmmUYlFWojVDgBVUOXTO
        IPS5aZXo6vUAxKsEWREEYL/+yJWSm7/NhJYDU6M=
X-Google-Smtp-Source: APiQypJxqdeMX6t2g6jZMRjJylawuTi7754jMHsZv2GB4yiZOUmxKIvs9KdxH9NCF/nCzYtoWqqiSP3kcP9KZuR+Pbo=
X-Received: by 2002:ad4:55ab:: with SMTP id f11mr16448676qvx.226.1587875436682;
 Sat, 25 Apr 2020 21:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com> <CAKiG+9Xtof8Hj3npsS-M0SnT_dcjtHjP_+avWB4oOHkaMdnSbw@mail.gmail.com>
 <40da111a-77e0-55b1-a6c2-9edc77cf1f3c@iee.email> <nycvar.QRO.7.76.6.2004251523560.18039@tvgsbejvaqbjf.bet>
 <CAKiG+9VMjft14ttqQuZMwewOGFbnbfJ3uXn0vPiJb05A8wdSwg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2004251624100.18039@tvgsbejvaqbjf.bet> <CAKiG+9XpZjesKs4p_yRvtgEhqwSHDqnjJcNkzqg_AEWr5BeuQg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2004251647520.18039@tvgsbejvaqbjf.bet> <CAKiG+9XwoD+UzHovS_mW76CPX_Vtt1eTaSM-xaszKWwt6R3ewA@mail.gmail.com>
 <20200426004119.otgynhnzvmykitez@danh.dev>
In-Reply-To: <20200426004119.otgynhnzvmykitez@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sun, 26 Apr 2020 10:00:25 +0530
Message-ID: <CAKiG+9VQd3R0DtPnxWq-RHwEAf-_kdpspPX_pAeQhBD8t=H_QQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] CMake build system for git
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 26, 2020 at 6:11 AM Danh Doan <congdanhqx@gmail.com> wrote:
>
> On 2020-04-25 20:27:37+0530, Sibi Siddharthan <sibisiddharthan.github@gmail.com> wrote:
> > Hi Dscho,
> >
> > I guess this is a pain point having to manage two separate build systems.
> > I will modify CMake script to get its sources from the Makefile.
> >
> > > > I understand what you are trying to say, this is not impossible to do but doing
> > > > so will make the CMake script dependent on the Makefile for the sources.
> > > > I am not fan of this approach.
> > > >
> > > > We should write a separate script (say python) to match each of the sources in
> > > > the Makefile and the CMake file automatically whenever the changes detected.
> > > > This excludes the platform specific/compatibility stuff in config.mak.uname.
> > >
> > > Hmm. That is an approach that _I_ don't like. Why duplicate the
> > > information when you don't have to?
> > >
> > > I don't see any issue with keeping CMakeLists.txt dependent on Makefile.
> > > We could of course extract the lists into a separate file that is sourced
> > > both from the Makefile and from CMakeLists.txt, but that would actually
> > > not reflect that the Makefile _is_ authoritative. CMakeLists.txt will
> > > never be the authoritative source.
>
> (This email is hard to be replied, because Sibi do top-posting.
> And, I want to quote both on this).
>
> I'm still not a fan of CMake despite that I need to write it at
> previous $DAYJOBS.
>
> I would like to keep Makefile as authoritative source of information,
> and to convince other developers, we need to keep Makefile as
> authoritative source of information. Let's say this way, I dislike it,
> but if it works for you, that's fine, just don't add more burden for
> existing people.
>
> Remember that with CMake support, we will never able to use CMake
> generated build in-tree because we have an existing Makefile in-tree
> (not a problem since it's expected to be built out-of-tree if CMake is used),
> but please don't complain if it people accidentally break it.
> ./configure doesn't work correctly with `--without-<pkg>` and people
> seems to not interest in my series to respect it, for example.
>

To prevent the CMake script from overwriting the current Makefile,
I can add a check at the beginning to stop the configure if the build
is done in source.

> When writing this, I intended to write something to support
> out-of-tree build with current Makefile. Hopefully, it won't be rocket
> science.
>
> Last but not least, (this point was discussed with Sibi off-list)
> about our test infrastructure, when we add a new test,
> we can simply run:
>
>         make test
>
> Makefile will pick it up, and run all tests just fine.
>
> CMake's glob only works at CMake configuration time.
> If there's a new test after CMake was run, and nothing changed in
> CMakeList.txt. The list generated by CMake will still be the same,
> ctest wouldn't know that there's a new test.
> People need to manually run cmake again to pick it up (or as Sibi
> told me off-list, that developer is question can run by hand
>
>         path/to/git/source/t/t-9999-true.sh
>
> That's not a problem for the person write that test,
> but it'll be problem for other people, who will fetch the new source
> to their own repo, and naively run msbuild and ctest.
>
> It's analogue to this habit in git (me in my previous $DAYJOBS)
>
>         yes | git add -p
>
> Anyway, get back to the solution (should this series be accepted),
> I think it'll work if we can split:
>
>         SOURCE_FILES += cmake.c
>
> into a source-list.mak
>
> Then, cmake will do some magic with `configure_file` or something
> similar, IIRC, it's a reduced functionallity of sed.
>

Me and Dscho discussed that we will use the Makefile for getting the
source list.
So we will basically parse the Makefile for the requires sourced to be
used( in CMake itself).
So devs can just maintain the Makefile alone.
This approach works for
SCRIPT_SH
SCRIPT_LIB
SCRIPT_PERL
SCRIPT_PYTHON
TEST_BUILTINS_OBJS
LIB_OBJS
BUILTIN_OBJS
XDIFF_OBJS
VCSSVN_OBJS

PROGRAM_OBJS do not work, as a few of them link with curl and expat.
As git-bugreport was added recently to the next branch.
This should not be major issue I guess.

> --
> Danh

Thank You,
Sibi Siddharthan
