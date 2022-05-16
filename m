Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AA3C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 21:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348954AbiEPVBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 17:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349294AbiEPVBM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 17:01:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021903915D
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:36:51 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso457032pjg.0
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jICJ9+gYK2yBeZwWJ/dsYU/3CHnceJU+W3yVr4uDYFE=;
        b=dfI3tjiNwK/lnzZly8806nKApB6TdSGmnp/WvR6TBlzLmMpCGNY9uOPPUgAZ2Jdtnf
         39HXvxAaQoVx6JPUPOCgmnlllXM2Lg/Dgxhegzr0JL3KjO5nyUBp4hSAXUDoEVlzQlts
         sHwHq/yELCCpv8+Eqy2tWL7trG7HGxPdR/cWDjYQeBxDrKZB0UN9H3AbjXOaa8/LoDZO
         M+EoGgE/2r2fv2QCEAgzDP+TvoltBhwLcDQuqWHgJ1qS/KPj2qJ6Z3yE2CHFfm9aVqz8
         AIJROs/yaTAVplcw1LCAuTC8BcqE49UqrIPv0iemh1d7ZBCInHspwq4Q3MfGOMKssiHP
         41DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jICJ9+gYK2yBeZwWJ/dsYU/3CHnceJU+W3yVr4uDYFE=;
        b=Q7g5j30gAh+qpYV3g1QLnxhv9eNyPE+Mha5DazKpU/cPanwXcEvO6Jc6TNH4NfV3i2
         d8LNSItCS+h8MNtbhghMIqWuLcRWKjuzj9u5c8WiUtCyLcO8ShfXAmGFP+/FWQlHFrLQ
         LmaF86yMgITo0Y8rv9WezB9FVuMZhkUta0BzaiBP9X/2jdaMb+7uZbXL8oFTy4QWIT1h
         iqKB/P95EVI11Dkk2P3RvDDXQV7Je63gs3y8FViR8nCGQ2d/Jza2T81XWBgc4Hn8CeYr
         5/PtXKIc8w1HgA8SpNX/BjTalX/XHvu3mImACMyoRH9h2AENKTcooo3EEFirDNLY+7XF
         /d+Q==
X-Gm-Message-State: AOAM530lMYJ23EKYEVDFtbWaqVPWZfF6jAzcJp8xjkk/6e7FAxLiaD7k
        vFr9nPHG3jFfHQccZgHUni8t
X-Google-Smtp-Source: ABdhPJzAnIJArZJ9zxyCHXiKmdXkUyyFCKjpZNC55p4or0EIOVV0ePEgjjmIVrQKiV+YFXfQeXHfiQ==
X-Received: by 2002:a17:90a:690c:b0:1df:3b6f:d073 with SMTP id r12-20020a17090a690c00b001df3b6fd073mr9914975pjj.18.1652733411502;
        Mon, 16 May 2022 13:36:51 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a990800b001df6216e89dsm112254pjp.28.2022.05.16.13.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 13:36:51 -0700 (PDT)
Message-ID: <12df1777-9f02-ca6f-7d17-57aebe25d06c@github.com>
Date:   Mon, 16 May 2022 13:36:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 1/8] sparse-index: create expand_to_pattern_list()
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
 <f1194d56d331611446c285a1d070509d73bd5f43.1652724693.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <f1194d56d331611446c285a1d070509d73bd5f43.1652724693.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> This is the first change in a series to allow modifying the
