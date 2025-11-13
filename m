Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8479C1ACDFD
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055292; cv=none; b=EWo2sX/sf2Zgq4nVDDFY2mTTPvSxbAW05Zvg9seky+GZHkFLjkioWmEGXqFg6iNbpkFCx6GnIT7/riHsa8kovTQS7859ah0EfRniOkFlGUeiJU9uuNu3jMhKPNKCGgdBmWOFvyUimW2w4+hUeoJfWABgZRKMftnj19ryWoiyidw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055292; c=relaxed/simple;
	bh=o1+9S4eQeA7OGfmNz1Gs9/IWG47xO7U7gNGZCnEaa0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H2jXZBauPragdF8+50Dc/atN0fIMBh9I0yOaFGciM8OvQZy/tSss+fFOc1iNWH7J9dmdu1fN73QwjUNyYrvhXyY5RRCXyqNOyWs4xlouLo7UcWMr1XgNMQZnt56NC2zhuFJiY4clTs5fnf8vy2K35s/+A7riKVpUSbTWdHrN1G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cmbqjg0Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S8r/aqUp; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cmbqjg0Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S8r/aqUp"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 7ECD71D0014F;
	Thu, 13 Nov 2025 12:34:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 13 Nov 2025 12:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763055289; x=1763141689; bh=8xeUq5c4OJ
	M9Um3G5pgWqvFk0LD0nQzvKcsp1BnZ+To=; b=Cmbqjg0Ygd3CP7d8IIWzDwYPQk
	GQHws4KJd6E/o9oDr8cXHFnRI3r+w7j27OWG6ObsSS5CQgRph3wq5Xxf/wQdH4v9
	XeBqNxQKY4ISsHZPXqYBnIZNabv3Fiz/EPv/gS4VWI4XOqVKz1OxVg1HBg3K+X2/
	Rb0ppWi2iD6+7C8lS99i1gRzkHVz/tfCicrPsFoOjWw4WItaLumO4AChcZ8WidcM
	NtXqSKQth1GapvP2phClnAzqQ98FxcLU0i3hgupgjSCSSjGUS6CrGFX2GsCasVJA
	Q0CuLwPT1BIdmn/bZyqqqOVoJru3eZB9MbhSokmVAftESKej0tLw0WUJ5nYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763055289; x=1763141689; bh=8xeUq5c4OJM9Um3G5pgWqvFk0LD0nQzvKcs
	p1BnZ+To=; b=S8r/aqUpFsm/tfKso7RrbZ/KbqM1R9tl2Am1QL6XYzQ/iLuYxYu
	Vi31Ton/uMHHxX8jrC6B24oy3Kg6yUz76ctO/wNBId0cFqEfxINIWildOQc/vUvy
	RHycKfVJ2vHzlb0PBxJE8eRjD2Ol61mIqXgbaKZbVGppc95z2jVgBFan6Woba6ug
	FTdPSVQIH50IS02YaPqvZwQsdepjAqfKcb2dRqTmyblr3n8GSWDd2gmQAmgrjt+f
	1MB8YdfsnBOmjFiePseyhljrqARIM8KUkkVbLQrtYuq5WqmZOyaAhrgXavVyjk/j
	4yotT1k0zLdPhxFSYOSFrEVhm2BA4VwGfPQ==
X-ME-Sender: <xms:uRYWaVy2NLNszkjkFN_h2tlbDxCYtQXulzSNB8Nn-jBYVzYPV6uOBA>
    <xme:uRYWactE6j_7NSOydSmFtdNUIVss9Li9dxnxzKDu9s9wCWEOCJMULEF4Qc9Zexi7g
    KEb_fpu5IhZnnc603UlPxYudIn8i87oBNKSkt87g4NYYMuQrptw>
X-ME-Received: <xmr:uRYWacu0L1royTHexYs0aVnpbhr9PY_9nki1CwP5ajOyNgUuNTN18SBFGoARDYBGPxP7DEKFBhdVjG1l6CRRwI4pLVvRY73tmlmv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uRYWaRPgrOA7aa8kMMfRVRXBCw6CXdQAN4Mci4A5LJF2rev7Cuocsg>
    <xmx:uRYWaa310XB1LsPoJ07Bj7tWwhf6mDC1BVQoGGl4RlyjcMQhkYK41Q>
    <xmx:uRYWadOJLDiePKgIcQdGDxDEKCOxdK3rzgYamrAtvQH5upeuO_aYgw>
    <xmx:uRYWaa1KIWXXeKYXwwb7tzesNpd43vV889sWUmXWJQne-7VhyGFyqw>
    <xmx:uRYWaca6LS2DhgQi_K2iz2VKoD-FNi6Bw8vZ0TF5T0SHvn3ZkrHMk7F2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 12:34:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] RelNotes: fix typo in release notes for 2.52.0
In-Reply-To: <495bed768c06a952294cfdb0ea28a0d346677b8d.1763053325.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 13 Nov 2025 12:02:26 -0500")
References: <495bed768c06a952294cfdb0ea28a0d346677b8d.1763053325.git.me@ttaylorr.com>
Date: Thu, 13 Nov 2025 09:34:47 -0800
Message-ID: <xmqqbjl5q1jc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Introduced via aea86cf00f (The nineteenth batch, 2025-10-14).
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> Noticed while reading through the release notes to prepare GitHub's
> coverage of the v2.52.0 release.

Thanks.

>
>  Documentation/RelNotes/2.52.0.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/RelNotes/2.52.0.adoc b/Documentation/RelNotes/2.52.0.adoc
> index 45e7f0a244..4df3d5a8a0 100644
> --- a/Documentation/RelNotes/2.52.0.adoc
> +++ b/Documentation/RelNotes/2.52.0.adoc
> @@ -53,7 +53,7 @@ UI, Workflows & Features
>
>   * Configuration variables that take a pathname as a value
>     (e.g. blame.ignorerevsfile) can be marked as optional by prefixing
> -   ":(optoinal)" before its value.
> +   ":(optional)" before its value.
>
>   * Show 'P'ipe command in "git add -p".
>
> --
> 2.52.0.rc2
