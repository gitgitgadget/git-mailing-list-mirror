Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA7C1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 21:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389719AbeG0XBN (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 19:01:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37563 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389583AbeG0XBN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 19:01:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11-v6so6930608wmc.2
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 14:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SiGdnFHWXAHUnTjkcvFvBhU6CNnOxliItQF8q0Kasrc=;
        b=suIEPlDhOARTX1GoFy/nYW1YzvJcVwDhZcWX8+bWUD5C7pY9lzwmPNgu9z8QCLMdMr
         gHR0D+H1bT/n7mlw3QxE+DNKZCxLbC+olqe0MSKUlMnPhQiaHi6FEq7KoCfpVmlBi8ks
         CVkQ4nDzwU92BPC/NI9lO3tyg+7r7NRIncgL97RVy1rv5D6qRGOairsE7SkAUgoFV1QI
         U4qm0GCbSnM1yzoDuYK5i3nZRDXZzrFsXgh3In2KbA5ObQQ43TFNAJc7FLhztVqMwFK/
         fjv6dONQXWVIPyPmcUC0kZ8LBPk3q6p48LoHhf6FOoea1h0o+PRvyLlMP/I8S+TL1e/t
         v7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SiGdnFHWXAHUnTjkcvFvBhU6CNnOxliItQF8q0Kasrc=;
        b=pogVva/KM6vL/Qb/ofLbuVrIDcBEcvCT8E1gJMmdjn2kagm1qFasRY/VzzNqv+IvKj
         tEerR3EsU4f9SWu7+215VgVk3fD+2M+iBa8JTr3rYo7dhW4Y/PJIKbxJ8Wv1FHwj1ct4
         o8oMzOpMCJBTbOin4i/RrXtubV4TNs6gX4+iTOqjFkhHeaKWjZUhQCoxLIU8CvdhW98u
         4mizfEg7dp4DLukhB4E/BZYlcDnYnWF2YQLLNTbdAkPB3WkadpkNie1eAEe9pTB+T4dd
         Fm4qeCmzAVtb6he9uJOJqpnql6R1ReBtvs3kEQAGarffjCoNXNRCA4q4sdhoIwSZQ/K7
         j/Jg==
X-Gm-Message-State: AOUpUlH5Bxe+Xch4ojYd5IDKbKTU+v7tMBo2Gwe24ef5vFyVCJUx0fds
        ppBoRcyRHIij1jt+5fxRFxjuJ7iE
X-Google-Smtp-Source: AAOMgpe+7X1QxExCeZ6oObU0vuByCFb6vw7V1ann4OJO9ixweir41zTsjuauKQeOE8ngsPT/Hlfopg==
X-Received: by 2002:a1c:6d94:: with SMTP id b20-v6mr5881072wmi.28.1532727445368;
        Fri, 27 Jul 2018 14:37:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p11-v6sm3403680wrs.51.2018.07.27.14.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 14:37:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config: fix case sensitive subsection names on writing
References: <20180727205117.243770-1-sbeller@google.com>
Date:   Fri, 27 Jul 2018 14:37:24 -0700
In-Reply-To: <20180727205117.243770-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 27 Jul 2018 13:51:17 -0700")
Message-ID: <xmqqk1pgl5rf.fsf@gitster-ct.c.googlers.com>
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
>
>   $ git init test  && cd test
>   $ git config foo."Bar".key test
>   $ git config foo."bar".key test
>   $ tail -n 3 .git/config
>   [foo "Bar"]
>         key = test
>         key = test
>
> Sub sections are case sensitive and we have a test for correctly reading
> them. However we do not have a test for writing out config correctly with
> case sensitive subsection names, which is why this went unnoticed in
> 6ae996f2acf (git_config_set: make use of the config parser's event
> stream, 2018-04-09)

Thanks for finding this bug and fixing it; yes it would have been
even nicer if we caught it before it hit 'master', but we can only
do what we can X-<.

> diff --git a/config.c b/config.c
> index 3aacddfec4b..3ded92b678b 100644
> --- a/config.c
> +++ b/config.c
> @@ -2374,7 +2374,7 @@ static int store_aux_event(enum config_event_t type,
>  		store->is_keys_section =
>  			store->parsed[store->parsed_nr].is_keys_section =
>  			cf->var.len - 1 == store->baselen &&
> -			!strncasecmp(cf->var.buf, store->key, store->baselen);
> +			!strncmp(cf->var.buf, store->key, store->baselen);
>  		if (store->is_keys_section) {
>  			store->section_seen = 1;
>  			ALLOC_GROW(store->seen, store->seen_nr + 1,
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 03c223708eb..8325d4495f4 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1218,6 +1218,24 @@ test_expect_success 'last one wins: three level vars' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'setting different case subsections ' '
> +	test_when_finished "rm -f caseSens caseSens_actual caseSens_expect" &&
> +
> +	# v.a.r and v.A.r are not the same variable, as the middle
> +	# level of a three-level configuration variable name is
> +	# case sensitive.
> +	git config -f caseSens v."A".r VAL &&
> +	git config -f caseSens v."a".r val &&

It probably is easier to read to write these as "v.A.r" and "v.a.r"
respectively.

> +
> +	echo VAL >caseSens_expect &&
> +	git config -f caseSens v."A".r >caseSens_actual &&
> +	test_cmp caseSens_expect caseSens_actual &&
> +
> +	echo val >caseSens_expect &&
> +	git config -f caseSens v."a".r >caseSens_actual &&
> +	test_cmp caseSens_expect caseSens_actual
> +'
> +
>  for VAR in a .a a. a.0b a."b c". a."b c".0d
>  do
>  	test_expect_success "git -c $VAR=VAL rejects invalid '$VAR'" '
