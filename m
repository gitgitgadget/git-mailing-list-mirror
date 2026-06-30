Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55353E1D12
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 05:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798197; cv=none; b=fj5XsDuizDqeZh+1raXWxhM099DK4u1qYtHFItAyflN8tKhu4P120OkspLCM/wTixi1gCnnuifECYK39HQrZ5HWsGOxslnZA9AACxd/cU0ncksUi7YqBcGVEuMnheZ5Cnd+li4cCDnbSt68wHv+5AH6VQWqPXLfd1ywhPYfSWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798197; c=relaxed/simple;
	bh=aql3vVPmlvRq7dqs1peD/786SdgT0HI0m1y2ATkkfSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8IiNtYXjLPXC4iSkheEH6LYSaZ68pyKoZjTOFX1Zy/t3CAto2EPbRorYlwnlhVL2ZQomCTGlpAMzrHM4PselUM0FbLayl92nMo80+1PitBXU05xON8uPt+sibBoINSf8ygTGNY++Z/5qOjekQhJ3qgy61qTFO/glUbT6AviauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Uo6VZkz5; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Uo6VZkz5"
Received: (qmail 69705 invoked by uid 106); 30 Jun 2026 05:43:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=aql3vVPmlvRq7dqs1peD/786SdgT0HI0m1y2ATkkfSE=; b=Uo6VZkz5LOCSE517yAMZDcEDyuu0X8fao8VLhyztd8FjNvTTec9WCO/3B69rIUP9XHq3iNQ1SGPqKAqrkO1rcN20nMAh4lIKqJ+VZOg2Z6A30TGEThtlmxUJeUKSvfRbiKM/o2IpC4SesnpriLHkL8a5X8IPon5WFYLKlMHbQB36xUTjgm2M3qp+cbKrdE9wlIKEqWj2etRot0iGFvHNtOphNGajRq593g2Jp5e89IO4C28zN3mYPfUQZVKLI6zz8vkkK40hzAKDKn5jP+HyxLhLy3Il78LRL05fi4GePgKIimUes0TxNb/wOsygA5OA534On+8M9BVA6yhZYJsNYQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2026 05:43:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 140948 invoked by uid 111); 30 Jun 2026 05:43:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2026 01:43:14 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jun 2026 01:43:14 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
Message-ID: <20260630054314.GD2495216@coredump.intra.peff.net>
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
 <20260621174934.GC2206349@coredump.intra.peff.net>
 <ajjuoS5Qc3K0nCRl@pks.im>
 <20260628081806.GA3594700@coredump.intra.peff.net>
 <akIL6oJgUv8J8SB2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akIL6oJgUv8J8SB2@pks.im>

On Mon, Jun 29, 2026 at 08:08:42AM +0200, Patrick Steinhardt wrote:

> > True, but AFAICT it probably is safe these days, at least one some
> > platforms.
> 
> Hm. That makes me wonder whether it is the completely wrong approach to
> make this a build option then. If it works on some systems and only on
> some filesystems, then a build option is just too coarse-grained. A
> distro wouldn't really be able to ever enable the option, unless it knew
> that repositories will only ever exist on a filesystem that works. Which
> I guess is an assumption that no distro can make.
> 
> So instead, I wonder whether we should treat this the same as for
> example "core.ignoreCase", where we only use nanosecond resolution when
> opted in by the user. Ideally, if we had a way to detect brokenness, we
> could even make git-init(1) set it automatically.

Yeah, this came up earlier in the thread. It would be nice if we could
set it automatically, but I'm not sure we have a good way of testing a
particular filesystem. I think the sequence is:

  1. stat() a file, getting nanoseconds

  2. somehow flush the kernel's in-core inode cache

  3. stat() it again and compare

Step 2 is the tricky part. ;) It's not only not portable, but probably
something that would annoy users if we did it for every repo creation.

It would also be nice if we could actually verify that the sequence
above _does_ show the problem. I was not able to come up with a failing
instance on my modern Linux machine (even going as far as unmounting and
re-mounting for step 2).

But I do agree in general that it should be a config flag and not a
build option. Run-time flags are more friendly to users when there is no
good reason to avoid them.

-Peff
