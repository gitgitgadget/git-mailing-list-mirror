Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1781D3A785D
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951023; cv=none; b=GsbQOfemNdMDhkP4XgQ/yfKoTx+hPqS2mz+noAtFetKzXtsMeTjbL1u+ishFJst+EduSb0m7YMXGn5IGowdUw2doqS4IwSbgzQi4JPxkrNSHksjGv04kMcO2fR5idDIRnVBZ25fTLzVnDnMP0aUg6iL0D462Uc3Bb/47HJ6Ge8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951023; c=relaxed/simple;
	bh=snfGb9NXjQrBMKcyejPjG8b3Rj0VMAg1j0TiAP6j7JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EltILibvcXMKQyah2MTHt+ly0ETYrIQDNNTznQ1CCLFf/sgsm/msIoD2wAnfj+WIJiKuLhXXvfGV7mKb84LUHqYDv9vHLJ6hief29Gy1vggN27PFJWeFmZNkjT/5+JqFXmsBpa7RXAJQtk7Jfq3dqQhBW2k30tIFfjf8ibaFT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=doF1Svo6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ErRfdbS5; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="doF1Svo6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ErRfdbS5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4CA9BEC0087;
	Mon, 17 Aug 2026 03:17:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 17 Aug 2026 03:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786951020; x=1787037420; bh=fTIK5LnA72
	VEWQyizBe2SFrAymYCcAmMKJ81NKd6ddE=; b=doF1Svo6I4OI3LMOz1QAhaRyTG
	Mf2nuKlLOswAC7i0bZ4NV9VcNRt4sg87YhmFhVErB5l4FfwNjaeSwNSO0mX5WCSa
	vwrNPQZlGE4ybD9f/d0ANqkqbpFXx7jrxyNQ1+IK7auUuRP+BBqgX7twZwDwWyN2
	LKEBm+gDrcZoilwVHRY0ydHoOgAU1cPglV/RRmkHXk+m3K4p+Rz6FsJM9Z9UEVTA
	cK/SHJ0cfxKWmSOwbRiXYzozyk5yfZLBv3GtHCz0fC9U0DLd9UitXeBfZ5col7Lr
	ahiebm6MwVAuvOXYLP387yFfSY9RYXwpbICa0HNkMZ4wdWO6s7ZWZbLqwFtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786951020; x=1787037420; bh=fTIK5LnA72VEWQyizBe2SFrAymYCcAmMKJ8
	1NKd6ddE=; b=ErRfdbS5kwzDw1PZcqWez6dn/1FFSDj+AlAwHftp5i4j/NB/l1T
	RA3+CveLV6Wc4gVWsrp1lI3EIYfGQ89J+3b8Jgv0YgOKFDXi3ylhf1oxs1DRb3fz
	zueucWuF1xoCvyCvJ7O+b9zjuQDI0tpwyArOuzJzEZ1yvh9ZNBAygHVtuW6STKCP
	YPFaZPSSHEJiLqUz9z1cG0eJEolapBBJGToBAOmUnsXwNg7svG2mqCEQPCyOd8wo
	S5ioWyOvHT1TTLrYjsp40pdoHR/USInxwLCPsuSAN7QU4M1FRBxPnKJw3cnyn1Ci
	S84KP/tgr3Q0bVgEmxzxAvE8jta31pXTRlw==
X-ME-Sender: <xms:bLWCasfA-ENpHdawfIvpz3Xk2TWfEctYAvZe8tiIPisi0uEe1Mfayw>
    <xme:bLWCalrWYmkHPGjE_MMPj5TJThhKrByQ1LAodzz_1UODHNtu4gv6aekt8Lx1ofbNr
    ZlxBbhTmVEJVgGiBwlM82hYXE_H1tMiC5BsyVc0cRPzXx5UNw-O-us>
