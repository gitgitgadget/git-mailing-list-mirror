Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324D33CEB6
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764847409; cv=none; b=kxaUNmEEcFXQjzTnvXLBQemskQOtex0DhEWyxGwOBb9LHNjJi/PbGGylfJqac1V8D1uxVG/jbpRzJ2GdA0bgbRLLBkQzJpj15iYuhLlDkEcVrzpatFsa1hDSYa4zflUaZMZyDKYB4BvgopyVX9MNvixUBbT5v4iTJVBnOkI6vs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764847409; c=relaxed/simple;
	bh=9GmqNwPRfalQy5fTER/3UKBXCOQGE6l73gRhGP3XVPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjPt1vZLTUNfj5/Add6JOnMwUiloM1B5LtOzw8z3h2O4HpRDT7sDVZq3D56wfuI8in/C20BVGG5RCoSB2nLUqFwng1EG6qDYywS2eG1/MIjLM+hw0vTjeo+gG0xXtF3Vsij1iyf6RLx2/LfVJ+4z5kfFJF+Lar2rVsVvZOnmOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pxZUU8Vx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HOhh+YQt; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pxZUU8Vx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HOhh+YQt"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BC52EC05B2;
	Thu,  4 Dec 2025 06:23:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 04 Dec 2025 06:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764847406; x=1764933806; bh=P7NgTJP3GA
	KE3iFlhkA6677NB7r0EuYpJPB81skQdFo=; b=pxZUU8VxNBYsh2YIh+VqV9vyuo
	WVaheKAISce/BGcdP/D727sn/X2PHYvkb6jl1dj76k0hPuk0/iw+hL7/YgO83kz3
	nOoE4wKZzZoD/7K9ezMqKGD6pTcc94hivj64suJEhbfqtxl79C70WeQkGS6VyzDy
	cQmo5+h7O77PCtCVG2xKPrT0VhImGGL+pY8z9DeP0jJn2aSdnMgqyUe1gS5gD6ee
	fqCZTqWHjvxwfqVytmZUwso2t5T8tSjm9hEDpTGfoz3geb+68OzoJrGU/5TX75d2
	mYp33MatGfPtJ1xdT7Whd6aajs1gGFzeicMWIMZxGEP+NvmogYKegVgP1TYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764847406; x=1764933806; bh=P7NgTJP3GAKE3iFlhkA6677NB7r0EuYpJPB
	81skQdFo=; b=HOhh+YQtOGDJfndLyVCxoghpk06dEmbsNtV7wqkJgL0cbfAOTGg
	8+pDVNJBbECMLEtJ/u2VZ7NlXpfnhMTlKZu9VQgjhcYj1T4d41l0TUtp6McF3vaL
	aY/R5F0zEEAdsuqwKqWHFZ21RKCp67+d5yF20uwEw6jTvIU+9IoymcJzkGUnuA5N
	T0dCA9ySREQX2iUxcmuefcOa0gYQITA1OtLQcst+UV0i5349Fv8D75HueZcmEwqe
	UEPZa08rltL65q5CtMxl0jp5IuEB4JiI+MespdqJdCR8HvgWBWykC+A1Lg19OyX2
	EL0JrzmuV0OX+ebpBc6gBdL8a0NK+mHjEJg==
X-ME-Sender: <xms:LW8xaXt8Yo9mM_n7dTwreu16AESR_8FnBNO_7bLgFjDF3HUkB-3gLg>
    <xme:LW8xacLDmuvo38CdIdJ80CBjgmEgfZ1xtLMpP3d_qsV8vik6WvFTCVssXP8lgyoJG
    XwnQUgoACpHTz5Pe2X3pqZE_SgNpMaK3pDPvZeFsLIRAUFOh1gmQg>
X-ME-Received: <xmr:LW8xaUkAYVjusxPy4UZR9GaX5lq5nJZmP2ajUA4k19Vw2y0SMyo4g-kEFTAI6Whx0IKV9kt2jRhIj3x7BedeA54nFKFR10JabVKM60lVIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehgeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegtmhhlihhsthhssehsvghnthdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomh
X-ME-Proxy: <xmx:LW8xadIkyDwNm8M3ZanAUM7pRiw-vb6388_ITX8DGQmvayR73i1U1w>
    <xmx:LW8xaZ4oWiZLph2CF7icjfUlza8nEr_-8lqblY6Qo2HhRqOtZu0mPg>
    <xmx:LW8xaR1euVl-WJVQAmkeYFBQEOv7CEJsAte9scDkwUhdGAiJVAQSzg>
    <xmx:LW8xafeWP7UIBncLECdZHj9Vfzx54rg_BrfG12jSXJPkixHzamzRGA>
    <xmx:Lm8xaYKOEvA0qvnP_PPuEGvtiow_V5w9nAkMfyCFeswLKSD5Yp0GQH-P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Dec 2025 06:23:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6556c2ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Dec 2025 11:23:23 +0000 (UTC)
