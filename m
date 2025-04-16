Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC6F215065
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824588; cv=none; b=mHGTHfjZLIBLrQJ6hf+9ffqbZMAdJDg4ronBovQVhnxpghnWFgCDZTHg2Ifh27Xv0hG2EmXTRptuS0TcY/8U7/mP7Ih6q643COZQ1ngXTk1/g98pmdZM25n9ryn6VM8JQ4MVDiI0fo/85NAht+JeAY0wKGexY+gpladyV5OfDJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824588; c=relaxed/simple;
	bh=+wObB47cM9Z4FTCoMtvkUgNXfK5tphUEDNL60u6aj6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GqZW+kwA+hdC67fBPiLQq0LeoodpRWqF+YSdXRwmhnl/DJXO1XsSLUZ2uYI5kt7oHzzK2CIbXG6Miw3XEIBYdbaySzf1jFkljyZMfIdD3QHS98PlsnqMr86L3TusJkQqJeZjw9l+Vou81DiPiWKmG+z6QirZexQUHong3SFQEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BJ+uikgx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXYUwar5; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BJ+uikgx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXYUwar5"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F25A1140255;
	Wed, 16 Apr 2025 13:29:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 16 Apr 2025 13:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744824585; x=1744910985; bh=zKlHlx3nmT
	uJ34HuBExnLptTvua8rtfweGvvAMAmu74=; b=BJ+uikgxq65tcXF4Ak34Zv7VM3
	iV01BjHk4wcMYkYUbEXcVApkRgpRhYs5OFydu6zmEfFjkPEc+PNUdsgmsRlPN4Xb
	XLGpWkmqr+ZnglKPYKM6zb7mnVOUv2G3YXNX0J+CHFvIdcdtZsefdK3nxc3Q+7+R
	kE1mIm45wRghEq1HK8wd1Z0G/X7eKn3v1HdiPjVrWaiwB32J/Unzl4D/0rK175oT
	IyY8vZktvC5wxKcFt9a8p4X+ECGzr0vTGNGTKhDwLZSGyzMinuJYZh9TA79H51b3
	AUvHuAHXVgD+lXxmZBOVT+M47mzQv9HxtSYczSWPTDudgFsDs2gFW6RzYpbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744824585; x=1744910985; bh=zKlHlx3nmTuJ34HuBExnLptTvua8rtfweGv
	vAMAmu74=; b=QXYUwar5GwdXdWbUCOTP/cUxNx+edHaZ2SErrL+n3vqWavD+/up
	OTnkJvrhIV8CVP7u05xS1ZWYbaRGXetr58i2OtYVwDx/XUGF2Eh7BPIxmFi+q4bb
	8Yzzz8j5f/hRis14MFyRXOvy82W1Spwk+qHUSEG2wsalEBbxAED30iatByCNEK15
	LqAufHWK6GJIpUslHQQNITOSZUiMfopkxrh8nMaeWo8z+CZ833mcoaAEOSkNJf02
	5X9kUdEinzMYiFU+NfhyBS4AFaLxC5J6B5ob7GjErOCLgo/WpQV9XVfFXicrU1v1
	1o8XcKGUHFnejnVyOjHrdb0A2TG8PaI/+sA==
X-ME-Sender: <xms:Cen_Z7jtlJW-wy8gGlyERRzHx9Uj7NZ3FBtgmQ6kHMbhhN7WFc5mcw>
    <xme:Cen_Z4CjknujsljOot-XfOnK54yU4JFqweYuVN2ZGa6g6q7F_rjqx7FAgpBJlm8S8
    elt3PvWbYhzt49MWw>
X-ME-Received: <xmr:Cen_Z7H1tA3NgvjKrkCQSGocraZc8TjG7IhRrZ5xtCnf0ourE-J34M2PPTHC9uU3ETG9El9c3OzbzlWmfm8KUQuOkPC0xuYrFrJi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeileejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtph
    htthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdr
    uggvpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:Cen_Z4QO2azPoXj3e2zTwjyTrUrJ1CP22zxYf7VysXyPJDc8kYrAOg>
    <xmx:Cen_Z4yKabEuSVTQRJbmrLdB38_JDAypmwx3K2TGFI5NbkH8Fg97tw>
    <xmx:Cen_Z-5hYP72HtRhNo0ZvuCfU1-KfpAXzeeTWzxKUy4RrwT_Bnr_Ew>
    <xmx:Cen_Z9wXCwVp1i7c-Lnoa8vkihnI5pHoltElgeSYebxpQPQckkpZOg>
    <xmx:Cen_Z4zEW1b8ZESSHB787C6WLSDLO7NHtPi5RMPHTOQAQChS35-ON9Cy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 13:29:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Todd Zullinger <tmz@pobox.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Derrick
 Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/7] parse-options: introduce precision handling for
 `OPTION_INTEGER`
