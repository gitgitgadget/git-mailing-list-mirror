Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B9191F84
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773610347; cv=none; b=btIZCyDye5oY8oVcO1h1UI5EnBrT7i9i+WZCU0pVh0sJPkGry3ai3Ac7X+Q8isx+j8+gX0SGl/FZdw/9g6eDTa/zC74WyJs/oGjJ0oDIptMYzI617n5hYKIcUIiWl3AFxkjpDkDwPHz6IqS5j7F/4sf09snVgPkYDtFfb2XpuEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773610347; c=relaxed/simple;
	bh=wWBvHDpAWD/+hsm82fVNCp2Pe1KV0IlQS0AnYRhvarI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PdcpiTd3cwWjP1u2FsGhOHxvBc18RhticAKJa0uPRUHrpZRk+6xt7CPdRK4u3sCtx79oalZtkgc7sGglXvTyFVR3OE9+YTcPupXQgKJgrDPK09hN17zpqi0X86p1aKRZ6bPfyY8GiFGkPNMsZFRy29eSFlMkl00AUXZTJRe6CSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Khv8Fdty; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0uX2SDQU; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Khv8Fdty";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0uX2SDQU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 18853EC0261;
	Sun, 15 Mar 2026 17:32:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 15 Mar 2026 17:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773610345;
	 x=1773696745; bh=3HydnbGIu/4mep/tIe0A13O24+cl5MUok3a/+Gd1s7Y=; b=
	Khv8Fdty6mV629oxOtkv+ceg8c4cLMezQaEkLM8r35DrXNlFuZpDGwIlXaFI+IXC
	+aMrWWHy9W5J1a0kVVIftrn1Y76tLAPdLV+JlrZ/BXEcbJBSyZI4UsLK9Ak+H/xG
	ABu/lPq4O1s92XqWsnK7t7ap0WBWkAHA/BrC9TwbYXMWBwAXO+rVGkiks+++//He
	Otlyw8vQvlgrPm108Hdd0OYHZ5+uvRslm59F+8/7bowPWzY2wtyijUH5BNaNggkU
	EZhb8mI/wYXdT56qO2KACVyUV/FbP4Ro4XgBbKpAqurdhkJ4cVI9MgOmqFPWNPma
	gE2O7uWZy2yYx8+WRchf9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773610345; x=
	1773696745; bh=3HydnbGIu/4mep/tIe0A13O24+cl5MUok3a/+Gd1s7Y=; b=0
	uX2SDQUkCn8phAkvl/VcB9A4W/QA66pp9ygzrXe2j3EwC2snSNYTlWtq/OQSCxAP
	jJdbUZqxwoBB8NBYisxserBYvPBoR41FMJmHs5+rOEdMQxFP86NC4drgNjJXhJs8
	R22anEknkLWwOA9BDiALEwJ5EoXLfBdZjOwrfaKHKD7jKNVg9X0JKRFtB/GT8JIW
	4K0iKOJxAv3SgJO8egRm5YUPHDom3AVVCT9mIHwfVMsmqUozm/k4jhXpMbx/l38j
	vsAtWtD7KjBZT/3Aq/JcXTfhFLxbRibfS41HuanpXLCdDBI7VXn29W6ToCbQA9mZ
	vC6xhPhG+9aJDMwW0Ya3g==
X-ME-Sender: <xms:aCW3aRQUUXKmB9M8vcY4OrJuRvXUy7HLPz_k0FCgyqNdiHAMz82BgQ>
    <xme:aCW3aXVry9aCGQ7gNGxc5TTaK2Udq8ehpNrCnsMlgMcNXTeiWyvVrp6i-9a3wyfwX
    NI1R785Oa012J1IOWmDYJiNtp0zYY2tqwpz96gYME2m8BeVnFLe>
X-ME-Received: <xmr:aCW3abQXqjARnjrkJnSB2myXHb-NRl0X2wdPxRI3RnesvvyVOiCt3qUHy3sP7cXlseLM35mTC-NjxWLz1jgPnr_SceMvavusxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleeiheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeevgfejveejffefueevfeehhedvhefhiefhgefhudeukeethedvudeggeef
    uedvjeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgtohhrphdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhooh
    hthhhprghsthgvrdhnvghtpdhrtghpthhtoheprghlrghnsegsrhgrihhthhifrghithgv
    rdguvghv
