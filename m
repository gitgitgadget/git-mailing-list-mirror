Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3B9C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 17:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E535233FD
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 17:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbhAGRhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 12:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbhAGRhE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 12:37:04 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE7DC0612F5
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 09:36:23 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id d8so7034049otq.6
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 09:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KwKtFU7CGnL//CAh+u4IJeBphKkCDKE7iFTMbJOw9k=;
        b=LTb0G2PDINUO46uk6ts8A7wn0WOpv1gLYo7fxdaYXNu746WTFnOBdJvpMfB/LEmFZB
         rvi29m4RJgflWzk0cu21E3T+tOg583VBWFWpwcGsYX9PZZzHugiIEg/vtlZNlThiQHTN
         Al6u85s1M7otxzOZUQemQ8kNvbX+lbBnRwIbViJLCxidozDb9/NQINYUZkbvrpQTT1dh
         w65hNJ7pkcVOXD1DxPL6Zhwsdo2ZKXd0vhGZyXKv7egJqzEfv2kJXztBD/srV/BhXPlQ
         HaktHEntslYthsTFqU1BlgGGDMOw82nvdMcT1tyfOIAifWxt8Bngh64VM0SMWHSv8Q9b
         ycgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KwKtFU7CGnL//CAh+u4IJeBphKkCDKE7iFTMbJOw9k=;
        b=fm+sEFQ5jlGJE4J9ULyrEw0JMIMeJnzVqcLILOi5yoPNTusi984bx2oLcpAHqc0EGl
         u0g5kvMa5mxHRhfwQwXdX9Tuvp5T8PLHT2Ni3Npu1V9hKcxcb1j9yeAgSNWIQKAM4JAU
         DQCV/PLBRJD+K73qcUs9BgxRl8SIR+4MLmPTGOhsw2R2fGaP9QFUb0cbUJFJftrBn8H0
         Agrc1kd1mTFvTRiv1fzmQ5vNZ1RZYVRyShYPGNa/2Wu1DntOx95SfGCtbXE25ycXM00g
         Q/Ov8FblNDRhCee4jpXshIXC6o47AsSYoJkm8LHhYux3K54WYoGaxIMcNUTM6MSeT8Rv
         JOLA==
X-Gm-Message-State: AOAM53066Wvqb/QKswBk+2BVMsZU7EqHvW/MLw62fzBxUB6Z2yVn16Ag
        zaQbYAXO+NRpHkhGitm8oCWnt2yuEc0jdkrjLmM=
X-Google-Smtp-Source: ABdhPJye8oejfyE1V5xwmnlhBX5MkeSt/tsIm00FlDHXr6reyR6vqKk6y7yh34b4uSVKnjTk9Cdw6Asn9LdN001vjK4=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr7257519oth.316.1610040982845;
 Thu, 07 Jan 2021 09:36:22 -0800 (PST)
MIME-Version: 1.0
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
 <xmqqeekt83fl.fsf@gitster.c.googlers.com> <CABPp-BHvZyb4cF29HqDYgMHTMEr2LdvKYATWqADRyhqJzB=Liw@mail.gmail.com>
 <CABPp-BGMX3wb7LiS1HkJpGveoW3J1oR0vVHbKTF5+qYLRF+59g@mail.gmail.com>
 <CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com>
 <1a1e33f6-3514-9afc-0a28-5a6b85bd8014@gmail.com> <CABPp-BHfbuRX2kWgS1SuHkpCa+rfpkeUvkrp4hZ9AWV+YfKgWA@mail.gmail.com>
 <06326ed2-d21d-2d4f-e90c-733cbfe2d04c@gmail.com>
In-Reply-To: <06326ed2-d21d-2d4f-e90c-733cbfe2d04c@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Jan 2021 09:36:11 -0800
Message-ID: <CABPp-BHwNoVnooqDFPAsZxBT9aR5Dwk5D9sDRCvYSb8akxAJgA@mail.gmail.com>
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

