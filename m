Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838D358378
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788388231; cv=none; b=nsDXiMRAIoKo1AC8eUlQg4B58idG0gywgglQNcnezmlzcGUd+t8AS9yl5/eXmkpC6CqfQdexKtNMT7nifEkx6DIJNLdTb5W+HTd2OrRTHE0z3papQpbbHQuWZBWqJG7Pvn18Yt+zqquFf7HY8qkk7v03ptTbT3bq4CS1r/Mm3sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788388231; c=relaxed/simple;
	bh=5mRDkQRJjuzhHRUu9guUDtjBSOAH7EseCbmrLjUhps8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nr27RjfvHgKdPwF6yLvXIb9WVw5BV3YPnrUQtwyTFvPHPWBA2Dvgmu03UJtjX6OnbT1pS3B/lINXQ9ydvmGPzuHyACCP4+J8PnD7ccrkmgjok54aVK2hW+dAaUzukRqnsiFDaLQmT/ikwdLzZQT+ei5crE8LPk7dQY2DlJYPS58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IamSx4kG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pKMYmcAr; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IamSx4kG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pKMYmcAr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 05E801D000FA;
	Wed,  2 Sep 2026 18:30:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 02 Sep 2026 18:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788388224; x=1788474624; bh=Lz/iK8RL0R
	khOCirteZdMgcbuvQo+C8hRPXYh2rtW3I=; b=IamSx4kGQ+eI0Pdt2m2TXmDL+D
	HvAWuVCRPCQwx1EGfg+PozU5FIAdKPqt+kqvEg6wrFpyqThHjtm4CTe6adChpvs6
	95iTtqsE1Bi562PPpvo7B8t1ek0Y39HVbpAS6rq5M+tpDpYsuGv1rKkAwzr6FdG4
	LSmzPf4bQ/Fdn/vlBa0y6cOBljyJIW4PkEP5ROor8N067w0Or5qCsQ0OXuGz3EfL
	ptDLjLzX0YneyIwyXN1E8ZudHbgA5Zm9bcRasxZ0H6YbYPERQgFbtBjA3FuoZG5G
	+YL06UIy+d1McmMaejDoEeMfBH2lXcnecMvEX5BJDE4dJPM/ogT/r2ZicNqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788388224; x=1788474624; bh=Lz/iK8RL0RkhOCirteZdMgcbuvQo+C8hRPX
	Yh2rtW3I=; b=pKMYmcAr1u89e2B/ZQG0IeTY3nIIX0mN+5EuVyd0MVabhobndJS
	7IoWS5V92wY/JiKzVtsUjFZ33y2fwGJVfAhq1lrReMAtBpQL/wRvYxcC6JlPkGJT
	lRdgVRAv38O+1zlfT5PHYwnWSCNwDzSNCDxSWNpu8+dHXUQRz5yGCUbOSknrWD5B
	UEUZYlbQdOMNVhjIHVebcVIp21SSkrls+oZ4VIhDJTrtiGn5Q5Gm8Z6Zb8ys2SwJ
	J1l+guVRtmBKmL1DkpigEe05LxhSprYD6sKU7Z/c/bt7qYEpJRcrBEwaCxcoFgm3
	bv6EgVy4G0etLggCyjexUB9YDLAR8M/QH9g==
X-ME-Sender: <xms:gKOYajwi-MJmFap55AlEKJH3JnMpRGkPIKMBM-G1ZqZ9EBiLZvFlMQ>
    <xme:gKOYat1bbLxDW0GsBtUmXgA-JKVh5cYBWtU4W_rgCpB54gL0sqeIdAjY8oMhpckQG
    b_BYHFEjLAbk0KRHm167kB-GA3c7uLlpG-FoL9MdW5t1dY1fW0tMQ>
X-ME-Received: <xmr:gKOYag-AhXGbDb31OyNJ7vjbZ9VRa27k5076HQ8eSsayElJmlO4Ez22-V8Vt61ArnmVCXh2vltbYbJaZtbeniVCZ6FCKvqWyhA>
X-ME-Proxy-Cause: dmFkZTEFAeSDFDIhKlmru421sUKkBYwNbU3DEmIAq2OH/XDNdKVnpISi0qZoW4lJDSigGW
    aTzUNnxudjRZLwNeymPmxnSAhfHjh5RHEVuIuD1uJXxykxHwUhW5cQNPgDoqxP8q7PrcEf
    YW0UjHw4f2mvIYVCm7kDK4bX/iqGOrBVjEH16ng9yNw3uALcsnLK31Cw11JaD4BkB6K90m
    u/sZ79e+9LDY9Y4quKyKtdV9841LCIhZlsu03q+sEG2CbYYXG+4GFDYoswnxtkV5G3/jdu
    q62Y0LFOBT8L5jJGnqoxgvPWvjAjOXOpVu+mikGGWOgwd41hbgWo+rpXjzj0M/dKmQzTri
    SVlYBUhbe2dZT5+RsxA/qJJ5BNYr/+6gWFBQm22rJU5LwRBL34j1jYCo2vp6/5EOaLFy2d
    Kp6gG9LQsjbjyMZEbgIBM7Q6Jl0KOuOIG6tumfC8NuNik4NeeaEZFCBZ7LFihSSFgWxIS1
    wXfkCgvI9ba6aLMBE1X/2bWvCs+JhvXTQoqHGokQTjqFrceE/TZuAcQpGGhzrvmTJTMupn
    7pv4k5lVl5eKcNybWyNsnLTkn1wpyt6YHuNWbrQn8yxeY2jMbqZvGSlBzVXQE8IIpmYGHl
    /sPkRsiTQT18pHnYzzFg4fEtLAgYwUSz6MQSx9SDAsChH/sl1TbMBq+D3DZQ
