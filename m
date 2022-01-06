Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7F9C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 01:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344453AbiAFBwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 20:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344450AbiAFBwe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 20:52:34 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF1C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 17:52:33 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j6so3506568edw.12
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 17:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKU9TObr/XLc52s7fuE9bfVeePykUdJyfHUQNobYKLo=;
        b=L09TrdRFbn6xVz3Wu+g3WgcYBbWkA7p5yE7tkoO/Z5C3h9oenwvruL3E8oiWTp3Fv+
         GO1XNv0/DwwgdK/d4+TtgMHN9LIte1W0GbMli8B2qYXwNMuhKc14xpdEgThUo18KbhGw
         WwQ7nYsIezx/nKxFRKQ3aUjrv1/KEZPJzKLvEfH9BtR+it9fB1Uxkon/dsSNbxWm7piN
         zGwGauAQwsE9QKukunw8BYa7+Gni2yCeuOxIFtC/mYrHY7CB0H1o8P5KhbmMTbRIgmlG
         ciAfszT0fzwxBqBWVcdtTB/swosWfcsGmd8TgUIJ+jajun1MhPKcPBmERGroBYVaenFU
         z1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKU9TObr/XLc52s7fuE9bfVeePykUdJyfHUQNobYKLo=;
        b=F+GdjI90R2AxmZ2cR4j3pKEbGqEbAmz50ldiJ/JlmJfdJLHO/Sxv3wQXtlSloSOmKR
         tc1Nec9rNo6mtOvs/W4dcj8tmCJrXl0aZ9cZkLkU/rdE8gWBhP3Se8PYjtlRaYWLal+m
         G75D5oaVemq1omLt0r8wvpu4dKKrsTogs8ArcY2grxEasob6146dQFhVR9/z9gtZd2CD
         Z5yienKLImYvt1cr5z/5FZ5/4Zw/fDPmrHkWqcE1wPuQjzhBjwmuZQV3rfThT+6KuWpr
         /uR8PfIWbx3VU4gyALNpzdxpJ2tGLXpQePunmXs56rdW4V6YBts96LKsqlPhgxZP7acP
         Z+DQ==
X-Gm-Message-State: AOAM531CEpv2ekEP3LvMHuXlXU2a92+/e8ey76Ip5m9HsBOTg01y5Os9
        buGxr4gEIyiAD64wtUwAtRgIprRjDWGRPze8ffM=
X-Google-Smtp-Source: ABdhPJyVaEBYkeOIHD2tRLp5QI/N//F8fKN/kdn5dixSNcT3XIpVfsO18ejd14VFN2k8zwDdrjZMMJhqLirzE2lbklw=
X-Received: by 2002:a17:906:4790:: with SMTP id cw16mr44770347ejc.493.1641433951930;
 Wed, 05 Jan 2022 17:52:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com> <ec9a751e8dcde99cfaa5c0a855f063de9284057e.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <ec9a751e8dcde99cfaa5c0a855f063de9284057e.1641317820.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Jan 2022 17:52:20 -0800
Message-ID: <CABPp-BGCCzgNJEaZ9fgHCkW52ws-ef+00GBhy+LZ5Tx+XkhqDw@mail.gmail.com>
Subject: Re: [PATCH 5/9] checkout-index: add --ignore-skip-worktree-bits option
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> Update `checkout-index --all` to no longer refresh files that have the
> `skip-worktree` bit set. The newly-added `--ignore-skip-worktree-bits`
> option, when used with `--all`, maintains the old behavior and checks out
> all files regardless of `skip-worktree`.
>
> The ability to toggle whether files should be checked-out based on
> `skip-worktree` already exists in `git checkout` and `git restore` (both of
> which have an `--ignore-skip-worktree-bits` option).

I learned something new.

And ick, what a name.  Why not --ignore-sparsity or something?  Oh well...

> Adding the option to
> `checkout-index` (and changing the corresponding default behavior to respect
> the `skip-worktree` bit) is especially helpful for sparse-checkout: it
> prevents inadvertent creation of *all* files outside the sparse definition
> on disk and eliminates the need to expand a sparse index by default when
> using the `--all` option.
>
> Internal usage of `checkout-index` in `git stash` and `git filter-branch` do
> not make explicit use of files with `skip-worktree` enabled, so
> `--ignore-skip-worktree-bits` is not added to them.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  Documentation/git-checkout-index.txt     | 11 +++++++++--
>  builtin/checkout-index.c                 | 12 ++++++++++--
>  t/t1092-sparse-checkout-compatibility.sh | 10 +++++-----
>  3 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
> index 4d33e7be0f5..2815f3d4b19 100644
> --- a/Documentation/git-checkout-index.txt
> +++ b/Documentation/git-checkout-index.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
>  'git checkout-index' [-u] [-q] [-a] [-f] [-n] [--prefix=<string>]
>                    [--stage=<number>|all]
>                    [--temp]
> +                  [--ignore-skip-worktree-bits]
>                    [-z] [--stdin]
>                    [--] [<file>...]
>
> @@ -37,8 +38,9 @@ OPTIONS
>
>  -a::
>  --all::
> -       checks out all files in the index.  Cannot be used
> -       together with explicit filenames.
> +       checks out all files in the index except for those with the
> +       skip-worktree bit set (see `--ignore-skip-worktree-bits`).
> +       Cannot be used together with explicit filenames.
>
>  -n::
>  --no-create::
> @@ -59,6 +61,11 @@ OPTIONS
>         write the content to temporary files.  The temporary name
>         associations will be written to stdout.
>
> +--ignore-skip-worktree-bits::
> +       Check out all files, including those with the skip-worktree bit
> +       set. Note: may only be used with `--all`; skip-worktree is
> +       ignored when explicit filenames are specified.

