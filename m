Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B28D1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 20:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeGPVJl (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:09:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35749 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPVJk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:09:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id y22-v6so2655177wma.0
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aQUzNOpWC9GPOeDGZb5eAnlLExzjzsCHMdXpqzVQB+Y=;
        b=qDXxL1S+mK7fzPpr0HRqdj8AVW7pp7phu5YPVUpIbmKWuByOcS+m1DztZ9C7JFZ1td
         SaIxysJQmyByWONrBjfFn9bcyAqtNLcBW5SYYP1UWnpLZZUWNUn2qkYxQkUPdwrjtx03
         VnqyeZtIn5yWxLftSXVf+Q3y4oZ2IjVnYERWB63Vq1v7ApXWpc4tlmEaw1rLD1Lch+5l
         Av+2tskwR64XglIetDwFne8Y3HHzyMSjlwovl0EkgX6/SxHb/Q2F3ZsNfMu14uPna4U9
         X0WrcaIAMQnzN7zzrHxKHz4zQ0NJvsGIs39O0nUFGj1BpWDzKwekMJBGoEq5PHRV9sVH
         nemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aQUzNOpWC9GPOeDGZb5eAnlLExzjzsCHMdXpqzVQB+Y=;
        b=fKBBLhHOmFA8ZiBQmGo0EY9OrR+C1QdybCJxA6fFhr8TK2Ev8wXDS9HY4WrxqREFUE
         w04Aml4OVwsMAP4o8hcsqSmGl0oaN/iD5UTSXYJmP8vjOSTksP4pENQB8fWqU1fqZ4yL
         yrTDkZWuat3QG4LdCtBc9dg/5eAEFXVMW8/p9TLMiblny6t8s1dm1mgCHgBfz1QhKSIB
         aGkxQERm5pMvZSLsM4XhPXIrENehevqX8YXtoeTSNUxHpeh9BPfgQZ/9jNkLGoHbPgoN
         f+EceqZ+BcyIf5ZVb2syPzsyHo1ZgFNaCUhRoWNX3Zf77ihtolDZ6sU95qOx1HdcROzG
         48Ug==
X-Gm-Message-State: AOUpUlFVJt8AeyQ9ml1eNMiiFT0hQzGNWajk0dJbVPKuENIjfGpxwToB
        EPdYT+PUq29CRNo0IjSgtFw=
X-Google-Smtp-Source: AAOMgpdgST8nxYEqWSr0g0AcVh0kKwcYQBKrOlRlbrRU1BQh5rOXxF+0ThXJQIfmdKTHNadQYpoEWQ==
X-Received: by 2002:a1c:148f:: with SMTP id 137-v6mr7881819wmu.61.1531773633192;
        Mon, 16 Jul 2018 13:40:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n198-v6sm8906029wmd.33.2018.07.16.13.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 13:40:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 3/7] gpg-interface: introduce an abstraction for multiple gpg formats
References: <cover.1531470729.git.henning.schild@siemens.com>
        <cover.1531470729.git.henning.schild@siemens.com>
        <38e2eb70233709aa73345d64c94d59d4ccc681ec.1531470729.git.henning.schild@siemens.com>
