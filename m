Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E743126DF
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772148081; cv=none; b=u82iidr3NpSiJHDXW8ecK05zeFdYfJnefOpOyZTSXT0NH9aY5g4U4MhW7p5lqapSOEJsdji8GpdjJ2jLeTh8NjAQW3L9bjYeR7+bMZc3kWyo2lBA5ghGAKwraqDy/F1j8aT+V1QDFq6QP3/h1bUeatgkqx+XcpLkWwR3m70vXcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772148081; c=relaxed/simple;
	bh=wiAwJyGmzbeCo7ijM/bKG+RH4d+S6x7hRrac1+9kNS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tEzl6d48Kt3AtreWyUBhJ9YcdA8c0uESckMjTQn2XpEE9Tk8JXq7Ssni8gENZ/lXRpe25C9m79c0LknFRtw8B0LS4g4UbCXs8M7fvA8LJ+L4c9Ehi50R/UhkL75W+fxER1XDKNlNnpIChXIwZs3e6loys9zgm6zBqSX6sBefWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mk5ZuhE/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=miXUEeSN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mk5ZuhE/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="miXUEeSN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id F38791D00128;
	Thu, 26 Feb 2026 18:21:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 26 Feb 2026 18:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772148078; x=1772234478; bh=9mHZ0SRQMm
	TGl5IAEFMoWNw31A20laChCcxlEz0qf1U=; b=Mk5ZuhE/W9LyzW8dL9u/wLRqud
	6L7mWkB2RSC5DWsj9u+Rhno7I8CD6keLI9BTqvsvuBkju+lKsJ8yWbc2f4h930nD
	nhgmfZ5qDkxRcUWQp+G/y4OOTj3rx1KHaQzqu8xReJWxOXUOE/Is5JWF0hD8VLpk
	tRPWm1MCQTcSRzSrEZCYdBLokUkx//1yKq2xVrHipQoN4UJOANy9oZOaEBh8ZoAy
	ZfeizhwZA7RpddQGVg1JGx4IHpurC7I8Wl44o7ldzL7gtrY3r7z1SrFRq8IQalw5
	cja9hNpunTOBbIgXRYIwmNgOERkXH5LsMLlxZhqkVI3y4Ztu/8CAzcpGf82w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772148078; x=1772234478; bh=9mHZ0SRQMmTGl5IAEFMoWNw31A20laChCcx
	lEz0qf1U=; b=miXUEeSNwCE00vuu3e2Q7nMCF0izEytGVbrclW9LInmkJHziClr
	DvfuNTvF/+Hbwj4SkGrauMVNQ3hRn8EiifttqFJ1svdH0KXgSsZhQRI5XXu/8jaP
	ViMbRqNSa1F5vGL0WTI5S1KQRxBSGN3Ss6blJLncQbAc4GQWNQYdnjskPbQvAYtz
	Tp5FdD/O7KlZKfWXXOSpc9bqflO3ycm4xvmovx+xvswiF03UgQDIq+0uWwGnJnQW
	oC/2yc+gePrKDpZKLuqyCeAYlhI3cBPn6TUg65mxLOBhOskqjmN9I03C81llJJk2
	aK+KVp+4z8Iet0PI9bZ+GaIVQV2kCBZdsFg==
X-ME-Sender: <xms:btWgadJ7f58SLZMQhvp3e-I69FzcA4pg9xm3qpkmr0sB8H0LOXMrMQ>
    <xme:btWgaQIlTRd6L7IebJDmBsgB5Ml4xFzXa6inEYh8ArhJDL9zbg-zUeGze5l0J3F_3
    rGCC4Tv9mY_eZWM_sgiU9n4nDw-gxEAU7CXqy3iomq4PnfdilGr-g>
X-ME-Received: <xmr:btWgaaub2oJjIvOytns3kpvS-MNka4GAGxVxB2Utaa-2sAhio9DSNK3RDvTJRDT4tRb2WSD23fdA1_gGOSDyFXlmmiEgSSGg0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvshhlrghmrdhrvggurgdrughivhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:btWgadT3s8Nj1Z21OFr500wo8KmPYIND5pvcX3-VPZWHAbhfF1Dr1w>
    <xmx:btWgaQMz-gDuFEu8SQsVlK186C2kJ2Hx4rv7CIIkcPOWcEmUxYF0ow>
    <xmx:btWgaSa4tiO7WRzpu-Usk9cfS7YTY0XBeRT071uZA57r2ouQ0D86ew>
    <xmx:btWgaayfMZ0O_RYhkuVCeflCS9eUpJhkAwxk3W4cmBxLTcgdAKOW9g>
    <xmx:btWgaaPl6aEsUaWVFLEzmwi10oRTEH0Qux9sh-xaCtbu3ZW1Df8J6p0Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 18:21:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  eslam reda <eslam.reda.div@gmail.com>
Subject: Re: [PATCH v4 01/10] repo: teach info context and category keys
In-Reply-To: <99c8058298d403508ab2a23ed06c36b8707989d0.1772140487.git.gitgitgadget@gmail.com>
	(Eslam reda ragheb via GitGitGadget's message of "Thu, 26 Feb 2026
	21:14:38 +0000")
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
	<pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<99c8058298d403508ab2a23ed06c36b8707989d0.1772140487.git.gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 15:21:17 -0800
Message-ID: <xmqqikbjum4y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Eslam reda ragheb <eslam.reda.div@gmail.com>
>
> Introduce an explicit repo_info context for the repo info codepath
> and thread it through value lookups and field printing.
>
> This removes direct coupling from these helpers to ad-hoc
> repository globals and makes key retrieval logic easier to extend
> safely.

The above makes it sound as if you are improving existing code where
existing helper functions are already making ad-hoc and unsafe
access to global variables, but I somehow doubt that is what is
happening here.

What does "these helpers" exactly refer to in this sentence?  The
ones you will introduce in patch 02/10?

    Currently helper functions of get_value_fn type receives the
    output buffer and repository instance as parameters, but we are
    about to teach "repo info" to retrieve information that requires
    to know more than just the repository (e.g., the prefix given
    when the command was invoked).  Introduce a new "repo_info"
    structure and update get_value_fn to take it as a parameter.

or something?

> Also teach git repo info to accept category names (for example,
> layout) and expand them to matching key.* entries in request
> order.

That smells like an unrelated change.  Wouldn't it better to do so
in a subsequent patch, so that each step will concentrate on doing
one thing and one thing well?
