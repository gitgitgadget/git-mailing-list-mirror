Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CA3C4708D
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 22:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiLGW45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLGW4z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 17:56:55 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D634B201B1
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 14:56:53 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m18so15921652eji.5
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 14:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZCms8o1+tst/rWxHi7jUJ/Yb8eME9DoOId4J8Vtf8A=;
        b=qgH3uKUQ79/SW68XT/ZGBXQJZ21aI5w12Oecq9P+BLb6W/XExdyPWvfEoCu53zTygR
         QXKod7a85H7BkMAIT01pC1ieJ+GUI8JwIRygkvZhrpPIH6Z8xY6fP2dswMgLSA4htSoK
         ImGBb1KmzF48Q2Ad68Lgj+B8XB6LRbSL6ipycGo8H+VpRwXiSXpoOKzx0h34OgR1Mxpi
         JAwvot5h25slJmyk+S2FIlQD0uqoNRuLUbRqmODHCydaE3ZZuMaKWoB/5vN82lv1jW88
         XMxfyE+5YA7bFfvKZx0i+46JEpAgPA/h2/4nxGcBiL45ujc6T4wg1I48hnzTT9gippHI
         YYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZCms8o1+tst/rWxHi7jUJ/Yb8eME9DoOId4J8Vtf8A=;
        b=CE1XnO9u6kXDI+eAP0mi4WVShjS8lEaol6GudlZYbsLdELWepo91WB+00vD84PcBfn
         uHtogD5/A53vNhHTxKICf0+XKuFcQoUdEUhfP9LzWBmUv82kuHOI2Bcaew4P/Dx7mIt7
         d4/DKYNd0qF6Gga1YG59q/AeBEu8zgLVvZpairXYD6jhczjPuwODOqc+6q66fQNVwlAQ
         EmkYcBLWSzGIZq6v04o2oVeDpKHRQU23nYKkLU9/thairC4uihOYmRunOgvlRFzjItEF
         NEyufTSUWVhJE4Ecu8nw+wEzpm/qZOJJiqlp3LQNwHSOCnu/Hzerei0VmutDl5ZJabl/
         zmAg==
X-Gm-Message-State: ANoB5pkUWOM3O4QZHFbWnZ4GpM7BPCG4mL4j6UmyRFaED8EwfNgqkSsR
        gRqbMPxGU7zQJivJStQ8GU9Izw0T06IL3Q==
X-Google-Smtp-Source: AA0mqf4iwkh0tzndRKChPG9jzO6aS5sBFp6h6a3iFNcnO2+BVJchc2/x1JoLNreDgajuaUFSv2XlaA==
X-Received: by 2002:a17:906:9705:b0:7c0:fd1e:972e with SMTP id k5-20020a170906970500b007c0fd1e972emr751196ejx.46.1670453812373;
        Wed, 07 Dec 2022 14:56:52 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id s3-20020a170906284300b007ba9c181202sm9056703ejc.56.2022.12.07.14.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:56:51 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p33LP-004dX7-1d;
        Wed, 07 Dec 2022 23:56:51 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Avoid using deprecated features in Git's GitHub
 workflows
Date:   Wed, 07 Dec 2022 23:42:21 +0100
References: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
Message-ID: <221207.86r0xa9618.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 07 2022, Johannes Schindelin via GitGitGadget wrote:

> I waited for quite a while with submitting this because I did not want to
> interfere with patch series that are in flight, but it seems that this was
> unwise, as there is now a patch floating about (ab/ci-retire-set-output)
> that partially fulfills this here patch series' purpose. However, these
> patches are more complete, so I proposed to supersede that patch with this
> more comprehensive solution.

What does "more complete" here mean? Just that this series is doing more
things than stand-alone patches?

> This patch series is based on od/ci-use-checkout-v3-when-applicable.
>
> Johannes Schindelin (4):
>   ci: use a newer `github-script` version

Is this the patch that needs or interacts with
od/ci-use-checkout-v3-when-applicable?

I don't see it in "What's Cooking", but "seen" currently has
"gitster/js/ci-set-output", which looks to be from
[1]

>   ci: avoid deprecated `set-output` workflow command

This is byte-for-byte the same as the second hunk in my [2].

>   ci: avoid using deprecated {up,down}load-artifacts Action

Most of this looks good & doesn't duplicate any existing patch, but why
is there a change in there that disables the uploading of failed test
directories for the "linux32" job?

>   ci(l10n): avoid using the deprecated `set-output` workflow command

This does the same as the first hunk in my [2], you're just using two
"echo", I used a here-doc.

I think what would make it valuable to bundle these up is if doing so
would resolve some tricky interference between these patches.

But I don't see that that's the case, and we can e.g. start writing to
"$GITHUB_OUTPUT" independent of other changes.

1. https://lore.kernel.org/git/pull.1387.git.1667902408921.gitgitgadget@gmail.com/
2. https://lore.kernel.org/git/patch-v2-1.1-4e7db0db3be-20221207T014848Z-avarab@gmail.com/