Date:   Mon, 16 Jul 2018 13:40:32 -0700
In-Reply-To: <38e2eb70233709aa73345d64c94d59d4ccc681ec.1531470729.git.henning.schild@siemens.com>
        (Henning Schild's message of "Fri, 13 Jul 2018 10:41:25 +0200")
Message-ID: <xmqq4lgyud6n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> Create a struct that holds the format details for the supported formats.
> At the moment that is still just "openpgp". This commit prepares for the
> introduction of more formats, that might use other programs and match
> other signatures.
>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  gpg-interface.c | 84 ++++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 63 insertions(+), 21 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 960c40086..699651fd9 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -7,11 +7,46 @@
>  #include "tempfile.h"
>  
>  static char *configured_signing_key;
> -static const char *gpg_format = "openpgp";
> -static const char *gpg_program = "gpg";
> +struct gpg_format {
> +	const char *name;
> +	const char *program;
> +	const char **extra_args_verify;
> +	const char **sigs;
> +};
> +
> +static const char *openpgp_verify_args[] = { "--keyid-format=long", NULL };

Let's write it like this, even if the current line is short enough:

static const char *openpgp_verify_args[] = {
	"--keyid-format=long",
	NULL
};

Ditto for the next one.  Even if you do not expect these two arrays
to get longer, people tend to copy & paste to imitate existing code
when making new things, and we definitely would not want them to be
doing so on a code like the above (or below).  When they need to add
new elements to their arrays, having the terminating NULL on its own
line means they will have to see less patch noise.

> +static const char *openpgp_sigs[] = {
> +	"-----BEGIN PGP SIGNATURE-----",
> +	"-----BEGIN PGP MESSAGE-----", NULL };
> +
> +static struct gpg_format gpg_formats[] = {
> +	{ .name = "openpgp", .program = "gpg",
> +	  .extra_args_verify = openpgp_verify_args,

If the underlying aray is "verify_args" (not "extra"), perhaps the
field name should also be .verify_args to match.

Giving an array of things a name "things[]" is a disease, unless the
array is very often passed around as a whole to represent the
collection of everything.  When the array is mostly accessed one
element at a time, being able to say thing[3] to mean the third
thing is much more pleasant.

So, from that point of view, I pretty much agree with
openpgp_verify_args[] and openpgp_sigs[], but am against
gpg_formats[].  The last one should be gpg_format[], for which we
happen to have only one variant right now.

> +	  .sigs = openpgp_sigs
> +	},
> +};
> +static struct gpg_format *current_format = &gpg_formats[0];

Have a blank line before the above one.

What does "current_format" mean?  Is it different from "format to be
used"?  As we will overwrite the variable upon reading the config,
we cannot afford to call it default_format, but somehow "current"
feels misleading, at least to me.  I expected to find "old format"
elsewhere and there may be some format conversion or something from
the variable name.

    static struct gpg_format *use_format = &gpg_format[0];

perhaps?

> +
> +static struct gpg_format *get_format_by_name(const char *str)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
> +		if (!strcasecmp(gpg_formats[i].name, str))

As [1/7], this would become strcmp(), I presume?

> +			return gpg_formats + i;
> +	return NULL;
> +}
>  
> -#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
> -#define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
> +static struct gpg_format *get_format_by_sig(const char *sig)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
> +		for (j = 0; gpg_formats[i].sigs[j]; j++)
> +			if (starts_with(sig, gpg_formats[i].sigs[j]))
> +				return gpg_formats + i;
> +	return NULL;
> +}

OK.

> @@ -140,18 +172,23 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>  	}
>  
>  	if (!strcmp(var, "gpg.format")) {
> -		if (value && strcasecmp(value, "openpgp"))
> -			return error("malformed value for %s: %s", var, value);
> -		return git_config_string(&gpg_format, var, value);
> -	}
> -
> -	if (!strcmp(var, "gpg.program")) {
>  		if (!value)
>  			return config_error_nonbool(var);
> -		gpg_program = xstrdup(value);
> +		fmt = get_format_by_name(value);
> +		if (!fmt)
> +			return error("malformed value for %s: %s", var, value);

If I say "opongpg", that probably is not "malformed" (it is all
lowercase ascii alphabet that is very plausible-looking string), but
simply "bad value".

But other than the minor nit, yes, this structure is what I expected
to see from the very first step 1/7.

> +		current_format = fmt;
>  		return 0;
>  	}

>  
> +	if (!strcmp(var, "gpg.program"))
> +		fmtname = "openpgp";

OK, this is a backward compatibility measure to treat gpg.program as
if it were gpg.openpgp.program, which makes sense.

> +	if (fmtname) {
> +		fmt = get_format_by_name(fmtname);
> +		return git_config_string(&fmt->program, var, value);
> +	}
> +
>  	return 0;
>  }
