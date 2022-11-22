Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA38C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 15:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiKVPAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 10:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiKVO7h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 09:59:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2944F6CA23
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:58:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e11so12198452wru.8
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D0clCgHwSC2yXBmqqTNlPv9fWxcBRZeT9T3gO5cNENE=;
        b=Jrurwp3QQhAHOeUbw4d3d8WOzBLNuPXmCdW2T7TyfbjkswJGI2dRm9jJFZmfQ6uQVG
         5DkO3VCD55Os/u68lhw0oyFQMvgXFBekvA12+ZxD9gJms+wnkRsXFAmnhSZElofGFeJU
         c6Ocaw6XqTKTMYnbrHRDQgmG/8cyGFnclwzbi8RJxgK4NYNZ1C9M63d67agj2YfQRvHf
         DRz1wuvu0WfsR+MMMQ6M6Qf/mwMi5AMotzEPnbv0Zz+okUUrnLR+/RaLLPUeNcm8RQzW
         PgrFupzA1O4ojGLiTQO1jzcCDE+H0jI7BiiRuCeYTtLEKx/hPYAYwuZ2WUsW+SqXanOR
         TGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0clCgHwSC2yXBmqqTNlPv9fWxcBRZeT9T3gO5cNENE=;
        b=Ewv6FceWWsnxLKxjIRk4gsWCmIcGOBNYGi6l+mHrCW+4fY/1w+9aMFPh8TLQlBukze
         jcnpF6SIX7BZlTXAoiOzW3QhlGdQT0JF8vi/wQoWS4AOz42djmFG+QIYTl0UsoTzcEAB
         bJrQ/HSzeejnEdk0ZGDoJHkow40eVu3a3dzpn8RvWDwg40SJx5v5r8C8WEDRw6g0TUnj
         AFIEg8aBHmgrEeAgCFlzrkuAMHM3XRxO2RaEAVoD/RZHjvBlyuvY5SdLVqARYNI2M6Po
         N7JVO2ugOMH8BLZbpO/rkvn2EdgxJLxHfjwxuDHYYs8w/R8C45rni2NFd20fm0NvgHE0
         casA==
X-Gm-Message-State: ANoB5pmrdKGX6sPaaQBVElLuuJ8xymQBW7Aqa246aW5ldGlr2Akagb7d
        5CWnEmekYvY3GsdDsoE/pxo=
X-Google-Smtp-Source: AA0mqf7vk9eaPqN62h/5KAYkgG3r3N4s0Ocq8ounI57Bwbz/Zv8Axa8dqTKR+n17URBzuKXn6BUJug==
X-Received: by 2002:adf:e0c2:0:b0:236:6f18:37e6 with SMTP id m2-20020adfe0c2000000b002366f1837e6mr13999216wri.262.1669129102723;
        Tue, 22 Nov 2022 06:58:22 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d6509000000b0023c8026841csm14264514wru.23.2022.11.22.06.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 06:58:22 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <8d0e11cc-b083-5700-5d30-4b61cd4c9b9a@dunelm.org.uk>
Date:   Tue, 22 Nov 2022 14:58:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <Y3g95OYdwzq2OP3z@nand.local>
 <35abf6a0-982c-42d3-78c8-0298b53e6faa@dunelm.org.uk>
 <on4s271q-21s5-onsp-ss70-863nr403760p@tzk.qr>
