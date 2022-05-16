Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92F4C4332F
	for <git@archiver.kernel.org>; Mon, 16 May 2022 21:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348878AbiEPVBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 17:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349303AbiEPVBN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 17:01:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F253EF30
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:36:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n8so15564252plh.1
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4+3g2DVl+J5P7Mvs7lE5rk7Js5UYbiT/ebyIPjmOCZM=;
        b=Mt07kAPQyd6Am9aIWjiggTRSAWh0BY1mJAtJ3+YyB8oTB2k/60BdagUbQp2i/YqeN8
         GvRj4IZLLAhq80hkohVFL4gTslvnOsVAa9nsIrZzOydhpACJePxjKE8aQI28eAswUiQD
         5BRRY72KfY52Q2oTJCyRaAJyJkUxOB1Rhh+8+G3kvQhU9XyIa1soG4v/gtBm2hYR8d3O
         ziyT5efV4g9y1owr10dKgUogpM1hhcZ6JaG9ES5zKokkBtZidI33QY8UmmdVsTzkv4Uy
         FDtN1fyJgqt/AyAfTWCbSXdJwndv0t5GnDvZhzxEj/RLhtrYdsPT2Nu+U+w26VBZF+rC
         Ah+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4+3g2DVl+J5P7Mvs7lE5rk7Js5UYbiT/ebyIPjmOCZM=;
        b=GsfVVu9HWpG+IufM+J4yZSU45/WNjl6VQxGe1AvM2DtgW+JK3V3z6CRp+gv0glTx2i
         mvgMDBmqSKAY4rSL0p4ZRmMoJqsJN7B0lciQQC0ZETdBVArEiclKxax6Kwz/0fziVkEZ
         Pm7jITMyggTYpksxZfv+DihG3fg9RtPorYITQ0eKnkRbauSPe8ydU5Tigl2GssuAJVma
         glRVHjUAqQM7OmgAIytzERmt3vWRHVpda6UH/ApgXFBvISn9ZTjfjKoDJt2E5ydLvUrR
         ObuzVodlue4lXQMC0iKEFAgXVC0GS0BIblgFVB7F/yLFIwJlDgvb/Q/JM/TP62FdgvVa
         jScA==
X-Gm-Message-State: AOAM532ndOUzygeTmb0SfykKz0mPPSMzbDTSis0D3avDkS8ayE8eu8z1
        HIP3eWyrN7XaRbY5gi7WgNpd
X-Google-Smtp-Source: ABdhPJztSkRhzVuaI1zr1oC1QMPVVyQfBAY9F/VfogtC6tvtMtFd4TbpGAr6ajZXLsuGb/XlLygXnw==
X-Received: by 2002:a17:902:bd05:b0:15f:19a0:95ed with SMTP id p5-20020a170902bd0500b0015f19a095edmr19370800pls.31.1652733418655;
        Mon, 16 May 2022 13:36:58 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709027b9600b0015e8d4eb25fsm7449282pll.169.2022.05.16.13.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 13:36:58 -0700 (PDT)
Message-ID: <a90af86d-e3dd-e0fe-106a-52123d6ac023@github.com>
Date:   Mon, 16 May 2022 13:36:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 5/8] sparse-index: partially expand directories
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
 <5c7546ab07080b43972b265eb2eee3de0c5396a2.1652724693.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <5c7546ab07080b43972b265eb2eee3de0c5396a2.1652724693.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The expand_to_pattern_list() method expands sparse directory entries