X-ME-Proxy: <xmx:aCW3af3QHKx8CyISJcxWqV9_ktvxcx71CWHPMTF86YRVvJpZM8h48g>
    <xmx:aCW3abchYpcq2hAbvOwbMSosxnsXIoHeCbHZCYh9mKWfgyiR6y4FlA>
    <xmx:aCW3aXM8yT4QI86wZBJizP3IVgCdAMqntwarhfunH9yLG4Gp8WhVEg>
    <xmx:aCW3afV3wo8BuBjk4570uNqwO0nWEAN3qpizuD4eOp8M145irvVbRg>
    <xmx:aSW3aSGnHoaTWgJVuLb1ZWYQvstSf-6u0o6nYiVejNE272hJiCYPcS3H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Mar 2026 17:32:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  christian.couder@gmail.com,
  jonathantanmy@google.com,  me@ttaylorr.com,  Jeff King <peff@peff.net>,
  "brian m. carlson" <sandals@crustytoothpaste.net>,  Alan Braithwaite
 <alan@braithwaite.dev>
Subject: Re: [PATCH v6] clone: add clone.<url>.defaultObjectFilter config
In-Reply-To: <pull.2058.v6.git.1773553022381.gitgitgadget@gmail.com> (Alan
	Braithwaite via GitGitGadget's message of "Sun, 15 Mar 2026 05:37:02
	+0000")
References: <pull.2058.v5.git.1772847236966.gitgitgadget@gmail.com>
	<pull.2058.v6.git.1773553022381.gitgitgadget@gmail.com>
Date: Sun, 15 Mar 2026 14:32:23 -0700
Message-ID: <xmqqldfsrd7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alan Braithwaite <alan@braithwaite.dev>
>
> Add a new configuration option that lets users specify a default
> partial clone filter, optionally scoped by URL pattern.  When
> cloning a repository whose URL matches a configured pattern,
> git-clone automatically applies the filter, equivalent to passing
> --filter on the command line.
>
>     [clone]
>         defaultObjectFilter = blob:limit=1m
>
>     [clone "https://github.com/"]
>         defaultObjectFilter = blob:limit=5m
>
>     [clone "https://internal.corp.com/large-project/"]
>         defaultObjectFilter = blob:none
>
> The bare clone.defaultObjectFilter applies to all clones.  The
> URL-qualified form clone.<url>.defaultObjectFilter restricts the
> setting to matching URLs.  URL matching uses the existing
> urlmatch_config_entry() infrastructure, following the same rules as
> http.<url>.* — a domain, namespace, or specific project can be
> matched, and the most specific match wins.
>
> The config only affects the initial clone.  Once the clone completes,
> the filter is recorded in remote.<name>.partialCloneFilter, so
> subsequent fetches inherit it automatically.  An explicit --filter
> on the command line takes precedence, and --no-filter defeats the
> configured default entirely.
>
> Signed-off-by: Alan Braithwaite <alan@braithwaite.dev>
> ---
>     fetch, clone: add fetch.blobSizeLimit config
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2058%2Fabraithwaite%2Falan%2Ffetch-blob-size-limit-v6
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2058/abraithwaite/alan/fetch-blob-size-limit-v6
> Pull-Request: https://github.com/gitgitgadget/git/pull/2058

I as a bistander reviewer would have appreciated some mention of
where some changes relative to the previous iteration came from.

E.g., check for !normalized_url case is from a realization that
url_normaize() can return NULL.  Use of test_when_finished all of
the place is to clean cruft after each test did its thing.

What I am most unsure about is what the removal of "large.bin" in a
test is about.  What was it trying to achieve by having the file
that weighs 100kB, and what was the reason the file got removed (is
it because whatever the presence of the file was trying to verify in
the previous iteration is already checked by other means and if so
what is it?  Or is it something else?).

Mechanically generated range-diff alone does not answer questions
like the above.

Other than the "dd" thing, everything is looking good.

Will replace.  Thanks.
