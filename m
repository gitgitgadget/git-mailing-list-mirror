Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC2B2E54BD
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994792; cv=none; b=RbiJ6DMbqKMI+7i+t/XtcjCGzmI4A8bbruKC8WnTOt6CcGIFUZmIbBfhJE/flH2HteUmIQWMwEBwubLIf+srOcH01zmXAMR0dQfcRnh8lXYo1QmmGsXUWYsMdR0khmlh3YUDBfgN8cIjS9WxGDCag9VpYrFmMcaHig6sMwyCUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994792; c=relaxed/simple;
	bh=ulCnvFZ3FgjEimkDYDUi8jsNzsGCoZaqScKmjxazu4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OgY41S8UWPQQ8HOuRGVCG5VkSl5ddyfcM92DjpFRzzYiIHpInZOMK5ybQzXxWcMqcHYqhUQBeNb+lMoJirgOSLMa/8yH4t6q1YGyoF3kAnDzrS3kR+PxuitawCboSgzsdRYJ4ZsNqzFdvRGSV0iHqqx6zijQcD66I8gvNTtTMps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FOJHXOAp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YUCzD68I; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FOJHXOAp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YUCzD68I"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 5FCC11D000D2;
	Tue,  8 Jul 2025 13:13:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 08 Jul 2025 13:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751994789; x=1752081189; bh=Q4fBTTNtGZ
	pOU6RKWDYGkskErGwJB9Gbxr0mbzZVlbM=; b=FOJHXOApf9vMXGM2q6lwqjB/pU
	u7VjJcRLoVoEmLF7rSvVF8S+dupCS8+wry6AB1UENNs9scU9zijpBXnfHYle0NqW
	/D9e7Zt6bdz7QwtQcdouoG/uz6Z+5v5U4dL1fVRG1S+An4LGNAgA5V7nTjzgEcZe
	ljVXiuvdT2YNcXMZnWLXeruBY2sXzU5VeyntVHbaZ9NiWrV4CVlQTUcqgmMfZTRK
	tqeYITBxz+S6P1/LLMd6eBr0Yg+NbPtufHA4elwVmNeSDpXo5LyckYzSyoJNLmEl
	4NuIyADewJ1WsnXv1l9kMgvdAnPBUnylvnzzZEb6Vxe7NBiC2poPZkV2pWFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751994789; x=1752081189; bh=Q4fBTTNtGZpOU6RKWDYGkskErGwJB9Gbxr0
	mbzZVlbM=; b=YUCzD68IUWorB3hVzXcI11pr1RcXGe98WViMw3fKUm2c8vR+Fcs
	tL6tBo3WFLEs3fw0BZybfK3YqoGdbPklD9JIGIIIWpdwNnjR6RYnLGzdAizguxKz
	O2VsePlu6AKv24XZnLIlF3wxRWOXExxQLQCwWNtdQwozjPeVcR+drhVextVmbSVa
	pxXRhu95fHevQcVl/sKypvtN/pBzdF3TtskVozuMgC+NIa0/dUTJPldFh31fC+w/
	mkE7iWiZhR/hhSkYznUyn/aVJSpNxG5SvLVQDyKY9gZE+twv7eYT3FYUt7SecKy2
	KG6FyGP1pnS8m1Nu0TsQZdfG/JpNvDGwRtA==
X-ME-Sender: <xms:pVFtaL2M-PuaLwMaScvQN5JdiZIh9dzLc5uYaFAI3kSmBcDJWnSoSQ>
    <xme:pVFtaErIa6kquEHUxblg5RHyWDdBNESc7AbCmuoreWc7ebyzcMjnYxYPrjHdEBC6g
    8109yKFu0Eh_Y3-DQ>
X-ME-Received: <xmr:pVFtaIfRLqJhDjMt6GDNKZql1tM6wS0ttUtYMe4AN61Y18hSp777MGGS8qOZgMU2Mv8qoqAUulb6o1vwMLV271hl5DDnR_HdmUCuEoc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefhedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehjmhdrrghrmhhijhhordhfsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pVFtaDq24wUC61idApgZzGu-5fka6ZyfsQR3UF-v9Xq-FJvCqYVisg>
    <xmx:pVFtaJEAu6-sNVNEInH4eUSCncnLPnVLIytXrm8y9kYzffyf-3Nr-w>
    <xmx:pVFtaDuXuKCgWqz1-buTTzkmxS5LkvVglQ-h3krvku4kMFfcovtZHA>
    <xmx:pVFtaLVMCPZ8Zl-J1KDEvjT-7et32Nx7EHTr5kD03pljEMf5FKvW9g>
    <xmx:pVFtaMnjQn8WJSw6-6o90QVQheVNfhr_XFTog-Q4zrdNGC0Br2Iu1iHJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 13:13:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Jos=C3=A9?= Miguel Armijo Fidalgo <jm.armijo.f@gmail.com>,
  git@vger.kernel.org
Subject: Re: Bug: "git stash create" ignores "message" argument
In-Reply-To: <20250706032512.GB3041790@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 5 Jul 2025 23:25:12 -0400")
References: <CAKMuBmSeFh63212_GhBHfOTbW5VaqvQjo7jz4aowm8bntCXkVw@mail.gmail.com>
	<20250706032512.GB3041790@coredump.intra.peff.net>
Date: Tue, 08 Jul 2025 10:13:07 -0700
Message-ID: <xmqqv7o2vc64.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>   2. Possibly "stash store" could pull the default message from the
>      commit, rather than using the generic one.

This might be a good compromise.  Even we discourage the use of
"store" and "create" combo to interactive users, we do care about
ergonomics for script writers.

Those who use "create" to write a detailed log message (which may
later be reused for a real commit that is created out of the stashed
changes) would end up with a huge and unpleasant stash entries if
they use "store" without any message, which may be a negative
experinece for them, though.



