Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A60C07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 00:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7CE610A7
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 00:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhGUAIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 20:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGUAI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 20:08:27 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F1C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 17:49:04 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id w22so528404ioc.6
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 17:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A6jEbhPPy48mELe/dGXIvfZBFcT+d0uFedyxc3rYUNA=;
        b=LFpg+E6Iey31jlHobNyTOhAEMmo7rrzLl9SmBlmHFt/PW9vD7IJm1ZRZpG0x6bAHlV
         4O0qE/LeB1Wc1Z/NHoSZUJlG1qHQu8ZXQBnEY4pzG3sqwzQXcJnmfcgdYqG3rpWSRtBZ
         paqqZDHwmrj2b/mLPJ78Mtx1CIpIEJXbB3tDvLr+DjvTlZZAuTnaG/GvypnDFpSgdH+S
         UE+fWn0NxyuQf8ZFcpuyRcpQHHJ1+zLH/+hIIS1H0k48IWLmY5aQFjObEmmkEMWyF0dr
         s47TU622t8xAZmEplTLQ98N1DRpnn77Wr/v9cBKIIvnmkUG1QJ6F7FgAjc858/WzlU28
         ih5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A6jEbhPPy48mELe/dGXIvfZBFcT+d0uFedyxc3rYUNA=;
        b=Zmpeao3PB3LI5jFBuR2uDQ4oR63VoWq1Nn3SE07A6Gx8BDodPfJAi4NWSMCVDjpk9x
         5spn3rSipi7kA9A4wVnHPswdv7YCQM3XMxbMeR29cdAVgBuCwyWQfW6nmBzdZMkZKPC8
         4VpwRz8We3K9omeMU3rcm6laf81Qmv9WQsDaHsqfr8yevlfGjfF6VT4kglgK8pUhVZ8l
         vf8Yk2WQhdxGTmJKYleuq8xyNiK4mulfCsdRebldmDrv0bh/q5ifyjA8woJpcSWP/piz
         riAtLXkABg12PXLV63K4PdhN4oaflZC8/+db/Hk2VykgfdR6Cri4xYVitxtdlr2p3JLX
         0WTw==
X-Gm-Message-State: AOAM5328amyyUmuU/1UbQ9ejzR317kEC2jN6zhcZIi/F8SOwXA2XhEmh
        5JLgCz4KkhLI0gatBZhvR+VfqSly9dTlPhKjzYY=
X-Google-Smtp-Source: ABdhPJzbgArXHQ9Vm8eevpoDedYjtRe8hi+Xokj4onkNVr3tWqmPlWFEU2ETTlchHjWlccAyISYlBSL63Am2sNWDK3Y=
X-Received: by 2002:a02:ccad:: with SMTP id t13mr28523816jap.29.1626828543426;
 Tue, 20 Jul 2021 17:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QLrG+R3sOHpMsAiveOT1wTKR-_Nw8Ro6iXL1_MTMZ6eA@mail.gmail.com>
 <5DDACB9C-4AC8-45A8-B9AE-5727464AA95D@gmail.com>
