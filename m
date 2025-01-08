Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29868146013
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350781; cv=none; b=pcAq6ydH7vV2Won638cCdKSQJxv5Xi2GEiW2pehefcxULXJWdLkAs5FLQ3uWafsziP45AZhmWwu+kDl1eU/Rl8e5G4FvOFpszlju97CuedI0dcZARK3QAsd3kJCRRdIRkqP731B7bkgMcSFFqCRd5aPonrknTP6nD11i2Qgsla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350781; c=relaxed/simple;
	bh=xlixqjVuQnp2eDFxrYYOsULIRt1IY9cQu3psbhZd3KU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O/djFExJXvr1LzyUM0J3KZtRDwyGUfX62XWKHgqDvASvfU0c0RwiYMi/h1wLu1gD26HOjdxrQZcaQxgR68iJwhXs/3iO1k0CC6+eXkif+aaeQ3esSapAKbUbmEsYJgdIfGcE1aErr/chIk47y4Z5rrpCVNEnukBiDt2TkS4v+to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e72CZv5v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZMGlKSmx; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e72CZv5v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZMGlKSmx"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 30051254017F;
	Wed,  8 Jan 2025 10:39:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 08 Jan 2025 10:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736350779; x=1736437179; bh=NRfzR2IB9U
	rMyyrUSwuCT8mgNscYR3I9DdDjxQ3i/m0=; b=e72CZv5v0igUMCMfDxuxXKcTro
	ME9Eo4xhXXriO9k21JB3opFqJZYiMX8IHv2iO2dkau/pZBtwk6vhNEMkmf2MAqLZ
	HiqAqG6nAgMmHBftxeLNarvm7rliDsvCLjF3/itZ/SlR5ljj5ANBOpov6ac3K+oy
	E5R7DBbOzGW4V5Mi59AbynvJOzEzEj0c1O/AnIAYLoGeLosWh09nuOexvDR9/ouN
	1mN7hZFlWM/LBckSbp0X2qoslA4wC43U0IEZk6x+9TLOCp4hU3eDY7RUoVRSFIUg
	Qny2Hy/uEUF+YYVc8w+XBcYuPo5Tyey90KPQ9A4tnESmLzfMNR40N+tjn0rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736350779; x=1736437179; bh=NRfzR2IB9UrMyyrUSwuCT8mgNscYR3I9DdD
	jxQ3i/m0=; b=ZMGlKSmxo32PSCb+EpjtkfowIBVmEsIH/S/LL646/s2BLQOf2jH
	cL1pqlb2i+p+iCC4abPQQbsh1QUctqTjj0uMJGoz17losO1iz6lHuEfT1QgUKndj
	cIGTbVZBHyHc9S0ZKGNz5RfuvflmhC4NI8pZt8ecjmzVFOv/7Grd3IXlXa1WamWE
	DASfYmwA//4CSG3pGdiCKQXtzAk5Uz4IAQ9pGvlARr3rGoGE8Lg5KgGurq8Ca+Z6
	FTzsRLKlU4G/zUe28dox2UMW77mdausdP4f2bhsd5jWGLWo1HMYUtQ2mlhsDyNlE
	4kQqbQFVdoCYDJ/ffBMhaIco2CS+7Q+s+mg==
X-ME-Sender: <xms:Opx-Z5Pn9EDY_JFNt0LVjaQxHu35y-uSI3Ke23ZETYfkXvVfMXFDOg>
    <xme:Opx-Z7_Hzu2HX8k5bG7v2797BiT4-v56BtlAhhWulGYjKgyCDnqwowR9Eo5d9t1ml
    eflk_cm4pxYxIq2QQ>
X-ME-Received: <xmr:Opx-Z4T-9MWNs0KmpATuEcf1dnV9Fpct9_VB3FELw7bFuv9-6LN7OLsVrb9QypNciPTQ8OXX1YMdVutSORTDegvMQiXVBAoIwj26>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Opx-Z1tijsRI6WyvUEkS-07r5H5HrZfhyMKtQ0QSGK5zbY32pZ_Edw>
    <xmx:Opx-ZxdnJW8RbYHf4jZSyBRiOlHZAUgEbuSPWbW62K-pDzdm53NUzA>
    <xmx:Opx-Zx0rpmlNgWkqiR7TlZpyqL3_Bh6ebLfTCLYL6CyVbWaUFEVpUA>
    <xmx:Opx-Z9_61Z07DqXlfOTdk2RuyQyv7TLUrHocx4-fMTyCZ0rLViWTiA>
    <xmx:O5x-Z45mklfAxeOmpIVR0OvGhMDqWwE_MABqDSSEy4emYyCbU8zy7VnZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 10:39:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 2/2] reftable/stack: accept insecure random bytes
In-Reply-To: <Z34gfa-_dSbWD19h@pks.im> (Patrick Steinhardt's message of "Wed,
	8 Jan 2025 07:51:41 +0100")
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
	<20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im>
	<xmqqzfk2qr62.fsf@gitster.g> <xmqqv7uqqqu9.fsf@gitster.g>
	<Z34gfa-_dSbWD19h@pks.im>
Date: Wed, 08 Jan 2025 07:39:37 -0800
Message-ID: <xmqqr05dnwli.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> It may still make sense to drop the first hunk, and consider how to
>> proceed when you further want to reduce the unnecessary dependencies
>> for external users of the reftable library, though.  Are there
>> correctness implications if git_rand() in format_name() yields non
>> random results (like, always using "rnd = 0" instead of calling
>> git_rand())?  I seriously hope not.  And if there is no correctness
>> implications, perhaps we can replace it with rand() or even constant
>> "0"?
>
> No, there aren't any implications on correctness in that case. Sure, the
> randomized delays not being randomized can lead to more contention. But
> even when the randomized suffix for tables is deterministic we wouldn't
> have an issue as the files are still distinguished by their update
> indices.

OK, so they both can be turned into a simple rand() that is expected
to work more reliably especially on more exotic systems (meaning:
the ability the system providers can test their rand() is much
better than our ability to test our git_rand() there)?  It would
help us solve the immediate issue reported, while removing one git
specific function from the reftable library?

Thanks.
