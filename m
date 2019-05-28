Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084D91F462
	for <e@80x24.org>; Tue, 28 May 2019 19:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfE1T40 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 15:56:26 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:40266 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfE1T4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 15:56:25 -0400
Received: by mail-it1-f170.google.com with SMTP id h11so5957475itf.5
        for <git@vger.kernel.org>; Tue, 28 May 2019 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAl9DvZUn+8yDSY6uBG3rzF5QSazgpr7rMvym7vMchc=;
        b=CkQOjhZlYFHNdmJWkYx3sMLioudwkiyo6k8njk+4D3TEC5GibOhIlVsqENjT5xRx4x
         XjndYhTeGiVHYtzMJuLlPM4kKVeh/eCn3KviJPVR90y/AxNPfCRVAfCgdi1OLcL7ZAM6
         Ju0ckxaDbzpK8QusmiVDkdSWWRxOc0iP/kyTvLOXkTu0Wn/+D56W48jLub9D/cvEl9Qc
         CyBPYhevrGK49oNiSkA8+wnyYOK8ttlcre8HuZLI7B1hSczfDmUtgoHmMWL2OWkwtioe
         FFPfPMOU1QAy+aJ2keCHKg4CHSLH5lzBF90naDSCC3Cj8pk89DA+NcowxcuwAlSH5hQg
         S+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAl9DvZUn+8yDSY6uBG3rzF5QSazgpr7rMvym7vMchc=;
        b=ToTxPzs6pX4rx3YJsLWAdQt7tduxAKSHu4PkUYR9+KJ7ilefduCVHQiMNeUw6tYdya
         HcAd2lmhHesnUt9nO6h1PvWQX1Nt/a2Wc+mWb/M+vl1BlyBMObu+9b6wMzRs21OkREZ5
         jd5SBDNX+IBHvfox+NDBuqNRxov/HMB0LqIutlpIbV3M3UaQar5aLtQRF9D2qbFbAgYs
         +1bbPmy1uPRIHONkjj6I1mStOXKXqQUVlcaYnOTXzKZx/7EE7jJsbRnTZ/u3tX5N1YSv
         lZVXJzotOSXeGZtLZbDWjnaNc79vf97W4+WDgjmFdaw+2t2Zdh74lBqs4+Jjp7GKZiZM
         tPGg==
X-Gm-Message-State: APjAAAXfQx87pUwqg6ZESqCkf8ICONBfVdvs/8r0xPtsWV3n3XMlvcZs
        xxw4H7mGxdgbepNSYGw/NozzokGogCJqYI0UJkY=
X-Google-Smtp-Source: APXvYqz4anQWAZ08N0E5z30RH3UIFK3kL/l4SS9Az7HfbWeT5ygiViWRgaNnyeqJBpQGgjdxDWV2ccN9mXJncPXJQmU=
X-Received: by 2002:a02:cb4b:: with SMTP id k11mr5742601jap.109.1559073384812;
 Tue, 28 May 2019 12:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkfZL2p8yFr3ecsQ63HzeZ+u-Jukf7YcYHk_8iBaKcA4WbEfg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905272046250.47@tvgsbejvaqbjf.bet> <20190528063451.GG7946@sigill.intra.peff.net>
In-Reply-To: <20190528063451.GG7946@sigill.intra.peff.net>
From:   Brendan Boerner <bboerner.biz@gmail.com>
Date:   Tue, 28 May 2019 14:56:13 -0500
Message-ID: <CAKkfZL30QuBM6vT69OSS_keNuGi1U-bJ+jDiyDfhZmnr9L9xvA@mail.gmail.com>
Subject: Re: 'git stash list' => Segmentation fault
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, providing the repo isn't an option.

Thanks for the suggestions, here's what I can provide. Unfortunately
not a lot in the stack trace.

Do you need the whole repo or would bits of it suffice e.g. index?

bboerner@myhost:~/funproject/Src$ GIT_TRACE=1 git stash list
14:52:22.633388 git.c:670               trace: exec: git-stash list
14:52:22.633448 run-command.c:643       trace: run_command: git-stash list
Segmentation fault (core dumped)
Segmentation fault (core dumped)
Segmentation fault (core dumped)
14:52:24.904494 git.c:419               trace: built-in: git rev-parse --git-dir
14:52:24.944879 git.c:419               trace: built-in: git rev-parse
--git-path objects
14:52:24.949126 git.c:419               trace: built-in: git rev-parse
--show-prefix
14:52:24.951414 git.c:419               trace: built-in: git rev-parse
--show-toplevel
14:52:24.953447 git.c:419               trace: built-in: git rev-parse
--git-path index
14:52:24.955670 git.c:419               trace: built-in: git config
--get-colorbool color.interactive
14:52:24.957435 git.c:419               trace: built-in: git config
--get-color color.interactive.help 'red bold'
14:52:24.958753 git.c:419               trace: built-in: git config
--get-color  reset
14:52:24.960461 git.c:419               trace: built-in: git rev-parse
--verify --quiet refs/stash
14:52:25.040053 git.c:419               trace: built-in: git log
'--format=%gd: %gs' -g --first-parent -m refs/stash --
14:52:26.436274 run-command.c:643       trace: run_command: unset
GIT_PAGER_IN_USE; LESS=FRX LV=-c less
stash@{0}: On devel: NYFL optimization
stash@{1}: On GL285: gl285


(gdb) bt
#0  0x00007fd321805fdf in ?? ()
#1  0x0000000000000000 in ?? ()

Regards,
Brendan

On Tue, May 28, 2019 at 1:34 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, May 27, 2019 at 08:47:56PM +0200, Johannes Schindelin wrote:
>
> > > bboerner@myhost:~/funproject/Src/bash$ git stash list
> > > Segmentation fault (core dumped)
> > > Segmentation fault (core dumped)
> > > Segmentation fault (core dumped)
> > > stash@{0}: On devel: NYFL optimization
> > > stash@{1}: On GL285: gl285
> >
> > Unfortunately, this leaves *very* little in the way of actionable
> > evidence. Would it be possible for you to share a tar'red up copy of the
> > .git/ directory? Or do you find that this happens for all of your stashes?
> > What is the output when you run this with `GIT_TRACE=1`?
>
> Alternatively, if you cannot share the repo, a backtrace from gdb might
> help. There should be a core file either in the working directory, or in
> the ".git/" directory. Try "gdb git /path/to/core" and then "bt" to get
> the backtrace.
>
> -Peff
