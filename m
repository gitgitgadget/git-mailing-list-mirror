Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8237FC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 15:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiKDPUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 11:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiKDPUr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 11:20:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37913640E
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 08:20:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bk15so7465822wrb.13
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1znbldeAJZsmUsM6OiHnlDfEOkRTXLYyRj4lyrafGWU=;
        b=nOfK6qF076cNgvxFdbGDMxf5ihlivcrlKhMdASr8VxfTOmCOMoh1aAr+VWpI/3KYnn
         tEJJmlpldW9xGK+U+vHrqT0k3tA7yzoqnlWYd88l/gJk/bqkZ5fPJOt8wY4YBQlrAbPi
         rpzWUM57YG40crSOvu77rkSESWvhDFU0QNHY5Pezq3Co6oyvx24/TNjUrDiQ8N3FD4Mx
         fO7tgyRqoSvsiExV8pMVqmV6ZVPazng+mJG9i9JZn3H4rfuJZ7VfFMvFkVCHoQEQxwY1
         iMLdxzkNFxop5TBQG+UdUAfBH4oB3a8U9g7xFHQJWiNywAWbr/+zpu96dbqGHi/3i6EJ
         Fldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1znbldeAJZsmUsM6OiHnlDfEOkRTXLYyRj4lyrafGWU=;
        b=ajq773CLDOf1L4DEhIzSsFcFu7lVRPm7/CLAzA9mqYPyAQMiXMIj7+qVPSg2SJEAQ+
         vLy3EiG8BttSWRLR4+Y0orrS7lzeYl8BnansEizayEnzLa2dFZyHF3PvDTDkSNxpl9Jb
         2KZAR8JFZIOODp7wVHvZB6PXprchpjDnaYShj1rJEEYzW8wJHLStjZVBBf+15p9cd0mz
         U9pY7mzcgO2L68NmgxhGjFwG4+8swCLsHMEBLEnwHH4V1HFixM3syD7G6StBSiHipOtS
         0jqyo7+2g7lCBIMjPtZDwKK3XK/lqs1dSXMUuYLXDcZEaY9bptoCmXyGjOimH/e320YA
         7zng==
X-Gm-Message-State: ACrzQf3eD+ElYlzTY99/S2mVu6nFcsWVzYen3a4RUZOQ0icNmRCYEjan
        ZsVdNIurjvmvLPvQAcVKqeg=
X-Google-Smtp-Source: AMsMyM5j82xCKvoMr6Da8KjfxfqsKCoxk5wyN/0BoYP+F9PdPD3Eq5oRJ4rbk1XFb6/z9MxnL5XTEQ==
X-Received: by 2002:a05:6000:5c4:b0:236:cbbb:5576 with SMTP id bh4-20020a05600005c400b00236cbbb5576mr18883978wrb.591.1667575244715;
        Fri, 04 Nov 2022 08:20:44 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d434e000000b0023677fd2657sm3609865wrr.52.2022.11.04.08.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 08:20:44 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <8eec228d-d392-523d-2415-149b946f642e@dunelm.org.uk>
Date:   Fri, 4 Nov 2022 15:20:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/17] leak fixes: use existing constructors & other
 trivia
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/11/2022 17:05, Ævar Arnfjörð Bjarmason wrote:
> With the very minor exceptions of:
> 
> * 03-04/17 (which need trivial oilerplate)
> * 05/17 (need to add trivial control flow to a free_*() function)
> * 12/17 (narrowing scope of allocation)

I've only looked at the rebase related patches. I'd really appreciate it 
if you could drop patches 12 & 14 as they conflict with [1] that fixes 
these issues by removing the setenv() calls.

Thanks

Phillip

[1] 
https://lore.kernel.org/git/pull.1405.git.1667575142.gitgitgadget@gmail.com

