Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D77DC433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C546221775
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbPlkruE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgHJQr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHJQr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 12:47:28 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F602C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 09:47:28 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m7so8916025qki.12
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AA6t1hf5K8xrSOnI5WfcMMfb5NETUdk22gQ/ctKB/0k=;
        b=PbPlkruEYPEzVOthwzj+g9ppP4atqVo2tTIqtSCpWJh1DSNVuK48RDVlG+PgJiY4Qv
         CqFodgjnYgTIQM7EAcjOMrnxh2IJjzgLpISaOu7TNwJnMdC5tv7JqDct6nUbxQHPe+q/
         3RSImLmjdJN0JefAtnY54qK4U4t5nJeyfkTdpCuk38x52RuL7NnS6AdAFrSRdvuQcpms
         LV8sPUiLAhJHZGgZhoiJCHeIwtZzNXov80e2AcGqZnc2qRWW+NudQoFDUFJ7TgPRrSdm
         MlUVv3lwDFNFJtfnF7Es9BByxElrPJ+WSv5M+WeFIb73oV5xgWHN39whQC3HfBw/f402
         q6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AA6t1hf5K8xrSOnI5WfcMMfb5NETUdk22gQ/ctKB/0k=;
        b=cx5sGinQNGmmJBZ61Mc9HG1MfkEFXkydokTbuKdlk+URP1BtAky9fIjrODJIvyXkZW
         lK8oLWqoxsJoRV6MRdFSTfHYdquwa9ELAKlO4sBM5zklh5rEaXxkh5ll7SBEVCaDcpYy
         +du+khVRE/bS13Y+PdLCpcudZ5pr1L7zNLVsTfm9hC2+ksdgg6CH7vrxluK2vRYYYL18
         wNrbi8zeGAQeOvSvrChsp8w1GtMlkW2GqDEUoFLMPtWZyQnuM9CwDTpbi2pK2mq1hC2x
         dWnAluXnqdrfaE73Qc+cuqrDJRm/kDoWmH73FeL7RbKSBwy0ze570Q8wi/aDU2WhtZPA
         7Paw==
X-Gm-Message-State: AOAM530x9wFNl95Mel6DTyMxvlfy8W+CGZvZ8qUPT0VCa+MViXL7H1+W
        slwJnpVdawvJPOxptafSKtyf+hS1WiI=
X-Google-Smtp-Source: ABdhPJx7lDznHGxDJEK0m4pkY65NODpB2UvK1KZ7A7L+ow6qlx6uZEwwzHvwWXkk0m1f619SYbNlpg==
X-Received: by 2002:a05:620a:89a:: with SMTP id b26mr25938060qka.175.1597078047769;
        Mon, 10 Aug 2020 09:47:27 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with ESMTPSA id y26sm15683731qto.75.2020.08.10.09.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 09:47:26 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] [GSoC] Implement Corrected Commit Date
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bf9ab386-39a0-e386-3828-4427fab3ee25@gmail.com>
Date:   Mon, 10 Aug 2020 12:47:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2020 10:53 PM, Abhishek Kumar via GitGitGadget wrote:
> This patch series implements the corrected commit date offsets as generation
> number v2, along with other pre-requisites.
> 
> Git uses topological levels in the commit-graph file for commit-graph
> traversal operations like git log --graph. Unfortunately, using topological
> levels can result in a worse performance than without them when compared
> with committer date as a heuristics. For example, git merge-base v4.8 v4.9 
> on the Linux repository walks 635,579 commits using topological levels and
> walks 167,468 using committer date.
> 
> Thus, the need for generation number v2 was born. New generation number
> needed to provide good performance, increment updates, and backward
> compatibility. Due to an unfortunate problem, we also needed a way to
> distinguish between the old and new generation number without incrementing
> graph version.
> 
> Various candidates were examined (https://github.com/derrickstolee/gen-test, 
> https://github.com/abhishekkumar2718/git/pull/1). The proposed generation
> number v2, Corrected Commit Date with Mononotically Increasing Offsets 
> performed much worse than committer date (506,577 vs. 167,468 commits walked
> for git merge-base v4.8 v4.9) and was dropped.
> 
> Using Generation Data chunk (GDAT) relieves the requirement of backward
> compatibility as we would continue to store topological levels in Commit
> Data (CDAT) chunk. Thus, Corrected Commit Date was chosen as generation
> number v2. The Corrected Commit Date is defined as:
> 
> For a commit C, let its corrected commit date be the maximum of the commit
> date of C and the corrected commit dates of its parents. Then corrected
> commit date offset is the difference between corrected commit date of C and
> commit date of C.
> 
> We will introduce an additional commit-graph chunk, Generation Data chunk,
> and store corrected commit date offsets in GDAT chunk while storing
> topological levels in CDAT chunk. The old versions of Git would ignore GDAT
> chunk, using topological levels from CDAT chunk. In contrast, new versions
> of Git would use corrected commit dates, falling back to topological level
> if the generation data chunk is absent in the commit-graph file.
> 
> Thanks to Dr. Stolee, Dr. Narębski, and Taylor for their reviews on the
> first version.
> 
> I look forward to everyone's reviews!
> 
> Thanks
> 
>  * Abhishek
> 
> 
> ----------------------------------------------------------------------------
> 
> Changes in version 2:
> 
>  * Add tests for generation data chunk.
>  * Add an option GIT_TEST_COMMIT_GRAPH_NO_GDAT to control whether to write
>    generation data chunk.
>  * Compare commits with corrected commit dates if present in
>    paint_down_to_common().
>  * Update technical documentation.
>  * Handle mixed graph version commit chains.
>  * Improve commit messages for
>  * Revert unnecessary whitespace changes.
>  * Split uint_32 -> timestamp_t change into a new commit.

This version looks to be in really good shape, for the most part. I feel
the need to point out that this is a very mature submission, and it covers
many of the bases we expect from a quality series, even at only the second
version.

My comments deal with some high-level "patch series strategy" considerations,
mostly. There are a few concerns about correctness in the complicated cases
of mixed commit-graphs with or without the GDAT chunk, and how we could
perhaps test those cases. The best way would be to update the 'verify'
subcommand to check the GDAT chunk. That's a good feature to have, but would
be unnecessary bloat to this series. Depending on timing, we might want to
hold this series in 'next' until such an implementation is submitted. (I
expect that Abhishek's GSoC internship would be over at that point, so I
volunteer to send those patches after this series stabilizes.)

Thank you for your careful work on such a complicated subject!

Thanks,
-Stolee

