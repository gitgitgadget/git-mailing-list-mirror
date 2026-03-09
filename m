Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFCF274652
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081059; cv=none; b=cp+IyErl8yWzhvNEFDpWQiteQ4spUZZ9EsN6c7WnawFPFdo2q63o1RjU5UgReQfDkXlfBDNRAjcRTPBhF+ojwxIES0YzQWcVJoGxn6pFgoWZnVjGZ91f2SbI1aiw7j7ovW33fsLuGRU9O6NEm19rYQirDN4bxFxTBbcIIs2m6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081059; c=relaxed/simple;
	bh=wykFL5AY1yTGRX9bZblPFYSNc779imE4bjWDG9wOlf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f6NTdNiethsQsvi09NrLiQlnDF68W31EwoR30esmNw4gWnGGZR5Q3dvATDW5i2y6HxxsASJjFYk/xYeI8yA+xjHHY8dFZmB7VNCXM9tXVFuX4DBMzu+ItKV9Mxn3gQK89FhVWTwYS7i+1Mnakmwe/Tjxfm25MjaCufDageIOb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k2FTo6nM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YgtvXE8K; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k2FTo6nM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YgtvXE8K"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 40CAA14001CB;
	Mon,  9 Mar 2026 14:30:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 09 Mar 2026 14:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773081057; x=1773167457; bh=eSDUUsOKoj
	iQPPRV+M5u28t5/fvCVyNepXIjqSnGs+0=; b=k2FTo6nMZuYVmh57ZIH2BjTEYo
	sy5mGQKqQRiob2Z1PFf91wM17Rb+GpX3nhWeQk3wRBkTefgZDWSAEw1fGVth7fhF
	BGA/yubvtmi1FqNwyFVhCa/0/gcMGGLJADZeZII1sCvESGWYc8ecBQMSUhAHtuok
	ijOd/SMsoqWRyoJKrZRUekq4mmq++F2ApEUfD0/o7KwwJjTO/fIH/IguEJau115C
	gNKVo3p43P66P/c+KbNpGOOXe+zgQ06RT/hqhKs5YKKPmQPavjxdQr9xtgWUJ4aD
	WDhgEBEwI4FVqOISkuWAl2Sb9LgnQLjcXY+BqtoZUESwMHAFgYSiwz4K37Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773081057; x=1773167457; bh=eSDUUsOKojiQPPRV+M5u28t5/fvCVyNepXI
	jqSnGs+0=; b=YgtvXE8KE4fUQgHlwAtKVZxzt/jmTRsX7q3QDNEa9v9F/kfyIuM
	z25JBpB3Mzp6wfcsseWW5NujJ0v/XFHs5ZrHfRSQu4iblZkX/EaX3kT/7eLDEmU2
	nIs5gtQyUlSsGRMA/cDTP2IQr5OvY5SC7CUjjTGNoq0pzw2ahjM/5nyMh80jWksU
	i10dKg7XZMulDHkHJ6BoMJnIYzsvs0hA58OXBNCKzGzvCPLoUrTPBGwiTTuW5B64
	sQpTf2ytWJ3sV5BmdtyZHaFiEruHhneiNO92sxy/AHzyCHk5c1DSFemeWEu/x1UC
	ad2hPwWlo2uDBD2b2MovDs0wtvvBYgELNOA==
X-ME-Sender: <xms:4RGvaaGN7zcv65LX82aBTP2pQbtXn1QxkcCei_lNwUAqnWNfuvXl8w>
    <xme:4RGvaSPa1lOBLS_fqKk14d6T9iIPbj42N0qYUj8MVL0RXVStAbu9TGwIKOsjFPQ0D
    wVTd0baJaEY9yqPyMClicE2If9vO9Qe4ak5W-8QeUEJxu4hH1_Gtg>
X-ME-Received: <xmr:4RGvacflzM9f32pOzX9V5iJmNbTPb_nirsqTAcQ_ayCzhInfrPabq5_TQcSsLDsy_pTawqJJ2eq1OK79ORehwV2f7MIk_tb4fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4RGvafvJw3uAo4hwdOaULytGP3hURZVY-s0GCO8E-JKJJDgcVmvTbA>
    <xmx:4RGvadk-TqzE_IOhMDPxJojCbambN9IIpEn6ZlsHrCDgGzK3ApJ-cQ>
    <xmx:4RGvaRwS0MuhOGx_sTft1D1DzLfEGxQ-_TMLJEgktjcDPSg4uyxm7g>
    <xmx:4RGvafMl5gdyQd9HB211Zg7PHHj5DfaeO80GPFe6b3uTsGgUfCi1Kg>
    <xmx:4RGvae9T6QiR-vS8f2-ShH2gWOqWGdn-q8TZSZp693XpBsfG-DbCqCNx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 14:30:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>,  phillip.wood123@gmail.com
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v5 0/3] wt-status: reduce reliance on global state
In-Reply-To: <CAOLa=ZR1nfGC499-mKvK2xrfzAvrC6nvpu=XNj0yfC7JpMT08Q@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 9 Mar 2026 03:32:50 -0700")
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260218175654.66004-1-shreyanshpaliwalcmsmn@gmail.com>
	<xmqqbjh0y4i1.fsf@gitster.g>
	<CAOLa=ZR1nfGC499-mKvK2xrfzAvrC6nvpu=XNj0yfC7JpMT08Q@mail.gmail.com>
Date: Mon, 09 Mar 2026 11:30:55 -0700
Message-ID: <xmqqfr686ejk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>>
>>> Changes in v5:
>>>  - Added the usage of struct repository *r in addition to adding it as a parameter to the functions,
>>>     in patch 1/3 instead of doing that in 2/3.
>>
>> We haven't seen any reviews on the latest round, but the previous
>> iterations all had good discussions.  Is everybody find this round
>> satisfactory?  If so, let me mark the topic for 'next'.
>>
>> Thanks.
>
> I'm happy with the current version. Makes sense to move it to 'next'.
>
> Thanks

Thanks for reviewing and helping the series to become in good shape.

