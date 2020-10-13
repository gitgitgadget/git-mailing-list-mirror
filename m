Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7C2C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 10:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38692207C3
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 10:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWLd92Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgJMKDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgJMKDv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 06:03:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17DBC0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 03:03:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e17so23236349wru.12
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 03:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=buq5m1ijq0KAhNEpdLUov3ygcsIXFCGYKp4dfzmu7VY=;
        b=CWLd92RoIbRTxOyQuwDOsYcBsoFKIc4s3/9ghrQsEgLzvpavPl7Sfcn/zbfwrRHPze
         XkGVwZwej9ZYTFtHh7DVGG3zvHbTElc+B0PfxxYLB1Ka3ctovQnfnPQdVkO1yGI7PYr3
         Ij5Zdyhdp3fIlVf0mt2Bqf/ggsx++iQAtxr4/7XvfGviqX5BVmgZPHHGXkSm0KFFFgAR
         qASG/HC5zWXf86mqjFY7XkV1cfVUrPsp5K1jYj9UkmCsf86OMIru3nZsRk1reCq8s90W
         Vy7KsU1xOuzeffEV4sHlz2CB+xZBj8JuwrswPQS5AoU3iusnvCdTfeqhogyOYYKWJk9q
         7tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=buq5m1ijq0KAhNEpdLUov3ygcsIXFCGYKp4dfzmu7VY=;
        b=OeqNhHy+nj3+udEGLC045oWD8ILgEq/kmxPQYNakcwyOrV470VqhBNtMaNmD3LloIN
         7+nXhh+oTZBM8AEMXpjewdwYRH2GTImdaJkJ0+VGU+T0N9LCnZFN/eI0VN44ym/HYUg7
         ylxqXlhKk7XnPJzJyDQFTd+fHklszLpr9GdwudCQT+YRGvBPhKDJZGLZv6/FC9y56LNY
         JzHy8k9nE0YfPjh1sFpna6aP6AIVLnQTJtEj0j6oiLyukhYEBtO4ptdPjc/gBDlaJ4gm
         wBQldUjGFPKQqx6XcgE38E7LhalCh6l468UtUAke433OIFW7mgsU3tUKVLU4kYm7LYSZ
         lHiQ==
X-Gm-Message-State: AOAM531z0yNs1K5V5+wZdkGVXRCY+jy6KrGHwGDqMHNDtEeW9iwN6cft
        kQBrDliPhQGZqfY9nKJwnTA=
X-Google-Smtp-Source: ABdhPJzh1Pcqq7XiSC5s2uqa1Qv6TQDvXIbbr69uQEMQ3QWXzrMG/olwf004JujL+uexcEhWD9Mi/Q==
X-Received: by 2002:adf:fd47:: with SMTP id h7mr28768807wrs.245.1602583430454;
        Tue, 13 Oct 2020 03:03:50 -0700 (PDT)
Received: from [192.168.1.201] (39.16.7.51.dyn.plus.net. [51.7.16.39])
        by smtp.googlemail.com with ESMTPSA id a3sm25840557wmb.46.2020.10.13.03.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 03:03:49 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] sequencer: pass explicit --no-gpg-sign to merge
To:     =?UTF-8?Q?Samuel_=c4=8cavoj?= <samuel@cavoj.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20201012234901.1356948-1-samuel@cavoj.net>
 <20201012234901.1356948-2-samuel@cavoj.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c408b835-a09d-d261-0b98-cd1d0db3610d@gmail.com>
Date:   Tue, 13 Oct 2020 11:03:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012234901.1356948-2-samuel@cavoj.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Samuel

On 13/10/2020 00:49, Samuel Čavoj wrote:
> The merge subcommand launched for merges with non-default strategy would
> use its own default behaviour to decide how to sign commits, regardless
> of what opts->gpg_sign was set to. For example the --no-gpg-sign flag
> given to rebase explicitly would get ignored, if commit.gpgsign was set
> to true.

That's a good explanation, thanks very much for adding this patch

Phillip

> 
> Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
> ---
>   sequencer.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 88ccff4838..043d606829 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3678,6 +3678,8 @@ static int do_merge(struct repository *r,
>   		strvec_push(&cmd.args, git_path_merge_msg(r));
>   		if (opts->gpg_sign)
>   			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> +		else
> +			strvec_push(&cmd.args, "--no-gpg-sign");
>   
>   		/* Add the tips to be merged */
>   		for (j = to_merge; j; j = j->next)
> 

