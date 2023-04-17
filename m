Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABADC77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 21:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjDQVHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 17:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjDQVHT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 17:07:19 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8741E74
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 14:07:16 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1842e8a8825so32072730fac.13
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681765635; x=1684357635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WoK4n3qslRA+EySUgosdK24dHDw83jcF8tj+MhX+aN4=;
        b=NLb+nyG1LMOrC2xKbMaygfRCst/KpylrHAAydoqzBqkENWpOxmBCM1hBeMQZnrw2Qw
         NArsleghAd06ngLCqvMLx80YlH7qkkUgMvRGkOqcCCXu62TUajOuRL6wDW3w0wVsLevE
         Lf2qfMy3DUSXDf8hKt9w/9b9TMSRJ5CBB2WzTcw+eAXaGWaBqVIgil0TADLM3p28vhqs
         v2LO4iixsnXITs/7jucyfeo9HvCDLGji5IEJLH3REuYBpI9ecIYPQHYw3OahsmpIKxKC
         i+kO9Y+whEDcplBOg45jqWNOROp6fxy0am+jYtgdY32vRBIA9l2ysHdHG8v7BQ3dh9Wa
         wBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681765635; x=1684357635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoK4n3qslRA+EySUgosdK24dHDw83jcF8tj+MhX+aN4=;
        b=PBDaYez/tATAbam8ayyLMgR2wd2axx+6YweyscM4piS0c8RJTjl72PoSp+SOjeXtYR
         X1XoCaWoHHIOrCDsZFNbBTl+i7SOngoMAtZs4yCS2crl0RbchvfD2UJFuNyV3ay3BnuD
         w+IK3ELV0gCHqCabkIfVCzV7NZMxDerxXtgS6YQFcxUAP77MEpeABpFmQfZl2XDA7Wqy
         wAOANL7eaNSgv2/HAIfYtTr2+b0vG7azAVC/6ND74mfN/0vd/MmACQgBLlRPY406q9wb
         vkLPvl7AiCEuOapBvUy3TOzVG5RVlSLYPpiVzQuLVCyWTY0dw1O6cuDk9TxSvIZCM1yt
         5s6Q==
X-Gm-Message-State: AAQBX9cL6+pOoCDfzrQDxZ326AYLdOy7HgTNAvJe4eLvfgRV65h+CiIX
        ZWZaaH1IdlkNRdKkOqPN/7BN
X-Google-Smtp-Source: AKy350YTwnf71qGgXy8L9Jt32LzB/V1MlD5nULRSf7iQXrkjvT3ITm5gz9anWVw987otfJzYBzFSYA==
X-Received: by 2002:a05:6870:9589:b0:183:eb95:7166 with SMTP id k9-20020a056870958900b00183eb957166mr9300589oao.15.1681765635740;
        Mon, 17 Apr 2023 14:07:15 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e2-20020a056870c34200b0017299192eb1sm4992125oak.25.2023.04.17.14.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 14:07:15 -0700 (PDT)
Message-ID: <ce9ef1c6-23c1-2e9f-ed5f-3790e5ff3e1f@github.com>
Date:   Mon, 17 Apr 2023 17:07:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/23] Header cleanups (more splitting of cache.h and
 simplifying a few other deps)
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, Elijah Newren <newren@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/15/2023 11:03 PM, Elijah Newren via GitGitGadget wrote:
> This series continues to focus on splitting declarations from cache.h to
> separate headers. This series also untangles some dependencies between
> hash.h and repository.h, and between read-cache.c and tree.[ch], and cleans
> up a few other headers. At the end of this series the number of cache.h
> includes drops from 189 down to 149.

Thank you for continuing to do this work.

>  * Patch 14-16: move functions between hash<->repository and
>    read-cache<->tree to simplify dependencies

My only comment was on patch 14, where I'm not sure I like the methods
moving from hash.h to repository.h. If we can find an alternative, that
would make me happy.

The rest of the series looked very good.

Thanks,
-Stolee
