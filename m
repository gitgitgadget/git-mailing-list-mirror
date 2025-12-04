Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB7533D6FD
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764847425; cv=none; b=qWzruHorepFrHF+bPCWY7MVEvl9cmLLf6QP4PvgpVFe0+h0+DPnmVtzOaAkB2VV6qyqfspGMPfuYP+FHqblwAva0PnF0fZoUBJQZ38K3y+Q0Kz9avp/M8WmkP29W8BhLNKNrGHNc6EEbDGe9H32Y8kvv9Kwd467anykiWnvnhw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764847425; c=relaxed/simple;
	bh=TUKWYl3KQ7BwNjl0v+D32SgzTBZrY3TOG1Yf98ViQxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzAHPvzAEgIDdiqOPBHnwW3w2+CmpGQkPOhjaXGwXvR3jEKr7o5X2D5+UGVuPXbiWWtIvroEPWu1pI0dWslMayDJLW/TlT3RDtY5YJ5z2BW3paL4y2WuiijSHaNzZISaaeng3nsbhHllbA/vHVKoQjaLuwhtGwfHywJNCu1wckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IIA6TKeK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W4T/SKQ0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IIA6TKeK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4T/SKQ0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7586014001D9;
	Thu,  4 Dec 2025 06:23:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 04 Dec 2025 06:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764847412; x=1764933812; bh=dGCLDTYLKb
	3TZyIWmMsUVOSzAEz68vOjbuF/ihmMoOU=; b=IIA6TKeKxBpaCUOWU/bkhqUDAO
	5a09e524Tr414YZ9uZ0aLpRt3DMl021y9zz8vEt+c3iFCTufYDWRJBFRco56udd6
	6VKxiOpI+3iI0zr6XWdTDDlUgzgiYnNmKqlONG1ycdA0CFHenf6qttqqSBTTP1kn
	C8ay/x5ibN+QQIw3Nyu/wWKC7LHs/EzVEfRvga744M+pWcobKZFsXrUkzboPptg4
	oYbn07HBhFBrW/ASHySwYJIdBRRWBAHJkkEakEg4Q3G7yPBJFNhNXwakf0yJo6+B
	9OhvVLtb0zbQl7uIKg79m63igpa9hPdSsMqwBP9lr6a9/tRwsuzWXMncXTLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764847412; x=1764933812; bh=dGCLDTYLKb3TZyIWmMsUVOSzAEz68vOjbuF
	/ihmMoOU=; b=W4T/SKQ0nIyYEms4gGjQBwFgYwTvg0sL2xcHfPZXlw4GbVwG7gm
	T9nXYhxrYAy4jg0szWSTVrPQJzuCUU48AFHdaHmHRWhd2nPLF8UbS621GT5vISng
	6J2YPosVk1oQ23s6vOymZ/z0vaUhYM6FdTS3nvG3jr/SwsKfpwriHZQAMhGuRklU
	CR9iPNE+wmex72hjjVVP+1Syiph+HxH1ze6dfVutWGxPQDGeP4ZryavATbiFlsQh
	XRKIXmT/18WLSc/1CS5xPI1eX0e+kixN2iOT4dyU2niqLoPZIGBbza7KrqGw/ZN/
	NsaVtOi5nbQziVUf3NfhcaUoMVtTQTKvKZQ==
X-ME-Sender: <xms:NG8xaT-9DEhY3UO1t10z6mnBIJgPZWKpZkvgtkHBkT8WSnuMpfpQBA>
    <xme:NG8xaTZv-C6-KcNZJYe1fdxl_zLuXbsTudb-ukbhvDJA5r9L_YJsBUSCPHKD8SBfl
    3j-KFdTFoxQoO8jvU_yKxnHpnisN6aqbZG2X2mpOg076xnixi_RgQ>
X-ME-Received: <xmr:NG8xaa04PdZgxLyoKgh-nAFhoz-EnnxwuBZdjFJFABl64sHT4OH5k82hYO2V9Ez5XE-zz8LWcqjce7-I_z0BOhqX2Q6JE0J-2BLZMeF3ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehgeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    tghmlhhishhtshesshgvnhhtrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvth
X-ME-Proxy: <xmx:NG8xaWb_ZWIF-2CDupPnY6TbG7qBltQQxVodxBC_oC7GOw2WDKuvXQ>
    <xmx:NG8xaaIxYdVJpXm0WAqZYToMnykNEMid7NXp7-m7k7MLgsKH6-0Okg>
    <xmx:NG8xadHMgfk93_FRD5QgVI5cUjhfPK_h8nYhwo4JQyTrVJe6xAAmsA>
    <xmx:NG8xaZtx_Pby09KU3GRmoJ0S0_7WOuFoPzr2uKZqGiuLFuM4BzqRkg>
    <xmx:NG8xabwoyJN06lNHaxGd5x1BZihT86SWSPu2CTluOzcWT9i46lbslXmw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Dec 2025 06:23:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 32069910 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Dec 2025 11:23:30 +0000 (UTC)
Date: Thu, 4 Dec 2025 12:23:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	correctmost <cmlists@sent.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/4] parse: prefer bool to int for boolean returns
Message-ID: <aTFvL1GV76o-tUJL@pks.im>
References: <20251130131351.GA198697@coredump.intra.peff.net>
 <20251130131441.GA199335@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130131441.GA199335@coredump.intra.peff.net>

On Sun, Nov 30, 2025 at 08:14:41AM -0500, Jeff King wrote:
> All of the integer parsing functions in parse.[ch] return an int that is
> "0" for failure or "1" for success. Since most of the other functions in
> Git use "0" for success and "-1" for failure, this can be confusing.
> Let's switch the return types to bool to make it clear that we are using
> this other convention. Callers should not need to update at all.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Obviously not strictly necessary for this series, but I think a good
> idea regardless of the rest of it.

Agreed, I think this is a sensible change as it helps guide users. I
know that I was confused by the API several times already.

> diff --git a/parse.c b/parse.c
> index 48313571aa..f626846def 100644
> --- a/parse.c
> +++ b/parse.c
>  int git_parse_maybe_bool_text(const char *value)
> diff --git a/parse.h b/parse.h
> index ea32de9a91..f80cc5b9fd 100644
> --- a/parse.h
> +++ b/parse.h
> @@ -1,13 +1,13 @@
>  #ifndef PARSE_H
>  #define PARSE_H
>  
> -int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
> -int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max);
> -int git_parse_ssize_t(const char *, ssize_t *);
> -int git_parse_ulong(const char *, unsigned long *);
> -int git_parse_int(const char *value, int *ret);
> -int git_parse_int64(const char *value, int64_t *ret);
> -int git_parse_double(const char *value, double *ret);
> +bool git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
> +bool git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max);
> +bool git_parse_ssize_t(const char *, ssize_t *);
> +bool git_parse_ulong(const char *, unsigned long *);
> +bool git_parse_int(const char *value, int *ret);
> +bool git_parse_int64(const char *value, int64_t *ret);
> +bool git_parse_double(const char *value, double *ret);

Should we maybe add a comment to these functions while at it to document
their behaviour?

Patrick
