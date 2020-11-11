Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163DFC4742C
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF6C20786
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgKKHLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:11:05 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33823 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKKHLE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 02:11:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id a15so1200645edy.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 23:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCF4KVFN1NpT0JwjnSqjzcFeGvcgoHW/iqAmElQA2NQ=;
        b=WE52vPUp3bh8vHLUMCCpcItcejUlRl1un8OD5lLONzx8OJMILRTlxb6oD1pU3ZinmG
         w2Rv/thk7nyvDW2+4TBnIWiFCk15cuPwAewTpCB9vegHY0vfAfXGZ5ARZl+r+GU7Su7l
         2yy/mwatukxeqgqC5Q/q/XpKkHuZceFngaVKLyMmH2lfhWA1UsAW9cZMEJy7M6/8bakr
         zMGHAgihhNeBJ87mw9exr5x89AJk/j7GNxCD/Pf0KBbov20iEAmtdOYGliI4oMaj2eiC
         X7pSAvmDUgEO6z7uMbcQTfw7n/KiX+8nCE8JgXpe2alzSbLmaytgN34QVH+DIm++e4qb
         3keA==
X-Gm-Message-State: AOAM533tWffbgqsnIqcT5se8TKZL7B7iRHXzg5DYo+/VtcbzDhR5v1cA
        yHTD0U0pdWgpPORVrtErwgQ3dUWe/TmkxEuUTdw=
X-Google-Smtp-Source: ABdhPJwPKdUVQNjOrPuav6Q54eBUCadAabaYPAsvfWR0jLI/TU/MGuytyLJpzteGjS0jZcy+UOwnODUePZXQtJ1Tcu8=
X-Received: by 2002:a05:6402:206:: with SMTP id t6mr3389827edv.291.1605078662065;
 Tue, 10 Nov 2020 23:11:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
 <pull.776.v2.git.1604520368.gitgitgadget@gmail.com> <709a17372099351af3e3b9f2dddcd9ce220a9fcb.1604520368.git.gitgitgadget@gmail.com>
In-Reply-To: <709a17372099351af3e3b9f2dddcd9ce220a9fcb.1604520368.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 11 Nov 2020 02:10:50 -0500
Message-ID: <CAPig+cReatZ-iSLWreQqYLM7qONWvBLbDUNVH1dJV37VnmPBgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] maintenance: include 'cron' details in docs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 3:06 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Advanced and expert users may want to know how 'git maintenance start'
> schedules background maintenance in order to customize their own
> schedules beyond what the maintenance.* config values allow. Start a new
> set of sections in git-maintenance.txt that describe how 'cron' is used
> to run these tasks.
>
> This is particularly valuable for users who want to inspect what Git is
> doing or for users who want to customize the schedule further. Having a
> baseline can provide a way forward for users who have never worked with
> cron schedules.

A few comments below, not necessarily worth a re-roll...

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> @@ -218,6 +218,60 @@ Further, the `git gc` command should not be combined with
> +The standard mechanism for scheduling background tasks on POSIX systems
> +is `cron`. This tool executes commands based on a given schedule. The

It is common in Git (and other Unix) documentation to refer to a Unix
tool by its man page reference. So, for instance, instead of `cron`,
we would say cron(8) since the `cron` man page is in section 8 of the
Unix manual.

> +The `<path>` string is loaded to specifically use the location for the

The word "loaded" sounds odd in this context.

> +`git` executable used in the `git maintenance start` command. This allows
> +for multiple versions to be compatible. However, if the same user runs
> +`git maintenance start` with multiple Git executables, then only the
> +latest executable will be used.

I had to read this paragraph four or five times to understand what it
is trying to say (assuming I do understand it). Perhaps it can be
rewritten more succinctly something like this:

    The `crontab` entry specifies the full path of the `git`
    executable to ensure that the `git` command run is the same one
    with which `git maintenance start` was issued independent of
    `PATH`.

> +These commands use `git for-each-repo --config=maintenance.repo` to run
> +`git maintenance run --schedule=<frequency>` on each repository listed in
> +the multi-valued `maintenance.repo` config option. These are typically
> +loaded from the user-specific global config located at `~/.gitconfig`.

I wonder if mentioning `~/.gitconfig` explicitly is wise since it
might also be at $XDG_CONFIG_HOME/git/config or some other location on
Windows. Perhaps it would be sufficient to mention only "global Git
configuration" or something.

> +If the config values are insufficient to achieve your desired background
> +maintenance schedule, then you can create your own schedule. If you run
> +`crontab -e`, then an editor will load with your user-specific `cron`
> +schedule. In that editor, you can add your own schedule lines. You could
> +start by adapting the default schedule listed earlier, or you could read
> +https://man7.org/linux/man-pages/man5/crontab.5.html[the `crontab` documentation]

For consistency with other parts of Git documentation, it might be
better to reference the `crontab` man page simply as crontab(5) rather
than providing an explicit URL.

> +for advanced scheduling techniques. Please do use the full path and
> +`--exec-path` techniques from the default schedule to ensure you are
> +executing the correct binaries in your schedule.
