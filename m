Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC589C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 19:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiAYTq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 14:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiAYTqY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 14:46:24 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA33C06175A
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 11:45:17 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id p37so20723024pfh.4
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 11:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=riIoZkTgsbeKCFE0/7zhqmf0ev2Wa8VPhxr7h1PMEuo=;
        b=q6pf6iFQ4KHQ28s2ENCPss6VLeBX6KXd7KPXwpSi1kNoN0Kc8waM0qFiXlxEad19+5
         JwnI0PK2lE6Lqsgv3kYP+Fp18ILLyJFEVrwpC5+5HSqBrR4EBHMXGe2N6g0Nq9bP5PFc
         AUnShaiwxvYYaVhVkEQ2WliqflPnbw33gQTVg+bGBrNUVB7T+AsYUf93SykQrOhqBTWO
         VabvtIQcEQbzt0gzvhwm+WWyIJUOnaMRynb3B/KyVwC+MxCH8VEMA2gNS/IUK4VfOe1n
         9fJsL6QUrTUDrSn42T+CevRwcvO6JoOCv1VgnOWcL26hhINnHxIsNjp/MKF1qDBXzLqw
         1amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=riIoZkTgsbeKCFE0/7zhqmf0ev2Wa8VPhxr7h1PMEuo=;
        b=CMr9gMwwDz0V83kxH7ItROtxxuUwpFSxpqpZKMtg5910+x/jFQ98DucGE67ud2aUug
         XqE4/WAPE1yFyHvHtIs0incZUtCMkh4fl6/+kpLu9ifI1+QoEqUkR6xuvuYGbXBVVVrN
         hzAFN6rf6rA21TmFkCxBTCUIwObvJZRTyOY9uJeecQrR6lJPnHJijabheYBf6Rw0ngTZ
         Y+0VrQc+gtTUPYfoSQVpVCVVpBz86XCK89k3bltAI18gTwRyapygARW7/ZKDsh35KTPx
         zqM/O9KF1b71Py6F5dddptbrMUbHXn7epA61O+B2QGZjswO68iIUu4JOdjr9uHT4brQp
         BR5w==
X-Gm-Message-State: AOAM532ljZGVIKz9kh88b+cq/9Qwgf8Jgxl5odSgwUakLWsiM2nYPs+A
        7gxPLLa4RHFE4BpU8hKi2xeAhw==
X-Google-Smtp-Source: ABdhPJxdHej82RAsafBjSJt7kRvKNtZeLNnkP+4IgybN7zpG7E6TGd2LUwHLTgiBfEc19ErdYqIaoA==
X-Received: by 2002:a63:10c:: with SMTP id 12mr16206778pgb.67.1643139916920;
        Tue, 25 Jan 2022 11:45:16 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:e7c6:925b:7e12:6498])
        by smtp.gmail.com with ESMTPSA id n3sm6557115pfu.84.2022.01.25.11.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:45:15 -0800 (PST)
Date:   Tue, 25 Jan 2022 11:45:10 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, gitscale@google.com
Subject: Submodule UX overhaul update (was: What's cooking in git.git (Jan
 2022, #07; Mon, 24))
Message-ID: <YfBTRuPrGGjepe+D@google.com>
References: <xmqq35lc53e9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq35lc53e9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finally finding the time to write up another "what's cooking as pertain
to overhauling submodules UX" reply.

On Mon, Jan 24, 2022 at 11:39:58AM -0800, Junio C Hamano wrote:
> --------------------------------------------------
> [Stalled]
> 
> * ar/submodule-update (2021-10-13) 9 commits
>  . submodule--helper: rename helper functions
>  . submodule--helper: remove unused helpers
>  . submodule: move core cmd_update() logic to C
>  . submodule--helper: run update using child process struct
>  . submodule--helper: allow setting superprefix for init_submodule()
>  . submodule--helper: refactor get_submodule_displaypath()
>  . submodule--helper: rename helpers for update-clone
>  . submodule--helper: get remote names from any repository
>  . submodule--helper: split up ensure_core_worktree()
> 
>  Rewrite of "git submodule update" in C.
> 
>  Expecting a reroll?
>  cf. <YWiXL+plA7GHfuVv@google.com>
>  source: <20211013051805.45662-10-raykar.ath@gmail.com>

Sounds like Glen is interested in this series with regard to some edge
cases about cloning newly added submodules during a 'git fetch
--recurse-submodules'. I'm curious to hear from Atharva about the status
of this work :)

> --------------------------------------------------
> [Cooking]
> 
> * js/apply-partial-clone-filters-recursively (2022-01-21) 1 commit
>  - clone, submodule: pass partial clone filters to submodules
> 
>  "git clone --filter=... --recurse-submodules" only makes the
>  top-level a partial clone, while submodules are fully cloned.  This
>  behaviour is changed to pass the same filter down to the submodules.
>  source: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>

Could use some comments on this. Looks like so far only Junio has
replied. If anybody's interested, this one is a very big deal
for us in terms of scaling Git for very large repos, or for
superprojects with many submodules, or both. :)