On Thu, Jan 7, 2021 at 4:53 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/6/2021 2:15 PM, Elijah Newren wrote:
> > On Sun, Jan 3, 2021 at 7:02 PM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 12/31/2020 3:03 PM, Elijah Newren wrote:
> >> Others use sparse-checkout to remove a few large files unless they
> >> need them. I'm less interested in this case, myself.
> >>
> >> Both perspectives get better with partial clone because the download
> >> size shrinks significantly. While partial clone has a sparse-checkout
> >> style filter, it is hard to compute on the server side. Further, it
> >> is not very forgiving of someone wanting to change their sparse
> >> definition after cloning. Tree misses are really expensive, and I find
> >> that the extra network transfer of the full tree set is a price that is
> >> worth paying.
> >
> > Out of curiosity, is that because the promisor handling doesn't do
> > nice batching of trees to download, as is done for blobs, or is there
> > a more fundamental reason they are really expensive?  (I'm just
> > wondering if we are risking changing design in some areas based on
> > suboptimal implementation of other things.  I don't actually have
> > experience with partial clones yet, though, so I'm basically just
> > querying about random but interesting things without any experience to
> > back it up.)
>
> GitHub doesn't support pathspec filters for partial clone because it
> is too expensive to calculate that initial packfile (cannot use
> reachability bitmaps). Even outside of that initial cost, we have
> problems.
>
> The biggest problem is that we ask for the tree as a one-off request.
> There are two ways to approach this:
>
> 1. Ask for all trees that are reachable from that tree so we can
>    complete the tree walk (current behavior). This downloads trees we
>    already have, most of the time.
>
> 2. Ask for only that tree and no extra objects. This causes the request
>    count to increase significantly, especially during a 'git pull' or
>    'git checkout' that spans a large distance.
>
> In either case, commands like "git log -- README.md" are really bad in
> a treeless clone (--filter=tree:0).
>
> For the sparse-checkout case, we still need the trees outside of our
> sparse cone in order to construct an index, even if we never actually
> check out those files. (Maybe not forever, though...)
>
> And maybe the solution would be to ask the server for your missing
> trees in the entire history when you change sparse-checkout definition,
> but what does that request look like?
>
>  client> I have these commits with trees according to this pathspec.
>  client> I want these commits with trees according to a new pathspec.
>  server> *flips table*

Ah, the good old *flips table* codepath.  That'd be a fun area of the
code to work on.  ;-)

To be serious, though, thanks for the extra info.

> >> I think there are three possible situations:
> >>
> >> 1. sparse-checkout should not affect the behavior at all.
> >>
> >>    An example for this is "git commit". We want the root tree to contain
> >>    all of the subtrees and blobs that are out of the sparse-checkout
> >>    definition. The underlying object model should never change.
> >>
> >> 2. sparse-checkout should change the default, but users can opt-out.
> >>
> >>    The examples I think of here are 'git grep' and 'git rm', as we have
> >>    discussed recently. Having a default of "you already chose to be in
> >>    a sparse-checkout, so we think this behavior is better for you"
> >>    should continue to be pursued.
> >>
> >> 3. Users can opt-in to a sparse-checkout version of a behavior.
> >>
> >>    The example in this case is "git diff". Perhaps we would want to see
> >>    a diff scoped only to our sparse definition, but that should not be
> >>    the default. It is too risky to change the output here without an
> >>    explicit choice by the user.
> >
> > I'm curious why you put grep and diff in different categories.  A
> > plain "git diff" without revisions will give the same output whether
> > or not it restricts to the sparsity paths (because the other paths are
> > unchanged), so restricting is purely an optimization question.  Making
> > "git diff REVISION" restrict to the sparsity paths would be a
> > behavioral change as you note, but "git grep [REVISION]" would also
> > require a behavioral change to limit to the sparsity paths.  If it's
> > too risky to change the output for git diff with revisions, why is it
> > not also too risky to do that with git grep with revisions?
>
> I generally think of 'grep' as being "search for something I care about"
> which is easier to justify scoping to sparse-checkouts.
>
> 'diff' is something that I usually think of as "compare two git objects"
> and it is operating on immutable data.
>
> The practical difference comes into play with a blobless partial clone:
> 'diff' will download blobs that need a content comparison, so the cost
> is relative to the number of changed paths in that region and relative
> to the requested output. 'grep' will download every blob reachable from
> the root tree. We've seen too many cases of users trying 'git grep' to
> search the Windows codebase and complaining that it takes too long
> (because they are downloading 3 million blobs one at a time).

