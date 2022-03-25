Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0A8C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 22:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiCYWjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 18:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbiCYWjS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 18:39:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0F8A0BDE
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 15:37:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q11so9625747pln.11
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 15:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hbHUP6/V/ZOOW3L7dzqzwygdqKg4JCJ+Q9pKzJqSfMM=;
        b=Z6bg5yYzZ8ETICDWBPOfaaxq1BCS4J8cBVI1Nf+pLLlOxY95qFcrq8YljKUMyHTPl5
         1CPusFuUCYM9Dg3MyWgl5XiaT4G1w+ym5hZvSrIcB1xnYE/YtVmKfQmdtZDvVcZkYSLk
         Yk5I4fLb2+7zgCbBIhN/WTvKrihhsXylg3uWUkNPzV+xeenEJEN4k3TAcyapSYEzeAkX
         F3X6Qw5myDX39dEnX+O0AiAboGi7pZw3TN429QWLXwNfCoBzoHIu1wJvIEa6XHqzPXVR
         o6ZVP+bZFca9DWFP6BHWGPmqdmjrHNeH2D9oIL6dM7aiYJ82ycRiD9tYDYO2+5iT2O1P
         MXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hbHUP6/V/ZOOW3L7dzqzwygdqKg4JCJ+Q9pKzJqSfMM=;
        b=u2cy3516p05w4d0+hRAwwArZhg8/6jXtmVSwLsQ4X/CstzP+7Al4yfW0PhK7F8CZOT
         X1V4VOxcXyHwTUIk965ujdeE8fniR7B4FzaJrVjbTYA01Zy7w3iUbaBWhqdqr9+HgUVI
         BqQEQ3JxsNM9Rhsf/eJyeYTx4AIsIGQhM/WiIK3E+8bi+8WIxykxQKJ8g/m/W/BKFtaY
         zRTbeH8fvi7MxRhDQOC6zYtziu8yc6/6IMDc95xwc9NJgmXjogtBvITFepKi2LZzsL5v
         M5C9UIpejL2tPPNavhUZH/bkeeEj1Gd6Nsb9tDv9r8s0/b9F3WIfsN8+2IT/vfh7hqFB
         p9MA==
X-Gm-Message-State: AOAM530iRZ/sYtOOMG0jtqPS2wf0qncSZVgVCHzhfPvQCTY7L7ZUosDr
        x66CKQ44B8s9s2M1uBGXQTyU
X-Google-Smtp-Source: ABdhPJweVp/m50WVhkVvBhaqahSreulYEaQw4iBIQglVdF3+s59WyVZb4KrNmEyrFzSMx2P9lsSuBg==
X-Received: by 2002:a17:903:2406:b0:14d:2f71:2e6d with SMTP id e6-20020a170903240600b0014d2f712e6dmr13704756plo.98.1648247863191;
        Fri, 25 Mar 2022 15:37:43 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id me5-20020a17090b17c500b001c63699ff60sm14880713pjb.57.2022.03.25.15.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 15:37:42 -0700 (PDT)
Message-ID: <d03a34e6-d6a7-6ddb-5784-57078e32ab89@github.com>
Date:   Fri, 25 Mar 2022 15:37:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] mv: refresh stat info for moved entry
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     reichemn@icloud.com, gitster@pobox.com
References: <pull.1187.git.1648173419533.gitgitgadget@gmail.com>
 <30d20d10-da33-ae41-7887-d73279e14e92@github.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <30d20d10-da33-ae41-7887-d73279e14e92@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 3/24/2022 9:56 PM, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> Add 'refresh_cache_entry()' after moving the index entry in
>> 'rename_index_entry_at()'. Internally, 'git mv' uses
>> 'rename_index_entry_at()' to move the source index entry to the destination,
>> overwriting the old entry if '-f' is specified. However, it does not refresh
>> the stat information on destination index entry, making its 'CE_UPTODATE'
>> flag out-of-date until the index is refreshed (e.g., by 'git status').
>>
>> Some commands, such as 'git reset', assume the 'CE_UPTODATE' information
>> they read from the index is accurate, and use that information to determine
>> whether the operation can be done successfully or not. In order to ensure
>> the index is correct for commands such as these, explicitly refresh the
>> destination index entry in 'git mv' before exiting.
> 
> Good find. Thanks for the fix!
> 
>> Reported-by: Maximilian Reichel <reichemn@icloud.com>
> 
> Thanks for the report, Maximilian!
> 
>> @@ -148,6 +148,7 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
>>  	untracked_cache_remove_from_index(istate, old_entry->name);
>>  	remove_index_entry_at(istate, nr);
>>  	add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
>> +	refresh_cache_entry(istate, new_entry, CE_MATCH_REFRESH);
> 
> It certainly seems reasonable to add this line. I was unfamiliar
> with this method, and it is used only twice: when creating a new
> cache entry in make_cache_entry() and in merge-recursive.c's
> add_cache_info(). So, it is currently acting in the case of a
> newly-inserted cache entry in its existing cases, and here in
> 'git mv' that's essentially what we are doing (deleting the old
> and adding a new would be more appropriate than just moving the
> old one).
> 
> I took a brief detour thinking about performance, but this is
> run only once per command-line argument, so any new overhead
> is minimal.
>   
>> +test_expect_success 'mv -f refreshes updated index entry' '
>> +	echo test >bar &&
>> +	git add bar &&
>> +	git commit -m test &&
>> +
>> +	echo foo >foo &&
>> +	git add foo &&
>> +	git mv -f foo bar &&
>> +	git reset --merge HEAD
> 
> Is there any post-condition on the index that we want to check here?
> 
> That is, is there anything that we could notice via 'git status' or
> similar that would break before this patch (assuming we put a
> test_might_fail in front of the 'git reset --merge HEAD' line)?
> 

While looking into this, I realized 1) that I wasn't actually refreshing the
cache entry because 'refresh_cache_entry' doesn't work in-place (will fix in
the next version) and 2) the test was only passing because of a race
condition that (as of right now) I can't quite figure out. 

If I add a 'sleep 1' after the 'git add', the test behaves as I expect:
fails when 'mv' doesn't refresh the entry, passes when it does. However,
when the sleep *isn't* there and I'm testing 'git mv' without the refresh,
most of the time the test *doesn't* fail (sometimes it does, but not
reliably). I'm going to try finding the root cause of that before sending
V2, in case I'm missing something else that should be fixed.

But to answer your question, yes - 'git diff-files' will produce an empty
result if the cache is reset properly, and will be non-empty if it is not.
I'll include that in the re-roll as well. 

> Thanks,
> -Stolee

