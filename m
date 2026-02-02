Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D512219FC
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059021; cv=none; b=S4EB4O3XzWfRYLoNPQ82JpXf5ppYiuOH5TesIHs6eEY7bi5xQptTTC+lcCr4rJIvjBQmWifeKGLpumMKx8j++EgQdLLiZEFM6p1jWn6wFi2+R559KZRm45k+rWAE4H7yUsC95HSd0NS1M+tZUnaR3L9LHjzQr/Vk5WAPOjMDmGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059021; c=relaxed/simple;
	bh=hvAgJcSH+4RAvZ3Ucy5pG5ATGVz8QuSjaV2esLpiHPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kixsBqx1aPcF3RTrFl05ufK1mWvCPjNYnBhEZGGD9Isum5Uh6Syd9uWCG+2ZdD5mCnxaXsVrT0KDbgAdMjZEx9OiM+RPCsjK4SX4M3kRJaT1JjWSIk9KLI/nIQuW/ehcf97Nukd992dkdqfH59dIiAqFalR2d8nxlsYeMra1MGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jtrVdeQ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AP9wNW99; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jtrVdeQ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AP9wNW99"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A3BCE7A0063;
	Mon,  2 Feb 2026 14:03:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 02 Feb 2026 14:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770059019; x=1770145419; bh=+/IY0VL6bD
	rLyMSs9W0LO17tTO9sPwUj0ROhj8jBdyk=; b=jtrVdeQ+BH8SWOfr9UxIVlNIp/
	gBK+yyb2fNRuyCzXROSfWZpPhl3oi2cdShupby/28yRTJk8O47rOCEM7SXugiSqf
	TGlLOOWJhqgLzb3XlbWIPDidISsB1FjeVdMNvtWamOnjk1Os4jPk02uMRZz4k9p9
	DjEFlPFkW5T+ZQ2YUCtw3FmsJTfe4bqWuJCizXEfaXKKIwTtzJrHzVij5qbjozjS
	QB3q0V6R275pGUxYj3eAgJwsV4ZwI1TA8ZTFkaCCxrRjEol+FQpf68Y2ERl5LLuh
	QiWC5rq0v0D3Hieu8Y0IFsmPmF3kQnQrywSuewulKZTh4d5f/1MYRTURrbTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770059019; x=1770145419; bh=+/IY0VL6bDrLyMSs9W0LO17tTO9sPwUj0RO
	hj8jBdyk=; b=AP9wNW99szULgY67Ic/FxaSktGttDqVUHkaB5qcRuA/wFbWmwMQ
	AzxZJXCmmMLjjNvQgBJ4ab7uToEJxWrLn3LHYk+sUyGOLgB475o9VkSbtuF7U2eR
	LXXmE/8NipszV9v+qxpw5VWvHPrwV9W52bYDBG4Yk5PtEwFe4jX41gAyA4u6q77q
	lyVXX9bKj4NrnS3iuqZxUFntlr88qy0C+k3kq6V3ixExcL50kAibn81TB5/DXHLP
	lZy/sUFlj1XlermPb9GDze1mLzxbX+0JVfY6Rf0g9krT059ogL/OG2e88ho2+T2Y
	zxg4dGTsIxuSgn/ikFfUjxueG21IWZRumsQ==
X-ME-Sender: <xms:C_WAaWf0emdwtKQlUXDptDPkX_O8MpmU39L9_vflvropN3i145he6g>
    <xme:C_WAaT7bUx-lhW817yFTCVTtq1ZMsy6UtyqsTMdwhBY7Xpte4sEWm8G0vkJNJxgzm
    qoh6-1p8tsg2cXiWkRmVKyk5rSuPWoZFfWN5xKNfrxYroS495qb1QI>
X-ME-Received: <xmr:C_WAaRVomdePIMeB_gRZZ5LQwG9G1HEtV8TnoAel-TqlPQ0xcEb1H9IIb3aMMcj5qFzpFUH12A-jZ4_c9wWpfguslOQ6__0HzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:C_WAaa6eHa3xB6jR1kgbm4na9voF2Y2wpT5f9EfIPZmqYlLgDwoVnA>
    <xmx:C_WAaUqzCuX8a0kZwRh0Ovendx2WAufIpn5Kav8kJho6gJBLceSKtw>
    <xmx:C_WAaVnxCiYBWIiJwSCrsU3cGputf4INLjAcgrogb1LwZjPb-kjgiw>
    <xmx:C_WAaYMvk8F3V9gpBZYTe5sGJAtRo6tLQh79WIvYIdau27CWQMnoqA>
    <xmx:C_WAafCXbznuIiDFjC3NaPI1T-c-x9HL91yvy8kJWlLgR8ABMXjZLxSl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:03:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] doc: shortlog: put back trailer paragraphs
In-Reply-To: <20260202182421.GA3421838@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 2 Feb 2026 13:24:21 -0500")
References: <shortlog_trailers.253@msgid.xyz>
	<20260202182421.GA3421838@coredump.intra.peff.net>
Date: Mon, 02 Feb 2026 11:03:37 -0800
Message-ID: <xmqq1pj3ynli.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Feb 02, 2026 at 06:59:42PM +0100, kristofferhaugsbakk@fastmail.com wrote:
>
>> 47beb37b (shortlog: match commit trailers with --group, 2020-09-27)
>> added the `trailer` bullet point with three paragraphs.[1] Later,
>> 3dc95e09 (shortlog: support arbitrary commit format `--group`s,
>> 2022-10-24) put the single-paragraph bullet point about `format` right
>> after the first paragraph about `trailer`. That meant that the second
>> and third paragraphs for `trailer` got moved to `format`.
>> 
>> Move the two paragraphs back to `trailer`. We now also need one blank
>> line before the final bullet point so that it does not get joined with
>> the second bullet point.
>
> Yeah, the change in 3dc95e09 was obviously wrong. The results look good
> here, via both doc-diff output and just eyeballing the generated .html
> file. Thanks for catching this.

Thanks, both.
