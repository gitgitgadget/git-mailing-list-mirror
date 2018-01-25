Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CFED1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 19:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeAYTSu (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 14:18:50 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40001 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeAYTSt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 14:18:49 -0500
Received: by mail-pf0-f195.google.com with SMTP id i66so6479724pfd.7
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 11:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Mu7HkwRaP0pYhuyrWR6B3l74+Q0brVRxLqIlWQ1hUIY=;
        b=eI5YfEk0+kizb7k/dqr+hnVt2PYR8ESwxUp9CjRRWsoC/5HIIyqTcX5g+ikeVV7JaB
         +wQ15EiO/dWl4GH1PPf3YikYKdPOVLcUBqyzl+UirdAbPnEPh+o7LHOHSoxodSCTrYJ/
         YZZQaFj6I2lly+8JwMBzrO5PX7RNSwmFk14i2aj9tTrVIaU5pWjfIxPbXS6PB1TuThWm
         1q3WJijxrqfo68+w7aiaoKkVF5rxA9vKnGXkWH7/j5wZQv18pH0lTJZ9YUThbQokk7Qn
         EI7M2xiQvyYX8Lj1p9DFEw+Yi6EfARhkemM3qRoszJyxiF3b6GIKcPtqO0+kS+dmfYMn
         UkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Mu7HkwRaP0pYhuyrWR6B3l74+Q0brVRxLqIlWQ1hUIY=;
        b=iRLhCU6HkeSHHfOzd8n8UOcFA5YMAnhI8uBI1NnU5XiAL7SRlXbPQCqsB8qfCfDGve
         UaOTdcwbGdEM+tZBl9tQcM0oHLtQ7s+iY43taRVOswR+I2obrxaIPoSkyrQ2HjHJjary
         milue17D6qnT8ft7Tomp3Ev/Q25rLAqTXotbHYAe1p1WC6ppXk8monUYnD/PInBLNrtZ
         /w/QaPPf57pTXOQREI6yfPJH0jS1PVwTVJTOBFnubRNbqlptT5lgcgu8gO8B4aCWcQYh
         5uxOxGVZ/w040eyjtXaxmhUYA2r6zlbPDlsVBh5B6jZhHa5jnYpx6bKv4Ar8s/qPjy1S
         03Rg==
X-Gm-Message-State: AKwxyteOxRxUTsaCkB7dEKUva+ACdDqnuFsQLZORWcPs1Fso64DruSkH
        Wj0tRdO71Xl65UMEEUywZDw=
X-Google-Smtp-Source: AH8x226Z6RnfyDPo4xBgY8j5lET5BoZSzavNd//1S2s0bGk39RRxzuEIN9QNejswm3kS2iwVlX9QSA==
X-Received: by 2002:a17:902:fa2:: with SMTP id 31-v6mr10816768plz.346.1516907928390;
        Thu, 25 Jan 2018 11:18:48 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f924:a479:e3c:a7cc])
        by smtp.gmail.com with ESMTPSA id x8sm15829764pfk.123.2018.01.25.11.18.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 11:18:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     robbat2@gentoo.org, git@vger.kernel.org
Subject: Re: [PATCH] builtin/pull: respect verbosity settings in submodules
References: <robbat2-20180120T054223-685328376Z@orbis-terrarum.net>
        <20180125190817.145041-1-sbeller@google.com>
Date:   Thu, 25 Jan 2018 11:18:46 -0800
In-Reply-To: <20180125190817.145041-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 25 Jan 2018 11:08:17 -0800")
Message-ID: <xmqqk1w5agrt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In a6d7eb2c7a (pull: optionally rebase submodules (remote submodule
> changes only), 2017-06-23), we taught Git how to rebase submodules in
> a pull. However we missed to pass on the verbosity settings.

Makes sense.  Thanks.

>
> Reported-by: Robin H. Johnson <robbat2@gentoo.org>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/pull.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 511dbbe0f6..1876271af9 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -574,6 +574,7 @@ static int rebase_submodules(void)
>  	cp.no_stdin = 1;
>  	argv_array_pushl(&cp.args, "submodule", "update",
>  				   "--recursive", "--rebase", NULL);
> +	argv_push_verbosity(&cp.args);
>  
>  	return run_command(&cp);
>  }
> @@ -586,6 +587,7 @@ static int update_submodules(void)
>  	cp.no_stdin = 1;
>  	argv_array_pushl(&cp.args, "submodule", "update",
>  				   "--recursive", "--checkout", NULL);
> +	argv_push_verbosity(&cp.args);
>  
>  	return run_command(&cp);
>  }
