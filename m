Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3206204C26
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257108; cv=none; b=LOQKCfc/a0UXCkAjr2CvLN5WrdPaUBCCxLjif9yKuyitkaZuBf4etDG8ooWJtXcI41JHpvJaNHfP1ePGuDu9GjsVZDwpaXJpWlIhgbPXSTaBAgyBJOyrlzS5d8ABwsxY9K2eif8RCAU3LqpZeCzCDzafrJqGDfhI2r2Je1RM3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257108; c=relaxed/simple;
	bh=XRr4i6ppRCnNXLXQx+acE32sGU0TxprklMup6R0kXg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skfP/eKoIQDorDy9seMJcHZ6nzbrhO8TdnGB7Hg4Gk6vbjeAE8kahMW0cX9hjLjwedWztcnckHJT70qMG2GyfB4BYts7mByKj1S8JNxhefypbsNuBJWiWIoy41Tbu1E4qzE6XFbNCxAeqsqHPxgeIxInkne4uyjQZJ679Be9D4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jj1crNEB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dd/r6O1S; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jj1crNEB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dd/r6O1S"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id A17A111400E9;
	Thu,  6 Mar 2025 05:31:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Thu, 06 Mar 2025 05:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741257105; x=1741343505; bh=chKQK4KzbJ
	9chexrkLp3LdGhADyC3NreRPQDTpafPcw=; b=jj1crNEB2LtFubB6r/ABdPuyH3
	6d857/4GG2EFFHahnQVApvSQuu0wtIZuMle0fFhelXII+u89pyEE34aoijYg82pU
	30zRkBXdgoNCDEqFoP+2uLKZKAeVwepwTyCDt8+/cwzWQVLcEeNT9Vp6wU0DuRRd
	Xw13VmKL5Is0GRxp6nwrNSszE1g/W2GexrfYXn62vvPZWoxJy8LtPDY/t6fnxkcd
	7PKgdE0lrOnH1NRmnWNvF4hfYk+IV5JYe/4fwWam9x8OdB1mIaH3LEvoPWqcWjNH
	JIUn/8Fdi/lbrSMrH2aHNZFDXgPD3Nz8jlLVLo6CDKc2R8yNFeEhV1Q1l24w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741257105; x=1741343505; bh=chKQK4KzbJ9chexrkLp3LdGhADyC3NreRPQ
	DTpafPcw=; b=dd/r6O1SWadn1p5idZJbJxw3rYjtBpj4inoumkPE2yo6HjsdRwP
	mILK83O2qTHpFJGKfyxuEDKszckBWrd7oLSIdVQ7CcSa0UQ+Wf/TjyimP0gokup2
	k2IFopdQQCbSDVLKQTGthDUJ70AnHeUKKRoWhCSAxAkWenPeUPQ2W9ZQxcXRZQUF
	co+XH7hUeQyMijXzVaScqdHI2kJkDzFNs0+4DmB5yNCc4quCMYiRuhw3JVYyGd8A
	yPA5i47vgnhPfT6L6s9u+ndTZwrVxogsTeKw4osWiQvQfsvx7GufOHL5r4uZj9hB
	QKFQMKxs0mjK4O+hbgoi7yf+oG5x829pTYA==
X-ME-Sender: <xms:kXnJZ71g1sKF-pFGwWyIzWV11OgySYXxafCxEY5yGA_ImqfQoa3fgA>
    <xme:kXnJZ6EaY-zQ_VrMp0nLYyZYl2ZBKAsoc9ygeYui9u0tXVtIJmR7B13cR-UQsonDC
    VM6QdNa2c7w-v6N3w>
X-ME-Received: <xmr:kXnJZ75U69E_dSdCSHnzZo_YT92i8DX7cE9s9cFnq11n7rmab80pFZfjxOGGfNCRkkomLLxy5m5OAJSbf7JVQiJrWjl2iOlOwbJzBlVYLrdyLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgr
    hihlohhrrhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kXnJZw01YffY21GFU4TjpzsWjEj4zLAf2JBysvr2gq-exoo_w75EzQ>
    <xmx:kXnJZ-EITRRmIx7-dci6tqX-Z5A7JV7ANEwQmdRXGfburSPJo2siyQ>
    <xmx:kXnJZx-KGalVsEEX-jktGFSnX7gL1X89AxlhxbhoGUwo_5ysMygXLA>
    <xmx:kXnJZ7k6KZtSXgOZUstfWT8Va3eBx3d5rUHtrqwstH2GfENdAq1Tjg>
    <xmx:kXnJZ7MoJcGhIgig-GEV2o4BjF3NtRjilSNlamxA2SFNAWkR_uZeLA8M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 05:31:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f17a269c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 10:31:43 +0000 (UTC)
Date: Thu, 6 Mar 2025 11:31:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 0/1] pack-objects: freshen objects with multi-cruft
 packs
Message-ID: <Z8l5j-uOpits9r0w@pks.im>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741133712.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741133712.git.me@ttaylorr.com>

On Tue, Mar 04, 2025 at 07:15:14PM -0500, Taylor Blau wrote:
> This is a(nother) reroll of my series to fix a bug in freshening objects
> with multiple cruft packs.
> 
> The only update since last time is that I dropped the first patch, after
> Patrick astutely pointed out a flaw with the approach pursued there.
> That flaw is why I wrote '--max-cruft-size' in what appeared to be a
> convoluted fashion, but I couldn't remember my line of thinking at the
> time.
> 
> As usual, there is a range-diff showing as much below. Thanks again,
> Patrick, for catching what would be a very frustrating issue to deal
> with later on ;-).

Would it maybe make sense to add a commit that explains _why_ the
existing algorithm looks as it does so that the next person won't be
triggered to remove the code again?

Patrick
