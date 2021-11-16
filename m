Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A27DC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 10:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E46061AD2
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 10:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhKPKDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 05:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbhKPKC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 05:02:58 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92E4C061746
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 02:00:00 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t30so36331311wra.10
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 02:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N25Gz8k6w/pUEol8YnuVA6diy5jvZZOdcOy1MiYARCc=;
        b=lauzPS19aarcGHhHhfd/clpk4EDy/EyTBp9HooYORuD9HZ7is+pxa2TMwfPqsLX1tf
         Q8I4sFkJxnY4cLK5a1ZUb1uckLO5QY1V741o+Az4kyuZM5nD3+9Dd9kTM4xcAMw9hCo9
         InyHfqh+ZBwz2WeDtEF4ESEW3Eiak5QvssCjPNXTgFfLxiVLTHzajjVfiZe1+4VM6QYx
         PLIIY433RdURw2Po84prXNWHRrHMK+PxUE2Vo1S0GNv4+NADbMspfyYswHfZHtpNeI5t
         erUC5oRY3+fbFYdq4br/Y8LrPRk/evkPNoUGOYtZ9/kYj0qRyAd4483Agy+JWHKCaoVf
         ZMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N25Gz8k6w/pUEol8YnuVA6diy5jvZZOdcOy1MiYARCc=;
        b=q64tojANjstIV8/9DZu68FpkWxBA7vXDGdTEZp+D2542X3gIN4eB54CzY02QG+Gzms
         76SvYYs9Ra8uSthbkPN8xdSB5wN8ZvZwX6FwKYOv10Bxh1sLIu7DiS+GXKfzmSFZiJGl
         DG8b4Kyr73nGcNhj2uyINx80Nz0BfelTamlcs9A1cTW35mJLeKKzRKwJI7lBfEFR3yEw
         ULKkB4jLbtV7hgO9Go6NHsPrpypHIimCQs29/s7H3fk6Ex3zHXBV2vd+pddzIapVHIEl
         GV5fQfzzXgHBwUZoDErwCPce0iJ3Nd8dpKpuhKcU7b2Agja/GhkaOIA9j34g71Ru1DgB
         B1lw==
X-Gm-Message-State: AOAM532Tig3mg58jNyTYxldgjm2Llo0HjNSmpfmRiVVnengh83ouZigD
        Q9acWPkp7op4Lb2wUS9jYWY=
X-Google-Smtp-Source: ABdhPJzyQNpBm5HoMYmVpr9wEhFssU2Biid5benuJdZxhOnDPtA6PGVTpN90t747cknNTsW9wK026A==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr7581961wrt.419.1637056799119;
        Tue, 16 Nov 2021 01:59:59 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id j17sm2115695wmq.41.2021.11.16.01.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 01:59:58 -0800 (PST)
Message-ID: <eec6add8-2935-3692-fa7e-c40cc765b675@gmail.com>
Date:   Tue, 16 Nov 2021 09:59:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: do not export GIT_DIR and GIT_WORK_TREE for
 'exec'
Content-Language: en-GB-large
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1134.git.git.1636738973089.gitgitgadget@gmail.com>
 <pull.1134.v2.git.git.1637041986945.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1134.v2.git.git.1637041986945.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 16/11/2021 05:53, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Commands executed from `git rebase --exec` can give different behavior
