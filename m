Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2714318EFA
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973906; cv=none; b=nwsGdBCH3GuGGfB3snKt8vmwZ7ARjI54rJKCc08GGIiKAKMMNTOxSLrIFa01TUCE10vfXpS07eKQWEZZjmlyN/ulrcMjhG/te3PNG9FVtctfDhyRDvi2LyeMj3P95HuLXtEqQB1NGYT4xyEe1FIZz/EnVHuJMbcbFbIeBlTgMUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973906; c=relaxed/simple;
	bh=OmxiVl04oarlwUgJnKHtcIiCtsg2QFjFI81u4O4F87I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH77buhvdTGMwFIrCUp8jU7kh2FkJ0RLI8yN9faDQQ6GKu+3dQDDuYROTOxauZOejjVYwuGXbbGtwAXrTRf7GX3ZMmYVkZ8R/z1rIc4VQYjAmcVUlwV9Jw6QmH4CUFhgrD2D/g+xksxdyeOct2RfzxhYXMd+wnp6IyZ1stFvA4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EAouztDf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ON+nGkHf; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EAouztDf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ON+nGkHf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0DAA57A0061;
	Fri,  9 Jan 2026 10:51:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 10:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767973903; x=1768060303; bh=dI+uYWfnn+
	20b2eO79cHcETOSikDKxj/ljDC0TJx8SY=; b=EAouztDfKiU00O1u26/abJN2F7
	9tGAb6qsabJh1VgZDBh/x6PY3Dp4lOKlWNEcCmOTnNFwhklL1/fBj3uqpq1fKJzh
	cUy48sG0j3MoaRovLmLmQ9L0lnjlJVT17s4/aQufItYcbAk1En/RoISh7r7hGM9C
	84+aKjCi1hiQZnhJB2Dh/ZlmTew+sHH+g4CtXCdmPhmJHOOwsAy1OjKUGV4lKBOv
	0O8BkNYJ6Dj+EAIpRhFNh3M9Y1ZrLxl3ugORuby2M8EFq4MAQ+88+CNia8P81IuM
	ybQvMh/+QYiv5mrFGzeZSzFv+BRdF74lp0rKgPLRk2mX+a/IzoB/izvw9BHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767973903; x=1768060303; bh=dI+uYWfnn+20b2eO79cHcETOSikDKxj/ljD
	C0TJx8SY=; b=ON+nGkHf6mcv915Ks8/h0mszcSB6aDHTUZsehQMdOSYm81u3YET
	ETzrGM5ZtCNEI+xBswtuLtTqR9PpjADgXoJKNwWDasT3PZ/AhtS6NNTkpWoPqiNf
	5OwKCPPBUw6jWbgVHIvRCgrCJf0aNmYMOzh3pQ53u32QpEOSeL4lcG1P73xG6yzM
	AY35iFqX5WRFdxtdwsYxm09g+fZS45lB/tiT9fhwGNspIYmq+TizdOoj+K6xkkJP
	a3Ri2mPZENZp3WsT4udjmwfjzTQdB6s0hByIscIxo9KzgyiZtODUxRZa0wZmeOmZ
	5GmfxumsBlr5Rn7x17Wh4M9n5GS7q25FTwA==
X-ME-Sender: <xms:DyRhaTlfsZjSqr_yjsFeIsdrApZ17Ay9b8m5BRJeJaA0OwP6bshQAA>
    <xme:DyRhaduny7BGdAOag_-Hf3c8ZpSduE2-C2XGGviq-F-EtGMdXQYvVG1i2pekH1ZAL
    fe1_cqk_E8KEvphTpPae4pkdytqNwJ7bZgGgjAOX7AnMs0_L1cjxg>
X-ME-Received: <xmr:DyRhaR_Ne4ofr59OlJ0-zV9-c1gUT5EvSI6Pw2kaiRvL7VMq-Cyk7l7FnPL-P0uVUO4Dy-Maw6bk76AMsetVQsmFwM9qUp4yQZMIs-QdDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvmhhilhihshhh
    rghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghmlhhishhtshesshgvnh
    htrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DyRhaXNaNbHpocQiAV8vzPCeUULltFtmu4eBMu2YiNb7f8jeXI_84A>
    <xmx:DyRhafGRFLRKMoQj2l2PseKf4Iut278CVv1CtE4p3IMk5WvdWHey-Q>
    <xmx:DyRhaVQDCbRHyDRkzjbBebAAEe9c75FbE6oC49qOZjKToFUpSijEfw>
    <xmx:DyRhacsqfQAqLZt-jo6vRbsg0r9Kj_NKvzhWVT9SQ4-k_zgbmsnj4A>
    <xmx:DyRhadV4LLyh0-LInoD-8IKEFNABlloOTb0K7wPZ60ges-NWYTRtKHih>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 10:51:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 32a14b2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 15:51:41 +0000 (UTC)
Date: Fri, 9 Jan 2026 16:51:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <emilyshaffer@google.com>,
	correctmost <cmlists@sent.com>
Subject: Re: [PATCH][next] hook: check for NULL pointer before deref
Message-ID: <aWEkCqABozBzT-QS@pks.im>
References: <20260109153528.476163-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109153528.476163-1-adrian.ratiu@collabora.com>

On Fri, Jan 09, 2026 at 05:35:28PM +0200, Adrian Ratiu wrote:
> diff --git a/hook.c b/hook.c
> index 35211e5ed7..c257bd3940 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -148,12 +148,11 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
>  	};
>  	const char *const hook_path = find_hook(r, hook_name);
>  	int ret = 0;
> -	const struct run_process_parallel_opts opts = {
> +	struct run_process_parallel_opts opts = {
>  		.tr2_category = "hook",
>  		.tr2_label = hook_name,
>  
>  		.processes = 1,
> -		.ungroup = options->ungroup,
>  
>  		.get_next_task = pick_next_hook,
>  		.start_failure = notify_start_failure,

What's omitted here is that the next two lines also dereference
`options`. That'll also have to be fixed for the warning to go away.

Patrick
