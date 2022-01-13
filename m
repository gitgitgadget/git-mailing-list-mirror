Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0AEC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 03:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiAMDCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiAMDCa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 22:02:30 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA2CC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:02:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z22so17681819edd.12
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+G4xvYp6a61J6bsHhmw9A666rBAz4dFbMowPWPaWcL0=;
        b=gCj/c2h3LYfYc3FqOg6/7Sxs2im/LNp8OZaq27snAf5D1Ko5mHwKVIC2jOF2KiPTHN
         nTh+FeBuWcC1MX4PZ6hvpA4HebCC+LM5NPxbrjM2oXV/XTjRrAYLUWqf8TQpTOVoVOkA
         Y4QAUR1A17deZX4zRE5Ph8NYuJXsfmbTZGJYvvcS3elHFtAMmjN8nUxqqB4RfdxBJtpE
         SI+C/VY/KdYK4Ex8XjVrD7eUfZjdWaXW0aTG0zIfWiFRLRAd0avQ8MaZxGDTjkxOLV8g
         RV5bfGfvPdfXExTO1iiqzN1XjHVH0y4aSJmqOArpw/LkCNRmGlm9USxDI2MYFi85fG5U
         oibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+G4xvYp6a61J6bsHhmw9A666rBAz4dFbMowPWPaWcL0=;
        b=WhdYKRPtyVsLuW5KnD1xfuPrck+1huWcrmlCIqfa8FCgb5b0AZf5FPeZIKVuOus7et
         Z3OpLbBS6jeOUsLmeczwBpuC/5holAD1RB5r6kLNb1kSAxYBnCK7dqV57ykfSBXTIZ1h
         MXme3mAgvF77SCAdTfivenKpCrjMN5yOYslWTdSDxWlhLsF3PUR7pE2CxAFqDlkxPP5g
         KX8cz8VvCsvTrOQyGfopOEcpQlKLH7srFk4ALyjnlqzti55yXZOsD8bMfJuV28QyCXEF
         WT3QPJbWju2OYcBgPp1EBRGdJ6vV50k8/tqrBkax1tsFvgnInB1sHufDXx7h6EdizY92
         QnQA==
X-Gm-Message-State: AOAM533zx/cmQmqRdUBAtXpvoh4zW1vT904if+bFmvFeSnsU002IrxiA
        mW1RoigUZpCPA4Tc53X16e6kEncoWyKRjXQrvvw=
X-Google-Smtp-Source: ABdhPJxsx4d/cqo/gnXNiqHBYzf2ttcIdtgGL/xTqilxuCM+rf27M9LTSQiETpZdly0RlvpowEqBaGd+/kk+YFMyw6A=
X-Received: by 2002:a17:907:3f1b:: with SMTP id hq27mr1937861ejc.613.1642042948284;
 Wed, 12 Jan 2022 19:02:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com> <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 12 Jan 2022 19:02:16 -0800