Oh, is the primary difference here that you're complaining about a bug
in git grep, where without --cached it mixes worktree search results
with index search results?  That's just a flat out bug that should be
fixed.  See https://lore.kernel.org/git/CABPp-BGVO3QdbfE84uF_3QDF0-y2iHHh6G5FAFzNRfeRitkuHw@mail.gmail.com/.
grep is supposed to search the working tree by default, and *just* the
working tree -- as documented from the beginning.  If you specify
--cached, it'll search the index.  If you specify revisions, then it
searches revisions.  There is not supposed to currently be mixing and
matching of searches from multiple areas.  Someone could add such an
ability to search multiple locations, but then the user should have to
specify that behavior.  The fact that sparse-checkouts search multiple
areas is a *bug*, regardless of sparse indexes or not, regardless of
"behavior A" or "behavior B", etc.

The interesting bit, is whether `git grep ... REVISION` should
restrict to sparsity paths.  Unlike the working tree, REVISION
probably has many paths that don't match the sparsity paths.  Same for
--cached.  That part makes sense to make configurable.

So, I guess my question is, after the bug in git grep is fixed that
I've been railing about for nearly a year (and sadly got tied up in
other changes Matheus wanted to make so that the rest could be made
configurable), then do you consider the rest of git grep different
from git diff?

> > Also, I think you are missing a really important category:
> >
> > 4. sparse-checkout changes the behavior of commands and there is no
> > opt-out or configurability provided.
> >
> > The most obvious examples are switch and checkout -- their modified
> > behavior is really the /point/ of sparse-checkouts and if you want to
> > "opt out" then just don't use sparse-checkouts.  `reset --hard` can go
> > in the same bucket; it's modified in the same way.  However, some
> > commands are modified in a different way, but also have no opt-out --
> > for example, merge, rebase, cherry-pick, revert, and stash, all "try"
> > to avoid writing files to the working tree that match the sparsify
> > specifications, but will vivify files which have conflicts (and maybe
> > a few additional files based on implementation shortcomings).  Another
> > command that behaves differently than any of these, and is also
> > non-configurable in this change, is git-add.  It'll ignore any tracked
> > files with the SKIP_WORKTREE bit set, even if the file is present.
> > That's really helpful thing for "git add -A [GLOB_OR_DIRECTORY]" to
> > do, as we don't want sparsity to accidentally be treated as a
> > directive to remove files from the repository.
>
> True. Except for these, the opt-in/out is "git sparse-checkout init"
> and "git sparse-checkout disable". If I want "git checkout" to behave
> differently, then I modify my sparse-checkout definition or disable
> it altogether.
>
> Perhaps instead we should think of this category as the "core
> functionality of sparse-checkout."

The core functionality of sparse-checkout has always been only
partially implemented.  See the last few lines of t7012.  See the bugs
over the years with the merge machinery and SKIP_WORKTREE entries.
See the bug reports with git-stash.  See my long explanation to
Matheus on how git-grep without --cached or revisions is flat broken
in sparse-checkouts[1].  See Junio's comments about how "the sparse
checkout 'feature' itself is a hack'"[2] and that folks working in
other areas didn't need to provide full support for it.

So, that raises the question -- what else is "core functionality of
sparse-checkout" besides what I listed above?  I reject the idea that
whatever is currently implemented is the bright line.  The rest is
certainly up for discussion, but I don't like using the idea of
current behavior as the litmus test for whether something is core
functionality.  In fact this is the very reason why I so strongly
requested the huge warning in the sparse-checkout documentation[3].

