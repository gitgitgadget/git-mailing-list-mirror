Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F5BFA3741
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiKABJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiKABJN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:09:13 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782A4218D
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:09:12 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id be13so21752609lfb.4
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PYltD/2SgJl66aoULj71LYo57hKlAzl49e/vWleDvAc=;
        b=k60QICwlzYTS0hkbYqt9gDJ1KhRxn9WsU11v124YpRTf1fXKlmS3ZJN/I1T3Dv9prh
         etPTWr2NxPCmIONsDmlbmQp6pYEGUHa/UVl9ayiGoUrmAX1VlUlt9P+ZsiBDo8pdPBYW
         W+M07r5Qf9TqTRxVtxaYOptsaqV5sfVzIwLFJqhYeTu+7tyPwUCHThU7YEcFhpEXca1D
         PWA8QSDutesmBpF5Zh7grviVFjREHkkaKvazRbON6vOilmQG8ZgkiFAC3Im5AvmHfwx0
         xnRGB2+Qego90sNnZ3I7eF11ToBMCSENsqgHTlzpTSMVmoq/BFLK5BYZhfEROIgMm2IT
         HTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYltD/2SgJl66aoULj71LYo57hKlAzl49e/vWleDvAc=;
        b=WXlC7aCqcgeJeHwOVXK6dXPMF9KrSAbgb72WJ0a/UbYYIvAHthr39SQK9thEXe4R+h
         1na4T4i/vjBHptZcoO+DlKdUxH6IEezd/uWseEnBxxwUcCm3s9glEKJB27swei6kLONX
         2/oGmy+MK7RpKWfTZQsjf8T8QG+G5g4Wnb2gX4cQOLOH1800fX7MNRqJ6lX5UGM0VNvE
         sdHmiSRpbc8BSRNmVhL6Kf4/SAEGyoqZHaFsF1dX+IdQKfDxLndzrd54LlAFJCkR1RQS
         c0bt7fwqNKTDECNu7ndQQMF0WjR2Q+R0DG30pdl+UhdvXT27FRKjdFsln+mXVZ6BZS4p
         L3Jw==
X-Gm-Message-State: ACrzQf0pxSHM4nxP4AhJwHjjTbAMeTbiFLiy0mny6d1LlCr29NIKCsme
        xq0P/7ry5FIn3/XPoyqaKKgHUmIg0KOJCl9ZyrY=
X-Google-Smtp-Source: AMsMyM7vBjoBiJ6UwGpNGR097z5n8kzOXKkiNJcO847l2l4CcLlxMh9+8nZfqc7N3pWBeJVePrWXxcZjsvV8cOBsz7A=
X-Received: by 2002:a05:6512:304e:b0:4a2:6c66:8355 with SMTP id
 b14-20020a056512304e00b004a26c668355mr7245535lfb.238.1667264950623; Mon, 31
 Oct 2022 18:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1397.v2.git.1666958144017.gitgitgadget@gmail.com> <pull.1397.v3.git.1667014975042.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v3.git.1667014975042.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 31 Oct 2022 18:08:00 -0700
