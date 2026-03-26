Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F343F3F7E8E
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527704; cv=none; b=NgnL7nCi3ZcAr19zIVe/8+e434r0hueOdooYoNai/1wvUgzy74i1WEYfnXgKvbYoDXMYyggsLV6AOnQJ9zZkK7LvJ2WhYyW/U/08G67E+Cvo8Q5VQGhUD+z8s5oEJ+Xemx8XMovS9LmBMsG2qNHbwQLRhDcGjZtqMGU2i8gF60c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527704; c=relaxed/simple;
	bh=DJ6/QXBlp1SLZ1NzDHhbrgMI8FtbPlThGuhfmRNMpa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BC4MjG+TK9pUVof1WWFcd+C8LZD9H/USwPsg6BjiXOCMcp5nOucHAsxI7LozrIbQLWcQ2RONStzktsJ5Oyqx7DEbDOQxu2bckIWf6o5TC05uAD7VCrPc4VHNuLk9fNUbOud3qhX6v65/2rPY8pByfoamUJep4hlRoM2BturY7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j6mCn8A8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HOSGuiw9; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j6mCn8A8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HOSGuiw9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5371C7A0040;
	Thu, 26 Mar 2026 08:21:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 26 Mar 2026 08:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774527702; x=1774614102; bh=Q+c+MOdtIE
	pNKIPKkQEL90mJiazJYk1hx78pS8KqG7I=; b=j6mCn8A8BnZ7fcDMvqhG5CmRgU
	4d1JuK8nQD3NZPRKN7rvrN3wrPcasv3mocdW9TJeYU5LHymdIIDgQZXadlyK9rMq
	F49GamrpaUzMBMMg7FzdrAg+4HBXT01KbZ+AtZugXf9t6FYcsWC/g9yzICal1O5L
	lurI6f/IOWTvlwxl6hoJ6OBYgKYiqIN9HmUCBUIVoZnkKJmqU5EgYsJ/B0bQKvwo
	CtVEh0CpTsLz4F8J5BlAbfwQ8Riil+KlD7cTQoW9Hgdew1iu/a3EvTLR0l4W32rz
	F4Rx5ffkh73prW25QU/K418kYqg2EYUp1QDeK8WK3Nw3AMowby8IsrH8vckw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774527702; x=1774614102; bh=Q+c+MOdtIEpNKIPKkQEL90mJiazJYk1hx78
	pS8KqG7I=; b=HOSGuiw98tWqj1s68DffYWYBVjXSiinzUmNJRAMYWP7/Oid08+2
	120cibqXrWkq3HA3M0VSfXC3MAw9AODKmwyFzTXYT7z6olS81uXiulq6EFfx5ODC
	ckV9vqRj2RHsVzHrDm95fesoxi9us1EpDC/B8Dge8ZnX5Zq73M/i7LhwNeienn5L
	O3dLL9vGY/9N71KXuiBKsKmQzHJYDoDkcHW55zGrndSKzkAcLQIwSYtcqlHecJoh
	yvaXsSf84S5EqEOBNzR/HzTYSBtUkI6SONyooj8L2bT7rMIE6h3A7iHOq6FJqfhe
	bGDGoT9VUqe/OVwle4mjCpMSmdGLdKCZCjQ==
X-ME-Sender: <xms:1iTFadXjCHUHE8GltoK_4FYu7JCu5qrpWElm9S2FXAL-XCORTiTzkw>
    <xme:1iTFaf1jpI7Li1b3P-A19g2lEfDqEfOcxqCt66PWvBFF_68sCAmQD4QyWPOq-BJ9i
    pDeEFUapt-fjF6BaWZ2ofzuDV8HBFZxiA9BMU2MVkRjxPXddn5pPA>
X-ME-Received: <xmr:1iTFabq8U-xF3gaOIMiH4jSUYVkprctrbDHzsVxxjfU3g1mdExG9U_KYhINNqFqF6ggnmiXgsbz2WWhzbTcZeq5dXz4wyzYlEykb73eGM2Vnxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epledukeeggfeuveektdduhfeigeefueettdekueegleefgedvjeetteevgfduudeunecu
    ffhomhgrihhnpehgihhtlhgrsgdrtghomhdpvgigrghmphhlvgdrtghomhdpvghvihhlqd
    hhrggtkhgvrhdrnhgvthdphhgrtghkvghrrdhnvghtnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpth
    htohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehn
    vgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtoh
    huuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:1iTFaWXlXbGYLmi0ixegoE2Jx9ZjW5EPnfSVd34N5rU1yg-BFnkenA>
    <xmx:1iTFaWY-5DfrX3fl7ru8TfbPiuymmnMuHwZfdun5w_yoVCmAu45OGA>
    <xmx:1iTFaTeVkyh5TAd55clsNQQ3_YDjGmk7GAaaM0TlShzV-yY67uJKjA>
    <xmx:1iTFaQ1OdJNY_XNVAOQFVV_nrAEY0UpcZ588HoawotZvcz5ikjfTVQ>
    <xmx:1iTFaamgwrQyhKiOJ4YaI_ovzEiSoEY_cwKyZ501mYp6j_i3h81BVUA6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 08:21:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id efe08dd0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 12:21:40 +0000 (UTC)
Date: Thu, 26 Mar 2026 13:21:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 14/16] promisor-remote: trust known remotes matching
 acceptFromServerUrl
Message-ID: <acUk0vTuj8COlvgf@pks.im>
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-15-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323080520.887550-15-christian.couder@gmail.com>

