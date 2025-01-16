Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11091DE3DC
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028202; cv=none; b=OO8B6kwaExgSlYAVw6GQs3xuCoWhgyu2OZI3cPpPKoEsejI6LotE0HmbwXSwrgCPr2AaKuDIAWCqaaLnsZCIPWlY9JUOU+PxggBDyFHdzou9e5xFXDPZPhGjcPSLoqcbWe/YUBXZXY765JmvJAvIZqk0xpHVi8E7T+z5JoC7eWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028202; c=relaxed/simple;
	bh=eEmwsmJv71l/ET4flT2WUF2iE/iI2EhrouIkENodTkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLq6/ynGEsF04vK9BeMQ0y7+wWShtzyxTN1l9kIrS/jyxAVpPFzuuJiWYKO7SSxRAy4iUw9wSFFuYaGQES6svEhMS9vcrTHahpi5rmbAVxKuG7wGkjyv5/wSDK6el2wRJmm+MTYFLQe0hSassTFqiWk3+sHkczM/batmXY/R6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X6oJloqx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tcp1adXo; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X6oJloqx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tcp1adXo"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C176B2540146;
	Thu, 16 Jan 2025 06:49:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 16 Jan 2025 06:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737028199; x=1737114599; bh=fUn87ONdKv
	U3DolIymOEsE2rfuBWsnIKRRFGwHZU07A=; b=X6oJloqx/BxQ37o0N39ugtRPkO
	71IeEv/jVaW8Sy+5rf9uWylQZV1C4fuRXlm4mXPjJX4FhFZKkI6kehcJHAt1wKNu
	TS3V9oyLJay1o4GQ+rM+udLIDlQW58PeKgk4ApxlVF/ehQicXKY29/F1ga2yhH67
	xxmrYyki0sim3lsgNicIRQzPObJtlSIZh2EkkBuRdk2Q+lvZIDGp4jje4e3toh+7
	NMM8pUyorYkVp8X5f9+r4irGUqvt9IpxfaLUdz7e7uBJUpeww1ZuwbyMNB7gstkb
	M5970Bftyyn+NGzalYg3ULHA8vIf3ny6y5+gku7pT2qcmQUwA+GSXgvkqFKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737028199; x=1737114599; bh=fUn87ONdKvU3DolIymOEsE2rfuBWsnIKRRF
	GwHZU07A=; b=tcp1adXoTmf+kj9P6duhkbocMnu3/g5cF3/DPORIL3e/k3Zuhwj
	B8NFiMGoiZgFT0ZAKbwyCWFmHKQdNODTb2hCmAgr5aEhJkLnPeWcuIErV3BlUtaO
	MkG2Wl3Be36XCnkwieT3FRuDuHXSWzmbMZ05lp7XHlxIsLwe5715ndrHoQnbHIGz
	pevBswBV1s1//Z4xg5TH4VU2VkakpSTjnkl3Gj2jlKWMjueiiiHuUmm3ixtKFisb
	GuUH4aZgU/wRR/b9LlVN4SXwkLaeliqSEfz2EQcYds1/UgVRnCbxT5rI4pxcMXCh
	8tf/AiXEx2b72EEP+gCKbiqcyVPSIpP9WlA==
X-ME-Sender: <xms:Z_KIZz-iKvHVDnK_2BNA9YQpOfAlNFw_rbCsuUzn8gMK_VNoCJEb3g>
    <xme:Z_KIZ_vK9XiXTV9truJF_1A0yNln70av9SFN8YmtReENknFHctN9wW5wJgApqqTLv
    xt4K39IpbD7gJm75g>
X-ME-Received: <xmr:Z_KIZxBHyRXmsVZ5IjPPxFJ3aKwjvJpDKWoNN4FcNu5awMiWGpCMLHSQ_VHy1ADIoea3hgF7orOlL80M7DISRajgTCt4eTMm3Lx4T3xnunnc43UZDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:Z_KIZ_cNL8REM5pwh_v0rlK0R9xZwwA9BREVQ7NsRSBjoiYFLMdm9Q>
    <xmx:Z_KIZ4OgjBy2O10-jCBWomTgZjrK_xnhKq08WEyEWeufJ7wIgPj8AQ>
    <xmx:Z_KIZxmmwJPZp7aP4c9JjPrVvPCwXqtWecIEasuG9IklaUE-sKfQXg>
    <xmx:Z_KIZyvA6j2Ug7i18dn_RhAhv9EKVn1hixeszHdDa91xR95R-Jt28w>
    <xmx:Z_KIZ33N-ddN-uNMsuFuhIyPgwufBN2UQFI-2Zw2atLY_tK5FL04u_cn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 06:49:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e655820a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 11:49:57 +0000 (UTC)
Date: Thu, 16 Jan 2025 12:49:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 4/8] hash.h: introduce `unsafe_hash_algo()`
Message-ID: <Z4jyZCAwqOjZ-u2U@pks.im>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
 <99dcbe2e7165d96e3a9c025540995a75f74b2489.1736363652.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99dcbe2e7165d96e3a9c025540995a75f74b2489.1736363652.git.me@ttaylorr.com>

On Wed, Jan 08, 2025 at 02:14:42PM -0500, Taylor Blau wrote:
> Address these issues by introducing a new pattern whereby one
> 'git_hash_algo' can return a pointer to another 'git_hash_algo' that
> represents the unsafe version of itself. So instead of having something
> like:
> 
>     if (unsafe)
>       the_hash_algo->init_fn(...);
>       the_hash_algo->update_fn(...);
>       the_hash_algo->final_fn(...);
>     else
>       the_hash_algo->unsafe_init_fn(...);
>       the_hash_algo->unsafe_update_fn(...);
>       the_hash_algo->unsafe_final_fn(...);
> 
> we can instead write:
> 
>     struct git_hash_algo *algop = the_hash_algo;
>     if (unsafe)
>       algop = unsafe_hash_algo(algop);
> 
>     the_hash_algo->init_fn(...);
>     the_hash_algo->update_fn(...);
>     the_hash_algo->final_fn(...);

This should all be `algop->init_fn(...)` and so on, right?

> This removes the existing shortcoming by no longer forcing the caller to
> "remember" which variant of the hash functions it wants to call, only to
> hold onto a 'struct git_hash_algo' pointer that is initialized once.

We still have to remember something, but now we only have to remember
the pointer to the hash algorithm itself, which definitely is less
tedious.

For what it's worth, this prompted me to have another look at my
proposal to stop having to use the hash algo altogether for `update()`
et al, and now have a version that works. It builds on top of your patch
series, which still is a step into the right direction. So I'll send it
once your series is being merged down.

Thanks!

Patrick
