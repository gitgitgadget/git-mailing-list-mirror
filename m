Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4890215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754945AbeEAMTm (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:19:42 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:37167 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754678AbeEAMTl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:19:41 -0400
Received: by mail-qk0-f181.google.com with SMTP id d74so8729625qkg.4
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BbgDwH/+EM24AHSAKoQJ1EwKXzoYLwhr4YwnxZXITns=;
        b=ep2WwGogANZl5k7RT9NWGKCq3r3prg5C1CfExB55nJ17DTX6rKcNchKh81CliphRbL
         w61XPL4YglURYLAwNhbJeQPWPtqTqqYLzx8R/cUNdRhQmUEXypijYW2c7b1tFsnV0LmG
         zgU+5YVor6kkJhN3eG9tyN/HwrKyDIXZqLHrNIIrcxTZnXbKv5VYyUJkGYUkDctZq9cI
         CiuaoLRCZ21zTzUqrPF3KHEiPkEmnPo+RHDyRZGtkEnuojuru0b6acasKDjYWIRTSqo2
         9dxA/t7xJsWbtMRWFqr3PjFGxlgrT7OjspkhEf4x9oDHJRj8QzlQVxRb9b6HDFT7nWhU
         8Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BbgDwH/+EM24AHSAKoQJ1EwKXzoYLwhr4YwnxZXITns=;
        b=A4adaossC9o7RLYnJ9/mh3uGxW2d6VhagetX1pijL4qLFHWRO2OivNviJl4C4cc0OL
         +BTmX4IQTKx3NANBe1i/1dViy3hJY1T4wRRY7/q9WBECtX4n7n5EmEK6kkEf5wbUWC9B
         o8NPZayq1YB5VsysXHxuaNmzGZj53CfZCC2eRcmtMFgYkOObFa3/c4qHeNt7Ya/DbEGJ
         c+OHV4tuBsUliciz8S9GVepD0HbDyC3N3lHPcszWK2gx6LvKG3m1Vhj5ceFmTLw0DsTo
         VnEsQbn54FVrm321Dil91RhMfdS0+3T9tJjiVrJXuBue26ki/tRwh85hjJaxDqSIUZK4
         +KqQ==
X-Gm-Message-State: ALQs6tDu78kpf6s/PNbsNpCAgQJ1xx9xoWjbk3woXPnAcXLrh/i3P+Qj
        t1cLoTnjAr8ZNc1Rj4ix3gc=
X-Google-Smtp-Source: AB8JxZqMXDrhBWb9yJMOtCSy9LoUK6WjcSg3E9/KyU3wlMKWecgM4M7nPfQ67phoWvCGyTryLRZjmA==
X-Received: by 10.55.203.193 with SMTP id u62mr11863073qkl.83.1525177180652;
        Tue, 01 May 2018 05:19:40 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id k10sm8953395qkh.95.2018.05.01.05.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:19:39 -0700 (PDT)
Subject: Re: [PATCH v4 05/10] commit-graph: always load commit-graph
 information
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
 <20180425143735.240183-1-dstolee@microsoft.com>
 <20180425143735.240183-6-dstolee@microsoft.com> <866049irrx.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4273bd76-94c5-d3c8-7f4e-b4cdb4bc35eb@gmail.com>
Date:   Tue, 1 May 2018 08:19:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <866049irrx.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/29/2018 6:14 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> Most code paths load commits using lookup_commit() and then
>> parse_commit().
> And this automatically loads commit graph if needed, thanks to changes
> in parse_commit_gently(), which parse_commit() uses.
>
>>                  In some cases, including some branch lookups, the commit
>> is parsed using parse_object_buffer() which side-steps parse_commit() in
>> favor of parse_commit_buffer().
> I guess the problem is that we cannot just add parse_commit_in_graph()
> like we did in parse_commit_gently(), for some reason?  Like for example
> that parse_commit_gently() uses parse_commit_buffer() - which could have
> been handled by moving parse_commit_in_graph() down the call chain from
> parse_commit_gently() to parse_commit_buffer()... if not the fact that
> check_commit() also uses parse_commit_buffer(), but it does not want to
> load commit graph.  Am I right?

If a caller uses parse_commit_buffer() directly, then we will guarantee 
that all values in the struct commit that would be loaded from the 
buffer are loaded from the buffer. This means we do NOT load the root 
tree id or commit date from the commit-graph file. We do still need to 
load the data that is not available in the buffer, such as graph_pos and 
generation.

>
>> With generation numbers in the commit-graph, we need to ensure that any
>> commit that exists in the commit-graph file has its generation number
>> loaded.
> Is it generation number, or generation number and position in commit
> graph?

We don't need to ensure the graph_pos (the commit will never be 
re-parsed, so we will not try to find it in the commit-graph file 
again), but we DO need to ensure the generation (or our commit walks 
will be incorrect). We get the graph_pos as a side-effect.

