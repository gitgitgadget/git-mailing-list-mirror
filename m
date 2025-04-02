Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12C233134
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579503; cv=none; b=PbynlaRiZ/QbduR62CVWLp5oXQ+EfR7aUnNGpnx9kRS5CQIrHRXpzFTzeIaHZQRfedmoPFxD0r5xpcNJsYlFD4Cy7Jvs2YZdxGojfq4C9PdeK3oZdyWLIeWQpzepa98z8Av0kbV3Vi/Uv3g9GliVITiYDsycqZ3XPacUr3nzu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579503; c=relaxed/simple;
	bh=Jyy83dqlsPA6eV/rDZWPGbtsnaSyix7pGM3bNBR0uVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHttNbempla83rRIAzNIsu9sm6Rv4Irl5Jj40CvIbf6GBXtj3ez+N/G5B1TfjN1UfSrJCggTQwPUduUgLuVcui6hMEqSmy7EcU1KV1LflrAFUZBLQI9akiI/NDaU6Z2qIgU0hcOlgam2/bSRwOiVQTDQEB0Ck2TiIxHnK8ULk6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l0T4NLuj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GhYdkA+u; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l0T4NLuj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GhYdkA+u"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id EC354114010F;
	Wed,  2 Apr 2025 03:38:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 02 Apr 2025 03:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743579500; x=1743665900; bh=kEF3quCiny
	ZGgQt4o1qcCD8lYGPIkYpHGVSXv1B6BjU=; b=l0T4NLujQWybSHmv4T1/j4oKC9
	zMoDrkxQPtK9alq9p0rP9b2HQiCwjryAX8Rc3a5tWjbqk/Un7lUjUlrzMuj1Xsw8
	i7yEz5tRo1fNT3Ww9ywFo0FuXFY5yT/WoZbN4ZFN/PKfxwMTHhLZWd+yLf3BMsZw
	idJ0272WFSWsxiWPUR/M6X79n6ZmMk9m4h2bNoBE61Bo8f0CXh/gqRSVGvIsbE7q
	+qJH4NVdqb6O5yJ6kt2/hW4TQ5w/OBagridVKWY13MPFPeeSNuXX58Xv8SsOMfpI
	KmTGD7pogRX4I1szsJiPBVJBJxqXRIeWA5sKLU/cVl4XEHH89DQPJSRryf6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743579500; x=1743665900; bh=kEF3quCinyZGgQt4o1qcCD8lYGPIkYpHGVS
	Xv1B6BjU=; b=GhYdkA+uspnBfaj4pYlbY7eFtU/BOssvUU3G2JCXpLCFUO1K4w6
	f40wAzRisbLLKbRKP7O03XuOkJWI/LIcGUr495WHRtR3fENn/zWQKvEJkx8AB0Sc
	Cw6vLgDttlR8SgHXoUr5DawmfPJbEmu78Z72ISOlF1d9pccrfnT7pLN5k9KQpOyk
	ktVQtEqbZswYzYtz42+0+Qwvoa1R/zR7X9KyCJRXeFWcpG6JLsLgXnuT7M8tWpHn
	sX3FTtRgp6H0L5STLNjQCCZhK00jQeIikSlEqLKzKj3KHMQNpfcMmg3BR4V0SH0w
	8holEqCFScx/b0roxVYIfjMI8AtShwnsVjQ==
X-ME-Sender: <xms:bOnsZ8b5zKm9-2w_OmdMU8kcijmuJiipKCHDK3W28XKYYCy7-Gck7A>
    <xme:bOnsZ3ZZLLMP9SHSJPBYrlN1zrGTTm-fRc1qexwGptsrCRa2W-XVfkSkQKxn0-VLl
    jNsNmiLOY6qNIPouQ>
X-ME-Received: <xmr:bOnsZ29zaubNQmviIblq9J9O_3s2i-6ecdxB53WBm60awNn7G6kFuikyMsmxIirTjFvIgVcKtMd4HWo_7fpJvNzhW4fY5SIRQZxm0QHgdk8TGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    hhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:bOnsZ2pMQLAHmZp15U9iEALwSt9hGsm90Q6gGQksLHKDobADzMHWqw>
    <xmx:bOnsZ3qJA2odlPE3r1WUxCVFV92ruvvMTn3-yP00sRtToFSqTRbUYA>
    <xmx:bOnsZ0TBY1rZKDNJJ0jOtwFdLYaTEJXvPrpPdKll8-k60stOOFlQcg>
    <xmx:bOnsZ3rzabGME5a3NfzLnRo3JexADZ3KhXWJC9yYc45L453TUaDe_Q>
    <xmx:bOnsZ8ANOEcjao3WYHGtPr0McEOLb5hyDn2w89yhOhFHjCY8Ajsa5YI6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 03:38:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1176ed23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 07:38:19 +0000 (UTC)
Date: Wed, 2 Apr 2025 09:38:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH v2 2/2] help: include unsafe SHA-1 build info in version
Message-ID: <Z-zpau_DsOGVVtjj@pks.im>
References: <20250328170121.157563-1-jltobler@gmail.com>
 <20250401203630.285451-1-jltobler@gmail.com>
 <20250401203630.285451-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401203630.285451-3-jltobler@gmail.com>

On Tue, Apr 01, 2025 at 03:36:30PM -0500, Justin Tobler wrote:
> diff --git a/Documentation/git-version.adoc b/Documentation/git-version.adoc
> index f06758a7cf..753794988c 100644
> --- a/Documentation/git-version.adoc
> +++ b/Documentation/git-version.adoc
> @@ -25,6 +25,9 @@ OPTIONS
>  +
>  Note that the SHA1 options `SHA1_APPLE`, `SHA1_OPENSSL`, and `SHA1_BLK` do not
>  have collision detection.
> ++
> +If built to use a faster SHA-1 implementation for non-cryptographic purposes,
> +that implementation is denoted as "non-crypto-SHA-1".
>  
>  GIT
>  ---

I got basically the same comment for this new paragraph as for the first
one. I'd either drop it or expand it so that readers know what's going
on.

> diff --git a/help.c b/help.c
> index 3aebfb3681..1238a962b0 100644
> --- a/help.c
> +++ b/help.c
> @@ -772,6 +772,11 @@ char *help_unknown_cmd(const char *cmd)
>  static void get_sha_impl(struct strbuf *buf)
>  {
>  	strbuf_addf(buf, "SHA-1: %s\n", SHA1_BACKEND);
> +
> +#if defined(SHA1_UNSAFE_BACKEND)
> +	strbuf_addf(buf, "non-crypto-SHA-1: %s\n", SHA1_UNSAFE_BACKEND);
> +#endif
> +

Should we maybe print the equivalent of "none" in case no unsafe backend
was selected?

I also think we shouldn't name this "non-crypto". The backend still is
SHA1, which is a proper cryptogtaphic hash function. It may be somewhat
broken nowadays, but that doesn't change the fact that it's a
cryptographic primitive.

How about we rename this to "SHA-1 without collision detection:"?

Patrick
