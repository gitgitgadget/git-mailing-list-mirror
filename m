Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC97C433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D78822242
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgL3T1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 14:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgL3T1h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 14:27:37 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67910C061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:26:56 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m5so18281879wrx.9
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=LOwsPP+hXGM5nJ/Wm9tSqaaFFP2lijiBbbQcsoBsucE=;
        b=iEkrCIXgYx8JuOKiIoWYYRq0nIEvbVu0QufRw2+d3LtlsSwCL6k6PpICHmP4RCgFSP
         49Vfwb050Xg5qCY6BA9KmKN6BOq7qI2nFeCLip9yKkZdMScexUemwsMAIK7BQVfj+l6/
         fPTpJN3MucM2f4k+6HJv8h2koCYXCXjdyyz7P7mU2E6bsDZ10qaE2dMmnnbS0StqQ5tB
         YzH4qDIz8Nqc3eJ2Ws+6q473Irv5g5XEeMznRfIeEcrVkaRjmwVr7a9lnwNlIlNhHJaT
         YNHoMJ//BZBUOJHJV5A7wvaH70LuoAuKP1rzrC/+MgeYoyMcyrTSI+WzaZk23R9Izn/m
         LXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LOwsPP+hXGM5nJ/Wm9tSqaaFFP2lijiBbbQcsoBsucE=;
        b=TxJ43uaSuHcpak+HEM1bOMe2NBNP7n+377+3ILq2zOn4dkx582g7ffrZL4Z56y41h2
         aN8C4Imaq8qcSInASFo1X2RpcCT9pYwksv2b6iR7w2vzKqWtJlXkdQrnk21ZfZ41+xe4
         qEHnjRgHl1nH0L6gDajIUq4JJPbkzOMEoaTh0AWFH/yqBOiZnhlo0MT6Wk+6jn6HnxhO
         PSeyyCmDoHdzQcFKqR4PHvAwF7QEbscGuBL/f7mUSci/fh1G5lvD6tIilWs8wr7tK8gz
         9R4GyvsYaXVgJWL/phRxXk4URe3PLAK+gKyJdqPdmPHDykyxDDiFlmrygbxglnP/GZqA
         KA5g==
X-Gm-Message-State: AOAM533jYv8BfT+MwviRN9Pm0xQ1BrQi8IGbkVGhVAJpCj34DFIWnU/E
        FU3ORRh79fQzaBfkUMICyJzjpjz/KPc=
X-Google-Smtp-Source: ABdhPJyU014YF/2RDX7C0HjtbQoTVQLqwFFQtvz05CqOFnwFJL/mFE0uIASJrg1Axu/7kyuoBJIaiQ==
X-Received: by 2002:adf:ef06:: with SMTP id e6mr60538217wro.231.1609356415019;
        Wed, 30 Dec 2020 11:26:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g192sm8707695wme.48.2020.12.30.11.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 11:26:54 -0800 (PST)
Message-Id: <pull.829.git.1609356413.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Dec 2020 19:26:45 +0000
Subject: [PATCH 0/8] Cleanups around index operations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've taken a professional interest in the index lately, and I've been trying
mostly to learn about it and measure different operations. Along the way,
I've seen some possible improvements in documentation, behavior, and
tracing.

This series collects most of my thoughts so far, including:

 1. Adding extra trace2 regions and statistics (similar to [1]) (Patches
    1-5).
 2. Update documentation about the cached tree extension (Patches 6-7).
 3. Removing an unnecessary loop from verify_cache() (Patch 8).

Thanks, -Stolee

[1]
https://lore.kernel.org/git/pull.828.git.1609302714183.gitgitgadget@gmail.com/

Derrick Stolee (8):
  tree-walk: report recursion counts
  unpack-trees: add trace2 regions
  cache-tree: use trace2 in cache_tree_update()
  cache-tree: trace regions for I/O
  cache-tree: trace regions for prime_cache_tree
  index-format: update preamble to cached tree extension
  index-format: discuss recursion of cached-tree better
  cache-tree: avoid path comparison loop when silent

 Documentation/technical/index-format.txt | 39 +++++++++++++++++++-----
 cache-tree.c                             | 25 +++++++++++++--
 tree-walk.c                              | 33 ++++++++++++++++++++
 unpack-trees.c                           |  6 +++-
 4 files changed, 92 insertions(+), 11 deletions(-)


base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-829%2Fderrickstolee%2Fcache-tree%2Fbasics-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-829/derrickstolee/cache-tree/basics-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/829
-- 
gitgitgadget
