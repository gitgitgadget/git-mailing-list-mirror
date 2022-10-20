Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5374BC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 09:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJTJ4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 05:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJTJ4W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 05:56:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B52F48
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 02:56:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n12so33313518wrp.10
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dou1xMwc5eQFEPouwx1WzctbRI6emXAaVTjq6OsiAAQ=;
        b=VDtwvGjncY0tQfzoL1fusWAbG16e1VzCK3MF5zWVP6IypM9ztrUSJz7EfsxTq5ZpH6
         Wov4Tq74kSTkHBoY7Hd/m/B8wHu02qrAf/Nq99K+xttD2eaXtK9N0OxdXOB7mtF/vOJm
         gxoM5EQfHp55G6T4/Nam6g6TJ/83HyZptcooeXQIKKxwHnFl8pWkvqyrxejkCL+KWr8Z
         dc05oqp5X6bsWLSMWBCZeYUvk68/VtyTanT7UlM3EZ2Ucx8tQMYxw6yIPT1hro7fqpvp
         cklU/D33VcOsge74gcZ7l5V74Rjm+/MI0tXXzfHaF1sAtBglekV5VytTOqhzVeqBUFHn
         x68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dou1xMwc5eQFEPouwx1WzctbRI6emXAaVTjq6OsiAAQ=;
        b=rvJfaJ1Wp/4Yk9EVzrNc8omD5h8/D4ocSk45khCVoHAKnaBeBYiZn+yhyDyVIsjQp2
         q0ONkRcnWsSEnl8dU4n+jEsfRm1WRoaoOwkO7b+VcjWHzWhQdgxMO/M8w0nUzJI7NUY6
         WTCrWlHRmVmGm46fDcpyf92Iyid7y+pl3JtOyi8VSUxF4fXLbOJKyFz7ppN3cjzZ2aVO
         MUpmmtYyvhDT3Vbd/SOwebQBVfqHKitdmRKsouXKBrnT3JNBlqyVQVUCsTVc0vzeJ6JA
         XRdU+FRl84Uyj+krNeinLJN1BUni5e1eo/OmYLqkW7gQVdVzMLGvS5aE3zPCUb51gT5Q
         AbFA==
X-Gm-Message-State: ACrzQf0qlW4HsyrMBBh9MTXZ0UiulZGe1HNmCZxXdXvCo2YARbF8jI4b
        iTtOQNq8VrtLbsvCp49HRqA=
X-Google-Smtp-Source: AMsMyM7ElujiIu8PC3OEmFa2pPTiFt7Uizgd0Yoy6ra6lJw97yCtoAzmueT1gry2Y3tCpfXbj5liVQ==
X-Received: by 2002:adf:e189:0:b0:22e:cbf4:1148 with SMTP id az9-20020adfe189000000b0022ecbf41148mr7850937wrb.47.1666259780203;
        Thu, 20 Oct 2022 02:56:20 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id b21-20020a05600c4e1500b003b476cabf1csm1554044wmq.26.2022.10.20.02.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 02:56:19 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <3ed29217-ac10-c5e3-ae7e-969b7f55d058@dunelm.org.uk>
Date:   Thu, 20 Oct 2022 10:56:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: pw/rebase-reflog-fixes (was Re: What's cooking in git.git (Oct 2022,
 #06; Wed, 19))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqa65rnuvv.fsf@gitster.g>
In-Reply-To: <xmqqa65rnuvv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

> * pw/rebase-reflog-fixes (2022-10-17) 9 commits
>   - rebase: cleanup action handling
>   - rebase --abort: improve reflog message
>   - rebase --apply: make reflog messages match rebase --merge
>   - rebase --apply: respect GIT_REFLOG_ACTION
>   - rebase --merge: fix reflog message after skipping
>   - rebase --merge: fix reflog when continuing
>   - t3406: rework rebase reflog tests
>   - rebase --apply: remove duplicated code
>   - Merge branch 'pw/rebase-keep-base-fixes' into pw/rebase-reflog-fixes
>   (this branch uses pw/rebase-keep-base-fixes.)
> 
>   Fix some bugs in the reflog messages when rebasing and changes the
>   reflog messages of "rebase --apply" to match "rebase --merge" with
>   the aim of making the reflog easier to parse.
> 
>   Will merge to 'next'??
>   source: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>

Can you hold off on this one please, I'm planning to re-roll next week 
to address <xmqq35brh9re.fsf@gitster.g>

Thanks

Phillip
