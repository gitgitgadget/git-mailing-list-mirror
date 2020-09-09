Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F37C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 15:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDDB21D7D
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 15:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFGCUj3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgIIO7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbgIIMWW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 08:22:22 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C34C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 05:14:56 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q63so1371339qkf.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wECv5/S28QMHurqm7XK6ztbNZ6aztfBqHaEXNmMSoLY=;
        b=JFGCUj3bNA4yn2i+kFdZdJPBYDiiSb4MGlLpZ2n5q6Z9K/zut30R6Nk2iMtpl3Rnd7
         ONY6ErCwYHrT7Qp4zrUoE4jNXQZYcKPTz4LN1UQ1xMxUtcwX3x6ALvMXPW9FpG6CngQ5
         Q0Q0aUaVbgxt0TwXij+q6O108YRF2YMIF7HV6Oz8ZDkEQ5Afku4U2R+W/utb3BFp7NSE
         7mYVlysW9Ob3Ruae2lUIgIbntmuM/IWKgEwfmP8mItsBhnQwPfSVGxOpajqJoWB7OSCp
         fWcA50synVaeFE7Tx0E8RRmqpLYYW9ec//AcLnZzl+Pcv4CK4I01tiC1cGDyxf7FDdma
         /diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wECv5/S28QMHurqm7XK6ztbNZ6aztfBqHaEXNmMSoLY=;
        b=B7541eMCSCUEUUs4eflckzK+m5XQBhQD50BYDClFzYf874y586Fzq/HE6wcQGOJGj6
         FXlamH+VL1BePxLLSnzhNHorFYG+/nGP3qInn1X9Pshho+PwQRhfJornNjwjI2Dm3mH2
         yEebDvNKeDMPKAQNR3XKeayGJ2yyJqUUwuxIVFEzN/WM9MTg0ZMjXoE0xyxD0+U4zVnm
         Lm62oSs16gJGJRJiIV/jsP8CgPZAdoR9BeVwW+dOaVwXiH26LAgMyo0O6K+8a5BdbYTj
         oTUKaQS2VmdUAcgiC6rMGt3Gvbu4MMCrPHwYCG4ie499q8a3o/EuFuaTwXEo8M7Moym7
         wvlQ==
X-Gm-Message-State: AOAM530nG8q1DkH8tmeUmxYGxUmF6xCp/az4mBPhsmw4hIAoycIvBa3R
        J+ZGGjJHwnFx5DIKVo3eaf4=
X-Google-Smtp-Source: ABdhPJwmvUTmaUyc1YOwhZOhZMb3gwYLLZH2szn3PZvwjbc/YZe5ohFmT0gTHZF10Oy2pRnNcxiKcw==
X-Received: by 2002:a37:65c8:: with SMTP id z191mr3102759qkb.161.1599653695808;
        Wed, 09 Sep 2020 05:14:55 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:84a2:b0cb:7621:10c7? ([2600:1700:e72:80a0:84a2:b0cb:7621:10c7])
        by smtp.gmail.com with ESMTPSA id p63sm2380241qkc.4.2020.09.09.05.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 05:14:55 -0700 (PDT)
Subject: Re: [PATCH 2/7] maintenance: add --schedule option and config
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
 <1783e80b8d3b8361d1d62947a49ba584685dacc4.1599234126.git.gitgitgadget@gmail.com>
 <20200908130738.GB25593@danh.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f1d8e155-2f9e-b0ea-6845-4c0e0d7c94d6@gmail.com>
Date:   Wed, 9 Sep 2020 08:14:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200908130738.GB25593@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/2020 9:07 AM, Đoàn Trần Công Danh wrote:
> On 2020-09-04 15:42:01+0000, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> A user may want to run certain maintenance tasks based on frequency, not
>> conditions given in the repository. For example, the user may want to
> 
> Hm, sorry but I couldn't decipher "not conditions" here. :|

Awkward, yes. I intended to contrast frequency-based maintenance with
threshold-based maintenance (git gc --auto).

>> perform a 'prefetch' task every hour, or 'gc' task every day. To assist,
> 
> I think it's better to say: "To assist those users", at least it's
> easier to read for non-native English like me.

Thanks.

>> update the 'git maintenance run' command to include a
>> '--schedule=<frequency>' option. The allowed frequencies are 'hourly',
> 
> So, we have "--schedule=" here, ...
> 
>> 'daily', and 'weekly'. These values are also allowed in a new config
>> value 'maintenance.<task>.schedule'.
>>
>> The 'git maintenance run --schedule=<frequency>' checks the '*.schedule'
> 
> and here, ...
> 
>> config value for each enabled task to see if the configured frequency is
>> at least as frequent as the frequency from the '--schedule' argument. We
>> use the following order, for full clarity:
>>
>> 	'hourly' > 'daily' > 'weekly'
>>
>> Use new 'enum schedule_priority' to track these values numerically.
>>
>> The following cron table would run the scheduled tasks with the correct
>> frequencies:
>>
>>   0 1-23 * * *    git -C <repo> maintenance run --scheduled=hourly
>>   0 0    * * 1-6  git -C <repo> maintenance run --scheduled=daily
>>   0 0    * * 0    git -C <repo> maintenance run --scheduled=weekly
> 
> but it's spelt with "--scheduled=", here and below, mispell, I guess.> 
> Reading the patch, it looks like "--scheduled=" is mispelt.

Yes, a previous version used "scheduled" and I didn't fix it here.

>> @@ -1250,8 +1289,10 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
>>  			continue;
>>  
>>  		if (opts->auto_flag &&
>> -		    (!tasks[i].auto_condition ||
>> -		     !tasks[i].auto_condition()))
>> +		    (!tasks[i].auto_condition || !tasks[i].auto_condition()))
>> +			continue;
> 
> This line only add unnecessary noise to this patch.

Thanks,
-Stolee
 
