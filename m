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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB281C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 20:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8492A22CA1
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 20:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbhAWUaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 15:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbhAWUaN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 15:30:13 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BD8C0613D6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 12:29:33 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id i30so8792276ota.6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 12:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KtQapetInrUA71qMGdJinqDf8EOXw/19n7OznYneXW0=;
        b=mcqQ2XcuA3eHjsrIg3ZEIDDLicXnt9ll8Hw3c/hXwQpEkaT1BmNo44ZNRRjVTQ0/U9
         xMuBDw8JJqOi082j+PsE6eJDAwwVyyqPPk1SUsy09z8GTiWbV2yMMia8N6Q8N/VomhdA
         cj/wefEclBLcfURn7HxEHrM4KzP3UoVKC4lNaU4a8iGqzqbKHf19T9d4jJcPGlfa8FiF
         R1EfwmyEJ3Hitp8unFZUR2nf1j9mbHB3qxYBfmkEd/ZQQbdyoPISfV28yXTm6S13OnPL
         mCzbFHWxavGHWJ7SFEvGxYfsl9TZsiu3JegahQtChHrRCdSvSMcOUWCupKzXA5B89RLH
         JnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtQapetInrUA71qMGdJinqDf8EOXw/19n7OznYneXW0=;
        b=OqamWlYb9qLLNCwbSdS8bwIukaURDPYMVQsf4D8wSiJKCm78plBqqjdnWSz7fCbInz
         mGH1GF6LyG1bpdKZBIDiu04DDkjtZ1Oqq4mE69wt6u1F7Vwq9X+n3C/labeNIMtK2y8Z
         oW8TN5Wggi7em4OYfIKrEUfcqcO2BwgnHBgDHyqIUKeAh1zVZncFftQeKq80J+AzrCHv
         vDZcHoyubU/aagMqqgXgXDa3C+3PQeFMInXp+btGmJwX+e89/pZvKYB1mrdXd+4/B0Cz
         f+Rm10I104KmnaMDqDGfZCArv2vkyz7v+uEcxHswq/iIzscSkYvGGT43NpMnTbzEtoFL
         fSAw==
X-Gm-Message-State: AOAM530POPt2rxIiUBvkQO87Ju0Tnc3YhnWfYyOrsVqd/QXGpUvWderr
        1MD+4mULw/fAUKNcvQw0Mx5KgI2/uJcFrsWCQY4=
X-Google-Smtp-Source: ABdhPJy82CO+zwefOmJf9wCEmLFCcg5pYXooKXj/yGcmGmOK2Q83OsdmOjFxWuKVf4BNp5zFttRkpj9tIez6G1lf3no=
X-Received: by 2002:a9d:506:: with SMTP id 6mr7379362otw.162.1611433772554;
 Sat, 23 Jan 2021 12:29:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com> <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 23 Jan 2021 12:29:21 -0800
