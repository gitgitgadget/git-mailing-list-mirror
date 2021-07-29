Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992F9C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 02:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8246960F12
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 02:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhG2C5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 22:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbhG2C53 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 22:57:29 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A589C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 19:57:26 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so4309174ota.11
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 19:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9D7Uc8HvywhOvdLEStVBfMLvtKzjjdX22awACdxRcw=;
        b=U6/q+3pBiLff+JEms/7INJVd9FzZ2odT9nnWTuvAQahyAqv2QqiLxeXLvbsLKoXRJ5
         /ZMrIg19ilFFGb5aXbkbl3w7pAx6vZFqubbPPOaDZYhPlvjcaJhS2Jz09sXp57NgPvpL
         t7LbjeAStwyMFvCP9ci/bd9ejjIzXco4JuGqTwF4zJyLr00oFNqQwk+4sFWJGXRj7WYl
         /w/gFemXbElYFW/qOBEr2jqcz/eLixvJC5TdlQKjTCyiIrJ5cxfw7Z4CHN/WKOEqov+H
         WN55eCd22EyvMNcL9GqZuUjLKTi1XqHSu9lvVNknTnnFH9Av8VRZUHsMGifbuJnoWg5S
         krHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9D7Uc8HvywhOvdLEStVBfMLvtKzjjdX22awACdxRcw=;
        b=NGNtx2VFTkxmQa4UNJq3zhwPR84/8/fbS8CxQhQHCLulqWZG3uwtC3DRrCeauOvSi3
         DttVY232m6olcAaEo4bdWX2hTTj9yjM7cb0qV1INmY99LtrM0lQK7IQ7DskSC5M5o8Jx
         gKfN7f8Lo7n2q6Kq4xuSGKjUgJMr5V/5ZQ2PTojQ3sx8tvkfPQmcWERQFLjRqu0cJ+Or
         +kr5AaEZ1km5YwLSh2v1kFRO0k2+SCVpFZEjKcAw+ERWXeHTCr8a8t3k1HJtAWqxc05t
         lmkgxuahLajvwjrRmHa37Wgb0WAORUDWMjTsnfCqIXL6aSVX1+4JIbPyOaUJ9UxeMmpj
         Ec2A==
X-Gm-Message-State: AOAM530Pq3VLB/vdh0uWwLOO4msxiL7w7VmrgCW/vhhJVxW249uZq2au
        M/RgpG4BRmOrWySlNIatpYWkcxg/UO1l5P5jqmg=
X-Google-Smtp-Source: ABdhPJyhnpjvddYvJInsb3d6p6GKdATIdVnciCJ8WnvCfiOmDkVY2lAc3inY06+5sAtZENk0Lw1BWWYXAvFBhgNH6Ts=
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr1981371ots.162.1627527445658;
 Wed, 28 Jul 2021 19:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
 <pull.999.v2.git.1627312727.gitgitgadget@gmail.com> <CABPp-BHnvEPuYahFAoVSF58k99t__N2-M4OKKHDAAK2qrhY3WQ@mail.gmail.com>
 <6a63736a-feb8-b74b-ef68-73cc71009e1d@gmail.com>
In-Reply-To: <6a63736a-feb8-b74b-ef68-73cc71009e1d@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 28 Jul 2021 20:57:14 -0600
Message-ID: <CABPp-BGUTg=GarkhP0MwjWKWmDyRJiEL2J75wFz52y2xi_50mw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse Index: Integrate with 'git add'
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 28, 2021 at 8:03 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/28/2021 7:13 PM, Elijah Newren wrote:
> > On Mon, Jul 26, 2021 at 9:18 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> ...
> >>  * a full proposal for what to do with "git (add|mv|rm)" and paths outside
> >>    the cone is delayed to another series (with an RFC round) because the
> >>    behavior of the sparse-index matches a full index with sparse-checkout.
> >
> > I think this makes sense.
> >
> > I've read through the patches, and I like this version...with one
> > exception.  Can we mark the test added in patch 1 under
> >
> >      # 3. Rename the file to another sparse filename and
> >      #    accept conflict markers as resolved content.
> >
> > as NEEDSWORK or even MAYNEEDWORK?
>
> I have no objection to adding a blurb such as:
>
>         # NEEDSWORK: allowing adds outside the sparse cone can be
>         # confusingto users, as the file can disappear from the
>         # worktree without warning in later Git commands.
>

Sounds great to me other than the simple typo (s/confusingto/confusing to/)

> And perhaps I'm misunderstanding the situation a bit, but that
> seems to apply not just to this third case, but all of them. I
> don't see why the untracked case is special compared to the
> tracked case. More investigation may be required on my part.

The possible cases for files outside the sparsity patterns are:
  a) untracked
  b) tracked and SKIP_WORKTREE
  c) tracked and !SKIP_WORKTREE (e.g. because merge conflicts)