Message-ID: <CABPp-BF1kjWMS7Te31FqGrHMNOQEGhG=e1g9ah29ZHWGYufbXA@mail.gmail.com>
Subject: Re: [PATCH v3] merge-tree.c: add --merge-base=<commit> option
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kyle Zhao <kylezhao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Oct 28, 2022 at 8:42 PM Kyle Zhao via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kyle Zhao <kylezhao@tencent.com>
>
> This patch will give our callers more flexibility to use `git merge-tree`,
> such as:
>
>     git merge-tree --write-tree --merge-base=branch^ HEAD branch
>
> This does a merge of HEAD and branch, but uses branch^ as the merge-base.
>
> And the reason why using an option flag instead of a positional argument
> is to allow additional commits passed to merge-tree to be handled via an
> octopus merge in the future.
>
> Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
> ---
>     merge-tree: allow specifying a base commit when --write-tree is passed
>
>     Thanks for Elijah's work. I'm very excited that merge-ort is integrated
>     into the git merge-tree, which means that we can use merge-ort in bare
>     repositories to optimize merge performance.
>
>     In this patch, I introduce a new --merge-base=<commit> option to allow
>     callers to specify a merge-base for the merge. This may allow users to
>     implement git cherry-pick and git rebase in bare repositories with git
>     merge-tree cmd.
>
>     Changes since v1:
>
>      * Changed merge_incore_recursive() to merge_incore_nonrecursive() when
>        merge-base is specified.
>      * Fixed c style problem.
>      * Moved commit lookup/die logic out to the parsing logic in
>        cmd_merge_tree().
>      * use test_commit for test
>
>     Changes since v2:
>
>      * commit message
>      * Rebased on top of en/merge-tree-sequence.
>      * Set opt.ancestor to o->merge_base. Because opt.ancestor is a *char.
>        To make it easier to pass parameters, I moved
>        lookup_commit_reference_by_name() to real_ merge() again.
>      * Added test comment.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1397%2Fkeyu98%2Fkz%2Fmerge-tree-option-merge-base-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1397/keyu98/kz/merge-tree-option-merge-base-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1397
>
[...]
>  Documentation/git-merge-tree.txt |  4 ++++
>  builtin/merge-tree.c             | 39 ++++++++++++++++++++++++--------
>  t/t4301-merge-tree-write-tree.sh | 30 ++++++++++++++++++++++++
>  3 files changed, 64 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> index 04bcc416e6e..d9dacb2ce54 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -64,6 +64,10 @@ OPTIONS
>         share no common history.  This flag can be given to override that
>         check and make the merge proceed anyway.
>
> +--merge-base=<commit>::
> +       Instead of finding the merge-bases for <branch1> and <branch2>,
> +       specify a merge-base for the merge.
> +
>  [[OUTPUT]]
>  OUTPUT
>  ------
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index fe853aa8f91..cd25aac6ba6 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -3,6 +3,7 @@
>  #include "tree-walk.h"
>  #include "xdiff-interface.h"
>  #include "help.h"
> +#include "commit.h"
>  #include "commit-reach.h"
>  #include "merge-ort.h"
>  #include "object-store.h"
> @@ -403,6 +404,7 @@ struct merge_tree_options {
>         int show_messages;
>         int name_only;
>         int use_stdin;
> +       const char *merge_base;
>  };
>
>  static int real_merge(struct merge_tree_options *o,
> @@ -432,16 +434,31 @@ static int real_merge(struct merge_tree_options *o,
>         opt.branch1 = branch1;
>         opt.branch2 = branch2;
>
> -       /*
> -        * Get the merge bases, in reverse order; see comment above
> -        * merge_incore_recursive in merge-ort.h
> -        */
> -       merge_bases = get_merge_bases(parent1, parent2);
> -       if (!merge_bases && !o->allow_unrelated_histories)
> -               die(_("refusing to merge unrelated histories"));
> -       merge_bases = reverse_commit_list(merge_bases);
> +       if (o->merge_base) {
> +               struct commit *base_commit;
> +               struct tree *base_tree, *parent1_tree, *parent2_tree;
> +
> +               base_commit = lookup_commit_reference_by_name(o->merge_base);
> +               if (!base_commit)
> +                       die(_("could not lookup commit %s"), o->merge_base);
> +
> +               opt.ancestor = o->merge_base;
> +               base_tree = get_commit_tree(base_commit);
> +               parent1_tree = get_commit_tree(parent1);
> +               parent2_tree = get_commit_tree(parent2);
> +               merge_incore_nonrecursive(&opt, base_tree, parent1_tree, parent2_tree, &result);
> +       } else {
> +               /*
> +                * Get the merge bases, in reverse order; see comment above
> +                * merge_incore_recursive in merge-ort.h
> +                */
> +               merge_bases = get_merge_bases(parent1, parent2);
> +               if (!merge_bases && !o->allow_unrelated_histories)
> +                       die(_("refusing to merge unrelated histories"));
> +               merge_bases = reverse_commit_list(merge_bases);
> +               merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> +       }
>
> -       merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
>         if (result.clean < 0)
>                 die(_("failure to merge"));
>
> @@ -515,6 +532,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>                            &o.use_stdin,
>                            N_("perform multiple merges, one per line of input"),
>                            PARSE_OPT_NONEG),
> +               OPT_STRING(0, "merge-base",
> +                          &o.merge_base,
> +                          N_("commit"),
> +                          N_("specify a merge-base for the merge")),
>                 OPT_END()
>         };
>
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
> index cac85591b52..5b0073d3dcd 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -860,4 +860,34 @@ test_expect_success '--stdin with both a successful and a conflicted merge' '
>         test_cmp expect actual
>  '
>
> +# specify merge-base as parent of branch2
> +# git merge-tree --write-tree --merge-base=c2 c1 c3
> +#   Commit c1: add file1
> +#   Commit c2: add file2 after c1
> +#   Commit c3: add file3 after c2
> +#   Expected: add file3, and file2 does NOT appear
> +
> +test_expect_success 'specify merge-base as parent of branch2' '
> +       # Setup
> +       git init base-b2-p && (
> +               cd base-b2-p &&
> +               test_commit c1 file1 &&
> +               test_commit c2 file2 &&
> +               test_commit c3 file3
> +       ) &&
> +       # Testing
> +       (
> +               cd base-b2-p &&
> +               TREE_OID=$(git merge-tree --write-tree --merge-base=c2 c1 c3) &&
> +
> +               q_to_tab <<-EOF >expect &&
> +               100644 blob $(git rev-parse c1:file1)Qfile1
> +               100644 blob $(git rev-parse c3:file3)Qfile3
> +               EOF
> +
> +               git ls-tree $TREE_OID >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
>  test_done
>
> base-commit: ec1edbcb56ac05e9980299b05924c5c1b51d68b4

This looks pretty good; thanks for the many changes.  One thing is
still missing: you are now building on a commit that adds a --stdin
option to merge-tree, which allows the user to specify what to merge
on stdin rather than via other arguments on the command line.  Since
you're making merge-tree support specified merge base(s), it should
also support that in conjunction with --stdin.  So, see the "/* Handle
stdin */" block and adjust it appropriately.

Once you do that, I think your series will be good to go.
