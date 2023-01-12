Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71778C677F1
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 11:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjALLZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 06:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbjALLYR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 06:24:17 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A2B5C927
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 03:14:57 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id v6so899997ejg.6
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 03:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2aVw1ghvgDUAJ+BqalJscyUrgc1NPqFxsvDidbdGr0=;
        b=bcp5NCxF5hND0FMiPm3On00Nb+jAhZLbzDRh2lN+hBgwU45eJgOgxRimZRjc4OsqCU
         w7JtapI1yem4P+1AWivkeIIyTrYQ82oOJw8+2HQybQ9chd5azMPM42KlzXXvBlviryBu
         KMw3LKt79YmHKNRQp4S31AfpMaqI/P0oZC8Hqph2LdIzRzwi7KUoH8pSpZV0Y3eAoI7Q
         IsBF7OpBJBQq7XAyzi15sHGFnOIgc/D8WAGL9DGT8zsF/Efkrcqk8YqaG2+UCGTYZSGY
         RmvF6DKqu0QHngvJ6IivLhU0+fHzPwSI2m/UL98Y3LLOD6wTN1YMEHH2Gl6JvA612/RV
         /eSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2aVw1ghvgDUAJ+BqalJscyUrgc1NPqFxsvDidbdGr0=;
        b=FQROpuxTN2q48+TC2gQ0BDz1VRNGET+4teHR3lB20VVo1NU501hPvIH/WO9CqyU8J6
         6LhclORKaDI035a1B1x61YHsxCjASPnDMmX80nsNyAIsw9U0W+qzyclKz/KJ19m5zDYu
         1y6KCnkFPctyrk7lMMwOpttYyJESe+kPl6HsGAzN0pFG3TM1WwT54i7YYu5jGQqp3gAC
         kiLp9h/EMmYlD+xt5+dS6J7Gn67aLTjoS3uadK43B6My+3nwAKUFTZ/dtIVD44Tkz8pv
         ndGGg2CrnQhR2xd6Sb8mDRIOBVUUzn+jdEO/j8DQH2SKKyaav9i1tKNbeOwoBLopDhrO
         Llwg==
X-Gm-Message-State: AFqh2koqTjcK5D0abGTYFwiRxhe8+sqD8nMCYtcsQ4x/a9jY0+NDYWif
        6qnyw6dPfSe41cS/JRCN94I=
X-Google-Smtp-Source: AMrXdXuhvsUXq+YNGPtNUDBeBZtxlEqWThggSSUjrZGbzbJKUHqYvrDfK6k7SA45Ow3mV/jcIAcd5g==
X-Received: by 2002:a17:906:1601:b0:85c:d016:7145 with SMTP id m1-20020a170906160100b0085cd0167145mr6250296ejd.62.1673522095659;
        Thu, 12 Jan 2023 03:14:55 -0800 (PST)
Received: from [10.20.18.15] ([216.24.213.26])
        by smtp.gmail.com with ESMTPSA id cs3-20020a0564020c4300b0046dd0c2a08esm7061390edb.36.2023.01.12.03.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 03:14:55 -0800 (PST)
Message-ID: <eaa80cb6-231b-10f2-74f4-b55d1a8cb1f5@gmail.com>
Date:   Thu, 12 Jan 2023 12:14:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01/2023 11:36, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> When adding a "break" command to a rebase todo list it can be helpful to
> add a comment as a reminder as to what the user was planning to do when
> the rebase stopped. Anything following the command is interpreted as an
> argument to the command and results in an error. Change this so that a
> "break command may be followed by "# <comment>" in the same way as
> a "merge" command. Requiring the comment to begin with "# " allows the
> break command to start taking an argument in the future if that turns
> out to be useful.
> 
> Reported-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>      rebase -i: allow a comment after a "break" command
>      
>      I'm open to suggestions for other ways to handle comments but copying
>      what we do to separate merge parents from the merge commit subject
>      seemed simplest.
>      
>      Should this print the comment when stopping for a break command?

Technically, the user can look up the command via `git status`, but it
would make sense to just give the user this information directly,
similar to how exec command prints "Executing: ..." in addition to the
existing break command's message "Stopped at ...".

> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1460%2Fphillipwood%2Fsequencer-allow-comment-after-break-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1460/phillipwood/sequencer-allow-comment-after-break-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1460
> 
>   Documentation/git-rebase.txt |  4 +++-
>   sequencer.c                  |  7 +++++--
>   t/lib-rebase.sh              |  2 +-
>   t/t3418-rebase-continue.sh   | 16 ++++++++++++++++
>   4 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index f9675bd24e6..511ace43db0 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -869,7 +869,9 @@ the files and/or the commit message, amend the commit, and continue
>   rebasing.
>   
>   To interrupt the rebase (just like an "edit" command would do, but without
> -cherry-picking any commit first), use the "break" command.
> +cherry-picking any commit first), use the "break" command. A "break"
> +command may be followed by a comment beginning with `#` followed by a
> +space.

A corresponding update to append_todo_help in rebase-interactive.c
would be helpful.

>   
>   If you just want to edit the commit message for a commit, replace the
>   command "pick" with the command "reword".

[...]

> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 130e2f9b553..18d82869b38 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -266,6 +266,22 @@ test_expect_success 'the todo command "break" works' '
>   	test_path_is_file execed
>   '
>   
> +test_expect_success 'the todo command "break" accepts a comment' '
> +	rm -f execed &&
> +	test_write_lines "break # comment" "break #" "exec >execed" >expect &&
> +	write_script cat-todo.sh <<-\EOS &&
> +	GIT_SEQUENCE_EDITOR="grep ^\[^#\]" git rebase --edit-todo >actual
> +	EOS
> +	FAKE_LINES="exec_./cat-todo.sh break_#_comment b_# exec_>execed" \

It seems that helper set_cat_todo_editor could be used here, except that
tests in t3418-rebase-continue.sh use a global set_fake_editor at the
very top of the file, unlike tests in t3404-rebase-interactive.sh which
call set_fake_editor individually.  See also related commits 6a619ca03c
(t3404: remove uneeded calls to set_fake_editor, 2019-10-15) and
b2dbacbddf (t3404: set $EDITOR in subshell, 2019-10-15).

> +		git rebase -i HEAD &&
> +	test_cmp expect actual &&
> +	test_path_is_missing execed &&
> +	git rebase --continue &&
> +	test_path_is_missing execed &&
> +	git rebase --continue &&
> +	test_path_is_file execed
> +'
> +
>   test_expect_success '--reschedule-failed-exec' '
>   	test_when_finished "git rebase --abort" &&
>   	test_must_fail git rebase -x false --reschedule-failed-exec HEAD^ &&
> 
> base-commit: 8a4e8f6a67e7fc97048d4666eec38399b88e0e3b

