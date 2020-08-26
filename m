Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BECC433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 10:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B829206EB
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 10:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcBX24Ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgHZKyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgHZKyp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 06:54:45 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317F1C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 03:54:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p37so854754pgl.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 03:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3yqGcLCqz1F2QDRMSggJHB7D+jpRgpLpYO2S63kxsig=;
        b=kcBX24Ad+l+6u1pCmhQBhfIu/cCC3uKzWav9qF5WVnwfEJ9l5aMUngmSQ4KMtGhTQd
         YPEEobf4L2yMLQMTw1dKi9AlKsqNs1+cBZA52o+KK2wSZxlsQ5YgngOiZVeXNuKmU/+R
         E0axjIcVD3oU9uoFzzLgDlbOTHMtAXLYEUXci9zLRsfUPiURorYsiHRE/+8ykS8JI5i7
         vR9Y3w8sCHWjWKvvvK8XbrhIh9IHduy/m5D5nrR3nsX7O1zE4eOZmVhuywgsK7Igz6j9
         jCnuvJ3NU9zl37BkF3S65Rg18hSdwtkFONrwXjo/bUQAgW2tJN5ySzj6OO30NWl0DMXZ
         3wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3yqGcLCqz1F2QDRMSggJHB7D+jpRgpLpYO2S63kxsig=;
        b=Z6h9hHZhFLCFVu9BE3AUnJUI+uwhlaqikbmW0bqUe7itoyuHwwxG+kde1XekGRTRof
         /kLoaUe3GqRv1rHQ6pqX6ohyA2R+P0OS3sg7d0kLsar3aCIKs+DBhJiiXhLW5pSClqJq
         2O8pE6y+wzPEcZx1Y3Bk8zRfOjsk7AjPm7j2MIatlKoxGxG0vMzJ5GQGGFHV5LK/Hiyz
         abfAlRIje1f6Mc9tsPwD86LiY3pYv9M20K9wU+v9uUEdcR5Nrzbob78nj2Y7F0A+fvgX
         pI01lDoSxigYGNe49I1uvrkCshbRqlwKZLHUyjsVGr/JOqC6PBA1DCHMPpv7HgwBV2cG
         tSmg==
X-Gm-Message-State: AOAM531X29TE542J63ea/rmkeALs4apR2Y1+gw4khBWhL2W18ebr3FDy
        Mogw7RP4H1ggWCRuDlN6TX21rFnXxOI=
X-Google-Smtp-Source: ABdhPJx9ULBA/Y7/ktjzPWMFLXZBiA1/c7ZAiNghZg/LLOBx3om2He1R7BvPT9sEWJrXPohDIcZ6jQ==
X-Received: by 2002:a62:2e81:: with SMTP id u123mr6085277pfu.304.1598439284708;
        Wed, 26 Aug 2020 03:54:44 -0700 (PDT)
Received: from [192.168.208.37] ([183.83.153.247])
        by smtp.gmail.com with ESMTPSA id p14sm300221pff.148.2020.08.26.03.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 03:54:44 -0700 (PDT)
Subject: Re: [GSoC][PATCH] submodule: port submodule subcommand 'add' from
 shell to C
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        christian.couder@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
References: <20200824090359.403944-1-shouryashukla.oo@gmail.com>
 <xmqq8se36gev.fsf@gitster.c.googlers.com>
 <43337924c09119d43c74fdad3f00d4dab76edb51.camel@gmail.com>
 <CAP6+3T2FbjKc35QYiDmaezzKbkrxEOcBqzirm032_tTU2foZ=Q@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <5899bf6e-f61f-8a19-196d-d38d611dc037@gmail.com>
Date:   Wed, 26 Aug 2020 16:24:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAP6+3T2FbjKc35QYiDmaezzKbkrxEOcBqzirm032_tTU2foZ=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26-08-2020 14:57, Shourya Shukla wrote:
> On 8/25/20, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:
>>
>> This part results in a difference in error message in shell and C
>> versions.
>>
>> -- 8< --
>> $ # Shell version
>> $ git submodule add ../subm1 sub
>> A git directory for 'sub' is found locally with remote(s):
>>   origin        /me/subm1
>> If you want to reuse this local git directory instead of cloning again from
>>   /me/subm1
>> use the '--force' option. If the local git directory is not the correct
>> repo
>> or you are unsure what this means choose another name with the '--name'
>> option.
>> $
>> $ # C version
>> $ git submodule add ../subm1 sub
>> A git directory for 'sub' is found locally with remote(s):
>>   origin        /me/subm1
>> error: If you want to reuse this local git directory instead of cloning
>> again from
>>    /me/subm1
>> use the '--force' option. If the local git directory is not the correct
>> repo
>> or you are unsure what this means choose another name with the '--name'
>> option.
>> -- >8 --
>>
>> Note how the third line is oddly prefixed by a `error` unlike the rest
>> of the lines. It would be nice if we could weed out that inconsistency.
>> We could probably use `advise()` for printing the last four lines and
>> `error()` for the lines above them.
> 
> Understood. I will correct this part. BTW, you surely are talking
> about error() on
> the first 2 lines? I think fprintf(stderr, _()) is OK for them otherwise they
> will be prefixed by 'error:' which will not be in line with the shell version.
> 

Yes. It's better to prefix them with `error` because well... it is an
error. I realize the shell version didn't explicitly do this but that
doesn't necessarily mean the error message was helpful without the
prefix. AFAIK, many Git commands prefix their error messages with
`fatal` or `error` which makes it easy to distinguish error messages
from actual program output in the terminal. So, it's good to do the same
here.

-- 
Sivaraam
