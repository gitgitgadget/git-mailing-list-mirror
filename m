Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86C5192B60
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664368; cv=none; b=PBDhayGeNb7kOE7zrRyVGle5g3y6+eAlBKutcMjMXV3XlIXPq+1/HiPAnTSFJ8GrD/HFqIBldfYN0aK/mb2aHBd7duQfGwybfyfjyvzeDqEN9ojmHSrKLIxZo64G4mYgr1VKFAclT3WroeyFvcDnE8cpVhNsppSiR/zVmxIV2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664368; c=relaxed/simple;
	bh=f+ZZi+0CJ/IRslHYv9wbAGx/CJEUEzFOtJjDZ5hTGZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaBqFB0yi/v6nxZ4TD3rM5OhRvykVWFxOaUwS0gqDaOQvYJ6WQHAorpPMDMl32gTj+bbm1wOzR+jjrSr8MVyt47UdoFsPYWFnHVZ2jOeGASjbZNA35fV2kp7YW375YJe1t0sPMtnrkJN57bCXH17FiKCjcrh8ckIDAaXOAERaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KGKipyTa; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KGKipyTa"
Received: (qmail 14738 invoked by uid 109); 15 Nov 2024 09:52:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=f+ZZi+0CJ/IRslHYv9wbAGx/CJEUEzFOtJjDZ5hTGZU=; b=KGKipyTaFeue1LhCftiODC9IvvlePIrejfOEHf4zvWu549SdQQTUwe357O11WElQBvtYKAB1p5DqeSWnLBYi7iSKxtTNhZeWuJgCpxK5VEEl3+LXEAHI0FVtnxTlCspXvFTYZ0l2QcylSgPCgvx2w2w67WQ29RJSTqBn7BS5hjsfNCzrJO4qOzU/cK445h4nyW7Hauul6i19D9zHshLOS4CDvk0d6mpyhbbIXy2fSss7vEH31RXr0MKBwrLsZI3tO+YhOkap/kLedlcLw3A9x8TQ4pjb83cO/5QEJiuWpOcVFfg1LFi+hHhP7KH7pzK2HCQVmkaTSJScFmOXFrhkIw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Nov 2024 09:52:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6877 invoked by uid 111); 15 Nov 2024 09:52:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Nov 2024 04:52:49 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 15 Nov 2024 04:52:44 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
	steadmon@google.com, hanyang.tony@bytedance.com, me@ttaylorr.com
Subject: Re: [PATCH v2 3/4] t5300: move --window clamp test next to unclamped
Message-ID: <20241115095244.GC1749331@coredump.intra.peff.net>
References: <20241113073500.GA587228@coredump.intra.peff.net>
 <20241113182656.2135341-1-jonathantanmy@google.com>
 <20241114005652.GC1140565@coredump.intra.peff.net>
 <xmqqiksq71x7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqiksq71x7.fsf@gitster.g>

On Thu, Nov 14, 2024 at 03:41:08PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> As far as I know, index-pack, when run as part of fetch, indexes a pack
> >> that's not in the repository's object store; it indexes a packfile in a
> >> temp directory. (So I don't think this is a strange thing to do.)
> >
> > When fetching (or receiving a push), we use "index-pack --stdin" and do
> > write the resulting pack into the repository (and the command will
> > complain if there is no repository).
> > ...
> >> We definitely should prevent the segfault, but I think that's better
> >> done by making --promisor only work if we run index-pack from within a
> >> repo. I don't think we can restrict the repacking to run only if we're
> >> indexing a pack within the repo, because in our fetch case, we're
> >> indexing a new pack - not one within the repo.
> >
> > I think the "--stdin" thing above neatly solves this.
> [...]
> 
> Tying this extra processing to the use of "--stdin" is not exactly
> intuitive, in that a "--stdin" user is not necessarily doing a fetch
> (even though a fetch may always use "--stdin"), but I guess it is a
> good enough approximation (and the best one easily available to us)
> if we want to safeguard the use of this "--promisor" logic only to
> fetch client.

I think the "--stdin" thing is a bit more general than that. Even though
we expect to use it with --promisor only under fetch, the real rule is
more like: only do the extra --promisor repacking when indexing a pack
that will be made available in the repository. With --stdin, we know
the result will be available because index-pack itself will write the
pack into the repository. And that is true whether it is fetch, push, or
some other script driving it.

When being fed a path to a pack on the command line, then "is it
available in the repo" would involve some path comparisons to see if
it's in the object database directory. Probably not that hard, but not
entirely trivial (due to normalization, etc). But since we care only
about fetch and --stdin, it seemed like an easy cheat to simply disallow
the other case for now, erring on the conservative side.

-Peff
