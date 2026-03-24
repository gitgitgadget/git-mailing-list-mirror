Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC5F38C2D0
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366954; cv=none; b=BVMMPccw2DdVLPjBg9WmAMg2/N4nZZgLrRzklBfgPBhcvdtrW6KwUaIQKEIxxAG/gy+Lh/dA5dAY6/jfvVz7psTJNiduNpV05vfMf5ChLiGG6MZT+/owrZSWc9bSFSBkqj0Ej1S8CqoSgWm/ZFgjfa6EYeDnEMAZryldsyzxjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366954; c=relaxed/simple;
	bh=VhOhsZ4DIWRYkeRSGf88D9PQKzJzwbrJpx3y9RBH6JY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pvYBBx5VRPtwg8fLpdQcEE+y2546xDuSwOzCESwwmBbxKXFiyCiTnB8K3/60aRuZXO3tDYoHAsJCS5zJ2auel46Kw3IF4xusj0/rbSGzm+qzj1dPNg1kHcIDb06BLjz/IDFpeIrXniJWRCkjbNgs3bD/XrV8z0Bqy8YRxY5plio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TKG5y7wQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m8TYzzME; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TKG5y7wQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m8TYzzME"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED1091400076;
	Tue, 24 Mar 2026 11:42:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 24 Mar 2026 11:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774366952; x=1774453352; bh=+8Q81cUcGK
	h/5Xwds5dzAwoXIjM1+npMl2ZM3kJarO4=; b=TKG5y7wQikRfqYNDvJr09/yKQr
	c9z7se4llSMeZZZYJmoLQTAGWBdEFpsOvOfOkXARpIfuMw9KFVaMBVdrLoZbEMt2
	pRUfN7gaulj0OOhOq9bnCgqlfeiW/Z1YHFxQnBSmv6Xl/7VWB2Akk0yJjI0pKDAc
	HESshZVaDRCKuifCmGZGWEH/eAFx3hnj8vnBDXxiCbu7NtuqBhnt4IWo6bq0Uc43
	U2jB0+TmTOV9pn0m+/8jOLaaEJwHIAQZnj6vbp8Qup9S6QJMM3MD71t018MCNnHk
	ORjDQFfB2SlDeIEj7/wHvj79bZJNVQclVjo3sthvEnFTjLtqmaj4uVmiBYdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774366952; x=1774453352; bh=+8Q81cUcGKh/5Xwds5dzAwoXIjM1+npMl2Z
	M3kJarO4=; b=m8TYzzME88r4NHO9w7Q9HCYHyhFOBXaP/RUI6Sor/i66j2F/TqM
	SuS0TzU6XKB/ZrCEpC7T+szfpt1QMkpQUPQeFyU1/4xe/8dhNWcbZvEWcdaOyIzB
	ODzErcSmUTgKibetQWV28w9LlZ/34L7nn18JYuSEnE2Ailoe2hjjKG41Sg2aNjxc
	sKQz0LNXfxPT54YtLYwNqkktSpo13eMkXi6NjEQwsGTCvKDRKVQzRR1Bi+viuqxy
	gEAN/o3OLidsNFN896nICgX4w6oHMVHCs8N/l59vLjcRJvBJcrdy182/BvU/NF1S
	ptX39SQvPFp+hR97SWfe7VkOvZDm0lxBBQg==
X-ME-Sender: <xms:6LDCaXmUW9kf71FaH2BZ3LcPDIxn6kk72NOqakDfIeSoMmtzSQ94Pg>
    <xme:6LDCaR2uHQSPCHRpyagaw92328rH63xyFF-KYZEd_DFmKH3ajnn37_OfeVu0lTsa8
    -Zd23qwuPLcwiX8IIFEqtRfmCRqmpFxpVEHD4HUUBYlXzi1gVuxVg>
X-ME-Received: <xmr:6LDCaSo-t4FyLLoomfkT88kT-YHuq38cB2nHtPPWvqqencjjNRbb080sNOayO3_CGlkXYE335uVqR3mE4FF2x_CIYl-hFgcEPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6LDCaedBt3BdlVpOWrqSrnFVMRl7qynBrYe-i992yGh8PSfAy77stA>
    <xmx:6LDCaRrPcWOrK4-9jn4ow9GtaGU8gcXgl7YAQL_Z7adhIA97_8DODQ>
    <xmx:6LDCafHXFF6wSMHk2Y3lFCHbqzakwnZHHBy7Lea9yGhYXSGiQWx88A>
    <xmx:6LDCaRuL-WCCLrQQb_hcX6PNdPns6kTepneaSxHTo2kKJWQXZkrF8g>
    <xmx:6LDCaeL8G0Z4WEl33cgMrNkquCI-gKNbmjp_oJykQlZBjXnwXcwDcZ26>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 11:42:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] commit-graph: fix writing generations with dates
 exceeding 34 bits
In-Reply-To: <20260324-pks-commit-graph-overflow-v2-1-843568cf8780@pks.im>
	(Patrick Steinhardt's message of "Tue, 24 Mar 2026 07:18:26 +0100")
References: <20260317-pks-commit-graph-overflow-v1-1-e6bee22cd826@pks.im>
	<20260324-pks-commit-graph-overflow-v2-1-843568cf8780@pks.im>
Date: Tue, 24 Mar 2026 08:42:31 -0700
Message-ID: <xmqq1ph92pzs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v2:
>   - Account for platforms where `timestamp_t` has 32 bit precision. This
>     matches logic in `write_graph_chunk_data()`, where we also depend on
>     the size of the commit timestamps.

> +static timestamp_t compute_generation_offset(struct commit *c)
> +{
> +	timestamp_t masked_date;
> +
> +	if (sizeof(timestamp_t) > 4)
> +		masked_date = c->date & (((timestamp_t) 1 << 34) - 1);
> +	else
> +		masked_date = c->date;

It is a bit surprising that on a platform where timestamp_t is only
32-bit wide, a smart-enough compiler would not find (1<<34) as
suspicious.  IOW, I would have expected this to be done not with
runtime switch but with conditional compilation.