Message-ID: <CABPp-BEVM-nhTX+DRf3NN16G-5Wr2KzObCiETqcy+ZYJLR4EWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Sparse index: integrate with 'clean',
 'checkout-index', 'update-index'
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 10:05 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series continues the work to integrate commands with the sparse index,
> adding integrations with 'git clean', 'git checkout-index', and 'git
> update-index'. These three commands, while useful in their own right, are
> updated mainly because they're used in 'git stash'. A future series will
> integrate sparse index with 'stash' directly, but its subcommands must be
> integrated to avoid the performance cost of each one expanding and
> collapsing the index.
>
> The series is broken up into 4 parts:
>
>  * Patches 1-2 are minor fixups to the 'git reset' sparse index integration
>    in response to discussion [1] that came after the series was ready for
>    merge to 'next'.
>  * Patch 3 integrates 'git clean' with the sparse index.
>  * Patches 4-6 integrate 'git checkout-index' with the sparse index and
>    introduce a new '--ignore-skip-worktree-bits' option.
>    * This involves changing the behavior of 'checkout-index' to respect
>      'skip-worktree' by default (i.e., it won't check out 'skip-worktree'
>      files). The '--ignore-skip-worktree-bits' option can be specified to
>      force checkout of 'skip-worktree' files, if desired.
>  * Patches 7-9 integrate 'git update-index' with the sparse index.
>    * Note that, although this integrates the sparse index with
>      '--cacheinfo', sparse directories still cannot be updated using that
>      option (see the prior discussion [2] for more details on why)
>
>
> Changes since V1
> ================
>
>  * Changed 'checkout-index' to fail by default when given filenames of files
>    with 'skip-worktree' enabled
>    * These files can still be forcibly checked-out by using the
>      '--ignore-skip-worktree-bits' option
>    * Added/updated corresponding t1092 tests
>  * Updated t1092 'update-index' tests
>    * Mentioned where/why 'skip-worktree' files were manually created on-disk
>      for testing purposes
>    * Provided explanation as to what '--remove' does, and how it relates to
>      '--ignore-skip-worktree-entries'; restructured corresponding test
>    * Fixed typo 'update-indexe' -> 'update-index'
>    * Removed unused 'edit-contents'
>    * Changed '--again' test to not use '--remove' to avoid confusion over
>      how/why it updates 'skip-worktree' entries
>    * Added "set skip-worktree" step to '--cacheinfo' test to illustrate how
>      it could be used to add a new outside-of-cone file and remain generally
>      compliant with a sparse-checkout definition
>    * Added '--cacheinfo' test to "ensure not expanded"
>    * Moved t1092 test 'sparse index is not expanded: update-index' to avoid
>      merge conflict
>  * Updated p2000 test for 'update-index': added file argument
>    * Without any file arguments, 'update-index' was effectively a no-op
>  * Clarified reasoning behind changing/not changing behavior of update-index
>    in sparse-checkouts

Nicely done!  You've addressed all my (voluminous) feedback from v1;
this round looks good to me.

Reviewed-by: Elijah Newren <newren@gmail.com>

