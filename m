Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C73A1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 01:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBFBjq (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 20:39:46 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37874 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeBFBjo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 20:39:44 -0500
Received: by mail-qt0-f195.google.com with SMTP id s27so282925qts.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 17:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BVxkfqMPEfPOUnZUKMKSUt1PXM/QZRzbRVUuFvTu41M=;
        b=TozhnCb+3B4co+QAcA86TPrDsLJ1qB3xvMWmwSZVneI0kYlZM6pU4cb4IYSbmAh9DK
         jI8EHTO4ZuoFKSxFk/B472UJoChtB/kIxdtnVQoACv/VycqYhQKQnqMK7gDqyKnffMfT
         6A61mJWCG/T3J18KS6r6XScNPFSxoEXZtUSlHpFlc3m5PdbEp/8XiucFaUSVMWuz3kI8
         Q8MoT5uBdQJISnoqNCyrb+4TGkiFmyKOQf3mxxdXFAT0WDxhvR97es4yMO55qt9BsRGt
         LYYuNa26gfi9Je0NszLr/bleXkGw3P5XWItyFFMf2f1M1VZJiVsGZGb7rO8e1xiNnGG2
         p/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BVxkfqMPEfPOUnZUKMKSUt1PXM/QZRzbRVUuFvTu41M=;
        b=tWuGohOBIGJtUF5nz0Fvxdfl5z3/aWDiBdq5nsgzUnCPSC0MvLpvK+jZlREBHLakSj
         ezqJKO8LBndDyI9jmXZQNSr2pV8JZz/9T5YQRIaGeo2C5N/XGDLniKrvRNtLBRy5oVlY
         KgiLgAsnvh/myxbdYjz5/bcaCpJ2WTQ+8vvSvsGMgyeK+8DAgmHiQJljEl5FZqIvG5Hd
         pXqeb+gVz1Ck5BRGurKKlBFkbzC79qpmyQsmwPxIMvkM2PEouQLXixFBensP3lUkMLKR
         irxXH29D/obFVh1XA8RbaxcF3NEvW5brH4g0lY8aNK0YewCDEggTZ5Hcc8fvCzPWDHDx
         uDog==
X-Gm-Message-State: APf1xPA430HFXD1gOH/wJPj3xW5OfB1ntDKU4t1Kqjybs71R8+xaLSX8
        BIK0HT8+vJucrLdvVK7L480=
X-Google-Smtp-Source: AH8x227UgnAryOGoxhr3hg7Mv0//rmdGCXU6VazuVtIHwtT+xdXQfAK+7Oq+gSqsto805NCaa1lGCw==
X-Received: by 10.200.47.103 with SMTP id k36mr1185054qta.151.1517881183575;
        Mon, 05 Feb 2018 17:39:43 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id a77sm6558695qkb.41.2018.02.05.17.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2018 17:39:42 -0800 (PST)
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to
 the untracked cache
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, bmwill@google.com,
        avarab@gmail.com
References: <20180205195619.31064-1-benpeart@microsoft.com>
 <xmqqd11j9mx2.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <6ff2ecb4-7e37-3b06-3722-cccec2329934@gmail.com>
Date:   Mon, 5 Feb 2018 20:39:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqd11j9mx2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/5/2018 3:55 PM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> The untracked cache saves its current state in the UNTR index extension.
>> Currently, _any_ change to that state causes the index to be flagged as dirty
>> and written out to disk.  Unfortunately, the cost to write out the index can
>> exceed the savings gained by using the untracked cache.  Since it is a cache
>> that can be updated from the current state of the working directory, there is
>> no functional requirement that the index be written out for every change to the
>> untracked cache.
>>
>> Update the untracked cache logic so that it no longer forces the index to be
>> written to disk except in the case where the extension is being turned on or
>> off.  When some other git command requires the index to be written to disk, the
>> untracked cache will take advantage of that to save it's updated state as well.
>> This results in a performance win when looked at over common sequences of git
>> commands (ie such as a status followed by add, commit, etc).
>>
>> After this patch, all the logic to track statistics for the untracked cache
>> could be removed as it is only used by debug tracing used to debug the untracked
>> cache.
>>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> ---
>>
> 
> OK, so in other words (note: not a suggestion to use different
> wording in the log message; just making sure I got the motivation
> behind this change correctly), without this new environment
> variable, changes to untracked cache alone (due to observed changes
> in the filesystem) does not count as "in-core index changed so we
> need to write it back to the disk".
> 

Correct

> That makes sense to me.
> 
> Is it envisioned that we want to have similar but different "testing
> only" behaviour around this area?  If not, this environment variable
> sounds more like "force-flush untracked cache", not "test untracked
> cache", to me.
> 

Many of the tests make a change and then verify that the on disk 
structure was updated correctly.  This was the simplest way to keep 
those tests functioning. I don't imagine this would be used for anything 
other than enabling the tests.  I hate naming so am happy to name it 
which ever you think is best. :)

>> +GIT_TEST_UNTRACKED_CACHE=true
>> +export GIT_TEST_UNTRACKED_CACHE
>> +
>>   sync_mtime () {
>>   	find . -type d -ls >/dev/null
>>   }
>>
>> base-commit: 5be1f00a9a701532232f57958efab4be8c959a29
