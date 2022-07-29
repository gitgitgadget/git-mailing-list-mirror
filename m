Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2093AC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 12:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbiG2M2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiG2M2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 08:28:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF209BE3D
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 05:28:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v3so4879768wrp.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 05:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=w/EpgzhyG8HznndKmAem4Y2a9MV39L21tgWXqyQOdk8=;
        b=SDO9BxpiRHZVwCMlY/UwE450I5R1+chHPApkKae/AFNsHTfTeQoNLvbwByQPm9ZROo
         HuaBFWNCsoS5uMm/ilOzVoXmG6/yEwSeSIJ8B+rHhNgrovEtcLvKHgLQxGRgegf8gOWC
         wWm+pMNiOGmmmwg+/9cu5EOOPVBEijMBPN9lCMEKvvEiHI54PD7HCps/I8Lrzko48bWU
         8Aiym2/Fvh7EoFIh4EiRT7rNGrErpdLxWx4CjtGE56TB/3SxsgoSwNtUJL0ee8kvb1vk
         Np1e4niJQZYPtEX0rMOxu3ua8xXrw8g2Pn3PRjMPeYLCsVzY1ptBXkwyVF5emZjyPDnB
         7iJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w/EpgzhyG8HznndKmAem4Y2a9MV39L21tgWXqyQOdk8=;
        b=x2bOW6YZrBcWeG1NBISQ3Sae9NAtTQS4qAcZNeDGo8634XZBrJjBlyoOHYLZ9xZOgt
         C9hwHIRXxnULE3djU8jlDL10E8JaTFdmvfUcdDtxWbNVHZJ18C3Ect22v7r3YlIX0X4J
         d5yuUM1pm+RrVgQwNjK+xVOlJ35//y1E+KcsBiutXXlm5eOKNyowjFVX4zo7K/gvOrlB
         yTrX9ndRtXn2DS9CwGccj88VVThyGntYRZoUgkvIbb1FxDuSJya1u9pZmFBwFrxX9XYW
         41ifRFHjDSMhkrrRaCD3b1c9+sfnNxXdH84JPW5c0pW7LjDBZrktjmTb2KFURiXV6YzK
         WXFw==
X-Gm-Message-State: ACgBeo1psOOwD4U9h+0xpGRdlXU4jRCrxNATSCPTruAcr93Y2z3wciYU
        yXTgRphBPWn8IzMTkiQ9IoleomY99oM=
X-Google-Smtp-Source: AA6agR5304VuwkyYMrnUA5w0BiBFXkc+gDETOq6/56uOC7puRShozkwOtHGlg1mN78f8LV2mJyOB3g==
X-Received: by 2002:a5d:6501:0:b0:21e:cc1c:ae5b with SMTP id x1-20020a5d6501000000b0021ecc1cae5bmr2283299wru.341.1659097725976;
        Fri, 29 Jul 2022 05:28:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z16-20020adfe550000000b002185631adf0sm3664220wrm.23.2022.07.29.05.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:28:45 -0700 (PDT)
Message-Id: <pull.1308.git.1659097724.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 12:28:42 +0000
Subject: [PATCH 0/2] ci: fix the FreeBSD build
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 3a251bac0d1a (trace2: only include "fsync" events if we git_fsync(),
2022-07-18), the FreeBSD builds are failing in t5351.6. See
https://cirrus-ci.com/task/4577761405698048 for an example. The run at
https://cirrus-ci.com/task/6004115347079168 shows that this patch fixes the
bug.

While verifying the fix on Windows, I noticed a recent, rather terrible
performance regression: t5351 all of a sudden takes almost half an hour
[https://github.com/git/git/runs/7398490747?check_suite_focus=true#step:5:171]
to run on Windows. I found a fix, and it now passes in less than half a
minute
[https://github.com/gitgitgadget/git/runs/7578071365?check_suite_focus=true#step:5:125]
again.

Johannes Schindelin (2):
  t5351: avoid relying on `core.fsyncMethod = batch` to be supported
  t5351: avoid using `test_cmp` for binary data

 bulk-checkin.c                  |  2 ++
 t/t5351-unpack-large-objects.sh | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)


base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1308%2Fdscho%2Ffix-t5351-on-freebsd-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1308/dscho/fix-t5351-on-freebsd-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1308
-- 
gitgitgadget
