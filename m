Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381A51F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 12:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeJLUFE (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 16:05:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44998 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbeJLUFE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 16:05:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id c56-v6so13588943qtd.11
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 05:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2J7DKUccxPf7QmdkRJ67vBEwnhd8UX9xFUrIwt/FK90=;
        b=abjXmisO5uHjlOqHbwtTgzKYKB2sk3zbkPXXbPaHJQZtwMlC7OxK2yk28fE8p3QWNn
         7Y170/SdnlQXhareM36Vq+rkbLtCwa/ARX4sv3t7eRtlV8aLt/i9FT77mW82Ie5LAtja
         uzn/O7L/BPC1Tme3A3T2lP908aONtbk6azzYIU9R5O4biKTf4Mccmt/ivNjdhuFlxzED
         4R786+AnkfwKrm8AGtM5RV5UL2of0wrIbKz6a27yPFqJnWSN7pCRZSIKR+UhT2WrLI/l
         rFcl3ukaLbNfkDWAWVuIbyzQcAD/31CdAsM5fpxNzWrvQk+7Vfype2THtVb83uNf2grQ
         TWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2J7DKUccxPf7QmdkRJ67vBEwnhd8UX9xFUrIwt/FK90=;
        b=AptHCBFNUREUBeK0bh2sNcVgHiK4MF3HEWRbpTIKIxVh9PvW0xIEiIaeJoOC1/PWRg
         u4ZEY7DJpi6MIIE2ztycjyrvzlztD/ehaXnSP4UNHOm96pKSZD+CuYEpghr8wvIcZc3z
         sRq/ZR/3dHUGyERoFEEigWe9+VVdA3kVJU4lhan7eZ9FwHRvNM5oJJGVUOTMPfCDkkHr
         lsFgumGf0i/5wFh9ZtZwu82riqXU6WAb2zQTZ9JTGnM/MHai8D9XLzPN49G22YeFCP7o
         UVc75GduCqohi/5Sq4A9ywLirJCNBO3gMpLCqsoe4/0gwiN55xrXhTiPpdn3AqJ5S8h4
         D7aw==
X-Gm-Message-State: ABuFfoijAeMvwAqV26Dc6c15fy2pARTjX9OiCty5T9haBiH5mut/mEdT
        t6vSvVPtaRArfq7omxYCooM=
X-Google-Smtp-Source: ACcGV606FHSoQyCF5Vd04HSHcPHE2YDXQ8XOu/z4cIJRCFDBXITv8uwf21S5lqj3foK2/xziITt/iA==
X-Received: by 2002:a0c:b49d:: with SMTP id c29-v6mr5853606qve.75.1539347567169;
        Fri, 12 Oct 2018 05:32:47 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:e9ec:1ddb:856c:2858? ([2001:4898:8010:0:d322:1ddb:856c:2858])
        by smtp.gmail.com with ESMTPSA id m2-v6sm419597qkg.92.2018.10.12.05.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 05:32:46 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] revision.c: begin refactoring --topo-order logic
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
 <pull.25.v3.git.gitgitgadget@gmail.com>
 <fd1a0ab7cdaa06fd99f86fec51b483238f588296.1537551564.git.gitgitgadget@gmail.com>
 <xmqqwoqnbrmw.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0407d50d-aabd-e85e-3c48-f6b6678f9884@gmail.com>
Date:   Fri, 12 Oct 2018 08:32:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqwoqnbrmw.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2018 2:33 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> * revs->limited implies we run limit_list() to walk the entire
>>    reachable set. There are some short-cuts here, such as if we
>>    perform a range query like 'git rev-list COMPARE..HEAD' and we
>>    can stop limit_list() when all queued commits are uninteresting.
>>
>> * revs->topo_order implies we run sort_in_topological_order(). See
>>    the implementation of that method in commit.c. It implies that
>>    the full set of commits to order is in the given commit_list.
>>
>> These two methods imply that a 'git rev-list --topo-order HEAD'
>> command must walk the entire reachable set of commits _twice_ before
>> returning a single result.
> With or without "--topo-order", running rev-list without any
> negative commit means we must dig down to the roots that can be
> reached from the positive commits we have.
If we use default order in 'git log', we don't walk all the way to the 
root commits, and instead trust the commit-date. (This is different than 
--date-order, which does guarantee parents after children.) In this 
case, revs->limited is false.
> I am to sure if having to run the "sort" of order N counts as "walk
> the entire reachable set once" (in addition to the enumeration that
> must be done to prepare that N commits, performed in limit_list()).

