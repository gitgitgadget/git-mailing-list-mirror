Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B869E275B18
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716400; cv=none; b=SrVRWT2gFnPKiAgHP4ZxjSXHgMZzxScx81LC9FUKW4KaP31KVtfmOq4Ixr85B88ioD5s8z+nsWy2NKZF1poDTzFxFNJm8drbUj6bSmpM4AA9twnaq9jdZy8jucIFSQcAdX+dylmTpxOf2m9V0R1JiS4E+w/RMU+oNgZqCL+TpiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716400; c=relaxed/simple;
	bh=owea9jCcF15gjt0GIPV1dUepYHX4lvXLK0UvwzaqtF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p935WM+wLYh5aT+m8yhUfEH0IsHaqtkxuHxmqtm+tDC2b5jazRzB9Pg7o97Tq7BWz0r9dXEQ8z1GEEfvATG5EmJDjbdhUVhSVgKQH4buMTNGYWFtpltdG9LRvouJyvkh7BPtIBrpN4aghyYpc1ZBUHKQyBqybZRyGbChXSECgdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C/eyfaLH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XMwYT9c3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C/eyfaLH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XMwYT9c3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA5D2140022A;
	Mon, 28 Jul 2025 11:26:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 28 Jul 2025 11:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753716397; x=1753802797; bh=bFRl8P5At6
	0PzP3nQfZLDDYcvzEm7qIVjsEy0uFLTgI=; b=C/eyfaLH6wPHd0bt0gStyon4Sl
	VkBomnInq23cRn+reaqj2FMyXN/qVijaShkdcfoeO7qeamKV3s8nnFFGJ92SoZCA
	siHL1R+UFwskO1PKf8MrvSRe9otGRqCm2xgbWu7IEE7mre2Z2b1AHyXu881bZEES
	9PV5CNwlvUAi4r6D3ZJ6KPlXfZGLpe/TRBYLB+JC/nMU/K7nYZQPw66AOOuORggU
	/y9W5flwDHlHD2OqPtwRa+Q7SNew3rQjIi1FwFkWWKtv6oyuS1Cd4yhoEpy4HVnH
	xLbTlMU+yHmkGy8VvlOHgBTmnNsOwRPj6tZAQKpcM8+frIjl1ykoeYUevHpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753716397; x=1753802797; bh=bFRl8P5At60PzP3nQfZLDDYcvzEm7qIVjsE
	y0uFLTgI=; b=XMwYT9c3zeu4U8gMnedmxZIBjSFjxoSjWM7hYPDdLU2Pze+OwEM
	WhDZMz3DcQrSDL4U8eUxyuVoLaowpztAoUR64n1/KrfN4vaTARVDyGz5/rF1aKFu
	4w4Td8athfRO9aLGd7Qfjh1DtxjrVo9WUFW7eprtH7Hcu6ftYTM/hLcFMPKmyQx+
	ZHqQXw0UfW5fCvITzOnCQzjXRmMtseViG+D4Z/eJfWVdR+vhDZEcbRPbqqPF5R2Q
	/r6RmUkDk0o1t6YXSofvG4m5IXXhH3pO0p7Ql5zeOSciK52TdbZfh9Q2FWm+QG+c
	gP9SisrG68nIaO1Bx4u5R9k4M/cff6cN8SA==
X-ME-Sender: <xms:rZaHaItVFKSnnlSydEep95AIn-rRRNNWqGA5LWFtjTWAjM06h288zw>
    <xme:rZaHaN6oatCMV4oduq8YZ6k1opIol_JUddYQzPraHTStYawg-2WrVz5M-aXprLFLB
    QQSA85VwBsJOlPJXw>
X-ME-Received: <xmr:rZaHaEPKtqWx76som0j_0XOfNQj9XRBEgUkGnbbSe4gSxW0a1gk3AzQeRNd8Ha7e6xXBuki_-0HxqM3vTp_t75PscI6d6r1EOS3LIGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopegrjhhrhhhunhhtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rZaHaLsfxr4yFZPr3u-Dm2h71sBY1PCYqG5Gace_57MwfqHI29A0wg>
    <xmx:rZaHaHajcTQosAtDYEoXDC5M6LVRiWXBnTMB0Q6G6skfYEFUkEbvXQ>
    <xmx:rZaHaNwTD4BDWChPiVNoXGhSCkni-2jF2aMnakUXIM-9ZzfWahsqfA>
    <xmx:rZaHaPgg4ScWXGZ1IrBEGSW5fYgR2COOsFWOZ0Puc4XRPkJzlt_xpA>
    <xmx:rZaHaNJf1XuPwqyTP_kPMTWCwPLg9qtwu6fP8RAF-HcYC2XAYlh0AH-Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 11:26:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Andrzej Hunt
 <ajrhunt@google.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 2/4] parse-options: name flags passed to
 usage_with_options_internal
