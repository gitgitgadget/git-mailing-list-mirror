Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBAF296BD1
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442325; cv=none; b=WUiIlldZ+/mEcfrJILc11pHksQIxa+VeNemR2PXar9uWxbcU5E1CWh9mImVEScNxoOY2wTBoXIP29s1occCJYZIgBkefbUsrKDbd8S+ZC/eV3cnUtMLQtWmyAQ4PCHrdGEJE6VegKeBAWfD10/NtkPxRJ5Ps49jJT47WAEgea4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442325; c=relaxed/simple;
	bh=O7hWZWCpkL0EDnFPldyZKB+AdE2yPqNCTBHQ6gA3uuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE2nTtWcPOmS1vZOXhzmi7dnJ6kl504B77AS8DV5/SMRK21JKvA2hifKrCva8QsioqJe84dpsCukVC4bu6uVvV0y1GzqCA7irNHJOwVxmvKEB+7Dq0RXEFSyfG8BHFY8vUI7mloYMH8aJCnUtUAAryeN2x+GKcM0n1WpVPXjKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j9z5E5r9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MLO9qwpN; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j9z5E5r9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MLO9qwpN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 15B067A00F3;
	Tue, 14 Oct 2025 07:45:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 14 Oct 2025 07:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760442321;
	 x=1760528721; bh=jnetP7dE9u22ipQ0XBthjq+q9jrVi1UJVZKdxCry6P8=; b=
	j9z5E5r9rMhXohAWIEQyA1Kv1hhL8FXGw0UUkB310IIOHe1gmHLNgKNBSHRNwhcc
	BKzpvJdlukaulgn1KC7dEHpe2LhDewogDIlxbh/l/FaHS95gpIii3GCCbsZlJwKr
	yNxRuyLUjmLSESwxQDDYnuykJjmRCP1DlO4NT+XDmKDYp9/ex4i4xZTwic2gxIt2
	jJxLWtx5zLXvwh3wpINcK8BCj+WRW6Pg+NkxpYbLMEmqB/X8/BQSrGojm2zYP9a9
	kNX1XB4A/RsXrGDELa2BBDFBxWVzk0s67blsnl2MwxijNE69zppSOm8yqmKl03GO
	G7PSPg71FTxFG003meWQWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760442321; x=
	1760528721; bh=jnetP7dE9u22ipQ0XBthjq+q9jrVi1UJVZKdxCry6P8=; b=M
	LO9qwpNkhG0PuLanLeAiPZfCd46ztliJdISOgN2oPJpP1OAXytuoL5ndxD888p7s
	JWW5NMwubabk1a9vvWWnhsGgZsEDBl3p+AvP/AkbTLn1gTCrYMHb9yoeGs6nT0jp
	LJoiC0gcXNdkvQ0VRqTKnWNsYKVG5J0AoY6uCipxTiLwU+TpZRO/sBY8eu92eTV4
	Rju2aK6jG1jYeG1ne1q/yvMdu09chebkrw9HT8g/tRcMXFo7NC8VArgDFC6OhrVX
	jJNu42ZPjRl/lIih8cBzPbfzUPTlOJyV9ZebwHBmWUSxdiE6pwwYGmON94GYKLJA
	vt9O0CHVFPWhlzN7OOr7w==
X-ME-Sender: <xms:0TfuaEwkyYBk7CFd8UQIaLSKJbLjbmWPTLjdQrcf3jRc-eyVBK9CYg>
    <xme:0TfuaL_9weEjLtACfgiM1PTLm64i9ZDQk3owiL8NerKWr1gjA5LKOyofOkTW3AJvz
    I1kVqcs-pID2Q0cdkEXbVVMrxWHurigoat2hXoxo1lEXR7cQG_z6w>
X-ME-Received: <xmr:0TfuaAL_aUBGAVNkSH5y9jQZBnJ8sQdKgO4vEd_zxS8E1eWswGc-NhsW24T2ths38fZW35IbUqBq36ahNHMwqyhOy0ESVcpTEXapedQ-qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggv
    nhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggr
