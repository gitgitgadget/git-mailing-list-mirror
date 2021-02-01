Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79607C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8C164E46
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBAPsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhBAPsw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 10:48:52 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48497C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 07:48:12 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id e70so16667645ote.11
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 07:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Eybr3um07bb3ZevC/kM1lsXuiZd6vYaP0gvQcVIZKh8=;
        b=XVky1DHGNZKzuR7X2iyImULSNd8eMZL8pDIpK0mkd+ocz+WlTyjXLOfuR/1h3mTgVS
         2Nsqk77guo5ho//uLXML+qipiq9GIyi51EFQj3lUfEdhi0F4iIYGh1l9/wXEfUlgrmZS
         QhzjlYJeKSAgpgOC+vUXAgODi5l2M8qa2n734UTjTjTXHHj/IPquD0u2C4pUYHfha7wl
         SD4c2upBNz9YFN517soTXtd+3EkDNNpz0cHYdOz9EzG76wov8NjHCbKj1ZNl4q4X+Un/
         pKOkhNApEEVZYeta4+ZdJWie3uryj4FNGvhlk1K2eVWXx40i0XdYAxQX2dG+Tnu4VIXI
         gUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Eybr3um07bb3ZevC/kM1lsXuiZd6vYaP0gvQcVIZKh8=;
        b=Ry+aYtFMTEbNatGzaaIIjz47FfYXpVPaCLvCY0OppPiYc7GKNYcqUGIkoD4bxxnpmY
         hsJS3/YLIvXoELBfJpvq3wvZs3fw+9iswsY+Ss84/IZlne4AHp3V3OLrr1g4+RiuicP1
         MI2yhlj/FAwp7ijUE4euvxW7JyJy9K8SQxdZMCWdDQpcJS86B+Q7nKYRekBJlvDcRiJI
         5Goo7RZV7NssfrdBUb+s7cmVwLSYRept+/hK0e6odaJ/NB6sKBRPxQHtN6JUEcsOIthF
         QpDInz7Wa3zWCrqAYyN96YJOeDphxxj6IE0NvByGBgQ5Fa7PWpyYjQ0/OMa5RT5GrTqe
         qcUA==
X-Gm-Message-State: AOAM532q1lDqvaYleC9NbIsUTMYMGO6uWJq0CSi8lNGs5zuNgRYc3jNe
        YwqChLoFGgMCEzOBEy9RvFQ=
X-Google-Smtp-Source: ABdhPJwZzCnIEOEt557oM9OBl30CspKDq3OnqjeZCL63lQfADK/lwG1NTux2wbZmn6r067dX1XD0Ew==
X-Received: by 2002:a05:6830:56e:: with SMTP id f14mr11968573otc.85.1612194491626;
        Mon, 01 Feb 2021 07:48:11 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8497:2090:4038:7fd1? ([2600:1700:e72:80a0:8497:2090:4038:7fd1])
        by smtp.gmail.com with UTF8SMTPSA id s2sm4169671otk.45.2021.02.01.07.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 07:48:11 -0800 (PST)
Message-ID: <7a1a8990-59e7-d538-d382-446fdc270810@gmail.com>
Date:   Mon, 1 Feb 2021 10:48:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 0/5] Speed up remove_redundant()
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, me@ttaylorr.com,
        peff@peff.net, gitster@pobox.com,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
 <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2021 7:47 AM, Derrick Stolee via GitGitGadget wrote:
> My tests were on the Linux kernel repository, testing this command:
> 
>   git merge-base --independent $(git for-each-ref refs/tags --format="%(refname)")
> 
>        Before: 16.4s
> After Patch 1:  1.1s
> After Patch 2:  0.1s

During my testing of v2, I discovered how remove_redundant()
is being used as part of 'git log --simplify-merges'. So, here
are some performance numbers for the Linux kernel repository
with a full commit-graph and changed-path Bloom filters running

  git log --oneline -n10 --simplify-merges -- kernel/

Benchmark #1: old
  Time (mean ± σ):      5.770 s ±  0.030 s    [User: 5.551 s, System: 0.219 s]
  Range (min … max):    5.728 s …  5.827 s    10 runs
 
Benchmark #2: new
  Time (mean ± σ):      5.030 s ±  0.017 s    [User: 4.805 s, System: 0.224 s]
  Range (min … max):    4.999 s …  5.054 s    10 runs
 
Summary
  'new' ran
    1.15 ± 0.01 times faster than 'old'

Thanks,
-Stolee
