Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94C391F453
	for <e@80x24.org>; Mon,  1 Oct 2018 20:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeJBDRP (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 23:17:15 -0400
Received: from mout.web.de ([212.227.17.12]:59291 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbeJBDRP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 23:17:15 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2MUi-1fqVSx1LpU-00s4ur; Mon, 01
 Oct 2018 22:37:31 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2MUi-1fqVSx1LpU-00s4ur; Mon, 01
 Oct 2018 22:37:31 +0200
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
To:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
 <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
 <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
Date:   Mon, 1 Oct 2018 22:37:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:85OLWWAUvZq+aY0ccqIyvT3Rjw7CJJpHABjljJKnC8g7y5RQyXN
 CIeZITojdP5+tVUM76PjcRDUiEoYZg28DXA/XkIL7vVHGK75OzHH7orYLJKA/XYRBUrtPeF
 kXzA2VA+ubF2U7dYtr/NIwEIB3nnrZdQGnp0RPVfDEgNdgFLwTQTCn9wTOuvepZwcsnwR4b
 WWKZN2OTtkzUVdBxD93Jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+KARjYcuDWM=:AD036R0BbS8uRrsZUmPeXs
 Yi0XAfg+/GzuHrwiFKZZV8T/KZLAalFq6TG4uvHO7KzCcda1h2OIhT45+HABxZmJLhie3NWoD
 Wq/RrUuac9dxtDxwYjpIB/H5Ytr5OpFM0jLl1pbv0uMrYnQLu3yVQXy4BlHmUVFqyPby+kV44
 gzPtRnQW3lBxI4EtDFs00nh+82cIhjSWVITFyVkQ8o9060bM9Nd/UkE4YsODZraUWFvx9Evjl
 4WdiUlZyo+TwD538OcY/19mpbUrwcH+7x3RrMMdDn9xsnU2ZPyzcJwCPzwRtMVjPFdJ3Cvy1S
 l4yFTlJA5xGhc/x11M3RqplQcJc3twdx6lzZH5ihlAdIb09MNbEXa9AEh5aQs4O/lPijut+5Y
 4VB1vLymRsIiEW6qg84PDs5nqeWjQoPMGVdZq7QM+XbSMe6blsVgyyd+3//36SZxnrYLV8sIh
 znZdG1mKf7D5q7Aqrwa9MIkwgfZ8hk+WvnbC2QXH8uzA5FUEz3Rh4JUDxs57iyLwCb0saRSLi
 emJAjOQ88llVzTxZNWq3JL0ADMYKL7GvD+QMWqRfpskJN60pl1CrA9kqP4JNauRe0B2Ue6efX
 zQhB6wQPQhq7MzOmYWOzUIKfbfYtIEZhED+O8h8dhAcZ92AGDDz9cQ8V0Ae+SyGDiTYI34ajW
 cLgWIOf43x9GrfBDmxB7ujFoUoDmqNErZU3bZ02mvR9mVG/ho5t2WMqLSd0rRjw6V448xp4He
 xpl0bsD8qn9rRAl+9Nkh9FaL7jb39JTJurop2Pp41DXveSZvVWxm0BhdFG7oVEtID8/RytYus
 HT6+T9nIRRKsmuum267nWsIALDK7phfPKO+kUsoqvS3lJIelQs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.10.2018 um 21:26 schrieb Derrick Stolee:
> On 10/1/2018 3:16 PM, René Scharfe wrote:
>> Am 28.06.2018 um 14:31 schrieb Derrick Stolee via GitGitGadget:
>>> diff --git a/commit-reach.c b/commit-reach.c
>>> index c58e50fbb..ac132c8e4 100644
>>> --- a/commit-reach.c
>>> +++ b/commit-reach.c
>>> @@ -513,65 +513,88 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
>>>   	return is_descendant_of(commit, list);
>>>   }
>>>   
>>> -int reachable(struct commit *from, int with_flag, int assign_flag,
>>> -	      time_t min_commit_date)
>>> +static int compare_commits_by_gen(const void *_a, const void *_b)
>>>   {
>>> -	struct prio_queue work = { compare_commits_by_commit_date };
>>> +	const struct commit *a = (const struct commit *)_a;
>>> +	const struct commit *b = (const struct commit *)_b;
>> This cast is bogus.  QSORT gets handed a struct commit **, i.e. an array
>> of pointers, and qsort(1) passes references to those pointers to the
>> compare function, and not the pointer values.
> 
> Good catch! I'm disappointed that we couldn't use type-checking here, as 
> it is quite difficult to discover that the types are wrong here.

Generics in C are hard, and type checking traditionally falls by the
wayside.  You could use macros for that, like klib [*] does, but that
has its own downsides (more object text, debugging the sort macros
themselves is harder).

[*] https://github.com/attractivechaos/klib/blob/master/ksort.h

>> diff --git a/commit-reach.c b/commit-reach.c
>> index 00e5ceee6f..2f5e592d16 100644
>> --- a/commit-reach.c
>> +++ b/commit-reach.c
>> @@ -529,8 +529,8 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
>>   
>>   static int compare_commits_by_gen(const void *_a, const void *_b)
>>   {
>> -	const struct commit *a = (const struct commit *)_a;
>> -	const struct commit *b = (const struct commit *)_b;
>> +	const struct commit *a = *(const struct commit * const *)_a;
>> +	const struct commit *b = *(const struct commit * const *)_b;
> 
> I would expect s/* const */**/ here, but I'm guessing your formulation 
> is a bit extra careful about types.

Yeah, that second const is not necessary, as the dereference in the same
line makes it inconsequential, but I added it to make clear that this
function is really not supposed to write at all..

René