In-Reply-To: <on4s271q-21s5-onsp-ss70-863nr403760p@tzk.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/11/2022 21:24, Johannes Schindelin wrote:
> Hi Phillip & Taylor,
> 
> On Sun, 20 Nov 2022, Phillip Wood wrote:
> 
>> Hi Taylor
>>
>> On 19/11/2022 02:22, Taylor Blau wrote:
>>> * ab/various-leak-fixes (2022-11-08) 18 commits
>>>    (merged to 'next' on 2022-11-18 at 8828bb7161)
>>>    + built-ins: use free() not UNLEAK() if trivial, rm dead code
>>>    + revert: fix parse_options_concat() leak
>>>    + cherry-pick: free "struct replay_opts" members
>>>    + rebase: don't leak on "--abort"
>>>    + connected.c: free the "struct packed_git"
>>>    + sequencer.c: fix "opts->strategy" leak in read_strategy_opts()
>>>    + ls-files: fix a --with-tree memory leak
>>>    + revision API: call graph_clear() in release_revisions()
>>>    + unpack-file: fix ancient leak in create_temp_file()
>>>    + built-ins & libs & helpers: add/move destructors, fix leaks
>>>    + dir.c: free "ident" and "exclude_per_dir" in "struct untracked_cache"
>>>    + read-cache.c: clear and free "sparse_checkout_patterns"
>>>    + commit: discard partial cache before (re-)reading it
>>>    + {reset,merge}: call discard_index() before returning
>>>    + tests: mark tests as passing with SANITIZE=leak
>>>    + Merge branch 'pw/rebase-no-reflog-action' into ab/various-leak-fixes
>>>    + rebase: stop exporting GIT_REFLOG_ACTION
>>>    + sequencer: stop exporting GIT_REFLOG_ACTION
>>>    (this branch is used by ab/merge-index-prep.)
>>>
>>>    Various leak fixes.
>>>
>>>    Will merge to 'master'.
>>>    source: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
>>
>> Below pw/rabse-no-reflog-action is marked for cooking in next but it will be
>> merged to master if you merge this series to master.
> 
> Not only that. `ab/various-leak-fixes` still merges an older iteration:

Thanks, I hadn't thought to check that

Best Wishes

Phillip

> -- snip --
> $ git range-diff ttaylorr/ab/various-leak-fixes~15^2...ttaylorr/pw/rebase-no-reflog-action
> 1:  d6f756b0d66f ! 1:  d188a60d7228 sequencer: stop exporting GIT_REFLOG_ACTION
>      @@ Commit message
>           pass the reflog action around in a variable and use it to set
>           GIT_REFLOG_ACTION in the child environment when running "git commit".
> 
>      +    Within the sequencer GIT_REFLOG_ACTION is no longer set and is only read
>      +    by sequencer_reflog_action(). It is still set by rebase before calling
>      +    the sequencer, that will be addressed in the next commit. cherry-pick
>      +    and revert are unaffected as they do not set GIT_REFLOG_ACTION before
>      +    calling the sequencer.
>      +
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>      +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>           Signed-off-by: Taylor Blau <me@ttaylorr.com>
> 
>        ## sequencer.c ##
> 2:  be0a662f863c ! 2:  0e34efb31d89 rebase: stop exporting GIT_REFLOG_ACTION
>      @@ Commit message
>           reflog_action.
> 
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>      +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>           Signed-off-by: Taylor Blau <me@ttaylorr.com>
> 
>        ## builtin/rebase.c ##
> -- snap --
> 
> And that superseded iteration of `pw/rebase-no-reflog-action` _did_ hit
> `next`.
> 
> Ciao,
> Dscho
> 
>>
>> Best Wishes
>>
>> Phillip
>>
>>> * pw/rebase-no-reflog-action (2022-11-09) 2 commits
>>>    (merged to 'next' on 2022-11-14 at 790dadc8d3)
>>>    + rebase: stop exporting GIT_REFLOG_ACTION
>>>    + sequencer: stop exporting GIT_REFLOG_ACTION
>>>    (this branch is used by ab/merge-index-prep.)
>>>
>>>    Avoid setting GIT_REFLOG_ACTION to improve readability of the
>>>    sequencer internals.
>>>
>>>    Will cook in 'next'.
>>>    source:
>>>    <31df037eafede799c2ef27df66c6da309b719b1b.1668003719.git.gitgitgadget@gmail.com>
>>
>>
