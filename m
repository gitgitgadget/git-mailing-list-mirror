Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18A01E9919
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 05:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147176; cv=none; b=jeFo7NdHvzFH88k0De1ChGmyfYS083qsHrFh1JFO1KnblTCzDgb/vdC5kzD7f+sE9RAMUlYkvNF0PFaYWUm7jQro5KyDOFbX+PaKpNKcwvM7P3YhXgjXz3mQ33OFH5YFqXh7QmG4W3+AbItLcZn6eRMVh5cqDpIb62up4z83XV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147176; c=relaxed/simple;
	bh=xIkz5k2LoAsfZ85kqIqIW1FNXzrsgD7/90W5nQrQrbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GHbubM8vFzRK5/Lo4RQsO9pp6z9YbuEZ38YbelrC8q7EG47dqW1JloAv7f0lJp3lAjZ0UCA0n9Fy0mOZA3O7pkCMkoJ5z7x9QMJyBNqS61cscr8OSaaWqAHBRY8fZlWpdFp6ECHYY0gcYXnmfRkkF/86XIC/94dSgtZeNTsVm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lXaAyb8D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O2NNOG/k; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lXaAyb8D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O2NNOG/k"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B01771D00141;
	Mon,  3 Nov 2025 00:19:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 00:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762147172; x=1762233572; bh=KQqavnC7Fp
	SSzNQHAXYrhPehRHTEDEPKqiV8dNiSjS4=; b=lXaAyb8DejsyHXA4BSPbJufV7j
	s4fwnNErQrCxLUMdwHbQo1xd2hXoQ3u1UB2oi1G0+8rs2qMbVj7JB8YxhowuFapl
	d1YqAEEvKezEvg0LAsJxYxGmYWaRG7na+htbbmTsw6DnzDNpb2mGsUHSCTI/OBus
	FfDMFSdRqzHwKrgGg3DqF6gQjvMNNYc75bFEwh2exLsPQm5UWpFah3jpkMvKrHj8
	C3z0pC41S9FJ1P3YmlyT+zqXqiNa++Z/vW6JADBswWaL6EWSDzGff3iJnQx3FgAL
	fkrtKzRuuA+r0GazDxyB4uVeiuvWhtZYy3hhwtyo3DybHi3MCdSbDbBuGs4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762147172; x=1762233572; bh=KQqavnC7FpSSzNQHAXYrhPehRHTEDEPKqiV
	8dNiSjS4=; b=O2NNOG/kKPP7fLJTHpb9UjOfgrsv3iUV/gWl2eem7NBRjLe3R59
	L2eYX67SxtMIZnUVIgH3ly/I0Pwk+IgBceYvDhHXPCeuR6NYlY4cIb8UcGO7HKm1
	v6BB/En1rImymg7QFrKFNhttbQRlgKnUu4rRVg7rHJyDg4CD5YIzmWUrvSx+gfsn
	EG13Pwy1TmDFfll2Ceo0o4HCKCbM5WDfChJ8zzlS9oKQ5t7FEDF6NpXj8IhHOFG7
	nlat1L5EDrHAsl3F87LYIPfKS96AHomrbpREXpVWcEE13m86YJt6OODJxGdZb+lh
	jIMYlN4Yvl/s8JlFmqUWXI/mdWbio9nkfDA==
X-ME-Sender: <xms:ZDsIaZPVdcIMdvnBC6CAaVnNekNebJuqAQk-npEAFk-9sMolQP_YGw>
    <xme:ZDsIaVRxf-vwqTt0JaViZvsLuV4v7DeQUjbFAir3Zh7HRvYVHmpcfKwb3Q3w21fF-
    aAP0CkREh3Qj5isTgF1i5WgWeLXabEZpQn3LQvLrynH_priC7fM>
X-ME-Received: <xmr:ZDsIafiH-nwOd__WGZDX6n7FGlkiPz9xw8Wi_VzNan7qbviZJ6k5wEgd35vqrXpEHb3TLITOUMW2dbmFxUaOvkIwlIbvENMUc4LY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtg
    hpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZDsIaW_TpERvNRspySos6jRUvIxRSAE5MiaXh_p9ZgKXkWs07xtVgw>
    <xmx:ZDsIaeE2gIoI2d-GnMXi9YKzWRuOwV2My4CYC2vkTSCcgRhB6nZg0A>
    <xmx:ZDsIaRmIH94X2Rw1YHSzU850Tgl7NOi7iyCvaWiCZXvjn4WR_-udaQ>
    <xmx:ZDsIaaZEA_i5Ej9uPCtbpHGuSDIJngEOjYNtS-guzHC8p7OeyPwWpw>
    <xmx:ZDsIacIXkMTQPWqypssLm0gyE578jRlKb-CRc3Lq1r4avHljfybaycmQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 00:19:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Taylor
 Blau <me@ttaylorr.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 3/5] parseopt: use boolean type for a simple flag
In-Reply-To: <10d531daf2c90d1bb53c07f1d72b087ebc1dd9c8.1762100242.git.ben.knoble+github@gmail.com>
	(D. Ben Knoble's message of "Sun, 2 Nov 2025 11:17:46 -0500")
References: <cover.1762100242.git.ben.knoble+github@gmail.com>
	<10d531daf2c90d1bb53c07f1d72b087ebc1dd9c8.1762100242.git.ben.knoble+github@gmail.com>
Date: Sun, 02 Nov 2025 21:19:30 -0800
Message-ID: <xmqq5xbrwv4t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>  parse-options.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 6211b55a83..197c01987e 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -208,7 +208,7 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
>  	case OPTION_FILENAME:
>  	{
>  		const char *value;
> -		int is_optional;
> +		bool is_optional;
>  
>  		if (unset)
>  			value = NULL;
> @@ -224,7 +224,7 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
>  
>  		is_optional = skip_prefix(value, ":(optional)", &value);
>  		if (!value)
> -			is_optional = 0;
> +			is_optional = false;

Whether it is spelled 0 or false, I do not think this makes any
sense.  skip_prefix() either touches &value to point at the
substring in value that comes after ":(optional)", or it does not
touch it at all, so there is no way value can be NULL here (and we
know value is not NULL before we call skip_prefix()).

Shouldn't you be removing the entire "if value is NULL, it is not
optional" thing instead?  That is exactly what Phillip pointed out
in his review.

>  		value = fix_filename(p->prefix, value);
>  		if (is_optional && is_missing_file(value)) {
>  			free((char *)value);
