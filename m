Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690B8C55178
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 19:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC6520E65
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 19:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAn0x8Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbgJWTDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 15:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbgJWTDF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 15:03:05 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED94C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 12:03:05 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 16so2942102oix.9
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJR6hJlt0/TeKxhvrHgyFoSCm1qL8COurc3y0/cCO0Q=;
        b=bAn0x8HxHYf6LyEnfxJfb3TBk9x1HzFfXh4jhn/XZHfloGzKMhJABUUjg5wxfNkEbF
         SiPl8l1rupwTYN8kVV1G3iqrsPLKsKC2XqWbJlxCv0DuKPP/qy9QET6+ynHnQOmr2yQ3
         wC9pRwpaLAJGTUc7vArXvUGlhRbZ8h8Jhcs8b4u93U5BAcqaCtrsD+CkWL9FZYv4LRIe
         10ylJUxrqlM/MeY9mjEEwIMFk1XK//TsTVP5HZOb01N2jvAZa1XTbFhDShluyYDSZOoU
         eOibGUSanJMG1C0sRXaXDlEMZM/eqKuooqE9/Png/YEx9OBM+J7BIugVB8WP85wmp7I4
         bn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJR6hJlt0/TeKxhvrHgyFoSCm1qL8COurc3y0/cCO0Q=;
        b=JAcR7TkdCJsLLlPb5jl53eMw93j6F+b8atR1wLQuyn+gT9hbAcVopVXaEqEDqm4J2O
         /BSraroPSCXMThB4tVDxYeENCc0VrG1BgREuaCczCsMntiwnt8K8ceF+ak6i6wAbTRun
         8TXaKJVu4vJXejTTat2PnejDQQTuaX8IeEGXeB1eCuuV4Ab5riYXEI1OlefP0pxf0LAT
         DgZTyycJbGjGVwDg1hESuAaPyU+dKSUJV+7NfWhl25MZpS7MYISXg3Y0gmlqQn3tAnJI
         z+hSxnhkImYIVIJg9F//Mg/wSO++8zD8OaknGUC8heGdCP8yLvL2FQ/U+nATpq3wkSZ1
         QiuA==
X-Gm-Message-State: AOAM533PNLouEDwbJHmEGQtWBnrrZMPXKL9ac+lND5z0eM+oUprdMm+s
        eDw/b/Dd3Ie0klXPVsaWhqQD1mYXXVJPsXdIL3g=
X-Google-Smtp-Source: ABdhPJwpLfc33f4QPhHpI2yYWU17T5gTo6Y+BANnowk9hIC0ppa47wmSt3WxpCRq69+MQlLDreGNNMp9GCd7t2nMBEY=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr2694245oic.31.1603479784410;
 Fri, 23 Oct 2020 12:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
 <54ef18182cf3a4b5d02889c139e495fa68588652.1603286555.git.gitgitgadget@gmail.com>
 <X5MdD5Ft/DNbCfQv@nand.local>
