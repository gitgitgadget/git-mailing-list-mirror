Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA74379964
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527021; cv=none; b=FEcSGLt2tg6bNxset6v9HkrKqoKpf4qhDK0a6xqac2NFmmHl9qE+ILsoBoAAJYPUayynzXrAmzrb3cpoYoR/I7WCkWYn4XWoKQNY4Hy9fDOKO/paB0eW9KvMGr3WMWZV7TPJLXQLJVKtbszMH9ruhV92IeAefNKMlBZLjgB2e7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527021; c=relaxed/simple;
	bh=yjAyVu+l6Nf6SDhcsxhiO2C1KU77o/K9Dxsdjz9S6d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOwpFBsY3Sgh+qUgNiNslnGOO0tXJTN5vpH2lLWKeqsdRBkAL27z2e+Y2MlO6e6HFCkPCjsq+YGsLCSMjUNASLvxzWlqpYg3urea2+w0O0yVd5zaqSEOVkDD/aWNE1AnPWLF8oebmkXNr9P2rfexdWrlzY7MFyh45Jjjw6gzxXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KIbRz3gk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fbIkRnPT; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KIbRz3gk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fbIkRnPT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A15961400054;
	Mon, 15 Jun 2026 08:36:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 08:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781527017; x=1781613417; bh=jOmhb3ugLH
	bwNmdCAiZJhYWbsLCA7b05A8BfriE2+f0=; b=KIbRz3gkbpBIgSSliwXBO09vdo
	tAeqkZomuF7ImGvjOn6Tfjz1DsVjDOsfgJlU+SB7MXwI7jkWikgaPG4ucb1HT7wH
	2kNFGYDioGJgv9a+Wrrl1eJHikEjTQVElfGCpvb+SgV+xUMTdUbL3tz5gAf2YjnL
	p8wPuNo1bInQv5GoUaki5UdtYQ/IPkmyctFm0ZPSbQTN2P6KqJHd5Tz+5tXP7AoP
	+JhZuGUTmdveHL8QzjWuaTTLkkc6UcJ61N7wNbTYfgrxlBHDn2CGLMnb13F7vQGU
	PbTJr4XFfBWxrFDnaeD8DITKaAW3LJWfgoSJTd0akOKdu40Ox+JYRKmk6+tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781527017; x=1781613417; bh=jOmhb3ugLHbwNmdCAiZJhYWbsLCA7b05A8B
	friE2+f0=; b=fbIkRnPTbtGn9MRhi0HZxrquaVTdAQMgTuJm0755QaN/Bsoh/An
	o8jc2l2Z16as5OWv7X3Z28Etn88KkkDsB6EpTfmRPPsJae/udxZpdxi/LpYcyB14
	Fx7rYaw/wGXYtWAdD4sGwmH+cttOWJoOawYfvQHcwanlvdgRcTH1D9AqzeGdoJPp
	kWfnlY1HPhXogIZc60hTIPvAi1Q4FMBexN4xRuStcwUfQWEHZY2uTyJZVugbf8YV
	WEAg9Fp4gLw9jddSKDayADuPkZiya0i7drVo9SH2ba/2XQivnTQ080jYAJabdxRu
	mgtGRTVZX6a8XKDBHFXJaPDN7+SOzcz1X3A==
X-ME-Sender: <xms:6fEvagFOV_flMfg-zrMwjD8VlJ2H8_OdHXSrSTJJr11TK5E6V5bxZg>
    <xme:6fEvagwU_zhQXJ_7e6-wTfRq9qObvsn73id6YUdrVNZJRiuVClAk2d0sbBLdnBu-u
    f0HpUNYrveY18FDelm1M97mST4yC7zUGfRq6-FGSgt3w1yqHVR9wg>
X-ME-Received: <xmr:6fEvanhZLIhV6aon0KopB7HcoP-0ABaXzu3J7F0cepyTI2QS-eTAyXmceSsHLTHueqe4pP2OpBLFoHzoTP4XEcA1_xGR5hWGuLAaub0N7Q>
X-ME-Proxy-Cause: dmFkZTFFznFP1fsS4E/kA+UGuqjc+ZXvzPSjdiHv+Fv/v/cyANUMsh0xLoa7wkbgPyRw16
    cComL070O0RDgpStA5qIrr4oD3uG/pwT2aF/KI5YNlJdCbynZKIaFjLL1ROJT8F+YpS5Id
    nl3HNST+pi8UnUaYkHobNprqO1LhftmPeoGIZfF+ytJ81ettvacL8jZeA7YNPNzDHmcKEV
    3H1sGpO/I8TuyDR0RZxsnMoUCClh9CUvXG2O5YczBWsolps9tU/HTY+QvvS0I5U+FJUZ4y
    ioIv4zZyC6EOstoVmGfzPupW+xaEa0QlEKO0rCB+nddpzP8je6F0d7RkyPp+OKjdHLbsCH
    RiZoHjsSAK/yzqVMfVOPvVJ8wxg1p2E9FKMEcjBXwar21wgFgESsx7uEov+Oi5mJO3KEbr
    pM3aTM1d7N5+QlMC+AsfIBlgZakl2AUuGDcWgOKwz2Vyrg4oxIkScDz4zBXetDDGDud0Bw
    9mz0hQjBFkLCGJ5gSeBtNUHbtb5IdBRTPYcdtz8n3LmgIiCb2jOSCt3MCWX/ED6q7KYLHZ
    ByPLBZNkqEkToM+OEpr9ZGFC5niC+47QWa3Khxa2l8T57eicu0NjcAlDdSJfeTT4AkNHy3
    84sLM+IKkCRgC9VpbtVaIvrfS/X6pm2/U9prSnsZEfq9X7cKvJ7Sx4Vvmp4Q
