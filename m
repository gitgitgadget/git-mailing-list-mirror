Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C4C2F83B7
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728877; cv=none; b=rDL0ZEwaeSP5UYJH98YiH+aQcbvd7my5ko64Xt/gWhDYPp/JEcGSI8Du8ISEF+pz8Vo//+Rd0/WsRgXeUih2RUAtDpOzLjQwLH1wpMRrB29PDNMBdKIk1vQip1+P+CTi1ZXRDxOqqdlauGRbe/oHlp2BPoEXumNclN/iFwlTjyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728877; c=relaxed/simple;
	bh=NwufafdYyAZwkQKlX5Bk0FpdWMZ3R2Jl1xuULyj9PKE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7Q7d2qhPMHWRvd9riSaGNAldqDoqkvQLyzbQ24YHXaO/49nkmOnSAyTXNGn9KTfwovxRq57uULLjnA5XGhO8HFGGl9MSWF7Er6FBGYLZVFRPK0osIKXTPlW7uhJuWIqgaYd4w4+8zRQw9V068uJ+XOvGMs/5o8X7XJhpUBc8Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YLT8lXxA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sxSG0M+1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YLT8lXxA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sxSG0M+1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 32383EC0304;
	Wed, 29 Oct 2025 05:07:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 29 Oct 2025 05:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761728875; x=1761815275; bh=Y5RsPuaouM
	iUrIyTtM/IAzwjboN6WbifBTJHOEEsB7c=; b=YLT8lXxASn5GREAKBwOD3/XoAo
	Le9Rj7bQlaFlfRCOsktkb0DS2aEx164TdnzYtJxSN4ApRKO70FTcxcn27v0G7gqq
	V9e+fjnj7fiAZp9IwT9Gt5mIL2k+0BzLFG/xips4hdEKorV3MP2OR2PhdV9QUczp
	UTPah1RibzCPFPBeYL1L5D7qM+Hz1YTSJAeJw1UzDMjOw+6Pdk5+NRSli6S7GAYW
	NI2EJMwLXgvPaGYt/zj6G7fuu5e7OEawK3gKG38xaxCS/2sRVgC9PJuUOAx/FQOn
	2RojEgyR4aHg4oyD6dgg8HTOpwEDLKta1KCayItahLSiw5k43Y+YC/DHG0WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761728875; x=1761815275; bh=Y5RsPuaouMiUrIyTtM/IAzwjboN6WbifBTJ
	HOEEsB7c=; b=sxSG0M+1cDyMwl4Y46wI88/ApSoFtiIUTlbo+8aO5d6PrhmyFGB
	GYeECWbLsxDIEDtNEz7SwVmSi/FQ0eyX3q7y+gI58icb6d5Aotx2VePxbIpkJXZS
	Fif0o65EqGGHfuInUfblOLfu6NscUJ+lo3ANqNJH4uEpaABhnstRUNf0H0aoJtAA
	CRs9wkCVyClN/uCT5Ir0299FcqYfOGkJnHv7zJI7ZB/pcj3K1rlgKvAQaCivwivl
	JUrye39qhHGr/r92ViLt348s2ueIOKUpzV5KGQ/pgTgPQUF147I0xLxRrAVbx/x1
	yRADjbxw/hLrcCBSjV886Lpc86PY1LJCcBA==
X-ME-Sender: <xms:atkBaZht2-Pw2zEO2nRVdIeNwrFw--GMtsNOSfM2lWWzgsx_gOYLGw>
    <xme:atkBaVD6MmTDx-2SxPUBI6d_0PStGvQi7TcZndgRXoAO-WZLeZWS1jb_4NOhOfdkF
    4a5jqkavipF0XfR1Sp5JAcyi6IxH9gKwPxjDr9nyTpKPcv62XyeqQ>
X-ME-Received: <xmr:atkBaeGBQgahyZ599aY7KjFJBGtIXpw-UR29KmItPAHAjDKM_o1-NU48tbncaX5NGU0eaptwQDJeIgzdk-0zGR0Cq8ce4u1J4WdlYXZXbfY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ehkeeffeeggedvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvght
X-ME-Proxy: <xmx:atkBadKAjR0Qxfu_1eJVACctRvJoJKsnqHLxkUDEXw7J1oavy7ziQA>
    <xmx:atkBaSm71UGqPMueMDrVb-FW8IgnyxhW0Zg6h0Vt_cMdltKkIIxN4g>
    <xmx:atkBaVTUiXQPVsXlccMzSNnQ3i6O1SxkCKoF3s4Y5Fw4xPnMHRAG_A>
    <xmx:atkBaULzzZAP8f66Ls5TIMKRV7fuSeS5HPk7QOEsfIC_Bq6v67WP6g>
    <xmx:a9kBaVXkK-c8NBjEv2YTpKP6ZndvW5bSdjyu54K8ZjIePSvdMwZ3AAZj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 05:07:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id edd1eb4a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 29 Oct 2025 09:07:53 +0000 (UTC)
Date: Wed, 29 Oct 2025 10:07:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 11/14] rust: add functionality to hash an object
Message-ID: <aQHZZuOGELzc7A1U@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-12-sandals@crustytoothpaste.net>
 <aQCKYtvzaP6SXmDE@pks.im>
 <aQFlgIJ2asBamlQT@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQFlgIJ2asBamlQT@fruit.crustytoothpaste.net>

On Wed, Oct 29, 2025 at 12:53:20AM +0000, brian m. carlson wrote:
> On 2025-10-28 at 09:18:26, Patrick Steinhardt wrote:
> > On Mon, Oct 27, 2025 at 12:44:01AM +0000, brian m. carlson wrote:
> > > In a future commit, we'll want to hash some data when dealing with a
> > > loose object map.  Let's make this easy by creating a structure to hash
> > > objects and calling into the C functions as necessary to perform the
> > > hashing.  For now, we only implement safe hashing, but in the future we
> > > could add unsafe hashing if we want.  Implement Clone and Drop to
> > > appropriately manage our memory.  Additionally implement Write to make
> > > it easy to use with other formats that implement this trait.
> > 
> > What exactly do you mean with "safe" and "unsafe" hashing? Also, can't
> > we drop this distinction for now until we have a need for it?
> 
> It's from the series that Taylor introduced.  For SHA-1, safe hashing
> (the default) uses SHA-1-DC, but unsafe hashing, which does not operate
> on untrusted data (say, when we're writing a packfile we've created),
> may use a faster algorithm.  See `git_hash_sha1_init_unsafe`.
> 
> I can omit the `safe` attribute until we need it, sure.

Ah, I completely forgot about that distinction! Makes sense.

> > > +impl Hasher {
> > > +    /// Create a new safe hasher.
> > > +    pub fn new(algo: HashAlgorithm) -> Hasher {
> > > +        let ctx = unsafe { c::git_hash_alloc() };
> > > +        unsafe { c::git_hash_init(ctx, algo.hash_algo_ptr()) };
> > 
> > I already noticed this in the patch that introduced this, but wouldn't
> > it make sense to expose `git_hash_new()` instead of the combination of
> > `alloc() + init()`?
> 
> The benefit to this approach is that it allows us to reset a state in
> the future if we want.  If we don't think that's necessary, I can
> certainly switch to `git_hash_new` if we prefer.

Hm, fair. I don't mind it much either way.

Patrick
