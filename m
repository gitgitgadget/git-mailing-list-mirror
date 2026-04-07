Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55923783D8
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590969; cv=none; b=GIjDAJJ7bpGT/S4t/M4IWML4AuHOSXbJzi+/wWaQEFpEq+h/a3v1rqEq3cGxOM68Q685tp+RtwldsQ2ffZUIo8aQmtoJUrZ5k2dI3Y3DklPYZnqpCgm0xZ1dhUge0vjki2XWl+xe9HkoBfIE/8YT3GvCEE84IGS68V3kqCcuBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590969; c=relaxed/simple;
	bh=a/JdA6P3slIhF4beTpv4NVrHOXfI2Z11wpQATWHops8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RV5pCYSdGhOlKge4KYd383+FLUdQqZDK6Bhi//Km4DI10N9RyFffJTN3N8EhhC2RiFcziP1FAOI6g/YQalw7Cd1hMRDGBw3EXaRwySKp6rAEPmqQdDVvyjeZ8XYb4fuqdNa/Si3iJoay0oCjcpaSUmmhG7SCEWw39sFkOZal6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BDB2kosE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hm/CrxRN; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BDB2kosE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hm/CrxRN"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BA0EEC017D;
	Tue,  7 Apr 2026 15:42:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 07 Apr 2026 15:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775590967; x=1775677367; bh=VZ+XzLY3t2
	FR7pqDNKzHBELCUJZtwGc4aXHx3uFKVuw=; b=BDB2kosEjhsaekzznuIvnJl2pD
	S+Tu4RXVHgpMSb8RdcUL4H3nnrVuSGTYgS+OZKs+cfpe2u9VRt2PrRAIuzammoz7
	ShGQjon4BEh0QLAOTkFEHTaJNecsOFHa465wNuwBgkTHj+qJqmCenyLzxQllHHaX
	Jcu5tx8mV+NVqKo2DgEybOesmNEZbVAH5osbJiW9m6MEDseFYfwJy11biw+Np2TC
	ujVo51qe5y0j96AV8PX8mRfzG1q0b7fs4TaJXw7/EB06NRUkU7exAMb0JW+RlTs8
	pIIOnFGk9J6traeh/8uO8aNQ8Ocz0ATi8beqL0WjmA8IWRu3D2WNSKJV1uiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775590967; x=1775677367; bh=VZ+XzLY3t2FR7pqDNKzHBELCUJZtwGc4aXH
	x3uFKVuw=; b=hm/CrxRNjAZDmJTFvOT2D2fXDg77I0OZ6x5ZiAofdmRPOHHTGH+
	cs2vE/iOrrpFttajVLESW5UMc5SPBACEwUvwl4ngt3chBWMNdHcT3nK5qVLwqflp
	uGuPfcPil67D9OS7BxX/X8cz8izLD1VkPvm235KI5qW27pA+xOxe5IELprbD45eT
	gUpo++FIBp+XduYzyYymxHw3ULYaCqw8NXQ5AtNTEEfYedb4ZkTlTMRhDvrsHa0u
	oBLwdBK0jzQYFFPNwoYkMZaxTXhOgFcx202+bN/aFc4M1Uwy8qwqpD7cL2LVPUZu
	EcuiAnwE/4zyQAW8p6j9Rl2YNI9mp0Tg1ag==
X-ME-Sender: <xms:Nl7VaQDDcF-1rE0NtKDzGYvqs_715YpmFCC2ibTfEoi2kWUTdPD9kA>
    <xme:Nl7VaZjHYxnCGvUpZx_91NZoSXMYal4w2HvNJkPueo1qpIaruP1cMgXqefKqDkgs3
    zg2HNama8EDQMR5H8WdX0UvWqjh10QibYHhM6Jyl0xOe2vPq--rqg>
X-ME-Received: <xmr:Nl7VaYmZ2LIWfyEBYnfZdIFozZTbTnSxNi5Ic7oD7P6hTTQWQW_iheqSBhEUSUt0e6AI5ecAH9Ud0L2cmbwc_Bs-9rLEfb6gzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehvihhkihhnghhttgegsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:Nl7VaVqDlvFMD4zhvy0lwN76pottznHCRh6rt9JS1zUe7F61n2tOrQ>
    <xmx:Nl7VaRH_UecnGcpSVHSbrC_hRf5POGcvLBTAcUq1ROJlKnQKw_aD1A>
    <xmx:Nl7VaRwuVVlEUDplx7Gywz1iVuOj9mcoC_k0_KaL0uiI7ek-A6MgoQ>
    <xmx:Nl7VaWrdbOIG_YCSV7lxPFdfBBkqMsU8WGky9FIxk86JStb2K9bPPA>
    <xmx:N17VaafklzqEYxVlDETbBGw-N1_0ddr-pegVmjFyJVU5R0GUBW1Gv1NZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 15:42:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org
Subject: Re: [GSoC PATCH] backfill: add --[no-]progress option
In-Reply-To: <ktjgf2gyf5wkktiquy4cfzdcifd2yhqk3mngckaih4bwca6fda@nkcju65ku7hf>
	(Trieu Huynh's message of "Wed, 8 Apr 2026 02:22:33 +0700")
References: <20260329152443.525493-1-vikingtc4@gmail.com>
	<8db10441-2fce-43ad-bcdc-331d26ec38ed@gmail.com>
	<xmqqh5poat4x.fsf@gitster.g>
	<ktjgf2gyf5wkktiquy4cfzdcifd2yhqk3mngckaih4bwca6fda@nkcju65ku7hf>
Date: Tue, 07 Apr 2026 12:42:44 -0700
Message-ID: <xmqq5x624kwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Trieu Huynh <vikingtc4@gmail.com> writes:

>> >> +	display_progress(ctx->progress, ++ctx->batches_requested);
>> >
>> > This looks correct. My preference is to not use prefix operators
>> > like this on struct members (it reads like you are incrementing
>> > 'ctx' and not 'batches_requested', even though it is correct).
>> 
>> Thanks for paying extra attention to such details.  In general,
>> post-increment and pre-decrement are the norm when evaluated in a
>> void context, so the use of pre-increment above violates that norm
>> too.
>> 
> Thanks for pointing it out. Will update, eg:
> ++counter;
> foo(counter);

I think you meant "counter++; foo(counter);" instead.  Otherwise,
the first line is exactly a pre-increment in a void context.
