Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF14415F29
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752441; cv=none; b=icZRLHZjk+tqW7hbX8gyhfpl5q7iqOueLx/TcdDXuEYbAKE0/g9JFTcy4S8JB1yEhn9zwQaVw7S5JetXAIiYEjRo0XC8scsYuE/776UHVNmE+uMPn9pxoE/zdgkoC8ZFnCmnmjX9aAhLvyEmCVp8o7JLOmBZYAYHCRY9ZA5h2S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752441; c=relaxed/simple;
	bh=WIYX8Bi4aB2wB+Yq6EBMoU/1M+THFqH7s11gPuakI0w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gGIkjvzwL3U3z/5DNKe+TlU0zdoT1nXG6/cXhTbKiDsoOgzEzJqsXuk250oyUFvY1R3lNVfScYonwUjhVhRJV/NhnQMN/JsFgGpzBMISsPg6jdMWEpjBaUelnltXyW/9trJ4JlCC+S8hCYia5/sypgCNW+xuMMSfTxcg/NMKkFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lte3cu/6; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lte3cu/6"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so2746426a91.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 00:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752439; x=1791357239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WpDBu6M3jshYV5ZqKPWIsboAOc4FV1LLCiLy3s+UDV4=;
        b=lte3cu/6rfRGrrz0bgHWagurJcSscnBiDCCsZTxKyqKF93gZlid25neYPxvJ4295UL
         nAWjlWHd1ESK5T1gcs/vBd4l8TQjAWh1aBL9+MxnxjUSAyQgq4drZiq+ccBbz+9i1/UJ
         GQAVSTaGLwElfFw3aEH4TEWbzKyEYsRvkwiuMbSXqFsquk1x4R4smOYt5ln3wNXWvH5b
         K9CitJj3pZYD4I2ybKHYKyvghk15cC0LMuiScfFEx3aeSuLRpZXLKWioTecCZgI6fhGq
         pdesjhPu6U+gthpHgCM0eMlZslWO6shooP1akA/cZWvieW7FBya6v6RNWuFBMNvuZccX
         07rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752439; x=1791357239;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WpDBu6M3jshYV5ZqKPWIsboAOc4FV1LLCiLy3s+UDV4=;
        b=JP4eDKHXDDKZmkPhrLRGqv+uJs1Lr8joekspc3hkG+VHRs6Bl1qs76nNjaeF3Q5q+F
         /nUVe14UxI2BJwwNdwS9QzRisJ6CjNlp+ZW+6lzh8nJJpcuSXE4GUrY5C5q4WEw9x4kv
         ddKlphAYy88h37q37kSlnwZZ1f/K4Ia0uTdOdelygo7Fenjh8GQefIIM2QiqsM13IqTA
         8S876C4lEcimThzBErUFQ0FlfYGfd4T9WTRDzWl5B7ZXcack0C8ueBt9lmaHZW8hAoOO
         yQ7otpJsf3TuSJUQbOrytMtuwdQfKGKQbNbdl0CTKyC2lX190QyibWkA6rMCbqrKvITr
         keYg==
X-Forwarded-Encrypted: i=1; AKwUvBxqAGbM96W2OXAv17+qh4oa0uIgyPb3Do6zOYszZXL8MwSAxsjHYbPeiI9o92IbFEmPx3E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLt8R3c93I/XZvJrEmE4IAa4EoEMYU4dBApvoc9galJttT5W+D8
	iThLlrAqU3yvToQAktUY36GLYw6oQwDyXNOiBZn165cgwWkg3gKnpSDW
X-Gm-Gg: AYBFou3pyBdb5qDsEUwMuy7GPBQvCfjzhwS1Hew49hhikh/UxPGSScDep1igEHGRd+x
	g2mfEGN4rd8/zVsnWd8U1+R1M+frjmQwQQPfkvypXmNot+kiuFhJyU+6topo31uxeXg9kXae20X
	B/jGtyhQgUAe1+YPSNoQlTF80QuIDmgNThbf/gohwqd3fS0xmb/sdeSAOQWm7rd7jsZZ6xPx35V
	eSnfLBfVaZP6MhLu2lJjEeDTpsMHMEwh8++Uca9h9GDKupsNJveal7RrMEVSFIt4McKzXHMIBDa
	B2jeIal0pGKOv2kjJ6MMfKJol7La+0ng7/hiQvIV4/gfGI0Kp7w+7rg5h3Lu1RWntnd1DMXDVoV
	rhCkstKdb7J2xeXcMQfp7IkkTrlN4WQjUMyQkkmH7gFGZzoOvn76tCvvUiSrm6v0Xz845ZUXHZ+
	A1Z+8M4RUJQPYEYPc79Hr06vQpoym3rzlX9U/6F+edc2qj8RSOKTHF4uDT1r65qo8iJDMHhd3XT
	UVEQ0kqDo8qH9Qdm7BCKJG+yrPYdv4HrAxRok2SLXZ2qRE1CY5AYl0=
