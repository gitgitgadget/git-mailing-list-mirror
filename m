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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EFCC433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 23:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4419B64FC6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 23:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhCJXod (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 18:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbhCJXoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 18:44:25 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5B6C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 15:44:24 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id j8so18265679otc.0
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 15:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8YDAHkpHp/VBg7esCiImmEPCh2cxWGG+eMbdifbNljM=;
        b=qiJehrYsfEnkf3ndo2QmYhIeVe3FaUqOQcX0rH3HovU7wYNZQ5KoNpVLzP9g9u5FVI
         XbD3eGb9D0IWO5VvNyB1gRD0DPB3dJP9clXT1DipZtOiaqlAl1qFN3eIjJi+Hp5x8Tit
         HtY1JHTW0/rMOvk5j7fazvE4X+C1CrePdBOq6UgP7SK20Wvct79oEaq1UUoRamw9npql
         H91MztTWAZOmrHnzZVQhqM+YuHfSfp9PLqg7rTFiXkbWKjW0ahPi3vShBJmuBfLq/u2I
         cBfLvzDcX6tFsmPUKgK4VXdj7Q7l2CI33N23JnWeTxmifc8cVPaTE5NECTzH3UeOU8Ub
         aSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YDAHkpHp/VBg7esCiImmEPCh2cxWGG+eMbdifbNljM=;
        b=pHWeOYdKWLUFD+gi6C5moNorRI52Cac6YXwlTAaTz5UsqTEV1Oi7X1dTU5npu77iCF
         tNLXcsJFt3sLhtxjb92usXvVmd+RUwxtq73oWag04m+/NSlcjdmdnTNZCEdqsdyXRkWG
         +ksnsSe9Snc6vq4S4K4qNT+9QcBL0CSWzrwngoJwVvnuDS80NTMYgrKh88w8Y2h1BIPn
         FtqPV48h8VLSI11J98SBGEHx49QwpanKZD7F5UBvFZaV/Pfui0GRKaasixXC+Fe8JRh2
         bgzFyNI3i+dLaGyc7CN0x65mexxJvl+0vIWKx5IcC2dc5/UCGyozW0rcRAuN/TJv0ETO
         8JhQ==
X-Gm-Message-State: AOAM531K+CD2P67X+9+Nv/Zuq4rOD2zBsjedJimhdJoJRVzXm5ywMWK+
        4OMaMij59M8C6fAdb2lVVIILvB0l4IJzkEsoKQI=
X-Google-Smtp-Source: ABdhPJwejP+U5hrqeNvZ/h6aCBg8x5lP1j87WNJRKWZH0R5XO/Y1YzviH609bWZB4gwsw5gINCtoeAhWeC3eZKIj5nI=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr4513390otf.345.1615419864080;
 Wed, 10 Mar 2021 15:44:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <pull.883.v2.git.1615404664.gitgitgadget@gmail.com> <f6db0c27a2854b16a3402e4133629a1f479e113d.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <f6db0c27a2854b16a3402e4133629a1f479e113d.1615404665.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 Mar 2021 15:44:13 -0800
Message-ID: <CABPp-BGUqVC7JV7nnNDTt++rHCxUF+98T0OLq5dFf0mOKkp8fw@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] sparse-index: convert from full to sparse
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
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
>
> The conversion process is assisted by the cache-tree extension. This is
> calculated from the full index if it does not already exist. We then
> abandon the cache-tree as it no longer applies to the newly-sparse
> index. Thus, this cache-tree will be recalculated in every
> sparse-full-sparse round-trip until we integrate the cache-tree
> extension with the sparse index.
>
> Some Git commands use the index after writing it. For example, 'git add'
> will update the index, then write it to disk, then read its entries to
> report information. To keep the in-memory index in a full state after
> writing, we re-expand it to a full one after the write. This is wasteful
> for commands that only write the index and do not read from it again,
> but that is only the case until we make those commands "sparse aware."
>
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
>  cache.h                                  |   2 +
>  read-cache.c                             |  26 ++++-
>  sparse-index.c                           | 139 +++++++++++++++++++++++
>  sparse-index.h                           |   1 +
>  t/t1092-sparse-checkout-compatibility.sh |  61 +++++++++-
>  6 files changed, 227 insertions(+), 5 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 2fb483d3c083..5f07a39e501e 100644
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
> diff --git a/cache.h b/cache.h
> index 303411726e10..9217d405b9b8 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -251,6 +251,8 @@ static inline unsigned int create_ce_mode(unsigned int mode)
>  {
>         if (S_ISLNK(mode))
>                 return S_IFLNK;
> +       if (mode == S_IFDIR)
> +               return S_IFDIR;
>         if (S_ISDIR(mode) || S_ISGITLINK(mode))
>                 return S_IFGITLINK;
>         return S_IFREG | ce_permissions(mode);
> diff --git a/read-cache.c b/read-cache.c
> index 97dbf2434f30..92126b9d23c9 100644
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
> @@ -1002,8 +1003,14 @@ int verify_path(const char *path, unsigned mode)
>
>                         c = *path++;
>                         if ((c == '.' && !verify_dotfile(path, mode)) ||
> -                           is_dir_sep(c) || c == '\0')
> +                           is_dir_sep(c))
>                                 return 0;
> +                       /*
> +                        * allow terminating directory separators for
> +                        * sparse directory entries.
> +                        */
> +                       if (c == '\0')
> +                               return S_ISDIR(mode);
>                 } else if (c == '\\' && protect_ntfs) {
>                         if (is_ntfs_dotgit(path))
>                                 return 0;
> @@ -3061,6 +3068,14 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
>                                  unsigned flags)
>  {
>         int ret;
> +       int was_full = !istate->sparse_index;
> +
> +       ret = convert_to_sparse(istate);
> +
> +       if (ret) {
> +               warning(_("failed to convert to a sparse-index"));
> +               return ret;
> +       }
>
>         /*
>          * TODO trace2: replace "the_repository" with the actual repo instance
> @@ -3072,6 +3087,9 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
>         trace2_region_leave_printf("index", "do_write_index", the_repository,
>                                    "%s", get_lock_file_path(lock));
>
> +       if (was_full)
> +               ensure_full_index(istate);
> +
>         if (ret)
>                 return ret;
>         if (flags & COMMIT_LOCK)
> @@ -3162,9 +3180,10 @@ static int write_shared_index(struct index_state *istate,
>                               struct tempfile **temp)
>  {
>         struct split_index *si = istate->split_index;
> -       int ret;
> +       int ret, was_full = !istate->sparse_index;
>
>         move_cache_to_base_index(istate);
> +       convert_to_sparse(istate);
>
>         trace2_region_enter_printf("index", "shared/do_write_index",
>                                    the_repository, "%s", get_tempfile_path(*temp));
> @@ -3172,6 +3191,9 @@ static int write_shared_index(struct index_state *istate,
>         trace2_region_leave_printf("index", "shared/do_write_index",
>                                    the_repository, "%s", get_tempfile_path(*temp));
>
> +       if (was_full)
> +               ensure_full_index(istate);
> +
>         if (ret)
>                 return ret;
>         ret = adjust_shared_perm(get_tempfile_path(*temp));
> diff --git a/sparse-index.c b/sparse-index.c
> index 316cb949b74b..5eb561259bb1 100644
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
> +       de = make_cache_entry(istate, S_IFDIR, &tree->oid, sparse_dir, 0, 0);
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
> +
> +       for (i = start; can_convert && i < end; i++) {
> +               struct cache_entry *ce = istate->cache[i];
> +
> +               if (ce_stage(ce) ||
> +                   !(ce->ce_flags & CE_SKIP_WORKTREE))
> +                       can_convert = 0;
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
> +                * Detect if this is a normal entry outside of any subtree
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
> diff --git a/sparse-index.h b/sparse-index.h
> index 09a20d036c46..64380e121d80 100644
> --- a/sparse-index.h
> +++ b/sparse-index.h
> @@ -3,5 +3,6 @@
>
>  struct index_state;
>  void ensure_full_index(struct index_state *istate);
> +int convert_to_sparse(struct index_state *istate);
>
>  #endif
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 4d789fe86b9d..ca87033d30b0 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2,6 +2,9 @@
>
>  test_description='compare full workdir to sparse workdir'
>
> +GIT_TEST_CHECK_CACHE_TREE=0

I still think it'd be nice to get a comment, either in the code or the
commit message, explaining why your series needs to set
GIT_TEST_CHECK_CACHE_TREE to 0.  I feel like I should almost know the
answer (was this just a preliminary step and it'll later be turned on?
did the cache-tree checking do stuff that assumes no sparse directory
entries? is it really slow?), but I don't.

> +GIT_TEST_SPLIT_INDEX=0
> +
>  . ./test-lib.sh
>
>  test_expect_success 'setup' '
> @@ -121,15 +124,49 @@ run_on_all () {
>  test_all_match () {
>         run_on_all "$@" &&
>         test_cmp full-checkout-out sparse-checkout-out &&
> -       test_cmp full-checkout-err sparse-checkout-err
> +       test_cmp full-checkout-out sparse-index-out &&
> +       test_cmp full-checkout-err sparse-checkout-err &&
> +       test_cmp full-checkout-err sparse-index-err
>  }
>
>  test_sparse_match () {
> -       run_on_sparse $* &&
> +       run_on_sparse "$@" &&
>         test_cmp sparse-checkout-out sparse-index-out &&
>         test_cmp sparse-checkout-err sparse-index-err
>  }
>
> +test_expect_success 'sparse-index contents' '
> +       init_repos &&
> +
> +       test-tool -C sparse-index read-cache --table >cache &&
> +       for dir in folder1 folder2 x
> +       do
> +               TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
> +               grep "040000 tree $TREE $dir/" cache \
> +                       || return 1
> +       done &&
> +
> +       GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set folder1 &&
> +
> +       test-tool -C sparse-index read-cache --table >cache &&
> +       for dir in deep folder2 x
> +       do
> +               TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
> +               grep "040000 tree $TREE $dir/" cache \
> +                       || return 1
> +       done &&
> +
> +       GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set deep/deeper1 &&
> +
> +       test-tool -C sparse-index read-cache --table >cache &&
> +       for dir in deep/deeper2 folder1 folder2 x
> +       do
> +               TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
> +               grep "040000 tree $TREE $dir/" cache \
> +                       || return 1
> +       done
> +'
> +
>  test_expect_success 'expanded in-memory index matches full index' '
>         init_repos &&
>         test_sparse_match test-tool read-cache --expand --table
> @@ -137,6 +174,7 @@ test_expect_success 'expanded in-memory index matches full index' '
>
>  test_expect_success 'status with options' '
>         init_repos &&
> +       test_sparse_match ls &&
>         test_all_match git status --porcelain=v2 &&
>         test_all_match git status --porcelain=v2 -z -u &&
>         test_all_match git status --porcelain=v2 -uno &&
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
>
