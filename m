Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F75AC433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 16:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C5320709
	for <git@archiver.kernel.org>; Wed, 20 May 2020 16:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="And7HNGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETQ3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 12:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETQ3F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 12:29:05 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A016EC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 09:29:05 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id z3so2939607otp.9
        for <git@vger.kernel.org>; Wed, 20 May 2020 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4eoZT+o3oaoCREd+CQwxEXw34+Y0K3t2Zs6XdlaEdk=;
        b=And7HNGoCErmuozYA962bdtXhBMpJLQDjCz+bazhFtCtr9Di2N6GJNZXXKkFaPvihJ
         s/aVW8YKx4W+8Nw9Rb3XEsj7Yx+HaAQm3oNRXfTqOZmn7GhaX55TyUiEezqtO5IELNJJ
         dKWMeQYNJoPQ5I1rK2KepLNO7lft4w0rQ1mkftuPf9VgfsV2jhvOg8n1FxARO7SqIg0b
         jGooveUyGaeuuNEsljpSO4OaRYt6P4PuJWpIcLttUgjQy0M9Yy5n5z3zaoqj1c4fyrNY
         kVATfeCg50JTsIGeIWI+4AJAaBefh/Yc3kvjkI7qlS+ucekZAN3ual/LVhfRMLb+x/h9
         bNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4eoZT+o3oaoCREd+CQwxEXw34+Y0K3t2Zs6XdlaEdk=;
        b=JY6KkSlxdJxW4wVVOcf5mvWCyhzoIzpdwGX93w4ctv453oCXUIc7DG6yBakSxBABkU
         oMPWgxsQTwstvns6+ptBZUv6/nwjz1eOpGfszsYhRKOC7uZ1Kvrvv08K0cmX9XPved2Z
         1KqjOUDnL2il9nB5u4hUSBBZwrrFoCPKps9M0oJowW5SJ0eVpMCUdqEq302GFlORelkv
         S6qR7s+vdSE2QKsvmp2mRYDC5y9+tR05nKZI5N5+RaB5myJ584FMASgwVf6VQWGNy8r6
         IrLNyr6UfjXkNvXU2qeJtRUl2RPG48zMZHpcaFLm2RztiK1pbA0cXRKUWsHtIKFE5B/y
         ReLA==
X-Gm-Message-State: AOAM530J6dY6na/lS/URMDKrkNp1XJ50DXDXpeEUfjzx8C+KWb6JHFRP
        FRO9067fT5Kfuq9msogYnVGGTXiUAwkJl7yk4O4=
X-Google-Smtp-Source: ABdhPJyVeILpua0NtdrvJO3CIUDJNz+4hsATsw/t0K4xELdmmHzCzdnkW52XSURpQhP54T3rRit+lhen5lC8QpKyG8s=
X-Received: by 2002:a05:6830:4c3:: with SMTP id s3mr3870966otd.162.1589992144694;
 Wed, 20 May 2020 09:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.627.git.1588857462.gitgitgadget@gmail.com> <9a2cb7bb5ed7a5dc039d4b47bfee83c589252a45.1588857462.git.gitgitgadget@gmail.com>
In-Reply-To: <9a2cb7bb5ed7a5dc039d4b47bfee83c589252a45.1588857462.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 May 2020 09:28:53 -0700
Message-ID: <CABPp-BGnj=7BNK51yKC6J+sfa5ibvyeO+qD6_B7Bcm1zi6q_zA@mail.gmail.com>
Subject: Re: [PATCH 05/10] sparse-checkout: automatically update in-tree definition
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, newren@gmaill.com,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for the long delay.  I'm trying to read through the patch series
but may comment out of order...

On Thu, May 7, 2020 at 6:21 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> A benefit of having sparse-checkouts defined in the tree data is that
> the sparse-checkout definition can change over time. To take advantage
> of that data, a user could run "git sparse-checkout reapply" whenever
> they thought the sparse-checkout definition was out of date. That is
> likely too manual of a process, since a user would probably only
> discover this after a failure to accomplish their goal, such as a build
> failure.
>
> Prevent user frustration by automatically updating the sparse-checkout
> definition after changing the index when an in-tree definition is
> provided by config. This will happen during every index change,
> including every step of a rebase, including conflict states.

