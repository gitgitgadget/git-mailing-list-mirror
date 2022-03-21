Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E7FC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 19:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348355AbiCUTNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 15:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345444AbiCUTNh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 15:13:37 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83EB187B91
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 12:12:11 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id f3so6558648qvz.10
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PvOVoBrdHrmSn7Z1h/3XrOekTalX386URZrWpWCctWM=;
        b=a/GUgsLXZlTZNB+dd6PwcW93YbduLBH8tEAuwea4GX05h0va0QoBYN/4VkZcaT0JHL
         FCa9gcgPByqshEM5F2ZipMx0/YyVCkgPTcBdZaqpPGT2mSd6eXCzC8BZpRkxIwcHHShk
         cvez1OjqCe0ukCgtnkLXzcK1F5stkQA4WozcujhNvkhEmHsEUkOHahxOIgTvE/KtM1Fk
         B3rYkvs5IQmtX1hHebuqqNa43lufblUoub5bp1y9IEndNkrkFl+r6N7JSR8bkfOCu6av
         Fh6KvpBf8mzG2NEqtU8DyO9t0dvQipdjcJxqCgIExZI8i3kOkYBlEMMs2JtCLXR8eIbM
         RMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PvOVoBrdHrmSn7Z1h/3XrOekTalX386URZrWpWCctWM=;
        b=U7Mt7U2ODdD3SLZmFQIj+H6iQfWHgtUsSDHRd/HNWq5CVT9Dp5sFXmsl995FcVJImR
         ddpglZ6HdzKgIS9tfA6sYJclAeVj3ps0WxMHJBo9CQYPLUal7J7pRQ6WsXB4UonS4Jtt
         cK0mJgCo+QuOKNT6OrhrfekgW84V5Nvft5oVYQ3GysHEBwMWcpvX1oGbgZPr16jEgkbi
         gA0ju82RRBE95a6WkHR4nSfsdYAaaLSk3Go2+0D5Yjf71CzUTqzPz2eJQOi1V1efSiwl
         mpNvKivSymUmaMkVNvEfWGbTCGgJmJZBPICyrGuk5qAFnguf2WNNix00idz0tDN5AUt+
         fcrA==
X-Gm-Message-State: AOAM530VaK1hAhK/DGcIgKDpDaW2pGUxeOfRICdBKoFbKv3OveEamveV
        VWfVBzrkFPdpKLEyLUGWtF0lrmYIlrE2
X-Google-Smtp-Source: ABdhPJxlvOwRClcqF1mkrMBPRybnMSPYDw5RfBeQRSRGbC3cBJ0Hf4Fkeem0rW7ZMidZAs7IOs4eeA==
X-Received: by 2002:a05:6214:caa:b0:441:2e8f:f398 with SMTP id s10-20020a0562140caa00b004412e8ff398mr3153661qvs.61.1647889931109;
        Mon, 21 Mar 2022 12:12:11 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85756000000b002e1cabad999sm12739803qtx.89.2022.03.21.12.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 12:12:10 -0700 (PDT)
Message-ID: <b4803b58-018b-fb02-717f-95e48d6f844a@github.com>
Date:   Mon, 21 Mar 2022 15:12:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/3] Fix use of 'cache_bottom' in sparse index
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, Victoria Dye <vdye@github.com>
References: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
 <pull.1179.v2.git.1647532536.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1179.v2.git.1647532536.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2022 11:55 AM, Victoria Dye via GitGitGadget wrote:
> To fix this, the 'cache_bottom' advancement is reinstated in
> 'mark_ce_used(...)', and instead it is disabled in 'unpack_callback(...)' if
> the tree in question is a sparse directory. This corrects both the
> non-"cache diff" cases and the 'unpack_index_entry(...)' cases while
> preventing the double-advancement 17a1bb570b originally intended to avoid
> (patch [2/3]).

Thank you for digging deep and finding the root cause here _and_ the
correct fix.
 
> Finally, now that the cache bottom is advanced properly, we can revert the
> "performance improvement" introduced in f2a454e0a5 (unpack-trees: improve
> performance of next_cache_entry, 2021-11-29) that mitigated performance
> issues arising in 'next_cache_entry(...)' from the non-advancing
> 'cache_bottom' (patch [3/3]). The performance results in
> 'p2000-sparse-operations.sh' showed expected variability around 0% change in
> execution time (+/= 0.04s, depending on the command), with example results
> for potentially-affected commands below.
> 
> 'git reset'                      master            this_series                  
> ------------------------------------------------------------------------
> full-v3                          0.51(0.21+0.27)   0.50(0.21+0.25) -2.0%
> full-v4                          0.51(0.22+0.27)   0.50(0.21+0.24) -2.0%
> sparse-v3                        0.30(0.04+0.55)   0.28(0.04+0.50) -6.7%
> sparse-v4                        0.31(0.04+0.51)   0.29(0.04+0.51) -6.5%
> 
> 'git reset -- does-not-exist'    master            this_series                  
> ------------------------------------------------------------------------
> full-v3                          0.54(0.23+0.27)   0.55(0.22+0.28) +1.9%
> full-v4                          0.56(0.25+0.26)   0.54(0.24+0.26) -3.6%
> sparse-v3                        0.31(0.04+0.54)   0.31(0.04+0.50) +0.0%
> sparse-v4                        0.31(0.04+0.52)   0.31(0.04+0.50) +0.0%
> 
> 'git diff --cached'              master            this_series    
> -------------------------------------------------------------------------
> full-v3                          0.09(0.04+0.04)   0.09(0.04+0.04) +0.0%
> full-v4                          0.09(0.04+0.04)   0.09(0.04+0.04) +0.0%
> sparse-v3                        0.05(0.01+0.02)   0.05(0.01+0.03) +0.0%
> sparse-v4                        0.04(0.01+0.02)   0.04(0.01+0.02) +0.0%

I'm glad this also makes things simpler here. It's interesting that
it previously manifested only as a performance issue and not a
correctness issue.
  
I carefully read these patches and think they are ready to go.

Thanks,
-Stolee