>
>> Create new load_commit_graph_info() method to fill in the information
>> for a commit that exists only in the commit-graph file. Call it from
>> parse_commit_buffer() after loading the other commit information from
>> the given buffer. Only fill this information when specified by the
>> 'check_graph' parameter.
> I think this commit would be easier to review if it was split into pure
> refactoring part (extracting fill_commit_graph_info() and
> find_commit_in_graph()).  On the other hand the refactoring was needed
> to reduce code duplication betweem existing parse_commit_in_graph() and
> new load_commit_graph_info() functions.
>
> I guess that the difference between parse_commit_in_graph() and
> load_commit_graph_info() is that the former cares only about having just
> enough information that is needed for parse_commit_gently() - and does
> not load graph data if commit is parsed, while the latter is about
> loading commit-graph data like generation numbers.
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   commit-graph.c | 45 ++++++++++++++++++++++++++++++---------------
>>   commit-graph.h |  8 ++++++++
>>   commit.c       |  7 +++++--
>>   commit.h       |  2 +-
>>   object.c       |  2 +-
>>   sha1_file.c    |  2 +-
>>   6 files changed, 46 insertions(+), 20 deletions(-)
> I wonder if it would be possible to add tests for this feature, for
> example that commit-graph is read when it should (including those branch
> lookups), and is not read when the feature should be disabled.
>
> But the only way to test it I can think of is a stupid one: create
> invalid commit graph, and check that git fails as expected (trying to
> read said malformed file), and does not fail if commit graph feature is
> disabled.
>
> Let me reorder files (BTW, is there a way for Git to put *.h files
> before *.c files in diff?) for easier review:
>
>> diff --git a/commit-graph.h b/commit-graph.h
>> index 260a468e73..96cccb10f3 100644
>> --- a/commit-graph.h
>> +++ b/commit-graph.h
>> @@ -17,6 +17,14 @@ char *get_commit_graph_filename(const char *obj_dir);
>>    */
>>   int parse_commit_in_graph(struct commit *item);
>>   
>> +/*
>> + * It is possible that we loaded commit contents from the commit buffer,
>> + * but we also want to ensure the commit-graph content is correctly
>> + * checked and filled. Fill the graph_pos and generation members of
>> + * the given commit.
>> + */
>> +void load_commit_graph_info(struct commit *item);
>> +
>>   struct tree *get_commit_tree_in_graph(const struct commit *c);
>>   
>>   struct commit_graph {
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 047fa9fca5..aebd242def 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -245,6 +245,12 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
>>   	return &commit_list_insert(c, pptr)->next;
>>   }
>>   
>> +static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
>> +{
>> +	const unsigned char *commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * pos;
>> +	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
>> +}
> The comment in the header file commit-graph.h talks about filling
> graph_pos and generation members of the given commit, but I don't see
> filling graph_pos member here.

We are missing the following line:

+    item->graph_pos = pos;

I will add it for v5. The equivalent line exists in fill_commit_in_graph().

>
> Sidenote: it is a tiny little bit strange to see symbolic constants like
> GRAPH_DATA_WIDTH near using magic values such as 8 and 2.

There needs to be some boundary between abstraction and concreteness 
when dealing directly with a binary file format. GRAPH_DATA_WIDTH helps 
us navigate to the correct "row" in the chunk, while we use the 
constants 8 and 2 to get the correct "column" out of that row.

