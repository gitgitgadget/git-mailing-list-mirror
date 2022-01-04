Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16D1C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 20:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiADUEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 15:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiADUEy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 15:04:54 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB595C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 12:04:53 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r5so33632895pgi.6
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 12:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYVne00/Ma7OdF+CLnU4kBtt2b5n0kfammxWLpaiE4A=;
        b=Dg+wYxvrvWsqUqb3LjsZxOKKbHUuk+83FbhCdRpgKxuU18yJGEM+/FDkAfCh5u4dIA
         iLoF1mvY7xqZRmHTglqR8Ld4b6gqm8e8QWMuJeJaNGcXw2f5lFK/bAUKv07iWyg6pIHp
         Q7G8sfntUs9poGFF6ZyHFfAJACev6FfhoT/jORnajmV+9oFflTEiRQTAzgzZuRNfM4cg
         j8R3cd6cGqePRy16Je+rnEj1+ma+VoDbXSpLpZeOJsSK5J4EgKOXAFSoTgscKy+Rcv2M
         kYIM+PhVmMg6O3Cj5Muv4D6mWy2UdvsqI8iIc5dGQdBoGOiV8dq4iAZk9yh78SZtpESS
         n3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYVne00/Ma7OdF+CLnU4kBtt2b5n0kfammxWLpaiE4A=;
        b=htPaEPxICG0UjXYZdO1syGTGPrKsT2bFGGVVKHAMeGdB+fv2K50voYD1KPVU0DouUm
         6NmJTThRanWZ28p522WdN9dm4WbwnLJtxLlYKBQgvEiEMBiV7nn6S3cq8duB4N7/V9zO
         P8pYAhfMEG0B8ICxGLCXPKBtceDmdDzAhhz/JxwfWP6O9mhA5lBbDucA46NS43FICr1n
         fbDYpNFqPy/K+nsgBDmZlG6NV34McjduFMFDU7o26tMKxamJ5hQaQmJ5Yx8VxBJWD1FJ
         /j/xcBmJfm5d366Tw8tbi0hJ/iUlwIYV9i1lqQZP+sS0vwRwJH4+QFFeIAx8mtw3bcUd
         rTkQ==
X-Gm-Message-State: AOAM531ZSCZbYmXT5PrlY8R8hBKn38/Z1FBOYGkgRbcfKjhw3lDUjxhf
        7FgyLLJb/wlua1SK7KMLOjVsI8jCwCfeLz0H7TlDxyT2FOo=
X-Google-Smtp-Source: ABdhPJxSA2tEgtqgdqE6Ty8KmPhCS+0IY4/OUNGSGr0cCCd0tMh16+4e5HTc5I1ihDdR9BE5WWg2zSEZevS+lDKeNP4=
X-Received: by 2002:a63:9242:: with SMTP id s2mr17931983pgn.316.1641326693249;
 Tue, 04 Jan 2022 12:04:53 -0800 (PST)
MIME-Version: 1.0
References: <CA+kUOak9_RLpdr9d4pQiwU=K42taCwhMdg5WkLP4GreQd4yWig@mail.gmail.com>
In-Reply-To: <CA+kUOak9_RLpdr9d4pQiwU=K42taCwhMdg5WkLP4GreQd4yWig@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 4 Jan 2022 12:04:41 -0800
Message-ID: <CAGyf7-HSia4pRs4FZ107v0jmP4k4Zfw5zJ-3Oz8UvF9oobczEw@mail.gmail.com>
Subject: Re: Bug using `fetch` with blank `-c` arguments to git
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 4, 2022 at 4:37 AM Adam Dinwoodie <adam@dinwoodie.org> wrote:
>
> While investigating some issues with a different project, I discovered
> the command `git -c config.helper= fetch` was working with the Debian
> stable version of Git (v2.30.2) but not with my local build
> (v2.34.1.428.gdcc0cd074f).

Since you're working with a locally-built Git, have you, by chance,
actually _installed_ that build, or is it simply in the Git repository
itself after running make?

If you haven't _installed_ your build, my guess is you might be
getting a mismatch wherein your _built_ Git, when it forks out
subprocesses, is triggering your _installed_ Git (which I assume you
have, and which I assume is not 2.34.1). Git compiles paths into
itself to know where to find certain binaries, and if you run a
compiled-but-not-installed Git then those paths are "wrong". (I see
administrators do this fairly often when building Git from source to
set up Bitbucket Server.)

What does `./git --exec-path` print, when you run your 2.34.1 binary?
And is that where, for example, the compiled 2.34.1 versions of things
like `git-remote-https` are?

Hope this helps,
Bryan

>
> Specifically, I see the following output:
>
> $ ./git -c credential.helper= fetch
> error: bogus format in GIT_CONFIG_PARAMETERS
> fatal: unable to parse command-line config
>
> Investigating with `git bisect`, the change in behaviour seems to have
> been introduced in 1ff21c05ba ("config: store "git -c" variables using
> more robust format", 2021-01-12).
>
> I see the same behaviour with `-c config.helper=`, `-c
> core.autocrlf=`, `-c core.autocrlf` and `-c core.autocrlf=true`..
> Notably the behaviour does not affect all other git commands; `git -c
> core.autocrlf= log -1` works as expected.
>
> I think this is a regression; I can't see any reason why these
> commands shouldn't work.
>
> Curiously, I'm seeing this behaviour on both my Raspberry Pi OS and
> Debian Bullseye systems, but not my Cygwin systems. I've not yet tried
> to work out what the difference is there. In all cases, I was testing
> with my own build, built with `make -j<num> configure && ./configure
> --prefix=$HOME/.local && make -j<num>`.
