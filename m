Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0717C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 14:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEED12070B
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 14:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L35XKGup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgHJOXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgHJOXf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 10:23:35 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED7BC061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 07:23:34 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k4so9046520oik.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RbFPLcaD4nT6j2OURk+xMhiCa8rOUGTmOLTTRZE+kaU=;
        b=L35XKGupGpCOgXBU2OFAPbOhzT6in3VeW7BgsGzUZ9UifALHFanONSDJuj1Q774tPs
         aftAkZZh/VLrUZRKocwrHvcFtJL4y3Pk+tmQh/rT4BJ10RrLHJGu6FkMwpHSMq/t+Dj8
         iOO1GJRHazrDZdSkLAZDHE/6TLumqfAXy4rDQP+AjN5R9jAStRN71GR/Mdp+l1dTbU/G
         gZyKN8IdKkfsw825W8PrVCG4drhrhcvtCITLf3Ga0Yk/aOs8ccLXahWHdY4Wqyjrzv8p
         8CXqG7tjvxOwzGtWs94ohUpmG2bFV3rpf7KvJysaxkAXtIvFDz+6fI0xZbCfh0qH4uD2
         hBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RbFPLcaD4nT6j2OURk+xMhiCa8rOUGTmOLTTRZE+kaU=;
        b=j8NB8BdxM/GYKWQxnq5tBqT1q7kHd858MONXueM/58qVHRm2qVlWZAQbEe6vMfG+iF
         98ccjqdhFksqhef+rQ04XSGyqLdidyxkLIHvAsHBKQtytasnglMUUpdv1jSDuzGy8BLu
         ZdbXPAVfWtudScEcpyhK4YzQLpcP8DotjxdgcT1YbWUm8yTXky1/TyPJn8kTEjW0RrGr
         cKPtjyYnCVTlcfPoUJQkz4c5OCRN+Kmcrex022Pe0gc56vP3LxcwFQLeESgkRyAFQolo
         lQPSrmkO0I0eiHK9wox6GlcWYSfdbM6cQFPVsCMYiZlxZFB9a7L7qETEdxIwCHYnZmx9
         HSjg==
X-Gm-Message-State: AOAM532fpqjHBw9Zp7lORRdhxTaKNp9xpEDl4R/rTDY6Kw1lo0+/3FA+
        nxbPz7yg72/gR194F0tgT3c=
X-Google-Smtp-Source: ABdhPJy3Etko/PA45aghzaI+O5gqUCTXgF03Vi4zC4UGYuiQxkhk9xl2lMF04sMLrouDMMfa75UsNg==
X-Received: by 2002:aca:504b:: with SMTP id e72mr870514oib.84.1597069413853;
        Mon, 10 Aug 2020 07:23:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with ESMTPSA id t21sm3628307ooc.43.2020.08.10.07.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 07:23:33 -0700 (PDT)
Subject: Re: [PATCH v2 07/10] commit-graph: implement corrected commit date
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <bfe14732014807ff19f943cdf51068f0d3043c30.1596941625.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a3910f82-ab2e-bf35-ac43-c30d77f3c96b@gmail.com>
Date:   Mon, 10 Aug 2020 10:23:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <bfe14732014807ff19f943cdf51068f0d3043c30.1596941625.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2020 10:53 PM, Abhishek Kumar via GitGitGadget wrote:
> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> 
> With most of preparations done, let's implement corrected commit date
> offset. We add a new commit-slab to store topogical levels while
> writing commit graph and upgrade the generation member in struct
> commit_graph_data to a 64-bit timestamp. We store topological levels to
> ensure that older versions of Git will still have the performance
> benefits from generation number v2.
> 
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---

> @@ -767,7 +764,10 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
>  	item->date = (timestamp_t)((date_high << 32) | date_low);
>  
>  	if (g->chunk_generation_data)
> -		graph_data->generation = get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
> +	{
> +		graph_data->generation = item->date +
> +			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
> +	}

You don't need curly braces here, since this is only one line
in the block. Even if you did, these braces are in the wrong
location.

There is a subtle issue with this interpretation, and it
involves the case where the following happens:

1. A new version of Git writes a commit-graph using the
   GDAT chunk.

2. An older version of Git adds a new layer without the
   GDAT chunk.

At that point, the tip commit-graph does not have GDAT,
so the commits in that layer will get "generation" set
with the topological level, which is likely to be much
lower than the corrected commit dates set in the
"generation" field for commits in the lower layer.

