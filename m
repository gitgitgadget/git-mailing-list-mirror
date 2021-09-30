Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14F3C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE52761A56
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351531AbhI3Owr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349797AbhI3Owq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 10:52:46 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8BFC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b192-20020a1c1bc9000000b0030cfaf18864so4547372wmb.4
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=0CCt8/5IR42Wfd9qrNU42gBGZD1GEHugPr2B9FNcWHI=;
        b=pK9jDH6Pxayuhueo/ZxBLSuER1jEb/Uxy+coDpI1+PIVuTggmgzwhFxHqbD6q6LGEO
         nJy+T2pIDczL2PGskUQM2Iv4fWMJzx8mwvjcEMFYCAJZuekBK/+gqwniNQxdcJsiAc8L
         sbdJ58U7/u60UvxKUBnZOf1tcJPpU/bYNkx7EUOl9vAAtTvEOGEB9oFxx7QcYRgwOjbh
         BQIpsW2Z8/eTPUztBbvnBgRrCpEe7M2uSclWP13nfixoxlaUr6xNzEidsWj+As4krsEM
         vl4RUYRip0S6LszscePm8JDZ/lhI+MThNcRJ8ZBAMnBZvDWJnU/yFc5ULM9PhBHocGMY
         dWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0CCt8/5IR42Wfd9qrNU42gBGZD1GEHugPr2B9FNcWHI=;
        b=qL04JAsOMM3s48AYpJicUK9HNlnbfK/BtD76MAQU8F/cRQfKeCcYAzaAuegC9cChrE
         LopLgtsIc1tcea4AQdlpPTbaH0oir9jURWm1r0ZAEpIKjvaENcSJ7ugozSPnAAEXmzke
         u5axH3nMmu2VScbMQOIoa32NreY/lm6PNAqxCxBzr/PLljhDVLaWgG+7p2+wNB+Wptri
         ARcEF4XcU02euH6w/MenSRQuGn29sQGoLyonQ/L995Qqmtu6PwDGfWA/ERk2nyKfI1LR
         xNyQf6LLw2jowkqrsXUZpEit44M+iSMSqdE1V2qvOUzYK601oCIDF1KKetdroZ9UDweb
         vnFQ==
X-Gm-Message-State: AOAM531cuqVEASaYvmoKSjuH+tP/dsujqVq5mk9SFCrd7XNYWyC8rmev
        vtJjOy4NnwBdr/r6RMlqRpTT0CM5m7E=
X-Google-Smtp-Source: ABdhPJxXkZLGoMjgJ57NRL/ncC6GOhlwuz0NPeTYJXE5ch1cDs/p0YIK+9BwG++PNComY23q1x9nww==
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr16339282wmk.11.1633013462696;
        Thu, 30 Sep 2021 07:51:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d70sm3157922wmd.3.2021.09.30.07.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:51:02 -0700 (PDT)
Message-Id: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Sep 2021 14:50:54 +0000
Subject: [PATCH 0/7] Sparse Index: integrate with reset
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series integrates the sparse index with git reset and provides
miscellaneous fixes and improvements to the command in sparse checkouts.
This includes:

 1. tests added to t1092 and p2000 to establish the baseline functionality
    of the command
 2. repository settings to enable the sparse index with ensure_full_index
    guarding any code paths that break tests without other compatibility
    updates.
 3. modifications to remove or reduce the scope in which ensure_full_index
    must be called.

The sparse index updates are predicated on a fix originating from the
microsoft/git fork [1], correcting how git reset --mixed handles resetting
entries outside the sparse checkout definition. Additionally, a performance
"bug" in next_cache_entry with sparse index is corrected, preventing
repeatedly looping over already-searched entries.

The p2000 tests demonstrate an overall ~70% execution time reduction across
all tested usages of git reset using a sparse index:

Test                                               before   after       
------------------------------------------------------------------------
2000.22: git reset (full-v3)                       0.48     0.51 +6.3% 
2000.23: git reset (full-v4)                       0.47     0.50 +6.4% 
2000.24: git reset (sparse-v3)                     0.93     0.30 -67.7%
2000.25: git reset (sparse-v4)                     0.94     0.29 -69.1%
2000.26: git reset --hard (full-v3)                0.69     0.68 -1.4% 
2000.27: git reset --hard (full-v4)                0.75     0.68 -9.3% 
2000.28: git reset --hard (sparse-v3)              1.29     0.34 -73.6%
2000.29: git reset --hard (sparse-v4)              1.31     0.34 -74.0%
2000.30: git reset -- does-not-exist (full-v3)     0.54     0.51 -5.6% 
2000.31: git reset -- does-not-exist (full-v4)     0.54     0.52 -3.7% 
2000.32: git reset -- does-not-exist (sparse-v3)   1.02     0.31 -69.6%
2000.33: git reset -- does-not-exist (sparse-v4)   1.07     0.30 -72.0%


[1] microsoft@6b8a074

Thanks! -Victoria

Kevin Willford (1):
  reset: behave correctly with sparse-checkout

Victoria Dye (6):
  sparse-index: update command for expand/collapse test
  reset: expand test coverage for sparse checkouts
  reset: integrate with sparse index
  reset: make sparse-aware (except --mixed)
  reset: make --mixed sparse-aware
  unpack-trees: improve performance of next_cache_entry

 builtin/reset.c                          |  77 ++++++++++++-
 cache-tree.c                             |  43 ++++++-
 cache.h                                  |  10 ++
 read-cache.c                             |  22 ++--
 t/perf/p2000-sparse-operations.sh        |   3 +
 t/t1092-sparse-checkout-compatibility.sh | 139 ++++++++++++++++++++++-
 t/t7114-reset-sparse-checkout.sh         |  61 ++++++++++
 unpack-trees.c                           |  23 +++-
 8 files changed, 353 insertions(+), 25 deletions(-)
 create mode 100755 t/t7114-reset-sparse-checkout.sh


base-commit: cefe983a320c03d7843ac78e73bd513a27806845
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1048%2Fvdye%2Fvdye%2Fsparse-index-part1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1048/vdye/vdye/sparse-index-part1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1048
-- 
gitgitgadget
