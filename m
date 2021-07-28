Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE8CC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 23:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0585460BD3
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 23:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhG1XNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 19:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhG1XNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 19:13:47 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163D0C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 16:13:45 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id x15-20020a05683000cfb02904d1f8b9db81so3818200oto.12
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 16:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ct/pY5Jc3umgLBhAZFYKFFX2Pc54VG662CJmRVZ0gf8=;
        b=UrfewwJRFiaYfbnMUp7nLuXu0DXI+RWhs8m6e3Rg5GZm+x4RxYQbgerx6Sqr/EKQif
         gW/bInO5Awv8HO5RfuLjtzBDmR/6OTGdukEOKyyjO4OeTh5deGK3Ms0bBxQ6mIUWDSxQ
         alkwN5v5zfnJSQFfyGEZQXhAoOcBSJzrVL2oReuBzGYUQiySWHsVXYZ9zXZRRi43n+tn
         BL7Cj7ayp7Inf16QcKNZYpFH6zCulhuP25GvQmdHAXO4YDZHip/jYgo/n8nzRyW+QvY2
         Bh38G3LGOXsdNWDJoPstS7QSVKxxFdpUEzmmd+x/saSyGACA+wD8+eAH5SxdRZ3JwwUg
         kRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ct/pY5Jc3umgLBhAZFYKFFX2Pc54VG662CJmRVZ0gf8=;
        b=qS7WEpXAymoMqIBxEkep51GWNqLgjJwt3EcofC3O6VGv3MbA7+s1v5s2/C3z7kQ+lI
         y/SE+GGArCM1AJAjAOnIucAKLfX6DV+VJSWO2LH9G1i2BBFvqnNIr+KeBOaiIOl68ZzN
         gKjqEVBsQ/hrSVGGmXKIUE+qQZ40nR0gH6i0f9sVCJE/EWdBkEqr/yMDY54gS8z2R1TM
         M5V/6y5FA59h3mq5aqGp/Z4jj3lAGLzzRUr1yBlmtu5qIot73mImM2MqYrt8tgg43ho6
         29JPx+3HUqgyaqJADhMjlmiG98rmPHzl2+WEwvH1DnygfzoHzAXpvwhsRMomMaI4yY1e
         V4Wg==
X-Gm-Message-State: AOAM531MHdt621iWD9X50+DqPHgeGvDqbiOevgkKNIR7z6E4AYNBWgot
        3plAoh7er0iUkTRItowmSIIFHRjVJKDoAhQDbd8=
X-Google-Smtp-Source: ABdhPJwnB0c0IHpxCEIpb/buTrDYci2crlAb2AWWB9/DK6F0mVTwV9DLK5VyI+HZT/JeC6YzLVV6xaYwK4u9wIDntfE=
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr1541990ots.162.1627514024432;
 Wed, 28 Jul 2021 16:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.999.git.1626901619.gitgitgadget@gmail.com> <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 28 Jul 2021 17:13:33 -0600
Message-ID: <CABPp-BHnvEPuYahFAoVSF58k99t__N2-M4OKKHDAAK2qrhY3WQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse Index: Integrate with 'git add'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 26, 2021 at 9:18 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This patch series re-submits the 'git add' integration with sparse-index.
> The performance gains are the same as before.
>
> It is based on ds/commit-and-checkout-with-sparse-index.
>
> This series was delayed from its initial submission for a couple reasons.
>
> The first was because it was colliding with some changes in
> mt/add-rm-in-sparse-checkout, so now we are far enough along that that
> branch is in our history and we can work forwards.
>
> The other concern was about how 'git add ' should respond when a path
> outside of the sparse-checkout cone exists. One recommendation (that I am
> failing to find a link to the message, sorry) was to disallow adding files
> that would become index entries with SKIP_WORKTREE on. However, as I worked
> towards that goal I found that change would cause problems for a realistic
> scenario: merge conflicts outside of the sparse-checkout cone.
>
> Update: Elijah points out that the SKIP_WORKTREE bit is removed from
> conflict files, which allows adding the conflicted files without warning.
> (However, we also need to be careful about untracked files, as documented in
> the test added here.)
>
> The first patch of this series adds tests that create merge conflicts
> outside of the sparse cone and then presents different ways a user could
> resolve the situation. We want all of them to be feasible, and this
> includes:
>
>  1. Reverting the file to a known version in history.
>  2. Adding the file with its contents on disk.
>  3. Moving the file to a new location in the sparse directory.
>
> The one place I did continue to update is 'git add --refresh ' to match the
> behavior added by mt/add-rm-in-sparse-checkout which outputs an error
> message. This happens even when the file exists in the working directory,
> but that seems appropriate enough.
>
>
> Updates in V2
> =============
>
>  * Test comments in patch 1 are improved.
>
>  * The test hunk that was removed in patch 2 and reintroduced in the old
>    patch 4 is modified to clarify how the behavior changes with that patch.
>    Then, the test is modified by future patches.
>
>  * Another instance of ensure_full_index() is removed from the --renormalize
>    option. This option already ignored files with the SKIP_WORKTREE bit, so
>    this should be an obviously-correct removal.
>
>  * a full proposal for what to do with "git (add|mv|rm)" and paths outside
>    the cone is delayed to another series (with an RFC round) because the
>    behavior of the sparse-index matches a full index with sparse-checkout.

