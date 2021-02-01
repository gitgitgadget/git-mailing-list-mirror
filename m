Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B21C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970A164EAC
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBARPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhBARPu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 12:15:50 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83352C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 09:15:10 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d16so17407315wro.11
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 09:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=IMn2ioh5HxnywAaXPHUhn690zQm3FT9ZFFvo9Ar4EcM=;
        b=N0seRhAgcY+jNUOtSKHfVLLee0Dyt4OLLtv0VqRDruN1pdpIt/33Xa5X7vgjR8H4Rw
         9jDDAVeOjIokTCQIrOUdBTD2jITbuf2FybXa0YEdPjJTZ8kect5Aql4HWtzWo827BvNd
         7IEyfNGidZhcX1QmRqJ0WnpMkC+JyMq1OldRMW0HGG39XhULs/YC0M+iBV+yCkaVLW79
         QVgrXSjkjsCp5X45zIsE7mV8oIU6VocH4aABS1kouln/nrdFq/raO3cruT2fiJfpfaoY
         ++8v5JtTWVP4WhoqUnz1vHU8sXPm91nujvE4gUrvF7l0ZdeGNjvUrqXa4MAhyzLkV+cP
         mUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IMn2ioh5HxnywAaXPHUhn690zQm3FT9ZFFvo9Ar4EcM=;
        b=fDnWC3o5ZC3jw6zWltH/bBtFfDEINxrGa6ts9R+br2aesI0uwixu7hXUCpOs7uSq8n
         DIIoYcswSs9J/C1IIPZRTJ7IbXl5mEg5sNQXNGkJf4QCHJaA7Yu3BuOBAZrSkaW6TfOm
         hS82psLfgtE3FphvXoEP5BRof5D/eEsI6I+jdMHon1L3l0CLlmcydlLPRQTp/Lz57q/i
         m/A6LLYSqtkBd97HxCsZWQYI2R9e9JwuDklh2Ee07DthG1yJFeBNoO8+3Ef+stSn18OK
         khifk4xUVSvCH7vgRPELc1JXZdohMvvmBRvM0sDA3DtXtu6oPBLhYK+NOXuHiloRXZN4
         Rxvw==
X-Gm-Message-State: AOAM5318DYigvTl6muuxandu7BUjxejOLR7aMYPPg/ihUPDMGGDKB+YD
        rStOllGlkergKlp6AyrbY41e2Pof/t4=
X-Google-Smtp-Source: ABdhPJzpb6THsmN3K8JdyMjoHwKody01epvla5ph+E6zcBug16OmdwcgdAzkwjZ99AAF3aN1MqmQPQ==
X-Received: by 2002:a5d:524f:: with SMTP id k15mr19491368wrc.16.1612199709108;
        Mon, 01 Feb 2021 09:15:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4sm3291725wrr.37.2021.02.01.09.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 09:15:08 -0800 (PST)
Message-Id: <pull.850.git.1612199707.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 17:15:02 +0000
Subject: [PATCH 0/5] Generation Number v2: Fix a tricky split graph bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, gister@pobox.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a bugfix for the recently-landed-in-next generation v2 topic
(ak/corrected-commit-date).

This was occasionally hitting us when computing new commit-graphs on
existing repositories with the new bits. It was very hard to reproduce, and
it turns out to be due to not parsing commits before accessing generation
number data. Doing so in the right place demonstrates the bug of recomputing
the corrected commit date even for commits in lower layers with computed
values.

The fix is split into these steps:

 1. Parse commits more often before accessing their data. (This allows the
    bug to be demonstrated in the test suite.)
 2. Check the full commit-graph chain for generation data chunks.
 3. Don't compute corrected commit dates if the lower layers do not support
    them.
 4. Parse the commit-graph file more often.

Thanks, -Stolee

Derrick Stolee (5):
  commit-graph: use repo_parse_commit
  commit-graph: always parse before commit_graph_data_at()
  commit-graph: validate layers for generation data
  commit-graph: be extra careful about mixed generations
  commit-graph: prepare commit graph

 commit-graph.c          | 87 ++++++++++++++++++++++++++---------------
 commit.h                |  5 ++-
 t/t5318-commit-graph.sh | 21 ++++++++++
 3 files changed, 79 insertions(+), 34 deletions(-)


base-commit: 5a3b130cad0d5c770f766e3af6d32b41766374c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-850%2Fderrickstolee%2Fgen-v2-upgrade-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-850/derrickstolee/gen-v2-upgrade-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/850
-- 
gitgitgadget
