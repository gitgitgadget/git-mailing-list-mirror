Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D93C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 14:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244904AbiCWO5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiCWO5K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 10:57:10 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DBB7DE08
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:55:40 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id b188so1851740oia.13
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jY71ZQpYZeZWWhcadppni6BLM5pJwV9/I8PoG3WH7zs=;
        b=eubWJjjlBe1SCWmxZg5Ta/lSdC55y3dohD4nuVxL1nd/slOysDVZw8Cqq9jm9zAtcL
         iQv0x1iFFKIJSkr4h4+1HNhn4NKJqDN5e1UWPF5xMz3bwlvELKS1l1unzRaEGZnT2agM
         J3s4uZpcmL3V1LspiCUSrATBrdei6RZ/ayIfRSPRg2TNjbF87jdJ7LaQ8Dkvql3HYH53
         L6cqd04I78jcYJb5I53hQoMJC7rK4fMR8EFiXVfoz3HE8MQGrB5sg83C6eC685/E3bHD
         5tRmhcRY0t4ykXwOgiQi6ZaTM/EbdebmE6HnRE5tmJN6b6IK4pzbf+gpLnk6B9/RXLPl
         0fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jY71ZQpYZeZWWhcadppni6BLM5pJwV9/I8PoG3WH7zs=;
        b=PHTHmAWuBXVprfIJ/NP3P/vJlwbdslOqZKRpnviM21gCSResV6BYIqlDVqcI/G5qlb
         on4vhTvBfDdZBnVGIQM8azgnDnXtNfMmLb+/4uSD5S7sPWHIcIzRRggrYSSApyuZZ0/A
         GpnlJ8ELBdqzEvr4gH9DNe/Y4pPO8cU8TtkmglEo/OGFClIF2gnjRBIgREY0DrRogO/B
         37uH3KYkMAJdqti0NvJrZFxsWucZS9Z1cKpWEhrinfRSMNCEJQZGpCPxRXWsMFw7L9SW
         Vp5S0NxFW8rAijcI8i/lp1+kO8qG/HySnjCdxq0RTrTyOIDiILYZYjaxC7ovyROeC9Wc
         Ks3g==
X-Gm-Message-State: AOAM532kMTGy+u8oCAPwJ6N7CeiKOPVeWjC+mPWFgRdFWUsJosMr+irv
        3eBE0yVzZY+/RE0T+S+bOMN+
X-Google-Smtp-Source: ABdhPJxBMSF5rBt5sGupvxn9PePv+heV74dXKD8tcJNCqiM8+/dW+owsoxJEZKVYfkl4aXBqYRQW2w==
X-Received: by 2002:aca:bd46:0:b0:2ed:16c7:29cb with SMTP id n67-20020acabd46000000b002ed16c729cbmr191516oif.92.1648047339489;
        Wed, 23 Mar 2022 07:55:39 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 184-20020a4a03c1000000b003240492fc15sm107900ooi.36.2022.03.23.07.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 07:55:39 -0700 (PDT)
Message-ID: <e5331972-512a-c498-6a1b-927f21ef9de2@github.com>
Date:   Wed, 23 Mar 2022 10:55:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] test-lib-functions: fix test_subcommand_inexact
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, chakrabortyabhradeep79@gmail.com
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
 <540936ba-7287-77fa-9cee-e257ed3c119d@github.com>
 <xmqqmthgu3e6.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqmthgu3e6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2022 10:53 AM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> So, this patch is incorrect about keeping things working. The
>> options are:
>>
>> 1. Keep the repeated ".*" and be clear about the expectations.
>>    (This could drop the "remove trailing comma" line.)
>>
>> 2. Find another way to test this --write-midx behavior while
>>    keeping the stricter test_subcommand_inexact helper.
>>
>> 3. Something else???
> 
> The result of doing #1 is still "inexact" but at that point it is
> unclear if we are being way too inexact to be useful.  If the
> looseness bothers us too much, we may decide that #1 is not worth
> doing.  But obviously the looseness did not bother us that much
> until last week, so probably an obvious #3, do nothing, letting the
> sleeping dog lie, might be what we want to do?
> 
> If we were to pursue #2, then, would we tightening the test for the
> write-midx using the "stricter" helper, or would the stricter one be
> too strict to be useful for that case?  If we are rewriting the
> write-midx test by not using the "stricter" helper, then we would be
> creating a stricter one nobody uses, which sounds quite wasteful.
> 
> It seems that the only case that could result in a result that is
> better than "do nothing" is if we can use a different pattern with
> the "stricter" helper to express what "write-midx" test wanted to
> do, but because what we need to fuzzily match on the command line in
> that test includes a generated temporary filename, I do not think
> it is likely to be easily doable.
> 
> So, perhaps #3 ;-)?

I'll default to #3 (do nothing), but if this shows up again
I'll plan on adding a comment to the helper to be clear on
how "inexact" the helper really is.

Thanks,
-Stolee
