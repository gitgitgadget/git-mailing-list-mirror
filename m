Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828ACFA3748
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 08:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJ1IOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 04:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJ1IOB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 04:14:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA71E1C2F2B
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 01:13:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u11so7413248ljk.6
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9K7/DxqROG9P+U8IfG5Qdx0wXv3qeH5D9L3edvHZog=;
        b=Esb1RQu30z1ggVfsucAlEsRWxTYlumdstQp+LAX54UPZK+mJk+IqYO1oDnH7G/MqLe
         LXWHueqN5JA1HsFqnWM6XTGn4CPCh0Z4VlOZw2iAVdu45ZsZ2oTNUK3Use/aXOY4ql+Y
         JG5Q0bXpCMNwn8pxQQVtZ2GZPoKxaw0cTrTeUTI4o88HZwquSjAlhrWdUhWXKWTMdYmH
         sU96wMSGzA6RQWombq5dgIpTMugfUYU+9tLcsL1bsaJGude9wT+j289lXA96Y1XQvf+u
         UOk5VIRWwBd3vDw7DpSZo++NisaMw0cAgzcaWAnOQxiDE3O7Y6Nam71a2CfCIIZADk/s
         klFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9K7/DxqROG9P+U8IfG5Qdx0wXv3qeH5D9L3edvHZog=;
        b=aU+BZj9wmLsfTIDOjP+G8pnPriMJpswUaGs1PYUWkBNvS+XzWdfT3y2tLtHMAoA9Rd
         CziKKAQ+LWQOgJWkPeQtnmJB9ht+pgpIvJtudfFrIGC9IzERc2r+epJBYTcf6xhiUQbt
         DtGC9T5vBgSRgPDnxafvAlHQi+eJoTb1wAw3ji+AN7v+y8EQznwmDVwV4NwBAQZH2jHc
         qi1Wvq55oodTrAStSHvMB4vxUgc+olbIr9tq2EbqAPQ/SyFasmZI81NGLYn5dGS1nnNU
         GejBtFvkpFheUGKIrI/GNnAF/pqpH6FYrqH2m70bUihuc6Jh5bWYYelH2SoeLs4QI8GK
         fV9A==
X-Gm-Message-State: ACrzQf1sXjyOZOwOZO4cgRcPnnti3Tc0EfDg36AqBw2RBWcd6EQ3CPbR
        QPkcvZGUI/MV1BQErqygrFy4rR4I6GLXeWZBls4=
X-Google-Smtp-Source: AMsMyM6+rTr6c0GRx7N2CXfxq6TAK/zwUURtOjkRGNfZL30OusD8Qjq+M9c8O5/X8A6g3Y9zlHx7bIWERJ0H9V7Glak=
X-Received: by 2002:a2e:834b:0:b0:26d:ffb1:dae7 with SMTP id
 l11-20020a2e834b000000b0026dffb1dae7mr20310629ljh.128.1666944837867; Fri, 28
 Oct 2022 01:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1397.git.1666872761355.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.git.1666872761355.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Oct 2022 01:13:45 -0700
Message-ID: <CABPp-BGBFyoY7m+KCA9MTifKmpZ0ccLgsYHahMCgPxuTpuUGPg@mail.gmail.com>
Subject: Re: [PATCH] merge-tree.c: add --merge-base=<commit> option
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kyle Zhao <kylezhao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kyle!

Thanks for the interest in this area of the code.  There's lots of
interesting history you're probably not aware of here...

On Thu, Oct 27, 2022 at 5:12 AM Kyle Zhao via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kyle Zhao <kylezhao@tencent.com>
>
> This option allows users to specify a merge-base commit for the merge.

Note that this has been implemented previously.  I may have
implemented it previously and ripped it out (about a year ago), or
maybe I just avoided it once I ran across the reasons below.  Dscho
also implemented it over at
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2202210956430.26495@tvgsbejvaqbjf.bet/

You may want to take a look at his code for comparison, especially the
merge_incore_nonrecursive() stuff.

> It will give our callers more flexibility to use the `git merge-tree`.
> For example:
>
>     git merge-tree --merge-base=<sha1>^1 source-branch <sha1>
>
> This allows us to implement `git cherry-pick` in bare repositories.

This capability is something we may ultimately want for completeness,
but it definitely should not be marketed as a building block for
implementing cherry-pick or rebase.  There are several reasons for
that:

