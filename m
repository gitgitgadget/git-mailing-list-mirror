Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466DBC433EF
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 09:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2293760F46
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 09:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhJRJjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhJRJji (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 05:39:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39AEC06161C
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 02:37:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t2so40200635wrb.8
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 02:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hIrPGRGPu14tMmViMlXLFCG/1c7/zGkPSAddFPgbEHc=;
        b=Xslyr5PDJ4GXiKaZZbRbibVizE24gAa0uPkvoNZphWDxgr+qB3F+sjTLC8NOt/TTjq
         rqP9OORIhhYI8vwVFHaFo2749/nQ2Aq7muuTzy4Rk/ROYg8qYf++SPtBMx+ael5iwy5l
         2aHkrV3qsPY4AFkl/+ljKeuj5iKThBqpU4+Hs6tav1WEZzF2VPzahEWbVmuZS2vkNf12
         CJIe5J0ZeXyJxrS3S1KIfTHrdCCYvVBzSbeDxta6yFj4WwL8/Oxc8/N7VGpSvZS08ij7
         uhEms0ZNfO3N/SrghLCisFQkAbebEKcn6mZVSKHEP4xjGqYJpfe9gkIJm3GO59OiU9cU
         3pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hIrPGRGPu14tMmViMlXLFCG/1c7/zGkPSAddFPgbEHc=;
        b=V4cuJ4DY4JdASfUL/pmw5ZWsKCLWjDqHS88CGov2yB0ZYDhSb4O9smquwNEbfitt11
         TH8/nz8HtawWrLp12nmxrH8tBLzqa3jvRMIVqRTeAkC3MeyL39kDCTwCWrWfKt0oB7Us
         WIhehUsKs0VEq8Mq8otGPYdlBhHlq7OA6sUhge/ZBPGMnqkh4it0lRZDnuDYXSEbXbcA
         ciryrx0cVZjeoKNx8u0pZXMIDw0OGvyvSPmK1xHwh4iUCOLccMW6+HaMgUCpi0KyRLZ4
         J0sCQvXye01X1BNz35xtzaUkVA5WQM7FiRlSQKhCb1NzbhmqECIiD1OeSGgS/gpwlKG6
         /uRQ==
X-Gm-Message-State: AOAM530Zp94KQfgVvJ+7MhRLIzay+9NHVM3eq5VVfoLcU5Vwikn0IHiS
        Gj6R2IVbQzJujKtsS1EyyME=
X-Google-Smtp-Source: ABdhPJwj/REWDYo0F+9PkWs/zHm8D7Uaj84/gR6jRBgpIA0qUCzsQJ65wJC45u3jtN3zXlqrRwx+tw==
X-Received: by 2002:adf:b19b:: with SMTP id q27mr34681350wra.125.1634549846332;
        Mon, 18 Oct 2021 02:37:26 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id k17sm17977581wmj.0.2021.10.18.02.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 02:37:25 -0700 (PDT)
Message-ID: <3d0ff15e-469d-c659-4b32-295c7645bb8d@gmail.com>
Date:   Mon, 18 Oct 2021 10:37:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
 <pull.1053.v4.git.1634375229338.gitgitgadget@gmail.com>
 <xmqqilxw1a9v.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqilxw1a9v.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 17/10/2021 06:38, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>      [RFC] sparse index: fix use-after-free bug in cache_tree_verify()
>>      
>>      Changes since V3
>>      
>>       * removed "-q" from the test [1]. This is the same as V2 with a typo
>>         fixed in the commit message
>>      
>>      [1] https://lore.kernel.org/git/
>>      e281c2e2-2044-1a11-e2bc-5ab3ee92c300@gmail.com/
> 
> Thanks.  Unfortunately I've already merged the previosu version on
> the 11th,

Oh sorry I'd missed that

  so I took the liberty of turning this round into an
> incremental.  How does this look?
It looks fine to me with Stolee's typo fixes

Thanks

Phillip

> ----- >8 --------- >8 --------- >8 --------- >8 -----
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> Date: Sat, 16 Oct 2021 09:07:09 +0000
> Subject: [PATCH] t1092: run "rebase --apply" without "-q" in the test
> 
> We run a few Git subcommands and make sure they produce identical
> results with and without sparse-index.  To this set of subcommands,
> an earlier commit added "rebase --apply", but did so with the "-q"
> option, in order to work around a breakge caused by a version used
> at Microsoft with some unreleased changes.
> 
> Because we would want to make sure the commands produce indentical
> results, including reports given to the output that lists which
> commits were picked, use of "-q" loses too much interesting
> information.  Let's drop "-q" from the command invocation and
> revisit the issue when the problematic changes are upstreamed.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   t/t1092-sparse-checkout-compatibility.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 80c77bb432..85d5279b33 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -484,7 +484,7 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
>   test_expect_success 'merge, cherry-pick, and rebase' '
>   	init_repos &&
>   
> -	for OPERATION in "merge -m merge" cherry-pick "rebase --apply -q" "rebase --merge"
> +	for OPERATION in "merge -m merge" cherry-pick "rebase --apply" "rebase --merge"
>   	do
>   		test_all_match git checkout -B temp update-deep &&
>   		test_all_match git $OPERATION update-folder1 &&
> 
