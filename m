Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28C611F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 00:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbeKSK6t (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 05:58:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42094 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeKSK6t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 05:58:49 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so16477403lfh.9
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 16:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0G8bl6Wer4m/38HoTV28noAY9/87z0do1bgPPnlelZw=;
        b=AJCXvuvFYZMAFN+4E3rtsVbqz08M645gDg4Jge4Os9Y+NwHX1p5f4llcAPspj8w9Bq
         dD++xAVOLByE9m54ZCZyEvPlwfhkBCZCcAL/QgEjbmMJqELmuvweCMb1xMVnMX3iIiL9
         cs8TTyTAfA+azznqfZX039Z9VMMjEkiVw5DZqcOqU/WNN5VdjqMvOAVvTETcnEptC2dd
         ieXKfjM1R+UV3W3czd2CIwVKo+K1zINgmEFBi+EAxHQGJ90/+u6eJFVlG7Z4ZaZ2kbTN
         3OJK+hthnoXhiriigtXA2gpweZ/Qz/I1AYlmy1PgR6sFi5onmSHRPreIixE8k2DDEGV6
         erNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0G8bl6Wer4m/38HoTV28noAY9/87z0do1bgPPnlelZw=;
        b=CS/0XoMOQYBhJmcJEIS1gtKxEqciJqbsV5Qfwc/oKTCcWa6XgyfVJjOnFmgX5vTKQd
         XDUmle425dZAteMkJwoz4sK5vWSLkGDo8NH60KsG0B/jnSiKFpc82b1usirJCLTCdXgW
         UV5CUTAS5IOSYmN59XkxCgWgqFxdQkvxJfYC7qtQVzIhRylk3vGRv2Z55hU0trwwhEHY
         bOnMBgQxQ5M1vc4QhiCD0RHmYy4D8SHa1mYyx/sa5FQavXLqln4Bkt4C9ykqXSteDYYI
         om4CTShAKiE+czszVsF6PvcZgTfPsJXzn+M8adZWlvDltxDwJngPt1ypPtPvmmYueS49
         QpHQ==
X-Gm-Message-State: AGRZ1gKJ7thVJvf/+8CXBrDy0zbIFBRzbXCxuWeJYqMAMy1rEtfRYs/O
        P00SxMjX41+oZCf7Cwhelt5Hbe7GSLoN9hVQeNAcNQ==
X-Google-Smtp-Source: AJdET5ezyX4ITABbcSgmd0ysO5ZDucGK1yXwYznOunuJuoXlCN1/LApAu6HmQM+8PWzyu2Lf6moBaPWEOiQJaX3UK9s=
X-Received: by 2002:a19:ca51:: with SMTP id h17mr9039625lfj.126.1542587815596;
 Sun, 18 Nov 2018 16:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20181115005546.212538-1-sxenos@google.com> <xmqqd0r4i29w.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0r4i29w.fsf@gitster-ct.c.googlers.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Sun, 18 Nov 2018 16:36:43 -0800
Message-ID: <CAPL8Zisv-Q04Y_jQzMN7G9fG9rkWwxh4travnSw6cG0ZUFivkA@mail.gmail.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Am I correct to understand that the reason why a commit object is
> (ab|re)used to represent a meta-commit is because by doing so we
> would get connectivity (i.e. fetching & pushing would transfer all
> the associated objects along) for free, and by not representing it
> as a new and different object type, existing implementations can
> just pass them along without understanding what they are, and as
> long as these are not mixed as parts of the main history of the
> project (e.g. when enumerating commits that has aa7ce5 as its
> parents, because somebody else obsoleted aa7ce5 and you want to
> evolve anything that built on it, you do not want to mistake the
> above "meta" commit as a commit that is part of the ordinary history
> and rebuild on top of the new version of aa7ce5, which would lead to
> a disaster), everything would work just fine?

Yes, sir. That's it exactly. My first draft of the proposal suggested
creating a new top-level object type, but when I started digging
through the code I realized that the new object was so similar to a
commit that there was no need for a new type.

> Perhaps you'd use something like "presence of parent-type header
> marks that a commit is a meta-commit and not part of the main
> history".

Yes, that's called out explicitly as part of the proposal (see the
first sentence in the Parent-type subsection). Fsck would enforce this
invariant.

> How are these meta commits anchored so that it won't be reclaimed by
> repack?

They would either be anchored by a ref in the metas/ namespace (for
active changes currently under consideration by evolve) or by the
reflog (for recently deleted changes).

> I do not see any "parent" field used to chain them together,

They point to one another using the usual "parent" field present in
all commit objects. For an example of what the raw struct would look
like with parent pointers, see the top of the "Detailed design"
section or search the doc for the string <example_meta_commit>. For
examples of how the metacommits in a change graph would be connected
after various operations, see the "Commit" section and the "Merge"
section. Please let me know if any of these examples are
insufficiently explained or if there's any other examples you'd like
to see.

> but I do not think we can afford to spend one ref per meta
> commit, as refs are not designed to point into each and every object
> in the repository.

Agreed. This is actually one of the reasons I'm proposing the use of
chains of meta-commits as opposed to using a purely ref-based
approach. I describe several other ref-based approaches in the "Other
options considered" section, and I made essentially the same point
there. We only create refs in the metas/ namespace to point to the
head of each change, and the rest of the commits and metacommits used
by the graph are reached via the parent pointers in the metacommits.

> I have a moderately strong opposition against "origin" thing.  If
> aa7ce555 replaces d664309ee, in order for the tool to be able to
> "evolve" other histories that build on top of d664309ee, it only
> needs the history between aa7ce555 and d664309ee and it would not
> matter how aa7ce555 was built relative to its parent.

