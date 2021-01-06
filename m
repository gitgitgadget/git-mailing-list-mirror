Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86D3C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 19:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E4F23131
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 19:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbhAFTQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 14:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbhAFTQV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 14:16:21 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C99C061575
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 11:15:40 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id o11so4033656ote.4
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 11:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wv9TqtK/7F8CpZHgMU7uz0miXEeoUDVopOW8Rz09Ecc=;
        b=KoJe6uRFjX0RQKElbuOFoKsb3+185eNiP0DGLy1sTYygmTCBPDKLF49pZL8ZvIhabR
         H0hofSM2mzoJ7FG+cJvcXFOmt0LuJ6Kj5pB/yzuB8iaV4IEyeBq78qTV/8YFHjaT4dCj
         JayAf2mpXnG/83LpXocTCkE6oZPViXJXKdiq5ntwtkVI8MEl1N/ClNtkghkVfvah3Zxx
         VVDyEoS8KhVbu6dGa27OgBccaziYyhatH44KoyyuxiwOHC+sAt2H4XHWnmaw2Q3zwc8C
         7F/Zw6gH5OKvYzteOI1RkqGj20i5rxrY0B3plHf97fEy0xPeDODKymPn4F8jpJZJ385k
         C5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wv9TqtK/7F8CpZHgMU7uz0miXEeoUDVopOW8Rz09Ecc=;
        b=tZUzB9gmKBKEaGw46VdH3ASJ8Yrkh1eLfNrAM0f6t+GRVb/BOkr++5ViDVxSqSGUrM
         SIG703eDG4qIQQJOBBJ0VgvNDDQO9rQS8yVDtbWDpvXcstXWx/GTl8O8LDzoQjRB/oXO
         Emf+Gv7FmXwDpl1AOdbgPXhkjS2P9yJYiQhZgRRjWCr1sR5ytHydgu+ohqQkNaYvqQR4
         tQdOvddyYI+PU8xKrxFUfWjqj91MKjuy7UK4VrkhLn6zxXu1NvUlsCaQunesor5jQetS
         cg7lN8gPM99Wek8q9X2oRuo9ZeZbChSrv2H+OxXKoRycTYKyPUA1/oaVbLpq9FEzeTPE
         cEUg==
X-Gm-Message-State: AOAM532+ZaLZZyG3wC1kUqHQpu9fEQGC3sYjf6FIl3Pz+pmG3twlWIyY
        cQrZNsfYtkuRNvGvzoynLZ/T9O7AowLtBN/ZsL8=
X-Google-Smtp-Source: ABdhPJyXQaJPGXtLquN73UzMNbou0qBVx/68v2XC0myZRtngrNu4KuMw1sB9LX8KcksIWdiBomXnIEfciHLxyyO+YLc=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr4247780oth.316.1609960539768;
 Wed, 06 Jan 2021 11:15:39 -0800 (PST)
MIME-Version: 1.0
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
 <xmqqeekt83fl.fsf@gitster.c.googlers.com> <CABPp-BHvZyb4cF29HqDYgMHTMEr2LdvKYATWqADRyhqJzB=Liw@mail.gmail.com>
 <CABPp-BGMX3wb7LiS1HkJpGveoW3J1oR0vVHbKTF5+qYLRF+59g@mail.gmail.com>
 <CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com> <1a1e33f6-3514-9afc-0a28-5a6b85bd8014@gmail.com>
In-Reply-To: <1a1e33f6-3514-9afc-0a28-5a6b85bd8014@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Jan 2021 11:15:28 -0800
Message-ID: <CABPp-BHfbuRX2kWgS1SuHkpCa+rfpkeUvkrp4hZ9AWV+YfKgWA@mail.gmail.com>
Subject: Re: sparse-checkout questions and proposals [Was: Re: [PATCH] rm:
 honor sparse checkout patterns]
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 3, 2021 at 7:02 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/31/2020 3:03 PM, Elijah Newren wrote:
> > Sorry for the long delay...
>
> Thanks for bringing us all back to the topic.
>
> >   sparse-checkout's purpose is not fully defined.  Does it exist to:
> >     A) allow working on a subset of the repository?
> >     B) allow working with a subset of the repository checked out?
> >     C) something else?
>
> I think it's all of the above!

I think I understand your sentiment, but since my choice C was so
vague, your answer doesn't really help us figure out correct behavior
for commands that currently behave weirdly.  ;-)

> My main focus for sparse-checkout is a way for users who care about a
> small fraction of a repository's files to only do work on those files.
> This saves time because they are asking Git to do less, but also they
> can use tools like IDEs that with "Open Folder" options without falling
> over. Writing fewer files also affects things like their OS indexing
> files for search or antivirus scanning written files.

