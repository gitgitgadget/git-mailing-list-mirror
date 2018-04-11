Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4419A1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 19:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756504AbeDKT6l (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 15:58:41 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:43460 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754765AbeDKT6i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 15:58:38 -0400
Received: by mail-pf0-f175.google.com with SMTP id u8so1195156pfg.10
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sjyXRd0Hmo+Jqx0ZqhdHJLUiY6fJmA8h5J6Wjmh9mjw=;
        b=spKG3jGqVl4+zfHxEQBCRfXngNaEJxBBM4Is6Q7U6HgKRwKXIy0TEJ/RptIh5s6l8H
         0nuWunc1fX147Sy7ZWdvLXlZRWCsu+m9i5alxH+CAv8sMAcaVh/djc0aYRllk18XVeHT
         HZkBPjlkAVg3PVfpEUQUWPu9GiymOclmRv2VZWFMZWKUXggSRmk82G+1vN8OaU2Bzq+M
         yQsWuIrPL7FOKA96t+QbAxCgyFXZnMBkF/bBnu5RsOq7ZybVBPI48WpQ6/8JLBOy2kno
         h4yyqoh8czWtObdY3TwItKhNqmpH6FJVU3BfHmf1IUNkvrSQtRta0NE8+5814jbJS1iQ
         PziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sjyXRd0Hmo+Jqx0ZqhdHJLUiY6fJmA8h5J6Wjmh9mjw=;
        b=rGvlwstGbpO7WLdNTDdJ2fdQib1GSveQ56sZTQp2tZWrOHQVI+1BJQkdvMZf5BGESZ
         M8cOPP0mGjpZ2gbYAA9n96B5CAYnKwBaBO2VlRoz5l3IWqxh8rKvlD6QXExNQDy6Sdci
         LvJHQJdpRoKqlMyKy0V8FJ+rcczrG3LX2wD8hsJAHOB82QIN4AChAPFYaHm3hltqSCZu
         BznvpTSvcrklxmQLPqauzKg0NEu5vI/cS95FCUPhfpVGUkEukx2XMCBO8NKTKb1L7/js
         7kwRz/v+MDA7walA7umkhDiRp/fI/GO8GT4EA7IPlluAbZA8vdrezOEseaf1LsQU/Tnk
         jXFQ==
X-Gm-Message-State: ALQs6tCGThUlDkMIVGG+aJR3t+nh7R2o90nPZK2KqMdoZtEx8LPwDZIW
        aeFLXGFMR1fOIJUjuIwNk6Q=
X-Google-Smtp-Source: AIpwx48gb5Ae/+C1rcqfv6ciGKSUvQfoCx/7pAU2drocL+L5kchFydUuxrI58FDqS9l3ATeky2UyUg==
X-Received: by 10.98.238.3 with SMTP id e3mr5140056pfi.88.1523476717452;
        Wed, 11 Apr 2018 12:58:37 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id g26sm5886396pfk.173.2018.04.11.12.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Apr 2018 12:58:36 -0700 (PDT)
Subject: Re: [PATCH 0/6] Compute and consume generation numbers
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <867epjez1n.fsf@gmail.com> <07abd2ce-e042-fe3c-b2db-3d2f2aa44de8@gmail.com>
 <868t9t5yjz.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <45320265-9fec-cee1-e82c-3ff719bb0435@gmail.com>
Date:   Wed, 11 Apr 2018 15:58:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <868t9t5yjz.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/11/2018 3:32 PM, Jakub Narebski wrote:
> What would you suggest as a good test that could imply performance? The
> Google Colab notebook linked to above includes a function to count
> number of commits (nodes / vertices in the commit graph) walked,
> currently in the worst case scenario.

The two main questions to consider are:

1. Can X reach Y?
2. What is the set of merge-bases between X and Y?

And the thing to measure is a commit count. If possible, it would be 
good to count commits walked (commits whose parent list is enumerated) 
and commits inspected (commits that were listed as a parent of some 
walked commit). Walked commits require a commit parse -- albeit from the 
commit-graph instead of the ODB now -- while inspected commits only 
check the in-memory cache.

For git.git and Linux, I like to use the release tags as tests. They 
provide a realistic view of the linear history, and maintenance releases 
have their own history from the major releases.

> I have tried finding number of false positives for level (generation
> number) filter and for FELINE index, and number of false negatives for
> min-post intervals in the spanning tree (for DFS tree) for 10000
> randomly selected pairs of commits... but I don't think this is a good
> benchmark.

What is a false-positive? A case where gen(X) < gen(Y) but Y cannot 
reach X? I do not think that is a great benchmark, but I guess it is 
something to measure.

> I Linux kernel sources (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git)
> that has 750832 nodes and 811733 edges, and 563747941392 possible
> directed pairs, we have for 10000 randomly selected pairs of commits:
>
>    level-filter has    91 =  0.91% [all] false positives
>    FELINE index has    78 =  0.78% [all] false positives
>    FELINE index has 1.16667 less false positives than level filter
>
>    min-post spanning-tree intervals has  3641 = 36.41% [all] false
>    negatives

Perhaps something you can do instead of sampling from N^2 commits in 
total is to select a pair of generations (say, G = 20000, G' = 20100) or 
regions of generations ( 20000 <= G <= 20050, 20100 <= G' <= 20150) and 
see how many false positives you see by testing all pairs (one from each 
level). The delta between the generations may need to be smaller to 
actually have a large proportion of unreachable pairs. Try different 
levels, since major version releases tend to "pinch" the commit graph to 
a common history.

> For git.git repository (https://github.com/git/git.git) that has 52950
> nodes and 65887 edges the numbers are slighly more in FELINE index
> favor (also out of 10000 random pairs):
>
>    level-filter has   504 =  9.11% false positives
>    FELINE index has   125 =  2.26% false positives
>    FELINE index has 4.032 less false positives than level filter
>
> This is for FELINE which does not use level / generatio-numbers filter.

Thanks,
-Stolee

