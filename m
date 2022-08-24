Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18DAC3F6B0
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 23:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiHXXnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 19:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiHXXnM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 19:43:12 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A655AC56
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 16:43:11 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s206so16385548pgs.3
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc;
        bh=6rm6lUTHJ/dT9KIXHlY7B5k8FO8dfYaFT3/ESMl2zN8=;
        b=FD4KWHjdNg5jDgoYi0CO/9UeDk8V5ge9+SKMxvrta1efGUYDRoRasb7d5Ffwk9OUMp
         gqWeZFJvvArO9dsIb37fVejeVlwVrMiThVP6RlxvOIDxj/WdQrY1zhQApC9A/zTIrMf2
         hnT2uWKFLFJHVzQiSMBYNAPrjt+eWy2TfjI2PYnlEzVBjIsxshpeLQ0I0JHBKC7uW1qA
         wcvcFiG/iifB9avbyaMYUofl571NJi1m/4H5FsaQ0M1GiiG26v00z8nZUMRyYdx3BVGH
         F4aBPeMOj4QWC4gQTXnzFo7DkuVIKUPelkPb38vU4GUo3CzPhEEtaBveGmhcdJTAF8KG
         PU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc;
        bh=6rm6lUTHJ/dT9KIXHlY7B5k8FO8dfYaFT3/ESMl2zN8=;
        b=2MmSnKD04g1Dk6Xxr5NClKQBVmuGs7gQBqaUOKLg1vkPc9VJM29FkU8T4dfjuvyqJp
         MPIsiN4WgZ8NQFSsPJ6a2CRwWPP6L2/vhLvawCIfZig835jC/1qEdsYW/xz5nnO235Y+
         ksg8imJc4Y52PVh5N9iX6VYFipsU4nefqmNsDw0Q9ob9YKAw2V/rzBpv0MqTZXq4jwfr
         0sojZTOeVRw4lGsBm0Q4W4zHIQl7Z1DgVgn2Ynj26wEcyfZYgEoFgya04fmotMbrM/yz
         Kt3OTIoRrcO+BD0ocjrVKKpVuPm7p4GabX9zksnonSyZVszVR8BPCM7TRtt7MXB+RMWO
         Z7CA==
X-Gm-Message-State: ACgBeo0fEUeqygo8CngFS3SnZ4jFRd1K2ofSlXUY5NEul93kGwN5XrBi
        NpPC7ILg4DlRg6bd6DObG/0=
X-Google-Smtp-Source: AA6agR772pW6R/X5bcjCHQMfl1c4CO2Lzxoug+AIbHjJT88r+JkCaUiThr94j/bwN1RJTi51XV6nCw==
X-Received: by 2002:a63:cd55:0:b0:42a:7649:77c7 with SMTP id a21-20020a63cd55000000b0042a764977c7mr991384pgj.149.1661384591267;
        Wed, 24 Aug 2022 16:43:11 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b16-20020a170903229000b001729fa08b8esm3799396plh.288.2022.08.24.16.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 16:43:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
Date:   Wed, 24 Aug 2022 16:43:10 -0700
In-Reply-To: <pull.1334.git.1661275691795.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 23 Aug 2022 17:28:11
        +0000")
Message-ID: <xmqqwnax438x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> GitHub Actions scheduled a brownout of Ubuntu 18.04, which canceled all
> runs of the 'static-analysis' job in our CI runs. Update to 22.04 to
> avoid this as the brownout later turns into a complete deprecation.
>
> The use of 18.04 was set in d051ed77ee6 (.github/workflows/main.yml: run
> static-analysis on bionic, 2021-02-08) due to the lack of Coccinelle
> being available on 20.04 (which continues today).
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>     ci: update 'static-analysis' to Ubuntu 20.04
>     
>     I noticed this while preparing my bundle URIs series. See an example
>     cancellation at [1]
>     
>     [1]
>     https://github.com/gitgitgadget/git/runs/7954913465?check_suite_focus=true
>     
>     I initially asked about this [2]. Thanks to Matthias Aßhauer for
>     pointing out that 22.04 has Coccinelle available [3].

Thanks, it is already paying its dividend, it seems.

We probably need to fix or revert/remove rules we have in
unused.cocci that makes bogus "suggestion".

  https://github.com/git/git/runs/8005321972?check_suite_focus=true

