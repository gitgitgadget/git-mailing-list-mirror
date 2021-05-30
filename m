Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B611C4708C
	for <git@archiver.kernel.org>; Sun, 30 May 2021 05:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98FA60FDB
	for <git@archiver.kernel.org>; Sun, 30 May 2021 05:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhE3Fj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 01:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhE3Fj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 01:39:29 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74606C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 22:37:50 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id u3so7120663ilv.8
        for <git@vger.kernel.org>; Sat, 29 May 2021 22:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WGI1OqlNfLfx5wXypi4HXoxQ+B1ZKX4Ev824teYApD8=;
        b=nPRjKHE1l+gLBpEtSFee/81KFd0mt/AjOxMq42TU99WlLXNr6OFI7xSyf/5JH2zzAq
         1rsx3BR9ayzjNF6YHNlJdHcvaygYuWZ1pi5dvB1/Hmsnap72Z1ku+uBGmcg7xK0VvYQN
         6xa6qd5PysQj0anunb6AjChVXKzHwa9cyoRkStFT7tSS7GgE294c38xH9uRp9fij61IP
         VwzFFHmzUwMkowZB/+LZvvLkL6nI0akp8WvuJyUJkskFfPHlvjXUoywygDPVrianwD2F
         FGQuDrYpTlN4bKHnBWyVR+HSJJAUyRsOaDyPiaiRj5r5OZSEhBE4qoMiFWEr0DOcoV4a
         Pn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WGI1OqlNfLfx5wXypi4HXoxQ+B1ZKX4Ev824teYApD8=;
        b=NMCW9wBKlk4jwTPhC47HHeNNjP6s1aLpTriaQwOMw4utUxpSkmX8RN8JSNwcoU8Prf
         KpGV6pxaNpINHkltQSD0EzxHfPWte98CB1e2IcjvIu/vmo1GZU755xdH8WuANBo/8dWD
         dlYunCzff4X845l9U0lmtQ11e9IeC8F8FA+xZLN90jDiOaQf2DPBg6/ls8djH/vM5owZ
         0LbE0/klqcSgziH8Vxsu6qmuTGPXVzqWuA7gmWHavtO5cUzyngZMxX0QpVdlptoR6+aN
         c4T+JOkFiKuvCsRM4BhX4yqwwduPxQo9Va3qmjA+TKjhTtTbFeMnnvGzXLg1AkA29fjI
         zbWg==
X-Gm-Message-State: AOAM533bOh8Z4mYXIitou6+TVkT9bN7AXwbxaeX8FGi0v+shoJv3A9ct
        9XAVjVZVaLHAiE6JoNpc1UqQakC3dY5KNCohX0o=
X-Google-Smtp-Source: ABdhPJy2M3k5t/UQGpQVan+ahuFSQJz/TIvYNW1RVhTmkJ+Dk7DSiko5kAyBfb0acY0lzyo27jwJj6eQkHTfL+exKc4=
X-Received: by 2002:a05:6e02:12c9:: with SMTP id i9mr178822ilm.17.1622353069631;
 Sat, 29 May 2021 22:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
 <60afca827a28f_265302085b@natae.notmuch> <CAOLTT8RbVsZuAwUZ-yn_Wwnvq7qyziA=4z=skMoGdPCTdQ5KPw@mail.gmail.com>
 <60b11a8e323ce_4b032208ad@natae.notmuch>
In-Reply-To: <60b11a8e323ce_4b032208ad@natae.notmuch>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 30 May 2021 13:37:37 +0800
Message-ID: <CAOLTT8Txkb59X33YAmx-TmR=c42Y0=fbmuugaTkK1_GDyEdMMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=
=8829=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:30=E5=86=99=E9=81=93=
=EF=BC=9A
>
> ZheNing Hu wrote:
> > Sorry for the weird, unclean `memcasecmp()`, I referred to memcmp()
> > in glibc before, and then I was afraid that my writing was not standard
> > enough like "UCHAR_MAX <=3D INT_MAX", I can't consider such an
> > extreme situation. So I copied it directly from gnulib:
> > https://github.com/gagern/gnulib/blob/master/lib/memcasecmp.c
>
> Yeah, I imagined you copied it from somewhere, but when you do that you
> need to transform the code to the style of the project. I've seen GNU
> code, and in my opinion it's too verbose and redundant. Not a good
> style.
>
> But more importantly: at the header of that file you can see the license
> is GPLv3, that's incompatible with the license of this project, which is
> GPLv2 only (see the note in COPYING).
>
> You can't just copy code like that. You need to be careful.
>

Now I notice the importance of license in open source project.

> And if you do copy code--even if allowed by the license--it's something
> that should be mentioned in the commit message, preferably with a link
> to the original, that way if there's trouble in the future with that
> code, we can follow the link and figure out why it was done that way.
>
> Also, it's just nice to give attribution to the people that wrote the
> original code.
>

Ok.

> > > Check the following resource for a detailed explanation of why my
> > > modified version is considered good taste:
> > >
> > > https://github.com/felipec/linked-list-good-taste
> >
> > OK. I will gradually standardize my code style.
>
> It is not a standard, it is my personal opinion, which is shared by
> Linus Torvalds, and I presume other members of the Git project.
>
> The style is not something that can be standardized, you get a feeling
> of it as you read more code of the project, write, and then receive
> feedback on what you write.
>

Yes it is. Reading and writing Git code has brought me a certain degree
of code style improvement. (this is indeed a kind of edification :) )

> It's like learning the slang of a new city; it takes a while.
>

Thanks for your guidance.

> Cheers.
>
> --
> Felipe Contreras

Thanks!
--
ZheNing Hu