From the above set, we've been talking about untracked and I think
we're on the same page about those.  Case (b) was already corrected by
Matheus a number of releases back; git-add will throw an error
explaining the situation and prevent the adding.  The error tells the
user to expand their sparsity set to work on those files.  For case
(c), you are right that those are problematic in the same way (they
can disappear later after a git-add)...but we're also in the situation
where the only way to get rid of the conflicting stages is to run git
add.  So, in my mind, case (c) puts us between a rock and a hard
place, and we probably need to allow the git-add.

> >  I'm still quite unconvinced that it
> > is testing for correct behavior, and don't want to paint ourselves
> > into a corner.  In particular, we don't allow folks to "git add
> > $IGNORED_FILE" without a --force override because it's likely to be a
> > mistake.
>
> I agree about ignored files, and that is true whether or not they
> are in the sparse cone.

Yes, and...

> > I think the same logic holds for adding untracked files
> > outside the sparsity cone.

In my opinion, "outside the sparsity cone" is another form of "being
ignored", and in my mind should be treated similarly -- it should
generally require an override to add such files.  (Case (c) possibly
being an exception, though maybe even it shouldn't be.)

> >  But it's actually even worse than that
> > case because there's a secondary level of surprise too: adding files
> > outside the sparsity cone will result in delayed user surprises when
> > the next git command that happens to call unpack_trees() (which are
> > found all over the codebase) removes the file from the working tree.
> > I've had some such reports already.
>
> I believe this is testing a realistic scenario that users are
> hitting in the wild today. I would believe that users succeed with
> these commands more often than they are confused by the file
> disappearing from the worktree in a later Git command, so having
> this sequence of events be documented as a potential use case has
> some value.
>
> I simultaneously don't think it is behavior we want to commit to
> as a contract for all future Git versions, but there is value in
> showing how this situation changes with any future meddling. In
> particular: will users be able to self-discover the "new" way of
> doing things?

Oh, I totally agree that documenting how things work definitely has
value.  I've added several test_expect_failure cases and whatnot to
the testsuite.  But there's a big difference between documenting how
things work and documenting how we expect them to work.  If the two
differ, then any good provided by documenting how things work with a
test marked as test_expect_success may be counterbalanced or even
overwhelmed by the harm it also causes, particularly in areas where
working around backward compatibility constraints are more difficult.

For example, not that long ago, it seemed people agreed (even Junio)
that commit hooks were never intended to be part of rebase (they
aren't part of the apply backend, and were only part of the
merge/interactive backend due to historical accident) and could be
removed (being replaced by just a rebase hook called at the end of the
rebase instead of with every commit).  There were user complaints
about the commit hooks being triggered when the default backend
switched, backing up the expectation.  But no one jumped in to fix it
at the time.  Then when it was brought up again recently, Junio said
we couldn't just remove those because of backward compatibility.
That's forcing me to consider suggesting a bunch of new arguments to
rebase to let users get unbroken when they discover they need it, or
maybe even a new toplevel command because we painted ourselves into a
corner (there are more backward compatibility corners in rebase
too...).

Trying to get out of a corner we paint ourselves into with
sparse-checkout would be massively harder, which is why I keep harping
on this kind of thing.  I'm very concerned it's happening even despite
my numerous comments and worries about it.

> The proposal part of changing how add/mv/rm behave in these cases
> would need to adjust this test with something that would also help
> direct users to a helpful resolution. For example, the first run
> of
>
>         git add sparse/dir/file
>
> could error out with an error message saying "The pathspec is
> outside of your sparse cone, so staging the file might lead to
> a staged change that is removed from your working directory."

Yes, much like we currently do with tracked files which are SKIP_WORKTREE.

> But we should _also_ include two strategies for getting out of
> this state:
>
> 1. Adjust your sparse-checkout definition so this file is in scope.
>
> -or- (and this is the part that would be new)
>
> 2. If you understand the risks of staging a file outside the sparse
>    cone, then run 'git add --sparse sparse/dir/file'.
>
> (Insert whatever option would be appropriate for --sparse here.)
>
> Such a warning message would allow users who follow the steps listed
> in the test to know how to adjust their usage to then get into a
> good state.

Choice 2 doesn't exist yet, but yeah your suggestion makes sense.

> > If that test is marked as NEEDSWORK or even as the correct behavior
> > still being under dispute, then you can happily apply my:
>
> I would classify this as "The test documents current behavior, but
> isn't a contract for future behavior." With a concept such as my
> suggestion above, the test could be modified to check for the
> warning and then run the second command with the extra option and
> complete the test's expectations. Having the existing behavior
> documented in a test helps demonstrate how behavior is changing.
>
> We we've discussed, we want to give such a behavior change the
> right venue for feedback and suggestions for alternate approaches,
> and this series is not the right place for that. Hopefully you
> can tell that it is on my mind and that I want to recommend a
> change in the near future.

I'm totally fine with such changes not being part of this series.  I
just don't want a test_expect_success that checks for behavior that I
consider buggy unless it comes with a disclaimer that it's checking
for existing rather than expected behavior.
