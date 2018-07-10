Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B201F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 17:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933411AbeGJRQo (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 13:16:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54254 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933299AbeGJRQm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 13:16:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id b188-v6so25441956wme.3
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l7au6X1K97AS9OsHvSIwk1WC0Xsuwx7zOGVjqYnMECU=;
        b=HantCUrcVuhpJgPUfwYNs3a650z+IxrUXDQrb07PGJkzQ/qetqHWPq4zn39LbYVEXy
         Z0ektT95qOBIvYXFLeNABuKO00TgpWE8rLDZsKkdD3fb20vdbT9reRGGxRotb2buBCfS
         ObppF19Uz08fs9S0R7MQpvzujSqBlyUJYf2/ejWeZ4tOeVpwj+e5CjuPweDIQUBhG3Km
         UDZJtjoDUqWlb5Bys8Nr9G8fRsRNl2WsgQjYwSSTudNrbiU39DwopDL6gZ5Gz0kwP9KT
         VlDpHuTPZqgH4/Ut3k5aSjGzArmKFppDHiT4Tug8kuq0x7zM8U0KjFSR78diyJ1ydzyE
         g26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l7au6X1K97AS9OsHvSIwk1WC0Xsuwx7zOGVjqYnMECU=;
        b=tlimmNnXEYdpKV4A3KZJhsqX83lRnga6JQ/dXj7x7IdhiQqBsFnchiD1lL8phXyrHr
         c2kYkWaL39bfaRslio9lurQjHjBO/VDs63DhJ6XhKE5B4+g6Lr9jnEhCUuVMLX8vNY3f
         PlYOyunWh8JhAtOcrCuxatOhZt4GXftcFxwGE0pusVqv/Sqz0qndUtFrpEdZQiAGji6m
         qjDdb7/79Kx+6jVj+pebaX0WUaqndJQ+ELyx+QcTP7St2Zl82tFPvqyGFJ+82967JU6G
         WJzgYjfO3xFZ6MsJ++iWgBWPgDYaedOnL7rrWNKSsM4+Bmd0/FhhK/IlI3R9iOt/7Wox
         iCGQ==
X-Gm-Message-State: APt69E1Cf8QB+BZo4zqAXbNcVOXkNfAskFwF//4Q1l0i8mymLH0NGnxZ
        29f7Bv1UHf7Siyyc/JFsHCo=
X-Google-Smtp-Source: AAOMgpf0EYfYUO6k/kDq/esPm2m425Iky8dGVIfFn1/3jJ5yu08MaFk78ONMqGaxq21AjqjgeJGmmw==
X-Received: by 2002:a1c:2094:: with SMTP id g142-v6mr14264236wmg.144.1531243000717;
        Tue, 10 Jul 2018 10:16:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z9-v6sm32408753wre.49.2018.07.10.10.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 10:16:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/9] gpg-interface: introduce an abstraction for multiple gpg formats
References: <cover.1531208187.git.henning.schild@siemens.com>
        <cover.1531208187.git.henning.schild@siemens.com>
        <93d74df91b9f5c68dfd8a03f576d7428491976c0.1531208187.git.henning.schild@siemens.com>