>
> Thanks!
>
>  * Victoria
>
> [1]
> https://lore.kernel.org/git/CABPp-BG0iDHf268UAnRyA=0y0T69YTc+bLMdxCmSbrL8s=9ziA@mail.gmail.com/
>
> [2]
> https://lore.kernel.org/git/a075091c-d0d4-db5d-fa21-c9d6c90c343e@gmail.com/
>
> Victoria Dye (9):
>   reset: fix validation in sparse index test
>   reset: reorder wildcard pathspec conditions
>   clean: integrate with sparse index
>   checkout-index: expand sparse checkout compatibility tests
>   checkout-index: add --ignore-skip-worktree-bits option
>   checkout-index: integrate with sparse index
>   update-index: add tests for sparse-checkout compatibility
>   update-index: integrate with sparse index
>   update-index: reduce scope of index expansion in do_reupdate
>
>  Documentation/git-checkout-index.txt     |  10 +-
>  builtin/checkout-index.c                 |  41 +++-
>  builtin/clean.c                          |   3 +
>  builtin/reset.c                          |  12 +-
>  builtin/update-index.c                   |  17 +-
>  read-cache.c                             |  10 +-
>  t/perf/p2000-sparse-operations.sh        |   2 +
>  t/t1092-sparse-checkout-compatibility.sh | 282 ++++++++++++++++++++++-
>  8 files changed, 360 insertions(+), 17 deletions(-)
>
>
> base-commit: dcc0cd074f0c639a0df20461a301af6d45bd582e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1109%2Fvdye%2Fsparse%2Fupdate-index_checkout-index_clean-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1109/vdye/sparse/update-index_checkout-index_clean-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1109
>
> Range-diff vs v1:
>
>   1:  eefb6ab4c61 =  1:  eefb6ab4c61 reset: fix validation in sparse index test
>   2:  0194d894c2f =  2:  0194d894c2f reset: reorder wildcard pathspec conditions
>   3:  52aec13d18e =  3:  52aec13d18e clean: integrate with sparse index
>   4:  e6a8671f6be !  4:  d964507fdcc checkout-index: expand sparse checkout compatibility tests
>      @@ Commit message
>
>           Add tests to cover `checkout-index`, with a focus on cases interesting in a
>           sparse checkout (e.g., files specified outside sparse checkout definition).
>      -    New tests are intended to serve as a baseline for expected behavior and
>      -    performance when integrating `checkout-index` with the sparse index.
>      +
>      +    New tests are intended to serve as a baseline for existing and/or expected
>      +    behavior and performance when integrating `checkout-index` with the sparse
>      +    index. Note that the test 'checkout-index --all' is marked as
>      +    'test_expect_failure', indicating that `update-index --all` will be modified
>      +    in a subsequent patch to behave as the test expects.
>
>           Signed-off-by: Victoria Dye <vdye@github.com>
>
>   5:  ec9a751e8dc !  5:  601888606d1 checkout-index: add --ignore-skip-worktree-bits option
>      @@ Metadata
>        ## Commit message ##
>           checkout-index: add --ignore-skip-worktree-bits option
>
>      -    Update `checkout-index --all` to no longer refresh files that have the
>      -    `skip-worktree` bit set. The newly-added `--ignore-skip-worktree-bits`
>      -    option, when used with `--all`, maintains the old behavior and checks out
>      -    all files regardless of `skip-worktree`.
>      +    Update `checkout-index` to no longer refresh files that have the
>      +    `skip-worktree` bit set, exiting with an error if `skip-worktree` filenames
>      +    are directly provided to `checkout-index`. The newly-added
>      +    `--ignore-skip-worktree-bits` option provides a mechanism to replicate the
>      +    old behavior, checking out *all* files specified (even those with
>      +    `skip-worktree` enabled).
>
>           The ability to toggle whether files should be checked-out based on
>           `skip-worktree` already exists in `git checkout` and `git restore` (both of
>      -    which have an `--ignore-skip-worktree-bits` option). Adding the option to
>      -    `checkout-index` (and changing the corresponding default behavior to respect
>      -    the `skip-worktree` bit) is especially helpful for sparse-checkout: it
>      -    prevents inadvertent creation of *all* files outside the sparse definition
>      -    on disk and eliminates the need to expand a sparse index by default when
>      -    using the `--all` option.
>      +    which have an `--ignore-skip-worktree-bits` option). The change to, by
>      +    default, ignore `skip-worktree` files is especially helpful for
>      +    sparse-checkout; it prevents inadvertent creation of files outside the
>      +    sparse definition on disk and eliminates the need to expand a sparse index
>      +    when using the `--all` option.
>
>           Internal usage of `checkout-index` in `git stash` and `git filter-branch` do
>           not make explicit use of files with `skip-worktree` enabled, so
>           `--ignore-skip-worktree-bits` is not added to them.
>
>      +    Helped-by: Elijah Newren <newren@gmail.com>
>           Signed-off-by: Victoria Dye <vdye@github.com>
>
>        ## Documentation/git-checkout-index.txt ##
>      @@ Documentation/git-checkout-index.txt: OPTIONS
>
>       +--ignore-skip-worktree-bits::
>       + Check out all files, including those with the skip-worktree bit
>      -+ set. Note: may only be used with `--all`; skip-worktree is
>      -+ ignored when explicit filenames are specified.
>      ++ set.
>       +
>        --stdin::
>         Instead of taking list of paths from the command line,
>      @@ builtin/checkout-index.c
>        #include "lockfile.h"
>        #include "quote.h"
>        #include "cache-tree.h"
>      +@@
>      + #define CHECKOUT_ALL 4
>      + static int nul_term_line;
>      + static int checkout_stage; /* default to checkout stage0 */
>      ++static int ignore_skip_worktree; /* default to 0 */
>      + static int to_tempfile;
>      + static char topath[4][TEMPORARY_FILENAME_LENGTH + 1];
>      +
>       @@ builtin/checkout-index.c: static int checkout_file(const char *name, const char *prefix)
>      -  return -1;
>      - }
>      +  int namelen = strlen(name);
>      +  int pos = cache_name_pos(name, namelen);
>      +  int has_same_name = 0;
>      ++ int is_skipped = 1;
>      +  int did_checkout = 0;
>      +  int errs = 0;
>
>      --static int checkout_all(const char *prefix, int prefix_length)
>      -+static int checkout_all(const char *prefix, int prefix_length, int ignore_skip_worktree)
>      - {
>      -  int i, errs = 0;
>      -  struct cache_entry *last_ce = NULL;
>      +@@ builtin/checkout-index.c: static int checkout_file(const char *name, const char *prefix)
>      +                  break;
>      +          has_same_name = 1;
>      +          pos++;
>      ++         if (!ignore_skip_worktree && ce_skip_worktree(ce))
>      ++                 break;
>      ++         is_skipped = 0;
>      +          if (ce_stage(ce) != checkout_stage
>      +              && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
>      +                  continue;
>      +@@ builtin/checkout-index.c: static int checkout_file(const char *name, const char *prefix)
>      +          fprintf(stderr, "git checkout-index: %s ", name);
>      +          if (!has_same_name)
>      +                  fprintf(stderr, "is not in the cache");
>      ++         else if (is_skipped)
>      ++                 fprintf(stderr, "has skip-worktree enabled; "
>      ++                                 "use '--ignore-skip-worktree-bits' to checkout");
>      +          else if (checkout_stage)
>      +                  fprintf(stderr, "does not exist at stage %d",
>      +                          checkout_stage);
>       @@ builtin/checkout-index.c: static int checkout_all(const char *prefix, int prefix_length)
>         ensure_full_index(&the_index);
>         for (i = 0; i < active_nr ; i++) {
>      @@ builtin/checkout-index.c: static int checkout_all(const char *prefix, int prefix
>                 if (ce_stage(ce) != checkout_stage
>                     && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
>                         continue;
>      -@@ builtin/checkout-index.c: int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>      -  int i;
>      -  struct lock_file lock_file = LOCK_INIT;
>      -  int all = 0;
>      -+ int ignore_skip_worktree = 0;
>      -  int read_from_stdin = 0;
>      -  int prefix_length;
>      -  int force = 0, quiet = 0, not_new = 0;
>       @@ builtin/checkout-index.c: int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>         struct option builtin_checkout_index_options[] = {
>                 OPT_BOOL('a', "all", &all,
>      @@ builtin/checkout-index.c: int cmd_checkout_index(int argc, const char **argv, co
>                 OPT__FORCE(&force, N_("force overwrite of existing files"), 0),
>                 OPT__QUIET(&quiet,
>                         N_("no warning for existing files and files not in index")),
>      -@@ builtin/checkout-index.c: int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>      +
>      + ## t/t1092-sparse-checkout-compatibility.sh ##
>      +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'checkout-index inside sparse definition' '
>      + test_expect_success 'checkout-index outside sparse definition' '
>      +  init_repos &&
>
>      -          if (all)
>      -                  die("git checkout-index: don't mix '--all' and explicit filenames");
>      -+         if (ignore_skip_worktree)
>      -+                 die("git checkout-index: don't mix '--ignore-skip-worktree-bits' and explicit filenames");
>      -          if (read_from_stdin)
>      -                  die("git checkout-index: don't mix '--stdin' and explicit filenames");
>      -          p = prefix_path(prefix, prefix_length, arg);
>      -@@ builtin/checkout-index.c: int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>      -  }
>      +- # File does not exist on disk yet for sparse checkouts, so checkout-index
>      +- # succeeds without -f
>      +- test_sparse_match git checkout-index -- folder1/a &&
>      ++ # Without --ignore-skip-worktree-bits, outside-of-cone files will trigger
>      ++ # an error
>      ++ test_sparse_match test_must_fail git checkout-index -- folder1/a &&
>      ++ test_i18ngrep "folder1/a has skip-worktree enabled" sparse-checkout-err &&
>      ++ test_path_is_missing folder1/a &&
>      ++
>      ++ # With --ignore-skip-worktree-bits, outside-of-cone files are checked out
>      ++ test_sparse_match git checkout-index --ignore-skip-worktree-bits -- folder1/a &&
>      +  test_cmp sparse-checkout/folder1/a sparse-index/folder1/a &&
>      +  test_cmp sparse-checkout/folder1/a full-checkout/folder1/a &&
>
>      -  if (all)
>      --         err |= checkout_all(prefix, prefix_length);
>      -+         err |= checkout_all(prefix, prefix_length, ignore_skip_worktree);
>      +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'checkout-index outside sparse definition' '
>      +  run_on_sparse mkdir -p folder1 &&
>      +  run_on_all cp ../new-a folder1/a &&
>
>      -  if (pc_workers > 1)
>      -          err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
>      -
>      - ## t/t1092-sparse-checkout-compatibility.sh ##
>      +- test_all_match test_must_fail git checkout-index -- folder1/a &&
>      +- test_all_match git checkout-index -f -- folder1/a &&
>      ++ test_all_match test_must_fail git checkout-index --ignore-skip-worktree-bits -- folder1/a &&
>      ++ test_all_match git checkout-index -f --ignore-skip-worktree-bits -- folder1/a &&
>      +  test_cmp sparse-checkout/folder1/a sparse-index/folder1/a &&
>      +  test_cmp sparse-checkout/folder1/a full-checkout/folder1/a
>      + '
>       @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'checkout-index with folders' '
>         test_all_match test_must_fail git checkout-index -f -- folder1/
>        '
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'checkout-index wi
>       - test_sparse_match test_path_is_missing folder1
>       + test_sparse_match test_path_is_missing folder1 &&
>       +
>      ++ # --ignore-skip-worktree-bits will cause `skip-worktree` files to be
>      ++ # checked out, causing the outside-of-cone `folder1` to exist on-disk
>       + test_all_match git checkout-index --ignore-skip-worktree-bits --all &&
>       + test_all_match test_path_exists folder1
>        '
>   6:  18c00fc9dd3 !  6:  b4b9086dcdc checkout-index: integrate with sparse index
>      @@ builtin/checkout-index.c: static int checkout_file(const char *name, const char
>         int pos = cache_name_pos(name, namelen);
>         int has_same_name = 0;
>       + int is_file = 0;
>      +  int is_skipped = 1;
>         int did_checkout = 0;
>         int errs = 0;
>      -
>       @@ builtin/checkout-index.c: static int checkout_file(const char *name, const char *prefix)
>                         break;
>                 has_same_name = 1;
>      @@ builtin/checkout-index.c: static int checkout_file(const char *name, const char
>       +         if (S_ISSPARSEDIR(ce->ce_mode))
>       +                 break;
>       +         is_file = 1;
>      -          if (ce_stage(ce) != checkout_stage
>      -              && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
>      -                  continue;
>      +          if (!ignore_skip_worktree && ce_skip_worktree(ce))
>      +                  break;
>      +          is_skipped = 0;
>       @@ builtin/checkout-index.c: static int checkout_file(const char *name, const char *prefix)
>                 fprintf(stderr, "git checkout-index: %s ", name);
>                 if (!has_same_name)
>                         fprintf(stderr, "is not in the cache");
>       +         else if (!is_file)
>       +                 fprintf(stderr, "is a sparse directory");
>      -          else if (checkout_stage)
>      -                  fprintf(stderr, "does not exist at stage %d",
>      -                          checkout_stage);
>      -@@ builtin/checkout-index.c: static int checkout_all(const char *prefix, int prefix_length, int ignore_skip_w
>      +          else if (is_skipped)
>      +                  fprintf(stderr, "has skip-worktree enabled; "
>      +                                  "use '--ignore-skip-worktree-bits' to checkout");
>      +@@ builtin/checkout-index.c: static int checkout_all(const char *prefix, int prefix_length)
>         int i, errs = 0;
>         struct cache_entry *last_ce = NULL;
>
>   7:  3b734f89c0f !  7:  ff32952a21c update-index: add tests for sparse-checkout compatibility
>      @@ Commit message
>           update-index: add tests for sparse-checkout compatibility
>
>           Introduce tests for a variety of `git update-index` use cases, including
>      -    performance scenarios. Tests for `update-index add/remove` are specifically
>      -    focused on how `git stash` uses `git update-index` as a subcommand to
>      -    prepare for sparse index integration with `stash` in a future series.
>      +    performance scenarios. Tests are intended to exercise `update-index` with
>      +    options that change the commands interaction with the index (e.g.,
>      +    `--again`) and with files/directories inside and outside a sparse checkout
>      +    cone.
>      +
>      +    Of note is that these tests clearly establish the behavior of `git
>      +    update-index --add` with untracked, outside-of-cone files. Unlike `git add`,
>      +    which fails with an error when provided with such files, `update-index`
>      +    succeeds in adding them to the index. Additionally, the `skip-worktree` flag
>      +    is *not* automatically added to the new entry. Although this is pre-existing
>      +    behavior, there are a couple of reasons to avoid changing it in favor of
>      +    consistency with e.g. `git add`:
>      +
>      +    * `update-index` is low-level command for modifying the index; while it can
>      +      perform operations similar to those of `add`, it traditionally has fewer
>      +      "guardrails" preventing a user from doing something they may not want to
>      +      do (in this case, adding an outside-of-cone, non-`skip-worktree` file to
>      +      the index)
>      +    * `update-index` typically only exits with an error code if it is incapable
>      +      of performing an operation (e.g., if an internal function call fails);
>      +      adding a new file outside the sparse checkout definition is still a valid
>      +      operation, albeit an inadvisable one
>      +    * `update-index` does not implicitly set flags (e.g., `skip-worktree`) when
>      +      creating new index entries with `--add`; if flags need to be updated,
>      +      options like `--[no-]skip-worktree` allow a user to intentionally set them
>      +
>      +    All this to say that, while there are valid reasons to consider changing the
>      +    treatment of outside-of-cone files in `update-index`, there are also
>      +    sufficient reasons for leaving it as-is.
>
>           Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
>           Signed-off-by: Victoria Dye <vdye@github.com>
>      @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git diff --cached
>        test_perf_on_all git blame $SPARSE_CONE/a
>        test_perf_on_all git blame $SPARSE_CONE/f3/a
>        test_perf_on_all git checkout-index -f --all
>      -+test_perf_on_all git update-index --add --remove
>      ++test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>
>        test_done
>
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'reset with wildca
>       + EOF
>       +
>       + # Create & modify folder1/a
>      ++ # Note that this setup is a manual way of reaching the erroneous
>      ++ # condition in which a `skip-worktree` enabled, outside-of-cone file
>      ++ # exists on disk. It is used here to ensure `update-index` is stable
>      ++ # and behaves predictably if such a condition occurs.
>       + run_on_sparse mkdir -p folder1 &&
>       + run_on_sparse cp ../initial-repo/folder1/a folder1/a &&
>       + run_on_all ../edit-contents folder1/a &&
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'reset with wildca
>       + run_on_sparse mkdir -p folder1 &&
>       + run_on_all ../edit-contents folder1/b &&
>       +
>      -+ # Similar to `git add`, the untracked out-of-cone file is added to the index
>      -+ # identically across sparse and non-sparse checkouts
>      ++ # The *untracked* out-of-cone file is added to the index because it does
>      ++ # not have a `skip-worktree` bit to signal that it should be ignored
>      ++ # (unlike in `git add`, which will fail due to the file being outside
>      ++ # the sparse checkout definition).
>       + test_all_match git update-index --add folder1/b &&
>       + test_all_match git status --porcelain=v2
>       +'
>       +
>      ++# NEEDSWORK: `--remove`, unlike the rest of `update-index`, does not ignore
>      ++# `skip-worktree` entries by default and will remove them from the index.
>      ++# The `--ignore-skip-worktree-entries` flag must be used in conjunction with
>      ++# `--remove` to ignore the `skip-worktree` entries and prevent their removal
>      ++# from the index.
>       +test_expect_success 'update-index --remove outside sparse definition' '
>       + init_repos &&
>       +
>      -+ # When `--ignore-skip-worktree-entries` is specified, out-of-cone files are
>      -+ # not removed from the index if they do not exist on disk
>      ++ # When --ignore-skip-worktree-entries is _not_ specified:
>      ++ # out-of-cone, not-on-disk files are removed from the index
>      ++ test_sparse_match git update-index --remove folder1/a &&
>      ++ cat >expect <<-EOF &&
>      ++ D       folder1/a
>      ++ EOF
>      ++ test_sparse_match git diff --cached --name-status &&
>      ++ test_cmp expect sparse-checkout-out &&
>      ++
>      ++ # Reset the state
>      ++ test_all_match git reset --hard &&
>      ++
>      ++ # When --ignore-skip-worktree-entries is specified, out-of-cone
>      ++ # (skip-worktree) files are ignored
>       + test_sparse_match git update-index --remove --ignore-skip-worktree-entries folder1/a &&
>      -+ test_all_match git status --porcelain=v2 &&
>      ++ test_sparse_match git diff --cached --name-status &&
>      ++ test_must_be_empty sparse-checkout-out &&
>       +
>      -+ # When the flag is _not_ specified, out-of-cone, not-on-disk files are
>      -+ # removed from the index
>      -+ rm full-checkout/folder1/a &&
>      -+ test_all_match git update-index --remove folder1/a &&
>      -+ test_all_match git status --porcelain=v2 &&
>      ++ # Reset the state
>      ++ test_all_match git reset --hard &&
>       +
>      -+ # NOTE: --force-remove supercedes --ignore-skip-worktree-entries, removing
>      ++ # --force-remove supercedes --ignore-skip-worktree-entries, removing
>       + # a skip-worktree file from the index (and disk) when both are specified
>      -+ test_all_match git update-index --force-remove --ignore-skip-worktree-entries folder1/a &&
>      -+ test_all_match git status --porcelain=v2
>      ++ # with --remove
>      ++ test_sparse_match git update-index --force-remove --ignore-skip-worktree-entries folder1/a &&
>      ++ cat >expect <<-EOF &&
>      ++ D       folder1/a
>      ++ EOF
>      ++ test_sparse_match git diff --cached --name-status &&
>      ++ test_cmp expect sparse-checkout-out
>       +'
>       +
>       +test_expect_success 'update-index with directories' '
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'reset with wildca
>       + #   file and either triggers an error ("does not exist  and --remove not passed")
>       + #   or is ignored completely (when using --remove)
>       + test_all_match test_must_fail git update-index deep &&
>      -+ run_on_all test_must_fail git update-indexe folder1 &&
>      ++ run_on_all test_must_fail git update-index folder1 &&
>       + test_must_fail git -C full-checkout update-index --remove folder1 &&
>       + test_sparse_match git update-index --remove folder1 &&
>       + test_all_match git status --porcelain=v2
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'reset with wildca
>       +test_expect_success 'update-index --again file outside sparse definition' '
>       + init_repos &&
>       +
>      -+ write_script edit-contents <<-\EOF &&
>      -+ echo text >>$1
>      -+ EOF
>      -+
>       + test_all_match git checkout -b test-reupdate &&
>       +
>       + # Update HEAD without modifying the index to introduce a difference in
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'reset with wildca
>       + test_sparse_match git reset --soft update-folder1 &&
>       +
>       + # Because folder1/a differs in the index vs HEAD,
>      -+ # `git update-index --remove --again` will effectively perform
>      -+ # `git update-index --remove folder1/a` and remove the folder1/a
>      -+ test_sparse_match git update-index --remove --again &&
>      -+ test_sparse_match git status --porcelain=v2
>      ++ # `git update-index --no-skip-worktree --again` will effectively perform
>      ++ # `git update-index --no-skip-worktree folder1/a` and remove the skip-worktree
>      ++ # flag from folder1/a
>      ++ test_sparse_match git update-index --no-skip-worktree --again &&
>      ++ test_sparse_match git status --porcelain=v2 &&
>      ++
>      ++ cat >expect <<-EOF &&
>      ++ D       folder1/a
>      ++ EOF
>      ++ test_sparse_match git diff --name-status &&
>      ++ test_cmp expect sparse-checkout-out
>       +'
>       +
>       +test_expect_success 'update-index --cacheinfo' '
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'reset with wildca
>       + # Cannot add sparse directory, even in sparse index case
>       + test_all_match test_must_fail git update-index --add --cacheinfo 040000 $folder2_oid folder2/ &&
>       +
>      -+ # Sparse match only - because folder1/a is outside the sparse checkout
>      -+ # definition (and thus not on-disk), it will appear "deleted" in
>      -+ # unstaged changes.
>      -+ test_all_match git update-index --add --cacheinfo 100644 $folder1_a_oid folder1/a &&
>      -+ test_sparse_match git status --porcelain=v2
>      ++ # Sparse match only: the new outside-of-cone entry is added *without* skip-worktree,
>      ++ # so `git status` reports it as "deleted" in the worktree
>      ++ test_sparse_match git update-index --add --cacheinfo 100644 $folder1_a_oid folder1/a &&
>      ++ test_sparse_match git status --porcelain=v2 &&
>      ++ cat >expect <<-EOF &&
>      ++ MD folder1/a
>      ++ EOF
>      ++ test_sparse_match git status --short -- folder1/a &&
>      ++ test_cmp expect sparse-checkout-out &&
>      ++
>      ++ # To return folder1/a to "normal" for a sparse checkout (ignored &
>      ++ # outside-of-cone), add the skip-worktree flag.
>      ++ test_sparse_match git update-index --skip-worktree folder1/a &&
>      ++ cat >expect <<-EOF &&
>      ++ S folder1/a
>      ++ EOF
>      ++ test_sparse_match git ls-files -t -- folder1/a &&
>      ++ test_cmp expect sparse-checkout-out
>       +'
>       +
>        test_expect_success 'merge, cherry-pick, and rebase' '
>   8:  c5b98e36516 !  8:  9ddc51a47d5 update-index: integrate with sparse index
>      @@ Metadata
>        ## Commit message ##
>           update-index: integrate with sparse index
>
>      -    Enable usage of the sparse index with `update-index`. Most variations of
>      +    Enable use of the sparse index with `update-index`. Most variations of
>           `update-index` work without explicitly expanding the index or making any
>           other updates in or outside of `update-index.c`.
>
>      @@ read-cache.c: static int add_index_entry_with_check(struct index_state *istate,
>                 if (!new_only)
>
>        ## t/t1092-sparse-checkout-compatibility.sh ##
>      -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is not expanded: blame' '
>      -  done
>      +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is not expanded: diff' '
>      +  ensure_not_expanded diff --cached
>        '
>
>       +test_expect_success 'sparse index is not expanded: update-index' '
>       + init_repos &&
>       +
>      ++ deep_a_oid=$(git -C full-checkout rev-parse update-deep:deep/a) &&
>      ++ ensure_not_expanded update-index --cacheinfo 100644 $deep_a_oid deep/a &&
>      ++
>       + echo "test" >sparse-index/README.md &&
>       + echo "test2" >sparse-index/a &&
>       + rm -f sparse-index/deep/a &&
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
>       + ensure_not_expanded update-index --remove deep/a
>       +'
>       +
>      - # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>      - # in this scenario, but it shouldn't.
>      - test_expect_success 'reset mixed and checkout orphan' '
>      + test_expect_success 'sparse index is not expanded: blame' '
>      +  init_repos &&
>      +
>   9:  de7fc143562 !  9:  80697e9259e update-index: reduce scope of index expansion in do_reupdate
>      @@ Metadata
>        ## Commit message ##
>           update-index: reduce scope of index expansion in do_reupdate
>
>      -    Expand the full index (and redo reupdate operation) only if a sparse
>      -    directory in the index differs from HEAD. Only the index entries that differ
>      -    between the index and HEAD are updated when performing `git update-index
>      -    --again`, so unmodified sparse directories are safely skipped. The index
>      -    does need to be expanded when sparse directories contain changes, though,
>      -    because `update_one(...)` will not operate on sparse directory index
>      -    entries.
>      +    Replace unconditional index expansion in 'do_reupdate()' with one scoped to
>      +    only where a full index is needed. A full index is only required in
>      +    'do_reupdate()' when a sparse directory in the index differs from HEAD; in
>      +    that case, the index is expanded and the operation restarted.
>
>           Because the index should only be expanded if a sparse directory is modified,
>           add a test ensuring the index is not expanded when differences only exist
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
>       + ensure_not_expanded update-index --add --remove --again
>        '
>
>      - # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>      + test_expect_success 'sparse index is not expanded: blame' '
>
> --
> gitgitgadget
