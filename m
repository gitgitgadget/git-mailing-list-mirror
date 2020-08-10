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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DFFC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9679B20825
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/8jBH5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgHJQmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgHJQmc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 12:42:32 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5183C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 09:42:31 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id r19so4520205qvw.11
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 09:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OIg6bhpSzsTcaOsobwv0RJOisU1Ewx/JfOvih9IwTRM=;
        b=l/8jBH5vGBgF3iCb/lE8cPG66ObR1oxcFsw0lyBl6JcUcoHmsB/42an9Qpn9ALQqVH
         ZvBtwsTOb83sbjvsUN1UvkN8PNLMWAvczl6XGPQpCc1Lpn46wbQlA+/4XI+r7Nhp9wLT
         jhzEV4NbP9yzy7IJQRY3Q9Qq0xcekdogjgCp2Tz2B9xvRGGFZDCyuAvtcoZZu4wovSAe
         Pn8Us5x4SfAbjOsMXAbVxquqM0pD+NLycJPYDllW4Ii2WCATQGVxybTVQBPspesi8va3
         G54FMBIVw+RTeTwS7SHBzPTKsEqEMaEIkXxSpfsv800Betze1WSZ5Yx4sV0hE+PViGrs
         jZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OIg6bhpSzsTcaOsobwv0RJOisU1Ewx/JfOvih9IwTRM=;
        b=owJi/34M0xcY/VwfTL4aM621DzPmd2OCjxa0Ph0Hwi4bR9r9pY52ydt+Ktu0TYtvD+
         e4CRBDp4Hj77ZiTfYaNvIJ6TrXydfgPk6jzA3Zj36LHzuA8d6IMBwwQqAzbeoD08yZ0w
         rzCOI4ZYA26sWk1gKukugg1NC16HlQTskQGY7E6TOV2yYBd9HRWPpr/8nUtYziNBfEvr
         ZaMyr830ZKJCo2ZIGUfuGfnW0HmmCYf/mYU7YhFBbwOUTnhOVhTipEWXN+ZLzDUQBm5O
         CuzSFKNJpAk5VdbwKJfHz42wXpBQ4Xu7OdKoSZc6Zbl1s63OyXpee2ISLDSWSGu7NoDK
         lIrg==
X-Gm-Message-State: AOAM531vrpoF7qYd9MARJ9ELH5caWEKZ2ngStqgkCkFVn0gPsaUinsNC
        3pWg6Jp6Zs8BR1Ti/VZAzxc=
X-Google-Smtp-Source: ABdhPJy99fqJJfJrRngZqEC3+Mnksca6sJTZbwz+wMOaspi9a0a5xlxgaCK/u7OdY+Jr8TYUl9N+hA==
X-Received: by 2002:a0c:f849:: with SMTP id g9mr29652611qvo.80.1597077750682;
        Mon, 10 Aug 2020 09:42:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with ESMTPSA id i7sm16157442qtb.27.2020.08.10.09.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 09:42:29 -0700 (PDT)
Subject: Re: [PATCH v2 08/10] commit-graph: handle mixed generation commit
 chains
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <833779ad53eb4f57ae514f4e8964e397845f1ddd.1596941625.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0d741fb2-e25a-be05-9f2b-81ba2b4ced3f@gmail.com>
Date:   Mon, 10 Aug 2020 12:42:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <833779ad53eb4f57ae514f4e8964e397845f1ddd.1596941625.git.gitgitgadget@gmail.com>
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
> As corrected commit dates and topological levels cannot be compared
> directly, we must handle commit graph chains with mixed generation
> number definitions.
> 
> While reading a commit graph file, we disable generation numbers if the
> chain contains mixed generation numbers.
> 
> While writing to commit graph chain, we write generation data chunk only
> if the previous tip of chain had a generation data chunk. Using
> `--split=replace` overwrites the existing chain and writes generation
> data chunk regardless of previous tip.
> 
> In t5324-split-commit-graph, we set up a repo with twelve commits and
> write a base commit graph file with no generation data chunk. When add
> three commits and write to chain again, Git does not write generation
> data chunk even without setting GIT_TEST_COMMIT_GRAPH_NO_GDAT=1. Then,
> as we replace the existing chain, Git writes a commit graph file with
> generation data chunk.
> 
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c                | 14 ++++++++
>  t/t5324-split-commit-graph.sh | 66 +++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index d0f977852b..c6b6111adf 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -674,6 +674,14 @@ int generation_numbers_enabled(struct repository *r)
>  	if (!g->num_commits)
>  		return 0;
>  
> +	/* We cannot compare topological levels and corrected commit dates */
> +	while (g->base_graph) {
> +		warning(_("commit-graph-chain contains mixed generation versions"));

This warning is premature. It will add a warning whenever we have
a split commit-graph, regardless of an incorrect chain.

> +		if ((g->chunk_generation_data == NULL) ^ (g->base_graph->chunk_generation_data == NULL))

Hm. A bit-wise XOR here? That seems unfortunate. I think that it
is easier to focus on the 



> +			return 0;
> +		g = g->base_graph;
> +	}
> +

