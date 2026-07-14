Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426EE39CCE0
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049258; cv=none; b=QuSb6R/qSvm/6dgZa8FG0fDRVma3A+ch06Yjb3Sz+F7ErAKzsetaepgkI0qqUA1oNEJCxJbLhe7llJ4oWMjxlTE6KAwg9jvqg3JzOjCkrA7mjt2g0+/yWFL8jcHG6mkzBT51XSA39gagXqyKS9cKZd1qyGmY0mbt7yOfhE6MU9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049258; c=relaxed/simple;
	bh=VWb2lsXjHWDWzBBPQSqIcqvFzduIUvvGnotFyq4ykdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QAPejbLfYsqMmIInTO7U+MRLk1quzFAavHiHaCYe1U+20A9YyJtxE3HRHAwJxaYJ0kuaOSWtA6EXNQ8AKUjnI1qv1wDu10WwQvLYFsID2npSLgxgQlxJrFcxk05zIH7OlPlCVoFYAw2cflcPUlfKDaw95YPpHaddaOp+g+zq6g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WYu/lSX7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bejiOaFJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WYu/lSX7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bejiOaFJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E257EC01CD;
	Tue, 14 Jul 2026 13:14:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 14 Jul 2026 13:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784049256; x=1784135656; bh=4ivqfi2fLQ
	SnPWkqw/uEYGYQMqedOCQtYljoKqtKMbM=; b=WYu/lSX7uPWjeQ8bBu42fswR/V
	sGyGOA4edXW919gyz/X4SPCGkvLN2/hbQ2yOdDbb4xYEPfYE6Q4udch2CmT/YTRT
	X3Reoc/Y6JxS2M2AspqanVNonQjye7lqMyCETRL+W11jJoP0vFRmxYDja1wIknPG
	VEMZLxAIOdoE8wPqDjKgPq9OZ+wUb54AYFQFMYmGVjsiAKdrVz+POj3ESQPIsMqh
	i2lzDc+POhaFLeRqLZVkZGuK09mBqTRh8bYbtvUMoUwgpnDXsQjEYk2QIUVmSwbu
	RCDtZfI4jJMh0ImVOuA7HOwVcCdAYs7BhQRYgbXjqqVzLQygEu4PVLS5ziug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784049256; x=1784135656; bh=4ivqfi2fLQSnPWkqw/uEYGYQMqedOCQtYlj
	oKqtKMbM=; b=bejiOaFJ07GVaBlDuW4o4YAuHCynvznDKk84coJ32gu1Q1mxOFa
	h1hbKV+gvRk1hIfBsP+hBrf3aH6BUtjR6vz/MYv0jJG3Fro17E6cxlN26u2p9Iuj
	RV0LNe3ijDe6DyH1f525d9fUvnmJ1rrsb8kxo3BtcvSw6ywCs6GwItDgfUJNw8Ul
	HBjfnwtyyNprBuukjOwK2m6yFbEbVC0Aj8AU7xN9yLrL+yMxdmnKymZAtbtWGNXk
	MfkOM5ZdFlYIwl00hqEVZl4xIJYvQZ7vFQ4FvBwn/IyEAGYZhluKT9vz4iSXEhIS
	bYSbocZmoCuJx42Yz89SLE2sZPI0qeOWArA==
X-ME-Sender: <xms:Z25Waj5lvM1M9D8XdwDqw07afNPLlyBC0ed4lC9PNvYp0FECnYZA3Q>
    <xme:Z25WaskQxuwHYosv9VjwjeE13fxjn-btO3Ew3W98OAeJfPmO0l6tGLVk75HGu6qqq
    ontIUlgALXhFyW-G3tvpVBkg--FmJuuGqtef0JYgihyG-eoxhyu9w>
X-ME-Received: <xmr:Z25WakQWedN61BG0s9SHJb_saqLCmsFMoV17TFATHPlimmHeRBIFlDo9mXEFuF2Spmo8oqQep98TUV_F-_-5t_UOjIL-duH1zrv5gqs>
X-ME-Proxy-Cause: dmFkZTFyviTLrc/AyuKroyet2L4nxmO4Fvuwjn/+XGxHu5LpB0dVpAzVBc12ws1AZC6Oqs
    7Geqhk897NnfQPF2D85OHwDiZI8Ab5Iq/SaXwXnRMBDDf9TJ3YtgsuVa/LrEOMXwAYCPEa
    1mtcBt2Fet1/pd331KmBjAM8QF4tMMbbSpctD6s67QJvHazsN8tnnjaJYvTZwHt0qqG0nP
    CoXHUgElKHZlM9dinQVNCtjUcpn6MNIW52Lj2pPDalZTGikwaeSPsaeO5rSaUw6nNqz02U
    5DN/DIU1atqV8D38VA4KS38yXiXi04A72T1cEJjgSOaUZOrLG2eOtEBeNhMiSthF6auSXS
    /RyL+jVughVIYHYVU2+JQAMOXb9VCkeoLRRs+IQ9LgDPPw5HYpHuKUV2zcmSjOw2jVvFiN
    eV3oCtN4yoiOqkB3AYbunM/+U7dArUNfajJhSzBgyMru5ytzJtpR0K80QopOTru7ZEH1fm
    0LLgWGdQK3BNkkkxIf2agvmEMcL1PK88RaSpRG9X66aUX8BPh88kXEJXCjTdPzNC1cjROJ
    M8VZE6B8u9d+5GU4Y3FC9F8IwZVCgr04m1YxM6CCK/VNn1+GECtSRrCaUlqVozEO5zpQhp
    nHeC78mw4mZB58ycZ8uUW9y6spldmaDYeFR0O4Tw5+kG4PfsjUAqUe4zSlvg
