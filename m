Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B52F3C1D
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769791828; cv=none; b=EiUJuMd9ZxSuGBq/E3CAC9FVfTvea5/k+qsZ7odnAgcF3pQ/L7WSl08n7ZCblVq0NMVPU54lmQAxmhVb8fk2M50nHbH+oqrdnaU6kgAEOrwrGEBa5neL4o77ZzvdgH8ZMKvsUZFIuIPm/htpLSTfBCB6hFKt9J4ZTDvzy3DYRS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769791828; c=relaxed/simple;
	bh=xb/oB6NvYWuPo4yOdWLciW2bG3DeDB/Vcp3p60K4UbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c8+89fkABOBJjJbPB4ooxqBOfQcYmHChazqlJ04U2rFl8BZsJb46xitcBqY/Qv57foGsp9Fp0ziqCGyPfeEoJ3ZGmF5jm6FvqxY0nRNL/EBS+vXVtNi7rTtwwn6EkoVGgTzR2DmDwvA0U+U+GZZL2x005S4zCgcnBjAntrlryy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F3I6gT6v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j0bYoVzA; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F3I6gT6v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j0bYoVzA"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 78F8C1D000BD;
	Fri, 30 Jan 2026 11:50:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 30 Jan 2026 11:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769791826; x=1769878226; bh=1FzsLHGfhQ
	SysuNX71pMUFkisiFbwwT4m7pcAI54gpY=; b=F3I6gT6vAWzocohAWWgQPxLYW5
	MJMLyJCwrYwd/PR5as6DPM5g4PIW+sNWBLImjyBUD/q2fMsQf4bN/8s2/A162kCr
	D+A/bT2hELHspF1a1UO3bSA0uc4tic3hOrmJYRwBgByG+h5X/iR+zOu4IG9i/UgN
	UwMFtdKggSVTWtvs3q2Eof878y3WAnOc0Hw9jsQYw85jvi7YmXi0E6+Yljdsj2mo
	olcNQERkwYaEXjfDGkqCAHKDEscOjBLlKYXxWQZPdpNKIlr+ovoR08uw1lssT94/
	yFt2agnLZbccsDOzmDEoniC9KvvyA7d2x0N7FIKpK7KgI9zPCJvh32u6dXHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769791826; x=1769878226; bh=1FzsLHGfhQSysuNX71pMUFkisiFbwwT4m7p
	cAI54gpY=; b=j0bYoVzADHPeLJpWyTL+kkmzuuMpyhzht/cy646XON/09aypOdr
	nBCxvAp5vwuyrCr/eMBpMpl1NWKAWuwpJAgPsMCiMj5q2nCHX6Fjw38J7vxnKS0O
	hBReRhBulkl+KXRDDgEe24u/U4zaE1w/MnBh6PdRwAiZdjAL8lJnFEi8GpzDWZ1f
	b7/OaO8C4jIoI/cGvjWz0lVjhuBpls6RFxgoMpOMEuJQMe2hBGIwmEhVgeEpcnz7
	r6OdkYQZ70Q1qulIbvjiidxRfacKuwfllusN34+UYPq4wR1djGYAxtfRW0XXGM18
	zQ8g2T3IOIrQsLqhMagaY//fM110+8ZNDHA==
X-ME-Sender: <xms:UuF8aQftBj9cpf8qgbO648Kt7tf_B-kP6VhTpdzoG1D1YEQKgkH_Jw>
    <xme:UuF8aZotLVXRUkxU8eNYSuCNyoyrChWyZ4HagRYZoz2F7cH6MrmUh5ajM-4UA2JvU
    43tol_ylLoYddindjD42P4yoSZkiVE-PR0J7nkmkoOcoMGLsHI_zw>
X-ME-Received: <xmr:UuF8ae7OqqXey65ysxSHJ1xYPV14S7UiRGZxZdGHYCgGIdn1n7BeoFVHUzIhVT_ASZx68S5rJRnfz2vbqIqhNI1F78456sUgDWgWPk8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhushhhkhgrrhhkuhhmrghrshhinhhghhduleejtd
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UuF8afpy1g_JPZYLZDtXs_vTP6wo8axxSWWWd9PSQM6fcAh8YKPcRw>
    <xmx:UuF8aQgMdZ4P9tk7PamvfNSvVxjyUFicUGufhEfuR2AoYfBD9EOTLg>
    <xmx:UuF8aZLQlrIP3XlDbTI9b_16BkdSe6YBMfy2Ry4RIO9rAlYUneHs5Q>
    <xmx:UuF8aQAEBdpX52PAwPdY8q8LqygKT5qxnCjksO10iXfp2sLd0VHHBw>
    <xmx:UuF8aVocqNDZtboYs2mgnAEzV9aquKG2u1NsDZoNpbL0ax1dIq6yw_c->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 11:50:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #10)
In-Reply-To: <20260130142451.7324-1-pushkarkumarsingh1970@gmail.com> (Pushkar
	Singh's message of "Fri, 30 Jan 2026 14:24:51 +0000")
References: <xmqqwm107za7.fsf@gitster.g>
	<20260130142451.7324-1-pushkarkumarsingh1970@gmail.com>
Date: Fri, 30 Jan 2026 08:50:24 -0800
Message-ID: <xmqqv7gj6o4v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> On Thu, Jan 15, 2026 at 12:26 PM Junio C Hamano wrote:
>> * ps/validate-prefix-in-subtree-split (2026-01-15) 1 commit
>>  - subtree: validate --prefix against commit in split
>>
>>  "git subtree split --prefix=P <commit>" now checks the prefix P
>>  against the tree of the (potentially quite different from the
>>  current working tree) given commit.
>>
>>  Expecting a reroll?
>>  source: <20260115122652.18673-2-pushkarkumarsingh1970@gmail.com>
>
> Hi Junio,
>
> Thanks for the update.

Sorry for the non-update ;-)  The expectation was against v2 of this
patch, which was met with v3.
