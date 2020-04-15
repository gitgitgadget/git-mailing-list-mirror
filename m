Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A33C2BB85
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 10:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E1620768
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 10:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3pZ6gkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896091AbgDOKBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895955AbgDOKBS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 06:01:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6FAC061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 03:01:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a25so18394640wrd.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dLHc3Skb02qdNRSHtskQlT2qkVvyVEu1rm/3Auu+eWM=;
        b=G3pZ6gkBWG0Vw3KKRnBx3GQgLoVJwChkdtpth0IfTbw8qGiOnrVaWXxVsyGnLr/NfZ
         0nEAxT+UtUpEFlKPzaQLdF4NYMnB3qs8rT0c5quNVuUro4sJdeDXLWd7EnO9yh/F+1EV
         ExqGi2Di12Ri0SYCXhllf4WTzouyTrSgXpzc8QQuMM2y5mDe/q9/c8b2zuVrOovwCSgx
         Pa86rPTuJzCaNp/MiWEsxKsCYCcEGm4vLMMzhTAzV7NfNXeCqrey8gvydViM+7og6C0Q
         iDD00gMn2gQa7LKRH5lvywtLkmjtmr5cWEzUj/B2YcFgFLlb26orrDl+7UqYG4a1hXEO
         9+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dLHc3Skb02qdNRSHtskQlT2qkVvyVEu1rm/3Auu+eWM=;
        b=DJIDoJPi4iJ7+wQID7WlbE+RYpqlOW8lIaVv+NAmOwmMpssIkmBVok8rtAZOtVfJOm
         63CRwZjKZ909b6lRZjg2igaoDL8dpqvIVkwVvXBVWj1a2Bosof/u1M6iFFVXmRoUNP45
         qlU0nYYn3y9jetDwljXJzD6ucoYttmMy/Q9piM1pY9cbbnipizYCUg2zuOTLRs7cQm7T
         tKRYyC0keL1x/Do9izAVso+32yi2HSF2uzxmIMPBltAAPYFxanVamXgbP4aQE5R14NYx
         8Lwf71QFd/sW5UaIkh02iDmrbR69je6UI1NiVHesKr3VFTrK/JboNUs5J4IS519N6YP8
         gOkg==
X-Gm-Message-State: AGi0Pua+6CUF6aRUKpyQgnB+RsSP1LvXvUcZVvks1PVhkbkSoJ7nGemk
        Z1hVObChaw8pZ9ewTrWc6ZE=
X-Google-Smtp-Source: APiQypLfuZB22yipGBylrvtnKsUnpme/Urombt1bisFfHHfz2tPr+o7Q5FujdUWiwA2YrmdpcVHJAA==
X-Received: by 2002:adf:9e49:: with SMTP id v9mr28251809wre.34.1586944876878;
        Wed, 15 Apr 2020 03:01:16 -0700 (PDT)
Received: from [192.168.1.201] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.googlemail.com with ESMTPSA id m14sm20693474wrs.76.2020.04.15.03.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 03:01:16 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/2] configuration-based hook management
To:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20200414005457.3505-1-emilyshaffer@google.com>
 <efad3927-1d8f-5545-48e9-9a58c2308273@gmail.com>
 <20200414203247.GE1879688@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0f661f31-ee75-15fb-0272-48d459176f29@gmail.com>
Date:   Wed, 15 Apr 2020 11:01:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414203247.GE1879688@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/04/2020 21:32, Jeff King wrote:
> On Tue, Apr 14, 2020 at 04:15:11PM +0100, Phillip Wood wrote:
> 
>> On 14/04/2020 01:54, Emily Shaffer wrote:
>>> Not much to look at compared to the original RFC I sent some months ago.
>>> This implements Peff's suggestion of using the "hookcmd" section as a
>>> layer of indirection.
>>
>> I'm not really clear what the advantage of this indirection is. It seems
>> unlikely to me that different hooks will share exactly the same command line
>> or other options. In the 'git secrets' example earlier in this thread each
>> hook needs to use a different command line. In general a command cannot tell
>> which hook it is being invoked as without a flag of some kind. (In some
>> cases it can use the number of arguments if that is different for each hook
>> that it handles but that is not true in general)
>>
>> Without the redirection one could have
>>   hook.pre-commit.linter.command = my-command
>>   hook.pre-commit.check-whitespace.command = 'git diff --check --cached'
>>
>> and other keys can be added for ordering etc. e.g.
>>   hook.pre-commit.linter.before = check-whitespace
>>
>> With the indirection one needs to set
>>   hook.pre-commit.command = linter
>>   hook.pre-commit.check-whitespace = 'git diff --check --cached'
>>   hookcmd.linter.command = my-command
>>   hookcmd.linter.pre-commit-before = check-whitespace
> 
> In the proposal I gave, you could do:
> 
>   hook.pre-commit.command = my-command
>   hook.pre-commit.command = git diff --check --cached
> 
> If you want to refer to commands in ordering options (like your
> "before"), then you'd have to refer to their names. For "my-command"
> that's not too bad. For the longer one, it's a bit awkward. You _could_
> do:
> 
>   hookcmd.my-command.before = git diff --check --cached
> 
> which is the same number of lines as yours. But I'd probably give it a
> name, like:
> 
>   hookcmd.check-whitespace.command = git diff --check --cached
>   hookcmd.my-command.before = check-whitespace
> 
> That's one more line than yours, but I think it separates the concerns
> more clearly. And it extends naturally to more options specific to
> check-whitespace.

I agree that using a name rather than the command line makes things
clearer here

Best Wishes

Phillip

> -Peff
> 

