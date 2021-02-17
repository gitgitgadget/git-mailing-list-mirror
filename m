Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C12C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 14:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F21FA64E02
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 14:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhBQOnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 09:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbhBQOmx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 09:42:53 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96390C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 06:42:11 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id n1so6414019edv.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 06:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=7TWBpniR5DYrRB+KwLZAqYQ7dgs2GcUd7OrdDV/+aRA=;
        b=hBYBShZl//bDprlgRSnx10ti4AbvsrpLe2J2bPjfQzatFDPtuvMIWPhH/uGU0YkmSY
         0f/h6eeZnSuJvazPZCNm6tWpm7Wf2dV9MG+QEKGq3IimD3uh8GGaG/wdvxQFJrjl/Wco
         qq6mGCYxaJkgTUDL3u6CJTLsaRIBX2DQpsA9LdyBrLLaMGg36ZHWYj4ks3EWUaEZaVUF
         J1zVBmZXWK61AyAxzwzZh4Mzx8f3ehYjAfiFUylb+fiwYPj8YjbXXLW8J4mkBtQrfVIo
         lt9Xu6srRO+DE4ot3K90c4mEW70ukxPlORh4/Vrxk8reFKMqCSFxCXK+35bUO6OoV4WX
         ACSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=7TWBpniR5DYrRB+KwLZAqYQ7dgs2GcUd7OrdDV/+aRA=;
        b=PvTTZvnYjYyPcIwDo/WF7UKW+1y+6PfYqfc/U1LMfdpI3Lvg3++1aQf4ymCpAhrmpp
         01P6taUBtouRkDa3p2hsa3O9pPpghvxWiR8LXRFtHRIBnYa5dlfusJMzuPMdqV7f3/s2
         uqeTZfl9mLoTw7ZqpkHcbcRnILXUz6P4UwOOmZcGvxzr4C3bvHg8+HpGlEmW/6X1XvUp
         gJzpfLGlf8mcSC/TYydd+YzyZaI7cEPvty2Wldw7A9M6oe7ovmjgD3OgdrVE5WLu8p63
         vWDq6AVRlYRvhkAWxXYKpmmDdyMf2SJypjVNA+xHVzxbf7va2LZ96eXZGaUFbyRaRUuF
         iE1A==
X-Gm-Message-State: AOAM531tA/Rl8SQVtusq/yohcrS9MnT7ynmek3qQzehXkyOxriILJBZz
        G9Mr3aGEksyIH4mbGJN+dgA=
X-Google-Smtp-Source: ABdhPJz7Am8PTQwzt1RXUwYtko6iEvjHDhJcpJkgYuGneNO2W1u6bUbtzXzMmX6BntRqt0kKIrVVJg==
X-Received: by 2002:a50:9f4e:: with SMTP id b72mr27328503edf.4.1613572930146;
        Wed, 17 Feb 2021 06:42:10 -0800 (PST)
Received: from cpm12071.fritz.box ([79.140.115.26])
        by smtp.gmail.com with ESMTPSA id gl7sm1104641ejb.59.2021.02.17.06.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 06:42:09 -0800 (PST)
References: <20210216163151.76307-1-rafaeloliveira.cs@gmail.com>
 <ce29b876-a5dd-76e9-bf79-5b917249b508@gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] blame: remove unnecessary use of get_commit_info()
Message-ID: <gohp6k1rdf588m.fsf@cpm12071.fritz.box>
In-reply-to: <ce29b876-a5dd-76e9-bf79-5b917249b508@gmail.com>
Date:   Wed, 17 Feb 2021 15:42:09 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Derrick Stolee <stolee@gmail.com> writes:

> On 2/16/2021 11:31 AM, Rafael Silva wrote:
>> Running Git PERF suite in linux.git, I've got a subtle performance
>> improvement for some runs:
>> 
>> 	# git.328c109303 - compiled git from commit 328c109303
>> 	# git.blame-patched - compiled git from commit 328c109303 + this patch
>>         Test                                          git.328c109303    git.blame-patched
>>         -------------------------------------------------------------------------------------
>>         blame --color-by-age kernel/fork.c            1.96(1.81+0.15)   1.95(1.80+0.14) -0.5%
>>         blame --color-by-age kernel/sys.c             1.67(1.53+0.13)   1.66(1.52+0.14) -0.6%
>>         blame --color-by-age mm/slab.c                2.16(2.00+0.16)   2.15(1.99+0.15) -0.5%
>>         blame --color-by-age lib/packing.c            0.20(0.14+0.05)   0.20(0.14+0.05) +0.0%
>>         blame --color-by-age drivers/cdrom/cdrom.c    1.62(1.46+0.15)   1.62(1.46+0.15) +0.0%
>>         blame --color-by-age crypto/crypto_engine.c   0.37(0.29+0.06)   0.36(0.28+0.06) -2.7%
>>         blame --color-by-age net/ipv4/ip_forward.c    1.49(1.35+0.13)   1.48(1.34+0.13) -0.7%
>
> Have you updated the commit-graph with changed-path Bloom filters in
> your copy of linux.git before running the perf tests? You might get
> smaller numbers overall (both sides) but make the difference for this
> patch be more pronounced:
>
> 	git commit-graph write --reachable --changed-paths
>

Thanks for pointing this out. I didn't updated the commit-graph in my
copy of linux.git when I ran the perf tests and indeed with the
commit-graph updated, the execution time is faster now.

Here's the results (best out of 3):

        # git.328c109303 - compiled git from commit 328c109303
        # git.blame-patched - compiled git from commit 328c109303 + this patch
        Test                                          git.328c109303   git.blame-patched
        ------------------------------------------------------------------------------------
        blame --color-by-age kernel/fork.c            1.13(0.96+0.17)  1.12(0.96+0.15) -0.9%
        blame --color-by-age kernel/sys.c             1.00(0.81+0.18)  0.98(0.81+0.15) -2.0%
        blame --color-by-age mm/slab.c                1.51(1.33+0.18)  1.49(1.31+0.17) -1.3%
        blame --color-by-age lib/packing.c            0.13(0.05+0.07)  0.12(0.04+0.07) -7.7%
        blame --color-by-age drivers/cdrom/cdrom.c    0.62(0.48+0.12)  0.61(0.48+0.12) -1.6%
        blame --color-by-age crypto/crypto_engine.c   0.16(0.08+0.08)  0.16(0.07+0.08) +0.0%
        blame --color-by-age net/ipv4/ip_forward.c    0.43(0.30+0.13)  0.42(0.29+0.11) -2.3%

For the "kernel/fork.c" example, there is around 1.7x improvement. The
percentage comparison is also bigger than it was before the commit-graph
file was updated with the changed paths Bloom Filter as you expected.

For the "net/ipv4/ip_forward.c" there a 3.4x improvements which I
believe is the biggest one in my tests.

-- 
Thanks
Rafael