I think this makes sense.

I've read through the patches, and I like this version...with one
exception.  Can we mark the test added in patch 1 under

     # 3. Rename the file to another sparse filename and
     #    accept conflict markers as resolved content.

as NEEDSWORK or even MAYNEEDWORK?  I'm still quite unconvinced that it
is testing for correct behavior, and don't want to paint ourselves
into a corner.  In particular, we don't allow folks to "git add
$IGNORED_FILE" without a --force override because it's likely to be a
mistake.  I think the same logic holds for adding untracked files
outside the sparsity cone.  But it's actually even worse than that
case because there's a secondary level of surprise too: adding files
outside the sparsity cone will result in delayed user surprises when
the next git command that happens to call unpack_trees() (which are
found all over the codebase) removes the file from the working tree.
I've had some such reports already.

If that test is marked as NEEDSWORK or even as the correct behavior
still being under dispute, then you can happily apply my:

Reviewed-by: Elijah Newren <newren@gmail.com>

> Thanks, -Stolee
>
> Derrick Stolee (5):
>   t1092: test merge conflicts outside cone
>   add: allow operating on a sparse-only index
>   pathspec: stop calling ensure_full_index
>   add: ignore outside the sparse-checkout in refresh()
>   add: remove ensure_full_index() with --renormalize
>
>  builtin/add.c                            | 15 ++++--
>  pathspec.c                               |  2 -
>  t/t1092-sparse-checkout-compatibility.sh | 62 ++++++++++++++++++++----
>  3 files changed, 65 insertions(+), 14 deletions(-)
>
>
> base-commit: 71e301501c88399711a1bf8515d1747e92cfbb9b
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-999%2Fderrickstolee%2Fsparse-index%2Fadd-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-999/derrickstolee/sparse-index/add-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/999
>
> Range-diff vs v1:
>
>  1:  a763a7d15b8 ! 1:  8f2fd9370fe t1092: test merge conflicts outside cone
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'merge' '
>       + test_all_match test_must_fail git merge -m merge merge-right &&
>       + test_all_match git status --porcelain=v2 &&
>       +
>      -+ # resolve the conflict in different ways:
>      -+ # 1. revert to the base
>      ++ # Resolve the conflict in different ways:
>      ++ # 1. Revert to the base
>       + test_all_match git checkout base -- deep/deeper2/a &&
>       + test_all_match git status --porcelain=v2 &&
>       +
>      -+ # 2. add the file with conflict markers
>      ++ # 2. Add the file with conflict markers
>       + test_all_match git add folder1/a &&
>       + test_all_match git status --porcelain=v2 &&
>       +
>      -+ # 3. rename the file to another sparse filename
>      ++ # 3. Rename the file to another sparse filename and
>      ++ #    accept conflict markers as resolved content.
>       + run_on_all mv folder2/a folder2/z &&
>       + test_all_match git add folder2 &&
>       + test_all_match git status --porcelain=v2 &&
>  2:  791c6c2c9ad ! 2:  6e43f118fa0 add: allow operating on a sparse-only index
>      @@ Commit message
>           sparse-index. Comparing to the full index case, 'git add -A' goes from
>           0.37s to 0.05s, which is "only" an 86% improvement.
>
>      +    This modification to 'git add' creates some behavior change depending on
>      +    the use of a sparse index. We modify a test in t1092 to demonstrate
>      +    these changes which will be remedied in future changes.
>      +
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>        ## builtin/add.c ##
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'status/add: outsi
>       - # This "git add folder1/a" fails with a warning
>       - # in the sparse repos, differing from the full
>       - # repo. This is intentional.
>      -- test_sparse_match test_must_fail git add folder1/a &&
>      ++ # Adding the path outside of the sparse-checkout cone should fail.
>      +  test_sparse_match test_must_fail git add folder1/a &&
>       - test_sparse_match test_must_fail git add --refresh folder1/a &&
>       - test_all_match git status --porcelain=v2 &&
>      --
>      ++
>      ++ test_must_fail git -C sparse-checkout add --refresh folder1/a 2>sparse-checkout-err &&
>      ++ test_must_fail git -C sparse-index add --refresh folder1/a 2>sparse-index-err &&
>      ++ # NEEDSWORK: A sparse index changes the error message.
>      ++ ! test_cmp sparse-checkout-err sparse-index-err &&
>      ++
>      ++ # NEEDSWORK: Adding a newly-tracked file outside the cone succeeds
>      ++ test_sparse_match git add folder1/new &&
>      +
>         test_all_match git add . &&
>         test_all_match git status --porcelain=v2 &&
>         test_all_match git commit -m folder1/new &&
>      ++ test_all_match git rev-parse HEAD^{tree} &&
>      +
>      +  run_on_all ../edit-contents folder1/newer &&
>      +  test_all_match git add folder1/ &&
>      +  test_all_match git status --porcelain=v2 &&
>      +- test_all_match git commit -m folder1/newer
>      ++ test_all_match git commit -m folder1/newer &&
>      ++ test_all_match git rev-parse HEAD^{tree}
>      + '
>      +
>      + test_expect_success 'checkout and reset --hard' '
>       @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is not expanded' '
>         git -C sparse-index reset --hard &&
>         ensure_not_expanded checkout rename-out-to-out -- deep/deeper1 &&
>  3:  a577ea4c74d = 3:  2ae91e0af29 pathspec: stop calling ensure_full_index
>  4:  89ec6a7ce67 < -:  ----------- t1092: 'git add --refresh' difference with sparse-index
>  5:  76066a78ce0 ! 4:  a79728d4c64 add: ignore outside the sparse-checkout in refresh()
>      @@ builtin/add.c: static int refresh(int verbose, const struct pathspec *pathspec)
>
>        ## t/t1092-sparse-checkout-compatibility.sh ##
>       @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'status/add: outside sparse cone' '
>      -  test_all_match git commit -m folder1/newer
>      - '
>
>      --test_expect_failure 'add: pathspec within sparse directory' '
>      -+test_expect_success 'add: pathspec within sparse directory' '
>      -  init_repos &&
>      -
>      -  run_on_sparse mkdir folder1 &&
>      -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'add: pathspec within sparse directory' '
>      -  # This "git add folder1/a" fails with a warning
>      -  # in the sparse repos, differing from the full
>      -  # repo. This is intentional.
>      -- #
>      -- # However, in the sparse-index, folder1/a does not
>      -- # match any cache entry and fails with a different
>      -- # error message. This needs work.
>      +  # Adding the path outside of the sparse-checkout cone should fail.
>         test_sparse_match test_must_fail git add folder1/a &&
>      -  test_sparse_match test_must_fail git add --refresh folder1/a &&
>      -  test_all_match git status --porcelain=v2
>      +-
>      +- test_must_fail git -C sparse-checkout add --refresh folder1/a 2>sparse-checkout-err &&
>      +- test_must_fail git -C sparse-index add --refresh folder1/a 2>sparse-index-err &&
>      +- # NEEDSWORK: A sparse index changes the error message.
>      +- ! test_cmp sparse-checkout-err sparse-index-err &&
>      ++ test_sparse_match test_must_fail git add --refresh folder1/a &&
>      +
>      +  # NEEDSWORK: Adding a newly-tracked file outside the cone succeeds
>      +  test_sparse_match git add folder1/new &&
>  -:  ----------- > 5:  1543550a4e8 add: remove ensure_full_index() with --renormalize
>
> --
> gitgitgadget
