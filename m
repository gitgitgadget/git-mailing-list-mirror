Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD56C43381
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5490F6510F
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhCPQ73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbhCPQ7P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:59:15 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC31C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:59:15 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id j20-20020a4ad6d40000b02901b66fe8acd6so4322238oot.7
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uhWmFmlQZf2QjBuYa/YshFrI7d632/tKhJMhiablkec=;
        b=PLURyR0fJi3NlMnrrgLeo8rwPIUIh87vsSw9z6Ed2AFe7fJctEslTyQ581b+Pc1JbG
         h23XLc7rt+qab/38mmuUVeKg1SzmYmkpVC3zVRnLN4NLOwAJ5hmhSPHN8N59e8huJ8/m
         jRUdibmVmeopzDfG6O/JfgvO7yxBstWfvGNWAqwI9xa45oalXVKtWkYUm0B/EA4F7KO9
         tk1oMLYY+Bqw2ubL2f4GuvA/wCbDmkMhHwxkfpRiJhLE7EeaFTF+fbbPfkzPhGC5840A
         IyHGrWTmZrvTiNblrmSEIS564cpoXxvAna5RzMUFG6jhCcN5yn8TkrnSvArmXXYk8zCX
         uPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uhWmFmlQZf2QjBuYa/YshFrI7d632/tKhJMhiablkec=;
        b=COgXOnz8A34hbMpH/8+BMZx2afXyxbWCvz0InSv+qFUjsxsbFkJ3ajEFBJHpPlkBxC
         Pqx6nX2TrqbR3wNNVRE9s49O8amxpLpRWJ2Z+yFRzaPDTmGU2ReUQaqyt9Sb+1dXDpPb
         lz5F+vjRtH3vtkt8iM7Cs9ES9I90ZCEUSAZpSuMNx2vsBb1Xao7GCXZSVxnWTfGnm+Rl
         B+5xsu86nmDiRstng8q4HuOrY0glVKrVv+4ZDM0c6de2p5giR7HV5yPdsxlFol9aV64d
         5l3PelWd+ceMQxYX+AzlSstOnofaghKxAcwzjjaQp+GLo8c8nB3t+H63hgu68CJryPIX
         f79Q==
X-Gm-Message-State: AOAM5311RKR0zfXkrhkADh6fCV4qrpPkNgT2QFuzIXO52SRuWaoeNDUl
        aX0vxw5vdBjbkxwLVOSZaXg=
X-Google-Smtp-Source: ABdhPJxlm3D1aowiNEojJvkBuNGagMe5h0zr0K8z9hyBwanqVhV9SDAn0pSCtgxm7SaPyIQYU8O5Fw==
X-Received: by 2002:a4a:4843:: with SMTP id p64mr4564614ooa.9.1615913954759;
        Tue, 16 Mar 2021 09:59:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:fcd1:da21:8108:69bc? ([2600:1700:e72:80a0:fcd1:da21:8108:69bc])
        by smtp.gmail.com with ESMTPSA id 18sm6648779oir.4.2021.03.16.09.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 09:59:13 -0700 (PDT)
Subject: Re: [PATCH v3 00/20] Sparse Index: Design, Format, Tests
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1ac21589-24c8-d24b-bee3-6682aa76e434@gmail.com>
Date:   Tue, 16 Mar 2021 12:59:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/16/2021 12:42 PM, Derrick Stolee via GitGitGadget wrote:> Updates in V3
> =============
> 
> For this version, I took Ævar's latest patches and applied them to v2.31.0
> and rebased this series on top. It uses his new "read_tree_at()" helper and
> the associated changes to the function pointer type.

Junio, I wanted to call your attention to this change in base.

Here is the relevant part of the range-diff:

>   5:  399ddb0bad56 !  5:  99292cdbaae4 sparse-index: implement ensure_full_index()
>      @@ sparse-index.c
>       +}
>       +
>       +static int add_path_to_index(const struct object_id *oid,
>      -+				struct strbuf *base, const char *path,
>      -+				unsigned int mode, int stage, void *context)
>      ++			     struct strbuf *base, const char *path,
>      ++			     unsigned int mode, void *context)
>       +{
>       +	struct index_state *istate = (struct index_state *)context;
>       +	struct cache_entry *ce;
>      @@ sparse-index.c
>       -	/* intentionally left blank */
>       +	int i;
>       +	struct index_state *full;
>      ++	struct strbuf base = STRBUF_INIT;
>       +
>       +	if (!istate || !istate->sparse_index)
>       +		return;
>      @@ sparse-index.c
>       +		ps.has_wildcard = 1;
>       +		ps.max_depth = -1;
>       +
>      -+		read_tree_recursive(istate->repo, tree,
>      -+				    ce->name, strlen(ce->name),
>      -+				    0, &ps,
>      -+				    add_path_to_index, full);
>      ++		strbuf_setlen(&base, 0);
>      ++		strbuf_add(&base, ce->name, strlen(ce->name));
>      ++
>      ++		read_tree_at(istate->repo, tree, &base, &ps,
>      ++			     add_path_to_index, full);
>       +
>       +		/* free directory entries. full entries are re-used */
>       +		discard_cache_entry(ce);
>      @@ sparse-index.c
>       +	istate->cache_nr = full->cache_nr;
>       +	istate->cache_alloc = full->cache_alloc;
>       +
>      ++	strbuf_release(&base);
>       +	free(full);
>       +
>       +	trace2_region_leave("index", "ensure_full_index", istate->repo);

Thanks,
-Stolee
