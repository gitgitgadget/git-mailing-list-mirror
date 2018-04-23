Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A461F424
	for <e@80x24.org>; Mon, 23 Apr 2018 14:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755281AbeDWOW0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 10:22:26 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36991 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755184AbeDWOWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 10:22:25 -0400
Received: by mail-qt0-f196.google.com with SMTP id w12-v6so17826916qti.4
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zo5Aq+8gRTMZ3x3FWgrs1ZqjN+1ucZrK9/3dKMmURNg=;
        b=qWZuXB2LnC5L06IvP/o9/RlEorB5WHnUVx+1Xr6a1H55zCaXIVetBUS0kuE6s9r+25
         mig/SLvOjYWjrjN7YxgreAXtuJmY4+eGKpBtRLMBIG4dvJ2QTc8P79y4WJLejv6PSG12
         99FLOyS9IUJhIyKM5f9cNqbWeSEW2mrlm5onY0JPK1VMRJe5G5LmX52KWr1pMOoiNzOm
         XJ7eC5C9yhd9SXR67E80q/+VxmXJwCtVHQGYNodQb1cw+eNtej7EkSCVAJeKh2eUG8sQ
         SgAbxYydZSWfmaOVrTYQWvtjHZk14zr6y2xr9xryp9Uj+BX60fqbd3gOF2/lMqgaZl2i
         8SOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zo5Aq+8gRTMZ3x3FWgrs1ZqjN+1ucZrK9/3dKMmURNg=;
        b=pQYEUecEAWA+68nKM3R/F7pDA/Z5qBuJhQUAZZ8/Ai1/nINrqVF3SAQJNVbYxos3gk
         MOje5P0MJmlX12UPI6ldZ4NVbfChoOOrTT8/d1sgMi6PryvzE/Z6FPehWYv4jvc0spOD
         yv67tRjYEt0uRkwPho9LeIlci2A8jCLO5C6rAyhzvFd0dJJBRQPP+ljc11x/48uRP4xu
         NfKC1X8JTcNd6oIEGBaTmM+3lofsRw/rAQRd+5C00WP/EfAFA3FUaHHD+TBzSykkIVN/
         gsb9HlFOTqvB2Vo5u7let5h8X5tuTRMP8b9x41Y3Gq/IpoIFAgI2ANlGe/CMNC7T+9R7
         ARjg==
X-Gm-Message-State: ALQs6tA82wMwCcq6FCYd76jbwZr2peq1AXUPjmKPwm5ixYOEqaNv3a9l
        B2eQKjmwrFGzvhOgd3B3Reg=
X-Google-Smtp-Source: AB8JxZqbxlFYverTNcur1SQI+aAbpKFrVtEn8TVaD6fM0+eRqy35lVy79jmh/OWdu52ztfTB4oGZ1A==
X-Received: by 10.12.178.148 with SMTP id r20mr1786222qve.9.1524493344227;
        Mon, 23 Apr 2018 07:22:24 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 1-v6sm11392752qtr.85.2018.04.23.07.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 07:22:23 -0700 (PDT)
Subject: Re: [PATCH v3 5/9] ref-filter: use generation number for --contains
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
References: <20180409164131.37312-1-dstolee@microsoft.com>
 <20180417170001.138464-1-dstolee@microsoft.com>
 <20180417170001.138464-6-dstolee@microsoft.com> <86r2ncgrcs.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <48f910b6-8762-f34b-b644-d6c7ff99499f@gmail.com>
Date:   Mon, 23 Apr 2018 10:22:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86r2ncgrcs.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2018 5:02 PM, Jakub Narebski wrote:
> Here I can offer only the cursory examination, as I don't know this area
> of code in question.
>
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> A commit A can reach a commit B only if the generation number of A
>> is larger than the generation number of B. This condition allows
>> significantly short-circuiting commit-graph walks.
>>
>> Use generation number for 'git tag --contains' queries.
>>
>> On a copy of the Linux repository where HEAD is containd in v4.13
>> but no earlier tag, the command 'git tag --contains HEAD' had the
>> following peformance improvement:
>>
>> Before: 0.81s
>> After:  0.04s
>> Rel %:  -95%
> A question: what is the performance after if the "commit-graph" feature
> is disabled, or there is no commit-graph file?  Is there performance
> regression in this case, or is the difference negligible?

Negligible, since we are adding a small number of integer comparisons 
and the main cost is in commit parsing. More on commit parsing in 
response to your comments below.

