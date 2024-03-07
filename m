Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43880CA6B
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709789825; cv=none; b=QvkzALIobrS3wrOC64i2BmjtxoV1R3epMXIpaKTnciwo3c9Z1hBfteCL2X9bFlNb18STWe46OGgX6n1G51iHbwTDhOCz97EeoASR6GrqhofhEcEOLcvIE5qqudGSLTI3sZyVtpbo12CmQhhUMCpr+evNvIoRSQS9n/P7O2kzVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709789825; c=relaxed/simple;
	bh=eMzW2oSIX4e6otYkVLIbOdHQT76R/J+oE1EF5ewnOxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sofdei6pUQ9KTTYdk0SU+Lga/qLMCrRBgNlyA4Y359F8qtKzUNqZJlrcOMg27w7jOEYsGzR+WVwIBM1jO3o1xClxKVbZ1Ad+Q0XbghK6w6pcNqWSwHvu+EdNt+LaUxgGaCqn0dH8X9i7GCGLBvw1vVUlWtmsfAVwzvksxK6Q5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz1AEb26; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz1AEb26"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51336ab1fb7so618346e87.1
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 21:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709789821; x=1710394621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=244sGWO2om1aRThYU6obwlwFD1xFYCr0+xRa4aAadzA=;
        b=Dz1AEb26dz0ygZDqKUSfygO9o8phvDS94AQZI5EZmiIdVW+TeGP9gL8O0WZrBz35Ql
         11oPO4q0SXxkTsDwWAx3h963aBjl6EopYb+Ijqjx4n3K85InNkELtXWKX/IgJjUH5x2B
         LmTurm192yMRr6MLn4B2EXGJE/nEV6+gZ0ZETE7U2vDlMmSup1iinQpHc9zyOdKHiXPZ
         9fYC40e6U+xCZ6MPIZ+TH4NInXJENvKyD9hXr92yXwgwsREfP4+92/xb3Qh3l1TjQvX8
         XN+R6n/qC6yvIvRQ3JWVSDrq7pd4N6OTr3VbJk7KgSHvxW5ItQqtU2AzMQYTOD6Q2R2G
         NFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709789821; x=1710394621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=244sGWO2om1aRThYU6obwlwFD1xFYCr0+xRa4aAadzA=;
        b=YCgIOZQBnzlOBUYLCSgVwAFoxSCDXz4ZP0Tq7Gi2YTDo6WoWTLxsfXozoksSWhwSQm
         nAPeeN+Sx83bDElDWyPTlYlmqZ+eIpVQv6YK5jTiOlYym2VTHwRNHKy5v4YPKveRGSbH
         9Ta+btTJu2QTzpPPbFoGq29HnWnXgPBMcCThheNVxGs+nbw0xpItd9W4e7uj0UWiGhub
         e+bFrwWCE1qAIZxo4kKCqnM5tOVqDlkDRllJbDqdOkhe8X27QXMTzYaKytYf5dUJOw/e
         F6wuM1IzSSKy/fDknCLVTHEo05Q7Ui2vk4Bq62V4oDlyCEAmSrBzgrorpW72GtQdpqJS
         z7tA==
X-Forwarded-Encrypted: i=1; AJvYcCULy+0auSMNeBOxR4UxPmOgSTeOxzD6VXTd79GVhetC0vH77qjRPQeJkhCaNGECsO9ypTy8myAuAiI/6RG7eYpNY5RP
X-Gm-Message-State: AOJu0YwIBjZaHk6QLEpNkEgFZS2lSb6PV7uHpm9BNA3aE2KAMUPwLkXL
	M2zbnbGJfjFjHW3UFty8OLvFwVM3x7EfXSiuy3kf2Li6aK/mTJK7OHpII5XJirz+3UFIFV0I5Tj
	mXeYCu/BMEC0I4eyOPYgyywopgW8A4piPvQQ=
X-Google-Smtp-Source: AGHT+IED4ZbZTv2Z+kB8fZJQ/D2GMM8bjS3rNWSrSLWESRRdros1DXwMxvwzvwWNFYy64R43W0O2ERQEHJVDtmwADxs=
X-Received: by 2002:ac2:54b5:0:b0:513:55d1:12b0 with SMTP id
 w21-20020ac254b5000000b0051355d112b0mr565101lfk.31.1709789820686; Wed, 06 Mar
 2024 21:37:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
 <354f9fed-567f-42c8-9da9-148a5e223022@haller-berlin.de> <xmqqsf144pi7.fsf@gitster.g>
 <CABPp-BGO2ftEMHJDrf6yg3J4AfpKn=rpf_5Wt_WAS+Hi70KqPQ@mail.gmail.com> <845ced9a-1f35-4100-a1ff-4243db2ba34f@haller-berlin.de>
