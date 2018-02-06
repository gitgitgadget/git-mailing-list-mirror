Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6491F404
	for <e@80x24.org>; Tue,  6 Feb 2018 01:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeBFBsC (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 20:48:02 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37316 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeBFBsB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 20:48:01 -0500
Received: by mail-qk0-f195.google.com with SMTP id c128so396499qkb.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 17:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uc8BS88aRTq/hd5hsROwt8cNdvU4Pk6w4bWhLJVsQiE=;
        b=SPt2Z9+PZZx64ybhGOHBTRY+1Wcbf94/CkOK8PRiXo07B7rvDXmm/gy8vAB0Ins5n3
         5QhDsZZlCpqDRMq0xGRtpkAeq86j6rPu6BIe683RHf1HEftsHzIzoT49FwbVzC0WiK+q
         YKzWtVpYU65baCg6OaSOF7dFKgpJRx3luGjVjtZm4iT8tVmq5ipE4o6FVQFbk2YpZMF0
         HMXLlUC10cbVIEO5KCsV3bjlvEjIC/pfRMuCWFF1Bza39V2iF9IstA7F9yG/EHfmA5Vk
         wt1MWFJLnbaWOiJW8pJZ/ThfJ/TXW6nwEUM2ASDebae0g0hW+OR2Vqyha4Da/xw2I893
         r3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uc8BS88aRTq/hd5hsROwt8cNdvU4Pk6w4bWhLJVsQiE=;
        b=Asz1PzqReapc4eTxsPCZrRH2f1p5h+bHs23TGt9dMGUToWxzlUICzYlTaX9B6ul6b8
         z35c4I4bSPh3NR9kByl5/wEkLqPI5UMTuaE5T87z4oLfbpSY+fLxGqbhVOD9lroM0Mb0
         4iTjzwY3OgDSvRCBTJpF8c2UBuOpEJuRbU+vdHOOTI23dh5XL4zfxxlqDpG7KJInCVpt
         S0+r4XxVVzdSOzpmgstuyMn/Z6JhQHA7V/jjg5GRSzIdAMBaHIMJa4LPzkbhBi7gD0GE
         LyTBWod/QFzVZ3gQuhVEe26+7XgpZjneDPXPC+QaEtyaJwYZ/92Y9qJj07G9GntCh18m
         DmKw==
X-Gm-Message-State: APf1xPDzrLZQ0w+/aiRJUYl9VUL93senubpmrX2ghYlkwUKTiBaLyjFd
        vYL2RsTqSjmrrbC/pjF+7Xg=
X-Google-Smtp-Source: AH8x225MHEQJ2df8ilptfw7h1pQZ3GK9KlTAKS/glM4+K9YSX/vjq/pKRxD0qrlNbWtF5LeqguS/cQ==
X-Received: by 10.55.144.2 with SMTP id s2mr1062187qkd.257.1517881680114;
        Mon, 05 Feb 2018 17:48:00 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id q28sm6645876qkh.43.2018.02.05.17.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2018 17:47:59 -0800 (PST)
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to
 the untracked cache
To:     Brandon Williams <bmwill@google.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, avarab@gmail.com
References: <20180205195619.31064-1-benpeart@microsoft.com>
 <20180205215805.GA90084@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <6fb43664-7546-7865-0488-8ed6292d77a6@gmail.com>
Date:   Mon, 5 Feb 2018 20:48:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205215805.GA90084@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/5/2018 4:58 PM, Brandon Williams wrote:
> On 02/05, Ben Peart wrote:
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
> 
> So we don't need to update it every time because its just a cache
> and if its inaccurate between status calls that's ok?  So only
> operations like add and commit will actually write out the untracked
> cache (as a part of writing out the index).  Sounds ok.
> 
> What benefit is there to using the untracked cache then?  Sounds like
> you should just turn it off instead?
> (I'm sure this is a naive question :D )

The parts of the untracked cache that have not changed since the 
extension was updated are still cached and valid.  Only those 
directories that have changes will need to be checked.

With the old behavior, making a change in dir1/, then calling status 
would update the dir1/ untracked cache entry, flag the index as dirty 
and write it out.  On the next status, git would detect that no changes 
have been made and use the cached data for dir1/.

With the new behavior, making a change in dir1/, then calling status 
would update the dir1/ untracked cache entry but not write it out. On 
the next status, git would detect the change in dir1/ again and update 
the untracked cache.  All of the other cached entries are still valid 
and the cache would be used for them.  The updated cache entry for dir1/ 
would not get persisted to disk until something that required the index 
to be written out.

The behavior is correct in both cases.  You just don't get the benefit 
of the updated cache for the dir1/ entry until the index is persisted 
again.  What you gain in exchange is that you don't have to write out 
the index which is (typically) a lot more expensive than checking dir1/ 
for changes.

> 
>>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> ---
>>
>> Notes:
>>      Base Ref: master
>>      Web-Diff: https://github.com/benpeart/git/commit/20c2e8d787
>>      Checkout: git fetch https://github.com/benpeart/git untracked-cache-v1 && git checkout 20c2e8d787
>>
>>   dir.c                             | 3 ++-
>>   t/t7063-status-untracked-cache.sh | 3 +++
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/dir.c b/dir.c
>> index 7c4b45e30e..da93374f0c 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -2297,7 +2297,8 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>>   				 dir->untracked->gitignore_invalidated,
>>   				 dir->untracked->dir_invalidated,
>>   				 dir->untracked->dir_opened);
>> -		if (dir->untracked == istate->untracked &&
>> +		if (getenv("GIT_TEST_UNTRACKED_CACHE") &&
>> +			dir->untracked == istate->untracked &&
>>   		    (dir->untracked->dir_opened ||
>>   		     dir->untracked->gitignore_invalidated ||
>>   		     dir->untracked->dir_invalidated))
>> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
>> index e5fb892f95..6ef520e823 100755
>> --- a/t/t7063-status-untracked-cache.sh
>> +++ b/t/t7063-status-untracked-cache.sh
>> @@ -14,6 +14,9 @@ test_description='test untracked cache'
>>   # See <20160803174522.5571-1-pclouds@gmail.com> if you want to know
>>   # more.
>>   
>> +GIT_TEST_UNTRACKED_CACHE=true
>> +export GIT_TEST_UNTRACKED_CACHE
>> +
>>   sync_mtime () {
>>   	find . -type d -ls >/dev/null
>>   }
>>
>> base-commit: 5be1f00a9a701532232f57958efab4be8c959a29
>> -- 
>> 2.15.0.windows.1
>>
> 
