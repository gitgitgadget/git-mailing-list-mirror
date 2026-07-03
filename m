Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A786346777
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055741; cv=none; b=QsmeAyGS44GySVZcYMB+m8wcTDWFCcLP6lZvmzz+lg5UFecQKzPj1nq8rSvY3sXojlzqlswUhmi2mVy3cyFt+oZAJCj2jfbsM5ZvKHdlHniR+etgfMuRAjoOU7ehgL/dWGya9s3UMsFcBah4w5lfEoop0F0H6gw30EG148iZfi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055741; c=relaxed/simple;
	bh=VyRtRSPsE0uS/rCuelZwune74MQba1AeElDRBGwps38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2jTx4qqNmMALk7kVxIRfsBfYAmWBLUmcZKLnVScOwUi7zzlCKmV7VH7yTnqlK7lgYGuFjlKn92UPaWycPLAQ5SOAFPz8wK3LeBnti4XnynDjFt07NSvowEI7gZDSchG+NP+owuiJUS8XUgF1FLO57OAyaUrzPvhitbbdtkdrNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UEKUb1mH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nx/tvsOa; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UEKUb1mH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nx/tvsOa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F3627A0109;
	Fri,  3 Jul 2026 01:15:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jul 2026 01:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783055730; x=1783142130; bh=xwQaLSprqJ
	LbrbGgx5/sAJ4HSeB6w4QHNvg88yWF998=; b=UEKUb1mHgS4PMLVDpz4NPo8jGd
	uQpakdqdbjJtRQDsH6nert7ilpPnBt55wdcvI8tVoJdX8HOsUeaihWRx8VCGhIe7
	HATB18LGH8jRscJADQCDvKmPSxU2JBrySxSH9BtYLwyRSi7vfIQlWBqpB19yDqCa
	P/ONXvwaGlJaYLqzWtUoiYcFgDPyGVuA0pCVzhJU8G1YH6KY7VWgkUsVPnR++VJQ
	xgE8wX2GYhqra2xnXYyJWRYHChTNdQbigrmEu0A3BUXsr8zKk5KZuy56WRR/4heO
	5ZG/ktCA7RiPOD9cshD8Rf0oYBFgf1LJbPKHI0rE0L9dNPqSvRE8bLRLgIDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783055730; x=1783142130; bh=xwQaLSprqJLbrbGgx5/sAJ4HSeB6w4QHNvg
	88yWF998=; b=nx/tvsOadsUJNY/z8azdfoTMba3fCGgpHKG0O2yFKyMkMBlY5Ui
	SdJQYlzZDqBLaU5OaqVql71bXj+9xMLdJ85sbNiSRR2VvIEFH0t7p5zp36N6Gst8
	mjRFhShvyO4ZfnFdPpOgoshSwvtD+/qbzSzlsRPcuC4uwNjv4QnMJa/L+ix8hnYT
	lc3+6I9gC2jXDKhdpAHQzpdilmzXpbEVDy0kZLF9vrB37NghV0olWYLVDg3EX73N
	YYKsg2klk+s9MhplbybniDr4xwO/V6AG8veU/HeYKNsY3qYYGdOM5NnIzLHlnSHb
	hW0XPyL/JjFbmRGVWu4O1OiCBx8nucMkgNQ==
X-ME-Sender: <xms:cUVHarVCnUhsqJfBXvU6IKJSJGNeIiGzoEs4nE4585e3KEf7xsgj8Q>
    <xme:cUVHanRGMaGGG3IVfeQHezNz-d4a4z7H2vY_Lr3YPs5j96DYrjU-lglywGhz5TH6n
    9fFNaXPlzdQ3lAcB48E1hDS27hjEEPR06ruDQq3uhhwedAJEW2z3w>
