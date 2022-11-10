Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A562C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 14:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiKJOk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 09:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKJOk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 09:40:28 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9474115706
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 06:40:26 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k8so2579682wrh.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 06:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=36M8oBpcoqj7k9M2W7md6o1QXlHgwZGPe4r34L2q4CM=;
        b=pdh+u74ZZfNH+L/3UYI//oFW+BnRuQyBnK8YwC60clD3yuxK9mQL9o3QHYnRYrL/Ol
         YHnKL6ne6w0zi/BhVNpYPYC9GX1dFuvEOipjJ7n+mf0O0Z8Z2jU4onGsx2VuOhDHioCv
         WUtvyEo1wpZsqy+UQN3SY2ote0n8pLxoAEqlNROe/HFs+RLlZjr56XXMQsIPITpB2xQO
         4TeByDKrMD5qKpj74tlnXNBiZ0xYFuX/Dfv/hAITdC8KooFTw4+XOvM84GZ6kLOChUoq
         jNtdlpLP37lPalMOFkHaSjh1yWzdfBFtQSelxJiLIBz/MvNv/+hzWx7JgZBsfPZBaZhb
         3mEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36M8oBpcoqj7k9M2W7md6o1QXlHgwZGPe4r34L2q4CM=;
        b=wz641cs/v3Mvqhgblrn7r6JskUGnInvmMPON2dQ9IPCpHt6pEYUhPPAURjunkx48Cm
         772+sDUkO6fCtU5+9EHV16TLMAeLyjKjt1jZ3U6GDR2D2tmCF9MQrclU6eclPnjVyoOR
         BnFW1py5qqPo636ZIKdIXIsJC76OyZAF0KNsB8BKBiE7/trt1CeY0LyE1clcguy9h9Ds
         73zV+CvliSRN1JKLq7dwP1qlCR+en4jNJa5BjK3MdbJN79gT9ZBOwIWAf57Y/cMojPQH
         UOQYLdNa2t7uQkIpLI7ljOgy/u8Y61D/DYFmRUJQF9XUXf/G9wFGMUNUuQADL9Ln3v96
         hhgg==
X-Gm-Message-State: ACrzQf0a00KHYhU7xH5eO3D3CU7umeug9FRctMH2vpzHcVhcL4B+BtQ2
        HIgPE8jV8Sj1Lh8sEHaSrEY=
X-Google-Smtp-Source: AMsMyM5Bdew0wjTWVvZ+IkzAGXbvr+8ACscylfoDKi0F+FfqEPq06902jERAVD0PFj6wAQm3yat/3Q==
X-Received: by 2002:adf:a3de:0:b0:22c:d593:f04d with SMTP id m30-20020adfa3de000000b0022cd593f04dmr1029814wrb.277.1668091225047;
        Thu, 10 Nov 2022 06:40:25 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id bo17-20020a056000069100b002366eb01e07sm16253561wrb.114.2022.11.10.06.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 06:40:24 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <44b0331a-17e5-1528-2249-e89f0bdd6ffb@dunelm.org.uk>
Date:   Thu, 10 Nov 2022 14:40:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/5] rebase: use 'skip_cache_tree_update' option
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
 <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
 <fffe2fc17ed3beb05376f1377ea193199c13c657.1668045438.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <fffe2fc17ed3beb05376f1377ea193199c13c657.1668045438.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

On 10/11/2022 01:57, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Enable the 'skip_cache_tree_update' option in both 'do_reset()'
> ('sequencer.c') and 'reset_head()' ('reset.c'). Both of these callers invoke
> 'prime_cache_tree()' after 'unpack_trees()', so we can remove an unnecessary
> cache tree rebuild by skipping 'cache_tree_update()'.
> 
> When testing with 'p3400-rebase.sh' and 'p3404-rebase-interactive.sh', the
> performance change of this update was negligible, likely due to the
> operation being dominated by more expensive operations (like checking out
> trees).

Yes, we only call this once at the beginning of the rebase and then for 
any reset commands and the run time will be dominated by picking commits.

> However, since the change doesn't harm performance, it's worth
> keeping this 'unpack_trees()' usage consistent with others that subsequently
> invoke 'prime_cache_tree()'.

That makes sense

> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>   reset.c     | 1 +
>   sequencer.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/reset.c b/reset.c
> index e3383a93343..5ded23611f3 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -128,6 +128,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
>   	unpack_tree_opts.update = 1;
>   	unpack_tree_opts.merge = 1;
>   	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
> +	unpack_tree_opts.skip_cache_tree_update = 1;

I've added an extra context line above to show that we do either a 
one-way or two-way merge - is it safe to skip the cache_tree_update for 
the two-way merge? (I'm afraid I seem to have forgotten everything I 
learnt about prime_cache_tree() and cache_tree_update() when we 
discussed this optimization before).

Best Wishes

Phillip

>   	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
>   	if (reset_hard)
>   		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
> diff --git a/sequencer.c b/sequencer.c
> index e658df7e8ff..3f7a73ce4e1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3750,6 +3750,7 @@ static int do_reset(struct repository *r,
>   	unpack_tree_opts.merge = 1;
>   	unpack_tree_opts.update = 1;
>   	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
> +	unpack_tree_opts.skip_cache_tree_update = 1;
>   	init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
>   
>   	if (repo_read_index_unmerged(r)) {
