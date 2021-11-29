Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC0BC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhK2Wuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbhK2Wtu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:49:50 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4839BC111CF4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:43:20 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id bj13so36080919oib.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ymBB5iRdoxWCNCWESjE9Xzqq3wDI/vcCVpXZg/7ahO0=;
        b=mPaYutHR/RJWa6DglMH7mPhCZeFyKTHrkHT3QLtmXmmRMO2qVoWHHK+wsAhvIvpach
         jb30qTu9TTkS7CrYdH5LEMLUidTG4ljba7YEdEpyRh7bzdKYFxVXA4NN4qHpgLzul17r
         pFJ4s30dpasMFumRfTaedyHar9PftlUkhR1zYsEF9V9LqZSPZVR+P2qE9/xen/ZAeeHD
         FzGRjZozwU9L0BK8t7gfsoi1WWzJK+kCVdWYKYQ76WSATJ8L+HvawUB3WMad63wjEAEu
         6L43eyxx4LWLG0vISSAFoxMVyRWnu4cSlHJfKXmpZH8eFPTmnBteDit2vrAHRo44RQub
         rBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ymBB5iRdoxWCNCWESjE9Xzqq3wDI/vcCVpXZg/7ahO0=;
        b=YpO0GalnS883OVzsCI0Mtvf3GTEimgXZbLpKwIaGtgK30JGRZuVNQVMIGVSZ/sgMfP
         /Nk4ZwwG1iHJuxYLuqMnrmP1fQF26d5LL4uMc/gMkuoDn/R4ELEb7f18Ulgt/wXZtb9m
         7Ylb0CdZzZ0kE14XXQTPaGWEU8e5N1915sS94zqC6GX1V4oYItN9MbtPdSU0j3pBcEC8
         WRZmVwZTlTEqmXOTI7msySjAKFfncGOBy7ivjoGO3alLI4s4MYFQXNeJSEjMoNwY0vrR
         go/O5Gs093pESC3tdraI5cIpqqlZlPNOHSJdl7viRN3n0UDZEJ2+rRkCGDwpNTwmVVbg
         PZOg==
X-Gm-Message-State: AOAM531ejyMZxn0lVa+bLWoJE+AcRgYAt2z0xtFdTgpwPXA0f1GtIY+y
        gDsRZ9ZaR+Pnm6kIQeCNclU=
X-Google-Smtp-Source: ABdhPJxZ+tYcd3gwBb5F/eNnyHrhOuJVQOw1MO3W6HjYhPnUFVBs6f9/0pY2rE0ZE6kK0dPczweF7w==
X-Received: by 2002:a05:6808:20e:: with SMTP id l14mr42006630oie.119.1638207799625;
        Mon, 29 Nov 2021 09:43:19 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3085:654c:eb81:848b? ([2600:1700:e72:80a0:3085:654c:eb81:848b])
        by smtp.gmail.com with ESMTPSA id n26sm2353954ooq.36.2021.11.29.09.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 09:43:19 -0800 (PST)
Message-ID: <068b7faf-2ade-14a7-fee3-83fec26ae856@gmail.com>
Date:   Mon, 29 Nov 2021 12:43:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/9] setup: introduce startup_info->original_cwd
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <f6129a8ac9c3d052fb7fb508a62d4eedb8d9ed57.1637829556.git.gitgitgadget@gmail.com>
 <48fced3c-1fcb-d5cd-cec0-b9e58be40259@gmail.com>
 <CABPp-BHStJ2x53cffJPb7miaxL2cKr0usgK13HxNDyYMQv11_g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHStJ2x53cffJPb7miaxL2cKr0usgK13HxNDyYMQv11_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/29/2021 12:18 PM, Elijah Newren wrote:
> On Mon, Nov 29, 2021 at 6:05 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 11/25/2021 3:39 AM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>
>>> @@ -866,6 +866,8 @@ int cmd_main(int argc, const char **argv)
>>>
>>>       trace_command_performance(argv);
>>>
>>> +     startup_info->original_cwd = xgetcwd();
>>> +
>>
>> I see this initial assignment in cmd_main()...
> 
> It looks like you accidentally responded to v2 when there's a v3
> (something I occasionally do too).  v3 changes this to put it in
> common-main instead of here, as suggested by Ævar, but to answer the
> question...

Yes, sorry about that. My inbox was delayed in showing me that a v3
existed until I was halfway through reviewing v2. (It then only
showed me half of the patches from v3, so something was causing
a delay.)

>>> +static void setup_original_cwd(void)
>>> +{
>>> +     struct strbuf tmp = STRBUF_INIT;
>>> +     const char *worktree = NULL;
>>> +     int offset = -1;
>>> +
>>> +     /*
>>> +      * startup_info->original_cwd wass set early on in cmd_main(), unless
>>> +      * we're an auxiliary tool like git-remote-http or test-tool.
>>> +      */
>>> +     if (!startup_info->original_cwd)
>>> +             return;
>>
>> ...which is assumed to be run before this method was called...
>>
>>> @@ -1330,6 +1378,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>>>               setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
>>>       }
>>>
>>> +     setup_original_cwd();
>>
>> ...here in setup_git_directory_gently().
>>
>> Why do we need that assignment in cmd_main()? Could we instead
>> let setup_original_cwd() do the initial assignment? Or is it
>> possible that a chdir has happened already before this point?
> 
> In v1, I made that mistake.  Then I realized that when users pass the
> -C option to git, there is a chdir() call immediately upon parsing of
> the -C option.  So I had to move the strbuf_getcwd() call earlier.

Ok. I wonder if we could setup_original_cwd() earlier than that
parsing, but I'm sure you've already explored that option.

Thanks,
-Stolee
