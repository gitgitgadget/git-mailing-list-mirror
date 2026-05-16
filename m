Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920819539F
	for <git@vger.kernel.org>; Sat, 16 May 2026 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778938552; cv=none; b=ofCkDC7AOy8Juaj/gKkRvxyoLgypUnxVT5taA0LVF9o1pXSn3zgaH+o7ns85ethiGutFjF0G8uDJHSGJ9vbdygZ56xqFQohG3StFjIDqFClF3kl8HWjUID5YRTAi5S0UiR+ZUKVVwS2sSS68J42jLQGPNjof7KdrgPixGu3HUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778938552; c=relaxed/simple;
	bh=Q5nlaroccQYdaR1pE11y8P5M6UMPDD1GTHn9A1tXqsA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hDRR2O4pgWEY2kqpzlmHJe/bq4YCU9oKuqbqj1qkvWmofsyKwIyDGI8K1mo+T4Df8d2uzTLZe0/t6GOF40lhWUWfykJkOiZl7d/NAwV1EsQgzN1hsPO8w001RXWzNK7JoDYTKDEkixWI1Kk0LFzT/6YXcXScnrzr/499vR2vfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uO28Eokd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fkbB5d2S; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uO28Eokd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fkbB5d2S"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id AE4E61D000A7;
	Sat, 16 May 2026 09:35:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 16 May 2026 09:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778938549; x=1779024949; bh=2riBXx2RKg
	pFW8iU8BLSbI9SudnFfGFMQSSrMAjyHo4=; b=uO28Eokd00hYXfc40Gx2shLZVD
	uVkjxlbIaYoxhI3VV/9nVec61j+tO66SgLitazrk35MuFrb9eojzTd+Z8Hh3HEou
	YEpKeyzz0tEv9BtHDc0T8c0N4bcvLAMxjHy7esmoo6rZIl4cJXiy5YWVwjpOOKdt
	5dE51xLY20NxsC+itPc2l1QqeozPUYa3GCygo2VTrkbUo+MtSIuhBw9nqweTKOaF
	FLGWi+vuGjdH+UpqNtdWAudISRJ5Z7qZMPH3HwZXmrnnov2R3KrDswDHUAf4bh15
	G8x6sg+80/bfA01Z/kXPsP8SJjiG+BWM+aY+Rr0LG2d3gHxDT17V1lMH8kqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778938549; x=1779024949; bh=2riBXx2RKgpFW8iU8BLSbI9SudnFfGFMQSS
	rMAjyHo4=; b=fkbB5d2S7p4UPfMirqNV0iWdFKBwJJFhu0lb8p9O+9ayYedd/Wc
	QIfN1hwQXgzNswL6VSkXgUYWFEg97zc67VVYwg/D+D9CkvOtAe6vUh6vefcnLGjC
	vhG72lBxtOK0cDqOdjLGJ1cwgkXFIpAhb0PUNMBNVppQOdDyXVslum6zwDKun/sF
	1nVNMTEzVMSiBlotCd83nkRKuxJB9KZuVHmrUUoTErVhysy676usWffQH6BsimJj
	0GKZ25o6p84kSPP7FcAVQAAUWznRokIG48qFTRO/JLJ6R8/MJeyNRnmrlUfGBAon
	spTqOC1qFO5xz2dCCKls41OPzd7L7UpPJ0Q==
X-ME-Sender: <xms:tXIIaqXoczekLepm1iQrinPvo-_65c6R-dzasqKjCiRNWjWck-dhKg>
    <xme:tXIIatkMqbC5UvB1tZi2V3KGtwPvdhfv26ryT5bSj6Q_GlAaO1H2QwJfgJJV6YLxN
    lTZTM4Xxf4CtTyG0xVTCk8sybr9qQTDhnROQqormzVOJB1lr9wifg>
X-ME-Received: <xmr:tXIIajZ8e41i71OpQMWQ2H9yHvqA0N38Dr-r7ne-0NFiY-5hxHxeks70T3i9MA6MNpdA0bP9TvkkJpWAVxOSkdOd3HBO-HYAJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeefgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthgrrghhohhlsehuthhurdhfihdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tXIIagN1FF6zCJxY20mTYOAXJPW4XETy-F3iBnIT1X6I19zi8V8_gQ>
    <xmx:tXIIaga625XM2ZLHhaFW09XxewctCfnc5_ZA1FUxC__7Ro9w611XGA>
    <xmx:tXIIam3mzTc53vVMAC_sJvBM6hQAhq0pSdF2SPQevlU5CtQQyjeVKw>
    <xmx:tXIIaucdGDpz8kA5TR3Fpxhan0SqiNi0ozctBJlHslDKTHmr3PP4zw>
    <xmx:tXIIararoy6m0gQFxvnSERJGA07cgBjwrVecrYwc3SIb5NN1bt8qlDy6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 May 2026 09:35:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] approxidate: make "today" wrap to midnight
In-Reply-To: <20260516113622.23902-1-taahol@utu.fi> (Tuomas Ahola's message of
	"Sat, 16 May 2026 14:36:22 +0300")
References: <20260515205803.26211-1-taahol@utu.fi>
	<20260516113622.23902-1-taahol@utu.fi>
Date: Sat, 16 May 2026 22:35:47 +0900
Message-ID: <xmqqik8ncw98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> Although some commands do reject invalid approxidate expressions,
> in other cases those are simply evaluated as the current time.
> Oftentimes that is a perfectly good compromise to handle silly
> requests, but it isn't without rough edges.
> ...
> Bind "today" to new function `date_today()` as an approxidate
> special.  Make it return the last midnight if no specific time
> is given; i.e. retain the old behavior of "noon today" and such.
>
> Document the new behavior of "git log --since=today" in
> rev-list-options.adoc.
>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---

I like this construction of argument.

How does this patch mesh with your earlier effort to make "noon" and
"tea" more sensible?  Should we eject the "today is now" step from
that series and instead queue this patch in its place?

Thanks.
