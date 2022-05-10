Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B20AC43217
	for <git@archiver.kernel.org>; Tue, 10 May 2022 07:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbiEJHhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 03:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239011AbiEJHK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 03:10:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE91E17E16E
        for <git@vger.kernel.org>; Tue, 10 May 2022 00:06:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id z2so29459312ejj.3
        for <git@vger.kernel.org>; Tue, 10 May 2022 00:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZKytYx9Yx4qjTgCkH2KjNw/Pkw90f6ILwnu+65+pKY=;
        b=IiYEH/V52vHN7K6xhvN0hI4DsiGywlZSG0EJ+1yVPfJTOv+G833zw2mteW+ifzQKXz
         wMmej/4cdUiKlwUOPn3rLrf0vjTddCplLjOnB3j08K2IhSUWOmFyS1Cc155aKEM1iwL/
         OE6BQzOupOlRMTCPn4PJ38Jql+BqNCq5UE25Nm/4kal10k3ikZ054nfNactRH4FKi5Ec
         ASW39G4t5tIidWo+3dSuc65N2W1k+PAfSo3xPNiS3sFDmy8FKViuCNs8X1g5ZgiTepoa
         raMSmg8EV/ozXNIK+GJ5lpAz8fz1N8LglGpUqRh70cvVWkHrwsmDcFNUhRcGdNW71uSC
         RQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZKytYx9Yx4qjTgCkH2KjNw/Pkw90f6ILwnu+65+pKY=;
        b=K8wIyQD0HU0692sxx+jzqmNieKuh3yCo7wR01SFZ3UHdVrnePSL64hG3h6C7rcHxPP
         xJ0C3UGGPuvGRCXoXYH70ot7yS8TStEaPjjz4UUfsRh+20g+cJLgNUOmpTPlTVKzYo7b
         q3I5QWT8ttwNzib0+WI0CTyaQq8LvNrJFqzl9rueYCYW7l9MooGELVdCWpsv1f2W3U72
         qc7ekrw7J5kKZcQ7rMbkgHBQbICYYObb1kV/l/6lJgPcufwYeNkCFzlgNg1dzHw2WDCT
         63iUzscGdLwM0XgOTUMsdfRrid0AaaTD+WjHCzNADgSRXgF84GGeOg6/38a0oM0nBOt+
         6w8Q==
X-Gm-Message-State: AOAM5333WCHl4bTEA9hvoDtJ3hwNi2dlEY5QSPXS9WLi5RnfoyC/CeNt
        IavgGrbJWCqx9xoQU8C5H6ZC3iWjhF8D/5qiX50=
X-Google-Smtp-Source: ABdhPJzA16SzJIWltlFD9Ucwb1K2ukqVT17IDNyFJWn5XjCxo4198LMZYNVTbYGJBpbqUEIeg1gYOpvXXYTGcmNsXo4=
X-Received: by 2002:a17:906:3a45:b0:6f4:e9e7:4ff with SMTP id
 a5-20020a1709063a4500b006f4e9e704ffmr17851413ejf.100.1652166416091; Tue, 10
 May 2022 00:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
 <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com> <4537d473b937b182cd79b2f3c5673b75d92cab23.1651083378.git.gitgitgadget@gmail.com>
 <CABPp-BHcWjOeVhRD_XKTko0OH2pwYsuCt8PzH=C_0u_gUWe0GQ@mail.gmail.com> <65dd1914-137e-d9ba-ee1f-7611e5f71d30@github.com>
