Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C17AC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhK2XLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbhK2XLa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:11:30 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D221C04C33B
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:30:51 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x131so18422940pfc.12
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PVAIOIrW+N955RS2utYt/mJK0iOMLzDjNAzLQQHXDa8=;
        b=TzMHVPB/JI5mT6K8Iumn4YPxHJFuKfcd2n1OPaegKQlRIfO/18zrntdGmP76JYJy9h
         bFc3NmJL7n2m95Z9LDvWw6D9nXWhXLuAalteQC7hlq1Jfs5Ofgh8KMEaBThe8MC762qJ
         W1HloPat5txewmWwaZaIVennLnmy/lPog0fmcxv0i75708QwzxiR6cOfhuzU7VNhdrcQ
         zA5NfOGWHSP8uOdF6qMQVO8tnu6fYcoL+yy7de7OeDh+60rm71c8SIgUXlHnsgL08S+g
         KBHIjVu9JTvIdEWTd2PhuorEo74DJpu++arzF0kVdezqjMjV9/oKLVTBrWKkGyyzrJDc
         IV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PVAIOIrW+N955RS2utYt/mJK0iOMLzDjNAzLQQHXDa8=;
        b=MY30qjgcCMiRxEzmu8LXA4mvyTST27uYrGWtPulruavehtKW6y8Lb+bnv7zxV0DbZx
         W41tbLSXJvhutO2j1i8uztw188Wy/K6m7jtN8DM6H7CK2MMxWSa6RAL46WqP7VN2Z+pw
         tQHBS3I+uSQY/wtD89iaUbG+syaNBtQdhU+OPcyUV9bZB94Zxr7u78u9TU04L+tHt4qR
         01EIRqteFXhG1Ckn2vsXAqYiOGsEkY/hPNZJ9+9FPesFyd7CIZo1JD0GPkbqO5CYLAE3
         kzkIAVNxZT2TJoo6Q213qfDiuJfYauaVMRC6B6nZ6P6OYDfHiKCNjcHNsJu8kRnzDJsd
         Ld5A==
X-Gm-Message-State: AOAM531QkjyhbToHJ1BsYkATTDuoPbnD8sYEqvyoX3T+gmQpdxDyuLj8
        frmBMwDQIOJF0oj0HQEtLmbt7A==
X-Google-Smtp-Source: ABdhPJwHViE/sALcjBycXuXcfT6efOmS2Es3e9YFNckE1CEd7sv0NL8X2xEcMLoPDr1PDvIanp/rnQ==
X-Received: by 2002:a63:3c0f:: with SMTP id j15mr20819566pga.243.1638225050707;
        Mon, 29 Nov 2021 14:30:50 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:ac8a:2304:bdf1:44e9])
        by smtp.gmail.com with ESMTPSA id e11sm320389pjl.20.2021.11.29.14.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:30:49 -0800 (PST)
Date:   Mon, 29 Nov 2021 14:30:45 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, gitscale@google.com
Subject: Submodules UX overhaul update (was: What's cooking in git.git (Nov
 2021, #06; Wed, 24))
Message-ID: <YaVUlYVa5ZWCIInd@google.com>
References: <xmqqlf1caica.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlf1caica.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 24, 2021 at 09:56:53PM -0800, Junio C Hamano wrote:
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

Update on es/superproject-aware-submodules to follow.

> --------------------------------------------------
> [Cooking]
> 
> * gc/remote-with-fewer-static-global-variables (2021-11-18) 5 commits
>  - remote: die if branch is not found in repository
>  - remote: remove the_repository->remote_state from static methods
>  - remote: use remote_state parameter internally
>  - remote: move static variables into per-repository struct
>  - t5516: add test case for pushing remote refspecs
> 
>  Code clean-up to eventually allow information on remotes defined
>  for an arbitrary repository to be read.
> 
>  Will merge to 'next'.

Thanks.

> * ab/config-based-hooks-2 (2021-11-24) 18 commits
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

I think I haven't looked at the update on 2021-11-01, so I probably owe
a review. Other reviews welcome, since I have bias :)

> * js/branch-track-inherit (2021-11-18) 1 commit
>  - branch: add flags and config to inherit tracking
> 
>  "git -c branch.autosetupmerge=inherit branch new old" makes "new"
>  to have the same upstream as the "old" branch, instead of marking
>  "old" itself as its upstream.

We're hoping this one will pave the way for a user to run simply 'git
push' from the superproject and have all submodules push to the correct
branch, even if it's different from the superproject's branch.

> * es/superproject-aware-submodules (2021-11-18) 5 commits
>  - submodule: use config to find superproject worktree
>  - submodule: record superproject gitdir during 'update'
>  - submodule: record superproject gitdir during absorbgitdirs
>  - introduce submodule.superprojectGitDir record
>  - t7400-submodule-basic: modernize inspect() helper
> 
>  A configuration variable in a submodule points at the location of
>  the superproject it is bound to (RFC).

Needs another reroll, but there is some quibbling over whether it makes
sense for this series to exist at all (or whether to just search the
filesystem every time we think we might be in a submodule). Ævar asked
for some benchmarking, I'll see if I can find some time.

Missing from this list, a few things we're still worried about:

Glen Choo: implement branch --recurse-submodules
https://lore.kernel.org/git/20211122223252.19922-1-chooglen%40google.com

An example implementation of 'git branch --recurse-submodules' in line
with the previously discussed RFC.

Jonathan Tan: Conditional config includes based on remote URL
https://patchwork.kernel.org/project/git/patch/cover.1637020610.git.jonathantanmy%40google.com

This one should allow users to distribute config-based hooks more
easily in managed environments where /etc/gitconfig is distributed to
all users, or by package manager via clever postinstall scripts.

 - Emily
