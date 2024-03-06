Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ABA1FA4
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709758842; cv=none; b=I7gMap89v5Xp4ViLsXZhFL/I8mEST4Q7sDIOYBV3O4pwtd8xWNjCSd2YyKTBVLfXnSfCXyaU/tE1jGqMY0DpMJXmOp7Chc2f6FXk6BIiL1Q4vKiXetDoc6mlJ+Wi/3neqJxjyyezr/uhKRthHKpcCYQP62EATejvrSJ+X0iP+B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709758842; c=relaxed/simple;
	bh=s9TjvLKzzD6+7RKEbrb5Tm3DQw81WCkQ8hOZokWpz4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o71EA0ug4qWbu9y4m64rVg/JNc3OY/S8OmLzzDF99Grr1ktjlQGAhELqpaW199ht0yUmvjNOFVTXWrOWuBp/LU+qQYiwhJQzLGf2Dg1CcUMJ8oeGQryGD22g8aFApmHMlumeY0cIyH7Ioy27BXbqfeUUCi9rUDyeXERnZkU2CRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=eWjZo6y0; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="eWjZo6y0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1709758830;
	bh=Eax/aCJa4entJiJLgtet884RJvUrbsZ3CtxmAnijhYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eWjZo6y0C3ERQ5JIIH+uEkXBFK5siVH4Jph4ZN1DCKQ7u7serGK/4m6csWEUqceqn
	 M6N1u1+OcEkTIulG7xhPBBkclIhha0T3CBBe3Un5xvzbeGpVWKdINZ2AS67hJvlEgn
	 EOEFU32I5HbsPH77bDSpHFgL6Mlz7YyRLSrFQa6orvMvHxaveKhasNTSNvch5j0xGK
	 p/9MpCpVrVLM/VNJbq2SHvs2Wa/n+nHvdCC1bBMfhL/iavTvBp1Oe2+7/tX3Y81xOi
	 n4zAE6DuD9zuGu/n85rPNi7mWnSrc+kMMeI+ZRBL8QJJU3NLWAlgV5P+j/Vp9KL/Mu
	 qsz8zuEB0GloQ==
Received: from [192.168.42.22] (56-97-142-46.pool.kielnet.net [46.142.97.56])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 180E13C1BC0;
	Wed,  6 Mar 2024 22:00:30 +0100 (CET)
Message-ID: <845ced9a-1f35-4100-a1ff-4243db2ba34f@haller-berlin.de>
Date: Wed, 6 Mar 2024 22:00:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
Content-Language: de-DE, en-US
To: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Christian Couder <christian.couder@gmail.com>
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
 <354f9fed-567f-42c8-9da9-148a5e223022@haller-berlin.de>
 <xmqqsf144pi7.fsf@gitster.g>
 <CABPp-BGO2ftEMHJDrf6yg3J4AfpKn=rpf_5Wt_WAS+Hi70KqPQ@mail.gmail.com>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <CABPp-BGO2ftEMHJDrf6yg3J4AfpKn=rpf_5Wt_WAS+Hi70KqPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ++

On 06.03.24 03:57, Elijah Newren wrote:

> 1) What if there is a branch that is "just a copy" of one of the
> branches earlier in the "stack"?  Since it's "just a copy", shouldn't
> it be excluded for similar reasons to what you are arguing?  And, if
> so, which branch is the copy?

This is a good point, but in my experience it's a lot more rare. Maybe
I'm looking at all this just from my own experience, and there might be
other usecases that are very different from mine, but as far as I am
concerned, copies of branches are not long-lived. There is no point in
having two branches point at the same commit. When I create a copy of a
branch, I do that only to rebase the copy somewhere else _immediately_,
leaving the original branch where it was. Which means that I encounter
copied branches only at the top of the stack, not in the middle. Which
means that I'm fine with keeping the current behavior of "rebase
--update-ref" to update both copies of that middle-of-the-stack branch,
because it never happens in practice for me.

