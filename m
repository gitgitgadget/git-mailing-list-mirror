Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED033C433FE
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 11:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD45A61151
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 11:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbhJFLWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 07:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238138AbhJFLWP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 07:22:15 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE4BC061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 04:20:23 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so2649424otx.3
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 04:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yXXVYicju93GFeLyAvv/vHhmPCCRJJmTIdffJRk/tdU=;
        b=QQ61gKQRlDTrWV3zE0uNhbLFuPoHPNVpdxGxhxsUbr2s4r4bLY3mWJND/vOVCIYPGL
         D80hLvr9SfMouPWd2m3l5baURkFXXEBv4NG4qVU+W3rYV9EizEKbhoSnzh8UJNIpRlbg
         g+jUYoRwS5l0FD+OT/jeh6eTSxPCjeX9QFRs8kAQRpxw95tf7ijbzCPwSusxxyBpfnfp
         pJJyEM8XT1Y1KddrMYHYzuGtMq8GuVWyM0hi2C1qfWu4HyeWW6xzxR7d5EJ5bj8GGurG
         06F/Ra5Bg79gXURrbHSmZ/Jwv4D89QV67pPk7BQyMuRrUdRp6nElyCqPdykTjLcZn9c8
         hbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yXXVYicju93GFeLyAvv/vHhmPCCRJJmTIdffJRk/tdU=;
        b=RrQd0y22FKXGJP1DhV3mcDpyd0o88ceJcp/b5sHLOMEVbDYCmKSTJwWiTwDoshxDPp
         yvCPSXjiLPBpPL8PhNRj6hC3xLM4/feXu8eYhe/Y4mPKvmYl3O5BWVpSqnPcJWyYyr0Q
         0H1yctbYmpKsVnSNqouaW0KfGjb2dyN8w8LLbMDBwLtYeNFUCPKfmOVThMr+Dp0SqFxA
         9HeGsgNsah9Lw6nmn4C8RWRLx27JV/yOQU9o2OC0XYYa9vnTkLunt6ewh9SM6BsPy9XJ
         outM3UkIHCmqddNfxO8CPmQVmzt/ixveNZ5EqhhY55oGSdCzSbuGq13/mBj+tk8FRpnS
         4NVg==
X-Gm-Message-State: AOAM5335htnCG/nXHWLs2dlpp2Sjj6KeIaRpOyBuAPvQEcs1qstL6ALY
        qCOM41hwh8XXU0kIjvfL3Ug=
X-Google-Smtp-Source: ABdhPJysPt2l2tpR2w0NXZE1qLmG+UYjVp/5Grf2et+nb6R3CxYx6NzyAPZGCP1WLJ0nYi6Sx2bGoA==
X-Received: by 2002:a9d:135:: with SMTP id 50mr18844692otu.295.1633519223073;
        Wed, 06 Oct 2021 04:20:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9408:42d7:3932:900f? ([2600:1700:e72:80a0:9408:42d7:3932:900f])
        by smtp.gmail.com with ESMTPSA id 4sm4196275ota.48.2021.10.06.04.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 04:20:22 -0700 (PDT)
Message-ID: <2b1f0e56-5bb4-7f41-5a1e-d8a21096084a@gmail.com>
Date:   Wed, 6 Oct 2021 07:20:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] [RFC] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-US
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, vdye@github.com
References: <pull.1053.git.1633512591608.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1053.git.1633512591608.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/6/2021 5:29 AM, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> In a sparse index it is possible for the tree that is being verified
> to be freed while it is being verified. This happens when
> index_name_pos() looks up a entry that is missing from the index and
> that would be a descendant of a sparse entry. That triggers a call to
> ensure_full_index() which frees the cache tree that is being verified.
> Carrying on trying to verify the tree after this results in a
> use-after-free bug. Instead restart the verification if a sparse index
> is converted to a full index. This bug is triggered by a call to
> reset_head() in "git rebase --apply". Thanks to René Scharfe for his
> help analyzing the problem.

Thank you for identifying an interesting case! I hadn't thought to
change the mode from --merge to --apply.

