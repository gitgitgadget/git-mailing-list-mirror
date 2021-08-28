Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7E6C4320E
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 14:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D115460EBD
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 14:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhH1OTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 10:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhH1OTp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 10:19:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE802C061756
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 07:18:53 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id w4so16831204ljh.13
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oiHNPraMVguNGOy7CxFsUQAIqCQE1NdrSQTKCpfg104=;
        b=XVecZphJo/eQVbD9ljxPIhRJQ94ewlv8ZH5svhYV/iMqo/Vn6TP7SJsuPUPXka0nuv
         ZIPIJdBVqiXqL8OTLqYWnXYaH8VydqnM5G36STRW6nx+8prUsayY0lT0BQd6vT2QrQ1z
         dp/4IHvlAD9oG+BvkuabSBCLqvQ49zmZkY+wiBDwzQA1AVP9/NBPeerhLCwrcPEuxMDB
         UwfCvXQI7YfzsV2Z15NfK47B90nnOMUqtiJuLrljvboikzHMGI2rZIpEjOoP2eSN3ZUZ
         Jbh09CBAWoWu1Tkf1cr7IEPPIWalCWbrv6bGUmOJ6+aSh9clz7wJFFiPIkDHQGEXLRO9
         MS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oiHNPraMVguNGOy7CxFsUQAIqCQE1NdrSQTKCpfg104=;
        b=baBXPnyQ4wavdnjT0Q/vOMwc9sMjX3QxB4tZYsdr4VII/XX33YrLUWA4AvLO36EQ55
         fumqtHUQtjG3+swXBkLmzSwopf/R8gY7gJxWIZrKDxyNFFszWX4BaXp4+gkO5kylmmTI
         Uv77FDpGIxdacMoHa52692aM5YS1Meu6V3RRkIpNonJeaznnf6VWVB758adXHGe3cprL
         nyKWTG0JhXTi4V6XaAU+l7diqCC2tE/QNwcU/rQlUYoJNLrKKZFBKa/fSoNaD17WtUwA
         Yh9qvFQ/IR0xJQuU5X0iZbDUx7roODYCuxQAitESdzohPYKtVhcXeEbfFBNVgxSf8ePj
         p4zQ==
X-Gm-Message-State: AOAM531eQcmuWRFVKO/W3jcxy0g5j/OiZV/5j+kXT3rsUaGJ8g0Ede55
        gjlULDVPo6hNpZlEZcgb+oG60rkoOsESQqoQ+RpZZA==
X-Google-Smtp-Source: ABdhPJxpjc1z2oHRc9N/iD1T2/n0zqLj2zrBtH75OrQjjbaTDTklgJ2hJJCnm0K2D+O7iLVBa7FA6InnSHs/RGOj6OQ=
X-Received: by 2002:a2e:b894:: with SMTP id r20mr12303410ljp.291.1630160332138;
 Sat, 28 Aug 2021 07:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com> <f6c0d4e3a0695c331b8216103bb46bfb4a461d1e.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <f6c0d4e3a0695c331b8216103bb46bfb4a461d1e.1629842085.git.gitgitgadget@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 28 Aug 2021 11:18:40 -0300
