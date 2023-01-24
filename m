Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB45C25B4E
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 16:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjAXQse (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 11:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjAXQsd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 11:48:33 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D94402C2
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 08:48:32 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id rl14so37320922ejb.2
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 08:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=exGCdXHLbuVLdL4PFWBcRqV3mOIwInWGoEE78ok53xc=;
        b=k4K2xbtZ/Q8kvvyBs9AWE7qQQzfP0YXW413VlQxzrWTjPi/v0Ujrji2BkQoVguhu34
         XO75tirn7LNQmeFNq0gKUEAMXa52wO+ipwIoYyc/z7bTh76FlR8xw7Yapi6H7UFHDAOu
         rRQSjJOhTCS+s6snB7o995SRW3IcW5v7u8FCjk0CgKRqzD36NnNFNvJ7BoGI7t2TuIH4
         ZsRVwylq5u2rKraRUTamWR5nx/tg7WgWNByvat5W6CUp1dD1B40V0DbtdVIJUHmqZcas
         GmINX9JC+WCJeU+W193/NLQ/0uPXOtw6HmcEZ89uryvRDQRzb0/vSPoBrAghoSjEspzP
         R92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exGCdXHLbuVLdL4PFWBcRqV3mOIwInWGoEE78ok53xc=;
        b=kP/U6YE2tfmj8gnl9bJLIAPGaZYb4c3q6TiGfV7LP01eChk8uO1j8c8tWcEsebB/l7
         oczIMmU+sBA4zyNmSZ4MYr8idflRBDWYvltEQPOhrTmiJWbO0qf4IiXg+5rPW1dpwbAo
         RkPfXFtEV7e54OZtxQZNBIIeCd5DtuQrfrVq2eaekyUSKcFR/tVeVWbPtUy+PtsFsoxc
         ikuTr6oi3S0JAz8DUxbsiovOZp/lSBsG3ZFrTCaPG2gZYDZQo7nHz7o4qkA4gc65XqKz
         GUp9tnQnPb/jpel6RbJq8s9hBg8Lwbm6ENsj6iknPSANGv2HGw7dmjHyVGmE2wgCvCd2
         JjQw==
X-Gm-Message-State: AFqh2ko3y7MeuwcBvfutz6FJlCxW7IG+/9BK00yX4VJQ1dl3BJJiVcMW
        XNjoG8yyz6kVQYWgyioDuK72ZnZHL14=
X-Google-Smtp-Source: AMrXdXuWCViW0yIGyvjNSOC89z1RkCNSzzTjx3gBGKyBMQgPmpsaOV057CTmoNn0Jl7GyTvd5Hce6w==
X-Received: by 2002:a17:906:60d0:b0:877:612e:516e with SMTP id f16-20020a17090660d000b00877612e516emr78988176ejk.61.1674578900401;
        Tue, 24 Jan 2023 08:48:20 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id m6-20020aa7d346000000b0049c6c7670easm1247820edr.70.2023.01.24.08.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:48:19 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <0418e5b6-8cbd-9dc9-085e-31380beda89b@dunelm.org.uk>
Date:   Tue, 24 Jan 2023 16:48:18 +0000
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
In-Reply-To: <CABPp-BHVUc7EdY9z_TPcHspCak6Yc3mfDXUkivj4zq_fJem3SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 24/01/2023 15:41, Elijah Newren wrote:
> Ah, despite looking over the code multiple times to check my
> statements, I somehow kept missing this:
> 
>      if (keep_base && options.reapply_cherry_picks)
>          options.upstream = options.onto;
> 
> which is how --[no-]reapply-cherry-picks is supported in conjunction
> with --keep-base.  Thanks.
> 
>>>> For all four cases (A)-(D), the apply backend will ignore whatever
>>>> --[no-]reapply-cherry-picks flag is provided.
>>>
>>> For (D) the flag is respected, (C) errors out, the other cases
>>> correspond to the default so it's like saying
>>>
>>>       git rebase --merge --no-reapply-cherry-picks
>>>
>>> ignores the flag.
>>
>> On reflection that is only true for (B). I agree that we should error
>> out on (A) which we don't at the moment.
>>
>> I'd support a change that errors out on (A) and (C) but continues to
>> allow (B) and (D). I think we can do that with the diff below
>>
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 1481c5b6a5..66aef356b8 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -1230,12 +1230,6 @@ int cmd_rebase(int argc, const char **argv, const
>> char *prefix)
>>                    if (options.fork_point < 0)
>>                            options.fork_point = 0;
>>            }
>> -        /*
>> -         * --keep-base defaults to --reapply-cherry-picks to avoid losing
>> -         * commits when using this option.
>> -         */
>> -        if (options.reapply_cherry_picks < 0)
>> -                options.reapply_cherry_picks = keep_base;
>>
>>            if (options.root && options.fork_point > 0)
>>                    die(_("options '%s' and '%s' cannot be used
>> together"), "--root", "--fork-point");
>> @@ -1412,11 +1406,17 @@ int cmd_rebase(int argc, const char **argv,
>> const char *prefix)
>>            if (options.empty != EMPTY_UNSPECIFIED)
>>                    imply_merge(&options, "--empty");
>>
>> -        /*
>> -         * --keep-base implements --reapply-cherry-picks by altering
>> upstream so
>> -         * it works with both backends.
>> -         */
>> -        if (options.reapply_cherry_picks && !keep_base)
>> +        if (options.reapply_cherry_picks < 0)
>> +                /*
>> +                 * --keep-base defaults to --reapply-cherry-picks to
>> +                 * avoid losing commits when using this option.
>> +                 */
> 
> I know you were copying the previous comment, but this comment is
> really confusing to me.  Shouldn't it read "--reapply-cherry-picks
> defaults to --keep-base" instead of vice-versa?

Clearly this comment has not been as helpful as I indented it to be. I 
think maybe we should spell out the defaults with and without 
--keep-base. Perhaps something like

default to --no-reapply-cherry-picks unless --keep-base is given in 
which case default to --reapply-cherry-picks


>> +                options.reapply_cherry_picks = keep_base;
>> +        else if (!keep_base)
>> +                /*
>> +                 * --keep-base implements --reapply-cherry-picks by
> 
> Should this be --[no-]reapply-cherry-picks, to clarify that it handles
> both cases?  Especially given how many times I missed it?

This has obviously proved to be confusing. The aim was to explain that 
in order to work with the apply backend "[--reapply-cherry-picks] 
--keep-base" was doing something unusual with `upstream` to reapply 
cherry picks. "--no-reapply-cherry-picks --keep-base" does not do 
anything unusual with `upstream`. I don't think changing it to 
--[no-]reapply-cherry-picks quite captures that. I came up with

To support --reapply-cherry-picks (which is not supported by the apply 
backend) --keep-base alters upstream to prevent cherry picked commits 
from being dropped.

but it really needs to mention that --keep-base also supports 
--no-reapply-cherry-picks in the usual way

>> +                 * altering upstream so it works with both backends.
>> +                 */
>>                    imply_merge(&options, "--reapply-cherry-picks");
> 
> And perhaps this should be
> 
>      imply_merge(&options, options.reapply_cherry_picks ?
> "--reapply-cherry-picks" :
>           "--no-reapply-cherry-picks");

That's a good idea

> Also, the comment in git-rebase.txt about incompatibilities would become
> 
>       * --[no-]reapply-cherry-picks, when --keep-base is not provided

Yes, that's good

Thanks again for working on this

Phillip
