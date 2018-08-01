Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF6EB1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 22:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbeHBAjZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 20:39:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50880 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeHBAjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 20:39:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so366189wmc.0
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 15:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=u3SOH10h+sc3nLXL1Uw+enAPZrD9JASCsobA7Rwd5ZM=;
        b=tJZtPr6x9YI8y8UaxC2tu5ok39/x+QhrpkvJlf3FTcKazK5EjRHXnkywpTABBjiVVL
         0DrZF1fQd6y/1DrwcVx4hRO9tZXto/R73UptFlsPzCv2KmD5XiRBD3y1zS9wz/WNciOw
         mqcGTs39qVhs0rtCpM7Fme/eugf76e+sVtufAreXjrVxXQPczOdrLR3qp5Bzw4/lq/t0
         tUpfplGUaPxEP+tl3TqzchZQJV3T78+Q2jOpjJ3hPmdRnZ83g1GYpUtRPbWYpxtLD1Dt
         4gC+5N+aiWAJ0s33OpOf4o3wLjS6FEtPMrn2OXi1K7h5D3Kh8uHW542e1ExrCEnEyHK9
         bblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=u3SOH10h+sc3nLXL1Uw+enAPZrD9JASCsobA7Rwd5ZM=;
        b=RKqtFqiSE1pwm1IxS/247za8dgLGomDSR997Dt1ozvEwLIjhbHtZGnwisp73lbvpNi
         A/B+4bA/4uvIYfhITq4oyQ1MXVHC1rXVlZyNFKdNjABV7UCtVFIiEHWSc1gcSBhlepJi
         DWcw+oAauFII+IIxi6HGDs5jAH/MMHtv+6NsHKKGA7o9liqvTxhS01RsgrWuiUcNPAH0
         wFbmREJMDFGnCt/A++LAyxVVZDV8KrYWdb5Vj/finpzV0p2QgG5YWQ6v6wCuj9nGDObt
         QPL2w2/3WbjUCcanZuec04HPejarbZBCX4bsHKosZBYy+RRezLmAAap7GC12g+kJEjHS
         o3dQ==
X-Gm-Message-State: AOUpUlHY6I4+mh2fyoaX8fvw+YvVr/cdeqfMJIzwElOBkBUrPwRFasBU
        Io4aEM4/32IVyM5TewpiI4n5TJUw
X-Google-Smtp-Source: AAOMgpfTm0pCwnomhq4OuCIFgMKYp6Ir87q/ZT/GV3Jb9u3SnJBezVss3/KHTXPU8HkbH2SQdqI70A==
X-Received: by 2002:a1c:6d17:: with SMTP id i23-v6mr199266wmc.139.1533163877803;
        Wed, 01 Aug 2018 15:51:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v124-v6sm80261wma.18.2018.08.01.15.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 15:51:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, johannes.schindelin@gmx.de,
        peff@google.com
Subject: Re: [PATCH 2/3] config: fix case sensitive subsection names on writing
References: <xmqq7elbe8po.fsf@gitster-ct.c.googlers.com>
        <20180801193413.146994-1-sbeller@google.com>
        <20180801193413.146994-3-sbeller@google.com>
Date:   Wed, 01 Aug 2018 15:51:16 -0700
In-Reply-To: <20180801193413.146994-3-sbeller@google.com> (Stefan Beller's
        message of "Wed, 1 Aug 2018 12:34:12 -0700")
Message-ID: <xmqqva8t4s63.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> A use reported a submodule issue regarding strange case indentation
> issues, but it could be boiled down to the following test case:

Perhaps

s/use/user/
s/case indentation issues/section mix-up/

> ... However we do not have a test for writing out config correctly with
> case sensitive subsection names, which is why this went unnoticed in
> 6ae996f2acf (git_config_set: make use of the config parser's event
> stream, 2018-04-09)

s/unnoticed in \(.*04-09)\)/unnoticed when \1 broke it./

This is why I asked if the patch is a "FIX" for an issue introduced
by the cited commit.

> Unfortunately we have to make a distinction between old style configuration
> that looks like
>
>   [foo.Bar]
>         key = test
>
> and the new quoted style as seen above. The old style is documented as
> case-agnostic, hence we need to keep 'strncasecmp'; although the
> resulting setting for the old style config differs from the configuration.
> That will be fixed in a follow up patch.
>
> Reported-by: JP Sugarbroad <jpsugar@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  config.c          | 12 +++++++++++-
>  t/t1300-config.sh |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/config.c b/config.c
> index 7968ef7566a..1d3bf9b5fc0 100644
> --- a/config.c
> +++ b/config.c
> @@ -37,6 +37,7 @@ struct config_source {
>  	int eof;
>  	struct strbuf value;
>  	struct strbuf var;
> +	unsigned section_name_old_dot_style : 1;
>  
>  	int (*do_fgetc)(struct config_source *c);
>  	int (*do_ungetc)(int c, struct config_source *conf);
> @@ -605,6 +606,7 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
>  
>  static int get_extended_base_var(struct strbuf *name, int c)
>  {
> +	cf->section_name_old_dot_style = 0;
>  	do {
>  		if (c == '\n')
>  			goto error_incomplete_line;
> @@ -641,6 +643,7 @@ static int get_extended_base_var(struct strbuf *name, int c)
>  
>  static int get_base_var(struct strbuf *name)
>  {
> +	cf->section_name_old_dot_style = 1;
>  	for (;;) {
>  		int c = get_next_char();
>  		if (cf->eof)

OK, let me rephrase.  The basic parse structure is that

 * upon seeing '[', we call get_base_var(), which stuffs the
   "section" (including subsection, if exists) in the strbuf.

 * get_base_var() upon seeing a space after "[section ", calls
   get_extended_base_var().  This space can never exist in an
   old-style three-level names, where it is spelled as
   "[section.subsection]".  This space cannot exist in two-level
   names, either.  The closing ']' is eaten by this function before
   it returns.

 * get_extended_base_var() grabs the "double quoted" subsection name
   and eats the closing ']' before it returns.

So you set the new bit (section_name_old_dot_style) at the beginning
of get_base_var(), i.e. declare that you assume we are reading old
style, but upon entering get_extended_base_var(), unset it, because
now you know we are parsing a modern style three-level name(s).

Feels quite sensible way to keep track of old/new styles.

When parsing two-level names, old-style bit is set, which we may
need to be careful, thoguh.

> @@ -2355,14 +2358,21 @@ static int store_aux_event(enum config_event_t type,
>  	store->parsed[store->parsed_nr].type = type;
>  
>  	if (type == CONFIG_EVENT_SECTION) {
> +		int (*cmpfn)(const char *, const char *, size_t);
> +
>  		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
>  			return error("invalid section name '%s'", cf->var.buf);
>  
> +		if (cf->section_name_old_dot_style)
> +			cmpfn = strncasecmp;
> +		else
> +			cmpfn = strncmp;
> +
>  		/* Is this the section we were looking for? */
>  		store->is_keys_section =
>  			store->parsed[store->parsed_nr].is_keys_section =
>  			cf->var.len - 1 == store->baselen &&
> -			!strncasecmp(cf->var.buf, store->key, store->baselen);
> +			!cmpfn(cf->var.buf, store->key, store->baselen);

OK.  Section names should still be case insensitive (only the case
sensitivity of subsection names is special), but presumably that's
already normalized by the caller so we do not have to worry when we
use strncmp()?  Can we add a test to demonstrate that it works
correctly?

Thanks.