Date:   Tue, 10 Jul 2018 10:16:39 -0700
In-Reply-To: <93d74df91b9f5c68dfd8a03f576d7428491976c0.1531208187.git.henning.schild@siemens.com>
        (Henning Schild's message of "Tue, 10 Jul 2018 10:52:27 +0200")
Message-ID: <xmqqlgaj80zs.fsf@gitster-ct.c.googlers.com>
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
>  gpg-interface.c | 74 ++++++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 58 insertions(+), 16 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index ed0e55917..0a8d1bff3 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -7,12 +7,46 @@
>  #include "tempfile.h"
>  
>  static char *configured_signing_key;
> -static const char *gpg_format = "openpgp";
> -static const char *gpg_program = "gpg";
> +struct gpg_format_data {
> +	const char *format;
> +	const char *program;
> +	const char *extra_args_verify[1];
> +	const char *sigs[2];
> +};

Do you use identifier "gpg_format" elsewhere as a structure name?  A
structure is there always to hold "data", so often "_data" suffix is
meaningless in a structure type name like this.

>  #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
>  #define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
>  
> +enum gpgformats { PGP_FMT };
> +struct gpg_format_data gpg_formats[] = {
> +	{ .format = "openpgp", .program = "gpg",
> +	  .extra_args_verify = { "--keyid-format=long" },
> +	  .sigs = { PGP_SIGNATURE, PGP_MESSAGE }
> +	},
> +};
> +static const char *gpg_format = "openpgp";
> +
> +static struct gpg_format_data *get_format_data(const char *str)

get_format_data_by_name() or something like that, for consistency
with the next function, perhaps?

> +{
> +	int i;
> +	for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
> +		if (!strcasecmp(gpg_formats[i].format, str))
> +			return gpg_formats + i;
> +	return NULL;
> +}
> +
> +static struct gpg_format_data *get_format_data_by_sig(const char *sig)
> +{
> +	int i, j;
> +	for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
> +		for (j = 0; j < ARRAY_SIZE(gpg_formats[i].sigs); j++)
> +			if (gpg_formats[i].sigs[j] && 
> +			    !strncmp(gpg_formats[i].sigs[j], sig,
> +				     strlen(gpg_formats[i].sigs[j])))
> +				return gpg_formats + i;
> +	return NULL;
> +}
> +
>  void signature_check_clear(struct signature_check *sigc)
>  {
>  	FREE_AND_NULL(sigc->payload);
> @@ -104,8 +138,7 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
>  
>  static int is_gpg_start(const char *line)
>  {
> -	return starts_with(line, PGP_SIGNATURE) ||
> -		starts_with(line, PGP_MESSAGE);
> +	return (get_format_data_by_sig(line) != NULL);

If this is still called "is_gpg_start()", then shouldn't the
implementation be more like this?

	struct gpg_format *found = get_format_data_by_sig(line);

	return found && found == &gpg_formats[PGP_FMT];

It probably does not make much difference in the end, as you won't
have functions is_(gpg|gpgsm|somethingelse|yetanother)_start() but
either have a single function "does some x509 looking block start
here?" or "I am expecting gpg and nothing else, does a block for
that start here?" and at that point this will no longer be called
is_gpg_start(), I would expect.

>  size_t parse_signature(const char *buf, size_t size)
> @@ -140,18 +173,14 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>  	}
>  
>  	if (!strcmp(var, "gpg.format")) {
> -		if (strcasecmp(value, "openpgp"))
> +		if (!get_format_data(value))
>  			return error("malformed value for %s: %s", var, value);
>  		return git_config_string(&gpg_format, var, value);

This is a bug introduced in an earlier step in the series, but you
will segfault when given a configuration that looks like this:

	[gpg]
		format

Imitate the way how !value is diagnosed upfront for "gpg.program"
below before this patch.

>  	}
>  
> -	if (!strcmp(var, "gpg.program")) {
> -		if (!value)
> -			return config_error_nonbool(var);
> -		gpg_program = xstrdup(value);
> -		return 0;
> -	}
> -
> +	if (!strcmp(var, "gpg.program"))
> +		return git_config_string(&gpg_formats[PGP_FMT].program, var,
> +					 value);

git_config_string() has its own "do not feed boolean 'true' to me"
check, so this change does not introduce a regression.

> @@ -165,12 +194,16 @@ const char *get_signing_key(void)
>  int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
>  {
>  	struct child_process gpg = CHILD_PROCESS_INIT;
> +	struct gpg_format_data *fmt;
>  	int ret;
>  	size_t i, j, bottom;
>  	struct strbuf gpg_status = STRBUF_INIT;
>  
> +	fmt = get_format_data(gpg_format);
> +	if (!fmt)
> +		BUG("bad gpg_format '%s'", gpg_format);
>  	argv_array_pushl(&gpg.args,
> -			 gpg_program,
> +			 fmt->program,
>  			 "--status-fd=2",
>  			 "-bsau", signing_key,
>  			 NULL);
> @@ -208,8 +241,9 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>  			 struct strbuf *gpg_output, struct strbuf *gpg_status)
>  {
>  	struct child_process gpg = CHILD_PROCESS_INIT;
> +	struct gpg_format_data *fmt;
>  	struct tempfile *temp;
> -	int ret;
> +	int ret, i;
>  	struct strbuf buf = STRBUF_INIT;
>  
>  	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
> @@ -223,10 +257,18 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>  		return -1;
>  	}
>  
> +	fmt = get_format_data_by_sig(signature);
> +	assert(fmt);
> +
> +	argv_array_pushl(&gpg.args,
> +			 fmt->program, NULL);
> +	for (i = 0; i < ARRAY_SIZE(fmt->extra_args_verify); i++)
> +		if (fmt->extra_args_verify[i])
> +			argv_array_pushl(&gpg.args,
> +					 fmt->extra_args_verify[i], NULL);

This loop allows us to extend .extra_args_verify when we need to
support another variant that needs to take two arguments by making
.extra_args field larger for all variants and stuffing a NULL to
unused slots, and it even allows a nonsense like this

	.extra_args_verify = { NULL, "--keyid-format=long" },

I cannot quite shake the feeling that .extra_args_verify and .sigs
fields should not be of fixed sized array of strings, but rather be
of type "const char **" that is NULL terminated.  Such a clean-up
will make it harder to write initializers, so it may not be worth
it, I guess.

>  	argv_array_pushl(&gpg.args,
> -			 gpg_program,
>  			 "--status-fd=1",
> -			 "--keyid-format=long",
>  			 "--verify", temp->filename.buf, "-",
>  			 NULL);
