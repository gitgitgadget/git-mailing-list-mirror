Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98B9C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 00:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B29261184
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 00:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhHUANc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 20:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhHUANc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 20:13:32 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D5AC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 17:12:53 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so17994282oth.7
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 17:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10EnCug5RCXkdnGwF1cQTKX9iMjqLzr2nnrPzsfkLjM=;
        b=FXXhLCVBq8FFavC6ixXTOtVgQyiogUVmqD/l4Q3Tn260NjP8ptd9dPs28nfAaitZzD
         z8h85d4IGRHTwIpvCeclDtvp3JoTGB6aEi3yJGQuK55i7+9CEd7MJ/V5BJ72Q8vi5B2h
         4WHBpkcfkkrNS84v/gU2o/aHN+snbHenZTtPJlS+mhis1r29b7puLHqdcAAFN7ob6qXs
         dZtoax9vUtALVQyzpIEvl0eIR57bTyZNGwh7OuIjfCmpcBuzOcqFLO91mr9uyWJHQdMu
         0xbAX2HeHTETwltoMHcUOiG00rn3lFgJYLD6sALqhmIe9T6HFYnzCBNsiRFlfpSzNvli
         lXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10EnCug5RCXkdnGwF1cQTKX9iMjqLzr2nnrPzsfkLjM=;
        b=GCW1f5TQSo4ehs2+wv/iclmCdc0ra9+sGmk01y/74XfytCxm6R/e3dXwmSWi5Gynhr
         T5Yr+y2xs4jlwPZKgAmSj09l9KGVzNKbow+TXYpKWI6LBWfwdGqaxBUmdwqIVX427Kda
         V6NeSVqkcmfCyTJc+9qkD9nGGSNUnTFualcRZZBTb4aoZg3ieVmPruxPAGANCyNjeVW+
         r99ATvvDNS5zKbEtvnISQd/HBygC7ZYFl12Tor+dMT0UnX3oR9L5NADIz3UgKVHnlbyf
         UqSQRUQBK+wLWvwWmFwOQCJeMWMygvVnSFRxwqYxZOUhNGcWDMA6mQ+ca6Fk8YFEzyzx
         WFAA==
X-Gm-Message-State: AOAM533hy+OpD/u8iFcAMormLLffwWTwl59ek2QBxAKLB/sGWjAV9ei5
        xmSMO2wFLkCCIcOskPPB5fi2jy3rhe6qsduzIZ4=
X-Google-Smtp-Source: ABdhPJweMP6FjxSOz7MwZ3altMkb2ecTbJE2F8R9Q21tDE4d4u81ohNFX0rE9jd18CVfl4Sj5wzOZdxQdh7YN0vMjTw=
X-Received: by 2002:a05:6808:2084:: with SMTP id s4mr4840938oiw.31.1629504772999;
 Fri, 20 Aug 2021 17:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com> <350ed86a4533d7fe332aebdf88cc474ceaf30ffe.1629220124.git.gitgitgadget@gmail.com>
In-Reply-To: <350ed86a4533d7fe332aebdf88cc474ceaf30ffe.1629220124.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Aug 2021 17:12:41 -0700
Message-ID: <CABPp-BF_djmCi6XdsMGx6F8fOqzJLog24rW=WsFo2VJgeyu99A@mail.gmail.com>
Subject: Re: [PATCH 6/6] sparse-index: integrate with cherry-pick and rebase
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 10:08 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The hard work was already done with 'git merge' and the ORT strategy.
> Just add extra tests to see that we get the expected results in the
> non-conflict cases.

