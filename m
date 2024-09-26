Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3113C836
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360366; cv=none; b=ez3L0PxuAMr9zhS203qdt17dFWNw9Iypp3pglpIGmngOXQp61ufA+Cr17kdXEXVxKi3bQWiNGpFWkYT71eNx+FE1k7ISWdmvD00o4JCLJv/XxRNGaNCk6M3wycxCeG9f/ZI4rNBOR2gOEzakaePZ2S73agZhavtBhDjwZFKezbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360366; c=relaxed/simple;
	bh=X6TTsN0EPeKUayN7dTospwAKFZiwoOigmJqEHHUL2MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiP5U5+OeXWkEYyYuSi9jcdLrixbZuunJnMtrjAAVhdj1z7uvnEjkX38bKv5aRyAAopf0PJuaeOFIqcYj+yy1ff5oSOHMwEBW/9RTLgmtDpH1G8IXtlCho9e17Gb/fsAV97z/hrBTIPkVv16+GKwxz8ITde33toSjAklUS85IHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iRsPmILM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bInqs3p4; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iRsPmILM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bInqs3p4"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E34A138043D;
	Thu, 26 Sep 2024 10:19:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 26 Sep 2024 10:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727360364; x=1727446764; bh=Tukne/X0CP
	exv1W4XPqi9LoKv86gBp/BoxkH7xEjG3U=; b=iRsPmILM93Yo3mGfrUUjFjAgbh
	DOGUxOqmXNwCXXAysVFDxLzNybksZPabKs34+ccX14rw15E0/VfetOTTQROfVkSE
	H7NSFQhb94XEW0L5inAI/qlg5XVrKU2tRE4Yb+hu29j30GBC4vQEglIYLby+Rc2O
	PXsbQ2ifo2E/bP7mCMeaOMEvbo8oBILRmJWVbeAeL2phqNVzaNI5wlASiGTeX9uL
	XRNjPWjM7Kyc7Za3ovUAMHCdiHZbRKm+2NLmeaRGpPQR+tVRDLhi2Y5J3VKJeaDl
	hmSWSzX6loyDAX1Q0CcIx62+ddvoif5xdgcuni2DwmdV+Gm6k+Q+W0Xqr91A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727360364; x=1727446764; bh=Tukne/X0CPexv1W4XPqi9LoKv86g
	Bp/BoxkH7xEjG3U=; b=bInqs3p4QKZEztPpgq0FjVGPxpDGTIfA+ZyRN9Q/dRTx
	HgqBC7aV7zNKfkK82LaHop/2GM7OZEAmOStx27dlop5N88E88ZCQtjEogoxZ9HWf
	Jx+2DLXlVyFecxKw6JQjxwg3gYjui3Iuk+HsEj6oJYYvfYpdr53+AyfP/vrRgR0T
	dRsLq7/OkseKZnmFBsQ+tBAeuTc6S/PI/TrwjsXdn4+S3MpPEDbp8SqJTcyXOlt7
	qAZDEO/S7Gm+HHICsow4CKjUzzid61lfTbrXSe9u+xbwF4K9qPZXIGL5ebS8gUez
	bz7AL+G/CCC95tM2XO8ej2DTW50akaI/NcR9pxJQnQ==
X-ME-Sender: <xms:bG31ZkjC92HL0SkTqkKZNIwTgIsYy5yEV0RvmhaY2MEyTW8pKAbURg>
    <xme:bG31ZtCEYCFqGPZhO22wPKdBGgFLWJ2zHEqJHrPkKA9a3yDX888RGjQxq7mUpfmuE
    FeIQlew58qqj4xOEw>
X-ME-Received: <xmr:bG31ZsHEi7QQJss6SXDYKRd87YLU3ohCj5Nc_CylGCDoIUoX4CjL_PafiBeF8jy43VsgBBPT_usDSG17ouitlTLqbi2nrj-IeUIUuTjN5ALI3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffke
    dujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bG31ZlSYF3e-i0aCTa4jUrp2B7Q2LkWToDchDQIoCpfib64OZDq5fw>
    <xmx:bG31ZhwYm2m4_ZxnM7aD2Y9XCAnkN9Z06d5GBIKluomRQTslcSDOXA>
    <xmx:bG31Zj4IaVGiJgz_TJsTel1pGeNN5awkOPTHQ-ZICWv19XAC9FidZw>
    <xmx:bG31ZuzH5daGFiiiviPTLx0jXS0pAFdLz_gKgxHSvzm54R0CWZYu-A>
    <xmx:bG31Zs-Mzo06Tys5ibfS5GUBYkYW2cQN3t7GeNub4I-0HD2AylBiSybB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 10:19:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6429f5cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 14:18:43 +0000 (UTC)
Date: Thu, 26 Sep 2024 16:19:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] test-lib: stop showing old leak logs
Message-ID: <ZvVtZDrUwkdeRbje@pks.im>
References: <20240924213404.GA1142219@coredump.intra.peff.net>
 <20240924213540.GA1142403@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924213540.GA1142403@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 05:35:40PM -0400, Jeff King wrote:
> We ask LSan to record the logs of all leaks in test-results/, which is
> useful for finding leaks that didn't trigger a test failure.
> 
> We don't clean out the leak/ directory for each test before running it,
> though. Instead, we count the number of files it has, and complain only
> if we ended up with more when the script finishes. So we shouldn't
> trigger any output if you've made a script leak free. But if you simply
> _reduced_ the number of leaks, then there is an annoying outcome: we do
> not record which logs were from this run and which were from previous
> ones. So when we dump them to stdout, you get a mess of
> possibly-outdated leaks. This is very confusing when you are in an
> edit-compile-test cycle trying to fix leaks.
> 
> The instructions do note that you should "rm -rf test-results/" if you
> want to avoid this. But I'm having trouble seeing how this cumulative
> count could ever be useful. It is not even counting the number of leaks,
> but rather the number of processes with at least one leak!
> 
> So let's just blow away the per-test leak/ directory before running. We
> already overwrite the ".out" file in test-results/ in the same way, so
> this is following that pattern.
> 
> Running "make test" isn't affected by this, since it blows away all of
> test-results/ already. This only comes up when you are iterating on a
> single script that you're running manually.

I'm very much in favor of this change. I frequently re-ran tests with
leak checking enabled only to realize that, oops, I forgot to "rm -rf"
the leak directory first. So eventually I ended up with the following
command:

    $ rm -rf /tmp/git-tests/ && make -C .. -j20 SANITIZE=leak && ./t5310-pack-bitmaps.sh -ix

Every time I didn't use it I soon came to regret it.

Patrick