X-ME-Proxy: <xmx:6fEvarxrrkbQqVvqAsuCm7TCXTkN_v3La-aX8SQQSDQ2ON4e0N8LFQ>
    <xmx:6fEvaqJCwJCR3Z8BuJzoXyrqoW0UlbiWD92jKcv2U6rAzvtUN3PgLQ>
    <xmx:6fEvaiRso1ECsM8TDQwFD3PNaCLT-zijRLH2tm7cP_kHMK_O1DeemA>
    <xmx:6fEvaiptwOx9FGAAaQz50aeIIRNgWHLx48zFg-Y2sYhlQDDd9Xqz_g>
    <xmx:6fEvavJpPzO5KxNt05qSjNpJwryHkGSwk4ppAph2Zm2oeldUPd8ybARx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 08:36:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be7bf90a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 12:36:56 +0000 (UTC)
Date: Mon, 15 Jun 2026 14:36:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 0/9] refs: stop using `chdir_notify_reparent()`
Message-ID: <ai_x5ln7JUUpJtR7@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
 <20260611065346.GD2191159@coredump.intra.peff.net>
 <aiukqI0Nj_RRn-wZ@pks.im>
 <20260613140024.GA766297@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613140024.GA766297@coredump.intra.peff.net>

On Sat, Jun 13, 2026 at 10:00:24AM -0400, Jeff King wrote:
> On Fri, Jun 12, 2026 at 08:18:16AM +0200, Patrick Steinhardt wrote:
> 
> > > If we move to a world of all absolute paths where chdir-notify is not
> > > necessary, will we lose that optimization?
> > 
> > Probably. Unfortunately, the commit doesn't have any repeatable
> > benchmarks in there, so it's hard to say whether we could still
> > reproduce those issues or not.
> 
> Here's an easy-ish reproduction specific to the ref code:
> 
>   rm -rf a/
>   dir=$(perl -e 'print "a/" x 1024')
>   mkdir -p $dir &&
>   cd $dir &&
>   git init &&
>   git commit --allow-empty -m foo &&
>   seq -f 'create refs/heads/foo%05g HEAD' 10000 |
>   git update-ref --stdin &&
>   time git show-ref
> 
> Before your series, I get timings like this:
> 
>   real	0m0.078s
>   user	0m0.020s
>   sys	0m0.057s
> 
> After, I get:
> 
>   real	0m0.876s
>   user	0m0.004s
>   sys	0m0.872s
> 
> So it really is measurable (and I did not expect the effect to be nearly
> so large). Unsurprisingly the extra CPU goes to system time.

This is indeed surprisingly bad.

> But obviously that case is quite silly. It's an absurdly deep hierarchy,
> and 10,000 loose refs is a lot. Just running "git pack-refs --all"
> brings the before/after to roughly the same timings (around 40ms --
> faster even than the before timing).
> 
> So it _can_ matter, but I think ultimately the better direction is
> probably "make fewer syscalls". Which we do via packfiles, and via
> packed-refs, and eventually via reftables, all of which put more data
> into a single file.
> 
> I offer the script above more as food for thought, and not necessarily
> an argument against your series.

Hum, yeah. I'm a bit hesitant to just wave your findings away. I mean I
agree with you that it's unlikely to really matter in practice. But you
never really know, and I'm not sure that I consider dropping the chdir
infra important enough to knowingly take that hit.

I definitely think that we should merge the remainder of this series
though, as these patches simplify "setup.c" and fix a couple of memory
leaks. But maybe we drop the last patch for now and...

> > Ideally, we'd have the best of both worlds: absolute paths everywhere
> > without the performance hit. A while back I had a discussion with
> > Torvalds on the securiy mailing list around this issue, and ultimately
> > the conclusion was that the best way forward would be to use openat(3p).
> > 
> > This wouldn't only allow us to optimize cases like this, but it also has
> > the added benefit that we're much less prone to TOCTOU-style issues and
> > we might even be able to use flags like O_BENEATH. So it would basically
> > be win-win. The only problem is of course that Windows doesn't have
> > openat(3p), so we'd have to emulate it, and that's where I always lost
> > the desire to do this.
> > 
> > When waking up this morning though I had the thought that we shouldn't
> > try to emulate openat(3p) directly, but instead create a higher-level
> > interface.
> > [...]
> 
> Yeah, I think given a decent interface it might not be so bad. It would
> mean code thinking about filesystem syscalls in a different way, but if
> done subsystem-by-subsystem it might be OK to do incrementally. Much of
> the code that would want to switch to this is using repo_git_path() or
> similar already (and getting rid of those remaining static-buffer
> functions would be a nice bonus).
> 
> I do wonder if your series here to move to absolute paths makes the
> TOCTOU situation a little worse. With a relative path, once we are
> "inside" the repo then we are only susceptible to changes within it.
> Whereas with an absolute path, if one of the intermediate paths changes
> from under us, there may be confusion.
> 
> Without thinking on it too hard, though, I'd guess if any such case is a
> security problem, it already was during the "open" part (because it
> implies that the attacker controls paths below you in the hierarchy, and
> you had to get to your cwd _somehow_, at which point they could have
> attacked you then).

... eventually give this idea here a test?

Patrick
