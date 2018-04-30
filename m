Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5902F215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 12:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeD3MFJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 08:05:09 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38705 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeD3MFH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 08:05:07 -0400
Received: by mail-qk0-f194.google.com with SMTP id b39so6388770qkb.5
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/jEH2MytH87QxeEAkqfzvhEPx0Sn2IVzFKAdH5XLGKQ=;
        b=OyqneqPBC2g6BShy8wUBd/ZEJAB7K4fY+/hRAD2vkXVyXVDUSxXhIxhhQC1LHvDLR4
         BmuLbvMPuMv59RHwVLe7f1AYORdpdk1/7jdj43xyZ1/cHP5OTxlTqOU29TPH7Rxcoka7
         2TF+lqydHzFoB4k5fFrj5ZUv8tJ8YqPqL+S94XJ5MGuCXSkP02H8fIA8Zf0OZbJgREBD
         hfG7W+TSsr+Fdi4BsDt+bIKAbvd40l32CAzqoYBQ7HuFY8Y6P3oYuJ7jAYTZfkc58Y8T
         uwscO40X+HutgQgPilsZg1/Dt5qJ1uPBPk0zfPpfJWlrXzSYO6FUMDk/uBEqr46EXwvG
         Svdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/jEH2MytH87QxeEAkqfzvhEPx0Sn2IVzFKAdH5XLGKQ=;
        b=qVeQBPqkRFdzSTqeHdx+Fm/4QfCcDRouALKTbU7DyZgU/wiqYjHoUHYYfa7L2cZJAW
         FZ/N9IIU1bqZjCURmx98GaGxCrUsd3sPMk/Po+yFttSAlGTqCA76Egw0TETnBrcuBbl4
         WbyYYoM0gPezok2+wH8oU1by0CLuupVcO8B2NSHpFyxRbhEfXHEpYJzVB1qPAFFF8pc7
         wPaqjhtqE3SfyNuBUOxT0Fl+5727jL3xW+PygggR12fa4p1Fo5P4ifiYNcriCT3a7reC
         twEX1hSD0hLXRogvFYcSOP5mZuVZuErlySehJr3/jnLj+t55TEVZLv2CmPU6WckfsEJj
         EHXw==
X-Gm-Message-State: ALQs6tAaQLmUN+fBeuTEeEWQPeSZgrjMrJk7vINFjVPO51aGMIwSfNti
        i5wvMWvY77WohYhMdkIFI9c=
X-Google-Smtp-Source: AB8JxZpCccbew9igf1ddDghMaQ9lc044pL3uYJoT6CkWZTtqejcJxq47opYh0N+mYcRJ09j7jQ2Rrg==
X-Received: by 10.55.173.17 with SMTP id f17mr9979479qkm.342.1525089906825;
        Mon, 30 Apr 2018 05:05:06 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id s125sm5659283qke.96.2018.04.30.05.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 05:05:06 -0700 (PDT)
Subject: Re: [PATCH v4 02/10] commit: add generation number to struct commmit
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
 <20180425143735.240183-1-dstolee@microsoft.com>
 <20180425143735.240183-3-dstolee@microsoft.com> <86604bj6xr.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4d6aa9bf-7bb3-8e56-83c7-88962bd64308@gmail.com>
