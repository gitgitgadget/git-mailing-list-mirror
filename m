Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A45335B142
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962305; cv=none; b=i9Gaw2V9P/b+C2j4YDoyN2y+uTGLhF4ekHtnNoI8NwJs2Vny85JDnO1oY1IoaQ7EjE9Nn1eONxyWpGUVSg3p5tqBUlhC1ORfeMp7TJjbLTAlhF4Juhglw7h60FfFas/HKkwcje5d1LEB3mBv+j08hDEtHpM201WZFYeZgTn2v0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962305; c=relaxed/simple;
	bh=PJoG5cvN5Kf8I+giK1FwrIgMzacJAVh8BHWUkGTNY50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRIP7xW3tmq6xODdFwwe6mpcIT8XqC4RGI43krLPT1tadmZWEajQroak+7WTuUIJSv+opbgDxKxpehV6hG9JVo67L8s+Kl3+71Dq85/g066IYMBsNkaR0NZdCEjY/4Lsih6dzQBaikZEydIZYIWGvEfXeHAqD95imsifXkAJLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JEnSMp/A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rsi2pgFQ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JEnSMp/A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rsi2pgFQ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 267E27A016C;
	Fri,  9 Jan 2026 07:38:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 09 Jan 2026 07:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767962302; x=1768048702; bh=y47spGMcqZ
	y/3ZTSW+Im2ATtR2Z7s5O4gfyLFjnb/9M=; b=JEnSMp/ATDs8X9IqjWycWCG8nO
	ToqUGJt9OUlzVOPuQKLeYoPzyk1aBR9Hd5UHAKo6NLiKWOb/Hz9OSN124JiYVCIe
	zxZrObYwFqw+ub4Gzhw2P+eAvPfbdXpevgvMhuqoLsp5nALXNIVIl8Uwy/NPxTMv
	IXsFbCKuk1E9fMbW0dvU7IoUzTlKgSIZbIfEtg3YX7M3y3CHzChZN9WgwBT7TW1k
	jEf4WmMzbsy+fjPFrWYIILw9XHQlKfipD+h0eVJz7AwxikF2EFM9xiuTh7XwlFbT
	laF3rX4RM/HKBGmYcHbDZH/cigG8O1BNR2w0omSYzqPMvnKY6Ap+4jBxwI9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767962302; x=1768048702; bh=y47spGMcqZy/3ZTSW+Im2ATtR2Z7s5O4gfy
	LFjnb/9M=; b=rsi2pgFQd2znX4CpH8QL0dMj6Xt/xKqhm5r6jq8EPUNUireZgko
	vVpUQPaThNAuhPEViCscLoD7QlnQtdCD96eaOTQ+juj7GR9pshJ66k8p85GJdVgU
	AkkO9juxtLfBPrIMLZ1ZRMid8k6/BmmaDaF0R/kGz5eVcyhkaPOGTz3jgJ7uvwF9
	fIATn/xesJbVACP2jLWdxyJeej4xzyMU8jX0BBmJ8Dbcnw4F60NKuWmDPe5vSUde
	EF2kybGcUO/TGfiWwOH/uFsQVs8lghhKN+uIAefstNm3FRazsCUB6xqIMChPvvz0
	FtrCiajWyPSh8mcR64dWGEEj87Fb/8TaNtw==
X-ME-Sender: <xms:vfZgaUrp55ci4WIB-SuLWVR3WGB5juFs_uIPwEL8gqNmyR3nMUrUUA>
    <xme:vfZgac7UXEQVJzeIvgaZmRGHPIpmXu4lrSXkTyc8bwCvs5pKqt8Nw0h-fiyMPOZgL
    YCfa5xkBBbgwxS7mMye-E6xlhS7WuGr6pDujygiak7mPxs2Ehbfvg>
X-ME-Received: <xmr:vfZgabeL4z-YwWWyBGIdfteuAqCIOGSAhiPgEaYBOdPDgfZgBnjP5bvY8HiGkVYzCnPwOVnn7pXB6rTMmfhNomx_eQGIVHEnzi_OqvTCow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgfdvieevkeegheegueevueeiledtuedutdeviedvtdetleelgfejgffftdefffeinecu
    ffhomhgrihhnpehmihhtrhgvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnug
    gvlhhinhesghhmgidruggvpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehophhohhhorhgvlhesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehstghh
    figrsgeslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:vfZgaR5VzLAoEE0VEYRA5FeO8yzsWdaCm1oAx49oNeEBzEnR-j8gXA>
    <xmx:vfZgaSsG1p57AOPO7Tf0dwPaMCI7vaXiBfElPnLeAwdxTrKfpgvoXQ>
    <xmx:vfZgaRiinDY4w3HDO91-ieAHt9zBY-HAKBKM-GrFwiN0Eunbwv1G8w>
    <xmx:vfZgadrvTKwKcBs6G9Ga3EX7SUXlwrIA-jYFLT_T5--h0RfhX-8wyA>
    <xmx:vvZgaWJ6fWytWKClM5sQA0uS5_Jnkxf3WLWYUNpXC7twRL2XdvjPpL8n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:38:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d88f8d75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:38:18 +0000 (UTC)
Date: Fri, 9 Jan 2026 13:38:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/4] sideband: mask control characters
Message-ID: <aWD2s5RyhxYSLmfc@pks.im>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
 <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
 <8d7047655933592939dd1395f5b1ead595cee4ee.1765981422.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d7047655933592939dd1395f5b1ead595cee4ee.1765981422.git.gitgitgadget@gmail.com>

On Wed, Dec 17, 2025 at 02:23:39PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The output of `git clone` is a vital component for understanding what
> has happened when things go wrong. However, these logs are partially
> under the control of the remote server (via the "sideband", which
> typically contains what the remote `git pack-objects` process sends to
> `stderr`), and is currently not sanitized by Git.
> 
> This makes Git susceptible to ANSI escape sequence injection (see
> CWE-150, https://cwe.mitre.org/data/definitions/150.html), which allows
> attackers to corrupt terminal state, to hide information, and even to
> insert characters into the input buffer (i.e. as if the user had typed
> those characters).
> 
> To plug this vulnerability, disallow any control character in the
> sideband, replacing them instead with the common `^<letter/symbol>`
> (e.g. `^[` for `\x1b`, `^A` for `\x01`).
> 
> There is likely a need for more fine-grained controls instead of using a
> "heavy hammer" like this, which will be introduced subsequently.

Most notably color codes, I assume.

> diff --git a/sideband.c b/sideband.c
> index 02805573fa..fc1805dcf8 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -65,6 +65,19 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
>  		list_config_item(list, prefix, keywords[i].keyword);
>  }
>  
> +static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)

Shouldn't `n` be of type `size_t`? I guess the answer is "maybe", as
`maybe_colorize_sideband()` also accepts `int n` with a big comment
explaining why that's okay. Ultimately, the reason is that we accept
pkt-lines, so every line is limited to at most 64kB anyway.

> +{
> +	strbuf_grow(dest, n);
> +	for (; n && *src; src++, n--) {
> +		if (!iscntrl(*src) || *src == '\t' || *src == '\n')
> +			strbuf_addch(dest, *src);
> +		else {

Tiny nit, not worth addressing on its own: the if branch should also
have curly braces.

Patrick