Performance reasons:
  * it's a design with a separate fork for every commit to be picked,
which is quite wasteful.  cherry-pick and rebase should do better.
  * it is explicitly single-commit replaying, which discards the
remembering renames optimization I placed into merge-ort.  We should
have something series-aware so it can take advantage of that.

Usability/Design reasons:
  * with cherry-picking or rebasing you often have a sequence of
commits.  Picking them one at a time not only has the performance
issues above, but also introduces usability and design questions
around the creation of commits from the toplevel trees created by
merge-tree.  For normal merges, we have no idea what the commit
message should be without explicit directives and user editing; this
is reflected in the fact that `git merge` has 9 different flags for
controlling how to specify the commit message or components of it or
how to tweak it or whatever.  I really don't want to copy all of that
logic from git-merge into git-merge-tree, and merge-tree is therefore
just a dry-run merge.  However, in the case of cherry-picking or
rebasing, we *do* have a commit message (and author) that we can just
re-use.  But if we make merge-tree handle the commit message and
create commits, you are fundamentally changing the output style of
merge-tree that we have carefully documented (and promised backward
compatibility on).  Figuring out how to extend the output and when
(and do we also allow that for non-specified merge bases) probably
requires some careful thought.
  * a cherry-pick or rebase tool actually might want to do something
clever with sequences of replayed commits.  For example, if later
commits in the series have commit messages that refer to earlier
commits in the series by their (abbreviated) commit hash, it would be
nice to update those (abbreviated) commit hashes to instead refer to
the replayed version of the earlier commit.  But that fundamentally
requires operating on a series rather than an individual commit.

Correctness/capability reason:
  * this patch is fundamentally limited to replaying regular commits.
Replaying merge-commits correctly doesn't fit within this design; it
needs a different framework.

Maintenance reason:
  * suggesting this code as a basis for cherry-pick or rebase is
likely to lead to yet another shell-scripted rebase; we've been trying
to generally nuke shell scripts from Git for a variety of reasons.
It'd be sad to regress here.

> Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
> ---
>     merge-tree.c: add --merge-base= option
>
>     Thanks for Elijah's work. I'm very excited that merge-ort is integrated
>     into the git merge-tree, which means that we can use merge-ort in bare
>     repositories to optimize merge performance.
>
>     In this patch, I introduce a new --merge-base=<commit> option to allow
>     callers to specify a merge-base for the merge. This may allow users to
>     implement git cherry-pick and git rebase in bare repositories with git
>     merge-tree cmd.

My apologies for having very limited git time (which is often entirely
used up just in reviewing/responding to patches and other queries on
the list instead of on new features like this, or maybe on making some
nice slides for a conference); if I had more time, I think git-replay
could have easily been done many months ago (or perhaps even last
year).  Then you'd have the high level tool you need for server side
cherry-picking and rebasing.  But, I haven't had much time.  So, it
makes sense that folks might want to use an interim hack while waiting
for the more robust tool to materialize.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1397%2Fkeyu98%2Fkz%2Fmerge-tree-option-merge-base-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1397/keyu98/kz/merge-tree-option-merge-base-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1397
>
>  Documentation/git-merge-tree.txt |  4 +++
>  builtin/merge-tree.c             | 23 +++++++++++++----
>  t/t4301-merge-tree-write-tree.sh | 44 ++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> index d6c356740ef..e762209b76d 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -64,6 +64,10 @@ OPTIONS
>         share no common history.  This flag can be given to override that
>         check and make the merge proceed anyway.
>
> +--merge-base=<commit>::
> +       Instead of finding the merge-bases for <branch1> and <branch2>,
> +       specify a merge-base for the merge.

We could potentially just handle this as an additional positional
argument, which might be more in-keeping with merge-tree style.
However...

* it would force the --write-tree option to be specified when three
commits are listed...at least until we can declare the deprecation
period for --trivial-merge over and nuke that code and flag.
* if we ever want to allow octopus merges, the additional positional
argument does not fly well; the explicit flag for --merge-base might
be necessary.

So, this kind of raises questions on what the deprecation period for
--trivial-merge should be, and whether we ever want to support octopus
merges within git-merge-tree.

>  [[OUTPUT]]
>  OUTPUT

No output changes...makes sense, but kind of reinforces the fact that
this really isn't a basis for cherry-pick or rebase (as noted above).

