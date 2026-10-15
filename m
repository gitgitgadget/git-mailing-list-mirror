Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ABA328267
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 05:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043039; cv=none; b=sNL7YChCn8IjF2+wJyH1I/H3q75NUiq4xxFfklZwPvRqWRn+2A8c8lDuycvUBDFva/w11g++jy7Mri5FyO8d9YOXbW7wtXAerTQP7pGYtuQ48JMmFLbqx41eYlBhIC2NJ2RndLB0UxRTdKDkVCjVGfglma5Q7JJmIsSGy1ABROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043039; c=relaxed/simple;
	bh=Zl1wNdD6KgaNvkZ6dI/aUkDldQMpN6of+IJdLf8+LNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCzLv9MZHhI4XSYEqm0gB7KPI03pE1omTgeg458SWwBjXIB41GuI7+pTh5MUUeOx00MTtwKP93Cs3q93kk3zNeWS9tmunLnKz/FNcC27rXhfe0kQs6lMCcSRuQcIxno2NMfMa8KVSOsjLwlBETXJiF0WDf4SOZf+IhDoPxlx9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=clna1sLb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w404HDsS; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="clna1sLb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w404HDsS"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C03401D0013A
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 01:43:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 15 Oct 2026 01:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792043037; x=1792129437; bh=zuZag81BQD
	JZ0J0uF+5QRh4fS1Jf7EjU1lNQMVzQfzU=; b=clna1sLbdXbsFb4hsngjeDbFlN
	x9ZQRn4q3/DG7uVaGCRAkjstW/Gbdwg5bkbVmW2gw1wPhGeqbsb38Lw7Kgq9Y1KY
	jb/7P3sCPGT6mmSq7v+cIt3UTpQd0vhsvWpqFNIhTMYHjHmXa7xx9KPI4V5k1SHo
	sAOpYrNeurihswfTCjZ3KguCDAqWreoHrfk6V5nQ3ym2CLSUMpQQ+Br8bPUJfRdU
	T7g7s7zijingFrfrIqSC6AH2ODI+DoIgdhkEFgocp78brb/FjlTmHCCLj2ngGGMz
	BfNDIdwo9aQ0R6QyUvLEEW0fHkw9h6s6MEK6yuIVkSnJEb3NxtOIq7iJYpbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792043037; x=1792129437; bh=zuZag81BQDJZ0J0uF+5QRh4fS1Jf7EjU1lN
	QMVzQfzU=; b=w404HDsSNflOvcXOp7SauSMxTveONr9X78dlgneziO3f/xGn1vN
	HYBnxgDtCSKDo0aUj4KllMoxnhfEtNKEHoY3DHSDFeQCxqlYyxPdpEjf37b3XKE2
	fHO6OiEj+/kmdA8dYtAsSkR2UgBtbXQiPv+243WFVwAD3eLbr+beBLgsvMP60KBI
	5B45rIzPuTpM9OM8KC5j6mc142vsQk2XlYkyn3xnzNZCZmXS0R4yDIaa9UgvtQPs
	Hznb9e2uWg3pwamLNDLtbVaj/kqilpt48ln6rzOA663i1QTfLLi3LMlhNKuPox/b
	eSuyPkt7DKBjI1DRIz3IXrjsoPdcGYCmTeg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792043037; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vRld9UK7W+ANpxiVO9vyUZWo3ELYB57jfqJKaEUAT6Rge1e
	b9mxdpHuO5AOXG5opKRO0zdcYqXxUct+w6BFjwArsa5tBjFScRYgJuUZJHueFqOo
	Ei7DT2p/9Y9j+ybgiiKzLlJvXlCYmTb/8ycoRp3Eqyp9qv/ut7RPFT2G0X7iS5nI
	D2RdU2ZvOQcec4bRbQhwplUR+FD/U1KLAzBZ7Eaqcskyrhxd6xYutItQz/1rv2Ed
	ja93xvDvPR90R4Hq9bSlFdCxfPAIXLELWDK72FUpYzLoZeh8plG0P1dmxZAHu3Qj
	ZsPRnj+A4Mwu2wq3l8/tsyllyeJ/WFyrVCBstgg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nxTq/E/gQfdDo5gPBZv/Tw8u3aUyW6/e0un+7tIvsls=:Zl1wNdD6KgaNvkZ6dI/aUkDldQMpN6of+IJdLf8+LNI=;
X-ME-Sender: <xms:HWjQanZ9cGDHR6qi2x3Buo3rnuI0SP0lYwNkhsjRX4bgRu6aO1qhNg>
    <xme:HWjQaqGw1hRTG_ajjJqGGXsrt5mX_8l7MB555VNet0KAqgJIRVHh-Qa6rL6JbiZhw
    ezVAhrXqjzirJ5ZiZQwpc3N14UdjbwD1AGRpFzVAerRSS_jyFeHeA>
