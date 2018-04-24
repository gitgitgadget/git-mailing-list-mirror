Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236531F424
	for <e@80x24.org>; Tue, 24 Apr 2018 12:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756796AbeDXMbN (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 08:31:13 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39390 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeDXMbL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 08:31:11 -0400
Received: by mail-qk0-f194.google.com with SMTP id z75so8329795qkb.6
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 05:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=h+za7PgWOsr46yhRWe5LGQmqjRnqNi2tNCc3MfISH2A=;
        b=sJXD07bZiSWo+E/MLc97q1JXrKELK6WDtH9yw7SyJLpk3h3uXCzQUfUfACn/dEUXi3
         JNcetBhMUlGqW63Tx2cME7fIgYCn59DwmQ2BpcnOjJ61S1Nl3Oqe/2zIs241BOjNBre0
         Pixor/bwpOoj9DnA7xGghDVerbgiXa6V/wPxH86KWxfvMBJdKywkecJ27CCORMaTV3ZW
         Q/i/B0MxJ2e7lLptYPy7WzRs/dHt7yHLHs6RCPkg1Stk8vsC37/OTv6GiCCrwlVOtQIh
         +Ic3inWfc+Z4LN7YsmR06wPeJk0wFInKAKuEE4GS1TjEg/GbgnjEkCN+2UP49tljGsEc
         dTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=h+za7PgWOsr46yhRWe5LGQmqjRnqNi2tNCc3MfISH2A=;
        b=NUtmFRg7KyvxcU0mTC0aLyqR1ZXKU/X62uBLP3Vz6tkT5SAHxyd7ktFqEfommFD66S
         P36UaJwLza3yJ6Zm0tGx6yNkP6XEJGE2+dRYuN/RcR6Tgb414WPF00unlV8YnySuxDpg
         iWe2EF2k+GYhHd9/je/uYWkCmQxLtGbet6QH7D6MV4M2dzZPcRLXbJoDlivFT7hMxi6Q
         hI5DMs9pvAeozptxcnHMueXD71zq1UqrzPWUnAwMXRszFkI8TbS7gXMtUUAJOrhKLJUJ
         3rqkPpMjmuFLpecNEUguXFkJqgnX0TSQq259DBO90I7VrdIqi5bARnfWEmMHyKuFNqtT
         5haw==
X-Gm-Message-State: ALQs6tBxwp+MXVSXNk/RnQ+BfVeMwqmMV+SwjpurRwmKJhK+SPI5ZxKz
        UYtLe8o2orL1WVwjz3exVlo=
X-Google-Smtp-Source: AB8JxZqJv9aYijB/pWmT9HAGpN5BIrlepO7qrL2B6cbHGEygs96td6bULNpf+34PD0Iug7kMyP9I1Q==
X-Received: by 10.55.108.135 with SMTP id h129mr25441041qkc.35.1524573071058;
        Tue, 24 Apr 2018 05:31:11 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id x81sm599320qka.50.2018.04.24.05.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Apr 2018 05:31:10 -0700 (PDT)
Subject: Re: [PATCH v3 7/9] commit: add short-circuit to
 paint_down_to_common()
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
References: <20180409164131.37312-1-dstolee@microsoft.com>
 <20180417170001.138464-1-dstolee@microsoft.com>
 <20180417170001.138464-8-dstolee@microsoft.com> <86bmeggl1m.fsf@gmail.com>
 <bd2011f0-41d4-4550-5392-65a3816ed4d3@gmail.com> <86efj5fvrz.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b32b7548-6b58-9619-b53e-aa0bad7a81eb@gmail.com>
Date:   Tue, 24 Apr 2018 08:31:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86efj5fvrz.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/23/2018 5:38 PM, Jakub Narebski wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> On 4/18/2018 7:19 PM, Jakub Narebski wrote:
>>> Derrick Stolee <dstolee@microsoft.com> writes:
>>>
>> [...]
>>>> [...], and this saves time during 'git branch --contains' queries
>>>> that would otherwise walk "around" the commit we are inspecting.
>>>>
>>> If I understand the code properly, what happens is that we can now
>>> short-circuit if all commits that are left are lower than the target
>>> commit.
>>>
>>> This is because max-order priority queue is used: if the commit with
>>> maximum generation number is below generation number of target commit,
>>> then target commit is not reachable from any commit in the priority
>>> queue (all of which has generation number less or equal than the commit
>>> at head of queue, i.e. all are same level or deeper); compare what I
>>> have written in [1]
>>>
>>> [1]: https://public-inbox.org/git/866052dkju.fsf@gmail.com/
>>>
>>> Do I have that right?  If so, it looks all right to me.
>> Yes, the priority queue needs to compare via generation number first
>> or there will be errors. This is why we could not use commit time
>> before.
> I was more concerned about getting right the order in the priority queue
> (does it return minimal or maximal generation number).
>
> I understand that the cutoff could not be used without generation
> numbers because of the possibility of clock skew - using cutoff on dates
> could lead to wrong results.

Maximal generation number is important so we do not visit commits 
multiple times (say, once with PARENT1 set, and a second time when 
PARENT2 is set). A minimal generation number order would create a DFS 
order and walk until the cutoff every time.

In cases without clock skew, maximal generation number order will walk 
the same set of commits as maximal commit time; the order may differ, 
but only between incomparable commits.

>>>> For a copy of the Linux repository, where HEAD is checked out at
>>>> v4.13~100, we get the following performance improvement for
>>>> 'git branch --contains' over the previous commit:
>>>>
>>>> Before: 0.21s
>>>> After:  0.13s
>>>> Rel %: -38%
>>> [...]
>>>>    		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
>>>>    		if (flags == (PARENT1 | PARENT2)) {
>>>>    			if (!(commit->object.flags & RESULT)) {
>>>> @@ -876,7 +886,7 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
>>>>    			return NULL;
>>>>    	}
>>>>    -	list = paint_down_to_common(one, n, twos);
>>>> +	list = paint_down_to_common(one, n, twos, 0);
>>>>      	while (list) {
>>>>    		struct commit *commit = pop_commit(&list);
>>>> @@ -943,7 +953,7 @@ static int remove_redundant(struct commit **array, int cnt)
>>>>    			filled_index[filled] = j;
>>>>    			work[filled++] = array[j];
>>>>    		}
>>>> -		common = paint_down_to_common(array[i], filled, work);
>>>> +		common = paint_down_to_common(array[i], filled, work, 0);
>>>>    		if (array[i]->object.flags & PARENT2)
>>>>    			redundant[i] = 1;
>>>>    		for (j = 0; j < filled; j++)
>>>> @@ -1067,7 +1077,7 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
>>>>    	if (commit->generation > min_generation)
>>>>    		return 0;
>>>>    -	bases = paint_down_to_common(commit, nr_reference, reference);
>>>> +	bases = paint_down_to_common(commit, nr_reference, reference, commit->generation);
>>> Is it the only case where we would call paint_down_to_common() with
>>> non-zero last parameter?  Would we always use commit->generation where
>>> commit is the first parameter of paint_down_to_common()?
>>>
>>> If both are true and will remain true, then in my humble opinion it is
>>> not necessary to change the signature of this function.
>> We need to change the signature some way, but maybe the way I chose is
>> not the best.
> No, after taking longer I think the new signature is a good choice.
>
>> To elaborate: paint_down_to_common() is used for multiple
>> purposes. The caller here that supplies 'commit->generation' is used
>> only to compute reachability (by testing if the flag PARENT2 exists on
>> the commit, then clears all flags). The other callers expect the full
>> walk down to the common commits, and keeps those PARENT1, PARENT2, and
>> STALE flags for future use (such as reporting merge bases). Usually
>> the call to paint_down_to_common() is followed by a revision walk that
>> only halts when reaching root commits or commits with both PARENT1 and
>> PARENT2 flags on, so always short-circuiting on generations would
>> break the functionality; this is confirmed by the
>> t5318-commit-graph.sh.
> Right.
>
> I have realized that just after sending the email.  I'm sorry about this.
>
>> An alternative to the signature change is to add a boolean parameter
>> "use_cutoff" or something, that specifies "don't walk beyond the
>> commit". This may give a more of a clear description of what it will
>> do with the generation value, but since we are already performing
>> generation comparisons before calling paint_down_to_common() I find
>> this simple enough.
> Two things:
>
> 1. The signature proposed in the patch is more generic.  The cutoff does
>     not need to be equal to the generation number of the commit, though
>     currently it always (all of one time the new mechanism is used) is.
>
>     So now I think the new signature of paint_down_to_common() is all
>     right as it is proposed here.
>
> 2. The way generation numbers are defined (with 0 being a special case,
>     and generation numbers starting from 1 for parent-less commits), and
>     the way they are compared (using strict comparison, to avoid having
>     to special-case _ZERO, _MAX and _INFINITY generation numbers) the
>     cutoff of 0 means no cutoff.
>
>     On the other hand cutoff of 0 can be understood as meaning no cutoff
>     as a special case.
>
>     It could be made more clear to use (as I proposed elsewhere in this
>     thread) symbolic name for this no-cutoff case via preprocessor
>     constants or enums, e.g. GENERATION_NO_CUTOFF:
>
>      @@ -876,7 +886,7 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
>        			return NULL;
>        	}
>        -	list = paint_down_to_common(one, n, twos);
>      +	list = paint_down_to_common(one, n, twos, GENERATION_NO_CUTOFF);
>          	while (list) {
>        		struct commit *commit = pop_commit(&list);
>      @@ -943,7 +953,7 @@ static int remove_redundant(struct commit **array, int cnt)
>        			filled_index[filled] = j;
>        			work[filled++] = array[j];
>        		}
>      -		common = paint_down_to_common(array[i], filled, work);
>      +		common = paint_down_to_common(array[i], filled, work, GENERATION_NO_CUTOFF);
>        		if (array[i]->object.flags & PARENT2)
>        			redundant[i] = 1;
>        		for (j = 0; j < filled; j++)
>
>
>     But whether it makes code more readable, or less readable, is a
>     matter of opinion and taste.
>

Since paint_down_to_common() is static to this file, I think 0 is 
cleaner. If the method was external and used by other .c files, then I 
would use this macro trick to clarify "what does this zero parameter mean?".

Thanks,
-Stolee