X-ME-Received: <xmr:bLWCaq4oIIc8MsbOMt--XdnVMpIgNUj9_z0ZCtgZuUcPECr-dNS23BIIUfJoe1SR6aVJAZAJs0nRMRW7oMzf2czpCiudwfRHhBI4n1XzuA>
X-ME-Proxy-Cause: dmFkZTFJzhLa9iwtfhXzQQ4Hu6Z9RdNvF+H3pOgzkTN71Hp2MGa7IXuOVE7KRIMELTcr29
    aKVeTNL0mdK79y2GU0HaGyAF8MJAbR969dJBlbTLYJI9kVNVAfA9SoITLGuBaUurCWguPJ
    g1HMGZlj+MMxkLjkosr/W1MXzDHa+LhRR6FMH0vaesombbcIUJhqgstKoI+CldeyJbZvcW
    2KTncpJDhw6r8atKM+XS90Gop/+RKnZg8oLDMtrySzFZW33gTEtxtDHe/eOnt1ch23lHnQ
    qC68LZqZnpQboetZpQz6mCEK964yV3WGG9S4bNSud0FTp81AVvBNLdHk1G9X3GdLbS5gqr
    1XWfZdsjBwkY1JkDhsXrVbu6U7nCtczT27p+Omr7pNuoJnukRhas+dRbgduAvPdhmbepMp
    OxpPBTQ3QfQCLWerjfMNogMAvq6o27gz+iQdKYx/y7BguGb0AJ4LUdOQSrfk0rcnrXXmFj
    4DYO9Wz/D885GNd5fJs1j14FQdvEtkNaGAvwNZwJlDyqlemrMfWHmByh/qT/gD3dca2bZN
    GhkXzneRZ7BVjpW7z0Q3LF8QZtKBokH0iIgme+cXpdxcBLA/tUd5jae9121OXyHeY9BN2V
    nvMYC6pnoOMBHW9+SrRV2wkrE90O7/f0kwXgfvXgJNIMveUW28wn/yIewSGA
X-ME-Proxy: <xmx:bLWCaropcLom_umfc8BPkK0Ehk3N82hTzAe16XqKpKiFRYSetH52dA>
    <xmx:bLWCashbGFX6vhlG2Coglc1-97UDemXvxA6g4E6mYUKD-ctgvL_Xng>
    <xmx:bLWCalJFxjQetnLx7TyBcfGsNSHguULUyGaZVudBODDFd_znQ1p-CA>
    <xmx:bLWCasA5Hgxs1yLeZor4jzMxDqeWozgU-Q6y4IuYmzcDjSomhlKpUw>
    <xmx:bLWCalU6zpKaTkyKO6DV2ZO8YStACnjboZn1h3epfyid6uPdns7FRPRy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 03:16:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c40aa0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 07:16:56 +0000 (UTC)
Date: Mon, 17 Aug 2026 09:16:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/4] odb: decouple source path comparisons from
 `the_repository`
Message-ID: <aoK1ZYfqh5PnNin6@pks.im>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
 <20260814171724.GB2563235@coredump.intra.peff.net>
 <aoKeeQMps50rjhWi@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoKeeQMps50rjhWi@pks.im>

