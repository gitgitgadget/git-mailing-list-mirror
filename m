Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AB2C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 17:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A432076B
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 17:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGnf0foY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgHKROH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgHKROG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 13:14:06 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380A4C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 10:14:06 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l64so12319313qkb.8
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 10:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sOanewU0uThtWPL6RaouDZEYUQHMdG86OW4sBrg+mIU=;
        b=LGnf0foYy/ICTZNsMIe0VZuUny+x5lt/EufeRAm9xq4ulP3RT2Cbco+Zq5W3AFCfiB
         3Aw8yiZyhSsXj+8kDjnbZ7mq+cfkfM/RsgA1pI6lo1ZdQyQIGWeHNvfp60z3v50Ibzq2
         7q/nRxhnNkNTeDUGbQPzNk7JKg9JaLcwkknXc+/N07OEYSoc1d9TqEAdMgkjUH9Elg2Q
         0OaqQFQXXo6UAmr0i4FY4wIqZu93q4SMR9AmF+uE2c1ZyywQCmWxCGz/fhBuMlNjpP4X
         3yZQC5uwW3P8S1XPU3HACrr2rKTM1kSReM5rZO/wNovAaUhCbR31xsN6XtL4qRZrE8ow
         UuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sOanewU0uThtWPL6RaouDZEYUQHMdG86OW4sBrg+mIU=;
        b=njcsqpy3J2P5HYW9s78NYeMECOviK2DzBBwh4HoToJU1PqP/9vilgxOdkax8hq6nIm
         o3ZnBkhbYZQUR38nNwrsKTR+0BoEG+PBUlTDhQDqPxBfDSs82zQLo5EX4oKVbW+hjDHx
         u2Cihk9RrwLtYhaJQYF6SetMRMZan4LFqtIPQIy9wYD9r2OFDM53th1VfP/8WE7nqnpU
         BvZAw3zTDSDpd8Ll6Fosf3srqx4E4S0QiUMx8/SN1wMTK+BSz9qmBNNWxI6P4pfqvJKR
         c8+PZvP5ZJXslGu86vALeJA4WKmyWw86iWEZ3G/HBmE8jY2ZNpAGERrVfwRZ9QbpXHlv
         wfTA==
X-Gm-Message-State: AOAM5324ELvJQvOGJGhKXuzhzeSrc2SI39VqpfK57WxoU57Vd27xAfla
        fO6pl9iiP5cd/WvJ7Vn6Q6A=
X-Google-Smtp-Source: ABdhPJxsXSPgw9RKOwJD2f5mlsb7yWKMIK1QpWNrMQus8PbcoiDK6Y78tzXqbl8L68G21JSIziQ7rQ==
X-Received: by 2002:a37:9c57:: with SMTP id f84mr2127528qke.34.1597166045183;
        Tue, 11 Aug 2020 10:14:05 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with ESMTPSA id i14sm9919460qtq.33.2020.08.11.10.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 10:14:04 -0700 (PDT)
Subject: Re: [PATCH] midx: use buffered I/O to talk to pack-objects
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
References: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
 <90541678-f412-89a1-2ee0-4cae30e26551@gmail.com>
 <3655b3c8-9b60-daec-c3a2-6e3703ec5b3f@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bf1fcdb6-f7bb-4235-8403-a36c38180ee7@gmail.com>
Date:   Tue, 11 Aug 2020 13:14:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <3655b3c8-9b60-daec-c3a2-6e3703ec5b3f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/11/2020 12:08 PM, René Scharfe wrote:
> Am 03.08.20 um 14:39 schrieb Derrick Stolee:
>> On 8/2/2020 10:38 AM, René Scharfe wrote:
>>> Like f0bca72dc77 (send-pack: use buffered I/O to talk to pack-objects,
>>> 2016-06-08), significantly reduce the number of system calls and
>>> simplify the code for sending object IDs to pack-objects by using
>>> stdio's buffering and handling errors after the loop.
>>
>> Good find. Thanks for doing this important cleanup.
>>
>> Outside of Chris's other feedback, this looks like an obviously
>> correct transformation.
> 
> I spent a surprising amount of time trying to find a solution that is
> easy to use and allows precise error handling.  But now I get second
> thoughts.  The main selling point of buffering is better performance,
> which is achieved by reducing the number of system calls.  How much
> better actually?
> 
> So I get this in my Git repo clone without this patch:
> 
>   $ strace --summary-only --trace=write git multi-pack-index repack --no-progress
>   % time     seconds  usecs/call     calls    errors syscall
>   ------ ----------- ----------- --------- --------- ----------------
>   100.00    2.237478           2    921650           write
>   ------ ----------- ----------- --------- --------- ----------------
>   100.00    2.237478                921650           total
> 
> And here's the same with the patch:
> 
>   % time     seconds  usecs/call     calls    errors syscall
>   ------ ----------- ----------- --------- --------- ----------------
>   100.00    0.013293           2      4613           write
>   ------ ----------- ----------- --------- --------- ----------------
>   100.00    0.013293                  4613           total
> 
> Awesome, right?  write(2) calls are down by a factor of almost 200 and
> the time spent on them is reduced significantly, as advertised.  Let's
> ask hyperfine for a second opinion though.  Without this patch:
> 
>   Benchmark #1: git multi-pack-index repack --no-progress
>     Time (mean ± σ):      1.652 s ±  0.206 s    [User: 1.383 s, System: 0.317 s]
>     Range (min … max):    1.426 s …  1.890 s    10 runs
> 
> And the same with this patch applied:
> 
>     Time (mean ± σ):      1.635 s ±  0.199 s    [User: 1.363 s, System: 0.204 s]
>     Range (min … max):    1.430 s …  1.871 s    10 runs
> 
> OK, so system time is down by ca. 50%, but the total duration is
> basically unchanged.  It seems strace added quite some overhead to our
> measurement above.
> 
> Anyway, now I wonder if adding our own buffer on top if the
> OS-internal pipe buffer is actually worth it.  The numbers above are
> from Debian testing , by the way.  Perhaps buffering still pays off on
> operating systems with slower pipes..

For what it's worth, I took your patch and applied it on Git for Windows
and tested 'git multi-pack-index repack' on my copy of the Git repo
(which includes Git for Windows and microsoft/git for a total of
1.7 million objects) and saw the time improve from 22.3s to 16.6s!

The "Enumerating objects" progress bar was visibly faster when I was
watching the command.

I was not expecting such a huge speed bump, seeing how the objects
are being repacked, so this command includes complicated processes
like delta compression an zlib compression.

Thanks! This is definitely worth the speed boost on Windows.

-Stolee
