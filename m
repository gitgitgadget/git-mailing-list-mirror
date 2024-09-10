Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64F816F265
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948567; cv=none; b=tj7BXP11hsLHVV2/noNFALLE+RvgMVQEoMYGFEgNsnDn7xo8b3lMCEQZUnsnEXzzXRLGBfVOIrVOMP8URzNsCMxQl4guVwrYnaCQpufKyxTN8+ZK6cUY8CLAz6fc1hBe5B61tBBAo0b0L9WMnsFQLUQcejOKwtISCVb+GNF0KLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948567; c=relaxed/simple;
	bh=H0rglXaJhB05Rf4YtbPrsP9uD8/seF0UgXjr9SvCa5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdN7W1aXEmsnF4bTvyVk0GTk+JWO4zB5f8h8Fg29C+M0+UfLye2En/jPLlg4LWz80X8ptm4iyqstkKTfa+ItIF7cnVaCEyypBy1NWyv89fwtKUlEUycVeLZngi9nQCNANmEC0yJXaUtjsjnax8/CEF0T7r+dKdzHncPhyZbRXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YoG3DQ1A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i68piFJV; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YoG3DQ1A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i68piFJV"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E821B11402F6;
	Tue, 10 Sep 2024 02:09:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 10 Sep 2024 02:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725948564; x=1726034964; bh=YSuXtfKZ7M
	oM65a0cdNd88KI9lUWGNlUhRT82STthL8=; b=YoG3DQ1AX+GqNiL+gqfdmXsjob
	LkoRZZx3lYjnC71nTUb28pJqGpXQKVx383uoKrOWjZ4HYgTlX0peTkOD1LRvl9Jv
	p+QY+W8KNkfy9Nr8uEQJdxL9yuGHPKjpmgmhh4LGI3z6iwFyDJJU6acJgqL5eruJ
	wZmcWHNNQ0docZDFGIDFIaXWa2HCk0YXr4kIWPLtoPAtzs3VvDPLCWIxHg4C9cH1
	98AI1MDPlXHd62OHDnEWFyipCgbFPm7MwsAm4JByGKReMFA+Wjgi5/zvjo2WPlnu
	+trvFaY1bRHHP4kQ6wqyAMr/WAI/vkWGPIxPUJIIP3O8ZQqjLyyEmxwwTwPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725948564; x=1726034964; bh=YSuXtfKZ7MoM65a0cdNd88KI9lUW
	GNlUhRT82STthL8=; b=i68piFJVHkUDD2I1aPkPtkE17GNUmBkqe8gZs8kojwDG
	gODWLa3irJhTGDhFYEqpIs6YKK+5yE9wy/2xvhTDZMZAwOcpXIzGzDaVQMw/xft5
	DUBTOI/c4wS4LrOF3vWqkgyhmuKFUORvnxOcqWfIdF3BB3+UcQJ42c/RK5HO+sug
	++l4iWQxWQK+ddSa/c/kFa033HADWp0aw7bCnmTRJpdf8fKGRv9wCSdUdMgJt4ev
	ulUhI/mfuDsKkmdXkxZT/yq1e9KcJRPS5ejXuUWjZbu4/Rvn3cloosFVhKUTt59Q
	0dar0q48mmjKjQwJ8jK68ERUPGKIAvPPfpp+yAUV6w==
X-ME-Sender: <xms:lOLfZoVwVjaUQ8WWIQ6P8wjD8_mYNpUCObk1S9tyET47yrqJ_Sbd-Q>
    <xme:lOLfZsmCdyQ0lkii5EJqViC_6H72IbaRRKsSsfWwo0pIlKrQRvLDyY4OUF5XeU3q4
    ab2u1qvEYuMhUOaXg>
X-ME-Received: <xmr:lOLfZsadD72Io8IR3AzsQl2TSX4NbToQJQfQFA7XpPprDQuMb6camtKleKhOcAQCQ4hK-Ryi1t2bahMoUS4eX5EqqDk-k7sZfr9wbMXB_W9Di6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsghrohhokhgvsegrlhgthhgvmhhishhtshdrihhopd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lOLfZnV90fLjD-nWqa0rolXwSM0Zm39Jq-xgEf5UrrTn6IdWOOp6xg>
    <xmx:lOLfZilNCfRhNAuCsFWdNX8qs8hJKosCztK4vOZDN6ZmGmwL7Zvijg>
    <xmx:lOLfZsdM-3MxNnjEj8LbktQAVMCqs3U2es0TX5bOlRCZBR9aoY2_eQ>
    <xmx:lOLfZkEMDPXozG72QtErireCduOev6xmj4pyouI1GjSbfSL9ePZpAg>
    <xmx:lOLfZkjkf5-V8NUxswJwt_Q1r1uXaMTRzf5vpA4R8yVBDaiuhhTimfUC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 02:09:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 635f8acf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 06:09:19 +0000 (UTC)
Date: Tue, 10 Sep 2024 08:09:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 2/9] ref-filter: avoid extra copies of payload/signature
Message-ID: <Zt_ikkhuMrqVcFOx@pks.im>
References: <20240909230758.GA921697@coredump.intra.peff.net>
 <20240909231228.GB921834@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909231228.GB921834@coredump.intra.peff.net>

On Mon, Sep 09, 2024 at 07:12:28PM -0400, Jeff King wrote:
> When we know we're going to show the subject or body of a tag or commit,
> we call find_subpos(), which returns pointers and lengths for the three
> parts: subject, body, signature.
> 
> Oddly, the function finds the signature twice: once by calling
> parse_signature() at the start, which copies the signature into a
> separate strbuf, and then again by calling parse_signed_buffer() after
> we've parsed past the subject.
> 
> This is due to 482c119186 (gpg-interface: improve interface for parsing
> tags, 2021-02-11) and 88bce0e24c (ref-filter: hoist signature parsing,
> 2021-02-11). The idea is that in a multi-hash world, tag signatures may
> appear in the header, rather than at the end of the body, in which case
> we need to extract them into a separate buffer.
> 
> But parse_signature() would never find such a buffer! It only looks for
> signature lines (like "-----BEGIN PGP") at the start of each line,
> without any header keyword. So this code will never find anything except
> the usual in-body signature.

Okay. So in other words the intent was to parse in-header signatures,
but the code failed to do so correctly and thus this never worked in the
first place?

In any case, `parse_signature()` is only a glorified wrapper around
`parse_signed_buffer()` in the first place, so in the end they would
both parse the buffer in the same way.

Nice cleanup, even though it leaves one wondering why the in-header
signatures have only been wired up partially.

Patrick
