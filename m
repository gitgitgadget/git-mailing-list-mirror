Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33047C433F1
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08677207FC
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOW6/h80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbgG1QgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731434AbgG1Qf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:35:58 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572B9C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 09:35:58 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id u64so19205286qka.12
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FY3+1vCtt40578K9oIz1otU9P55zj/n67pAPeEYDWPM=;
        b=hOW6/h80TPOsAIsPDJCj4ITpD8ZNtXrAKQFASLbc6SGNEbVzys56OoXgyLiBqh/wjO
         FIPr0fJrOHHrz0GwdtNv3dYwlTOKMAyp7bYvcsfvJWBS1CJz/9ClThzlFhX+l2muu//Z
         ybyedyglu6rUdWNPw+mWotL+H/1dfNS7LM2iLTlDaKUzmX+2rpxgMIgN96eHhUhVIhq3
         sh3r6FCFAmZDCBb+Ilvn/LuHh8wn+Cv6XvnpneUg9ST5tqW7610NafGDbok09u8IK+qU
         pYXRtgCYWfF34e7bZ957YrWT27YiZEFlxFCO8hOFEvSenK971guBNysWp29NtiwSq7Bp
         FEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FY3+1vCtt40578K9oIz1otU9P55zj/n67pAPeEYDWPM=;
        b=NUjL0zlnwyp9M9XUG5gqZ/42W5sFGEq8RH/Ku5Lvt5CwedIIkkgV/EsNUH9QH/+fa6
         UFzzauvwfhm3MA+WVxOs3PScT5WWJY5PHyD2k5soZyuZVX+raP7/73eQJnUO/iJHGr92
         hxKUyuul7Gj6K1q5YsPpBAWU8fi4zHlAUgJf39eGMq4l0WO3JJtoU/ZQUIGjPh8Qv6Bf
         eCmX2mlIXPViHl5ePXIs0hmPzt72FCZglculsU52ASamwfueTRUYAenZ3TQByCNx5ntV
         vwQS/wcxGSIH92mZVbh+obFkDJercbYKkFikEo9EF/D6zFFQ/NFd9zbJoM1ExQExIoQY
         TVog==
X-Gm-Message-State: AOAM533NyeIOGGVsQtDUdvLf7KJNyTYxGthWsLlEb5pjy/4rGkpxqni7
        Mof1XjItozsmAKZaJMm/T9fYFji/ijGgvw==
X-Google-Smtp-Source: ABdhPJwniskg8c+R3eTWQfR1YvaOYbAtMNPojxO+/mabkY8EO9LMS27muUroRPN40XHBhbvuRg1sZA==
X-Received: by 2002:a37:4783:: with SMTP id u125mr29818058qka.172.1595954157445;
        Tue, 28 Jul 2020 09:35:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4854:557c:a990:d78e? ([2600:1700:e72:80a0:4854:557c:a990:d78e])
        by smtp.gmail.com with ESMTPSA id 205sm20700767qkj.19.2020.07.28.09.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 09:35:56 -0700 (PDT)
Subject: Re: [PATCH 0/6] [GSoC] Implement Corrected Commit Date
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2ae8e6e0-9bf7-4e47-2a93-5e5092abe77a@gmail.com>
Date:   Tue, 28 Jul 2020 12:35:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <pull.676.git.1595927632.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/28/2020 5:13 AM, Abhishek Kumar via GitGitGadget wrote:
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
> Here's what left for the PR (which I intend to take on with the second
> version of pull request):
> 
>  1. Add an option to skip writing generation data chunk (to test whether new
>     Git works without GDAT as intended).

This would be a good idea, if only as a GIT_TEST_* environment variable.
I think it important we have a test for the compatibility scenario where
we have an "old" commit-graph with the new code and test that reading and
writing still works properly.

>  2. Handle writing to commit-graph for mismatched version (that is, merging
>     all graphs into a new graph with a GDAT chunk).

This is an excellent thing to do. There are a few options when writing an
incremental commit-graph when the base graphs do not have the GDAT chunk:

   i. Do not write the GDAT chunk unless we are merging all levels
      (based on the merging strategy).

  ii. Merge all levels, then write the GDAT chunk.

>  3. Update technical documentation.

Yes, I was going to ask for a patch that updates
Documentation/technical/commit-graph-format.txt.

This is an excellent v1. A lot of small things, but no
really big issues.

Thanks,
-Stolee