Interesting, IDE failure/overload was one of the big driving factors
in our adoption as well.

> Others use sparse-checkout to remove a few large files unless they
> need them. I'm less interested in this case, myself.
>
> Both perspectives get better with partial clone because the download
> size shrinks significantly. While partial clone has a sparse-checkout
> style filter, it is hard to compute on the server side. Further, it
> is not very forgiving of someone wanting to change their sparse
> definition after cloning. Tree misses are really expensive, and I find
> that the extra network transfer of the full tree set is a price that is
> worth paying.

Out of curiosity, is that because the promisor handling doesn't do
nice batching of trees to download, as is done for blobs, or is there
a more fundamental reason they are really expensive?  (I'm just
wondering if we are risking changing design in some areas based on
suboptimal implementation of other things.  I don't actually have
experience with partial clones yet, though, so I'm basically just
querying about random but interesting things without any experience to
back it up.)

> I'm also focused on users that know that they are a part of a larger
> whole. They know they are operating on a large repository but focus on
> what they need to contribute their part. I expect multiple "roles" to
> use very different, almost disjoint parts of the codebase. Some other
> "architect" users operate across the entire tree or hop between different
> sections of the codebase as necessary. In this situation, I'm wary of
> scoping too many features to the sparse-checkout definition, especially
> "git log," as it can be too confusing to have their view of the codebase
> depend on your "point of view."
>
> (In case we _do_ start changing behavior in this way, I'm going to use
> the term "sparse parallax" to describe users being confused about their
> repositories because they have different sparse-checkout definitions,
> changing what they see from "git log" or "git diff".)

Thanks for this extra perspective.

>
> > === Why it matters ==
> >
> > There are unfortunately *many* gray areas when you try to define how git
> > subcommands should behave in sparse-checkouts.  (The
> > implementation-level definition from a decade ago of "files are assumed
> > to be unchanged from HEAD when SKIP_WORKTREE is set, and we remove files
> > with that bit set from the working directory" definition from the past
> > provides no clear vision about how to resolve gray areas, and also leads
> > to various inconsistencies and surprises for users.)  I believe a
> > definition based around a usecase (or usecases) for the purpose of
> > sparse-checkouts would remove most of the gray areas.
> >
> > Are there choices other than A & B that I proposed above that make
> > sense?  Traditionally, I thought of B as just a partial implementation
> > of A, and that A was the desired end-goal.  However, others have argued
> > for B as a preferred choice (some users at $DAYJOB even want both A and
> > B, meaning they'd like a simple short flag to switch between the two).
> > There may be others I'm unaware of.
> >
> > git implements neither A nor B.  It might be nice to think of git's
> > current behavior as a partial implementation of B (enough to provide
> > some value, but still feel buggy/incomplete), and that after finishing B
> > we could add more work to allow A.  I'm not sure if the current
> > implementation is just a subset of B, though.
> >
> > Let's dig in...
>
> I read your detailed message and I think you make some great points.
>
> I think there are three possible situations:
>
> 1. sparse-checkout should not affect the behavior at all.
>
>    An example for this is "git commit". We want the root tree to contain
>    all of the subtrees and blobs that are out of the sparse-checkout
>    definition. The underlying object model should never change.
>
> 2. sparse-checkout should change the default, but users can opt-out.
>
>    The examples I think of here are 'git grep' and 'git rm', as we have
>    discussed recently. Having a default of "you already chose to be in
>    a sparse-checkout, so we think this behavior is better for you"
>    should continue to be pursued.
>
> 3. Users can opt-in to a sparse-checkout version of a behavior.
>
>    The example in this case is "git diff". Perhaps we would want to see
>    a diff scoped only to our sparse definition, but that should not be
>    the default. It is too risky to change the output here without an
>    explicit choice by the user.

I'm curious why you put grep and diff in different categories.  A
plain "git diff" without revisions will give the same output whether
or not it restricts to the sparsity paths (because the other paths are
unchanged), so restricting is purely an optimization question.  Making
"git diff REVISION" restrict to the sparsity paths would be a
behavioral change as you note, but "git grep [REVISION]" would also
require a behavioral change to limit to the sparsity paths.  If it's
too risky to change the output for git diff with revisions, why is it
not also too risky to do that with git grep with revisions?


Also, I think you are missing a really important category:

4. sparse-checkout changes the behavior of commands and there is no
opt-out or configurability provided.

The most obvious examples are switch and checkout -- their modified
behavior is really the /point/ of sparse-checkouts and if you want to
"opt out" then just don't use sparse-checkouts.  `reset --hard` can go
in the same bucket; it's modified in the same way.  However, some
commands are modified in a different way, but also have no opt-out --
for example, merge, rebase, cherry-pick, revert, and stash, all "try"
to avoid writing files to the working tree that match the sparsify
specifications, but will vivify files which have conflicts (and maybe
a few additional files based on implementation shortcomings).  Another
command that behaves differently than any of these, and is also
non-configurable in this change, is git-add.  It'll ignore any tracked
files with the SKIP_WORKTREE bit set, even if the file is present.
That's really helpful thing for "git add -A [GLOB_OR_DIRECTORY]" to
do, as we don't want sparsity to accidentally be treated as a
directive to remove files from the repository.

I think more commands should fall under this fourth category as well,
including rm.

However, I actually think 4 deserves to be broken up into separate
categories based on the type of behavior change.  Thus, I'd need a 4a,
4b, and 4c for my example commands above.

> Let's get into your concrete details now:
>
> > === behavioral proposals ===
> >
> > Short term version:
> >
> >   * en/stash-apply-sparse-checkout: apply as-is.
> >
> >   * mt/rm-sparse-checkout: modify it to ignore sparse.restrictCmds --
> >       `git rm` should be like `git add` and _always_ ignore
> >       SKIP_WORKTREE paths, but it should print a warning (and return
> >       with non-zero exit code) if only SKIP_WORKTREE'd paths match the
> >       pathspec.  If folks want to remove (or add) files outside current
> >       sparsity paths, they can either update their sparsity paths or use
> >       `git update-index`.
> >
> >   * mt/grep-sparse-checkout: figure out shorter flag names.  Default to
> >       --no-restrict-to-sparse, for now.  Then merge it for git-2.31.
>
> I don't want to derail your high-level conversation too much, but by the
> end of January I hope to send an RFC to create a "sparse index" which allows
> the index to store entries corresponding to a directory with the skip-
> worktree bit on. The biggest benefit is that commands like 'git status' and
> 'git add' will actually change their performance based on the size of the
> sparse-checkout definition and not the total number of paths at HEAD.

This is _awesome_; I think it'll be huge.  It'll cause even more
commands behavior to change, of course, but in a good way.  And I
don't consider this derailing at all but extending the discussion
complete with extra investigation work.  :-)

