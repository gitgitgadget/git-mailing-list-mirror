Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9875B78C90
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352722; cv=none; b=bjC5F20+05zqCMe2mQfVEZsqNZqgs7uhqBhGlN1+hHhX3rwFsTPiTUQLuZozWRYC5p4l6ocd5oCwy78jzSSI+jcR4AmmTMtIlCBe2jSh7YhoJMKlxpwF2mGTbrUBeTw7LihGsPKT7XnbgyhLxGqDBviTX7fincyogTS8jXO31xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352722; c=relaxed/simple;
	bh=ppx1a68nlfjxeN8gfPbynuiJWGthPnCEUUZs/fQNBSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqVJ6XJsV0tbLvXWS+fPgyyS8n5xMNMbMbI2l1VBlpcntuXihKhsSHbq01FTYBY3fvyRubsWiezlRBIzGLhsKbZ5lBvbg/5AQ1v7brGZgSrQGwgo+f+96aSutxVMIpNSVv44L8jhSKItHHBhhCT4DaqMXPvzY32HopuWiLrmP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AnmNcTJQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gI5M1Zc2; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AnmNcTJQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gI5M1Zc2"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAC5311401DD;
	Thu, 26 Sep 2024 08:11:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 26 Sep 2024 08:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727352719; x=1727439119; bh=BuQm7I/vK4
	GN1/ujjtVP430DIjPpipvEZG5v4VxJEoc=; b=AnmNcTJQU1LTtZgmOdfp3rRM89
	wvKqQBHltbJSoTmfDsJWMWh6bk/8qL+1j3bF0S8J3xj6vrTbhLEgpgYTxdEdXTn5
	DOB/4noQRHK0QelNB0AcA/XBVCvH3YlBA4SkMYS/v9+n9Kceqqgzs+F1oKot6qhQ
	fsYaQC/jDAVu6GxLcQkh5C3ZTbLkBe8qNb0Zn2zA2eVCEVFun7pU5fdj4Q/54tS6
	PGWdYU0G4dkq1hgFL8JxXfypA0KhKst8BD0irJ6r9p0sRhviL1b4M1V5WaEUy85w
	bsWA+KqhCNj89yo8kOccmGfj4ENP8dSxmAe8kajygGQJbmzcLCm1wMIM4NvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727352719; x=1727439119; bh=BuQm7I/vK4GN1/ujjtVP430DIjPp
	ipvEZG5v4VxJEoc=; b=gI5M1Zc2NSv9KdPiLu6Ka1zYMfStlnQr9nFbDlwj496b
	d6Jqws3KrKWDadPcjd6IOvSn2D7NtgBl1ExL26T3p9YliXT/HYrRpcF5y7u8isEC
	fAJnk/GkRnSjm1wBpgi5j9j1ANtq+yKeNzk8FFMMsbMgLiLQg0AQqj4tqkZ87JM/
	g4sqG65foCi8MB0Y13FJ3R5v3mG4CFxTNa4mTZcTjtIsiQxqH75pn4UlyeWKvJiZ
	0PpnOgWASNG25oBTolEbIJ8c0shtXPzDm1Oyh7q5VgJaytOCpiDXAKSrEcbMvqpm
	mF8TtBKqq0/ZQwcz5PihiOnSvA8nxfsTU/oDFkOh3Q==
X-ME-Sender: <xms:j0_1Zux-3KKTsTV80MaRHlHmqqU9GDTXIcIeVOV2INzNNupoK3dfIg>
    <xme:j0_1ZqQucGNPmaKdM1wNmJ9X6VSYpJVdmGQB2mjNEzjExvV-hRy7gu1Ui3nVEzFjA
    qUKAiqYRHe0bWgorQ>