> to their list of contained files when either the pattern list is NULL or
> the directory is contained in the new pattern list's cone mode patterns.
> 
> It is possible that the pattern list has a recursive match with a
> directory 'A/B/C/' and so an existing sparse directory 'A/B/' would need
> to be expanded. If there exists a directory 'A/B/D/', then that
> directory should not be expanded and instead we can create a sparse
> directory.
> 
> To implement this, we plug into the add_path_to_index() callback for the
> call to read_tree_at(). Since we now need access to both the index we
> are writing and the pattern list we are comparing, create a 'struct
> modify_index_context' to use as a data transfer object. It is important
> that we use the given pattern list since we will use this pattern list
> to change the sparse-checkout patterns and cannot use
> istate->sparse_checkout_patterns.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  sparse-index.c | 46 +++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/sparse-index.c b/sparse-index.c
> index 79e8ff087bc..3d8eed585b5 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -9,6 +9,11 @@
>  #include "dir.h"
>  #include "fsmonitor.h"
>  
> +struct modify_index_context {
> +	struct index_state *write;
> +	struct pattern_list *pl;
> +};
> +
>  static struct cache_entry *construct_sparse_dir_entry(
>  				struct index_state *istate,
>  				const char *sparse_dir,
> @@ -231,18 +236,41 @@ static int add_path_to_index(const struct object_id *oid,
>  			     struct strbuf *base, const char *path,
>  			     unsigned int mode, void *context)
>  {
> -	struct index_state *istate = (struct index_state *)context;
> +	struct modify_index_context *ctx = (struct modify_index_context *)context;
>  	struct cache_entry *ce;
>  	size_t len = base->len;
>  
> -	if (S_ISDIR(mode))
> -		return READ_TREE_RECURSIVE;
> +	if (S_ISDIR(mode)) {
> +		int dtype;
> +		size_t baselen = base->len;
> +		if (!ctx->pl)
> +			return READ_TREE_RECURSIVE;
>  
> -	strbuf_addstr(base, path);
> +		/*
> +		 * Have we expanded to a point outside of the sparse-checkout?
> +		 */
> +		strbuf_addstr(base, path);
> +		strbuf_add(base, "/-", 2);
> +
> +		if (path_matches_pattern_list(base->buf, base->len,
> +					      NULL, &dtype,
> +					      ctx->pl, ctx->write)) {
> +			strbuf_setlen(base, baselen);
> +			return READ_TREE_RECURSIVE;
> +		}
>  
> -	ce = make_cache_entry(istate, mode, oid, base->buf, 0, 0);
> +		/*
> +		 * The path "{base}{path}/" is a sparse directory. Create the correct
> +		 * name for inserting the entry into the idnex.

s/idnex/index

> +		 */
> +		strbuf_setlen(base, base->len - 1);
> +	} else {
> +		strbuf_addstr(base, path);
> +	}
> +
> +	ce = make_cache_entry(ctx->write, mode, oid, base->buf, 0, 0);
>  	ce->ce_flags |= CE_SKIP_WORKTREE | CE_EXTENDED;
> -	set_index_entry(istate, istate->cache_nr++, ce);
> +	set_index_entry(ctx->write, ctx->write->cache_nr++, ce);
>  
>  	strbuf_setlen(base, len);
>  	return 0;
> @@ -254,6 +282,7 @@ void expand_to_pattern_list(struct index_state *istate,
>  	int i;
>  	struct index_state *full;
>  	struct strbuf base = STRBUF_INIT;
> +	struct modify_index_context ctx;
>  
>  	/*
>  	 * If the index is already full, then keep it full. We will convert
> @@ -294,6 +323,9 @@ void expand_to_pattern_list(struct index_state *istate,
>  	full->cache_nr = 0;
>  	ALLOC_ARRAY(full->cache, full->cache_alloc);
>  
> +	ctx.write = full;
> +	ctx.pl = pl;
> +
>  	for (i = 0; i < istate->cache_nr; i++) {
>  		struct cache_entry *ce = istate->cache[i];
>  		struct tree *tree;
> @@ -319,7 +351,7 @@ void expand_to_pattern_list(struct index_state *istate,
>  		strbuf_add(&base, ce->name, strlen(ce->name));
>  
>  		read_tree_at(istate->repo, tree, &base, &ps,
> -			     add_path_to_index, full);
> +			     add_path_to_index, &ctx);
>  
>  		/* free directory entries. full entries are re-used */
>  		discard_cache_entry(ce);

