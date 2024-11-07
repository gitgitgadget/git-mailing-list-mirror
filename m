Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144FA179A3
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943565; cv=none; b=jbXYUj3A/NoMMQN+KvBvG1s6wUw/rQ69j4YSmFMxBj4O9iMDTbgDSBvn8SynhEowhIpCxLNV5L5t1cM0Gzg1h0knP/S2MnIO9BkTtPKFCEQTCcuoC3bxnflgBLWRWuVJT09BRklMmv3ddrJ+s/4TKIYLONEFVNRgCnN4Gur5YfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943565; c=relaxed/simple;
	bh=G0YKMY0qlwQAX3UKHxD8dagKTK1MlDTf7KMTmIKw98E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZ8Ro0AQ+a+7/vB0g83V7iu49e2rsbVps6AensgPy9YpV0NUtyLH96OY+SyeoxoKkh6NAHl8T+RwtVxdRuuJ6i+gkpFatOZFXO7JAiDr3Sme27LJY5tyk4WHncvAR+MraAftK/pYp6Af1n8UU1RoHD4isGGrUcXWIQPNa/K/8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=edWF+b/E; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="edWF+b/E"
Received: (qmail 17370 invoked by uid 109); 7 Nov 2024 01:39:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=G0YKMY0qlwQAX3UKHxD8dagKTK1MlDTf7KMTmIKw98E=; b=edWF+b/EXfBjr/r/sQnxn5BBLnO/ssgvEUEBGsQBWayb3K7DGhYR9LYHW0ot+Ld5WwIAExtsKZ+/7umWoTACL5wy5S4Nyq715KyEz0LEZaOR8sKc1q7DhBRKlfZknb0zn2Xff3nAAqab1VA7YZgQNK+mFx9vm8vAKmf31SgkTL7E9F4mYszoRlINhIcAyCAaXJiFzwL76uH+m+N8+z5MT9UZRCW75fvwGHGin5qxoNbOKGgGn5ucmMfl87sHKLwT5OgYAvEPNVCS296ib16Fkk03aTemGwctAdBfnZML3w4CBNov4bys/FAv6Q+BiceXCdk6t/b6WG36rFKpxGqvQw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Nov 2024 01:39:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10201 invoked by uid 111); 7 Nov 2024 01:39:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2024 20:39:16 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Nov 2024 20:39:15 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] t/helper/test-sha1: prepare for an unsafe mode
Message-ID: <20241107013915.GA961214@coredump.intra.peff.net>
References: <cover.1730833506.git.me@ttaylorr.com>
 <0e2fcee6894b7b16136ff09a69f199bea9f8c882.1730833507.git.me@ttaylorr.com>
 <xmqqcyj9qgyf.fsf@gitster.g>
 <ZywOWn08cGBnBWM-@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZywOWn08cGBnBWM-@tapette.crustytoothpaste.net>

On Thu, Nov 07, 2024 at 12:48:26AM +0000, brian m. carlson wrote:

> > I would have expected that there are different algorighm instances,
> > and one of them would be "unsafe SHA-1", among "normal SHA-1" and
> > "SHA-256" (as the last one would not even have unsafe_init_fn
> > method), and the callers that want to measure the performance of
> > each algorithm would simply pick one of these instances and go
> > through the usual "init", "update", "final" flow, regardless of the
> > "unsafe" ness of the algorithm.
> [...]
> > ... I didn't expect any of these "if (unsafe) .. else .." switches.
> 
> I don't think we can remove those, and here's why.  Certainly Taylor can
> correct me if I'm off base, though.
> 
> In the normal case, our hash struct is a union, and different
> implementations can have a different layout.  A SHA-1 implementation
> will usually keep track of a 64-bit size, 5 32-bit words, and up to 64
> bytes of data that might need to be processed.  Maybe SHA-1-DC, our safe
> implementation, stores the size first, but our unsafe implementation
> is OpenSSL and it stores the 5 hash words first, or whatever.
> 
> If we use the same update and final functions, we'll end up with
> incorrect data because we'll have initialized the union contents with
> data for one implementation but are trying to update or finalize it with
> different data, which in the very best case will just produce broken
> results, and might just cause a segfault (if one of the implementations
> stores a pointer instead of storing the data in the union).

I don't think Junio is proposing mixing the functions on a single data
type. Which, as you note, would be a disaster. I think the idea is for a
separate git_hash_algo struct entirely, that can be slotted in as a
pointer (since git_hash_algo is already essentially a virtual type).

That gets weird as you say here:

> We could certainly adopt a different hash algorithm structure for safe
> and unsafe code, but we have a lot of places that assume that there's
> just one structure per algorithm.  It would require a substantial amount
> of refactoring to remove those assumptions and deal with the fact that
> we now have two SHA-1 implementations.  It would also be tricky to deal
> with the fact that for SHA-1, we might use the safe or unsafe algorithm,
> but for SHA-256, there's only one algorithm structure and we need to use
> it for both.

both because we have two different algos for "sha1", but also because
they are not _really_ independent. If the_hash_algo is sha1, then
whichever implementation a given piece of code is using, it must still
be one of the sha1 variants.

So I think you wouldn't want to allocate an enum or a slot in the
hash_algos array, because it is not really an independent algorithm.
But I think it _could_ work as a separate struct that the caller derives
from the main hash algorithm. For example, imagine that the
git_hash_algo struct didn't have unsafe_init_fn, etc, but instead had:

  struct git_hash_algo *unsafe_implementation;

with a matching accessor like:

  struct git_hash_algo *unsafe_hash_algo(struct git_hash_algo *algo)
  {
	/* if we have a faster "unsafe" implementation, use that */
	if (algo->unsafe_implementation)
		return algo->unsafe_implementation;
	/* otherwise just use the default one */
	return algo;
  }

And then csum-file.c, rather than calling:

  the_hash_algo->unsafe_init_fn(...);
  ...
  the_hash_algo->unsafe_final_fn(...);

would do this:

  struct git_hash_algo *algo = unsafe_hash_algo(the_hash_algo);
  algo->init_fn(...);
  ...
  algo->final_fn(...);

And likewise this test helper would have a single conditional at the
start:

  if (unsafe)
	algo = unsafe_hash_algo(algo);

and the rest of the code would just use that.

All that said, I do not think it buys us anything for "real" code. There
the decision between safe/unsafe is in the context of how we are using
it, and not based on some conditional. So while the code in this test
helper is ugly, I don't think we'd ever write anything like that for
real. So it may not be worth the effort to refactor into a more virtual
object-oriented way.

-Peff
