Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB961F42D
	for <e@80x24.org>; Thu, 31 May 2018 13:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755025AbeEaNRD (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 09:17:03 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:45897 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754998AbeEaNRB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 09:17:01 -0400
Received: by mail-qt0-f180.google.com with SMTP id i18-v6so17105965qtp.12
        for <git@vger.kernel.org>; Thu, 31 May 2018 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ho4hQPz/5auXeJe+wQTAkdZL4/3W9AxS4M4op5DKK3g=;
        b=cp9Ps5CsK5CZh5Vb6+suBP9ZiqfMtCSbNh/P864WBT+K7A7SyRSCHH5QR/5X9F8lGV
         QtcX4JMZ2hkxY15a5DApg/udTQ67ocEKy686TR4OmDdhpr5on3fOgv4ZiNX8tV5vkevq
         lwF4Rh5JFhaVeN0UHmpWROTMM4jSnXRXawKdVsD2fcX2HCjGSMkK0gXpJ0JBKCbEDat+
         rXnsqYJah/E82080POnvBhJTMqWJRjqyJSzsKkIoc60mShizSFEujQAKpL0P982WR14e
         wHE1h0O2pSpmYn6DvhXqXa5KkcsaiFebjXLH0yZxUZKn/L+RSJmtBhDJeukvRjVJ1otJ
         WYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ho4hQPz/5auXeJe+wQTAkdZL4/3W9AxS4M4op5DKK3g=;
        b=GmEnkPvNMjdQZ8eOJvqFx37Qr2kXKbNae67IGK2cxkO6+4Eeoh9qw0sVNjMR6kICJv
         CcwuTuezjAwNBKIYgwbBhSwWCZYWeMWPWVUCIjjsM7EvzOrAqo63mqXtok0IwSXxEXvP
         04q9wB28b0RGCpNLkRUQk0SfT9/LxdCcf1It3tp/GrLVdm4TiHPy07j+zi1CVOVJUZLm
         b9cxCkLUJ8FPV+UnZYw6NW5zA1ncti+Nwgw3evocXFgf6C9+bwB+GK4pGbRC547fnzE0
         45Nk/HbKrCpBcfju+4MtxktDaL+mpEPoMKSSjNLLbQA27Au1RdZpiVwjP/z8SKT5viqy
         YgIw==
X-Gm-Message-State: APt69E0TVm/i6OS3gN+bh8p5Ow6VkzKt97sk4iWfnIUOnGAqZH1yljOi
        e/kiD007dWphHOQtKkPK9j8=
X-Google-Smtp-Source: ADUXVKJLXAYQu3QyP5jGhS8lXe+IJyWbw81NPVBklPIIrQLOO2d5dVpuPtWdCMGh6vGptsMIkv/o3w==
X-Received: by 2002:a0c:d1f7:: with SMTP id k52-v6mr6479423qvh.199.1527772620811;
        Thu, 31 May 2018 06:17:00 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2cb8:1b85:8d36:d4f1? ([2001:4898:8010:0:15ee:1b85:8d36:d4f1])
        by smtp.gmail.com with ESMTPSA id b3-v6sm24849529qkd.37.2018.05.31.06.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 06:17:00 -0700 (PDT)
Subject: Re: [PATCH v3 11/20] commit-graph: verify root tree OIDs
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-12-dstolee@microsoft.com> <86zi0gvl1h.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d59f5723-7fb6-56d6-af2b-b8263cfdf354@gmail.com>
Date:   Thu, 31 May 2018 09:16:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <86zi0gvl1h.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/30/2018 6:24 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> The 'verify' subcommand must compare the commit content parsed from the
>> commit-graph and compare it against the content in the object database.
> You have "compare" twice in the above sentence.
>
>> Use lookup_commit() and parse_commit_in_graph_one() to parse the commits
>> from the graph and compare against a commit that is loaded separately
>> and parsed directly from the object database.
> All right, that looks like a nice extension of what was done in previous
> patch.  We want to check that cache (serialized commit graph) matches
> reality (object database).
>
>> Add checks for the root tree OID.
> All right; isn't it that now we check almost all information from
> commit-graph that hs match in object database (with exception of commit
> parents, I think).
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   commit-graph.c          | 17 ++++++++++++++++-
>>   t/t5318-commit-graph.sh |  7 +++++++
>>   2 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 0420ebcd87..19ea369fc6 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -880,6 +880,8 @@ int verify_commit_graph(struct commit_graph *g)
>>   		return verify_commit_graph_error;
> NOTE: we will be checking Commit Data chunk; I think it would be good
> idea to verify that size of Commit Data chunk matches (N * (H + 16) bytes)
> that format gives us, so that we don't accidentally red outside of
> memory if something got screwed up (like number of commits being wrong,
> or file truncated).

This is actually how we calculate 'num_commits' during 
load_commit_graph_one():

     if (last_chunk_id == GRAPH_CHUNKID_OIDLOOKUP)
     {
         graph->num_commits = (chunk_offset - last_chunk_offset)
                              / graph->hash_len;
     }

So, if the chunk doesn't match N*(H+16), we detect this because 
FANOUT[255] != N.

(There is one caveat here: (chunk_offset - last_chunk_offset) may not be 
a multiple of hash_len, and "accidentally" truncate to N in the 
division. I'll add more careful checks for this.)

We also check out-of-bounds offsets in that method.

>
>>   
>>   	for (i = 0; i < g->num_commits; i++) {
>> +		struct commit *graph_commit;
>> +
>>   		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
>>   
>>   		if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
>> @@ -897,6 +899,11 @@ int verify_commit_graph(struct commit_graph *g)
>>   
>>   			cur_fanout_pos++;
>>   		}
>> +
>> +		graph_commit = lookup_commit(&cur_oid);
> So now I see why we add all commits to memory (to hash structure).
>
>> +		if (!parse_commit_in_graph_one(g, graph_commit))
>> +			graph_report("failed to parse %s from commit-graph",
>> +				     oid_to_hex(&cur_oid));
> All right, this verifies that commit in OID Lookup chunk has parse-able
> data in Commit Data chunk, isn't it?
>
>>   	}
>>   
>>   	while (cur_fanout_pos < 256) {
>> @@ -913,16 +920,24 @@ int verify_commit_graph(struct commit_graph *g)
>>   		return verify_commit_graph_error;
>>   
>>   	for (i = 0; i < g->num_commits; i++) {
>> -		struct commit *odb_commit;
>> +		struct commit *graph_commit, *odb_commit;
>>   
>>   		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
>>   
>> +		graph_commit = lookup_commit(&cur_oid);
>>   		odb_commit = (struct commit *)create_object(cur_oid.hash, alloc_commit_node());
> All right, so we have commit data from graph, and commit data from the
> object database.
>
>>   		if (parse_commit_internal(odb_commit, 0, 0)) {
>>   			graph_report("failed to parse %s from object database",
>>   				     oid_to_hex(&cur_oid));
>>   			continue;
>>   		}
>> +
>> +		if (oidcmp(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
>> +			   get_commit_tree_oid(odb_commit)))
>> +			graph_report("root tree OID for commit %s in commit-graph is %s != %s",
>> +				     oid_to_hex(&cur_oid),
>> +				     oid_to_hex(get_commit_tree_oid(graph_commit)),
>> +				     oid_to_hex(get_commit_tree_oid(odb_commit)));
> Maybe explicitly say that it doesn't match the value from the object
> database; OTOH this may be too verbose.
>
>>   	}
>>   
>>   	return verify_commit_graph_error;
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index 996a016239..21cc8e82f3 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -267,6 +267,8 @@ GRAPH_BYTE_FANOUT2=`expr $GRAPH_FANOUT_OFFSET + 4 \* 255`
>>   GRAPH_OID_LOOKUP_OFFSET=`expr $GRAPH_FANOUT_OFFSET + 4 \* 256`
>>   GRAPH_BYTE_OID_LOOKUP_ORDER=`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* 8`
>>   GRAPH_BYTE_OID_LOOKUP_MISSING=`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* 4 + 10`
>> +GRAPH_COMMIT_DATA_OFFSET=`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* $NUM_COMMITS`
>> +GRAPH_BYTE_COMMIT_TREE=$GRAPH_COMMIT_DATA_OFFSET
> All right, so the first is entry into record in Commit Data chunk, and
> the latter points into tree entry in this record -- which entry is first
> field:
>
>    Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
>      * The first H bytes are for the OID of the root tree.
>
>>   
>>   # usage: corrupt_graph_and_verify <position> <data> <string>
>>   # Manipulates the commit-graph file at the position
>> @@ -341,4 +343,9 @@ test_expect_success 'detect OID not in object database' '
>>   		"from object database"
>>   '
>>   
>> +test_expect_success 'detect incorrect tree OID' '
>> +	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_TREE "\01" \
>> +		"root tree OID for commit"
>> +'
> All right.
>
> I wonder if we can create a test for first check added (that Commit
> Graph data parses correctly), that is the one with the following error
> message:
>
>    "failed to parse <OID> from commit-graph file".
>
>> +
>>   test_done
> Regards,

