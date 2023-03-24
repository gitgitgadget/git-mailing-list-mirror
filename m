Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CD3C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 14:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjCXOGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjCXOFt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 10:05:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EE21E5FA
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:04:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r29so1888930wra.13
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679666689;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpK9r/MC6YtY4Txtz/lw2LU3EQST43DeMWZwWu77eVk=;
        b=EAzohlwHjW78yB1HBqNaiShQlGYdrrlVqFpRCgxfoy3nzQLx/gGFiqu+JDeWeurBIc
         U0WG1Oe1yfmNtsF90Etw7uQcWA7m0A0qE0OWMwxaVyjrZ+JcmwOYbgJ+h2aVo/a1o1Hd
         QA3MfZbo9TeoLxWdBRDeOApRNPvmPKseK43ED9+BawpbFlxqL0m6b9WT64dwm/NT2+Sq
         FlZP0mwAe21op/P0EU+ldpcGmn+XStgkZAKpzT8Lao2yZkuOhHQ1tBHFyVputn+tRZdo
         OJX/CD7f4PNQocMIgfrqd3+WXofqGGK+odZ9XcYptFmtwyt+EvV/yX8XdfvBCLXxHpgU
         bMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679666689;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpK9r/MC6YtY4Txtz/lw2LU3EQST43DeMWZwWu77eVk=;
        b=E4gTax9zP7Pw3qp5NKOhPOuhgf8sTEZLEdO61A5EkaK/aEtXRGINmxdWzOAPcdkzLd
         Pgx6SqVGLJdFWBA+8hlJOj6LW5j69n3DIY8xrvAHsHOviDYEyT0rzI0seXzyaRt212H5
         N+tlQxj9eQMLQa1gsPyzYPmmE2TMelrK2rfhAdWxmGOUreHhVyxSz4Wzef8TfORg8BzM
         HHiOlvXO7bKeC2Chw8uG42cG8OKaSnQ87QQY2Gy5z3GVSI8Gw8/dS4D5uxzS1pNYPmsV
         +RiMfgg9f6IrdyXS6i5PGuYlvOX4tva+EH8u3FVmN+9JdTswceZ2NXn2nQJEGCeo2A6C
         MJQw==
X-Gm-Message-State: AAQBX9c0Pgsmdqc2SCtQgKz5PcmJBpy9JjzUe3cubxVySOHAncSEMdtR
        nEiIcG9+hdjCu+rdRi03ma0=
X-Google-Smtp-Source: AKy350Zcil2zSzXBXqVFqpCwI0cnhR2Th8bXXg2vRGFJ5XLhByjI6o5YVsiDuTWa4dTXCAx7UmR8xg==
X-Received: by 2002:a5d:460d:0:b0:2c5:5a65:79a0 with SMTP id t13-20020a5d460d000000b002c55a6579a0mr2651175wrq.53.1679666689423;
        Fri, 24 Mar 2023 07:04:49 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id s13-20020a5d510d000000b002c794495f6fsm15453615wrt.117.2023.03.24.07.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 07:04:48 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <9489e843-1612-4aca-4e20-de23636e16d5@dunelm.org.uk>
Date:   Fri, 24 Mar 2023 14:04:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] wildmatch: fix exponential behavior
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
References: <cover.1679328580.git.phillip.wood@dunelm.org.uk>
 <f6e3ae73-daae-3cc1-eb16-d4a24a2612db@github.com>
In-Reply-To: <f6e3ae73-daae-3cc1-eb16-d4a24a2612db@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 23/03/2023 14:19, Derrick Stolee wrote:
> On 3/20/2023 12:09 PM, Phillip Wood wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The wildmatch implementation in git suffers from exponential behavior as
>> described in [1] where the time taken for a failing match is exponential
>> in the number of wildcards it contains. The original implementation
>> imported from rsync is immune but the optimizations introduced by [2.3]
>> failed to prevent unnecessary backtracking when handling '*' and '/**/'.
>>
>> This bug was were discussed on the security list and the conclusion was
>> that it only affects operations that are already potential DoS vectors.
>>
>> In the long term it would be nice to get rid of the recursion in the
>> wildmatch() code but the patches here focus on a minimal fix.
> 
> Thanks for these changes. The patches look good to me.
> 
> I particularly appreciate that there is a regression test to avoid
> this accidentally happening again in the future. The two second
> timeout is a reasonable balance between "not taking too long" and
> "will not be flaky, assuming the code is correct". I could imagine
> that it might _pass_ unexpectedly if it runs on fast-enough hardware,
> but that's not a huge concern right now. CI machines are not normally
> powered significantly more than a typical developer machine.

Thanks for taking the time to look at these again and for prompting me 
to add the regression test in the first place.

Best Wishes

Phillip

> Thanks,
> -Stolee
