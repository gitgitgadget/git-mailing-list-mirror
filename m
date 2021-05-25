Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E46C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E7B6142D
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhEYKzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhEYKzf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:55:35 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028B2C061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:54:06 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c20so29930098qkm.3
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mqqnTvjIHijxDPQYPAGplHwkDrb9A2qUkhmtsan/2Sc=;
        b=Lv00+97KEOsuvEaQ+VnFUcM5wRsiaMg+mt++kvZsGGL2uYJ/YpdyvrT/uXhsg+bLqW
         lrSqlv/CpfRZ4rlrp86J4Y5sdflOjVCn8CLu6JDI+NlNhvGE8eosS+tTNXZN7p6Fh+kB
         hV7E/1tYWG3pd2+bM6rmCmh4BFx2jMjjL7/TC3XIuJKxNcNO9IOroNZ2KKGUSQdpg1gf
         WPLgD8h6FKtsvl8iLZLYsndECdEF0eZ2lQ5dlkQ2jmzNecJ50RERkQ9tOivEKEzlKRLu
         tJYq+nlTstzSVI5QFZuyfSMqUnwacSgQEd1wlI/bx9iUaTqO+mT/NgnOeAcr+vUa1yK0
         bjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mqqnTvjIHijxDPQYPAGplHwkDrb9A2qUkhmtsan/2Sc=;
        b=VKks6tRPCMke8ZdY7CV32MoPPPBt/8gsTa3fDTVS4ubBww/3Zuh2pP47mIGVTywedg
         IP5rUCcavar5O2xzxX1U121SQdY09G/gCSeSaITY+G8a+Rhzw7Oa8/G2R8mBLu7LOw/d
         cbLsRjAXjPoaHWPJXJwxYv+2AhThpNyq+G9W2ss754oY9vI0ejWhxR/lUT6+nf6jlgqh
         LY3gVPrqpkCCklw7apyO4VpQws58yAbPOk6w09c+kxEroEFUhLRYGGxOoIu/uCbDtJxB
         CKzVK8WT43h1mQE7pstXG4olR1u9hJ/Af5/ji+BiywrHMHgm3TxP8jgZ4lw+W6EbFmGb
         uQpQ==
X-Gm-Message-State: AOAM530WBIk1WtlxMQ+OH6c7X24+i0V5dhwhHLUOUHYli5/7NIcH++FN
        3NwWcLXh6LqTKrtA30QNsVE=
X-Google-Smtp-Source: ABdhPJzPQpC5s/GayX280Mzi2I4hSUYHu5/WKMsm+KxmUGF/J+G7PrVRRI/ZLgnmfjxfeXnamXv3iQ==
X-Received: by 2002:a37:acc:: with SMTP id 195mr35096520qkk.285.1621940044963;
        Tue, 25 May 2021 03:54:04 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:406:75b4:8c89:8431? ([2600:1700:e72:80a0:406:75b4:8c89:8431])
        by smtp.gmail.com with ESMTPSA id 123sm11683615qkh.104.2021.05.25.03.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 03:54:04 -0700 (PDT)
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
 <YKwMU13DOtTIgaeP@google.com>
 <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
 <YKwd2e5VxVmU6zqj@nand.local> <87fsybohy5.fsf@evledraar.gmail.com>
 <YKxBIP4lkoPeCYvb@nand.local>
 <68a2bf8f-07e8-b117-a3f4-862654c781b4@gmail.com> <xmqqy2c3fhmy.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9d6568ee-c9bf-b349-d1a6-0bb2fcf06dab@gmail.com>
Date:   Tue, 25 May 2021 06:54:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <xmqqy2c3fhmy.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/25/2021 2:32 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> So we silently convert -1 to 2^64-1, and call it a day.
>>
>> That works for me. I'll send a v2 with that tomorrow unless someone
>> presents a better option.
> 
> I'll queue with this tweak for tonight's integration run.
> 
> Thanks.
> 
> 1:  d327f7d3b9 ! 1:  e2b05746e1 t1092: use GIT_PROGRESS_DELAY for consistent results
>     @@ Commit message
>          values may be different as those indexes have a different number of
>          entries.
>      
>     -    Instead, use GIT_PROGRESS_DELAY=100000 to ensure that any reasonable
>     -    machine running these tests would never display delayed progress
>     -    indicators.
>     +    Instead, use GIT_PROGRESS_DELAY=-1 (which will turn into UINT_MAX)
>     +    to ensure that any reasonable machine running these tests would
>     +    never display delayed progress indicators.
>      
>          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     @@ t/t1092-sparse-checkout-compatibility.sh: init_repos () {
>       	(
>       		cd sparse-checkout &&
>      -		"$@" >../sparse-checkout-out 2>../sparse-checkout-err
>     -+		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
>     ++		GIT_PROGRESS_DELAY=-1 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
>       	) &&
>       	(
>       		cd sparse-index &&
>      -		"$@" >../sparse-index-out 2>../sparse-index-err
>     -+		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-index-out 2>../sparse-index-err
>     ++		GIT_PROGRESS_DELAY=-1 "$@" >../sparse-index-out 2>../sparse-index-err
>       	)
>       }
>       
>     @@ t/t1092-sparse-checkout-compatibility.sh: init_repos () {
>       	(
>       		cd full-checkout &&
>      -		"$@" >../full-checkout-out 2>../full-checkout-err
>     -+		GIT_PROGRESS_DELAY=100000 "$@" >../full-checkout-out 2>../full-checkout-err
>     ++		GIT_PROGRESS_DELAY=-1 "$@" >../full-checkout-out 2>../full-checkout-err
>       	) &&
>       	run_on_sparse "$@"
>       }

Thank you for proactively modifying the patch. This works
for me. I didn't realize that this was affecting other
contributors [1] until I woke up this morning.

[1] https://lore.kernel.org/git/036b01d750ed$642b75c0$2c826140$@nexbridge.com/

Thanks,
-Stolee