On Mon, Aug 17, 2026 at 07:39:05AM +0200, Patrick Steinhardt wrote:
> On Fri, Aug 14, 2026 at 01:17:24PM -0400, Jeff King wrote:
> > On Wed, Aug 12, 2026 at 11:13:57AM +0200, Patrick Steinhardt wrote:
> > 
> > > When registering alternates we deduplicate object database sources by
> > > their path so that the same source won't be added twice. Ever since
> > > cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
> > > this duplicate check is backed by a map keyed by the source's path,
> > > using `fspathhash()` and `fspatheq()` as hash and equality functions,
> > > respectively.
> > > 
> > > These functions are problematic in this context for two reasons:
> > > 
> > >   - They implicitly depend on `the_repository` instead of the
> > >     repository that owns the object database.
> > 
> > I'm not even sure that using core.ignorecase here is strictly correct.
> > It is a property of the containing repository, and the filesystem in
> > which it's stored. But there is no guarantee that the alternate
> > directories are in the same repository, or even the same filesystem!
> > 
> > So it is really just a best guess proxy for "this system tends to use or
> > not use case insensitive filesystems[1]". It can be wrong in both
> > directions (failing to suppress duplicates, and suppressing them when
> > they are not actually duplicates).
> > 
> > I wonder how bad it would be if we just always did case-sensitive
> > comparisons and made it the caller's responsibility to spell things
> > consistently.  I guess some names ultimately come from things like
> > "--reference" command-line arguments, so that would depend on user
> > spelling. But having duplicates at all is kind of unlikely (you can't
> > get it from one --reference clone, but rather a complex tree of
> > interwoven repos with shared roots).
> > 
> > How bad is a duplicate alternate? It's a minor performance issue, I'd
> > think. We would add its packs to the list (though hardly ever look
> > through them, as the "first" copy would satisfy most requests, and the
> > unused second copies end up at the back of the MRU list). You'd only pay
> > the extra lookup cost for an object which we fail to find entirely,
> > which is rare-ish (mostly speculative lookups for fetches).
> 
> A performance regression is definitely the most likely change in
> behaviour we might see because of this. One other part I am a bit
> worried about is housekeeping, but I think we should be fine there as we
> only consider the primary source as special.
> 
> I also had the feeling that case insensitivity is quite a bit lacking,
> too. What we're really after is whether two directories are actually the
> exact same path. And whether the path is case-insensitive is only one
> part of that equation, so it's an imperfect metric by itself already.
> 
> Ideally, we should probably use realpath(3p) to at least also resolve
> symlinks. Unfortunately, it's not guaranteed that this function also
> knows to canonicalize casing.
> 
> > And it would fix the unlikely-but-possible opposite case of suppressing
> > a non-duplicate. If you have a repo on a case-insensitive filesystem
> > with two alternates on a case-sensitive system that differ only in case,
> > we erroneously suppress one of them, and commands may fail to find
> > objects we should have. Of course that's super unlikely, which is why
> > nobody has run into it before.
> > 
> > So I kind of wonder if we could just do away with considering case
> > insensitivity here at all. We'd err on the side of correctness in the
> > ambiguous cases, and this code complexity can just go away.
> 
> You will of course be able to craft edge cases where that would be a
> significant regression. But if your alternates file looks like this you
> may be holding it wrong:
> 
>     /path/to/alternate
>     /PATH/TO/ALTERNATE
>     /pAtH/tO/aLtErNaTe
>     /PaTh/To/AlTeRnAtE
> 
> > Alternatively, I think we could probably make the check more thorough in
> > a similar way. Always consider a pair of case-insensitive matches as
> > possible duplicates, and then for each possible duplicate use stat() to
> > check their st_dev and st_ino values. That keeps things cheap for normal
> > cases, and we pay only the stat() before de-duping. It's correct and
> > doesn't rely on the repo, though it is a bit more somewhat complicated
> > code.
> 
> Hm. Weren't there filesystems where `st_ino` and `st_dev` aren't set at
> all? I think that's the case on Windows, which is unfortunately also the
> one where we see case insensitive filesystems by default. So that makes
> it way less effective, as it only works on systems where we typically
> aren't case-insensitive in the first place (except macOS maybe).
> 
> So if we want to go down this path I'm inclined to just unconditionally
> use case sensitive matching and not introduce any secondary machinery.

Thinking about this a bit more: I'd suggest that we leave this out of
this patch and instead document this as a NEEDSWORK area for now. I
_think_ that this proposed refactoring should be generally fine, and I
quite like the simplification that results from it. But the risk for
regression is quite a bit higher compared to the origanal patch that
I've proposed.

Patrick
