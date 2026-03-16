Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314ED3DEAF7
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686677; cv=none; b=RrnQSfAriHz7rMLnV8lPSyhNFPaXiRLT2nGjtlrBbCBFvyG9yjRpAZ37khoJCx5JWfEs9xqZ07Z0ztJwZW0GyiFq0FgFr+SqzeRYdNv4UEF6ZB8W9KrtaJ9E8r8sRusBX20yMSQ8o2qtcAa8NCfuacHB1gtn4MLW+4DlxiJIXM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686677; c=relaxed/simple;
	bh=gVjGgW/FIzIJIJ2NNx3Ybp8ZHWSRQNj8WCC2FRJX6ak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MlR+yfBgiBhOqTF3Qov7Jvnx0t2eljjS18OiR/k78TiSzWgwZRzxmEaECwIibQtvFn0qLZRrEVqKOzsL/Zn/O4h4cqe4udjjNwBfjLQ1zUss/yW7lSdHSHbGTJQPA9NYyUf8rmjvwNOn+gJOx8dUlGTkruIcIRItnNmL+4Egpwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OeadtlPi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oa/f9U1o; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OeadtlPi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oa/f9U1o"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3CC587A0114;
	Mon, 16 Mar 2026 14:44:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 16 Mar 2026 14:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773686674; x=1773773074; bh=g7XciaKLjK
	8jnp8M4y1BLd6LcqzowsFJ5lk0uzY+Uy4=; b=OeadtlPi+V52YBU5u0IA3Flxil
	ixfJ1n61CiSsNRZAF2+VXRFHz85UFd05N9wV5u9NBdMSoNPntdDHqTgUhlKCWOTL
	VmrDMVs8b0NqA80f/tLk41gA/lkbwF8eXsUfVKrtUFsQUjRjgMQHVgJij5LO6ie+
	mjLsECs8Ij6U8rpgBPYpH2091QMxVfoYIjJUBsTsaKk9Qd6/kcvmnlQts2/eb96n
	ModpvlVW48PBz7LZoD3nOyMdpwtK2ywxgFxs5R6GSZAuMvGUHmemABxvIIaV0rAU
	ZL1jpskKZKkU5Xvsy2t/JzQ3s0zKiM9BXbzLWKi0MKjCo0qdCF2V0n2cGleQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773686674; x=1773773074; bh=g7XciaKLjK8jnp8M4y1BLd6LcqzowsFJ5lk
	0uzY+Uy4=; b=Oa/f9U1othCl2KsqOPIDmA2SFZqn3YiEnKCmePqKESm9YLPLHaU
	tf8Qs3PPWpjyUEMjfCnmTTJEXSiVFIyhuanRClhQkpdJMa9sEvjlTtWP0mUGCwqE
	FNIcZ1t/Xsbv7mZGofFuYPCbbbJXlvr13dsu6cV+jBlqmeuPry9siaqey+MlHBi/
	IzaPVHkAhOlUCDEAOr7AmUPhp/dZS5z2HKmDilqL3j+B4UvSNX5MNJCvszaidqAq
	mPq3tjgI133yhgl2o9UusBKrwswR6w8AE8XCxdanEHiUaAkzGcd3P2Nfmy6vdSAY
	f80xzzcedFWHeNweJbwU9a0YmQUK9iNVbUA==
X-ME-Sender: <xms:kU-4aciTLKRta3o026EmoF8Hi7SqfO2qnK6V-Q9iKp7V-MHvuXRnUw>
    <xme:kU-4aXl81NK4s9Bh0BY5ccMVsT_9t1mOs-n7hIjuI0mhJ2r4vKf3lm1iEGxia2_qR
    j9NksztIdM4usFdZ6Bea3b7KyKOn3h6my1rQGlvQzqmm59AVExHuQ>
X-ME-Received: <xmr:kU-4aXuK9-CN0RctIIFMuIpS871mrdJ8djI34YX2V7TnjY8uBjBPU_d0sj3KbHWsdY9-iSjHaW1S5GOk-6zwv5fM78JvglNxfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleeludefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kU-4adYtwZDCkA-q4bbAFOTv0xGcALKoEYLgjqgPya6dHs0VX6m_pw>
    <xmx:kU-4afD3NojQIFnaBmFgEfQfgLhN7a3b_RBagKXndzYT5uIE8vabyg>
    <xmx:kU-4aV_nCiWjG9VWRrF4ejhpSvf4Cus8kSc4BnQBbt-ywtv91YCY7g>
    <xmx:kU-4abTZHgi-7q4kNuIgCgyGxqcslKXxQ7mStM8JlzDx7sy7ZNcuiQ>
    <xmx:kk-4aecKfM1D7HfRVgCXF5gWpF3COepZ5hm-6S1vHfpn898xTthxc34U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 14:44:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 8/9] hook: introduce extensions.hookStdoutToStderr
In-Reply-To: <20260309133739.294555-9-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 9 Mar 2026 15:37:38 +0200")
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-9-adrian.ratiu@collabora.com>
Date: Mon, 16 Mar 2026 11:44:32 -0700
Message-ID: <xmqqy0jrobqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> All hooks already redirect stdout to stderr with the exception of
> pre-push which has a known user who depends on the separate stdout
> versus stderr outputs (the git-lfs project).
>
> The pre-push behavior was a surprise which we found out about after
> causing a regression for git-lfs. Notably, it might not be the only
> exception (it's the one we know about). There might be more.
>
> This presents a challenge because stdout_to_stderr is required for
> hook parallelization, so run-command can buffer and de-interleave
> the hook outputs using ungroup=0, when hook.jobs > 1.
>
> Introduce an extension to enforce consistency: all hooks merge stdout
> into stderr and can be safely parallelized. This provides a clean
> separation and avoids breaking existing stdout vs stderr behavior.
>
> When this extension is disabled, the `hook.jobs` config has no
> effect for pre-push, to prevent garbled (interleaved) parallel
> output, so it runs sequentially like before.
>
> Alternatives I've considered to this extension include:
> 1. Allowing pre-push to run in parallel with interleaved output.
> 2. Always running pre-push sequentially (no parallel jobs for it).
> 3. Making users (only git-lfs? maybe more?) fix their hooks to read
>    stderr not stdout.
>
> Out of all these alternatives, I think this extension is the most
> reasonable compromise, to not break existing users, allow pre-push
> parallel jobs for those who need it (with correct outputs) and also
> future-proofing in case there are any more exceptions to be added.

Hmph, I am a bit surprised that this is not hook.<name>.stdoutToStderr
controlled per hook process.

If we already have consensus that giving output to stdout is a
historical wart that we would rather want to fix, then this
configuration is probably good enough.  It is certainly a much
simpler approach, and there is no need to make finer-grained
customization available when nobody wants it ;-).

We may also want to consider "fixing" it at Git 3.0 boundary, if
that is the case, though?  I dunno.  I weren't following the
discussion closely enough to tell myself.

Thanks.