In-Reply-To: <X5MdD5Ft/DNbCfQv@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Oct 2020 12:02:52 -0700
Message-ID: <CABPp-BFWzE=4pD6+NZknGTNgvav5yR7hTXx4ZN19EWCKTckK6g@mail.gmail.com>
Subject: Re: [PATCH 1/4] merge-ort: barebones API of new merge strategy with
 empty implementation
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 23, 2020 at 11:12 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Wed, Oct 21, 2020 at 01:22:32PM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > This is the beginning of a new merge strategy.  While there are some API
> > differences, and the implementation has some differences in behavior, it
> > is essentially meant as an eventual drop-in replacement for
> > merge-recursive.c.  However, it is being built to exist side-by-side
> > with merge-recursive so that we have plenty of time to find out how
> > those differences pan out in the real world while people can still fall
> > back to merge-recursive.  (Also, I intend to avoid modifying
> > merge-recursive during this process, to keep it stable.)
> >
> > The primary difference noticable here is that the updating of the
> > working tree and index is not done simultaneously with the merge
> > algorithm, but is a separate post-processing step.  The new API is
> > designed so that one can do repeated merges (e.g. during a rebase or
> > cherry-pick) and only update the index and working tree one time at the
> > end instead of updating it with every intermediate result.  Also, one
> > can perform a merge between two branches, neither of which match the
> > index or the working tree, without clobbering the index or working tree.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Makefile    |  1 +
> >  merge-ort.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  merge-ort.h | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 102 insertions(+)
> >  create mode 100644 merge-ort.c
> >  create mode 100644 merge-ort.h
> >
> > diff --git a/Makefile b/Makefile
> > index 95571ee3fc..088770c2ae 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -921,6 +921,7 @@ LIB_OBJS += mailmap.o
> >  LIB_OBJS += match-trees.o
> >  LIB_OBJS += mem-pool.o
> >  LIB_OBJS += merge-blobs.o
> > +LIB_OBJS += merge-ort.o
> >  LIB_OBJS += merge-recursive.o
> >  LIB_OBJS += merge.o
> >  LIB_OBJS += mergesort.o
> > diff --git a/merge-ort.c b/merge-ort.c
> > new file mode 100644
> > index 0000000000..5230364a8d
> > --- /dev/null
> > +++ b/merge-ort.c
> > @@ -0,0 +1,52 @@
> > +/*
> > + * "Ostensibly Recursive's Twin" merge strategy, or "ort" for short.  Meant
> > + * as a drop-in replacement for the "recursive" merge strategy, allowing one
> > + * to replace
> > + *
> > + *   git merge [-s recursive]
> > + *
> > + * with
> > + *
> > + *   git merge -s ort
> > + *
> > + * Note: git's parser allows the space between '-s' and its argument to be
> > + * missing.  (Should I have backronymed "ham", "alsa", "kip", "nap, "alvo",
> > + * "cale", "peedy", or "ins" instead of "ort"?)
> > + */
>
> One thing that might be good here (and I realize that you sort of get to
> it in your next patch) is some example usage. Maybe it's good enough to

The remainder of this series, all 3 patches, are solely about this.  I
think smashing all four patches into one would just make it too large,
and obscure the different types of usage.

> say "see the $FILE_MODIFIED_BY_NEXT_PATCH for example usage", but it may
> be good to be a little bit clearer here.

I could do that, however.  (Though it'd be THE_NEXT_THREE_PATCHES,
rather than just FILE_MODIFIED_BY_NEXT_PATCH)

> Perhaps it may even be appropriate to add a
> Documentation/technical/api-merge-ort.txt or something (if you haven't
> already in one of your other branches...).

I don't have such a thing.  Since there are basically just two
functions that callers would be calling (one of either the recursive
or nonrecursive variants, plus one of either merge_finalize() or
merge_switch_to_result()), it didn't occur to me to write anything
like that up.  I had thought about documenting the implementation
strategy and performance strategies and whatnot, but haven't yet done
that either (other than my talk at Git Merge 2020, of course).  If the
API usage is confusing, I can add that, though if calling two
functions is confusing, there might be something wrong with the two
functions.

