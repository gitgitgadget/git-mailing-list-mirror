Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74BB1F42D
	for <e@80x24.org>; Wed, 30 May 2018 16:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeE3QSa (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 12:18:30 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:41987 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeE3QS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 12:18:29 -0400
Received: by mail-qt0-f169.google.com with SMTP id c2-v6so23955615qtn.9
        for <git@vger.kernel.org>; Wed, 30 May 2018 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VCzH44kybruoWd1DxRCkFsDtaOsGuVeuvKR8b64P/Pg=;
        b=T6bQQekaPK+oP0nk5ZG15O5R25LMbP1Bm1uVk0V45gSgEuQtaR6nKKoe7af9gKHGKf
         qwjRpPCTLRAjeirIMUcx5M0pUDSS89BcifPAblvDrOTVlSuL3ezaQpmchGJ9eqzcWu0R
         vZvGIN6rkL+TKZQGiRqnrbfK7ttIPg/bJeJjxGwoo17+igAr3IbKIKIgi71U6qMHFXzb
         9oM35NTWcvWpe56BPZhEn5VH1UW3FGgmA7LFfhrx7KEYGMotvIsqBLfHbnHxvm7j8ygO
         uQSqgcIXRW3TQbjOydGJEM42kAj17fpF2mhI91Z4Hc15ThyVm9fBd6tBktCYESOEmSTP
         WxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VCzH44kybruoWd1DxRCkFsDtaOsGuVeuvKR8b64P/Pg=;
        b=C9njghlDMXPJ5oyetTyg9Izaab0SefO/U7vDlaupHhQXUSKHNmuDyYfjD0MldHVnmT
         BgqR3GyxWmZ+cP9EGtmw8qLb997JyMiD35isXFHWwPr3ZHfNlfgz+eILaN0LMcBj9uA1
         d/NLelP9uTPnseu+UFH5BwbfhEDZiHFAc21GWjKwe7ccIk9EXM/+lq9Ztd21bO+oB1Ff
         phm581+Y96VQitVz9/NHDIydqy51hEghXQgGR3NgMxtsq7mXEd5+2lv+6QqJi5mP46J1
         JyO9Dfi/IaZ18xeNPEZIBOmagpILK6hI7zf3XHPIJIOTIOQjcgm5tfAeB0APIR3WexU9
         3jKw==
X-Gm-Message-State: APt69E1Jpg9UTU1eZw+5Cm55ZoJVLGwdskN1FUrHak0KrO7ebTLKFhgn
        CvH7IYStVo/fMCD7WKlxmuA=
X-Google-Smtp-Source: ADUXVKK7Ra7CSqdnQba629lTvPvw9Vavuj0dXdUj3b2r90g3Vp5O/AcUafs3Lf4Gd1Yg61Hq/dm+dw==
X-Received: by 2002:a0c:e211:: with SMTP id q17-v6mr3163149qvl.240.1527697108856;
        Wed, 30 May 2018 09:18:28 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id x186-v6sm25461127qkc.10.2018.05.30.09.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 09:18:28 -0700 (PDT)
Subject: Re: [PATCH v3 09/20] commit-graph: verify corrupt OID fanout and
 lookup
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-10-dstolee@microsoft.com> <86in75w9m9.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b34afb39-8df2-b825-773c-8526d93314b5@gmail.com>
Date:   Wed, 30 May 2018 12:18:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <86in75w9m9.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 5/30/2018 9:34 AM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> In the commit-graph file, the OID fanout chunk provides an index into
>> the OID lookup. The 'verify' subcommand should find incorrect values
>> in the fanout.
>>
>> Similarly, the 'verify' subcommand should find out-of-order values in
>> the OID lookup.
> O.K., the OID Lookup chunk is checked together with OID Fanout chunk
> because those two chunks are tightly connected: OID Fanout is fanout
> into OID Lookup.
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   commit-graph.c          | 36 ++++++++++++++++++++++++++++++++++++
>>   t/t5318-commit-graph.sh | 22 ++++++++++++++++++++++
>>   2 files changed, 58 insertions(+)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 06e3e4f9ba..cbd1aae514 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -855,6 +855,9 @@ static void graph_report(const char *fmt, ...)
>>   
>>   int verify_commit_graph(struct commit_graph *g)
>>   {
>> +	uint32_t i, cur_fanout_pos = 0;
>> +	struct object_id prev_oid, cur_oid;
> Minor nitpick about the naming convention: why cur_*, and not curr_*?
>
>> +
>>   	if (!g) {
>>   		graph_report("no commit-graph file loaded");
>>   		return 1;
>> @@ -869,5 +872,38 @@ int verify_commit_graph(struct commit_graph *g)
>>   	if (!g->chunk_commit_data)
>>   		graph_report("commit-graph is missing the Commit Data chunk");
>>   
>> +	if (verify_commit_graph_error)
>> +		return verify_commit_graph_error;
>> +
> Before checking that commits in OID Lookup are sorted, and that OID
> Fanout correctly points into OID Lookup (thus also checking that OID
> Lookup is sorted), it would be good to verify that sizes of those chunks
> are correct.
>
> Out of 4 standrd chunks, 1 of them (OIDF) has constant size, and 2 of
> them have size given by number of commits and hash size
>   - OID Fanout is (256 * 4 bytes)
>   - OID Lookup is (N * H bytes),
>     where N is number of commits, and H is hash size
>
> The one that is more significant is if number of commits gets corrupted
> upwards, and walking through OID Lookup would lead us out of bounds,
> outside the file size.
>
> IIRC we have checked that all chunks fit within file size, isn't it?
>
>> +	for (i = 0; i < g->num_commits; i++) {
>> +		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
> Why do you use hashcpy() here, but oidcpy() below?

We are copying from a section of binary data, not from a struct object_id *.

>
>> +
>> +		if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
> All right, OIDs needs to be sorted in ascending lexicographical order,
> and the above condition checks that this constraint is fullfilled.
>
>> +			graph_report("commit-graph has incorrect OID order: %s then %s",
>> +				     oid_to_hex(&prev_oid),
>> +				     oid_to_hex(&cur_oid));
> Nice informative error message.
>
>> +
>> +		oidcpy(&prev_oid, &cur_oid);
>> +
>> +		while (cur_oid.hash[0] > cur_fanout_pos) {
>> +			uint32_t fanout_value = get_be32(g->chunk_oid_fanout + cur_fanout_pos);
>> +			if (i != fanout_value)
>> +				graph_report("commit-graph has incorrect fanout value: fanout[%d] = %u != %u",
>> +					     cur_fanout_pos, fanout_value, i);
>> +
>> +			cur_fanout_pos++;
>> +		}
> The k-th entry of fanout, F[k], stores the number of OIDs with first
> byte at most k.
>
> Let's examine it in detail on a simple example:
>
>     fanout                     lookup
>     ------                     ------
>     0 : 0  ---------------> 0: 1xxxx....
>     1 : 2  -----\           1: 1yyyy....
>     2 : 2  ------\--------> 2: 3xxxx....
>     3 : 3  ---------------> 3: 4xxxx....
>
> We are checking that after most significant byte (first byte) changes,
> then all fanout position up to the current first byte value (exclusive)
> point to current position in OID Lookup chunk.
>
> Seems all right; it would be nice to come up with rigorous proof that it
> is all right.
>
>> +	}
>> +
>> +	while (cur_fanout_pos < 256) {
>> +		uint32_t fanout_value = get_be32(g->chunk_oid_fanout + cur_fanout_pos);
>> +
>> +		if (g->num_commits != fanout_value)
>> +			graph_report("commit-graph has incorrect fanout value: fanout[%d] = %u != %u",
>> +				     cur_fanout_pos, fanout_value, i);
>> +
>> +		cur_fanout_pos++;
>> +	}
> All right, this checks that all remaining fanout entries, up and
> including the 255-ith entry store the total number of commits, N.
>
>> +
>>   	return verify_commit_graph_error;
>>   }
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index 4ef3fe3dc2..c050ef980b 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -247,6 +247,7 @@ test_expect_success 'git commit-graph verify' '
>>   	git commit-graph verify >output
>>   '
>>   
>> +HASH_LEN=20
>>   GRAPH_BYTE_VERSION=4
>>   GRAPH_BYTE_HASH=5
>>   GRAPH_BYTE_CHUNK_COUNT=6
>> @@ -258,6 +259,12 @@ GRAPH_BYTE_OID_LOOKUP_ID=`expr $GRAPH_CHUNK_LOOKUP_OFFSET + \
>>   			      1 \* $GRAPH_CHUNK_LOOKUP_WIDTH`
>>   GRAPH_BYTE_COMMIT_DATA_ID=`expr $GRAPH_CHUNK_LOOKUP_OFFSET + \
>>   				2 \* $GRAPH_CHUNK_LOOKUP_WIDTH`
>> +GRAPH_FANOUT_OFFSET=`expr $GRAPH_CHUNK_LOOKUP_OFFSET + \
>> +			  $GRAPH_CHUNK_LOOKUP_WIDTH \* $GRAPH_CHUNK_LOOKUP_ROWS`
>> +GRAPH_BYTE_FANOUT1=`expr $GRAPH_FANOUT_OFFSET + 4 \* 4`
>> +GRAPH_BYTE_FANOUT2=`expr $GRAPH_FANOUT_OFFSET + 4 \* 255`
>> +GRAPH_OID_LOOKUP_OFFSET=`expr $GRAPH_FANOUT_OFFSET + 4 \* 256`
>> +GRAPH_BYTE_OID_LOOKUP_ORDER=`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* 8`
> Something that I forgot to write about in previous patch.
>
> POSIX shell includes $(( ... )) for arithmetic expansion, there is
> nowadays no need to use $(expr ...), and even more no need to use
> pre-POSIX `expr ...`.
>
> TLDR: use $(( ... )), not `expr ... `.

I'll use this convention in v4. Thanks!

>
>>   
>>   # usage: corrupt_graph_and_verify <position> <data> <string>
>>   # Manipulates the commit-graph file at the position
>> @@ -312,4 +319,19 @@ test_expect_success 'detect missing commit data chunk' '
>>   		"missing the Commit Data chunk"
>>   '
>>   
>> +test_expect_success 'detect incorrect fanout' '
>> +	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT1 "\01" \
> How can you be sure that this value is incorrect?

The repo is created using constant information (the commit/author dates 
are set by environment variables in the test environment). The 
commit-graph file that is generated by the test script is identical each 
time.


>
>> +		"fanout value"
>> +'
>> +
>> +test_expect_success 'detect incorrect fanout' '
>> +	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT2 "\01" \
>> +		"fanout value"
>> +'
> I would prefer if different tests had different description.  Those two
> are both 'detect incorrect layout'.  What is the difference between them?
I'll specify this one is for the final value.
>
>> +
>> +test_expect_success 'detect incorrect OID order' '
>> +	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_ORDER "\01" \
>> +		"incorrect OID order"
>> +'
> How can you be sure that this value is incorrect, or rather that it
> would be always incorrect?
>
>> +
>>   test_done