> from within that environment than they would outside of it, due to the
> fact that sequencer.c exports both GIT_DIR and GIT_WORK_TREE.  For
> example, if the relevant script calls something like
> 
>    git -C ../otherdir log --format=%H --no-walk
> 
> the user may be surprised to find that the command above does not show a
> commit hash from ../otherdir, because $GIT_DIR prevents automatic gitdir
> detection and makes the -C option useless.
> 
> This is a regression in behavior from the original legacy
> implemented-in-shell rebase.  It is perhaps rare for it to cause
> problems in practice, especially since most small problems that were
> caused by this area of bugs has been fixed-up in the past in a way that
> masked the particular bug observed without fixing the real underlying
> problem.
> 
> An explanation of how we arrived at the current situation is perhaps
> merited.  The setting of GIT_DIR and GIT_WORK_TREE done by sequencer.c
> arose from a sequence of historical accidents:
> 
> * When rebase was implemented as a shell command, it would call
>    git-sh-setup, which among other things would set GIT_DIR -- but not
>    export it.  This meant that when rebase --exec commands were run via
>        /bin/sh -c "$COMMAND"
>    they would not inherit the GIT_DIR setting.  The fact that GIT_DIR
>    was not set in the run $COMMAND is the behavior we'd like to restore.
> 
> * When the rebase--helper builtin was introduced to allow incrementally
>    replacing shell with C code, we had an implementation that was half
>    shell, half C.  In particular, commit 18633e1a22 ("rebase -i: use the
>    rebase--helper builtin", 2017-02-09) added calls to
>        exec git rebase--helper ...
>    which caused rebase--helper to inherit the GIT_DIR environment
>    variable from the shell.  git's setup would change the environment
>    variable from an absolute path to a relative one (".git"), but would
>    leave it set.  This meant that when rebase --exec commands were run
>    via
>        run_command_v_opt(...)
>    they would inherit the GIT_DIR setting.
> 
> * In commit 09d7b6c6fa ("sequencer: pass absolute GIT_DIR to exec
>    commands", 2017-10-31), it was noted that the GIT_DIR caused problems
>    with some commands; e.g.
>        git rebase --exec 'cd subdir && git describe' ...
>    would have GIT_DIR=.git which was invalid due to the change to the
>    subdirectory.  Instead of questioning why GIT_DIR was set, that commit
>    instead made sequencer change GIT_DIR to be an absolute path and
>    explicitly export it via
>        argv_array_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
>        run_command_v_opt_cd_env(..., child_env.argv)
> 
> * In commit ab5e67d751 ("sequencer: pass absolute GIT_WORK_TREE to exec
>    commands", 2018-07-14), it was noted that when GIT_DIR is set but
>    GIT_WORK_TREE is not, that we do not discover GIT_WORK_TREE but just
>    assume it is '.'.  That is incorrect if trying to run commands from a
>    subdirectory.  However, rather than question why GIT_DIR was set, that
>    commit instead also added GIT_WORK_TREE to the list of things to
>    export.
> 
> Each of the above problems would have been fixed automatically when
> git-rebase became a full builtin, had it not been for the fact that
> sequencer.c started exporting GIT_DIR and GIT_WORK_TREE in the interim.
> Stop exporting them now.

Thanks for fixing this. The commit message does a great job of 
explaining the problem and how we got there. The patch looks fine to me 
though I think all the exec tests live in t3404 (interactive and non 
interactive) so it feels a bit strange to add a new test file just for 
this. There are plenty of uses of --exec in other test files but I think 
they are just using the exec command as part of the test rather than 
testing the --exec functionality (with the exception of t3418 which 
tests --reschedule-failed-exec)

Best Wishes

Phillip

> Signed-off-by: Elijah Newren <newren@gmail.com>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>      sequencer: fix environment that 'exec' commands run under
>      
>      Changes since v1:
>      
>       * Fix wording in multiple locations pointed out by Johannes
>         Altmanninger
>      
>      Note that Johaness Altmanninger also suggested some additional
>      GIT_DIR/GIT_WORK_TREE and --git-dir/--work-tree testcases, but since
>      those change the current working directory to the work tree so that
>      GIT_WORK_TREE ends up being '.' in every case, I think it's straying a
>      bit from the point of the test. If other feel strongly, I can add them
>      in.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1134%2Fnewren%2Ffix-rebase-exec-environ-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1134/newren/fix-rebase-exec-environ-v2
> Pull-Request: https://github.com/git/git/pull/1134
> 
> Range-diff vs v1:
> 
>   1:  12713c83705 ! 1:  c647c45375a sequencer: fix environment that 'exec' commands run under
>       @@ Metadata
>        Author: Elijah Newren <newren@gmail.com>
>        
>         ## Commit message ##
>       -    sequencer: fix environment that 'exec' commands run under
>       +    sequencer: do not export GIT_DIR and GIT_WORK_TREE for 'exec'
>        
>            Commands executed from `git rebase --exec` can give different behavior
>            from within that environment than they would outside of it, due to the
>       @@ Commit message
>            masked the particular bug observed without fixing the real underlying
>            problem.
>        
>       -    How we arrived at the current situation is perhaps merited.  The setting
>       -    of GIT_DIR and GIT_WORK_TREE done by sequencer.c arose from a sequence
>       -    of historical accidents:
>       +    An explanation of how we arrived at the current situation is perhaps
>       +    merited.  The setting of GIT_DIR and GIT_WORK_TREE done by sequencer.c
>       +    arose from a sequence of historical accidents:
>        
>            * When rebase was implemented as a shell command, it would call
>              git-sh-setup, which among other things would set GIT_DIR -- but not
>       @@ Commit message
>              was not set in the run $COMMAND is the behavior we'd like to restore.
>        
>            * When the rebase--helper builtin was introduced to allow incrementally
>       -      replacing shell with C code, we were in an implementation that was
>       -      half shell, half C.  In particular, commit 18633e1a22 ("rebase -i: use
>       -      the rebase--helper builtin", 2017-02-09) added calls to
>       +      replacing shell with C code, we had an implementation that was half
>       +      shell, half C.  In particular, commit 18633e1a22 ("rebase -i: use the
>       +      rebase--helper builtin", 2017-02-09) added calls to
>                  exec git rebase--helper ...
>              which caused rebase--helper to inherit the GIT_DIR environment
>              variable from the shell.  git's setup would change the environment
>       @@ Commit message
>              export.
>        
>            Each of the above problems would have been fixed automatically when
>       -    git-rebase become a full builtin, had it not been for the fact that
>       +    git-rebase became a full builtin, had it not been for the fact that
>            sequencer.c started exporting GIT_DIR and GIT_WORK_TREE in the interim.
>            Stop exporting them now.
>        
> 
> 
>   sequencer.c               |  9 +--------
>   t/t3409-rebase-environ.sh | 23 +++++++++++++++++++++++
>   2 files changed, 24 insertions(+), 8 deletions(-)
>   create mode 100755 t/t3409-rebase-environ.sh
> 
> diff --git a/sequencer.c b/sequencer.c
> index ea96837cde3..9afdbe3e3d1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3495,17 +3495,12 @@ static int error_failed_squash(struct repository *r,
>   
>   static int do_exec(struct repository *r, const char *command_line)
>   {
> -	struct strvec child_env = STRVEC_INIT;
>   	const char *child_argv[] = { NULL, NULL };
>   	int dirty, status;
>   
>   	fprintf(stderr, _("Executing: %s\n"), command_line);
>   	child_argv[0] = command_line;
> -	strvec_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
> -	strvec_pushf(&child_env, "GIT_WORK_TREE=%s",
> -		     absolute_path(get_git_work_tree()));
> -	status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
> -					  child_env.v);
> +	status = run_command_v_opt(child_argv, RUN_USING_SHELL);
>   
>   	/* force re-reading of the cache */
>   	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
> @@ -3535,8 +3530,6 @@ static int do_exec(struct repository *r, const char *command_line)
>   		status = 1;
>   	}
>   
> -	strvec_clear(&child_env);
> -
>   	return status;
>   }
>   
> diff --git a/t/t3409-rebase-environ.sh b/t/t3409-rebase-environ.sh
> new file mode 100755
> index 00000000000..83ffb39d9ff
> --- /dev/null
> +++ b/t/t3409-rebase-environ.sh
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +
> +test_description='git rebase interactive environment'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit one &&
> +	test_commit two &&
> +	test_commit three
> +'
> +
> +test_expect_success 'rebase --exec does not muck with GIT_DIR' '
> +	git rebase --exec "printf %s \$GIT_DIR >environ" HEAD~1 &&
> +	test_must_be_empty environ
> +'
> +
> +test_expect_success 'rebase --exec does not muck with GIT_WORK_TREE' '
> +	git rebase --exec "printf %s \$GIT_WORK_TREE >environ" HEAD~1 &&
> +	test_must_be_empty environ
> +'
> +
> +test_done
> 
> base-commit: 88d915a634b449147855041d44875322de2b286d
> 
