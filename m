Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B23C00140
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 01:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiHSBYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 21:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiHSBYD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 21:24:03 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676F7DEEB
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 18:24:01 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id m17so2432853qvv.7
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 18:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OrZIyL4+gK724FBDVYvVX9D/dTvn4nI319pVh4VoKws=;
        b=o00C7I0oHNSKqH103NXYIiPMqlx8GhMAUo50rDCvHsg+ywHOb0AwfrG8p2gj6O9U/n
         yHMvnYVJqhRWpLNlaesxaOS6p1ZTP0lmg1x8gT9s6mGsYogSZZh61nTPs+NXKjY9XxI4
         FLNyFJ7RoGDw1cJHtYKTa4mOYMbJGVWkmF3IrlLU5p9MiAn9C0y+U+jga02482NCTuEU
         OVoakATS6K89UTbREUPiaUgKxBRj50s0QZzU6FNGUAhOu++Gjrhr5C0/bHHg/a4296eM
         Uu4QGNSW/x9oaCTnotDff6OhEZgoF5DxpSqkOoC82odYei2gv7CK3JcugIarX+NYiZ6y
         QiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OrZIyL4+gK724FBDVYvVX9D/dTvn4nI319pVh4VoKws=;
        b=C/h6Mhvz/GManGtPzqNx4XxS6Jz3B1+EVN9R4/gncDROvltsrT5kLEje1qOEP/epA8
         wDCqT4XahM0elxNCyxA/HuwD1IG+pe2UBlaX6iG47A4KE1SqIeee+QqZv3A1tzoRL/D6
         jwMTCOFupa5bB99iPYbPF2jjrF1cqIpED2ymVaJLhuZBpMOzdK62anAmBAxLixiixfUb
         t58FP8lE2iSJ9EnCjCI4KR5cZ68YqX4lXJPU7b02SAy7ijn5a1wp1GoVAZWJO8ISUSFS
         65ENiHA0a7Cmx1QNXaRVbmbObtdu6IycmSoizvnzw9rlb60D5Yahx7uk57Sjpf9St/ua
         eOLw==
X-Gm-Message-State: ACgBeo3TOmOh0JZ6xzCoppRRc62HuSk93t9OzGJAk559LNgSSgMZ3FZn
        9FI+hGbvBQBtYb92r54bCl5S70e8KwAn93zTLm8=
X-Google-Smtp-Source: AA6agR7suRIN8PgigVugjc/2Ro8JbKgk5+9if44iIRMlS8xuqmdh5Wgpq8Ir5ZM9LbHmxNwTnUoL2qd0NI1WYlOBrHI=
X-Received: by 2002:a0c:da8e:0:b0:476:fa44:ea0f with SMTP id
 z14-20020a0cda8e000000b00476fa44ea0fmr4598872qvj.115.1660872240465; Thu, 18
 Aug 2022 18:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <f580ec6d06072ea6ed2ecc4f8142b94fccbe4c0f.1660803467.git.gitgitgadget@gmail.com>
 <20220818222416.3567602-1-jonathantanmy@google.com>
In-Reply-To: <20220818222416.3567602-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 18 Aug 2022 18:23:00 -0700
Message-ID: <CABPp-BFjxFeGO+NU4HFCGqDe4aRFhqOdOxNYVDf7EJOWdT5RgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] revision: allow --ancestry-path to take an argument
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2022 at 3:24 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Thanks - overall this looks good. I only have some minor textual
> comments and one small code comment.
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > From: Elijah Newren <newren@gmail.com>
> >
> > We have long allowed users to run e.g.
> >     git log --ancestry-path master..seen
> > which shows all commits which satisfy all three of these criteria:
> >   * are an ancestor of seen
> >   * are not an ancestor master
>
> are not an ancestor *of* master

Thanks, good catch.

> > diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> > index 2f85726745a..001e49cee55 100644
> > --- a/Documentation/rev-list-options.txt
> > +++ b/Documentation/rev-list-options.txt
> > @@ -389,12 +389,15 @@ Default mode::
> >       merges from the resulting history, as there are no selected
> >       commits contributing to this merge.
> >
> > ---ancestry-path::
> > +--ancestry-path[=<commit>]::
> >       When given a range of commits to display (e.g. 'commit1..commit2'
> > -     or 'commit2 {caret}commit1'), only display commits that exist
> > -     directly on the ancestry chain between the 'commit1' and
> > -     'commit2', i.e. commits that are both descendants of 'commit1',
> > -     and ancestors of 'commit2'.
> > +     or 'commit2 {caret}commit1'), only display commits in that
> > +     range where <commit> is part of the ancestry chain.  By "part of
> > +     the ancestry chain", we mean including <commit> itself and
> > +     commits that are either ancestors or descendants of <commit>.
> > +     If no commit is specified, use 'commit1' (the excluded part of
> > +     the range) as <commit>.  Can be passed multiple times to look for
> > +     commits in the ancestry range of multiple commits.
>
> "Ancestry chain" seems to be used multiple times in the Git codebase,
> apparently with slightly different definitions, so probably best to
> clear up at least this part by not reusing the term. It's also probably
> not worth introducing a new term "ancestry range". Maybe rewrite to
> say:
>
>   When given a range of commits to display (e.g. 'commit1..commit2'
>   or 'commit2 {caret}commit1'), only display commits in that
>   range that are ancestors of <commit>, descendants of <commit>, or
>   <commit> itself. If no commit is specified, use 'commit1' (the
>   excluded part of the range) as <commit>. Can be passed multiple times;
>   if so, a commit is included if it is any of the commits given or if it
>   is an ancestor or descendant of one of them.

Works for me; thanks.

> > @@ -568,11 +571,10 @@ Note the major differences in `N`, `P`, and `Q` over `--full-history`:
> >
> >  There is another simplification mode available:
> >
> > ---ancestry-path::
> > -     Limit the displayed commits to those directly on the ancestry
> > -     chain between the ``from'' and ``to'' commits in the given commit
> > -     range. I.e. only display commits that are ancestor of the ``to''
> > -     commit and descendants of the ``from'' commit.
> > +--ancestry-path[=<commit>]::
> > +     Limit the displayed commits to those containing <commit> in their
> > +     ancestry path.  I.e. only display <commit> and commits which have
> > +     <commit> as either a direct ancestor or descendant.
>
> Can we refer back to the documentation of --ancestry-path instead?

I had the same thought, especially since the nearby text also
duplicates definitions for --dense, --sparse, --simplify-merges, and
--show-pulls, each of which might also benefit from just referring
back to previous definitions to avoid drift.  I think we should handle
this whole "History Simplification" section consistently, so if we
just refer back to the previous definition somehow for this flag then
we should also do the same for the others.  But some of the others
appear to intentionally avoid using the same wording in order to draw
graphs and pictorially explain it.

So it feels like a can of worms that I'm not sure how to solve, and
what I currently have is the best solution available.

