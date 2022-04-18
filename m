Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DC4C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 12:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbiDRMTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 08:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbiDRMTL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 08:19:11 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFA01B78C
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 05:16:19 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 204so4959468qkg.5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 05:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/iQq4DKLKMY/zZVMiivSfHFlGfs2VP6ilhQKZNSI6hw=;
        b=hEHI4T7+Ti2/bgGOTQRIDGdPKgAWL0FCNn56Y9DCAVxnpUKr4LLvvBPOr2l8NHu177
         gMhHhNvR8rRv2sawK/TP7i2QCUb01MxY+iLkr4cLv8HZrAeBsXHFOCsczeardImkIT/8
         DPeieTmHHeopmd4Qn5ajYIy0+xvdJmg7c+OI1mrOecbXLD5Wy+FvVAh+hUzza7eCpmz6
         XF80rdYOpYa91GM/+WHPWvUEgTLo56xqhKgIbixoZzZeBqP9O+GgOMsIkmtvbc55asfM
         gbx9BYsnIIsIrOGidQeSPv4xoGb3A/eaHy9cATQEY3fI2790v3NxvnHSiHzoYRHMHlwr
         tO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/iQq4DKLKMY/zZVMiivSfHFlGfs2VP6ilhQKZNSI6hw=;
        b=MNv9cB+3gAoXwtKT4izTofm93etPSXmUzeTcJ3OPnEBMrEE/05NqbUZg4xMB77nwM5
         1szj/GdVqOYHshgkLQlGNVMLiuts+lij/qgpMHdmyAYNz78LaxWdddpUv8/fgM1Qf/tU
         bGpgu3iBwHiMm6a83wWv2rUkNdTbo3eh0LJroo7YXLwg8vANZJGclxZYdNO/8nfx5vzq
         UBAGN+E9JCDNqk/pyMKCymTIvABDOZZcS5iiWDbPOBS9XIbHi+N5VYla5eKvXcQYKh2M
         rOK+0IU/448aNg+DflRa3euIbkmud7jzsJ2tJSM+r+V01Rj5Jh0fYkxde1jghdTHv62A
         0jqQ==
X-Gm-Message-State: AOAM533A3a3IPZsrIPlbEYXfGcM4lKuAsWA1bc7GHHvSkMPIGFXAut3P
        vxBSsG6kJg/COm5aGsU74WRp
X-Google-Smtp-Source: ABdhPJw3Z7pXsSaAgk8PdilUy3I2520qI/W+GFTXvyXj1xua+jDGQUMDgtNOO+WaMM0dNBGzKx+w8w==
X-Received: by 2002:a05:620a:2943:b0:69e:7ee2:f292 with SMTP id n3-20020a05620a294300b0069e7ee2f292mr5142672qkp.348.1650284178595;
        Mon, 18 Apr 2022 05:16:18 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w9-20020a05620a444900b00699b2ba4cd1sm6757274qkp.56.2022.04.18.05.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 05:16:18 -0700 (PDT)
Message-ID: <8ec81980-32a4-dbd7-a788-e7f5a012ba09@github.com>
Date:   Mon, 18 Apr 2022 08:16:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] area: /t/t4204-log.sh, partially modernized test script
 t4202
Content-Language: en-US
To:     Jack McGuinness via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jack McGuinness <jmcguinness2@ucmerced.edu>
References: <pull.1218.git.1650096550631.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1218.git.1650096550631.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/16/2022 4:09 AM, Jack McGuinness via GitGitGadget wrote:> From: Jack <jmcguinness2@ucmerced.edu>
> 
> Remove test body indentations made with spaces, replace with tabs.

This goal has a subtle issue that I'll point out below.

> Remove blank lines at start and end of test bodies.
These are very easy to review.
>  test_expect_success 'decorate-refs-exclude with glob' '
> @@ -2037,7 +2016,7 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 miss
>  	GNUPGHOME=. git log --graph --show-signature -n1 plain-x509-nokey >actual &&
>  	grep "^|\\\  merged tag" actual &&
>  	grep -e "^| | gpgsm: certificate not found" \
> -	     -e "^| | gpgsm: failed to find the certificate: Not found" actual

In this example, the "\" means that the command is continuing to the next
line. For such continuations, it is OK to use something other than a full
tab, for stylistic reasons.

Specifically here, the "-e" arguments have vertical alignment in the old
version.

Since the leading whitespace here is a tab followed by five spaces, it
would not appear as an error in "git log --check".

(This is all to say, leave this line as-is.)
>  test_expect_success 'log --end-of-options' '
> -       git update-ref refs/heads/--source HEAD &&
> -       git log --end-of-options --source >actual &&
> -       git log >expect &&
> -       test_cmp expect actual
> +	   git update-ref refs/heads/--source HEAD &&
> +	   git log --end-of-options --source >actual &&
> +	   git log >expect &&
> +	   test_cmp expect actual
>  '

Here, you have issues because you are replacing seven spaces with a tab
PLUS three spaces. While that won't be a complaint in "git log --check",
it is incorrect in this case. It should be a single tab on the left of
these lines.

I feel like maybe you did a find/replace taking four spaces and converting
them to tabs. The real situation is more subtle here.

Thanks,
-Stolee
