Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24CAC433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B3423442
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbhATTnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbhATTlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:41:16 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D251BC061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:40:35 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id i20so16707260otl.7
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoLuqZM41IBrJDBf+tUXHZhbroic5VZlnrpWFS6G1Js=;
        b=u8AjbTBUTeum0txNEN9sJkRRZgYUkPV9Ku555y98V5MpfObD0JtfhVn0kS7oc4dAmm
         6gtq5xcKEOb8Rra2SeOLqxmbHQYqBNRyUR5JxPFbTs4xyve3Nl6s9uIwzqpEpAWBjA6F
         n4gHKgMoaZpBCuEpwWzsL1cLzDI7E6b4QuLwAQBfO1EcBQfTuxB5qCYHVDx5oTf5A5oG
         F1iB+uK06fBu0+gE+kkVQOziLcTnq5/RsK/vy+XDXEdSxliisTIvuNvJ7FVQMgcNxP6S
         tPWNsxAIxiKjpXC02md0VWpY4DQSrxhNzOTt5UlypJqFs1qUBBRcT0txWa5XNaAgNpmK
         2UJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoLuqZM41IBrJDBf+tUXHZhbroic5VZlnrpWFS6G1Js=;
        b=W1gs6NGTWvSEYkHENzn8AnMP8RNbPJP1OEZ21mt+ycXAu0b1otAEpkQGinvmzmWQ0s
         BIeJl9QFb9M4AuSnWWSiVoTwy2qLXJFiANwGmgA/iD+6XDTA0FX5sWlPHPfPkYPxGD0S
         tcvw9RJQXz08ir2VQVs0UXNjPqtvJ2IuAMhyM49Jh3bv3ONkMfB9SLEVnwc7b90HjUXI
         o1oCIgjaMJkn9V+UVZXCKBvMiZzrnOq7dIAffaccvqDEq7Io+sviiEJkzSTLID3XCgLm
         xKUmUFaL36wamYHh1LFEsD4HHjjLSsGWzDit5ic72Qn+7OlCINjK8FF0cHRKg2VpGgbK
         8JYQ==
X-Gm-Message-State: AOAM531UsV5F+5W/p8Po4oxKofPnX9p9S1HU0LE6zQTaXcHdZcvVNBth
        M535RXuXmDc4jFbkdS0teyuFLlC6wR9l3JYPm1YVHiivpAbzzA==
X-Google-Smtp-Source: ABdhPJzTibn7TQDh2sk8eXmKpXFFt74cJmSOgewmo7que7nIfcTsveqw1O5VO5LZ+/xvG803wSYiW5vye/i1gQYFWVc=
X-Received: by 2002:a05:6830:402f:: with SMTP id i15mr6047889ots.345.1611171634498;
 Wed, 20 Jan 2021 11:40:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.git.1611161639.gitgitgadget@gmail.com> <555e210dc03e3966d39b84d5fd5d409038422c40.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <555e210dc03e3966d39b84d5fd5d409038422c40.1611161639.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jan 2021 11:40:23 -0800
Message-ID: <CABPp-BH=E4bR2K21e-p+ABTG02feDF7YNvrOKhsMW5Dtet6y7Q@mail.gmail.com>
Subject: Re: [PATCH 9/9] t1092: test interesting sparse-checkout scenarios
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 8:54 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> These also document some behaviors that differ from a full checkout, and
> possibly in a way that is not intended.

I'm in favor.  I should turn some of my noted weird behaviors from [1]
into testcases as well.

