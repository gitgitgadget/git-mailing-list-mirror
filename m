Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D863645
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741847395; cv=none; b=UUlu2dEoIFBh/2VY9B4ZLjEwnKkn83yRMxFRZfTnIy7aLBkh5+Dhs+Z6tY8HlfCKLyZ6e9J6RLmefyu1JRXCWilIPErUF/jsgYYYNeT2OUafPR2yktt1lidZcawuCfI2qW9jn69ql0pzvoHGGzK1/gORAkvroRNe/b7QOAprpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741847395; c=relaxed/simple;
	bh=074/tP6XyBu9W8tkenfpreMZiWYrRyPX7srm1QTfkno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9ObQxwC7+EHdr7VuaKn1kzui7XiPbJXch1xmAhHIfdW04nkMWRaCuUExMDWum19Xxsyl6xPUGpuF247dPv/UnKoG1Wx2IBzfGVhuWlDWyEV7rexzV1j3JepLOkCIbNQfohMro49330/xrKW+xeo2ngWkv5spIcsocKYM/3dVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Q6zMbdnK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Q6zMbdnK"
Received: (qmail 21407 invoked by uid 109); 13 Mar 2025 06:29:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=074/tP6XyBu9W8tkenfpreMZiWYrRyPX7srm1QTfkno=; b=Q6zMbdnK3Rq2RwHIz6Ob7NcQTzrRcAfO4yKFT2vcWYr+HBh+cwCn7m1QIWMmCOV7Fl8oftjxvHCJI6ZnJFSRfQk+JkKCq4/q/5cXg7+yqWlXQuDmDB4xHeDnoLMmJKmCKLrWTQHM+d1GSWGN0Yy/kObo+QvoR7fub58DVAWfY0CwReG75+0z5rPapdchhhrnFLmcv3CxO8juoJoPRg9fvDoGYXQa302PkLWd+D82OJuZt57TAKgqSXF16rYBCPZVrOXYwznYDjG5e1FErxRYxudZd7wg7iFk+2+3Aj3QrhDSlwSyvhnmOppcBpWvE2Y0hI2hNaG9rIEEmBs1fSVMCw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Mar 2025 06:29:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12294 invoked by uid 111); 13 Mar 2025 06:29:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Mar 2025 02:29:51 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Mar 2025 02:29:51 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/6] pack-objects: freshen objects with multi-cruft
 packs
Message-ID: <20250313062951.GA96035@coredump.intra.peff.net>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741648467.git.me@ttaylorr.com>
 <xmqqr0332un3.fsf@gitster.g>
 <Z9GpQqm4YBvWF7Ff@nand.local>
 <xmqqfrjixfwe.fsf@gitster.g>
 <Z9Ha2mFXpojI+aIR@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9Ha2mFXpojI+aIR@nand.local>

On Wed, Mar 12, 2025 at 03:04:58PM -0400, Taylor Blau wrote:

> > > I think this is similar to the discussion earlier in the thread, but let
> > > me know if there is something here I'm missing.
> >
> > I think the only thing you are missing is that max specified is the
> > ceiling, and "you can bust it, hoping by a little but you do not
> > know how huge the error is" is unacceptable.
> 
> I agree that in the general case it is unacceptable. I think I might see
> it slightly different than you, since for cruft packs the idea is to
> bound the working set of what you're repacking using the size of the
> resulting packs as a proxy for the former.
> 
> Maybe we should call the option something else that makes the cruft pack
> use-case clearer. But in the other thread I came around to the idea that
> this case is too niche to address completely, so I think we can discard
> this round as a terrible idea.

Having read through the thread, I think the naming is really the issue.
Elijah's earlier response was the most clear to me: the new feature is
not a max size at all, but a --combine-cruft-below-size. Our goal is not
to have small packs, but to avoid rewriting bytes over and over again
(which would happen if we simply rolled all cruft packs into one on each
repack). But also to avoid having a zillion cruft packs (which would
happen if we never rolled them up).

So I think all of the discussion about "would we bust the max limit" is
mostly a red herring.

But also, I think there is no need to tell pack-objects to limit the
size of the resulting cruft pack at all. Let's say you have three cruft
packs with sizes 30MB, 20MB, and 10MB. I want to roll up so that each
cruft pack is at least 40MB. We could say (and this is what I think
your series does, based on our earlier off-list discussions, but please
correct me if things have changed):

  1. All of those are candidates for rolling up, because they're below
     our threshold.

  2. We'll feed the packs along with the "max" size to pack-objects,
     which will then roll it all up into a 40MB pack, plus a 20MB pack
     left over. We'll have written all of the bytes once, but on the
     next repack we'd only rewrite 20MB (plus whatever new cruft comes
     along).

But do we actually care about eventually having a series of 40MB packs?
Or do we care about having some cutoff so that we don't rewrite those
first 40MB on subsequent repacks?

If the latter, then for step 2, what if we don't feed a max size? We'd
end up with one 60MB pack (again, having written all of the bytes once).
And on the next repack we'd leave it be (since it's over the threshold).
We'll start forming new packs, which will eventually aggregate to 40MB
(or possibly larger).

If I understand the main purpose of the series, it is that we must
rescue objects out of cruft packs if they became fresher (by having
loose copies made). But that is orthogonal to max pack sizes, isn't it?
We just need for pack-objects to be fed those objects (which should be
happening already) and decide _not_ to omit them based on their presence
in the kept cruft packs (based on the mtime in those cruft packs, of
course). Which looks like what your want_cruft_object_mtime() is doing.

-Peff