On Mon, Mar 23, 2026 at 09:05:17AM +0100, Christian Couder wrote:
> A previous commit introduced the `promisor.acceptFromServerUrl` config
> variable along with the machinery to parse and validate the URL glob
> patterns and optional remote name prefixes it contains. However, these
> URL patterns are not yet tied into the client's acceptance logic.
> 
> When a promisor remote is already configured locally, its fields (like
> authentication tokens) may occasionally need to be refreshed by the
> server. If `promisor.acceptFromServer` is set to the secure default
> ("None"), these updates are rejected, potentially causing future
> fetches to fail.

This only talks about already-configured remotes, and so I was naturally
wondering what about not-yet-configured remotes. But looking ahead a bit
shows that this is implemented in the next commit. Good.

> To enable such targeted updates for trusted URLs, let's use the URL
> patterns from `promisor.acceptFromServerUrl` as an additional URL
> based whitelist.
> 
> Concretely, let's check the advertised URLs against the URL glob
> patterns by introducing a new small helper function called
> url_matches_accept_list(), which iterates over the glob patterns and
> returns the first matching allowed_url entry (or NULL).
> 
> (Before matching, the advertised URL is passed through url_normalize()
> so that case variations in the scheme/host, percent-encoding tricks,
> and ".." path segments cannot bypass the whitelist.)
> 
> Let's then use this helper at the tail of should_accept_remote() so
> that, when `accept == ACCEPT_NONE`, a known remote whose URL matches
> the whitelist is still accepted.
> 
> To prepare for this new logic, let's also:
> 
>  - Add an 'accept_urls' parameter to should_accept_remote().
> 
>  - Replace the BUG() guard in the ACCEPT_KNOWN_URL case with an
>    explicit 'if (accept == ACCEPT_KNOWN_URL) return' and a new
>    BUG() guard in the ACCEPT_NONE case, so url_matches_accept_list()
>    is only called in the ACCEPT_NONE case.
> 
>  - Call accept_from_server_url() from filter_promisor_remote()
>    and relax its early return so that the function is entered when
>    `accept_urls` has entries even if `accept == ACCEPT_NONE`.
> 
> Let's then properly document `promisor.acceptFromServerUrl` in
> "promisor.adoc" as an additive security whitelist for known remotes,
> including the URL normalization behavior, and let's mention it in
> "gitprotocol-v2.adoc".

I feel like the description is steering a bit too strongly into the
direction of a step-by-step instruction of how to implement the change
rather than explaining what's done and why it's done this way.

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/config/promisor.adoc    | 46 +++++++++++++++++
>  Documentation/gitprotocol-v2.adoc     |  9 ++--
>  promisor-remote.c                     | 50 +++++++++++++++---
>  t/t5710-promisor-remote-capability.sh | 73 +++++++++++++++++++++++++++
>  4 files changed, 166 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
> index b0fa43b839..6f5442cd65 100644
> --- a/Documentation/config/promisor.adoc
> +++ b/Documentation/config/promisor.adoc
> @@ -51,6 +51,52 @@ promisor.acceptFromServer::
>  	to "fetch" and "clone" requests from the client. Name and URL
>  	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
>  
> +promisor.acceptFromServerUrl::
> +	A glob pattern to specify which URLs advertised by a server
> +	are considered trusted by the client. This option acts as an
> +	additive security whitelist that works in conjunction with
> +	`promisor.acceptFromServer`.
> ++
> +This option can appear multiple times in config files. An advertised
> +URL will be accepted if it matches _ANY_ glob pattern specified by
> +this option in _ANY_ config file read by Git.
> ++
> +Be _VERY_ careful with these glob patterns, as it can be a big
> +security hole to allow any advertised remote to be auto-configured!
> +To minimize security risks, follow these guidelines:
> ++
> +1. Start with a secure protocol scheme, like `https://` or `ssh://`.
> ++
> +2. Only allow domain names or paths where you control and trust _ALL_
> +   the content. Be especially careful with shared hosting platforms
> +   like `github.com` or `gitlab.com`. A broad pattern like
> +   `https://gitlab.com/*` is dangerous because it trusts every
> +   repository on the entire platform. Always restrict such patterns to
> +   your specific organization or namespace (e.g.,
> +   `https://gitlab.com/your-org/*`).
> ++
> +3. Don't use globs (`*`) in the domain name. For example
> +   `https://cdn.example.com/*` is much safer than
> +   `https://*.example.com/*`, because the latter matches
> +   `https://evil-hacker.net/fake.example.com/repo`.
> ++
> +4. Make sure to have a `/` at the end of the domain name (or the end
> +   of specific directories). For example `https://cdn.example.com/*`
> +   is much safer than `https://cdn.example.com*`, because the latter
> +   matches `https://cdn.example.com.hacker.net/repo`.
> ++
> +Before matching, the advertised URL is normalized: the scheme and
> +host are lowercased, percent-encoded characters are decoded where
> +possible, and path segments like `..` are resolved.  Glob patterns
> +are matched against this normalized URL as-is, so patterns should
> +be written in normalized form (e.g., lowercase scheme and host).
> ++
> +Even if `promisor.acceptFromServer` is set to `None` (the default),
> +Git will still accept field updates (like tokens) for known remotes,
> +provided their URLs match a pattern in
> +`promisor.acceptFromServerUrl`. See linkgit:gitprotocol-v2[5] for
> +details on the protocol.

Given that there's a bunch to process here, would it make sense to give
users an example for how to do it properly?

I also wonder why we require a new config entry instead of extending
`promisor.acceptFromRemote` to have for example a new "url:https://..."
setting. Are there cases where you would ever want to use the new
URL-based schema with a different setting than "all"?

I guess the case with "none" is exactly that, where you may auto-update
configured remotes. But I wonder whether it would be more sensible to
split out behaviour of accepting and updating promisors into separate
configuration variables. These are ultimately different concerns, and
the interaction as layed out in this commit is somewhat non-obvious to
me.

Patrick
