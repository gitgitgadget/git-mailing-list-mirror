Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A591F42D
	for <e@80x24.org>; Tue, 29 May 2018 12:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933825AbeE2Mbj (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 08:31:39 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40403 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933711AbeE2Mbf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 08:31:35 -0400
Received: by mail-qt0-f196.google.com with SMTP id h2-v6so18327862qtp.7
        for <git@vger.kernel.org>; Tue, 29 May 2018 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hZP4Qaai6pWJZdEfD4qfZZxdx9y2GmGWIkpw4zgcDbk=;
        b=tuPqZUZ54GT7RreepN3OXgGgqS+lEyZojDA3tnVGoUFEGAO8L9AAKEZcX0Nom4jij4
         ciokwehBZUwHbGHjQpwRYnGEFm6d1mBd+331xgwoBoVi8d/mYg9CHSTfrr51jYdKrqgL
         PXOAJzRh+qnPLxIbk7p4aK/H168BgVYPhQ1yCfCw5gMbt6Rc3lnr8/8xFISR5VhHtMDp
         uHFkk5bKqQYTqhTHk8/cTys4+/Ku+ngoyiSTslsj25f5gAQMjgGaMWh44c8C/NDuzPBX
         ewUvIHAzdbFLYvU+OX2q1L3ug0ClvKZ6V4NqWkEXfh0hHpaeBj85o21VWT3apn91fBq8
         7Trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hZP4Qaai6pWJZdEfD4qfZZxdx9y2GmGWIkpw4zgcDbk=;
        b=o7PGD7uh4/BNRmKkYkU+ICYJ0Zo/pAv7HeuJYKaqk1D+WQXtMxAc3GpNRzW/pIyD19
         tfUYHy4yi+Kqx1d0pzvpklnm5Ez3pIcXFj5KZXSRxVX4fqrsVnpj/FDjAtRkLKRf6bIB
         IZ6pPRNfJretB7cIl5QxCCxDtwAkuaeCtgakb5XuUVQ4SkMT6HQULwle3m+9oDnTyH0c
         wWEoxg7PYrnv3ZcnwGAz1x+CN8wt/jefWY8JpDKjIYk50U9I806+eW6HYizdcD8eiVgk
         x++F5CH/mXDdtNFUHXw9th65DXeHTTmxma6dz5i3gxMoCU/gpPCI+rBZLNLrNrETfPMx
         1etw==
X-Gm-Message-State: ALKqPwdjc84wdky1WtfTvxCmS3hao43rZOMO6LUP0AmiNvAEjOejGxqx
        nt+RDZjuL3+UFlxd9Hyqg+o=
X-Google-Smtp-Source: ADUXVKKYQ3ag574txqkkByJYUrwjq1WsmmBLZ1IL5lAwXrFeR7kogJiE3PGwGnr6gKCQxAH8wMTEUQ==
X-Received: by 2002:ac8:5208:: with SMTP id r8-v6mr16049235qtn.102.1527597094312;
        Tue, 29 May 2018 05:31:34 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:85b8:1327:9ae7:c654? ([2001:4898:8010:0:6eee:1327:9ae7:c654])
        by smtp.gmail.com with ESMTPSA id f99-v6sm8198137qkh.85.2018.05.29.05.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 May 2018 05:31:33 -0700 (PDT)
Subject: Re: [PATCH v3 03/20] commit-graph: parse commit from chosen graph
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-4-dstolee@microsoft.com> <86y3g5z9ah.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <83acfbf4-dc09-377d-212a-24579c4d7703@gmail.com>
Date:   Tue, 29 May 2018 08:31:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <86y3g5z9ah.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/2018 6:23 AM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> Before verifying a commit-graph file against the object database, we
>> need to parse all commits from the given commit-graph file. Create
>> parse_commit_in_graph_one() to target a given struct commit_graph.
> If I understand it properly the problem is that when verifying against
> the object database we want to check one single commit-graph file, not
> concatenation of data from commit-graph file for the repository and
> commit-graph files from its alternates -- like prepare_commit_graph()
> does; which is called by parse_commit_in_graph().
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> O.K., so you introduce here a layer of indirection; parse_commit_in_graph()
> now just uses parse_commit_in_graph_one(), passing core_commit_graph
> (or the_commit_graph) to it, after checking that core_commit_graph is set
> (which handles the case when feature is not turned off) and loading
> commit-graph file.
>
> Nice and simple 'split function' refactoring, with new function taking
> over when there is commit graph file prepared.
>
>
> So, after the changes:
> * parse_commit_in_graph() is responsible for checking whether to use
>    commit-graph feature and ensuring that data from commit-graph is
>    loaded, where it passes the control to parse_commit_in_graph_one()
> * parse_commit_in_graph_one() checks whether commit-graph feature is
>    turned on, whether commit we are interested in was already parsed,
>    and then uses fill_commit_in_graph() to actually get the data
> * fill_commit_in_graph() gets data out of commit-graph file, extracting
>    it from commit data chunk (and if needed large edges chunk).
>
> All those functions return 1 if they got data from commit-graph, and 0
> if they didn't.
>
>
> One minor nitpick / complaint / question is about naming of global
> variables used here, namely:
> * static struct commit_graph *commit_graph
>    from commit-graph.c for global storage of commit-graph[s] data
> * int core_commit_graph
>    from environment.c for storing core.commitGraph config
>
> But I see that at least the latter is common convention in Git source
> code; I guess that the former maybe follows convention as used for "the
> index" and "the repository" - additionally it is static / file-local.

See also `struct packed_git *packed_git;` from cache.h.

>
>> ---
>>   commit-graph.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 82295f0975..78ba0edc80 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -310,7 +310,7 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
>>   	}
>>   }
>>   
>> -int parse_commit_in_graph(struct commit *item)
>> +static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
>>   {
>>   	uint32_t pos;
>>   
>> @@ -318,9 +318,21 @@ static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
>>   	if (!core_commit_graph)
>>   		return 0;
> All right, we check that commit-graph feature is enabled because
> parse_commit_in_graph_one() will be used standalone, not by being
> invoked from parse_commit_in_graph().
>
> This check is fast.
>
>>   	if (item->object.parsed)
>>   		return 1;
> Sidenote: I just wonder why object.parsed and not for example
> object.graph_pos is used to checck whether the object was filled if
> possible with commit-graph data...

Here we are filling all data, including commit date and parents. We use 
load_commit_graph_info() when we only need the graph_pos and generation 
values.

>
>> +
>> +	if (find_commit_in_graph(item, g, &pos))
>> +		return fill_commit_in_graph(item, g, pos);
>> +
>> +	return 0;
>> +}
>> +
>> +int parse_commit_in_graph(struct commit *item)
>> +{
>> +	if (!core_commit_graph)
>> +		return 0;
> All right, this check is here to short-circuit and make it so git does
> not even try to lod commit-graph file[s] if the feature is disabled.
>
>> +
>>   	prepare_commit_graph();
>> -	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
>> -		return fill_commit_in_graph(item, commit_graph, pos);
>> +	if (commit_graph)
>> +		return parse_commit_in_graph_one(commit_graph, item);
>>   	return 0;
>>   }