[1] https://lore.kernel.org/git/CABPp-BGVO3QdbfE84uF_3QDF0-y2iHHh6G5FAFzNRfeRitkuHw@mail.gmail.com/
[2] https://lore.kernel.org/git/xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com/
[3] https://lore.kernel.org/git/CABPp-BEryfaeYhuUsiDTaYdRKpK6GRi7hgZ5XSTVkoHVkx2qQA@mail.gmail.com/

And I'm arguing a change in rm behavior should be core functionality
of sparse-checkout; more on that below.

> > I think more commands should fall under this fourth category as well,
> > including rm.
>
> The biggest issue with 'rm' is that users may want to use it to
> delete paths outside of their sparse-checkout according to a
> pathspec. This is especially true since it is the current
> behavior, so if we change it by default we might discover more
> complaints than the current requests for a way to limit to the
> sparse-checkout definition.

Users cannot update files outside their sparsity paths using add,
though.  Even if they create the file from scratch with the necessary
changes and run 'git add' on it.  And that's core functionality.
Users must first change their sparsity paths before trying to add such
files.  If we were to allow them, I think things get weird.

I think that's a good model.  We should require them to do the same
for removing.  If they come to us requesting a way to delete paths
outside their sparse-checkout, we give them the same answer that we do
for updating paths outside their sparse-checkout: simply change your
sparsity definition first.  It's a simple solution.  No
configurability is required here, IMO, and it makes commands more
consistent with each other.

Of course, that's the high-level explanation.  Digging in to the
details, there we should also change or add warning/error messages for
both 'add' and 'rm' in some cases; see my original email in this
thread for that discussion.

