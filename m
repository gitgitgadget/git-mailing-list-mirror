Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC90C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 18:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjC1Scp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 14:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjC1Sco (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 14:32:44 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C054199B
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 11:32:43 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id g9so9863634qvt.8
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1680028362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3xoBFG6Gl7JUG8syUCIsB2Fbe7+YArG5VhausE+Jsw=;
        b=D4ehc9/c2ozNsG5oRoiKfMBS9Ew/yYNoMfheAfg+EiL3woapc3osKjGHL0joCYIqSU
         uP1X8gaxG183h7+6IwE1imOLZpK0KmaEfDrY+3gRSOOoIxfVL7Dk7kvPoOJBmwOHLeeZ
         h0IGjJmNxpzi9xJzc6MU5CQFsPREttA75RJ/HYlF18DoiggzIMi9KDA2nsSkWgtMSooS
         E3M34DwmZioyZS73h0gTQfHBI5Hjh/6ihT3kv4T319TeWp+hFtpt/9f3kGmPkx6p/Wl9
         DRsAQRra8kGiKx6abuLgsWkAUd+weRcH+uLaT0ceyHEDX4jSVPlqgYBRmdD773zSJtuM
         231Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680028362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3xoBFG6Gl7JUG8syUCIsB2Fbe7+YArG5VhausE+Jsw=;
        b=tYFIuhFR5XRS5AfloHzQ8VrmG6gXzNpB7tviAIQqyEm/mbIPitDJxSdUMJZP3d7i2D
         m2kmoLdz9LQHEE0VbH9V/GIggjXJXoEUsMNpPJHaXE+Op+5iq7SysZUx1/jZxF7mLpU+
         VmIuzwnCMHDCqY327/g1tTL9NKZxzOVE8vKTnR9vXvQ8Qrp8L+Kb2U2NzLOZwk+K/V7T
         aEosXevfo51Do3I5JNPeAIYzKNq4f4vtFmzApbXs6pNmV72Y+OK0UtZ0GXMygfn4m5j9
         X5XfTaC30OrFgfA0uYl+bh9ooQOqhSM6G7Cii1m8uepbQPTOiv14PxqhJCm19gKy2MBe
         rHww==
X-Gm-Message-State: AAQBX9dmi0TgMO2H1Qm8uujry3EBjZgXQmv4a6ZHBU6uNuT5S4dNPZiG
        rXNq3ep1MH8CzghjiE0i14rrqiEUB/I314yxDA==
X-Google-Smtp-Source: AKy350bu6LbI7/+YR/MPQh2d2X+MpZy6spyOmyO98jrqNQu8gC8FJL6rIihvzOzBaS1SqoXoG7JdVw==
X-Received: by 2002:a05:6214:226e:b0:5dd:5c8d:866f with SMTP id gs14-20020a056214226e00b005dd5c8d866fmr27146765qvb.23.1680028362112;
        Tue, 28 Mar 2023 11:32:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5188:124d:a12d:bff? ([2600:1700:e72:80a0:5188:124d:a12d:bff])
        by smtp.gmail.com with ESMTPSA id 78-20020a370551000000b0074236d3a149sm8740503qkf.92.2023.03.28.11.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 11:32:41 -0700 (PDT)
Message-ID: <ca1f77db-a483-8b32-8e34-9bce1ea8afc3@github.com>
Date:   Tue, 28 Mar 2023 14:32:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] commit-graph: fix truncated generation numbers
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <f8a0a869e8b0882f05cac49d78f49ba3553d3c44.1679904401.git.ps@pks.im>
 <xmqqfs9og47y.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqfs9og47y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/28/23 1:45 PM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> In 80c928d947 (commit-graph: simplify compute_generation_numbers(),
>> 2023-03-20), the code to compute generation numbers was simplified to
>> use the same infrastructure as is used to compute topological levels.
>> This refactoring introduced a bug where the generation numbers are
>> truncated when they exceed UINT32_MAX because we explicitly cast the
>> computed generation number to `uint32_t`. This is not required though:
>> both the computed value and the field of `struct commit_graph_data` are
>> of the same type `timestamp_t` already, so casting to `uint32_t` will
>> cause truncation.
>>
>> This cast can cause us to miscompute generation data overflows:
>>
>>     1. Given a commit with no parents and committer date
>>        `UINT32_MAX + 1`.
>>
>>     2. We compute its generation number as `UINT32_MAX + 1`, but
>>        truncate it to `1`.
>>
>>     3. We calculate the generation offset via `$generation - $date`,
>>        which is thus `1 - (UINT32_MAX + 1)`. The computation underflows
>>        and we thus end up with an offset that is bigger than the maximum
>>        allowed offset.
>>
>> As a result, we'd be writing generation data overflow information into
>> the commit-graph that is bogus and ultimately not even required.
>>
>> Fix this bug by removing the needless cast.
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>
>> This commit applies on top of cbfe360b14 (commit-reach: add
>> tips_reachable_from_bases(), 2023-03-20), which has recently been merged
>> to next.
> 
> The patch is clearly explained and the change looks quite
> straight-forward.  Derrick, Ack?

Yes, looks good. What a silly mistake, but thanks for going
the extra mile to introduce a test that will prevent it in
the future.

Thanks,
-Stolee

