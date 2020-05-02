Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDA6C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 14:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A4D21835
	for <git@archiver.kernel.org>; Sat,  2 May 2020 14:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHoDLOWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgEBOvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 10:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgEBOvE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 10:51:04 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C6EC061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 07:51:03 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id v38so6143016qvf.6
        for <git@vger.kernel.org>; Sat, 02 May 2020 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLXP+O+pZMWl4dtcNs1vx3jcHig2bVp+LXBEesZya1o=;
        b=AHoDLOWKkfTFD2hetVMrFR6qBSn7bfOFbZP8eUTbRSM7rOj4dawkRKGsvhucsmadyg
         SdFW9SZXw5mwXnIn7RC1Wbkm2W50ual8JOaew+NV/73J0//sYW/NOiAN/9/2SLXh+anU
         Ptu/o5JVh87SYVpQQurdBnVLA6p41Ehp4i1dX1XlChJTbyTx+JIAYkGJ+qedHlC5Ug55
         Vx64UMKZUILh+gl1S6RbUlDq9PT5Xm+PIbeAlsrUJALry8vgwDf9Z/iaak2D1DRUggmM
         3tHxMw2S964Q8i9wUQXCiqpMGLS5x8ii3/bZ0JkzK/wY4P52MqQe1d6GqUo/T6L8e+w7
         jKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLXP+O+pZMWl4dtcNs1vx3jcHig2bVp+LXBEesZya1o=;
        b=F47IN0VSaTufCn+uyngHAOZWQN26o0XOqe646wGx54fwObFs1ehu/cU4BC0/x0TUDp
         Yem0krk6sinwJWJBD/WV6g1/afnXK33d4ssrnRZSU79LVQ0xZya5ft5J85XQSL7DLf5D
         WHEZp08LxY8SFWQ3gOCs4foJTwBjaH1Fmlr+QMCg/RoWbxR5J1+BIY2lkA0jjs9V66Pp
         vF+1DDkijVoxLhSzq+v4NbNx2kDV8xZNpUKEOBXI12BNK4fE5g/2WhPLjNUnD6nKP1qo
         nhqw/Hxx79gS+KoRWrEAn/bEcxS2m8XoZdjxOgidgfLGWOioo1guzDD79tMeuayzfBYE
         o+fA==
X-Gm-Message-State: AGi0PuYhOT9KA9xFSQB2MbCJht8CeLjW8vceDSC5sUqxLQon9BPlH8Yt
        BGs5C387zomtqrFs5wD6w+jVCzUpdlv33+nLF6M=
X-Google-Smtp-Source: APiQypJuy77M2nhGh93/OwF+u8cGNC0IATsPjSSQ4cAigYdl82NK6sCxNtAmPEOV6XDd/sHYTschi3vVJyt57ayAXVU=
X-Received: by 2002:a0c:a692:: with SMTP id t18mr8716831qva.56.1588431062325;
 Sat, 02 May 2020 07:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net> <20200427201228.GD1728884@coredump.intra.peff.net>
 <20200428135222.GB31366@danh.dev> <20200428210750.GE4000@coredump.intra.peff.net>
 <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com> <20200502132144.GB3143@danh.dev>
In-Reply-To: <20200502132144.GB3143@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 2 May 2020 20:20:50 +0530
Message-ID: <CAKiG+9WNkM-9hfp83xz_xv0s3LQaiyG0voMFKoxvMwFKt4YoZQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] CMake build system for git
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 2, 2020 at 6:51 PM Danh Doan <congdanhqx@gmail.com> wrote:
>
> Hi Sibi,
>
> On 2020-04-29 14:12:43+0530, Sibi Siddharthan <sibisiddharthan.github@gmail.com> wrote:
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
> > Adding the CMake script to contrib/buildsystem is a good option.
> > Is there any changes (apart from the CMakeLists.txt critique and) that
> > I have to do on my part?
>
> (Sorry for this late reply, it's holiday over here).
>
> It's long time since last time I worked with CMake, but I have some
> suggestion, maybe it was written in my previous comment, maybe not.
>
> - If we could find anything in CMake that equivalent with `sysconfdir`
>   in autotools, please use it for configuration files instead of
>   relative to `CMAKE_INSTALL_PREFIX`

The module GNUInstallDirs does what you ask.

> - I'll change (this and alikes)
>         find_program(SH_PATH, "sh")
>   with:
>         option(SHELL_PATH "path to POSIX compliance shell" "/bin/sh")
>   in order to support Solaris people, should they want to try CMake
> - I'll wrap the incompatible option of gettext under uname check
> - and remove ${} around variable in `if`
>

The thing with options in cmake is the values it takes are boolean only.
To do what you want I think you have to do something along the lines of this.
if(NOT DEFINED SHELL_PATH)
set(SHELL_PATH  <default value> CACHE STRING "path to POSIX compliance shell")
endif()

Then if you want to change this value, edit this value in CMakeCache.txt.

Thank You,
Sibi Siddharthan

> --
> Danh
