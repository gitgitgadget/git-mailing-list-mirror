Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA59C433DF
	for <git@archiver.kernel.org>; Sat, 23 May 2020 15:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3081207F7
	for <git@archiver.kernel.org>; Sat, 23 May 2020 15:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHXhGZwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgEWPno (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 11:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgEWPno (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 May 2020 11:43:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F30C061A0E
        for <git@vger.kernel.org>; Sat, 23 May 2020 08:43:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u12so8090887wmd.3
        for <git@vger.kernel.org>; Sat, 23 May 2020 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ORHxf3cxCA3zjZzyJImpo4pH0Ubtms0HsT+q5yuOvWc=;
        b=iHXhGZwFx9AkYLRFYaVK388bIpv+809ZIOsiIOUliYhz7eKxrkFvaKo+icUQYHCvg4
         AVO8ttOrrVuMOq+sBxgrJQted+F8kC7pfp9aP8/y/hn/qbvEI87TRTfJA0cGVGmQfh7N
         5+KDtb28Ps6GYzLpCA/Hw/IUNEi4IIuIy74oNPwnOhX+JWmL1f/KdyHoLbWwY7coUv8T
         Y2xeuDdJj9suDO5Iq/BCl/fF/dcRwQz/VWlPgZvmbrkGILL7j9SkR3xRteG6f84wKHOr
         CazQvYnli28jSPebkRFOFM5i2pxpgaIKdPnVrC9xk6AIEwYu4fNS7FrqT3S+8cJB0ttI
         lPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ORHxf3cxCA3zjZzyJImpo4pH0Ubtms0HsT+q5yuOvWc=;
        b=DYjqRhfymBycDbvUzzqMvP+F4eYzqhH9TMXSiBbVKKsRAYJR8JPhOCVnBRDS2du5LC
         TM8I9rKSe8gQxsKJwn9c4ZOwRI5gGnz6G5K/RHZJWfc43ab32zcfJBxjokI4UUcgEA9H
         A3flS3sp54Uas9B8qSrhJpwVpawRwfydfs0KgobwLifJF9xhMfV1arJaI4JSrFy6xbxM
         9we5FsnHFh+17OKor3gI+qrlzTqGsMjKmXY/K8MPLhJbGPGuRs6vmGRDFoiJFWgX6tAM
         9fE7NZqICL8bmLprWlHbszmx3osFG+bb75MAOQ0rwFvCM/BqA78isLvKU1OKZ6p1Gwgf
         dteA==
X-Gm-Message-State: AOAM532gzoqLFRZLRYc3I3H74OGu1F9zMsQzTmTLCzQYkqodwT4y0ZUX
        T3a5NYZ3wi1KZAoITsszKJwC+POh
X-Google-Smtp-Source: ABdhPJxuMCXg25FegB3ey+8+CQhK5JjTM++CBhHWfxnztkaS4009jptSWxqNhk7SYomJ3w4rNfMb+Q==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr17493602wmc.10.1590248622062;
        Sat, 23 May 2020 08:43:42 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id p23sm12614456wma.17.2020.05.23.08.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 08:43:41 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/5] rebase -i: support --ignore-date
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200521101455.63484-1-phillip.wood123@gmail.com>
 <20200521101455.63484-5-phillip.wood123@gmail.com>
 <20200523123025.GA20683@danh.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <bc6bc4d4-79cb-f788-deca-41a3735fcaae@gmail.com>
Date:   Sat, 23 May 2020 16:43:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200523123025.GA20683@danh.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh

On 23/05/2020 13:30, Đoàn Trần Công Danh wrote:
> Hi Phillip,
> 
> On 2020-05-21 11:14:54+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
>> +# Checking for +0000 in author time is enough since default
>> +# timezone is UTC, but the timezone used while committing
>> +# sets to +0530.
>> +test_expect_success '--ignore-date works with apply backend' '
>> +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
>> +	git rebase --apply --ignore-date HEAD^ &&
>> +	git log -1 --pretty="format:%ai" >authortime &&
> 
> Those --pretty="format:%ai" won't print the newline character in my
> test environment.
> It looks like it won't print the newline if stdout isn't a tty.
> 
> 	git log -1 --pretty=%ai
> 
> doesn't have that issue.
> 
> I think there're some grep out there considers file doesn't end with
> newline as non-text files.

Yes it would be better to print the newline, thanks

>> +	grep "+0000" authortime
>> +'
>> +
>> +test_expect_success '--ignore-date works with merge backend' '
>> +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
>> +	git rebase --ignore-date -m HEAD^ &&
>> +	git log -1 --pretty="format:%ai" >authortime &&
>> +	grep "+0000" authortime
>> +'
>> +
>> +test_expect_success '--ignore-date works after conflict resolution' '
>> +	test_must_fail git rebase --ignore-date -m \
>> +		--onto commit2^^ commit2^ commit2 &&
>> +	echo resolved >foo &&
>> +	git add foo &&
>> +	git rebase --continue &&
>> +	git log --pretty=%ai >authortime &&
>> +	grep +0000 authortime
>> +'
> 
>  From the test's name, I guess git-rebase is supposed to continue
> respect --ignore-date after conflict resolution.
> 
> But the content of authortime read:
> 
> 	2020-05-23 12:13:58 +0000
> 	1999-04-02 08:03:20 +0530
> 	1999-04-02 08:03:20 +0530
> 
> It's still pass "grep +0000 authortime" because of first line,
> I'm not sure if I missed anything.

It's only rebasing one commit - the log command is missing -1. I've 
checked the log invocations in the other tests and I think they're all OK.

Junio - are you happy to fix this up (assuming there are no other 
issues) or do you want a re-roll?

Thanks

Phillip
