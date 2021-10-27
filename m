Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B437CC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 906856058D
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbhJ0RXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhJ0RXk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 13:23:40 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A984C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 10:21:15 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id bl14so3161566qkb.4
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=ln9vqic7PGvYNiiV2wCfbv5cphPqAeYYH4Ru9h/UdTU=;
        b=JIvQvahiaAvhsbIAInKv7QNRrhlDzmI519pqy4SQtgXdg1A5NONhn9eln7eTPQ21q4
         l9AKOS6imc9NCMpXUI2jqB9WKWxXyA3Qava8fF/3hbk8/UrZH5fiYSvvhJe/bPHLbOMt
         RVIjLQ8c14bydkPBJR4+af88Is3a7Te80FMWVqZstgK6g5SEFKQ6V+tzm0kZczxBpvu4
         sLLdyYiUQ7ANcGcSPDqVhSLd4woJZDBG8QgNq2zZ0bjFSoQnHm5H8hZ42Jc6oQCWmio+
         nlksFLMZAIF0Oacm86wy0w1Z9yCo7NbD9QHoVgtPkRZPLJAP/aQxNrr6B1u45trOUj2Y
         a6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=ln9vqic7PGvYNiiV2wCfbv5cphPqAeYYH4Ru9h/UdTU=;
        b=sWgmEoY+byfAEblpnKYxOpBM8LOSPWXlHduCVHzKs0lxoE5ULJHKZbCl7fBW9HaQEt
         pk2r7ntTez8gXp1ye6nNdyc5enDaZ4AaLPRxYtij4Ytqou34g37QM+cKbayKliMMDWhS
         tRFei1lmC2YG0+Vzm7JnfikHnkQKTIZW4H6kvM8YRNHchGib98zbNkdXMOjNXHxi1fO1
         frMDneAZntTUPnWA68GAtP809pLepyoHQP86yUG2/dtR+Lwhk022K+6LAMQg8mmmRmhK
         S/VLhAmlWyVvZ/iey8PJaL3GixeS/MDvRJd3ZCsQQudxw0+bjxVqiC1EJoHlE004s0Fo
         O5KQ==
X-Gm-Message-State: AOAM532tpHe3uufk7LAPZVJo746YWyPp2pjGF1OuOqiyV4QLEhR7WjqK
        jItwM8HTMg/ZQs7aIM/LdWqotvlMvLvl
X-Google-Smtp-Source: ABdhPJx33+9V5YNsSqyKa+3DGFG8L40vflhLdRZku7uxqR4RNjy/6jUnuT3LzFbjaIICdew1VC3l6A==
X-Received: by 2002:a37:2790:: with SMTP id n138mr3891765qkn.417.1635355274417;
        Wed, 27 Oct 2021 10:21:14 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id 12sm328591qty.9.2021.10.27.10.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 10:21:14 -0700 (PDT)
Message-ID: <a9ce8fa1-287e-56ef-4096-1492cceff3fc@github.com>
Date:   Wed, 27 Oct 2021 13:21:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
From:   Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 2/3] sparse-index: add ensure_correct_sparsity function
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
 <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
 <0b6e6633bb2b9f21a79625ace6db9509c48bd819.1634849307.git.gitgitgadget@gmail.com>
 <xmqqy26mhvel.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqy26mhvel.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >> @@ -313,6 +336,19 @@ void ensure_full_index(struct index_state *istate)
>>  	trace2_region_leave("index", "ensure_full_index", istate->repo);
>>  }
>>  
>> +void ensure_correct_sparsity(struct index_state *istate)
>> +{
>> +	/*
>> +	 * First check whether the index can be converted to sparse by attempting
>> +	 * to convert it with the SPARSE_INDEX_VERIFY_ALLOWED flag. If the
>> +	 * SPARSE_INDEX_VERIFY_ALLOWED checks indicate that the index cannot
>> +	 * be converted because repository settings and/or index properties
>> +	 * do not allow it, expand the index to full.
>> +	 */
> 
> The logic may be OK, but the need to give this long description is a
> sign that the meaning of the value returned from the function is not
> clear from the name of the function.
> 
>> +	if (convert_to_sparse(istate, SPARSE_INDEX_VERIFY_ALLOWED))
>> +		ensure_full_index(istate);
> 
> It might make it more straight-forward to 
> 
>  (1) drop the "if (verify)" part in convert_to_sparse(), which would
>      mean that for all callers convert_to_sparse() will retain the
>      same behaviour as before;
> 
>  (2) make a call to can_convert_to_sparse() here, and if that
>      returns true, make a call to ensure_full_index(); this would
>      behave identically to what this patch does when can_convert is
>      false; and
> 
>  (3) correct the can_convert_to_sparse() function to not blow away
>      the cache_tree unconditionally and recompute, so that calling
>      it twice in a row will not be costly.
> 

Agreed, this approach is a lot easier to follow. I went a bit overboard
trying to handle *all* possible cases where `convert_to_sparse` returns
before converting, but the primary goal of this series is updating the
behavior when config settings change. I'll include the suggested
restructuring in my next re-roll. Thanks!
