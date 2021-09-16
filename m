Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C73C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8934A60E76
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhIPFLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhIPFLq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:11:46 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA6EC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:10:26 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id v16so5447520ilg.3
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7+BIdccIHNVZL5ze8/uE1iIKwHM9o0AgEYmQ6B6yXf8=;
        b=cl4+LDuMG8zfmsk1t+tgvhW5oBlyiYRU4MCYjQF1iBDckXaO3PDbC+x91txXdFTqCn
         tSxD4OPT3rGvKpUuKGNWgxZHPp7AJjfT7BJl54GggfkPdc86Wwm+ItGyCIz2eO1XjvU9
         sk8z8NyAqn0Hf/UQp+h3q4rdu6enmij37/15eQL+cvj+srBho1hm07Rh+4ftgJAFd753
         PILbVA5Zrf6YPCHdslwrzVPGeZsDwDEFaiH3muUDCC2gi/xQYCmA2H/4VrqQFhoo0Quk
         W384WpPdQUqtjErLKfPjnyQc7pstCfTXefPbuSNHP6y5hkU769iF1FZMrReLnW/6jJed
         jJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7+BIdccIHNVZL5ze8/uE1iIKwHM9o0AgEYmQ6B6yXf8=;
        b=JwHdtJqnp6JpfdG3nYhs7o6Z980eKJ0LpWW5Re2h/U51Y3EevITxjIBXBu7f99pNUw
         kU+RHOttEl1AwrQMgDcXcy45x/+Ne9xytsfKwMDhRJY7NaRnVfjaSfuK7Ljj6Boa+Ysn
         wg549B5WuMDDxnsuRF8szI5TeEENe1flzpqnlQeS+xq2bEawiLQXmvF30wM6sD53ikNl
         9wJIU2JPBYcsraWzoZrCm2CC4JgTsfXSPvaufOpNswF+m7yEOMSaRsK4DdE/skYl+wFQ
         v0Eb5B96xe/HAHFyddSfp/jgsfwI33/4P9eb4f+infvXRW436cimc6JWQ0ek/CnkNQ4/
         ZbhQ==
X-Gm-Message-State: AOAM5321Ulr2u/NXxiHGWAdFWATKhWDbjrTkHRbn3Y2P/0zP9Le6l/CM
        yztLNpF3gx5rhFlcThzHZdvksA==
X-Google-Smtp-Source: ABdhPJwmjI3pWbaiLeq24BhbgpdJ1H0lAVsByjQbxa3ulHARfGUwf5PcECtzrVXWc5K8CskeX8Ld9Q==
X-Received: by 2002:a92:d14e:: with SMTP id t14mr2709561ilg.218.1631769025501;
        Wed, 15 Sep 2021 22:10:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r16sm1138877ile.66.2021.09.15.22.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 22:10:25 -0700 (PDT)
Date:   Thu, 16 Sep 2021 01:10:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Kyle Zhao <keyu98@qq.com>, kylezhao <kylezhao@tencent.com>
Subject: Re: [PATCH v2] pack-revindex.h: correct the time complexity
 descriptions
Message-ID: <YULRwFhL/T44ygpe@nand.local>
References: <pull.1039.git.1631695337775.gitgitgadget@gmail.com>
 <pull.1039.v2.git.1631696964072.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1039.v2.git.1631696964072.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 09:09:23AM +0000, Kyle Zhao via GitGitGadget wrote:
> From: kylezhao <kylezhao@tencent.com>
>
> Time complexities for pack_pos_to_midx and midx_to_pack_pos are swapped,
> correct it.

Great eyes! Thanks for noticing and fixing. I took a look through the
other three functions which convert between pack offset, pack position,
and index position, and those had the correct runtime noted.

But these two were swapped, and are now correct after your patch. Thanks
again.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