The crux of the issue is that we are only considering
the current layer when interpreting the generation number
value.

The patch below inserts a flag into fill_commit_graph_info()
corresponding to the "global" state of whether the top
commit-graph layer has a GDAT chunk. By your later protection
to not write GDAT chunks on top of commit-graphs without
a GDAT chunk, this top commit-graph has all of the information
we need for this check.

Thanks,
-Stolee

--- >8 ---

From 62189709fad3b051cedbd36193f5244fcce17e1f Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Mon, 10 Aug 2020 10:06:47 -0400
Subject: [PATCH] commit-graph: use generation v2 only if entire chain does

Since there are released versions of Git that understand generation
numbers in the commit-graph's CDAT chunk but do not understand the GDAT
chunk, the following scenario is possible:

 1. "New" Git writes a commit-graph with the GDAT chunk.
 2. "Old" Git writes a split commit-graph on top without a GDAT chunk.

Because of the current use of inspecting the current layer for a
generation_data_chunk pointer, the commits in the lower layer will be
interpreted as having very large generation values (commit date plus
offset) compared to the generation numbers in the top layer (topological
level). This violates the expectation that the generation of a parent is
strictly smaller than the generation of a child.

It is difficult to expose this issue in a test. Since we _start_ with
artificially low generation numbers, any commit walk that prioritizes
generation numbers will walk all of the commits with high generation
number before walking the commits with low generation number. In all the
cases I tried, the commit-graph layers themselves "protect" any
incorrect behavior since none of the commits in the lower layer can
reach the commits in the upper layer.

This issue would manifest itself as a performance problem in this
case, especially with something like "git log --graph" since the low
generation numbers would cause the in-degree queue to walk all of the
commits in the lower layer before allowing the topo-order queue to write
anything to output (depending on the size of the upper layer).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index eb78af3dad..17623274d9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -762,7 +762,9 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 	return &commit_list_insert(c, pptr)->next;
 }
 
-static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
+#define COMMIT_GRAPH_GENERATION_V2 (1 << 0)
+
+static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos, int flags)
 {
 	const unsigned char *commit_data;
 	struct commit_graph_data *graph_data;
@@ -785,11 +787,9 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	date_low = get_be32(commit_data + g->hash_len + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
-	if (g->chunk_generation_data)
-	{
+	if (g->chunk_generation_data && (flags & COMMIT_GRAPH_GENERATION_V2))
 		graph_data->generation = item->date +
 			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
-	}
 	else
 		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
@@ -799,6 +799,10 @@ static inline void set_commit_tree(struct commit *c, struct tree *t)
 	c->maybe_tree = t;
 }
 
+/*
+ * In the case of a split commit-graph, this method expects the given
+ * commit-graph 'g' to be the top layer.
+ */
 static int fill_commit_in_graph(struct repository *r,
 				struct commit *item,
 				struct commit_graph *g, uint32_t pos)
@@ -808,11 +812,15 @@ static int fill_commit_in_graph(struct repository *r,
 	struct commit_list **pptr;
 	const unsigned char *commit_data;
 	uint32_t lex_index;
+	int flags = 0;
+
+	if (g->chunk_generation_data)
+		flags |= COMMIT_GRAPH_GENERATION_V2;
 
 	while (pos < g->num_commits_in_base)
 		g = g->base_graph;
 
-	fill_commit_graph_info(item, g, pos);
+	fill_commit_graph_info(item, g, pos, flags);
 
 	lex_index = pos - g->num_commits_in_base;
 	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
@@ -904,10 +912,14 @@ int parse_commit_in_graph(struct repository *r, struct commit *item)
 void load_commit_graph_info(struct repository *r, struct commit *item)
 {
 	uint32_t pos;
+	int flags = 0;
+
 	if (!prepare_commit_graph(r))
 		return;
+	if (r->objects->commit_graph->chunk_generation_data)
+		flags |= COMMIT_GRAPH_GENERATION_V2;
 	if (find_commit_in_graph(item, r->objects->commit_graph, &pos))
-		fill_commit_graph_info(item, r->objects->commit_graph, pos);
+		fill_commit_graph_info(item, r->objects->commit_graph, pos, flags);
 }
 
 static struct tree *load_tree_for_commit(struct repository *r,
-- 
2.28.0.38.gc6f546511c1

