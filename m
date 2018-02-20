Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D58E1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 20:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeBTUkF (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 15:40:05 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:43570 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeBTUkE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 15:40:04 -0500
Received: by mail-yw0-f170.google.com with SMTP id p70so2984419ywg.10
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 12:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C8tDBl3PESS7kQlIeQJEf036ajNB7XrrRiIZ54tws2o=;
        b=h6bYItOKfTtHXWWXS8bSRX9lO8gk5GEFeYOjJEN2S8CHxY+V/5mxEkc/CYf4hMbFJp
         Ido8MwWe7vtTDWpzfUfrwIsrXzJ6vEkONANISRqugrdOst8fagvQCVTHxfHHdf3pPjUV
         hfUdZ4dUpVLfWyhNvchFuow/6o13FYYiBi0rif5MDZYqEEQZWtLsS9QaYT15Q8gdNwMd
         P3pdxbjMmySQyYH1e0CdSF9B1F/00wfB4rO0p7BKaYsnfqh6QS34wiyfPMjTO7Iw8cVa
         jXMQk69d78f65zy5ac0K5bXMpOK3+YbR1me8vaC5FZnnc9MJ20PGZswLw1cb7+/chTF0
         YW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C8tDBl3PESS7kQlIeQJEf036ajNB7XrrRiIZ54tws2o=;
        b=qlk3Q4ETEFRuAZRpawDFJsAKkKN1qbZkz2991Bg4CcL1sF3gVu3cCr6kvSYpSGMnqq
         iidJJG78GkTjANGfcWXxH1vPwHIHjx98mI8fb/bpEp70NSwSJgXCwAKCSQS3F5F7dHDe
         7ADpiiDVwBqBa0j+f+30xs9uQSLymRkM5tIz7v1FdLp7YqVbQOMw+/6hopK2yeuSPwrl
         pGYOj2A9f37dsLwrjSB6z7sMHg2Dfwi1jt1yzp3ghIkTRA0WQnpj7SqcYgCX1N2VYmrN
         014Ht4fhY55JcnL2lk55ZKN+CyvvMe1W/LqoxvEAVE3fdcoZfWF/hKyUacydhjjLLQUe
         ob3w==
X-Gm-Message-State: APf1xPCSD2YQ1Iw2RwQi7AD7KQ8OIjepn7Fq5G2VI/X0Ndg5sDs7XzWl
        OJ+Dj+tqQ2qiXtUIngWqhffwAHK1ReDbAiDqHPIeww==
X-Google-Smtp-Source: AH8x227bjM5TSFfw2ieMEqKMDXySOSOydqoeYaYo18EY8orZDSPxcz6StRJQWmxkDBI2yORCb8AO7ZXusBnRE+FjIxY=
X-Received: by 10.129.169.202 with SMTP id g193mr752651ywh.500.1519159203145;
 Tue, 20 Feb 2018 12:40:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 20 Feb 2018 12:40:02
 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1802201709570.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1802201709570.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Feb 2018 12:40:02 -0800
Message-ID: <CAGZ79kZXtE84nfO_nx+H61+2B9SU7ASD4r4JozwV=8HZ050SCA@mail.gmail.com>
Subject: Re: File locking issues with fetching submodules in parallel
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 8:20 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan (and other submodule wizards),
>
> Igor Melnichenko reported a submodule problem in a Git for Windows ticket:
>
>         https://github.com/git-for-windows/git/issues/1469
>

Thanks for bringing this up. Is it better to discuss it here on at that issue?

> Part of it is due to Windows' behavior where you cannot read the same file
> in one process while you write it in another process.
>
> The other part is how our submodule code works in parallel. In particular,
> we seem to write the `.git` file maybe even every time a submodule is
> fetched, unconditionally, not even testing whether the .git file is
> already there and contains the correct contents?

only when they need to be newly cloned (as that is when the
submodule--helper clone is invoked). When fetching, we'd not touch
the '.git' file IIRC.

> For some reason, the bug reporter saw a "Permission denied" on the `.git`
> file when we try to write it (and I am pretty certain that I tracked it
> down correctly to the `connect_work_tree_and_git_dir()` function). The
> intermittent "Permission denied" error seems to suggest that *another*
> process is accessing this file while we are writing it.

The reporter also reports this coming out of "git submodule add",
which is not parallelized, but rather in the messy state of migrating
as much code into C from shell, trying to not introduce to many bugs. ;)

So for add there is no parallelism I am aware of, which makes me wonder
how the race is coming in there.

I recall making the decision to unconditionally write out the '.git' file
for other operations like "git reset --hard --recurse-submodules" or
"git checkout --force --recurse-submodules", as there you are really asking
for a clean slate. I missed the Windows FS semantics for that case,
so I guess re-reading the file to make sure it is already correct would
avoid issues on Windows there. (though I do not yet recall how the
parallel stuff would bite us there, as the file is written as the very
first thing)

> It also seems that this problem becomes worse if the firewall is turned
> on, in which case a couple of network operations become a little slower
> (which I could imagine to be the factor making the problems more likely).
>
> A plausible workaround would be to write the `.git` file only when needed
> (which also would fix a bug on macOS/Linux, although the window is
> substantially smaller: the reader could potentially read a
> partially-written file).
>
> But maybe we are simply holding onto an open handle to the `.git` file too
> long?

That could very well be the case.

> I tried to put together a bit more information here:
>
> https://github.com/git-for-windows/git/issues/1469#issuecomment-366932746

Thanks!

> Do you think there is an easy solution for this? You're much deeper in the
> submodule code than I ever want to be...

I'll take a look for open handles, though we're already using our
wrapper functions
like 'write_file', which is supposed to close the handle gracefully (and has
undergone testing on Windows a lot as it is the standard write function)

Thanks,
Stefan
