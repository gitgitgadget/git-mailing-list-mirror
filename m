Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2C3C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 22:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3B62176D
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 22:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skBpTsxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfK1WE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 17:04:59 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:42364 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfK1WE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 17:04:59 -0500
Received: by mail-oi1-f180.google.com with SMTP id o12so24363584oic.9
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 14:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/JP+OB+zuo9ryyd0YPPJhMZm2duTJZ7Ya6sw8k5OKS4=;
        b=skBpTsxcHyM8xqM9Osg44gqZUuJicDp30/4G/DGaGxhnJyFXi8tiaiDshYkTbaQoSB
         /xHioTvnHWQ32qysqhS+rZM5kxkdWteTgAuK6RTH3SJd00uemm8BYYs/bIMasyNxqrQ2
         cjKtvFj9WjMnwXVhj+INu/P9/HZkTztJVgb+RFv43L3YNPlbNUGR6eKInEssKjXi8jap
         VU82c8h4DE84dUlQt9ShKhmBQWTCcxYeAJ+KS7VCyf8+H2WxFmzPDqrU239FIOJTcwLK
         +CGfEeujwAJDZDlat9OSNSNGN6J1+FrYHZK2MyL30Z+xuv66KCV3OicAdSocperBKT3P
         eZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/JP+OB+zuo9ryyd0YPPJhMZm2duTJZ7Ya6sw8k5OKS4=;
        b=VZaNhNg4VB2x8cINpfTRpxWfkuPTl5SsSWbZmevLTPqDDTyoDuKB2/GHeq2OzOmu8+
         HRWZ7D+xw6/izcs/XagC2sC7Y9blVy/Ap5jjvBD1uWQV00o3oxWDjDLmdTVdws1pRYn2
         Rt3DH1oQtcCAn0tdVus0OOYdovtQ9ivPWv4CdByJfPcGneqz62AJTUCyVmYhBKN4Tqj8
         FgbaCI/c54qlC8bRWdzMaUclyrThCfUV/1OCbSD53tIIXfNau0Mcy+7onG9NvdD/VmFv
         1JSlrE0xFALzvXO73Le1WkV9qmfokbGK5H9AOoTApGtJfVJXaGsVDQDPHoWsoieG4lbO
         MAhQ==
X-Gm-Message-State: APjAAAWe10HrvtQjdiUOqst7PLCxu1sB4jRMCslFjb6WZvxS6Sj72xDD
        fmIgw4dTySF5Rxm3qcTwtn6s5xfD
X-Google-Smtp-Source: APXvYqzEzTGFTuhK40PCuUhl+MF1gg4qDJV1a9cCPWT99X6iyoWesjQOMTYGuGq9q2Yi9S3xrAsMvQ==
X-Received: by 2002:aca:ef8b:: with SMTP id n133mr9545424oih.11.1574978697637;
        Thu, 28 Nov 2019 14:04:57 -0800 (PST)
Received: from [192.168.1.2] (64-136-202-95.dyn.everestkc.net. [64.136.202.95])
        by smtp.gmail.com with ESMTPSA id p3sm349676otg.33.2019.11.28.14.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 14:04:57 -0800 (PST)
Subject: Re: Git Test Coverage Report (Nov 25)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>
References: <1cb7ddbf-020e-d63a-85b6-5a9267c0a5a3@gmail.com>
 <nycvar.QRO.7.76.6.1911262116100.31080@tvgsbejvaqbjf.bet>
 <59ae5223-6dd8-00cd-4c39-b307f8364457@gmail.com>
 <nycvar.QRO.7.76.6.1911272029050.31080@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b9515bf6-81ec-3b24-8982-5248e36306fe@gmail.com>
Date:   Thu, 28 Nov 2019 17:04:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1911272029050.31080@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/27/2019 2:32 PM, Johannes Schindelin wrote:
> Hi Stolee,
> 
> On Wed, 27 Nov 2019, Derrick Stolee wrote:
> 
>> On 11/26/2019 3:46 PM, Johannes Schindelin wrote:
>>
>>> [...] the Windows build.
>>
>> Sorry that I have not set up a Windows build, but the Linux test-coverage
>> build already takes a long time so adding Windows would be complicated.
>> (Not to mention that merging the uncovered lines across two platforms would
>> be a huge challenge.)
>>
>> If anyone wants to consider such an effort, I'm willing to play along.
> 
> I fear it is even worse: once upon a time, I tried to set up a gcov run
> with mingw-w64-gcc, and it failed miserably (there was simply no output at
> all).
> 
> So I, for one, am completely comfortable with keeping the status quo for
> the time being.
> 
>>>> Johannes Schindelin	116d1fa6 vreportf(): avoid relying on stdio buffering
>>>> usage.c
>>>> 116d1fa6 16) fprintf(stderr, "BUG!!! too long a prefix '%s'\n", prefix);
>>>> 116d1fa6 17) abort();
>>>> 116d1fa6 22) *p = '\0'; /* vsnprintf() failed, clip at prefix */
>>>
>>> Those are defensive programming, so this is expected not to be covered.
>>
>> I wonder why we are not using BUG() here (for the fprintf and abort).
> 
> It's because `BUG()` calls `vreportf()`, and even if the _current_ version
> would bail out at some point, I would be uncomfortable calling `BUG()`
> from `vreportf()` and risk a (future-only) recursion ad infinitum.

That's a pretty good reason to not use BUG() here!