>
>> +
>>   static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t pos)
>>   {
>>   	uint32_t edge_value;
>> @@ -292,31 +298,40 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
>>   	return 1;
>>   }
>>   
>> +static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t *pos)
>> +{
>> +	if (item->graph_pos != COMMIT_NOT_FROM_GRAPH) {
>> +		*pos = item->graph_pos;
>> +		return 1;
>> +	} else {
>> +		return bsearch_graph(g, &(item->object.oid), pos);
>> +	}
>> +}
> Nice refactoring here.
>
>> +
>>   int parse_commit_in_graph(struct commit *item)
>>   {
>> +	uint32_t pos;
>> +
>>   	if (!core_commit_graph)
>>   		return 0;
>>   	if (item->object.parsed)
>>   		return 1;
>> -
>>   	prepare_commit_graph();
>> -	if (commit_graph) {
>> -		uint32_t pos;
>> -		int found;
>> -		if (item->graph_pos != COMMIT_NOT_FROM_GRAPH) {
>> -			pos = item->graph_pos;
>> -			found = 1;
>> -		} else {
>> -			found = bsearch_graph(commit_graph, &(item->object.oid), &pos);
>> -		}
>> -
>> -		if (found)
>> -			return fill_commit_in_graph(item, commit_graph, pos);
>> -	}
>> -
>> +	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
>> +		return fill_commit_in_graph(item, commit_graph, pos);
>>   	return 0;
>>   }
>>   
>> +void load_commit_graph_info(struct commit *item)
>> +{
>> +	uint32_t pos;
>> +	if (!core_commit_graph)
>> +		return;
>> +	prepare_commit_graph();
>> +	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
>> +		fill_commit_graph_info(item, commit_graph, pos);
>> +}
> Similar functions, different goals (as the names imply).
>
>> +
>>   static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *c)
>>   {
>>   	struct object_id oid;
>> diff --git a/commit.c b/commit.c
>> index 4d00b0a1d6..39a3749abd 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -331,7 +331,7 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
>>   	return ret;
>>   }
>>   
>> -int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size)
>> +int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size, int check_graph)
>>   {
>>   	const char *tail = buffer;
>>   	const char *bufptr = buffer;
>> @@ -386,6 +386,9 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
>>   	}
>>   	item->date = parse_commit_date(bufptr, tail);
>>   
>> +	if (check_graph)
>> +		load_commit_graph_info(item);
>> +
> All right, read commit-graph specific data after parsing commit itself.
> It is at the end because commit object needs to be parsed sequentially,
> and it includes more info that is contained in commit-graph CDAT+EDGE
> data.
>
>>   	return 0;
>>   }
>>   
>> @@ -412,7 +415,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>>   		return error("Object %s not a commit",
>>   			     oid_to_hex(&item->object.oid));
>>   	}
>> -	ret = parse_commit_buffer(item, buffer, size);
>> +	ret = parse_commit_buffer(item, buffer, size, 0);
> The parse_commit_gently() contract is that it provides only bare minimum
> of information, from commit-graph if possible, and does read object from
> disk and parses it only when it could not avoid it.  If it needs to
> parse it, it doesn't need to fill commit-graph specific data again.
>
> All right.
>
>>   	if (save_commit_buffer && !ret) {
>>   		set_commit_buffer(item, buffer, size);
>>   		return 0;
>> diff --git a/commit.h b/commit.h
>> index 64436ff44e..b5afde1ae9 100644
>> --- a/commit.h
>> +++ b/commit.h
>> @@ -72,7 +72,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
>>    */
>>   struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
>>   
>> -int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size);
>> +int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size, int check_graph);
>>   int parse_commit_gently(struct commit *item, int quiet_on_missing);
>>   static inline int parse_commit(struct commit *item)
>>   {
>> diff --git a/object.c b/object.c
>> index e6ad3f61f0..efe4871325 100644
>> --- a/object.c
>> +++ b/object.c
>> @@ -207,7 +207,7 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
>>   	} else if (type == OBJ_COMMIT) {
>>   		struct commit *commit = lookup_commit(oid);
>>   		if (commit) {
>> -			if (parse_commit_buffer(commit, buffer, size))
>> +			if (parse_commit_buffer(commit, buffer, size, 1))
> All that rigamarole was needed because of
>
> DS>                 In some cases, including some branch lookups, the commit
> DS> is parsed using parse_object_buffer() which side-steps parse_commit() in
> DS> favor of parse_commit_buffer().
>
> Here we want parse_object_buffer() to get also commit-graph specific
> data, if available.  All right.
>
>>   				return NULL;
>>   			if (!get_cached_commit_buffer(commit, NULL)) {
>>   				set_commit_buffer(commit, buffer, size);
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 1b94f39c4c..0fd4f0b8b6 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -1755,7 +1755,7 @@ static void check_commit(const void *buf, size_t size)
>>   {
>>   	struct commit c;
>>   	memset(&c, 0, sizeof(c));
>> -	if (parse_commit_buffer(&c, buf, size))
>> +	if (parse_commit_buffer(&c, buf, size, 0))
> For check we don't need commit graph data.  Looks all right.
>
>>   		die("corrupt commit");
>>   }
> Best,

