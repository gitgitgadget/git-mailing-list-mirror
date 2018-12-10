Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FBE1211B4
	for <e@80x24.org>; Mon, 10 Dec 2018 18:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeLJSTy (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:19:54 -0500
Received: from mail-vs1-f45.google.com ([209.85.217.45]:33278 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeLJSTx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:19:53 -0500
Received: by mail-vs1-f45.google.com with SMTP id p74so7253217vsc.0
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4/BlYaRTl0c4LvOujb3hUc2c3CQQi9Wxyvd74fCWMI=;
        b=Xi1HACg6rdFSutnio+jzaTkYiJDZqlEFwLD/f4XZmnvF9AkAwz8RBSpAXAWuKFmkbp
         aMQxxf7QxOcyZzCgAqENoL0hCwRCQ5ozSWzPWJjk/IsfvKrU/vBbzdT9a3kyxhDYcAaH
         n8667MrUn2sxiO1nSAclOgHcwEHK1zx6yZgqhWtL5RIz+wTchh7FyceQSG45QxHIfLlU
         mk9d7u9wp56mOZ2Xkrc/qcvVAFhFiZlup1VDCG2QPHrhFHFbEaZzipOFUvaGhsx1y1XN
         OUPHSOdc/nWZuL6CcBmCg5gCeaFJQ1DwayRGWMUQ+mWb85va6PwZc+ofUMJBVzAo8xpF
         8lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4/BlYaRTl0c4LvOujb3hUc2c3CQQi9Wxyvd74fCWMI=;
        b=XNoa/DNdIqGAS6EB1rloavZsLq6jz1wALnChdpCpXVb2Ds2HY6fcWCBla9jn3E2hKX
         lrHOMRQMv0Ld/t+T1hlEtDtCdAl1llP2y5re5GsR/NGaZKzkV+W9YN9R8PaUrsxaarbE
         Bw62qo9Oig6idvHu7HiMZXI1UD3MGgvJWUGMRKQtnwfo1ok+NpRwZYTltRbnh2egLJLS
         RkNkyE3bKXIAlQcZASBWWPN0ygeq868PRSKL7lAyCa6jgY0FXNc6ICVnryV7xEWL4Gaq
         C0JNGH2EPszYz7ERz9Ks8VigyfrUGXmqjE5ZGIvmB6U+mjTa71LtjypOdvRtdLz2nMaR
         1bJw==
X-Gm-Message-State: AA+aEWbIywd7JOFaosBMB0lMGGcgY0ObYjOnCeZcb6T+N4q7RQAkI52d
        G7syDFlGuZ/6R0smaHUHn2+c17StNgXjfbVuo1w=
X-Google-Smtp-Source: AFSGD/W2n1w/V/aoS5ZL5/ZqI+N7hGvnLcCYf/sXYfb61OFE+8e7fp9n4CqvaQFYRdwnNTaPA3B2Qf/q32svQhmDafA=
X-Received: by 2002:a67:3c5c:: with SMTP id j89mr5791724vsa.117.1544465991705;
 Mon, 10 Dec 2018 10:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-6-t.gummerer@gmail.com>
In-Reply-To: <20181209200449.16342-6-t.gummerer@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Dec 2018 10:19:40 -0800
Message-ID: <CABPp-BEk+7n2wcbjETishqnMBs5DGrTEvD7gahLtEj5bZ2AYvA@mail.gmail.com>
Subject: Re: [PATCH 5/8] checkout: introduce --{,no-}overlay option
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 12:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> Currently 'git checkout' is defined as an overlay operation, which
> means that if in 'git checkout <tree-ish> -- [<pathspec>]' we have an
> entry in the index that matches <pathspec>, but that doesn't exist in
> <tree-ish>, that entry will not be removed from the index or the
> working tree.
>
> Introduce a new --{,no-}overlay option, which allows using 'git
> checkout' in non-overlay mode, thus removing files from the working
> tree if they do not exist in <tree-ish> but match <pathspec>.
>
> Note that 'git checkout -p <tree-ish> -- [<pathspec>]' already works
> this way, so no changes are needed for the patch mode.  We disallow
> 'git checkout --overlay -p' to avoid confusing users who would expect
> to be able to force overlay mode in 'git checkout -p' this way.

Whoa...that's interesting.  To me, that argues even further that the
traditional checkout behavior was wrong all along and the choice of
--overlay vs. --no-overlay in the original implementation was a total
oversight.  I'm really tempted to say that --no-overlay should just be
the default in checkout too...but maybe that's too high a hill to
climb, at least for now.

Making --overlap and -p incompatible is a reasonable first step.  But
you should probably add a comment to the -p option documentation that
it implies --no-overlay.

> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/checkout.c             | 64 +++++++++++++++++++++++++++-------
>  t/t2025-checkout-no-overlay.sh | 47 +++++++++++++++++++++++++
>  t/t9902-completion.sh          |  1 +
>  3 files changed, 99 insertions(+), 13 deletions(-)
>  create mode 100755 t/t2025-checkout-no-overlay.sh
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index acdafc6e4c..0aef35bbc4 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -44,6 +44,7 @@ struct checkout_opts {
>         int ignore_skipworktree;
>         int ignore_other_worktrees;
>         int show_progress;
> +       int overlay_mode;
>         /*
>          * If new checkout options are added, skip_merge_working_tree
>          * should be updated accordingly.
> @@ -132,7 +133,8 @@ static int skip_same_name(const struct cache_entry *ce, int pos)
>         return pos;
>  }
>
> -static int check_stage(int stage, const struct cache_entry *ce, int pos)
> +static int check_stage(int stage, const struct cache_entry *ce, int pos,
> +                      int overlay_mode)
>  {
>         while (pos < active_nr &&
>                !strcmp(active_cache[pos]->name, ce->name)) {
> @@ -140,6 +142,8 @@ static int check_stage(int stage, const struct cache_entry *ce, int pos)
>                         return 0;
>                 pos++;
>         }
> +       if (!overlay_mode)
> +               return 0;
>         if (stage == 2)
>                 return error(_("path '%s' does not have our version"), ce->name);
>         else
> @@ -165,7 +169,7 @@ static int check_stages(unsigned stages, const struct cache_entry *ce, int pos)
>  }
>
>  static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
> -                         const struct checkout *state)
> +                         const struct checkout *state, int overlay_mode)
>  {
>         while (pos < active_nr &&
>                !strcmp(active_cache[pos]->name, ce->name)) {
> @@ -173,6 +177,10 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
>                         return checkout_entry(active_cache[pos], state, NULL);
>                 pos++;
>         }
> +       if (!overlay_mode) {
> +               unlink_entry(ce);
> +               return 0;
> +       }
>         if (stage == 2)
>                 return error(_("path '%s' does not have our version"), ce->name);
>         else
> @@ -302,15 +310,29 @@ static int checkout_paths(const struct checkout_opts *opts,
>                 ce->ce_flags &= ~CE_MATCHED;
>                 if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
>                         continue;
> -               if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
> -                       /*
> -                        * "git checkout tree-ish -- path", but this entry
> -                        * is in the original index; it will not be checked
> -                        * out to the working tree and it does not matter
> -                        * if pathspec matched this entry.  We will not do
> -                        * anything to this entry at all.
> -                        */
> -                       continue;
> +               if (opts->source_tree && !(ce->ce_flags & CE_UPDATE)) {
> +                       if (!opts->overlay_mode &&
> +                           ce_path_match(&the_index, ce, &opts->pathspec, ps_matched)) {
> +                               /*
> +                                * "git checkout --no-overlay <tree-ish> -- path",
> +                                * and the path is not in tree-ish, but is in
> +                                * the current index, which means that it should
> +                                * be removed.
> +                                */
> +                               ce->ce_flags |= CE_MATCHED | CE_REMOVE | CE_WT_REMOVE;
> +                               continue;
> +                       } else {
> +                               /*
> +                                * "git checkout tree-ish -- path", but this
> +                                * entry is in the original index; it will not
> +                                * be checked out to the working tree and it
> +                                * does not matter if pathspec matched this
> +                                * entry.  We will not do anything to this entry
> +                                * at all.
> +                                */
> +                               continue;
> +                       }
> +               }
>                 /*
>                  * Either this entry came from the tree-ish we are
>                  * checking the paths out of, or we are checking out
> @@ -348,7 +370,7 @@ static int checkout_paths(const struct checkout_opts *opts,
>                         if (opts->force) {
>                                 warning(_("path '%s' is unmerged"), ce->name);
>                         } else if (opts->writeout_stage) {
> -                               errs |= check_stage(opts->writeout_stage, ce, pos);
> +                               errs |= check_stage(opts->writeout_stage, ce, pos, opts->overlay_mode);
>                         } else if (opts->merge) {
>                                 errs |= check_stages((1<<2) | (1<<3), ce, pos);
>                         } else {
> @@ -375,12 +397,14 @@ static int checkout_paths(const struct checkout_opts *opts,
>                                 continue;
>                         }
>                         if (opts->writeout_stage)
> -                               errs |= checkout_stage(opts->writeout_stage, ce, pos, &state);
> +                               errs |= checkout_stage(opts->writeout_stage, ce, pos, &state, opts->overlay_mode);
>                         else if (opts->merge)
>                                 errs |= checkout_merged(pos, &state);
>                         pos = skip_same_name(ce, pos) - 1;
>                 }
>         }
> +       remove_marked_cache_entries(&the_index, 1);
> +       remove_scheduled_dirs();
>         errs |= finish_delayed_checkout(&state);
>
>         if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
> @@ -542,6 +566,11 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
>          * opts->show_progress only impacts output so doesn't require a merge
>          */
>
> +       /*
> +        * opts->overlay_mode cannot be used with switching branches so is
> +        * not tested here
> +        */
> +
>         /*
>          * If we aren't creating a new branch any changes or updates will
>          * happen in the existing branch.  Since that could only be updating
> @@ -1178,6 +1207,10 @@ static int checkout_branch(struct checkout_opts *opts,
>                 die(_("'%s' cannot be used with switching branches"),
>                     "--patch");
>
> +       if (!opts->overlay_mode)
> +               die(_("'%s' cannot be used with switching branches"),
> +                   "--no-overlay");
> +
>         if (opts->writeout_stage)
>                 die(_("'%s' cannot be used with switching branches"),
>                     "--ours/--theirs");
> @@ -1266,6 +1299,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>                             "checkout", "control recursive updating of submodules",
>                             PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
>                 OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
> +               OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
>                 OPT_END(),
>         };
>
> @@ -1274,6 +1308,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>         opts.overwrite_ignore = 1;
>         opts.prefix = prefix;
>         opts.show_progress = -1;
> +       opts.overlay_mode = -1;
>
>         git_config(git_checkout_config, &opts);
>
> @@ -1297,6 +1332,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>         if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_branch) > 1)
>                 die(_("-b, -B and --orphan are mutually exclusive"));
>
> +       if (opts.overlay_mode == 1 && opts.patch_mode)
> +               die(_("-p and --overlay are mutually exclusive"));
> +
>         /*
>          * From here on, new_branch will contain the branch to be checked out,
>          * and new_branch_force and new_orphan_branch will tell us which one of
> diff --git a/t/t2025-checkout-no-overlay.sh b/t/t2025-checkout-no-overlay.sh
> new file mode 100755
> index 0000000000..3575321382
> --- /dev/null
> +++ b/t/t2025-checkout-no-overlay.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +
> +test_description='checkout --no-overlay <tree-ish> -- <pathspec>'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +       git commit --allow-empty -m "initial"
> +'
> +
> +test_expect_success 'checkout --no-overlay deletes files not in <tree>' '
> +       >file &&
> +       mkdir dir &&
> +       >dir/file1 &&
> +       git add file dir/file1 &&
> +       git checkout --no-overlay HEAD -- file &&
> +       test_path_is_missing file &&
> +       test_path_is_file dir/file1
> +'
> +
> +test_expect_success 'checkout --no-overlay removing last file from directory' '
> +       git checkout --no-overlay HEAD -- dir/file1 &&
> +       test_path_is_missing dir
> +'
> +
> +test_expect_success 'checkout -p --overlay is disallowed' '
> +       test_must_fail git checkout -p --overlay HEAD 2>actual &&
> +       test_i18ngrep "fatal: -p and --overlay are mutually exclusive" actual
> +'
> +
> +test_expect_success '--no-overlay --theirs with M/D conflict deletes file' '
> +       test_commit file1 file1 &&
> +       test_commit file2 file2 &&
> +       git rm --cached file1 &&
> +       echo 1234 >file1 &&
> +       F1=$(git rev-parse HEAD:file1) &&
> +       F2=$(git rev-parse HEAD:file2) &&
> +       {
> +               echo "100644 $F1 1      file1" &&
> +               echo "100644 $F2 2      file1"
> +       } | git update-index --index-info &&
> +       test_path_is_file file1 &&
> +       git checkout --theirs --no-overlay -- file1 &&
> +       test_path_is_missing file1
> +'
> +
> +test_done
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 175f83d704..a3fd9a9630 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1436,6 +1436,7 @@ test_expect_success 'double dash "git checkout"' '
>         --progress Z
>         --no-quiet Z
>         --no-... Z
> +       --overlay Z
>         EOF
>  '
>
> --
> 2.20.0.405.gbc1bbc6f85
>
