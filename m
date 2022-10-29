Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C922CC38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 01:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ2Bc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 21:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2Bc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 21:32:27 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900F8224AA5
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 18:32:26 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r12so10963406lfp.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 18:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xOsP2/klrH1wlzdg7B8eGmxz3HUW1iCEE8MJOme0tNQ=;
        b=lbfUeDs3AGkgtqy+VNKf1OZdfQeSH237CkoNHhVsYEAPyyXMXrBpPdsIu2L02fr98I
         qFJyZ/cO/vQaUiB/DlTrQ47yM6OUFrRN+HV6IODLFxSal9OXH0iNWrD4/B5YXW/LJY9U
         1qkQI38D0m2pV+ckt9kzS2SuS1rjYwu3amSRXVWSjlnGRbji4Qj4GuXTIN3ukvVN16yC
         H9GQYZCFvk1s7LLUQfpnHR+7kA4753hWVpM9v6pmXrcg5MWBv2hejfICflar7aGYLSOB
         5JNmUXx+NEwEyAjkQUf5ypHtFcetbNCy73T3UKFMD9iV8YfaHrfCmYTAo2zun0Xp2OsF
         KINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOsP2/klrH1wlzdg7B8eGmxz3HUW1iCEE8MJOme0tNQ=;
        b=Gf9baTJU8+R077HPzDIdCPJumlIHQqeIsEpVmS4ON2XL8mjWlM8hMaJZVzHZKF10it
         WwqpFcMkGBCUHcSDL3BwCBLh2IT7GWJoPPjThzZQjFONoE1Bc1usLsTvlfnAbCFfYDkR
         uhBHwxTbttCdL+C5yrC+9KpvjzBhRUNmyHVlCaujkEyMlCK8mik8Z42iCgoa9VyfV57G
         p95fQD94aoZWP08Tvb73BcrDjjaeT7Rjxk+ihwcfjHyesLPbUpS8EIaJjgoMQKmZlvAD
         jpvVW6mRq2Dmfqf/VZpXbuvT3G0TxPtFy4b4tJig9HTFC5q4gBe5XwbPk93JTnMPuDrC
         iPNA==
X-Gm-Message-State: ACrzQf2bX0HeoIoQ3cK7D3FzLJwlwLQqtnaPRzeAgYlujqRoMpMkg3Md
        N7JqhFhmTC4HJX8xqQSBKYpTVcznoc/+9cpCPzP5+9iD
X-Google-Smtp-Source: AMsMyM7HC6RQioDP0dX0i3ARddPZs1vEKx+Xt4asa9W2UIcZHFu8bvCQ6LBy3ALeYriVs+67cNrdFCuUhLkPXD8Tykc=
X-Received: by 2002:a05:6512:22d3:b0:4a2:3f7e:95fb with SMTP id
 g19-20020a05651222d300b004a23f7e95fbmr826616lfu.32.1667007144634; Fri, 28 Oct
 2022 18:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1397.git.1666872761355.gitgitgadget@gmail.com> <pull.1397.v2.git.1666958144017.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v2.git.1666958144017.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Oct 2022 18:32:11 -0700
Message-ID: <CABPp-BHiqW2zgt4UfnH5iJbOf6RzPnnw+=bzvRYdrLQs08hU5g@mail.gmail.com>
Subject: Re: [PATCH v2] merge-tree.c: add --merge-base=<commit> option
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kyle Zhao <kylezhao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Oct 28, 2022 at 4:55 AM Kyle Zhao via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kyle Zhao <kylezhao@tencent.com>
>
> This patch will give our callers more flexibility to use `git merge-tree`,
> such as:
>
>     git merge-tree --write-tree --merge-base=branch^ HEAD branch
>
> It would cherry-pick the commit at the tip of the branch on top of the
> current commit even if the repository is bare.

Perhaps just "This does a merge of HEAD and branch, but uses branch^
as the merge-base."

Also, given that both Junio and I thought a positional argument might
be better, it might be worth calling out that the reason for using an
option flag instead of a positional argument is to allow additional
commits passed to merge-tree to be handled via an octopus merge in the
future.

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
>      * Changed merge_incore_nonrecursive() to merge_incore_recursive() when
>        merge-base is specified.

I think you mean the other way around (using
merge_incore_nonrecursive() instead of merge_incore_recursive() when
merge-base is specified).

> +       if (o->base_commit) {
> +               struct tree *base_tree, *parent1_tree, *parent2_tree;
> +
> +               opt.ancestor = "specified merge base";

It is a specified merge base, but that won't help the user much when
they get conflict markers if they attempt to investigate them.  Since
the specified merge base is a commit the user will know, and in fact
one they named on the command line, we should use that name.  So, I'd
expect this to be set to o->merge_base.

> @@ -544,8 +561,14 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>                 usage_with_options(merge_tree_usage, mt_options);
>
>         /* Do the relevant type of merge */
> -       if (o.mode == MODE_REAL)
> +       if (o.mode == MODE_REAL) {
> +               if (merge_base) {
> +                       o.base_commit = lookup_commit_reference_by_name(merge_base);
> +                       if (!o.base_commit)
> +                               die(_("could not lookup commit %s"), merge_base);
> +               }

Personally, I think of the code before "/* Do the relevant type of
merge */" as a continuation of option parsing (i.e. sanity checking
arguments and determining defaults and whatnot), and I think the last
five lines above are more option parsing.  From that angle, I think
it'd make sense to move these lines out above this block (before or
after determining o.mode).

But this may well just be personal preference; what you have certainly works.

>                 return real_merge(&o, argv[0], argv[1], prefix);
> +       }
>         else
>                 return trivial_merge(argv[0], argv[1], argv[2]);
>  }
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
> index 013b77144bd..64bfe6f4a41 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -819,4 +819,27 @@ test_expect_success SANITY 'merge-ort fails gracefully in a read-only repository
>         test_must_fail git -C read-only merge-tree side1 side2
>  '
>
> +test_expect_success 'specify merge-base as parent of branch2' '
> +       # Setup
> +       git init base-b2-p && (
> +               cd base-b2-p &&
> +               test_commit c1 file1 &&
> +               test_commit c2 file2 &&
> +               test_commit c3 file3

Much simpler.  :-)

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

In particular, you are testing here that file2 does NOT appear despite
the fact that it was part of c3.  That makes sense, but I'm not sure
casual readers of this code would catch that.  It might be worth
adding a comment to make it easier to follow for future test readers.

> +       )
> +'
> +
>  test_done
>
> base-commit: 5af5e54106e20f65c913550c80aec3186b859e9b

This should be rebased on top of en/merge-tree-sequence.  Then, you
need to either figure out how to modify the new --stdin flag to also
accept a specified merge base in a way that permits future handling of
octopus merges (it looks like Junio might have a good suggestion
elsewhere in this thread), or else explicitly call out in the commit
message why specified merge base support is only being added when
--stdin is not specified.
