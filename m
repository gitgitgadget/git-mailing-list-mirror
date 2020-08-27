Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD63C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBB42087D
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txeGPF1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgH0PrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgH0PrG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 11:47:06 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E778C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:47:06 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e5so4863594qth.5
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SFKbik7daAZ4pOqM0e8Mcgmoc4Mg6s1mUD4gZ/n+B/k=;
        b=txeGPF1MQyWbUiNt/PSId70vqmF+yMI7K7Mr988FZXXRi1YXpzhRS0tASuHTFn0Gg4
         vaFNyEwfQRFuaxbGl8WKcHw2Qa1tCDqBjz/xx+UJzNfBoV8otQnil5gaFTWl+hpA3Llp
         iMiZ5+EriQNn94qXUKx9voI6yfya14VBN3EQo8DeDjQIHWUrGlgqvfW0AWKE6ylWdYPp
         DNAY7Jzoimf7S9fhHVqsl6Bo9+/micUjRGXwkHDLy/1iABHDd/9FrtU/XAx37KyUcxfi
         4sJvPV0TH741zI3sbREKD+1XMHKGHkyJgoLTUBgQgSqiKgy5t5AKAbUzCHvR3MwCvUgu
         7OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SFKbik7daAZ4pOqM0e8Mcgmoc4Mg6s1mUD4gZ/n+B/k=;
        b=jeO4x1BS7AO1bpg2Db3XTM6M9QGi/1cW8OIU/E2UGIFdYCC+vgDfpwu4hnhic7Idy6
         lFD6D/QZJRP4UcB3f+tbfkmPaOcnJwFu8g6omKN6XiZ+bA2tB00Y3jIANGjdB5/9Rhk3
         SxmGh5ysy618VeG+KsE00mOLcdSWxk+z5yoxGC4PstVLItwLGBcdB5BZmJnv9PG9hvQI
         4veRRkExJbgAxFOYSlgcRKNJclp+ziicrWPoTt+iDVyvgDndY8PAJ/EiH/3SMBsP0a32
         a3RzaRFKP/Hx18x7xbnjboM+l9rUbhj/2s5vJL5UVafJowktb+0ahOvKf0OeEgx5xXlB
         +x1A==
X-Gm-Message-State: AOAM532jso4ZoBB0kN+rI+A+40lBmTi0PxrObqBWSvBJfzWzBGwjITCr
        OtpHBAGRF7sqQkKvvyrDkv4=
X-Google-Smtp-Source: ABdhPJxVOwn/GLBRFUCLv3ehgiGyJO3iHlD5VoVH/QEg80M4EV+d1kgz4TpZG0wiBOKnMm/GGA9cHA==
X-Received: by 2002:ac8:17af:: with SMTP id o44mr7243355qtj.343.1598543225140;
        Thu, 27 Aug 2020 08:47:05 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b932:a679:4c12:1a2a? ([2600:1700:e72:80a0:b932:a679:4c12:1a2a])
        by smtp.gmail.com with ESMTPSA id g4sm1961640qtp.89.2020.08.27.08.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 08:47:04 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] maintenance: add --scheduled option and config
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
 <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
 <c728c57d85b17035d42313260620a7de5756b0c3.1598380805.git.gitgitgadget@gmail.com>
 <xmqqd03ez8pp.fsf@gitster.c.googlers.com>
 <bd4e18b7-6265-73e7-bc1a-a7d647eafd0a@gmail.com>
Message-ID: <4666c635-b808-a0a8-ab3a-0a07e222827b@gmail.com>
Date:   Thu, 27 Aug 2020 11:47:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <bd4e18b7-6265-73e7-bc1a-a7d647eafd0a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/26/2020 11:30 AM, Derrick Stolee wrote:
> Let users specify a schedule frequency among this list: hourly, daily,
> weekly, monthly. We then set the following* crontab:
> 
> 	0 * * * * git for-each-repo --config=maintenance.repos maintenance run --scheduled=hourly
> 	0 0 * * * git for-each-repo --config=maintenance.repos maintenance run --scheduled=daily
> 	0 0 * * 0 git for-each-repo --config=maintenance.repos maintenance run --scheduled=weekly
> 	0 0 0 * * git for-each-repo --config=maintenance.repos maintenance run --scheduled=monthly
> 
> *Of course, there is some care around "$path/git --exec-path=$path"
> that I drop for ease here.

Jeff Hostetler pointed out the following details in the crontab
documentation [1]:

 Ranges of numbers are allowed.  Ranges are two numbers separated with
 a hyphen.  The specified range is inclusive.  For example, 8-11 for
 an 'hours' entry specifies execution at hours 8, 9, 10, and 11. The
 first number must be less than or equal to the second one.

[1] https://man7.org/linux/man-pages/man5/crontab.5.html

This means we could try this schedule:

 0 1-23 * * * git for-each-repo --config=maintenance.repos maintenance run --scheduled=hourly
 0 0 * * 1-6 git for-each-repo --config=maintenance.repos maintenance run --scheduled=daily
 0 0 1-30 * 0 git for-each-repo --config=maintenance.repos maintenance run --scheduled=weekly
 0 0 0 * * git for-each-repo --config=maintenance.repos maintenance run --scheduled=monthly

And it should behave this way:

 Run --scheduled=hourly every hour, except at midnight. This runs
 all "hourly" tasks.

 Run --scheduled=daily at midnight, except on Sunday. This runs all
 "hourly" and "daily" tasks.

 Run --scheduled=weekly at midnight Sunday, except on the first day
 of the month. This runs all "hourly", "daily", and "weekly" tasks.

 Run --scheduled=monthly at midnight on the first day of the month.
 This runs all scheduled tasks.

There is some subtlety between whether the "weekly" runs should be a
subset of "monthly" and maybe the easiest way to handle that would
be to not support "monthly" and have only "hourly", "daily", and "weekly"
options for now.

This should get around all of the parallel issues and allow us to drop
the *.lastRun config option.

Thoughts?

Thanks,
-Stolee
