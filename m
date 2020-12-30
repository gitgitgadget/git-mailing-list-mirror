Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0332C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 01:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983E521D1B
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 01:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgL3Bx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 20:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL3Bxz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 20:53:55 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2B0C06179B
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 17:53:15 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h19so10152029qtq.13
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 17:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Blsdf3U/wrlIpItKmp4VRlqs/h3yJxS81PD6IezFNfo=;
        b=Assx6G/6eLKF/sVS61LC6aAg6AiSfevKWUh3uVKIspjgVxYgfcimWRrz9D+c0Iu8wo
         umYdjqBHiggQlhF0FjUNkmTlZ2/i0s+J+hYbVTAKz8Rrlv9yziGmVQqLjuJY5HIjNKSs
         xZTkX5x8HMXdq0Khr99vUZjHc67WLaCy1P6i2jU+JIThFrLJJpg2N1M7fYtnBw+GDmqW
         +uL8Wn8j8nkfN2n6UfrPLh67vnpm9x5vyCdElUI9CBTnNAhsfI6hxmnfDEfpYH6NbeOF
         +SWmWY9s6jS/6IZGHMXQVFDgH+iD6PZbxmSNsPjtl2w07iCwDyx8KXv2sQSWnxQ98dt+
         HeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Blsdf3U/wrlIpItKmp4VRlqs/h3yJxS81PD6IezFNfo=;
        b=PjYZj8RREOFQGKPuCNi0Ka2Q1wWtEvPf05EcVVR/zR3TKzXEloR1d73Vakx5Bi6DVh
         59vzJ2ZGgOUx6UcJcooCGTRtPFFFLSSMSbJ+uWKh2WcADZEKO74FRpJjIUfRsrOkXSqG
         Ks2EYiO3863Db2BreTpuyYs4S0EoNzH2VZBDIhwZmGMN6Na91gbuQZY7yRQp5w9I12Hq
         nBG5phEv3ynA00tDzqn+82+KOGnT15p7ENGBHDMZUgryNd3BtdLcqmsG5adG/SJYg6vR
         /hsdjhSi8E3tsZ+kiGsRY9YVkvNuWntDou0kG42yZjTOtjZUwV5PpfYbLw2Xr1YXZ9Y0
         yN9A==
X-Gm-Message-State: AOAM532U8F0pBkscsWO9Trpm5B1iovQyk4j/YVNgyNRUN4F+vgZ4yBHs
        hcq2l4gBsA+jE0HdtmcbtbuXlcPNgPyHdA==
X-Google-Smtp-Source: ABdhPJzr7bH/g4f5WXylOl76QeUXWcuj6gpa42/UuRQNW152Sf2juCqitazq5XbdY1OrpXrGyxxDZA==
X-Received: by 2002:ac8:4910:: with SMTP id e16mr51451157qtq.244.1609293194546;
        Tue, 29 Dec 2020 17:53:14 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id m65sm26208046qtd.5.2020.12.29.17.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 17:53:13 -0800 (PST)
Subject: Re: [PATCH v5 07/11] commit-graph: implement corrected commit date
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <859c39eff52e32ad322969d024184971acec82e7.1609154168.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7a0eaa06-131f-ce2d-a335-b624d64ec7e4@gmail.com>
Date:   Tue, 29 Dec 2020 20:53:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <859c39eff52e32ad322969d024184971acec82e7.1609154168.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/28/2020 6:16 AM, Abhishek Kumar via GitGitGadget wrote:
> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> 
> With most of preparations done, let's implement corrected commit date.
> 
> The corrected commit date for a commit is defined as:
> 
> * A commit with no parents (a root commit) has corrected commit date
>   equal to its committer date.
> * A commit with at least one parent has corrected commit date equal to
>   the maximum of its commit date and one more than the largest corrected
>   commit date among its parents.
> 
> As a special case, a root commit with timestamp of zero (01.01.1970
> 00:00:00Z) has corrected commit date of one, to be able to distinguish
> from GENERATION_NUMBER_ZERO (that is, an uncomputed corrected commit
> date).
> 
> To minimize the space required to store corrected commit date, Git
> stores corrected commit date offsets into the commit-graph file. The
> corrected commit date offset for a commit is defined as the difference
> between its corrected commit date and actual commit date.
> 
> Storing corrected commit date requires sizeof(timestamp_t) bytes, which
> in most cases is 64 bits (uintmax_t). However, corrected commit date
> offsets can be safely stored using only 32-bits. This halves the size
> of GDAT chunk, which is a reduction of around 6% in the size of
> commit-graph file.
> 
> However, using offsets be problematic if one of commits is malformed but

However, using 32-bit offsets is problematic if a commit is malformed...

> valid and has committerdate of 0 Unix time, as the offset would be the

s/committerdate/committer date/

> same as corrected commit date and thus require 64-bits to be stored
> properly.
> 
> While Git does not write out offsets at this stage, Git stores the
> corrected commit dates in member generation of struct commit_graph_data.
> It will begin writing commit date offsets with the introduction of
> generation data chunk.
> 
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 1b2a015f92f..bfc3aae5f93 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1339,9 +1339,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  					ctx->commits.nr);
>  	for (i = 0; i < ctx->commits.nr; i++) {
>  		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
> +		timestamp_t corrected_commit_date = commit_graph_data_at(ctx->commits.list[i])->generation;
>  
>  		display_progress(ctx->progress, i + 1);
> -		if (level != GENERATION_NUMBER_ZERO)
> +		if (level != GENERATION_NUMBER_ZERO &&
> +		    corrected_commit_date != GENERATION_NUMBER_ZERO)
>  			continue;
>  
>  		commit_list_insert(ctx->commits.list[i], &list);
> @@ -1350,16 +1352,23 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  			struct commit_list *parent;
>  			int all_parents_computed = 1;
>  			uint32_t max_level = 0;
> +			timestamp_t max_corrected_commit_date = 0;
>  
>  			for (parent = current->parents; parent; parent = parent->next) {
>  				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
> +				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
>  
> -				if (level == GENERATION_NUMBER_ZERO) {
> +				if (level == GENERATION_NUMBER_ZERO ||
> +				    corrected_commit_date == GENERATION_NUMBER_ZERO) {
>  					all_parents_computed = 0;
>  					commit_list_insert(parent->item, &list);
>  					break;
> -				} else if (level > max_level) {
> -					max_level = level;
> +				} else {
> +					if (level > max_level)
> +						max_level = level;
> +
> +					if (corrected_commit_date > max_corrected_commit_date)
> +						max_corrected_commit_date = corrected_commit_date;

nit: the "break" in the first case makes it so this large else block
is unnecessary. 

-				if (level == GENERATION_NUMBER_ZERO) {
+				if (level == GENERATION_NUMBER_ZERO ||
+				    corrected_commit_date == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
-				} else if (level > max_level) {
-					max_level = level;
+				
+				if (level > max_level)
+					max_level = level;
+
+				if (corrected_commit_date > max_corrected_commit_date)
+					max_corrected_commit_date = corrected_commit_date;
-				}
 			}

Thanks,
-Stolee

