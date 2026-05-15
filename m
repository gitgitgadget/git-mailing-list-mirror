Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D587337DEB4
	for <git@vger.kernel.org>; Fri, 15 May 2026 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830874; cv=none; b=GIu1IKjdkcWOMx2yVKOpPYF7fkPihtCZV3MbXXQoBRsNGjnMdq8s3kzF+SK5dcmTk8XR0Z9O+zTKbZtX0sJRIXXOHm2RiDEgZ0L+j1eIM8ao0+rrX59xlQ4o0gY78iS9EWTnJpqkpDv41OKBx41j8lJiB621Kvz+fd0BlGGuaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830874; c=relaxed/simple;
	bh=LLv2phtWCQgApV/1+5AST/fKsWzPvi2qFakvbrXbI9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBapYi6P8z4tpjJ+RPT7xR6+wkjxFBe5hwnitklYS+NsM0BKpLoSZMIjzK5IgLUU8Ut6GCdUwOgCILBlyART04dMjCxMjzbjSytOIk5QNmES2lzls/hscqscFREjd/0Qnh2wEYh30fur3UIP3Gx56Lq8/1LVMVnqW7n2OqGiGG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f80b5Xcq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jf+3cgx/; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f80b5Xcq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jf+3cgx/"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E503E7A00F6;
	Fri, 15 May 2026 03:41:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 15 May 2026 03:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778830871; x=1778917271; bh=AIoyJBkF+X
	2JHX5hepwjzeBZs8uI0WWOzAMmxUNtEpw=; b=f80b5XcqxUib25a+YslJWeQSDD
	UFBcGWOW3jyUZ8XWWYwtwAxpLavDLpPRsOKxbnXzWjJcfnc8WHybTpGhtTLwfwEs
	1je/0KNmGtGuNIfW6UPHnO/sgEfKuNDJXrq2fr8OAiroPBznc4hbC3anNxhEOfcL
	cuyxdWjendTL+irOvAYDFiQHNIM4x7pS5RzQaOKTLiqUvY1srFcQLUOzkdDBfLxI
	MZIBuIH+kGv3suW686YAW+RCdg0qMvckFC/CWrTELX9X3SvNZbH0LSe3TDvRF5DP
	PsrYE6dWdSY6hRnoCXYypyY8gMiomtNiqGgMDQABs0jUfkFLdlrN/XNiHvXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778830871; x=1778917271; bh=AIoyJBkF+X2JHX5hepwjzeBZs8uI0WWOzAM
	mxUNtEpw=; b=Jf+3cgx/AGX6dGZ6o7tHZ/OH7C88r6ihH+gSE6g2DneVHmllSDV
	flb29kBsneMZZhDzLGdmZhfyCO30s+WylOiBUc68ovrq22RUzHTbABQAr5b+eH6N
	VnXs1uIKx8RpUR22848WOH4sr3e4bA1g+C1PHXl4lylYuZRKjRfHcHiDabUT+h5o
	w3z9ibVL4MFKQBAH7XEXL+Xq5aSKz1Tpa1w5V7sQLGtaUFt7Mpyq6SvJfIL0wat4
	mbHkrJJW9nEPOmWLREgNqYBNPvC6qxahTHf99HwSc9lPhTC2NKAeOu8k8FQQipC4
	/lIi36lXHU6Ab+UY2GvfVoow2dR+Bi8gCYw==
X-ME-Sender: <xms:F84GamZHpQ4Pd3sDdYY3A7t6cZUce6ccpO9JgmBhkUH8F0Nbz8KOrA>
    <xme:F84GagbLu2P3GNi-uVDZWdqifEh3AB2GP6SfqGI6mSIt45Lom-dtf7mf--cXQQ8Ub
    EpiNZnS-gMgNChhfCi_jckOiiTZynfuyy-5ea_9SN6bFM4wLyD38A>
X-ME-Received: <xmr:F84Gal_jzvp9yFSy2XqCCY6nxZWWgsqFnROP10MVWuyOek8Z_9ECPLDHlNs3h7wsIiYsVldutvVbpnguRJ5VQXJwKgt546sM58IIKGHfRJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedtleehieevgfelvdeitddtiefgffdvjeeltd
    dtffffieehleefffettdehhedvffenucffohhmrghinhepvhhitghtihhmrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhlohhnkhgriihoihgusehslhhonhhk
    rdhinhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:F84Gang3EoFJCNKty5Wl7hMAqdilxJhSi0-df9D_udOmqOQHhth3KA>
    <xmx:F84GatejeDL9I_R9W7AI1Dm_hqy-JIdXHaVwUAUbzw-74HArkJetyw>
    <xmx:F84Gamo6W6utixb7TQoH_Pi_SQJvBqCqvWU57IZ1iVbyfqpLiixjVQ>
    <xmx:F84GaqAu9jl1WbgKVUd8z5mnVx9Cj2mzBSiIp67dtUXYwvt-phNySA>
    <xmx:F84GajfR5_wIWfWJTagzy-5R8sBs3mdu-PNvD3V01SIWCyRpHK4wDCXH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 03:41:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6405c0b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 May 2026 07:41:09 +0000 (UTC)
Date: Fri, 15 May 2026 09:41:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	slonkazoid <slonkazoid@slonk.ing>
Subject: Re: [PATCH] http: handle absolute-path alternates from server root
Message-ID: <agbOEsZ8NmE8SyfV@pks.im>
References: <20260512162619.GA69813@coredump.intra.peff.net>
 <xmqqo6ikjeqp.fsf@gitster.g>
 <20260513185825.GB147423@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513185825.GB147423@coredump.intra.peff.net>

On Wed, May 13, 2026 at 02:58:25PM -0400, Jeff King wrote:
> On Wed, May 13, 2026 at 10:10:54AM +0900, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > >           ... Probably in a way that makes it totally invalid, but
> > >           if you were very unlucky you could turn something like:
> > >
> > >              http://victim.com.evil.domain:8000
> > >
> > >           into:
> > >
> > >             http://victim.com
> > >
> > > 	  Which looks like the start of a redirect attack, except that
> > > 	  the attacker could just have written "http://victim.com" in
> > > 	  the first place! Either way we feed it to
> > > 	  is_alternate_allowed(), which is where we check redirect and
> > > 	  protocol rules.
> > 
> > Yuck.  I know I am the guilty party who introduced the dumb HTTP
> > walker but I wish we could kill it off after all these years. I did
> > not even recall that we supported the alternate object store in the
> > "protocol" until I saw this patch X-<.
> 
> Me too. It's been the source of many obscure bugs, and I think a couple
> of vulnerabilities (even though clients never intend to use dumb clones
> in the first place).
> 
> We talked about dropping it a few years ago, but Eric countered that
> dumb clones are easier on the server in some cases (like gigantic
> public-inbox repos that are packed to keep most of the old history in
> one big pack that is never updated). The verbatim pack-reuse feature
> tries to get smart clones closer to that, but it's hard to beat serving
> a static file from the server's perspective. I haven't measured anything
> in that area in a while, though.

In theory we can get much closer with packfile URIs, too, can't we? If
the packfiles are directly accessible anyway the server could just
announce these directly and have the client fetch them. That should
significantly reduce the load on the server even further.

Of course, the big downside is that "fetch.uriProtocols" is empty by
default, so Git will not use them. Makes me wonder whether this is
something we want to eventually change, but I guess the current default
behaviour is somewhat insecure as it would allow the server to redirect
clients to arbitrary locations. It would be great if we had a mechanism
that only allowed packfile URIs that use the same host, which would make
this a lot more reasonable to enable by default.

Patrick
