Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389C3C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 20:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbhL1Uok (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 15:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbhL1Uok (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 15:44:40 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E5C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 12:44:39 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p13so7385868lfh.13
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 12:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=oEyiCDHW7LwZMHMoOkQUuYxkr4Jm0ADJcYJUOs9TAI8=;
        b=pjwZiXjnJT5GhgOSsah2XpnnwdssTQ4UV5/Csh5uHVEMZi5zyo8CBllyvqKiMrJ5y0
         i9TbyNkAPoCwoJ6QCO9KtdAiHbExQpFHAXQ9b8l5M8lY+VnhFjqaere8PBLZT0BB+ZjD
         rPxf+oAEiZklPdVev3xmK2E+Yk9yyt3OjHVJMRk3fMukfIBN5UTN4/ACUeSCIUh7+nC7
         OuCUDvhVMLxOV5Ejj8dV//7D8vw1XUdR7biwTDC2XqLOZNXj8WNQKMPJglu2y/+N6ihu
         DsyTNVliqNHDOt5WeYN8WZDKpj4qDCX2CMC/8g6hwoOTqGhqU/2XJ0lBUU63oVL6KZWR
         Db8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=oEyiCDHW7LwZMHMoOkQUuYxkr4Jm0ADJcYJUOs9TAI8=;
        b=uzQzyYiVhKnRgzTr4Q3INptiFyuiaaNJoNF+yn5NyPjyeH1BHSP2iLrVWIfARp+xgP
         RiIQka3nLd2ZgckAQbAwDUgBgDuIMRy/ndVvFhoD0VYy7B4jXw+eMlEchQuSMH/BVkXf
         O2RCnfAeShA3smVYbtwI8fV3YEvreYp9VjuZOiYTWZmBsLxjwVtTXyCo/QrjQcl6Mulq
         mnaJLFnazunbIyY7RrNJbhPIHGFEsLEqLl/rCOYCqCjaHmWkDI5pTdD5CVsECSs4CBpE
         YVQIXCCQAWdbqssKBbL4/IYjgsAbZbq6o/BR7G5q/LxT8Xan1VK949/nRtvwYRl8CQdx
         Kw3A==
X-Gm-Message-State: AOAM532JoqXZ3CznxEk8Q5cXoDZN5yBnniF3t3zBlWI9mWJQsw8Nt60L
        gjL1b//MYhDzNSqC2YN6wutsCBpVfyc=
X-Google-Smtp-Source: ABdhPJzM6D+QlKiMFca7TOSukGYQguab80YbudS5XwEWMNyYrbsAuBM3gKIBv/PuslfL3aPHzJcZ+g==
X-Received: by 2002:a05:6512:314d:: with SMTP id s13mr21188230lfi.397.1640724276955;
        Tue, 28 Dec 2021 12:44:36 -0800 (PST)
Received: from ?IPV6:2a02:2168:8729:6c00:f9e:84f5:5aba:46b8? ([2a02:2168:8729:6c00:f9e:84f5:5aba:46b8])
        by smtp.gmail.com with ESMTPSA id d2sm707504ljj.118.2021.12.28.12.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 12:44:36 -0800 (PST)
Message-ID: <a8f3246f-2b50-e713-16c3-1d23b80a42a1@gmail.com>
Date:   Tue, 28 Dec 2021 23:44:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: request: allow passing -X <strategy-option> to git checkout
 <path> to auto-solve merge conflicts
Content-Language: en-US
To:     git@vger.kernel.org
References: <3e1548ab-5e20-9555-bd10-d6cbf2ffbce4@gmail.com>
 <CA+JQ7M-By65FVPnMFnwE8zx3T4O7DV3_5Kf2P6eZhP4Zcemorg@mail.gmail.com>
Cc:     Erik Cervin Edin <erik@cervined.in>
From:   Andrey Butirsky <butirsky@gmail.com>
In-Reply-To: <CA+JQ7M-By65FVPnMFnwE8zx3T4O7DV3_5Kf2P6eZhP4Zcemorg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Erik, please post your further replies to the mailing list so 
others could see it also.

On a topic,
I'm not familiar with Git code-base so don't know if it even possible in 
it's current architecture..


On 28.12.2021 20:32, Erik Cervin Edin wrote:
> That's my answer =)
>
> I think adding a merge strategy option to checkout might be useful
>
> On Mon, Dec 27, 2021 at 4:49 PM Andrey Butirsky <butirsky@gmail.com> wrote:
>> Hi, stumbling upon this again and again, so decided to write finally,
>>
>> while in conflicting state, the only thing we can do to auto-pick one or
>> another side of conflict is passing --ours/--theirs option to git-checkout:
>> git checkout --ours/--theirs <path>
>>
>> The problem is - it doesn't actually do a _merge_, i.e. you lose all
>> non-conflicted changes.
>>
>> There is no easy way to solve that currently without third-party tools.
>>
>> This link illustrates it:
>> https://stackoverflow.com/a/68498101/1063363
>>
>> Proposal:
>> Shell we add -X <strategy-option> to git checkout <path> to allow it do
>> a merge and _actually solve_ merge conflicts?
>> That would be in-pair with other commands taking the option already:
>> git-merge, git-rebase, (etc.?)
>>
