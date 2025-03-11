Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66435258
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741659056; cv=none; b=K+RDacSt9KScs8P00J6ezPzhEq27wjhRnS42MQ1RxktnbvoE023sLVl2Duu68MsSPJzLCHr4PuCPRd1rc63+5pv4YiaadFKvlI0/uC3M/Wgf9NYSCueBz56xAhnTkSPd3X3HhBFEKGy6NoJ/gGmQyiWfYyWwKrUceSKorOVCfYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741659056; c=relaxed/simple;
	bh=5QPKpfoqUEPJNXTEVil3ANAgBvD/c8KFVLX53k/vadA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7/0BZ638iNercabuTgY7HgjLiZwuuKqFcrxR4R5kj6SVw6MlprRyLms7KVAI5dkNgUMsEaqydsMkurD9nLNEptt2e34BnXztKTrCyjW2dTgXa566Ptj6GleOZu03jNzoKWX8AI0Tcau22dQrseCQ2HidBlv3295sDL6wU097Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Wh9ng+Vr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Wh9ng+Vr"
Received: (qmail 27586 invoked by uid 109); 11 Mar 2025 02:10:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5QPKpfoqUEPJNXTEVil3ANAgBvD/c8KFVLX53k/vadA=; b=Wh9ng+VrZAIIRZUDrbeLuW5lszeHgdgp3VHoXTjfFafGObps7c0SAc/P7JkXsGzGFgleuVOLr/M0uzpMeDSqNFmGKz/yYuV1aYCa8MxpkkXa/s2Q3JldwRQdcb2U7FNVcgHjO5eqpoDkyxYH7zC8wMB/JzHG4W9RmB46BoQCd9TDG5PF8sGoYPMHZL+CsZITw8ESqtBB291sMM2FJ/YDltMv4GG7iWOTuQ4NW7ge2HTpRQc5eAo2L80EAFNJORawznQN/Wax9MzxxAy1FQSh8+RgNnjvus306gKyg4i1LzrCz72FMnEL4D3R2vZDEkhCzwRlYSafImnCUivwFMoBkg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Mar 2025 02:10:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3914 invoked by uid 111); 11 Mar 2025 02:10:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Mar 2025 22:10:50 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 10 Mar 2025 22:10:49 -0400
From: Jeff King <peff@peff.net>
To: Benjamin Woodruff <github@benjam.info>
Cc: Junio C Hamano <gitster@pobox.com>,
	Benjamin Woodruff via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/2] describe and diff: implement --no-optional-locks
Message-ID: <20250311021049.GA33498@coredump.intra.peff.net>
References: <pull.1872.git.1741240685.gitgitgadget@gmail.com>
 <xmqqo6yejg0y.fsf@gitster.g>
 <20250309033908.GA2361799@coredump.intra.peff.net>
 <xmqqwmcx9io3.fsf@gitster.g>
 <20250310160837.GA26308@coredump.intra.peff.net>
 <xmqqo6y87m4d.fsf@gitster.g>
 <bbc8a0ef-737c-44ba-9786-f5456f5ce71b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbc8a0ef-737c-44ba-9786-f5456f5ce71b@app.fastmail.com>

On Mon, Mar 10, 2025 at 01:50:36PM -0700, Benjamin Woodruff wrote:

> It might help if I start with some more context of why I wrote this
> patch. We've got a tool that uses the Rust `vergen-gitcl` crate to call
> `git describe --dirty`. You can see that code here:
> https://github.com/vercel/next.js/pull/76889/files
> 
> We use `vergen-gitcl` to generate version identifiers for an on-disk
> cache. This cache stores results of thousands of functions and has no
> backwards compatibility. We want to invalidate it when *any* of the code
> changes. `git-describe` felt like a good fit for that, as it gives us a
> unique identifier that's still reasonably user-friendly.
> 
> However, we discovered that we'd frequently end up with stale git
> lockfiles. This appeared to be due some combination of IDE tools that
> run the build in the background (i.e. the rust-analyzer LSP), behavior
> that causes builds to sometimes get killed before completion, and the
> fact that `git describe --dirty` takes a lock.

Yeah, that is not quite the original use case that --no-optional-locks
was designed for (i.e., simultaneous contention), but I think it is a
reasonable application of the flag.

> >>> git describe and git diff may update the index in the background for
> >>> similar performance reasons to git-status.
> >>
> >> That is a wrong reasoning that is completely opposite, though.
> >> 
> >> The commands at the Porcelain level, like "status" and "diff",
> >> refresh the index for the CORRECTNESS purposes.
> >
> > Right, but "status" supports --no-optional-locks already.
> 
> Does this mean the documentation in `git-status` is incorrect? It
> implies that the background refresh is only for performance reasons.
> That's where I got this idea from:
> <https://git-scm.com/docs/git-status#_background_refresh>

I think Junio gave an explanation here, so I won't repeat that. But I
also think both of us may have been a bit confused about the changes
your patches are making, because there's some subtlety.

The important thing to keep in mind is that there are _two_ steps:
refreshing the in-core index and writing the result out to the on-disk
file. With --no-optional-locks we must continue to do the first step
(for correctness), and skip the second step.

So looking at your patch 1/2 for git-describe, it is doing the right
thing: we still call refresh_index() always, and only skip the calls to
repo_hold_locked_index() and repo_update_index_if_able().

But one thing that puzzles me is that we read and refresh the index
first and only _then_ take a lock. Which seems wrong to me, as we could
racily overwrite an intermediate write from somebody else that we never
even saw (e.g., imagine you call "git add" at just the wrong moment).

That is not a bug in your code, but an existing problem that I think
made it harder to understand your change (and probably one we should
fix regardless).

Your patch 2/2 for git-diff is what I thought was actually wrong, but
after digging further, I'm not so sure.

In your patch we return early from refresh_index_quietly(), without
actually refreshing the in-core index. So I _thought_ that meant we'd
produce a wrong answer for something like this:

  $ touch git.c
  $ ./git --no-optional-locks diff

where we should report "no changes", but would instead find the
stat-dirty git.c (just like a plumbing "git diff-files" would). But
that doesn't happen!

That's because refresh_index_quietly() runs after the diff has completed
anyway. The real magic is in diffcore_skip_stat_unmatch(), which
processes individual stat-dirty entries and suppresses them (when
there's no actual content change).

So the call in refresh_index_quietly() really is just about updating
what we're about to write out, and your patch is correct to bail from
the whole function (if we are not writing it out, there is no purpose in
refreshing at that point).

So as far as I can tell the patches are doing the right thing. But I
think the commit messages probably need to describe those subtleties and
argue that the change is correct. Bonus points if a preparatory patch
fixes the race in git-describe. ;)

> It's also worth noting that libgit2 does not do this background refresh
> by default (`GIT_DIFF_UPDATE_INDEX` and `GIT_STATUS_OPT_UPDATE_INDEX`).
> I think that makes sense for libgit2's typical use-cases, but it is a
> divergence in behavior.

Yes, I think that is probably a reasonable default for libgit2, where
you'd expect everything to happen in a single process (that can share
the in-core index).

-Peff