Date:   Mon, 30 Apr 2018 08:05:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86604bj6xr.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/28/2018 6:35 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> The generation number of a commit is defined recursively as follows:
>>
>> * If a commit A has no parents, then the generation number of A is one.
>> * If a commit A has parents, then the generation number of A is one
>>    more than the maximum generation number among the parents of A.
> Very minor nitpick: it would be more readable wrapped differently:
>
>    * If a commit A has parents, then the generation number of A is
>      one more than the maximum generation number among parents of A.
>
> Very minor nitpick: possibly "parents", not "the parents", but I am
> not native English speaker.
>
>> Add a uint32_t generation field to struct commit so we can pass this
>> information to revision walks. We use three special values to signal
>> the generation number is invalid:
>>
>> GENERATION_NUMBER_INFINITY 0xFFFFFFFF
>> GENERATION_NUMBER_MAX 0x3FFFFFFF
>> GENERATION_NUMBER_ZERO 0
>>
>> The first (_INFINITY) means the generation number has not been loaded or
>> computed. The second (_MAX) means the generation number is too large to
>> store in the commit-graph file. The third (_ZERO) means the generation
>> number was loaded from a commit graph file that was written by a version
>> of git that did not support generation numbers.
> Good explanation; I wonder if we want to have it in some shortened form
> also in comments, and not only in the commit message.
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   alloc.c        | 1 +
>>   commit-graph.c | 2 ++
>>   commit.h       | 4 ++++
>>   3 files changed, 7 insertions(+)
> I have reordered patches to make it easier to review.
>
>> diff --git a/commit.h b/commit.h
>> index 23a3f364ed..aac3b8c56f 100644
>> --- a/commit.h
>> +++ b/commit.h
>> @@ -10,6 +10,9 @@
>>   #include "pretty.h"
>>   
>>   #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
>> +#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
>> +#define GENERATION_NUMBER_MAX 0x3FFFFFFF
>> +#define GENERATION_NUMBER_ZERO 0
> I wonder if it wouldn't be good to have some short in-line comments
> explaining those constants, or a block comment above them.
>
>>   
>>   struct commit_list {
>>   	struct commit *item;
>> @@ -30,6 +33,7 @@ struct commit {
>>   	 */
>>   	struct tree *maybe_tree;
>>   	uint32_t graph_pos;
>> +	uint32_t generation;
>>   };
>>   
>>   extern int save_commit_buffer;
> All right, simple addition of the new field.  Nothing to go wrong here.
>
> Sidenote: With 0x7FFFFFFF being (if I am not wrong) maximum graph_pos
> and maximum number of nodes in commit graph, we won't hit 0x3FFFFFFF
> generation number limit for all except very, very linear histories.

Both of these limits are far away from being realistic. But we could 
extend the maximum graph_pos independently from the maximum generation 
number now that we have the "capped" logic.

>
>> diff --git a/alloc.c b/alloc.c
>> index cf4f8b61e1..e8ab14f4a1 100644
>> --- a/alloc.c
>> +++ b/alloc.c
>> @@ -94,6 +94,7 @@ void *alloc_commit_node(void)
>>   	c->object.type = OBJ_COMMIT;
>>   	c->index = alloc_commit_index();
>>   	c->graph_pos = COMMIT_NOT_FROM_GRAPH;
>> +	c->generation = GENERATION_NUMBER_INFINITY;
>>   	return c;
>>   }
> All right, start with initializing it with "not from commit-graph" value
> after allocation.
>
>>   
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 70fa1b25fd..9ad21c3ffb 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -262,6 +262,8 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
>>   	date_low = get_be32(commit_data + g->hash_len + 12);
>>   	item->date = (timestamp_t)((date_high << 32) | date_low);
>>   
>> +	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
>> +
> I guess we should not worry about these "magical constants" sprinkled
> here, like "+ 8" above.
>
> Let's examine how it goes, taking a look at commit-graph-format.txt
> in Documentation/technical/commit-graph-format.txt
>
>   * The first H (g->hash_len) bytes are for the OID of the root tree.
>   * The next 8 bytes are for the positions of the first two parents [...]
>
> So 'commit_data + g->hash_len + 8' is our offset from the start of
> commit data.  All right.
>
>    * The next 8 bytes store the generation number of the commit and
>      the commit time in seconds since EPOCH.  The generation number
>      uses the higher 30 bits of the first 4 bytes. [...]
>
> The higher 30 bits of the 4 bytes, which is 32 bits, means that we need
> to shift 32-bit value 2 bits right, so that we get lower 30 bits of
> 32-bit value.  All right.
>
>    All 4-byte numbers are in network order.
>
> Shouldn't it be ntohl() to convert from network order to host order, and
> not get_be32()?  I guess they are the same (network order is big-endian
> order), and get_be32() is what rest of git uses...

ntohl() takes a 32-bit value, while get_be32() takes a pointer. This 
makes pulling network-bytes out of streams much cleaner with get_be32(), 
so I try to use that whenever possible.

