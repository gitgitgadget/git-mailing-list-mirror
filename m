Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F64215F6B
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 06:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296520; cv=none; b=OjrDGVZ9JkrwaEej7LS33H0YZs7YwtNlYDtNUUKLleXFzDKYUNhgf1mIX7r6QqIeI/9xN2OKjGm2wjQKdlL397Oxex31S04UfNuCqDRmOqCmETujQAo2O2vdbmGQCeJrLF/kz4pkZBKklC9K931I30W5SM8gyxewooWyinKu6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296520; c=relaxed/simple;
	bh=Jv4fJ8VA1GsgHB8ZKgA0qD5jDZ8WylvVihVwYJ0Av0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mutG4sUDz/ox52XR7jv/0gBEAL6A8q1Bvhx8/NfWAkDEA6l8TxQNBm8v9g3L1JhMp5+BRJrFY/8c6Fg59RAnsPIAjc3at+/43pG+/lTYge+4VSi0FK9pI9nwUxB/IRslJpXADGk8ilSXT7hY9mDFLWWer+pje5Fyy660EsGCsRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fWPlPEaK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z4r6YKr1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fWPlPEaK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z4r6YKr1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 05854EC0ADD;
	Thu, 12 Mar 2026 02:21:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 02:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773296518;
	 x=1773382918; bh=BwDSwNGbA+DOGC7Vy+JCbHllJeANlTVPTs1RuHS33JE=; b=
	fWPlPEaKQDO7pyglW25kgawfeoB2lR795w9xPVCm5a0n+ConfVSt5cW2RFqvjew/
	PLccWvFdLXN5KZcMCczUyYa4Zs6jvGqqeAqcj7UKjnaXKSscpSopXEArvK8mdk6d
	Q6/EKt9qDfMv+/6tqnyxP1bcv3h71rvVewAHAB5xwDewtOf5DOd6+LGQnIfd6rbc
	8XrJfafVG8ZrX3C5Zr33Z68y9Ysfg6T3EyjvKZDubw4EXzGOlcHdReeu/ClgTiG6
	qoCUTi2/hvet5u8MKF+PFZbkIT7PwYe7H4rAVW2qs19G4jzcT0AAxJxH8E3HHetX
	vPUzJdkD7QR9S4zzG5AuaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773296518; x=
	1773382918; bh=BwDSwNGbA+DOGC7Vy+JCbHllJeANlTVPTs1RuHS33JE=; b=Z
	4r6YKr120soMV8fR3dRqpTiA1va/gMtJoLEIHy2s+qZtnFB43nvdX6dFmCSnkgz8
	dZJ3FJkSAeaJn+HuNBBaDfRUOIYW67L6lvhiqiyHGYRPqLlz//Nteh9JmJe7SZLk
	LB3x/vchhg/ef8zKhytmHjtnUEBzdp94Bp1szkmvQHEb/jhMRz1SwDKCHLh6UbNY
	YHdOuInwTwSs+w+QHyqpcR11cPmRTXV2spiLZ702ylMbWCZSIWcSBGahVGzX81Ne
	Scj8pMLa+TOvnSzqZjaPzLvDGH+nUjEyFc69KDAtTXViBRM28sTQM4AmVCgeLQU+
	D0v81w/K7U37Cp1lV5F1w==
X-ME-Sender: <xms:hVuyaR3ApPuonJuRf-8P-Ym5AIPy5KleJ4CgRe99sZDZnfG5QMh8eg>
    <xme:hVuyaWAjVpJsHWUK3Trlb-zcO-wuSnep-kAvmgXtWlUe7WqFiy8vPSA5Am7jVXgVy
    9xu3tRde7CtlyUZCpBI-Z_1JFU9rELdJ8gy5nODoIt0FQiIVkGLww>
X-ME-Received: <xmr:hVuyaZfNu3h70ECd3p5V9gXgydd48Nf863SLgXV8ZKprgPszC3Oke9_xwMMOMQLwCu8NMb6cpfEcpNSF--VLKibDeLiMxw4Gx_Dxvbr6sv2Twg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrd
    hukh
X-ME-Proxy: <xmx:hVuyabgeeDmyb_5SJUyVJOGPI313aszcBUki7tYHAvrSbh-USC_2tA>
    <xmx:hVuyaRoX8yDGhRnL0JcBO3iPTA-5fD0pMklCfSQRmR1IQnraXVguow>
    <xmx:hVuyabEpDPg05gXpuyj5zAiK9Zr8YoapJWuYXRjn2KMLLarTWFWLTg>
    <xmx:hVuyabnOTKwqFClP8O9MvtZpOTwk-l8C-PmdMVqCRAuwasYDXA4DyQ>
    <xmx:hluyad5ezl6FBdztJUgxlVnxzUjF-YofdsDzuBBxGosOOpy1t-NbHVtK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 02:21:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3a92a727 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 06:21:55 +0000 (UTC)
Date: Thu, 12 Mar 2026 07:21:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] meson: precompile "git-compat-util.h"
Message-ID: <abJbf3m-EpYmHiYG@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-8-ec75d0710d6a@pks.im>
 <040296b2-9a69-4603-9a2a-2001c98220b7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <040296b2-9a69-4603-9a2a-2001c98220b7@gmail.com>

On Wed, Mar 11, 2026 at 02:32:36PM +0000, Phillip Wood wrote:
> On 10/03/2026 17:52, Patrick Steinhardt wrote:
> > Every compilation unit in Git is expected to include "git-compat-util.h"
> > first, either directly or indirectly via "builtin.h". This header papers
> > over differences between platforms so that we can expect the typical
> > POSIX functions to exist. Furthermore, it provides functionality that we
> > end up using everywhere.
> > 
> > This header is thus quite heavy as a consequence. Preprocessing it as a
> > standalone unit via `clang -E git-compat-util.h` yields over 23,000
> > lines of code overall. Naturally, it takes quite some time to compile
> > all of this.
> > 
> > Luckily, this is exactly the kind of use case that precompiled headers
> > aim to solve: instead of recompiling it every single time, we compile it
> > once and then link the result into the executable. If include guards are
> > set up properly it means that the file won't need to be reprocessed.
> > 
> > Set up such a precompiled header for "git-compat-util.h" and wire it up
> > via Meson. This leads to a significant speedup when performing full
> > builds:
> > 
> >    Benchmark 1: ninja (rev = HEAD~)
> >    Time (mean ± σ):     14.467 s ±  0.126 s    [User: 248.133 s, System: 31.298 s]
> >    Range (min … max):   14.195 s … 14.633 s    10 runs
> > 
> >    Benchmark 2: ninja (rev = HEAD)
> >      Time (mean ± σ):     10.307 s ±  0.111 s    [User: 173.290 s, System: 23.998 s]
> >      Range (min … max):   10.030 s … 10.433 s    10 runs
> > 
> >    Summary
> >      ninja (rev = HEAD) ran
> >        1.40 ± 0.02 times faster than ninja (rev = HEAD~)
> 
> This is a nice speedup for a full build. I'm not sure about dumping the
> precompiled header in tools/ though, it seems like an odd location for a
> header file. It is a requirement of meson that the source for the
> precompiled header lives in a separate directory to the rest of the sources
> but it might be better to adopt the suggestion in the documentation of a
> "pch" (or maybe "precompiled"?) directory rather than mixing it in with our
> build scripts.

Yeah, it's a bit on the odd side. The reason I decided on "tools/"
though is that it now contains our build infra and developer tooling, so
it's an okayish fit. And I didn't feel like creating a directory for a
single file, only.

Patrick
