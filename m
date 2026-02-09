Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA97E38A720
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665755; cv=none; b=t6FRje8g1N0Tjwdhefq5SnpX+DZjJZu+KThZTi/Tun+LL7KXZS+qbi779ceiC4YQUIE0J/fGNJb0bz4OMs+AWaDGHMJaQXIFNJEgtaR9K869tMvHnfyj6VvPPKQLgR2K7oJqJSNKzH5Gca92KaqmHvm4h5Cfql9fQu/Ry4aeQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665755; c=relaxed/simple;
	bh=bCm4JcIGYyHxfepyKJ3bsRO5rQRxQhEwHbrWx5u6X80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ht/yrsejWzj2tpaZ8df4O5R3UuR7NxODKV/F5XDaXnasSf63w6VmUmRtqfyCEiJ8Nyzq6BjMG6IAUxtAIquFhomgCA+WGLYmrgFUUG0GZzONPT5mKRLeh3vTG3TZ0UgO5pQFhHb7kYFb7FUWZqm8D3C3TCnBJ9lY+KjD2UdBBTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jrDvnNSw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f7bUZunf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jrDvnNSw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f7bUZunf"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A81E71400189;
	Mon,  9 Feb 2026 14:35:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 09 Feb 2026 14:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770665753; x=1770752153; bh=sUD7Tre2mJ
	qVj8Sur3VmcwQkGlc8fcsP43/6U7rlmfo=; b=jrDvnNSwzeEIKNkfCv6+N3vrlw
	URoJqWhWkimhh01cCFPppxz2zBIwRcoBRUhHs9A4xcu/jxJLM8os35iPAu0ALMiS
	889X45tX8hbcnIaOp5h64u52AyaIG+fIarw+FeVuwH50cKbqNEcP6WR5lMkbKaC2
	1uvwokbEKytSfBBePqopsRrzttswbvTWWRZ/EosYL3RqFu/BLBP6HxT295BgSQw0
	QNwkax9ep1wP9mwPBkaJT6JdYcBJVhe3RaN0bcdur8rMIuFQgvcoTts47vpuljSJ
	ZMflLVV85n7Wu3qe/C7LnD4VDqHpXNTM/UyIwUqGhEokGdsSIXmJcwMUrnSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770665753; x=1770752153; bh=sUD7Tre2mJqVj8Sur3VmcwQkGlc8fcsP43/
	6U7rlmfo=; b=f7bUZunfGLI0ltcTt5E/NimOsnuAsrjY7XAU4vZ8e9dHdYHynUJ
	C9EFU3R+mgjXiUEchGXwBu81/aICfxKyJ4DqS/olENe3Tq96b5rfq3IR7y6vkZCv
	R3jqfsMLV1KgVFcCDsWSQPwXgijTRx2gqfA34xeDb7V/oCgOLIGtXfzCujwPm/JR
	cf+sjmoXPurHwgNagYmIjSrpbmk9y+9ZcsVWAfMnWVDzLY5jZgXcAy/OA1fSmZ70
	SZaseiYTk2CC4V999YpnaGoStqIfCsqfToL6lPqiZhfUmpzM+ChzmI4lymcQaoYe
	sLTsTBtMELz7wwkRtKVrmm/s7zft5Fqombw==
X-ME-Sender: <xms:GTeKaRAQ7_zQXF-Ywn1g3zav0-_KhhKLmVVgz8DrETEfyR6XNGHeJQ>
    <xme:GTeKaWj3JozKIzdmOhTnDsNtdLbDE4UPvaEaVHMm5OGooCqZ-q1dryrttO8MnNFP9
    mZTqi_rqXyb3xf5yLOP4yxKGedWkgIrWSQSUp12eR3C2BWrKoUG6A>
X-ME-Received: <xmr:GTeKaRnVqGBcRBXDviCwWN6tv6Oo_HiT3LGAf8NhC-1NUI0ztlZ3zXeYGGkepd0YBHEbelurKygnvWKu7w1n0ZP-HYvXCyIP1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GTeKaao_g9GlUBRRn__uUz3U5pP-1D1lABRVMoIYXlQ47qV1cGeDAg>
    <xmx:GTeKaSENDuqrazUa9X5tnTgcnsB6mp-AKGlfpdavg_YI0vkr4oRIOA>
    <xmx:GTeKaeyKyU7qQMpW3f-oj1WDMfo-MW8kupODa2jg_3iS5BV607HbVQ>
    <xmx:GTeKafpBG-DvQPASzmdfzZstBpyt4CxZT0BSuRhOfwtDX9bT8DDu-A>
    <xmx:GTeKaaUdZJVIsGLh9UsS6ymSCnidE0nF68MQQ3Nrs1RhcZ_IDwvEugCC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 14:35:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Johannes Sixt <j6t@kdbg.org>,  git@vger.kernel.org
Subject: Re: [PATCH RFC] graph: implement git-log(1) --untangle
In-Reply-To: <87h5rqqv4y.fsf@iotcl.com> (Toon Claes's message of "Mon, 09 Feb
	2026 07:38:21 +0100")
References: <20260206-toon-log-graph-no-merge-base-v1-1-a6f983991a1d@iotcl.com>
	<ad776ca0-1038-43f7-860d-2f3a78a5db6d@kdbg.org>
	<87h5rqqv4y.fsf@iotcl.com>
Date: Mon, 09 Feb 2026 11:35:51 -0800
Message-ID: <xmqqecmt4smg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> I've been thinking about something else. Display in some way part of the
> history is missing, maybe by showing a '.' in the graph:
>
>     *
>     |\
>     | *
>     | *
>     | .
>     *
>     |\
>     * *
>     |/
>     *
>     *
>
> This indicates a piece of the history is truncated. I'm still on the
> fence about this

It has been quite a while since I used gitk the last time, but I
recall it did something similar.  Instead of saying "I removed line
from here so you do not know where the other end of it is", it drew
a little down arrow and there was some way to find the matching up
arrow further down in the graph (either being in the same color or
perhaps clicking on one end jumped you to the other one, taking
advantage of being interactive program, I do not recall the
details).  I wnder if we can "label" your "." above with something
like (a)..(z)(aa)..(az).. or something?