> The other thing that happens once we have that idea is that these behaviors
> in 'git grep' or 'git rm' actually become _easier_ to implement because we
> don't even have an immediate reference to the blobs outside of the sparse
> cone (assuming cone mode).
>
> The tricky part (that I'm continuing to work on, hence no RFC today) is
> enabling the part where a user can opt-in to the old behavior. This requires
> parsing trees to expand the index as necessary. A simple approach is to
> create an in-memory index that is the full expansion at HEAD, when necessary.
> It will be better to do expansions in a targeted way.

I'm not sure if you're just thinking of the old mt/rm-sparse-checkout
and commenting on it, or if you're actively disagreeing with my
proposal for rm.

> (Your merge-ort algorithm is critical to the success here, since that doesn't
> use the index as a data structure. I expect to make merge-ort the default for
> users with a sparse index. Your algorithm will be done first.)

Well, at 50 added/changed lines per patch, I've only got ~50 more
patches to go for ort after the ones I submitted Monday (mostly
optimization related).  If I submit 10 patches per week (starting next
week since I already sent a big patchset this week), then maybe
mid-to-late February.  That's a more aggressive pace than we've
managed so far, but maybe it gets easier towards the end?  Anyway,
hopefully that helps you with timing predictions.

On my end, this does make the ort work look like there's finally some
light at the end of the tunnel; I just hope it's not an oncoming
train. :-)

> My point in bringing this up is that perhaps we should pause concrete work on
> updating other builtins until we have a clearer idea of what a sparse index
> could look like and how the implementation would change based on having one
> or not. I hope that my RFC will be illuminating in this regard.

Are you suggesting to pause any work on those pieces of the proposal
that might be affected by your sparse index, or pause any work at all
on sparse-checkouts?  For example, I think
en/stash-apply-sparse-checkout that's been sitting in seen is good to
merge down to master now.  I suspect mt/rm-sparse-checkout WITH my
suggested changes (no configurability -- similar to git-add) and a
better warning/error message for git-add are some examples of cleanups
that could be done before your sparse index, but if you're worried
about conflicting I certainly don't want to derail your project.  (I
agree that anything with configurability and touching on "behavior A"
or "sparse parallelax", like mt/grep-sparse-checkout would be better
if we waited on.  I do feel pretty bad for how much we've made Matheus
wait on that series, but waiting does still seem best.)

