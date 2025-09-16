Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7B2868A1
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009985; cv=none; b=PMlnD2Gq/AnSaTYFMsJ3yN8In9h/fdHuQjZuWhEt++rnDb/juwvi0kPhwUr32RS8iMs2t0xpnabtswUORQxU/8bJVEL8odoQcAecUHDI6OJ8NCP7MJmb2qbRR8kfJWY9CiiwvnMY0w/4DiyZhu2GW4aV+oBHm6YT4V7/KK3mMMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009985; c=relaxed/simple;
	bh=Kfku0S9S0qsVDKnplrw1FdYvIjyTARsqTLVu5TZgSvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Awnhx1GcL+i4QsAjclHLg+q841cdOC5jqCMSBiyRuKzZNSWBUq3qVbUc84MAHIr2YazG2TrITaXOLr4aUWz7rocoed3DcVgHeFoCNQQSuVXpTyFtTJ4JjXR4sgeQ7OybLauTNHHTtKNr1+30ecdhMnl505BZOP7EnspRfbR7A0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a4ubQdbD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VC8M+f2c; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a4ubQdbD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VC8M+f2c"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3CF637A026A;
	Tue, 16 Sep 2025 04:06:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 16 Sep 2025 04:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758009982; x=1758096382; bh=hj+ZLTkFiq
	jGgnzHccgzcrYvAdipGYYo+bnoMzI8Jng=; b=a4ubQdbDyxJxE779bRiDwvUV03
	IB6QlSkN/KewLVkOI5waw48fPHbGMLMabMZ3Kw13VEkcx+oD7dEaH8+GUe9trAX6
	Z/ZgGc648soJcflZY3mk/JDO1GgNNnclVCcfP0fvxedNuUN9GgKVInBXLnRhasdO
	WE2iwk8CrW7FFkOD19KTqi/iA3hVkKCI8OcRb9dUj01wRkGvU7Gne7nQnifDs/HD
	UVSYvKPQ7UWuTDpYqnfbcIuSrrjnzkAlE7wU6O+p9U++qf+fOI2Rij1dV1xD5G4O
	3gU1vXLE94lFkSb2rYtTJU1lDaRHvix2r2fSEENQc4oqrVPjXEc3b0ZGqXIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758009982; x=1758096382; bh=hj+ZLTkFiqjGgnzHccgzcrYvAdipGYYo+bn
	oMzI8Jng=; b=VC8M+f2ceQSTf5ldZ7nxVgwoo+WdZuI23I7mOssvlhEBLlZ8uzg
	xAH3o9SfDnfO9WzKvYiVOxYdQZWe9ed+5FOJnmKXxvNVtR1PUcUlFVTXcQ0Pag4N
	NewJWSNkfMWrIZOOO1AySOEqbS9Z9lu2tqtZ+glWq1FiOY8iqm/qKLQ05lzwrGbZ
	0HqNt0Wa/KyQqZhw4n3VpOAbGKs3U3YelvfFTMMjhicaB+Nb5dcjkuxmhYzHkumJ
	Qft4wmiwx3hemw03V7h/hhz7G9AnCWTC8/o6K2gdNEX8iL7lA5pGRfKIvyxFZOgP
	ZvB2V8LKUC9jNLe/URNTLrxkZPyteywnpbA==
X-ME-Sender: <xms:fRrJaNU2b7O8k6lxe1eMs-1XooXfPltBKetwATzAfXIij6_cJ92WhA>
    <xme:fRrJaA2_d8gtLmophF1DHgMnLYvRGBT6mItm83ps0mWACqUfSF8DINYdeM9xrfm5X
    YpQQf9OyumAQVo-HA>
X-ME-Received: <xmr:fRrJaC2KaD9LfL8xu_hd7Ksm8JD-poEwlqhIbGlUO5WDrQ8WgYRPUx_vuReLGaB_DUTUtPvGf6zi0lLaLW9XAw7CSk2Gda3l3SOOfQSSzs0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhh
    ihhrohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:fRrJaL--hL2bKnK703Xnc65KdklAvi4I-Rd6xIYOIJc4z7EEBNN-cg>
    <xmx:fRrJaH1SinkOximfCHoF0dxL24v8D0xDD2PYQCXs2CZSIMQovmJp3A>
    <xmx:fRrJaA93EOUNqqKGa6e3TAjXzOyoLelF3nXW-_a7ps9oEz4f5vka6A>
    <xmx:fRrJaPvr_HnT8XQMMHkt0Tc2cuzbjf7tY_RHTAIgns5F127rQn9fQw>
    <xmx:fhrJaAxiV6n-WpNd9aax_zaUInQ_-XuoZiAyIiBcjiYkWPh9EEgj8aZD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 04:06:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f760d555 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 16 Sep 2025 08:06:19 +0000 (UTC)
