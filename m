Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57E31F453
	for <e@80x24.org>; Wed, 20 Feb 2019 20:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfBTUmA (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 15:42:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36631 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfBTUl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 15:41:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id j125so7773126wmj.1
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 12:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=X+AZuQJh/VJGVSzl0p/42jAiAl2uOQ1+ADjdUGk3XHA=;
        b=ZxloxPsnof/HcNxABNppBkQ6cac4By2oKaG9F1Dv8Rxzrk4sGthNRCNrj0on+ej+5i
         /RyDotbLNk2F5RutmdWI9rl81uM6Czv0/iOXsoOaN8I1+CsKgtG5ix4I9DGmzuFqs0KM
         9XyBmmETgdSrcYagS0QBuc002M3FLiTiE0fZa4gqmn55sHcgK91ZNCzWwwC6u92xnOvD
         DKQvrndnm8Wibyz04PO4JLlpaa87lfDaiRtIfLXXfpUICPIx3wrkeZxq0m1dgX2s8mM+
         tbCMLTw4iLOFQtMVQvhQnWyWwIIwVvC8yQ6mUEdmXaQcAyc3DGXfDPzWYsiojBMjDOzB
         u9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=X+AZuQJh/VJGVSzl0p/42jAiAl2uOQ1+ADjdUGk3XHA=;
        b=gk5YvZkhiRWXRHnVZsGhHAcWW1DhoTtdSIZeZ/y4/F9W/gm2apZnpW/7ExH4WbkSUo
         q8srqy95BrONwNQZO5kfB59E8/If1MoHcyZ5SJu/Ycro0XXmCOMmVw+82hQzII2pn4Wb
         xyefT/YtFR4Ub6q/+kyKxkocm3FQk28FSqrOVSeND2OkCuUFD8kechLrHD8Ko6pvmZX3
         abevcAua8YsRqcTXq2oJYQXk+qToQF4PzLvaNyPojA0+/W0Kl79x1K0y08V+AltPVwQZ
         vMpClsrKFSqu18vPguGnVCNUHWf6+gZU2/Uxx5i5BQFWbet5uFEAPS8+7Lg54n6qCdSM
         d1aA==
X-Gm-Message-State: AHQUAuZWvLuw5hSo1clezxF9Ae2M2nDpWZTSJgnM2LsdB/FVqJ57yrKX
        lHUSP9TLbNCH0W+VbS3a/ec=
X-Google-Smtp-Source: AHgI3Ib9z3vzj1WIvr/J1hMxdpMU05OqffqepFf6HQb6b4ALZbyAvX8eT2Ywr46sk11mq63ylj479g==
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr8116936wmg.90.1550695316058;
        Wed, 20 Feb 2019 12:41:56 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p5sm4026258wmh.16.2019.02.20.12.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 12:41:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 01/21] diff-parseopt: convert --patch-with-raw
References: <20190207103326.10693-1-pclouds@gmail.com>
        <20190216113655.25728-1-pclouds@gmail.com>
        <20190216113655.25728-2-pclouds@gmail.com>
Date:   Wed, 20 Feb 2019 12:41:54 -0800
In-Reply-To: <20190216113655.25728-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 16 Feb 2019 18:36:35 +0700")
Message-ID: <xmqq5ztew5t9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 4bc9df7362..12e333c67f 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4901,6 +4901,10 @@ static void prep_parse_options(struct diff_options *options)
>  		OPT_BIT_F(0, "raw", &options->output_format,
>  			  N_("generate the diff in raw format"),
>  			  DIFF_FORMAT_RAW, PARSE_OPT_NONEG),
> +		OPT_BITOP(0, "patch-with-raw", &options->output_format,
> +			  N_("synonym for '-p --raw'"),
> +			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
> +			  DIFF_FORMAT_NO_OUTPUT),
>  		OPT_END()
>  	};
>  
> @@ -4929,10 +4933,7 @@ int diff_opt_parse(struct diff_options *options,
>  		return ac;
>  
>  	/* Output format options */
> -	if (!strcmp(arg, "--patch-with-raw")) {
> -		enable_patch_output(&options->output_format);
> -		options->output_format |= DIFF_FORMAT_RAW;
> -	} else if (!strcmp(arg, "--numstat"))
> +	if (!strcmp(arg, "--numstat"))
>  		options->output_format |= DIFF_FORMAT_NUMSTAT;
>  	else if (!strcmp(arg, "--shortstat"))
>  		options->output_format |= DIFF_FORMAT_SHORTSTAT;

Quite straight-forward, and makes us anticipate the eventual removal
of enable_patch_output() helper function  ;-)