Message-ID: <CABPp-BHFiXLOS4Vbm156+JxZw=t2P_Fzf8E3p4u0iwCv28_Rdw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] More index cleanups
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 23, 2021 at 11:58 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is based on ds/cache-tree-basics.
>
> Here are a few more cleanups that are vaguely related to the index. I
> discovered these while preparing my sparse-index RFC that I intend to send
> early next week.
>
> The biggest patch is the final one, which creates a test script for
> comparing sparse-checkouts to full checkouts. There are some commands that
> do not behave similarly. This script will be the backbone of my testing
> strategy for the sparse-index by adding a new mode to compare
> sparse-checkouts with the two index types (full and sparse).
>
>
> UPDATES IN V3
> =============
>
>  * Callers to cache_tree_update() no longer initialize the cache_tree in
>    advance.
>
>  * Added a patch to update verify_cache() prototype.
>
>  * Added missing "pos + 1" in fsmonitor.c.
>
>  * Added a BUG() statement when repo->istate->repo is already populated, but
>    not equal to repo.
>
>  * Cleaned up test_region pattern quoting. Thanks, Junio!
>
> Thanks, -Stolee
>
> Derrick Stolee (9):
>   cache-tree: clean up cache_tree_update()
>   cache-tree: simplify verify_cache() prototype
>   cache-tree: extract subtree_pos()
>   fsmonitor: de-duplicate BUG()s around dirty bits
>   repository: add repo reference to index_state
>   name-hash: use trace2 regions for init
>   sparse-checkout: load sparse-checkout patterns
>   test-lib: test_region looks for trace2 regions
>   t1092: test interesting sparse-checkout scenarios
>
>  builtin/checkout.c                       |   3 -
>  builtin/sparse-checkout.c                |   5 -
>  cache-tree.c                             |  38 +--
>  cache-tree.h                             |   2 +
>  cache.h                                  |   1 +
>  dir.c                                    |  17 ++
>  dir.h                                    |   2 +
>  fsmonitor.c                              |  27 +-
>  name-hash.c                              |   3 +
>  repository.c                             |   6 +
>  sequencer.c                              |   3 -
>  t/t0500-progress-display.sh              |   3 +-
>  t/t1092-sparse-checkout-compatibility.sh | 301 +++++++++++++++++++++++
>  t/test-lib-functions.sh                  |  42 ++++
>  unpack-trees.c                           |   8 +-
>  15 files changed, 408 insertions(+), 53 deletions(-)
>  create mode 100755 t/t1092-sparse-checkout-compatibility.sh
>
>
> base-commit: a4b6d202caad83c6dc29abe9b17e53a1b3fb54a0
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-839%2Fderrickstolee%2Fmore-index-cleanups-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-839/derrickstolee/more-index-cleanups-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/839
>
> Range-diff vs v2:
>
>   1:  f9dccaed0ac !  1:  bdc8ecca3d2 cache-tree: clean up cache_tree_update()
>      @@ Commit message
>           BUG() statement or returning with an error because future callers will
>           want to populate an empty cache-tree using this method.
>
>      -    Also drop local variables that are used exactly once and can be found
>      -    directly from the 'istate' parameter.
>      +    Callers can also remove their conditional allocations of cache_tree.
>      +
>      +    Also drop local variables that can be found directly from the 'istate'
>      +    parameter.
>
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>      + ## builtin/checkout.c ##
>      +@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
>      +          }
>      +  }
>      +
>      +- if (!active_cache_tree)
>      +-         active_cache_tree = cache_tree();
>      +-
>      +  if (!cache_tree_fully_valid(active_cache_tree))
>      +          cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
>      +
>      +
>        ## cache-tree.c ##
>       @@ cache-tree.c: static int update_one(struct cache_tree *it,
>
>      @@ cache-tree.c: static int update_one(struct cache_tree *it,
>         trace2_region_leave("cache_tree", "update", the_repository);
>         trace_performance_leave("cache_tree_update");
>         if (i < 0)
>      +@@ cache-tree.c: static int write_index_as_tree_internal(struct object_id *oid,
>      +          cache_tree_valid = 0;
>      +  }
>      +
>      +- if (!index_state->cache_tree)
>      +-         index_state->cache_tree = cache_tree();
>      +-
>      +  if (!cache_tree_valid && cache_tree_update(index_state, flags) < 0)
>      +          return WRITE_TREE_UNMERGED_INDEX;
>      +
>      +
>      + ## sequencer.c ##
>      +@@ sequencer.c: static int do_recursive_merge(struct repository *r,
>      +
>      + static struct object_id *get_cache_tree_oid(struct index_state *istate)
>      + {
>      +- if (!istate->cache_tree)
>      +-         istate->cache_tree = cache_tree();
>      +-
>      +  if (!cache_tree_fully_valid(istate->cache_tree))
>      +          if (cache_tree_update(istate, 0)) {
>      +                  error(_("unable to update cache tree"));
>      +
>      + ## unpack-trees.c ##
>      +@@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>      +          if (!ret) {
>      +                  if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
>      +                          cache_tree_verify(the_repository, &o->result);
>      +-                 if (!o->result.cache_tree)
>      +-                         o->result.cache_tree = cache_tree();
>      +                  if (!cache_tree_fully_valid(o->result.cache_tree))
>      +                          cache_tree_update(&o->result,
>      +                                            WRITE_TREE_SILENT |
>   -:  ----------- >  2:  1b8b5680094 cache-tree: simplify verify_cache() prototype
>   2:  84323e04d08 =  3:  314b6b34f75 cache-tree: extract subtree_pos()
>   3:  31095f9aa0e !  4:  4e688d25f8c fsmonitor: de-duplicate BUG()s around dirty bits
>      @@ Commit message
>           cannot simplify it too much. However, the error string is identical in
>           each, so this simplifies things.
>
>      +    Be sure to add one when checking if a position if valid, since the
>      +    minimum is a bound on the expected size.
>      +
>           The end result is that the code is simpler to read while also preserving
>           these assertions for developers in the FSMonitor space.
>
>      @@ fsmonitor.c
>       - if (pos >= istate->cache_nr)
>       -         BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %u)",
>       -             (uintmax_t)pos, istate->cache_nr);
>      -+ assert_index_minimum(istate, pos);
>      ++ assert_index_minimum(istate, pos + 1);
>
>         ce = istate->cache[pos];
>         ce->ce_flags &= ~CE_FSMONITOR_VALID;
>   4:  a0d89d7a973 !  5:  6373997e05c repository: add repo reference to index_state
>      @@ Commit message
>           repository, add a 'repo' pointer to struct index_state that allows
>           access to this repository.
>
>      +    Add a BUG() statement if the repo already has an index, and the index
>      +    already has a repo, but somehow the index points to a different repo.
>      +
>           This will prevent future changes from needing to pass an additional
>           'struct repository *repo' parameter and instead rely only on the 'struct
>           index_state *istate' parameter.
>      @@ repository.c: int repo_read_index(struct repository *repo)
>       + /* Complete the double-reference */
>       + if (!repo->index->repo)
>       +         repo->index->repo = repo;
>      ++ else if (repo->index->repo != repo)
>      ++         BUG("repo's index should point back at itself");
>       +
>         return read_index_from(repo->index, repo->index_file, repo->gitdir);
>        }
>   5:  bc092f5c703 =  6:  9b545d7dbec name-hash: use trace2 regions for init
>   6:  04d1daf7222 =  7:  554cc7647e6 sparse-checkout: load sparse-checkout patterns
>   7:  8832ce84623 !  8:  b37181bdec4 test-lib: test_region looks for trace2 regions
>      @@ t/test-lib-functions.sh: test_subcommand () {
>       +         shift
>       + fi
>       +
>      -+ grep -e "\"region_enter\".*\"category\":\"$1\",\"label\":\"$2\"" "$3"
>      ++ grep -e '"region_enter".*"category":"'"$1"'","label":"'"$2"\" "$3"
>       + exitcode=$?
>       +
>      -+ if test $exitcode != $expect_exit
>      ++ if test $exitcode != $expect_exit = 1]

I don't understand this change.  Is it even valid code?  What does it mean?

>       + then
>       +         return 1
>       + fi
>       +
>      -+ grep -e "\"region_leave\".*\"category\":\"$1\",\"label\":\"$2\"" "$3"
>      ++ grep -e '"region_leave".*"category":"'"$1"'","label":"'"$2"\" "$3"
>       + exitcode=$?
>       +
>      -+ if test $exitcode != $expect_exit
>      ++ if test $exitcode != $expect_exit = 1]

Same comment.

>       + then
>       +         return 1
>       + fi
>      ++
>      ++ return 0
>       +}
>   8:  984458007ed !  9:  72f925353d3 t1092: test interesting sparse-checkout scenarios
>      @@ t/t1092-sparse-checkout-compatibility.sh (new)
>       +         echo a >a &&
>       +         echo "after deep" >e &&
>       +         echo "after folder1" >g &&
>      ++         echo "after x" >z &&
>       +         mkdir folder1 folder2 deep x &&
>       +         mkdir deep/deeper1 deep/deeper2 &&
>       +         mkdir deep/deeper1/deepest &&
>      @@ t/t1092-sparse-checkout-compatibility.sh (new)
>       +         echo "after deepest" >deep/deeper1/e &&
>       +         cp a folder1 &&
>       +         cp a folder2 &&
>      ++         cp a x &&
>       +         cp a deep &&
>       +         cp a deep/deeper1 &&
>       +         cp a deep/deeper2 &&
>       +         cp a deep/deeper1/deepest &&
>      ++         cp -r deep/deeper1/deepest deep/deeper2 &&
>       +         git add . &&
>       +         git commit -m "initial commit" &&
>       +         git checkout -b base &&
>

Having read the previous rounds, the rest of the range-diff looks good
to me; I sent out separate comments on the new patch.