X-ME-Proxy: <xmx:0TfuaJfPAl7dFE-Xdpb2X5LrQss55GC9H8Hjh2kp3-j0B3KtQ-Iqgg>
    <xmx:0TfuaH_cXUVa7XwF7BiRAMbJuedM2qf3XthB-6KQVjUu1TcDqTJ_OQ>
    <xmx:0TfuaOoaVdPy95FPWMUMuQQcAc0rblcqAH4vyOpdOj1-zb1zz_CSWQ>
    <xmx:0TfuaEAoKzsVg_ZrLqPdoyTPLzN6irxdBVVrySx_MordopSs_SJSTQ>
    <xmx:0TfuaGV1id1ozBPjQy0P0uUffwG5_MWrXNIotkd0eiAdqn5GDdJOB11C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 07:45:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78d74b56 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 14 Oct 2025 11:45:18 +0000 (UTC)
Date: Tue, 14 Oct 2025 13:45:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Julia Evans <julia@jvns.ca>
Cc: Junio C Hamano <gitster@pobox.com>,
	Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2] doc: add a explanation of Git's data model
Message-ID: <aO43ywdCKXWchRqG@pks.im>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
 <aOjzQ7-88m5e_YJl@pks.im>
 <xmqq8qhe5040.fsf@gitster.g>
 <aO3jbnXRI67JsAx7@pks.im>
 <46c6ca15-c1d2-4dd9-a6d3-2538f482b475@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46c6ca15-c1d2-4dd9-a6d3-2538f482b475@app.fastmail.com>

On Tue, Oct 14, 2025 at 05:18:58AM -0400, Julia Evans wrote:
> 
> 
> On Tue, Oct 14, 2025, at 1:45 AM, Patrick Steinhardt wrote:
> > On Mon, Oct 13, 2025 at 07:48:15AM -0700, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >> > On Wed, Oct 08, 2025 at 01:53:41PM +0000, Julia Evans via GitGitGadget wrote:
> >> > [snip]
> >> > Not quite true. Pseudo refs are outside the hierarchy and are in fact
> >> > treated differently. But root refs are treated the same as any other
> >> > reference.
> >> >
> >> >     References are stored in a hierarchy. While most references are
> >> >     stored in the "refs/" hierarchy, some references with special
> >> >     meaning like for example "HEAD" are stored directly in the root of
> >> >     the hierarchy.
> >> >
> >> > I don't really think we should get into root refs vs pseudo refs here,
> >> > so maybe this is sufficient?
> >> 
> >> I do not think "root ref" (or pseudo for that matter) is a concept
> >> that has no use in this context.  If this is really about data
> >> model, where you find refs (or what the "pathname looking" thing
> >> exactly look like that names your refs) should be immaterial.  It
> >> does help to know that HEAD is just a ref.  It also would help to
> >> know there are symbolic refs that point at other refs, which is much
> >> more relevant to the data model.
> >
> > Yeah, I don't necessarily think that we need to mention root refs here.
> > But what I think we need to avoid is the following sentence, as it is
> > misleading:
> >
> >     References are stored in a hierarchy, and Git handles references
> >     differently based on where they are in the hierarchy.
> >
> 
> Why do you say that it’s misleading? (what do you think it’s implying
> that is not true?)
> 
> What i’m trying to communicate is that branches, tags, etc are treated
> differently from each other and that Git knows how to handle them
> based on where they are in the hierarchy.

Oh, I think I managed to repeatedly misread this sentence! I was
basically s/where/whether/ and thought that this was saying that refs
are handled differently depending on whether they are stored _in_ that
hierarchy or _outside_ of it. And that would have been misleading
indeed.

But that's not what this sentence says at all. So please ignore this
tangent, sorry :)

Patrick
