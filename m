Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B30D61F404
	for <e@80x24.org>; Sun,  8 Apr 2018 01:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeDHBRw (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 21:17:52 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44764 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbeDHBRv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 21:17:51 -0400
Received: by mail-qk0-f195.google.com with SMTP id n139so5449624qke.11
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 18:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wuu7fC0YD2nyu0oLZYkyQiTMqIeLL8aPQP5mB/mA8WM=;
        b=AXo7/vlk5Qa1rpqQdAQ/N6ON5oI3tbbuUfNLAva1eyV/lYexu200yDfxFWBr0ZNO/7
         w26Twk9kmUd2Hu7uI5DXgMSjycXSbuLuF3n4jF4kaWwPo+TQ4FYh0gbhsxtyT+3ehSoM
         FkRUs2/5xWOzY5r2JAOkCqEHnS0frXLC/6jGgtrQZN+ekLNgZcnNz3hmWDc2h7Yy4CAy
         w1whbXFie9RwSraFwBpCO6ihArHvCi37GEKM8kV0PHNYcjtzYE44YLwM7skZbkcNmveb
         3R7dK69laFhr7yTOs5+kBiWKEnVWsXKjUqyFi6JNo9Y6ZzXCKvlNlkIVp5DtWmgwzc6N
         VSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wuu7fC0YD2nyu0oLZYkyQiTMqIeLL8aPQP5mB/mA8WM=;
        b=kNLg9VjkYrk+49ob2n8znoet8cx4gF7R6YXI9R7pxVnKVKfCwjjeN8l7rIgQ4v544+
         wLrgSTQxmkQQA7zHDHAHVmos2eP1prURqIz800MxDOoJkdzNra8Mp3n2/Me3ZfGaUWxj
         nY28WFgGh93kaEFLbwZlf0iyLQu1Z2fPUzP7D8AjWSl5+ZUDWChKFrQZzjj9c5ewJ7oU
         qFR9Lu1wtGLei9OKsxMYTZ4eNtuYPaJfo1IP9GKlXJ9EL7EfLm6539NtsoxbXaIhh6W8
         /iJzSOy8KvU4qhDH0yoCjjuTGXLTCQEtNDrigx6yCdUjOCrimWZ3BQB95w5YjUVAApAf
         cW3Q==
X-Gm-Message-State: ALQs6tCAt0elMesMganWd3EulYvfsDzUelNNeAQyQq+7RLUfIUIhtDtg
        NTx77pvFFs/pRNqBe29Q2MU=
X-Google-Smtp-Source: AIpwx4+uJt/Btz3IMdF4YsE1+BZ4w/h9HieujhniHutKoRCsk0n3S+KDO6Br9dHJS6mXroDPwFSL1Q==
X-Received: by 10.55.139.197 with SMTP id n188mr42384063qkd.212.1523150270652;
        Sat, 07 Apr 2018 18:17:50 -0700 (PDT)
Received: from [172.22.150.178] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id d52sm12340310qta.25.2018.04.07.18.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Apr 2018 18:17:50 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Lazy-load trees when reading commit-graph
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, peff@peff.net,
        sbeller@google.com, avarab@gmail.com, larsxschneider@gmail.com,
        gitster@pobox.com
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180406190919.167092-1-dstolee@microsoft.com> <86y3hyeu6c.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <eb861bc6-b9f0-ccaa-7cb6-abdb0d343c3d@gmail.com>
Date:   Sat, 7 Apr 2018 21:17:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <86y3hyeu6c.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/7/2018 2:40 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
> [...]
>> On the Linux repository, performance tests were run for the following
>> command:
>>
>>      git log --graph --oneline -1000
>>
>>      Before: 0.92s
>>      After:  0.66s
>>      Rel %: -28.3%
>>
>> Adding '-- kernel/' to the command requires loading the root tree
>> for every commit that is walked. There was no measureable performance
>> change as a result of this patch.
> In the "Git Merge contributor summit notes" [1] one can read that:
>
>> - VSTS adds bloom filters to know which paths have changed on the commit
>> - tree-same check in the bloom filter is fast; speeds up file history checks
>> - if the file history is _very_ sparse, then bloom filter is useful
> Could this method speed up also the second case mentioned here?  Can
> anyone explain how this "path-changed bloom filter" works in VSTS?
>    

The idea is simple: for every commit, store a Bloom filter containing 
the list of paths that are not TREESAME against the first parent. (A 
slight detail: have a max cap on the number of paths, and store simply 
"TOO_BIG" for commits with too many diffs.)

When performing 'git log -- path' queries, the most important detail for 
considering how to advance the walk is whether the commit is TREESAME to 
its first parent. For a deep path in a large repo, this is almost always 
true. When a Bloom filter says "TREESAME" (i.e. "this path is not in my 
set") it is always correct, so we can set the treesame bit and continue 
without walking any trees. When a Bloom filter says "MAYBE NOT TREESAME" 
(i.e. "this path is probably in my set") you only need to do the same 
work as before: walk the trees to compare against your first parent.

If a Bloom filter has a false-positive rate of X%, then you can possibly 
drop your number of tree comparisons by (100-X)%. This is very important 
for large repos where some paths were changed only ten times or so, the 
full graph needs to be walked and it is helpful to avoid parsing too 
many trees.


> Could we add something like this to the commit-graph file? 

I'm not sure if it is necessary for client-side operations, but it is 
one of the reasons the commit-graph file has the idea of an "optional 
chunk". It could be added to the file format (without changing version 
numbers) and be ignored by clients that don't understand it. I could 
also be gated by a config setting for computing them. My guess is that 
only server-side operations will need the added response time, and can 
bear the cost of computing them when writing the commit-graph file. 
Clients are less likely to be patient waiting for a lot of diff 
calculations.

If we add commit-graph file downloads to the protocol, then the server 
could do this computation and send the data to all clients. But that 
would be "secondary" information that maybe clients want to verify, 
which is as difficult as computing it themselves.

Thanks,

-Stolee