> sparse-checkout pattern set without expanding a sparse index to a full
> one in the process. Here, we focus on the problem of expanding the
> pattern set through a command like 'git sparse-checkout add <path>'
> which needs to create new index entries for the paths now being written
> to the worktree.
> 
> To achieve this, we need to be able to replace sparse directory entries
> with their contained files and subdirectories. Once this is complete,
> other code paths can discover those cache entries and write the
> corresponding files to disk before committing the index.
> 
> We already have logic in ensure_full_index() that expands the index
> entries, so we will use that as our base. Create a new method,
> expand_to_pattern_list(), which takes a pattern list, but for now mostly
> ignores it. The current implementation is only correct when the pattern
> list is NULL as that does the same as ensure_full_index(). In fact,
> ensure_full_index() is converted to a shim over
> expand_to_pattern_list().
> 
> A future update will actually implement expand_to_pattern_list() to its
> full capabilities. For now, it is created and documented.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  sparse-index.c | 35 ++++++++++++++++++++++++++++++++---
>  sparse-index.h | 14 ++++++++++++++
>  2 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/sparse-index.c b/sparse-index.c
> index 8636af72de5..37c7df877a6 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -248,19 +248,41 @@ static int add_path_to_index(const struct object_id *oid,
>  	return 0;
>  }
>  
> -void ensure_full_index(struct index_state *istate)
> +void expand_to_pattern_list(struct index_state *istate,
> +			      struct pattern_list *pl)

Hyper-nit: I don't think this is aligned (it's probably not worth fixing
unless you end up rerolling for something else).

>  {
>  	int i;
>  	struct index_state *full;
>  	struct strbuf base = STRBUF_INIT;
>  
> +	/*
> +	 * If the index is already full, then keep it full. We will convert
> +	 * it to a sparse index on write, if possible.
> +	 */
>  	if (!istate || !istate->sparse_index)
>  		return;
>  
> +	/*
> +	 * If our index is sparse, but our new pattern set does not use
> +	 * cone mode patterns, then we need to expand the index before we
> +	 * continue. A NULL pattern set indicates a full expansion to a
> +	 * full index.
> +	 */
> +	if (pl && !pl->use_cone_patterns)
> +		pl = NULL;
> +
>  	if (!istate->repo)
>  		istate->repo = the_repository;
>  
> -	trace2_region_enter("index", "ensure_full_index", istate->repo);
> +	/*
> +	 * A NULL pattern set indicates we are expanding a full index, so
> +	 * we use a special region name that indicates the full expansion.
> +	 * This is used by test cases, but also helps to differentiate the
> +	 * two cases.
> +	 */
> +	trace2_region_enter("index",
> +			    pl ? "expand_to_pattern_list" : "ensure_full_index",
> +			    istate->repo);
>  
>  	/* initialize basics of new index */
>  	full = xcalloc(1, sizeof(struct index_state));
> @@ -322,7 +344,14 @@ void ensure_full_index(struct index_state *istate)
>  	cache_tree_free(&istate->cache_tree);
>  	cache_tree_update(istate, 0);
>  
> -	trace2_region_leave("index", "ensure_full_index", istate->repo);
> +	trace2_region_leave("index",
> +			    pl ? "expand_to_pattern_list" : "ensure_full_index",
> +			    istate->repo);
> +}
> +
> +void ensure_full_index(struct index_state *istate)
> +{
> +	expand_to_pattern_list(istate, NULL);
>  }
>  
>  void ensure_correct_sparsity(struct index_state *istate)
> diff --git a/sparse-index.h b/sparse-index.h
> index 633d4fb7e31..037b541f49d 100644
> --- a/sparse-index.h
> +++ b/sparse-index.h
> @@ -23,4 +23,18 @@ void expand_to_path(struct index_state *istate,
>  struct repository;
>  int set_sparse_index_config(struct repository *repo, int enable);
>  
> +struct pattern_list;
> +
> +/**
> + * Scan the given index and compare its entries to the given pattern list.
> + * If the index is sparse and the pattern list uses cone mode patterns,
> + * then modify the index to contain the all of the file entries within that
> + * new pattern list. This expands sparse directories only as far as needed.
> + *
> + * If the pattern list is NULL or does not use cone mode patterns, then the
> + * index is expanded to a full index.
> + */
> +void expand_to_pattern_list(struct index_state *istate,
> +			      struct pattern_list *pl);
> +
>  #endif

