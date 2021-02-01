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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ECCC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 23:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6228164DDD
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 23:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBAXJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 18:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBAXJY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 18:09:24 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71731C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 15:08:44 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id t25so7947146otc.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 15:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57dWp8Wul8xOCwHc4+lWazKiCDe9D3CFWRMmG/3AiLw=;
        b=a4P9dah5dOsm3IO9N6m+VbKVnfrAHikRdC3MJijsiwczCv/M4wdZc4E+1ysBNpgiO9
         hQapNU9k6Kom0ERUIsIu0xe5I8WpTAvoDAMIm3OlkGDokVqZQb6sSZkq/yQ8HcDyhWs1
         Cyjn4s6+ZW406NblvQeuv1BmsYh3PmRHeqCbUqQ2kWjhC0VNOdM//LrJ7CKqhS3L66cw
         3tWCUiGEFkU93+Ac0zYtk2+isQh0qV4vawu5VmeXoMZKLKNKijVX7tM+zkRW3pzVW3h4
         z7EkDtpdsIcqeEEQt4q8onuiUD7SeLTLvsz6CWgsGm9ZoSbrpq7v7Ya/w4YvLGICJwE/
         m7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57dWp8Wul8xOCwHc4+lWazKiCDe9D3CFWRMmG/3AiLw=;
        b=tLaCugtoqdiiLYUi3yKnc41YrC4mIjMmFgRgWe4MCjBQIFIutcXmUrUEJzetQM13Zh
         dtBJwRkBZboTFxWKTfv9QgNbS0DTc6aoc92D8dg9mo7+RntAGztCsQjn7JAwCIMPNWoS
         egmh2wjAhQAI5FaZBWOLsdVRl0c6/Jdk2Eh5OEk891zAcT7uLez85hYZY2w0zSEELde/
         rhrVu9/Li4XqPkKS/KgtgrhtHbUr9iJqQjfRjezRX3HYJS3WeF4aSKjv09qEjN78EiiC
         ZyYooN/9jjVZUpi4qgDRpTDXAVz21w/CjpOO2ms+09FALILshAdYfKkVrEw40GuKKnZI
         h05w==
X-Gm-Message-State: AOAM531145yVgannEdmGOTu9WqbyQGTWpwoAvIXheAwbEhr/WKUa+vFw
        1DdNYLZlc7m9OU85Geh6/zzWLW9mYub3GV36Mrk=
X-Google-Smtp-Source: ABdhPJzvyJkX54cIUqS5H/tFPrUB9myzCjxu30tnc1gkBjFzoqcCfS+m6eltlXu6fn8sT4cCfIKtDSuRTEOEneh+34k=
X-Received: by 2002:a9d:506:: with SMTP id 6mr13019322otw.162.1612220923723;
 Mon, 01 Feb 2021 15:08:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <b40872d34d45220bc9f3ff11a9b5f49dc34942a9.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <b40872d34d45220bc9f3ff11a9b5f49dc34942a9.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Feb 2021 15:08:32 -0800
Message-ID: <CABPp-BH0Kwb8_id=TEUjrhDK1KtxcCL=ZEFPz+0NMRwpZ8y4YQ@mail.gmail.com>
Subject: Re: [PATCH 22/27] add: allow operating on a sparse-only index
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
> Replace enough callers to ensure_full_index() to instead call
> expand_to_path() to reduce how often 'git add' expands a sparse index in
> memory (before writing a sparse index again).
>
> One non-obvious case is index_name_pos_also_unmerged() which is only hit
> on the Windows platform (in my tests). Use expand_to_path() instead of
> ensure_full_index().

I read this paragraph as saying that the conversion of
index_name_pos_also_unmerged() was tricky, whereas after reading the
patch it looks like the conversion was trivial and you were perhaps
meaning to say that it is easy to miss that this function also needs a
conversion.  Also, since the second sentence is true of all the
conversions, not sure how much it helps to highlight it when just
talking about this one function.
Both of these are minor quibbles, but if there's a clever way to
reword here that reduces potential confusion, that'd be great.