...every step of a rebase _that writes to the index_.  (Currently,
rebase writes to the index and working tree with every commit that is
applied, though that's a waste of time and resources; if the patch
applies cleanly it should be done in-memory and just continue on to
the next one.  That avoids dirtying working tree files unnecessarily
too.  I'm hoping to start working on it again soon...)

> Special care was needed around the --no-sparse-checkout option in "git
> read-tree". This previously relied on changing the skip_sparse_checkout
> option in "struct unpack_trees_options" to prevent applying the
> skip-worktree bits. However, now that we make a second update to the
> index focusing on the skip-worktree bits, this needs to be prevented in
> another way. The simplest thing to do was disable the feature through
> the core_apply_sparse_checkout global variable.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt |  7 ++++---
>  builtin/commit.c                      |  4 +++-
>  builtin/read-tree.c                   |  4 ++++
>  read-cache.c                          |  8 +++++---
>  sparse-checkout.c                     | 26 +++++++++++++++++++++++++-
>  sparse-checkout.h                     |  1 +
>  t/t1091-sparse-checkout-builtin.sh    | 19 +++++++++++++++----
>  7 files changed, 57 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index da9322c5e41..c1713ebb1d2 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -233,9 +233,10 @@ Use `git sparse-checkout set --in-tree <path>` to initialize the patterns
>  to those included in the file at `<path>`. This will override any existing
>  patterns you have in your sparse-checkout file.
>
> -After switching between commits with different versions of this file, run
> -`git sparse-checkout reapply` to adjust the sparse-checkout patterns to
> -the new definition.
> +As Git switches between commits, it will update the in-tree sparse-checkout
> +definition according to the files available at the new commit. If any of
> +the specified files do not exist at the new commit, then the sparse-checkout
> +definition will not change.
>
>
>  SUBMODULES
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 7ba33a3bec4..0eab8d74469 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -36,6 +36,7 @@
>  #include "help.h"
>  #include "commit-reach.h"
>  #include "commit-graph.h"
> +#include "sparse-checkout.h"
>
>  static const char * const builtin_commit_usage[] = {
>         N_("git commit [<options>] [--] <pathspec>..."),
> @@ -222,7 +223,8 @@ static int commit_index_files(void)
>         case COMMIT_AS_IS:
>                 break; /* nothing to do */
>         case COMMIT_NORMAL:
> -               err = commit_lock_file(&index_lock);
> +               err = commit_lock_file(&index_lock) ||
> +                     update_in_tree_sparse_checkout();
>                 break;
>         case COMMIT_PARTIAL:
>                 err = commit_lock_file(&index_lock);

I like the fact that you found one simple place to change to make sure
all places call the necessary code.  I'm trying to think out loud
about whether that catches everything and whether it has any ill
side-effects.  Not sure if there is one, but...if someone is doing a
merge, a rebase, or even a checkout, then:

* unpack_trees() will apply sparsity patterns (but likely the old ones
that weren't updated yet, right?)
* commit_index_files() will reapply the new sparsity patterns

While I think this doesn't present any problem from a correctness
point of view, is there a performance issue here?  Is there a case
where this will cause a huge amount of unnecessary disk activity, e.g.
when old rules include some big directory that later rules don't?

> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index af7424b94c8..9ae81ffffa1 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -247,6 +247,10 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>                 parse_tree(tree);
>                 init_tree_desc(t+i, tree->buffer, tree->size);
>         }
> +
> +       if (opts.skip_sparse_checkout)
> +               core_apply_sparse_checkout = 0;
> +
>         if (unpack_trees(nr_trees, t, &opts))
>                 return 128;
>
> diff --git a/read-cache.c b/read-cache.c
> index aa427c5c170..150e73feb0d 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -25,6 +25,7 @@
>  #include "fsmonitor.h"
>  #include "thread-utils.h"
>  #include "progress.h"
> +#include "sparse-checkout.h"
>
>  /* Mask for the name length in ce_flags in the on-disk index */
>
> @@ -3074,9 +3075,10 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
>
>         if (ret)
>                 return ret;
> -       if (flags & COMMIT_LOCK)
> -               ret = commit_locked_index(lock);
> -       else
> +       if (flags & COMMIT_LOCK) {
> +               ret = commit_locked_index(lock) ||
> +                     update_in_tree_sparse_checkout();
> +       } else
>                 ret = close_lock_file_gently(lock);
>
>         run_hook_le(NULL, "post-index-change",
> diff --git a/sparse-checkout.c b/sparse-checkout.c
> index d6c27ca19c4..6c58fda9722 100644
> --- a/sparse-checkout.c
> +++ b/sparse-checkout.c
> @@ -92,9 +92,12 @@ int load_in_tree_pattern_list(struct repository *r,
>                  * Exit silently, as this is likely the case where Git
>                  * changed branches to a location where the inherit file
>                  * does not exist. Do not update the sparse-checkout.
> +                *
> +                * Use -1 return to ensure populate_from_existing_patterns()
> +                * skips the sparse-checkout updates.
>                  */
>                 if (pos < 0)
> -                       return 1;
> +                       return -1;
>
>                 oid = &istate->cache[pos]->oid;
>                 type = oid_object_info(r, oid, NULL);
> @@ -145,6 +148,7 @@ int populate_sparse_checkout_patterns(struct pattern_list *pl)
>         return result;
>  }
>
> +static int updating_sparse_checkout = 0;
>  int update_working_directory(struct pattern_list *pl)
>  {
>         enum update_sparsity_result result;
> @@ -152,6 +156,10 @@ int update_working_directory(struct pattern_list *pl)
>         struct lock_file lock_file = LOCK_INIT;
>         struct repository *r = the_repository;
>
> +       if (updating_sparse_checkout)
> +               return 0;
> +       updating_sparse_checkout = 1;
> +
>         memset(&o, 0, sizeof(o));
>         o.verbose_update = isatty(2);
>         o.update = 1;
> @@ -180,9 +188,24 @@ int update_working_directory(struct pattern_list *pl)
>         else
>                 rollback_lock_file(&lock_file);
>
> +       updating_sparse_checkout = 0;
>         return result;
>  }
>
> +int update_in_tree_sparse_checkout(void)
> +{
> +       const char *first_value;
> +
> +       if (!core_apply_sparse_checkout)
> +               return 0;
> +
> +       /* only update if doing so due to sparse.inTree. */
> +       if (!git_config_get_value(SPARSE_CHECKOUT_IN_TREE, &first_value) &&
> +           first_value)
> +               return update_working_directory(NULL);
> +       return 0;
> +}
> +
>  static char *escaped_pattern(char *pattern)
>  {
>         char *p = pattern;
> @@ -273,6 +296,7 @@ int write_patterns_and_update(struct pattern_list *pl)
>                 free(sparse_filename);
>                 clear_pattern_list(pl);
>                 update_working_directory(NULL);
> +               updating_sparse_checkout = 0;
>                 return result;
>         }
>
> diff --git a/sparse-checkout.h b/sparse-checkout.h
> index 993a5701a60..fb0ba48524a 100644
> --- a/sparse-checkout.h
> +++ b/sparse-checkout.h
> @@ -13,6 +13,7 @@ char *get_sparse_checkout_filename(void);
>  int populate_sparse_checkout_patterns(struct pattern_list *pl);
>  void write_patterns_to_file(FILE *fp, struct pattern_list *pl);
>  int update_working_directory(struct pattern_list *pl);
> +int update_in_tree_sparse_checkout(void);
>  int write_patterns(struct pattern_list *pl, int and_update);
>  int write_patterns_and_update(struct pattern_list *pl);
>  void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path);
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 1040bf9c261..fdaafba5377 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -605,6 +605,7 @@ test_expect_success MINGW 'cone mode replaces backslashes with slashes' '
>  '
>
>  test_expect_success 'basis of --in-tree' '
> +       git -C repo branch no-in-tree &&
>         git -C repo config auto.crlf false &&
>         cat >folder1 <<-\EOF &&
>         [sparse]
> @@ -690,18 +691,28 @@ test_expect_success '"add" with --in-tree' '
>         check_files repo a deep folder1
>  '
>
> -test_expect_success 'reapply after updating in-tree file' '
> +test_expect_success 'automatically change after updating in-tree file' '
>         git -C repo sparse-checkout set --in-tree .sparse/sparse &&
>         check_files repo a &&
>         test_path_is_dir repo/.sparse &&
> -       echo "\tdir = folder1" >>repo/.sparse/sparse &&
> +       printf "\tdir = folder1\n" >>repo/.sparse/sparse &&
>         git -C repo commit -a -m "Update sparse file" &&
> -       git -C repo sparse-checkout reapply &&
>         check_files repo a folder1 &&
>         test_path_is_dir repo/.sparse &&
>         git -C repo checkout HEAD~1 &&
> -       git -C repo sparse-checkout reapply &&
>         check_files repo a &&
> +       test_path_is_dir repo/.sparse &&
> +       git -C repo checkout - &&
> +       check_files repo a folder1 &&
> +       test_path_is_dir repo/.sparse
> +'
> +
> +test_expect_success 'keep definition when in-tree file is missing' '
> +       git -C repo checkout no-in-tree &&
> +       check_files repo a folder1 &&
> +       test_path_is_missing repo/.sparse &&
> +       git -C repo checkout - &&
> +       check_files repo a folder1 &&
>         test_path_is_dir repo/.sparse
>  '
>
> --
> gitgitgadget
>