X-ME-Received: <xmr:j0_1ZgWMO0-eaS--AcqkvdirE6LrOl4w70Zwc0SPktaQIyhX8DMeNlAFHZC7tF7xz23UWcC-ppXlyRLRS2y0vqkoeVNSmNb2rlRiFXRl_8wEzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:j0_1ZkiIpuvjebgp0yjNHmbTTqLV7p5kvArmAjt8gO9iSgHZTjbLow>
    <xmx:j0_1ZgB7_EIrku6nfVrJcw_YjyR0kerM5nTu0wk0IE694nDZ18zy4A>
    <xmx:j0_1ZlL76EBfkXXQuzGoaLkKcVEVBO7U9Rpb4y78JYB4dlboeIKihA>
    <xmx:j0_1ZnA_NDO2eQctGNg8v6i-W064xem0jZ9FXz7MkZBUTdqHFdhBjg>
    <xmx:j0_1ZjO5ojgAiGfT4F1dB7_lo9nb7cyeJkERakXiVOCYlr4W-HACCZrk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 08:11:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7a36fee8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 12:11:19 +0000 (UTC)
Date: Thu, 26 Sep 2024 14:11:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v2 04/22] reftable/basics: handle allocation failures in
 `reftable_calloc()`
Message-ID: <ZvVPiIzzLTTb75b8@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
 <f6ad92ffd01c442dacd3ac6aa448891028636636.1727158127.git.ps@pks.im>
 <xmqqikulugwj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikulugwj.fsf@gitster.g>

On Tue, Sep 24, 2024 at 09:59:24AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >  void *reftable_calloc(size_t nelem, size_t elsize)
> >  {
> > -	size_t sz = st_mult(nelem, elsize);
> > -	void *p = reftable_malloc(sz);
> > -	memset(p, 0, sz);
> > +	void *p;
> > +
> > +	if (nelem && elsize > SIZE_MAX / nelem)
> > +		return NULL;
> 
> Now it is open coded, it strikes me that the check is a bit overly
> conservative.
> 
> If we are trying to allocate slightly than half of SIZE_MAX by
> asking elsize==1 and nelem==(SIZE_MAX / 2 + 10), we'd say that
> (elsize * nelem) would not fit size_t and fail the allocation.
> 
> For the purpose of this caller, it is not a practical issue, as it
> is likely that you'd not be able to obtain slightly more than half
> your address space out of a single allocation anyway.
> 
> But it illustrates why open coding is not necessarily an excellent
> idea in the longer term, doesn't it?  When unsigned_mult_overflows()
> is updated to avoid such a false positive, how would we remember
> that we need to update this copy we?

I agree in general, but with the reftable library I'm stuck between a
rock and a hard place. My goal is to make it fully reusable by other
projects without first having to do surgery on their side. While having
something like `st_mult()` is simple enough to port over, the biggest
problem I have is that over time we sneak in more and more code from the
Git codebase. The result is death by a thousand cuts.

Now if we had a single header that exposes a small set of functions
without _anything_ else it could work alright. But I rather doubt that
we really want to have a standalone header for `st_mult()` that we can
include. But without such a standalone header it is simply too easy to
start building on top of Git features by accident.

So I'm instead aiming to go a different way and fully cut the reftable
code loose from Git. So even if we e.g. eventually want `struct strbuf`
return errors on failure, it would only address one part of my problem.

A couple months ago I said that I'll try to write something like shims
that wrap our types in reftable types such that other projects can
provide implementations for such shims themselves. I tried to make that
work, but the result was an unholy mess that really didn't make any
sense whatsoever. Most of the features that I need from the Git codebase
can be provided in a couple of lines of code (`struct strbuf` is roughly
50 lines for example), plus maybe a callback function that can be
provided to wire things up on the user side (`register_tempfiles()` for
example). So once I saw that those wrappers are harder to use and result
in roughly the same lines of code I decided to scrap that approach and
instead try to convert it fully.

So yeah, overall we shouldn't open-code things like this. But I don't
really see another way to do this for the reftable library.

Patrick