> Add a test to check that 'git add -A' and 'git add <file>' does not
> expand the index at all, as long as <file> is not within a sparse
> directory.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/add.c                            |  3 +++
>  dir.c                                    |  8 ++++----
>  read-cache.c                             | 10 +++++-----
>  sparse-index.c                           | 18 ++++++++++++++----
>  t/t1092-sparse-checkout-compatibility.sh | 14 ++++++++++++++
>  5 files changed, 40 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index a825887c503..b73f8d51de6 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -491,6 +491,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>         add_new_files = !take_worktree_changes && !refresh_only && !add_renormalize;
>         require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
>
> +       prepare_repo_settings(the_repository);
> +       the_repository->settings.command_requires_full_index = 0;
> +
>         hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
>
>         /*
> diff --git a/dir.c b/dir.c
> index c786fa98d0e..21998c7c4b7 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -18,6 +18,7 @@
>  #include "ewah/ewok.h"
>  #include "fsmonitor.h"
>  #include "submodule-config.h"
> +#include "sparse-index.h"
>
>  /*
>   * Tells read_directory_recursive how a file or directory should be treated.
> @@ -899,9 +900,9 @@ static int read_skip_worktree_file_from_index(struct index_state *istate,
>  {
>         int pos, len;
>
> -       ensure_full_index(istate);
> -
>         len = strlen(path);
> +
> +       expand_to_path(istate, path, len, 0);
>         pos = index_name_pos(istate, path, len);
>         if (pos < 0)
>                 return -1;
> @@ -1707,8 +1708,7 @@ static enum exist_status directory_exists_in_index(struct index_state *istate,
>         if (ignore_case)
>                 return directory_exists_in_index_icase(istate, dirname, len);
>
> -       ensure_full_index(istate);
> -
> +       expand_to_path(istate, dirname, len, 0);
>         pos = index_name_pos(istate, dirname, len);
>         if (pos < 0)
>                 pos = -pos-1;
> diff --git a/read-cache.c b/read-cache.c
> index 78910d8f1b7..8c974829497 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -647,7 +647,7 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
>         int pos;
>         struct cache_entry *ce;
>
> -       ensure_full_index(istate);
> +       expand_to_path(istate, path, namelen, 0);
>
>         pos = index_name_pos(istate, path, namelen);
>         if (pos >= 0)
> @@ -724,8 +724,6 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>         int hash_flags = HASH_WRITE_OBJECT;
>         struct object_id oid;
>
> -       ensure_full_index(istate);
> -
>         if (flags & ADD_CACHE_RENORMALIZE)
>                 hash_flags |= HASH_RENORMALIZE;
>
> @@ -733,6 +731,8 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>                 return error(_("%s: can only add regular files, symbolic links or git-directories"), path);
>
>         namelen = strlen(path);
> +       expand_to_path(istate, path, namelen, 0);
> +
>         if (S_ISDIR(st_mode)) {
>                 if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
>                         return error(_("'%s' does not have a commit checked out"), path);
> @@ -1104,7 +1104,7 @@ static int has_dir_name(struct index_state *istate,
>         size_t len_eq_last;
>         int cmp_last = 0;
>
> -       ensure_full_index(istate);
> +       expand_to_path(istate, ce->name, ce->ce_namelen, 0);
>
>         /*
>          * We are frequently called during an iteration on a sorted
> @@ -1349,7 +1349,7 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
>  {
>         int pos;
>
> -       ensure_full_index(istate);
> +       expand_to_path(istate, ce->name, ce->ce_namelen, 0);
>
>         if (option & ADD_CACHE_JUST_APPEND)
>                 pos = istate->cache_nr;
> diff --git a/sparse-index.c b/sparse-index.c
> index bf8dce9a09b..a201f3b905c 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -286,6 +286,7 @@ static int in_expand_to_path = 0;
>  void expand_to_path(struct index_state *istate,
>                     const char *path, size_t pathlen, int icase)
>  {
> +       struct cache_entry *ce = NULL;
>         struct strbuf path_as_dir = STRBUF_INIT;
>         int pos;
>
> @@ -320,13 +321,22 @@ void expand_to_path(struct index_state *istate,
>
>         if (pos < 0)
>                 pos = -pos - 1;
> +       if (pos < istate->cache_nr)
> +               ce = istate->cache[pos];
>
>         /*
> -        * Even if the path doesn't exist, if the value isn't exactly a
> -        * sparse-directory entry, then there is no need to expand the
> -        * index.
> +        * If we didn't land on a sparse directory, then there is
> +        * nothing to expand.
>          */
> -       if (istate->cache[pos]->ce_mode != CE_MODE_SPARSE_DIRECTORY)
> +       if (ce && !S_ISSPARSEDIR(ce))
> +               goto cleanup;

Seems like these changes to expand_to_path() could and maybe should be
squashed into the commit that introduces expand_to_path()?

> +       /*
> +        * If that sparse directory is not a prefix of the path we
> +        * are looking for, then we don't need to expand.
> +        */
> +       if (ce &&
> +           (ce->ce_namelen >= path_as_dir.len ||
> +            strncmp(ce->name, path_as_dir.buf, ce->ce_namelen)))

Should this also be squashed into the commit that introduces
expand_to_path()?  Why is this check added here?

>                 goto cleanup;
>
>         trace2_region_enter("index", "expand_to_path", istate->repo);
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 09650f0755c..ae594ab880c 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -390,6 +390,20 @@ test_expect_success 'sparse-index is expanded and converted back' '
>         GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
>                 git -C sparse-index -c core.fsmonitor="" reset --hard &&
>         test_region index convert_to_sparse trace2.txt &&
> +       test_region index ensure_full_index trace2.txt &&
> +
> +       rm trace2.txt &&
> +       echo >>sparse-index/README.md &&
> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +               git -C sparse-index -c core.fsmonitor="" add -A &&
> +       test_region index convert_to_sparse trace2.txt &&
> +       test_region index ensure_full_index trace2.txt &&
> +
> +       rm trace2.txt &&
> +       echo >>sparse-index/extra.txt &&
> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +               git -C sparse-index -c core.fsmonitor="" add extra.txt &&
> +       test_region index convert_to_sparse trace2.txt &&
>         test_region index ensure_full_index trace2.txt
>  '
>
> --
> gitgitgadget
>