[1] https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 323 +++++++++++++++++++++++
>  1 file changed, 323 insertions(+)
>  create mode 100755 t/t1092-sparse-checkout-compatibility.sh
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> new file mode 100755
> index 00000000000..46f9dc2cdf3
> --- /dev/null
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -0,0 +1,323 @@
> +#!/bin/sh
> +
> +test_description='compare full workdir to sparse workdir'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +       git init initial-repo &&
> +       (
> +               cd initial-repo &&
> +               echo a >a &&
> +               echo "after deep" >e &&
> +               echo "after folder1" >g &&
> +               mkdir folder1 folder2 deep x &&
> +               mkdir deep/deeper1 deep/deeper2 &&
> +               mkdir deep/deeper1/deepest &&
> +               echo "after deeper1" >deep/e &&
> +               echo "after deepest" >deep/deeper1/e &&
> +               cp a folder1 &&
> +               cp a folder2 &&
> +               cp a deep &&
> +               cp a deep/deeper1 &&
> +               cp a deep/deeper2 &&
> +               cp a deep/deeper1/deepest &&
> +               git add . &&
> +               git commit -m "initial commit" &&
> +               git checkout -b base &&
> +               for dir in folder1 folder2 deep
> +               do
> +                       git checkout -b update-$dir &&
> +                       echo "updated $dir" >$dir/a &&
> +                       git commit -a -m "update $dir" || return 1
> +               done &&
> +
> +               git checkout -b rename-base base &&
> +               echo >folder1/larger-content <<-\EOF &&
> +               matching
> +               lines
> +               help
> +               inexact
> +               renames
> +               EOF
> +               cp folder1/larger-content folder2/ &&
> +               cp folder1/larger-content deep/deeper1/ &&
> +               git add . &&
> +               git commit -m "add interesting rename content" &&
> +
> +               git checkout -b rename-out-to-out rename-base &&
> +               mv folder1/a folder2/b &&
> +               mv folder1/larger-content folder2/edited-content &&
> +               echo >>folder2/edited-content &&
> +               git add . &&
> +               git commit -m "rename folder1/... to folder2/..." &&
> +
> +               git checkout -b rename-out-to-in rename-base &&
> +               mv folder1/a deep/deeper1/b &&
> +               mv folder1/larger-content deep/deeper1/edited-content &&
> +               echo >>deep/deeper1/edited-content &&
> +               git add . &&
> +               git commit -m "rename folder1/... to deep/deeper1/..." &&
> +
> +               git checkout -b rename-in-to-out rename-base &&
> +               mv deep/deeper1/a folder1/b &&
> +               mv deep/deeper1/larger-content folder1/edited-content &&
> +               echo >>folder1/edited-content &&
> +               git add . &&
> +               git commit -m "rename deep/deeper1/... to folder1/..." &&
> +
> +               git checkout -b deepest base &&
> +               echo "updated deepest" >deep/deeper1/deepest/a &&
> +               git commit -a -m "update deepest" &&
> +
> +               git checkout -f base &&
> +               git reset --hard
> +       )
> +'
> +
> +init_repos () {
> +       rm -rf full-checkout sparse-checkout sparse-index &&
> +
> +       # create repos in initial state
> +       cp -r initial-repo full-checkout &&
> +       git -C full-checkout reset --hard &&
> +
> +       cp -r initial-repo sparse-checkout &&
> +       git -C sparse-checkout reset --hard &&
> +       git -C sparse-checkout sparse-checkout init --cone &&
> +
> +       # initialize sparse-checkout definitions
> +       git -C sparse-checkout sparse-checkout set deep
> +}
> +
> +run_on_sparse () {
> +       (
> +               cd sparse-checkout &&
> +               $* >../sparse-checkout-out 2>../sparse-checkout-err
> +       )
> +}
> +
> +run_on_all () {
> +       (
> +               cd full-checkout &&
> +               $* >../full-checkout-out 2>../full-checkout-err
> +       ) &&
> +       run_on_sparse $*
> +}
> +
> +test_all_match () {
> +       run_on_all $* &&
> +       test_cmp full-checkout-out sparse-checkout-out &&
> +       test_cmp full-checkout-err sparse-checkout-err
> +}
> +
> +test_expect_success 'status with options' '
> +       init_repos &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git status --porcelain=v2 -z -u &&
> +       test_all_match git status --porcelain=v2 -uno &&
> +       run_on_all "touch README.md" &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git status --porcelain=v2 -z -u &&
> +       test_all_match git status --porcelain=v2 -uno &&
> +       test_all_match git add README.md &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git status --porcelain=v2 -z -u &&
> +       test_all_match git status --porcelain=v2 -uno
> +'
> +
> +test_expect_success 'add, commit, checkout' '
> +       init_repos &&
> +
> +       write_script edit-contents <<-\EOF &&
> +       echo text >>README.md
> +       EOF
> +       run_on_all "../edit-contents" &&
> +
> +       test_all_match git add README.md &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git commit -m "Add README.md" &&
> +
> +       test_all_match git checkout HEAD~1 &&
> +       test_all_match git checkout - &&
> +
> +       run_on_all "../edit-contents" &&
> +
> +       test_all_match git add -A &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git commit -m "Extend README.md" &&
> +
> +       test_all_match git checkout HEAD~1 &&
> +       test_all_match git checkout -
> +'

