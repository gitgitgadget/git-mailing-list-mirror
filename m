Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB41D1502
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731052153; cv=none; b=C6QYkfIrLIZzakig5z6OeYwOhnHQq8l9K7xA5BPgSWNFh2HDlNvZKXsWwj2hF+uuJzjL3Xknjl19BspJLz1loLVk9iCRk9XptnbXZQPVv44jFRg0vh2VY24pCqLE6wyQJfPfCaX/2f1V7v1pYM0M92nfTAXv3ivXYGiWgxfTdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731052153; c=relaxed/simple;
	bh=ssOLu3erUalnnuatutpeYFKRS3UqheiS/80uV+7WawY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TfsuE15NGD0RtAWRbznWtJ9I6RGSD1Nd9ore4yWip61i1FJr1RK9NBDYvuYJwL3XMffTn5h4igmv1FzLRKaRm9rz2hQ3gm1pkKM5ouxLy6Tlm2Q5HcGPz4RiSWDLCxCqbhoz4ar5oWPaQH3UiPR7we8jHIxvBosjRGWhvIFbIV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yo3UGy4+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O/r4+o1J; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yo3UGy4+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O/r4+o1J"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B2DA61140108;
	Fri,  8 Nov 2024 02:49:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 08 Nov 2024 02:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731052149; x=1731138549; bh=IIEowD0f4C
	tKwydfQv97ysUUTE3/OfQT9w/1fU71oIY=; b=Yo3UGy4+UO/PsSeBIyx1gkaA6G
	GL5XaxmR73n5Hx8piK9+472iT6PJbjaiRzbVQvMoKV8/yeyYQ89vnn7lx9gn9caB
	NUQmKODIdRT1FnS+XUDeAMLD7g8FJGrm3qYGMbhIwVWJTFZG+7D5jFIOB/2kJf+o
	9AkPY5RGn2sK30NWxKhkozWcwivzajbZ8295WoiJ4a/MNgs2dEs2rbZEhtyTnZcu
	dxonNQr8zZafwoahr7nEbtTkzYN//5W9lkp7QCu0n8UlXc/cHHfhx9noElfDM/4W
	5iw2Dqroi9eyr3tlIEQS3L/pBF4neVUOIZrhXQ6Dbrcp/IvMN9va6NitHOdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731052149; x=1731138549; bh=IIEowD0f4CtKwydfQv97ysUUTE3/OfQT9w/
	1fU71oIY=; b=O/r4+o1J38U5tOwp4fUhlr6JtPE322zXrQNqcOl5my5Epxjc2WE
	EkQ+iPGEwUh31eOFBbas8ynfp1KwIKDNE+M7qyrDQ8vBLDEZC8yQx10RCHAXHXxs
	EBt30e05H1fqRTeurCzwk0n8/OmnwhEedq3I8Hz7/ONAnopAylEICiExAtKB891S
	z2pXkBPxpeJKvL5idAHe0AALOei0+3QXNbyXZBiZDGrTLPkubp6QocYG08DtYHrY
	/kM9L1RWpxNHW2Q5O/eG99Q49LwPetpXrzBu3WSXjIumuCgAGcvE8vDBEQMvw3nQ
	A7NmavN5QS1iekCDoEjpTI2FkpqIIURH/Gg==
X-ME-Sender: <xms:dcItZ-HKp5uLfdK0g7rPurw22AxYe3h8HUdUbzqdR6jyO3uZ1PwCQA>
    <xme:dcItZ_WjGXRcnhlFp3WV8Q7D4oZ26gRLUwLGk8nz3wtBd3ZAKxjm1NFkwc5W0xq_K
    utqUJ1PMYP-5CNLVQ>
