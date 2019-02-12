Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DC191F453
	for <e@80x24.org>; Tue, 12 Feb 2019 17:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbfBLRkA (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 12:40:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35496 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBLRj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 12:39:59 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so3956267qtk.2
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 09:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PtjBjKwIVq9E3sMfLGErXBdODRrXvph0+f+8/IChSTA=;
        b=iMTt+dot/tEwO9R+nSLW/48N9bqmoqrjEQ4vSXdjbaO1jLmdDUfqHXf1YrLmGO9pfo
         GL/8ZY63g0BkD22BIPOjES7ePtDP+YckoDO1cn+4UnUmtqIAq5G2+uqK+Jm8PYm59N2l
         mVW0MKFmUlSoZqmhJWDwEKGM/awWPwgn7YwO3kzsoJMK9RAfQq61WJ0B9MAGEEfJCUmK
         U0CcmRG6Ggr1kfAPSJzM5SVxUyGRo585pVl2aY5VApqWEWJqZPu5NEvlgJVIvMPIOAFs
         Ei0Lw/7WnMrhHDdGqMaPT/JwB4/sMw7lXog6QTSm8uwAN8PsG1kxPfXNDlyE5++lZol+
         sr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PtjBjKwIVq9E3sMfLGErXBdODRrXvph0+f+8/IChSTA=;
        b=q84yF2sSYtk/73pe9nUlx7gj6NcvH+T3QNIXDQnjsws0i/ZMZrIKeaBstAvNwHAbc6
         wOQp61YAH/e6LxmHlprbE0c+fMQnCPN7fl5fW3LrHbfvL24Quy2q2R6SHEAmrG851Qmu
         ugbhwcVoYzMbF68GGrh/QRB/MXSCFe8WBFQR+YNKFu5IJqLhsQ5Hbopf+Iyx167ilkV+
         Zx6nvzxqbUjKobY7dbLpQLsZOYOcTlZVef8Qjsg6iIP5CnZydY7JAQJgIEjqeKgFRReS
         MpOeaTp77v3F1LmWCzlzBknJhXSMaJ5EIgcq7NIST154D3SEyUNHKIlceedTaxqxEe/0
         nlqw==
X-Gm-Message-State: AHQUAuZ7plj19vIiOggaqxYyRk/nxJNV+Pr/HWrFeqkkd0u5uU4r3BS/
        pYRuTv4p+GblrIDIV18CPLnqn7Nj
X-Google-Smtp-Source: AHgI3IatPfrQkO1YmRnSWGIxiQWs677fKLxWUQzqJXW8tteMlNFk5f0zMpivlPUagioCm7q+DWaHMw==
X-Received: by 2002:ac8:1085:: with SMTP id a5mr3794037qtj.279.1549993198135;
        Tue, 12 Feb 2019 09:39:58 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id i28sm13061262qkk.41.2019.02.12.09.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:39:57 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v1 1/3] read-cache: add post-indexchanged hook
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, benpeart@microsoft.com, kewillf@microsoft.com
References: <20190208195115.12156-1-peartben@gmail.com>
 <20190208195115.12156-2-peartben@gmail.com>
 <20190208235317.GI11927@genre.crustytoothpaste.net>
Message-ID: <782f0801-a207-96c9-2f1c-ed7939a9e3a5@gmail.com>
Date:   Tue, 12 Feb 2019 12:39:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208235317.GI11927@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/8/2019 6:53 PM, brian m. carlson wrote:
> On Fri, Feb 08, 2019 at 02:51:13PM -0500, Ben Peart wrote:
>> From: Ben Peart <benpeart@microsoft.com>
>>
>> Add a post-indexchanged hook that is invoked after the index is written in
>> do_write_locked_index().
>>
>> This hook is meant primarily for notification, and cannot affect
>> the outcome of git commands that trigger the index write.
>>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> 
> First, I think the tests should be merged into this commit. That's what
> we typically do.