I was going to add comments here, but I noticed the next test had the
same description and looked very similar, so I'll defer the
comments...

> +
> +test_expect_success 'add, commit, checkout' '
> +       init_repos &&
> +
> +       write_script edit-contents <<-\EOF &&
> +       echo text >>$1
> +       EOF
> +       run_on_all "../edit-contents README.md" &&
> +
> +       test_all_match git add README.md &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git commit -m "Add README.md" &&
> +
> +       test_all_match git checkout HEAD~1 &&
> +       test_all_match git checkout - &&
> +
> +       run_on_all "../edit-contents README.md" &&
> +
> +       test_all_match git add -A &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git commit -m "Extend README.md" &&
> +
> +       test_all_match git checkout HEAD~1 &&
> +       test_all_match git checkout - &&

Up to here, this test is identical to the previous one.  Why repeat it?

> +
> +       run_on_all "../edit-contents deep/newfile" &&
> +
> +       test_all_match git status --porcelain=v2 -uno &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git add . &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git commit -m "add deep/newfile" &&
> +
> +       test_all_match git checkout HEAD~1 &&
> +       test_all_match git checkout -
> +'

Think out loud...so you are only adding files that were not previously
tracked and that would have been part of the sparse cone.  You aren't
trying to add files that would be outside the sparse cone, or manually
creating files missing from the working tree due to sparseness and
then attempting to add them.  (Which is fine, we have to start
somewhere with our testing.  Also, I think my testcases didn't look at
the case you did, and only covered one of these other two cases.)

> +
> +test_expect_success 'checkout and reset --hard' '
> +       init_repos &&
> +
> +       test_all_match git checkout update-folder1 &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       test_all_match git checkout update-deep &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       test_all_match git checkout -b reset-test &&
> +       test_all_match git reset --hard deepest &&
> +       test_all_match git reset --hard update-folder1 &&
> +       test_all_match git reset --hard update-folder2
> +'
> +
> +test_expect_success 'diff --staged' '
> +       init_repos &&
> +
> +       write_script edit-contents <<-\EOF &&
> +       echo text >>README.md
> +       EOF
> +       run_on_all "../edit-contents" &&
> +
> +       test_all_match git diff &&
> +       test_all_match git diff --staged &&
> +       test_all_match git add README.md &&
> +       test_all_match git diff &&
> +       test_all_match git diff --staged
> +'

Also a case where you're operating on a file that matches the sparsity
patterns (in cone mode, everything in the root directory is included).

> +test_expect_success 'diff with renames' '
> +       init_repos &&
> +
> +       for branch in rename-out-to-out rename-out-to-in rename-in-to-out
> +       do
> +               test_all_match git checkout rename-base &&
> +               test_all_match git checkout $branch -- .&&
> +               test_all_match git diff --staged &&
> +               test_all_match git diff --staged --find-renames || return 1

Aren't these last two lines the same? (diff.renames defaults to true
ever since commit 5404c116aa, "diff: activate diff.renames by
default", 2016-02-25)  Are they only different because you have a
tweaked config that turns off renames by default?

Perhaps the first diff line should have a --no-renames flag.

