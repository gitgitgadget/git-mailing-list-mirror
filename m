Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD27C433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 20:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355585AbhLDUDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 15:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352970AbhLDUDt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 15:03:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A155C061751
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 12:00:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q3so13312632wru.5
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 12:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=h27KcAkkWuVVgfdWmxzTOoaOjKbUz076blQQQ6PJc4c=;
        b=SmYXrbmb2gbpvh1aQle6/dTCxafXh24lWmsAwjRkU3J78B+0/j3gCPWbMBhYrj7few
         RDHcMRb9LjV3YPWyBHieV+H0IyhuwHX60iq61ErCEF5pqs7JUMgWuDjl6eeAh7ogKi6E
         orYF65n15REoi/zQK951G7pDGCRKx9St+uMZtlSNDig+qltqaKJt7TEP1Z4RcZAeiC9b
         BrgEq5lircMDwCMvWUEDpAGXnXD1ynFHzxlZtdIBfTIkJjoojxlBNot0NvKmX22aUkVU
         a1y0cUaLjhl1u0N+80i11fR8D6OVdKtw+8sxfjcfjC6BEP6IrmcRAPxcGBzxYnzL0Il2
         eclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h27KcAkkWuVVgfdWmxzTOoaOjKbUz076blQQQ6PJc4c=;
        b=pemkXfxOFr3hIm36h+4NAXbUVUel1hTMY4MmpOggULCX/Ys1CmZbzsky9W9nWlFCtF
         uZWwhH52ehPDEKBLqQ07nakcaUUX9oHXEmBI0kpL7hl63AiLHVuHYI1dW6p3TiYdvD21
         6a+tvSo0DXVLWAaIbCvsCssX8GJgX/gYjD2583oRf7mWjQqHAidI+HiaRJ/5SSkXTXko
         s0G4VI9hY2UJecqV6d06MdfcOAAiDy/t1Uvuu8NPw1152iwCOnO0L8QirzHiI6tptYS0
         1WBRJLeemO2KXyDdJgibXKzmM701Lda4jGcnAjE+gXty/+73TguuEEw3B7wffQL0v+qU
         o7Dw==
X-Gm-Message-State: AOAM533nje8VcoEouedo2o9RcEUlH5jutGOnZ5O1O232lwdw+H442f+r
        h4k7VdekHFBdOYkrT4n/LdjvXH+bbUY=
X-Google-Smtp-Source: ABdhPJx+KqGLjGjdz5bBZXRne1nQ8PwzF5nWmVidGmVWZlNpCCuA9CBnmoQ65khq5GbhtY8GLk+/qg==
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr30555229wrw.283.1638648021821;
        Sat, 04 Dec 2021 12:00:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm7908389wrr.10.2021.12.04.12.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 12:00:21 -0800 (PST)
Message-Id: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 20:00:14 +0000
Subject: [PATCH 0/6] sparse-checkout: make set subsume init
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As described at [1], the split of init and set subcommands in
sparse-checkout causes multiple issues:

 * Poor performance (deleting all tracked files, then later restoring many
   and maybe even most of them)
 * Poor UI (multiple progress bars in wrappers that hide both commands under
   1 user-facing command)
 * Loss of ignored files under directories the user wanted to keep

This series fixes this bug by providing a single command to switch to a
sparse-checkout: set. It does so by making set able to do the combined work
of init and set. It keeps init as-is to give folks time to adapt, but marks
it as deprecated.

A quick overview:

 * Patches 1-2: small preparatory refactorings
 * Patch 3: the crux of the series
 * Patches 4-5: documentation modifications (Patch 4 is worth reviewing; it
   marks init as deprecated -- are others okay with that?)
 * Patch 6: trivial modification of git clone --sparse to use git
   sparse-checkout set rather than git sparse-checkout init.

[1]
https://lore.kernel.org/git/CABPp-BE8TJ8QGAQWsSGT7S+9Xp-XmApcC9PSw3K=RQOP0rt+PQ@mail.gmail.com/

Elijah Newren (6):
  sparse-checkout: pass use_stdin as a parameter instead of as a global
  sparse-checkout: break apart functions for sparse_checkout_(set|add)
  sparse-checkout: enable `set` to initialize sparse-checkout mode
  git-sparse-checkout.txt: update to document that set handles init
  Documentation: clarify/correct a few sparsity related statements
  clone: avoid using deprecated `sparse-checkout init`

 Documentation/git-clone.txt           |   8 +-
 Documentation/git-sparse-checkout.txt |  94 ++++++++++---------
 builtin/clone.c                       |   2 +-
 builtin/sparse-checkout.c             | 130 +++++++++++++++++++++-----
 4 files changed, 160 insertions(+), 74 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1151%2Fnewren%2Fsparse-checkout-no-init-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1151/newren/sparse-checkout-no-init-v1
Pull-Request: https://github.com/git/git/pull/1151
-- 
gitgitgadget
