Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C533B28D
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238893; cv=none; b=hOJ+hcf5Mv3e/hAzdOST27POW9SfoozsptLxEwwFpYWIpEhKfhLUbp125y7C6fnmKuL4PtOHSSsK4k6dgHfoX4iFwV6QTjaYhj3AeRdirdlrWoYKXM3er4b0bTVBafP/53upL+AC0HeM+y3XIY2LM3/0T90LZxORvV6+3kDBLl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238893; c=relaxed/simple;
	bh=arRwZqNMFit63f+TmSeD+dg6z4cM2DMzKdBN+tMtD78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEi9rKenxF9bwQ2I4ag3Y6AY30fte38OTY89/c07dpN1YFZc94sCADlIF42mwFYBuGeD0AKrRhASb8qZ7MQLRKWumaJCA8pGCgeiuA1R3xbQf/PRHllhAOUefwUrO0WTByO/bImQbHweuEfIpqfnGcBqGfMvFXoUkDHCPhRIJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BYx14879; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BYx14879"
Received: (qmail 6893 invoked by uid 106); 1 Sep 2026 05:01:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=arRwZqNMFit63f+TmSeD+dg6z4cM2DMzKdBN+tMtD78=; b=BYx14879BVoqEZZVCWsfiBs+cspn+awxSfBAzTzXO7pTVyXuiCf1Id5feUYmlD4mOzFD985Utb9Wfyg3M24sW0RW5WMmh0tctwaegI4Dj66HGlr2BuGJjHt/pybqZnVDiGTQcsBk933JbEalyvEKLQennGUllSl1EChWjeZAzWlPSTQLBDJjAavha0S8zz5zITN5/Z5SUuCbcASo1q42f3R1SuxP/QCja5E2grhuyuyff/dN2BewgK/rldlbzcPUvaJceoBgy45zVhUaWoWkjQkCR3BlQlmOqa8G6MVKd8LDOqS8JEtPfw0ULDHugsaKIIa+5rq2ziuPbOonPwgs/g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2026 05:01:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 33139 invoked by uid 111); 1 Sep 2026 05:01:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2026 01:01:30 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Sep 2026 01:01:29 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com,
	Taylor Blau <ttaylorr@openai.com>
Subject: Re: [PATCH v2 0/7] trace2: stop allowing die()
Message-ID: <20260901050129.GB1075462@coredump.intra.peff.net>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
 <20260827052318.GC176544@coredump.intra.peff.net>
 <a41bdb3b-1fe7-4c1e-9d16-72390d93503b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a41bdb3b-1fe7-4c1e-9d16-72390d93503b@gmail.com>

On Mon, Aug 31, 2026 at 09:27:49AM -0400, Derrick Stolee wrote:

> > OK. This feels like the tip of the iceberg, though. All of strbuf would
> > have to be off-limits, too (both because it calls malloc directly, but
> > also because it will bail if snprintf() returns -1). I won't be
> > surprised if there are other indirect calls hiding in various places
> > (e.g., all of json-writer.c).
> 
> You're absolutely right. Not only in json-writer.c, but several direct
> calls to the strbuf API. The only real way to fix that would be to
> create a "safe strbuf" library. This is potentially an interesting
> direction that I might want to pursue and send an RFC after getting
> started.

Yes, though at some point the strbuf abstractions don't necessarily make
sense, and you want to surface "did we truncate" or "did this result
fit" to the caller.

So you probably end up with a whole new string interface (hopefully much
more stripped down than what strbuf needs).

> > I think if you really want to avoid allocations in trace2 it would
> > probably need to be a ground-up no-dependency rewrite.
> 
> Or to update the dependencies to be "safe". Not an easy thing, either
> way.

Yes. My thinking is that by the time you've pruned the dependencies,
you've essentially done that rewrite. So maybe it is all just a matter
of perspective. One man's refactor is another's rewrite, or something. :)

> I don't have much knowledge of CodeQL, but the following vibe-coded
> .ql script is able to detect these transitive calls and demonstrate
> the issue:

Yeah, I think the whack-a-mole can be solved with static analysis that
actually understands the complete (possible) call tree. And then you
wouldn't even really need your banned-die.h, because you'd have the real
thing.

There's probably still a lot of work in rewriting the code to avoid
those dependencies, though. And I fear you may hit some part that really
needs to call into generic Git code in order to get an answer, which
will be hard to pull apart. But maybe not; in theory we are feeding data
into trace2, and it never really "asks" the rest of Git anything
substantial.

-Peff
