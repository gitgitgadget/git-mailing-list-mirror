Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECCCC56202
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 00:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C9822087D
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 00:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbgKRAet (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 19:34:49 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:47092 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgKRAet (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 19:34:49 -0500
Received: by mail-ej1-f67.google.com with SMTP id w13so235358eju.13
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 16:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tk/PKUOeZifzMCIFffiiQn7FvwhAkQJetbCUT0vUeyc=;
        b=dlGUr1GdrV1FlkgMBEgdgSO+KkCORSgkAn01GmPhvaFI48GQ/VjMuvIJ4iYn8HWJv0
         SkFCLSzNLsj8ocD1Ue21gNG5qsPnxxqrmmfNr5iXaIZg5msFHq/eK1z7McFBbbiTllGK
         n9bt4tEZQYf6fAui3ZD89jYmaQpsTn7Is8xSPfp6pTi8PE0fOtkm+mNu9LBzcrn5YSYE
         WEBrjXrdy0awl3EIdnBPm7uLhXQiCKerry/gZ4qmC195HsEnWPvN7tT/jKeXjXh0PYy5
         cKlzASiuMGIyB2BVEz8AUkw3UU1FPPy4Fi9w45jKV2NmWmhvH3NvA6aevmM97vaRHzzT
         UrnQ==
X-Gm-Message-State: AOAM530twI6L9dOEaJ420xCxsUpbd8tuAH9VX3chJ0kQLAf4CDBa536R
        yG3UJl8XX/s/11z0+SzC34RVLWGvmpyhb0mbjEg=
X-Google-Smtp-Source: ABdhPJy6HGemunGa8CtTwtC0HbUbMCjUKX/NpWsWwQ/lBLxfnxatRLJ67A6zNQC865ONuQyyQm12WIK93+tN5dqyxGM=
X-Received: by 2002:a17:906:6949:: with SMTP id c9mr21354951ejs.482.1605659686709;
 Tue, 17 Nov 2020 16:34:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <pull.776.v4.git.1605647598.gitgitgadget@gmail.com> <99170df4626544c1dc26d2e188b215a776140a32.1605647598.git.gitgitgadget@gmail.com>
In-Reply-To: <99170df4626544c1dc26d2e188b215a776140a32.1605647598.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Nov 2020 19:34:35 -0500
Message-ID: <CAPig+cQw=hBqp2jSOOKNCKMe7bUFFLqT2fi0iaBfth-4x7RTgQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] maintenance: include 'cron' details in docs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 4:13 PM Derrick Stolee via GitGitGadget
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
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> @@ -218,6 +218,60 @@ Further, the `git gc` command should not be combined with
> +The comments are used as a region to mark the schedule as written by Git.
> +Any modifications within this region will be completely deleted by
> +`git maintenance stop` or overwritten by `git maintenance start`.
> +
> +The `<path>` string is loaded to specifically use the location for the
> +`git` executable used in the `git maintenance start` command. This allows
> +for multiple versions to be compatible. However, if the same user runs
> +`git maintenance start` with multiple Git executables, then only the
> +latest executable will be used.

It looks like this section in v4 got accidentally reverted to the
wording from v2, whereas v3 had been changed to:

    The `crontab` entry specifies the full path of the `git`
    executable to ensure that the executed `git` command is the same
    one with which `git maintenance start` was issued independent of
    `PATH`. If the same user runs `git maintenance start` with
    multiple Git executables, then only the latest executable is used.

> +These commands use `git for-each-repo --config=maintenance.repo` to run
> +`git maintenance run --schedule=<frequency>` on each repository listed in
> +the multi-valued `maintenance.repo` config option. These are typically
> +loaded from the user-specific global config located at `~/.gitconfig`.
> +The `git maintenance` process then determines which maintenance tasks
> +are configured to run on each repository with each `<frequency>` using
> +the `maintenance.<task>.schedule` config options. These values are loaded
> +from the global or repository config values.

Same problem here. This wording is from v2, whereas v3 had been
changed to say generically "user-specific global config" rather than
mentioning `~/.gitconfig` explicitly.

> +If the config values are insufficient to achieve your desired background
> +maintenance schedule, then you can create your own schedule. If you run
> +`crontab -e`, then an editor will load with your user-specific `cron`
> +schedule. In that editor, you can add your own schedule lines. You could
> +start by adapting the default schedule listed earlier, or you could read
> +https://man7.org/linux/man-pages/man5/crontab.5.html[the `crontab` documentation]
> +for advanced scheduling techniques. Please do use the full path and
> +`--exec-path` techniques from the default schedule to ensure you are
> +executing the correct binaries in your schedule.

And here too. v3 had updated this to say only "crontab(5)" rather than
providing an explicit URL.
