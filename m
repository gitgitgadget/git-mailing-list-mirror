Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9121A1C
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 04:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728016373; cv=none; b=R55LuSJ6IATI4QxTVEz0VEvEkPnoHScYo5Us6QQPk5dfYAXJa60NhZPPUSiZlRHst7PaJhTkd26uIwZL/nM7OQEcN/stNUN/AG7FPOjpe4DoxhMeZldREU2FHqfiYhk5DBWbzs+HAofW0R+u7+qOoQCT3JPy9o9VEPaZlCFiPD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728016373; c=relaxed/simple;
	bh=RhbHrZS/+AKjY8jDjonwsexCv+vZXN2XhSXtdPGVAnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZv0z18XupGSchY6i/rrsHxKX3degcuThR60GSNoPhaRNEyXP8nLUFT/Mes6Rt2kJniMo9BOTKlPJGIuHDGfiiQC13o/KqKhUslunpSw2dPZ/sYf99fgCB5w5SBbdswvNyubpfvm1Ww11abcNFNx1nU4LnMgC/SOQveDxQ434pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NcL4Y152; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JPNKtl4Z; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NcL4Y152";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JPNKtl4Z"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB6D11140252;
	Fri,  4 Oct 2024 00:32:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 04 Oct 2024 00:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728016370; x=1728102770; bh=IlpYp9pjH5
	OB7ks5VNq0zhhCvMVeOeOzjXJaUHZcgj0=; b=NcL4Y152gQuK9AZCnG8iQtD8BE
	2lrMe/LoNYj86sY7r7Ua2IjN8vbtmsjnKGyPGUkGfhXxSFpDU2ZesW3qz0O4PAHB
	zKLYc01GqsN57qWoGD9Dntyn6yi+4dMpJj6wyhU/jzfelenXD2Lx5Fe6KG8MXiQB
	5TwjdjiWRR6JbEs3t8y7qoqSmAwoKlYVs+bqLLklPjWGl005EoibdMeqJZ64kGbZ
	zc8lLbY0eoVcP/Ok6ddYrTaHDnEhODvcOZOyE0SZtNMKMoC5xB4m5pD2iswnovy6
	R/4Aumxeg782l00lkYgyNAr4NP6Fzvp3e4EHEOaQ6P/o1lIsJC9B7MKFGT4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728016370; x=1728102770; bh=IlpYp9pjH5OB7ks5VNq0zhhCvMVe
	OeOzjXJaUHZcgj0=; b=JPNKtl4ZyGeoNRCP8nI3rWYlTXl8y+9SghZvqQCGX16P
	ChPLWLwefAeATw6KKwir17I6ge5lN4wKZpOxZfc4rbsSXg+MvMLEcmE+ZB9+PXa8
	Z/VKo2GTey4c3SR5xm+LF+tVr2fOyDAldYdD4SmyLZa4B6Bk1YeGAIK0VUfr3JvV
	bITyX/rLd3DJikLTmVe+lZ2qALKkur8qLDCD0OL0drkv0nrcCNXVg5XhIRlLEDyd
	RD7GqQDXABCGH+BDZmconeNaZzqYe6N6VvJhRDkGjel1IwppKruWKvas7Zvl3i0P
	+b1WCY89/jDh4jUv28+v0vdwvgHva1O2USwwv1elZw==
X-ME-Sender: <xms:8m__ZlxEMc9xashOBVmYM-1obDt0GpCmJQMS8fLdyKHXLZzDURCM3Q>
    <xme:8m__ZlTfKpCVGLhLvRtYTx30NAGwBmchf2sfhwsvoHI6LfnpUgUkNopaL52aFDHB_
    cP4vfrmE59tWvH6FA>
X-ME-Received: <xmr:8m__ZvXmtpfgifwJnz-u-TPmhSl6F9NY9kGTfPG0H8LZhX8vfITOgCNaXGuw7-LQiCclizxjVla098PyzF8s_wkLo1FVzhUWPIyCLjNIk5gXdDnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:8m__ZnjgH5E5rAcevAIxy6avwAziuz6KhY2bxMZGUVmp_CEAjNGzHg>
    <xmx:8m__ZnAnIqnI0vL061WJ2LB3es9caCrD61GiKxNZOkss5D5jbKjBRA>
    <xmx:8m__ZgIHIK_aWicf28oUWaJS-XHMtuZxvdsB-b9Y4FD1ViBFP4Jydw>
    <xmx:8m__ZmBZZPsEyNOlgQAOxBORJvQ2x_MZyhBbtseBSLFI7RLkzsXcfQ>
    <xmx:8m__Zi-0Q5ss-oWdlrgyjZYXNZu-jNpcebyOpKs4rYMHBhWwY9e-mtEv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 00:32:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0a207930 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Oct 2024 04:31:56 +0000 (UTC)
Date: Fri, 4 Oct 2024 06:32:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 5/5] diff: store graph prefix buf in git_graph struct
Message-ID: <Zv9v7THK8jlH9exj@pks.im>
References: <20241003210548.GB11180@coredump.intra.peff.net>
 <20241003211317.GE11328@coredump.intra.peff.net>
 <xmqq7caohhw3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7caohhw3.fsf@gitster.g>

On Thu, Oct 03, 2024 at 04:43:40PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > Since we only need the strbuf when we are formatting graph padding, we
> > can give ownership of the strbuf to the git_graph struct, letting us
> > free it when that struct is no longer in use.
> >
> >  static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
> >  {
> >  	struct git_graph *graph = data;
> > -	static struct strbuf msgbuf = STRBUF_INIT;
> >  
> >  	assert(opt);
> >  
> >  	if (!graph)
> >  		return opt->line_prefix;
> >  
> > -	strbuf_reset(&msgbuf);
> 
> Oooh, I love this change.  The fewer file scope statics (or global
> states in general) we have, the better ;-).

True, thanks for going the extra mile here! The other patches look good
to me, as well.

Patrick