>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   ref-filter.c | 23 +++++++++++++++++++----
>>   1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index cffd8bf3ce..e2fea6d635 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1587,7 +1587,8 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
>>   /*
>>    * Test whether the candidate or one of its parents is contained in the list.
>                                   ^^^^^^^^^^^^^^^^^^^^^
>
> Sidenote: when examining the code after the change, I have noticed that
> the above part of commit header for the comtains_test() function is no
> longer entirely correct, as the function only checks the candidate
> commit, and in no place it access its parents.
>
> But that is not your problem.

I'll add a commit in the next version that fixes this comment before I 
make any changes to the method.

>
>>    * Do not recurse to find out, though, but return -1 if inconclusive.
>>    */
>>   static enum contains_result contains_test(struct commit *candidate,
>>   					  const struct commit_list *want,
>> -					  struct contains_cache *cache)
>> +					  struct contains_cache *cache,
>> +					  uint32_t cutoff)
>>   {
>>   	enum contains_result *cached = contains_cache_at(cache, candidate);
>>   
>> @@ -1603,6 +1604,10 @@ static enum contains_result contains_test(struct commit *candidate,
>>   
>>   	/* Otherwise, we don't know; prepare to recurse */
>>   	parse_commit_or_die(candidate);
>> +
>> +	if (candidate->generation < cutoff)
>> +		return CONTAINS_NO;
>> +
> Looks good to me.
>
> The only [minor] question may be whether to define separate type for
> generation numbers, and whether to future proof the tests - though the
> latter would be almost certainly overengineering, and the former
> probablt too.

If we have multiple notions of generation, then we can refactor all 
references to the "generation" member.

>
>>   	return CONTAINS_UNKNOWN;
>>   }
>>   
>> @@ -1618,8 +1623,18 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>>   					      struct contains_cache *cache)
>>   {
>>   	struct contains_stack contains_stack = { 0, 0, NULL };
>> -	enum contains_result result = contains_test(candidate, want, cache);
>> +	enum contains_result result;
>> +	uint32_t cutoff = GENERATION_NUMBER_INFINITY;
>> +	const struct commit_list *p;
>> +
>> +	for (p = want; p; p = p->next) {
>> +		struct commit *c = p->item;
>> +		parse_commit_or_die(c);
>> +		if (c->generation < cutoff)
>> +			cutoff = c->generation;
>> +	}
> Sholdn't the above be made conditional on the ability to get generation
> numbers from the commit-graph file (feature is turned on and file
> exists)?  Otherwise here after the change contains_tag_algo() now parses
> each commit in 'want', which I think was not done previously.
>
> With commit-graph file parsing is [probably] cheap.  Without it, not
> necessary.
>
> But I might be worrying about nothing.

Not nothing. This parses the "wants" when we previously did not parse 
the wants. Further: this parsing happens before we do the simple check 
of comparing the OID of the candidate against the wants.

The question is: are these parsed commits significant compared to the 
walk that will parse many more commits? It is certainly possible.

One way to fix this is to call 'prepare_commit_graph()' directly and 
then test that 'commit_graph' is non-null before performing any parses. 
I'm not thrilled with how that couples the commit-graph implementation 
to this feature, but that may be necessary to avoid regressions in the 
non-commit-graph case.

>
>>   
>> +	result = contains_test(candidate, want, cache, cutoff);
> Other than the question about possible performace regression if
> commit-graph data is not available, it looks good to me.
>
>>   	if (result != CONTAINS_UNKNOWN)
>>   		return result;
>>   
>> @@ -1637,7 +1652,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>>   		 * If we just popped the stack, parents->item has been marked,
>>   		 * therefore contains_test will return a meaningful yes/no.
>>   		 */
>> -		else switch (contains_test(parents->item, want, cache)) {
>> +		else switch (contains_test(parents->item, want, cache, cutoff)) {
>>   		case CONTAINS_YES:
>>   			*contains_cache_at(cache, commit) = CONTAINS_YES;
>>   			contains_stack.nr--;
>> @@ -1651,7 +1666,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>>   		}
>>   	}
>>   	free(contains_stack.contains_stack);
>> -	return contains_test(candidate, want, cache);
>> +	return contains_test(candidate, want, cache, cutoff);
> Simple change. It looks good to me.
>
>>   }
>>   
>>   static int commit_contains(struct ref_filter *filter, struct commit *commit,