> +       done
> +'
> +
> +test_expect_success 'log with pathspec outside sparse definition' '
> +       init_repos &&
> +
> +       test_all_match git log -- a &&
> +       test_all_match git log -- folder1/a &&
> +       test_all_match git log -- folder2/a &&
> +       test_all_match git log -- deep/a &&
> +       test_all_match git log -- deep/deeper1/a &&
> +       test_all_match git log -- deep/deeper1/deepest/a &&
> +
> +       test_all_match git checkout update-folder1 &&
> +       test_all_match git log -- folder1/a
> +'
> +
> +test_expect_success 'blame with pathspec inside sparse definition' '
> +       init_repos &&
> +
> +       test_all_match git blame a &&
> +       test_all_match git blame deep/a &&
> +       test_all_match git blame deep/deeper1/a &&
> +       test_all_match git blame deep/deeper1/deepest/a
> +'

Good check.

On a side note going back to a piece of the other thread I didn't get
a response to, I'm still curious whether
    git blame -C -C $PATH_INSIDE_SPARSE_DEFINITION
should (optionally?) behave differently in a sparse checkout.  In
particular, should it limit its copy detection to other paths also in
the sparse checkout, or should it always search all other files within
the repository for copied lines?  Searching just within the sparse
checkout seems like it could be a really nice performance
optimization.

> +
> +# TODO: blame currently does not support blaming files outside of the
> +# sparse definition. It complains that the file doesn't exist locally.

Nice catch.  Yeah, blame tries to check the local working copy for
changes, and shows those lines with a changed in commit 0000000000.
We should add a check that says that if the file is SKIP_WORKTREE,
then we treat it the same as `git blame $PATH HEAD`.

> +test_expect_failure 'blame with pathspec outside sparse definition' '
> +       init_repos &&
> +
> +       test_all_match git blame folder1/a &&
> +       test_all_match git blame folder2/a &&
> +       test_all_match git blame deep/deeper2/a &&
> +       test_all_match git blame deep/deeper2/deepest/a
> +'
> +
> +# TODO: reset currently does not behave as expected when in a
> +# sparse-checkout.

I'm going to go to test this out to see what it does.  It's the first
testcase you listed that I didn't know how it worked and couldn't
figure it out from your comments.  However it turns out, definitely a
good test to have.

> +test_expect_failure 'checkout and reset (mixed)' '
> +       init_repos &&
> +
> +       test_all_match git checkout -b reset-test update-deep &&
> +       test_all_match git reset deepest &&
> +       test_all_match git reset update-folder1 &&
> +       test_all_match git reset update-folder2
> +'
> +
> +test_expect_success 'merge' '
> +       init_repos &&
> +
> +       test_all_match git checkout -b merge update-deep &&
> +       test_all_match git merge -m "folder1" update-folder1 &&
> +       test_all_match git rev-parse HEAD^{tree} &&
> +       test_all_match git merge -m "folder2" update-folder2 &&
> +       test_all_match git rev-parse HEAD^{tree}
> +'
> +
> +test_expect_success 'merge with outside renames' '
> +       init_repos &&
> +
> +       for type in out-to-out out-to-in in-to-out
> +       do
> +               test_all_match git reset --hard &&
> +               test_all_match git checkout -f -b merge-$type update-deep &&
> +               test_all_match git merge -m "$type" rename-$type &&
> +               test_all_match git rev-parse HEAD^{tree} || return 1
> +       done
> +'
> +
> +test_expect_success 'clean' '
> +       init_repos &&
> +
> +       echo bogus >>.gitignore &&
> +       run_on_all cp ../.gitignore . &&
> +       test_all_match git add .gitignore &&
> +       test_all_match git commit -m ignore-bogus-files &&
> +
> +       run_on_sparse mkdir folder1 &&
> +       run_on_all touch folder1/bogus &&
> +
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git clean -f &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       test_all_match git clean -xf &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       test_all_match git clean -xdf &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       test_path_is_dir sparse-checkout/folder1
> +'
> +
> +test_done
> --

I made lots of comments, but overall these tests look good to me other
than just one question about test duplication and another about using
--no-renames for diff when rename detection isn't wanted.
