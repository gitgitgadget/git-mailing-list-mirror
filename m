Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B8DC4727E
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 01:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99097206FA
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 01:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZrFwmMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbgJBBzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 21:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBBzp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 21:55:45 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EB1C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 18:55:43 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id m128so578977oig.7
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 18:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=snRWiHdM0Xpe4bh4gGIazAP9BI7q4fwX5EPzsb+yVds=;
        b=QZrFwmMxp2Jhe7YZ7E8EQGYaZVYTOw1a/Fel79WAgjLwtadyWRQZWsb4lkHR7EmLSb
         T8L3JVHeChRvdVgYdLnAe9Iee9TSOoErXiVJANb5xBIM3Ylm+u7PFU599iqbK7Hh0kXq
         nxZnx6zurqAqpeUDauBZ95krR8JM5GDnXbdySc7SlgcsLvEmIqftuZ84zip2HVFHuZpa
         xqkm3xFZCk6ONMB8G7JPzXOKJ3vzuwuSpTcTD4VytYliAJmZDXaAAXy/7EtgrCPSDaGY
         3ARBEyU7y31t5WGEGJICm0OXO5pRahKQQIDEXkrD0oag4E9b/gc+kpjYieJx2n40BVyw
         bfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=snRWiHdM0Xpe4bh4gGIazAP9BI7q4fwX5EPzsb+yVds=;
        b=sfdCYoTGhraqmf9oCKhr5dh3Lz03Y/gSFB9bNGGtaZAB1XqpbupY2dlr94K8FVHunO
         dwxMb7JFdA1Z2qce0/gywml2MPbSDc5wlPgx6zTCh8y8VGKOMPQp2sngo2cYLt1QaAcB
         pq5z35ChVhjbVVtzfu0vSprFyPJ/Tvcjc18J+DxxXYnJ6DmE2SW3dzzYu4F9UBSTZuX6
         Hgsdbv1sxOo8p307Wpn169ej2wJsXRzk71aJ7Zs88Sm+/nmiBLt60dGf8Ge5Ir4zH89t
         rpwPk4Oleth130Zw4/qKFsvCsNbkOZHLn8k3i3oaQ8bdsG2uANrttyNX5Q6FK+Ge3Fy3
         Tn7w==
X-Gm-Message-State: AOAM530p8Lp9iLgTLSh9Y56A2xJAhjb8vLfOSUW6Oc08TwImIRPsWiVx
        y4clvxjs0CanrmqdmHWFryY=
X-Google-Smtp-Source: ABdhPJx48QZHPpOW3QquMp0xnfvEe4hMorMaoWyE249wzKDU4c/Yp5kMBAnHsLOMecZ2k2tCnzE76A==
X-Received: by 2002:a54:4086:: with SMTP id i6mr155873oii.66.1601603743046;
        Thu, 01 Oct 2020 18:55:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8070:e593:34fe:7a8a? ([2600:1700:e72:80a0:8070:e593:34fe:7a8a])
        by smtp.gmail.com with UTF8SMTPSA id p1sm1709510otq.7.2020.10.01.18.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 18:55:42 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] maintenance: recommended schedule in
 register/start
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, sluongng@gmail.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
 <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
 <f609c1bde27558db2a9601ac34f8a51ce86f0e2c.1599846561.git.gitgitgadget@gmail.com>
 <CAN0heSqkJoqXKP5ccaGMA1_ppd0bcQ7G0ozUH+H7tBMonhcrjQ@mail.gmail.com>
 <bb9cd08f-1e59-ae19-b184-545688451203@gmail.com>
 <3e18199a-1dcb-057d-4753-03d5acfcc036@gmail.com>
 <20201002003844.GA28643@danh.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2198ba04-e73a-cfd5-960c-909a4f3ef0d2@gmail.com>
