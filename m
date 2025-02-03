Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0847D2101B3
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623128; cv=none; b=rUxrzbMFcNIAAGUTOg23XY8nwfc5BTfNnxMu3XTL1GZNe3jqPFKEV6lxHU1251YA295Bk68SlDy7CNTmzgXZ0SrEZeIUQh64kB6vzlrzS1LXZtGEk2T52F6KhhotKKi2ByyWYA6TOW/PKLAK/cs/HRvgF4c7CXgcrwgtSllB9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623128; c=relaxed/simple;
	bh=AT2tTAz+e/5w7uzeITtUgZYdlLiJoCbVwPGJXs12Atk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i5FzAM+yVjpFgL9kRYdIB9DxNQTw7o9qrnHJB1XRLYkpRyJiBX93CFIAnk2Ch6sVHQaEc8IuPv7XB1upq/oLj3f2KlEYxAipBZdWaGHs5xI0/fkYJhn4fIO4vJcrIYcUUsmjhnlChc1OS/e8ceDLC3Mfxr6sswgzVDDFBxzi3uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AeuVDXBl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zAC+nvZq; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AeuVDXBl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zAC+nvZq"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E37B22540146;
	Mon,  3 Feb 2025 17:52:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 03 Feb 2025 17:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738623124; x=1738709524; bh=YEdsKb2ViH
	ba7YFl937esmQEB9KaLXlQ3k7O/ey+/eo=; b=AeuVDXBlgjOIpvGpuElHNxfNnl
	BbaaIvT6kcbN+yXOn//Rbubd3Wc4cyOCRX0YDI3C31z9z+8x1/h/s2fT7vIQ1Deg
	SaA0q+6tacW0tLTXNu4vY0WYf87w/ZxfhhVuCnH09rZL6BwRr8ES9vAsggP64Bay
	noh6N5s7Oh+qpF9efp44L9TJXjMGMaQeD43j31oWslEJXJeBXbDnjS2qYxy2X4Pu
	GsZq0aDmSgCSI2OSNcvMFWlF0gmU1GhXF+taYdzU5aKp6EOze5C+mSu/dzV1hSbm
	Dot4j7oeRzEg6UHliedvbdMzzXUvN6ZasOMXkdTbCho27RJivyjBYYhgec2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738623124; x=1738709524; bh=YEdsKb2ViHba7YFl937esmQEB9KaLXlQ3k7
	O/ey+/eo=; b=zAC+nvZqZ6ctj37dptTRsdfuBLuCZzT5WRG2nWRUb1Uxax276uH
	gxdIAghqqPM3hdGMlVkizg4R0iFebTiBzBOjpuHNr6JY6bi9w0t43OTWMhmEQoNn
	BeMQjJSsK9IwdSe35mb+/kC+SLGq0Vlzauo/hEEDwNOdmymPGfqj4FJK9qwH4KGr
	t27g77NeiV7JcpberqChHo9AqIXAIxJ1nzpEQ3i54RUdRTSju3DZZ5ovHw16diM1
	/V8acjEns78KtMrieIqdY2jqcsX7HoY+dnX7gN88oTu1cflF7IGn0W248ZQwY514
	FcC9b66IjweJCZ55QJBPj5uKjWDcNro/kKQ==
X-ME-Sender: <xms:lEihZ63sw_Fv5cSqqVkfY9mEtithSCWCNdvKxF8WrYDkkVvdMKFSyQ>
    <xme:lEihZ9FPgXTeqhtyKYxAzlqew1RIS5qBGFZGD5b-8LG_8L5OaYNOnyTTnR2RYf9jp
    V0LBLgjjsH6A09gkw>
X-ME-Received: <xmr:lEihZy4a0ZLrIBPoB8RLqxl-hdawgQprICCH6dZWUzVhusPQBczVAhSkQb9urAtAskOVInQwuq8w8ygzjgkeOhFzmq_ffbz4wbuB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lEihZ73l2KvDZ1YEPi3ZzS2hNB2-sH-GhImMglEM15BmYO_9PDFDUg>
    <xmx:lEihZ9FjQfby2tcdB9mIDtR7vWQ9ZggRFIlW3zpuR9ymFzQlMDxD4g>
    <xmx:lEihZ0_iF10LH25Kq7Ed001lkvYJJxQZMFLihpbuxo9MvzGhuMuBXw>
    <xmx:lEihZynn762JyJO4oNlU6qLbH0vuEjcqOLtHHd14bMkl5AYiZv431Q>
    <xmx:lEihZxjSXaFAcYVTOHkniILu_2IwMXXVuBbcuVQRWwCbRSTh3p5ZJNpC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 17:52:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH v3 2/4] quote: add quote_path() flag to ignore config
