Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3975DC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CFE6144D
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhDWJzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 05:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhDWJze (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 05:55:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B518C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 02:54:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r12so73045170ejr.5
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=orUBrhwwyLHgxl0SF7xrBmp3o10L7HOVakrUAYyhU7Y=;
        b=E9cIYtrghdvMd+vKFoFc4iyEI7pK/Zze07Fk8zORtmNdt9BdDxla+L9hyCmc1EzNVR
         zEFc+lP9cTE8CPC/1irgoCLv6JKPFZJKfq4Daw3VFa3wxvqGImkySSxXfoso/THOl8oN
         uWk8Z7gqBmTF66D8jjxerFplQtW1llS5ZjzT6fk2OUIIhxYDBrZ7cHHh1itDF38TJQCl
         SIyquxJgtQq7I381LZhY0Jh+cvs0zjO3bQuXHE10e03//MBrVDqr+dX/77GEVIb6d6iG
         8nBg2I+VLMLkpfwoBeauCSWtaTcoWQB6apiB2Dvkmps5bbDgZ82K0Hln7LU2y/5gedEL
         j+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=orUBrhwwyLHgxl0SF7xrBmp3o10L7HOVakrUAYyhU7Y=;
        b=TKpr0W8v3GqukcM0HCUDFWqADNIpmTKnI22uhFQDY1k9duBie/OY1EyBpKq/vUerzB
         Zb6eCsesC+3Whg63Af21LpcRj3ldVRA/owSzKdFNauqu+jieS83MBPLTnPzanx3C1Awf
         z5DrLcwSqNZE5LzTp4nkY0RKbIRTNndQSO7Ue/MYK1UshzB5SdXRWa4u7PlyLMlxJPn4
         bfiMlUcTMZdwncsO3b6GyL31IGpjbk4Gnb+f2I0CY0dnOSSJHgs7CiZq6WxWvcfWiErc
         dpBE7Ekzi5wJxMMmCBoGwvkz6ZEJqKbltYbDHcD8Ob1u8STWu4iqXgBix5pcamKbzcTU
         +XMg==
X-Gm-Message-State: AOAM531KvLsk8qxSNpFiOKAWtm7dMns8PFQ49LjcuVZDvOz9aAOyaBCn
        gr9fHC5ViStp3qfrbXGu8KiEwekeLG0=
X-Google-Smtp-Source: ABdhPJxuxLNBw9CQPgW/XCcfeHsT7Zkuoyd4rHBsAaoi7DnbxEPCe/Euk1a8Jqd4BM2kUXDeH1LFdA==
X-Received: by 2002:a17:906:7257:: with SMTP id n23mr3359079ejk.412.1619171697081;
        Fri, 23 Apr 2021 02:54:57 -0700 (PDT)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id la24sm3839460ejb.71.2021.04.23.02.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 02:54:56 -0700 (PDT)
Subject: Re: [RFC PATCH v2 3/4] t7006-pager.sh: more lenient trace checking
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20210423001539.4059524-1-emilyshaffer@google.com>
 <20210423001539.4059524-4-emilyshaffer@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f4c3688e-8316-7f66-3bcb-d8aaeef3a7d3@gmail.com>
Date:   Fri, 23 Apr 2021 10:54:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210423001539.4059524-4-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily

On 23/04/2021 01:15, Emily Shaffer wrote:
> A number of tests in t7006-pager.sh are, as a side effect, checking that
> 'git log' does not invoke any child processes besides the pager. There
> is no reason for that guarantee, and it is not explicitly the purpose of
> these tests, so let's make the checking more intelligent and flexible.
> 
> child_start and child_exit events share a child ID - using that child
> ID, we can try to disambiguate which child_exit belongs to which
> child_start and limit our validation to only the pager's child process.

I've not looked at this test file properly but if we want to check that 
the pager is invoked can we use a script that writes a file when it has 
been run as the pager and just cleanup that file at the end of each test 
case?

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>   t/t7006-pager.sh | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index 0e7cf75435..ac2d91d56b 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -676,7 +676,9 @@ test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
>   		test_terminal git log
>   	fi &&
>   
> -	grep child_exit trace.normal >child-exits &&
> +	PAGER_CHILD_ID=$(grep pager-used trace.normal | \
> +			 sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&

If you want to save a process you could use sed to do the job of the 
grep command. I think this should do it

sed -n -e "/child_exit/ {" -e "s/child_start\[\([0-9]\+\)\].*/\1/p" -e "}"

> +	grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&

Why is $PAGER_CHILD_ID unquoted?

Best Wishes

Phillip

>   	test_line_count = 1 child-exits &&
>   	grep " code:0 " child-exits &&
>   	test_path_is_file pager-used
> @@ -697,7 +699,9 @@ test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
>   		test_terminal git log
>   	fi &&
>   
> -	grep child_exit trace.normal >child-exits &&
> +	PAGER_CHILD_ID=$(grep pager-used trace.normal | \
> +			 sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
> +	grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
>   	test_line_count = 1 child-exits &&
>   	grep " code:1 " child-exits &&
>   	test_path_is_file pager-used
> @@ -718,7 +722,9 @@ test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
>   		test_terminal git log
>   	fi &&
>   
> -	grep child_exit trace.normal >child-exits &&
> +	PAGER_CHILD_ID=$(grep pager-used trace.normal | \
> +			 sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
> +	grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
>   	test_line_count = 1 child-exits &&
>   	grep " code:1 " child-exits &&
>   	test_path_is_file pager-used
> @@ -739,7 +745,9 @@ test_expect_success TTY 'git discards nonexisting pager without SIGPIPE' '
>   		test_terminal git log
>   	fi &&
>   
> -	grep child_exit trace.normal >child-exits &&
> +	PAGER_CHILD_ID=$(grep does-not-exist trace.normal | \
> +			 sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
> +	grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
>   	test_line_count = 1 child-exits &&
>   	grep " code:127 " child-exits &&
>   	test_path_is_file pager-used
> @@ -760,7 +768,9 @@ test_expect_success TTY 'git attempts to page to nonexisting pager command, gets
>   		test_terminal git log
>   	fi &&
>   
> -	grep child_exit trace.normal >child-exits &&
> +	PAGER_CHILD_ID=$(grep does-not-exist trace.normal | \
> +			 sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
> +	grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
>   	test_line_count = 1 child-exits &&
>   	grep " code:-1 " child-exits
>   '
> @@ -780,7 +790,9 @@ test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
>   		test_terminal git log
>   	fi &&
>   
> -	grep child_exit trace.normal >child-exits &&
> +	PAGER_CHILD_ID=$(grep pager-used trace.normal | \
> +			 sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
> +	grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
>   	test_line_count = 1 child-exits &&
>   	grep " code:143 " child-exits &&
>   	test_path_is_file pager-used
> 

