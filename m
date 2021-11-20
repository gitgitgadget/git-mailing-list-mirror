Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3229C433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 22:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhKTWFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 17:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhKTWFr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 17:05:47 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE249C061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 14:02:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r11so58549595edd.9
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 14:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lH6sdc8gqVx7sIgLvCBYZTRYP10kZh1Dtt1nmIHDaNo=;
        b=hwpRPuKS3xna3c6OsebXDrWsddfqPUdYjIaIMVvtklI7xxM9UklZisEBIGPTh5DzcB
         cyjt6Q1C9LmCDm5I+H8ZOU88VyZIGyG3Kc1K6DIlRM+l70/zrmQOQN6sTu4209vK2P6U
         xs2HH+hXUlCtPofl/42cklFsP55p5N1/1RAAqgmilIfDS3zJGaRHlZGmhFzInNoXhGc9
         uWZCtBglvgT1FuL9S0mLXxF26vI7dXcvO3CUygABHQjEI+c9nRpmWulDdw3s33lE+lyO
         llEiCOt0Ee2jachof9O2EBcYlFiKNhCSiIqTLbNrUwN/uPnIdKRM7dg/Q/maIiGBBgKX
         F2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lH6sdc8gqVx7sIgLvCBYZTRYP10kZh1Dtt1nmIHDaNo=;
        b=QIbhYiIkrf0XSm03OwNGV2ZS+JW8ZdMY0oZK5vodVYXt5pXIS0U+HO06R9TzsLN3b9
         wiEEDhJsLJJ0PZEWeOnG1oYDXO5KfLJrNSFpDKzKC+uao7nTKao9UYu7qi8kHtLnPvMx
         I5sHA1cNVxqS5DfwwzCHT42UiSmQz7NLZaf7jskFEgwn4Dkx091eL2XwVvbOVOm9EFp5
         uVxBpr3TEOXXmpT8/QnvV28r5pngPvTqqvaCAXutvqifvTVs6w++b3PN/RSi3z2BwTJQ
         2386zDDBmNBjpM+aSQpneznaLt/9wmT3w/x/Lzf/eKcqXyAQb8sKpyy9O1pkFYyEqP3c
         R57w==
X-Gm-Message-State: AOAM530PptHYGhGG2aABdt1pDEIoNNLx8FOdrUj+QK1p/7XpcS7+HEyW
        9rBp+5yqxvBuXWnHvAUfpFHJFm+CTqILc65Ro18=
X-Google-Smtp-Source: ABdhPJxydLy0G9gK3xpOoU3x143UKvdBdp8XyERtnrw7askQkp4/V1JNYrqAG3NMMOUXqMxkuq+217RR3U3PQPiEXpM=
X-Received: by 2002:a05:6402:405:: with SMTP id q5mr42160344edv.62.1637445762194;
 Sat, 20 Nov 2021 14:02:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com> <6ef8e4e31d39386e3a6fa1e6c24acd2c005fbd54.1633641339.git.gitgitgadget@gmail.com>
In-Reply-To: <6ef8e4e31d39386e3a6fa1e6c24acd2c005fbd54.1633641339.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Nov 2021 14:02:30 -0800
Message-ID: <CABPp-BEcWutcLJWJvO-DC5B59EO4focgCJG1OWYg080j8ti44Q@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] reset: make --mixed sparse-aware
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 7, 2021 at 2:15 PM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> Remove the `ensure_full_index` guard on `read_from_tree` and update `git
> reset --mixed` to ensure it can use sparse directory index entries wherever
> possible. Sparse directory entries are reset use `diff_tree_oid`, which

I am having trouble parsing this second sentence.  Was this meant to
be 'Sparse directory entries _which_ are reset use...'?