X-ME-Received: <xmr:HWjQajw1SX03C85zgAchra0chqLYa68ibbc-gMBbr0AJquvVdBHBAv5IaD_h7LReYNGH1rM>
X-ME-Proxy-Cause: dmFkZTGubLO/mUhEZaX6D0hdE5TAKWca9Q8KdmPwbhrqZgdHwUueIlWx8WYUDZXzyRi8M6
    /seS76nJIWICJF+MqT+14zOK5e5MDYOBzyqeVKTU+gHxUED4dP2Jay4T8iRFzelgxWraHY
    wDZ7OeeAGOw6wxbOGjwZYKYHl27WR2BcJUfl014Dy1UEhmfeInU4rqDIslQb/qfLNWMruw
    aucFTCtcuYDpv/lWG4XRWMHMzWLUfuUnmuZ0ysbDUe1/Ix7vxnHYYr2SD+6+q3LwI3wUV+
    xYDySF4HdpSojmWjdZgJgsOhkQbfrgyuG/drQzYuElQEzk3RqFgFDmZLF9rxffR6AV2ZmR
    Tajk9HMklHoEWxlphLbhvpoLGvfkhAaKqTeNZL34gxYaAnsU5D0X4zBBvddpvAQKqXkxxt
    NnURYNkZRsBuhRnwmwzlT0//c33Baok1z1Mo63kX8nqxXnQoVuKQMYW8tG64v7pJowFP1v
    KjLgjyK4MS6GaBJcoQo0x97Mv++pA8O+pgNKDi4DRb3m7LH26xaskebQV2Q/qpegVJDOGN
    sMvjqCGzJalyP76pS9M30+gx0b7PF503LobOVMCOm1eT/3LjyZMqVrZ7kNHs7euIyzS8rc
    jhd6ciTOubi9iFhT7um4ZfVSf84eKJd/o2jqb7aIhBZwjhOVv+fjuZIqXcUg
X-ME-Proxy: <xmx:HWjQakkCPR2qs0uAWLOEU3yMB-9dhnDP-9vdt8f4HinU5npSTMyaHw>
    <xmx:HWjQakleyRL4mqM_-z3HSqyszJGB4FpTB0WVy0jO9G4uqMvYFsUBmQ>
    <xmx:HWjQauzZ7rK2KXBmXpYWX9LQg6M9icTO7U6xxEXmjS6zmBzbOHpeaw>
    <xmx:HWjQahpIFWN98_3yboMXpv4uKD59te5KQQwg9GHbufsJP33Gcc88DA>
    <xmx:HWjQahJQ1sfgbjus_I9DwptmPOCftnWgicq-czj1G-QOFai4CexFl0Vo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 01:43:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 90c48189 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 05:43:55 +0000 (UTC)
Date: Thu, 15 Oct 2026 07:43:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/8] t5004: skip SHA-1-only test in SHA-256 repository
Message-ID: <atBoGE_R_EJhkEs0@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-1-04c24e1f480d@pks.im>
 <20261014090746.GA1341124@coredump.intra.peff.net>
 <as9a0znMFrbOm5s1@pks.im>
 <3888af48-339f-4b6a-ae84-88d0ad9caf07@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3888af48-339f-4b6a-ae84-88d0ad9caf07@gmail.com>

On Wed, Oct 14, 2026 at 08:34:09PM +0530, Kaartic Sivaraam wrote:
> On 10/14/26 16:04, Patrick Steinhardt wrote:
> > On Wed, Oct 14, 2026 at 05:07:46AM -0400, Jeff King wrote:
> > > On Wed, Oct 14, 2026 at 10:30:27AM +0200, Patrick Steinhardt wrote:
> > > 
> > > > We're about to fix that typo in the next commit, but this will also
> > > > uncover that the above test case is broken when running in SHA-256
> > > > repositories. The extracted objects are SHA-1 objects, so extracting
> > > > them into a SHA-256 repository is not going to yield anything good. So
> > > > once we fix the Fedora-based job to enable breaking changes, which will
> > > > make tests use SHA-256 by default, the test will break.
> > > > 
> > > > Fix this issue by adding the SHA1 prerequisite.
> > > 
> > > Does that mean we'll basically never run the test once Git 3.0 shifts to
> > > sha256 by default? I guess we'll have a sha1 ci job (like we have sha256
> > > today), but would that job actually hit all the other prereqs?
> > > 
> > > If we instead teach it to use its own repo, independent of the defaults,
> > > then we could run it everywhere (that allows all of the other prereqs).
> > > 
> 
> That indeed sounds like a good idea.
> 
> I also wonder, though. How many CI jobs actually satisfy the prerequisite
> after the change? From a quick look and guessing via the time it took the
> t5004 jobs to run[1] it seems only the macOS jobs and on AlmaLinux 8 jobs
> run the test. The linux jobs don't seem to run it. I suppose this is
> expected behaviour.
> 
> I wonder if it is worth mentioning in the commit message or not. FWIW, the
> "not a lot of jobs even exercise this." in the commit message made me want
> to confirm if this job runs at all after the change.
> 
> [1]: https://github.com/git/git/actions/runs/38526140649?pr=2445

I guess it's less interesting which exact jobs run this, so I think I'll
keep this information out of the commit message for now.

Patrick
