Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED4C1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 03:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeDKDLv (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 23:11:51 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:54884 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeDKDLu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 23:11:50 -0400
Received: by mail-wm0-f51.google.com with SMTP id r191so1064790wmg.4
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 20:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=26abtSE/nPN8RjfobnRXqV6WQmAqdZg7kcgQaRAbqH4=;
        b=ZFEUMnfg65N/dboaM0BHFHn0QSMaPUFCEjQWUqYQEk1kmC7AJz2pSxesprHVDUHDPw
         uuarylWdF82ZdNA9oHo80Bae9rrfzXW9yvcG8eD0bbr5T3UNLtV13HceG0AbA09C9PR0
         q6ZQ31Nwp2rnt1Fa6Uvh9GQqrCbT4v7c31eTxBcxqUiJtjTrwJjrRHt4K9yiXbQOrkUH
         Y8/EG3hvQxMBA0gl39m4932AYOKvGM8tzSDPdoGvbe22ov52fR4bBLDdBl9VoocFClzJ
         lz4F2rQUpBMUfoSSt2RetLSSjHwczejBXUvJb8N7mT7SUDGp0ZW1M6/EW6MnSo1FEaQ8
         0m5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=26abtSE/nPN8RjfobnRXqV6WQmAqdZg7kcgQaRAbqH4=;
        b=RMdtOvDANHLkFSNHbgXSd1T2tK/HBZ4FHCTMEp9GUgkPSr4suFgbFSlpwbFrOIDHLo
         ji+oddwrZOUthiJiob9hrCoOx38sT2c7r2HB5HOj2Ie5uN7jduAo3KG8dqLOUImp0OYL
         4la/jW/LmW6Pby6gjgEAy1cNm1r3erm2YMAX+QBzpgL212SReMlY+XthVEShiv5fC2xV
         EMYd9HpAcS8YvgDBJfgOkDerc+NPlLWHRFWz65gcpQ3C8Ep/tuP0r5dRBT6jEXgv7Hyt
         olQS6RsCXaubsNaL819ZN8eRFsFwnzAdgKKQ8nIzWRy8BLd1rjJ7ovq5swkyGv7vDJjJ
         XVzw==
X-Gm-Message-State: ALQs6tDvdfeNdeGemvUGaCWpDBOrOkdpPiskuQMEjBKZRTMR87pRZKgl
        5pDx7BpPu4yuwByrNKuG+hg=
X-Google-Smtp-Source: AIpwx49BvGgbl8b4Sgcom7ZpRLbjRObdqg2N9d1SaflepFDf9mpMS8zWLZV2NhIAq0qGKOf/qObRpw==
X-Received: by 10.28.211.147 with SMTP id k141mr1097443wmg.15.1523416308863;
        Tue, 10 Apr 2018 20:11:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n143sm427218wmd.29.2018.04.10.20.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 20:11:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net
Subject: Re: [PATCH v8 0/2] builtin/config.c: support `--type=<type>` as preferred alias for `--type`
References: <20180328234719.595-1-me@ttaylorr.com>
        <20180411010654.GA28561@syl.local>
        <xmqqtvsizg9u.fsf@gitster-ct.c.googlers.com>
        <20180411013309.GA36066@syl.local>
Date:   Wed, 11 Apr 2018 12:11:47 +0900
In-Reply-To: <20180411013309.GA36066@syl.local> (Taylor Blau's message of
        "Tue, 10 Apr 2018 18:33:09 -0700")
Message-ID: <xmqq1sfmzbbg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> > +#define OPT_CALLBACK_VALUE(s, l, h, f, i) \
>> > +	{ OPTION_CALLBACK, (s), (l), NULL, NULL, (h), PARSE_OPT_NOARG | \
>> > +	PARSE_OPT_NONEG, (f), (i) }
>> > +
>> > +static struct option builtin_config_options[];
>>
>> OK.  I am not sure if OPT_CALLBACK_VALUE() needs to take 'f', as you
>> always pass the option_parse_type function to it.
>
> That's fair. I left this in as an indication that something like this
> _might_ want to make its way into parse-options.h as a general-purpose
> utility, but was not yet ready to do so. Thus, I defined it inside
> builtin/config.c.

I understood the reasoning, but as your current verdict is that this
is not yet ready for parse-options.[ch], I think it is probably
preferrable to reduce repeated passing of the same function to the
macro, at least while it is in this builgin/config.c file.

> @@ -71,7 +71,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
>  			     int unset)
>  {
>  	if (unset) {
> -		type = 0;
> +		*((int *) opt->value) = 0;
>  		return 0;
>  	}

Yup.  This (if it works) is exactly what I imagined the function
should look like.
