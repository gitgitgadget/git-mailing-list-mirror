Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208C43ACB
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 04:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728967081; cv=none; b=KmaRuVhkztdVqFKCtBSN8+M3SKey5wGkCttMRZNCsMLehoRcqb1NwkJdsjjmCNHmGJO909HPwwuTKa7mBqYv81qaQs/kR1IQEHnNYeKEJKYLHxPaFl5c0D/m08vlbRqQri5SZC4WiyN0FXT+BAodPa7ZFQYe/+5Le1zfl4XwGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728967081; c=relaxed/simple;
	bh=Td7iBgt0Pp8hjFciuGW/DpaZvjOVhmjlhdiozOukyYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5ivFkKgtb6RUsJtklFt+FlfDx+l/M1sh5BDonqZxI7w7OhNlBNy9dkf9qPZ1/4mTi1Lst0TrycUyUH2+fAEfgmxjKruBPv9KeGwWtng8L7zH+4EkHTiZVIKigoCLuqI3ULF6d0Ff9MvLOtxuwUqQeWGGSIbNaKXj2RsPvyx5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s7N2CCcv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pf+A6/Nv; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s7N2CCcv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pf+A6/Nv"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A626114008C;
	Tue, 15 Oct 2024 00:37:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 15 Oct 2024 00:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728967078; x=1729053478; bh=JkOuYdm1cK
	0pYyXO0fmAI2LenNLLVFXa5UtNxuFCMDc=; b=s7N2CCcv6bi1QGv1OZQLkNVJnk
	GR3C63r6V36lI0DL10xlCM4d5hM4Ut84rmzWhzYZl2DxzhUUkUn6FOM8B+z/MEY+
	oQOb8ivjqCTaD9XZdGDeNBg+Y2TY51d6CTdG+RyDkzsSSOvvTyn1Ot6JsFezf28N
	YTj1gv3Pp31rx9Gt/rw2eVjoyzYbodXbpPLDiYtoDLRoVRoT/3dA+b/lO94lkCrr
	mKWVd1i+dhGPjSXLgVBsiioc74p4tXGX2VqsDk5frIRzybiji6ekEzy5msUYn0lS
	YLbVHRkgC1KZl70852B6DlahblfzXexh8wmEYiOILPuQt41IZ8w++RLEJ3JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728967078; x=1729053478; bh=JkOuYdm1cK0pYyXO0fmAI2LenNLL
	VFXa5UtNxuFCMDc=; b=pf+A6/NvA0E/edCS04gA1aLJXrZk8XAPkMn99yxDLLEq
	rVoYRk/6zhpPKAwfSdKKePC5QwMGT8Jd19wehCVoqgFknfyIMNm2hAuZd/F1iSfG
	UW2oKjIWPJLuDx/4ACqAmFARZfXmLXLgvqp71J8l4ivklq97Mt0w2Np9WS7morCG
	YR+BvHm9y4bedKS7KzlWh+Nc+vlRCeXPCxqb5WjLG79xn70NKKlgGQJIVTpFTLqy
	0J9lj5Tp2urR/tvEov1twbKKcKC1YtjF1mExWVscw8rx0/itzfMKBKRY6tCMmB5L
	B6tofXOuUTJnfp0bNiGRW0kgb4BDvkCsGPx3C4lZxg==
X-ME-Sender: <xms:pvENZ_00rhjZjeThvZScW2ZXkXRY5lD7shwAsfomTGkoczqHvyY8mg>
    <xme:pvENZ-H5-YxugWbB7IhS1zorG_03U1khvSPU2fiBwaylDZJj4aPJeJFwgZhid7hPE
    Fb_gbN6v1f2tcMDdA>
X-ME-Received: <xmr:pvENZ_7iuw0CdsKyjxDBbMoEvu56_44fHbFLb0MrkpDDBY7CNDnn_cWId2RPoaW57NJbA4Z7LutiCTiNNyrFqryZ-xwu-D0NRo9rWgPLbLiwJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:pvENZ01G-3GMiKNr_HQe9b4U9a5c2JUamE0y7HqYhKPFgmOLz2AM7A>
    <xmx:pvENZyHhZRr4NoZZ-W1nllz_ltVtE6i6XL3T6tM7acouREbh-3UtrQ>
    <xmx:pvENZ18d9261-M1pHxDepnsiriYL0wOQhwhUcdoxbe7TWK2px-4Caw>
    <xmx:pvENZ_lszCvtp0oDiPu3HuePMFM4H-X2M4bhiV2-jjQf8itRHBD7eQ>
    <xmx:pvENZ-hB91i1JjLtXPOt_0ygzKXO_30i6vXXBV2QNZ2x4aZoT_wzCyyk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 00:37:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f710385d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 04:36:42 +0000 (UTC)
Date: Tue, 15 Oct 2024 06:37:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 02/10] reftable: stop using `strbuf_addf()`
Message-ID: <Zw3xnFN_c7WSz1u8@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <6a7333b275e9f7eab81568a8de939011d292a31a.1728910727.git.ps@pks.im>
 <Zw2b5+8Lw83ywhzk@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw2b5+8Lw83ywhzk@nand.local>

On Mon, Oct 14, 2024 at 06:32:07PM -0400, Taylor Blau wrote:
> On Mon, Oct 14, 2024 at 03:02:21PM +0200, Patrick Steinhardt wrote:
> > We're about to introduce our own `reftable_buf` type to replace
> > `strbuf`. Get rid of the seldomly-used `strbuf_addf()` function such
> > that we have to reimplement one less function.
> 
> Hmm. I count twelve calls to strbuf_addf() here in this patch that were
> rewritten in terms of snprintf()ing to a temporary buffer. So I am not
> sure that I agree that it is "seldomly-used".
> 
> Sure, implementing fewer functions is nice, but I am not sure that
> forcing the caller to use snprintf() directly is necessarily a
> worthwhile trade-off.

Another problem here is that snprintf() isn't exactly the most portable
interface. Some systems don't have it at all, others have broken return
code handling. So avoiding it completely makes that issue go away
entirely.

I can add that to the commit message if this needs a reroll.

> Part of me wishes that we didn't have to write our own `reftable_buf` in
> the first place. Could we use `strbuf` as-is and expose it through a
> generic reftable-specific interface that users of reftable fill in with
> a vtable or something?

I tried that, and it felt way worse. The amount of code you have to
write is roughly in the same ballpark, you don't have pluggable
allocators, you don't have allocation error handling and every consumer
would have to implement their own type.

So overall it's only losses from my point of view.

Patrick
