Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34531C433E9
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 17:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84FE64DA3
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 17:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344023AbhA0RlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbhA0RbR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 12:31:17 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FC2C061756
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 09:30:37 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id j25so3021718oii.0
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 09:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vy1ivTBTjDL/NO/OdbE1z9vpetbB+bY5FT0x1+cpO2k=;
        b=BcJ5DcnTXVT7dncj763BHZqi3t3/bj38qajIDXWULoPS52wiBnRem7sV3cuPcnshlA
         g0U/alpyshuDUjoD82SxdrQ9edKvNnPCH8M84SrpoTnz4duS4iRJxPDSPsEC0pair586
         lIYzXE/dBmBPUIm+FiGemCDG5tuIICy7eHc8oX9F4nD8lKX7iv5EzSKogKId34soHvVR
         CO8fw3tBPKb3lS0Jz4a5vdl90QIWUN6J/DJGjZkcDo3SIRFYeLB2ISAVhifm+Y7IRBcE
         CbRMB4MngWw47NdaQKIc6k3TlZtKNzzBeSEeqoP+A4u6UJYxfHkLWDZH5jnCQ0hZ1qo1
         fdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vy1ivTBTjDL/NO/OdbE1z9vpetbB+bY5FT0x1+cpO2k=;
        b=g7SPsUyOnx66wbiZPD9qd+wAsjhbbzbuTPYZwVcFh8AcZJJQr7VedhIvVHFbVFF95Z
         XJ85qrd8oGSV+3dBS7t2eXx+cRoCqZKRnr5HNRBbPxX2Kn4KQEUgC76S/As/weLPtrV8
         a05cC5s8dik4fvvLKMF7VGZsYXFiIwf1A4hNfhwszqr2WLx5svQZI/fXljJhSsEN1XKt
         kU+dUqoN7hw48pR9AH5bGUuXfHZnbbDXUyzsnebPO103B+9Ub9c+qhAFVZ4Th0idmxQ+
         u8tf2M2YJ/JhcCZgtna2cDgIl9OOugleDo2D4XgW7j/BS+p3A6Z+LYgZ4OawUE3YObsU
         cN1A==
X-Gm-Message-State: AOAM5302muBZoNcXESUmpeKk7IO3KSI9JYBkFd4QHGvL7O354WVm8v09
        yZg2E4UUcNyBnevBulbjv1RNBK/a3pfpnlfYh0c=
X-Google-Smtp-Source: ABdhPJzAPkuo5+NvZepxgvXOohdF63ey7lzKxXTCk5GplXnruSNa+w8pZBHMK9WUzZ7h8qeiaG0aHqh1ev5XyMpZc5s=
X-Received: by 2002:aca:4e4f:: with SMTP id c76mr3911796oib.167.1611768636331;
 Wed, 27 Jan 2021 09:30:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <dcdc9f2532a5f6c385e98b069c41ac2ccde3053c.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <dcdc9f2532a5f6c385e98b069c41ac2ccde3053c.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Jan 2021 09:30:25 -0800
Message-ID: <CABPp-BE9wPwmC0=pA4p1_QSRDHrO8RzqfJQdE2NxYZsYL_Rcig@mail.gmail.com>
Subject: Re: [PATCH 09/27] sparse-index: convert from full to sparse
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> If we have a full index, then we can convert it to a sparse index by
> replacing directories outside of the sparse cone with sparse directory
> entries. The convert_to_sparse() method does this, when the situation is
> appropriate.
>
> For now, we avoid converting the index to a sparse index if:
>
>  1. the index is split.
>  2. the index is already sparse.
>  3. sparse-checkout is disabled.
>  4. sparse-checkout does not use cone mode.
>
> Finally, we currently limit the conversion to when the
> GIT_TEST_SPARSE_INDEX environment variable is enabled. A mode using Git
> config will be added in a later change.
>
> The trickiest thing about this conversion is that we might not be able
> to mark a directory as a sparse directory just because it is outside the
> sparse cone. There might be unmerged files within that directory, so we
> need to look for those. Also, if there is some strange reason why a file
> is not marked with CE_SKIP_WORKTREE, then we should give up on
> converting that directory. There is still hope that some of its
> subdirectories might be able to convert to sparse, so we keep looking
> deeper.

Oh good, you check for *both* unmerged entries and !CE_SKIP_WORKTREE
ones.  Very nice.

>
> The conversion process is assisted by the cache-tree extension. This is
> calculated from the full index if it does not already exist. We then
> abandon the cache-tree as it no longer applies to the newly-sparse
> index. Thus, this cache-tree will be recalculated in every
> sparse-full-sparse round-trip until we integrate the cache-tree
> extension with the sparse index.

When going from full to sparse, won't the parts of the cache-tree for
paths outside of sparsified directories still be valid?  Can't we use
those?

