Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087F1EDA2C
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773608411; cv=none; b=HypTMu5sgeTXmd5Q1qdI7UfZgebbHYNqpktIQeoPYp5Xu0Z3eXD9sP4a3/i+76eCQrvW4XaGFtUGrj9xE1l0aJHECFLJl+KZKVpeRS6e9v4vTVrNZrFPY25CHIo30N09wbiX1Yf2CVTSxaxmka9WrLVt2+iubYvyIknuyGkJld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773608411; c=relaxed/simple;
	bh=/DqyKkkmYJmWGZZ1D837nVtYIkht3UXMXNpsVpxsJow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ik6UIfGaBhUZk3JJwIoxhP3Ex2vWduyV5zVEAvVK9ShzHlT1qYQ90lSCJhlpkY+yQ+/RgyZ7k5/94NY/pREBPGCw87DooqPpma0j0Xe261JycKDOjaXQF8qEmCYoEJ/0L3/Pgi1U/gaWmdHp+UGShmsM9NWOMjWiNJzdi2xgYn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i574RWbj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1COk8Ue5; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i574RWbj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1COk8Ue5"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D3D4BEC05A6;
	Sun, 15 Mar 2026 17:00:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sun, 15 Mar 2026 17:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773608409; x=1773694809; bh=8auE7pLuV5
	QAdjVRtaEv3F/SkDMGqaSrmCUHoODC4GY=; b=i574RWbj7IeebpM0qzquztEfnV
	+S7qdn1SIX/DR3JFu2aGDyXfBvttsHVEztFAKKalkZs+zUAIaDyo117zmtB5zCMi
	lkf9naJnP0l9RhruzZe4MELJ4tNVBie8bDXRS0qIjQ7qLpIWkWakT/4bCTNTvh90
	oGI23AA0xGNnbudsFDRcQT5TqKMYHs971/l7Q+up3jrkkYprtlaH3OX7oeS31MRI
	LlbmPXfk2W3SACkiNuy9IeCCpryWskukJgimolC0yftFItIAU1xnjei+b4z/alRK
	SFzRmcvm+vDV47D4N2m9dp2NexWaAdz0LyevIFKbTJUtu4q0Jmkxishqet8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773608409; x=1773694809; bh=8auE7pLuV5QAdjVRtaEv3F/SkDMGqaSrmCU
	HoODC4GY=; b=1COk8Ue5deo+XXkGwrCGXbnjWPZSxMM90xkCim/CEKEaeG3D5Xl
	zKoVprZhciiexMb3R90x3SeVUzgpWo2gofAeHW1FCDGaHPmeVMDcZwV7pk7M2j+N
	PUkAJAonok0TS1vnjkJwycv44TfZjPS8CJx9Co4ouRvWwtlzPaWwJ3U41jnSiqVo
	ifdn/Bz455IvA7hWjBRLtzBcVbu5BpOYcBjGEdTl3rOrUVg9td8GxeXSCDPVZmxq
	it32dzxP/tHFCEmaGN4fE8WPK3BxOAp+nKx1Mnr8ySpkekygz0ra0iHNIiNSP1Ev
	KaCVcDTEc7XJLcKB+8VJYkbgdDsfawQbCOg==
X-ME-Sender: <xms:2R23aWxYZRMGPU5j7n61zvT6pQekMtllyv1lWCsvsHzo5RbxJyK2jQ>
    <xme:2R23ae2U8_K2L389Q-OUi64dzwPPDXjTzRA7a5RzTf_enSonyhqRESNV1zsa29M4t
    SPqDz_SP-5TpnlhyzLaqZB1c62byXSu7xEwhKGQskkrVRdnX8ruMG4>
X-ME-Received: <xmr:2R23acyPpY3fs43H9k7kxjBMr7Hj5Jw4kJFLH9AHJMxV0gIPA4trqHZ-LYPkk-2RXXCuPyZqYehNs7drfdyuCekUqVLkoBVAIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleeiheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsoh
    hrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegvmhhilhihshhhrg
    hffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htoheprghvrghrrggssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2R23aTWDNLdyFQd7sX4EkeL7KUGtvSbe0a64u1_WxJuJtucmhtIAwA>
    <xmx:2R23aY9TN3Yiv_QucOccIzXaHmLatGLtYxnaeKpvROE6YNj_Thy6YA>
    <xmx:2R23aWuFd-0qWLAsQ2iT9cN_CZqnY0Xz4VEqvuezJodfGcSe_8qhhg>
    <xmx:2R23aY1ZJtqDkJUN3k-rHS-IxSw3Jboqky9a2Jq99YRxcNs0g2RMRg>
    <xmx:2R23aZXRf8zaeAF_1_whU9x0BK66qH7AE7x2hjL7vSTgSRi8sJGu8pJR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Mar 2026 17:00:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v3 6/9] hook: add -j/--jobs option to git hook run
In-Reply-To: <20260309133739.294555-7-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 9 Mar 2026 15:37:36 +0200")
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-7-adrian.ratiu@collabora.com>
Date: Sun, 15 Mar 2026 14:00:03 -0700
Message-ID: <xmqq7brcst9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> diff --git a/hook.c b/hook.c
> index 815b299bf8..299cbf9e97 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -567,15 +567,17 @@ static unsigned int get_hook_jobs(struct repository *r,
>  	if (!options->stdout_to_stderr)
>  		return 1;
>  
> -	/* An explicit job count (FORCE_SERIAL jobs=1, or -j from CLI). */
> -	if (options->jobs)
> -		return options->jobs;
> +	/* Pinned serial: FORCE_SERIAL (internal) or explicit -j1 from CLI. */
> +	if (options->jobs == 1)
> +		return 1;

Hmph, puzzled.  

Shouldn't just -j1 but -j12 from CLI also trump configured
parallelism?  Which was what the code before this step already did,
no?

>  	/*
> +	 * Resolve effective job count: -jN (when given) overrides config.
> +	 * Default to 1 when both config an -jN are missing.
>  	 */
> -	if (r && r->gitdir && r->hook_config_cache)
> +	if (options->jobs > 1)
> +		jobs = options->jobs;
> +	else if (r && r->gitdir && r->hook_config_cache)
>  		/* Use the already-parsed cache (in-repo) */
>  		jobs = r->hook_config_cache->jobs ? r->hook_config_cache->jobs : 1;
>  	else

