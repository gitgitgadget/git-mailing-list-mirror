Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AF6C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 18:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E4060FD7
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 18:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhHQSNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 14:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhHQSNM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 14:13:12 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F37C0613CF
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 11:12:39 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id f15so19213106ilk.4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/wp8vI5iaGI+EqIfnLi4bCm+psqNVL/MUNdyLFV0vcc=;
        b=ECtfjOPgjf3KKAT0YLKD7k9TCgZSzU9Bhfv+3sUPFlQjkLyLkQRpK0eXxYoqXi9ydd
         9mwoXMc/xwmNpaoOIZzbKNlIrv79uJGR1aoTuy56xEaIyKYRRCJqprTDvJGSw8ZE/jpl
         HEQ8nvZ5/IoM9JMaIOL/d0M6qUDL0JwiyxbZXrYvuhptY28+QLzwnHPC+JJ7K64Kqrbm
         fZYvG+Z5tnFMzh1OABzX3R10YrD9AmaqGHJuNw627SFqHDXfoiuAZfrgOQ4zTMoPMKJg
         u92uEhNubgIoq+EyeskW/ehcD90Xv4NaeuBdWmdDGJSD6spv+l+hlThQ+AqzR6221ceW
         NhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/wp8vI5iaGI+EqIfnLi4bCm+psqNVL/MUNdyLFV0vcc=;
        b=adLFrkiC05dX/TI7aOQ2Ug6y5t8Di12esCrca2l9733LjamOPZCEQGXS3dlROBXCI/
         0/exq0TjBQtEN1zKJvK9I1ua/YD6mgTzuMckpUI2TjaGI0Pd5abgE5p5KcgPkFx+Y9ry
         er5Fo2hqKmM2bl2ZHBoUKMAmUIId/T/Ip0N/YqK+8dcVmpblpfHZbeETS2LITRGa/ile
         7T++wRRTaqt30BryrpjElVZKigr478WNNVXK+6+TxX14VebtTDaWNvjowfQz7UMKw1oE
         cy6CuRcrC7/d5RTMq4wy0gLNouUEUjnQgqDM8qzr1S63ZTB8AAouZ0kedcqIbZXnWYWv
         42XQ==
X-Gm-Message-State: AOAM531rhJZYdoou8/7oZrpjzKm3G/BAA6gNm67UFus5A654YRfcLvBG
        ikVwaPvWSPFiIAsDULJtBXs=
X-Google-Smtp-Source: ABdhPJxowmQadPub2aoFWtSkqgmSh5BbuAuEZhbBzk7sEHpOeodV48MoFpyLt+sBK4wWyGKefudfKA==
X-Received: by 2002:a92:da87:: with SMTP id u7mr3335751iln.297.1629223958553;
        Tue, 17 Aug 2021 11:12:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:dc75:b61d:e533:9004? ([2600:1700:e72:80a0:dc75:b61d:e533:9004])
        by smtp.gmail.com with ESMTPSA id o15sm1504258ilo.73.2021.08.17.11.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 11:12:37 -0700 (PDT)
Subject: Re: [PATCH 1/6] t1600-index: remove unnecessary redirection
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
 <20210817174938.3009923-2-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d8d8d59a-ecac-2cd5-18a3-f1cb65e48c2e@gmail.com>
Date:   Tue, 17 Aug 2021 14:12:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817174938.3009923-2-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2021 1:49 PM, SZEDER Gábor wrote:
> In a helper function in the 't1600-index.sh' test script the stderr
> of a 'git add' command is redirected to its stdout, but its stdout is
> not redirected anywhere.  So apparently this redirection is
> unnecessary, remove it.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  t/t1600-index.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t1600-index.sh b/t/t1600-index.sh
> index c9b9e718b8..5d10cec67a 100755
> --- a/t/t1600-index.sh
> +++ b/t/t1600-index.sh
> @@ -79,7 +79,7 @@ test_index_version () {
>  		else
>  			unset GIT_INDEX_VERSION
>  		fi &&
> -		git add a 2>&1 &&
> +		git add a &&
>  		echo $EXPECTED_OUTPUT_VERSION >expect &&
>  		test-tool index-version <.git/index >actual &&
>  		test_cmp expect actual

Since here we have a 'test_cmp expect actual', perhaps the
actual mistake is that the line isn't

	git add a 2>&1 >actual &&

What do you think about that?

Thanks,
-Stolee
