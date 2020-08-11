Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685C8C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 314DD20756
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knFgfaKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgHKVLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKVLw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 17:11:52 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85FAC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:11:51 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u24so13570661oiv.7
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n/STS/kbwFJVwI9mu8w1OmRN6MTftrWJKu0brwnJRRw=;
        b=knFgfaKNVXGRSIV3den+0+LVsnb52raA7te3Yl6vGixe6mOdmy8nl111Ca0f3r865F
         gyknaYOnMDje49TvrbgD9EZIdT2Y7grIP2Ayzjl1plw0m0GKfx2qgDkRqfUE2HbCwMdH
         tb/CHKiDHmxYHDUA8DcvL4fSI/HkhcetcrGWoxsi5NDsa351kE3RJVFMWwTD//H7+vaS
         69SJ8L3p+2xg0x4VD1ssZsb6a0lN4CY76FrxpGlp/oKFIkpGsPRoZFgXWsTnb4WRyIQx
         V+xBcFjbhh+P0ARxPLK3N6Wt7ja7KhEt7W8M+RoBYhTF0aKoxFZffblMCyAplzikdqX+
         jJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n/STS/kbwFJVwI9mu8w1OmRN6MTftrWJKu0brwnJRRw=;
        b=H1zncVZAOnDlfFld7rv80e2IpnrmIrJhofYmQ2JvvXMmsa1EO8tHvCg/xgGxHWEwY0
         n0pIwHFX0wXA2avIp0quLcihvm3IjbRk2RcH6qr9zf4zHiB5RVwLu+JE+QlDY+LamWVR
         n3T2zlKpTWPIEn/dJPuask7d5Cae/ZXS/rEFe9S+aAORG9z1CdrLqZFf73XLvN7GX05N
         NsuYJc4Y3sqlA4og6vECEPLqMC42HY+4205qgQ1wjP2x6p0lpF6kgkVyMjl1yu9adG4O
         +qT2gZEtxgkIHNzvqvfKoi1jEHWQTAJdM4Zdx/0J5JDSCNTgX8IrRcbPoSo0ad1szTCz
         yGZw==
X-Gm-Message-State: AOAM5321OdN9DlqLaNNl6isw2o5eVdR7XvQsizFQTadZ2HWrDDQleGZc
        LIftvR7VQJeG6jK3CwTCv4w=
X-Google-Smtp-Source: ABdhPJzWt4HtRd34HipzxShdnaEFEvjop23Ke+L1JKKgaQYZD/TIuemoc4sPyhvZiRdVRzfY46x1Rw==
X-Received: by 2002:a05:6808:a0d:: with SMTP id n13mr5174807oij.179.1597180311113;
        Tue, 11 Aug 2020 14:11:51 -0700 (PDT)
Received: from Derricks-MacBook-Pro.local ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 1sm4322248otc.44.2020.08.11.14.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 14:11:50 -0700 (PDT)
Subject: Re: [PATCH v3 12/14] commit-graph: add large-filters bitmap chunk
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com,
        gitster@pobox.com
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <619e0c619dd12e2bea2b80c7d249ba66fe2a315c.1597178915.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4f487dca-a938-b4c4-8b77-a202209459cb@gmail.com>
Date:   Tue, 11 Aug 2020 17:11:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <619e0c619dd12e2bea2b80c7d249ba66fe2a315c.1597178915.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/11/20 4:52 PM, Taylor Blau wrote:
> To allow using the existing bitmap code with 64-bit words, we write the
> data in network byte order from the 64-bit words. This means we also
> need to read the array from the commit-graph file by translating each
> word from network byte order using get_be64() when loading the commit
> graph. (Note that this *could* be delayed until first-use, but a later
> patch will rely on this being initialized early, so we assume the
> up-front cost when parsing instead of delaying initialization).

I don't think this is correct to do. This means that every commit-graph
load will load the entire large bloom filter chunk into memory before
allowing a single commit to be read from the graph.

In the case of a very large commit-graph (> 1 million commits), this
would cause a significant initial cost that is not necessarily needed
for anything. For example, "git log -1" will be delayed by this action.

If I understand correctly, this bloom_large bitmap is only used when
writing Bloom filters. At that point, reading the entire bitmap from
disk into memory is inexpensive compared to the time saved by the
feature.

> @@ -429,6 +430,24 @@ struct commit_graph *parse_commit_graph(struct repository *r,
>  				graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
>  			}
>  			break;
> +
> +		case GRAPH_CHUNKID_BLOOMLARGE:
> +			if (graph->chunk_bloom_large_filters)
> +				chunk_repeated = 1;
> +			else if (r->settings.commit_graph_read_changed_paths) {

This is guarded against commitGraph.readChangedPaths, which is good,
but that's not enough to claim that we need the bloom_large bitmap
in this process.

> +				size_t alloc = get_be64(chunk_lookup + 4) - chunk_offset - sizeof(uint32_t);

If we store this inside the commit_graph struct, we can save this
size for later so...

> +				graph->chunk_bloom_large_filters = data + chunk_offset + sizeof(uint32_t);
> +				graph->bloom_filter_settings->max_changed_paths = get_be32(data + chunk_offset);

...this portion can be done only when we are about to read from the
bitmap.

> +				if (alloc) {
> +					size_t j;
> +					graph->bloom_large = bitmap_word_alloc(alloc);
> +
> +					for (j = 0; j < graph->bloom_large->word_alloc; j++)
> +						graph->bloom_large->words[j] = get_be64(
> +							graph->chunk_bloom_large_filters + j * sizeof(eword_t));
> +				}



> +			}
> +			break;
>  		}
>  
>  		if (chunk_repeated) {
> @@ -443,7 +462,9 @@ struct commit_graph *parse_commit_graph(struct repository *r,
>  		/* We need both the bloom chunks to exist together. Else ignore the data */
>  		graph->chunk_bloom_indexes = NULL;
>  		graph->chunk_bloom_data = NULL;
> +		graph->chunk_bloom_large_filters = NULL;
>  		FREE_AND_NULL(graph->bloom_filter_settings);
> +		bitmap_free(graph->bloom_large);

Perhaps this bitmap_free() needs a check to see if we
initialized it (with my recommended lazy-loading), but
maybe not?

>  	}
>  
>  	hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_len);
> @@ -932,6 +953,20 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
>  	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
>  }
>  
> +static int get_bloom_filter_large_in_graph(struct commit_graph *g,
> +					   const struct commit *c)
> +{
> +	uint32_t graph_pos = commit_graph_position(c);
> +	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
> +		return 0;
> +
> +	while (g && graph_pos < g->num_commits_in_base)
> +		g = g->base_graph;
> +
> +	if (!(g && g->bloom_large))
> +		return 0;

Here is where we can check if the size of the chunk is
non-zero and if the g->bloom_large bitmap is uninitialized.
Since we are caring about this information, it is now time
to do the network-byte transition of the full bitmap.

> +	return bitmap_get(g->bloom_large, graph_pos - g->num_commits_in_base);
> +}
>  
Thanks,
-Stolee
