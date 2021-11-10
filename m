Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5999C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 20:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB5061051
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 20:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhKJVBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 16:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbhKJVBY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 16:01:24 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFA1C061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 12:58:36 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f8so15825104edy.4
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 12:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gGOHSYI6kZzGOlRoUPHxPY00dDL7ycpIRRYW370dmis=;
        b=oibD66pLwaw0qOtyXmvHSHi9PM+CJ0JOKm/76ZVPKVAt4G37xTUnDd3a6GfvfWDe64
         DCW7pL2RBemhXuJO2AjMv0qy6GNToZ8f3+jAVJC61uolfJ7VaypRZjRB7MsnAIyyIzbi
         G3Ndec0W4F7uBZgClAD3EzeqQz7wUCE+Nz7dc5Vy7UsUegQ3ko97ZjPX5fFcY53cJ82d
         BONDP6c+eP62xUe+bMThAlzNsaScCczSQeNmKATvliSkxFKOW8Cm4KHJzQ+md7izYY8i
         skrSvPUysoERcEyqnN5ycPcmoiLA3eFw2ipgiFIwG+8eXyQ0FTCFl8nBTRXNcwhgprgo
         rtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gGOHSYI6kZzGOlRoUPHxPY00dDL7ycpIRRYW370dmis=;
        b=RyLAxDBQRimc+Z0SBJbKcWnGBnRrvu7BPS1xU/pz0Yci7ChQR2JunqWcxRkO45rYV6
         ttmJd3VnDpt+3ys5I3iVj11P3b6VHjDZbt5N9OC+l+YPWlUSXEXzoEICPn9s0oMoYFAd
         /hSps7R301ZU6sUnww6kk9eQcMkVGRHWg/iu7T1QepsHfTziyQE4C5P1gu4fehbpc/uz
         q2AKjBDhCQBz9LX9OYgHwSKuHiLa0jLXfsnEdSfspEqyn2Sar9/l8n+NPKE+8lj2AnAU
         nMgwjNn1rICllR6SWcEJRzfHnlYTsB8s2zTeKHUEYhlPXkr/RRTWYMnwadiwViB7r2MB
         ysgA==
X-Gm-Message-State: AOAM531lMmwpD4ZLFziuiii+gxeUq8Ww6Uuo7dgZxLLr0RkiBpz2lWxO
        QoUTc86hddCd0brp6shCV68=
X-Google-Smtp-Source: ABdhPJzFD3TxZlnKvFFakKxz3I0wWT+OdcDQBKaKSrY0gp1eTfF1xWf3O0wlTWbZUT2aTeLYMu/Dfg==
X-Received: by 2002:a17:906:4fd0:: with SMTP id i16mr2504606ejw.277.1636577914229;
        Wed, 10 Nov 2021 12:58:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hw8sm393863ejc.58.2021.11.10.12.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:58:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkufx-0005OW-AN;
        Wed, 10 Nov 2021 21:58:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] maintenance: disable cron on macOS
Date:   Wed, 10 Nov 2021 21:56:13 +0100
References: <pull.1075.git.1636569360002.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <pull.1075.git.1636569360002.gitgitgadget@gmail.com>
Message-ID: <211110.86y25vpw1y.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 10 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> In eba1ba9 (maintenance: `git maintenance run` learned
> `--scheduler=<scheduler>`, 2021-09-04), we introduced the ability to
> specify a scheduler explicitly. This led to some extra checks around
> whether an alternative scheduler was available. This added the
> functionality of removing background maintenance from schedulers other
> than the one selected.
>
> On macOS, cron is technically available, but running 'crontab' triggers
> a UI prompt asking for special permissions. This is the major reason why
> launchctl is used as the default scheduler. The is_crontab_available()
> method triggers this UI prompt, causing user disruption.
>
> Remove this disruption by using an #ifdef to prevent running crontab
> this way on macOS. This has the unfortunate downside that if a user
> manually selects cron via the '--scheduler' option, then adjusting the
> scheduler later will not remove the schedule from cron. The
> '--scheduler' option ignores the is_available checks, which is how we
> can get into this situation.
>
> Extract the new check_crontab_process() method to avoid making the
> 'child' variable unused on macOS. The method is marked MAYBE_UNUSED
> because it has no callers on macOS.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     [For 2.34.0 Release] maintenance: disable cron on macOS
>     
>     This one is really tricky because we can't notice anything is wrong
>     without running git maintenance start or git maintenance stop
>     interactively on macOS. The tests pass just fine because the UI alert
>     gets automatically ignored during the test suite.
>     
>     This is a bit of a half-fix: it avoids the UI alert, but has a corner
>     case of not un-doing the cron schedule if a user manages to select it
>     (under suitable permissions such that it succeeds). For the purpose of
>     the timing of the release, I think this is an appropriate hedge.
>     
>     Thanks! -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1075%2Fderrickstolee%2Fmaintenance-cron-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1075/derrickstolee/maintenance-cron-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1075
>
>  builtin/gc.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 26709311601..bcef6a4c8da 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1999,15 +1999,11 @@ static int schtasks_update_schedule(int run_maintenance, int fd)
>  		return schtasks_remove_tasks();
>  }
>  
> -static int is_crontab_available(void)
> +MAYBE_UNUSED
> +static int check_crontab_process(const char *cmd)
>  {
> -	const char *cmd = "crontab";
> -	int is_available;
>  	struct child_process child = CHILD_PROCESS_INIT;
>  
> -	if (get_schedule_cmd(&cmd, &is_available))
> -		return is_available;
> -
>  	strvec_split(&child.args, cmd);
>  	strvec_push(&child.args, "-l");
>  	child.no_stdin = 1;
> @@ -2022,6 +2018,25 @@ static int is_crontab_available(void)
>  	return 1;
>  }
>  
> +static int is_crontab_available(void)
> +{
> +	const char *cmd = "crontab";
> +	int is_available;
> +
> +	if (get_schedule_cmd(&cmd, &is_available))
> +		return is_available;
> +
> +#ifdef __APPLE__
> +	/*
> +	 * macOS has cron, but it requires special permissions and will
> +	 * create a UI alert when attempting to run this command.
> +	 */
> +	return 0;
> +#else
> +	return check_crontab_process(cmd);
> +#endif
> +}
> +
>  #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
>  #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
>  
>
> base-commit: 6c220937e2b26d85920bf2d38ff2464a0d57fd6b

I haven't tested, but isn't a smaller fix for this to just re-arrange
the array where we declare the methods to check to have "cron" come
after all the OS-specific ones, or at least after launchctl?

I.e. we already have an ifdef to pick launchctl and never cron for OSX
on "start", so this is only for the case where we loop through the array
looking for something to select.

That wouldn't work if that user can run cron, but can't use launchctl at
all, but in that case won't they be happy to get the prompt?

