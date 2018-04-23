Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B9B21F424
	for <e@80x24.org>; Mon, 23 Apr 2018 14:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755494AbeDWOk6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 10:40:58 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33613 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755227AbeDWOk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 10:40:56 -0400
Received: by mail-qk0-f193.google.com with SMTP id c70so7541106qkg.0
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 07:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JMKrGG6GMQ8d/iLmLFOiFLeqMz53RaNe4+l0hfEOz1c=;
        b=Naz2nIM9L6Ct77hMb2UFQhIz+oVOtociJ+YNoYc6X7C80EU+IvSVxHjAutgL0gmUZV
         xezld/RV83FXsjQaV0kRiiTYM8BubpGR7d8UbiSeJ1uW1+s1emYnXc7vtH8JGSUZCUSo
         /XCVHKL3e2uQw9GfFa5qxaCQpfuZBJHW14lrrJ9HFwAHyMUGAOAYZVrVEe47U3uI/744
         +cah+uoq+8eJB5Pe+odpeBLkVizjC6wZMj+Liy6lfkvnymRttcmWLkn5w2tZ/+sM2IP9
         RdN2Ou8Wz3MRYjBGsxWSgA0lUO0UVsuUjCyGLDWDG2Dquy8EXYD6QQIfnV9KwxhICiSy
         AIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JMKrGG6GMQ8d/iLmLFOiFLeqMz53RaNe4+l0hfEOz1c=;
        b=TIuE0sYN9Sc+ksABsptUPAmPUD/2b9fukod8G+gm2gvpyENGEWwn4SHgaYKqsOwMXC
         bLJN0IJjjgewbx3UVPZTCUSfvm/wCe5VTvom50eToYZctYgCXSDoVNCd8O8xeQD6Zyj9
         CxNwASMeYcmxLhhRmbp6Bm/SvJyuLApmUdWjSqYMsfU+hruUXJ860E9UQtAMJ10hefHv
         W3j+C2IDtKWE/1XZfiRa4FBEwWFz0i2u18CIfiDR/YkEG7hznk+B+L/NFGmPu9SARx8B
         XuqhDMi7KO1Nx+Cr8VtCWKMpqpPefD4dwBmujrs7RZCz1g3qt+qBN1TKhowq2ch6Ae5S
         ITjg==
X-Gm-Message-State: ALQs6tCt5VDQm7uvbKa/HmA71T8wVSqj6GY/NvnqAjJQCBmlOpJIgvzk
        DSh6l38/DaWQrxtOdnubZqg=
X-Google-Smtp-Source: AB8JxZpUbVxPunz2MwB9IFyEoD4qql3GZUzh5EcpaLo3Gadxf6VEBcwPn7+dxaxJHs115rXIC2wN/w==
X-Received: by 10.55.27.97 with SMTP id b94mr21441585qkb.281.1524494455465;
        Mon, 23 Apr 2018 07:40:55 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id d3sm10129376qkf.22.2018.04.23.07.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 07:40:54 -0700 (PDT)
Subject: Re: [PATCH v3 7/9] commit: add short-circuit to
 paint_down_to_common()
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
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
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bd2011f0-41d4-4550-5392-65a3816ed4d3@gmail.com>
Date:   Mon, 23 Apr 2018 10:40:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86bmeggl1m.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2018 7:19 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
[...]
>> [...], and this saves time during 'git branch --contains' queries
>> that would otherwise walk "around" the commit we are inspecting.
> If I understand the code properly, what happens is that we can now
> short-circuit if all commits that are left are lower than the target
> commit.
>
> This is because max-order priority queue is used: if the commit with
> maximum generation number is below generation number of target commit,
> then target commit is not reachable from any commit in the priority
> queue (all of which has generation number less or equal than the commit
> at head of queue, i.e. all are same level or deeper); compare what I
> have written in [1]
>
> [1]: https://public-inbox.org/git/866052dkju.fsf@gmail.com/
>
> Do I have that right?  If so, it looks all right to me.

Yes, the priority queue needs to compare via generation number first or 
there will be errors. This is why we could not use commit time before.

>
>> For a copy of the Linux repository, where HEAD is checked out at
>> v4.13~100, we get the following performance improvement for
>> 'git branch --contains' over the previous commit:
>>
>> Before: 0.21s
>> After:  0.13s
>> Rel %: -38%
> [...]
>>   		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
>>   		if (flags == (PARENT1 | PARENT2)) {
>>   			if (!(commit->object.flags & RESULT)) {
>> @@ -876,7 +886,7 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
>>   			return NULL;
>>   	}
>>   
>> -	list = paint_down_to_common(one, n, twos);
>> +	list = paint_down_to_common(one, n, twos, 0);
>>   
>>   	while (list) {
>>   		struct commit *commit = pop_commit(&list);
>> @@ -943,7 +953,7 @@ static int remove_redundant(struct commit **array, int cnt)
>>   			filled_index[filled] = j;
>>   			work[filled++] = array[j];
>>   		}
>> -		common = paint_down_to_common(array[i], filled, work);
>> +		common = paint_down_to_common(array[i], filled, work, 0);
>>   		if (array[i]->object.flags & PARENT2)
>>   			redundant[i] = 1;
>>   		for (j = 0; j < filled; j++)
>> @@ -1067,7 +1077,7 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
>>   	if (commit->generation > min_generation)
>>   		return 0;
>>   
>> -	bases = paint_down_to_common(commit, nr_reference, reference);
>> +	bases = paint_down_to_common(commit, nr_reference, reference, commit->generation);
> Is it the only case where we would call paint_down_to_common() with
> non-zero last parameter?  Would we always use commit->generation where
> commit is the first parameter of paint_down_to_common()?
>
> If both are true and will remain true, then in my humble opinion it is
> not necessary to change the signature of this function.

We need to change the signature some way, but maybe the way I chose is 
not the best.

To elaborate: paint_down_to_common() is used for multiple purposes. The 
caller here that supplies 'commit->generation' is used only to compute 
reachability (by testing if the flag PARENT2 exists on the commit, then 
clears all flags). The other callers expect the full walk down to the 
common commits, and keeps those PARENT1, PARENT2, and STALE flags for 
future use (such as reporting merge bases). Usually the call to 
paint_down_to_common() is followed by a revision walk that only halts 
when reaching root commits or commits with both PARENT1 and PARENT2 
flags on, so always short-circuiting on generations would break the 
functionality; this is confirmed by the t5318-commit-graph.sh.

An alternative to the signature change is to add a boolean parameter 
"use_cutoff" or something, that specifies "don't walk beyond the 
commit". This may give a more of a clear description of what it will do 
with the generation value, but since we are already performing 
generation comparisons before calling paint_down_to_common() I find this 
simple enough.

Thanks,
-Stolee