Why this restriction?  What if the user ran
   git checkout-index -- '*.c'
That's not an explicit filename, but a glob.

> +
>  --stdin::
>         Instead of taking list of paths from the command line,
>         read list of paths from the standard input.  Paths are
> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index e21620d964e..2053a80103a 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -7,6 +7,7 @@
>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "config.h"
> +#include "dir.h"
>  #include "lockfile.h"
>  #include "quote.h"
>  #include "cache-tree.h"
> @@ -116,7 +117,7 @@ static int checkout_file(const char *name, const char *prefix)
>         return -1;
>  }
>
> -static int checkout_all(const char *prefix, int prefix_length)
> +static int checkout_all(const char *prefix, int prefix_length, int ignore_skip_worktree)
>  {
>         int i, errs = 0;
>         struct cache_entry *last_ce = NULL;
> @@ -125,6 +126,8 @@ static int checkout_all(const char *prefix, int prefix_length)
>         ensure_full_index(&the_index);
>         for (i = 0; i < active_nr ; i++) {
>                 struct cache_entry *ce = active_cache[i];
> +               if (!ignore_skip_worktree && ce_skip_worktree(ce))
> +                       continue;

So here I see you let it fall through to the code below that will
write the file to the working tree...but it doesn't clear the
SKIP_WORKTREE bit in the index when it does so, which I think is a
bug.

>                 if (ce_stage(ce) != checkout_stage
>                     && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
>                         continue;
> @@ -176,6 +179,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>         int i;
>         struct lock_file lock_file = LOCK_INIT;
>         int all = 0;
> +       int ignore_skip_worktree = 0;
>         int read_from_stdin = 0;
>         int prefix_length;
>         int force = 0, quiet = 0, not_new = 0;
> @@ -185,6 +189,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>         struct option builtin_checkout_index_options[] = {
>                 OPT_BOOL('a', "all", &all,
>                         N_("check out all files in the index")),
> +               OPT_BOOL(0, "ignore-skip-worktree-bits", &ignore_skip_worktree,
> +                       N_("do not skip files with skip-worktree set")),
>                 OPT__FORCE(&force, N_("force overwrite of existing files"), 0),
>                 OPT__QUIET(&quiet,
>                         N_("no warning for existing files and files not in index")),
> @@ -247,6 +253,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>
>                 if (all)
>                         die("git checkout-index: don't mix '--all' and explicit filenames");
> +               if (ignore_skip_worktree)
> +                       die("git checkout-index: don't mix '--ignore-skip-worktree-bits' and explicit filenames");
>                 if (read_from_stdin)
>                         die("git checkout-index: don't mix '--stdin' and explicit filenames");
>                 p = prefix_path(prefix, prefix_length, arg);
> @@ -280,7 +288,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>         }
>
>         if (all)
> -               err |= checkout_all(prefix, prefix_length);
> +               err |= checkout_all(prefix, prefix_length, ignore_skip_worktree);
>
>         if (pc_workers > 1)
>                 err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index db7ad41109b..fad61d96107 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -799,14 +799,14 @@ test_expect_success 'checkout-index with folders' '
>         test_all_match test_must_fail git checkout-index -f -- folder1/
>  '
>
> -# NEEDSWORK: even in sparse checkouts, checkout-index --all will create all
> -# files (even those outside the sparse definition) on disk. However, these files
> -# don't appear in the percentage of tracked files in git status.
> -test_expect_failure 'checkout-index --all' '
> +test_expect_success 'checkout-index --all' '
>         init_repos &&
>
>         test_all_match git checkout-index --all &&
> -       test_sparse_match test_path_is_missing folder1
> +       test_sparse_match test_path_is_missing folder1 &&
> +
> +       test_all_match git checkout-index --ignore-skip-worktree-bits --all &&
> +       test_all_match test_path_exists folder1

I added an 'exit 1' here, ran the test and then checked:

$ cd trash\ directory.t1092-sparse-checkout-compatibility/sparse-checkout/
$ git ls-files -t | grep folder1/
S folder1/0/0/0
S folder1/0/1
S folder1/a

So there's some more work to do on this patch.
