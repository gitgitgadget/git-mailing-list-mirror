Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DAE23875D
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755447689; cv=none; b=MHUgOUnmSeIYFabEv1h/5jBv9xbcKubvcgQCWtyO7tZXZxZ9WqBRWyOxc8zCiUOSVxXj/Z5kiuYnjKHi+h0B5xv2C2JFRY5/v9QCDV4exqZk6PS4KR58FmhHnLpEET+CCfgL+TwbKu/MBgsBtzQsrPI8VkYe8zyy/y4VFsUeSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755447689; c=relaxed/simple;
	bh=HPRURACAOLolE2+Sv4w11dUesoy2dyd6kQbmpu28Kj0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qsbCHdOKw50sIxy5JmDkcfp57OvmefgUFaZg9Mm6Q42b5Wtz1jeS3xKxyUNUN4hSQIi4q+8kfMuooy/cLwwriK3dCJQIQDloRDmUpChpARQUaebL/75U0GUsWTFnd+HXW4mLSPsIQfDo5K3K9Z6+PD4SD7uDif7zUIHatiReYP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SGwmQH+j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V8d9z7AM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SGwmQH+j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V8d9z7AM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B83B1140003D;
	Sun, 17 Aug 2025 12:21:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 17 Aug 2025 12:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755447686; x=1755534086; bh=T7rAXddSLf
	1lZ3M+mU4HkxLwChpnxBy6lXo45I7gb8Q=; b=SGwmQH+jyF1MqwUtOio15kLkZk
	2V2X+SJmiNzGY+J00kr6mUN7R/sqdNsdh/4dy9R+Zdrl1uVgGXRKndgp7GzU9wY4
	3Z/TQvcIxKY7NfHPPin2tNhKmf8MLDnYRLSQpm97v9SbvANpUJD6pVu0g5v2v/4l
	Tf/i9lKJxdcnHynSljZ+EgzvUF8kOyQVDJPfwJeqLFeKKouxgVES/e6Qlojhzj0X
	uakJkdPICzIc/pUtSrEIJRTG51u5iVyZzkCXYtkJcS9Jwi3B4BAXLdfPE2SYGQAN
	jmChYfWls/eQdPg6Nfwe7MPTTaaO3S0d3WDPLwCrnIBwuIYua+sQZjj36pGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755447686; x=1755534086; bh=T7rAXddSLf1lZ3M+mU4HkxLwChpnxBy6lXo
	45I7gb8Q=; b=V8d9z7AME8YKnkBIa6x8oQoHlJYXE1cr0gCNaB3BL6Enf4pClVq
	aNsZX1RwaCxyL5VVrNeONCIrG4StGqMX5wKPuoVsYu6QMNkQWfG1tOoD0wthr04q
	Wc6XKT5ylroi7J9DbHMdKIhRivkRO5cqjuK00O1lDTHD9JrURhmoeHUuIvNNI0bE
	lUtDn3j8Biki9z06PU5yi409AluT9dTLhH534WTdeXfACfVnsDBfVuGIJWTu0scY
	q9iErmSHpXxWzm0StmL0L7Qy1kepC0eoQ/APqZZjRDxF9/fOe11/FEja6Ha1OEbE
	utvhLwc8H0as1r13hbhsqlJ0gGgOtdu6IKw==
X-ME-Sender: <xms:hQGiaJmF-CgEQVqg3BfhlwTUcw-6szm0cmqWlMcqcYC0lS5zvU8lSg>
    <xme:hQGiaNebMogEZaZiFNqxdvUaAyVzZeCVs5RPf4AgcDibfx_bMi5yXe_a84Ig_wOtJ
    n0CkhrhO56vEgSkQw>
X-ME-Received: <xmr:hQGiaHFXqIhok8uW54FIoKz8ycVzEOrQaCL9KAT89VX4LCLO7mnX5xpEUVUwGvHRqP9BTdDodEl1_k3oSeYfUuiVqvxGJXHYZRf9ytg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepvdevleffhfdttdfgieehgedugfffvdffvedugfegvdegtdehlefhvdeujeeh
    tdfgnecuffhomhgrihhnpegrshgtihhiughotghtohhrrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsfigrlh
    gurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggv
    rdhfrh
X-ME-Proxy: <xmx:hQGiaDjcM9iGZFfkf43czuLeBZftcyEy7W6-boEGhuKZUs6s2TXadQ>
    <xmx:hQGiaL1-wPYBoud-tVkGEV1CgG8Bc1zqDQ4tPWmvPl_RldzkEbKLyA>
    <xmx:hQGiaOf9YIa0wTR0xq4wjXcnh4EFpBzRDAtJbLYdwARvVD5YJEukiA>
    <xmx:hQGiaJziC_Hi1w1OI7YIzqbO42mjB89ve1ahxoFTrIrqpX-4WgI0Hw>
    <xmx:hgGiaBTUfO00EVIVUCl69ophj3uUWxNTY-6ojI1JqMELCwETLvVK9c3U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Aug 2025 12:21:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  oswald.buddenhagen@gmx.de,  ps@pks.im,
  karthik.188@gmail.com,  ben.knoble@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com,  jn.avila@free.fr,
  sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v11 0/5] repo: declare the repo command
In-Reply-To: <20250816224603.3307-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Sat, 16 Aug 2025 19:45:58 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250816224603.3307-1-lucasseikioshiro@gmail.com>
Date: Sun, 17 Aug 2025 09:21:24 -0700
Message-ID: <xmqq7bz1ly0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>      +The output format can be chosen through the flag `--format`. Two formats are
>      +supported:
>      ++
>     ++`keyvalue`:::
>     ++	output key-value pairs one per line using the `=` character as

Earlier I suggested to use ';;' out of habit, but using ':::' seems
to be more kosher, according to

    https://docs.asciidoctor.org/asciidoc/latest/lists/description/

Thanks for sticking to the best practice.

Let's mark the topic for 'next', unless no further changes are
needed.

Thanks.