In-Reply-To: <20250726165320.4039-3-ben.knoble+github@gmail.com> (D. Ben
	Knoble's message of "Sat, 26 Jul 2025 12:53:12 -0400")
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
	<20250726165320.4039-3-ben.knoble+github@gmail.com>
Date: Mon, 28 Jul 2025 08:26:36 -0700
Message-ID: <xmqqjz3sxro3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> When reading or editing calls to usage_with_options_internal, it is
> difficult to tell what trailing "0, 0", "0, 1", "1, 0" arguments mean
> (NB there is never a "1, 1" case).
>
> Give the flags readable names to improve call-sites.

It is a good idea to explicitly say that this step introduces no
change in behaviour, and only changes the way how these 0/1 are
spelled.

> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>  parse-options.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 5224203ffe..c3222cc9bb 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -953,10 +953,21 @@ static void free_preprocessed_options(struct option *options)
>  	free(options);
>  }
>  
> +enum usage_style {
> +	style_normal = 0,
> +	style_full = 1,
> +};
> +
> +enum usage_output {
> +	to_out = 0,
> +	to_err = 1,
> +};

These are very much internal implementation detail, so I am not sure
if this churn is a good thing, though.

For example, it ought to be sufficient, for the purpose of improved
readability, to instead doing this

>  static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *,
>  							 const char * const *,
>  							 const struct option *,
> -							 int, int);
> +							 enum usage_style,
> +							 enum usage_output);

just do

		int full_usage,
		int usage_to_stderr);

here.  Dropping the parameter names in the function prototype is
allowed, and we encourage to do so in our codebase but _only_ when
the meaning of each parameter is obvious from their type.  The first
3 parameters we see above are of distinct types and except for the
second one being the usage string given to the users, they should be
obvious.  But the last two unnamed integers are not obvious and they
should have been spelled out---otherwise a developer who is adding
a new callsite cannot work from the prototype alone and has to go to
the implementation to figure out what to pass.

Adding two enums for this is a bit overkill, but is OK here locally.


> @@ -1088,7 +1099,7 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
>  		}
>  
>  		if (internal_help && !strcmp(arg + 2, "help-all"))
> -			return usage_with_options_internal(ctx, usagestr, options, 1, 0);
> +			return usage_with_options_internal(ctx, usagestr, options, style_full, to_out);

But this is not an improvement as-is.  Wrap long lines or the result
is even harder to read.

> @@ -1278,10 +1289,11 @@ static const struct option *find_option_by_long_name(const struct option *opts,
>  static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *ctx,
>  							 const char * const *usagestr,
>  							 const struct option *opts,
> -							 int full, int err)
> +							 enum usage_style help_style,
> +							 enum usage_output to_where)
>  {
>  	const struct option *all_opts = opts;

> -	FILE *outfile = err ? stderr : stdout;
> +	FILE *outfile = to_where == to_err ? stderr : stdout;

This one ...


> @@ -1327,7 +1339,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
> -	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
> +	if (to_where != to_err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
>  		fprintf(outfile, "cat <<\\EOF\n");

... and this one become markedly harder to read.  I think the
primary reason is because unlike the original, the parameter names
are not biased.  "If we are doing full usage, do this" is far easier
to grok than "If the "style" we are told to use is the "style_full",
then do this", but use of "enum" inherently is about not making the
variables and parameters of that enum type unbiased.

> @@ -1373,7 +1385,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
>  				fprintf(outfile, "%s\n", _(opts->help));
>  			continue;
>  		}
> -		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
> +		if (help_style != style_full && (opts->flags & PARSE_OPT_HIDDEN))
>  			continue;

Ditto.

>  		if (need_newline) {
> @@ -1435,7 +1447,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
>  	}
>  	fputc('\n', outfile);
>  
> -	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
> +	if (to_where != to_err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
>  		fputs("EOF\n", outfile);

Ditto.

One way to reduce this churn is to do

	int err = (to_where == to_stderr);
	int full = (help_style == style_full);

at the very beginning of the function.  Then you do not have to
change the body of the function harder to read at all.

Thanks.
