Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FD4C4332B
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 17:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9279C229CA
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 17:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbhAKRQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 12:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389057AbhAKRQk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 12:16:40 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39175C061794
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 09:16:00 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id h4so163529qkk.4
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 09:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l+782H6KawMiyPcjjtz/t6hZBd81xDR3PD+QaAABt5s=;
        b=ELY4sggY2DRCHnp4LmIru6h2eH/oi4FP8fsD+sKB9lNGvMQn08b2rvRXfnJrMJwy6M
         022dhBqja3bee2WP3zQNmJvphtQFg+aaKBHyI+BZd2l43Md/LRi4wcxzBFNRsM1K03hL
         hzh8vWeq/Td9ROGFzD0o2RGQ7VHX3dOPvuLUVOI0311ZrYmcnljjrn0B2/4ZMnvjIJDp
         HoaPK9/tsfOD0oAH47Gs9qMZvQhjb93IIDvdXH1MjwyDyrwmC4WeOOWh4cz4GWKh1ixk
         fkoO1LWIe9S7dyVq43ZD4elGXPlW1VqUiR7O8ixYc3QfGcQUbERWqPcR9gZUkqdNGVUU
         RWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l+782H6KawMiyPcjjtz/t6hZBd81xDR3PD+QaAABt5s=;
        b=qzdFF0W9sOm+ZcFvr+SwrZTdW7a1Y6T/HnBjZGSxaiXgdeEIyJy/5DwOKFcn54eNKG
         lxHvOeMiHEeTjPXCnZeiVCpKfduOVAtno4UPeXxRnQ9NOP4Hrc1bh8qEjtMMzbfvH5ra
         CVIe7P730OjEV5bUl5W9G9wLGZZp+mH2pmBBYW0IMIvJXrtXWALbQ8KAf8u/xhXaiyYm
         cbMDa+bwXr5/FG/4poVOqjqjWof2FNa+CjWqCz2V9R8As48ucnpBmzLvGrRedn8BXqow
         5QpEocMOE1brRinAZCMHtXtPm8Up4Xs/slGQDlK3Ge1WeW9GZFJWZ9IhzYpEHC4JBGSK
         eVeA==
X-Gm-Message-State: AOAM533mwUoGYnOeqGwxhpRGLLJPnQUBbsZvrE9RoMOXDIzoi/qvsd57
        6pSAI94oq+d4H/kFZftXsfUhjhSSGQs=
X-Google-Smtp-Source: ABdhPJwjR934kTrjzEpk42M1cqHrPwBlhhmUW5rgaSw4rwGf4VkC3imTwSjbl/eQwYlebpmh4Qk4fw==
X-Received: by 2002:a37:8703:: with SMTP id j3mr253629qkd.455.1610385359444;
        Mon, 11 Jan 2021 09:15:59 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id d46sm84291qtc.76.2021.01.11.09.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 09:15:59 -0800 (PST)
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
References: <cover.1610129796.git.me@ttaylorr.com>
 <75ba9979-1a1f-de9f-c2cc-1433d30ed09d@gmail.com>
 <X/x9MMv4hBZMGKBT@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7e56e831-c6d6-3454-94c5-b8e888497568@gmail.com>
Date:   Mon, 11 Jan 2021 12:15:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <X/x9MMv4hBZMGKBT@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/11/2021 11:30 AM, Taylor Blau wrote:
> On Mon, Jan 11, 2021 at 07:07:17AM -0500, Derrick Stolee wrote:
>> My comments on this series are very minor.
>>
>> I made only one comment about "if (method() < 0)" versus
>> "if (method())" but that pattern appears in multiple patches.
>> _If_ you decide to change that pattern, then I'm sure you can
>> find all uses.
> 
> I have no strong opinion here, so I'm happy to defer to your or others'
> judgement. My very weak opinion is that I'd just as soon leave it as-is,
> but that if I'm rerolling and others would like to see it changed, then
> I'm happy to do it.

Well, I found 782 instances of ") < 0)" in the codebase, and my initial
scan of these shows they are doing exactly what you are asking. So as
far as code style goes, there is plenty of precedent.

The thing that makes me react to this is that it _looks_ like an extra
comparison. However, I'm sure the assembly instructions have the same
performance characteristics between "!= 0" and "< 0".

Thanks,
-Stolee

