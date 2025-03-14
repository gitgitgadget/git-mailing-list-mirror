Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B309BA38
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741987023; cv=none; b=FEYbGwSQER6D3Yiyj0IIab6nry7iJaWO2l2g4ruRzkxOsVD53jvvj1k+ldc0dCtudX6EPIsOO3lraSumcS4h09609PjYzVhz0Y6kVh2f44Up/UeaVzOkUUO0yGygNhNDN+tyr+7xK66dKj7XcllxnbHgEJXJfK94tcW+vH2hp4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741987023; c=relaxed/simple;
	bh=ReqtiL7BJKEMSVzNQqgCSMnQjkZ75y0110u54bLM02U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YDnUIHH64MoND3AzIc+kxrw51y0FQmbyG01UjJvNAB9KAuz7iz16UH1TQ3aTmoI98kNUGuKvN/fPjaAUUJIT9SByRpa8MIh8mVYNs0f7SdygQBfIJHANL4tmhpjH+VuqCwmTwQweiYDy9O8hupevOfIBYWE1rP8J0yE7x564w0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GIWR1yKp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rwLISR5B; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GIWR1yKp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rwLISR5B"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90554254017A;
	Fri, 14 Mar 2025 17:17:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 14 Mar 2025 17:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741987020; x=1742073420; bh=LRUp8X3q33
	tkOYoja75yerjHjxInqhvDIC3tFAbo04g=; b=GIWR1yKpYl+1Y6D/xYTW+1X4b1
	XqHtyN0SEeptZZwfAYTLMSoIHmxg+M7GIxOatDgRoht87hR7FXoUQMt0PPla/XTo
	pp7bjPCok6UGJnsn9kzBuksIRD7pZ3lvoIS55VbbYuzEcW7jHU9II8TBhUcZQeB6
	EB6jBwKb1SkAIgUUhlJPFMa/8Jgwbh97pSvH7jo7luYTC8+j7k6+jK3Aw1xQbEVT
	9yCuFEJv+Q6wVAviNHoRtZf8ikflQKsrWGnLorB7NtXKirkRCa48yHJLSOKfrs9Q
	1CHFdn9PPU+E0GBZUnncxu54WuQeW8z8po81amICMQsOihZ6jp5akwCAfBYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741987020; x=1742073420; bh=LRUp8X3q33tkOYoja75yerjHjxInqhvDIC3
	tFAbo04g=; b=rwLISR5B7qQ6VJ9TXLVSW2uiCXWzDkMIOyVvRcszu3AgUdGh5Py
	SIS1ycrySTWrdcn6FFREALeH+goTOm9TE7Sv/qIIZaVvdHLk89uDMSTE/8BHoVGK
	OD2kj/9kEEG5qZN2uPoe6NUKY/kOIPTwpL/onhXEBWdmqKELMzOmR6OuzUhhuGQi
	GDBdD4/sESjF3JzRJJIeyKaRNiYAfB93Oaw1aEVSw2mM5rVwA4XEnS8YzvcDNsJo
	t4ZeXVjKesTBKymGeVo2FCpXQnAOyUwRcfPWz6Eb2oVRWyRtUrzcAkaEhKcrFcyV
	gWQ7eRo0LrCevgpiR5FtYX8TW4RUwWcvAyQ==
X-ME-Sender: <xms:zJzUZ5CcbBFcERWe9Q84uKiqguL7c2L7CbQyEwEfA9AW4X94JvZwbg>
    <xme:zJzUZ3glnnz3ar3gtOVT3AAX2LQ0u4k12ZPDGuitjAkkEj8BFoFSGiGAtvJtVDwsV
    94i8gjj6AILwcrwJA>
X-ME-Received: <xmr:zJzUZ0kcALclh7Jl0WZ7OMkU_0Cbt-V61JgCNhGp1pmYIsIYno22AXHmc-JkmVpNF5UBF2VTxnXLz72hrWUUjZjVXD8ckW-H8jZ-Id8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedukeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zJzUZzwNpar92vI1bHLrQdXOdktX1YxIo5WC-_rOTyeHIyH9Ln8DPg>
    <xmx:zJzUZ-ROvmmTIhi9KOlWGBNSZ8B41pCN-i0OQ_1FP88gvi8SrtG5eg>
    <xmx:zJzUZ2YL__Oqi0oBxUoDlA1SuSarYq4ajJimbV7dUeCU6_SNOLDZ7Q>
    <xmx:zJzUZ_QPe3B9J03qXrhhVJzXIB11q85d9axmv1G2Mbcl-IjtrqvsSg>
    <xmx:zJzUZ9FFeuJHKvV7FScHjuqQxsGaWHK3dYLTerTltWYZ7lL9DMaZmO_Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 17:16:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  ps@pks.im,
  christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
In-Reply-To: <po5vjngxt6afwdkg7bvpw5j4dhot5h4uz5yudb3o4eug4k2nqu@rwp5rpe5d3u6>
	(Justin Tobler's message of "Fri, 14 Mar 2025 14:53:05 -0500")
References: <20250310192829.661692-1-jltobler@gmail.com>
	<20250311235720.GA73755@coredump.intra.peff.net>
	<sm5xvh7bipyrlpw45bptlctbuhey7v3qktpskal5dzexomt34f@wgfziyhcf3t6>
	<20250313053329.GC94015@coredump.intra.peff.net>
	<qapd7sijizopaefpxh3slgn7g2ecwdtyhzqzufcypciyv6n3qm@turmldwzipwe>
	<20250314024929.GB114103@coredump.intra.peff.net>
	<xmqqsenfk0ks.fsf@gitster.g>
	<20250314185914.GD578421@coredump.intra.peff.net>
	<po5vjngxt6afwdkg7bvpw5j4dhot5h4uz5yudb3o4eug4k2nqu@rwp5rpe5d3u6>
Date: Fri, 14 Mar 2025 14:16:58 -0700
Message-ID: <xmqqtt7ve2id.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> If we want to adopt less ambiguous long options names for NUL-delimited
> input/output options as an alternative to "-z", maybe we could do
> something like:
>
>     $ git rev-list --nul-delimited={all,input,output}
>
> where the default for the `--nul-delimited` could be both input/output. 

I'd prefer not to see that route taken, as it does not look any
"less ambiguous" at least to me.  Making individual selections are
almost the same in either syntax, and the only difference is that
--nul-delimited-input --nul-delimited-output can be independently
chosen and given and happen to end up selecting both.

But with --nul-delimited=<value>, you have to plan ahead and choose
"all".  When your script first wants NUL delimited I/O on the output
side, you'd write "output".  When later you want to allow it to
optionally take NUL delimited I/O on the input side, you have to
notice that you have "output" there already and replace it with "all".
If the initial version did not have NUL-delimited output, your change
to add support for NUL-delimited input would be different.

And you also have to remember that it has to be spelled "all" and
not "both" when you replace existing "output".

In other words, I'd prefer to leave independent/orthogonal things as
such, even if such a general design principle may make the result a
bit more verbose, at the plumbing level.

Thanks.