:-)

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/rebase.c                         |  6 ++++
>  builtin/revert.c                         |  3 ++
>  t/t1092-sparse-checkout-compatibility.sh | 41 ++++++++++++++++++++++--
>  3 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 33e09619005..27433d7c5a2 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -559,6 +559,9 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>         argc = parse_options(argc, argv, prefix, options,
>                         builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
>
> +       prepare_repo_settings(the_repository);
> +       the_repository->settings.command_requires_full_index = 0;
> +
>         if (!is_null_oid(&squash_onto))
>                 opts.squash_onto = &squash_onto;
>
> @@ -1430,6 +1433,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                 usage_with_options(builtin_rebase_usage,
>                                    builtin_rebase_options);
>
> +       prepare_repo_settings(the_repository);
> +       the_repository->settings.command_requires_full_index = 0;
> +

While rebase can use either merge-recursive or merge-ort under the
covers, this change is okay because merge-recursive.c now has code to
expand the index unconditionally, and merge-ort does so only
conditionally in the cases needed.  Right?  (Same for change below to
revert.c)

>         options.allow_empty_message = 1;
>         git_config(rebase_config, &options);
>         /* options.gpg_sign_opt will be either "-S" or NULL */
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 237f2f18d4c..6c4c22691bd 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -136,6 +136,9 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>                         PARSE_OPT_KEEP_ARGV0 |
>                         PARSE_OPT_KEEP_UNKNOWN);
>
> +       prepare_repo_settings(the_repository);
> +       the_repository->settings.command_requires_full_index = 0;
> +
>         /* implies allow_empty */
>         if (opts->keep_redundant_commits)
>                 opts->allow_empty = 1;
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index a52d2edda54..c047b95b121 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -532,6 +532,38 @@ test_expect_success 'merge with conflict outside cone' '
>         test_all_match git rev-parse HEAD^{tree}
>  '
>
> +test_expect_success 'cherry-pick/rebase with conflict outside cone' '
> +       init_repos &&
> +
> +       for OPERATION in cherry-pick rebase
> +       do
> +               test_all_match git checkout -B tip &&
> +               test_all_match git reset --hard merge-left &&
> +               test_all_match git status --porcelain=v2 &&
> +               test_all_match test_must_fail git $OPERATION merge-right &&
> +               test_all_match git status --porcelain=v2 &&
> +
> +               # Resolve the conflict in different ways:
> +               # 1. Revert to the base
> +               test_all_match git checkout base -- deep/deeper2/a &&
> +               test_all_match git status --porcelain=v2 &&
> +
> +               # 2. Add the file with conflict markers
> +               test_all_match git add folder1/a &&
> +               test_all_match git status --porcelain=v2 &&
> +
> +               # 3. Rename the file to another sparse filename and
> +               #    accept conflict markers as resolved content.
> +               run_on_all mv folder2/a folder2/z &&
> +               test_all_match git add folder2 &&
> +               test_all_match git status --porcelain=v2 &&
> +
> +               test_all_match git $OPERATION --continue &&
> +               test_all_match git status --porcelain=v2 &&
> +               test_all_match git rev-parse HEAD^{tree} || return 1
> +       done
> +'
> +
>  test_expect_success 'merge with outside renames' '
>         init_repos &&
>
> @@ -670,9 +702,12 @@ test_expect_success 'sparse-index is not expanded' '
>         echo >>sparse-index/untracked.txt &&
>         ensure_not_expanded add . &&
>
> -       ensure_not_expanded checkout -f update-deep &&
> -       ensure_not_expanded merge -s ort -m merge update-folder1 &&
> -       ensure_not_expanded merge -s ort -m merge update-folder2
> +       for OPERATION in "merge -s ort -m merge" cherry-pick rebase
> +       do
> +               ensure_not_expanded checkout -f -B temp update-deep &&
> +               ensure_not_expanded $OPERATION update-folder1 &&
> +               ensure_not_expanded $OPERATION update-folder2 || return 1
> +       done

Won't this fail on linux-gcc in the automated testing, since it uses
GIT_TEST_MERGE_ALGORITHM=recursive and you didn't override the merge
strategy for cherry-pick and rebase?

To fix, you'd either need to put a GIT_TEST_MERGE_ALGORITHM=ort at the
beginning of the file, or add `--strategy ort` options to the
cherry-pick and rebase commands.


>  '
>
>  test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
> --
> gitgitgadget