sort_in_topological_order() does actually _two_ walks (the in-degree 
computation plus the walk that peels commits of in-degree zero), but 
those walks are cheaper because we've already parsed the commits in 
limit_list().
>> 3. expand_topo_walk() provides get_revision_1() with a way to signal
>>     walking beyond the latest commit. Currently, this calls
>>     add_parents_to_list() exactly like the old logic.
> "latest"?  We dig down the history from newer to older, so at some
> point we hit an old commit and need to find the parents to keep
> walking towards even older parts of the history.  Did you mean
> "earliest" instead?
I mean "latest" in terms of the algorithm, so "the commit that was 
returned by get_revision_1() most recently". This could use some 
rewriting for clarity.
>>   
>> @@ -2454,7 +2455,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>>   	if (revs->diffopt.objfind)
>>   		revs->simplify_history = 0;
>>   
>> -	if (revs->topo_order)
>> +	if (revs->topo_order && !generation_numbers_enabled(the_repository))
>>   		revs->limited = 1;
> Are we expecting that this is always a bool?  Can there be new
> commits for which generation numbers are not computed and stored
> while all the old, stable and packed commits have generation
> numbers?

For this algorithm to work, we only care that _some_ commits have 
generation numbers. We expect that if a commit-graph file exists with 
generation numbers, then the majority of commits have generation 
numbers. The commits that were added or fetched since the commit-graph 
was written will have generation number INFINITY, but the topo-order 
algorithm will still work and be efficient in those cases. (This is also 
why we have the "half graph" case in test_three_modes.)

>> @@ -2892,6 +2893,33 @@ static int mark_uninteresting(const struct object_id *oid,
>>   	return 0;
>>   }
>>   
>> +struct topo_walk_info {};
>> +
>> +static void init_topo_walk(struct rev_info *revs)
>> +{
>> +	struct topo_walk_info *info;
>> +	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));
>> +	info = revs->topo_walk_info;
>> +	memset(info, 0, sizeof(struct topo_walk_info));
> There is no member in the struct at this point.  Are we sure this is
> safe?  Just being curious.  I know xmalloc() gives us at least one
> byte and info won't be NULL.  I just do not know offhand if we have
> a guarantee that memset() acts sensibly to fill the first 0 bytes.
This is a good question. It seems to work for me when I check out your 
version of this commit (6c04ff30 "revision.c: begin refactoring 
--topo-order logic") and run all tests.
>> +	limit_list(revs);
>> +	sort_in_topological_order(&revs->commits, revs->sort_order);
>> +}
>> +
>> +static struct commit *next_topo_commit(struct rev_info *revs)
>> +{
>> +	return pop_commit(&revs->commits);
>> +}
>> +
>> +static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
>> +{
>> +	if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
>> +		if (!revs->ignore_missing_links)
>> +			die("Failed to traverse parents of commit %s",
>> +			    oid_to_hex(&commit->object.oid));
>> +	}
>> +}
>> +
>>   int prepare_revision_walk(struct rev_info *revs)
>>   {
>>   	int i;
>> @@ -2928,11 +2956,13 @@ int prepare_revision_walk(struct rev_info *revs)
>>   		commit_list_sort_by_date(&revs->commits);
>>   	if (revs->no_walk)
>>   		return 0;
>> -	if (revs->limited)
>> +	if (revs->limited) {
>>   		if (limit_list(revs) < 0)
>>   			return -1;
>> -	if (revs->topo_order)
>> -		sort_in_topological_order(&revs->commits, revs->sort_order);
>> +		if (revs->topo_order)
>> +			sort_in_topological_order(&revs->commits, revs->sort_order);
>> +	} else if (revs->topo_order)
>> +		init_topo_walk(revs);
>>   	if (revs->line_level_traverse)
>>   		line_log_filter(revs);
>>   	if (revs->simplify_merges)
> The diff is a bit hard to grok around here, but
>
>   - when limited *and* topo_order, we do the sort here, as we know we
>     already have called limit_list(), i.e. we behave identically as
>     the code before this patch in that case.
>
>   - when not limited but topo_order, then we do init_topo_walk();
>     currently we do limit_list() and sort_in_topological_order(),
>     which means we do the same as above.
>
> As long as limit_list() and sort_in_topological_order() does not
> look at revs->limited bit, this patch cannot cause any regression.
>
>> @@ -3257,6 +3287,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
>>   
>>   		if (revs->reflog_info)
>>   			commit = next_reflog_entry(revs->reflog_info);
>> +		else if (revs->topo_walk_info)
>> +			commit = next_topo_commit(revs);
>>   		else
>>   			commit = pop_commit(&revs->commits);
> So this get_revision_1() always grabs the commit from next_topo_commit()
> when topo-order is in effect.
And specifically, when the conditions for our new topo-walk algorithm 
are in effect. If the commit-graph doesn't exist, the old logic will 
still go through for "git log --topo-order".

Thanks for the careful look!
-Stolee