Date:   Thu, 1 Oct 2020 21:55:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20201002003844.GA28643@danh.dev>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/1/2020 8:38 PM, Đoàn Trần Công Danh wrote:
> On 2020-10-01 16:38:48-0400, Derrick Stolee <stolee@gmail.com> wrote:
>> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
>> index 7628a6d157..52fff86844 100644
>> --- a/Documentation/git-maintenance.txt
>> +++ b/Documentation/git-maintenance.txt
>> @@ -37,6 +37,21 @@ register::
>>  	`maintenance.<task>.schedule`. The tasks that are enabled are safe
>>  	for running in the background without disrupting foreground
>>  	processes.
>> ++
>> +If your repository has no `maintenance.<task>.schedule` configuration
>> +values set, then Git will use a recommended default schedule that performs
>> +background maintenance that will not interrupt foreground commands. The
>> +default schedule is as follows:
> 
> I don't mind about using a default schedule (but someone else might).
> I think some distributions will be paranoia with this change and shiped
> with disable by default in system config.

If a user wants to prevent this schedule, then they can simply change
any one of the `.schedule` or `.enabled` configs in their --global config
and these defaults will not be used.

Of course, perhaps you are missing the fact that "git maintenance run
--schedule=<frequency>" is only run as a cron job if a user chose to
start background maintenance using "git maintenance start" (or "git
maintenance register" after running the 'start' subcommand in another
repo). So this is _not_ starting by default without some amount of
choosing to opt in.

>> ++
>> +* `gc`: disabled.
>> +* `commit-graph`: hourly.
>> +* `prefetch`: hourly.
> 
> However, no `prefetch` in default schedule, please.
> IIUC, this is a network operation, if someone is on the go and paying
> their internet based on their traffic, this will be a disaster.

It _is_ a network operation. You're right that we should make it clear
that network operations are being run in the background if the defaults
are being used.

Of course, this is why "git maintenance stop" exists. Background
maintenance can be halted while not being in a mode where this maintenance
is acceptable.

And further: these defaults are optimized for desktop machines that are
expected to always be on and connected to a non-metered network. Laptops
are not always on, not always connected, and sometimes are metered. Perhaps
a user should decide that they don't want to have background maintenance,
and then they can choose to not opt-in.

If this scenario is common enough, then we could extend the "prefetch"
task to somehow detect (on some platforms) that the network connection is
metered, and then not do any fetches.

>> +* `loose-objects`: daily.
>> +* `incremental-repack`: daily.
> 
> And I would say no incremental-repack, too.
> Users don't want to a large operation of IO on some random time of the day,
> be it when they open their PC in the morning, or when they want to close
> their laptop to go home.

But that's exactly why incremental-repack is an improvement over
a "random" instance of 'git gc --auto' going over an invisible threshold.
The "incremental" nature is intended to only do a reasonable amount of work 
instead of rewriting everything.
 
> ----------(Windows rant ahead)
> I still remember those days that Windows 8 was introduced,
> Back in that days, my computer still uses the old 7200rpm HDD.
> I was super-angry that whenever Windows is started, it starts some IO
> disk-caching, indexing that hung my computer for a good 10 minutes.
> While that same computer can run Windows 7 and other OS fine.
> I don't particularly care how much my computer is faster after that.
> I want my computer usable at that time, instead of wasting a good 10
> minutes on nothing.
> ---------(Windows rant end)
> 
> Either the users know what are they doing, or we don't do anything at
> all. Let's them do it on their free time.
> 
> IOW, Please let users opt in instead of opt out of this features.

But users _do_ opt-in to this feature. They need to start the maintenance
at all to have this run. We just need to give them something that actually
"maintains" their repository without being incredibly expensive or
possibly leading to data loss. That is exactly why "incremental-repack" is
chosen over the "gc" task. If there isn't enough work to be done, then
this task is very cheap to do.

Perhaps all of your concerns are satisfied with this reassurance that
background maintenance is completely opt-in and will not be set up
without a user explicitly enabling it.

Thanks,
-Stolee

