Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3C21CC79
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587358; cv=none; b=c3xReq6518bfo+yM2aqMs7wjWJrdOgC69B4xOp5/9wZD7YzP/79/Iym8tmdQ8TLtRyZINGDMH6aT6i8sF826+8j7SR2TtpoqVbhgRd6hfvCk8sDzTzi4AG2hGJ1EcO2uE3xbqYt3NzCxb1ju8mjYji3eSfITScdccekJL9H1hqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587358; c=relaxed/simple;
	bh=4A6diP16T5WMpUpB02a42WYzmTPFu6U21fOpl773fFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2D4W+QqFW6A9IrhK3koFpyydd9zocjO9f/8k1zFhoNxY5/FM049soUnqYIJh5PMtPhnGj3XGHFozzdqnoUm7EgMoZXNBTTDm8iivpDIMIdnCnpFDtE5/Eo98TDzgjMit0H7E+if50GPX46qqsnJW7pnKcTmhft3OP0CRXWy1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AiUF+8yJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3azwP89r; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AiUF+8yJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3azwP89r"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 41BDC11401A8;
	Wed, 26 Feb 2025 11:29:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 26 Feb 2025 11:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740587354; x=1740673754; bh=nmy7QYZqLc
	Y1q9LVmxNlT86o5I+Gel4g/PDaBrCNxUY=; b=AiUF+8yJ4VnlEtBKXuohamv9Lw
	/Q6Em34UD2VYQgnoe87TO5LVwpdA9kP9gmGRTxOXnpjONtDYDI1nAuI60H7qWcwC
	uf1P2a0qyIVRmWFK7nXqgn48Bx3uooxumTB8X8aONrYwtV4iXOI/bDHBc8xQBjPO
	V14XhMmxwtoJOHb5RrsBhVYN4C4ue+hz7ukrFvAA+UHYeYBUe53d9thtjqlHaFzR
	5rWuYMMuBtAz9SXzUIAtmDU55e7QclQMRHxr3nGgIv+iftLfjtEwCIObcZ9MoVXP
	45VANBaDQPcoigfqNwuM0FjatvH1Ox/gpQRms14zMWCW4uhm0Og+ksVNs6Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740587354; x=1740673754; bh=nmy7QYZqLcY1q9LVmxNlT86o5I+Gel4g/PD
	aBrCNxUY=; b=3azwP89rYxXiah0RLI0EQB2I+09zk76mMM3/T2iPClwsGcfX/ks
	JlDio7qJShiY778Q8ICBhUty1p1QUiMWKyGIaKCfUz1yEo/3mDTBfXvY8R09eeAN
	e1YKbWtU5rDxTJ/LDJARtjaxrlUULeUhML4k+h8bZ3da//uByn4g6O5Bm8y6SUEG
	YrjADANZr5fNBo+vclmJj0GtmGEIA7LSEwZasde8l1o24zlkT68T8cKqVMXKx0mU
	gAiv3lwUziBau9RFqTYfYnMPu+3N4BmONRkHvKs4Ab3Yo1LUBVBrrDJn+MXdTJPB
	7ySIKTYfkoDRWa32gNgsOX1e3oqeAEO/NQw==
X-ME-Sender: <xms:WUG_Z8PPvw8lexrgm3NptnUubYkQ9fZ9utXEZnQBtWxbErfAyW0l_w>
    <xme:WUG_Zy_EDvNAGCRTQDEh8YuqALUm4p_A4NlkBgqYgRh1e48cFN5px3CsvOYUIH1sP
    IPrrcvH2_dilFj9SA>
X-ME-Received: <xmr:WUG_ZzQaQFb2mEZCHo3R1CiVrEBfDRvZE3yDoY9ZUctuDFnKi5pH16WRKBln4eYe5fOpRw5I4rfXM4h5_gFN0XaLUJXAQ3B7c6tc9QbgQuKXIaJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekhedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvefhfeeftd
    etleeugfdtuefgtdekuefgleektdehgeeikeduudeuveeghedukeffnecuffhomhgrihhn
    pehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WUG_Z0tMqdXDJNAqUEzfgzxRwBIIhJ3_ErDDWd2ET73XfxmofE5_zg>
    <xmx:WkG_Z0eiCK8yJ_V1TG_GCRF4Av7PJya5t4_9EGbp5G35aOWuExLL6Q>
    <xmx:WkG_Z41-0_QbhiG_ZB4_jFlQC16L-oJXAf_2cIPPR-XAMT9M8oornA>
    <xmx:WkG_Z48hWaSd6aDoJdw2kuBSYm7lR2MAFYdP3YItjO3iEmWfIC0YyA>
    <xmx:WkG_Z1oR9TaGnuA7xdM7uVffHWbCkZj5ulc5KCcvzcZq8Yy_v2kLZdKr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 11:29:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e8686c0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 16:29:09 +0000 (UTC)
Date: Wed, 26 Feb 2025 17:29:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: win+Meson test failures due to ps/build-meson-fixes-0130 topic?
Message-ID: <Z79BVcFMdCpgbKqM@pks.im>
References: <xmqqo6ypiz9w.fsf@gitster.g>
 <Z76qYgV7B2eUJHiP@pks.im>
 <Z77EJRJwPDGUglLk@pks.im>
 <xmqqh64gg0pu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh64gg0pu.fsf@gitster.g>

On Wed, Feb 26, 2025 at 07:55:09AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Okay, the issue was in 163a3e97ac1 (meson: simplify use of the
> > common-main library, 2025-01-30). In that commit we stopped using the
> > common-main dependency for a couple of binaries, including
> > git-remote-https and others. What I didn't realize though is that this
> > also made us not use the linker arguments anymore, but those are
> > required on Windows when linking an executable.
> >
> > I've kicked off CI jobs on GitHub to verify that the revised version of
> > this patch series works alright. Once those tests pass I'll send another
> > version of this patch series.
> 
> Thanks.  What is a bit more worrying is that you earlier said your
> other CI didn't notice anything funny.  Is the reason for the
> non-breakage also known (like: the two CI jobs build things
> differently)?

Oh, yeah, I forgot to mention that detail: the jobs failed, but the
failure wasn't reported (see e.g. [1]). It's a bug in the CI setup
itself. I'll send a patch series tomorrow to fix that.

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/jobs/8996075448
