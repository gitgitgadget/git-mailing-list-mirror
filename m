Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 039FA1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 14:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754256AbeBGONc (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 09:13:32 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:47073 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754240AbeBGON2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 09:13:28 -0500
Received: by mail-qk0-f194.google.com with SMTP id d125so1204761qkg.13
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 06:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4eBudWJ8TXbpBYXtRPRxGGJoepQD2HfC1Oa3VvVqqok=;
        b=KmXxYIesZeah/kpXsiUkHDIIOWw+lWXlVEKvUROdrALaVUH2eR0l46LUPv669Y2yR1
         pW845JQ71Lq7QGtm608PysPhWpnkwq1v+ng8cs6g0MJdNDtzQruDkrr5+5lz+L+XPWGB
         ZXNtstyWVO9FBE0NWAuEAaE+lZswnjHKZq+Nq6tCopebrBgB//k+dXI585N95+mXWRGy
         Vm04oKOfNnKNFTBqsXJ0VH6om7+qgwVcJ7W4IIOfEvvDpclaOmg/iH7yHVbmY0IKgTl0
         bqHhsAouFnS/xjbW2I1E9sVopMfoEiROkSnFFUwuuM+lMzUw2b4EmUew86ocpEzXKlxI
         LO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4eBudWJ8TXbpBYXtRPRxGGJoepQD2HfC1Oa3VvVqqok=;
        b=nurxFvvIECgqxgx+wrEwaKSA9hwKN3Bok60W7qiFR+auTSGmODbbRJkT120IHLRKbV
         dF/grABbhuRX5imgbHEf5Ok9++9p73N8uBY4VdT8WhK0Nw82uD2OIidxpyo7IStMd8n3
         XtwFR8npfvz9tWizp2LS2VhcCkUU18J39xmWNQ7m7xNDEgMvNjRr7FNlQT43FRYlwFR4
         UwSLgSddDY8LVXTbHAU5hOX81lLOg0twTXOsQcGVJqyQBf5MloOJqUQP8tvOs8qBRv+o
         l1b9DRew5X/O8KJFQxo5JFooEg4cM+sC/24//4/205iySyh3PitbEGX0jiyBaaKEOtgG
         f3bQ==
X-Gm-Message-State: APf1xPCQ6lxufPjCDTbCOg2SAtP+epqOFEGOXKClAoTjeh9OUxhWXKYJ
        hjArEcPIpkOIY7EcgDWB8o8=
X-Google-Smtp-Source: AH8x224YX+SNPVyL1xjM1DN+M9DufW4KFqUWkJBmFqxkrLkl4FxfC/DXR8j6FbA8aTu1NRnXSgI7kQ==
X-Received: by 10.55.140.130 with SMTP id o124mr8528546qkd.120.1518012807961;
        Wed, 07 Feb 2018 06:13:27 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id h5sm1068433qkd.61.2018.02.07.06.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2018 06:13:27 -0800 (PST)
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to
 the untracked cache
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180205195619.31064-1-benpeart@microsoft.com>
 <20180205215805.GA90084@google.com>
 <6fb43664-7546-7865-0488-8ed6292d77a6@gmail.com>
 <CACsJy8DLP=j-h3knwX9zOpejAfUbv1YJwfB-iw4476oy0hTfxg@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0039c71c-cefd-4950-aa7c-ffbb7cf66e49@gmail.com>
Date:   Wed, 7 Feb 2018 09:13:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8DLP=j-h3knwX9zOpejAfUbv1YJwfB-iw4476oy0hTfxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/6/2018 7:27 AM, Duy Nguyen wrote:
> 
> This is another thing that bugs me. I know you're talking about huge
> index files, but at what size should we start this sort of
> optimization? Writing down a few MBs on linux is cheap enough that I
> won't bother optimizing (and I get my UNTR extension repaired all the
> time, so reduced lstat calls and stuff). This "typically" only comes
> at certain size, what size?
> 

It's important to identify what we're trading off here.  With the 
proposed optimization, we'll end up doing less writes of the index but 
potentially more lstat calls.  Even with a small index, writing the 
index is much more expensive than calling lstat on a file.  Exactly how 
much more expensive depends on a lot of variables but even with a SSD 
its still orders of magnitude difference.

That means we could potentially lstat hundreds or thousands of files and 
still come out ahead.  Given the untracked cache works at the directory 
level, the lstat cost actually scales with the number of directories 
that have had changes (ie changing a 2nd file in the same directory 
doesn't add any additional cost).  In "typical" workflows, developers 
don't often change hundreds of files across different directories so 
we'd "typically" still come out ahead.

We have internal performance tests based on common developer sequences 
of commands (status, edit a file, status, add, status, commit, log, 
push, etc) that show that having the untracked cache turned on actually 
makes these sequences slower.  At the time, we didn't have time to 
investigate why so we just turned off the untracked cache.

When writing the fsmonitor patch series which can utilize the untracked 
cache, I did some investigation into why the untracked cache was slowing 
things down in these tests and discovered the cause was the additional 
index writes.  That is what led to this patch.

I've been sitting on it for months now because I didn't have the time to 
write some performance tests for the git perf framework to demonstrate 
the problem and how this helps solve it.  With the discussion about the 
fsmonitor extension, I thought this might be a good time to send it out 
there.

If you have the cycles, time a typical series of commands with and 
without the untracked cache (ie don't just call status over and over in 
a loop) and you should see the same results.  Given my limited time 
right now, I'm OK putting this on the back burner again until a git perf 
test can be written to ensure it actually speeds things up as advertised.