X-ME-Proxy: <xmx:gKOYatq1RWRRIRgJIweDeFLYj6eGrvl6yeEEmk2TEWwcweviijx1BQ>
    <xmx:gKOYaqR5iIX8hNcBJZH9W1AQgljKVMiw1ngp1WZcDPCfCLPBbEg1bA>
    <xmx:gKOYagPZNuUX9j_OkptKlAtkx48rldeMGFM9mGlmZSSqDO0MMN019A>
    <xmx:gKOYaogUHlFV2cqf9X27XMZEfIDfvH-76pbBJP8whL1RN-xw3BbzCg>
    <xmx:gKOYak33L_uMQZGr75TDpvo2HqJpSGLwdqEArXndk5ixUmC9D_1m-3mT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 18:30:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 2/6] bisect: fix "--" detection when a term name is "--"
In-Reply-To: <20260902161047.476753-3-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 2 Sep 2026 18:10:43 +0200")
References: <20260902161047.476753-1-christian.couder@gmail.com>
	<20260902161047.476753-3-christian.couder@gmail.com>
Date: Wed, 02 Sep 2026 15:30:23 -0700
Message-ID: <xmqqse3rffr4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> `bisect_start()` walks its arguments twice. The second loop actually
> parses the options, and it knows that `--term-good`, `--term-old`,
> `--term-bad` and `--term-new` take their value as a separate argument,
> so it skips that value.
>
> The first loop, which only looks for the "--" separating revisions from
> paths, doesn't know about these options. So when such an option is given
> "--" as its value, that "--" is mistaken for the separator and
> `has_double_dash` is wrongly set.

It may be theoretically true, but I wonder how much practical value
it has to correctly parse "--term-good --" as "Ah, the user wants to
mark good revisions as '--' instead of 'good' or 'old'"?  Even
though "refs/bisect/--" is *not* forbidden, how likely is it for
users to do that?

This is not like "git grep -e --" which does have much more pracical
value.



>  builtin/bisect.c            | 27 +++++++++++++++++++++------
>  t/t6030-bisect-porcelain.sh |  8 ++++++++
>  2 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 1cfb8a794b..ad089b289f 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -803,6 +803,19 @@ static enum bisect_error bisect_auto_next(struct bisect_terms *terms,
>  	return bisect_next(terms, prefix);
>  }
>  
> +/*
> + * The options "git bisect start" accepts. Only the ones taking their
> + * value as a separate argument matter to the scan looking for "--" below,
> + * as their value has to be skipped along with them.
> + */
> +static const struct early_scan_option bisect_start_early_options[] = {
> +	EARLY_SCAN_SKIP_VALUE("term-good"),
> +	EARLY_SCAN_SKIP_VALUE("term-old"),
> +	EARLY_SCAN_SKIP_VALUE("term-bad"),
> +	EARLY_SCAN_SKIP_VALUE("term-new"),
> +	EARLY_SCAN_END()
> +};
> +
>  static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
>  				      const char **argv)
>  {
> @@ -825,13 +838,15 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
>  
>  	/*
>  	 * Check for one bad and then some good revisions
> +	 *
> +	 * The scan below has to know about the options taking their value
> +	 * as a separate argument, or such a value that happens to be "--"
> +	 * would be mistaken for the "--" separating revisions from paths.
>  	 */
> -	for (i = 0; i < argc; i++) {
> -		if (!strcmp(argv[i], "--")) {
> -			has_double_dash = 1;
> -			break;
> -		}
> -	}
> +	i = early_scan_options(argc, argv, bisect_start_early_options,
> +			       EARLY_SCAN_STOP_AT_DASHDASH, NULL, NULL);
> +	if (i < argc)
> +		has_double_dash = 1;
>  
>  	for (i = 0; i < argc; i++) {
>  		const char *arg = argv[i];
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index a7588222a8..464ca53b42 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -1297,6 +1297,14 @@ test_expect_success 'bisect start takes options and revs in any order' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'bisect start with "--" as a term name' '
> +	git bisect reset &&
> +	git bisect start --term-good -- hello &&
> +	git bisect terms --term-good >actual &&
> +	echo -- >expected &&
> +	test_cmp expected actual
> +'
> +
>  # Bisect is started with --term-new and --term-old arguments,
>  # then skip. The HEAD should be changed.
>  test_expect_success 'bisect skip works with --term*' '
