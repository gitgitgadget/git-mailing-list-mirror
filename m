Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748C134EF08
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772834733; cv=none; b=K3DnUs8onfOzirJWcozzj3MNi+ypx7oumziTtqWzqNsdxKoFg2hVoCj+welbwps/JfkNZSWZttueB56+4nXjN7tbrGcnqbDZV/ptGWZUl6m+02QKdg/ul/hajyEGBl/0MuvLEb6EH4LqAzWJBeCY9BbbOXE6iwrvz9Lnx4fI4d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772834733; c=relaxed/simple;
	bh=zM/icE5Y6W1JQNn3+OuRAbt/L4xRPInBg8B5UEgmkFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WbBgnEqaT/xEL/nm6cnGVajJr9ATKvQ4WjL9g9ejYEOBZT39YVf9COR7/utX1uCpTmsIGZ4OrkHO2vFho38JwNAD8q+MUwOoRNcwY9RObNaAlHrVz4NM0clFc7mGO5tGkJRtje8wNSUoabnyLst9KVE+YO3boqP5tvQkf/8O2/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h0Af93ET; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IdSvv/V1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h0Af93ET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IdSvv/V1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5D1E140015D;
	Fri,  6 Mar 2026 17:05:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 06 Mar 2026 17:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772834731; x=1772921131; bh=EI1j/xX0Sq
	mcEEXLI8mYSu/TRpbyAVp2J5FF4rtQJwA=; b=h0Af93ETxdaA3UomB6CsCaHdzq
	smoGaMLsV0E5rFXPgegp39PJgGVb8RoAsVu1SmYUNrChzGMKfJHAtBmfrvOh+Qcm
	qpuNLAmRDl8/QpAdvCJhRBumrFKA9liWCij9CzLvKrud0ov7GKiAhdgng0QT0s9Y
	qvNC+tNkcrXtw6eCuggIWQR6GAAxgDJ2SyLM0zy3Iz1JSyGL6oPiN6KtSRNRBb3F
	VA+hW3itEvwlWEzgYvb67d2kcfWPgqtoQ8Te7zI2AIZsTWOYN3LqMk3C58a0zrdi
	3IXaMm1io6j9HhwwZrna3414WPsyrTAEbuRLjU0m7Uwkz4ZUWAY2m7ZP66AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772834731; x=1772921131; bh=EI1j/xX0SqmcEEXLI8mYSu/TRpbyAVp2J5F
	F4rtQJwA=; b=IdSvv/V1OzuwpCT+nrSIUHsvnkp+d1ozc1Lc+iz4ctUpKbLn63A
	WY8p5x9FWXVk4UbxzDh74gHnD1H6NhHY9lf8u26t0Nac9m4szyHCSd5OkzG50HU+
	+QZxXj1u2S3wj0kIQoiCdjn0/4wXtIVuzX0JEKYU57vVOnSwC88+CqMcdV4LQf0X
	grok0dXOF0Ygt7eOSP2zlP32COahIXFGS4elVsue1EnsxQsh8mcaUo+tu8xJjQtL
	peq20LnBc4aWSvMIwlODx3wBUtu7Q4i9E5en4Zg/5lLt7cZyfX2IsoSf7YVCn9y8
	3WlkgxAyBfoXl3XcY6Czljxs2oHcB2iB0pQ==
X-ME-Sender: <xms:q0-rab0hipq8G55YD65EmQ8p8mZpjkrMg1X0fVu52oEdiWaAH8qxlQ>
    <xme:q0-raX45fMCJxNoJ-n2PEzFkwDS0Oj2wrwi8yNn1YkHwtDoFPBQ0m2ooVHx8I-UyY
    A-g5sEKex-K9MiqKVdFXTUALykI8kkHxISsnTr5kVsnEnjW527xSQ>
X-ME-Received: <xmr:q0-raWXk9IHJ_m9yHuGfnKY8-nWs0ZbCOwPFClaTKExzmnv86t9SwBJcVrAiRh4dr424MxvrR3Te_ZF0xzhAjvMZDr-1Pz_z1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:q0-raeBKKswHhNLEDCAn9nEgyMlWVh0sCW1ha3iDzWe9OvyHoSJx4A>
    <xmx:q0-rad40srv0GAPDI2dpZMw8Gbs7xZkGoN1784Jfbj3cmHe8bp2eAA>
    <xmx:q0-raRzdNGJGWA072PxS1_a_H1r3JTDqcegs6SSYz-FzxAJbCWgAdA>
    <xmx:q0-raczfCxDuAZbizXfv2azkR_yF8vILce_YXSLzn9p_VGsCW9ofjA>
    <xmx:q0-raVxJtszJ8jXfC76N66qPFqGVI3tIBwjMRKCUvc7D6NqONIkNZJjt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 17:05:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 0/4] plugging some mmap() leaks
In-Reply-To: <c3e66e36-cba0-49d3-b2a6-d65367f4be0f@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 6 Mar 2026 18:55:18 +0000")
References: <b9fa930e-7d5e-47f1-8896-1997cf7c0cdb@intel.com>
	<20260305220214.GB736322@coredump.intra.peff.net>
	<20260305230315.GA2354983@coredump.intra.peff.net>
	<9137fd66-9ac3-42ff-a892-1b6f20b49972@ramsayjones.plus.com>
	<xmqq5x78249v.fsf@gitster.g>
	<c3e66e36-cba0-49d3-b2a6-d65367f4be0f@ramsayjones.plus.com>
Date: Fri, 06 Mar 2026 14:05:29 -0800
Message-ID: <xmqqjyvoy5p2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 06/03/2026 6:37 pm, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>> 
>>> When compiling with the NO_MMAP build variable set, the built-in
>>> 'git_mmap()' and 'git_munmap()' compatability routines use simple
>>> memory allocation and file I/O to emulate the required behaviour.
>>> The current implementation is vunerable to the "double-delete" bug
>>> (where the pointer returned by malloc() is passed to free() two or
>>> more times), should the mapped memory block address be passed to
>>> munmap() multiple times.
>> 
>> Sorry if I am missing something glaringly obvious, but quite
>> honestly I am confused.  Wouldn't it be a bug to call munmap() again
>> on the same region of memory obtained from mmap() and then already
>> unmapped by calling munmap()?
>
> Yes. The (second) call to munmap() with the (already unmapped) memory
> region would return -1 with errno set to EINVAL.
>
> The emulation layer does not detect this situation and simply calls
> free() on the given pointer. Hence the 'double-delete' bug.
>
>> Or can the emulation layer cause such a second free() even if the
>> munmap() is done once and only once per memory region obtained from
>> a single mmap()?
>
> No. If you only git_munmap() once for a given memory region, everything
> is fine.

Hmph.  You make it sound as if we have some code that calls munmap()
on something that we are not sure if we have unmapped just in case,
trusting that it won't crash us and instead give us EINVAL, and that
is very much deliberate?  Unless we have such a code, bending over
backwards to track what has already been unmapped and return -1 with
EINVAL from munmap() for a second call is of dubious value, no?  I
still must be missing something...

Thanks.

