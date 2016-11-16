Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 943CF2021E
	for <e@80x24.org>; Wed, 16 Nov 2016 00:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbcKPAdv (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 19:33:51 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35089 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752554AbcKPAdu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 19:33:50 -0500
Received: by mail-pf0-f172.google.com with SMTP id i88so38813440pfk.2
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 16:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1mXq9szOK4e6807rK5JlOBkjduuBDoGl6gCG63sXbJc=;
        b=I4Qqfasd+Jh5f0RRc1pQ1pS48t7uFChS490Tlp5oclsX2BMNhZFGbh9E4N1dJR1O8p
         f86cPgur562BHng1AL9HDOhk/kTzVS0py4cOQxwv+zQmFDHTDEBbPRrLSs5MjHJiYc71
         EJ92je5D01ZtnC6r7g5thaTudv5YR49/oOx8EGbMZA0GUwFlOfXLS0JVixMVtutPRo5F
         4P8Vz8P7216rBwgadU/cfHiIeBY+vTxf55Ks8QOCfvi7vetpTUQuwPsjHRLa5nBoqfP/
         djG1E0KGftD7eOxdC1v3r3pQNPrHq0F7ziy2ty992ISD61VhyC2p7bYgq3vdmE9w/k4b
         ovQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1mXq9szOK4e6807rK5JlOBkjduuBDoGl6gCG63sXbJc=;
        b=Uc6yrHkqUnND5g6t3zprcYzVS9eqDe25nlZvs1wBBA4Q30+V+ivVs9opJ6SDA76fnk
         6DeFD9g1REw9TAyCrUd0apj+hi8FCbtaMcnNlZOdAMLUhkO3cn+uA2xGHYPT9G1rMfDi
         SdJjKjKAfK1jDFMZ/1Ukc8W+zzvT0q5TVwg/Tzdov+F8YzycGs+SRyWOS319hlV+1ic3
         RAW62LxBDGJ2EI8rMtAeMeOu7ZQgXhWUoDF4+3wznX0Ze+MnAm8ZH2lFQ80rxOrrDEvW
         qRQ4yA7q/CGYHann5AMrSmECHtRWuLMFeWZeRwotrGWlqEhi42nbNxz4vd3nAWM7uN1K
         K+Lw==
X-Gm-Message-State: ABUngvcRo+wBXQEKNgg/4EM8CUkGDf8JFb8yJfyHtE0RbqdU07uXjuo4s++UMtp81XlGqRfF
X-Received: by 10.99.65.65 with SMTP id o62mr1890904pga.73.1479256429826;
        Tue, 15 Nov 2016 16:33:49 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f0a8:aad3:5a98:9829])
        by smtp.gmail.com with ESMTPSA id t89sm44374451pfe.50.2016.11.15.16.33.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 16:33:48 -0800 (PST)
Date:   Tue, 15 Nov 2016 16:33:47 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        mogulguy10@gmail.com, David.Turner@twosigma.com
Subject: Re: [PATCH 14/16] checkout: recurse into submodules if asked to
Message-ID: <20161116003347.GJ66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-15-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161115230651.23953-15-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15, Stefan Beller wrote:
> +int option_parse_recurse_submodules(const struct option *opt,
> +				    const char *arg, int unset)
> +{
> +	if (unset) {
> +		recurse_submodules = RECURSE_SUBMODULES_OFF;
> +		return 0;
> +	}
> +	if (arg)
> +		recurse_submodules =
> +			parse_update_recurse_submodules_arg(opt->long_name,
> +							    arg);
> +	else
> +		recurse_submodules = RECURSE_SUBMODULES_ON;
> +
> +	return 0;
> +}

I assume it is ok to always return 0 from this function?  Also, I know
we don't like having braces on single statement if's but it is a bit
hard to read that multi-line statement without braces.  But that's just
my opinion :)


-- 
Brandon Williams
