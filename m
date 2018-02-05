Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704BA1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 18:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeBESHt (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 13:07:49 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39031 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbeBESHs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 13:07:48 -0500
Received: by mail-qk0-f194.google.com with SMTP id d72so3556609qkc.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 10:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HTNdM/LjT7zZz5FeJXohBUwUxqbxYMJjHIUaKrei8vU=;
        b=mqGuFkrVH/Uwtnvw/TSB6AZ0m91nq7KKA1gUrnWHaF/gDho5gRtjLIAoHfzJK8jcy8
         yNrI7zljQk2PFQ9tFgaeHWzvAaGfHY9A7/x0kvRmDuygX50kLpgF89zf2i3Gqj79x9z9
         CmovjyE+pLL7QwdpN1n9SGogeE2bUvirkaSt6njF/hPKRL8VwHanpPtjR/rExk27hdkU
         aqG8iLkxi+uQkj2VzaxKGdmoX3EezrbPAgeXBjmJe9nrAMjw38OqRHi2f+4H5TjU3iyL
         HdzP7gpLZ6VG9a9CTP2D8b4ndewv3Vi/bmmH0APhSP7Equfig2mRcXhabljVtBrXpBXS
         v4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HTNdM/LjT7zZz5FeJXohBUwUxqbxYMJjHIUaKrei8vU=;
        b=DP+FcNHbgyXirb3Z+/MBRZWOBnaZnfwMv/uQy9CZJ54TLN3yNY8gsQlk9hCuHR/j0k
         PUUkFsL8eEq3hDn1KBMsAsgnISm8N8T+xp1Q6N2Bfw3RvA+1VQ/tDPIsonxjzrUFnxv/
         RoiVz3j5BN7IRxq3y/3fO9K2p0BoSe0sWNAbO1Vi2xvDfJ6pSPx5vdgD7ji6arm8xJWQ
         nRe+Z+Ztp6qGwliAW6jEvPcZpssTRjcPAe1Bj0HQibzmBRh6DVy1GdYNXQ8Pik29OClk
         8SkTScnDhjELPM+G0YaJ/aFc+lSXAngkX9a5gajQe+NOu8O/O7hwqq5+cUz5Kgo3hFaZ
         M/tA==
X-Gm-Message-State: APf1xPC1XMHH80Z7hxfYo0UnvctsdXrMRrjsrwaFQA02ogIdGdFbIiTp
        ohzbWaJIDpXqHU8KWqAWbKA=
X-Google-Smtp-Source: AH8x226V6+OG3noITv6zkfrX+6EJ2ICx+LldgeB0eFdkWBUIXbs+pg+qL3kn81rPrOkNcwEV9iPY1w==
X-Received: by 10.55.157.151 with SMTP id g145mr12299575qke.159.1517854067289;
        Mon, 05 Feb 2018 10:07:47 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 23sm6606692qtx.33.2018.02.05.10.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2018 10:07:46 -0800 (PST)
Subject: Re: [PATCH v2 05/14] commit-graph: implement git-commit-graph --write
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1517348383-112294-6-git-send-email-dstolee@microsoft.com>
 <20180201234805.7506-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6c05d38c-c9fe-e5e5-8081-c862de49d8dc@gmail.com>
Date:   Mon, 5 Feb 2018 13:07:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180201234805.7506-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2018 6:48 PM, SZEDER Gábor wrote:
>> Teach git-commit-graph to write graph files. Create new test script to verify
>> this command succeeds without failure.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/git-commit-graph.txt | 18 +++++++
>>   builtin/commit-graph.c             | 30 ++++++++++++
>>   t/t5318-commit-graph.sh            | 96 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 144 insertions(+)
>>   create mode 100755 t/t5318-commit-graph.sh
>>
>> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
>> index c8ea548dfb..3f3790d9a8 100644
>> --- a/Documentation/git-commit-graph.txt
>> +++ b/Documentation/git-commit-graph.txt
>> @@ -5,3 +5,21 @@ NAME
>>   ----
>>   git-commit-graph - Write and verify Git commit graphs (.graph files)
>>   
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git commit-graph' --write <options> [--pack-dir <pack_dir>]
>> +
> What do these options do and what is the command's output?  IOW, an
> 'OPTIONS' section would be nice.
>
>> +EXAMPLES
>> +--------
>> +
>> +* Write a commit graph file for the packed commits in your local .git folder.
>> ++
>> +------------------------------------------------
>> +$ git commit-graph --write
>> +------------------------------------------------
>> +
>> +GIT
>> +---
>> +Part of the linkgit:git[1] suite
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> new file mode 100755
>> index 0000000000..6bcd1cc264
>> --- /dev/null
>> +++ b/t/t5318-commit-graph.sh
>> @@ -0,0 +1,96 @@
>> +#!/bin/sh
>> +
>> +test_description='commit graph'
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup full repo' \
>> +    'rm -rf .git &&
>> +     mkdir full &&
>> +     cd full &&
>> +     git init &&
>> +     git config core.commitgraph true &&
>> +     git config pack.threads 1 &&
> Does this pack.threads=1 make a difference?
>
>> +     packdir=".git/objects/pack"'
> We tend to put single quotes around tests like this:
>
>    test_expect_success 'setup full repo' '
>          do-this &&
>          check-that
>    '
>
> This is not a mere style nit: those newlines before and after the test
> block make the test's output with '--verbose-log' slightly more
> readable.
>
> Furthermore, we prefer tabs for indentation.

Oops! My bad for using t5302-pack-index.sh as my model for creating test 
scripts. It's pretty old, but I do see some of the newer tests using 
this newer style.

> Finally, 'cd'-ing around such that it affects subsequent tests is
> usually frowned upon.  However, in this particular case (going into
> one repo, doing a bunch of tests there, then going into another repo,
> and doing another bunch of tests) I think it's better than changing
> directory in a subshell in every single test.
>
>> +
>> +test_expect_success 'write graph with no packs' \
>> +    'git commit-graph --write --pack-dir .'
>> +
>> +test_expect_success 'create commits and repack' \
>> +    'for i in $(test_seq 5)
>> +     do
>> +        echo $i >$i.txt &&
>> +        git add $i.txt &&
>> +        git commit -m "commit $i" &&
>> +        git branch commits/$i
>> +     done &&
>> +     git repack'
>> +
>> +test_expect_success 'write graph' \
>> +    'graph1=$(git commit-graph --write) &&
>> +     test_path_is_file ${packdir}/graph-${graph1}.graph'
> Style nit:  those {} around the variable names are unnecessary, but I
> see you use them a lot.
>
>> +
>> +t_expect_success 'Add more commits' \
> This must be test_expect_success.
>
>> +    'git reset --hard commits/3 &&
>> +     for i in $(test_seq 6 10)
>> +     do
>> +        echo $i >$i.txt &&
>> +        git add $i.txt &&
>> +        git commit -m "commit $i" &&
>> +        git branch commits/$i
>> +     done &&
>> +     git reset --hard commits/3 &&
>> +     for i in $(test_seq 11 15)
>> +     do
>> +        echo $i >$i.txt &&
>> +        git add $i.txt &&
>> +        git commit -m "commit $i" &&
>> +        git branch commits/$i
>> +     done &&
>> +     git reset --hard commits/7 &&
>> +     git merge commits/11 &&
>> +     git branch merge/1 &&
>> +     git reset --hard commits/8 &&
>> +     git merge commits/12 &&
>> +     git branch merge/2 &&
>> +     git reset --hard commits/5 &&
>> +     git merge commits/10 commits/15 &&
>> +     git branch merge/3 &&
>> +     git repack'
>> +
>> +# Current graph structure:
>> +#
>> +#      M3
>> +#     / |\_____
>> +#    / 10      15
>> +#   /   |      |
>> +#  /    9 M2   14
>> +# |     |/  \  |
>> +# |     8 M1 | 13
>> +# |     |/ | \_|
>> +# 5     7  |   12
>> +# |     |   \__|
>> +# 4     6      11
>> +# |____/______/
>> +# 3
>> +# |
>> +# 2
>> +# |
>> +# 1
>> +
>> +test_expect_success 'write graph with merges' \
>> +    'graph2=$(git commit-graph --write) &&
>> +     test_path_is_file ${packdir}/graph-${graph2}.graph'
>> +
>> +test_expect_success 'setup bare repo' \
>> +    'cd .. &&
>> +     git clone --bare full bare &&
>> +     cd bare &&
>> +     git config core.graph true &&
>> +     git config pack.threads 1 &&
>> +     baredir="objects/pack"'
>> +
>> +test_expect_success 'write graph in bare repo' \
>> +    'graphbare=$(git commit-graph --write) &&
>> +     test_path_is_file ${baredir}/graph-${graphbare}.graph'
>> +
>> +test_done
>> -- 
>> 2.16.0.15.g9c3cf44.dirty
>

