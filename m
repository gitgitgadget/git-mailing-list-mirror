Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246D2C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 19:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244669AbiBTTo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 14:44:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiBTTo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 14:44:28 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729E530F46
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 11:44:06 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id q4so12544275qki.11
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 11:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WGEOIX3IJPx6zNcwFWCN+nJnHPEjpvj1pd9xU3CMwo8=;
        b=DnlFHL74ufmBUBmTlJYmdHT8N3tIMh1XJf14W+qdAw+3yh8oxWiQheEQCQ85VwrB7N
         dZ6AdHlpoG+NDDEjzk7PTfgSlCw3aICwCWFmXrx88U20BahNBgRNEVNiZFupb0L6P85e
         wYl+I6iCbA2DRfQJisc9CbvCHwL/rSP9j3Bb9n/4r4IVcrhA95Uw9DXkoXQkEUql2rHN
         wKpigFspO5ggGO1ORLqEoC2QIi//vYD4jmt1/m0+UHfTcD6ehiyV5YQkYqzpCWSW6hea
         tCQupAAm/xIj/VJcoU7yq2+Xbfe68/0hYnhOmEY5yhsC3kKBwmjFdK9OR6RQORJTEPgR
         fhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WGEOIX3IJPx6zNcwFWCN+nJnHPEjpvj1pd9xU3CMwo8=;
        b=H4668MpPdKTMC61KQo4upxhNb8hin2Oda91Q+H9w7zrmjz2vOp4dA/p3DbDH4aHVUs
         LbenWQaC4DXSDQlI/+OTw/1pt4P5sJ6eWel+QrpCkZH54skxYxYrEb8TiE8rksc3n5ku
         4ST829Jp5a+MApwJba77650wfEbui84SoFGuOFLxIrUkXRNfVNhYe1PGbYm+QJ0x067z
         /THmADXov+rd8EEcrfgUr9dNBph82iXXfwUqInI74OQADsP8yjA3dV0I6bI2yMjlOunT
         CHUctvuFSz4WK2fdLsm4a6ZrfF6DTas3Ym2IUeGZXpvGmTFxAIbEwh9qKmM2OX7LMUsC
         +hEw==
X-Gm-Message-State: AOAM533onVwPlYX+g45Z5gn8LK6FkAi9FyJ+wAleE1wpL6WQeJmRTlLF
        vkurWrAaFlJapijAXq1iV96s
X-Google-Smtp-Source: ABdhPJySBq2oQIG0t7xCH+SZvREkBh2/72Vkviu7011nKCi+Naggk8vCAvlfjsNTJmN5rQbcy+GE9w==
X-Received: by 2002:a05:620a:799:b0:60d:f1cc:b5cd with SMTP id 25-20020a05620a079900b0060df1ccb5cdmr9090152qka.489.1645386245572;
        Sun, 20 Feb 2022 11:44:05 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t6sm6172671qtn.59.2022.02.20.11.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 11:44:05 -0800 (PST)
Message-ID: <88f7f183-10a9-1a54-e940-52c31677ac66@github.com>
Date:   Sun, 20 Feb 2022 14:44:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 0/5] sparse checkout: fix a few bugs and check argument
 validity for set/add
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
References: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
 <pull.1118.v5.git.1645289086.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1118.v5.git.1645289086.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/19/2022 11:44 AM, Elijah Newren via GitGitGadget wrote:

> == Update history ==
> 
> Changes since v4:
> 
>  * have --skip-checks enable running from a subdirectory in non-cone mode
>  * make sure new die() messages are marked for translation (and using single
>    quotes instead of double)
> 
> Changes since v3:
> 
>  * Use strpbrk() instead of multiple strchr(), fix commit message relative
>    to backslashes.
> 
> Changes since v2:
> 
>  * Dropped patch 5
>  * Added Stolee's Reviewed-by

I looked at the range-diffs for these iterations and found the changes
to be acceptable. This version (still) looks good to go.

Thanks,
-Stolee
