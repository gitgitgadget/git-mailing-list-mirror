Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A96C35641
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 00:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC42206EF
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 00:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V44eP3hB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgBVAz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:55:59 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34723 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgBVAz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 19:55:59 -0500
Received: by mail-yw1-f66.google.com with SMTP id b186so2103887ywc.1
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 16:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VQeuuPaL+onAOcPHZBNs35cGdICeyZ7vPAX67g7Kw2k=;
        b=V44eP3hB+w4bo8vdeuQ61EtGaBuiEdfvXTE44nPnnA2YfevJ9Zsy24o3wym2MYeGU7
         3++rFZzNQWeMFFfid5cAHE45BJ05fYOxysDiXFahMwa31JgKb6Oytdkfatdhf73HkzDK
         mKJY4gmQ9ZAW9x4Tm1vAl22AsLpiC3TdpPIymuHXggf376dej3gdM8zpA3HQVKFveXR2
         xs7z5/VyjtwCSn+Za5GbY5v8UFhQqznJhqP95xuRVNfqZD0LU/KiSkxPY6CrigP1avuj
         LDe2XvVrEn+UIMwd3jyFepbpp3fvFPmqPg3FUJE1yJMVSsy1/a63Cld7y0VOvy8CybNU
         zqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VQeuuPaL+onAOcPHZBNs35cGdICeyZ7vPAX67g7Kw2k=;
        b=Mpaa99sskW4IO0d/5jS49JJHFAzbyeZskD8SFEKZVen/87r2lJhVuRVnOSnC0U2S8r
         NEqY0nV9ANqpA65DtuT2g4D+uv8X15bQjQMxozi89O6URFsEnFbs9mpMvq0wB2eJ9msX
         uRDSqPnhspxl5Vnxa9qNt2u9R6opK6xH29QVP7fZujT+xbpiLYpBvHoFMPY3K6G+E4mu
         q2BcYil8oNpTb7r9p5FzQJce+pQAXmhno+LIxenr8RyU6M2KVZXNhci44yMikDG34bVW
         gi2jXnO2ndV7XXSRO8kNycOYJNUC1ofk8xl17S6hQKY81uOButBNXtkKcVmQaPAj4JnO
         O4Zg==
X-Gm-Message-State: APjAAAX1ESAovcXWqy9zR5WEqY/2/t4rqyzEDJwc/HDd6OmyecGZP/bD
        v3ylcDjhnVjMY4vn5UwOlFw=
X-Google-Smtp-Source: APXvYqwGIRSDLvO/loySlvuRar5n485H1SpTWwnU4iqPfIXZ7BG5jW7RiXPW68kmPUfTskbP/4ji5Q==
X-Received: by 2002:a81:9b4c:: with SMTP id s73mr34473451ywg.334.1582332958192;
        Fri, 21 Feb 2020 16:55:58 -0800 (PST)
Received: from ?IPv6:2600:1700:b00:7980:25f3:c564:ed3b:ab96? ([2600:1700:b00:7980:25f3:c564:ed3b:ab96])
        by smtp.gmail.com with ESMTPSA id b195sm2095023ywh.80.2020.02.21.16.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 16:55:57 -0800 (PST)
Subject: Re: [PATCH v2 04/11] commit-graph: compute Bloom filters for changed
 paths
To:     Jakub Narebski <jnareb@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
 <c17bbcbc66ea77bb480391804d1f2db66ffa0926.1580943390.git.gitgitgadget@gmail.com>
 <86k14klvyb.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <0f1ab477-fae8-b744-5c48-87995f7fc8eb@gmail.com>
Date:   Fri, 21 Feb 2020 19:55:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <86k14klvyb.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/17/2020 4:56 PM, Jakub Narebski wrote:
> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Garima Singh <garima.singh@microsoft.com>
>> Subject: [PATCH v2 04/11] commit-graph: compute Bloom filters for changed paths
>>
>> Compute Bloom filters for the paths that changed between a commit and its
>> first parent using the implementation in bloom.c, when the
>> COMMIT_GRAPH_WRITE_CHANGED_PATHS flag is set. This computation is done on a
>> commit-by-commit basis. We will write these Bloom filters to the commit graph
>> file in the next change.
> 
> I have no major complaints about the contents of this patch (except lack
> of test, and type of total_bloom_filter_data_size), but the commit
> message could have been worded better.
> 
> I would write something like this instead:
> 
>   Add new COMMIT_GRAPH_WRITE_CHANGED_PATHS flag that makes Git compute
>   Bloom filters that store the information about changed paths (that
>   changed between a commit and its first parent) for each commit in the
>   commit-graph.  This computation is done on a commit-by-commit basis.
> 
>   We will write these Bloom filters to the commit-graph file, to store
>   this data on disk, in the next change in this series.
> 
> In my opinion the fact that we compute Bloom filters for each and every
> commit in the commit-graph file is more important than quite obvious
> fact that we use implementation from bloom.c.
> 

Nice! Incorporated in v3. Thanks!

>>
>> Helped-by: Derrick Stolee <dstolee@microsoft.com>
>> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
>> ---
>>  commit-graph.c | 32 +++++++++++++++++++++++++++++++-
>>  commit-graph.h |  3 ++-
>>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> It would be good to have at least sanity check of this feature, perhaps
> one that would check that the number of per-commit Bloom filters on slab
> matches the number of commits in the commit-graph.
> 

The combination of all the e2e tests in this series with the test
flag being turned on in the CI, and the performance gains we are seeing
confirm that this is happening correctly.

>>  
>>  	const struct split_commit_graph_opts *split_opts;
>> +	uint32_t total_bloom_filter_data_size;
> 
> This is total size of Bloom filters data, in bytes, that will later be
> used for BDAT chunk size.  However the commit-graph format uses 8 bytes
> for byte-offset, not 4 bytes.  Why it is uint32_t and not uint64_t then?
>

Changed to size_t. Thanks for noticing! 
 
>>  };
>>  
>>  static void write_graph_chunk_fanout(struct hashfile *f,
>> @@ -1140,6 +1143,28 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>>  	stop_progress(&ctx->progress);
>>  }
>>  
>> +static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>> +{
>> +	int i;
>> +	struct progress *progress = NULL;
>> +
>> +	load_bloom_filters();
>> +
>> +	if (ctx->report_progress)
>> +		progress = start_progress(
>> +			_("Computing commit diff Bloom filters"),
>> +			ctx->commits.nr);
>> +
> 
> Shouldn't we initialize ctx->total_bloom_filter_data_size to 0 here?  We
> cannot use compute_bloom_filters() to _update_ Bloom filters data, I
> think -- we don't distinguish here between new and existing data (where
> existing data size is already included in total Bloom filters size).  At
> least I don't think so.
> 

This line in commit-graph.c takes care of reinitializing the graph context and
by consequence the bloom filter data size. 
  ctx = xcalloc(1, sizeof(struct write_commit_graph_context));
  
So the total size gets recalculated every time, which is correct. 

> 
> Side note: perhaps we could add trailing comma after new enum entry,
> that is
> 
>   +	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),
> 
> following new CodingGuidelines recommendation
> 

Thanks! Fixed in v3.

Cheers! 
Garima Singh
