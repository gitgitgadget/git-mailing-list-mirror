Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFC7E1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755936AbeDKUl1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:41:27 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34048 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756149AbeDKUlT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 16:41:19 -0400
Received: by mail-lf0-f67.google.com with SMTP id x125-v6so4544732lff.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 13:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6OatJ2NaGQsPIunbED88e7wWz17VE45Lf5c4Wv+fY5k=;
        b=Vn8FZZnsBHpeU21jWFjWFmNNVnbjFDYqh/VeGtXJ2v9eB2MOn475wA0Xew4ejiPEEt
         LGmIOttq3M+1RhcD+WJJd0DS/Nsga7mlLswWrWulALRapDlmLuzZA9TP2ioIUpZBovnX
         dWt6LK/Nbi964epKXPvHVTZ+236/AMd3ZXeYhpgtDz/8YyvOwESGRFBeEkLriXwODpgr
         7nMo7uLgcGog1RqIkUOhawzXtx2zLzzNCbjUlQZa0PDMXDCzcufuABExeocZoK/BuxXR
         uxaTc3BkpDRsX6H9DW2o7NXPaBKo7YX9o8kIXWkrO8gZBFd3Cvquf6ORgxDnEn84Khzz
         DwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=6OatJ2NaGQsPIunbED88e7wWz17VE45Lf5c4Wv+fY5k=;
        b=J/XtiJ1tfJ0LKt0ra5jGq2IersfZhmKvVvu0DB4oREPA4hcAwDbD6EryMIhgQvuTFz
         XC009a6biVmOmMtLIqkzRpC/rkVubm27Vxv6rnbMN6SGtsWHUWMAzdUjwQBdPjy1WW/w
         hHE0D9q+NEdW+o6+eevq7C7noY88o0tUFBTGU0RvhhsNDgp/iTOl36PQCDPBEUKR2pxI
         Xsl2NeR+P2fMBOpk6Ooe1Ckb+VDMRRBBUwgI7gg+opu1HiGHlbTESv3eNSiAA8RRlqPV
         Np4pUY/VZlHls8lvV/3QZC4y0tgMcNBdpcTkV4CkM9zemjEe93oopHYYvwUtWPEaC5iQ
         PRAg==
X-Gm-Message-State: ALQs6tA3/FtKw7E8BAzy1IQAXUFQTZqLys1ocCwEzz9LmuSgM6+Vpi7U
        +LZ/0efzzUkv8INge0GLpX8=
X-Google-Smtp-Source: AIpwx4/MPynucJ97O45X+bwGlGzCkjyQfTzOnfpEhkLYRpUa+QA0ICzBOPlxiETdpN2ApZVcHneYfQ==
X-Received: by 10.46.134.25 with SMTP id a25mr3816581lji.87.1523479277357;
        Wed, 11 Apr 2018 13:41:17 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abrk101.neoplus.adsl.tpnet.pl. [83.8.104.101])
        by smtp.gmail.com with ESMTPSA id 63-v6sm400526lfr.61.2018.04.11.13.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 13:41:16 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>, peff@peff.net,
        sbeller@google.com, avarab@gmail.com, larsxschneider@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH v2 0/4] Lazy-load trees when reading commit-graph
References: <20180403120057.173849-1-dstolee@microsoft.com>
        <20180406190919.167092-1-dstolee@microsoft.com>
        <86y3hyeu6c.fsf@gmail.com>
        <eb861bc6-b9f0-ccaa-7cb6-abdb0d343c3d@gmail.com>
Date:   Wed, 11 Apr 2018 22:41:12 +0200
In-Reply-To: <eb861bc6-b9f0-ccaa-7cb6-abdb0d343c3d@gmail.com> (Derrick
        Stolee's message of "Sat, 7 Apr 2018 21:17:47 -0400")
Message-ID: <864lkh5vdj.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/7/2018 2:40 PM, Jakub Narebski wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:
>>
>> [...]
>>> On the Linux repository, performance tests were run for the following
>>> command:
>>>
>>>      git log --graph --oneline -1000
>>>
>>>      Before: 0.92s
>>>      After:  0.66s
>>>      Rel %: -28.3%
>>>
>>> Adding '-- kernel/' to the command requires loading the root tree
>>> for every commit that is walked. There was no measureable performance
>>> change as a result of this patch.
>>
>> In the "Git Merge contributor summit notes" [1] one can read that:
>>
>>> - VSTS adds bloom filters to know which paths have changed on the commit
>>> - tree-same check in the bloom filter is fast; speeds up file history c=
hecks
>>> - if the file history is _very_ sparse, then bloom filter is useful
>>
>> Could this method speed up also the second case mentioned here?  Can
>> anyone explain how this "path-changed bloom filter" works in VSTS?
>>=20=20=20=20
>
> The idea is simple: for every commit, store a Bloom filter containing
> the list of paths that are not TREESAME against the first parent. (A
> slight detail: have a max cap on the number of paths, and store simply
> "TOO_BIG" for commits with too many diffs.)

Isn't Bloom filter with all bits set to 1 equivalent of "too big"? It
would answer each query with "possibly in set, check it".

> When performing 'git log -- path' queries, the most important detail
> for considering how to advance the walk is whether the commit is
> TREESAME to its first parent. For a deep path in a large repo, this is
> almost always true. When a Bloom filter says "TREESAME" (i.e. "this
> path is not in my set") it is always correct, so we can set the
> treesame bit and continue without walking any trees. When a Bloom
> filter says "MAYBE NOT TREESAME" (i.e. "this path is probably in my
> set") you only need to do the same work as before: walk the trees to
> compare against your first parent.
>
> If a Bloom filter has a false-positive rate of X%, then you can
> possibly drop your number of tree comparisons by (100-X)%. This is
> very important for large repos where some paths were changed only ten
> times or so, the full graph needs to be walked and it is helpful to
> avoid parsing too many trees.

So this works only for exact file pathnames, or does checking for
subdirectory also work?  I guess it cannot work for globbing patterns
(like "git log -- '*.c'").

I guess that it speeds up "git log -- <pathname>", but also "git blame
<pathname>".


Sidenote: I have stumbled upon https://github.com/efficient/ffbf project
(fast-forward Bllom filters - for exact matching of large number of
patterns), where they invent cache-efficient version of Bloom filter
algorithm.  The paper that the project is based on also might be
interesting, if only because it points to other improvements of classic
Bloom filters.

>> Could we add something like this to the commit-graph file?=20
>
> I'm not sure if it is necessary for client-side operations, but it is
> one of the reasons the commit-graph file has the idea of an "optional
> chunk". It could be added to the file format (without changing version
> numbers) and be ignored by clients that don't understand it. I could
> also be gated by a config setting for computing them. My guess is that
> only server-side operations will need the added response time, and can
> bear the cost of computing them when writing the commit-graph
> file. Clients are less likely to be patient waiting for a lot of diff
> calculations.

So the problem is performing large amount of diff calculations.  I
wonder if it would be possible to add Bloom filters incrementally, when
for some reason we need to calculate diff anyway.

>
> If we add commit-graph file downloads to the protocol, then the server
> could do this computation and send the data to all clients. But that
> would be "secondary" information that maybe clients want to verify,
> which is as difficult as computing it themselves.

Can you tell us how much work (how much time) must spend the server to
calculate those per-commit "files changed" Bloom fillters?

Best,
--
Jakub Nar=C4=99bski