I see I haven't justified the "origin" thing well enough. I'll
elaborate in the document, but here's the short version. The "origin"
edges are needed to address several use-cases:

1. Gerrit needs to know about cherry picks.

This is one of the lesser-known things that it uses the change-id
footers for and if we want to be able to eliminate the gerrit
change-id footers we need to record and communicate information about
cherry-picks somehow. This is the main reason for the origin edges -
the early drafts of this proposal didn't have them but it came up when
I asked a kind Gerrit maintainer to whether the proposal would be
sufficient to eliminate gerrit's change-ids. However there may be
alternatives I didn't think of. If we were to omit the origin edges,
can you suggest an alternative way for git to record the fact that one
commit was cherry-picked from another and communicate this fact to
gerrit?

I see that I forgot to call out "replacing gerrit change-ids" as an
explicit goal. I'll add that to the doc.

2. Obsolescence across cherry-picks.

In your example, it *may* actually matter how aa7ce55 was constructed.
One such scenario is what I'm calling obsolescence across
cherry-picks. Let me describe the use-case for it:

Alice creates commit A1.

Bob cherry-picks A1 to another branch, producing B1. At this point,
Bob has a metacommit saying that A1 is the origin of B1.

Alice amends A1, producing A2. She shares this with Bob.

At this point, Bob probably wants to amend B1 to include whatever
bugfix Alice did in A2 since the thing he cherry-picked is now out of
date. That's what the obsolescence across cherry-picks feature does.
If bob runs evolve with this option enabled, the evolve command will
produce B2 by amending B1 with whatever diff Alice did between A1 and
A2... and this only works if we have origin edges. Without the origin
edge, the evolve command wouldn't know that B1 came from the now
out-of-date A1. The commit B2 that results from this would have both
origin and replacement edges. It replaces B1 but it was formed by
cherry-picking A2.

I'm currently unsure if obsolescence across cherry-picks should be on
or off by default. I was thinking of making it off-by-default
initially and then possibly flipping the default after users have a
chance to try it and give feedback.

3. Merge-base.

Origin edges will always point to a better merge base (ancestor for
three-way merges) than the content's parent. For example, consider
doing a cherry-pick followed by a rebase:

$ git checkout -b source
# Stage some stuff
$ git commit -m "A" && git tag A
# Stage some more stuff
$ git commit --amend -m "B" && git tag B
$ git checkout -b dest && git reset --hard HEAD^1
$ git cherry-pick A
$ git checkout source
$ git rebase dest

We cherry-picked an old version of a change, and then rebased a new
version of that same change onto the a branch containing the old one.
With today's code we'd pick A's parent commit as the common ancestor
and the user would have to resolve a bunch of merge conflicts since
both A and B are versions of the same patch and touch a lot of the
same lines. We know that B is the newer version but the merge tool
doesn't know that B is newer than A. If we had origin edges, we would
know that the latest commit on the dest branch was a cherry-pick of A
and would traverse its origin edge before the content edge to look for
ancestors. That would select A as the common ancestor, and since B
applies cleanly on top of A there would be no conflicts and the
automerge would most likely succeed.

Now, this may seem like a crazy thing to do. Why would you rebase two
different versions of the same change on top of one another? This
scenario is likely to crop up when users start using the change graph
to collaborate on the same WIP change. They'll be using rebase, merge,
and cherry-pick to resolve divergence and incorporate changes from
other users... so rebases and cherry-picks of different versions of
the same change would be commonplace.

> The user may
> have typed/developed it from scratch, the user may have borrowed 70%
> of its change from 7e1bbcd while remaining 30% was done from
> scratch, or it was a concatenation of the change made in 7e1bbcd and
> another commit.

I don't think the amount they developed from scratch invalidates any
of the three main use-cases (above). Even if we have no idea how many
manual edits were made, the origin parents would still be useful for
communication with gerrit, locating a better merge base, and giving
the user the option of obsolescence across cherry-picks. The proposal
calls for commands like squash merge to create multiple origin
parents, so concatenations *would* be recorded accurately if there was
ever a reason to treat them differently (I'm not sure any of my 3 main
use-cases need to).

> One half of my point being that we can do _without_ it, and in all
> cases, aa7ce555, if leaving the fact that it was derived from
> 7e1bbcd is so important, can mention that in its log message how it
> relates to the "origin" thing.

Log messages would be sufficient for communicating cherry-picks to the
user, but wouldn't address any of the driving use-cases for origin
parents which require it to be machine-readable.

Now, admittedly the obsolescence-across-cherry-picks and merge-base
use-cases are minor features due to the fact that cherry-picks and
squash merges are themselves uncommon. A lot of users would probably
never notice the difference. However, it would be very disappointing
if gerrit's change-ids needed to stick around just for the sake of
this one missing corner case.

> And the other half is that while I consider the "origin" thing is
> unnecessary for the above reasons, having it means we need to not
> just transfer the history reading to aa7ce555 and d664309ee (which
> are necessary anyway while we have histories to transplant from
> d664309ee to aa7ce555) but also have to pull in the history leading
> to 7e1bbcd and we cannot discard it.

I'll assume that by "history" you're referring to the change graph
(the metacommits) and not the branches (the commits), which would have
no origin edges or connection between replacements.

If the user has kept a change around in their metas namespace, it's an
indication that they (or their collaborators) are still working on it
and want its history to be retained. I don't necessarily see this as a
problem because if collaborators are still editing a change that the
local user cherry-picked, it's plausible that the change may be the
subject of a future obsolescence-over-cherry-pick in which case having
the history around is necessary.

You're right that our default position should be not to retain extra
objects unless there's a compelling reason to do so, and this proposal
should have explained that reason. Now that I've explained the reason
do you still have a strong objection to the "origin" parents, or have
I overlooked a use-case?

  - Stefan
