Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830F21D59D
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435446; cv=none; b=WZvEHG79FJ6TVkEUqGBvn7yiaEi39rYY16imWSbO8FLHKm0tlIRqT2KWuyC6OtPKfdfDu815O/BFxGSdsQgcmOO6PuNAtEVHJMZr4ygj3veI51LJOKe4+j8+fIvn2E4CaaqwrRtSYqkShYXVNIuWD3YRgmyz2MzYpOYDty7y+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435446; c=relaxed/simple;
	bh=rAjAuUKGDQIyY8JhEOq+JgNntWhfWHyHzvJ/DWp/vHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHatVVablFl8As6iFYUwy21x3JGoWnQ7BtgnI5aLywJazmzpF865e5IF4BfoARtbxnSWlO8y0PcHv7cct79ja5jsv4wivOWRa5sKW/+PqKyhvQFZLhtciSJXELWr6Ioe79TWyoY63tRB7g9NJ6OTTKJ1UE2qeSjTsZIXY+9ffuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V/+Tci0F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oAeBwzQP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V/+Tci0F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oAeBwzQP"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A4FB138017B;
	Thu,  9 Jan 2025 10:10:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 09 Jan 2025 10:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736435443; x=1736521843; bh=yOCJng59QK
	38Pg6up8v1WHSXDC4lKpj2nuWc/hnYmHw=; b=V/+Tci0F70WbCJ9OyH/tYkAhpy
	RwlZu2YFmA/dLDEUKEmk4UhwBgPc6r4wNBkm/fhxPWIPHW7eKFtvAcgGJo8Ow1Xi
	HCDFQ9rdNmJ7HEgL/rnwVAsppYcsCLGwCtC+Aldd0eNU+QomafjI08CfHTsaL5C/
	O5t7TltjLuSpWEwSenMH75isLysWi9g0TKqXNEOuz2BkoYKz6CW8KPUyBUZKBUle
	r6BPXjWQaqlu8zOEhChfSDSkrIhQJiJ0spvvnTUR0O61iFrJphn+ipL6RpLgXJSE
	ikx/T+UO4cEYLffLjuZaEvh1x0TspPv9Z3Olfb0dKudeVXrKxrI8kR896hqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736435443; x=1736521843; bh=yOCJng59QK38Pg6up8v1WHSXDC4lKpj2nuW
	c/hnYmHw=; b=oAeBwzQPRa9dzqTfnmk/FJxoloERI3FyCJtFRboK+GdoINP6j5B
	DKkktCPrUzIuR+yBgZZYiAlIKrcoYoOaVV53I+pYNOBIAPBZbEM/pu30Y5/DQ54I
	+hI4xQPysSv0kssCKO9iIxI3pBfIgWRP0w7JkvUIfkQFjGXqal6cUe8HdzVUfUWB
	ua+3Wy5r7LuQzozaCg/zl+Ps+GlgvANukubRsAfMQTtmZUng+wB9jXbEiMj8P5Qf
	HxFKZSb4cJKPAS0mFfoClVNib8puZ5TUMB3BJJoLGfBq6DOVpUcyfc6vuMe21sb5
	5d3SS9nBNWW7d35Dkco8ZBEryteVrxCtVOA==
X-ME-Sender: <xms:8uZ_Z2CQRUbmUhDVHZ9TBLUdAX-o-D27Nz53E2v1L1hdA5LZSp9rgQ>
    <xme:8uZ_ZwjVygtLBW5GV-HXzHZOnfn4KSeT9AaXMjXOBxWtRzwm78nNlb44I4NxqKVGL
    -VmMJQEPXecZ0fTAA>
X-ME-Received: <xmr:8uZ_Z5k8govb8zUVhq5-QBDr6U7Pfr1P1yaaTrR8nQhod7WYKSwnaR-skhNpev7ahjjhDvtn5CFnG4gLekPjXbE19eFA16kn_XKGv4cqyWyjgEou>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8uZ_Z0yv1DgwxjK_UEfRUxeYy8571BDquofm49DODJFRShDiy1MibQ>
    <xmx:8uZ_Z7SvYAaqluICRU4Oq1qhCLZfwp66pUMsnS8kEdDD6hmXrOle3A>
    <xmx:8uZ_Z_Yj3Sf-o15a-gHTUbUqXRjSeWNNdbm3ttEhA0WOP1WrAw9kuQ>
    <xmx:8uZ_Z0Tl3JT00KqAtM1D-14OfwHCPGDfggcrNkTEZAUpOhXBwL3dZQ>
    <xmx:8-Z_Z5NYpBbTXztexVC27fOCdNbJNYFpPQ0dmxNdkCeS0YEsfZZ3c82q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 10:10:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6144a084 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jan 2025 15:10:38 +0000 (UTC)
Date: Thu, 9 Jan 2025 16:10:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, gitster@pobox.com
Subject: Re: [PATCH v3] t/unit-tests: convert hash to use clar test framework
Message-ID: <Z3_m5uNhXjdFyGJK@pks.im>
References: <20250108120339.225596-1-kuforiji98@gmail.com>
 <20250109140952.5267-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109140952.5267-1-kuforiji98@gmail.com>

On Thu, Jan 09, 2025 at 03:09:52PM +0100, Seyi Kuforiji wrote:
> Range-diff against v2:
> -:  ---------- > 1:  fcc2a376a5 t/unit-tests: convert hash to use clar test framework

Hm. The range-diff is a bit funny -- I would have expected it to
recognize that it's the same patch as not a lot of things have changed
compared to v2. Did you maybe compare to v1 by accident?

Anyway, this is of course no reason to send a revised version. The
changes themselves look good to me, thanks!

Partick