Also, when going from sparse to full, can't we just populate the
cache-tree as well since we have to read trees to get the individual
file entries and we will get all the directory (tree) values at the
same time?

> We can compare the behavior of the sparse-index in
> t1092-sparse-checkout-compability.sh by using GIT_TEST_SPARSE_INDEX=1
> when operating on the 'sparse-index' repo. We can also compare the two
> sparse repos directly, such as comparing their indexes (when expanded to
> full in the case of the 'sparse-index' repo). We also verify that the
> index is actually populated with sparse directory entries.
>
> The 'checkout and reset (mixed)' test is marked for failure when
> comparing a sparse repo to a full repo, but we can compare the two
> sparse-checkout cases directly to ensure that we are not changing the
> behavior when using a sparse index.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  cache-tree.c                             |   3 +
>  read-cache.c                             |  18 ++-
>  sparse-index.c                           | 139 +++++++++++++++++++++++
>  t/t1092-sparse-checkout-compatibility.sh |  63 +++++++++-
>  4 files changed, 218 insertions(+), 5 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 2fb483d3c08..5f07a39e501 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -6,6 +6,7 @@
>  #include "object-store.h"
>  #include "replace-object.h"
>  #include "promisor-remote.h"
> +#include "sparse-index.h"
>
>  #ifndef DEBUG_CACHE_TREE
>  #define DEBUG_CACHE_TREE 0
> @@ -442,6 +443,8 @@ int cache_tree_update(struct index_state *istate, int flags)
>         if (i)
>                 return i;
>
> +       ensure_full_index(istate);
> +
>         if (!istate->cache_tree)
>                 istate->cache_tree = cache_tree();
>
> diff --git a/read-cache.c b/read-cache.c
> index 1097ecbf132..0522260416e 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -25,6 +25,7 @@
>  #include "fsmonitor.h"
>  #include "thread-utils.h"
>  #include "progress.h"
> +#include "sparse-index.h"
>
>  /* Mask for the name length in ce_flags in the on-disk index */
>
> @@ -1002,8 +1003,15 @@ int verify_path(const char *path, unsigned mode)
>
>                         c = *path++;
>                         if ((c == '.' && !verify_dotfile(path, mode)) ||
> -                           is_dir_sep(c) || c == '\0')
> +                           is_dir_sep(c))
>                                 return 0;
> +                       /*
> +                        * allow terminating directory separators for
> +                        * sparse directory enries.

s/enries/entries/

> +                        */
> +                       if (c == '\0')
> +                               return mode == CE_MODE_SPARSE_DIRECTORY ||
> +                                      mode == SPARSE_DIR_MODE;

Why two values here?  I get confused why you have both (which isn't
new to this patch; I'm just still confused from when I saw
SPARSE_DIR_MODE).

