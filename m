Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E38C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE7D6141E
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhDUApc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhDUApc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 20:45:32 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088F3C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 17:45:00 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id e89-20020a9d01e20000b0290294134181aeso11725281ote.5
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 17:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvO1zC5yOzFRMXPr+G4rUktKXAt97PKnebfwKPfXt1A=;
        b=ebQ9istjkkKFpqIXDsL7v6FxR0wXDa4OBX7qptDGDtlsPGAmli56ls8SgPqNRmpIXE
         qjLi39PUeP6wM05YeD6e9CKUNSQx0kifn/rwSYdcEsWTjX/MhBmV+fC7Wm5CcO1mis/p
         Y0/CHZeH6nNuDWrFhZpEH+Ct1ZCcKk4HQ6q6HqZtjWYjsrE0AdBeP5Xc1VYn59E8icR/
         aMoIRDoTLejw7Jwp0BRgm7nm3loPL7yBs8gASb3g3kWyese3J6+MF2HMQiQXdWp3lLql
         +CuFFM8yX5KhdHx+IK1Mjxg2tukqF9vPZDeJ0/mn9dwj23oskRFnkjyBchwkAOUKJInM
         Y2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvO1zC5yOzFRMXPr+G4rUktKXAt97PKnebfwKPfXt1A=;
        b=CS3fE6KRrhYwzYYTL1BkrkjZSItdBsa7FY6oiCPiQXRi9H7Ev3LFDJTRhnBYAvHFGS
         nKEyIa7fnG1M3xvOg8O/cA0EPvjku+T4Lsmxc2ogTz7+hmtG3MoGr1EW+WFWMUBc9/Sy
         w5osz/L5kXg1iFtzmVPDZt6zTHDfXEkyf+eppxw1PwJKmI+zpJ1sgishyoy9jKBhHJh9
         bN8vXNeRf8h8EfVBSWj5UgylarMVI99fo83ypPUOJZJlIlTcbj7FF3teKBBJNRhFwyWW
         ++198/irvcVDXx2y4E/m7ZyOy/sYgkDdSHSFaSiy1lJHlsMxXtaF9zPtBWjBL5EBCZOA
         +uPA==
X-Gm-Message-State: AOAM533S6rqMmaa3d0fxiaYLZ1dKH0a0parox2nsM4Bz5bzveua+I2Z7
        fAjg3ZlLsHpx7ct6InaX/9+X0XIAVGMGeMWcvr4=
X-Google-Smtp-Source: ABdhPJyhpNpKrK44p2RqBV7lRIBXqZv3uMicUKfGdgIequA9UghIhoU92h4RNOuRop+DmrIw0yUmiDl+e2pCENyApXE=
X-Received: by 2002:a9d:8a6:: with SMTP id 35mr20995615otf.316.1618965899303;
 Tue, 20 Apr 2021 17:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com> <d7d4cad8be0b2a27a332a2796ba0dce92783355f.1618322497.git.gitgitgadget@gmail.com>
In-Reply-To: <d7d4cad8be0b2a27a332a2796ba0dce92783355f.1618322497.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Apr 2021 17:44:48 -0700
Message-ID: <CABPp-BHzfcCNqhHOnK0gsC1r6XX9KAqMYVHhsAzdLpJj5E5TEw@mail.gmail.com>
Subject: Re: [PATCH 05/10] status: use sparse-index throughout
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> By testing 'git -c core.fsmonitor= status -uno', we can check for the
> simplest index operations that can be made sparse-aware. The necessary
> implementation details are already integrated with sparse-checkout, so
> modify command_requires_full_index to be zero for cmd_status().
>
> By running the debugger for 'git status -uno' after that change, we find
> two instances of ensure_full_index() that were added for extra safety,
> but can be removed without issue.
>
> In refresh_index(), we loop through the index entries. The
> refresh_cache_ent() method copies the sparse directories into the
> refreshed index without issue.

I do see the removal of a call to ensure_full_index() in
refresh_index() that you mention in this paragraph in the patch below.

I'm confused, though; I would have thought we wanted to avoid a
refresh_cache_ent() call.  Also, one of your previous patches added a

    if (istate->sparse_index && S_ISSPARSEDIR(ce->ce_mode))
        continue;

