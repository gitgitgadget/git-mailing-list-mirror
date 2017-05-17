Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FD452023D
	for <e@80x24.org>; Wed, 17 May 2017 03:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbdEQDfp (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 23:35:45 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35265 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdEQDfk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 23:35:40 -0400
Received: by mail-qt0-f196.google.com with SMTP id r58so56344qtb.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 20:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=IBKM6WCWfpb5FE7N37jLrMWN/7G/p1J99KrSRXfj6Nk=;
        b=YgPBaZh7bYzN5l7VyUhA9mwWV8Im0jsSdQO0Nsh2S4ZDpUGU8p9QsN5R2cYmDoHe3c
         ZlZVtsyand5Qvi0g8B32EVhh+JtlX+QzspemWUdN/3rwEkWf6fSayQZ3rIR/TNM4MIgM
         NDLHHQXYm4T9d25Bm/Kqxn6h2A87UznVssuzwQah5FgnT7ZJyuoVZR2chftskwC0u8m5
         nZScnZz8B9edTcUIf0ffvoe/7LdNF50k0U7J3jQXPpIppcoNOffs4Cnq/P1ONJA97BVf
         UYlqroEZBo+CvkXrPuuJ2qfb6koRVxM0sPkReBsGPceKWB8B8Hm5z7LPYtnVHz3U5lER
         8f/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=IBKM6WCWfpb5FE7N37jLrMWN/7G/p1J99KrSRXfj6Nk=;
        b=O+fILGTDiDfoOD3G5UPEWi61TpnkrSbYcJWAEtRcmkSoO7+tgv8LrlutAZfTZCO7rc
         lqg8HMaYV+KxyEuSiD5JI71ivYXqjS0mUVsbf4BnjPSuBq1Qn6f0VEZL/F83cJbbYwyO
         q2b2C0V+o9ioQhCe4c15HAhgLWidLwJfNwU1ccV7/Caqf8LsU11R2WYu3eaGaQOdINyP
         +SnvhPuK0A9QegVyuxdg1WbxzvmuOyYvan1us50jOQO/cd4Nuxjypwj1cKIAF29CTky0
         c3b2s2SladsWoxySgv6rXZezlU1PRFihAd8mu8OhF9tMGf+F4zyiVKkiEnoh4pGqprl2
         QBMg==
X-Gm-Message-State: AODbwcCZbW+MIjGFY04TH0EC0iZVoPbYog25+tyeNMkM0mFtdLAO9gnm
        L+sszhbfQWaefQ==
X-Received: by 10.200.48.221 with SMTP id w29mr1063855qta.54.1494992138796;
        Tue, 16 May 2017 20:35:38 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id z43sm607976qtz.9.2017.05.16.20.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 20:35:38 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] Teach git to optionally utilize a file system
 monitor to speed up detecting new or changed files.
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-3-benpeart@microsoft.com>
 <473c4b47-06a7-cb55-6d67-e335fa5b5a5b@google.com>
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
From:   Ben Peart <peartben@gmail.com>
Message-ID: <45f4f321-bccf-b64f-0d20-af7603c9e8f8@gmail.com>
Date:   Tue, 16 May 2017 23:35:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <473c4b47-06a7-cb55-6d67-e335fa5b5a5b@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/16/2017 5:41 PM, Jonathan Tan wrote:
> I'm not very familiar with this part of the code - here is a partial
> review.
>
> Firstly, if someone invokes update-index, I wonder if it's better just
> to do a full refresh (e.g. by deleting the last_update time from the
> index).

A full refresh can be very expensive when the working directory is large 
(the specific case this patch series is trying to improve).  Instead, 
the code does the minimal update required to keep things fast but still 
return correct results.

>
> Also, the change to unpack-trees.c doesn't match my mental model. I
> notice that it is in a function related to sparse checkout, but if the
> working tree changes for whatever reason, it seems simpler to just let
> the hook do its thing. As far as I can tell, it is fine to have files
> overzealously marked as FSMONITOR_DIRTY.

The case this (and the others like it) is solving is when the index is 
updated but there may not be any change to the associated file in the 
working directory.  When this occurs, the hook won't indicate any change 
has happened so the index and working directory could be out of sync. 
To be sure this doesn't happen, the index entry is marked 
CE_FSMONITOR_DIRTY to ensure the file is checked.

This is pretty simple to demonstrate - a simple "git reset HEAD~1" will 
do it as a mixed reset updates the index but doesn't touch the files in 
the working directory.

>
> On 05/15/2017 12:13 PM, Ben Peart wrote:
>> diff --git a/cache.h b/cache.h
>> index 40ec032a2d..64aa6e57cd 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -201,6 +201,7 @@ struct cache_entry {
>>  #define CE_ADDED             (1 << 19)
>>
>>  #define CE_HASHED            (1 << 20)
>> +#define CE_FSMONITOR_DIRTY   (1 << 21)
>>  #define CE_WT_REMOVE         (1 << 22) /* remove in work directory */
>>  #define CE_CONFLICTED        (1 << 23)
>>
>> @@ -324,6 +325,7 @@ static inline unsigned int canon_mode(unsigned int
>> mode)
>>  #define CACHE_TREE_CHANGED    (1 << 5)
>>  #define SPLIT_INDEX_ORDERED    (1 << 6)
>>  #define UNTRACKED_CHANGED    (1 << 7)
>> +#define FSMONITOR_CHANGED    (1 << 8)
>>
>>  struct split_index;
>>  struct untracked_cache;
>> @@ -342,6 +344,8 @@ struct index_state {
>>      struct hashmap dir_hash;
>>      unsigned char sha1[20];
>>      struct untracked_cache *untracked;
>> +    time_t last_update;
>> +    struct ewah_bitmap *bitmap;
>
> Here a bitmap is introduced, presumably corresponding to the entries in
> "struct cache_entry **cache", but there is also a CE_FSMONITOR_DIRTY
> that can be set in each "struct cache_entry". This seems redundant and
> probably at least worth explaining in a comment.
>

The ewah bitmap is loaded from the index extension and saved until it 
can be processed after the untracked cache has been loaded and 
initialized in post_read_index_from().  I'm not opposed to documenting 
that to make it clearer but I've just followed the same pattern the 
untracked cache, and split index extensions use which don't specifically 
document it either.

>> +/*
>> + * Call the query-fsmonitor hook passing the time of the last saved
>> results.
>> + */
>> +static int query_fsmonitor(time_t last_update, struct strbuf *buffer)
>> +{
>> +    struct child_process cp = CHILD_PROCESS_INIT;
>> +    char date[64];
>> +    const char *argv[3];
>> +
>> +    if (!(argv[0] = find_hook("query-fsmonitor")))
>> +        return -1;
>> +
>> +    snprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update);
>> +    argv[1] = date;
>> +    argv[2] = NULL;
>> +    cp.argv = argv;
>> +    cp.out = -1;
>> +
>> +    return capture_command(&cp, buffer, 1024);
>> +}
>
> Output argument could probably be named better.

I agree.  I've renamed it query_result for the next iteration.

>
> Also, would the output of this command be very large? If yes, it might
> be better to process it little by little instead of buffering the whole
> thing first.
>

The output is usually quite small as it is is the list of files modified 
in the working directory since the last command that requested the 
updated list.

>> +void write_fsmonitor_extension(struct strbuf *sb, struct index_state*
>> istate);
>
> Space before * (in the .h and .c files).
>

Thanks, missed that.  I'll fix it for the next iteration.

