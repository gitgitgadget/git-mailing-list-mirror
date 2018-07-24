Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12CB1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 15:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbeGXQin (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 12:38:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40814 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388365AbeGXQin (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 12:38:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so2146244wma.5
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qRD32Huu3KaHuhQ5xyDkamcJq3NoKKvKumDd8XgmJAA=;
        b=ZoZeAShZBgmsmpZgbP0CAZgvVoSy3kXoWhmhqFCuZSRXTpAirqNNdYsG2348N4rqoj
         ftoW6X4GuWTY/uG4FjZ3bDSf8F2xc2CJft2ePMG15owich6xwLOEjZiKQLSkTi2dmP6o
         qn45V5s56/8uxpzf1M8wpSOz31laM1A82Tv1RWG9ZJtTygBxi+I0BhC7XAspCBPAIQfZ
         wxDKYkUks/IV33HYYV6guxocFMZ1u9mZO9n4Lq4sjfqG4OslATV1ESfmz67ZyWm2mj+P
         Zjn/XNf0Ef5cpq7L7MEoQXyWGOnXgmbBmsPbMWoGVBryJCpZ8Zb4IYOyXx9amqttYrly
         kfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qRD32Huu3KaHuhQ5xyDkamcJq3NoKKvKumDd8XgmJAA=;
        b=jrhule0oHfN/tskPmuuDkYtoQae/JXBIIIQ90yclK1ZuR/qEMGzkOfy38CuxD00HfH
         ACWez16pmBFSrEAzLMf6nttq4RDY0g42iU+YWKfyvD429GHxXjf5ykx5y70wVccClY8H
         4ZaSufWvWhijJPAuxV+MdyzybyINbzd+qv/pnDdif2AGdivYNTKl9uEcViSG/NhlVTmP
         1by9akS5rVK1+MgbEI8ls/EuIoM78W82DWt6ybzukufKU9o5gDOj2x0ndZ829Trwv+6/
         an7v8ElHrsX0ZSj1HCcRie2glqRsMguRZyKsKPzQVFbXuLEMJYWRGgoG/0g+aWjtG5i1
         dlqA==
X-Gm-Message-State: AOUpUlF3azPXr8NG/Jp2l/k4kxDoEanAAoMtKeOY4Sx+mSLDpVmKxqZJ
        sBKeWuAtcrO+97z/xU+tj28=
X-Google-Smtp-Source: AAOMgpe3lJbni22Q5Xx27/7bOM63Bxr+q3dmpqaYeaOEPl5m39YA+SlimcXPY6cTlfkeobjbRdyf/A==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr2172829wmc.30.1532446299780;
        Tue, 24 Jul 2018 08:31:39 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a145-v6sm2890124wmd.39.2018.07.24.08.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 08:31:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Akinori MUSHA <knu@iDaemons.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH] sequencer: fix quoting in write_author_script
References: <eb295aea-dae5-5e1c-bacf-2c77d3ce0195@talktalk.net>
        <20180718155518.1025-1-phillip.wood@talktalk.net>
Date:   Tue, 24 Jul 2018 08:31:38 -0700
In-Reply-To: <20180718155518.1025-1-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Wed, 18 Jul 2018 16:55:18 +0100")
Message-ID: <xmqq36w81wh1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Single quotes should be escaped as \' not \\'. Note that this only
> affects authors that contain a single quote and then only external
> scripts that read the author script and users whose git is upgraded from
> the shell version of rebase -i while rebase was stopped. This is because
> the parsing in read_env_script() expected the broken version and for
> some reason sq_dequote() called by read_author_ident() seems to handle
> the broken quoting correctly.
>
> Ideally write_author_script() would be rewritten to use
> split_ident_line() and sq_quote_buf() but this commit just fixes the
> immediate bug.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>
> This is untested, unfortuantely I don't have really have time to write a test or
> follow this up at the moment, if someone else want to run with it then please
> do.

Any follow-up on this?

Dscho, I do agree with Phillip that the author-script this code
produces does not quote single quotes correctly (if we consider that
the author-script is meant to be compatible with shell script
version and what "git am" uses, that is), and Phillip's fix looks
like a reasonable first step going forward (the next step would
remove the transitional band-aid from the reading code, also added
by this patch).

Thanks.

>
> sequencer.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 5354d4d51e..0b78d1f100 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -638,21 +638,21 @@ static int write_author_script(const char *message)
>  		else if (*message != '\'')
>  			strbuf_addch(&buf, *(message++));
>  		else
> -			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> +			strbuf_addf(&buf, "'\\%c'", *(message++));
>  	strbuf_addstr(&buf, "'\nGIT_AUTHOR_EMAIL='");
>  	while (*message && *message != '\n' && *message != '\r')
>  		if (skip_prefix(message, "> ", &message))
>  			break;
>  		else if (*message != '\'')
>  			strbuf_addch(&buf, *(message++));
>  		else
> -			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> +			strbuf_addf(&buf, "'\\%c'", *(message++));
>  	strbuf_addstr(&buf, "'\nGIT_AUTHOR_DATE='@");
>  	while (*message && *message != '\n' && *message != '\r')
>  		if (*message != '\'')
>  			strbuf_addch(&buf, *(message++));
>  		else
> -			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> +			strbuf_addf(&buf, "'\\%c'", *(message++));
>  	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
>  	strbuf_release(&buf);
>  	return res;
> @@ -666,13 +666,21 @@ static int read_env_script(struct argv_array *env)
>  {
>  	struct strbuf script = STRBUF_INIT;
>  	int i, count = 0;
> -	char *p, *p2;
> +	const char *p2;
> +	char *p;
>  
>  	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
>  		return -1;
>  
>  	for (p = script.buf; *p; p++)
> -		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
> +		/*
> +		 * write_author_script() used to escape "'" incorrectly as
> +		 * "'\\\\''" rather than "'\\''" so we check for the correct
> +		 * version the incorrect version in case git was upgraded while
> +		 * rebase was stopped.
> +		 */
> +		if (skip_prefix(p, "'\\''", &p2) ||
> +		    skip_prefix(p, "'\\\\''", &p2))
>  			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
>  		else if (*p == '\'')
>  			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