> >>>   * mt/grep-sparse-checkout: figure out shorter flag names.  Default to
> >>>       --no-restrict-to-sparse, for now.  Then merge it for git-2.31.
> >>
> >> I don't want to derail your high-level conversation too much, but by the
> >> end of January I hope to send an RFC to create a "sparse index" which allows
> >> the index to store entries corresponding to a directory with the skip-
> >> worktree bit on. The biggest benefit is that commands like 'git status' and
> >> 'git add' will actually change their performance based on the size of the
> >> sparse-checkout definition and not the total number of paths at HEAD.
> >
> > This is _awesome_; I think it'll be huge.  It'll cause even more
> > commands behavior to change, of course, but in a good way.  And I
> > don't consider this derailing at all but extending the discussion
> > complete with extra investigation work.  :-)
> >
> >> The other thing that happens once we have that idea is that these behaviors
> >> in 'git grep' or 'git rm' actually become _easier_ to implement because we
> >> don't even have an immediate reference to the blobs outside of the sparse
> >> cone (assuming cone mode).
> >>
> >> The tricky part (that I'm continuing to work on, hence no RFC today) is
> >> enabling the part where a user can opt-in to the old behavior. This requires
> >> parsing trees to expand the index as necessary. A simple approach is to
> >> create an in-memory index that is the full expansion at HEAD, when necessary.
> >> It will be better to do expansions in a targeted way.
> >
> > I'm not sure if you're just thinking of the old mt/rm-sparse-checkout
> > and commenting on it, or if you're actively disagreeing with my
> > proposal for rm.
>
> I remember the discussion around how making 'rm' sparse-aware was more
> complicated than "only look at entries without CE_SKIP_WORKTREE" but
> it might be easier with a sparse-index. So my intention here was to
> see if we should _delay_ our investigation here until I can at least
> get a prototype ready for inspection.
>
> I'm also saying that perhaps we could redirect this discussion around
> how to opt-in/out of these changes. Much like your "category 4" above
> being "behavior expected when in a sparse-checkout," what if this
> behavior of restricting to the sparse set was expected when using a
> sparse-index instead of based on config options or run-time arguments?

All the delay was based on the configurability (which I initially
thought was needed too).  But after further recent investigation, I
think configurability for rm's behavior is just wrong.  rm should
restrict to sparse paths, just like add does.  I agree on delaying any
new features or changes that require configurability (and I agree with
you that the sparse-index could play a role in how to configure
things).  I just think that en/stash-apply-sparse-checkout and a
modified version of mt/rm-sparse-checkout are two cases that don't
require configurability and could go in first.

I also think pulling the bugfix out of mt/grep-sparse-checkout (don't
mix worktree and index searches) and merging it could happen now,
while waiting off on all the other bits that require configuration.

> What if we had something like "git update-index --[no-]sparse" to
> toggle between the two states?

Ooh, interesting idea.  We might have to discuss the name a bit; I'm
worried folks might struggle to differentiate between that command and
`git sparse-checkout {init,disable}`.

> That's my intention with bringing up my half-baked idea before I have
> code to show for it.
>
> >> (Your merge-ort algorithm is critical to the success here, since that doesn't
> >> use the index as a data structure. I expect to make merge-ort the default for
> >> users with a sparse index. Your algorithm will be done first.)
> >
> > Well, at 50 added/changed lines per patch, I've only got ~50 more
> > patches to go for ort after the ones I submitted Monday (mostly
> > optimization related).  If I submit 10 patches per week (starting next
> > week since I already sent a big patchset this week), then maybe
> > mid-to-late February.  That's a more aggressive pace than we've
> > managed so far, but maybe it gets easier towards the end?  Anyway,
> > hopefully that helps you with timing predictions.
> >
> > On my end, this does make the ort work look like there's finally some
> > light at the end of the tunnel; I just hope it's not an oncoming
> > train. :-)
>
> While I expect to have an RFC ready at the end of the month, I expect
> I will be working on sparse-index for the entire 2021 calendar year
> before it will be fully ready to use by end-users. I expect my RFC to
> have fast "git status" and "git add" times, but other commands will
> have a guard that expands a sparse-index into a "full" index before
> proceeding. This protection will keep behavior consistent but will
> cause performance problems. Iteratively removing these guards and
> implementing "sparse-aware" versions of each index operation will take
> time and care.
>
> >> My point in bringing this up is that perhaps we should pause concrete work on
> >> updating other builtins until we have a clearer idea of what a sparse index
> >> could look like and how the implementation would change based on having one
> >> or not. I hope that my RFC will be illuminating in this regard.
> >
> > Are you suggesting to pause any work on those pieces of the proposal
> > that might be affected by your sparse index, or pause any work at all
> > on sparse-checkouts?  For example, I think
> > en/stash-apply-sparse-checkout that's been sitting in seen is good to
> > merge down to master now.  I suspect mt/rm-sparse-checkout WITH my
> > suggested changes (no configurability -- similar to git-add) and a
> > better warning/error message for git-add are some examples of cleanups
> > that could be done before your sparse index, but if you're worried
> > about conflicting I certainly don't want to derail your project.  (I
> > agree that anything with configurability and touching on "behavior A"
> > or "sparse parallelax", like mt/grep-sparse-checkout would be better
> > if we waited on.  I do feel pretty bad for how much we've made Matheus
> > wait on that series, but waiting does still seem best.)
>
> I don't want to hold up valuable work. It's just tricky to navigate
> parallel efforts in the same space. I'm asking for a little more time
> to get my stuff together to see if it would influence your work.
>
> But it is unreasonable for me to "squat" on the feature and keep others
> from making valuable improvements.

I'm totally willing to hold off on bigger changes, new features, and
anything that requires configurability.  I'm also willing to hold off
on any bug fixes that I have reason to think might conflict with your
work.

However, I think that several bug fixes would be independent of your
current work.  For example, the already-submitted
en/stash-apply-sparse-checkout from a month ago (which I think should
be merged to master), and fixing up reset --hard.  You know more about
me than your changes, though; do you have reason to think these might
conflict?

