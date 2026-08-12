Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638E84B04B7
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513487; cv=none; b=Yo7plM/8Mh93E5Dk7qhT9F5xBGt0jdrt5R6+4MS4dyoyfb/EIajm38rsHeXkX4ZoeVLNjxvCBtMbcr76+h2uBgwPH7e6u/5TByEY7yUoVAKegtAGquyE4eECcdmRSvoSGxK5DplTGPP2TuQ1RcZyv+is5w4ZgFZ5Rp8+AGvhTgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513487; c=relaxed/simple;
	bh=uJ22qfLPoTmJrSvPYcUC4vMXvTHcgbODKnYPvzEzyp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCL03sNpVYUOfa4OMIq8nRvHnqfXkvOelR5NL0/BJ07GQquOFQCDdMEGE1T2BGaUz6AuOPAuoa1Xd/Y2ctJF/VT+ypB51Abof8ie9QLf7e2XFOILAxyERhf/OT46zo+pA2X35+k/mvp7kz8z74ZJKvD1NgaxDAF+lJcTrTIq8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GpoYf7Tb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9azx+ZL; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GpoYf7Tb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9azx+ZL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 650FB140004C;
	Wed, 12 Aug 2026 01:44:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 01:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786513485; x=1786599885; bh=ExCOJHTK+x
	DyVKdD8rrhd4eETaw5l8eiHzBKAz1A/v8=; b=GpoYf7TbZh3tPSj6cCC/sLYja3
	Zl7AVVnNBRD+MS3sD+6URw/gCHkHDxqjFhn4IpjFl7VtHY26tYizYEL9LBkWyzhA
	5O+bgvWRkXj8fjLpcvRiqxlkL8o75A+S26PmcwQT9vnrWPeaUwbyh5Q6VRLzeyMn
	ybOoV997CgPgYaR3HwNP8Smwo5BbNhZ0V218JJ2Zd/k0B3vU6Jw9yrp8+bsheSrz
	fiQqHIxQy8SS9o9UPe79XqkwOZoQbB62FVqICT2h1dvzy4u4NtC4NLyrYCpSIfpr
	/boN7Xo6mG+kAhw6JvTpByTFSIvtoq/Bi+7oFi8gcBiyzKMDBwWJu6Zgvd2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786513485; x=1786599885; bh=ExCOJHTK+xDyVKdD8rrhd4eETaw5l8eiHzB
	KAz1A/v8=; b=l9azx+ZLTzxcsb5cLMKqcfAHe7yIq2gXqVAzbxC8SmjeKeUfOSi
	h7L5xyCxrwTafLL8Fgm/1DFyHQIBNo17GJGxNRBcyBkhXbmsl1d92v19zNBe+w9/
	UdtUAWBKWyNcc1zVp6wJwJpqkodRIrKPy3bOVSpgsces6m5FboK33IPQtT+Iw1hU
	MbQrBlny3kDkPJI0G9qsAoDxHSo3Xfp9w0rAic2j5uJ7yfAaB74IaqBfD3xLlX3v
	kWlrLLA2U+En/zefOaiigU4XwZ/SMtrYwrPa9aggcSgAdzTIY9JtIJES0ZYapB+Y
	/T+HhETtmRhQuYlK1t5O0owvQmzUg07OnKA==
X-ME-Sender: <xms:TQh8akKB4YmIUR2Xj5sxDEQhA_dPE3Oc0K43P6MVP3f7_7fVCMEscw>
    <xme:TQh8arlMz2V91IqLPqvncmNe6Wz82txHSwecb75g0S9TRojUN1lNipgSMQtY-zyup
    8lkhvCNKgbXUBFsxG_4X7Qih8YJpted6dFXV1lKmJpZmcN6mnUJsg>
X-ME-Received: <xmr:TQh8aiHpO_WZKvkTLyqFXdUtE-iw58OtQ05x3plSj6kyGqae6uUYG3RDIfiRB97UtJsdVf2pIpQpUmVc4tDmu7z3tdwaCPJbMnlebX0RVA>
X-ME-Proxy-Cause: dmFkZTFWrJzqry5EKpZ2xleEsL0Gcn2PHUZtRotX7iyyotc73B7jT6I/VESenw4R05dLUX
    P18wEsekhAxJQ0gLvx6nQK4sysQ+eu8xWha6gSYPUvuVuDiytq0j/njJylWR9deyL3wN8B
    uT0h/HQkdiKj4omUaWfnqWGzQM0LqwxUp/zyZbZ3SmFyYVWweyf1oxeHWhKJByYBFdnXNg
    vpis957+HjZhDWzBgd5qyCPCObg3mTEVXyE43eJdJ2jxVQFcNsyryqSXZlxM2TyEITYz21
    3YJ2yx5jylVvBUbZTQ5bLcMRRF1ejRouyTTaqMvt/4LYhvl33RePPBglyX7K4EFMZpeAXS
    IAmUYeWhShMEsN2w9tu1I1DVRbjht6K+Hf8GWBvWln7MmIiL5BC6YDSFdo+MCNtdg/sauH
    0agxxxB+dllRjm3298Ra1vQzpaGAfv6kIcnlApoifhmBols0vHYBPm8GooWr36ClWBXKNi
    StmJodRJ7nVttN0JtXPvPS9E5B4EMkYFF8wuAVcmpWCN+HYG7f7kZnkgc0Y7kdf2gu/Nk/
    SWD6JBNN+t7FJYGh2UVMte5gW+sOMDr7yw6ulELgCnwrMm9ORWAZIlJBvionYEHsBmuVVf
    oto+32d6dz/K6PtWQVdeYbxB/9rKNVAg8iUkxf8wwY64QS1yHQO04UamAeLQ
