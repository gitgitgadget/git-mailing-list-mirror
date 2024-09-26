Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1114B948
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360370; cv=none; b=hJtVFsv7SPY7GPzmWx5zGkQf3/hwcPpLPbnnUUy/bHJbYp6IEyLdV3hR/4sHAkUtf6ddZs6vchG31rijkuehT1MBOwvfCAOlQKmi24PSC60yoyQtsQUQze46Y1nec/+1hi+7qIwL7OXPSxozUS4pGKQ/E+URW8Yfkea51GSXcew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360370; c=relaxed/simple;
	bh=YMB03DIX0uELzC2lUt8Gz89/Wm74RFHsxWqqbzPtuhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihBHOyQbZNK1wWaqXhhtYnNoQoffVM96eVJ+w7n/0emGpSy1bRjsJJF8NFqVy91Q3TzKT5yZ2P2p57CEzuQJxpiCnuq/y0hk9+5GrFiNz0QoNHjeFgq7gu6U92La+h9M7QbsMP2z0yaXypgBSB9VecCcTF3UEr2i2yiGvm5YTCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lYHn1/Xc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nXC9ADJv; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lYHn1/Xc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nXC9ADJv"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9084813802C9;
	Thu, 26 Sep 2024 10:19:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 26 Sep 2024 10:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727360368; x=1727446768; bh=4ijlC4rytU
	7ZM6euSlkZbGUkF6izAfmjOMfSjEb4slA=; b=lYHn1/XcmHTYB0mNLkyGVdmIuM
	Hxxk2Q8W7A/xYCwQgHUmU4pELeo3diR6KyKLJscegDLbilBn4WRc/sRuvTA7tTuP
	kq56nWFxATqZHoAGRbw19gNg7Uduy5rgi2+s7mfy2ciQYkC6ft5YNpMdzfMaGu0I
	KSnc4tie5V5e13SuGNBbV1mpMi5bUyvawaRTPucefnVj0cjJk4WSU4LlBXVejrf1
	NLH7UoBifFaySx5YJjdkZLV0euPlg6/c3KV/CCNBz290C44GWYAZP0VUcM73lBLC
	k7OoelpMF0POMgiUJCnSAdwS8pvTZomQT01Xt/djfzj2X6aRssQXxrVVHCXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727360368; x=1727446768; bh=4ijlC4rytU7ZM6euSlkZbGUkF6iz
	AfmjOMfSjEb4slA=; b=nXC9ADJvmKwFxI+QFowb2pDV/esuphEChb2u7VnZHts0
	eITpwQEQ4YyfdQHSNXGKzerjgS0FNbsZsfTBG2x1DVwsovlvwJNwQ7ApHBJ3hOUi
	GPxEQh14kNcCaUb/5wi8lt15Br2ROGLUfnmwIrrNRZvti62a5lbAT2Ru8QNYzj7m
	Mw5CZUV29GELC3C/H5z9s+3h6mL65EJG2sVEKiNSnk4sbPg6XbD08L9naSMk2ym2
	GnThVelFvNBdhObHnYVb0dYGB7DRhom9UwUF/icp/iuiYdX5lO0x3i3dSSPY/EhA
	Wpor4F+Elj7FC9vKzx17mCB7MLpThJRuZ1OQqX00NA==
X-ME-Sender: <xms:cG31ZmwjHAmB5mKqh7ZcU9EB9-4f5lhGcCTE_YBy94xXrwSZAj9BYA>
    <xme:cG31ZiQ5VMBuvWLqbmjTou5CDyJXtDpxLNRfttuzcWeJ4fKbKMwcwH_6Mk1DdmChT
    5lBWZIeYxUlBTmHzA>
X-ME-Received: <xmr:cG31ZoUEw2sEfhbwtVSNFvaBZK07VsbDSwt9rajOZ2HFLJ5ZglxxpRBCzuM-tuIiD55FrPilCl5AQYmqAx70v7Ej31QcYxpq33mJvLYDzux2tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cG31ZsjWl92AoNgq1Ukq1MfuuifCl1hH8pcuR3UKGP-rob5EoAuz5w>
    <xmx:cG31ZoDnQXFNQ1kvxEZ0SE8Af81Q2sIc6KWvXLwDjes-5jq2M6Tidg>
    <xmx:cG31ZtIt81mUYfGt_SxOn7HfoQ5P2xqGz7poCGnW7tXB-EBjEHYy_w>
    <xmx:cG31ZvC_6pM1asBA_2SwgHmNzedN6SC6dhMYaOMAQOX5PMycybSsWg>
    <xmx:cG31ZrNkkjqZJeq_Ce9MtV2dsQx81mp1RSZhkIozuQTI16Wmor75yb48>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 10:19:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d364a783 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 14:18:49 +0000 (UTC)
Date: Thu, 26 Sep 2024 16:19:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] test-lib: check for leak logs after every test
Message-ID: <ZvVtbPw5VjTSfwzH@pks.im>
References: <20240924213404.GA1142219@coredump.intra.peff.net>
 <20240924213836.GC1142403@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924213836.GC1142403@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 05:38:36PM -0400, Jeff King wrote:
> If you are trying to find and fix leaks in a large test script, it can
> be overwhelming to see the leak logs for every test at once. The
> previous commit let you use "--immediate" to see the logs after the
> first failing test, but this isn't always the first leak. As discussed
> there, we may see leaks from previous tests that didn't happen to fail.
> 
> To catch those, let's check for any logs that appeared after each test
> snippet is run, meaning that in a SANITIZE=leak build, any leak is an
> immediate failure of the test snippet.
> 
> This check is mostly free in non-leak builds (just a "test -z"), and
> only a few extra processes in a leak build, so I don't think the
> overhead should matter (if it does, we could probably optimize for the
> common "no logs" case without even spending a process).

So previously, `--immediate` didn't detect tests that should have failed
because they were leaks, and now it does? Sounds like a sensible change
to me, too.

Patrick
