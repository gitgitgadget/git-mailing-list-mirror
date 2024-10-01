Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB821BD034
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823049; cv=none; b=Uw2C6zSyhGFCwusiQIwTLXEXhU9xwxq8z8Ie2cj9MmouoHrwy/9ML0pO2QpUFW47eDN+Znm3GDbCyctkuhUuD2p8hODAt27UB/CAA9Jvx4UrFp4Evbvt5yJHiFrgq4EZU5KUosZknf/CyvPxAVO5Il62u+XFn+FZiM5R4C+sHJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823049; c=relaxed/simple;
	bh=9/pXTX7JALv0TX8GAL6E4Pbiltf+zqXztJBF3wHh51w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rz5r8ezFjKsU/QsbugoPVkcIYaNTYNdDKTNNV09BO8uuvRS2sn2hbWPe+aVsfuqkm7R0RcPw8aCm8/t7xhNYkEeBERsY0WfoW2LEVGbegvI5LqGjkXECPcFxNoj4QbmGfcAVoD2eT80J27D/OlSvrpF/IxSpOYjex1wuTSUtmB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qFV9vYoy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RVk+yzee; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qFV9vYoy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RVk+yzee"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E4B41380C03;
	Tue,  1 Oct 2024 18:50:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 01 Oct 2024 18:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727823045; x=1727909445; bh=9/pXTX7JAL
	v0TX8GAL6E4Pbiltf+zqXztJBF3wHh51w=; b=qFV9vYoyIMKHD8x2B6c5A51Kdg
	cr0hu66SRq2HtuEs1EZQGnzDPJl7Cj/Ox02PBh7uYvZKkwoL4A5Ml5sYKQD+ymVU
	buigjYw7AWwdHRhfEzvhqcd5fD2xJThgzMGcDdDo1KKYAPvj2ltQsiWLSF/9ij83
	Crixypr8AlYWk8rA5h32wSxRZsu4l9E/szfRrqwHVeFlv+w8zkjNbsCB7Y8U7W3P
	dw8tvTtbPSPkbGGAskOABtMeG5JiD6K154KifmIuT2xqjRe/yIRYresjc3SdFNhI
	1bG7lmbg0Up0R32xVw33+CWBIrxwuhjQY1L2/pl14OchBEKY6J4u+Xzx/IZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727823045; x=1727909445; bh=9/pXTX7JALv0TX8GAL6E4Pbiltf+
	zqXztJBF3wHh51w=; b=RVk+yzeerptld9M8Y2iv8rrp35tv6/4uKB8b1gb3WUYh
	ly+tjEIyyAVm26pHXhA4YxuCRFJ57rrFEz8k3dHIh+G6GAFV8tLgKPFVOLpqx6CR
	KbwTrqIMZt7R++ikbzZPNfkm8Redo7rZ2CMCKL+E+1nyfLGiEVuu9m+qepmIfnqK
	TB/K8/NTNnUsLzWthFnoqRGVIgcOUAt4mpyWX7iuKGKp0svqx+3QmMjtdU6Re8oY
	YyMC0bjSorj9Ug/SlRzVvFrlllWEsdPiclEuNhDxwQAM1Ha/WGuHE7qWSAkVbhto
	hop8D85trXjxenmuZaWI8it0FFjKo8H4jICQCfobgA==
X-ME-Sender: <xms:xHz8Zn9WLL609qRhrLno0af2QMHCDSiPW19TSoTTxz6bjAbs0naClA>
    <xme:xHz8ZjsKofUCJ5cX1SAuq7doelsQoiizxtQFsSY18V6E0KqjiavwZDSxY5IJbE5bX
    j_fqAGi0AzK0XGqDA>
X-ME-Received: <xmr:xHz8ZlC1htQmyjtNpXb_qpt9QWe8tyTdIgd3Jq-CRiKZ1z79w2sQi9O3IhCaRWrDhN7DCQ159H8EcEumtZbBLJ5HWwl7-JdZV3_CdbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddukedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtoheplh
    drshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:xHz8Zjd_5E6L60XAy5irYisjN0yz6Y7yoAcZ9VDtktq9vQKS8XEyhw>
    <xmx:xHz8ZsNYjRZmkLyxBrozYsYQRDhHgYcvNoV1wWG2R6IeodZp35IJBA>
    <xmx:xHz8ZlmZmAb_VZbhFKHLkMTkbQSKP1Y-bBRZPaQK7WZwOyEpuNrrBw>
    <xmx:xHz8ZmvSaOfi2TRt5h0TQ9FkRGSkw2UbK7SOe5sW4eI4GB4bBiLoBA>
    <xmx:xXz8Zr16uJbwZ-NMwdGRDKgouMoO4hP8Gzi-GN0FnjZNoL80GKaWLwvo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 18:50:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 25/25] reftable/basics: ban standard allocator functions
In-Reply-To: <764961e6f02b8e5788bce75830559b70c2e6f231.1727774935.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 1 Oct 2024 11:43:03 +0200")
References: <cover.1726489647.git.ps@pks.im> <cover.1727774935.git.ps@pks.im>
	<764961e6f02b8e5788bce75830559b70c2e6f231.1727774935.git.ps@pks.im>
Date: Tue, 01 Oct 2024 15:50:42 -0700
Message-ID: <xmqqh69vsail.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +#ifndef REFTABLE_ALLOW_BANNED_ALLOCATORS
> +# define REFTABLE_BANNED(func) use_reftable_##func##_instead

We'd need to mimic banned.h a bit better, by adding

#undef malloc
#undef realloc
#undef free
#undef calloc
#undef strdup

before (potentially re-)defining them.

> +# define malloc(sz) REFTABLE_BANNED(malloc)
> +# define realloc(ptr, sz) REFTABLE_BANNED(realloc)
> +# define free(ptr) REFTABLE_BANNED(free)
> +# define calloc(nelem, elsize) REFTABLE_BANNED(calloc)
> +# define strdup(str) REFTABLE_BANNED(strdup)
> +#endif
