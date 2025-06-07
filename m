Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D712580FF
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749275025; cv=none; b=MZDbdic3mUsRQPam+l/a1mzfsHg3TwrD0eZmBMwfNOHdyMg6+1PnQkYSBJ9aGpAHG9rXyxqvUazGrYCP5c9n0l4v9rD21y+qeOzf/JaGEsQ/j2PynC6qlk7o4H+cHnxHCFbGL0kkMmWIgUWXXP7SCeq2iYE7PgxDwTNzyV//Yg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749275025; c=relaxed/simple;
	bh=fLzzo9K0HR/Ham5V9F6qymFCRWaxw2QfTRD7BfHpK4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzAA/qXO5d7cjWXZYTnl73U1DDG5g89gSWszEYu+X5lLzmp8IzLgm+zqWKJeprnRyWLMuUAjp2slaMTue5owzMdwcnHz2LOF6FpWoIbH1mP0qNOgtXG2HweAyrB4mjH4rWCXBoxNQpkEhotAAV2kttWONRjxFYPrwj6OWVPNNn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=obYcjbaa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ORkcvsbv; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="obYcjbaa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ORkcvsbv"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C430114010C;
	Sat,  7 Jun 2025 01:43:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sat, 07 Jun 2025 01:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749275021; x=1749361421; bh=LF4x5JEpXM
	m+OiFmYDYZQRNi9iYjhBnIt/hY1K3KnwM=; b=obYcjbaa/qIqaIJwAud9X0YzOE
	jgO/XDt0WY3yYCM7ykGBLkSasLnrXKzHGZxVn1lB2x1lIwIkybRdy6cFds7WtoW/
	XccDBLy0KQP7/DPdc44gMNpWMO0uB6rFyQYXK7dMiZmLZqhcfHW4BsA2DedkKLaD
	A8NC+X+Pul3sEIcZM9aMdLTcBgCX4UJAfbxBS9njaXbfCfO8vuyns9bFVXqoHq8c
	APAnbMz0yjsMPuwIz5Q5uKNmfMQ3/EZta1yAd6yJ3kMTURZ9qLqOm+gs5ysiFJP/
	b1ZNv/15uYFchzJO3FQYMGfJHxiSmzDHd6kvDpQ0kpWFNEP1hsf41BZ3P9lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749275021; x=1749361421; bh=LF4x5JEpXMm+OiFmYDYZQRNi9iYjhBnIt/h
	Y1K3KnwM=; b=ORkcvsbvmeJ8GyzmilhAC6MTv4mlIPBnilP1KOBHIrMhCDIRC53
	zfirUvGbSJlt4G9Poxz/1D7B2FEYczX2/JoXZ6MFNhkVD6d3YE6FncUg6pKpB8oj
	lBXkD6egr75LbzFNDq1EysdB05rgaWDo0t/nP5+pWWaHNAZ6SDB4ZWzR/BxsA2/j
	DmFDqzkYJ1lBujYqKW3uDhMwQXY4ECT+UFDo6eBImSynDuVEh1XUghnKUV/8YiK3
	1Zj8Yyfd4Kh3AbP35KKpXhmfBgvIuV6tLQbZg9Hbn3OHxru7vqDBQNAf0jg1t4RL
	7VXLxRrKYzDzXNprl2xv1oHRFgS31MNMxXA==
X-ME-Sender: <xms:jdFDaGanHMsrtpZLo1WH4aAn3XADTOtE3UaQGt2M-7wS9QtYBz0RYQ>
    <xme:jdFDaJYGl0e_agQj63tsbiJEMs_CZOuOeOQzFUOiy919WnvnCNhaFZVFnzOVj-Ars
    g2RZqtorxkdvcrJqQ>
X-ME-Received: <xmr:jdFDaA_q4Eht_9kjOxPenyTLrqwv8sfLadX2U-BkL6TmFmLTKTCEp-I4SHOM1DhugUMTXQ3aUrVotojtHvkhTALKu4Bg6WZMqLoRxtCHlRmd2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeiuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jdFDaIqOxCYuUtu9YDmGZP5zzigXBBkceDHbqJqi3Fe2yBLWRV2oVg>
    <xmx:jdFDaBpxPGlIHRc3tB-BFcl-Q-ianTzLvM2GdRZXOJHUUnEiMMlARg>
    <xmx:jdFDaGQgOG1gKOKvjQjrydAlE-9RImWDO5n9962ujhxZOh4fXoS-9A>
    <xmx:jdFDaBo0zfTm1mVmYEtBN9sXoaoONt2J8rePioey6izB8l5fAFIjeg>
    <xmx:jdFDaD0XnjBmIFffuWSzAxfxTZyVJxB12FlDKCA-S8s2-emrG6NUI4rf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Jun 2025 01:43:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 72a032f3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sat, 7 Jun 2025 05:43:38 +0000 (UTC)
Date: Sat, 7 Jun 2025 07:43:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: issue with git submodules and a clone.defaultRemoteName
 different than origin?
Message-ID: <aEPRiEdJ8c0X4HY5@pks.im>
References: <4f638125-39e0-43a1-9c58-35c2d433042f@intel.com>
 <xmqq1ps0gzo5.fsf@gitster.g>
 <48c2af0f-348a-4443-a8b7-74ea4b666bff@intel.com>
 <bdf7e50f-aa65-4514-b147-9f7ebed147ab@intel.com>
 <xmqq8qm41m62.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qm41m62.fsf@gitster.g>

On Fri, Jun 06, 2025 at 04:32:21PM -0700, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
> > It looks like those end up in the "read_remotes_file" and
> > "read_branches_file" functions which are deprecated, and planned to be
> > removed in 3.0...
> >
> > Would patches to modify those to take a repository pointer in order to
> > allow callers of read_config() to work properly with a submodule
> > repository be acceptable?
> 
> The recent trend has been that it generally is very much welcomed to
> fix such a code path that takes "repo" at an entry point but ends up
> deep in its callchain to ignore it and use the_repository instead,
> even without a potential use case to benefit from such a change.
> 
> You have a concrete use case, so I would suspect it is even better
> than "acceptable".  Patrick, what do you think?

I definitely agree, yes. It is a long road to get rid of
`the_repository`. Taking many small steps on this road that have a
proper motivation is way easier than doing large steps that get rid of
the variable for the sake of getting rid of it.

Patrick
