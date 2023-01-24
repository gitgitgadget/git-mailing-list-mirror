Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F504C25B50
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 19:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjAXTVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 14:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjAXTVW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 14:21:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F223A30EBE
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 11:21:20 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g11so13928703eda.12
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 11:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RtpZR+/YXt+r+cZMTOFH48Du31+skrZIYLprvLefyno=;
        b=BiX+5Yp5yVmeQuEqh6X0lutT/2c72mylBl/62s29tIs9vNDx/DgtOpj3erdTAyR0KQ
         Je5r4gX+pYLsf738JuyBa3JwbJuX0/9u/RWCIOkZI67IVm6iPrz4IAivzrzJ3hGnG3a5
         moUYhOXQLzkyynKg5zvwpyG1PFayi3e7gnDRC8+tFQd2ovsCqj0QfriKKqAGo/N4Zduo
         Gm0WYd0IYUQloNzGX9Izdn4D7TPgj3699c7OHFQxj0GtvPBGQX7qRMcQr/+LT6im0Z+8
         AGK+xWQeGrXfrlO3gh67JdOVrdAL991rqy+pPd1mzCy6tqd0n+KVZ/PVOGrFWB7fHQYF
         J09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtpZR+/YXt+r+cZMTOFH48Du31+skrZIYLprvLefyno=;
        b=Z1dVqMHYbr5lmuguVXZzF/Llnb5lbqukIT5dpoGRoukqdwDT4ZP5XQ/YV4xPKgzGSl
         gNWotREGFjXW9j209GwQF2j/0o7oqNl7fNSWKg8RUp43XtayLTwjZiwImxV05sobmik8
         8NxHovorMLBt7jqRwmi47uxYc+7TBgpcIeJrKBl8Ila4qnxVWzPbrXlXaJFug1mwHgVg
         PY0EBpx59plsr0cjdMPwphRCusW0gSa7PZaYZ5AEVbXjrlzR3jY8ntUtKHpILzKMN7qs
         mcQsgB3Xe41pLrDjGbVrA9B30tGCH8o2rkU7sVw4jEenq4nF0VpvtLI/CnJBYbLjD/Sp
         F0Rw==
X-Gm-Message-State: AFqh2kriPNY9iGXCs3EYT9JsIwDfRU2oPbfZGlK9Hw8jl2owRIBMQXKg
        ntQ5z9wQgqmTiNlKodBW3JM=
X-Google-Smtp-Source: AMrXdXucaS0EFkA8FYGSBDXyJ/zK/tn5cJto2j4TiPEHpbuKwkIAe4Kfokw/DrU6IzCyhZWoHlf2Gw==
X-Received: by 2002:a05:6402:1484:b0:49e:9d82:49d6 with SMTP id e4-20020a056402148400b0049e9d8249d6mr18613014edv.10.1674588079386;
        Tue, 24 Jan 2023 11:21:19 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id m6-20020aa7d346000000b0049c6c7670easm1400608edr.70.2023.01.24.11.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 11:21:19 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <83c489c6-7927-ee3a-03bb-7896a928c280@dunelm.org.uk>
Date:   Tue, 24 Jan 2023 19:21:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 5/9] rebase: add coverage of other incompatible options
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
 <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
 <5e4851e611ee18112bd71939ee900e02a8d590c5.1674367961.git.gitgitgadget@gmail.com>
 <759fb313-ce88-4eb7-96c0-4adeb75ca9f9@dunelm.org.uk>
 <CABPp-BE+wRgjmWknARQpNsdUFjNOz0ND9wgx_-_RTyK+EwJjXA@mail.gmail.com>
 <83d27162-59d4-d8c0-fde3-f522630d024d@dunelm.org.uk>
 <7b9ee972-2680-2e1b-bef3-201d8a1e4bdd@dunelm.org.uk>
 <CABPp-BHVUc7EdY9z_TPcHspCak6Yc3mfDXUkivj4zq_fJem3SQ@mail.gmail.com>
 <0418e5b6-8cbd-9dc9-085e-31380beda89b@dunelm.org.uk>
 <CABPp-BEwv+cRMOR_-kz_UhfQt1+SGRdhictLmwmq=122LYZaDw@mail.gmail.com>
In-Reply-To: <CABPp-BEwv+cRMOR_-kz_UhfQt1+SGRdhictLmwmq=122LYZaDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/01/2023 17:12, Elijah Newren wrote:
> On Tue, Jan 24, 2023 at 8:48 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>> +                options.reapply_cherry_picks = keep_base;
>>>> +        else if (!keep_base)
>>>> +                /*
>>>> +                 * --keep-base implements --reapply-cherry-picks by
>>>
>>> Should this be --[no-]reapply-cherry-picks, to clarify that it handles
>>> both cases?  Especially given how many times I missed it?
>>
>> This has obviously proved to be confusing. The aim was to explain that
>> in order to work with the apply backend "[--reapply-cherry-picks]
>> --keep-base" was doing something unusual with `upstream` to reapply
>> cherry picks. "--no-reapply-cherry-picks --keep-base" does not do
>> anything unusual with `upstream`. I don't think changing it to
>> --[no-]reapply-cherry-picks quite captures that. I came up with
>>
>> To support --reapply-cherry-picks (which is not supported by the apply
>> backend) --keep-base alters upstream to prevent cherry picked commits
>> from being dropped.
>>
>> but it really needs to mention that --keep-base also supports
>> --no-reapply-cherry-picks in the usual way
> 
> Somewhat wordy, but perhaps:
> 
>      /*
>       * The apply backend always searches for and drops cherry
>       * picks.  This is often not wanted with --keep-base, so
>       * --keep-base allows --reapply-cherry-picks to be
>       * simulated by altering the upstream such that
>       * cherry-picks cannot be detected and thus all commits are
>       * reapplied.  Thus, --[no-]reapply-cherry-picks is
>       * supported when --keep-base is specified, but not when
>       * --keep-base is left out.
>       */

That sounds good to me, it is definitely an improvement on the current 
comment which I think is too terse.

Best Wishes

Phillip
