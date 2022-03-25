Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90213C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 14:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353597AbiCYOFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 10:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359165AbiCYOFK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 10:05:10 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC5469CE3
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:03:35 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id q129so8255653oif.4
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Btyx+5yq1MAKawSdRkwLEb+DCwq572b7V4E11lcoOaI=;
        b=ThOIG8EgEZICjpkxTaEYU5oRbA2nieit1l617waOCSdU3CGUz7KREUr/v5M1dsuPBW
         UzOREMgOztsJ1bQ1TPoc7L6f1ORyT7EfqvI9s6loYxXVLfFTNzl558zQTiTiJixisJH0
         5ah0k4KDDPfBmTzwA8MazzLd4IBVQ1TKUCHA/BNAZIYotKM8/9mfm//ggpQLyTY1SnqM
         TReud+2g+lqZaj4whIqdV+6x5GOTBcX8gWEM5KCtxJsVFxfyDH/WnEE81TLc+uTdw6nK
         iZ1m9FsfT2eU/81cqun41sHa+IAMY5qUd6/dn27Pe6j0FKRxMBPssO3GFXdjuBwCEapq
         F+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Btyx+5yq1MAKawSdRkwLEb+DCwq572b7V4E11lcoOaI=;
        b=TM9H0CCgnz3T9ohlpaRjlQgRopvRvQu9moC5UIvumBxjBUTSaEAF0mVvilvh3ngCUu
         6oL8vC+DP2cnQ3k1GpuxrG4eAFSeR+XxabY2oZge4P0jsFJhlUJYoeE/uUgoKv5+B/hF
         mHuL2v+FeV94ZKQRTkjQ3YJ0BjrY+bR+poZQ6Pbf0tXYH0O0exkr5nZ2V0pu/ApDHseo
         kjon1cnL6knSEo3M/TDke1axMSxdA0K0bhRcjPF6/RVZh+4E+EYcblehIk2Yrr02CIgx
         CMv/p7LUahJOBfGp949gKdHVZ14Qz1D2FZlw6JGMaEnsA1evOcZ++hpjE4PlHVegIoEs
         Rb2g==
X-Gm-Message-State: AOAM5321DrvNeve9qG5qbBYeSsRt3/Bbv4XcSvVa/8F7DJqo5kgKQUOH
        ShsWTSp15vQMXLNE4kAgvwr6
X-Google-Smtp-Source: ABdhPJwl29v33Pdf2RF2FmQzcO9sBpsaDNtf9h6JKIeyLDnF4oXKKPwHG0Qstf5fxPc4n9w5QKTUUA==
X-Received: by 2002:a05:6808:20a5:b0:2da:7ea7:7f68 with SMTP id s37-20020a05680820a500b002da7ea77f68mr5314079oiw.260.1648217014756;
        Fri, 25 Mar 2022 07:03:34 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v24-20020a9d5a18000000b005ad458facbdsm2689426oth.27.2022.03.25.07.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 07:03:34 -0700 (PDT)
Message-ID: <fc1db75c-868c-08c6-7087-b70460653460@github.com>
Date:   Fri, 25 Mar 2022 10:03:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] test-lib-functions: fix test_subcommand_inexact
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, chakrabortyabhradeep79@gmail.com,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
 <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
 <ed67b7489719a01c88d7a6765e7499c1157da32e.1648146897.git.gitgitgadget@gmail.com>
 <xmqqtubnf568.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqtubnf568.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/24/2022 4:48 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> All existing tests continue to pass with this change. There was one
>> instance from t7700-repack.sh that was taking advantage of this
>> flexibility, but it was removed in the previous change.
> 
> Of course all existing tests continue to pass, as we no longer have
> any user of test_subcommand_inexact after the previous step ;-).

Yeah, I definitely should have checked to see if there were other
uses of this. I thought there was, but I was mistaken.

> Among
> 
>  (1) doing nothing,
>  (2) removing, and
>  (3) clarifying the implementation,
> 
> my preference would be 2 > 1 > 3.  If we add

I agree that (2) is the best option here.
 
>  (4) clarify the implementation and document what kind of inexactness we
>      tolerate with an updated comment"
> 
> to the mix, that would come before all 3 others, though.

Is there value in fixing the implementation and adding this comment
if we are to just delete the helper? I suppose that we could prevent
a future contribution from reintroducing the broken implementation.
 
> Perhaps squash something like this in?
> 
>  t/test-lib-functions.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git i/t/test-lib-functions.sh w/t/test-lib-functions.sh
> index 0f439c99d6..6f6afae847 100644
> --- i/t/test-lib-functions.sh
> +++ w/t/test-lib-functions.sh
> @@ -1789,8 +1789,8 @@ test_subcommand () {
>  }
>  
>  # Check that the given command was invoked as part of the
> -# trace2-format trace on stdin, but without an exact set of
> -# arguments.
> +# trace2-format trace on stdin, but only require that the
> +# initial arguments are given as specified.

This is an accurate description of what the fixed implementation
does.

My current feeling is that we should just delete this and refer
to that deletion if anyone considers needing something like it.

Thanks,
-Stolee