In-Reply-To: <845ced9a-1f35-4100-a1ff-4243db2ba34f@haller-berlin.de>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 6 Mar 2024 21:36:47 -0800
Message-ID: <CABPp-BE36Zhacdumd1JSc+7NXYpxZ=CQ1=ieebze=mDewpEUGA@mail.gmail.com>
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
To: Stefan Haller <lists@haller-berlin.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Derrick Stolee <derrickstolee@github.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 1:00=E2=80=AFPM Stefan Haller <lists@haller-berlin.d=
e> wrote:
>
> On 06.03.24 03:57, Elijah Newren wrote:
>
> > 1) What if there is a branch that is "just a copy" of one of the
> > branches earlier in the "stack"?  Since it's "just a copy", shouldn't
> > it be excluded for similar reasons to what you are arguing?  And, if
> > so, which branch is the copy?
>
> This is a good point, but in my experience it's a lot more rare. Maybe
> I'm looking at all this just from my own experience, and there might be
> other usecases that are very different from mine, but as far as I am
> concerned, copies of branches are not long-lived.

> There is no point in having two branches point at the same commit.

But isn't that what you're doing?

> When I create a copy of a
> branch, I do that only to rebase the copy somewhere else _immediately_,
> leaving the original branch where it was.

If it is inherently tied like this, why not create the new branch
immediately after the rebase (with active_branch@{1} as the start
point), instead of creating it immediately before?

> Which means that I encounter
> copied branches only at the top of the stack, not in the middle. Which
> means that I'm fine with keeping the current behavior of "rebase
> --update-ref" to update both copies of that middle-of-the-stack branch,
> because it never happens in practice for me.

You've really lost me here; are you saying you're fine changing the
design to add inherent edgecase bugs to the code because those edge
cases "never happen in practice for me"?  I've spent a lot of time
dealing with built up cruft in git from partial solutions and fixes
that overlooked subsets of relevant testcases, so I'm not a fan of
that statement and in particular the last two words of it.  Perhaps
I'm reading it wrong, and if so I apologize, but it triggered unhappy
memories of mine from merge-recursive.c and dir.c and elsewhere.

> > 2) Further, a "stack", to me at least, suggests a linear history
> > without branching (i.e. each commit has at most one parent _and_ at
> > most one child among the commits in the stack).  I designed `git
> > replay` to handle diverging histories (i.e. rebasing multiple branches
> > that _might_ share a subset of common history but none necessarily
> > need to fully contain the others, though perhaps the branches do share
> > some other contained branches), and I want it to handle replaying
> > merges as well.  While `git rebase --update-refs` is absolutely
> > limited to "stacks", and thus your argument might make sense in the
> > context of `git rebase`, since you are bringing `git replay` into the
> > mix, it needs to apply beyond a stack of commits.  It's not clear to
> > me how to genericize your suggestions to handle cases other than a
> > simple stack of commits, though.
>
> I don't see a contradiction here. I don't tend to do this in practice,
> but I can totally imagine a tree of stacked branches that share some
> common base branches in the beginning and then diverge into different
> branches from there. It's true that "rebase --update-refs", when told to
> rebase one of the leaf branches, will destroy this tree because it pulls
> the base branches away from under the other leaf branches, but this is
> unrelated to my proposal, it has this problem today already. And it's
> awesome that git replay has a way to avoid this by rebasing the whole
> tree at once, keeping everything intact. Still, I don't see what's bad
> about excluding branches that point at the same commits as the leaf
> branches it is told to rebase when using "replay --contains".

By "leaf branches", do you mean (a) those commits explicitly mentioned
on the command line for being replayed, (b) only the subset of the
branches mentioned on the command line which aren't an ancestor of
another commit being replayed, or (c) something else?

> (I suppose
> what I'm suggesting is to treat "--contains" to mean "is included in the
> half-open interval from base to tip" of the revision range you are
> rebasing, rather than the closed interval.)

"half-open interval"?  That to me again implies a simple stack, which
since we're trying to address the more general case, makes me more
confused rather than less.

Let me re-ask my question another way.  If someone runs
    git replay --onto A --contained ^B ^C D E F
