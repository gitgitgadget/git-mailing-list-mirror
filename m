Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3661DC54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 10:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjAPKrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 05:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjAPKrS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 05:47:18 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85F017CE5
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 02:47:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so3737520wml.0
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 02:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+6PWITd/6XdQX3C5jxJWZGrrVZgBYYIlP09MQ/kYLN8=;
        b=Gx0fy/BcGbCvwD1iN5ZQqZ95HzcWM6Vwj+4JxfxDfG97KuLsNKUN30itpJ8PVGeh+v
         55y0r8qrF99Ap8y93AWg5mVPBVXWSiGj3O3vaOGOyOEQvabp1gPFLu0kDppBRjthEkEH
         uhnKxamkVKk6RTVJTXqs/cKHIERxKjEYOBPT4KxIXxFtwu/eSTXn51mrACXLjLPdA5dX
         jje1ibrfvs3aQBRVqz1kKzNdoMoYx7XHt9TsfkksmsHV44FPdO+UKr/Uiwc73yHZmxry
         ZqgiazHdA/rOWXCSj6FaaLbkKkQDWzFA8QfzyNzgyrt52YUVJb+V2+l7MnE0UOOsTf8Z
         6NiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6PWITd/6XdQX3C5jxJWZGrrVZgBYYIlP09MQ/kYLN8=;
        b=LyuPKqpnSIWmSGxR9jAO3mQ9GHkHVR4El6IXt/LUtgSQzK3Vu3qTMsb7avNoMUgDBi
         9DJPRqjaMP7QRwEC6qIj/TgCs4PWGgPA+K3ZYTtWM7QZhhgXOdJsWguFD6BN7t91udE/
         bYd7k2VBPdCIjjPH2WNJggruIq7vXyGPpZkQ0V7HEgApV+8svehvcG/lu7Xi3+plpJPK
         B8j5q3MZ9zV2OTJBUUj2ri8wp+5w4CS9pWTl1DoAassoBVGBFfnNaAhYRza5/Ngr/7wc
         uNmk9Qx688S7yMl2L7O3vyVwt9fMD9qOj1f3BFrx/byqL9LfXP7C6P2LF/P97m7VPp2D
         KDaA==
X-Gm-Message-State: AFqh2krZb4bgS/zScoq3bXKMNNQEfwahwpzH1L22eKRoyrjE5qulASyY
        cKDidJfOXqfwLhvOCaN3p8PPenqWz7E=
X-Google-Smtp-Source: AMrXdXvMdZlXpX4tXd/gnHxezUAQxCXTPl7Qiyb64fLX/H86US2qwFdxU2uDK7xNCYLWtG2lRS+7qQ==
X-Received: by 2002:a7b:cb50:0:b0:3d1:f882:43eb with SMTP id v16-20020a7bcb50000000b003d1f88243ebmr66110535wmj.10.1673866035137;
        Mon, 16 Jan 2023 02:47:15 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id fc14-20020a05600c524e00b003a3442f1229sm43189846wmb.29.2023.01.16.02.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 02:47:14 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <70a01a52-f16c-e85f-297e-c42a23f95a9a@dunelm.org.uk>
Date:   Mon, 16 Jan 2023 10:47:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 3/4] worktree add: add --orphan flag
Content-Language: en-US
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221212014003.20290-1-jacobabel@nullpo.dev>
 <20221220023637.29042-1-jacobabel@nullpo.dev>
 <20221228061539.13740-1-jacobabel@nullpo.dev>
 <20230107045757.30037-1-jacobabel@nullpo.dev>
 <20230109173227.29264-1-jacobabel@nullpo.dev>
 <20230109173227.29264-4-jacobabel@nullpo.dev>
 <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk>
 <20230114224715.ewec6sz5h3q3iijs@phi>
In-Reply-To: <20230114224715.ewec6sz5h3q3iijs@phi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob

On 14/01/2023 22:47, Jacob Abel wrote:
> On 23/01/13 10:20AM, Phillip Wood wrote:
>> Hi Jacob
>>
>> On 09/01/2023 17:33, Jacob Abel wrote:
>>> [...]
>>
>> It's perhaps a bit late to bring this up but I've only just realized
>> that it is unfortunate that --orphan takes a branch name rather than
>> working in conjunction with -b/-B. It means that in the common case
>> where the branch name is the same as the worktree the user has to repeat
>> it on the command line as shown above. It also means there is no way to
>> force an orphan branch (that's admittedly quite niche). If instead
>> --orphan did not take an argument we could have
>>
>> 	git worktree add --orphan main
>> 	git worktree add --orphan -b topic main
>> 	git worktree add --orphan -B topic main
>>
>> Best Wishes
>>
>> Phillip
>>
>>> [...]
> 
> I think this is a good idea and something similar was brought up previously
> however I originally wanted to handle this and a common --orphan DWYM in a later
> patch.

I think adding it in a later patch makes the implementation more 
complicated than it needs to be as you'll still have to support --orphan 
taking a name for backwards compatibility that means you need to handle

	git worktree add --orphan=main main
	git worktree add --orphan topic main
	git worktree add --orphan --lock main
	git worktree add --orphan -b topic main
	git worktree add --orphan -B topic main

Rather than just the last three. Now you can probably get that to work 
by changing --orphan to take an optional argument but I think it would 
be simpler to have --orphan as a flag from the start.

>> 	git worktree add --orphan main
> 
> I am OK implementing this option and have been workshopping it prior to
> responding. I think I have it worked out now as an additional patch which can be
> be applied on top of the v8 patchset.
> 
> I'll reply to this message with the one-off patch to get feedback. Since this is
> essentially a discrete change on top of v8, I can either keep it as a separate
> patch or reroll depending on how much needs to be changed (and what would be
> easier for everyone).
> 
>> 	git worktree add --orphan -b topic main
>> 	git worktree add --orphan -B topic main
> 
> I am hesitant to add these as they break away from the syntax used in
> `git switch` and `git checkout`.

When I wrote my original email I wrongly though that --orphan did not 
take an argument for "git checkout". While I think it is a mistake for 
checkout and switch to have --orphan take an argument they do at least 
always need a branch name with that option. "git worktree" add already 
has the branch name in the form of the worktree directory in the common 
case.

> Also apologies for the tangent but while researching this path, I noticed that
> --orphan behaves unexpectedly on both `git switch` and `git checkout` when mixed
> with `-c` and `-b` respectively.
> 
>      % git switch --orphan -c foobar
>      fatal: invalid reference: foobar
> 
>      % git switch -c --orphan foobar
>      fatal: invalid reference: foobar
> >      % git checkout -b --orphan foobar
>      fatal: 'foobar' is not a commit and a branch '--orphan' cannot be created from it
>
>      % git checkout --orphan -b foobar
>      fatal: 'foobar' is not a commit and a branch '-b' cannot be created from it

The messages for checkout look better than the switch ones to me as they 
show the branch name which makes it clearer that we're treating what 
looks like an option as an argument. What in particular is unexpected 
here - --orphan and -b take an argument so they'll hoover up the next 
thing on the commandline whatever it is.

Best Wishes

Phillip

> I tried this on my system install as well as from a fresh fetch of next FWIW.
> 
> [Info: fresh build from next]
> git version 2.39.0.287.g8cbeef4abd
> cpu: x86_64
> built from commit: 8cbeef4abda4907dd68ea144d9dcb85f0b49c3e6
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> 
> [Info: system install]
> git version 2.38.2
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> 
> If this bug is something that needs to be addressed, I can dig a bit deeper and
> put together a patch for it in the next few days.
> 
> VR,
> Abel
> 