> 
> * ds/sparse-checkout-requires-per-worktree-config (2022-01-14) 6 commits
>  . worktree: copy sparse-checkout patterns and config on add
>  . sparse-checkout: use repo_config_set_worktree_gently()
>  . config: add repo_config_set_worktree_gently()
>  . worktree: add 'init-worktree-config' subcommand
>  . config: make some helpers repo-aware
>  . setup: use a repository when upgrading format
> 
>  "git sparse-checkout" wants to work with per-worktree configration,
>  but did not work well in a worktree attached to a bare repository.
> 
>  Expecting an update.
>  cf. <1db0f601-4769-15c0-cd58-ecddfa1fc9d5@gmail.com>
>  Introduces new leaks.
>  cf. https://github.com/git/git/runs/4823667255?check_suite_focus=true
>  source: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>

Looks like this is getting some conversation from Eric and Elijah, but
I'll call my team's attention to it too - sounds really useful.

> 
> * gc/branch-recurse-submodules (2022-01-10) 6 commits
>  - branch: add --recurse-submodules option for branch creation
>  - builtin/branch: clean up action-picking logic in cmd_branch()
>  - branch: add a dry_run parameter to create_branch()
>  - branch: make create_branch() always create a branch
>  - branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
>  - Merge branch 'js/branch-track-inherit' into gc/branch-recurse-submodules
> 
>  "git branch" learned the "--recurse-submodules" option.
> 
>  Expecting a reroll.
>  cf. <kl6l7db6kvp2.fsf@chooglen-macbookpro.roam.corp.google.com>
>  source: <20211220233459.45739-1-chooglen@google.com>

Looks like the reroll came just after this mail:
<20220124204442.39353-1-chooglen@google.com>

> * jt/conditional-config-on-remote-url (2022-01-18) 2 commits
>   (merged to 'next' on 2022-01-19 at 3c2df266eb)
>  + config: include file if remote URL matches a glob
>  + config: make git_config_include() static
> 
>  The conditional inclusion mechanism of configuration files using
>  "[includeIf <condition>]" learns to base its decision on the
>  URL of the remote repository the repository interacts with.
> 
>  Will cook in 'next'.
>  source: <cover.1642527965.git.jonathantanmy@google.com>

Very cool, thanks. We are hoping to be able to use this for distributing
configs like sparsity filters, submodule behavior, config-based hooks,
etc. in our controlled-environment /etc/gitconfig workplace. This kind
of conditional include will let us say something like, "teams who
are using https://some/remote have agreed to be guinea pigs" and curate
a special config for the things we want them to try. I'm very excited to
see it :)

> 
> * ab/config-based-hooks-2 (2022-01-07) 17 commits
>   (merged to 'next' on 2022-01-19 at 594b6da22c)
>  + run-command: remove old run_hook_{le,ve}() hook API
>  + receive-pack: convert push-to-checkout hook to hook.h
>  + read-cache: convert post-index-change to use hook.h
>  + commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>  + git-p4: use 'git hook' to run hooks
>  + send-email: use 'git hook run' for 'sendemail-validate'
>  + git hook run: add an --ignore-missing flag
>  + hooks: convert worktree 'post-checkout' hook to hook library
>  + hooks: convert non-worktree 'post-checkout' hook to hook library
>  + merge: convert post-merge to use hook.h
>  + am: convert applypatch-msg to use hook.h
>  + rebase: convert pre-rebase to use hook.h
>  + hook API: add a run_hooks_l() wrapper
>  + am: convert {pre,post}-applypatch to use hook.h
>  + gc: use hook library for pre-auto-gc hook
>  + hook API: add a run_hooks() wrapper
>  + hook: add 'run' subcommand
> 
>  More "config-based hooks".
> 
>  Will cook in 'next'.
>  source: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
> 

Very excited to see this one go in and looking forward to the next set!
By the way, this reduced the number of patches Google is carrying
internally on top of 'next' from 46 to 29. :) (All but 7 of those are
the rest of config-based-hooks.)

It might seem slightly selfish for me to include config-based-hooks in
the "submodules update" letter, but this is actually very important for
submodules too - without config-based hooks, we don't have a good way to
distribute a hook across an entire Git superproject-and-submodules
codebase. With config-based hooks + "config.superproject" shared between
the submodules and superproject, this becomes a very easy story :)

Thanks!

> 
> * es/superproject-aware-submodules (2021-11-18) 5 commits
>  - submodule: use config to find superproject worktree
>  - submodule: record superproject gitdir during 'update'
>  - submodule: record superproject gitdir during absorbgitdirs
>  - introduce submodule.superprojectGitDir record
>  - t7400-submodule-basic: modernize inspect() helper
> 
>  A configuration variable in a submodule points at the location of
>  the superproject it is bound to (RFC).
> 
>  Expecting a reroll.
>  cf. <20211117234300.2598132-1-jonathantanmy@google.com>
>  source: <20211117005701.371808-1-emilyshaffer@google.com>

Hoping to reroll this week. I have been ignoring this to make more room
for the discussion and followup work from <YbvBvch8JcHED+A9@google.com>,
which I think is all distributed now.

By the way, speaking of that mail, for the past 2 weeks or so all the
patches from the Google Git team - so me, Glen Choo, Josh Steadmon,
Jonathan Tan, Jonathan Nieder, and Calvin Wan - have been undergoing an
internal review of cover letter, --- description, and commit message
before being sent.  If anybody has feedback on how those parts of our
series are looking lately, I'd be really interested in hearing it.


Thanks all.
 - Emily
