Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D019C433F5
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 19:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5175F61039
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 19:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbhJQThf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 15:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhJQThe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 15:37:34 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CAFC06161C
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 12:35:24 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id g14so9109249qvb.0
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LLgO5FlpuEAsL0Rx+X4tG/iMca8tpiMdeg/kOMzVSjg=;
        b=QdpW3lod/MpNrgBosTsJNBvp/8ehPdIPfbMrwC2FR8JaJlgtjdBqOI+k+wnzB0QKUu
         Xzm/BZ8iQ/ooFyuroKYCWLrantafZszYNnfX+42PESkaERJp3BUNs7GvbL2htc8dQMWb
         e1q87Qt8AHI5rF/siYThLuw7T0U7IFrhVLB4IuXMHl+tyr0C2Swr+mqgZso6Zo/rb2Y2
         jwJCXQJUTYKdC+5+l3WMmQ1IKJzbA3pnnHNKzx6V+Nbey2Of+taGVp16XeBnpSOGVuvO
         Qd96YZUimHLIw2grL6UIBZKR4Hbh4X2IuXVVpFbuxx8azq3pc5DyuGMN3YjWqD55auO7
         6faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LLgO5FlpuEAsL0Rx+X4tG/iMca8tpiMdeg/kOMzVSjg=;
        b=xI9o+NOfC6IPfyKJI7q6Prh9/XNL5LV6USSETM9frTobCg5Opq+9KlyCDxOrpohdSR
         PdPqJfClydWNhEw6alHOH9q6gqkc3g7KdfSE+jEG6j5XCDxRqrNHHQtpZGosFRs0Qb+F
         cUvPpYfomPgrz0ZgAS9J2l/ENgtM9XyWPW+bZJOJ/yhrptpE2ZP03qDx1dXXWSFCatFi
         u4K+Qd7KsudjDOCdcPMHVQ3uSyFlllTZuZVqps3ciGUJ/RmYnFWhLS6ruUYdCTqHBmn1
         kKaYwr8CYnbi1nz+uE4Db9hz0YekvDBGxMeVB1Hio69fiZYNx0hIs5+++qeZq89BigFX
         6RlQ==
X-Gm-Message-State: AOAM532sN+gAxCTeweVsjP4t8UGJUCAEd0ExulWPW+Pj9xjlyXEQDw5m
        Zqf7bUFRHwq0+5tdg4EoQnE=
X-Google-Smtp-Source: ABdhPJx020Biqye5R6Sslcc6AXlsX1n3BIUykqMFT0eIjHb6bTvyzyBw25GXYCzdWwTo0lL6KfZZyg==
X-Received: by 2002:a05:6214:6ad:: with SMTP id s13mr22132953qvz.12.1634499323903;
        Sun, 17 Oct 2021 12:35:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:90b3:b602:b30:17a8? ([2600:1700:e72:80a0:90b3:b602:b30:17a8])
        by smtp.gmail.com with ESMTPSA id 128sm5551214qkl.111.2021.10.17.12.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 12:35:23 -0700 (PDT)
Message-ID: <08129e78-a900-0688-572d-1b5b51709629@gmail.com>
Date:   Sun, 17 Oct 2021 15:35:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
 <pull.1053.v4.git.1634375229338.gitgitgadget@gmail.com>
 <xmqqilxw1a9v.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqilxw1a9v.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17/2021 1:38 AM, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>     [RFC] sparse index: fix use-after-free bug in cache_tree_verify()
>>     
>>     Changes since V3
>>     
>>      * removed "-q" from the test [1]. This is the same as V2 with a typo
>>        fixed in the commit message
>>     
>>     [1] https://lore.kernel.org/git/
>>     e281c2e2-2044-1a11-e2bc-5ab3ee92c300@gmail.com/
> 
> Thanks.  Unfortunately I've already merged the previosu version on
> the 11th, so I took the liberty of turning this round into an
> incremental.  How does this look?
> 
> ----- >8 --------- >8 --------- >8 --------- >8 -----
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> Date: Sat, 16 Oct 2021 09:07:09 +0000
> Subject: [PATCH] t1092: run "rebase --apply" without "-q" in the test
> 
> We run a few Git subcommands and make sure they produce identical
> results with and without sparse-index.  To this set of subcommands,
> an earlier commit added "rebase --apply", but did so with the "-q"
> option, in order to work around a breakge caused by a version used

s/breakge/breakage/

> at Microsoft with some unreleased changes.
> 
> Because we would want to make sure the commands produce indentical

s/indentical/identical/

> results, including reports given to the output that lists which
> commits were picked, use of "-q" loses too much interesting
> information.  Let's drop "-q" from the command invocation and
> revisit the issue when the problematic changes are upstreamed.

I think this summarizes the situation quite well. Thanks.

-Stolee
