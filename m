Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04885C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 13:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B0D64E2A
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 13:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhBANPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 08:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhBANPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 08:15:16 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E92AC061756
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 05:14:36 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id s77so2663020qke.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 05:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z+lHY5PpQCHSwp6DZdgq08sOYp65zbqgxo56pQkNync=;
        b=Sh0sC7w080eNxGEFgJfihRcLf/VYBDSz3i2avlbjAmYNg5OOGG25hS+hZER3BarsMn
         GfHSHobbxp/9LpYwOjyt7F4LE/SRdSdlE6Zn6pXRVxSicPMiyUIL+BexmuWYWQJfWwwH
         dQkObpljiRGL1t94+EHWS3ne8EF/7oUx1kj0opGbIFsaT4zxJru6K9Ak8lS3xDcFw9Fv
         uALhH+Zkyd1MHiX3+mc9z4d/8Tw5M+Ml0eO1NlqqXI7kgGpkChEHDcj3w9vNA5mCbn5V
         ywIIZt5BN+nQ48Y/momlaYrPuZJWrMUthSH4Ot9Yg8e4QBXD5PCHVz8A4KURkXmFp661
         8v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z+lHY5PpQCHSwp6DZdgq08sOYp65zbqgxo56pQkNync=;
        b=Hm+Tt61fUSd8g9qzNGuUuusvSKNaeuYdQy+Iv9LuUsAIu2RL78Ni2xBVUJzLI6uk/P
         eZXPYY9EHYXV15gAdGOag5UYexnpV3Ilyl3wCWpyRchdVNgcolPUdrJUAEJwEav+Z/iT
         Rofk7XFHkM2JB+oqqZyjKIuRLLCOBeHO9K5/0Kbabyspwu8Fr/h2pHamz6dupi9mBLNU
         yjDc9dwXnK81ANaN3ahrG7J0dbi5N7mf6KOB7W5D/QM6u9vxWQnE8da9gPlPizvKUwMw
         gSQpYrM/Oyde4Mr9zaC4BCTHbpqeLRAhpScaDW/mP+kMWrTR8WKbUTXDTX64vJQ5lyo8
         NhZQ==
X-Gm-Message-State: AOAM533LTLzl1A+JSaNupXZOdAM1Y1yZr4HILQBhReMXz4gT2D1cloin
        WWhPF86o4lQexBQefQjt27E=
X-Google-Smtp-Source: ABdhPJzc/sKbtDR7QXGcxl9lggSw1eiSjhafgh2iqviDgdv5V5HZ3Ur4XvEnHcNebVIjetHbMXsFww==
X-Received: by 2002:a37:642:: with SMTP id 63mr15866119qkg.311.1612185275214;
        Mon, 01 Feb 2021 05:14:35 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8497:2090:4038:7fd1? ([2600:1700:e72:80a0:8497:2090:4038:7fd1])
        by smtp.gmail.com with UTF8SMTPSA id g186sm14175852qke.0.2021.02.01.05.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 05:14:34 -0800 (PST)
Message-ID: <3c48f860-e743-afbe-63e8-99804036a965@gmail.com>
Date:   Mon, 1 Feb 2021 08:14:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v7 00/11] [GSoC] Implement Corrected Commit Date
Content-Language: en-US
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
 <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2021 1:58 AM, Abhishek Kumar via GitGitGadget wrote:

> Changes in version 7:
> 
>  * Moved the documentation patch ahead of "commit-graph: implement corrected
>    commit date" and elaborated on the introduction of generation number v2.

The only change in this version is this commit message:

