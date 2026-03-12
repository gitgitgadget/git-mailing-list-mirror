Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C693D2BD5A8
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310983; cv=none; b=pWeDMWwSqZK7Lljkz2gq76XEZhYbkr1TuMzYy2sXRg3Miz+TvsN+Jq+hXnkdh88aR1z+TSk5JEA4is9g5+i+O/mDSeJVzlxjfBIowZ8nPzLs1U8aLLZcdYu4Ezo6Aws50H7RAN3DZ0+sLjkFJVF8bpjEBxlOwHXrI1RZxyRRh00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310983; c=relaxed/simple;
	bh=lg7JcfSIK/WNXyXHuA6v1YDE8DdctWRSA79MRY4rFQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BV6rpC1ZuycMFttpbgdk+HycrPUuZ8OTmdFqQkRY+rNB9NgPP50krZ/6+2FgPs/pMPmuyRwls3EN9X11hIW4g+nHFdgJ/l73/40546Bp182QDlgGDyZUyfGrxrnmNp/FtMXFOjKvYI3bk9zNs0UMjt63E2oqRGt3pEsA5vO/fW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D7g1k4wk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xaPHGq0K; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D7g1k4wk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xaPHGq0K"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3B871400176;
	Thu, 12 Mar 2026 06:23:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 06:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773310980; x=1773397380; bh=2n+DMHAJdy
	sgG+HSz5PluPmYpRreys0aCTzwNeThaMc=; b=D7g1k4wkT4VU+13rfWi2FImNSR
	Ym2Ur3Lcwy8KqZsxDImIj8rdCXdk5RCpeNOQIEXH0MezbWaD7q7PsKYrbZ/oMjME
	OwU37u5uo5tSAdnO6hTsVFxRvdU8GdVNs1vpc9qMXrY2HgALPXCzxJIKoWAGjWc8
	SnOWtId/HC+naNcE/nUjyiaC4rE12ASleo3AwRauunpRWV6x0TIqRqcqt49f5Wei
	/VQKvorwZ6MRbkxNwpqxXrbcmyZNubtZR9aOs8As536uo3yVHphIaGfj6CLqt2Cy
	ywMaALL0ULuaaH/5HKyCoJULZ3V+Y4fgKtpkR8k780O2XcXBYUpFzPrKdSkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773310980; x=1773397380; bh=2n+DMHAJdysgG+HSz5PluPmYpRreys0aCTz
	wNeThaMc=; b=xaPHGq0KMi7KTDZCi8M/z5UJd5A5arymunAiDfolD7R0xgbEWYd
	MaFM9Ris8JrwYqt/z8GoXyOqpNRKWiTNTaTzCWLv989CI3rjIKd0e84qyLbVMWX0
	8jFGi9Mj64xngCe31lfTCRL1uUFZuO5xbO6R50uO2LW/MeccaioRljZGztpWZN0a
	awvAA8zQvudJ5Avdptk9hMEfGToD8dATSKfXFgirHK/ot2CuRqjpDLjeTHZZvNw9
	0wOlJPlNSyGGPAHRu97lcw7z4Vnv+brqxAZbBIxbPLcSg9vEXvX0+CwkCxRIxt2y
	uBzUYqUwVQqlQUp9mOge85JEVIg88oXcW8w==
X-ME-Sender: <xms:BJSyaVFI8u8lgXmHZxO-_mJ5E5vAoBaAPFNTHAlr2fSWz_-36EGqdA>
    <xme:BJSyaRN3-tr313_NQVFei9ugHvATjXrOUO6UhbybVkuilpU40ihzCv23xpwKCM_bU
    PRa0z6mUI5g0i9agdEYuMwT4rCs41uBMBYBc3R7EONL4o7WxnxVXQ>
X-ME-Received: <xmr:BJSyafdXNibPaZp9quzaFTiaqW0ueNmYXbWy1ZkeuX2cr53birzEohUCJS2JIFCI3nTYTmSBPZ-Z61prgp_FxInNtvWkAkusZ7FCR-YNObMGqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeiheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheptghhrhhishht
    ihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:BJSyaWuIgOcqFcwUv11z6ATzCctZD41EPCj_Fiy3Eu50THv4_Cka3Q>
    <xmx:BJSyaYn0A87Nqfn5TrlaH577OHMD3221VH1JnF5lA4jqrU-oJzBDNQ>
    <xmx:BJSyaQyOqoXRSAuiR1Y_sjkiGSsaoCBdwDKSRcgyJcuYW1lvDSMAIQ>
    <xmx:BJSyaSOLhtbfrzKy2yXBUWyvl6tZVgNuuP0iTSHekrRVmU1bVRglHg>
    <xmx:BJSyaWca2W0E_5E6l1Qnxwg3oG0H98UXm0wVtGMD4uvhB9lnbROKqyck>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 06:22:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1a530207 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 10:22:58 +0000 (UTC)
Date: Thu, 12 Mar 2026 11:22:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net,
	christian.couder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v4 2/3] gpg-interface: introduce sign_buffer_with_key()
Message-ID: <abKT_50GVgBcj7op@pks.im>
References: <20260310201116.1130160-1-jltobler@gmail.com>
 <20260311173147.2336432-1-jltobler@gmail.com>
 <20260311173147.2336432-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311173147.2336432-3-jltobler@gmail.com>

On Wed, Mar 11, 2026 at 12:31:46PM -0500, Justin Tobler wrote:
> diff --git a/gpg-interface.h b/gpg-interface.h
> index 789d1ffac4..a32741aeda 100644
> --- a/gpg-interface.h
> +++ b/gpg-interface.h
> @@ -83,6 +83,13 @@ size_t parse_signed_buffer(const char *buf, size_t size);
>  int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
>  		const char *signing_key);
>  
> +/*
> + * Similar to `sign_buffer()`, but uses the default configured signing key as
> + * returned by `get_signing_key()` when the provided "signing_key" is NULL or
> + * empty. Returns 0 on success, non-zero on failure.
> + */
> +int sign_buffer_with_key(struct strbuf *buffer, struct strbuf *signature,
> +			 const char *signing_key);

I think this interface is a bit confusing, as you wouldn't really be
able to tell what the difference between `sign_buffer()` and
`sign_buffer_with_key()` is without having a deeper look. Naively, I
would expect the latter function to be the one that actually mandates
that the user provides a key, but it's the other way round.

Would it be preferable to instead extend `sign_buffer()` to take a flags
parameter and then introduce `SIGN_BUFFER_USE_DEFAULT_KEY` to make it
fall back to the configured signing key? If so, we could drop
`sign_commit_to_strbuf()` completely.

Patrick
