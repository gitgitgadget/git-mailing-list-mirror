Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0458FC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 16:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiDMQcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbiDMQcP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 12:32:15 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BB640E77
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:29:51 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 9so2496183iou.5
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TZF4w/b93GUOw5fLAkWEABjuX5wz+rS8X6cxprRWdMY=;
        b=QxdY2J+yo4x1gGXQNI5IMaZDIfnySdTMqdRxZCTwEvXIqTHyLu7LD7GTb/QLFLvluR
         L/3eyQ2LEuf0B73QvtJgNVptzKmMYes8VMnoB2O27sk6ZzJ8ezGyElGSr9EzJUQmXlwj
         SD9nMIVCE8/8QPQIUhnAKtvSKs/5guV1CZA9C84pAJP/pH16Zk6qbHWJF9LISlqlT419
         uArjbeJXDrSehIaHUHr7KUO9tS0wkrjI3xyrXfCgEktXNXOiA4/mJXoYNMlao5II/IS4
         Kb9tquGfZ9SvHo7ZB4z1rD7zrryNGZ82ejsQOHe07us36Q/O7S0HiGFSnC2EVKMqWjaC
         XibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TZF4w/b93GUOw5fLAkWEABjuX5wz+rS8X6cxprRWdMY=;
        b=jOPlyEQ7CAPNq4eolcWoR9NTDSAfhj9r1ZGt7Yq6K6kEGHR8jy9xKAoLmqADb79UG5
         3lfUCSAQnaxrUQTU5M8vEOlR01+jjVPnJKkfxCFFKefzbEJWHY4Dsy1QrfmX+ijKW0qH
         OvbGkZ2eFNRjOw3nHJ0MGvphIiWo9FCB9R2iDex/le34RxF2V9EPIH0ZUAxbWcRep8Hu
         orZvS/NczZ9qolQDfXo878xCIXXfYv5HiI/SIZkTaZUVo50OCuOFlOOLoTwb6KfEsifr
         50UKs1xYTnGpPF68Z5BNT1hOW0QlNOdWTENtLcNp1iY8hXjZVMcCDi3y3COWXISuuIqc
         lgAA==
X-Gm-Message-State: AOAM5326HD2S+9WEWuNfC4BGUrVA6Rd+zGUfWiDNtWREBGb25/nbGNH4
        OM+BkSzYAAphBJ/Vnrd8pVP1
X-Google-Smtp-Source: ABdhPJycAOud3vfj/dUJ50Bi0IJ7w1lqIYCERBuo847Bkw6+KWsqFOSHepiCN/WZXdXbOrs6ytIMJA==
X-Received: by 2002:a05:6638:270b:b0:323:8ff0:a5e4 with SMTP id m11-20020a056638270b00b003238ff0a5e4mr20182663jav.102.1649867391375;
        Wed, 13 Apr 2022 09:29:51 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y4-20020a92d204000000b002ca9d47d5d0sm234800ily.20.2022.04.13.09.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 09:29:50 -0700 (PDT)
Message-ID: <7f5bebcd-5622-51c7-2904-b793337843b1@github.com>
Date:   Wed, 13 Apr 2022 12:29:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/3] t0033: add tests for safe.directory
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, johannes.schindelin@gmx.de
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <5b18bd1852d673ab5c62a67f873987d74294cd70.1649863951.git.gitgitgadget@gmail.com>
 <xmqqwnft9cjg.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqwnft9cjg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/2022 12:24 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> It is difficult to change the ownership on a directory in our test
>> suite, so insert a new GIT_TEST_ASSUME_DIFFERENT_OWNER environment
>> variable to trick Git into thinking we are in a differently-owned
>> directory. This allows us to test that the config is parsed correctly.
> 
> OK.
> 
>> -	if (is_path_owned_by_current_user(path))
>> +	if (is_path_owned_by_current_user(path) &&
>> +	    !git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0))
>>  		return 1;
> 
> Shouldn't the overriding "GIT_TEST_BLAH" be checked before the
> real logic kicks in, I wonder?

Either order would work. I bet that checking the environment is
faster than checking the disk, so swapping the order would be prudent
here.
 
>> diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
>> new file mode 100755
>> index 00000000000..9380ff3d017
>> --- /dev/null
>> +++ b/t/t0033-safe-directory.sh
>> @@ -0,0 +1,34 @@
>> +#!/bin/sh
>> +
>> +test_description='verify safe.directory checks'
>> +
>> +. ./test-lib.sh
>> +
>> +GIT_TEST_ASSUME_DIFFERENT_OWNER=1
>> +export GIT_TEST_ASSUME_DIFFERENT_OWNER
>> +
>> +expect_rejected_dir () {
>> +	test_must_fail git status 2>err &&
>> +	grep "safe.directory" err
>> +}
>> +...
>> +test_expect_success 'safe.directory matches' '
>> +	git config --global --add safe.directory "$(pwd)" &&
>> +	git status
>> +'
> 
> Just double checking, as I know you are much closer to the affected
> platform than I'd ever be ;-) but is the use of $(pwd) safe and
> correct here?
> 
> I always get confused between $(pwd) and $PWD, which does not make
> any difference on platforms I have access to, but makes difference
> to hurt Windows users.

These tests pass CI on Windows. I've had issues before using $PWD,
thinking back to tests in t7900-maintenance.sh that use $(pwd)
instead.

Thanks,
-Stolee