In-Reply-To: <65dd1914-137e-d9ba-ee1f-7611e5f71d30@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 May 2022 00:06:44 -0700
Message-ID: <CABPp-BGcxu8gkNtdKYsGErNapxKzcHugNxoz61=RwG-8dkOWGg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] merge-recursive: add merge function arg to 'merge_recursive_generic'
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 9, 2022 at 12:24 PM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren wrote:
> > On Wed, Apr 27, 2022 at 11:16 AM Victoria Dye via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Victoria Dye <vdye@github.com>
> >>
> >> Replace the hardcoded 'merge_recursive()' function used by the
> >> 'merge_recursive_generic()' with a caller-specific merge function. This will
> >> allow us to use 'merge_ort_recursive()' (and therefore avoid the index
> >> expansion of 'merge_recursive()') in commands that perform merges with
> >> 'merge_recursive_generic()', such as 'git stash pop'.
> >>
> >> Note that this patch is strictly a refactor; all callers still use
> >> 'merge_recursive()', and any changing to 'merge_ort_recursive()' will be
> >> done in a later commit.
> >
> > I'm not sure if we can gut merge_recursive_generic(), but I don't
> > think stash should use it...
> >
> >> Signed-off-by: Victoria Dye <vdye@github.com>
> >> ---
> >>  builtin/am.c              | 2 +-
> >>  builtin/merge-recursive.c | 2 +-
> >>  builtin/stash.c           | 2 +-
> >>  merge-ort.c               | 3 ++-
> >>  merge-recursive.c         | 4 ++--
> >>  merge-recursive.h         | 9 ++++++++-
> >>  6 files changed, 15 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/builtin/am.c b/builtin/am.c
> >> index 0f4111bafa0..6d01185d122 100644
> >> --- a/builtin/am.c
> >> +++ b/builtin/am.c
> >> @@ -1614,7 +1614,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
> >>         if (state->quiet)
> >>                 o.verbosity = 0;
> >>
> >> -       if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
> >> +       if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, merge_recursive, &result)) {
> >>                 repo_rerere(the_repository, state->allow_rerere_autoupdate);
> >>                 free(their_tree_name);
> >>                 return error(_("Failed to merge in the changes."));
> >> diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
> >> index b9acbf5d342..687ed1e527b 100644
> >> --- a/builtin/merge-recursive.c
> >> +++ b/builtin/merge-recursive.c
> >> @@ -81,7 +81,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
> >>         if (o.verbosity >= 3)
> >>                 printf(_("Merging %s with %s\n"), o.branch1, o.branch2);
> >>
> >> -       failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, &result);
> >> +       failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, merge_recursive, &result);
> >>
> >>         free(better1);
> >>         free(better2);
> >> diff --git a/builtin/stash.c b/builtin/stash.c
> >> index 1bfba532044..16171eb1dab 100644
> >> --- a/builtin/stash.c
> >> +++ b/builtin/stash.c
> >> @@ -554,7 +554,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
> >>         bases[0] = &info->b_tree;
> >>
> >>         ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, 1, bases,
> >> -                                     &result);
> >> +                                     merge_recursive, &result);
> >>         if (ret) {
> >>                 rerere(0);
> >>
> >> diff --git a/merge-ort.c b/merge-ort.c
> >> index 8545354dafd..4bccdfcf355 100644
> >> --- a/merge-ort.c
> >> +++ b/merge-ort.c
> >> @@ -4737,7 +4737,8 @@ void merge_incore_recursive(struct merge_options *opt,
> >>         trace2_region_enter("merge", "incore_recursive", opt->repo);
> >>
> >>         /* We set the ancestor label based on the merge_bases */
> >> -       assert(opt->ancestor == NULL);
> >> +       assert(opt->ancestor == NULL ||
> >> +              !strcmp(opt->ancestor, "constructed merge base"));
> >
> > ...and here's one of the reasons why.  The fact that
> > merge_recursive_generic() uses this string when exactly one merge base
> > is passed is something that is only correct for git-am; it is wrong
> > and actively misleading for git-stash since it has a real merge base
> > that is not internally constructed by the operation using the merge
> > machinery.  (The merge base it uses is something like $STASH^1, IIRC.)
> >
> > In fact, this was half the coin around why merge_recursive_generic()
> > wasn't converted when merge-ort was written; see
> > https://lore.kernel.org/git/CABPp-BHW61zA+MefvWK47iVZKY97rxc2XZ-NjXzuJxEhgSLqUw@mail.gmail.com/
> > and https://lore.kernel.org/git/CABPp-BFr=1iVY739cfh-1Hp82x-Mny-k4y0f3zZ_YuP3PxiGfQ@mail.gmail.com/
> > for more details.
> >
>
> All of that makes sense, thanks for the context!
>
> > The use of merge_recursive_generic() by stash is also a bit weird;
> > most of the time, stash is going to have actual commits instead of
> > just trees.  But stash dereferences those commits to trees, passes
> > them to merge_recursive_generic(), and then merge_recursive_generic()
> > has to create fake commits containing those trees, because the merge
> > machinery wants commits.  It feels a bit like a Rube Goldberg machine.
> > Also, stash also always calls merge_recursive_generic() with exactly
> > one merge base, which together with having real commits both kind of
> > defeat the need for "generic".    I think stash should just use
> > merge_trees()/merge_incore_nonrecursive() directly (much as
> > sequencer.c does).  The only special case to worry about with stash is
> > when c_tree != HEAD^{tree}, i.e. when applying changes on top of
> > already present changes instead of just on top of HEAD.  But in that
> > case, I think stash should be the thing to create a fake commit rather
> > than invoking some wrapper that will create fake commits for all three
> > trees.
> >
>
> I'm a bit confused about this. The non-recursive merge functions
> ('merge_trees()' & 'merge_ort_nonrecursive()' or the lower-level
> 'merge_incore_nonrecursive()') merge trees, not commits, so performing a
> non-recursive merge requires dereferencing commits to trees anyway. I think
> I agree with your other message [1] that the 'stash' merge doesn't need to
> merge recursively, but that would mean it also doesn't use the commits
> *directly* (i.e., as arguments in the merge).
>
> Apologies if I'm missing something obvious, but I want to make sure I
> understand your suggestion.
>
> [1] https://lore.kernel.org/git/CABPp-BFANwZn73w8zrVySB7mh0bQQBdGJjBuSJy50UOeyYT6aA@mail.gmail.com/

Oh, right, it's only the recursive merge that needs commits (so that
it can find ancestors and ancestors of ancestors, etc.).  So, ignore
my comments about making fake commits; that's not needed.