>                 } else if (c == '\\' && protect_ntfs) {
>                         if (is_ntfs_dotgit(path))
>                                 return 0;
> @@ -3062,6 +3070,13 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
>  {
>         int ret;
>
> +       ret = convert_to_sparse(istate);
> +
> +       if (ret) {
> +               warning(_("failed to convert to a sparse-index"));
> +               return ret;
> +       }
> +
>         /*
>          * TODO trace2: replace "the_repository" with the actual repo instance
>          * that is associated with the given "istate".
> @@ -3165,6 +3180,7 @@ static int write_shared_index(struct index_state *istate,
>         int ret;
>
>         move_cache_to_base_index(istate);
> +       convert_to_sparse(istate);
>
>         trace2_region_enter_printf("index", "shared/do_write_index",
>                                    the_repository, "%s", (*temp)->filename.buf);
> diff --git a/sparse-index.c b/sparse-index.c
> index 1e70244dc13..d8f1a5a13d7 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -4,6 +4,145 @@
>  #include "tree.h"
>  #include "pathspec.h"
>  #include "trace2.h"
> +#include "cache-tree.h"
> +#include "config.h"
> +#include "dir.h"
> +#include "fsmonitor.h"
> +
> +static struct cache_entry *construct_sparse_dir_entry(
> +                               struct index_state *istate,
> +                               const char *sparse_dir,
> +                               struct cache_tree *tree)
> +{
> +       struct cache_entry *de;
> +
> +       de = make_cache_entry(istate, SPARSE_DIR_MODE, &tree->oid, sparse_dir, 0, 0);
> +
> +       de->ce_flags |= CE_SKIP_WORKTREE;
> +       return de;
> +}
> +
> +/*
> + * Returns the number of entries "inserted" into the index.
> + */
> +static int convert_to_sparse_rec(struct index_state *istate,
> +                                int num_converted,
> +                                int start, int end,
> +                                const char *ct_path, size_t ct_pathlen,
> +                                struct cache_tree *ct)
> +{
> +       int i, can_convert = 1;
> +       int start_converted = num_converted;
> +       enum pattern_match_result match;
> +       int dtype;
> +       struct strbuf child_path = STRBUF_INIT;
> +       struct pattern_list *pl = istate->sparse_checkout_patterns;
> +
> +       /*
> +        * Is the current path outside of the sparse cone?
> +        * Then check if the region can be replaced by a sparse
> +        * directory entry (everything is sparse and merged).
> +        */
> +       match = path_matches_pattern_list(ct_path, ct_pathlen,
> +                                         NULL, &dtype, pl, istate);
> +       if (match != NOT_MATCHED)
> +               can_convert = 0;

I know some people hate gotos, but this seems like one of the cases
where a goto jumping after the following for & if would be clearer
then setting can_convert to 0.

> +
> +       for (i = start; can_convert && i < end; i++) {

Instead of checking can_convert here...

> +               struct cache_entry *ce = istate->cache[i];
> +
> +               if (ce_stage(ce) ||
> +                   !(ce->ce_flags & CE_SKIP_WORKTREE))
> +                       can_convert = 0;

...could you just insert a break here?

> +       }
> +
> +       if (can_convert) {
> +               struct cache_entry *se;
> +               se = construct_sparse_dir_entry(istate, ct_path, ct);
> +
> +               istate->cache[num_converted++] = se;
> +               return 1;
> +       }
> +
> +       for (i = start; i < end; ) {
> +               int count, span, pos = -1;
> +               const char *base, *slash;
> +               struct cache_entry *ce = istate->cache[i];
> +
> +               /*
> +                * Detect if this is a normal entry oustide of any subtree

s/oustide/outside/

> +                * entry.
> +                */
> +               base = ce->name + ct_pathlen;
> +               slash = strchr(base, '/');
> +
> +               if (slash)
> +                       pos = cache_tree_subtree_pos(ct, base, slash - base);
> +
> +               if (pos < 0) {
> +                       istate->cache[num_converted++] = ce;
> +                       i++;
> +                       continue;
> +               }
> +
> +               strbuf_setlen(&child_path, 0);
> +               strbuf_add(&child_path, ce->name, slash - ce->name + 1);
> +
> +               span = ct->down[pos]->cache_tree->entry_count;
> +               count = convert_to_sparse_rec(istate,
> +                                             num_converted, i, i + span,
> +                                             child_path.buf, child_path.len,
> +                                             ct->down[pos]->cache_tree);
> +               num_converted += count;
> +               i += span;

And there's no i++ in the loop itself, so this is good.

> +       }
> +
> +       strbuf_release(&child_path);
> +       return num_converted - start_converted;
> +}
> +
> +int convert_to_sparse(struct index_state *istate)
> +{
> +       if (istate->split_index || istate->sparse_index ||
> +           !core_apply_sparse_checkout || !core_sparse_checkout_cone)
> +               return 0;
> +
> +       /*
> +        * For now, only create a sparse index with the
> +        * GIT_TEST_SPARSE_INDEX environment variable. We will relax
> +        * this once we have a proper way to opt-in (and later still,
> +        * opt-out).
> +        */
> +       if (!git_env_bool("GIT_TEST_SPARSE_INDEX", 0))
> +               return 0;
> +
> +       if (!istate->sparse_checkout_patterns) {
> +               istate->sparse_checkout_patterns = xcalloc(1, sizeof(struct pattern_list));
> +               if (get_sparse_checkout_patterns(istate->sparse_checkout_patterns) < 0)
> +                       return 0;
> +       }
> +
> +       if (!istate->sparse_checkout_patterns->use_cone_patterns) {
> +               warning(_("attempting to use sparse-index without cone mode"));
> +               return -1;
> +       }
> +
> +       if (cache_tree_update(istate, 0)) {
> +               warning(_("unable to update cache-tree, staying full"));
> +               return -1;
> +       }
> +
> +       remove_fsmonitor(istate);
> +
> +       trace2_region_enter("index", "convert_to_sparse", istate->repo);
> +       istate->cache_nr = convert_to_sparse_rec(istate,
> +                                                0, 0, istate->cache_nr,
> +                                                "", 0, istate->cache_tree);
> +       istate->drop_cache_tree = 1;
> +       istate->sparse_index = 1;
> +       trace2_region_leave("index", "convert_to_sparse", istate->repo);
> +       return 0;
> +}
>
>  static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
>  {
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 3aa9b0d21b4..22becbaca2e 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2,6 +2,9 @@
>
>  test_description='compare full workdir to sparse workdir'
>
> +GIT_TEST_CHECK_CACHE_TREE=0

Why do you need to set this?  I vaguely remember needing to mess with
this when working with sparse checkouts because it did weird stuff but
I don't remember details.  But since you patch touches cache_trees, it
seems weird to show up without explanation.

> +GIT_TEST_SPLIT_INDEX=0
> +
>  . ./test-lib.sh
>
>  test_expect_success 'setup' '
> @@ -106,7 +109,7 @@ run_on_sparse () {
>         ) &&
>         (
>                 cd sparse-index &&
> -               $* >../sparse-index-out 2>../sparse-index-err
> +               GIT_TEST_SPARSE_INDEX=1 $* >../sparse-index-out 2>../sparse-index-err
>         )
>  }
>
> @@ -121,7 +124,9 @@ run_on_all () {
>  test_all_match () {
>         run_on_all $* &&
>         test_cmp full-checkout-out sparse-checkout-out &&
> -       test_cmp full-checkout-err sparse-checkout-err
> +       test_cmp full-checkout-out sparse-index-out &&
> +       test_cmp full-checkout-err sparse-checkout-err &&
> +       test_cmp full-checkout-err sparse-index-err
>  }
>
>  test_sparse_match () {
> @@ -130,6 +135,38 @@ test_sparse_match () {
>         test_cmp sparse-checkout-err sparse-index-err
>  }
>
> +test_expect_success 'sparse-index contents' '
> +       init_repos &&
> +
> +       test-tool -C sparse-index read-cache --table --no-stat >cache &&
> +       for dir in folder1 folder2 x
> +       do
> +               TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
> +               grep "0b0000 0755 $TREE $dir/" cache \
> +                       || return 1
> +       done &&
> +
> +       GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set folder1 &&
> +
> +       test-tool -C sparse-index read-cache --table --no-stat >cache &&
> +       for dir in deep folder2 x
> +       do
> +               TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
> +               grep "0b0000 0755 $TREE $dir/" cache \

It would seem clearer to me if this output were to better match `git
ls-tree -rt ...` output (or at least the ' tree ' lines from such
output).

> +                       || return 1
> +       done &&
> +
> +       GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set deep/deeper1 &&
> +
> +       test-tool -C sparse-index read-cache --table --no-stat >cache &&
> +       for dir in deep/deeper2 folder1 folder2 x
> +       do
> +               TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
> +               grep "0b0000 0755 $TREE $dir/" cache \
> +                       || return 1
> +       done
> +'
> +
>  test_expect_success 'expanded in-memory index matches full index' '
>         init_repos &&
>         test_sparse_match test-tool read-cache --expand --table --no-stat
> @@ -137,6 +174,7 @@ test_expect_success 'expanded in-memory index matches full index' '
>
>  test_expect_success 'status with options' '
>         init_repos &&
> +       test_sparse_match ls &&
>         test_all_match git status --porcelain=v2 &&
>         test_all_match git status --porcelain=v2 -z -u &&
>         test_all_match git status --porcelain=v2 -uno &&
> @@ -169,7 +207,7 @@ test_expect_success 'add, commit, checkout' '
>
>         test_all_match git add -A &&
>         test_all_match git status --porcelain=v2 &&
> -       test_all_match git commit -m "Extend README.md" &&
> +       test_all_match git commit -m "Extend-README.md" &&

Why this change?

>
>         test_all_match git checkout HEAD~1 &&
>         test_all_match git checkout - &&
> @@ -273,6 +311,17 @@ test_expect_failure 'checkout and reset (mixed)' '
>         test_all_match git reset update-folder2
>  '
>
> +# Ensure that sparse-index behaves identically to
> +# sparse-checkout with a full index.
> +test_expect_success 'checkout and reset (mixed) [sparse]' '
> +       init_repos &&
> +
> +       test_sparse_match git checkout -b reset-test update-deep &&
> +       test_sparse_match git reset deepest &&
> +       test_sparse_match git reset update-folder1 &&
> +       test_sparse_match git reset update-folder2
> +'
> +
>  test_expect_success 'merge' '
>         init_repos &&
>
> @@ -309,14 +358,20 @@ test_expect_success 'clean' '
>         test_all_match git status --porcelain=v2 &&
>         test_all_match git clean -f &&
>         test_all_match git status --porcelain=v2 &&
> +       test_sparse_match ls &&
> +       test_sparse_match ls folder1 &&
>
>         test_all_match git clean -xf &&
>         test_all_match git status --porcelain=v2 &&
> +       test_sparse_match ls &&
> +       test_sparse_match ls folder1 &&
>
>         test_all_match git clean -xdf &&
>         test_all_match git status --porcelain=v2 &&
> +       test_sparse_match ls &&
> +       test_sparse_match ls folder1 &&
>
> -       test_path_is_dir sparse-checkout/folder1
> +       test_sparse_match test_path_is_dir folder1
>  '
>
>  test_done
> --
> gitgitgadget
