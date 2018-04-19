Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493251F404
	for <e@80x24.org>; Thu, 19 Apr 2018 02:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeDSCry (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 22:47:54 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44829 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753251AbeDSCrx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 22:47:53 -0400
Received: by mail-wr0-f195.google.com with SMTP id o15-v6so9784787wro.11
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 19:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=x4Ft/n8MSs9UcGCApylO3ZBPT1MeMhOkyMnUV6MgzGc=;
        b=kBnrGFWA+RdeqV14uhtnpr9+5itfMF63weNdT50mK5ZZnioSWGU3qr8Ap2iOywW0Ng
         SOdZlnt7NAmK4cSMC5MfXMrWrJTBisb+twOQqgv2fLaBA/a11AJdGMbObsi8PrjF10ZX
         Re6Qn0OA6MkDF2peU1zoIwFpxDPN4dAC0dmWCXes7vS46XfzepT3p2t4V64/IMm1qH9+
         vnSoMbRaeGTXdnDxsEJQkUJB0P4OdcWe9CjfdTf8QyN7HxkcUV0pJLcA7yxGojT/5nf7
         a55Prj9Qyncf2pg2UHMTlzHcu7JjXbKmgvM7M7/vVKJrEUdKHGzOd7nlv/mMHTuUndiu
         DoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=x4Ft/n8MSs9UcGCApylO3ZBPT1MeMhOkyMnUV6MgzGc=;
        b=a3YN9nDsOShgeup6eLRB9XN5VF6wbqhBVWHN9l5hr9Momm0/6/EMWzlAUPrFKcr3eU
         fhSlqAMmsE+22Epl5ka2/zWDE2o6+peq3BW1zYKCSxM2ctYngWTzbaItRI4TaEQrsA3j
         cS2XBiS9D3X1Q0jAFmf+gGz9AuJ0/yxhl7Z3VtLJKeT/b8MmF+8vF23Yv/Sa/ZbDbAgH
         vydILEkgfrUuC2q7gEDXJUcW+yfZhbbkpo9ThaWS7vlOhFpYNQRWiZdBdWcoVMEbCN6/
         MIdJsNeqH+hPqLamnC3uHaIXPi0S68iZLGm3OMPHOJsoEwnyrp89DbHdnNsii8gcYbjQ
         EBWA==
X-Gm-Message-State: ALQs6tCJA9BUQQNPwnZB0vaA8F7sUuGqPBtJdhZpu3EnHLJ/wFWqihb6
        leZHh7XESOqqxQWOjwRIIlU=
X-Google-Smtp-Source: AIpwx4+EZRVzVsiIpFyStmKhyGXicCyGuKDZ1R84xHny88B8rAVsARp9R6dGIPNoaNgAXjDtqx1pbQ==
X-Received: by 10.28.21.84 with SMTP id 81mr3283604wmv.36.1524106071862;
        Wed, 18 Apr 2018 19:47:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v75-v6sm4999539wrc.65.2018.04.18.19.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 19:47:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net
Subject: Re: [PATCH v9 2/2] builtin/config.c: support `--type=<type>` as preferred alias for `--type`
References: <20180328234719.595-1-me@ttaylorr.com>
        <cover.1524087557.git.me@ttaylorr.com>
        <20180418214335.GC36803@syl.local>
Date:   Thu, 19 Apr 2018 11:47:50 +0900
In-Reply-To: <20180418214335.GC36803@syl.local> (Taylor Blau's message of
        "Wed, 18 Apr 2018 14:43:35 -0700")
Message-ID: <xmqq8t9jgbe1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/builtin/config.c b/builtin/config.c
> index 92fb8d56b1..bd7a8d0ce7 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -61,6 +61,58 @@ static int show_origin;
>  #define TYPE_PATH		4
>  #define TYPE_EXPIRY_DATE	5
>  
> +#define OPT_CALLBACK_VALUE(s, l, v, h, i) \
> +	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
> +	PARSE_OPT_NONEG, option_parse_type, (i) }
> +
> +static struct option builtin_config_options[];
> +
> +static int option_parse_type(const struct option *opt, const char *arg,
> +			     int unset)
> +{

Declare all local variables here.  We do not accept decl-after-statement.

> +	if (unset) {
> +		*((int *) opt->value) = 0;
> +		return 0;
> +	}
> +
> +	/*
> +	 * To support '--<type>' style flags, begin with new_type equal to
> +	 * opt->defval.
> +	 */
> +	int new_type = opt->defval;

Like this one and ...

> +	if (!new_type) {
> +		if (!strcmp(arg, "bool"))
> +			new_type = TYPE_BOOL;
> +		else if (!strcmp(arg, "int"))
> +			new_type = TYPE_INT;
> +		else if (!strcmp(arg, "bool-or-int"))
> +			new_type = TYPE_BOOL_OR_INT;
> +		else if (!strcmp(arg, "path"))
> +			new_type = TYPE_PATH;
> +		else if (!strcmp(arg, "expiry-date"))
> +			new_type = TYPE_EXPIRY_DATE;
> +		else
> +			die(_("unrecognized --type argument, %s"), arg);
> +	}
> +
> +	int *to_type = opt->value;

... this one.

> +	if (*to_type && *to_type != new_type) {
> +		/*
> +		 * Complain when there is a new type not equal to the old type.
> +		 * This allows for combinations like '--int --type=int' and
> +		 * '--type=int --type=int', but disallows ones like '--type=bool
> +		 * --int' and '--type=bool
> +		 * --type=int'.
> +		 */
> +		error("only one type at a time.");
> +		usage_with_options(builtin_config_usage,
> +			builtin_config_options);
> +	}
> +	*to_type = new_type;
> +
> +	return 0;
> +}
> +
