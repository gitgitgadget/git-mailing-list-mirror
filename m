Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72678C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiCCQKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiCCQKI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:10:08 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8BD43ED1
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:09:23 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id o7-20020a056820040700b003205d5eae6eso5761681oou.5
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Bu1A3ZE7jL4RW7Q8WDPhpH/9aXzdTeBqRADe9ntKEnM=;
        b=BLE2hpriyJ2j1C4Wu6dUoK//7prTi+u0jRYbhEZh45XIVoJmYA21N7E2oBW+2KnB/7
         PyYVu3Y8RdJr5w9wdHehGTzuXqq87Nlmojg6kIjzBd560CjrpnvXElMH+TJUbHTlWmVy
         6In/EuUKa0xo5I2b351xKFel61uEsav0+XZS5ds7nC5LOeypTZyMQUcREMAbpspnhICU
         SelAcfc1Z5J+O8eHS031EPaSJAL+7bWFwxqZHxz59JhST63bw61J8HsZNvKhQRvzds2g
         fvzRMQAqXRUy8WA2OFTSyFmisryLqLG9kMcEHIU47CcKF0mDNTTV1FOiFp5EIoIcmAl5
         K2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bu1A3ZE7jL4RW7Q8WDPhpH/9aXzdTeBqRADe9ntKEnM=;
        b=y4xqUzezQ+Q4ZQl42ak8IylRKUFAblSEpF9c077CVpP9rRGENmsUEdggMb9sLgjsUl
         Wr2eYBqPClW4JneCbr3VF9klD9g4MGjX85TbrLMhBg89OfBhbp/CmVgX2OYS4c/iUe5B
         Yu3IB7imHpGTCkUurRa7huvImGjkgZMgAAOVoHc0vSQQLQ+iFxSQ2DDFOY3UCu5pygn0
         jqxl6R2vyk7HmGmsZ80bnqd9DsFRLftUVo4iO1x3CsN3xUbE+4G6TVcS3TiuuOA/8TKG
         c7+NlB9uYPKBHWLjYIi70T/eIKwtt5iLj3hgHWAkcIJZ9otRnEHELqBiU7kL5IGGbI5U
         iQMA==
X-Gm-Message-State: AOAM5301L7aDrDg4bAz1ezk6PphFz4a/ZHLyFVm7jc+tKxdPqM6MkcRr
        IBlSj4v0+YxMOHuzR1xB+lLPoa0gEWWX
X-Google-Smtp-Source: ABdhPJz7TCvklYbJjSiDPYU3iV57XhSWZkuvdM5fJYfh7zXYDExHAJ3DcH0UbCQP4AZd9sd6msZ40A==
X-Received: by 2002:a05:6870:32d1:b0:d7:3343:3131 with SMTP id r17-20020a05687032d100b000d733433131mr4592416oac.124.1646323762761;
        Thu, 03 Mar 2022 08:09:22 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f21-20020a4ada55000000b0031c16df28f9sm1099517oou.42.2022.03.03.08.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 08:09:22 -0800 (PST)
Message-ID: <95207e46-defb-f36e-ea3c-a2454c15bd8e@github.com>
Date:   Thu, 3 Mar 2022 11:09:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] builtin/remote.c: show progress when renaming remote
 references
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <Yh/t3HfKiEMx957i@camp.crustytoothpaste.net> <Yh/2Pkc493ABWv46@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yh/2Pkc493ABWv46@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/2/2022 5:57 PM, Taylor Blau wrote:
> On Wed, Mar 02, 2022 at 10:21:16PM +0000, brian m. carlson wrote:
>> For context, I discovered this when I tried to rename a remote with tens
>> of thousands of branches and it just ran silently for an extended period
>> of time without any output.  I actually interrupted it with Ctrl-C
>> because I thought it had hung, so I'm hoping this will provide a better
>> experience for users in that situation.
> 
> Thanks again for pointing it out to me. To be honest, I'm skeptical that
> this patch alone will improve things much, since you still have to pass
> the '-v' flag to see the new progress meter.
> 
> But perhaps users who suspect the command is hung will re-run it with
> the '-v' flag instinctually and get more helpful output. I'll look at
> making `git remote`'s `-v` behave a little more like `--[no-]progress'
> in another series.

I guess one big reason for Ævar's suggestion about using --[no-]progress
as the signal for progress is that we can make --progress the default
when isatty(2) is true. We should not do the same for --verbose.

Looking at other examples, I see that 'fsck' has --verbose imply
--no-progress, probably because the verbose output would write lines
that become interleaved with the progress indicators (and those lines
act as progress in themselves). Not sure if that's the right choice in
this case, too.

Thanks,
-Stolee

