Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1111F45F
	for <e@80x24.org>; Tue,  7 May 2019 22:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfEGWp3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 18:45:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40932 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGWp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 18:45:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so9397837pfn.7
        for <git@vger.kernel.org>; Tue, 07 May 2019 15:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1r5nDnB15f+WUZmWcCH1yJbhHRh2WEVw/iIE6YqA6nU=;
        b=muuxO5xmhLEVEzR9cLXywfWx6eSiTLL8ee7lU31E1cXFkyvML+yI2kb8UsdUCCpXrS
         E8vRO/BA+nQty2xWLNiRCWxDMtqoPY7A2IFCCNTBMUBIx6Sd3luE0hJXxQ6FovdNP6Sy
         MIDP6aQYxkNFt6hhRv6hwSF8ju/UoBfT59Y6MVJx0sEskcAmJc8fXkAEDkqO829aR/Pg
         jGMwCb00adcI/IgZpud0QhInVsynuQr66UkagKSpde2xZ37EUC00fo0FwKEiJzj0jEt4
         Ccgqyw6B0jtNd1uQEUEZyOLyTcsp5knFUyjp1EtPVxy9m9Kx2eG0hfeW/ZTFaAjJdA62
         ypJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=1r5nDnB15f+WUZmWcCH1yJbhHRh2WEVw/iIE6YqA6nU=;
        b=PJMtnxaTCICKdnl9kqq+ATW4+o4aYMQwVDUMgsctFZ1WLNO8d35PFXC3i5uC+Z0AAB
         FOevkraZiMfUyWY9cmVOqyYTk1aitjEOLLzDpQIeHwOJe9vTsjU7GSbWJldBoEWDToJT
         GYtVQHFhAJk/hGBjb0XeWNqggw/AlAjkr6rE4+iVt4yKhiK5CwzSmKSj0J417N9maV4C
         H7MagNwQmD1Sfa5Qn/9sOUZpsh3I25OqKhSAof+5z6IUy8rgwPF51s9VrnMuwYcn7WLf
         oy71Ii5Rfmj9UA6M1lvElzLz4xAquSE8FmOoW4ziHzk602NgPcmWquxGS+r6OoBWir0r
         647Q==
X-Gm-Message-State: APjAAAXeUzAzMlOXmQbxTHWC6Can1qJoh71gtorXoEaf+XFTOdDE9SD/
        NTYKmg1cQ+DrFJnn3j5CBcOmLA==
X-Google-Smtp-Source: APXvYqxzxuNJrEKt7OW8tm67VycbcC+Om30R05y68xMMeATWyltECNd9nseuHsk8WnCUYo0oXEXR7A==
X-Received: by 2002:a65:6644:: with SMTP id z4mr42730533pgv.300.1557269127613;
        Tue, 07 May 2019 15:45:27 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id 13sm18004054pfi.172.2019.05.07.15.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 15:45:26 -0700 (PDT)
Date:   Tue, 7 May 2019 15:45:20 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        stolee@gmail.com
Subject: Re: [PATCH] t/lib-httpd: pass LSAN_OPTIONS through apache
Message-ID: <20190507224520.GD26779@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        stolee@gmail.com
References: <20190507223046.GA16315@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507223046.GA16315@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.05.07 18:30, Jeff King wrote:
> Just as we instruct Apache to pass through ASAN_OPTIONS (so that
> server-side Git programs it spawns will respect our options while
> running the tests), we should do the same with LSAN_OPTIONS. Otherwise
> trying to collect a list of leaks like:
> 
>     export LSAN_OPTIONS=exitcode=0:log_path=/tmp/lsan
>     make SANITIZE=leak test
> 
> won't work for http tests (the server-side programs won't log their
> leaks to the right place, and they'll prematurely die, producing a
> spurious test failure).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Found this after giving similar advice in
> 
>   https://public-inbox.org/git/20190507222601.GA976@sigill.intra.peff.net/
> 
>  t/lib-httpd/apache.conf | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 06a81b54c7..5c1c86c193 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -76,6 +76,7 @@ PassEnv GIT_VALGRIND
>  PassEnv GIT_VALGRIND_OPTIONS
>  PassEnv GNUPGHOME
>  PassEnv ASAN_OPTIONS
> +PassEnv LSAN_OPTIONS
>  PassEnv GIT_TRACE
>  PassEnv GIT_CONFIG_NOSYSTEM
>  PassEnv GIT_TEST_SIDEBAND_ALL
> -- 
> 2.21.0.1314.g224b191707

Looks good to me.
