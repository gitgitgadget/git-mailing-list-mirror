Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D86C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F9A61152
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhJNR2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 13:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhJNR2B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 13:28:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18800C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 10:25:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g198-20020a1c20cf000000b0030d60cd7fd6so98224wmg.0
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=xaWefaA/2keOSncK3yD7/2f/UIIYRuB62zbZ3SWWcAU=;
        b=Cbk8U+jj5T5rFPIJuDa5V3cS5qzvwv2OVBmxzbcYQDgpvfqR5lxneFFVUTkHYzwNVs
         69DTlvcdLiteqcKZ5EicS6ERCQwRZYh3bUuFI0tpZlYEC4bGQ8Bo5OxMJMrHAGufMAv+
         4sx0rCG/nyEDy91eMuVkBNkCk8fPZmvybpAInLjthz8d3i39cQWXFi4eBP96n4W5oU12
         NXZoOAq61G9wEbWB66R1f3JkIMvA8A6118ONybXDbXokCCM/lSKmXjX8GKVCr8kbGMtB
         21ncUDT2ZvbykYTI+kCXG5PnSRdCcbXYhb8DawVmKvDr6MiEkf+FOlaFaAsh/MIDFYZ4
         VQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xaWefaA/2keOSncK3yD7/2f/UIIYRuB62zbZ3SWWcAU=;
        b=X9m199KUoPd1yqB0WQN4ijr6/svLnw3eErF7ty40d5OohjjdAv6p940Hj7j6i95wl8
         b5uwqp6f9vbaw3WRwAMD8SxfYbsr2YvrSwyf3Btc9WbZjykFXN9NUrFJu2NX1cZpLp5L
         zJblLcpytXIPoFPl/l5sK8FESQt+ZaVTZQdKCSsDFBCl2gl86+YDFxz+SnyoiGe9KukC
         nTdt36QwD5pBHLYlDpkReo108d/24Zix2oC56S8cljoOUCk2ndMEctVk+ucX+wzJY8al
         oQ3I7zKdhPXtusjT5alg8cfjwy+602UsAG+jo0KRf0RwuB16y8ZPm+EmdM8j+a6CkPK6
         jJSg==
X-Gm-Message-State: AOAM531aZTLV+gP6k7MjxjkfeMnvlBV5deZq2SQ6RiFBOYYBtPWvUCMe
        D+CtRGAWTZW3Lq7//eJgs2zz+h/7nGo=
X-Google-Smtp-Source: ABdhPJyhwu9teufnrD4ihg0ksqj4FQ0ybNFQwUToECP24dH1rg8VwGnrk3E46nLVwfId3Sz6TTU1Tg==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr13284025wmj.182.1634232354677;
        Thu, 14 Oct 2021 10:25:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6sm2809018wmg.10.2021.10.14.10.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:25:53 -0700 (PDT)
Message-Id: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 14 Oct 2021 17:25:50 +0000
Subject: [PATCH 0/2] Sparse Index: diff and blame builtins
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on vd/sparse-reset. It integrates the sparse index with
git diff and git blame and includes:

 1. tests added to t1092 and p2000 to establish the baseline functionality
    of the commands
 2. repository settings to enable the sparse index

The p2000 tests demonstrate a ~30% execution time reduction for 'git diff'
and a ~75% execution time reduction for 'git diff --staged' using a sparse
index. For 'git blame', the reduction time was ~60% for a file two levels
deep and ~30% for a file three levels deep.

Test                                         before  after
----------------------------------------------------------------
2000.30: git diff (full-v3)                  0.37    0.36 -2.7%
2000.31: git diff (full-v4)                  0.36    0.35 -2.8%
2000.32: git diff (sparse-v3)                0.46    0.30 -34.8%
2000.33: git diff (sparse-v4)                0.43    0.31 -27.9%
2000.34: git diff --staged (full-v3)         0.08    0.08 +0.0%
2000.35: git diff --staged (full-v4)         0.08    0.08 +0.0%
2000.36: git diff --staged (sparse-v3)       0.17    0.04 -76.5%
2000.37: git diff --staged (sparse-v4)       0.16    0.04 -75.0%
2000.62: git blame f2/f4/a (full-v3)         0.31    0.32 +3.2%
2000.63: git blame f2/f4/a (full-v4)         0.29    0.31 +6.9%
2000.64: git blame f2/f4/a (sparse-v3)       0.55    0.23 -58.2%
2000.65: git blame f2/f4/a (sparse-v4)       0.57    0.23 -59.6%
2000.66: git blame f2/f4/f3/a (full-v3)      0.77    0.85 +10.4%
2000.67: git blame f2/f4/f3/a (full-v4)      0.78    0.81 +3.8%
2000.68: git blame f2/f4/f3/a (sparse-v3)    1.07    0.72 -32.7%
2000.99: git blame f2/f4/f3/a (sparse-v4)    1.05    0.73 -30.5%


Thanks, Lessley

Lessley Dennington (2):
  diff: enable and test the sparse index
  blame: enable and test the sparse index

 builtin/blame.c                          |  3 ++
 builtin/diff.c                           |  3 ++
 t/perf/p2000-sparse-operations.sh        |  4 ++
 t/t1092-sparse-checkout-compatibility.sh | 66 +++++++++++++++++++++---
 4 files changed, 69 insertions(+), 7 deletions(-)


base-commit: 57049e844c80d5fe1394e6d65b28705eabfd6585
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1050%2Fldennington%2Fdiff-blame-sparse-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1050/ldennington/diff-blame-sparse-index-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1050
-- 
gitgitgadget