> 2) Further, a "stack", to me at least, suggests a linear history
> without branching (i.e. each commit has at most one parent _and_ at
> most one child among the commits in the stack).  I designed `git
> replay` to handle diverging histories (i.e. rebasing multiple branches
> that _might_ share a subset of common history but none necessarily
> need to fully contain the others, though perhaps the branches do share
> some other contained branches), and I want it to handle replaying
> merges as well.  While `git rebase --update-refs` is absolutely
> limited to "stacks", and thus your argument might make sense in the
> context of `git rebase`, since you are bringing `git replay` into the
> mix, it needs to apply beyond a stack of commits.  It's not clear to
> me how to genericize your suggestions to handle cases other than a
> simple stack of commits, though.

I don't see a contradiction here. I don't tend to do this in practice,
but I can totally imagine a tree of stacked branches that share some
common base branches in the beginning and then diverge into different
branches from there. It's true that "rebase --update-refs", when told to
rebase one of the leaf branches, will destroy this tree because it pulls
the base branches away from under the other leaf branches, but this is
unrelated to my proposal, it has this problem today already. And it's
awesome that git replay has a way to avoid this by rebasing the whole
tree at once, keeping everything intact. Still, I don't see what's bad
about excluding branches that point at the same commits as the leaf
branches it is told to rebase when using "replay --contains". (I suppose
what I'm suggesting is to treat "--contains" to mean "is included in the
half-open interval from base to tip" of the revision range you are
rebasing, rather than the closed interval.)

Maybe I should make this more explicit again: I'm not trying to solve
the problem of making a copy of a stack of branches, and rebasing that
copy somewhere else. I think this can't be solved except by making
branch stacks a new concept in git, which I'm not sure we want to do.

> 3) This is mostly covered in (1) and (2), but to be explicit: `git
> replay` is completely against the HEAD-is-special assumptions that are
> pervasive within `git rebase`, and your problem is entirely phrased as
> HEAD-is-special due to your call out of "the current branch".  Is your
> argument limited to such special cases?  (If so, it might still be
> valid for `git rebase`, of course.)

No, I don't think I need HEAD to be special. "The thing that I'm
rebasing" is special, and it is always HEAD for git rebase, but it can
be something else for replay.

> 4a) `git replay` does what Junio suggests naturally, since it doesn't
> update the refs but instead gives commands which can be fed to `git
> update-ref --stdin`.  Thus, users can inspect the output of `git
> replay` and only perform the updates they want (by feeding a subset of
> the lines to update-ref --stdin).

At this point I probably need to explain that I'm rarely using the
command line. I'm a user and co-maintainer of lazygit, and I want to
make lazygit work in such a way that "it does the right thing" in as
many cases as possible.

> 4b) For `git replay`, --contained is just syntactic sugar -- it isn't
> necessary.  git replay will allow you to list multiple branches that
> you want replayed, so you can specify which branches are relevant to
> you.

That's great, even if it means that I have to redo some of the work that
--contains would already do for me, just because I want a slightly
different behavior.

> 4c) For `git rebase --update-refs`, you can add `--interactive` and
> then delete the `update-ref` line(s) corresponding to the refs you
> don't want updated.

Yes, that's what I always do today to work around the problem. It's just
easy to forget, and I find it annoying that I have to take this extra
step every time.

One last remark: whenever I describe my use case involving copies of
branches, people tell me not to do that, use detached heads instead, or
other ways to achieve what I want. But then I don't understand why my
proposal would make a difference for them. If you don't use copied
branches, then why do you care whether "rebase --update-refs" or "replay
--contained" moves those copies or not? I still haven't heard a good
argument for why the current behavior is desirable, except for the one
example of a degenerate stack that Phillip Wood described in [1].

-Stefan


[1] <https://public-inbox.org/git/
     98548a5b-7d30-543b-b943-fd48d8926a33@gmail.com/>
