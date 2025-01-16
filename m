Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA7199931
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022306; cv=none; b=Wx+oVqNw4qsP64/gb8yP4rRufv40bkIm2EZb9Q1uyS3n/Q+eaVPQwl3Nk2hVS7myTBoWKn4Bdf+tdI2mzyWuBQcXmd3csYxNzRuheP14Gv4y5pmLUrYiLQzSNQRkpPpg84OjoNJ424izbPBr4PY4rEsGlg4a8VmcdmHpIaZC784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022306; c=relaxed/simple;
	bh=laogbrD0okU/IOlDdLB14Kx+P5/s0b8jz/KTxI94VQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFEJGJry9NqzscE8bY4BIEUS2fUPycjgVH5mYuawFuXq3QdOtT+UuLNCkWhhj4a4mj7HhtltRpgZjurnVjArc9mhD85JuVvhFQkppBRMqfEyoiOhNQtfqHz9OZ+DYT4UQzvvOhvQ7zyl/cFvm98ssUwQXKJtCE82aGy3isGAQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UzFG9aCS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FG/2DG7j; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UzFG9aCS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FG/2DG7j"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 02B6725400FB;
	Thu, 16 Jan 2025 05:11:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jan 2025 05:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737022303; x=1737108703; bh=laogbrD0ok
	U/IOlDdLB14Kx+P5/s0b8jz/KTxI94VQI=; b=UzFG9aCSqk8w+Ei+XVZ+CXASTQ
	gJqT5lGHQcChCXNY57ndUWyBe71q31RERmk6l4nqus0vd2x2sHDlDR+uSjE/uNcc
	7uBk7nRclUBMiT1lYcElObdjzHgaXqjs/IIim571cIJ42bkZXTdBitbEJbgWBhkD
	wQBgb6qBmiM1F+NtgMB55K24jWoOMEWdKFJ5QbfJPlLhxOaD1tLxymXL/CLNMhfJ
	MMPOxXfBHUAInpzdxPkwodQ2LXKnSGsiCYVjxLpG/axyndI+c10+vMi0i3t5Br6Q
	44mCe+EFv5bz7iixvxfNaNUvWzyxPpi8OprN19avqB8lwUPJzRgnfmclXV2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737022303; x=1737108703; bh=laogbrD0okU/IOlDdLB14Kx+P5/s0b8jz/K
	TxI94VQI=; b=FG/2DG7jUP/nx2sgeJo6LIdz0qOWUBRIX7yskJcNydwOWrkJdWx
	lFSzvuTBaWqjAnE1v+JTxpQ9TInbEUYnd/tF+YkT8JN8WkI0lv5035SzuAPlJpmK
	uahY+Ynb+SeCm2bspC4qt2rEl8IfjK8XAy/ptikmpb/a4OBNpGsu2AZxw6yaDY06
	32gyhLJb1Pde1nynZj9Dx8L7LTwjS0Bu27B5sFjTKdfBLdEXuD8wD1mJt7J0t92b
	jNlmhGSi1eEisrBveV2Y5OlFyGBGOgHOJfKnKWBBOXxsRHYJZcU8bn4E0I2U1Mev
	iLcZr+UzhNpxERyGIDVYQxxVjrOOPXp5WEA==
X-ME-Sender: <xms:X9uIZzBZDXbYlcogrK1NbuwtoZpQfEFApvUU8Z_yp1Jm3wnhIuLB7A>
    <xme:X9uIZ5g1BmI956sn-_x3FYTXBd__Xi0em_TNTl3HVNGEhHeH3T7ISwcLAXKfmz8sB
    wEBjz8GMdWDzOCt8w>
X-ME-Received: <xmr:X9uIZ-m5S4DrkasSflNtrGDJzG4-XMzyrKADwAoq7fKjuitPp4k5txTlVFQjAblNCz4xh-s6aOpFLt7k7iN2tMM_mB0egktpusLqYuUo7XpMN5Nntg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekieesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrthhh
    rghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggvrhhrihgtkhhsth
    holhgvvgesghhithhhuhgsrdgtohhm
X-ME-Proxy: <xmx:X9uIZ1zq9F5bexlxKTS54yJws4ngxyZdbR12uTwCPIL9FmzwTAUA_w>
    <xmx:X9uIZ4Q16onRQAfJmWqLydLmH3tlb3gQ6LbKsW2-g78OjH6bgwpNXA>
    <xmx:X9uIZ4b9Y3P-BcxYH616X__0quGRATI7E24JksCE5PFQgjjBCOlNmA>
    <xmx:X9uIZ5TnflUolRKf615pCK3LLqbc1tp7b_BZaf3orQ2TwlaNvEuyrQ>
    <xmx:X9uIZ0rPFPDgtbJ6_O0ZoUcni7N5FWHtS2XyJxWJcNb1J5hbe9G9PfFH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 05:11:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d842dcdb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 10:11:40 +0000 (UTC)
Date: Thu, 16 Jan 2025 11:11:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	karthik.188@gmail.com, Derrick Stolee <stolee@gmail.com>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/5] backfill: add builtin boilerplate
Message-ID: <Z4jbW7UtaC7hQU1Z@pks.im>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
 <0300aa1b8c37dcd0d529cc24588ae77960fdfbff.1733515638.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0300aa1b8c37dcd0d529cc24588ae77960fdfbff.1733515638.git.gitgitgadget@gmail.com>

On Fri, Dec 06, 2024 at 08:07:14PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
> new file mode 100644
> index 00000000000..640144187d3
> --- /dev/null
> +++ b/Documentation/git-backfill.txt
> @@ -0,0 +1,23 @@
> +git-backfill(1)
> +===============
> +
> +NAME
> +----
> +git-backfill - Download missing objects in a partial clone
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git backfill' [<options>]

Ah, one thing I forgot about: this could use the new `[synopsis]` style,
which removes some need for formatting directives.

Patrick