Message-ID: <CAHd-oW4ANhC4QF9qWc==3BR1uMWjw-Qb4nNCYdd3s8shWwwT=w@mail.gmail.com>
Subject: Re: [PATCH 12/13] mv: add '--sparse' option to ignore sparse-checkout
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 6:54 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index b58fd4ce5ba..92ea9f0ca37 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -118,17 +118,18 @@ static int index_range_of_same_dir(const char *src, int length,
>  int cmd_mv(int argc, const char **argv, const char *prefix)
>  {
>         int i, flags, gitmodules_modified = 0;
> -       int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
> +       int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0;
>         struct option builtin_mv_options[] = {
>                 OPT__VERBOSE(&verbose, N_("be verbose")),
>                 OPT__DRY_RUN(&show_only, N_("dry run")),
>                 OPT__FORCE(&force, N_("force move/rename even if target exists"),
>                            PARSE_OPT_NOCOMPLETE),
>                 OPT_BOOL('k', NULL, &ignore_errors, N_("skip move/rename errors")),
> +               OPT_BOOL(0, "sparse", &ignore_sparse, N_("allow updating entries outside of the sparse-checkout cone")),

Should this include a doc update too?

>                 OPT_END(),
>         };
>         const char **source, **destination, **dest_path, **submodule_gitfile;
> -       enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
> +       enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
>         struct stat st;
>         struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
>         struct lock_file lock_file = LOCK_INIT;
> @@ -182,11 +183,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>                 if (show_only)
>                         printf(_("Checking rename of '%s' to '%s'\n"), src, dst);
>
> -               if (!path_in_sparse_checkout(src, &the_index)) {
> +               if (!ignore_sparse && !path_in_sparse_checkout(src, &the_index)) {
>                         string_list_append(&only_match_skip_worktree, src);
>                         skip_sparse = 1;
>                 }
> -               if (!path_in_sparse_checkout(dst, &the_index)) {
> +               if (!ignore_sparse && !path_in_sparse_checkout(dst, &the_index)) {
>                         string_list_append(&only_match_skip_worktree, dst);
>                         skip_sparse = 1;
>                 }
> @@ -194,9 +195,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>                         continue;
>
>                 length = strlen(src);
> -               if (lstat(src, &st) < 0)
> -                       bad = _("bad source");
> -               else if (!strncmp(src, dst, length) &&
> +               if (lstat(src, &st) < 0) {
> +                       /* only error if existence is expected. */
> +                       if (modes[i] != SPARSE)
> +                               bad = _("bad source");

OK, so this is about the directories which contain sparse entries in
it, right? In this case, we don't expect such entries to be in the
working tree, so we don't error out if they are missing and still let
the parent directory be moved.

This made me wonder about a slightly different case: would it be
interesting to also allow `git mv --sparse` to rename a single sparse
entry even if it's not in the working tree? I mean, something like:

echo a >a
echo b >b
git add a b
git commit -m files
git sparse-checkout set a
git mv --sparse b c

This currently wouldn't be allowed because "b" is not in the working
tree ("fatal: bad source" error). But, perhaps, would it be
interesting to allow the index to be updated anyway?

> +               } else if (!strncmp(src, dst, length) &&
>                                 (dst[length] == 0 || dst[length] == '/')) {
>                         bad = _("can not move directory into itself");
>                 } else if ((src_is_dir = S_ISDIR(st.st_mode))
> @@ -225,11 +228,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>                                 dst_len = strlen(dst);
>
>                                 for (j = 0; j < last - first; j++) {
> -                                       const char *path = active_cache[first + j]->name;
> +                                       const struct cache_entry *ce = active_cache[first + j];
> +                                       const char *path = ce->name;
>                                         source[argc + j] = path;
>                                         destination[argc + j] =
>                                                 prefix_path(dst, dst_len, path + length + 1);
> -                                       modes[argc + j] = INDEX;
> +                                       modes[argc + j] = ce_skip_worktree(ce) ? SPARSE : INDEX;

OK, here we are assigning the SPARSE mode to sparse index entries that
are inside a directory we want to move. Later iterations of the loop
will then process these entries, see this mode, and not error out if
the files are missing.

>                                         submodule_gitfile[argc + j] = NULL;
>                                 }
>                                 argc += last - first;
> @@ -293,7 +297,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>                         printf(_("Renaming %s to %s\n"), src, dst);
>                 if (show_only)
>                         continue;
> -               if (mode != INDEX && rename(src, dst) < 0) {
> +               if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {

And finally, we don't want to rename the SPARSE working tree file (if
it exists) because its parent directory was already moved.

>                         if (ignore_errors)
>                                 continue;
>                         die_errno(_("renaming '%s' failed"), src);
> diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
> index 5397c6d07bd..517fd587fa8 100755
> --- a/t/t7002-mv-sparse-checkout.sh
> +++ b/t/t7002-mv-sparse-checkout.sh
> @@ -31,7 +31,9 @@ test_expect_success 'mv refuses to move sparse-to-sparse' '
>         echo b >>expect &&
>         echo e >>expect &&
>         cat sparse_hint >>expect &&
> -       test_cmp expect stderr
> +       test_cmp expect stderr &&
> +       git mv --sparse b e 2>stderr &&
> +       test_must_be_empty stderr
>  '
>
>  test_expect_success 'mv refuses to move sparse-to-sparse, ignores failure' '
> @@ -44,7 +46,9 @@ test_expect_success 'mv refuses to move sparse-to-sparse, ignores failure' '
>         echo b >>expect &&
>         echo e >>expect &&
>         cat sparse_hint >>expect &&
> -       test_cmp expect stderr
> +       test_cmp expect stderr &&
> +       git mv --sparse -k b e 2>stderr &&
> +       test_must_be_empty stderr

Nit: Isn't this case a bit redundant considering the test before this
one? That is, with `--sparse` there should be no error for `-k` to
ignore, and in the test above it we already checked that this command
indeed succeeds with `--sparse`.

>
>  test_expect_success 'recursive mv refuses to move (possible) sparse' '
> @@ -80,7 +88,14 @@ test_expect_success 'recursive mv refuses to move (possible) sparse' '
>         echo sub >>expect &&
>         echo sub2 >>expect &&
>         cat sparse_hint >>expect &&
> -       test_cmp expect stderr
> +       test_cmp expect stderr &&
> +       git mv --sparse sub sub2 2>stderr &&
> +       test_must_be_empty stderr &&
> +       git commit -m "moved sub to sub2" &&
> +       git rev-parse HEAD~1:sub >expect &&
> +       git rev-parse HEAD:sub2 >actual &&
> +       test_cmp expect actual &&
> +       git reset --hard HEAD~1

Perhaps this could be a `test_when_finished` (maybe right after the
`git commit` invocation), so that we can restore the original state
for the next tests even if this one fails?
