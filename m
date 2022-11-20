Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BDDC4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 19:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiKTTqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 14:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiKTTqL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 14:46:11 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC32F01B
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 11:46:09 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d1so4910766wrs.12
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 11:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6tvu4Rk8BvH45jV5w5NDd4P4Pc1T8C0DgMxAckJlfHU=;
        b=gOcYKSAPFSzhlnPocQm0uOh+4cW7ffbbb9NCH5xqFD2JZWhkJ3LJQNBXODyv4+401e
         s3BIeF0FBoIoz6vz6EQOIZih9RQjl6+HGcADCcn16ud38/UH+uI5aZliD6AIHEav7vNy
         6a/2H1tEKwUUKBybaeU71/x9YspqCw4B8EZtcGoE6SpbQSxxS9ouvqx7Oo4+fy2CUFbe
         6yRapE5/hbBLj3TUs4zk6qRD8bC1yT1NMI1NgsNAnFk7EG/rtKgrchtRKcNEUCRKgT+u
         7bGr0dbviwQOobjrYMXcT0uXunYQxZULbrf+cl5wGaaT9j2c3Qu4UvqdjpZqeqF718Sg
         ZuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tvu4Rk8BvH45jV5w5NDd4P4Pc1T8C0DgMxAckJlfHU=;
        b=xO6jLjZwAimtqi4t23u0zuQxvLqQg3j8tdKT3U4llazw7B7sz2n0fyrauYVOM6jlNQ
         hTSyM1JYSDoE+5D0XR9sWuBU5V32T3i5Fa6ELx7nO4DQxYV3Yykoo/FzqH6d0no6Hkdg
         sPOB0NUb2w3UM+hAWT/ydv3tgzNbqMOVmy/3FfFMnFKr1ox+89lLOzwGa4eooKE6AVfM
         gF0A3h15jLqzjg/OlpffG4pan2RWOqgZL48bvE0P8QyXdGbYCa5S1On4pfFXBrwEDk5e
         hjsHWZ3dZvBjqp+BqxxVF7aL3CHvTbprPx18JTUqhzOiXiOJkQETPTACu17iHqqdgMBM
         uYsg==
X-Gm-Message-State: ANoB5pnO4s9PdDMXRAJf98InLmUTKUbv88CQyzLxnUWEXZsc2pa1cVy4
        qyFo+BIPrTZD0eeFW+3Q754=
X-Google-Smtp-Source: AA0mqf7AYTkbxYkjNGSyJnicZcGCLpz0fq3fooDHyWWAuykl7V6h8XdXO4BcllnaKsUY4IBD/jmBoA==
X-Received: by 2002:adf:d22a:0:b0:236:c5fc:5536 with SMTP id k10-20020adfd22a000000b00236c5fc5536mr9221980wrh.664.1668973567452;
        Sun, 20 Nov 2022 11:46:07 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id bg28-20020a05600c3c9c00b003cfaae07f68sm17633398wmb.17.2022.11.20.11.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 11:46:07 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <35abf6a0-982c-42d3-78c8-0298b53e6faa@dunelm.org.uk>
Date:   Sun, 20 Nov 2022 19:46:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <Y3g95OYdwzq2OP3z@nand.local>
In-Reply-To: <Y3g95OYdwzq2OP3z@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor

On 19/11/2022 02:22, Taylor Blau wrote:
> * ab/various-leak-fixes (2022-11-08) 18 commits
>    (merged to 'next' on 2022-11-18 at 8828bb7161)
>   + built-ins: use free() not UNLEAK() if trivial, rm dead code
>   + revert: fix parse_options_concat() leak
>   + cherry-pick: free "struct replay_opts" members
>   + rebase: don't leak on "--abort"
>   + connected.c: free the "struct packed_git"
>   + sequencer.c: fix "opts->strategy" leak in read_strategy_opts()
>   + ls-files: fix a --with-tree memory leak
>   + revision API: call graph_clear() in release_revisions()
>   + unpack-file: fix ancient leak in create_temp_file()
>   + built-ins & libs & helpers: add/move destructors, fix leaks
>   + dir.c: free "ident" and "exclude_per_dir" in "struct untracked_cache"
>   + read-cache.c: clear and free "sparse_checkout_patterns"
>   + commit: discard partial cache before (re-)reading it
>   + {reset,merge}: call discard_index() before returning
>   + tests: mark tests as passing with SANITIZE=leak
>   + Merge branch 'pw/rebase-no-reflog-action' into ab/various-leak-fixes
>   + rebase: stop exporting GIT_REFLOG_ACTION
>   + sequencer: stop exporting GIT_REFLOG_ACTION
>   (this branch is used by ab/merge-index-prep.)
> 
>   Various leak fixes.
> 
>   Will merge to 'master'.
>   source: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>

Below pw/rabse-no-reflog-action is marked for cooking in next but it 
will be merged to master if you merge this series to master.

Best Wishes

Phillip

> * pw/rebase-no-reflog-action (2022-11-09) 2 commits
>    (merged to 'next' on 2022-11-14 at 790dadc8d3)
>   + rebase: stop exporting GIT_REFLOG_ACTION
>   + sequencer: stop exporting GIT_REFLOG_ACTION
>   (this branch is used by ab/merge-index-prep.)
> 
>   Avoid setting GIT_REFLOG_ACTION to improve readability of the
>   sequencer internals.
> 
>   Will cook in 'next'.
>   source: <31df037eafede799c2ef27df66c6da309b719b1b.1668003719.git.gitgitgadget@gmail.com>
