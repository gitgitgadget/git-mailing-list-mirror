Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5CC228CB0
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761282783; cv=none; b=Dtq9QDxG7W/6W2zVXD9aXtIA3pTAqs6bZpJwiVRiCDxt6nJVRdpdf2hoLAhOkAPtqbF8FljZfBGlspnFnDtjumutEVw+9zG1G5IYRPJbcrqvQdGAB8YqUoei9ADQ8mXZE877oFJ+AHz7jGYI5PoT8krjaYKOV9hczTDcOJQ8QsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761282783; c=relaxed/simple;
	bh=QJAtLOOeIjdEBnCt5lO2Gma9kp/qk0aTqL9DWTgMjJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Njujf8QMP795XXVW/j1lqCSG1EcpX4p1IA4qyf0Oh/2Qwq8VhX1dE9NkU9vIrK6VNr6huDJr0yVULzrwuOQa06a+bHYlbo6E0Pww3wr40mHGdmusNGZjOzYd8HxmNq56dHUsPs6SQhpqZAOUD582WOyYspLictohZDyfApiXw+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oXfQZsjv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QNxwMC4P; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oXfQZsjv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QNxwMC4P"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 494C77A0139;
	Fri, 24 Oct 2025 01:12:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 24 Oct 2025 01:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761282778; x=1761369178; bh=NWJDVjiZes
	6v9y1Es0b9jcKWqJuJNBaSlvCvJ7s64ns=; b=oXfQZsjvrLJViLP/TWHlwtPyKt
	Fbk0BbNArPkGSJoUoJExWW0pFwBZL5ilgAxPpzitu/yvKOfX0Q2IX3a7ivmnyD2r
	rOhSLhTlpI3YcGbKD3nBzEnVWU5Hj9/4p33G8jTnB3v1kVXB0WVYP78ILzo0d3uy
	kSxXLFD6bwT1+16dWPUcedsopIwsMIKK5B0QKzCJWJYFYiOtIkYhCoyidTedwXYs
	6z2Vxb1Pa5bdi8jMNxRmZJE/Yz/axkPyrlRZVTbcS/VCwM1ydz0hHyUJ4I9FgyKZ
	jxHseesfrCw8VrBTZxI0F2KwTirzeSseoJNNWKtRgcBjusx7R/8bOxR/6I7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761282778; x=1761369178; bh=NWJDVjiZes6v9y1Es0b9jcKWqJuJNBaSlvC
	vJ7s64ns=; b=QNxwMC4PQRgB9S/kSD6GgiTCGa3z9rj3tiCRpoP6pATcnFk0FsX
	kW1tfDkK9PDR7+UeA2bquLGsNJBMFRuMyJ0+408BrEH1n2hQ42koAaD5dIyOmDdH
	nDocdVDGb4DGh88+KBY7LabtjlPEiSwLPfYLsH6r0MnkASib7H/OEGKyDV19gHMQ
	7gFqpEzNeV1pV+ThY7sRWwesrde1Pvz1976Joe6Tstc97hV9+Y0UZxp2J8uoXnbv
	rdY8ku3yHdgEKg3Qw+NGaPZZVDqFv2ZP7pSvfOpCCNrEHV1ZwwudSROh/xbezCS3
	3mLp3CbNyFcfyZd6IeN6n/+kPfxss7whEgA==
X-ME-Sender: <xms:2Qr7aMDCiCWHdKW7elY9vjiql47DB_76s-t4FsG-kGPdhhjqhOn88g>
    <xme:2Qr7aCOtpNrQ1Ly1uVRmGU4FJqdlGBlA60SKpyUqAj8gEbj6RtUc25jd6u6f7UOyO
    8RdvfZ4kjsZ-sYs0qSPAuqI1o6kO2pyD2ROUrHlWLviyxSaY1a0>
X-ME-Received: <xmr:2Qr7aJaEskqeBN2v1X0C8l7zr1mxL2c1MuAsfFTvlk_4y9dg_6ODT7ib0JMjx7QifPVCJ8eHduhXDWtaLJtJRm9gT0Kd2IOPteLQ0H8QAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2Qr7aJunVmOzj5syzWnRYm8wHBb1AXODssVI5KOmiEMM80jRIdx3Pg>
    <xmx:2Qr7aDNu1Hlmlxs5j9dK4bqoG5hZMY6wQd4PALNPkEnowMr674Q_tA>
    <xmx:2Qr7aI7cqBqwq_gNY7us-_XRAZprkBxN3pSk_Pd5VILx_u-IWQMv6Q>
    <xmx:2Qr7aBTz_ZQ6PpTE89PBYKIwYHqIp2kXuZEY97fp5r6bFGl-Tjr7sQ>
    <xmx:2gr7aO-1mwt9q5rCk9U2R2tAMO4tMuRAM8RHJU6MlqKK6kNPR1r2NNhx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 01:12:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ea880af (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 05:12:54 +0000 (UTC)
Date: Fri, 24 Oct 2025 07:12:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 00/14] refs: improvements and fixes for peeling tags
Message-ID: <aPsK0ydFVUKa7ReK@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
 <xmqq3479rzfq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq3479rzfq.fsf@gitster.g>

On Thu, Oct 23, 2025 at 04:06:01PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > I'm not particularly fond of the patches 11 to 13. It feels more like
> > playing whack-a-mole, and I very much assume that there still are edge
> > cases where we should properly verify the tagged object type. But
> > changing it in `parse_tag_buffer()` itself causes a bunch of tests to
> > fail where we intentionally create such corrupted tags. So I didn't
> > really dare to touch that part, to be honest.
> >
> > If anybody has suggestions for an alternative approach I'd be very open
> > to it.
> 
> Are you still ;-), or are we ready to declare victory for now and
> mark the topic for 'next'?  It seems that another topic depends on
> this and the topic itself is a good shape enough to advance.

Yes and no. I still think that this is playing whack-a-mole, and I'm not
particularly happy about that. But nobody else had a better suggestion,
and I don't see any downside with merging the current approach. So let's
merge it down.

Thanks!

Patrick