X-ME-Received: <xmr:dcItZ4JFdQuaws-pMHYnAgNpbfg1O8Njzg3hR_GVSA4jBoENzSMkoYmhkGGGuk2hs7TbxIVLR5F6BUGN9ZqQuwAibPnyCliJuteW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepheetvedtffegtdduffeggffgffduveeileek
    gffggeevvedvieevgedvtefhveeunecuffhomhgrihhnpehgtgdrtgifpdhprggtkhhfih
    hlvgdrtgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dcItZ4HQHFJu6iF-JEZpz7ZwyQQ-7v1ltoOG4EbNDa5WpSd70FvIlA>
    <xmx:dcItZ0VxyCo9Ch_I1oWVi-Vp4F3tQNAlRzgY30bxEmBHZ559wr9jtA>
    <xmx:dcItZ7PUng8FFMtfXZzY-RxUgE6DBaihO9qVvinZQf0kxcztvtwOPg>
    <xmx:dcItZ73zWhvyHpr1E0TescZ-ur3KhjW5H68pNGKLyQ74wVORFQ5MDw>
    <xmx:dcItZ-cpvO4DxXMZTrZqWNS7H-Kl3bYH9VqtG9yCxlOMHZ6lpm8AYIdZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 02:49:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  peff@peff.net
Subject: Re: [PATCH v6 0/9] packfile: avoid using the 'the_repository'
 global variable
In-Reply-To: <cover.1730976185.git.karthik.188@gmail.com> (Karthik Nayak's
	message of "Thu, 7 Nov 2024 15:10:27 +0100")
References: <cover.1729504640.git.karthik.188@gmail.com>
	<cover.1730976185.git.karthik.188@gmail.com>
Date: Fri, 08 Nov 2024 16:49:07 +0900
Message-ID: <xmqqo72qnp1o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Changes in v6:
> - Lazy load repository settings in packfile.c. This ensures that the settings are
> available for sure and we do not rely on callees setting it.
> - Use `size_t` for `delta_base_cache_limit`.

I'll trust the reviews made while I was gone and will comment only
on the differences between the last iteration.

> diff --git c/builtin/gc.c w/builtin/gc.c
> index 9a10eb58bc..ad80c3aed2 100644
> --- c/builtin/gc.c
> +++ w/builtin/gc.c
> @@ -138,7 +138,7 @@ struct gc_config {
>  	char *repack_filter_to;
>  	unsigned long big_pack_threshold;
>  	unsigned long max_delta_cache_size;
> -	unsigned long delta_base_cache_limit;
> +	size_t delta_base_cache_limit;
>  };

Makes sense.

> @@ -170,6 +170,7 @@ static void gc_config(struct gc_config *cfg)
>  {
>  	const char *value;
>  	char *owned = NULL;
> +	unsigned long longval;
>  
>  	if (!git_config_get_value("gc.packrefs", &value)) {
>  		if (value && !strcmp(value, "notbare"))
> @@ -207,7 +208,9 @@ static void gc_config(struct gc_config *cfg)
>  
>  	git_config_get_ulong("gc.bigpackthreshold", &cfg->big_pack_threshold);
>  	git_config_get_ulong("pack.deltacachesize", &cfg->max_delta_cache_size);
> -	git_config_get_ulong("core.deltabasecachelimit", &cfg->delta_base_cache_limit);
> +
> +	if(!git_config_get_ulong("core.deltabasecachelimit", &longval))
> +		cfg->delta_base_cache_limit = longval;

And this is a sensible way to fill size_t member with the value read
into a ulong.  Should "longval" be named after "unsigned long" instead
of "long", by the way?

There is a required SP missing inside "if(!".

> diff --git c/packfile.c w/packfile.c
> index e1b04a2a6a..46f5369173 100644
> --- c/packfile.c
> +++ w/packfile.c
> @@ -653,7 +653,11 @@ unsigned char *use_pack(struct packed_git *p,
>  		if (!win) {
>  			size_t window_align;
>  			off_t len;
> -			struct repo_settings *settings = &p->repo->settings;
> +			struct repo_settings *settings;
> +
> +			/* lazy load the settings incase it hasn't been setup */
> +			prepare_repo_settings(p->repo);
> +			settings = &p->repo->settings;

This is a bit curious.  I'll read the individual patch that has this
change before commenting on it.

