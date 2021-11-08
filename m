Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CB7C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 01:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49DC661359
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 01:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhKHBJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 20:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhKHBJs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 20:09:48 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2E5C061570
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 17:07:04 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id br39so14146562qkb.8
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 17:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0kHTom+n3hlFogmzVLWO7igmcOgBDcExbtbjV4vQxWo=;
        b=fkIgppjWS9ajKcC3zJ+UNsNFLDm0I4rsWay1SEvenEne/owsssq8LZqYyNHIIi4wcx
         HRUhYIDUoUcAQ1GJSbmJrdoJIbp+oHDO1iCQpNwxxVKt/uqDrKZ6KMsUsiSkOE29R+hM
         9zUyjrpHclNhd2NL7fadIndM0b6twJyXfwkZ3ezWMyo+p2nBzOHcRvQndr8rgPEHuXlP
         j9RUTlRtAhNgcFtE+CZsxGHIqJG7f9c7I2pSt1by0/I+52f6mrEnJF/3s0bD258Ur1hI
         NNqEDCr9n8w6dRWs/+97/Vnt8u7/3sqCbUJNQOjLfIYGUVCRiwomC41ST4AojuDEHPo/
         yH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0kHTom+n3hlFogmzVLWO7igmcOgBDcExbtbjV4vQxWo=;
        b=fV/BaWhKcLYISPc0hJZsPzJ0LhaxuYLsDeH29y66XmNa3kpkLJ1khh+mTnWmZ+7zfg
         mFOodgEzhd9EglfU81FP7O5amPzz7vHbeEVsrwcF42/QajHSai7P/2Dy9HjcomRRlmp1
         ktlTI+Rck2SBoIl4bDLRVxJpVZoihij9FNoBpzQnKKNuGWQ7j4EWnBsZNShkeNVEZmGr
         wmZ8urDSBNSosLP28fDUNbQsfZWCVGBUEoEQ/jQi0cm+gjYJrG3XXEn0uxoi4XmDqxku
         WLHktZ0wZllg5RL+R47LilZN6EbjhQxPmDmS2lWc8n1a8sQLiaaXQ2Lb+K6xg0L1ilEE
         9rrg==
X-Gm-Message-State: AOAM533Cu9v7aWwZKlCPwQJ4hBfJNPr4rJ4t+Aivf/5ZjAJHmL5q4Yh+
        uNLYrzQylegte27Ipm7oN7XXWKPWIFc=
X-Google-Smtp-Source: ABdhPJwTGvV6S4Y2PDRBLjpfgRCXPW8ouQmjScrIYDK/QZTRkZ9ERh/dfAWLSJrjSVZdpsTrVCnaKg==
X-Received: by 2002:a37:b7c2:: with SMTP id h185mr61759341qkf.311.1636333623785;
        Sun, 07 Nov 2021 17:07:03 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d408:2f91:3d1a:771e? ([2600:1700:e72:80a0:d408:2f91:3d1a:771e])
        by smtp.gmail.com with ESMTPSA id h14sm10254188qth.23.2021.11.07.17.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 17:07:03 -0800 (PST)
Message-ID: <b42a3c00-2c6c-5cb6-2a3c-0aad095e6fef@gmail.com>
Date:   Sun, 7 Nov 2021 20:07:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 3/4] submodule: record superproject gitdir during
 absorbgitdirs
Content-Language: en-US
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20211014203416.2802639-4-emilyshaffer@google.com>
 <20211018231818.89219-1-jonathantanmy@google.com>
 <b208eb06-21c7-2199-0bc8-597669a165a1@gmail.com>
 <YYRrH6Hw/C1qj5MV@google.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YYRrH6Hw/C1qj5MV@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/4/2021 7:22 PM, Emily Shaffer wrote:
> On Mon, Oct 25, 2021 at 12:14:07PM -0400, Derrick Stolee wrote:
>> Since you're setting this config value inside the submodule's config,
>> what does it mean for a submodule to also be a worktree (and hence
>> require config.worktree)? What happens in this rough scenario?
>>
>>   1. git init sub
>>   2. git init super
>>   3. git -C sub worktree add super/sub
>>   4. git -C super submodule absorbgitdir sub
>>
>> I haven't actually tried running these things, but it seems unusual
>> and unexpected. This doesn't even account for cases where the repo
>> root and a worktree are both submodules within the superproject.
>>
>> If we already have protections preventing these worktrees as
>> submodules, then perhaps there is no need for work here. I'm not
>> familiar enough with the area to make a claim one way or another.
> 
> Yeah, I think there is actually a test case covering this in t7412:
...
> 147 test_expect_success 'absorbing fails for a submodule with multiple worktrees' '
> 148         test_must_fail git submodule absorbgitdirs sub3 2>error &&
> 149         test_i18ngrep "not supported" error
> 150 '
> 
> That is, I think because 'sub/' in your scenario above has multiple
> worktrees, the absorbgitdirs will fail. So I won't do additional work
> here. Thanks.

Good to hear. Thanks for tracking that down.

-Stolee
