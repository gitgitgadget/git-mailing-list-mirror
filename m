Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA77C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577CF6117A
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhJ2Nx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 09:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhJ2Nx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 09:53:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BB2C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:51:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i5so8610521wrb.2
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MQpBQNS0hWaX5mLXeKVPpZqZny5ADFTXnS7B6rUCgB4=;
        b=SOF8dsWLRqBnaTPCu98ZDVWYJ8XzfMxEYGlE2voKVUwJec/oQOPLB6QY6PXotzr6x7
         u/dYiI+c/tUEEWUJ+FJXvEcCZjevV6Hyh1TBE1xkgvhSEmSlQqbbqdUR2NpEmxBgnbR8
         hcI7whlZavijXQ8qoG1RDdFwU1WUCYQbm6d0BfJN7Q6g41nNl94150pWAQPYHUEAzqdk
         lfrWqNpnX4Ye3KD90aeN+bSdOCZvEtaM+V//1MpFGwwxpKHSDZGFJosLPO6r1f89soxF
         kSYkIO4xfBPMHBB+mZkqOziCRj733QhgNtAtjzLeeUmQoYcX5l0Qy3raeMZU9TTu2+r8
         PTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MQpBQNS0hWaX5mLXeKVPpZqZny5ADFTXnS7B6rUCgB4=;
        b=bAoOzMu/NRIsGK3mDGHoiey0uQuXvt1luq8iNryKnbSL/JCO1nAUrtQbXPdiu4A7/d
         5GGJ7/ZlHG+PC4WKi/GhT3cXga0Xao6b+tI16b28c4zbzDrSx3jJca7MRicKm2S7V1pZ
         OSYJFaIauCcMOiErVIquRhBHKoGr2jVbJE3+fnBS7bClD0XRLf1eRwatNKLJSuEd2v7n
         cjBgsj5UoHKaNxNlO40LCelEIyesbD6l7JctLK/qxeiMOtGqGBJHLx86oKT6Svt4QUbL
         wCBk4xPu6skuJuApxNuKm0O8eHj9YxqK5I9YHl8p3xurozuUSStHb9ul3Xey/Ifw2CHW
         UuFQ==
X-Gm-Message-State: AOAM532XU+KLRL9LM09waSTQxoW8yb/TIosVZ7mlVbbdnazSmrnWWIi1
        FYA7ZL2vNwGzWVxWGMk6uLaHfKyZh64=
X-Google-Smtp-Source: ABdhPJxK1A6coBgP9STT1lj4BgRyVij+/tD4JnLY4eVDpTweWkUPzG1SLHyF1NDdmitS+OkyMcTt3Q==
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr11582957wrw.283.1635515488056;
        Fri, 29 Oct 2021 06:51:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o23sm5671495wms.18.2021.10.29.06.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:51:27 -0700 (PDT)
Message-Id: <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
References: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 13:51:22 +0000
Subject: [PATCH v4 0/4] sparse-index: expand/collapse based on 'index.sparse'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series updates do_read_index to use the index.sparse config setting
when determining whether the index should be expanded or collapsed. If the
command & repo allow use of a sparse index, index.sparse is enabled, and a
full index is read from disk, the index is collapsed before returning to the
caller. Conversely, if index.sparse is disabled but the index read from disk
is sparse, the index is expanded before returning. This allows index.sparse
to control use of the sparse index in addition to its existing control over
how the index is written to disk. It also introduces the ability to
enable/disable the sparse index on a command-by-command basis (e.g.,
allowing a user to troubleshoot a sparse-aware command with '-c
index.sparse=false' [1]).

While testing this change, a bug was found in 'test-tool read-cache' in
which config settings for the repository were not initialized before
preparing the repo settings. This caused index.sparse to always be 'false'
when using the test helper in a cone-mode sparse checkout, breaking tests in
t1091 and t1092. The issue is fixed by moving prepare_repo_settings after
config setup.


Changes since V1
================

 * Add ensure_correct_sparsity function that ensures the index is sparse if
   the repository settings (including index.sparse) allow it, otherwise
   ensuring the index is expanded to full.
 * Restructure condition in do_read_index to, rather than check specifically
   for the index.sparse config setting, call ensure_correct_sparsity
   unconditionally when command_requires_full_index is false.


Changes since V2
================

 * Rename can_convert_to_sparse to is_sparse_index_allowed to more
   accurately reflect what the function returns.
 * Remove index-iterating checks from is_sparse_index_allowed, leaving only
   inexpensive checks on config settings & sparse checkout patterns. Checks
   are still part of convert_to_sparse to ensure it behaves exactly as it
   did before this series.
 * Restructure ensure_correct_sparsity for better readability.
 * Fix test_env variable scope.


Changes since V3
================

 * Add a new patch to avoid unnecessary cache tree free/recreation when
   possible in convert_to_sparse.

[1]
https://lore.kernel.org/git/cc60c6e7-ecef-ae22-8ec7-ab290ff2b830@gmail.com/

Thanks! -Victoria

Victoria Dye (4):
  test-read-cache.c: prepare_repo_settings after config init
  sparse-index: avoid unnecessary cache tree clearing
  sparse-index: add ensure_correct_sparsity function
  sparse-index: update do_read_index to ensure correct sparsity

 read-cache.c                             |  8 ++++
 sparse-index.c                           | 58 ++++++++++++++++++------
 sparse-index.h                           |  1 +
 t/helper/test-read-cache.c               |  5 +-
 t/t1092-sparse-checkout-compatibility.sh | 31 +++++++++++++
 5 files changed, 86 insertions(+), 17 deletions(-)


base-commit: f443b226ca681d87a3a31e245a70e6bc2769123c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1059%2Fvdye%2Fsparse%2Findex-sparse-config-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1059/vdye/sparse/index-sparse-config-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1059

Range-diff vs v3:

 1:  6974ce7e7f5 = 1:  6974ce7e7f5 test-read-cache.c: prepare_repo_settings after config init
 -:  ----------- > 2:  91351ac4bde sparse-index: avoid unnecessary cache tree clearing
 2:  9d6511db072 = 3:  d2133ca1724 sparse-index: add ensure_correct_sparsity function
 3:  d6c3c694e1e = 4:  b67cd9d07f8 sparse-index: update do_read_index to ensure correct sparsity

-- 
gitgitgadget
