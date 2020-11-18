Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71488C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6FE20897
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0YR/As2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgKRSaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgKRSav (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 13:30:51 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D30EC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 10:30:51 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id m65so2329509qte.11
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 10:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=24i0ywghmvEmioM+rZ0Rr/rasf8epqJTXrAOT1xw83c=;
        b=j0YR/As2WlErEuMKTioVh/N/ljJf7hcWjrBgYxOFNUPS4JQbsnf1Te5F5jAc5nwERX
         hAZX+38lHrmPGF/i7oGTVRIft5eXSoMMkF/Xzcfv+2FCBB3P9TqEolowCZtOhzjHvcj1
         C55SW0L4r6Q3rJD+Fsf/hT3n91M9WfHCpfpxSqKi43KIhzfYNsBco/QQ8+a1Um5zV+gn
         I/ZdO/0jEYQdzQnKyf/65UDReqAHetNHZgW1bNxFLZH17ArpUXrAUu9KfUp68RyQoFa6
         34X4fzcv7gQ5f2ptLPAkonj7rpWdN7AqppKcVHNmQ6vNedqmWwGjdEiOVJ0HMs3PZEeE
         f+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=24i0ywghmvEmioM+rZ0Rr/rasf8epqJTXrAOT1xw83c=;
        b=CTGSHehg9+J//SjCcBF0xtjNslTRs8qx0GZ5kn89YnSzWZEl66IPWDHRKvAdQF1D3k
         YPQX+ZLR/RGB9eA8b8+mdKPOzHJXq6tD6li5MxGl6U8tEK6Nctv5i4HA6Cw4enSCLMnL
         VBM1Reck7lmNusYpFindYWQ4gxGgldpRbq7DJZWR9NTmw1UMf9/uVUAf4dQ3YwHnxEkq
         dbO5dvJsAiq90zjy0eg27k19IKwgY/R77ubZKzBtAtj11bUOS2raNYLB57kUXqg9jdYA
         9ObJmF/UqngjJwp1uhEyA9ZuqAuBVTItrm0kyA8rgo3pj/jSrNFWqXOps5gIwahN68FS
         7+3Q==
X-Gm-Message-State: AOAM530bK3qDw/8VSOeMiJ3py3y9hvC6xMVPFqKeT3Do+LXDutEOTjL8
        JWhyHoF2C7M3zCTRfCWivR2/zy0bHqzv9Q==
X-Google-Smtp-Source: ABdhPJxdWxARPV62MCEOclD2Vy45N9jhAegt63Cifgw6aUsDTBFKh0UQ1VLU4zdS49I0K2lg9pG5WA==
X-Received: by 2002:a05:622a:142:: with SMTP id v2mr5903846qtw.169.1605724250762;
        Wed, 18 Nov 2020 10:30:50 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:805f:b8ae:cbb3:6b01? ([2600:1700:e72:80a0:805f:b8ae:cbb3:6b01])
        by smtp.gmail.com with UTF8SMTPSA id w15sm5788347qkf.52.2020.11.18.10.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 10:30:50 -0800 (PST)
Subject: Re: [PATCH v4 2/4] maintenance: include 'cron' details in docs
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
 <99170df4626544c1dc26d2e188b215a776140a32.1605647598.git.gitgitgadget@gmail.com>
 <CAPig+cQw=hBqp2jSOOKNCKMe7bUFFLqT2fi0iaBfth-4x7RTgQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6bd1b36f-48fe-c27d-3917-899a9b28eef3@gmail.com>
Date:   Wed, 18 Nov 2020 13:30:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQw=hBqp2jSOOKNCKMe7bUFFLqT2fi0iaBfth-4x7RTgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/2020 7:34 PM, Eric Sunshine wrote:
> On Tue, Nov 17, 2020 at 4:13 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Advanced and expert users may want to know how 'git maintenance start'
>> schedules background maintenance in order to customize their own
>> schedules beyond what the maintenance.* config values allow. Start a new
>> set of sections in git-maintenance.txt that describe how 'cron' is used
>> to run these tasks.
>>
>> This is particularly valuable for users who want to inspect what Git is
>> doing or for users who want to customize the schedule further. Having a
>> baseline can provide a way forward for users who have never worked with
>> cron schedules.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
>> @@ -218,6 +218,60 @@ Further, the `git gc` command should not be combined with
>> +The comments are used as a region to mark the schedule as written by Git.
>> +Any modifications within this region will be completely deleted by
>> +`git maintenance stop` or overwritten by `git maintenance start`.
>> +
>> +The `<path>` string is loaded to specifically use the location for the
>> +`git` executable used in the `git maintenance start` command. This allows
>> +for multiple versions to be compatible. However, if the same user runs
>> +`git maintenance start` with multiple Git executables, then only the
>> +latest executable will be used.
> 
> It looks like this section in v4 got accidentally reverted to the
> wording from v2, whereas v3 had been changed to:> 
>     The `crontab` entry specifies the full path of the `git`
>     executable to ensure that the executed `git` command is the same
>     one with which `git maintenance start` was issued independent of
>     `PATH`. If the same user runs `git maintenance start` with
>     multiple Git executables, then only the latest executable is used.

Embarassing. Thanks for the catch.

Thanks,
-Stolee
