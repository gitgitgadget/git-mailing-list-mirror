Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5926B740
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367332; cv=none; b=dvkeNnCln5shOtw992aZvPFb1WhEH49AySg+R5eDthYel81mezGAeOSR7PidiAE3shbDA1UlCpgT4lbSTUfikF818gyApYxM+pirE3QeMCDR0I5WZUsEacqxN7l5661g6uSlIt70s8hmeOVbEljbfDXbPwPj3MzavtNsUqb6RA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367332; c=relaxed/simple;
	bh=jO9j9OGKirCox6Y6GbjGolgLkdxJuE1ohlhgVgoV7Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pu1EgG5xWzblMNxoIRws7zYrjqgPhrK73r2lpzFvgeLhPg6oO8raKlIhYSxxCVwWajDmHlVZn6MfIES4CFVEmdYa7Dikt4ks3wUdfmLthnKQ2PZrTBJQTJnBSebiouB//2gNS6pJZmCE0jKJ3wnCgU1BWwtC+O5JBn2YqeIJ6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XqK0R4Ru; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RbnZ0GU5; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XqK0R4Ru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RbnZ0GU5"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D417A7A0116;
	Tue,  1 Jul 2025 06:55:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 01 Jul 2025 06:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751367329;
	 x=1751453729; bh=LnjHv5OjCMqHm13hsKjEzXXo+KiakMTC3l43eXWG/bk=; b=
	XqK0R4RuE93Fsx5W03Vp91V2oceT0G1h+199GxmsmOtbHED31PERlxBgeANjm2Lt
	TeASnazhK956nRcxONr2OKaZv2eif6CZEgyUTCS5NZHjpQj6OtL1/ROT5K3EOSSY
	dZY14BnCJlX49eBMOjjK88wIUYeVjLdJJijBPGrIYdlGlg/f5zfWHSxG7Ebw6kFK
	+S9eYjVJq9NkRrPPD2OqvJDL93Z75s4oNCLa0YICaNdkWiKXhvinAfC6O4WaXQab
	Ypel6tOJHT+KoDSqqrujp1u4NgwmEdm7t7/hbxO2VLm7y7QyEPAq2dAUXwvfBCXH
	7PIv/f5GD7fTTf8WsYGO9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751367329; x=
	1751453729; bh=LnjHv5OjCMqHm13hsKjEzXXo+KiakMTC3l43eXWG/bk=; b=R
	bnZ0GU5fhMY7Rqlru6WvZShhJU/UPT73NYtYUbigqQNwpN6EYnKojrE79ywpwMF6
	uuN964SLE/iV13x0PHLqg+9NOFEn9mZERD2Va+Vug80Sn9SvnaNG3uYiRgiNKHLg
	UWDywt1CJMs8fTS+RuIEkkWJHM+74aO4dkYCBjci1y7C0slxkUefyO+IPGXlf+6F
	MqPRpmbyKFmNJ8vovjZtZPEU6MwDyVv1VfDHAfvJVLw/1VykF3i+CSEglSgRDML+
	L8BiCmCtekCdLCD1NZK6yWRJ8E4U8dG9oLm5LlkVEpMjVrVTW1AkwX4Z+iIDOJWN
	6ZSsSJns/kOZept4rtVew==
X-ME-Sender: <xms:ob5jaEH_VY_ANvaQgWuNove3wPjI3mfS1I1SgHiplYODxaLPdTI9TA>
    <xme:ob5jaNUw1EDTUUq9A6orU5LqFcy3dnfVi626cXzMt8nWgyAIM1ufFmvXwZacXFCKD
    mXTgUVZUyqfkkY_vQ>
X-ME-Received: <xmr:ob5jaOKA9O-_3naQ5jYYFPi56TgJdUYqLMT5jIXnIC96LBvhvNSzuXw3vfNNJlT-V3rPUz5OEcP6pfvFTBB9xVii578eYNY-_VUUSg-gCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ob5jaGFYIehV8NNRd9LFMMwOS0xCW6vXz0-K3R7xEv2Gy2Lor_DWVg>
    <xmx:ob5jaKWLSZ-uRugcVqPNa62gbgVFAZ8OsK2Sa7nBBa6eCLMz6HzMPg>
    <xmx:ob5jaJNPyThXDuQtHwVnRS_0B5Q9lHT9S1jLL1L_Z_codKjxK3IfTA>
    <xmx:ob5jaB2FVlMdslgwIkkk13PZvZEKqcykZsTKtIe1bLMQlNuvBDwU1A>
    <xmx:ob5jaAHOaBfSnu82H27zqLEQibNRz11XpMCI7j2lJKKZTLvJ04e1PwQX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 06:55:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8de881f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 10:55:28 +0000 (UTC)
Date: Tue, 1 Jul 2025 12:55:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] parse-options: add precision handling for
 OPTION_COUNTUP
Message-ID: <aGO-nSyCN7OD9Zae@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <7322758a-9310-4892-b476-50dc57d559b4@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7322758a-9310-4892-b476-50dc57d559b4@web.de>

On Sun, Jun 29, 2025 at 01:51:36PM +0200, René Scharfe wrote:
> diff --git a/parse-options.c b/parse-options.c
> index 0dc9b0324a..0dd08a3a77 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -166,10 +166,22 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
>  	}
>  
>  	case OPTION_COUNTUP:
> -		if (*(int *)opt->value < 0)
> -			*(int *)opt->value = 0;
> -		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
> -		return 0;
> +	{
> +		size_t bits = CHAR_BIT * opt->precision;
> +		intmax_t upper_bound = INTMAX_MAX >> (bitsizeof(intmax_t) - bits);
> +		intmax_t value = get_int_value(opt);
> +
> +		if (value < 0)
> +			value = 0;
> +		if (unset)
> +			value = 0;
> +		else if (value < upper_bound)
> +			value++;
> +		else
> +			return error(_("value for %s exceeds %"PRIdMAX),
> +				     optname(opt, flags), upper_bound);
> +		return set_int_value(opt, flags, value);
> +	}
>  
>  	case OPTION_SET_INT:
>  		return set_int_value(opt, flags, unset ? 0 : opt->defval);
> @@ -630,10 +642,10 @@ static void parse_options_check(const struct option *opts)
>  		case OPTION_BIT:
>  		case OPTION_NEGBIT:
>  		case OPTION_BITOP:
> +		case OPTION_COUNTUP:
>  			if (!signed_int_fits(opts->defval, opts->precision))
>  				optbug(opts, "has invalid defval");
>  			/* fallthru */
> -		case OPTION_COUNTUP:
>  		case OPTION_NUMBER:
>  			if ((opts->flags & PARSE_OPT_OPTARG) ||
>  			    !(opts->flags & PARSE_OPT_NOARG))
> diff --git a/parse-options.h b/parse-options.h
> index 8bdf469ae9..312045604d 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -183,6 +183,7 @@ struct option {
>  	.short_name = (s), \
>  	.long_name = (l), \
>  	.value = (v), \

It's a bit surprising that `COUNTUP` accepts a signed integer, so should
we maybe add `BARF_UNLESS_SIGNED(*(v))` here?

> +	.precision = sizeof(*v), \
>  	.help = (h), \
>  	.flags = PARSE_OPT_NOARG|(f), \
>  }

Patrick