> * 17/17: Add "goto ret" pattern, combine two "ret" variables
> 
> These are all "one-line" leak fixes where we merely need to make use
> of an existing release function. The "one-line" only having the slight
> disclaimer of needing to e.g. add braces to an "if" in one case, etc.
> 
> Each commit in this series is tested with:
> 
> 	GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_SANITIZE_LEAK_LOG=true \
> 	make SANITIZE=leak test
> 
> I.e. mark tests as leak-free as we fix the leaks.
> 
> In 17/17 I replace uses of UNLEAK() where we can just as easily free()
> instead, i.e. most of it's built-ins doing UNLEAK(x) instead of
> strbuf_release(&x) etc.
> 
> As 17/17 notes I still think these's a place for unleak (some of the
> remaining ones are quite tricky), but that we gain more from leaving
> it for those tricky cases. Before this series we have 28 uses of
> UNLEAK(), after it's 15.
> 
> Ævar Arnfjörð Bjarmason (17):
>    tests: mark tests as passing with SANITIZE=leak
>    {reset,merge}: call discard_index() before returning
>    commit: discard partial cache before (re-)reading it
>    read-cache.c: clear and free "sparse_checkout_patterns"
>    dir.c: free "ident" and "exclude_per_dir" in "struct untracked_cache"
>    built-ins & libs & helpers: add/move destructors, fix leaks
>    unpack-file: fix ancient leak in create_temp_file()
>    revision API: call graph_clear() in release_revisions()
>    ls-files: fix a --with-tree memory leak
>    sequencer.c: fix "opts->strategy" leak in read_strategy_opts()
>    connected.c: free the "struct packed_git"
>    sequencer.c: fix a pick_commits() leak
>    rebase: don't leak on "--abort"
>    sequencer.c: fix sequencer_continue() leak
>    cherry-pick: free "struct replay_opts" members
>    revert: fix parse_options_concat() leak
>    built-ins: use free() not UNLEAK() if trivial, rm dead code
> 
>   builtin/add.c                            |  2 +-
>   builtin/bugreport.c                      |  9 +++--
>   builtin/checkout.c                       |  2 ++
>   builtin/commit.c                         | 13 +++++---
>   builtin/config.c                         | 42 +++++++++++-------------
>   builtin/diff.c                           |  2 +-
>   builtin/ls-files.c                       |  1 +
>   builtin/merge.c                          |  1 +
>   builtin/rebase.c                         |  4 +++
>   builtin/repack.c                         |  2 +-
>   builtin/reset.c                          |  2 ++
>   builtin/rev-parse.c                      |  1 +
>   builtin/revert.c                         |  4 +++
>   builtin/stash.c                          |  2 ++
>   builtin/unpack-file.c                    |  1 +
>   builtin/worktree.c                       |  7 ++--
>   connected.c                              |  6 +++-
>   dir.c                                    | 10 ++++--
>   dir.h                                    |  1 +
>   read-cache.c                             |  5 +++
>   ref-filter.c                             |  1 +
>   revision.c                               |  1 +
>   sequencer.c                              | 12 +++++--
>   t/helper/test-fake-ssh.c                 |  1 +
>   t/t0068-for-each-repo.sh                 |  1 +
>   t/t0070-fundamental.sh                   |  1 +
>   t/t1011-read-tree-sparse-checkout.sh     |  1 +
>   t/t1022-read-tree-partial-clone.sh       |  2 +-
>   t/t1404-update-ref-errors.sh             |  2 ++
>   t/t1409-avoid-packing-refs.sh            |  1 +
>   t/t1413-reflog-detach.sh                 |  1 +
>   t/t1501-work-tree.sh                     |  2 ++
>   t/t2012-checkout-last.sh                 |  1 +
>   t/t2018-checkout-branch.sh               |  1 +
>   t/t2025-checkout-no-overlay.sh           |  1 +
>   t/t3009-ls-files-others-nonsubmodule.sh  |  1 +
>   t/t3010-ls-files-killed-modified.sh      |  2 ++
>   t/t3050-subprojects-fetch.sh             |  1 +
>   t/t3060-ls-files-with-tree.sh            |  2 ++
>   t/t3409-rebase-environ.sh                |  1 +
>   t/t3413-rebase-hook.sh                   |  1 +
>   t/t3428-rebase-signoff.sh                |  1 +
>   t/t3429-rebase-edit-todo.sh              |  1 +
>   t/t3433-rebase-across-mode-change.sh     |  1 +
>   t/t4015-diff-whitespace.sh               |  4 +--
>   t/t4045-diff-relative.sh                 |  2 ++
>   t/t4052-stat-output.sh                   |  1 +
>   t/t4053-diff-no-index.sh                 |  1 +
>   t/t4067-diff-partial-clone.sh            |  1 +
>   t/t4111-apply-subdir.sh                  |  1 +
>   t/t4135-apply-weird-filenames.sh         |  1 +
>   t/t4213-log-tabexpand.sh                 |  1 +
>   t/t5544-pack-objects-hook.sh             |  2 ++
>   t/t5554-noop-fetch-negotiator.sh         |  2 ++
>   t/t5610-clone-detached.sh                |  1 +
>   t/t5611-clone-config.sh                  |  1 +
>   t/t5614-clone-submodules-shallow.sh      |  1 +
>   t/t5617-clone-submodules-remote.sh       |  1 +
>   t/t5618-alternate-refs.sh                |  2 ++
>   t/t6060-merge-index.sh                   |  2 ++
>   t/t6301-for-each-ref-errors.sh           |  1 +
>   t/t6401-merge-criss-cross.sh             |  2 ++
>   t/t6406-merge-attr.sh                    |  1 +
>   t/t6407-merge-binary.sh                  |  1 +
>   t/t6415-merge-dir-to-symlink.sh          |  1 +
>   t/t6435-merge-sparse.sh                  |  1 +
>   t/t7103-reset-bare.sh                    |  2 +-
>   t/t7504-commit-msg-hook.sh               |  1 +
>   t/t7517-per-repo-email.sh                |  1 +
>   t/t7520-ignored-hook-warning.sh          |  1 +
>   t/t7605-merge-resolve.sh                 |  1 +
>   t/t7614-merge-signoff.sh                 |  1 +
>   t/t9003-help-autocorrect.sh              |  2 ++
>   t/t9115-git-svn-dcommit-funky-renames.sh |  1 -
>   t/t9146-git-svn-empty-dirs.sh            |  1 -
>   t/t9148-git-svn-propset.sh               |  1 -
>   t/t9160-git-svn-preserve-empty-dirs.sh   |  1 -
>   77 files changed, 150 insertions(+), 51 deletions(-)
> 
