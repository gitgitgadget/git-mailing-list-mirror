Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE53C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347463AbiCHO1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241122AbiCHO1p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:27:45 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7C34BBA6
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:26:49 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id j83so8306264oih.6
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HrntcO17rXVIo33QU99SACC2b3JQN0sT8zlbHVoVlrw=;
        b=Tq8oa8PAnVenqCDBNgvmGKwhgHQNf4ldNM4Ww/EaI7im0Kbd8EnSpmfm7W8M6NzHCk
         4oxS/1lKRANOiHNpDEMdxPKAwUwwVWXrpoOtdC/08TqNfJMfwSuoDLNigIBcbRw5a7wg
         1cuJ06cpnoqSIPEJesnt1UtPDPuaFZAnzBFyiu7dnrEgElDMzNSOL7GNb+NYJ/mKsr6o
         ToqqKF+f+dOj+xba82dZvWaohkwghYfBSN2THkGEjN4A2zQonYBKNONvYP5i36U/Gr3L
         Z6lQqZBr2zPMErSAHzmloMh3yLhlWyZ1uv2+DCYqGoQ+ubeg8TE1/W2wiun6o4FFppIb
         blIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HrntcO17rXVIo33QU99SACC2b3JQN0sT8zlbHVoVlrw=;
        b=nMuOAR626fsNaZUSirD1Z+MnuicG+81p6JQSeeLuxlxu80xicokadILc7REr2Q0JOq
         4qQ95EpgAhCQDFg5BHPwTt08iB6/I/dmvb9DryOSCUxxEBtQ7zhKYtqpYNcYveVVeBX8
         vU4lYCrSU6LjPrKGCtsfAEESxmtpbLbfTUazOEI1uygkfJSVJamDE+JJOI2uq20UQql0
         jFCCEzLaScc4s5vo7019MrZ/58RplqYv1cM0w2ZmuW6AlEDK3RQSy6LzHfDYciZ77I5U
         x6lnv8g6bIaA0X4dSax6KcX8BlttsLKZBbRQ0DYW6vKM0hmKHy8hvI4ncM6pz3nT06es
         J7CQ==
X-Gm-Message-State: AOAM533dfcft9s6wIw8QuJSrDBDqaXIrOUZNHt6NFabtScyVJ/WbtB7H
        QZejs7la//WRlw1ptKMxVf8Ju1+A5Jrs
X-Google-Smtp-Source: ABdhPJx6rXjFHZ5tzaXA7p78pzxPi4RJ1k8N3w/jhPhW0nqOS97cCMgjTcU2pWFsZf7KJEXgz9lBNA==
X-Received: by 2002:a05:6808:220d:b0:2d9:bdb3:15b2 with SMTP id bd13-20020a056808220d00b002d9bdb315b2mr2771162oib.88.1646749608970;
        Tue, 08 Mar 2022 06:26:48 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m3-20020a4ae3c3000000b00320d7c78b01sm3279482oov.20.2022.03.08.06.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:26:48 -0800 (PST)
Message-ID: <cbbf31e0-14fb-07fa-db12-aecbbeb1e592@github.com>
Date:   Tue, 8 Mar 2022 09:26:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/9] sparse-checkout: make --cone the default
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
 <b174b42ed82a45f57959a2a493dcfb32bf26c12d.1646725188.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <b174b42ed82a45f57959a2a493dcfb32bf26c12d.1646725188.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2022 2:39 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Make cone mode the default, and update the documentation accordingly.

Doc changes look good.

> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -397,7 +397,7 @@ static int update_modes(int *cone_mode, int *sparse_index)
>  
>  	/* Set cone/non-cone mode appropriately */
>  	core_apply_sparse_checkout = 1;
> -	if (*cone_mode == 1) {
> +	if (*cone_mode == 1 || *cone_mode == -1) {

Part of me likes the fact that you're pointing out "if it is
enabled directly or not set at all", but maybe it would be
best to do

	if (*cone_mode) {

What do you think?

Thanks,
-Stolee