Happy to.  In fact, I'd be happy to add the documentation as well and 
have a single commit. That's what _I'd_ typically do for something small 
like this. :)

> 
> I'm also going to bikeshed slightly and suggest "post-index-changed",
> since we normally use dashes between words in our hook names.
> 

I can do that as well to help make it more consistent.

>> diff --git a/cache.h b/cache.h
>> index 27fe635f62..46eb862d3e 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -338,7 +338,9 @@ struct index_state {
>>   	struct cache_time timestamp;
>>   	unsigned name_hash_initialized : 1,
>>   		 initialized : 1,
>> -		 drop_cache_tree : 1;
>> +		 drop_cache_tree : 1,
>> +		 updated_workdir : 1,
>> +		 updated_skipworktree : 1;
> 
> How important is it that we expose whether the skip-worktree bit is
> changed? I can understand if we expose the workdir is updated, since
> that's a thing a general user of this hook is likely to be interested
> in. However, I'm not sure that for a general-purpose hook, the
> skip-worktree bit is interesting.
> 

In our use case, we needed the skip-worktree flag because if something 
clears the skip-worktree bit on a file, we need to start paying 
attention to it in the work directory.  This flag tells us that may have 
happened and enables us to not have to do the extra work for other index 
changed events that don't change the index without updating the working 
directory.

Initially this was just to deal with 'reset --mixed' as it behaves 
differently with regards to updating the index and working directory 
than most other commands.  However, the update-index command can also 
arbitrarily clear the skip-worktree bit so we renamed the flag to be 
more generic.

>> diff --git a/read-cache.c b/read-cache.c
>> index 0e0c93edc9..0fcfa8a075 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -17,6 +17,7 @@
>>   #include "commit.h"
>>   #include "blob.h"
>>   #include "resolve-undo.h"
>> +#include "run-command.h"
>>   #include "strbuf.h"
>>   #include "varint.h"
>>   #include "split-index.h"
>> @@ -2999,8 +3000,17 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
>>   	if (ret)
>>   		return ret;
>>   	if (flags & COMMIT_LOCK)
>> -		return commit_locked_index(lock);
>> -	return close_lock_file_gently(lock);
>> +		ret = commit_locked_index(lock);
>> +	else
>> +		ret = close_lock_file_gently(lock);
>> +
>> +	run_hook_le(NULL, "post-indexchanged",
>> +			istate->updated_workdir ? "1" : "0",
>> +			istate->updated_skipworktree ? "1" : "0", NULL);
> 
> I have, in general, some concerns about this API. First, I think we need
> to consider that if we're going to expose various bits of information,
> we might in the future want to expose more such bits. If so, adding
> integer parameters is not likely to be a good way to do this. It's hard
> to remember and if a binary is used as the hook, it may not always
> handle additional arguments gracefully like shell scripts tend to.
> 

Binaries deal with a variable number of arguments all the time via `int 
argc, const char **argv` so this isn't a problem (we actually use a 
binary for this hook already).

> If we're not going to expose the skip-worktree bit, then I suppose one
> argument is fine. Otherwise, it might be better to expose key-value
> pairs on stdin instead, or something like that.
> 

I'm not sure what else we may want to add in the future; this is all 
we've needed for our uses.  For now, I'd suggest we keep it simple and 
just pass them as command line parameters like we do with the other 
hooks.  It's easy to add additional arguments in the future and if we 
ever get to where that is unwieldy, we can address it then (YAGNI).

> Finally, I have questions about performance. What's the overhead of
> determining whether the hook exists in this code path when there isn't
> one? Since the index is frequently used, and can be written out as an
> optimization by some commands, it would be nice to keep overhead low if
> the hook isn't present.
> 

If you ever hit this code path, we've just updated the index which means 
we read the index file, did an lstat() on every file in the repo plus 
various refs, config files, etc, and then wrote out a new index file. 
Adding one more test for a hooks existence doesn't have any measurable 
impact.

Thank you for the feedback!

