Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2237EC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbiF3V5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbiF3V5p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:57:45 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C710F564FF
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:57:44 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id m17-20020a170902d19100b0016a0e65a433so280949plb.8
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=gBNIi2aH72IqnR3xR5nd6Cz9aBMLSMWzMj0qtv7mYw0=;
        b=hRqdjdTRVFVbqvdcb/0/ATZTkvXtRGzfP/ZNLtLrOLR5evBC6geFWuG61XihuoXQ8N
         gZHtRz8YpFfeXmX8NgY6UzMaXit+s0Z4yvPPFxDMKm0Dj3B45N3xvzsDTfrnhJkf0LaV
         O6x64DnBMWMO4OaPOlNNPL7Lg+CuH/d402Ep9IiPAGFxKNmg2Bk/60S1XOKjqgUE4o2w
         AyVmNQiy7Qh7PZ713vZguHalaZvuVIvoxEHkjxgPP4V1PjUSaM5uOeoIJM8w0jRBkEHy
         p4Owvwzs9kxxR6+7odsw/FwoHMYNkUxY9JsRziURJSWoC+qqOd4E5NX+NgtIeU48kV5o
         HwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=gBNIi2aH72IqnR3xR5nd6Cz9aBMLSMWzMj0qtv7mYw0=;
        b=btsHEvGVlrj6UA6M5HagozyxrWT6BhbR51W6MD/a4oia3z6ojesDew4bmdoPbW54Dq
         xRX+0oZg+c6XnReb1GIEuLc+hEYARCb4pNw/av+6T1I2UNzkbViWdv7cTFtA4TKlE5KT
         Z+SUgqVRW204nRBBJyUZ7+vCICJ3m7QfBubN+Lxpjagw7r6GFtuiFwQ4cJUxi/z1XwKs
         97ABeqT+CVWM9xrXYOaLo4pyKTVXBseW7BbjT+25WExIh6zJopbsIIqp/+bAEW4trT36
         9NAQyHsBpgL9H+r9Ra1aDYTAO0aLZL2hRwzEc2VXdPWN6S0RNEg0f1ahRVmfoSy2/+MY
         sd3Q==
X-Gm-Message-State: AJIora/1d/maW5w0gxnxVX2v+NqWyFYxOQbE2RUx5yPMXbRbYOYSm/pz
        ozpgWwH7d+L8zUUrYvliuB3gUX6nfaP7cw==
X-Google-Smtp-Source: AGRyM1uRX1tC8JERF3NE/77MmpnN6p7o0AiCbN1Jd9T+FUKVJQJUd0LkNH9xbZ1N7AeMw/D6KFBJto5Na8gHqA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e850:b0:16a:209a:971a with SMTP
 id t16-20020a170902e85000b0016a209a971amr17693132plg.163.1656626264251; Thu,
 30 Jun 2022 14:57:44 -0700 (PDT)
Date:   Thu, 30 Jun 2022 14:57:42 -0700
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
Message-Id: <kl6lwncxstk9.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com> <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 00/18] submodule: remove "--recursive-prefix"
From:   Glen Choo <chooglen@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason" 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Glen Choo (6):
>   submodule--helper: eliminate internal "--update" option
>   submodule--helper update: use display path helper
>   submodule--helper: don't recreate recursive prefix
>   submodule--helper: use correct display path helper
>   submodule--helper update: use --super-prefix
>   submodule--helper: remove display path helper
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (12):
>   git-submodule.sh: remove unused sanitize_submodule_env()
>   git-submodule.sh: remove unused $prefix variable
>   git-submodule.sh: make the "$cached" variable a boolean
>   git-submodule.sh: remove unused top-level "--branch" argument
>   submodule--helper: have --require-init imply --init
>   submodule update: remove "-v" option
>   submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
>   submodule--helper: report "submodule" as our name in some "-h" output
>   submodule--helper: understand --checkout, --merge and --rebase
>     synonyms
>   git-submodule.sh: use "$quiet", not "$GIT_QUIET"
>   git-sh-setup.sh: remove "say" function, change last users
>   submodule--helper: remove unused SUPPORT_SUPER_PREFIX flags

Looks like I accidentally submitted all of ab/submodule-cleanup... Let
me try this again without GGG.
