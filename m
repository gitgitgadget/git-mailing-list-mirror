Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6F6C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CAF20790
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2eT32Wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbgJ0W6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 18:58:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56228 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgJ0W6K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 18:58:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id a72so2856161wme.5
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 15:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=4dxYwwIrLDw0XtUZBLVQTHkmqOGnZi8kZsTokrwEvyQ=;
        b=N2eT32WkN4gRHjN32yudLs7BX7DnirLlXZt/Rz2SSl249z6jSL6fxyD/7JBro+7uy2
         9dMVZn2zOANc9SDbc4FXnJCLJl2VsIqRk98qF2nBjc3dEGArkV6EYR6iJfvRgc6aq/pG
         e0nQ47U6lcvBH7417lbQ/ne7Wu4jpwf+Paz/4OzkTaOmJ20b6HUNar1NerB4SKF8DuTb
         4xY82dcsX8G1bHS1ck7r+ZdcvXrv1vvPu2MKLHDa8P7kmxp949Oz2fQfaKuJLPrCYNHO
         tnh7f+rb3Fnv10bnibKhSyCrprHv88FXXr6h0KgzAsShfsWV0moaEEQwI+mhyDGpWxNc
         A34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4dxYwwIrLDw0XtUZBLVQTHkmqOGnZi8kZsTokrwEvyQ=;
        b=EqEpdcYYXaZPFgWTNWQ3oHaeKIHH5VA6YxzFKucvxVBxoXwT0k27Ab/GkAZKKKxcVD
         jzf7d3Egfg0azGrlBbdcFKlZZG7MS7TAnGG6oRFtqxkPUfwP37xmH5xT+secldm/N2TC
         H+7ZDH6lfLmniemmq2Ki7+7eVsiARqn7SBJV8xbL33dlWkZU0BWJcP0tNRn8HoVTnkpg
         PJuAbFH6/nISeDbFXCbSpHW3Akh5Rker5eiMCWzv7e9E5uCp2c4v/vnu+Cu9MQbNU6nM
         Sq+hq1BDZu6tv6jrjRixMtRe5lgAzJWymC91Vwh6YmMQv6Tv4/X2hd0sqzhOkK/X6tfP
         /INw==
X-Gm-Message-State: AOAM531tUdZuFH9uhINR2Hcx3fzYG1JZHwUE2iPN2SAsthpy+yva7tms
        eePOVsd8hIB+rdUkMxK5Lz0z+2v31iY=
X-Google-Smtp-Source: ABdhPJybTeRUtABiHaypO46icqmHZfgzoSN/eYrMGofsKjE+/C3TrPHBdvJks3/5KLT9yXwrADW8BA==
X-Received: by 2002:a1c:8087:: with SMTP id b129mr5006608wmd.10.1603839488948;
        Tue, 27 Oct 2020 15:58:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4sm3980530wrv.11.2020.10.27.15.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 15:58:08 -0700 (PDT)
Message-Id: <pull.760.git.1603839487.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 22:58:03 +0000
Subject: [PATCH 0/4] Adjust t5411 for the upcoming change of the default branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test script t5411-proc-receive-hook.sh is an interesting case: it not
only requires tons of mostly straight-forward changes that amount to an
automated search-and-replace, but it also requires a few adjustments due to
the change of the default branch name's length.

This patch series is part of the over-all effort tracked in 
https://github.com/gitgitgadget/git/pull/655.

Johannes Schindelin (4):
  t5411: start using the default branch name "main"
  t5411: start adjusting the support files for init.defaultBranch=main
  t5411: adjust the remaining support files for init.defaultBranch=main
  t5411: finish preparing for `main` being the default branch name

 t/t5411-proc-receive-hook.sh                  |  17 ++-
 t/t5411/common-functions.sh                   |   2 +-
 t/t5411/once-0010-report-status-v1.sh         |  50 ++++----
 t/t5411/test-0000-standard-git-push.sh        |  72 +++++------
 .../test-0001-standard-git-push--porcelain.sh |  72 +++++------
 t/t5411/test-0002-pre-receive-declined.sh     |  12 +-
 ...st-0003-pre-receive-declined--porcelain.sh |  12 +-
 t/t5411/test-0011-no-hook-error.sh            |  38 +++---
 t/t5411/test-0012-no-hook-error--porcelain.sh |  38 +++---
 t/t5411/test-0013-bad-protocol.sh             |  96 +++++++-------
 t/t5411/test-0014-bad-protocol--porcelain.sh  |  70 +++++-----
 t/t5411/test-0020-report-ng.sh                |  40 +++---
 t/t5411/test-0021-report-ng--porcelain.sh     |  40 +++---
 t/t5411/test-0022-report-unexpect-ref.sh      |  36 +++---
 ...est-0023-report-unexpect-ref--porcelain.sh |  36 +++---
 t/t5411/test-0024-report-unknown-ref.sh       |  12 +-
 ...test-0025-report-unknown-ref--porcelain.sh |  12 +-
 t/t5411/test-0026-push-options.sh             |  36 +++---
 t/t5411/test-0027-push-options--porcelain.sh  |  36 +++---
 t/t5411/test-0030-report-ok.sh                |  22 ++--
 t/t5411/test-0031-report-ok--porcelain.sh     |  22 ++--
 t/t5411/test-0032-report-with-options.sh      | 120 +++++++++---------
 ...est-0033-report-with-options--porcelain.sh | 120 +++++++++---------
 t/t5411/test-0034-report-ft.sh                |  30 ++---
 t/t5411/test-0035-report-ft--porcelain.sh     |  30 ++---
 ...t-0036-report-multi-rewrite-for-one-ref.sh |  90 ++++++-------
 ...rt-multi-rewrite-for-one-ref--porcelain.sh |  82 ++++++------
 t/t5411/test-0038-report-mixed-refs.sh        |  40 +++---
 .../test-0039-report-mixed-refs--porcelain.sh |  40 +++---
 t/t5411/test-0040-process-all-refs.sh         |  42 +++---
 .../test-0041-process-all-refs--porcelain.sh  |  42 +++---
 ...t-0050-proc-receive-refs-with-modifiers.sh |  42 +++---
 32 files changed, 726 insertions(+), 723 deletions(-)


base-commit: 3224b0f0bb7bc90c0156e73c58f1d2e770f0ad7c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-760%2Fdscho%2Fprepare-for-main-branch-t5411-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-760/dscho/prepare-for-main-branch-t5411-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/760
-- 
gitgitgadget
