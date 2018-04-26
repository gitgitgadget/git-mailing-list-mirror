Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6CAC1F404
	for <e@80x24.org>; Thu, 26 Apr 2018 09:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755073AbeDZJxd (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 05:53:33 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37499 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755036AbeDZJtt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 05:49:49 -0400
Received: by mail-wm0-f54.google.com with SMTP id l16so12055831wmh.2
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dwVCcurcskJj+IDvCQT3v0nkDXPR84zY7bLJmB5YPyE=;
        b=NEzChcpCGJwDjwRdFeespon81cnfBUKSdYKt1BFTnci6dYPDuhqQtreBRVdioiSG0T
         kN48qaJnw/dtUmqYxsLA9UuuFqUnTrSQRX8p/VKOMI9Lbcigs+pydQy2l/C1gYCJRPwx
         ZhX1KJ100hOnnOsgVedBSCt8uId5AWmWPqdoew1nticN8qwDqcPJFM9kpyYnla9BvxY/
         xE73qgqPv1RN+kXt4OXSa7fw8qRu3qGQb8NfBbh5u9lgMUwbZmU1qXnC2dp598XYnwLy
         sRiInn2+7xRMF2Ig31cMgSR/yNNDuATbeG/cMMzsz68Urd6jYFrCxpQzfF9TE3n/uGU4
         n1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dwVCcurcskJj+IDvCQT3v0nkDXPR84zY7bLJmB5YPyE=;
        b=eenXgMFyh2gClSB1jXn+oZl9aQ68XGgdCXp4B5kTgmFugcDl7NAa50rDjLf8iriU64
         Wme6mlJkadiLgZMY/YGCCLulEi+T3bVKVIikNMazYDB3rxU8qoj6h0KAl16PlEVJa0cT
         aNqmETX/IJfJAYQlfmjLCC7zd4f1t/7OyN1xa/BXNOwtv27EzvA2ylBNGbjSLSXzVxSF
         fEiwiO+QtqHATzw+QrZgaOtZ0gclZ5ybdp1uml0D6D9oY3/9Bk5E/0NV/m9XEcx6PKhh
         nTvZjuwmG8k8xGgEFDxAk+Xs8Q05SKQvFwP8PFqsbMI3Q6PdMVglihVko6TabZqUKPBx
         qTCQ==
X-Gm-Message-State: ALQs6tCI2yl4mpQdT60yosOqI0WCIkqf+bU0CjiVqbmbYt0+qaDXwNF9
        1aqYovt6ekwqsf/FgSCR3zuJxGN0
X-Google-Smtp-Source: AB8JxZrcqMGwTqtvsFTmrttL9NPsu3wjLSwKoR7cP58sfqbShtiu7srLG9QyYDVaBqJU46K2GILApg==
X-Received: by 10.28.216.13 with SMTP id p13mr8149426wmg.32.1524736187685;
        Thu, 26 Apr 2018 02:49:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p35-v6sm26120345wrb.12.2018.04.26.02.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Apr 2018 02:49:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/5] builtin/config.c: support `--type=<type>` as preferred alias for `--<type>`
References: <cover.1524716420.git.me@ttaylorr.com>
        <cover.1524722247.git.me@ttaylorr.com>
        <404da8bdeb9808d2dfcfdf09bc62c76195c9a08c.1524722247.git.me@ttaylorr.com>
Date:   Thu, 26 Apr 2018 18:49:46 +0900
In-Reply-To: <404da8bdeb9808d2dfcfdf09bc62c76195c9a08c.1524722247.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 25 Apr 2018 22:58:32 -0700")
Message-ID: <xmqqmuxq1emd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> +static int option_parse_type(const struct option *opt, const char *arg,
> +			     int unset)
> +{
> +	/*
> +	 * To support '--<type>' style flags, begin with new_type equal to
> +	 * opt->defval.
> +	 */
> +	int new_type = opt->defval;
> +	int *to_type = opt->value;
> +
> +	if (unset) {
> +		*((int *) opt->value) = 0;

As you moved the definition of to_type higher than the previous
rounds, you can already use it here to avoid cryptic casting, i.e.

		*to_type = 0;

no?

> +		return 0;
> +	}
