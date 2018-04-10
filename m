Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D765D1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 00:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeDJAU2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 20:20:28 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:32990 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDJAU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 20:20:27 -0400
Received: by mail-pl0-f45.google.com with SMTP id s10-v6so6228273plp.0
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 17:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NN1VLWW0WXa09VLfqHAtGPWa0j/CnK+vSDORBCy4xM4=;
        b=Tom+8By9wi9tdnDkdaXLp5vRYN799M0g7mUC1ZjNT6qWEQvamM4lC477Ka5ypCghFK
         scmm2sgOR1HfILMPClXFP3+zd7+fT+XQZ+JHgB45a+6UtTmhi/X1RfeO0wYRkHDHgIh4
         DkTleeUK4IVb8ktSwOBuG8jl/+PzcGn7XDAtggcTVQnK0FOOSxKnprPQ7hjUFWOySjBZ
         pylzkm552S0jw/CYT92B8ZZ0AuxfLL7ZtJFf90RUvmewwpB3r5sKXg7fhiPOryar1wiO
         sB3udNw2xgGE6a7rR6c7tQfgmrJqe9Tl8fxsJFvZ9Mv45SAx+JYABN15a94bcZGT9UQa
         9UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NN1VLWW0WXa09VLfqHAtGPWa0j/CnK+vSDORBCy4xM4=;
        b=t/nUyPj9bIvzDJC55IAuFCUqLOm81OLtaRmqtxmu0sx3CaMEbpyCEPFFxsRbe7E/uu
         FeXopRqj5ZbovYowEO9bfW8M1GIVpa4meANepu5nUsYFvXbm1g6cExiiHnf4mxhJkMqm
         NLcVdggqO8PgQAW9Y/x7+Z0cyJvugiPE8vfPw/6NysFMBIEw5uRfQQoAt1ajyYzcZQOX
         RzFHzBmT8eUsjL5ocG7DfTVcVa1ImiwwrvfCC2NUOd74nWRvxoPzjKJ5X936xpue1JeB
         kNRZ/B/+XmtGfFBcOKZIhKRV8NuYTE67C5zBLTTBCmj3yI9ooRwsXXwRzVnJ0ykL0ocT
         VPLQ==
X-Gm-Message-State: ALQs6tAEeCaw2OG6NjeuSpmTmfNRlLMhvN53pvPulGZiYfiiWiTfBmMx
        SELuLyUWENFBXThB8CLRBU3DVIJUcRk=
X-Google-Smtp-Source: AIpwx4+/fOCh7KlBvUDfTbtlLiPJIMwfpl8nHrph+LWnGBUPrpZ6Js98M+PDF3hOeouEh5ZcUbPnyg==
X-Received: by 2002:a17:902:7702:: with SMTP id n2-v6mr10828743pll.216.1523319626656;
        Mon, 09 Apr 2018 17:20:26 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:1d66:22f3:ac1d:6007])
        by smtp.gmail.com with ESMTPSA id r76sm2722248pfl.24.2018.04.09.17.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 17:20:25 -0700 (PDT)
Date:   Mon, 9 Apr 2018 17:20:24 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        sunshine@sunshineco.com
Subject: Re: [PATCH v4 1/3] builtin/config: introduce `--default`
Message-ID: <20180410002024.GA48196@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <cover.1522896713.git.me@ttaylorr.com>
 <20180405025912.GB49902@syl.local>
 <20180405222949.GC29117@sigill.intra.peff.net>
 <xmqq60518eyt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq60518eyt.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 09, 2018 at 08:18:18AM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > On Wed, Apr 04, 2018 at 07:59:12PM -0700, Taylor Blau wrote:
> >
> >> @@ -286,6 +288,16 @@ static int get_value(const char *key_, const char *regex_)
> >>  	config_with_options(collect_config, &values,
> >>  			    &given_config_source, &config_options);
> >>
> >> +	if (!values.nr && default_value) {
> >> +		struct strbuf *item;
> >> +		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
> >> +		item = &values.items[values.nr++];
> >> +		strbuf_init(item, 0);
> >> +		if (format_config(item, key_, default_value) < 0) {
> >> +			exit(1);
> >> +		}
> >> +	}
> > ...
> >
> > It's obvious in this toy example, but that config call may be buried
> > deep in a script. It'd probably be nicer for that exit(1) to be
> > something like:
> >
> >   die(_("failed to format default config value"));
>
> Together with key_ and default_value, you mean?
>
> >
> >> +test_expect_success 'does not allow --default without --get' '
> >> +	test_must_fail git config --default quux --unset a >output 2>&1 &&
> >> +	test_i18ngrep "\-\-default is only applicable to" output
> >> +'
> >
> > I think "a" here needs to be "a.section". I get:
> >
> >   error: key does not contain a section: a
>
> "section.var"?  That aside, even with a properly formatted key, I
> seem to get an empty output here, so this may need a bit more work.

This should be fixed in the latest re-roll, v6:

	expecting success:
					test_must_fail git config --default=quux --unset a.section >output 2>&1 &&
					test_i18ngrep "\-\-default is only applicable to" output

	error: --default is only applicable to --get
	ok 5 - does not allow --default without --get


Thanks,
Taylor