> Ok, enough of that sidebar. I thought it important to bring up, but
>
> > Longer term version:
> >
> > I'll split these into categories...
> >
> > --> Default behavior
> >   * Default to behavior B (--no-restrict-to-sparse from
> >     mt/grep-sparse-checkout) for now.  I think that's the wrong default
> >     for when we marry sparse-checkouts with partial clones, but we only
> >     have patches for behavior A for git grep; it may take a while to
> >     support behavior A in each command.  Slowly changing behavior of
> >     commands with each release is problematic.  We can discuss again
> >     after behavior A is fully supported what to make the defaults be.
> >
> > --> Commands already working with sparse-checkouts; no known bugs:
> >   * status
> >   * switch, the "switch" parts of checkout
> >
> >   * read-tree
> >   * update-index
> >   * ls-files
> >
> > --> Enhancements
> >   * General
> >     * shorter flag names than --[no-]restrict-to-sparse.  --dense and
> >       --sparse?  --[no-]restrict?
>
> --full-workdir?

Hmm.  "workdir" sounds like an abbreviation of "working directory",
which is the place where the files are checked out.  And the working
directory is sparse in a sparse-checkout.  So isn't this misleading?
Or did you intend for this option to be the name for requesting a
sparser set?  (If so, isn't "full" in its name a bit weird?)

Also, what would the inverse name of --full-workdir be?  I was looking
to add options for both restricting the command to the sparser set and
for expanding to the full set of files.  Though I guess as you note
below, you perhaps might be in favor of only one of these without
configuration options to adjust defaults.

> >   * sparse-checkout (After behavior A is implemented...)
> >     * Provide warning if sparse.restrictCmds not set (similar to git
> >       pull's warning with no pull.rebase, or git checkout's warning when
> >       detaching HEAD)
> >   * clone
> >       * Consider having clone set sparse.restrictCmds based on whether
> >       --partial is provided in addition to --sparse.
>
> In general, we could use some strategies to help users opt-in to these
> new behaviors more easily. We are very close to having the only real
> feature of Scalar be that it sets these options automatically, and will
> continue to push to the newest improvements as possible.

Nice!

> > --> Commands with minor bugs/annoyances:
> >   * add
> >     * print a warning if pathspec only matches SKIP_WORKTREE files (much
> >       as it already does if the pathspec matches no files)
> >
> >   * reset --hard
> >     * spurious and incorrect warning when removing a newly added file
> >   * merge, rebase, cherry-pick, revert
> >     * unnecessary unsparsification (merge-ort should fix this)
> >   * stash
> >     * similar to merge, but there are extra bugs from the pipeline
> >       design.  en/stash-apply-sparse-checkout fixes the known issues.
> >
> > --> Buggy commands
> >   * am
> >     * should behave like merge commands -- (1) it needs to be okay for
> >       the file to not exist in the working directory; vivify it if
> >       necessary, (2) any conflicted paths must remain vivified, (3)
> >       paths which merge cleanly can be unvivified.
> >   * apply
> >     * See am
> >   * rm
> >     * should behave like add, skipping SKIP_WORKTREE entries.  See comments
> >       on mt/rm-sparse-checkout elsewhere
> >   * restore
> >     * with revisions and/or globs, sparsity patterns should be heeded
> >   * checkout
> >     * see restore
> >
> > --> Commands that need no changes because commits are full-tree:
> >   * archive
> >   * bundle
> >   * commit
> >   * format-patch
> >   * fast-export
> >   * fast-import
> >   * commit-tree
> >
> > --> Commands that would change for behavior A
> >   * bisect
> >     * Only consider commits touching paths matching sparsity patterns
> >   * diff
> >     * When given revisions, only show subset of files matching sparsity
> >       patterns.  If pathspecs are given, intersect them with sparsity
> >       patterns.
> >   * log
> >     * Only consider commits touching at least one path matching sparsity
> >       patterns.  If pathspecs are given, paths must match both the
> >       pathspecs and the sparsity patterns in order to be considered
> >       relevant and be shown.
> >   * gitk
> >     * See log
> >   * shortlog
> >     * See log
> >   * grep
> >     * See mt/grep-sparse-checkout; it's been discussed in detail..and is
> >       implemented.  (Other than that we don't want behavior A to be the
> >       default when so many commands do not support it yet.)
> >
> >   * show-branch
> >     * See log
> >   * whatchanged
> >     * See log
> >   * show (at least for commits)
> >     * See diff
> >
> >   * blame
> >     * With -C or -C -C, only detect lines moved/copied from files that match
> >       the sparsity paths.
> >   * annotate
> >     * See blame.
>
> this "behavior A" idea is the one I'm most skeptical about. Creating a
> way to opt-in to a sparse definition might be nice. It might be nice to
> run "git log --simplify-sparse" to see the simplified history when only
> caring about commits that changed according to the current sparse-checkout
> definitions. Expand that more when asking for diffs as part of that log,
> and the way we specify the option becomes tricky.

--simplify-sparse is a really long name to need to specify at every
invocation.  Also, if we have --[no]-restrict or --sparse/--dense
options at the git level (rather than the subcommand level), then I
think we don't want extra ones like this at the subcommand level.

Also, if the option appears at the global git level, doesn't that
remove the trickiness of revision traversal vs. diff outputting in
commands like log?  It just automatically applies to both.  (The only
trickiness would be if you wanted to somehow apply sparsity patterns
to just revision traversal or just diff outputting but not to both,
but that's already tricky in log with explicit pathspecs and we've
traditionally had files restrict both.)

> But I also want to avoid doing this as a default or even behind a config
> setting. We already get enough complains about "missing commits" when
> someone does a bad merge so "git log -- file" simplifies away a commit
> that exists in the full history. Imagine someone saying "on my machine,
> 'git log' shows the commit, but my colleague can't see it!" I would really
> like to avoid adding to that confusion if possible.

That's a good point.  A really good point.  Maybe we do only want to
allow explicit requests for this behavior -- and thus need very short
option name for it.

Here's a not-even-half-baked idea for thought: What if we allowed a
configuration option to control this, BUT whenever a command like
diff/grep/log restricts output based on the sparsity paths due solely
to the configuration option, it prints a small reminder on stderr at
the beginning of the output (e.g. "Note: output limited to sparsity
paths, as per sparse.restrictCmds setting")?

> > --> Commands whose behavior I'm still uncertain of:
> >   * worktree add
> >     * for behavior A (marrying sparse-checkout with partial clone), we
> >       should almost certainly copy sparsity paths from the previous
> >       worktree (we either have to do that or have some kind of
> >       specify-at-clone-time default set of sparsity paths)
> >     * for behavior B, we may also want to copy sparsity paths from the
> >       previous worktree (much like a new command line shell will copy
> >       $PWD from the previous one), but it's less clear.  Should it?
>
> I think 'git worktree add' should at minimum continue using a sparse-
> checkout if the current working directory has one. Worktrees are a
> great way to scale the creation of multiple working directories for
> the same repository without re-cloning all of the history. In a partial
> clone case, it's really important that we don't explode the workdir in
> the new worktree (or even download all those blobs).

Okay, sounds like you agree with me for the partial clone case -- it's
necessary.

But what about the non-partial clone case?  I think it should adopt
the sparsity in that case too, but Junio has objected in the past.
I'm pretty sure Junio wasn't thinking about the partial clone case,
where I think it seems obvious and compelling.  But I'm not sure how
best to convince him in the non-partial clone case (or maybe I already
did; he didn't respond further after his initial objection).

> Now, should we copy the sparse-checkout definitions, or start with the
> "only files at root" default? That's a more subtle question.

Ooh, good point.  Even if we adopt sparsity in the new worktree,
there's apparently a number of ways to do it.

> >   * range-diff
> >     * is this considered to be log-like for format-patch-like in
> >       behavior?
>
> If we stick with log acting on the full tree unless specified in the
> command-line options, then range-diff can be the same. Seems like a
> really low priority, though, because of the proximity to format-patch.
>
> >   * cherry
> >     * see range-diff
> >   * plumbing -- diff-files, diff-index, diff-tree, ls-tree, rev-list
> >     * should these be tweaked or always operate full-tree?
> >   * checkout-index
> >     * should it be like checkout and pay attention to sparsity paths, or
> >       be considered special like update-index, ls-files, & read-tree and
> >       write to working tree anyway?
> >   * mv
> >     * I don't think mv can take a glob, and I think it currently happens to
> >       work.  Should we add a comment to the code that if anyone wants to
> >       support mv using pathspecs they might need to be careful about
> >       SKIP_WORKTREE?
> >
> > --> Might need changes, but who cares?
> >   * merge-file
> >   * merge-index
> >
> > --> Commands with no interaction with sparse-checkout:
>
> (I agree with the list you included here.)
>
> Thanks for starting the discussion. Perhaps more will pick it up as
> they return from the holiday break.

Thanks for jumping in and pushing it much further with sparse indices
(or is it sparse indexes?)  I'm excited.
