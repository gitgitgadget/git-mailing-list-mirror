Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F622D4E9
	for <git@vger.kernel.org>; Wed, 21 May 2025 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852336; cv=none; b=VAyRcE2dkESoogomhCR70Hpgf9SErthDbkt5bWTfLLjElXRCRh8CqrpDknbAZ1YXg5GiZUPuKW5Ya3PhQZnoZjBNhhWJubt0s3vuzu1F6+DkZsSkJ3TwBresAcWM0OM9LmXh7sEzZztSgy2lqnweynMEZc9Iah7FjMdORKbVwY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852336; c=relaxed/simple;
	bh=W1yH3MD4xu+boS3NUX93OrNw8Lw9vXhVRNsqtYbv++c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lm9SmCvEfpZIqs2CYnL/VSoA6yD4qnhvYD2lfDzpAG0BtibbaMz85Q3XeKWl/sOkQpQ5srrHB/Da/TSzyw5Zrj/oyAvt35xrx5X410YiTPRa0AxqMU9peeHVB8n0ZtpLlDHFO5JOaCsHQHge1Nus1JJ10gvbGNxPGnryGHMVmiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LNfqE0HV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hVNkQLK0; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LNfqE0HV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hVNkQLK0"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36ABD11400D7;
	Wed, 21 May 2025 14:32:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 21 May 2025 14:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747852332; x=1747938732; bh=TP3lJN0+1u
	zhfTFowlQS6+PTo8FRuyzjvSmZpP4+xB0=; b=LNfqE0HV9XG3QgtsnTP2d3v5Mr
	ygBDzOcLHMxHLUcV49oJNKYcclazqwZIsQyeYZ/BZ4XlnaXJPNscoInfr39xSzG3
	1hi8h4nSxMpToPwM6tvruyqp2jG2HAp/g26dt0yPoPPJ61pS6igiPNrgCNo1TaCQ
	LD40D5U2bB+Z6++Wfxs3XHhEGTiDNUFE2971Zk29cbnwl9EzhCTxVkF/J8kwt3b+
	ouraBpwh2332TdneyhFzSxb1noFLrfRoguQyUgN7Kcu7Hy0VMolOSORhvPrIXGzR
	9Xg63OeRbzp34yi2IzKS1Uqutgceocb34QSFnQ9CJPSsZDPUSt9oKHmIH1Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747852332; x=1747938732; bh=TP3lJN0+1uzhfTFowlQS6+PTo8FRuyzjvSm
	ZpP4+xB0=; b=hVNkQLK009tO4D2EwES6K+friMgiobnzhZg7PxSVNRJMbIKEVU3
	INRjL8vOANOD5UM8IJ87vkrKs05u5K4qVyGrxjqADuWcoC6PCcClBX2AoVcYCx32
	uCITHDKnVrwAaQekzrXvXH/sOpZzDaQUgBSxJBUZ4/0BF2rSeP48mEnZ5qc30GaP
	yVr0BNiQAhxiSPIG7BAs85DObm2PQCJhc5S6WSUk+CI3o1Q8lpeJCLnZLUGSLW2L
	/zIWKb/8SovGlR8STxSf6jc3nAwC4DN9l/rVMTkXkJuGVW5nGV22j/BF52cIHI7H
	KXcqgZv1Yo3xdWdhAv2RoHp6GCmvHYlVLtA==
X-ME-Sender: <xms:KxwuaEFw_Yd5NvHQ_hxwsy4ueupZhkiY7MKZi1wOALaKxOC7SkvT7w>
    <xme:KxwuaNVNpbuKmVhQMGGUj2UEVbLjWJov1_uXeOgJ3BrFfdAR5DJo4g3h_I9uR1HFL
    GaAZztv-qab3Nr4Nw>
X-ME-Received: <xmr:KxwuaOLZC9cOBIUKpaXc2NNZHzvawp5RmB2189PR4SAVuhrMR54sReq3HYdh2YIrpwm2WtalG5VjY7Qgf9zPtvUPysBSFFT2MtSEL_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefkeduucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhgvgigrnhgurhhfohigsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LBwuaGE9CFOGXVVaAg5WCRaegNwC9BRay_syW_K0ZGp4SKB6xreyWg>
    <xmx:LBwuaKUMV7FHGwX-Yay0LbFKIXBGnj59Te_Q5awOZDmth-c79Za1QA>
    <xmx:LBwuaJM8b_bx0cN8xIThIdlDe8Jl3y2NnMWXTLcE9_yA-IAdiEpY7A>
    <xmx:LBwuaB1u6qFTgIUkLsvEhq0pPJu12QZBmAZdksVTjMN54DTrrMioKA>
    <xmx:LBwuaGnNy07SvskeFr8SPD3BshY0SjHeWuSC69342FiX5PJHzSViP3jW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 14:32:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Alex Mironov via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Alex Mironov <alexandrfox@gmail.com>
Subject: Re: [PATCH] name-hash: don't add sparse directories in threaded
 lazy init
In-Reply-To: <9c26d844-6ac5-449b-a5ff-a842ed6ba8b9@gmail.com> (Derrick
	Stolee's message of "Wed, 21 May 2025 13:17:08 -0400")
References: <pull.1970.git.git.1747827645129.gitgitgadget@gmail.com>
	<9c26d844-6ac5-449b-a5ff-a842ed6ba8b9@gmail.com>
Date: Wed, 21 May 2025 11:32:10 -0700
Message-ID: <xmqqwma9ak7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> This seems to be a performance-only fix, ...

Hmph, then the proposed log message is phrased in a slightly
misleading way.  I took that "should not" below ...

> Sparse directory entries represent a directory that is outside the
> sparse-checkout definition. These are not paths to blobs, so should not
> be added to the name_hash table as they must never be queried.

... to be saying that we would find something we should not find
when querying the name_hash table if we didn't omit them, and the
change is done for correctness.

Thanks for a quick review.  Very much appreciated.