>  ------
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index ae5782917b9..adc461f00f3 100644
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
> @@ -402,6 +403,7 @@ struct merge_tree_options {
>         int allow_unrelated_histories;
>         int show_messages;
>         int name_only;
> +       char* merge_base;
>  };
>
>  static int real_merge(struct merge_tree_options *o,
> @@ -430,11 +432,18 @@ static int real_merge(struct merge_tree_options *o,
>         opt.branch1 = branch1;
>         opt.branch2 = branch2;
>
> -       /*
> -        * Get the merge bases, in reverse order; see comment above
> -        * merge_incore_recursive in merge-ort.h
> -        */
> -       merge_bases = get_merge_bases(parent1, parent2);
> +       if (o->merge_base) {
> +               struct commit *c = lookup_commit_reference_by_name(o->merge_base);
> +               if (!c)
> +                       die(_("could not lookup commit %s"), o->merge_base);

Would it make sense to have o->merge_base be a struct commit *, and
move this lookup/die logic out to the parsing logic in
cmd_merge_tree()?

Just a thought.

> +               commit_list_insert(c, &merge_bases);
> +       } else {
> +               /*
> +                * Get the merge bases, in reverse order; see comment above
> +                * merge_incore_recursive in merge-ort.h
> +                */
> +               merge_bases = get_merge_bases(parent1, parent2);
> +       }
>         if (!merge_bases && !o->allow_unrelated_histories)
>                 die(_("refusing to merge unrelated histories"));
>         merge_bases = reverse_commit_list(merge_bases);

and the next line of code, not showing in the context here, is a call
to merge_incore_recursive().  While that technically works, it doesn't
make logical sense.  You're not doing a recursive merge when you have
a specified merge base, so I think the code should instead call
merge_incore_nonrecursive() in such a case (see Dscho's code for a
comparison here).

> @@ -505,6 +514,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>                            &o.allow_unrelated_histories,
>                            N_("allow merging unrelated histories"),
>                            PARSE_OPT_NONEG),
> +               OPT_STRING(0, "merge-base",
> +                        &o.merge_base,
> +                        N_("commit"),
> +                        N_("specify a merge-base commit for the merge")),
>                 OPT_END()
>         };
>
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
> index 013b77144bd..032ff4a1c3d 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -819,4 +819,48 @@ test_expect_success SANITY 'merge-ort fails gracefully in a read-only repository
>         test_must_fail git -C read-only merge-tree side1 side2
>  '
>
> +# specify merge-base as parent of branch2.
> +# git merge-tree --merge-base=A O B
> +#   Commit O: foo, bar
> +#   Commit A: modify foo after Commit O
> +#   Commit B: modify bar after Commit A
> +#   Expected: foo is unchanged, modify bar

So, the O-A-B thing thing was taken from t6423; it appears I didn't
copy the comment at the top of t6423 over to t4301 to explain this.
Sorry about that.  Anyway, for these types of comments in these files,
O is always the merge base of both A and B, and neither A nor B
contain each other in their history.  From that basis, your
description here makes no sense (A would be the tip of some branch,
not the parent of anything).  I'd call your commits something else
(maybe just C1, C2, and C3 or something?).

> +
> +test_expect_success 'specify merge-base as parent of branch2' '
> +       # Setup
> +       git init base-b2-p && (
> +               cd base-b2-p &&
> +               echo foo >foo &&
> +               echo bar >bar &&
> +               git add foo bar &&
> +               git commit -m O &&
> +
> +               git branch O &&
> +               git branch A &&
> +
> +               git checkout A &&
> +               echo "A" >foo &&
> +               git add foo &&
> +               git commit -m A &&
> +
> +               git checkout -b B &&
> +               echo "B" >bar &&
> +               git add bar &&
> +               git commit -m B

Would test_commit be useful here, given that you aren't worried about
the exact contents of files?

> +       ) &&
> +       # Testing
> +       (
> +               cd base-b2-p &&
> +               TREE_OID=$(git merge-tree --merge-base=A O B) &&
> +
> +               q_to_tab <<-EOF >expect &&
> +               100644 blob $(git rev-parse B:bar)Qbar
> +               100644 blob $(git rev-parse O:foo)Qfoo
> +               EOF
> +
> +               git ls-tree $TREE_OID >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
>  test_done
>
> base-commit: db29e6bbaed156ae9025ff0474fd788e58230367
> --
> gitgitgadget
