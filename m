Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E5831F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 11:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeJKS1P (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 14:27:15 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:34406 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeJKS1P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 14:27:15 -0400
Received: by mail-qt1-f180.google.com with SMTP id o17-v6so9281729qtr.1
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 04:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LKJaTLUlgK2aS6eBwetp7PK/Tn7nKVrtcY0WGJLGecE=;
        b=KIgZc3Prxvn8kcsB4lN189HK+96XrXoGEvFdEbpFED1Np8EXUj9GugqM59nxmcTMHe
         kU4uwdXu12UB5KQql9XbMKkYGClXYSrNQ2oReCeH/XSTHQsFHcMeJbB4j8F7sXlwYSQa
         XmqoqcNo6TPAo5mjznntCqwNu8/MucDro1u0NYIGbIkbcUQb+EwgzE0oNst3begNb1ev
         hE1rhROYtK2YjdCRLPnfsJ9IJPC8y6OoGqBDGcn/iUmznCIymIlGAKZ8XgsOCeQpO0jv
         SRP+8dfrVOtyVfC7fq/5pgFKKP5rGZafe8OGFgU4ckc1y0WkhPQhYuyzWHBhPbhvvYI8
         WQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LKJaTLUlgK2aS6eBwetp7PK/Tn7nKVrtcY0WGJLGecE=;
        b=gRklEoOKK6rEa6OPdfVHebJvvyjN55nOhMnnFTIQVAxRq3aoM4RPFkPBVngiC5tOba
         N1MW9OsHFKyf2/N7V6/mRG1v6Pfi46sMFMQoY4hLm5vm97tOUgCjhD7PzAwM8Q8nnZqu
         ib3qpc2pnl/BaJRP33DlF0ENFYYTIyw5eiGms217tDttLAoshj4pAL0imhmvsl4jx0SE
         oweJQMj0se0w5nWjI7k65JZPB1II7H2p8EfV3yHY1A6WEWfhSrP1sdRdl2TplQaWOOvz
         0eg4gQtAUEmdG/QxS1Um5SdqXxynVtMfnhkMizzbOMHQlYzC0Sy/VcVrJU7dMzIsIeSG
         /TOQ==
X-Gm-Message-State: ABuFfoisGxhHkgfjmhLBdkfCecAGdMPk/D34Ffaqi5AzhgzfFZ1Tx/rw
        2QqckI1xS6ABJJ1AdNXSyJ8KlHOg
X-Google-Smtp-Source: ACcGV60mwn0fZcWBYIqxXknZyvXmLwiwgrulel5cf7VKbZFsga+MUFC+MqFl+XfeopVlH+QQ9Rj6LQ==
X-Received: by 2002:aed:3ec2:: with SMTP id o2-v6mr986491qtf.26.1539255631686;
        Thu, 11 Oct 2018 04:00:31 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id n16-v6sm11421802qkg.5.2018.10.11.04.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 04:00:30 -0700 (PDT)
Subject: Re: [RFC PATCH 6/6] commit-reach: fix first-parent heuristic
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
References: <2ba9d81a-5578-a81c-a7d9-179864cb4277@gmail.com>
 <20180906151309.66712-1-dstolee@microsoft.com>
 <20180906151309.66712-7-dstolee@microsoft.com>
 <20181011015007.GA40329@aiede.svl.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <58d2959a-ffb1-13ba-26f1-84fc2953fcc3@gmail.com>
Date:   Thu, 11 Oct 2018 07:00:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181011015007.GA40329@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2018 9:50 PM, Jonathan Nieder wrote:
> Hi,
>
> Derrick Stolee wrote:
>
>>   commit-reach.c        | 4 +++-
>>   t/t6600-test-reach.sh | 2 +-
>>   2 files changed, 4 insertions(+), 2 deletions(-)
> I like this testing technique, and the test passes for me.
>
> Except: if I put
>
> 	CC = cc -m32
> 	NO_OPENSSL = YesPlease
> 	NO_CURL = YesPlease
>
> in config.mak (the first line to force 32-bit pointers, the others
> to avoid some dependencies on libs that I don't have 32-bit versions
> of), then the test fails for me:
>
>   $ ./t6600-test-reach.sh -v -x -i
>   [...]
>   expecting success:
>           cp commit-graph-full .git/objects/info/commit-graph &&
>           run_and_check_trace2 can_all_from_reach_with_flag num_walked 19 input \
>                   "test-tool reach can_all_from_reach"
>
>   ++ cp commit-graph-full .git/objects/info/commit-graph
>   ++ run_and_check_trace2 can_all_from_reach_with_flag num_walked 19 input 'test-tool reach can_all_from_r
>   each'
>   ++ CATEGORY=can_all_from_reach_with_flag
>   ++ KEY=num_walked
>   ++ VALUE=19
>   ++ INPUT=input
>   ++ COMMAND='test-tool reach can_all_from_reach'
>   +++ pwd
>   ++ GIT_TR2_PERFORMANCE='/usr/local/google/home/jrn/src/git/t/trash directory.t6600-test-reach/perf-log.t
>   xt'
>   ++ test-tool reach can_all_from_reach
>   can_all_from_reach(X,Y):1
>   ++ cat perf-log.txt
>   ++ grep 'category:can_all_from_reach_with_flag key:num_walked value:19'
>   error: last command exited with $?=1
>   not ok 11 - can_all_from_reach:perf
>   #
>   #               cp commit-graph-full .git/objects/info/commit-graph &&
>   #               run_and_check_trace2 can_all_from_reach_with_flag num_walked 19 input \
>   #                       "test-tool reach can_all_from_reach"
>   #
>
> When I cat perf-log.txt, I see
>
>    ..category:can_all_from_reach_with_flag key:num_walked value:20
>
> instead of the expected 19.
It is possible this is related to the sort-order problem reported and 
fixed by Rene [1]. I'll look into it in any case.

[1] 
https://public-inbox.org/git/dca35e44-a763-bcf0-f457-b8dab53815cf@web.de/