>     In a sparse index it is possible for the tree that is being verified to
>     be freed while it is being verified. This is an RFC as I'm not familiar
>     with the cache tree code. I'm confused as to why this bug is triggered
>     by the sequence
>     
>     unpack_trees()
>     prime_cache_tree()
>     write_locked_index()
>     
>     but not
>     
>     unpack_trees()
>     write_locked_index()
>     
>     
>     as unpack_trees() appears to update the cache tree with
>     
>     if (!cache_tree_fully_valid(o->result.cache_tree))
>                 cache_tree_update(&o->result,
>                           WRITE_TREE_SILENT |
>                           WRITE_TREE_REPAIR);
>     
>     
>     and I don't understand why the cache tree from prime_cache_tree()
>     results in different behavior. It concerns me that this fix is hiding
>     another bug.

prime_cache_tree() appears to clear the cache tree and start from scratch
from a tree object instead of using the index.

In particular, prime_cache_tree_rec() does not stop at the sparse-checkout
cone, so the cache tree is the full size at that point.

When the verify_one() method reaches these nodes that are outside of the
cone, index_name_pos() triggers the index expansion in a way that the
cache-tree that is restricted to the sparse-checkout cone does not.

Hopefully that helps clear up _why_ this happens.

There is a remaining issue that "git rebase --apply" will be a lot slower
than "git rebase --merge" because of this construction of a cache-tree
that is much larger than necessary.

I will make note of this as a potential improvement for the future.

> -static void verify_one(struct repository *r,
> -		       struct index_state *istate,
> -		       struct cache_tree *it,
> -		       struct strbuf *path)
> +static int verify_one(struct repository *r,
> +		      struct index_state *istate,
> +		      struct cache_tree *it,
> +		      struct strbuf *path)
>  {
>  	int i, pos, len = path->len;
>  	struct strbuf tree_buf = STRBUF_INIT;
> @@ -837,21 +837,30 @@ static void verify_one(struct repository *r,
>  
>  	for (i = 0; i < it->subtree_nr; i++) {
>  		strbuf_addf(path, "%s/", it->down[i]->name);
> -		verify_one(r, istate, it->down[i]->cache_tree, path);
> +		if (verify_one(r, istate, it->down[i]->cache_tree, path))
> +			return 1;
>  		strbuf_setlen(path, len);
>  	}
>  
>  	if (it->entry_count < 0 ||
>  	    /* no verification on tests (t7003) that replace trees */
>  	    lookup_replace_object(r, &it->oid) != &it->oid)
> -		return;
> +		return 0;
>  
>  	if (path->len) {
> +		/*
> +		 * If the index is sparse index_name_pos() may trigger
> +		 * ensure_full_index() which will free the tree that is being
> +		 * verified.
> +		 */
> +		int is_sparse = istate->sparse_index;
>  		pos = index_name_pos(istate, path->buf, path->len);
> +		if (is_sparse && !istate->sparse_index)
> +			return 1;

I think this guard is good to have, even if we fix prime_cache_tree() to
avoid triggering expansion here in most cases.

>  		if (pos >= 0) {
>  			verify_one_sparse(r, istate, it, path, pos);
> -			return;
> +			return 0;
>  		}
>  
>  		pos = -pos - 1;
> @@ -899,6 +908,7 @@ static void verify_one(struct repository *r,
>  		    oid_to_hex(&new_oid), oid_to_hex(&it->oid));
>  	strbuf_setlen(path, len);
>  	strbuf_release(&tree_buf);
> +	return 0;
>  }
>  
>  void cache_tree_verify(struct repository *r, struct index_state *istate)
> @@ -907,6 +917,9 @@ void cache_tree_verify(struct repository *r, struct index_state *istate)
>  
>  	if (!istate->cache_tree)
>  		return;
> -	verify_one(r, istate, istate->cache_tree, &path);
> +	if (verify_one(r, istate, istate->cache_tree, &path)) {
> +		strbuf_reset(&path);
> +		verify_one(r, istate, istate->cache_tree, &path);
> +	}

And this limits us to doing at most two passes. Good.

>  test_expect_success 'merge, cherry-pick, and rebase' '
>  	init_repos &&
>  
> -	for OPERATION in "merge -m merge" cherry-pick rebase
> +	for OPERATION in "merge -m merge" cherry-pick "rebase --apply" "rebase --merge"

Thank you for the additional test!

Thanks,
-Stolee
