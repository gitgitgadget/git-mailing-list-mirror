Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB8AC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 16:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbhLQQ2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 11:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhLQQ2u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 11:28:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AEDC061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 08:28:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o13so5044245wrs.12
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=XEnIPEXyL+KZObNuBWWXhPINy02YcaYDMW61rBf0Xx0=;
        b=ToKF7AEMsR5OM24DR8nqjQvvKHKPx7bgJ/LJZXB+2tB5mCdsqZRFAkEiykh8/xGt2g
         jNRS07DInHdsu/NBhvyR+RqYRojU3s3zOXCrIH+bL87dmyr2EkRxtx9XmscJCyw2pNeK
         y9F5oh9YnZMks4St06j7NCp60u/aMRyRitKGcm8GLCouKDEUAULd8XIFomA3LWtqM3Pj
         xERNZdYvYciOO5Jg+whS59/J6N3W6eYVdd3LqCUM/mwVtK7qmXCAp4CRQnT5P0uMGwp8
         pSGxXcNEjD68SaEla1t4dFSCMt0C+DJ02kjxc+oxM70ucDz0LNLMgR8gAPibw5rQlmFg
         U1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XEnIPEXyL+KZObNuBWWXhPINy02YcaYDMW61rBf0Xx0=;
        b=z6XxBqUiHD7pjZJu05Zx/vl28iZsMFFkh2Vdb0EIKeQxHgk5MqRfsqQuXEv3XczfvL
         +BPWj8mrb/pF/vdlvyPQnf5U1lI8xm10rSkKgq2Dp8MpxC8f/h9OaiXHdadDNcI9z3a8
         i7CQBEa5F1w3B9302sfDH4ho2K/OwDEtgDoh4146r1L/bOL2GEHwDtTDRkIagdVC6NNv
         wtm/p7ncvM7Bi93NdAoT0QsQFSK+fJQg0+rWDyxl8NC0Pzkrz+r9UIqB2p+rlN64N9+r
         NthLgcggc69jOuupCWCPWt8FUWQduzDf+vg8mxwhSE6S7gkF3iOmQ1ub1HjuUS/qKWfO
         bENw==
X-Gm-Message-State: AOAM532syFUDdI0893ljfDA7kAt9ZSh2CpPK6NdIakgF/ciS6cmSzdwA
        MI8QklFATSxNXHpy735wPMaQ/KHT7/s=
X-Google-Smtp-Source: ABdhPJx4NrZRuBIm+PPD2cPn9nnu9UcwlMgSdcE/3y29IrxSJWrbNWnagDM4dOBjf+Vzx6sBxV0hMw==
X-Received: by 2002:a05:6000:2cd:: with SMTP id o13mr3081391wry.718.1639758527883;
        Fri, 17 Dec 2021 08:28:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z22sm2537535wmi.26.2021.12.17.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:28:47 -0800 (PST)
Message-Id: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Dec 2021 16:28:44 +0000
Subject: [PATCH 0/2] Two small 'git repack' fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was experimenting with some ideas in 'git repack' and discovered these two
bugs.

The first is a "real" bug in that it repacks much more data than is
necessary when repacking with '--write-midx -b' and there exists a .keep
pack. The fix is simple, which is to change a condition that was added for
the '-b' case before '--write-midx' existed.

The second is a UX bug in that '--quiet' did not disable all progress, at
least when stderr was interactive.

Thanks, -Stolee

Derrick Stolee (2):
  repack: respect kept objects with '--write-midx -b'
  repack: make '--quiet' disable progress

 builtin/repack.c  |  8 +++++---
 t/t7700-repack.sh | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)


base-commit: 69a9c10c95e28df457e33b3c7400b16caf2e2962
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1098%2Fderrickstolee%2Frepack-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1098/derrickstolee/repack-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1098
-- 
gitgitgadget
