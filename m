Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9CD1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 01:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeDKBYt (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 21:24:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36051 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeDKBYs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 21:24:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id x82so760952wmg.1
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 18:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tlH+6Zd5znTKs4thnuH3I9yJMqd+B7NeWgAA/+Drmck=;
        b=J7cE4BCitjsdnoVHmRLu2Kkj5GLEJ6Os8kK0SxJuvd/40+1Luek1hZ3jKudqbxw2QA
         enBGSxuKX1qa00FhgWCu/++S2nydIyD8lDU5ThHQ2+QzIqIBW+zthPsWzfZ9rFumpV42
         QOD3d67LzvWAfvJj/U9m4KbwID02/nboIZpGBzUWlHs1INGpG6xgo0GGtcVyzSTGadGR
         iQikyd/bsMKiOd3GbQpKlTz8mJrJxaMyC0tHwDdvLbUnqqmGsodtD/9Y6HXWjN7fDngR
         Rn56Y/IHObrUvFPTcP4VJ2jvt2rlnLIQ5bpbnkpICnROKY+lqckfwCX+4k7wdRR2mOt0
         eXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tlH+6Zd5znTKs4thnuH3I9yJMqd+B7NeWgAA/+Drmck=;
        b=N7qxwz5s6ZTURyMzO7jdGm9cFQQohGJ2HysEGvNSv6CtOz1Oo1aURbqi4pojNzwlUX
         kSfubzstos4AHqx5EjNWoZyspt8wkyxxxdQK+RnenVwSM+33lxeYUkUr8ZtMwkwa5CaH
         y/Mg9rD+joGrfEou+LUI+bc8kP5hwY9cHtwhdV/+zSO3ixFYR55tnjeFkWu7lWLfCPXE
         07kBlepDoXvyvldS/1WXcR9fFNK5tKojsTw1js0T4ziJTJtBACO1htLB3reESBKrOdpL
         TcahFB8KyljJPXsKx1mx9cqnGRtv3d/Z3PBSnY6zBvv+s1fUyElHCrkQkNiDaMGL9+ho
         OBWw==
X-Gm-Message-State: ALQs6tCWHAXrYl1qA/IK4hmu9vyPNQH+l6BrXR9n3WbusSZyQ/iqxzw0
        7voo1MYzL8O7kLvGU9LS1+rjwkTd
X-Google-Smtp-Source: AIpwx4+2kXMHv78oQVsyj/05x6Aj8GpVX3+4a2Gg/f/Wgl0dlgxhn3+VhyVVpFST9YYb+OtWrIaNUw==
X-Received: by 10.28.99.84 with SMTP id x81mr1148353wmb.8.1523409886700;
        Tue, 10 Apr 2018 18:24:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l73sm791890wma.10.2018.04.10.18.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 18:24:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net
Subject: Re: [PATCH v8 0/2] builtin/config.c: support `--type=<type>` as preferred alias for `--type`
References: <20180328234719.595-1-me@ttaylorr.com>
        <20180411010654.GA28561@syl.local>
Date:   Wed, 11 Apr 2018 10:24:45 +0900
In-Reply-To: <20180411010654.GA28561@syl.local> (Taylor Blau's message of
        "Tue, 10 Apr 2018 18:06:54 -0700")
Message-ID: <xmqqtvsizg9u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Attached is the eighth re-roll of my series to add `--type=<type>` as
> the preferred alternative for `--<type>`.
>
> The main changes since v7 concern handling degenerate cases, such as:
>
>   * git config --type=int --type=bool
>   * git config --type=int --int
>
> We have previously had discussion about whether we should (1) retain the
> error in previous versions when confronted with multiple, conflicting
> type specifiers, (2) ignore the error, in favor of making --<type> and
> --type=<type> true synonyms, or (3) some combination of the two.
>
> I have thought some more about my argument that it would be favorable to
> make "--type=int" and "--int" behave in the same way, and I am no
> longer convinced that my argument makes sense. It's based on the premise
> that "--type=<type>" must _necessarily_ allow multiple invocations, such
> as '--type=int --type=bool', and therefore "--int --bool" should be
> updated to behave the same way.
>
> We are not constrained to this behavior, so in v8, I have taught Git the
> following:
>
>   1. Allow multiple non-conflicting types, such as '--int --int',
>      '--type=int --int', and '--int --type=int'.
>
>   2. Disallow multiple conflicting types, such as '--int --bool',
>      '--type=int --bool', and '--int --type=bool'.
>
>   3. Allow conflicting types following --no-type, such as '--int
>      --no-type --bool', '--type=int --no-type --bool', and '--int
>      --no-type --type=bool'. Note that this does _not_ introduce options
>      such as '--no-int' and whatnot.
>
> This is accomplished by a new locally defined macro called
> OPT_CALLBACK_VALUE, which allows us to reuse option_parse_type() to
> handle --int as well, by sending it through as opt->defval.
>
> I think that the above is the best-of-all-worlds choice, but I am
> curious to hear everyone else's thoughts. Thanks in advance for your
> review.

I too am curious.  Personally I do not think your "last one wins"
was necessarily bad--in fact it internally was consistent--I just
thought that the log message did not justify the choice well.  And I
do not think the semantics defined by this one, "once you choose,
stick to it, or explicitly clear the previous choice", is bad,
either.

> diff --git a/builtin/config.c b/builtin/config.c
> index 5c8952a17c..7184c09582 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -61,28 +61,53 @@ static int show_origin;
>  #define TYPE_PATH		4
>  #define TYPE_EXPIRY_DATE	5
>
> +#define OPT_CALLBACK_VALUE(s, l, h, f, i) \
> +	{ OPTION_CALLBACK, (s), (l), NULL, NULL, (h), PARSE_OPT_NOARG | \
> +	PARSE_OPT_NONEG, (f), (i) }
> +
> +static struct option builtin_config_options[];

OK.  I am not sure if OPT_CALLBACK_VALUE() needs to take 'f', as you
always pass the option_parse_type function to it.

>  static int option_parse_type(const struct option *opt, const char *arg,
>  			     int unset)
>  {
> -	int *type = opt->value;
> -
>  	if (unset) {
> -		*type = 0;
> +		type = 0;
>  		return 0;
>  	}
>
> -	if (!strcmp(arg, "bool"))
> -		*type = TYPE_BOOL;
> -	else if (!strcmp(arg, "int"))
> -		*type = TYPE_INT;
> -	else if (!strcmp(arg, "bool-or-int"))
> -		*type = TYPE_BOOL_OR_INT;
> -	else if (!strcmp(arg, "path"))
> -		*type = TYPE_PATH;
> -	else if (!strcmp(arg, "expiry-date"))
> -		*type = TYPE_EXPIRY_DATE;
> -	else
> -		die(_("unrecognized --type argument, %s"), arg);
> +	/*
> +	 * To support '--<type>' style flags, begin with new_type equal to
> +	 * opt->defval.
> +	 */
> +	int new_type = opt->defval;
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
> +	if (type != 0 && type != new_type) {
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
> +	type = new_type;

Does this rely on a file-scope global variable (type)?

>
>  	return 0;
>  }