In-Reply-To: <20250416-b4-pks-parse-options-integers-v3-3-d390746bea79@pks.im>
	(Patrick Steinhardt's message of "Wed, 16 Apr 2025 12:02:12 +0200")
References: <20250416-b4-pks-parse-options-integers-v3-0-d390746bea79@pks.im>
	<20250416-b4-pks-parse-options-integers-v3-3-d390746bea79@pks.im>
Date: Wed, 16 Apr 2025 10:29:43 -0700
Message-ID: <xmqq1ptshv5k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The `OPTION_INTEGER` option type accepts a signed integer. The type of
> the underlying integer is a simple `int`, which restricts the range of
> values accepted by such options. But there is a catch: because the
> caller provides a pointer to the value via the `.value` field, which is
> a simple void pointer. This has two consequences:
>
>   - There is no check whether the passed value is sufficiently long to
>     store the entire range of `int`. This can lead to integer wraparound
>     in the best case and out-of-bounds writes in the worst case.
>
>   - Even when a caller knows that they want to store a value larger than
>     `INT_MAX` they don't have a way to do so.
>
> Funny enough, even if the caller gets everything correct the parsing
> logic is still insufficient because we use `strtol()` to parse the
> argument, which returns a `long`. But as that value is implicitly cast
> when assigning it to the `int` field we may still get invalid results.
>
> In practice this doesn't tend to be a huge issue because users typically
> don't end up passing huge values to most commands. But the parsing logic
> is demonstrably broken, and it is too easy to get the calling convention
> wrong.
>
> Improve the situation by introducing a new `precision` field into the
> structure. This field gets assigned automatically by `OPT_INTEGER_F()`
> and tracks the size of the passed value. Like this it becomes possible
> for the caller to pass arbitrarily-sized integers and the underlying
> logic knows to handle it correctly by doing range checks. Furthermore,
> convert the code to use `strtoimax()` intstead of `strtol()` so that we
> can also parse values larger than `LONG_MAX`.
>
> Note that we do not yet assert signedness of the passed variable, which
> is another source of bugs. This will be handled in a subsequent commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> ...
> +	{
> +		intmax_t upper_bound = INTMAX_MAX >> (bitsizeof(intmax_t) - CHAR_BIT * opt->precision);
> +		intmax_t lower_bound = -upper_bound - 1;
> +		intmax_t value;
> +
>  		if (unset) {
> ...
> +		if (value < lower_bound || value > upper_bound)
>  			return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),

When I imagined the case where precision is set to the same size as
sizeof(intmax_t), this comparison made my head spin, but I think it
should safely yield false for any "value", in which case it is fine.

> +		switch (opt->precision) {
> +		case 1:
> +			*(int8_t *)opt->value = value;
> +			return 0;
> +		case 2:
> +			*(int16_t *)opt->value = value;
> +			return 0;
> +		case 4:
> +			*(int32_t *)opt->value = value;
> +			return 0;
> +		case 8:
> +			*(int64_t *)opt->value = value;
> +			return 0;
> +		default:

Good to have this "default" arm.  As you cannot take an address of a
bitfield, you cannot pass a bitfield member in a struct that is set
to say 24-bit wide with .precision set to 3.  IOW, limiting ourselves
only to sizes of naturally occurring integral types is sufficient.

> +			BUG("invalid precision for option %s",
> +			    optname(opt, flags));
> +		}
> +	}
>  	case OPTION_MAGNITUDE:
>  		if (unset) {
>  			*(unsigned long *)opt->value = 0;
> diff --git a/parse-options.h b/parse-options.h
> index 997ffbee805..8db96402c4d 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -92,6 +92,10 @@ typedef int parse_opt_subcommand_fn(int argc, const char **argv,
>   * `value`::
>   *   stores pointers to the values to be filled.
>   *
> + * `precision`::
> + *   precision of the integer pointed to by `value` in number of bytes. Should
> + *   typically be its `sizeof()`.
> + *

Nicer to see "bytes" in the description.  I am still puzzled, and
more importantly, I suspect readers will be puzzled, when told
"Should typically be", as it implies there may be valid cases when
it can be different from it, and wanting to know what these cases
are.

> @@ -214,6 +219,7 @@ struct option {
>  	.short_name = (s), \
>  	.long_name = (l), \
>  	.value = (v), \
> +	.precision = sizeof(*v), \
>  	.argh = N_("n"), \
>  	.help = (h), \
>  	.flags = (f), \

Nice.  By doing this in OPT_INTEGER_F(), we cover OPT_INTEGER() as
well automatically.

Thanks.
