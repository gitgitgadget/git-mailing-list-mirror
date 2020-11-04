Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4593CC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D95682071A
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu/VapVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgKDNCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgKDNCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 08:02:37 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E38C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 05:02:37 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id z16so14045202otq.6
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 05:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0zegHOFsnA3hE6d/giOGcImxoRY3ahyFukum92q9Zzw=;
        b=Bu/VapVuYQmpVJXI2VPA5gCI3T5Y9SLfzqIoZZarj75FLKMXnGfdFO2OmUz1ZwqWQI
         gwjRoWTx0TBitpKpfsvovGN99KlqWZODI60v2YcYmj8QbH9Zr2yJ3enGYC8SDQRzeDcQ
         bNTXg/ZcyHDjdnn7iPj62g7s93ZhpNvyH75eUIZTFh3kjotkFUHCUVJyRuWlb0K+CzJe
         Zw2rvf9009EF5HUywth+ly/fFTBg80V6QumN0vQUkTHhbyIv17YoF0Mu6nCSMN0HCiWl
         hoJJceOxaxADA6ZTtp4Q/5xhEfTDZrBI/Xy2jmylhKpggSgh6zo6P053ELjG+L8x+/RY
         tZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0zegHOFsnA3hE6d/giOGcImxoRY3ahyFukum92q9Zzw=;
        b=o7aMVENDkBkyqUc4K0GoW5ySb+gdNQrVPbeCWki2o82URQHt6rX01CqUkUHe7AA1hZ
         fNpIvUQ92BSgHgQ9G5tZ0rP5vtU0aiWHSGK/li+8dqqKrlYbZ9X6kODoJFUk5fy5vdb5
         x3kV+F3Yi964lz1veH7O+8/qXH/ecJRAUK815Nr4782ebRLVsgJrbUkF4X9Axrze/TZS
         yegfrgsuendf4NDTB0hsyj5IrLmpV5UdWjSDXnOXRjOMnComkr08puUYkcJKNsy8izGN
         jlEmhJ+j+VUDX235f+761Tc/VjtesU3pA5rTmTViqYN4Ny0tL7bQ1Vh95Ieq553g+bYp
         n3aw==
X-Gm-Message-State: AOAM5330a83wzWnZLreh7uAUjBLIbA547Z9F/kuboHgVEUFjfR5khXCv
        ZQNCouaFlHd8Er7OUuPxzcc=
X-Google-Smtp-Source: ABdhPJxqc9ST1BsLQeazAi9hltvj2YTqO99NgmUhtxhliSCG+XGD/5FF8sywCo08h0C/JN9mU2uMyg==
X-Received: by 2002:a9d:aa8:: with SMTP id 37mr10322063otq.286.1604494956519;
        Wed, 04 Nov 2020 05:02:36 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id j10sm489298oou.4.2020.11.04.05.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 05:02:35 -0800 (PST)
Subject: Re: [PATCH 0/3] Maintenance IV: Platform-specific background
 maintenance
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
 <xmqqmtzyqjil.fsf@gitster.c.googlers.com>
 <022c5792-e66c-71d8-fbf4-ead9231030ad@gmail.com>
 <xmqqo8keoyy8.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <af2befd7-7d93-5981-42c8-700e49f3999a@gmail.com>
Date:   Wed, 4 Nov 2020 08:02:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8keoyy8.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/3/2020 5:30 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>> I'm hoping that parts 3 and 4 can make it in time for 2.30,
>> so the feature is universally available for all platforms.
>> I realize that's not entirely up to just me.
> 
> After writing this entry in the What's cooking report:
> 
>     * ds/maintenance-part-4 (2020-11-03) 3 commits
>      - maintenance: use Windows scheduled tasks
>      - maintenance: use launchctl on macOS
>      - maintenance: extract platform-specific scheduling
>      (this branch uses ds/maintenance-part-3.)
> 
>      Follow-up on the "maintenance part-3" which introduced scheduled
>      maintenance tasks to support platforms whose native scheduling
>      methods are not 'cron'.

This is a good summary of this series.

> I was wondering if I should propose making these two parts into one,
> so we may be pretty much on the same page.

I'm happy to have the two topics be merged into one series, but
I'd prefer to only re-roll these three patches during review.
Of course, by keeping them together we have the ability to re-
roll all of the patches, but part-3 has a decent length and has
been stable for a while.

I defer to what is easiest for you.

Thanks,
-Stolee

