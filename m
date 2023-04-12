Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FE4C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 17:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDLRhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 13:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjDLRhG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 13:37:06 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7172729
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 10:37:05 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-184518754bfso10991425fac.5
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681321025; x=1683913025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBJ//8VQMCNfVDUXX6wYLtxaWOdQzG0/iUrCzxjx/M8=;
        b=AE/wqJQFpwFhPD97FfpOb+azWVbM0DbQuGe3R5/x47DtBM/ulVFdq/3y5g3FemJG4/
         lMIUnA3EqvWlJ1/7VXO9lc0HNfTL5Qa5vpBW83ghgvlmRj8kAmjf7tc02N63ZUxP8qjH
         pNPatIhNauEjLGLP0+0hPMF9Jyp0RVTKgHV7kCkQmQeMIzfQ/F/fJ0Hb0FBl6aMJqXFY
         8EjWYUS2atk3OABTMv5yCJALcWM+P/V7H17srjvUewBucb6u1XRySxmyIVkc3t/Lcrpj
         wVnmBDti/tr6dhgknjmjyelHbWoVQcDkB55EB/uszc0HtdsPl5nDvue7eZHxpNDnmMUX
         ukXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681321025; x=1683913025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBJ//8VQMCNfVDUXX6wYLtxaWOdQzG0/iUrCzxjx/M8=;
        b=CQsBD7G+XjGC2a9nJ2SVrU9sH/4AWw42K6QDs6MEjO/a9UsOUZ4qyQX1JdZ7EN9KFc
         fWLQNOx3/20oDMUxxuVBlEkLkz6h9AJ9Mgw0FkR0Ge3tMLGxjXGc8i7GYK3zd+GDn+fy
         uw7zeLyxanf9oQ7jgMypVvC4UhdCWWa8Qqu+/rcWFAT0o6wrhhxhcaupxKuPmEhBSiz2
         sWjnZ2oW1F0Y9aHdnEiuW/IPRhKZ1csC1VUvWA3oqN9gjxm/l5yrx2MFgK7PNxmD4l6Z
         RSmWW+bTOucmd9R/UjQhWVQ0Yw/kjkBN2U04tEqRRKc2A1w+TS0q6z/iLLm1Q9hYSMyv
         8WPQ==
X-Gm-Message-State: AAQBX9e+8cmXw1iWl1X5j6sIDsV8O6hw1T5epX1ofL/mL6FsfKKX9VbC
        Y42vJ2Fs2D0GnYu34tg7UhBX
X-Google-Smtp-Source: AKy350YB+TOkoGracG2S48kYNruhPocvz+8UK/Ge2Y+wN4Xtfl+w0d0TWqrZ1f/oTFVsYSZdWabghA==
X-Received: by 2002:a05:6870:3043:b0:176:7d49:b06b with SMTP id u3-20020a056870304300b001767d49b06bmr4032682oau.23.1681321025131;
        Wed, 12 Apr 2023 10:37:05 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id yo7-20020a05687c018700b001807f020a39sm6347899oab.12.2023.04.12.10.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 10:37:04 -0700 (PDT)
Message-ID: <c04a0ea4-c107-f8d2-4a53-f6aa9ee934ef@github.com>
Date:   Wed, 12 Apr 2023 13:37:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 7/7] t: invert `GIT_TEST_WRITE_REV_INDEX`
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1681166596.git.me@ttaylorr.com>
 <9c80379958824ac8fb7834f4f98000d11c3dc4e0.1681166596.git.me@ttaylorr.com>
 <18a54c6e-7357-42ca-779f-2ba3e6653880@github.com>
 <ZDXSHal5IBynUTMX@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZDXSHal5IBynUTMX@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/11/2023 5:33 PM, Taylor Blau wrote:
> On Tue, Apr 11, 2023 at 09:51:06AM -0400, Derrick Stolee wrote:
>> On 4/10/2023 6:53 PM, Taylor Blau wrote:
>>> Instead of getting rid of the option, invert its meaning to instead
>>> disable writing ".rev" files, thereby running the test suite in a mode
>>> where the reverse index is generated from scratch.
>>>
>>> This ensures that we are still running and exercising Git's behavior
>>> when forced to generate reverse indexes from scratch.
>>
>> I don't think this is true because you remove the environment
>> variable from the following test.
> 
> This is intentional; I wrote that last sentence ("This ensures...") with
> an implied "[When set], this ensures..." at the beginning of it. IOW, if
> you wanted to run the test suite with primarily in-memory reverse
> indexes, you still could.

I guess I think of "we are still running and exercising" as only
being true if it happens during regular CI, not just when someone
thinks to try it.

> I wasn't quite sure what to do here. On one hand, sticking
> GIT_TEST_NO_WRITE_REV_INDEX=1 here would ensure that the linux-TEST-vars
> test is still exercising the old code.
> 
> Is that desirable? I dunno. On one hand it increases our coverage, but
> on the other hand I've always treated this suite as for experimental
> features, not older ones.
> 
> But I think all things being equal, I'd rather have more CI coverage
> than not, so I'll add it back in. Thanks for a sanity check on this one.

If we think there is value in continuing to test the case without .rev
files by default, then adding it in would be good. I think it has some
value at least for some time after the transition. We're unlikely to
remember to remove it, but having the extra mode in this build is not
too much overhead.

We should consider auditing this build just to be sure we want to
continue testing these options or if some could be removed in favor
of new defaults.

Thanks,
-Stolee