> >>>     * shorter flag names than --[no-]restrict-to-sparse.  --dense and
> >>>       --sparse?  --[no-]restrict?
> >>
> >> --full-workdir?
> >
> > Hmm.  "workdir" sounds like an abbreviation of "working directory",
> > which is the place where the files are checked out.  And the working
> > directory is sparse in a sparse-checkout.  So isn't this misleading?
> > Or did you intend for this option to be the name for requesting a
> > sparser set?  (If so, isn't "full" in its name a bit weird?)
> >
> > Also, what would the inverse name of --full-workdir be?  I was looking
> > to add options for both restricting the command to the sparser set and
> > for expanding to the full set of files.  Though I guess as you note
> > below, you perhaps might be in favor of only one of these without
> > configuration options to adjust defaults.
>
> Right. Perhaps --full-tree or --sparse-tree would be better? I was
> trying to link the adjectives "full" and "sparse" to a noun that they
> modify.
>
> --dense already exists in rev-list to describe a form of history
> simplification.

I still think the flag should be a git global flag (like --no-pager,
--work-tree, or --git-dir), not a subcommand flag, so rev-list's
--dense flag isn't a collision even if we pick --dense/--sparse.

--full-tree and --sparse-tree are good considerations though to add to
the list we've come up with so far:
   --{full,sparse}-tree
   --dense/--sparse
   --[no-]restrict
   --[no-]restrict-to-sparse-paths

> >>> --> Commands that would change for behavior A
> >>>   * bisect
> >>>     * Only consider commits touching paths matching sparsity patterns
> >>>   * diff
> >>>     * When given revisions, only show subset of files matching sparsity
> >>>       patterns.  If pathspecs are given, intersect them with sparsity
> >>>       patterns.
> >>>   * log
> >>>     * Only consider commits touching at least one path matching sparsity
> >>>       patterns.  If pathspecs are given, paths must match both the
> >>>       pathspecs and the sparsity patterns in order to be considered
> >>>       relevant and be shown.
> >>>   * gitk
> >>>     * See log
> >>>   * shortlog
> >>>     * See log
> >>>   * grep
> >>>     * See mt/grep-sparse-checkout; it's been discussed in detail..and is
> >>>       implemented.  (Other than that we don't want behavior A to be the
> >>>       default when so many commands do not support it yet.)
> >>>
> >>>   * show-branch
> >>>     * See log
> >>>   * whatchanged
> >>>     * See log
> >>>   * show (at least for commits)
> >>>     * See diff
> >>>
> >>>   * blame
> >>>     * With -C or -C -C, only detect lines moved/copied from files that match
> >>>       the sparsity paths.
> >>>   * annotate
> >>>     * See blame.
> >>
> >> this "behavior A" idea is the one I'm most skeptical about. Creating a
> >> way to opt-in to a sparse definition might be nice. It might be nice to
> >> run "git log --simplify-sparse" to see the simplified history when only
> >> caring about commits that changed according to the current sparse-checkout
> >> definitions. Expand that more when asking for diffs as part of that log,
> >> and the way we specify the option becomes tricky.
> >
> > --simplify-sparse is a really long name to need to specify at every
> > invocation.  Also, if we have --[no]-restrict or --sparse/--dense
> > options at the git level (rather than the subcommand level), then I
> > think we don't want extra ones like this at the subcommand level.
> >
> > Also, if the option appears at the global git level, doesn't that
> > remove the trickiness of revision traversal vs. diff outputting in
> > commands like log?  It just automatically applies to both.  (The only
> > trickiness would be if you wanted to somehow apply sparsity patterns
> > to just revision traversal or just diff outputting but not to both,
> > but that's already tricky in log with explicit pathspecs and we've
> > traditionally had files restrict both.)
> >
> >> But I also want to avoid doing this as a default or even behind a config
> >> setting. We already get enough complains about "missing commits" when
> >> someone does a bad merge so "git log -- file" simplifies away a commit
> >> that exists in the full history. Imagine someone saying "on my machine,
> >> 'git log' shows the commit, but my colleague can't see it!" I would really
> >> like to avoid adding to that confusion if possible.
> >
> > That's a good point.  A really good point.  Maybe we do only want to
> > allow explicit requests for this behavior -- and thus need very short
> > option name for it.
>
> And even though I mentioned earlier that "having a sparse-index might
> be a good way to opt-in," I would still say that simplifying commit
> history in 'git log' or reducing diff output would still require a
> short command-line option.
>
> > Here's a not-even-half-baked idea for thought: What if we allowed a
> > configuration option to control this, BUT whenever a command like
> > diff/grep/log restricts output based on the sparsity paths due solely
> > to the configuration option, it prints a small reminder on stderr at
> > the beginning of the output (e.g. "Note: output limited to sparsity
> > paths, as per sparse.restrictCmds setting")?
>
> I'm not thrilled with this idea, but perhaps the warning can be
> toggled by an advice.* config option.

You've noted multiple times that you're leery of even providing such a
configuration option -- and you provided good rationale to be worried
about it.  So, if we did use this escape hatch to make it sane to
allow such a configuration option, I'd say this is probably one case
where we do not allow this advice to be turned off.  (In fact, we'd
not only avoid implementing it, we'd be careful to document that it's
intentionally not implemented so that someone doesn't come along later
and assume we just overlooked it.)

But that's still an 'if' and is just an idea I threw out there for us
to consider over the next year or two; we may well require the short
command-line option every time as you say.

> >>> --> Commands whose behavior I'm still uncertain of:
> >>>   * worktree add
> >>>     * for behavior A (marrying sparse-checkout with partial clone), we
> >>>       should almost certainly copy sparsity paths from the previous
> >>>       worktree (we either have to do that or have some kind of
> >>>       specify-at-clone-time default set of sparsity paths)
> >>>     * for behavior B, we may also want to copy sparsity paths from the
> >>>       previous worktree (much like a new command line shell will copy
> >>>       $PWD from the previous one), but it's less clear.  Should it?
> >>
> >> I think 'git worktree add' should at minimum continue using a sparse-
> >> checkout if the current working directory has one. Worktrees are a
> >> great way to scale the creation of multiple working directories for
> >> the same repository without re-cloning all of the history. In a partial
> >> clone case, it's really important that we don't explode the workdir in
> >> the new worktree (or even download all those blobs).
> >
> > Okay, sounds like you agree with me for the partial clone case -- it's
> > necessary.
> >
> > But what about the non-partial clone case?  I think it should adopt
> > the sparsity in that case too, but Junio has objected in the past.
> > I'm pretty sure Junio wasn't thinking about the partial clone case,
> > where I think it seems obvious and compelling.  But I'm not sure how
> > best to convince him in the non-partial clone case (or maybe I already
> > did; he didn't respond further after his initial objection).
>
> We might want to consider certain behavior to be on by default when
> enough other optional features are enabled. A philosophy such as "We
> see you are using partial clone and sparse-checkout, so we restricted
> the search in 'git grep' for your own good" might be useful here.

You're dodging the question.  ;-)  We already agree on the behavior
for sparse-checkouts with worktrees when partial clones are in effect;
it seems obvious any newly added worktree needs to also be sparse in
such a case.  The whole question was what about the non-partial-clone
case.  I'm of the opinion that it makes sense there too (if for no
other reason than making it easy to explain and understand what
worktree does without having to provide a list of cases to users), but
was curious if others had thoughts on the matter.  Maybe you don't
care since you always use partial clones?

> >> Thanks for starting the discussion. Perhaps more will pick it up as
> >> they return from the holiday break.
> >
> > Thanks for jumping in and pushing it much further with sparse indices
> > (or is it sparse indexes?)  I'm excited.
>
> Another way to push this discussion further would be to create a
> forward-looking documentation file in Documentation/technical.
> We could use such a documentation as a place to organize thoughts
> and plans, especially things like:
>
> * How sparse-checkout works and why users need it.
> * How it works (and doesn't work) with partial clone.
> * Plans for modifying behavior in sparse scenarios:
>   - Current behavior that is wrong or suspicious.
>   - Commands that could have different default behavior.
>   - Commands that could have different opt-in behavior.
>   (This section would include a description of the planned flag
>    that modifies behavior to limit to the sparse set.)
>
> I would add a section about sparse-index into such a document, if it
> existed.
>
> As things get implemented, these items could be moved out of the
> technical documentation and into Documentation/git-sparse-checkout.txt
> so we have a central place for users to discover how sparse-checkout
> can change their behavior.

Yeah, good idea.  This thread has a lot of that information, so I'd be
happy to start up such a document after I both hear back from Matheus
and hear back from you on my rm & grep bug fix ideas.