>  11:  e571f03d8bd !  7:  8647b5d2e38 doc: add corrected commit date info
>      @@ Metadata
>       Author: Abhishek Kumar <abhishekkumar8222@gmail.com>
>       
>        ## Commit message ##
>      -    doc: add corrected commit date info
>      +    commit-graph: document generation number v2
>       
>      -    With generation data chunk and corrected commit dates implemented, let's
>      -    update the technical documentation for commit-graph.
>      +    Git uses topological levels in the commit-graph file for commit-graph
>      +    traversal operations like 'git log --graph'. Unfortunately, topological
>      +    levels can perform worse than committer date when parents of a commit
>      +    differ greatly in generation numbers [1]. For example, 'git merge-base
>      +    v4.8 v4.9' on the Linux repository walks 635,579 commits using
>      +    topological levels and walks 167,468 using committer date. Since
>      +    091f4cf3 (commit: don't use generation numbers if not needed,
>      +    2018-08-30), 'git merge-base' uses committer date heuristic unless there
>      +    is a cutoff because of the performance hit.
>      +
>      +    [1] https://lore.kernel.org/git/efa3720fb40638e5d61c6130b55e3348d8e4339e.1535633886.git.gitgitgadget@gmail.com/
>      +
>      +    Thus, the need for generation number v2 was born. As Git used to die
>      +    when graph version understood by it and in the commit-graph file are
>      +    different [2], we needed a way to distinguish between the old and new
>      +    generation number without incrementing the graph version.
>      +
>      +    [2] https://lore.kernel.org/git/87a7gdspo4.fsf@evledraar.gmail.com/
>      +
>      +    The following candidates were proposed (https://github.com/derrickstolee/gen-test,
>      +    https://github.com/abhishekkumar2718/git/pull/1):
>      +    - (Epoch, Date) Pairs.
>      +    - Maximum Generation Numbers.
>      +    - Corrected Commit Date.
>      +    - FELINE Index.
>      +    - Corrected Commit Date with Monotonically Increasing Offsets.
>      +
>      +    Based on performance, local computability, and immutability (along with
>      +    the introduction of an additional commit-graph chunk which relieved the
>      +    requirement of backwards-compatibility) Corrected Commit Date was chosen
>      +    as generation number v2 and is defined as follows:
>      +
>      +    For a commit C, let its corrected commit date  be the maximum of the
>      +    commit date of C and the corrected commit dates of its parents plus 1.
>      +    Then corrected commit date offset is the difference between corrected
>      +    commit date of C and commit date of C. As a special case, a root commit
>      +    with the timestamp zero has corrected commit date of 1 to distinguish it
>      +    from GENERATION_NUMBER_ZERO (that is, an uncomputed generation number).
>      +
>      +    While it was proposed initially to store corrected commit date offsets
>      +    within Commit Data Chunk, storing the offsets in a new chunk did not
>      +    affect the performance measurably. The new chunk is "Generation DATa
>      +    (GDAT) chunk" and it stores corrected commit date offsets while CDAT
>      +    chunk stores topological level. The old versions of Git would ignore
>      +    GDAT chunk, using topological levels from CDAT chunk. In contrast, new
>      +    versions of Git would use corrected commit dates, falling back to
>      +    topological level if the generation data chunk is absent in the
>      +    commit-graph file.
>      +
>      +    While storing corrected commit date offsets saves us 4 bytes per commit
>      +    (as compared with storing corrected commit dates directly), it's however
>      +    possible for the offset to overflow the space allocated. To handle such
>      +    cases, we introduce a new chunk, _Generation Data Overflow_ (GDOV) that
>      +    stores the corrected commit date. For overflowing offsets, we set MSB
>      +    and store the position into the GDOV chunk, in a mechanism similar to
>      +    the Extra Edges list chunk.
>      +
>      +    For mixed generation number environment (for example new Git on the
>      +    command line, old Git used by GUI client), we can encounter a
>      +    mixed-chain commit-graph (a commit-graph chain where some of split
>      +    commit-graph files have GDAT chunk and others do not). As backward
>      +    compatibility is one of the goals, we can define the following behavior:
>      +
>      +    While reading a mixed-chain commit-graph version, we fall back on
>      +    topological levels as corrected commit dates and topological levels
>      +    cannot be compared directly.
>      +
>      +    When adding new layer to the split commit-graph file, and when merging
>      +    some or all layers (replacing them in the latter case), the new layer
>      +    will have GDAT chunk if and only if in the final result there would be
>      +    no layer without GDAT chunk just below it.

While that is a quality message, v6 has landed in 'next' and I've begun
working off of that version. As Taylor attempted to say [1], this topic
should be considered final and updates should be follow-ups on top.

[1] https://lore.kernel.org/git/YBYLwpKdUfxCNwaz@nand.local/

(Of course, if Junio says differently, then listen to him.)

Thanks,
-Stolee