Date: Tue, 16 Sep 2025 10:06:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH] repo: add --all to git-repo-info
Message-ID: <aMkaePi90Q6sXuO4@pks.im>
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915223618.13093-1-lucasseikioshiro@gmail.com>

On Mon, Sep 15, 2025 at 07:36:17PM -0300, Lucas Seiki Oshiro wrote:
> Add a new flag `--all` to git-repo-info for requesting all the available
> keys. By using this flag, the user can retrieve all the values instead
> of searching what are the desired keys for what they wants.

One thing I wonder is whether we actually need the "--all" flag in the
first place. Right now, when saying `git repo info` without any further
arguments, then the user will be met with complete silence. I don't
really think that this is useful as a default in any way, as it makes it
very difficult for the user to figure out what kind of information
exists in the first place.

So how about we don't introduce a separate flag, but instead detect the
case where the user passed no arguments at all and then print all values
by default? It changes the current behaviour, but on the other hand I
would argue that the current behaviour is not useful in the first place.
And the command is labelled as experimental anyway, so for now we still
can change it.

> diff --git a/builtin/repo.c b/builtin/repo.c
> index bbb0966f2d..906d8a3e12 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -77,6 +77,24 @@ static get_value_fn *get_value_fn_for_key(const char *key)
>  	return found ? found->get_value : NULL;
>  }
>  
> +static void print_field(enum output_format format, const char *key,
> +			struct strbuf *valbuf, struct strbuf *quotbuf)
> +{
> +	strbuf_reset(quotbuf);
> +
> +	switch (format) {
> +	case FORMAT_KEYVALUE:
> +		quote_c_style(valbuf->buf, quotbuf, NULL, 0);
> +		printf("%s=%s\n", key, quotbuf->buf);
> +		break;
> +	case FORMAT_NUL_TERMINATED:
> +		printf("%s\n%s%c", key, valbuf->buf, '\0');
> +		break;
> +	default:
> +		BUG("not a valid output format: %d", format);
> +	}
> +}
> +
>  static int print_fields(int argc, const char **argv,
>  			struct repository *repo,
>  			enum output_format format)

Changes like this which are preparatory refactorings can also be split
out into separate commits. That makes it easier to see and review such a
change standalone.

> @@ -119,6 +124,26 @@ static int print_fields(int argc, const char **argv,
>  	return ret;
>  }
>  
> +static void print_all_fields(struct repository *repo,
> +			     enum output_format format)
> +{
> +	struct strbuf valbuf = STRBUF_INIT;
> +	struct strbuf quotbuf = STRBUF_INIT;
> +
> +	for (unsigned long i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
> +		struct field field = repo_info_fields[i];
> +		get_value_fn *get_value = field.get_value;
> +		const char *key = field.key;

Nit: I don't really feel like the `get_value` or `key` variables help
much. I'd just drop those.

> @@ -140,6 +165,7 @@ static int repo_info(int argc, const char **argv, const char *prefix,
>  		     struct repository *repo)
>  {
>  	enum output_format format = FORMAT_KEYVALUE;
> +	int all_keys = 0;
>  	struct option options[] = {
>  		OPT_CALLBACK_F(0, "format", &format, N_("format"),
>  			       N_("output format"),
> @@ -148,11 +174,17 @@ static int repo_info(int argc, const char **argv, const char *prefix,
>  			       N_("synonym for --format=nul"),
>  			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
>  			       parse_format_cb),
> +		OPT_BOOL(0, "all", &all_keys, N_("return all keys")),
>  		OPT_END()
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
>  
> +	if (all_keys) {
> +		print_all_fields(repo, format);
> +		return 0;
> +	}

Instead of checking for `all_keys` we could check for `if (!argc)` if
you want to follow my suggestion.

>  	return print_fields(argc, argv, repo, format);
>  }
>  
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> index 2beba67889..b1391a47b6 100755
> --- a/t/t1900-repo.sh
> +++ b/t/t1900-repo.sh
> @@ -110,4 +110,10 @@ test_expect_success 'git repo info uses the last requested format' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'git repo info --all returns all fields' '
> +	git repo info layout.bare layout.shallow object.format references.format >expect &&
> +	git repo info --all >actual &&
> +	test_cmp expect actual
> +'

This test will obviously need to be adapted every time we add a new
field, which I think is fine. But we should adapt it so that it's easily
extensible without by just adding another line. E.g. like this:

    test_expect_success 'git repo info --all returns all fields' '
            git repo info \
                layout.bare \
                layout.shallow \
                object.format \
                references.format \
                >expect &&
            git repo info --all >actual &&
            test_cmp expect actual
    '

This ensures that it's as simple as adding a new line when we add a
specific field without having to rewrite the whole line.

Patrick