X-ME-Received: <xmr:cUVHahOS-rqfpWQiEWXVNhb3ouDsJaJYQuRD4s89i7yyqiN-xXRXWxPJQE-LLLEz7_fOTLto4oP8RQfjIu3uBIel1tTcc-rwrcUb75hw9w>
X-ME-Proxy-Cause: dmFkZTFsxyjZ3sf7hWis6mTSXKc8SFEImwm2YDEk3zoedXgquTUaCDwJDFXsGyMjBOoHG3
    9z84Aktd0/FWvhtov+1VMBNlbT6AgvQmbcOa/y6bAd5GnbnGiR1iu1d7e8rvwF6leLLKM2
    /gVVGPXRZt+JVOb32+MO7p5ButTjyd/RIJRhqyChFTatKEjv9YsP9VexGhYBpz40oKkxCM
    kNUUEo7ynBOkZcp1ZvC0u1B0v0fYCJeAHWWsyv2aSMgTQDXrRoind1iLekaY0PDYgK4U2U
    PgD3thtf1MRMjAy5ydNS3qkqItzLV/uPGVE6WsB2rGY3UhmAd3fYBUcuLh2/hK3+dK1lAG
    J4VYl6wlJL5DNMynySL/zGlXo7kLwsWWBuxBQzCWuOzQp6FUzAJyJuGv5CMmgopPIlTe0I
    I03ocYoT/8SWBgm5So3XIz2AYhvVT75bYrN4N25/L+TB/IkZOOuSdlVJWwcHwmAgvV8xNf
    Obes9UCRUlGw+p0TbZC5xQJ6b0VMVvJl7ah9qrIzaFJF78JK3oINT4woxOfxetXRkshDpL
    c1KBgTtWa3PnzWIz4OvmbuYlIXc61/RLtQTMTwwG3j2fDzk+YIIHNGo6n9pna9wSxgSYZV
    zC/XQQiNvVdVC87VmtbKt609pFzl+fDZtMEYaVZbuu2dB6c6iFjzzt56Jw2g
X-ME-Proxy: <xmx:cUVHatSzXsNZJACQB8bWVYPxzNo7I_8Y8AuLKgBx_u9KAWU8utmLBw>
    <xmx:ckVHanjYyErIQBx4AJr2jcBDNH9FMjQCAhOg9vArCjoBcsvEiygWPA>
    <xmx:ckVHau8Z0HeiCUAeQdpQhAGQMaGhkCz5Cl_efMeomFjCwyupqcxYFw>
    <xmx:ckVHamE7RDNRGgSx9DOreLxYWaghbUaFOysg8Sk7o0tCJpWNecG0TA>
    <xmx:ckVHajPLXXPKs8fuXI7_YCALQcFoGyelsW4iuVWWuXjAspm0P3SK1A8U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 01:15:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 567c59aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 05:15:25 +0000 (UTC)
Date: Fri, 3 Jul 2026 07:15:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shardul Natu <shardul.27591@gmail.com>
Cc: Shardul Natu via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Shnatu <snatu@google.com>, Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH v2] Makefile: link osxkeychain & support universal Rust
Message-ID: <akdFarZgYhhFehGo@pks.im>
References: <pull.2288.git.git.1778001976709.gitgitgadget@gmail.com>
 <pull.2288.v2.git.git.1782943303219.gitgitgadget@gmail.com>
 <akZQmDYe9MtTdGM2@pks.im>
 <CABw8Y3H7P3JKwaSrUGjifcDh7rMR2nCFgqPjw8q6vfZnLc730w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABw8Y3H7P3JKwaSrUGjifcDh7rMR2nCFgqPjw8q6vfZnLc730w@mail.gmail.com>

On Thu, Jul 02, 2026 at 03:30:15PM -0700, Shardul Natu wrote:
> > Can we assume lipo to be generally available on macOS? Also, is it
> > sufficient to just do this for the library? I would have expected that
> > binaries would also need some treatment there.
> >
> > In other words: what does it help us to have the Rust treated this way
> > if the rest isn't?
> 
> Yes, "lipo" is part of the Apple Xcode CLT, which
> is already a hard prerequisite for invoking clang or make on macOS.
> The reason only Rust needs special treatment in the Makefile is due to
> how the respective toolchains handle multi-architecture builds:
> 1. Apple's C toolchain (clang) natively supports universal builds via
> CFLAGS and LDFLAGS. When "-arch x86_64 -arch arm64" is passed, clang
> automatically compiles and links universal binaries for all C object
> files and executables out of the box.
> 2. Cargo and rustc, however, do not support multiple "-arch" flags or
> emitting universal binaries in a single invocation. Instead, Cargo must
> be invoked separately for each target triple ("--target x86_64-apple-darwin"
> and "--target aarch64-apple-darwin").
> 
> By using "lipo" to combine those target-specific Rust static libraries
> into a single universal archive at "target/release/libgitcore.a", we
> bridge this gap. Once $(RUST_LIB) is a universal archive, the standard C
> linker seamlessly links it with the C object files to produce the final
> universal Git executables.

Okay, that makes sense. This information should definitely be part of
the commit message to give reviewers a bit more context.

Thanks!

Patrick
