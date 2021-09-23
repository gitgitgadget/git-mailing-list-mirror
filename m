Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C83C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 06:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7FA6109E
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 06:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbhIWGW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 02:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbhIWGW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 02:22:26 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1D5C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 23:20:55 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 3so2156273vkg.7
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 23:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFnmNIdvljVwNVkK+p+oh5qLx87/lO+HhZnpylnU0aA=;
        b=pRgb7Cljo/PfUlJ+AGiqTaRuw6wkR55CjRU4uXxYuvL4aAk4trcnl1UMBswWZYnTuM
         h11scHqlruvmWEYmWpsPhdGIA21aznj42oYfDHuTmWqOc7W0CBDwerCCTgp5yU5vMvNK
         s2mKiioz7ocbY8URpVUdp5RB8mSPPzHKdKRgUTxUWzXYExxyyk4kC777LHZuVIM+tJkA
         JLWmB4S+rywaQOENWblgfEnztVSWNvy/RzxmcR6VEzCBvnB39Vu7abdC4k94eVc/KEUI
         7t2Sgl2J428QQh07Z2CUOXhhSRz07xssqP6ByBq19fSDxPsPK/1ADcz9+eDCRs/8F8hA
         RM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFnmNIdvljVwNVkK+p+oh5qLx87/lO+HhZnpylnU0aA=;
        b=Hn5qmfwuS7QX98YYjOx9XwMsyh6pR5sgS+v61PvuEF9KYinghgohOHajcN1HB+qw74
         B/TTcZGrDNYo0H1KQfqkadXUXY+RL+uOzM+cmYUUntIfEQ60+pIthw4b8rUCpP1tTZNw
         BUutJ2GnG0mMj8Kf+NrCuNI+IE7vbHOIracbYBtvFufe0aR7F/nzmJ11zzXiDGaHf4GB
         DEZy/ndol2hdD8GpKr9ZLgX3UhRP/RqG+8HwtsABJZ05xs0S81T/w+v9R521NtKcLZFy
         DYQnGT1lIq4KAJwCxmb4TOhh5aMflOsA87YLz7Kdry0szaRy3jBAmS65ZpY0h+Lm0i9x
         Js1A==
X-Gm-Message-State: AOAM5323+t0OcuWPdT1gLe/hx7SsNwNTt/UwIiN0aLXTPK9TuvyIXsFV
        1SGaVpFrOzKc2w7FvUvx+Hj4k7Tbv2LXivlMUTjm+RFg9zc=
X-Google-Smtp-Source: ABdhPJy23h74sLX1FeDS0+HztSa2tEuyAamuSiIiU6eysxrchunUwNWMshFwkmYjbCDmftlVD+HMpLytDdXkv5p63Pw=
X-Received: by 2002:a1f:c9c1:: with SMTP id z184mr2051236vkf.7.1632378054827;
 Wed, 22 Sep 2021 23:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <4381472f-a9db-b8a7-a395-81c3935309ae@kdbg.org>
 <CAPUEspguHsx+BtViT5tO3eyZSJf7mJ0of-K3vAMqB0-ju4fpsg@mail.gmail.com> <2793c9c0-57ee-c7e0-957c-01d9aa27b44b@kdbg.org>
In-Reply-To: <2793c9c0-57ee-c7e0-957c-01d9aa27b44b@kdbg.org>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 22 Sep 2021 23:20:43 -0700
Message-ID: <CAPUEspjaKUxq4_kptMC305Rkc7mEUEY_JGTxrRTiTaw5km87oQ@mail.gmail.com>
Subject: Re: [PATCH cb/pedantic-build-for-developers] lazyload.h: fix warnings
 about mismatching function pointer types
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 2:21 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 22.09.21 um 22:16 schrieb Carlo Arenas:
> > On Wed, Sep 22, 2021 at 12:56 PM Johannes Sixt <j6t@kdbg.org> wrote:
> >>
> >> Here, GCC warns about every use of the INIT_PROC_ADDR macro, for example:
> >>
> >> In file included from compat/mingw.c:8:
> >> compat/mingw.c: In function 'mingw_strftime':
> >> compat/win32/lazyload.h:38:12: warning: assignment to
> >>    'size_t (*)(char *, size_t,  const char *, const struct tm *)'
> >>    {aka 'long long unsigned int (*)(char *, long long unsigned int,
> >>       const char *, const struct tm *)'} from incompatible pointer type
> >>    'FARPROC' {aka 'long long int (*)()'} [-Wincompatible-pointer-types]
> >>    38 |  (function = get_proc_addr(&proc_addr_##function))
> >>       |            ^
> >> compat/mingw.c:1014:6: note: in expansion of macro 'INIT_PROC_ADDR'
> >>  1014 |  if (INIT_PROC_ADDR(strftime))
> >>       |      ^~~~~~~~~~~~~~
> >
> > did you have CFLAGS adding -Wincompatible-pointer-types explicitly?
>
> I don't know of the top of my head (am not at that Windows box right
> now). I am fairly certain that I do not have DEVELOPER set.

the config.mak.uname for MinGW sets that for you.

> > This is the reason why the code that got merged to master had -Wno
> > for this case.
> >
> >> (message wrapper for convenience). Insert a cast to keep the compiler
> >> happy. A cast is fine in these cases because they are generic function
> >> pointer values that have been looked up in a DLL.
> >
> > I have a more complete "fix" which I got stuck testing GGG[1]; you are likely
> > going to also hit -Wcast-function-type otherwise.

Sadly, as predicted your fix, broke the build [1], so submitted[2] and
adaptation
of the original fix on top of yours with the rest of the code that
will be needed
so it can be added in top of js/win-lazyload-buildfix and merged into "seen" to
fix that.

> I think that the correct solution is that get_proc_addr() returns void*,
> not FARPROC. Then either no cast is needed (because void* can be
> converted to function pointer type implicitly) or a cast is needed and
> that is then not between incompatible function pointer types and should
> not trigger -Wcast-function-type, theoretically.

The reasons behind why won't work are fairly academic IMHO, but there is
an obvious clash between POSIX and C specs here and "pedantic" just
reflects that.

Note that the return type for GetProcAddress[3] is FARPROC, and the C
standard says that any function pointer can be assigned to any other so
your code should work, but gcc has no way to know that FARPROC is not
the "real" function type and therefore warns that you might crash if using it.

Carlo

[1] https://github.com/git/git/runs/3680695336
[2] https://lore.kernel.org/git/20210923060306.21073-1-carenas@gmail.com/
[3] https://docs.microsoft.com/en-us/windows/win32/api/libloaderapi/nf-libloaderapi-getprocaddress
