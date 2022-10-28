Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B6DECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 15:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJ1PtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 11:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ1PtX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 11:49:23 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20A01F1838
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 08:49:22 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id q18so3133206ils.12
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+qNHwyWLFecga7hkkqeoekMe8xKWDtCG3DGXyrna9w=;
        b=RqlD0Ga+r81m1an7kZ07aCXu42wtx+mXSbldc56bfMJ507iKZnYZwBU5VoIUme6MdF
         aSD/urtVYXDRNXovbBMc22ekBgCNcL2Kk94Dby++Mwp/sSOys0NMPN6xDGFmrEAiBlbo
         5xIC+h66FQFTQqRKsSxOP3K5k4GtfV1DAMUctQ2bOM3E5tmqo+wxD7dmYQYtJ6mcN6mz
         tNTM7Z3pH91G7c4HVEvnXbaTf6B1f+h2FWcK3h/7Cm3GPKVVVSoh/CQvLNUbqmgsKnp4
         XcY0YlT76y9suQO/SEMReRS+2yRxFrD0VLproRMx6dEGFlluiwbIRROAGJdILaHJ+keW
         lqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+qNHwyWLFecga7hkkqeoekMe8xKWDtCG3DGXyrna9w=;
        b=f+fdVjMBRgAYZF8TkKh62OhF7YNNQ5llGidP04R1JpeP0yTMA6BLKAUR661xdknsWG
         bTByV2ym3sc+HakTd5sLug8nrGLM/4IBL3LXV5nAl8BQS5bRaAI28yQfy+b2+u9gWyDC
         DY1qlMO/xwDv5BdnCE3S80dPiatDXcQbrqHRhsv1fqWDucTCFZEssCxYH1F2p4S2BDdD
         D1Y4Sjbrb+pM3IUpS2h9RI1NO8roT4wkQYqvIzF2Ij9tVhHukVsi/g8v9BErT2UXHkaO
         yG+TknJjcYLnKq3gkCJck7RU0EIFqTsd+DEW43L+YO7e+S87Ta61DWKJqze5/LrTPKua
         gnxQ==
X-Gm-Message-State: ACrzQf2Gq3eEEIMrpxvmna7iNpwlTmRKTnb50H7N7ikG829gvggthisk
        rfTyNbkbVLHbCTcTExXqTH1r
X-Google-Smtp-Source: AMsMyM6EvAj2fjc+qcV/iLo6elruIsLGIkBWEs1b/AZsYghBLXE9lZsuDnk7gIPuOU+cpsDPw4mOcQ==
X-Received: by 2002:a05:6e02:1b89:b0:300:55df:175f with SMTP id h9-20020a056e021b8900b0030055df175fmr47037ili.186.1666972161999;
        Fri, 28 Oct 2022 08:49:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3412:78d7:b093:983e? ([2600:1700:e72:80a0:3412:78d7:b093:983e])
        by smtp.gmail.com with ESMTPSA id o13-20020a056e02092d00b002f5024d8543sm1714570ilt.38.2022.10.28.08.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 08:49:21 -0700 (PDT)
Message-ID: <313a6619-273c-066e-c3da-a519b38c03af@github.com>
Date:   Fri, 28 Oct 2022 11:49:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] index: add trace2 region for clear skip worktree
To:     Anh Le via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>, Anh Le <anh@canva.com>
References: <pull.1368.git.git.1666742722502.gitgitgadget@gmail.com>
 <pull.1368.v2.git.git.1666917961644.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1368.v2.git.git.1666917961644.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/27/2022 8:46 PM, Anh Le via GitGitGadget wrote:
> From: Anh Le <anh@canva.com>
> 
> In a large repository using sparse checkout, checking
> whether a file marked with skip worktree is present
> on disk and its skip worktree bit should be cleared
> can take a considerable amount of time. Add a trace2
> region to surface this information, keeping a count of how many paths
> have been checked and separately
> keep counts for after a full index is
> materialised.
You have some strange line wrapping here. You can wrap them better
using several editors, but here is brief technique if your core.editor
is vim (do within 'git commit --amend'):

1. Use "SHIFT+V" to get into visual mode.
2. Use up and down arrows to select the entire paragraph.
3. Type "G" then "Q" to word wrap the selection.
4. Save and close the editor.
>  	int i;
> +	int path_counts[2] = {0, 0};
> +	int restarted = 0;

This count mechanism is a good one. Nice and simple.

>  
>  	if (!core_apply_sparse_checkout ||
>  	    sparse_expect_files_outside_of_patterns)
>  		return;
>  
> +	trace2_region_enter("index", "clear_skip_worktree_from_present_files", istate->repo);
>  restart:
>  	for (i = 0; i < istate->cache_nr; i++) {
>  		struct cache_entry *ce = istate->cache[i];
>  
> -		if (ce_skip_worktree(ce) &&
> -		    path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
> -			if (S_ISSPARSEDIR(ce->ce_mode)) {
> -				ensure_full_index(istate);
> -				goto restart;
> +		if (ce_skip_worktree(ce)) {
> +			path_counts[restarted]++;
> +			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
> +				if (S_ISSPARSEDIR(ce->ce_mode)) {
> +					ensure_full_index(istate);
> +					restarted = 1;
> +					goto restart;
> +				}
> +				ce->ce_flags &= ~CE_SKIP_WORKTREE;
>  			}
> -			ce->ce_flags &= ~CE_SKIP_WORKTREE;
>  		}
>  	}
> +
> +	if (path_counts[0] > 0) {
> +		trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/path_count", path_counts[0]);
> +	}
> +	if (restarted) {
> +		trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/full_index/path_count", path_counts[1]);
> +	}

A few style things:

1. Use "if (path_counts[0])" to detect a non-zero value.
2. Don't use { } around a single-line block.
3. Your lines are quite long, due a lot from your long keys.
   Shorten the keys (maybe "sparse_path_count" and "restarted_count"
   is enough context) and consider using a line break in
   the middle of the parameters.

> +	trace2_region_leave("index", "clear_skip_worktree_from_present_files", istate->repo);

Thanks,
-Stolee