X-ME-Proxy: <xmx:TQh8arFsLK-NjHIauVj4HEWMYPb17SXXrwQbxdYZjgJMTGY8ijS6Nw>
    <xmx:TQh8avPIHptG0nTaYcf_g4m3XVCrJEPS9ZaA0uDA1mDj6Upw2DFQsg>
    <xmx:TQh8aqFiO7nuaG39iLpZHAACNeOqfdprv77DxtTOorbqW4ieuEoW3g>
    <xmx:TQh8amOuJDEg2A44SBOWhGultoDRoxi7ZWy8XSyiqzYzOH8vkvLokg>
    <xmx:TQh8akTHnCWXmtwdA6q6GkxmKCQpKUxRWigWrIEXC515tWtgxJXOOZGm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 01:44:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 41696b06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 05:44:42 +0000 (UTC)
Date: Wed, 12 Aug 2026 07:44:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>
Subject: Re: [PATCH] odb/files: be less aggressive with geometric repacking
Message-ID: <anwIRuuaYG3AgG1m@pks.im>
References: <20260811-pks-geometric-maintenance-reduce-frequency-v1-1-7a54c42355ac@pks.im>
 <anuFzZluJEU21MB0@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anuFzZluJEU21MB0@denethor>

On Tue, Aug 11, 2026 at 03:44:12PM -0500, Justin Tobler wrote:
> On 26/08/11 11:04AM, Patrick Steinhardt wrote:
> > When performing auto-maintenance with geometric repacking we have two
> > conditions that may trigger a repack:
> > 
> >   - Either the geometric sequence of packfiles is invalidated.
> > 
> >   - Or we have too many loose objects.
> > 
> > The first condition shouldn't trigger all that often: it may be hit when
> > we fetch a new packfile, but users tend to not do that all the time. The
> > second condition is what typically triggers more regularly though, as
> > every command that ends up writing new objects may cause us to cross the
> > threshold of loose objects. It is thus preferable to not be too
> > aggressive here, as otherwise we may end up repacking objects quite
> > often.
> > 
> > For the geometric-repacking strategy though we have a default of 100
> > objects, only. As we're approximating the count of objects by only
> > reading the "objects/17/" shared, we'd only need 2 objects in there
> > before we perform a repack by default, which is quite aggressive.
> > git-gc(1) on the other hand has a default of 6700, so it is quite a bit
> > more conservative here.
> 
> Ok IIUC, the reason two loose objects can potentially trigger repacking
> is because the heuristic used to estimate the number of loose objects
> only counts objects in "objects/17/" and multiples it by 256 (the
> maximum number of directories that are fanned-out). That makes sense and
> indeed seems like it could lead to repacking processes be spawned more
> frequently than desired.
> 
> My first thought is whether the heuristic itself should be updated to
> capture a more accurate estimate for the number of objects. That would
> of course require looking up more objects and thus be more expensive. If
> the goal here is just for a very rough estimate anyways, maybe it
> wouldn't be worth it though.

That wouldn't really solve the problem though. The problem is not really
that the estimation can be wrong, it's rather that even if it was always
correct we're still being too aggressive with packing the loose objects.
Because ultimately, a 100 objects is a comparatively small threshold,
and leads to 67 times more repacking compared to git-gc(1).

> Increasing the loose object threshold here to be more conservative seems
> like a reasonable approach. I'm not sure exactly why 6700 was chosen
> here. 6700 / 256 ~= 26.2 which means "objects/17/" would have to contain
> at least 27 objects before repacking is triggered. That is certainly
> much more conservative. I see that 6700 has also been chosen else where
> in the codebase as the threshold too. It might be nice to explain the
> reasoning a bit more in the commit message though.

Hmm, don't I already do that? In the paragraph you're responding to I'm
saying that git-gc(1) already had that default forever, so I'm adjusting
our heuristic to match that.

Thanks!

Patrick
