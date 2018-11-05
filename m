Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A70F1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 07:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbeKEQ0n (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 11:26:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34566 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbeKEQ0n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 11:26:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so8219805wre.1
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 23:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pLGvD36+vpv9CXAGoSFQB/XjLGLZhNzfb2IupJSdGac=;
        b=of247Y7NGg0XcSzjzlRrg0EInM0XY+1C3kCxiuvjt85lHJAbFWCd0IH1f7+sJwz5X/
         iZUBQEG6lL8peHJcFC7ZsDB49UAoN50hKt3AdymVUhm9lDFrxsS41S8WYAxAOAQPQzGc
         ZS0tZ8tjJ35QG0GV89emNQbpNek4JgP7WBuhBekrvCuk/vijZt2gKnNmvvbFCM2ked8h
         HfiV5rM/xyB/73IZ1zzwSckDxMDcE31vWuWllSXYBQn3knpeTGGFo80I9+YRSCob6lB9
         IX8+im7aaKXnL4H88XxzkOKx+kc1dwihnXKlfboJZi4EyJ9lFIOOf05SbuHzql/EDdE9
         Uezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pLGvD36+vpv9CXAGoSFQB/XjLGLZhNzfb2IupJSdGac=;
        b=sj19ajK5TS3/tYQpOixxB/tJrnppjwxP1j+Amm1q4L758DthBtjKn7Uww4MJPtHUC5
         hHOEUhd5clSwSJ/Wcrgj7LmvWZ9tShOzEzoXjn4P72USfK3JJf3gCPcxSnQHwLPOo3eI
         I/2AlPADkgL46uvGVaJFwlobN+eYT559H6jaT8tqy2KfVj12Yt4FPQpYPYjgn85Gi00W
         794IShryeMZQnKrzN56rNaN0b2/R5rq+X4idVjHY63pjHrhKvHX9vaN1seUxpPSft0g7
         W6ycs9hpala2y7uTtZ0Di5NxWh7b+YezBfB9XnG2CGBpPpNzN96mDXLzEH4KIK96QWzV
         KEdg==
X-Gm-Message-State: AGRZ1gLSVilua7RPAuTL+GSzsgIwjhlwwwVHjTMR29As9PaszKRMDbwu
        hH8+PDg6Hv3H826Rmhtme4A=
X-Google-Smtp-Source: AJdET5fnsTR8SDz0oXbQryJF7B2Jk8xLbprR3RTTgTqWvHfcCyVcBR7hbWJA3t/N1FTBH1pFIRMUjQ==
X-Received: by 2002:a05:6000:1048:: with SMTP id c8mr16985075wrx.171.1541401708339;
        Sun, 04 Nov 2018 23:08:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g10-v6sm28611559wru.39.2018.11.04.23.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 23:08:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/13] am: handle --no-patch-format option
References: <20181105063718.GA24877@sigill.intra.peff.net>
        <20181105063839.GB25864@sigill.intra.peff.net>
Date:   Mon, 05 Nov 2018 16:08:27 +0900
In-Reply-To: <20181105063839.GB25864@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 5 Nov 2018 01:38:39 -0500")
Message-ID: <xmqq8t28huhg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Running "git am --no-patch-format" will currently segfault, since it
> tries to parse a NULL argument. Instead, let's have it cancel any
> previous --patch-format option.

Makes perfect sense.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/am.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 3ee9a9d2a9..dcb880b699 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2165,7 +2165,9 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
>  {
>  	int *opt_value = opt->value;
>  
> -	if (!strcmp(arg, "mbox"))
> +	if (unset)
> +		*opt_value = PATCH_FORMAT_UNKNOWN;
> +	else if (!strcmp(arg, "mbox"))
>  		*opt_value = PATCH_FORMAT_MBOX;
>  	else if (!strcmp(arg, "stgit"))
>  		*opt_value = PATCH_FORMAT_STGIT;