when branches G, H, & I are in the revision range of "^B ^C D E F",
with G in particular pointing where D does and H pointing where E
does, and E contains D in its history, and F contains commits that are
in neither D nor E, how do I figure out which of D-I should be
updated?

> Maybe I should make this more explicit again: I'm not trying to solve
> the problem of making a copy of a stack of branches, and rebasing that
> copy somewhere else. I think this can't be solved except by making
> branch stacks a new concept in git, which I'm not sure we want to do.

Oh, I hadn't even thought of that.  Yeah, that'd be even more complex.

> > 3) This is mostly covered in (1) and (2), but to be explicit: `git
> > replay` is completely against the HEAD-is-special assumptions that are
> > pervasive within `git rebase`, and your problem is entirely phrased as
> > HEAD-is-special due to your call out of "the current branch".  Is your
> > argument limited to such special cases?  (If so, it might still be
> > valid for `git rebase`, of course.)
>
> No, I don't think I need HEAD to be special. "The thing that I'm
> rebasing" is special, and it is always HEAD for git rebase, but it can
> be something else for replay.

But what exactly should that something else be?  I still don't
understand what that is from your explanation so far.

> > 4a) `git replay` does what Junio suggests naturally, since it doesn't
> > update the refs but instead gives commands which can be fed to `git
> > update-ref --stdin`.  Thus, users can inspect the output of `git
> > replay` and only perform the updates they want (by feeding a subset of
> > the lines to update-ref --stdin).
>
> At this point I probably need to explain that I'm rarely using the
> command line. I'm a user and co-maintainer of lazygit, and I want to
> make lazygit work in such a way that "it does the right thing" in as
> many cases as possible.

...and I'm pointing out that `git replay` has the necessary tools to
enable you to do so.  Unlike `git rebase --update-refs` it doesn't
automatically update the branches, but just creates the new commits
and tells you what it could update each branch to, in a format that
you can pass along to another tool to actually do the updates of the
branches.  As such, you can write your tool to take that output, pick
out the bits you like, and only pass those bits along so that only
some of the branches are updated.

> > 4b) For `git replay`, --contained is just syntactic sugar -- it isn't
> > necessary.  git replay will allow you to list multiple branches that
> > you want replayed, so you can specify which branches are relevant to
> > you.
>
> That's great, even if it means that I have to redo some of the work that
> --contains would already do for me, just because I want a slightly
> different behavior.

Right, but I thought you were maintaining lazygit, meaning that
programming it to select the branches you want is a one time cost?

Something like `git log --format=3D%D --decorate-refs=3Drefs/heads/
${base}..HEAD^1 | grep -v ^$`, plus adding in the current branch,
right?

Or is the concern with this suggestion the performance hit you'd take
(which admittedly might be a problem with this solution, since you
walk the commits an extra time)?

> > 4c) For `git rebase --update-refs`, you can add `--interactive` and
> > then delete the `update-ref` line(s) corresponding to the refs you
> > don't want updated.
>
> Yes, that's what I always do today to work around the problem. It's just
> easy to forget, and I find it annoying that I have to take this extra
> step every time.

And if you forget, then after the rebase it's trivial to move the
updated branch back to where you want it, right?

   git branch -f ${copy_branch_name} ${current_branch_name}@{1}

In fact, that's probably easier than making the rebase interactive,
and should be easier to remember since you only ever create these
branches precisely when you want to do a rebase.

> One last remark: whenever I describe my use case involving copies of
> branches, people tell me not to do that, use detached heads instead, or
> other ways to achieve what I want. But then I don't understand why my
> proposal would make a difference for them. If you don't use copied
> branches, then why do you care whether "rebase --update-refs" or "replay
> --contained" moves those copies or not? I still haven't heard a good
> argument for why the current behavior is desirable, except for the one
> example of a degenerate stack that Phillip Wood described in [1].

The current behavior is easy to describe and explain to users, and
generalizes nicely to cases of replaying multiple diverging and
converging branches.

To me, the behavior you're proposing doesn't seem to share either of
those qualities, at least not as you've explained it so far.

But, perhaps that's because I still don't really understand your
usecase.  I'm trying to, and it's possible I could be convinced there
is a proposal here that is easy to explain to users and generalizes
nicely.  My way of attempting to get that out is to make
counter-proposals and ask questions as a way of teasing out what your
usecase is and what a refined proposal might be.  Currently, it seems
there are two trivial alternative solutions that would solve this
problem more cleanly (namely, either creating the branch after the
fact instead of beforehand, or simply updating the branch after the
fact)...but maybe I'm still just missing something?