> > @@ -1304,13 +1304,20 @@ static int still_interesting(struct commit_list *src, timestamp_t date, int slop
> >  }
> >
> >  /*
> > - * "rev-list --ancestry-path A..B" computes commits that are ancestors
> > + * "rev-list --ancestry-path=C A..B" computes commits that are ancestors
> >   * of B but not ancestors of A but further limits the result to those
> > - * that are descendants of A.  This takes the list of bottom commits and
> > - * the result of "A..B" without --ancestry-path, and limits the latter
> > - * further to the ones that can reach one of the commits in "bottom".
> > + * that have C in their ancestry path (i.e. are either ancestors of C,
> > + * descendants of C, or are C).  If multiple --ancestry-path=$COMMITTISH
> > + * arguments are supplied, we limit the result to those that have at
> > + * least one of those COMMITTISH in their ancestry path. If
> > + * --ancestry-path is specified with no commit, we use all bottom
> > + * commits for C.
> > + *
> > + * Before this function is called, ancestors of C will have already been
> > + * marked with ANCESTRY_PATH previously, so we just need to also mark
> > + * the descendants here, then collect both sets of commits.
> >   */
> > -static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *list)
> > +static void limit_to_ancestry(struct commit_list *bottoms, struct commit_list *list)
>
> I thought the original description of this function ("This takes the
> list...") to be clear and it would be nice to retain it. So, e.g.:
>
>   "rev-list --ancestry-path=C_0 [--ancestry-path=C_1 ...] A..B" computes commits
>   that are ancestors of B but not ancestors of A but further limits the
>   result to those that have any of C in their ancestry path (i.e. are
>   either ancestors of any of C, descendants of any of C, or are any of
>   C). If --ancestry-path is specified with no commit, we use all bottom
>   commits for C.
>
>   Before this function is called, ancestors of C will have already been
>   marked with ANCESTRY_PATH previously.
>
>   This takes the list of bottom commits and the result of "A..B" without
>   --ancestry-path, and limits the latter further to the ones that have
>   any of C in their ancestry path. Since the ancestors of C have already
>   been marked (a prerequisite of this function), we just need to mark
>   the descendants, then exclude any commit that does not have any of
>   these marks.

Sounds good to me; I'm happy to adopt this wording.

> Optional: Besides that, from what I can tell, sometimes the C commits
> themselves are marked with ANCESTRY_PATH (when they are explicitly
> specified) and sometimes they are not (when they are not explicitly
> specified). It's not a bug here, but it might be worth handling that in
> the ancestry_path_need_bottoms codepath (instead of explicitly setting
> TMP_MARK on the bottoms in limit_to_ancestry() - that way, I think we
> can also use ANCESTRY_PATH instead of TMP_MARK throughout the ancestry
> path codepaths, but I haven't tested it), at least to prevent possible
> future bugs.

That sounds like you're trying to duplicate the bug in my first
attempt at this patch.  If you try to coalesce ANCESTRY_PATH and
TMP_MARK, then you not only get all descendants of C, you also get all
descendants of any ancestor of C, which defeats the whole point of my
changes.

It's true that I don't mark implicit C commits with ANCESTRY_PATH, but
those are always bottom commits that are the excluded end of a range
anyway.  While those could be marked without causing problems, it
would always be a waste of effort.

> > @@ -2213,7 +2220,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
> >                              const struct setup_revision_opt* opt)
> >  {
> >       const char *arg = argv[0];
> > -     const char *optarg;
> > +     const char *optarg = NULL;
> >       int argcount;
> >       const unsigned hexsz = the_hash_algo->hexsz;
>
> [snip]
>
> > @@ -2280,10 +2287,26 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
> >               revs->first_parent_only = 1;
> >       } else if (!strcmp(arg, "--exclude-first-parent-only")) {
> >               revs->exclude_first_parent_only = 1;
> > -     } else if (!strcmp(arg, "--ancestry-path")) {
> > +     } else if (!strcmp(arg, "--ancestry-path") ||
> > +                skip_prefix(arg, "--ancestry-path=", &optarg)) {
>
> This and the above hunk might cause bugs if --ancestry-path was first
> specified with a commit and then specified without. Probably best to
> break this up into separate "else if" branches, even though there is a
> bit of code duplication (and also remove the "= NULL" addition in the
> above hunk).

Ah, good catch.

> > @@ -164,6 +165,7 @@ struct rev_info {
> >                       cherry_mark:1,
> >                       bisect:1,
> >                       ancestry_path:1,
> > +                     ancestry_path_need_bottoms:1,
>
> Might be better named as ancestry_path_implicit_bottoms? And probably
> worth documenting, e.g.
>
>   True if --ancestry-path was specified without an argument. The bottom
>   revisions are implicitly the arguments in this case.

Sure, sounds good.

Thanks for the careful review!
