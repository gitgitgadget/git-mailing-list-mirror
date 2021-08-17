Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D180C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F108E61052
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 18:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhHQS3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 14:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhHQS3l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 14:29:41 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C049DC0613C1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 11:29:07 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o123so18844879qkf.12
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2ftTwAvMq6XPMXv9vAK/wAtkBsNph594gDb2S4OQx3Q=;
        b=Se/LjwnxUAHXC0NhLFaZlttzL7wZ49H+z5HJLFQOQnkJNiLty17yW+h9g57jsHELUo
         em6plQ8Dj3m7MxM2+tVnO7Q9vbdqrBysux1MX/tfbcJItljJdujnw9tOGtEWbWPFapBz
         XPQOm4gTwci2xNDVUapAR3/+5N110gC8BnmtJeIhiO+QItVQgCR+OLWUhAebQZamahTH
         5c1M8lL+YqNJ5wT9iLDRhOoIjVrh90T+WUrbsZXpm+vMiNCxgKK0qjjvlIRW/sWd1Nh4
         ba4AQIhr1UFkMoMkPwk5r3/mgGGJycciiMIowumLM5xUx7SSL9KW0IMZABrSV105GWmh
         nnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ftTwAvMq6XPMXv9vAK/wAtkBsNph594gDb2S4OQx3Q=;
        b=Gd24eI6PybRPWc6AuKXnR1M0qqLqBSdkHAD2bBcfC01p7rmmPDVZvM/CwU5TOfc17V
         nDDzRjx/sEe2eBGzwnNPFNop9FYmPszr/TXBdrGIQKCpd0zZn00llCwdGAig6SDNskpN
         aeMABXbRd21RJvnDmn2LPwDuFU9M2lzwwULjs9ejbBNyz02TvrVTRbEufQ0hvJ0Ig6qI
         VTigwMJ5mz+qGZ0Z7SO4CdlQmPloDEuBi3dW8Bq8vYqbQWgf01y6OB3URHj3lDbrrAsq
         sFSaaNR7up7Z4M8Dq8MFlzbjeRbCFLUx6aMXWjLo1/cZ1j6pyeT72PKptDfhsDkf9M+r
         HaWg==
X-Gm-Message-State: AOAM531d9ak2bQs23o1dN1qlhv5tYu6Jl9FMjWkblW2+pXsaUWwBqVTB
        NQF9/MaJhNnvAWjGkD6Q1bg=
X-Google-Smtp-Source: ABdhPJwPiRKtPh4OAWUV3qcktulGvpFjtZf55kEyNs0P0rkB6CBczjG1EodHVuEmoNrMIeeaJsfW3w==
X-Received: by 2002:a37:bc8:: with SMTP id 191mr5363352qkl.25.1629224946943;
        Tue, 17 Aug 2021 11:29:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:dc75:b61d:e533:9004? ([2600:1700:e72:80a0:dc75:b61d:e533:9004])
        by smtp.gmail.com with ESMTPSA id k8sm1539154qtp.14.2021.08.17.11.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 11:29:06 -0700 (PDT)
Subject: Re: [PATCH 6/6] read-cache: fix GIT_TEST_SPLIT_INDEX
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
 <20210817174938.3009923-7-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <edd7b53e-f0e9-b56c-e13d-63a2f963b703@gmail.com>
Date:   Tue, 17 Aug 2021 14:29:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817174938.3009923-7-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2021 1:49 PM, SZEDER Gábor wrote:

Sorry to crop all of your excellent description of why this wasn't
working before and why it will work now, but...

> +test_expect_success 'GIT_TEST_SPLIT_INDEX works' '
> +	git init git-test-split-index &&
> +	(
> +		cd git-test-split-index &&
> +		>file &&
> +		GIT_TEST_SPLIT_INDEX=1 git update-index --add file &&
> +		ls -l .git/sharedindex.* >actual &&
> +		test_line_count = 1 actual
> +	)
> +'
> +

This is really the critical piece to ensure we don't have a
similar problem in the future. Thanks!

-Stolee
