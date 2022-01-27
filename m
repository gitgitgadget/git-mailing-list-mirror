Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB685C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 14:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242654AbiA0Oq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 09:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242660AbiA0Oq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 09:46:58 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CF9C06173B
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 06:46:58 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id n6-20020a9d6f06000000b005a0750019a7so2757588otq.5
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 06:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LqirZvloGvvYI/EVhPOMBOj4qEF51gZVqB0+/Fvx6ZA=;
        b=VsUih3Lm2KoILf9OjJtd/61gW4Oplkb03u0o0qwNgETVqTu0XsDnz5YQZZvZfNbiX7
         veupMFEcnZY88AzwfBWdhX2qLuZrlgt6mDugU6uZcGtc/KfcDe39FSRxY1pENVu9R2ut
         XJnUoNtNtoWedzOVLvDDZ03teOSzoXlGPdAKqCDiX74fVLoI5Ebl4HbDM7wjIopI7mxV
         JQ0a4Qcga1V72UDrbgnhAsaY2NodWRaWnTH9wyzqPNMhlaVpez/wpPwsPcd+9GKcD/VF
         8RnlBKqpkamlhq+lTfuaVdoXWtLXs5eq8WBp+vLFnldid6mKlnTFxG2/MTRl9s11a/KK
         +ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LqirZvloGvvYI/EVhPOMBOj4qEF51gZVqB0+/Fvx6ZA=;
        b=gPvAQpx+nB2GAbOwjKrcPH1vo4nLuNxYxAWIzH/eTU67dCnEsWT+xnXL+8ImzBR9cP
         HvkFoGEVChr7hdoHxSpq8X7Sszn7sKbRkeDg3qib8l3qUZoUJejdh1woPOSReIMtLD2N
         8B9cqAFB1cEtP1X3L/tefyImDoxcthZE/PYT3aIMYc4OUOguZTdueYCZ8/4RPLbVsT2N
         aNDnWCyEOANh88KLuwHTGgsiD0OxeVkn+rtrydfyFgJZN/V+fEL2CkPfVUGboSyiL4PP
         NLuB+VjhyKw+m8uG5/2PW2XecRcspTUOEhdqxJ4+dT1KDRcdpvpv41YkLTvFS8IRggUh
         KffQ==
X-Gm-Message-State: AOAM53268tgPOjvdDRVbGRuRTVo0ZEz1reTQHTI/xkZ9IgLzDEslM/ow
        vFPjfBrWhukeFdNe8tIOFLM=
X-Google-Smtp-Source: ABdhPJxATNywa649NnB41aSBXPoMbqv8b6p8KsHaqIvkbJy6vWG4J2HPIH32csAJbyK3zZomEZHJ1A==
X-Received: by 2002:a05:6830:183:: with SMTP id q3mr2298834ota.162.1643294817427;
        Thu, 27 Jan 2022 06:46:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d9cb:250e:9ea6:f8? ([2600:1700:e72:80a0:d9cb:250e:9ea6:f8])
        by smtp.gmail.com with ESMTPSA id l14sm8543648ooq.12.2022.01.27.06.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 06:46:56 -0800 (PST)
Message-ID: <0f8d5d04-e86c-48e2-fea0-32c25c3f9325@gmail.com>
Date:   Thu, 27 Jan 2022 09:46:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] scalar: accept -C and -c options before the subcommand
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
 <220127.86v8y5dgus.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <220127.86v8y5dgus.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/26/2022 9:55 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jan 26 2022, Johannes Schindelin via GitGitGadget wrote:
> 
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> The `git` executable has these two very useful options:
>>
>> -C <directory>:
>> 	switch to the specified directory before performing any actions
>>
>> -c <key>=<value>:
>> 	temporarily configure this setting for the duration of the
>> 	specified scalar subcommand
>>
>> With this commit, we teach the `scalar` executable the same trick.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>     scalar: accept -C and -c options
>>     
>>     This makes the scalar command a bit more handy by offering the same -c
>>     <key>=<value> and -C <directory> options as the git command.
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1130%2Fdscho%2Fscalar-c-and-C-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1130/dscho/scalar-c-and-C-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1130
> 
> I think it would help for context to note that this patch had at least 6
> submissions on the ML already as part of early versions of the scalar
> series.
> 
> Here's the CL of the iteration that ejected it:
> https://lore.kernel.org/git/pull.1005.v7.git.1637158762.gitgitgadget@gmail.com/
> 
> Where you summarized:
>     
>      * The patch that adds support for -c <key>=<value> and -C <directory> was
>        moved to its own add-on patch series: While it is obvious that those
>        options are valuable to have, an open question is whether there are other
>        "pre-command" options in git that would be useful, too, and I would like
>        to postpone that discussion to that date.
> 
> Having been involved in those discussions I can't remember what the
> pre-command options you're referring to there are, but it seems "that
> date" is probably upon us.

My understanding was that this was ejected so we could find the right time
to lib-ify handle_options() (as Taylor suggested), but we didn't want to do
that while Scalar was still in a tentative state (in contrib/ with a plan
to move it out after more is implemented).

The biggest benefits of using handle_options() is for other pre-command
options such as --exec-path, which I use on a regular basis when testing
new functionality.

There are other options in handle_options() that might not be appropriate,
or might be incorrect if we just make handle_options() non-static. For
example, `scalar --list-cmds=parseopt` wouldn't show the scalar commands
and would instead show the git commands.

So my feeling is that we should continue to delay this functionality until
Scalar is more stable, perhaps even until after it moves out of contrib/.
The need to change handle_options() to work with a new top-level command
is novel enough to be worth careful scrutiny, but that effort is only
valuable if the Git community is more committed to having Scalar in the
tree for the long term.

Thanks,
-Stolee