In-Reply-To: <20250201201658.11562-3-jltobler@gmail.com> (Justin Tobler's
	message of "Sat, 1 Feb 2025 14:16:56 -0600")
References: <20250110053417.2602109-2-jltobler@gmail.com>
	<20250201201658.11562-1-jltobler@gmail.com>
	<20250201201658.11562-3-jltobler@gmail.com>
Date: Mon, 03 Feb 2025 14:52:02 -0800
Message-ID: <xmqqtt9azlnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The `quote_path()` function invokes `quote_c_style_counted()` to handle
> quoting. This means the output `quote_path()` is ultimately affected by
> `core.quotePath` configuration. In a subsequent commit, `quote_path()`
> will be used in a scenario where the output should remain consistent
> regardless of the current configuration.
>
> Introduce the `QUOTE_PATH_IGNORE_CONFIG` flag for `quote_path()`which
> when set instructs the underlying `quote_c_style_counted()` to also
> ignore the `core.quotePath` configuration when executed.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---

I've already read what [3/4] does using this, but I do not quite see
why the scenario the quote_path() function is called requires that
the output should remain consistent.

As it is possible that a path has any byte other than NUL in it, the
recipient MUST be prepared to unquote it before being able to use
it.  So if a run of "rev-list --info" in the same repository with
the same arguments tells a path as "abc" (without quotes) and
another one shows the same path as "abc" (with quotes) or even as
"\141\142\143", the consumer should be able to cope with the
variations and see that they are the same path, no?  At least, I do
not quite see why we require consistency across different settings
of the configuration.

If we drop the first two patches, as long as we use a known value in
core.quotepath in tests in t6022, everything should reliably work,
no?

When we do need to quote SP (i.e. outside the "diff" output, for
which originally cquote machinery was invented), the default cquote
mechanism does not help, so we need to allow _some_ tweak from the
caller's side, but I do not know if I agree that "no, we do not
allow bytes with 8-bit set without quoting" is a good idea in this
age.

Thanks.

>  quote.c | 13 ++++++++++---
>  quote.h |  3 ++-
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/quote.c b/quote.c
> index d129c1de70..baec34ca94 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -370,10 +370,18 @@ char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigne
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  	const char *rel = relative_path(in, prefix, &sb);
> -	int force_dq = ((flags & QUOTE_PATH_QUOTE_SP) && strchr(rel, ' '));
> +	unsigned cquote_flags = 0;
> +	int force_dq = 0;
>  
>  	strbuf_reset(out);
>  
> +	if ((flags & QUOTE_PATH_QUOTE_SP) && strchr(rel, ' ')) {
> +		force_dq = 1;
> +		cquote_flags &= CQUOTE_NODQ;
> +	}
> +	if (flags & QUOTE_PATH_IGNORE_CONFIG)
> +		cquote_flags &= CQUOTE_IGNORE_CONFIG;
> +
>  	/*
>  	 * If the caller wants us to enclose the output in a dq-pair
>  	 * whether quote_c_style_counted() needs to, we do it ourselves
> @@ -381,8 +389,7 @@ char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigne
>  	 */
>  	if (force_dq)
>  		strbuf_addch(out, '"');
> -	quote_c_style_counted(rel, strlen(rel), out, NULL,
> -			      force_dq ? CQUOTE_NODQ : 0);
> +	quote_c_style_counted(rel, strlen(rel), out, NULL, cquote_flags);
>  	if (force_dq)
>  		strbuf_addch(out, '"');
>  	strbuf_release(&sb);
> diff --git a/quote.h b/quote.h
> index 2a793fbef6..84903951ef 100644
> --- a/quote.h
> +++ b/quote.h
> @@ -94,7 +94,8 @@ void write_name_quoted_relative(const char *name, const char *prefix,
>  
>  /* quote path as relative to the given prefix */
>  char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigned flags);
> -#define QUOTE_PATH_QUOTE_SP 01
> +#define QUOTE_PATH_QUOTE_SP	 (1u << 0)
> +#define QUOTE_PATH_IGNORE_CONFIG (1u << 1)
>  
>  /* quoting as a string literal for other languages */
>  void perl_quote_buf(struct strbuf *sb, const char *src);
