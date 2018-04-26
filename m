Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B131F424
	for <e@80x24.org>; Thu, 26 Apr 2018 13:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755698AbeDZNtO (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 09:49:14 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:42091 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755354AbeDZNtN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 09:49:13 -0400
Received: by mail-qk0-f173.google.com with SMTP id j10so25565611qke.9
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 06:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=05qM+9fvA0X+hB+LGyceT3wXoDWqh4ID590FQrrvvuI=;
        b=Zk6CxVuYoR9lwKL2eV7qmFSP+OD9OW1NSAWgGnToeYh9t3aUzlADCQWMGF7La59zVh
         M1xMysgzmAkZJqmOhL7jv6VR7r1wwJkP57W5AbZmAMM38xvgDMzfOjceQbypLqhockre
         f64mV/RqXeyCLey4ehGEEMPLFKvsyRcLfi/di5Oi94ScVyrWwJfaLCb+Z1MRzcDt515D
         XKo6W8RuhKJ/hFBagrg1NTaf14TpVJbfR6Mt+gxyjdXgmdiFKY8/P0ZNH5rmujvJ9QhT
         ZscbREIAm+EoE/rCTZVkBVGCJZW1eD1By3cerLKlOley9/KnDnirLHfpG28bgj3xT8C1
         8wxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=05qM+9fvA0X+hB+LGyceT3wXoDWqh4ID590FQrrvvuI=;
        b=PL2iH6btg3Bubl6XYvGDFtJ7tYZMxTAj6TtojjQuTr26jyUfZwHfIegf4z57mZO58v
         V1FvPT145JPixGzuxA87T0NZZHgJH7Vlf6XB69pvcDiS7vgiwgwQCoKsKZGFt54LuKMT
         SPfjpB/QNFda95W6woCLNfM0W6d9F7WZgCkVFAqqZaiHaSWQQyK8l7Ae9x/kEjZ2vEZn
         cyffWIuyb1qDDZYg8H55RA/ZMxldoI91uOayLmPB1FqrhbUxbDBQbwd1S49a8gstVAR0
         j+Mhg6695aeCGuWe/V+erO9bg7dZGQhBBkR0S18KNRVF8v/kUAsHcJT2GDP1JUhEvXNJ
         Oeeg==
X-Gm-Message-State: ALQs6tAP0l1/tpGKHTfnC5Ug1JFnTQzYht/PHGqWTjIyN8Rnj7zTZomZ
        8U22ztKmfKvIj+7xYvaibw2gCBZMtpw=
X-Google-Smtp-Source: AB8JxZqZZ+KE3SyZW/itz5ofh9YqXucMQcIzMiUOQbcvuhxvgp3mOXCkrH4Fqe/HE7KWXpq8WSDGJw==
X-Received: by 10.233.216.65 with SMTP id u62mr36269740qkf.133.1524750552176;
        Thu, 26 Apr 2018 06:49:12 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id d21sm5308681qkc.30.2018.04.26.06.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 06:49:11 -0700 (PDT)
Subject: Re: [PATCH v4 03/10] commit-graph: compute generation numbers
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
 <20180425143735.240183-1-dstolee@microsoft.com>
 <20180425143735.240183-4-dstolee@microsoft.com>
 <xmqqvace3d9s.fsf@gitster-ct.c.googlers.com>
 <21272fff-acf9-8641-3aa9-1d026843ff3a@gmail.com>
Message-ID: <3a7e7f76-834b-2671-6c61-67a42b2eeb77@gmail.com>
Date:   Thu, 26 Apr 2018 09:49:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <21272fff-acf9-8641-3aa9-1d026843ff3a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/2018 8:58 AM, Derrick Stolee wrote:
> n 4/25/2018 10:35 PM, Junio C Hamano wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:
>>
>>> @@ -439,6 +439,9 @@ static void write_graph_chunk_data(struct 
>>> hashfile *f, int hash_len,
>>>           else
>>>               packedDate[0] = 0;
>>>   +        if ((*list)->generation != GENERATION_NUMBER_INFINITY)
>>> +            packedDate[0] |= htonl((*list)->generation << 2);
>>> +
>>>           packedDate[1] = htonl((*list)->date);
>>>           hashwrite(f, packedDate, 8);
>> The ones that have infinity are written as zero here.  The code that
>> reads the generation field off of a file in fill_commit_graph_info()
>> and fill_commit_in_graph() both leave such a record in file as-is,
>> so the reader of what we write out will think it is _ZERO, not _INF.
>>
>> Not that it matters, as it seems that most of the code being added
>> by this series treat _ZERO and _INF more or less interchangeably.
>> But it does raise another question, i.e. do we need both _ZERO and
>> _INF, or is it sufficient to have just a single _UNKNOWN?
>
> This code is confusing. The 'if' condition is useless, since at this 
> point every commit should be finite (since we computed generation 
> numbers for everyone). We should just write the value always.
>
> For the sake of discussion, the value _INFINITY means not in the graph 
> and _ZERO means in the graph without a computed generation number. 
> It's a small distinction, but it gives a single boundary to use for 
> reachability queries that test generation number.
>
>>
>>> @@ -571,6 +574,46 @@ static void close_reachable(struct 
>>> packed_oid_list *oids)
>>>       }
>>>   }
>>>   +static void compute_generation_numbers(struct commit** commits,
>>> +                       int nr_commits)
>>> +{
>>> +    int i;
>>> +    struct commit_list *list = NULL;
>>> +
>>> +    for (i = 0; i < nr_commits; i++) {
>>> +        if (commits[i]->generation != GENERATION_NUMBER_INFINITY &&
>>> +            commits[i]->generation != GENERATION_NUMBER_ZERO)
>>> +            continue;
>>> +
>>> +        commit_list_insert(commits[i], &list);
>>> +        while (list) {
>>> +            struct commit *current = list->item;
>>> +            struct commit_list *parent;
>>> +            int all_parents_computed = 1;
>>> +            uint32_t max_generation = 0;
>>> +
>>> +            for (parent = current->parents; parent; parent = 
>>> parent->next) {
>>> +                if (parent->item->generation == 
>>> GENERATION_NUMBER_INFINITY ||
>>> +                    parent->item->generation == 
>>> GENERATION_NUMBER_ZERO) {
>>> +                    all_parents_computed = 0;
>>> +                    commit_list_insert(parent->item, &list);
>>> +                    break;
>>> +                } else if (parent->item->generation > 
>>> max_generation) {
>>> +                    max_generation = parent->item->generation;
>>> +                }
>>> +            }
>>> +
>>> +            if (all_parents_computed) {
>>> +                current->generation = max_generation + 1;
>>> +                pop_commit(&list);
>>> +            }
>> If we haven't computed all parents' generations yet,
>> current->generation is undefined (or at least "left as
>> initialized"), so it does not make much sense to attempt to clip it
>> at _MAX at this point.  At leat not yet.
>>
>> IOW, shouldn't the following two lines be inside the "we now know
>> genno of all parents, so we can compute genno for commit" block
>> above?
>
> You're right! Good catch. This code sets every merge commit to _MAX. 
> It should be in the block above.
>
>>
>>> +            if (current->generation > GENERATION_NUMBER_MAX)
>>> +                current->generation = GENERATION_NUMBER_MAX;
>>> +        }
>>> +    }

This bothered me: why didn't I catch a bug here? I rebased my "fsck" RFC 
onto this branch and it succeeded. Then, I realized that this does not 
actually write incorrect values, since we re-visit this commit again 
after we pop the stack down to this commit. However, there is time in 
the middle where we have set the generation (in memory) incorrectly and 
that could easily turn into a real bug by a later change.

I'll stick the _MAX check in the if above to prevent confusion.

Thanks,
-Stolee

