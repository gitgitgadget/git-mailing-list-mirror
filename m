Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BF7C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 18:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjCFSwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 13:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCFSw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 13:52:27 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A97169072
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 10:52:22 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n6so11503001plf.5
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 10:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678128741;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKks+b57nBy9i/hA3Cv9gDFF/eBmfHTA4MtJ9DRwSmc=;
        b=Qxsj2Q6D/C9KNirfpGyAFxnurDxocRDse1rVz0dpF8zPC4RluPNcS8tFANhbd+kiVT
         /LLoPH6ACxhjrp7fBRhZo6oYn3d4YREuKAnBrxQLwcvdVnhhppJGFmmqmx2DP+319F8I
         q+Wt0FEZqKRahasel76fdyAiWPs0XOi8fKIb9r4/H5+5DHpTD2+lz4PMOSjExg2RE6+o
         UU2JGGQp2fMfa4RBAHWBLC9I9LBe9t2i/8LQQv4O2tpP3iBN/DnCPW7KI8SpbFme/J6x
         BkfsSUj3l+smCIoEkUXLH+3ZKQgU9ojUGpEOQiZv7RxlXmepZiHVwqICj5fOkru2TZjw
         bhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678128741;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xKks+b57nBy9i/hA3Cv9gDFF/eBmfHTA4MtJ9DRwSmc=;
        b=3/bf6FPS/cf7JLgY7qqGvO/8Lck92FQwgPChg/i2tCwJWFZ3OMEQ4t5t3ZW6g/tmm1
         W3GCCQmgj2GOXNQ8BqdnuPmqkOyApf2SbfZy+5sPHuWB7vYIhJmGYaKHZ/lBh1chztcr
         cY2GatYdhJ/T4mjA1wAOhCT0+qRTble+dtVf9SWPNUKD1BfoCJSH8kphLSu+ZDqWXKxF
         F7arkS940h7WQ/k578IDAQa2hTlBwTMeTbEAAgwPZKtqcvUq3r5z6c4gXhQBY82rUS8i
         /k9qi3FA4Hu9orvs3E3wOojexLtyCOSUATGigAc0VbPwOz1a3UrJW7DQccAfknmXDJbH
         me3w==
X-Gm-Message-State: AO0yUKUOwrc6eKTcOkAzcRgEYGiTFoGCy53XRDcIqFbxX49d06xiMtUb
        9u5qayXqRybiGRjHoRvl+js=
X-Google-Smtp-Source: AK7set/HrRQ+Si9kR5ncqqZ5YpoDeEL4njlXqejt/Y9AfgFXRmjlLdIbdOb4+Smcke6MQLC3Z4KWEw==
X-Received: by 2002:a05:6a20:7883:b0:cc:8a62:d0da with SMTP id d3-20020a056a20788300b000cc8a62d0damr9994522pzg.12.1678128741466;
        Mon, 06 Mar 2023 10:52:21 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id k17-20020aa790d1000000b005907716bf8bsm6646605pfk.60.2023.03.06.10.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 10:52:20 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 6/8] commit-graph: introduce `ensure_generations_valid()`
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <f31994ac78aa7aff11d923a77be6b0652f3af70d.1678111599.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Mar 2023 10:52:20 -0800
In-Reply-To: <f31994ac78aa7aff11d923a77be6b0652f3af70d.1678111599.git.gitgitgadget@gmail.com>
        (Taylor Blau via GitGitGadget's message of "Mon, 06 Mar 2023 14:06:36
        +0000")
Message-ID: <xmqqttyx90gr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Taylor Blau <me@ttaylorr.com>
>
> Use the just-introduced compute_reachable_generation_numbers_1() to
> implement a function which dynamically computes topological levels (or
> corrected commit dates) for out-of-graph commits.
>
> This will be useful for the ahead-behind algorithm we are about to
> introduce, which needs accurate topological levels on _all_ commits
> reachable from the tips in order to avoid over-counting.

Interesting and nice to see it done with so small a change thanks to
the previous refactoring.

>
> Co-authored-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  commit-graph.c | 29 +++++++++++++++++++++++++++++
>  commit-graph.h |  7 +++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index f04b02be1bb..a573d1b89ff 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1610,6 +1610,35 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  	stop_progress(&ctx->progress);
>  }
>  
> +static void set_generation_in_graph_data(struct commit *c, timestamp_t t,
> +					 void *data)
> +{
> +	commit_graph_data_at(c)->generation = t;
> +}
> +
> +/*
> + * After this method, all commits reachable from those in the given
> + * list will have non-zero, non-infinite generation numbers.
> + */
> +void ensure_generations_valid(struct commit **commits, size_t nr)
> +{
> +	struct repository *r = the_repository;
> +	int generation_version = get_configured_generation_version(r);
> +	struct packed_commit_list list = {
> +		.list = commits,
> +		.alloc = nr,
> +		.nr = nr,
> +	};
> +	struct compute_generation_info info = {
> +		.r = r,
> +		.commits = &list,
> +		.get_generation = get_generation_from_graph_data,
> +		.set_generation = set_generation_in_graph_data,
> +	};
> +
> +	compute_reachable_generation_numbers_1(&info, generation_version);
> +}
> +
>  static void trace2_bloom_filter_write_statistics(struct write_commit_graph_context *ctx)
>  {
>  	trace2_data_intmax("commit-graph", ctx->r, "filter-computed",
> diff --git a/commit-graph.h b/commit-graph.h
> index 37faee6b66d..a529c62b518 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -190,4 +190,11 @@ struct commit_graph_data {
>   */
>  timestamp_t commit_graph_generation(const struct commit *);
>  uint32_t commit_graph_position(const struct commit *);
> +
> +/*
> + * After this method, all commits reachable from those in the given
> + * list will have non-zero, non-infinite generation numbers.
> + */
> +void ensure_generations_valid(struct commit **commits, size_t nr);
> +
>  #endif
