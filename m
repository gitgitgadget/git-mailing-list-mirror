Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81889205123
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 02:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731377776; cv=none; b=UhQ2jc6rp0o3PvOsjB9ZgmOXCC/rk9YP3w2rr6ALMJrccraFpFk3OQiXpl9DBZxlWBVukyiU8KGQUWJZjPEbyg7nT8LauE+aOY6gk/6ug3lTbDMOZxHW1x6D4IB/RCnXCuhvj6JbbQpEW/y5WGRYdwtajkOwnCc0Q6kL5FMjzEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731377776; c=relaxed/simple;
	bh=y6tJ+wWP/fE1U5OB1JhA0uFBcvIgTnyt43Ckn+y1eMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h8FSIQl8/0FkW1SYVSxdwBg8LTlZq1S0XrCzHSt5VhuFv1N4CYsThIk4+ZrYVz6OuLzUzlYC0ItNaxUUl7nD7R6VYDHHQ3ERGCUv5J9czmqy3wSz5riix2ZtvxEO3FuZlAKMXjZoboCllAOPXzDpGh9jBke1SOvc4CxarGG/Gg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X7ERLgW8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fxwHbYb9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X7ERLgW8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fxwHbYb9"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8AA0511401F1;
	Mon, 11 Nov 2024 21:16:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 11 Nov 2024 21:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731377772; x=1731464172; bh=s7CW7TQXxO
	05Mwtzgj13mN43JCLcrOHeKouc4rapIas=; b=X7ERLgW8STAXFyuhJ9SevB6upj
	39y47MyjUsXwTuqA+fSr6elgCgyby8z8cjcBRrMVLFHRYXSuErbeoduE6J9Su2Sx
	ZHhkYQkaeBKOFW0dJVtjJle4AyrbMJaXg77sxi/gqQXXpHgiJRn3XyZFX3hdydSw
	Vl9j3sqwQnrSP9B9PqDd2aKm3d0X8LhjMAilDZBks2faHYbdVdUdoIPpYj8kHKzx
	QdWGEDssuw/n/RA0+X0zVFqRmkO4gvqljielHXLeYLIzSOwy65VNIDXABetj8Zzy
	DkJrOkVN6NehbcAHpNJ5Q6Gwxyw1bGxYj9RXVNo5aeb12fp0sAYe6ekQsXQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731377772; x=1731464172; bh=s7CW7TQXxO05Mwtzgj13mN43JCLcrOHeKou
	c4rapIas=; b=fxwHbYb92JAUH1mH1gkQ8q1yLtY3S4gYziY6SgIvgHXZdnYmovK
	iX/+H6c+WRnAnZQ9IZDuJVWTe89XFDYUBVMYdvfADNEJyUlXYsSKwXBjtPo4mwCX
	UQQ4h1NsYLT9YGjotGndwnXIs+t7pxWHXo/TpueqReqchFCAVzsQSJsQfGjZZi8U
	ckBWbnSX8hbM71VwwvITY4i28jClaYt1s1o02+PnqC8up/7dxtR1c+9nEdtS8JeD
	6sIBQQ0jM0tXvQyMxMQffw4vqOOFoeEh5MV6u8WLjME1BJkf9Mns1pbvMF8eGBuy
	t6MGeBm6xMDmRtywfyUvP5Yh1tEW8isFmtw==
X-ME-Sender: <xms:bLoyZ1Ck_eoS64OZrEetq4PW3c4cNTdojmo6OZDMyJvq6QjT40aDSQ>
    <xme:bLoyZzjyVBG3c3E8FrjyhfQekzBeUHDKOLV1UoZE8dGWYYT43oj1pJEVImMNJzOz9
    zhHlxHCfafh32kfaA>
X-ME-Received: <xmr:bLoyZwnKyYXB8HrL45f21x9zyG7MZsgHmnlJntJNSz2iS5eL_647GwOA7tq2WHhL0KNfRbPY1ot2ny8uSVPz3hfRNAJ-wYcedIYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
    dprhgtphhtthhopehlihhnuhhssehutghlrgdrvgguuhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bLoyZ_yHnpVB9hbxeWBq-EjeitgrkmnuLqFUau7GQy3WqnKc4AUj7w>
    <xmx:bLoyZ6QSQEOEcFg4_sxMKs4tWAGssWlJkzVzsWhX9MNb2zIcb4FQWA>
    <xmx:bLoyZybkHRuD_sr0DymA9q502NqdBGaeBO1e0wg3LJMy7g8Bo_AIfQ>
    <xmx:bLoyZ7TZWSCjkW6g2fnNVIBo8pNOGO_4GJlnyS85KQxiLq3wd-NxyQ>
    <xmx:bLoyZ3I4jEovLjdlZT6MfOEPPt4rv7ZqWbzMFOFRtjWRBqMEMk4m3-6B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 21:16:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,
  Linus Arver <linus@ucla.edu>
Subject: Re: [PATCH] trailer: spread usage of "trailer_block" language
In-Reply-To: <pull.1811.git.git.1728820722580.gitgitgadget@gmail.com> (Linus
	Arver via GitGitGadget's message of "Sun, 13 Oct 2024 11:58:42 +0000")
References: <pull.1811.git.git.1728820722580.gitgitgadget@gmail.com>
Date: Tue, 12 Nov 2024 11:16:10 +0900
Message-ID: <xmqq34jx8adx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Deprecate the "trailer_info" struct name and replace it with
> "trailer_block". This is more readable, for two reasons:
>
>   1. "trailer_info" on the surface sounds like it's about a single
>      trailer when in reality it is a collection of one or more trailers,
>      and
>
>   2. the "*_block" suffix is more informative than "*_info", because it
>      describes a block (or region) of contiguous text which has trailers
>      in it, which has been parsed into the trailer_block structure.
>
> Rename the
>
>     size_t trailer_block_start, trailer_block_end;
>
> members of trailer_info to just "start" and "end". Rename the "info"
> pointer to "trailer_block" because it is more descriptive. Update
> comments accordingly.

All makes sense.  Often "_info" suffix has very low information
density, as everything is "info" in a sense ;-)

This was a more-or-less mechanical and straight-forward renaming of
a handful of variables and structure fields.  It is a shame that
nobody bothered to review these changes (or say "this does not make
anything worse, but is it worth it?" to object to it, for that
matter) for almost a month.

Will merge to 'next' (unless there is a belated "it may not break,
but it is not a good idea because ...", that is).

Thanks.
