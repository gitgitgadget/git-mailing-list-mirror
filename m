Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404FB6FC3
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029723; cv=none; b=M9FAS3JUTNKQU3eBqXknFgcNX8aj1JsuAhNhDWxVF2ujvF99alOG3Bo45k+2Z3SXDIQfdhD/IhQQofhNretGFt85/y1uWvsOLnie0kM6DJ7sRER0JpbAzGFwgxvuOY5SkcXYUAw7ipqs7mK3V7CXs35/21/DM07F66TTXkxDVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029723; c=relaxed/simple;
	bh=uJg4RuUM24Thte8jUAw26sTxHtm3G/um3e4Hqk9+3kI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b2EDwc0wNrY3LYK8UdiXltrKUVIvLT7NkTPnrSZjc2BUZIxjQUIDhiXiFmGgwRRrP/FbcMNCVvz1LewT/8TunslGD/gc6+cEzc7vHVETBAp0YlMA6weMLQJqoCV+Bqw4YKN+3f4lPjysCy/h9axM1oKwvNsyWARMzHWesF7dUKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XdAjQsSD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7Ha7cUw; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XdAjQsSD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7Ha7cUw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 547307A00E7;
	Wed, 21 Jan 2026 16:08:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 21 Jan 2026 16:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769029717; x=1769116117; bh=q/SQ4U/QOt
	e1j11RuOyNAaMLQIM0KfScUfzPuMd6Is4=; b=XdAjQsSDFIx/vS3yq7OoowNjD6
	tEdj++gQM2dHqOWRPnwC944iQGl045LzbltbL/hFs2cbS+eA+8QvS95LRxs/8YMj
	qgZO9JYX+hQ3fj8jfs9gGAWG2TtLbMi736GHKdZmGarLbMR30WOV6uQRGNIYfvkJ
	eq+++k8SNtxa0DIpt84NHawPCpxKedDaXzpmbyE8JS8BLIH/ABn4uFexZLSH4Fn6
	UQc5MxlioYmFLdQZKcrGJq5RBvntbl7GqnVtsZt9gYXMmCzcrKqB9BckYk9+Rlnz
	FNGtfHP8fYnJqTpkXBuUifX4+Wc8PhPCeRm/ovqKN9PKlGJw7dPsZooLerqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769029717; x=1769116117; bh=q/SQ4U/QOte1j11RuOyNAaMLQIM0KfScUfz
	PuMd6Is4=; b=j7Ha7cUweHtZx6rGLcpLxEjGZdK8eYrofxZQi8pgnerQ3AnYh7g
	jN4Yjc+mb4js87sdnhFUntJ5dNCH/LzUBZVoCzBf62J1iJTWrjnvl9F03REjg6Is
	OBuCfdyrQE9n8D/JofytkHOGkcgQ+/ZgFcmhm7nqIMx+LE1F2ePfkKHuhXdheF8a
	lEh3J3Iu7FskW4XBLLIob0vH5r38yhhm+D0BM0KBQhN/ud/hwdC6wfZyoGiXhPNv
	LjEagZF4TuYIgD+GhswgWTzefzqoBs+uXZBobpsAyxyfGj5QA8gKf7yrOmUG1S0a
	uzhhGsIc0/0Y9n9Dzr1YxkXZJl0vpRkqY2w==
X-ME-Sender: <xms:VUBxaczzVvCWuO2Orcovp8dCRW_Ftuv72fNaWNv__vUr4WW0wZy5lw>
    <xme:VUBxaXsN8c3jAnFuJoHInrXFGKZGLsKPzaN2IapixrToPgVygLR3VuxEkaA4MAZH0
    zUO-PIjYw17aYP0-lmG4b8yaGO4GxjqL5olhEBniB5EXj4R7TjE>
X-ME-Received: <xmr:VUBxabtHoY3aaHioWcnBcSwHb-nVQZ0yuwNvvEIpLvyx_2sxYPpgBCLdGxo5Kl1PRje-vwrog_W2kwHbVK8a362AFVeFbUTZdrnmJUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VUBxaUMQTGfUqGrpiELVC-pCtcEdHMpovQBjzUgzuQy-H3dgdTW6vA>
    <xmx:VUBxaR2aJNRPON6G-bs67N_fttXtorPPkwNB8BeRhs52os8zds7dzA>
    <xmx:VUBxaYMtWXnUCzlSBUSYfI6GEBL3cjBV9jiunZvp0DQ1aDyVUUFGng>
    <xmx:VUBxaZ0cc8ZRwDILgz3THQ5ZYKt3DZXh3KztBjNtU7oolB009GXesg>
    <xmx:VUBxaXs_jYKATfi6yKPGadVEm1QAd8mnS-WbcMbDCxfmbraynNj7YnMx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 16:08:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #07)
In-Reply-To: <69F44B0F-0780-4635-8685-704732FC4106@gmail.com> (Lucas Seiki
	Oshiro's message of "Wed, 21 Jan 2026 18:03:06 -0300")
References: <xmqq5x8uu6yk.fsf@gitster.g>
	<69F44B0F-0780-4635-8685-704732FC4106@gmail.com>
Date: Wed, 21 Jan 2026 13:08:35 -0800
Message-ID: <xmqq7btasmgc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Hi, Junio
>
>> "git repo info" learns "--keys" action to list known keys.
>> 
>> Will merge to 'next'?
>> source: <20260119210932.68893-1-lucasseikioshiro@gmail.com>
>
> Not yet. The last review by Patrick made me rethink the entire
> series and I still need to iterate a little more on it.

Yup, I already marked the topic to be expecting a (major) reroll.
Thanks.
