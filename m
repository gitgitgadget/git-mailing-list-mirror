Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F8621841
	for <e@80x24.org>; Tue,  1 May 2018 11:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754856AbeEALrF (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:47:05 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39218 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754662AbeEALrD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:47:03 -0400
Received: by mail-qt0-f193.google.com with SMTP id f1-v6so14266565qtj.6
        for <git@vger.kernel.org>; Tue, 01 May 2018 04:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=J044jSdMzQCITzEgf+nhMbi5Z93NgAWX4Qn/eN/NAFE=;
        b=QfkE+sWYNrAkC205BnRfobgK+bNUVUxJ/YI09XU1iW1Dn3hqjgB123FamL3vjGmFih
         h+e9WVlBOOBAC38JZSEbZwH9LiYlYFnIyJARlN60GjQGqH1brD47JFstkXMKh6l+/fht
         2jxmO4xMtIoqsAfGE6/QKyUBAt/8Fzttpqpps3bvMltf+3yidxRIGrjwZy6rE5XZdVGU
         tF+lTtmpctxO3DGwd4chJDcjWhivF2PlZcxpAjJWMeLiR6sVMaRLFMCdpdCXPzB4lxzi
         h/MwcylqBPXpzMQHaPEYaTN4izW0EOwt53nhtrdZn6tOkhrMJ7t1D6ujz1xEHCBaH0YZ
         rAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=J044jSdMzQCITzEgf+nhMbi5Z93NgAWX4Qn/eN/NAFE=;
        b=o97p0Slrr1T3wkTlv3UUpz36FcySiWmmgXzhJG4/BmHzjiwusALzi+QJGVUmZYBmTi
         FJNh/ZtJWgt2DDdMc2BMHlvUl23qp0qYP7kEQjNJus2l8aofamyI+YOTJk5aCgq6iKdS
         ZeUXObEnUIsMu4RAsUs+5j0P6CDNSB3hpOaAqH5JrXx7g8YSMI6eKKwAvhc1DrHrRFSp
         t7tjCXU0StzKyvMhYgMcILsf/m3yyuXYHYdefwC/u7tgfUMbptSaY/hjvfzsYAObiZd3
         2LTHzQ+QNA0x3xCUq8UKFpf5QWC9OfMDtRTUu3bXJQe92TJLmgirJpVjnitimtiAlRtE
         Up1g==
X-Gm-Message-State: ALQs6tAZ1TpxMRVZSkEuXpfCkURsu8QQaagT6CxgZm7MqUxYL+tq7OFx
        Fnnciavw4sHYrPUUFOwDn24=
X-Google-Smtp-Source: AB8JxZrPTqgygiL0bvQtrs2KfepTD8pl1vU2CkNXPHm4aSCiO/y9B6r3eHKSa5EJtgiOH7aLkeXFpQ==
X-Received: by 2002:a0c:bed1:: with SMTP id f17-v6mr10332370qvj.18.1525175222879;
        Tue, 01 May 2018 04:47:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id n64sm7020346qkc.56.2018.05.01.04.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 04:47:02 -0700 (PDT)
Subject: Re: [PATCH v4 08/10] commit: add short-circuit to
 paint_down_to_common()
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
 <20180425143735.240183-1-dstolee@microsoft.com>
 <20180425143735.240183-9-dstolee@microsoft.com> <864ljsgwx1.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3e3ae7e4-9efd-3046-c0c2-7b3bf12d0d81@gmail.com>
Date:   Tue, 1 May 2018 07:47:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <864ljsgwx1.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/30/2018 6:19 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> When running 'git branch --contains', the in_merge_bases_many()
>> method calls paint_down_to_common() to discover if a specific
>> commit is reachable from a set of branches. Commits with lower
>> generation number are not needed to correctly answer the
>> containment query of in_merge_bases_many().
>>
>> Add a new parameter, min_generation, to paint_down_to_common() that
>> prevents walking commits with generation number strictly less than
>> min_generation. If 0 is given, then there is no functional change.
> This is thanks to the fact that generation numbers start at zero (as
> special case, though, with _ZERO), and we use strict inequality to avoid
> handling _ZERO etc. in a special way.
>
> As you wrote in response in previous version of this series, because
> paint_down_to_common() is file-local, there is no need to come up with
> symbolic name for GENERATION_NO_CUTOFF case.
>
> All right.
>
>> For in_merge_bases_many(), we can pass commit->generation as the
>> cutoff, and this saves time during 'git branch --contains' queries
>> that would otherwise walk "around" the commit we are inspecting.
> All right, and when using paint_down_to_common() to actually find merge
> bases, and not only check for containment, we cannot use cutoff.
> Therefore at least one call site needs to run it without functional
> change... which we can do.  Good.
>
>> For a copy of the Linux repository, where HEAD is checked out at
>> v4.13~100, we get the following performance improvement for
>> 'git branch --contains' over the previous commit:
>>
>> Before: 0.21s
>> After:  0.13s
>> Rel %: -38%
> Nice.
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   commit.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
> Let me reorder chunks a bit to make it easier to review.
>
>> diff --git a/commit.c b/commit.c
>> index 7bb007f56a..e2e16ea1a7 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -1070,7 +1080,7 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
>>   	if (commit->generation > min_generation)
>>   		return ret;
>>   
>> -	bases = paint_down_to_common(commit, nr_reference, reference);
>> +	bases = paint_down_to_common(commit, nr_reference, reference, commit->generation);
>>   	if (commit->object.flags & PARENT2)
>>   		ret = 1;
>>   	clear_commit_marks(commit, all_flags);
>> @@ -808,11 +808,14 @@ static int queue_has_nonstale(struct prio_queue *queue)
>>   }
>>   
>>   /* all input commits in one and twos[] must have been parsed! */
>> -static struct commit_list *paint_down_to_common(struct commit *one, int n, struct commit **twos)
>> +static struct commit_list *paint_down_to_common(struct commit *one, int n,
>> +						struct commit **twos,
>> +						int min_generation)
>>   {
>>   	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>>   	struct commit_list *result = NULL;
>>   	int i;
>> +	uint32_t last_gen = GENERATION_NUMBER_INFINITY;
>>   
>>   	one->object.flags |= PARENT1;
>>   	if (!n) {
>> @@ -831,6 +834,13 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
>>   		struct commit_list *parents;
>>   		int flags;
>>   
>> +		if (commit->generation > last_gen)
>> +			BUG("bad generation skip");
>> +		last_gen = commit->generation;
> Shouldn't we provide more information about where the problem is to the
> user, to make it easier to debug the repository / commit-graph data?
>
> Good to have this sanity check here.

This BUG() _should_ only be seen by developers who add callers which do 
not load commits from the commit-graph file. There is a chance that 
there are cases not covered by this patch and the added tests, though. 
Hopefully we catch them all by dogfooding the feature before turning it 
on by default.

I can add the following to help debug these bad situations:

+			BUG("bad generation skip %d > %d at %s",
+			    commit->generation, last_gen,
+			    oid_to_hex(&commit->object.oid));



>
>> +
>> +		if (commit->generation < min_generation)
>> +			break;
> So the reasoning for this, as far as I understand, is the following.
> Please correct me if I am wrong.
>
> The callsite with non-zero min_generation, in_merge_bases_many(), tries
> to find out if "commit" is an ancestor of one of the "references".  At
> least one of "references" is above "commit", so in_merge_bases_many()
> uses paint_down_to_common() - but is interested only if "commit" was
> painted as reachable from one of "references".
>
> Thus we can interrupt the walk if we know that none of [considered]
> commits in the queue can reach "commit"/"one" - as if they were all
> STALE.
>
> The search is done using priority queue (a bit like in Dijkstra
> algorithm), with newer commits - with larger generation numbers -
> considered first.  Thus if current commit has generation number less
> than min_generation cutoff, i.e. if it is below "commit", then all
> remaining commits in the queue are below cutoff.
>
> Good.
>
>> +
>>   		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
>>   		if (flags == (PARENT1 | PARENT2)) {
>>   			if (!(commit->object.flags & RESULT)) {
>> @@ -879,7 +889,7 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
>>   			return NULL;
>>   	}
>>   
>> -	list = paint_down_to_common(one, n, twos);
>> +	list = paint_down_to_common(one, n, twos, 0);
> When calculating merge bases there is no such possibility of an early
> return due to generation number cutoff.  All right then.
>
>>   
>>   	while (list) {
>>   		struct commit *commit = pop_commit(&list);
>> @@ -946,7 +956,7 @@ static int remove_redundant(struct commit **array, int cnt)
>>   			filled_index[filled] = j;
>>   			work[filled++] = array[j];
>>   		}
>> -		common = paint_down_to_common(array[i], filled, work);
>> +		common = paint_down_to_common(array[i], filled, work, 0);
> Here we are interested not only if "one"/array[i] is reachable from
> "twos"/work, but also if "twos" is reachable from "one".  Simple cutoff
> only works in one way, though I wonder if we couldn't use cutoff being
> minimum generation number of "one" and "twos" together.
>
> But that may be left for a separate commit (after checking that the
> above is correct).
>
> Not as simple and obvious as paint_down_to_common() used in
> in_merge_bases_any(), so it is all right.

Thanks for reporting this. Since we are only concerned about 
reachability in this method, it is a good candidate to use 
min_generation. It is also subtle enough that we should leave it as a 
separate commit. Also, we can measure performance improvements 
separately, as I will mention in my commit message (but I'll copy it here):

     For a copy of the Linux repository, we measured the following
     performance improvements:

     git merge-base v3.3 v4.5

     Before: 234 ms
      After: 208 ms
      Rel %: -11%

     git merge-base v4.3 v4.5

     Before: 102 ms
      After:  83 ms
      Rel %: -19%

     The experiments above were chosen to demonstrate that we are
     improving the filtering of the merge-base set. In the first
     example, more time is spent walking the history to find the
     set of merge bases before the remove_redundant() call. The
     starting commits are closer together in the second example,
     therefore more time is spent in remove_redundant(). The relative
     change in performance differs as expected.


>
>>   		if (array[i]->object.flags & PARENT2)
>>   			redundant[i] = 1;
>>   		for (j = 0; j < filled; j++)