Date: Thu, 4 Dec 2025 12:23:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	correctmost <cmlists@sent.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/4] parse: add functions for parsing from non-string
 buffers
Message-ID: <aTFvKOHlm4zfT9dU@pks.im>
References: <20251130131351.GA198697@coredump.intra.peff.net>
 <20251130131537.GB199335@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130131537.GB199335@coredump.intra.peff.net>

On Sun, Nov 30, 2025 at 08:15:37AM -0500, Jeff King wrote:
[snip]
> For the interface:
> 
>   - What do we call it? We have git_parse_int() and friends, which aim
>     to make parsing less error-prone. And in some ways, these are just
>     buffer (rather than string) versions of those functions. But not
>     entirely. Those functions are aimed at parsing a single user-facing
>     value. So they accept a unit prefix (e.g., "10k"), which we won't
>     always want. And they insist that the whole string is consumed
>     (rather than passing back an "end" pointer).
> 
>     We also have strtol_i() and strtoul_ui() wrappers, which try to make
>     error handling simpler (especially around overflow), but mostly
>     behave like their libc counterparts. These also don't pass out an
>     end pointer, though.
> 
>     So I started a new namespace, "parse_<type>_from_buf".

I think it would be nice if we could eventually converge towards a
common namespace here. E.g. `strotol_i()` would then become
`parse_<type>()`, without the `_from_buf()` suffix. That would make it a
bit more discoverable.

Similarly, `git_parse_int()` could become `parse_<type>_with_units()`
eventually.

That certainly doesn't have to be part of this series though.

>   - Like those other functions above, we use an out-parameter to store
>     the result, which lets us return an error code directly. This avoids
>     the complicated errno dance for detecting overflow that you get with
>     strtol().
> 
>     What should the error code look like? git_parse_int() uses a bool
>     for success/failure. But strtol_ui() uses the syscall-like "0 is
>     success, -1 is error" convention.
> 
>     I went with the bool approach here. Since the names are closest to
>     those functions, I thought it would cause the least confusion.

I think that's a sensible choice.

> diff --git a/Makefile b/Makefile
> index 237b56fc9d..751bd40a9f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1510,6 +1510,7 @@ CLAR_TEST_SUITES += u-mem-pool
>  CLAR_TEST_SUITES += u-oid-array
>  CLAR_TEST_SUITES += u-oidmap
>  CLAR_TEST_SUITES += u-oidtree
> +CLAR_TEST_SUITES += u-parse-int
>  CLAR_TEST_SUITES += u-prio-queue
>  CLAR_TEST_SUITES += u-reftable-basics
>  CLAR_TEST_SUITES += u-reftable-block
> diff --git a/parse.c b/parse.c
> index f626846def..1dcbcf64a1 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -209,3 +209,99 @@ unsigned long git_env_ulong(const char *k, unsigned long val)
>  		die(_("failed to parse %s"), k);
>  	return val;
>  }
> +
> +/*
> + * Helper that handles both signed/unsigned cases. If "negate" is NULL,
> + * negative values are disallowed. If not NULL and the input is negative,
> + * the value is range-checked but the caller is responsible for actually doing
> + * the negatiion. You probably don't want to use this! Use one of
> + * parse_signed_from_buf() or parse_unsigned_from_buf() below.
> + */
> +static bool parse_from_buf_internal(const char *buf, size_t len,
> +				    const char **ep, bool *negate,
> +				    uintmax_t *ret, uintmax_t max)
> +{
> +	const char *end = buf + len;
> +	uintmax_t val = 0;
> +
> +	while (buf < end && isspace(*buf))
> +		buf++;

Hm. Do we really want to retain the behaviour of skipping leading
spaces? I think it's a rather weird edge case of `strtol()` and friends,
and if we can avoid it I'd prefer to not replicate this behaviour.

> diff --git a/t/unit-tests/u-parse-int.c b/t/unit-tests/u-parse-int.c
> new file mode 100644
> index 0000000000..a1601bb16b
> --- /dev/null
> +++ b/t/unit-tests/u-parse-int.c
> @@ -0,0 +1,98 @@
[snip]
> +void test_parse_int__basic(void)
> +{
> +	cl_invoke(check_int_full("0", 0));
> +	cl_invoke(check_int_full("11", 11));
> +	cl_invoke(check_int_full("-23", -23));
> +	cl_invoke(check_int_full("+23", 23));
> +
> +	cl_invoke(check_int_str("  31337  ", 7, 0, 31337));
> +
> +	cl_invoke(check_int_err("  garbage", EINVAL));
> +	cl_invoke(check_int_err("", EINVAL));
> +	cl_invoke(check_int_err("-", EINVAL));
> +
> +	cl_invoke(check_int("123", 2, 2, 0, 12));
> +}

As Phillip suggested, it might make sense to wrap these `cl_invoke()`
calls into a macro.

Patrick