In-Reply-To: <5DDACB9C-4AC8-45A8-B9AE-5727464AA95D@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 21 Jul 2021 08:49:26 +0800
Message-ID: <CAOLTT8QQoV30fvtdOv2V7LzeZ-P=4g9Xvj-dBf28+FeLn4nC1w@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 9
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Atharva Raykar <raykar.ath@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On 19-Jul-2021, at 12:25, ZheNing Hu <adlternative@gmail.com> wrote:
> >
> > [...]
> > ### BUG REPORT 2
> >
> > * What did you do before the bug happened? (Steps to reproduce your iss=
ue)
> >
> > Normally execute the test under git/t.
> >
> > * What did you expect to happen? (Expected behavior)
> >
> > Pass the test t/t0500-progress-display.sh.
> >
> > * What happened instead? (Actual behavior)
> >
> > ```zsh
> > $ sh t0500-progress-display.sh -d -i -v
> > ...
> > expecting success of 0500.3 'progress display breaks long lines #1':
> > sed -e "s/Z$//" >expect <<\EOF &&
> > Working hard.......2.........3.........4.........5.........6: 0%
> > (100/100000)<CR>
> > Working hard.......2.........3.........4.........5.........6: 1%
> > (1000/100000)<CR>
> > Working hard.......2.........3.........4.........5.........6: Z
> > 10% (10000/100000)<CR>
> > 100% (100000/100000)<CR>
> > 100% (100000/100000), done.
> > EOF
> >
> > cat >in <<-\EOF &&
> > progress 100
> > progress 1000
> > progress 10000
> > progress 100000
> > EOF
> > test-tool progress --total=3D100000 \
> > "Working hard.......2.........3.........4.........5.........6" \
> > <in 2>stderr &&
> >
> > show_cr <stderr >out &&
> > test_cmp expect out
> >
> > --- expect 2021-07-19 06:09:39.800189433 +0000
> > +++ out 2021-07-19 06:09:39.803522767 +0000
> > @@ -1,6 +1,5 @@
> > Working hard.......2.........3.........4.........5.........6: 0%
> > (100/100000)<CR>
> > Working hard.......2.........3.........4.........5.........6: 1%
> > (1000/100000)<CR>
> > -Working hard.......2.........3.........4.........5.........6:
> > - 10% (10000/100000)<CR>
> > - 100% (100000/100000)<CR>
> > - 100% (100000/100000), done.
> > +Working hard.......2.........3.........4.........5.........6: 10%
> > (10000/100000)<CR>
> > +Working hard.......2.........3.........4.........5.........6: 100%
> > (100000/100000)<CR>
> > +Working hard.......2.........3.........4.........5.........6: 100%
> > (100000/100000), done.
> > not ok 3 - progress display breaks long lines #1
> > #
> > # sed -e "s/Z$//" >expect <<\EOF &&
> > # Working hard.......2.........3.........4.........5.........6: 0%
> > (100/100000)<CR>
> > # Working hard.......2.........3.........4.........5.........6: 1%
> > (1000/100000)<CR>
> > # Working hard.......2.........3.........4.........5.........6: Z
> > # 10% (10000/100000)<CR>
> > # 100% (100000/100000)<CR>
> > # 100% (100000/100000), done.
> > # EOF
> > #
> > # cat >in <<-\EOF &&
> > # progress 100
> > # progress 1000
> > # progress 10000
> > # progress 100000
> > # EOF
> > # test-tool progress --total=3D100000 \
> > # "Working hard.......2.........3.........4.........5.........6" \
> > # <in 2>stderr &&
> > #
> > # show_cr <stderr >out &&
> > # test_cmp expect out
> > #
> > ```
> >
> > * What's different between what you expected and what actually happened=
?
> >
> > It seems that the progress display is not working normally.
> >
> > * Anything else you want to add:
> >
> > I am thinking:
> > 1. Is this bug caused by my own patches?
> > So I switched to other branches, including upstream/master, see the bug=
 too.
> > 2. Is this bug caused by zsh?
> > So I switched to bash, and saw the bug too.
> > 3. Does this bug only appear on my Arch-Linux?
> > So I asked my classmates (who use arch linux too) to download git/git
> > from github and perform the test, see the bug too.
> > 4. Does Ubuntu also have this bug?
> > No. In the case of using Ubuntu's docker and Centos's virtual machine,
> > after cloning git/git from github, they actually passed the test!!!
> >
> > So what's wrong with Arch-Linux?
>
> I noticed there's already a thread about this problem here:
> https://lore.kernel.org/git/49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint=
.net/
>
> This seems to be a bug with a recent bash, and a fix was suggested there.
>

Okay, it seems I need to have a related discussion here.

> > * [System Info]
> >
> > ```
> > git version:
> > git version 2.32.0
> > cpu: x86_64
> > no commit associated with this build
> > sizeof-long: 8
> > sizeof-size_t: 8
> > shell-path: /bin/sh
> > uname: Linux 5.12.15-arch1-1 #1 SMP PREEMPT Wed, 07 Jul 2021 23:35:29
> > +0000 x86_64
> > compiler info: gnuc: 11.1
> > libc info: glibc: 2.33
> > $SHELL (typically, interactive shell): /bin/zsh
> > ```
> >
> > * [Enabled Hooks]
> >
> > None.
> >
> > [...]
>
> ---
> Atharva Raykar
> =E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=
=E0=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
> =E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=
=E0=A4=95=E0=A4=B0
>

Thanks, it's helpful!
--
ZheNing Hu