X-ME-Proxy: <xmx:Z25WarECLTegQnJa_8DJLi0--comTZk5UEwNEdVoFdCniQq6sK9VUA>
    <xmx:Z25WapH6Nk5F_sWW57ItkbKG0MBtmVXDFUXKyRoVzOJikgX8YArWwA>
    <xmx:Z25WapQUY_0nUBhHEUhCKQWDtFKjWj0EgQ0a7WomUbi_FVrl8h-vZQ>
    <xmx:Z25WaqIxJUbWK2mAwGEPti4YXp-zDshaV2uaeFQiyY5DeXZbw0Qhdw>
    <xmx:aG5WavcdXDhbPji26WIonnFAe1vUVQw1i6DWTi5TRi-iczNwuiVO4-0Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 13:14:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  Glen
 Choo <glencbz@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 2/2] fetch: add fetch.submoduleErrors to make
 submodule fetch errors non-fatal
In-Reply-To: <20260714132959.3368867-3-paulius.zaleckas@gmail.com> (Paulius
	Zaleckas's message of "Tue, 14 Jul 2026 16:29:57 +0300")
References: <20260710122655.3066377-1-paulius.zaleckas@gmail.com>
	<20260714132959.3368867-1-paulius.zaleckas@gmail.com>
	<20260714132959.3368867-3-paulius.zaleckas@gmail.com>
Date: Tue, 14 Jul 2026 10:14:14 -0700
Message-ID: <xmqq1pd5trx5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paulius Zaleckas <paulius.zaleckas@gmail.com> writes:

> +	if (!strcmp(k, "fetch.submoduleerrors")) {
> +		if (!v)
> +			return config_error_nonbool(k);
> +		else if (!strcasecmp(v, "fail"))
> +			fetch_config->submodule_errors = SUBMODULE_ERRORS_FAIL;
> +		else if (!strcasecmp(v, "warn"))
> +			fetch_config->submodule_errors = SUBMODULE_ERRORS_WARN;
> +		else
> +			die(_("invalid value for '%s': '%s'"),
> +			    "fetch.submoduleErrors", v);
> +		return 0;
> +	}

Two points.

 * Do not use strcasecmp() on the value.

   While "fetch.submoduleerrors" may be case-insenstive, the value
   does not have to be.  We do not want to encourage users to write
   "[fetch] submoduleErrors = Fail", as some people may want to
   write third-party add-on scripts that parse "git config --get
   fetch.submoduleerrors" output.  For example:

	error_handling=$(git config --get fetch.submoduleErrors)
	case "$error_handling" in
	fail)
		... do something ... ;;
	warn)
		... do something else ... ;;
	esac

   We should not force them to write extra code to handle the value
   case-insensitively.

 * Since you need to convert between the enum and the string here,
   in option_parse_submodule_errors(), and in add_options_to_argv(),
   defining a pair of parse/format functions would be cleaner.

	/* really private - use accessors to parse and format */
	static const char *submodule_errors_[] = {
        	[SUBMODULE_ERRORS_FAIL] = "fail",
        	[SUBMODULE_ERRORS_WARN] = "warn",
	};

	static const char *submodule_error(int num)
	{
		assert(0 <= num && num < ARRAY_SIZE(submodule_errors_));
		return submodule_errors[num];
	}

	static int parse_submodule_error(const char *name)
	{
		for (int num = 0; num <	ARRAY_SIZE(submodule_errors_); num++)
			if (!strcmp(submodule_errors_[num], name))
				return num;
		return -1;
	}

The configuration parsing block would then become:

	if (!strcmp(k, "fetch.submoduleerrors")) {
		int num;

		if (!v)
			return config_error_nonbool(k);
		num = parse_submodule_error(v);
		if (num < 0)
			die(_("invalid value..."), ...);
		fetch_config->submodule_errors = num;
		return 0;
	}

This approach is much more maintainable.  You only need to keep the
submodule_errors_[] array up to date with respect to the error-handling
preprocessor macros.  Some reviewers might suggest converting these macros
into a proper enum.  I would not object to that change, but I would not
bother doing it myself as I do not personally care much about the
distinction between an enum and a preprocessor macro in this context.

> @@ -2205,6 +2219,10 @@ static void add_options_to_argv(struct strvec *argv,
>  		strvec_push(argv, "--no-recurse-submodules");
>  	else if (config->recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
>  		strvec_push(argv, "--recurse-submodules=on-demand");
> +	if (config->submodule_errors == SUBMODULE_ERRORS_FAIL)
> +		strvec_push(argv, "--submodule-errors=fail");
> +	else if (config->submodule_errors == SUBMODULE_ERRORS_WARN)
> +		strvec_push(argv, "--submodule-errors=warn");

This part then becomes:

	if (config->submodule_errors < 0)
		; /* nothing */
	else {
		const char *name = submodule_error(config->submodule_errors);
		strvec_push(argv, "--submodule-errors=%s", name);
	}

This is, again, much more miantainable.

> +static int option_parse_submodule_errors(const struct option *opt,
> +					  const char *arg, int unset)
> +{
> +	int *v = opt->value;
> +	if (unset || !strcasecmp(arg, "fail"))
> +		*v = SUBMODULE_ERRORS_FAIL;
> +	else if (!strcasecmp(arg, "warn"))
> +		*v = SUBMODULE_ERRORS_WARN;
> +	else
> +		die(_("invalid value for '%s': '%s'"), "--submodule-errors", arg);
> +	return 0;
> +}

Updating this function is left as an exercise ;-)