check before the code ever gets to the refresh_cache_ent() call, so as
far as I can tell, that function won't be called from refresh_entry()
for sparse entries.  Maybe your commit message here is out-of-date?
Or am I confused somehow?

> The loop within run_diff_files() skips things that are in stage 0 and
> have skip-worktree enabled, so seems safe to disable ensure_full_index()
> here.

Unlike the above, I don't see a removal of a ensure_full_index() call
in run_diff_files() as claimed by this paragraph.  Has the commit
message gotten out of date with refactorings you did while developing
this series?

> This allows some cases of 'git status' to no longer expand a sparse
> index to a full one, giving the following performance improvements for
> p2000-sparse-checkout-operations.sh:
>
> Test                                  HEAD~1           HEAD
> -----------------------------------------------------------------------------
> 2000.2: git status (full-index-v3)    0.38(0.36+0.07)  0.37(0.31+0.10) -2.6%
> 2000.3: git status (full-index-v4)    0.38(0.29+0.12)  0.37(0.30+0.11) -2.6%
> 2000.4: git status (sparse-index-v3)  2.43(2.33+0.14)  0.04(0.05+0.04) -98.4%
> 2000.5: git status (sparse-index-v4)  2.44(2.35+0.13)  0.05(0.04+0.07) -98.0%
>
> Note that since HEAD~1 was expanding the sparse index by parsing trees,
> it was artificially slower than the full index case. Thus, the 98%
> improvement is misleading, and instead we should celebrate the 0.37s to
> 0.05s improvement of 82%. This is more indicative of the peformance
> gains we are expecting by using a sparse index.

82%, very nice.  Was this with git.git as the test repository, or some
other repo?  If it's git.git, then we'd actually expect a much bigger
speedup for other repositories, as git.git is pretty small.


> Note: we are dropping the assignment of core.fsmonitor here. This is not
> necessary for the test script as we are not altering the config any
> other way. Correct integration with FS Monitor will be validated in
> later changes.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/commit.c                         |  3 +++
>  read-cache.c                             |  2 --
>  t/t1092-sparse-checkout-compatibility.sh | 12 ++++++++----
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index cf0c36d1dcb2..e529da7beadd 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1404,6 +1404,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>         if (argc == 2 && !strcmp(argv[1], "-h"))
>                 usage_with_options(builtin_status_usage, builtin_status_options);
>
> +       prepare_repo_settings(the_repository);
> +       the_repository->settings.command_requires_full_index = 0;
> +
>         status_init_config(&s, git_status_config);
>         argc = parse_options(argc, argv, prefix,
>                              builtin_status_options,
> diff --git a/read-cache.c b/read-cache.c
> index 6308234b4838..83e6bdef7604 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1578,8 +1578,6 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>          */
>         preload_index(istate, pathspec, 0);
>         trace2_region_enter("index", "refresh", NULL);
> -       /* TODO: audit for interaction with sparse-index. */
> -       ensure_full_index(istate);
>         for (i = 0; i < istate->cache_nr; i++) {
>                 struct cache_entry *ce, *new_entry;
>                 int cache_errno = 0;
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index e488ef9bd941..380a085f8ec4 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -449,12 +449,16 @@ test_expect_success 'sparse-index is expanded and converted back' '
>         GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
>                 git -C sparse-index -c core.fsmonitor="" reset --hard &&
>         test_region index convert_to_sparse trace2.txt &&
> -       test_region index ensure_full_index trace2.txt &&
> +       test_region index ensure_full_index trace2.txt
> +'
>
> -       rm trace2.txt &&
> +test_expect_success 'sparse-index is not expanded' '
> +       init_repos &&
> +
> +       rm -f trace2.txt &&
>         GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> -               git -C sparse-index -c core.fsmonitor="" status -uno &&
> -       test_region index ensure_full_index trace2.txt
> +               git -C sparse-index status -uno &&
> +       test_region ! index ensure_full_index trace2.txt
>  '
>
>  test_done
> --
> gitgitgadget

Other than what looks like a couple issues in the commit message, the
change looks good to me.