X-Received: by 2002:a17:90b:2b43:b0:3a4:8d74:2ee1 with SMTP id 98e67ed59e1d1-3a4d197a2fdmr434231a91.22.1790752438587;
        Wed, 30 Sep 2026 00:13:58 -0700 (PDT)
Received: from ?IPV6:2401:4900:884c:d167:793:d042:ebbf:3c1d? ([2401:4900:884c:d167:793:d042:ebbf:3c1d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7da12684csm325329a12.8.2026.09.30.00.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 00:13:58 -0700 (PDT)
Message-ID: <84f9d1c9-30b7-4d8b-82d6-9afd16d0ab08@gmail.com>
Date: Wed, 30 Sep 2026 12:43:53 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 2/3] parse-options: add early_scan_options()
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Justin Tobler <jltobler@gmail.com>
References: <20260902161047.476753-1-christian.couder@gmail.com>
 <20260923080928.1534413-1-christian.couder@gmail.com>
 <20260923080928.1534413-3-christian.couder@gmail.com>
Content-Language: en-US
In-Reply-To: <20260923080928.1534413-3-christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/26 13:39, Christian Couder wrote:
>
 > [ snip ]
 >
> One consequence of staying simple is that abbreviated options are
> still not matched, even though the scan is now given the command's
> full option array. Resolving them the way parse_options() does would
> mean duplicating the ambiguity detection that parse_long_opt()
> performs. So the scan can fail to see an option that parse_options()
> would accept, and its callers have to cope with that, typically by
> erring on the safe side. This and the other differences with
> parse_options() are documented in "parse-options.h".
> 

I think not handling abbreviations could also have another potential 
problem. Consider a command as follows:

  $ git fast-import --quiet --export-pack --allow-unsafe-features

Here `--export-pack` is an abbreviation of `--export-pack-edges`. So, 
the arg next to it should ideally be considered as a value for it but
given the correct "ignore" logic, we will happily interpret is an 
argument which misaligns with parse_options()'s behaviour.

In the ideal world, we could say such weird names for files is unlikely 
and this isn't such a big concern. But given it is the scope of this 
series to make early scan more reliable, I think we should consider how 
to handle this better.

Would it make sense to actually err on the safe side and just stop 
walking the args as soon as we notice an unrecognized argument? This 
will the ensure the walk never misinterpret a value for an argument.

>   
> diff --git a/parse-options.c b/parse-options.c
> index a132c1ea12..559dad9061 100644
> --- a/parse-options.c
> +++ b/parse-options.c
>
 > [ snip ]
 >
> +int early_scan_options(int argc, const char **argv,
> +		       const struct option *option,
> +		       enum early_scan_flags flags,
> +		       early_scan_fn *fn, void *data)
> +{
> +	for (int i = 0; i < argc; i++) {
> +		const char *arg = argv[i];
> +		const char *value;
> +		const struct option *opt;
> +		int pos = i;
> +
> +		/*
> +		 * parse_options() always stops parsing options at these,
> +		 * whatever its flags, so nothing after them is an option.
> +		 */
> +		if (!strcmp(arg, "--") || !strcmp(arg, "--end-of-options"))
> +			return i;
> +
> +		opt = find_early_scan_option(arg, option, &value);
> +		if (!opt) {
> +			if ((flags & EARLY_SCAN_STOP_AT_NON_OPTION) &&
> +			    (*arg != '-' || !arg[1]))
> +				return i;
> +			continue;
> +		}
> +
> +		/*
> +		 * When an option takes a value, but that value is not
> +		 * stuck to it with '=', then the next argument is the
> +		 * value and it has to be skipped so that it isn't
> +		 * taken for an option itself.
> +		 */
> +		if (parse_options_takes_argument(opt) && !value && i + 1 < argc)
> +			value = argv[++i];
> +

The 'i +1 < argc' part is an appropriate guard to have. But this means a 
command such as the following:

   test-tool early-scan-options --wanted-value

... would reult in 'value' being NULL. I suppose this is kind of 
expected for the early scan code and is not something we need to worry 
about?

> +		if (opt->flags & PARSE_OPT_EARLY && fn(opt, value, pos, data))
> +			return i;
> +	}
> +
> +	return argc;
> +}
> +
>   static int usage_argh(const struct option *opts, FILE *outfile)
>   {
>   	const char *s;
> diff --git a/parse-options.h b/parse-options.h
> index f29e73f85c..3ef64744a4 100644
> --- a/parse-options.h
> +++ b/parse-options.h
 >
> [ snip ]
>
> +/*
> + * Scan `argv` for the options described by `option`, calling `fn` for
> + * each of those that have PARSE_OPT_EARLY set. `argv` is not
> + * modified.
> + *
> + * `fn` may be NULL when no option has PARSE_OPT_EARLY set, which is
> + * useful to only find out where the scan stops.
> + *
> + * The scan always stops at "--" and at "--end-of-options", as
> + * parse_options() always stops parsing options there too, whatever its
> + * flags. PARSE_OPT_KEEP_DASHDASH and PARSE_OPT_KEEP_UNKNOWN_OPT only
> + * decide if the terminator is left in argv, not if it terminates.
> + *
> + * Returns the index at which the scan stopped, which is `argc` when the
> + * whole array was scanned.
> + *

As for the return index, when the callback stops the scan the index 
returned is that of the option's value rather than the option itself. 
Would it be better to capture this more clearly?

Also, would it be helpful to also have a test for this?

> + * This scan is for now deliberately much simpler than
> + * parse_options(), so it differs from it in the following ways:
> + *
> + *  - Only the long form of an option is matched, and it has to be
> + *    spelled in full: short options and abbreviations are ignored.
> + *
> + *  - Negated forms ("--no-<name>") are not matched. This is harmless,
> + *    as they never take a value to skip.
> + *
> + *  - Options with PARSE_OPT_OPTARG or PARSE_OPT_LASTARG_DEFAULT are
> + *    treated as not taking a separate value.
> + *
> + *  - OPTION_SUBCOMMAND entries are skipped.
> + *
> + *  - OPTION_ALIAS entries are not resolved to the option they stand
> + *    for.
> + *
> + * So the scan can fail to see an option that parse_options() would
> + * accept, and callers have to cope with that, typically by erring on
> + * the safe side.
> + */
> +int early_scan_options(int argc, const char **argv,
> +		       const struct option *option,
> +		       enum early_scan_flags flags,
> +		       early_scan_fn *fn, void *data);
 >
> [ snip ]>
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index 449fff4d34..b796d96b9a 100755
>
 > [ snip ]> +
> +test_expect_success 'early_scan_options() takes values from struct option' '
> +	test-tool early-scan-options --number --wanted >actual &&
> +	cat >expect <<-\EOF &&
> +	stopped at: 2 of 2
> +	EOF
> +	test_cmp expect actual &&
> +	test-tool early-scan-options --number=5 --wanted >actual &&
> +	cat >expect <<-\EOF &&
> +	found: wanted at 1
> +	stopped at: 2 of 2
> +	EOF
> +	test_cmp expect actual
> +'

Compared to others, I'm not quite sure this test is testing something 
special. Do we need it?

> +test_expect_success 'early_scan_options() does not skip an optional value' '
> +	test-tool early-scan-options --optarg --wanted >actual &&
> +	cat >expect <<-\EOF &&
> +	found: wanted at 1
> +	stopped at: 2 of 2
> +	EOF
> +	test_cmp expect actual &&
> +	test-tool early-scan-options --lastarg --wanted >actual &&
> +	cat >expect <<-\EOF &&
> +	found: wanted at 1
> +	stopped at: 2 of 2
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'early_scan_options() matches a stuck optional value' '
> +	test-tool early-scan-options --early-optarg=one >actual &&
> +	cat >expect <<-\EOF &&
> +	found: early-optarg at 0 value: one
> +	stopped at: 1 of 1
> +	EOF
> +	test_cmp expect actual &&
> +	test-tool early-scan-options --early-lastarg=two >actual &&
> +	cat >expect <<-\EOF &&
> +	found: early-lastarg at 0 value: two
> +	stopped at: 1 of 1
> +	EOF
> +	test_cmp expect actual
> +'

Would the following be a useful part to also add to the above?

          test-tool early-scan-options --optarg=5 --wanted >actual &&
          cat >expect <<-\EOF &&
          found: wanted at 1
          stopped at: 2 of 2
          EOF
          test_cmp expect actual

-- 
Sivaraam

