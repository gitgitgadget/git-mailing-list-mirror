Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C84C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 15:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiBOPPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:15:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiBOPPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:15:16 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF0F3F308
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:15:04 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so23631595oov.3
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XmAGScGwmk+/rTIkwSYw9RYEV4SzSIIvSgn+Cwgm99I=;
        b=PFtmuJGoJSqR0nmc3SsTVlWOIPW7pmhXEMB2t8xKdN7f6zzjgxy/iMEWQHtWl94a2L
         rHJMgywNWl+fJde4LiY+nxnk17GZ2q8bavlIdjzijob++oObCwoI2pbsJeOrWA6SORnr
         1LpvNSliS0oZkvUR57dU7/lWSTQaNi10OtA6c4qeW37qyRr4G7OKrrS05jPFKbVuVhE9
         ckFTr+lMAiODrQRH/+EU6gMLfPi+FOyENqXFiX0T+mjgRHduzQN83oTXcF/WfrOlBhUE
         bK+K5tDlFrb6zXq0uq7s9f2sGGZOXNd/NxIZofe6+/gqbSHjmFa3q1K5L09y4JW6NMJa
         79Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XmAGScGwmk+/rTIkwSYw9RYEV4SzSIIvSgn+Cwgm99I=;
        b=bb9LH+XYSVrdj52t8V56c4zLvxXRC4oekqhZTQr9CFKLZrzLaZqWYIhfcpSpjGyS7z
         3/X9rrLn3szT8YjqQE5OtT6w45eBgvg00VupVAx14WkDL0DRjQhyK8+wl4wtE1lxfrn9
         pjGi0RbLs2WVvAVHJ/RkgBtmivIacleFTs0oKNMwpj6Ca54NXC/IhA0n4QW01ASwftRK
         zPkAX0xAJb8VfmmfIXkhViO/5u8vEjZ7zCWrAx4SFos7hRFpx3c2QmjJ4LPtHbmZ5p2c
         cDx/EVoodiMTbnKK692VM4GRjlx85FJOxXgf0aHmpnbzOXGd7s2u98jvBzsugH0XIuvq
         jR+A==
X-Gm-Message-State: AOAM533xJbR2xUEV4S9AVIv+jj2TivNbxFa3Njc93KzscWUAJquSeTKN
        eMuG1cualnO2BaslngIRc4VKoC3ABkJK
X-Google-Smtp-Source: ABdhPJxBH8yuYF5Iak7zE+bxq+Aic9yWlDPAWEQQP+t0a2SLv1+C+qla+OcgtzMu2+j+WZ6ZHQqqYQ==
X-Received: by 2002:a05:6870:134e:b0:d3:7659:e8b5 with SMTP id 14-20020a056870134e00b000d37659e8b5mr149440oac.131.1644938103913;
        Tue, 15 Feb 2022 07:15:03 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j2sm8211446oon.18.2022.02.15.07.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 07:15:03 -0800 (PST)
Message-ID: <367e277c-e26d-94be-7989-e2ddf7010ad0@github.com>
Date:   Tue, 15 Feb 2022 10:15:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 0/6] sparse checkout: fix a few bugs and check argument
 validity for set/add
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 3:32 AM, Elijah Newren via GitGitGadget wrote:
> == Maintainer notes ==
> 
> Note1: This has been rebased on origin/master. v1 wasn't picked up anyway,
> so this shouldn't matter, but just pointing it out.
> 
> Note2: There is a small textual and small semantic conflict with
> ds/sparse-checkout-requires-per-worktree-config in seen. I included the diff
> with the correct resolution near the end of this cover letter.
> 
> == Overview ==
> 
> This series continues attempts to make sparse-checkouts more user friendly.
> A quick overview:
> 
>  * Patches 1-2 fix existing bugs from en/sparse-checkout-set (i.e. in
>    v2.35.0)
>  * Patch 3 fixes sparse-checkout-from-subdirectories-ignores-"prefix" (see
>    https://lore.kernel.org/git/29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com/),
>    in cone mode. Since we'll get nasty surprises whether we use or don't use
>    "prefix" for non-cone mode, simply throw an error if set/add subcommands
>    of sparse-checkout are run from a subdirectory.
>  * Patches 4-6 check positional arguments to set/add and provide
>    errors/warnings for very likely mistakes. It also adds a --skip-checks
>    flag for overridding in case you have a very unusual situation.
> 
> == Update history ==
> 
> Changes since v1:
> 
>  * Dropped the commit changing cone-mode to default (patch 7, which will be
>    split into multiple patches and submitted as a separate series)
>  * Removed the RFC label
>  * Decided to error out when running set/add with paths from a subdirectory
>    in non-cone mode, and added tests
>  * Changed the warning for non-cone mode with individual files to point out
>    that the user is likely trying to select an individual file, but should
>    likely add a leading slash to ensure that is what happens
>  * Fixed typos, removed unnecessary condition checks

Thanks for these updates.

We already discussed the changes that are different from my recommendations,
and I agree with your new approach in those.

I read the range-diff carefully and found this version to resolve all of my
concerns with v1.

Reviewed-by: Derrick Stolee <derrickstolee@github.com>

Thanks,
-Stolee


 