Hm. So this scenario actually disables generation numbers completely
in the event that anything in the chain disagrees. I think this is
not the right way to approach the situation, as it will significantly
punish users in this state with slow performance.

The patch I sent [1] is probably better: it uses generation number
v1 if the tip of the chain does not have a GDAT chunk.

[1] https://lore.kernel.org/git/a3910f82-ab2e-bf35-ac43-c30d77f3c96b@gmail.com/

>  	first_generation = get_be32(g->chunk_commit_data +
>  				    g->hash_len + 8) >> 2;
>  
> @@ -2186,6 +2194,9 @@ int write_commit_graph(struct object_directory *odb,
>  
>  		g = ctx->r->objects->commit_graph;
>  
> +		if (g && !g->chunk_generation_data)
> +			ctx->write_generation_data = 0;
> +
>  		while (g) {
>  			ctx->num_commit_graphs_before++;
>  			g = g->base_graph;
> @@ -2204,6 +2215,9 @@ int write_commit_graph(struct object_directory *odb,
>  
>  		if (ctx->split_opts)
>  			replace = ctx->split_opts->flags & COMMIT_GRAPH_SPLIT_REPLACE;
> +
> +		if (replace)
> +			ctx->write_generation_data = 1;
>  	}

Please make a point to move the line that checks GIT_TEST_COMMIT_GRAPH_NO_GDAT
from its current location to after this line. We want to make sure that the
environment variable is checked _last_. The best location is likely the start
of the implementation of compute_generation_numbers(), or immediately before
the call to the method.

> +test_expect_success 'setup repo for mixed generation commit-graph-chain' '
> +	mkdir mixed &&
> +	graphdir=".git/objects/info/commit-graphs" &&
> +	cd "$TRASH_DIRECTORY/mixed" &&
> +	git init &&
> +	git config core.commitGraph true &&
> +	git config gc.writeCommitGraph false &&
> +	for i in $(test_seq 3)
> +	do
> +		test_commit $i &&
> +		git branch commits/$i || return 1
> +	done &&
> +	git reset --hard commits/1 &&
> +	for i in $(test_seq 4 5)
> +	do
> +		test_commit $i &&
> +		git branch commits/$i || return 1
> +	done &&
> +	git reset --hard commits/2 &&
> +	for i in $(test_seq 6 10)
> +	do
> +		test_commit $i &&
> +		git branch commits/$i || return 1
> +	done &&
> +	git reset --hard commits/2 &&
> +	git merge commits/4 &&
> +	git branch merge/1 &&
> +	git reset --hard commits/4 &&
> +	git merge commits/6 &&
> +	git branch merge/2 &&
> +	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split &&
> +	test-tool read-graph >output &&
> +	cat >expect <<-EOF &&
> +	header: 43475048 1 1 3 0
> +	num_commits: 12
> +	chunks: oid_fanout oid_lookup commit_metadata
> +	EOF
> +	test_cmp expect output
> +'
> +
> +test_expect_success 'does not write generation data chunk if not present on existing tip' '
> +	cd "$TRASH_DIRECTORY/mixed" &&
> +	git reset --hard commits/3 &&
> +	git merge merge/1 &&
> +	git merge commits/5 &&
> +	git merge merge/2 &&
> +	git branch merge/3 &&
> +	git commit-graph write --reachable --split &&
> +	test-tool read-graph >output &&
> +	cat >expect <<-EOF &&
> +	header: 43475048 1 1 4 1
> +	num_commits: 3
> +	chunks: oid_fanout oid_lookup commit_metadata
> +	EOF
> +	test_cmp expect output
> +'
> +
> +test_expect_success 'writes generation data chunk when commit-graph chain is replaced' '
> +	cd "$TRASH_DIRECTORY/mixed" &&
> +	git commit-graph write --reachable --split='replace' &&
> +	test_path_is_file $graphdir/commit-graph-chain &&
> +	test_line_count = 1 $graphdir/commit-graph-chain &&
> +	verify_chain_files_exist $graphdir &&
> +	graph_read_expect 15
> +'

It would be valuable to double-check here that the values in the GDAT chunk
are correct. I'm concerned about the possibility that the 'generation'
member of struct commit_graph_data gets filled with topological level during
parsing and then that is written as an offset into the CDAT chunk.

Perhaps this is best left for a follow-up series that updates the 'verify'
subcommand to check the GDAT chunk.

Thanks,
-Stolee

