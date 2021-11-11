Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544D4C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B17761215
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhKKWWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 17:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhKKWWP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 17:22:15 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF94DC061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 14:19:25 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g18so6762063pfk.5
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 14:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JHPKibHVu8qnydDEtvBjjVxcBmU9kd92OhOWsF45Vq0=;
        b=saXl/B5Vh0+37tTK4aVzK5kCWPJIb6WqfP4awevGiZmDManYem4QmcJaI0ZaSUOsgU
         46X9JqpHy9laIskc1wBuTYzt08/90BnOXwW8XHGfiyNuXKHtbH1FuJWqvr2pbtR9x0Q1
         iLBmu0R29ebXWara3v7IwX+EtAiXrRQ3c5XanhJ3hKBE32Uw27WJk7NeWZp6dcDeXEiI
         V79gK5d5BRsL+iFCUqWce0UhBbJRUaOW3aTwer72bXnCfJ3iAaA/b63OzFCKEvTzqDmt
         8zLjlrqYrswaB3ejjPJEPUUIaaN6I8CFonyS1uHbKQw4kJk6R32JHkr5AVY2eX7Or+qM
         hr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JHPKibHVu8qnydDEtvBjjVxcBmU9kd92OhOWsF45Vq0=;
        b=bBamRuuaeEbW8s3fnH6qilD3mPq8R9iR79XXVrVUb34UFyKzeKQlCT55KmMFx3JaxS
         65MbVzfANJbXVh2E9emhrTkEMr1AYNp+dBFBVlAIdvZmstimVrO4R+UJxQ1rJLiMW1gF
         aNcLo8O3bcLyDRi/lGH/mfxj4P9zuGpHcxaQAycLD/w+kKicqAf/S9IdLee5BQQBYBcl
         oi0MFQpiaN81QqlAwb5XU8kdFmvBpn5cjOQDBltF8ZdQMN1QUX3iBwdaDhTpAocI3Uf7
         VoBBWE17Ea8ynK0+G8W5L0rPs2Ru0ZcvMJHJ/VfeSq/SOGVNZHQvP8b0vUawZ1HLYuEI
         ihlw==
X-Gm-Message-State: AOAM533oGhnrGxFjw0kDOwpZncM9lsKb99pzyi76AsulUqDY9lQQ2ARt
        kTb1SDveGNY1pdfN03hRLCiJrOsbI4PoBUSV
X-Google-Smtp-Source: ABdhPJyVTQRrIMeXuoi3UJhQShxRqyWAm4o33Cyb5NjvaEDhehQQrFjNRfZ50qNQOvi7VhVBLW3BNQ==
X-Received: by 2002:a65:5889:: with SMTP id d9mr6861102pgu.456.1636669165036;
        Thu, 11 Nov 2021 14:19:25 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:ab2f:d045:9fa5:64f1])
        by smtp.gmail.com with ESMTPSA id b28sm2957844pgn.67.2021.11.11.14.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 14:19:24 -0800 (PST)
Date:   Thu, 11 Nov 2021 14:19:20 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2021, #03; Tue, 9)
Message-ID: <YY2W6ESIxSz9lakK@google.com>
References: <xmqqy25wygek.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy25wygek.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once more, updates to submodule-UX-overhaul related work.

On Tue, Nov 09, 2021 at 04:59:31PM -0800, Junio C Hamano wrote:
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
>  Kicked out of 'seen' to make room for es/superproject-aware-submodules
>  which is among the topics this topic stomps on.

There is some discussion on es/superproject-aware-submodules, and
whether it is still needed. I think it is, but I'll say more downthread,
instead of next to this topic.

> --------------------------------------------------
> [Cooking]
> 
> * gc/remote-with-fewer-static-global-variables (2021-10-28) 6 commits
>  - remote: add struct repository parameter to external functions
>  - remote: die if branch is not found in repository
>  - remote: remove the_repository->remote_state from static methods
>  - remote: use remote_state parameter internally
>  - remote: move static variables into per-repository struct
>  - t5516: add test case for pushing remote refspecs
> 
>  Code clean-up to eventually allow information on remotes defined
>  for an arbitrary repository to be read.
> 
>  Will merge to 'next'?

What's still blocking this from being merged? Anything? Release
schedule?

> * js/branch-track-inherit (2021-10-18) 1 commit
>  - branch: add flags and config to inherit tracking
> 
>  "git -c branch.autosetupmerge=inherit branch new old" makes "new"
>  to have the same upstream as the "old" branch, instead of marking
>  "old" itself as its upstream.
> 
>  Under discussion.
>  cf. <87a6j6tbsv.fsf@gmgdl.gmail.com>

Got confirmation this week that Josh is actively working on the next reroll.

> * ab/config-based-hooks-2 (2021-11-01) 18 commits
>  - run-command: remove old run_hook_{le,ve}() hook API
>  - receive-pack: convert push-to-checkout hook to hook.h
>  - read-cache: convert post-index-change to use hook.h
>  - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>  - git-p4: use 'git hook' to run hooks
>  - send-email: use 'git hook run' for 'sendemail-validate'
>  - git hook run: add an --ignore-missing flag
>  - hooks: convert worktree 'post-checkout' hook to hook library
>  - hooks: convert non-worktree 'post-checkout' hook to hook library
>  - merge: convert post-merge to use hook.h
>  - am: convert applypatch-msg to use hook.h
>  - rebase: convert pre-rebase to use hook.h
>  - hook API: add a run_hooks_l() wrapper
>  - am: convert {pre,post}-applypatch to use hook.h
>  - gc: use hook library for pre-auto-gc hook
>  - hook API: add a run_hooks() wrapper
>  - hook: add 'run' subcommand
>  - Merge branch 'ab/config-based-hooks-1' into ab/config-based-hooks-2
> 
>  More "config-based hooks".

I think I owe another review, but as always with these topics, I wrote a
lot of the code so I'm not sure how much I can really help. Other eyes
appreciated.

> * es/superproject-aware-submodules (2021-11-04) 4 commits
>  - submodule: record superproject gitdir during 'update'
>  - submodule: record superproject gitdir during absorbgitdirs
>  - introduce submodule.superprojectGitDir record
>  - t7400-submodule-basic: modernize inspect() helper
> 
>  A configuration variable in a submodule points at the location of
>  the superproject it is bound to (RFC).

To summarize the discussion from here: Ævar suggested this topic might
not be necessary anymore, and that we should rely on in-process
discovery of the superproject's gitdir. However, after some more
thought, I think it's valuable to strive for a definitive way to tell
"yes, I am a submodule" - and I'd like for this topic to be it. I'm
planning a reroll (and an explanation in the cover letter), and to drop
language referring to that as a "cache" (because it isn't a cheap
version of an operation the submodule would be doing otherwise). I will
also add another patch to demonstrate how we can use that new
information as a point of truth, instead of a performance shim.

---

Jonathan Tan: WIP v2 Conditional config includes remotes based on remote URL
https://lore.kernel.org/git/cover.1635527389.git.jonathantanmy%40google.com

Additional discussion ongoing, Jonathan is working on another reroll,
with a substantially different implementation but same user-facing
feature. I think this discussion can benefit from reviews with an open
mind - this is another effort to solve "how can a team ship configs for
anybody developing their project, in the least painful (to the user) way
possible?" In other words, this is a spiritual successor to the
"remote-suggested hooks" topic, in that we are still trying to solve the
same problem.

 - Emily