> > +
> > +#include "cache.h"
> > +#include "merge-ort.h"
> > +
> > +void merge_switch_to_result(struct merge_options *opt,
> > +                         struct tree *head,
> > +                         struct merge_result *result,
> > +                         int update_worktree_and_index,
> > +                         int display_update_msgs)
> > +{
> > +     die("Not yet implemented");
> > +     merge_finalize(opt, result);
> > +}
> > +
> > +void merge_finalize(struct merge_options *opt,
> > +                 struct merge_result *result)
> > +{
> > +     die("Not yet implemented");
> > +}
> > +
> > +void merge_inmemory_nonrecursive(struct merge_options *opt,
> > +                              struct tree *merge_base,
> > +                              struct tree *side1,
> > +                              struct tree *side2,
> > +                              struct merge_result *result)
> > +{
> > +     die("Not yet implemented");
> > +}
> > +
> > +void merge_inmemory_recursive(struct merge_options *opt,
> > +                           struct commit_list *merge_bases,
> > +                           struct commit *side1,
> > +                           struct commit *side2,
> > +                           struct merge_result *result)
> > +{
> > +     die("Not yet implemented");
> > +}
> > diff --git a/merge-ort.h b/merge-ort.h
> > new file mode 100644
> > index 0000000000..9c655cd3ad
> > --- /dev/null
> > +++ b/merge-ort.h
> > @@ -0,0 +1,49 @@
> > +#ifndef MERGE_ORT_H
> > +#define MERGE_ORT_H
> > +
> > +#include "merge-recursive.h"
> > +
> > +struct commit;
> > +struct tree;
> > +
> > +struct merge_result {
> > +     /* whether the merge is clean */
> > +     int clean;
> > +
> > +     /* Result of merge.  If !clean, represents what would go in worktree */
> > +     struct tree *tree;
> > +
> > +     /*
> > +      * Additional metadata used by merge_switch_to_result() or future calls
> > +      * to merge_inmemory_*().
> > +      */
> > +     unsigned _;
>
> I was a little surprised that '_' is allowed, since I can't think of any
> other variable that is called that (and a search with "git grep ' _;' --
> **/*.h" confirms that this is the only one. It does compile with
> DEVELOPER=1, so...
>
> Is this meant to be a flags-like? I believe you that it's necessary, but
> I wonder if it could be named more clearly, even though it's private.

Yeah, this one is a little weird.  It technically could be dropped,
but is there solely to help catch API mis-use; most of the API is
relatively obvious but there's one gotcha...

The merge_inmemory_*recursive() functions accept both a struct
merge_options and a struct merge_result.  merge_result is _mostly_ an
output so people might omit zeroing it out beforehand, but the
merge_result can be re-used between multiple calls when cherry-picking
or rebasing a sequence of commits.  When it is re-used in such a
manner, it enables some performance optimizations (information
computed in a picking a previous commit need not be recomputed).
However, that raises a sticky question: how can you tell the
difference between result->priv being reused, vs. being nonzero just
because it's uninitialized garbage?  If it's the latter, looking into
result->priv might give you a segfault or at least nonsensical results
that take a while to debug.  The simple way I avoided this problem for
callers is that I expect result->_ to either be 0 or have a special
value, and if it doesn't have one of those two values, then I BUG().
At the end of a merge, I set result->_ to that special value.  The
special value is not exported and is only known within merge-ort.c.

You could get away without this _ member and just let valgrind or
segfaults catch the accidental use of uninitialized values, but since
result looks and feels like an output-only variable it was something
that was easy to misuse and I wanted an extra helping guardrail to
make that kind of debugging loop be shorter.

I guess if I were to rename it, I would call it 'initialized' or
"carry_over" or something.  It's really just a boolean variable rather
than a set of flags, but an actual boolean bit that is uninitialized
provides ~0% confidence in knowing whether the struct really is
initialized or not, while an unsigned has enough bits of safety that
an uninitialized value is cosmically unlikely to match my special
'RESULT_INITIALIZED' value.

With this field, the one gotcha is basically trivial to debug; without
it, it takes a bit more effort.  If I were to remove this extra field,
then it'd make more sense to write up more documentation about API
usage.

>
> > +     void *priv;
> > +};
> > +
> > +/* rename-detecting three-way merge, no recursion. */
> > +void merge_inmemory_recursive(struct merge_options *opt,
> > +                           struct commit_list *merge_bases,
> > +                           struct commit *side1,
> > +                           struct commit *side2,
> > +                           struct merge_result *result);
> > +
> > +/* rename-detecting three-way merge with recursive ancestor consolidation. */
> > +void merge_inmemory_nonrecursive(struct merge_options *opt,
> > +                              struct tree *merge_base,
> > +                              struct tree *side1,
> > +                              struct tree *side2,
> > +                              struct merge_result *result);
>
> Good. This API looks sane to me, and contains nothing more nor less than
> I'd expect. I appreciate that the _recursive declaration is separate
> from the _nonrecursive one (and not hidden behind a flag that switches
> between the two).
>
> > +/* Update the working tree and index from head to result after inmemory merge */
> > +void merge_switch_to_result(struct merge_options *opt,
> > +                         struct tree *head,
> > +                         struct merge_result *result,
> > +                         int update_worktree_and_index,
> > +                         int display_update_msgs);
>
> Seems like these last two could probably be made into an enum and passed
> as flags instead of adding more parameters on the end.

Yes, it'd make the API slightly less self-documenting, but would be
more flexible for adding additional flags in the future.  I had
thought about that earlier, but I really just don't see what other
flags could possibly be added.  Maybe when I resume working on
evil-(merge/revert/cherry-pick) detection I'll have a better feel for
that, but I had just leaned towards leaving it as these two flags for
now.

> > +/* Do needed cleanup when not calling merge_switch_to_result() */
> > +void merge_finalize(struct merge_options *opt,
> > +                 struct merge_result *result);
> > +
> > +#endif
> > --
> > gitgitgadget
