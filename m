Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98022619
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738186484; cv=none; b=YXWfu7kEX6qnYrtbTTiuUZ+akhcAZMoYAdi4Rs00oLy5nZVWOMnahmAvzXrYfqsRA3W92Yg9D53IqxdBqm8BLxX/s1hCtnNJHLzLbsMNm/0/rE39FBf3v+FFHTjAPnGm830XXpql3pQRiA6zQTd70iVf1PoQgm6jrzsmK/M50rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738186484; c=relaxed/simple;
	bh=qHPAejgb328J3Q1Un1+RcoA2kdossf7+0RT/MTz6BjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IMgyPR3dVo5ssbVU1oVyX9aU6LI6rps/fI9Yvs03wOrIJZnIOxIJ4BidIjE5dgPNIEmNIwACoF1OEtNw8rOICeqkwVyxpwRtZDuDFQpSY5+kmQJo0OCXcNAbigVDaeoVQrVP13BVVo1uPUThSI9EyXQK94OOxWV3v9wrgEXZzfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jRY9a7zY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p6TlbRIG; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jRY9a7zY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p6TlbRIG"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6ADF2540168;
	Wed, 29 Jan 2025 16:34:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 29 Jan 2025 16:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738186481; x=1738272881; bh=0AT9Pd9X71
	ANoqIKqKqXZhyyX4YiGJg295nRQqKSqqQ=; b=jRY9a7zYSJzTO4pJB5/OU9yTXq
	PzP2LaqQmmFBsZ30HjyoCtLYFfk2ykz6ypeuSii2bI2bJUAR71YmqzoT4J49mfut
	nDtKYcqHpEV7wNjOLM0efraLWjy/xPBvDF5YBeA2cZymqD1djK0HN5Yya5JTbFRZ
	nBuoWPEz/7Q3oR+0wN2hOfqCVteSH4blat5q3ZErRwl2H3OylzROsbGwXTfBw86E
	M5jPvG14Fi+VigQz+j2F+Hc+/XMaMjITxoomkLMwfvhpu8bfLMznnYvNI+XX00iZ
	SpZ1XhuAMlP0B8DuFHRjbnyLWBw+oz/S9bbAmNfpnD0ujApPQ84vzAfRNzlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738186481; x=1738272881; bh=0AT9Pd9X71ANoqIKqKqXZhyyX4YiGJg295n
	RQqKSqqQ=; b=p6TlbRIGXK8y8eOx24MpkTWc8RpkJ3LbpuOkIFsKbaJWv7blHBw
	OnvW1dtMy7FMAvwWp41dxWXk7RGWAdE7Fq00gzl41kCXQcw7r8R8Zi1T5WByHAol
	xYLiRVnDIb7CTrPh1aRSiYZO8hG88Wy+wDjR1ePmZyirHKkWm0A3Dw7OU0b5iKnx
	cl58PmDLyLsbgpWxzikKptd7gNEbBfURL7QZSQgKnyjhGOgIgdEJJ0anyAUEs+hI
	D+CY72dPPY1/pGwZQvf2LQQm2Z/3GS0sIxuTvDC41atBZFNp8aGdW+nymCnJ4Gzq
	4Rnw1MDlp8ElSJzXiC9ir16r4eZAarpfipw==
X-ME-Sender: <xms:8Z6aZy0XsRz1aEm0UjjkHv1yDtTBBNuhnkEiiN5a4clsoXPsz82nmw>
    <xme:8Z6aZ1Foq_2j-8G2JGBgnLdvouVEk8zsVocy3XLmG90UdXk4zQt6mVwa6oR6khLO8
    N-hz4o16YEHi3t8GQ>
X-ME-Received: <xmr:8Z6aZ66IwGFoyrL9DYEvN7NzfT0it6CIFjpv_08_N4ECBC7Qgeezw2WFCp_smna0UElUF_tof0Ty8oGsJ7kwmjT0IHky_1etSuUE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8Z6aZz3yEcOw_0wJxU8yiNe122DPdIXovjNORv5fUVq31ju2zBG5EA>
    <xmx:8Z6aZ1G2xqAcQHo3bTvZametWAX52Q_bdrDleWKDSjAGcg9TRH5I3Q>
    <xmx:8Z6aZ88C-80fA3krifmIddSU7X0AWczF7YBsyijmyXjKOIT1JAEz3w>
    <xmx:8Z6aZ6m918PWIdmjzL0ouzZlS6nurSbBk_6NTxyFro4S1DGen_UIPQ>
    <xmx:8Z6aZ1BTrVJxabbPRla93cDJjLr6MsPnsf84WgFU0pqRxz_nXcppqsih>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 16:34:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #08; Tue, 28)
In-Reply-To: <xmqqr04lk98n.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	29 Jan 2025 06:03:36 -0800")
References: <xmqqlduulbgn.fsf@gitster.g> <Z5nfcAUZPNdDSI0l@pks.im>
	<xmqqr04lk98n.fsf@gitster.g>
Date: Wed, 29 Jan 2025 13:34:39 -0800
Message-ID: <xmqq1pwli9sg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Tue, Jan 28, 2025 at 04:18:00PM -0800, Junio C Hamano wrote:
>>> * ps/ci-misc-updates (2025-01-10) 10 commits
>>> ...
>>> 
>>>  CI updates (containerization, dropping stale ones, etc.).
>>> 
>>>  Will merge to 'master'.
>>>  source: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
>>
>> I'm a bit confused about the state of this topic. You say it will be
>> merged to 'master', but as far as I can see it's not even part of 'next'
>> yet.
>
> I am utterly confused---I'll figure out what happened here.

This turns out to be a simple typo where I meant to say "next" and
typed "master".  I was worried about something worse, like
accicentally removing one entry that was ready to be merged to
'master' that happened to be listed immediately after this one.

Thanks for noticing.
