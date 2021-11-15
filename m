Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58ADC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 01:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C392861104
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 01:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352732AbhKPB1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 20:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243685AbhKOTCY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:02:24 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F0FC0F26C0
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 09:56:49 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b13so15164814plg.2
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 09:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5Cpq5Q/eB/+YYqzE0RaD8rYw9b38AiqfQ1wtHQeypo=;
        b=lWy4zcerBdIWjHK9UTikErxnPviRU1WW21Gc/rgFJEmao/NdXAyjcncQrn3dvkKtoY
         6vKsQt+s5hpuIZM8vbtFROhmjl+k0xnVXsPr28+wzla7OlKV20gcDOaydqKxyjNAwqs2
         6rfvOT1w6jWqI4uJH/sf9GoyIy0t/trxN1czsnoKlpnTFrJr0T0QMPmDMmZXh8Z2JEeN
         SmLY+IPH1f2S+3UV1KudaDCfl1vPPpY6I9nIQ/rPqFXWmaKRRtxXQJfnhps/PM2q4PSH
         7FlfloSur8YOPYTATWm+cs9IYxuO+WeHX2HSX2dsDUEqCFoqT9H2ZpReQcxgmO1TnzJf
         HHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5Cpq5Q/eB/+YYqzE0RaD8rYw9b38AiqfQ1wtHQeypo=;
        b=ag26r/SC8RMVU+PZZW2D1ySB+0+4xEbv/vdTZd2xiomcZAgSNtbkNQ76DK5l1PNrLv
         Mj8vvT81hSL876qsynhB+m/Np1XCw7WmPbqlA11WHyo/4xaV8Uy5US4nG/BF6NuPU0rd
         aR7H5UWDY/eLcq5wLs9meIS8lTiUC4ab7aIhsoRLS5a8zg4o8VIz7g6nIKA8Vk+0I+7H
         +6kwhtdnLTAm9hV/+sSqhHkUz6qaOX4KUa2Skmp1zIHxcrAC62DG+PsbE5AVFniXuVgs
         yn5uQAVH/nO9lnoWU7j879ojhrzAZcmub1g7E6TiB6/oXurEySOwwnn75X2RP5vEbnUr
         QOBg==
X-Gm-Message-State: AOAM530EibBMm4F/KGeB07GUqEQHEWuHJIRQdlVbKFakvdPYKOJQSbqh
        pl2CAGnQkK888GBFBF4scEcy7hP9G4FenKaUU4CSwPjHCWw=
X-Google-Smtp-Source: ABdhPJxtKpevUeg7VXdFV36fZF0nhqiAAe0+luwzsHvS8vqnZK+sPiptLvBYjpguSKD21d+zA6lN20FFDw47U9gJR9w=
X-Received: by 2002:a17:902:bf4b:b0:143:aa96:f608 with SMTP id
 u11-20020a170902bf4b00b00143aa96f608mr31688646pls.23.1636999008365; Mon, 15
 Nov 2021 09:56:48 -0800 (PST)
MIME-Version: 1.0
References: <CADL96rvRX2R_4Wm23tz88hDUztcpK531RU+Ops2UVoiOW0bCHw@mail.gmail.com>
In-Reply-To: <CADL96rvRX2R_4Wm23tz88hDUztcpK531RU+Ops2UVoiOW0bCHw@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 15 Nov 2021 09:56:37 -0800
Message-ID: <CAGyf7-H5icSmOQ1eDx9RXDTwFcB2y9sgUxNNTF7V7Xu1MfHTEA@mail.gmail.com>
Subject: Re: git pull bug report
To:     Erwin Villejo <erwinvillejo@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 12:42 AM Erwin Villejo <erwinvillejo@gmail.com> wrote:
>
> > What did you do before the bug happened? (Steps to reproduce your issue)
> * make local changes, stage, and commit
> * local is ahead of upstream. confirmed by `git status`:
>
> ```
> $ git status
> On branch main
> Your branch is ahead of 'github/main' by 1 commit.
>   (use "git push" to publish your local commits)
> ```
>
> * try to pull upstream to local
>
> > What did you expect to happen? (Expected behavior)
> No-op (and NO failure) since local is ahead of upstream.
>
> > What happened instead? (Actual behavior)
> `git pull` fails with error:
>
> ```
> $ git pull
> hint: You have divergent branches and need to specify how to reconcile them.
> hint: You can do so by running one of the following commands sometime before
> hint: your next pull:
> hint:
> hint:   git config pull.rebase false  # merge (the default strategy)
> hint:   git config pull.rebase true   # rebase
> hint:   git config pull.ff only       # fast-forward only
> hint:
> hint: You can replace "git config" with "git config --global" to set a default
> hint: preference for all repositories. You can also pass --rebase, --no-rebase,
> hint: or --ff-only on the command line to override the configured default per
> hint: invocation.
> fatal: Need to specify how to reconcile divergent branches.
> ```
>
> > What's different between what you expected and what actually happened?
> I expected no failure and no-op since local is ahead of upstream.
> Instead, `git pull`
> fails because it thinks the branches have diverged.

You're making a logical, but still incorrect, assumption about what
the "git status" output means. "git status" does NOT actually check
the remote server.

When you pull, there are typically 3 refs that are involved, not 2.
(Given it appears you're on "main", I'll use that name below.)
refs/heads/main: This is the local branch you're working on
refs/remotes/github/main: This is your _local copy_ of what the
_remote_ branch was pointed at the last time you fetched or pulled
successfully
refs/heads/main on Github: This is the remote branch you're trying to push to

When you run "git status", it is NOT talking to Github; it's simply
comparing the state of your "refs/heads/main" and
"refs/remotes/github/main" branches.

When you run "git pull", it's actually talking to Github, which allows
it to find out about commits that are present remotely but have not
been fetched to your "refs/heads/main" or "refs/remotes/github/main"
branches.

If you run "git fetch", rather than "git pull", that will update your
local "refs/remotes/github/main" branch without trying to also update
"refs/heads/main". If you then run "git status", it will tell you your
"main" branch has diverged, just like "git pull" does, instead of
showing it as ahead.

Hope this helps,
Bryan

>
> > Anything else you want to add:
> I found this bug in VSCode. VSCode runs `git pull` first before `git
> push` when pushing to upstream.
> This bug causes pushing via VSCode to always fail, although it can be
> worked around by simply opening
> a terminal and running `git push` manually.
>
> [System Info]
> git version:
> git version 2.33.1
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.15.2-arch1-1 #1 SMP PREEMPT Fri, 12 Nov 2021 19:22:10
> +0000 x86_64
> compiler info: gnuc: 11.1
> libc info: glibc: 2.33
> $SHELL (typically, interactive shell): /bin/bash
>
>
> [Enabled Hooks]
>
> Best regards,
> Erwin