> requires `change` and `add_remove` functions to process the internal
> contents of the sparse directory. The `recursive` diff option handles cases
> in which `reset --mixed` must diff/merge files that are nested multiple
> levels deep in a sparse directory.
>
> The use of pathspecs with `git reset --mixed` introduces scenarios in which
> internal contents of sparse directories may be matched by the pathspec. In
> order to reset *all* files in the repo that may match the pathspec, the
> following conditions on the pathspec require index expansion before
> performing the reset:
>
> * "magic" pathspecs
> * wildcard pathspecs that do not match only in-cone files or entire sparse
>   directories
> * literal pathspecs matching something outside the sparse checkout
>   definition
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/reset.c                          | 78 +++++++++++++++++++++++-
>  t/t1092-sparse-checkout-compatibility.sh | 17 ++++++
>  2 files changed, 93 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 0ac0de7dc97..60517e7e1d6 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -148,7 +148,9 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>                  * If the file 1) corresponds to an existing index entry with
>                  * skip-worktree set, or 2) does not exist in the index but is
>                  * outside the sparse checkout definition, add a skip-worktree bit
> -                * to the new index entry.
> +                * to the new index entry. Note that a sparse index will be expanded
> +                * if this entry is outside the sparse cone - this is necessary
> +                * to properly construct the reset sparse directory.
>                  */
>                 pos = cache_name_pos(one->path, strlen(one->path));
>                 if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) ||
> @@ -166,6 +168,73 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>         }
>  }
>
> +static int pathspec_needs_expanded_index(const struct pathspec *pathspec)
> +{
> +       unsigned int i, pos;
> +       int res = 0;
> +       char *skip_worktree_seen = NULL;
> +
> +       /*
> +        * When using a magic pathspec, assume for the sake of simplicity that
> +        * the index needs to be expanded to match all matchable files.
> +        */
> +       if (pathspec->magic)
> +               return 1;
> +
> +       for (i = 0; i < pathspec->nr; i++) {
> +               struct pathspec_item item = pathspec->items[i];
> +
> +               /*
> +                * If the pathspec item has a wildcard, the index should be expanded
> +                * if the pathspec has the possibility of matching a subset of entries inside
> +                * of a sparse directory (but not the entire directory).
> +                *
> +                * If the pathspec item is a literal path, the index only needs to be expanded
> +                * if a) the pathspec isn't in the sparse checkout cone (to make sure we don't
> +                * expand for in-cone files) and b) it doesn't match any sparse directories
> +                * (since we can reset whole sparse directories without expanding them).
> +                */
> +               if (item.nowildcard_len < item.len) {
> +                       for (pos = 0; pos < active_nr; pos++) {
> +                               struct cache_entry *ce = active_cache[pos];
> +
> +                               if (!S_ISSPARSEDIR(ce->ce_mode))
> +                                       continue;

This double loop over all pathspecs and over all index entries reminds
me of the original non-cone mode sparsity patterns.  Stolee introduced
cone mode patterns specifically to avoid the expensiveness of such
double loops (cf.
https://lore.kernel.org/git/19d664a5dada87a9a8dcf18d7548582275593f10.1566313865.git.gitgitgadget@gmail.com/).
Can one of the functions he added allow us to avoid this double loop,
or are there complications that don't allow this (e.g. the actually
SKIP_WORKTREE paths don't quite match the requested sparsity paths in
some cases, or here we are faced with just a leading path of multiple
index entries)?

> +                               /*
> +                                * If the pre-wildcard length is longer than the sparse
> +                                * directory name and the sparse directory is the first
> +                                * component of the pathspec, need to expand the index.
> +                                */
> +                               if (item.nowildcard_len > ce_namelen(ce) &&
> +                                   !strncmp(item.original, ce->name, ce_namelen(ce))) {
> +                                       res = 1;
> +                                       break;
> +                               }
> +
> +                               /*
> +                                * If the pre-wildcard length is shorter than the sparse
> +                                * directory and the pathspec does not match the whole
> +                                * directory, need to expand the index.
> +                                */
> +                               if (!strncmp(item.original, ce->name, item.nowildcard_len) &&
> +                                   wildmatch(item.original, ce->name, 0)) {
> +                                       res = 1;
> +                                       break;
> +                               }
> +                       }
> +               } else if (!path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
> +                          !matches_skip_worktree(pathspec, i, &skip_worktree_seen))

Oh, so you can at least generally avoid the double loop.  That's good.
So is this just a case of wildcards are special and there isn't a way,
even in cone-mode, to avoid the double loop?

(Given that I'm so tardy in reviewing this, even if the answer is that
the double loop is avoidable, or if we just don't know, I'd be totally
fine with a 'TODO: consider whether this double loop could be avoided
in cone mode using some kind of variant of
path_in_cone_mode_sparse_checkout()')

> +                       res = 1;
> +
> +               if (res > 0)
> +                       break;
> +       }
> +
> +       free(skip_worktree_seen);
> +       return res;
> +}
> +
>  static int read_from_tree(const struct pathspec *pathspec,
>                           struct object_id *tree_oid,
>                           int intent_to_add)
> @@ -178,9 +247,14 @@ static int read_from_tree(const struct pathspec *pathspec,
>         opt.format_callback = update_index_from_diff;
>         opt.format_callback_data = &intent_to_add;
>         opt.flags.override_submodule_config = 1;
> +       opt.flags.recursive = 1;
>         opt.repo = the_repository;
> +       opt.change = diff_change;
> +       opt.add_remove = diff_addremove;
> +
> +       if (pathspec->nr && the_index.sparse_index && pathspec_needs_expanded_index(pathspec))
> +               ensure_full_index(&the_index);
>
> -       ensure_full_index(&the_index);
>         if (do_diff_cache(tree_oid, &opt))
>                 return 1;
>         diffcore_std(&opt);
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 4ac93874cb2..c9343ff5b9c 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -774,11 +774,28 @@ test_expect_success 'sparse-index is not expanded' '
>                 ensure_not_expanded reset --hard $ref || return 1
>         done &&
>
> +       ensure_not_expanded reset --mixed base &&
>         ensure_not_expanded reset --hard update-deep &&
>         ensure_not_expanded reset --keep base &&
>         ensure_not_expanded reset --merge update-deep &&
>         ensure_not_expanded reset --hard &&
>
> +       ensure_not_expanded reset base -- deep/a &&
> +       ensure_not_expanded reset base -- nonexistent-file &&
> +       ensure_not_expanded reset deepest -- deep &&
> +
> +       # Although folder1 is outside the sparse definition, it exists as a
> +       # directory entry in the index, so the pathspec will not force the
> +       # index to be expanded.
> +       ensure_not_expanded reset deepest -- folder1 &&
> +       ensure_not_expanded reset deepest -- folder1/ &&
> +
> +       # Wildcard identifies only in-cone files, no index expansion
> +       ensure_not_expanded reset deepest -- deep/\* &&
> +
> +       # Wildcard identifies only full sparse directories, no index expansion
> +       ensure_not_expanded reset deepest -- folder\* &&
> +
>         ensure_not_expanded checkout -f update-deep &&
>         test_config -C sparse-index pull.twohead ort &&
>         (
> --
> gitgitgadget
