Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AE4C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A87461152
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbhJFUpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbhJFUpn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 16:45:43 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7362C061753
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 13:43:49 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id u20-20020a9d7214000000b0054e170300adso4688711otj.13
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ai61waABQCOWCFYw+Fg78GEjMMwuP7jkP1ppolz1fq8=;
        b=L+Vaya55j/aCmYJPzntKQQjTh2W79fN0d7tmylxLmUhJfd+NTXUbRczhXKXef3Vg7j
         cRKnc7macCHsnWC6LDbljGsS/Evu7covBwIGoO+gP3iclAxAyghQLu9zIeq4KHmSUMuq
         G6nk18q9zciri4Zhywe3ZkHFPR/LtqKLsMTMbRg2hqjeMTw9B3017iE+ZE35aEzDJnDi
         MqmqdQojgwp+hqL6XKIkuzfc0n2+M3L8qELXi6z0+Dwlk9Cng4/COAgrtVucGfRbb6MR
         sN9FgdUruRvsJsHgx2QqHUJk8sYGXKnXo7mk/amM1Ti0VpuI0zvsxBmeU3Y3zNEOaAiN
         hXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ai61waABQCOWCFYw+Fg78GEjMMwuP7jkP1ppolz1fq8=;
        b=fWPCoUy+pea9fpVRXtxIwtyL+TYiGmpvBu4UVqccIg3FbVNhJXHkYeTDOIMa71KZaT
         75hwnSMtBJQPWG8l8q3vVFtUDB03tQVRBt7qM+NXqZyANVDD8jqsUTmHzlzjXImTy+vb
         G44TcPZQMmMZkS4USSV5rXyYt3HC4WuUnNvdRZ7bspDio/kHQSffkqOTd6y/0OS5gY3L
         crot97KdflWlcJceT3vOrttDvzZnW6ObKOkwFpns5LbS6MAqDpLxGL3clY2O6fUOXG9r
         FyDQ4Vh4WrynPGQBMMsEcy9jc7JiKcVjnoQcfF0CFLBDAckhT2hGMkBAVW0MlUNBdw/g
         3PiQ==
X-Gm-Message-State: AOAM533fcmwk2JmW+nqeQVcnkMwtuHH/KEUQrCpTkHi5c0uYeZW3D8Q8
        DIasuScaCL800a9vnOYeo+o=
X-Google-Smtp-Source: ABdhPJyjxRaojMO12yQRwkTLSRNTLmeSCc0PLxQBfdaf4KOq4RCZ6jpiLzUkXZu6UXIH7+G93GnMFA==
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr337596otp.212.1633553028907;
        Wed, 06 Oct 2021 13:43:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a5f2:2ad3:7396:8f96? ([2600:1700:e72:80a0:a5f2:2ad3:7396:8f96])
        by smtp.gmail.com with ESMTPSA id h18sm4369565otg.2.2021.10.06.13.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 13:43:48 -0700 (PDT)
Message-ID: <7ef4f68c-8c32-86ea-f8a6-cd673ed281c7@gmail.com>
Date:   Wed, 6 Oct 2021 16:43:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] [RFC] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1053.git.1633512591608.gitgitgadget@gmail.com>
 <xmqq1r4yrmhp.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq1r4yrmhp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/6/2021 3:17 PM, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> @@ -907,6 +917,9 @@ void cache_tree_verify(struct repository *r, struct index_state *istate)
>>  
>>  	if (!istate->cache_tree)
>>  		return;
>> -	verify_one(r, istate, istate->cache_tree, &path);
>> +	if (verify_one(r, istate, istate->cache_tree, &path)) {
>> +		strbuf_reset(&path);
>> +		verify_one(r, istate, istate->cache_tree, &path);
>> +	}
>>  	strbuf_release(&path);
>>  }
> 
> This is just a style thing, but I would find it easier to follow if
> it just recursed into itself, i.e.
> 
> -	verify_one(...);
> +	if (verify_one(...))
> +		cache_tree_verify(r, istate);
> 
> or
> 
> -	verify_one(...);
> +	again:
> +	if (verify_one(...))
> +		strbuf_reset(&path);
> +		goto again;
> }	}
> 
> On the other hand, if the new code wants to say "I would retry at
> most once, otherwise there is something wrong in me", then
> 
>> -	verify_one(r, istate, istate->cache_tree, &path);
>> +	if (verify_one(r, istate, istate->cache_tree, &path)) {
>> +		strbuf_reset(&path);
>> +		if (verify_one(r, istate, istate->cache_tree, &path))
>> +			BUG("...");
>> +	}
> 
> would be better.

I'm in favor of this second option.

Thanks,
-Stolee
