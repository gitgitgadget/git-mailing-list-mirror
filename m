Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAD2C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhLGRs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhLGRs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:48:58 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA08C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:45:27 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u17so23787116wrt.3
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=wMIi5M+HiKRHS6hN2tUgw6e4rAqPgeEk2LtLwKdooXg=;
        b=ZCzHRtk8Ic+zEM5IrmZ8UU3W4bbz4PVnfOBfbOkLE+MJBT7ih6knSXkaM/4uhFp26G
         VO0qzE56JwfXrdhtnJFGicDTaS0Beo3uf5xNfbXIAeBqBjD1c4OSSZYY2by0tfHwqIEG
         LvUC/IYDoCZmCbs5nK/8oXj7bcSwYdz1aoF4hTqkx92lGkHpaevaA+YN+tqbFbf2U346
         71BsBDG8qqvuus3wYVTUcIQggCFZIbt3H6dcP+Kd/cuojHkMqwOX016mZoD/zX10QJj3
         VmU8iu3xsN2UeCgIjTDQ9HM1a0W7TYFsvOD1i1zLTuhQo9aM62k6k2JRcPT0/M4orLIu
         OfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wMIi5M+HiKRHS6hN2tUgw6e4rAqPgeEk2LtLwKdooXg=;
        b=1g81GjTAaSQxIroV39ajoyFapjuW3keuI22WzIodog8kg6AlqnmTAyGH/GMjJa2Xv+
         Smm3mrSTN7QlyYhnL7b5jHR3LUKOWoI7eMgVgNKMeZRJRhL/FjXC/MaR/SIk7Nh+xCPK
         PHngz4QTAxlPHEx6QDG35VfuKdswRqngKMkA7/TataWZDyEFC3+0QOPc6R2uMuB/x2Qv
         X0sFSw9tdhftniNwFELIDBNtDdsau08DHIPwLgpP4Qhp9KU4GS4I7n4AlMl5qPofAFpR
         JdtZn4iX/+tTExY9cq12j7vCGvHMkkahOtA3DcUplwvb8ghaUENg/WbFRzI66MWQviOW
         Q25g==
X-Gm-Message-State: AOAM5320RUhVRV/ECxhImTeUYooa2unWZtpFbaSx3pqsK61/sneT14yd
        t2N1+o8SmKSa/bK19qMsNLxqgR5XOig=
X-Google-Smtp-Source: ABdhPJwQxdYGfzQX6TWc2LojnKJgg67Xl1t4ypBNF5fDddpmByW/Se5N7ptDqAcOJW39FCiJZxZcmQ==
X-Received: by 2002:a5d:4312:: with SMTP id h18mr53364338wrq.626.1638899126006;
        Tue, 07 Dec 2021 09:45:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm414529wrp.8.2021.12.07.09.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:45:25 -0800 (PST)
Message-Id: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 17:45:14 +0000
Subject: [PATCH 00/10] Reftable coverity fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series was targeted to 'next'.

This addresses some complaints from Coverity that Peff reported.

CI on GGG shows a segfault on windows
(https://github.com/git/git/runs/4446635428?check_suite_focus=true), which I
can't make sense of. Any hints would be greatly appreciated.

Han-Wen Nienhuys (10):
  reftable: fix OOB stack write in print functions
  reftable: fix resource leak in error path
  reftable: fix resource leak blocksource.c
  reftable: check reftable_stack_auto_compact() return value
  reftable: ignore remove() return value in stack_test.c
  reftable: fix resource warning
  reftable: fix NULL derefs in error paths
  reftable: order unittests by complexity
  reftable: drop stray printf in readwrite_test
  reftable: make reftable_record a tagged union

 reftable/block.c          |  29 ++++--
 reftable/block_test.c     |  22 ++---
 reftable/blocksource.c    |   6 +-
 reftable/generic.c        |  35 ++++----
 reftable/iter.c           |   4 +-
 reftable/merged.c         |  37 ++++----
 reftable/pq.c             |   3 +-
 reftable/pq_test.c        |  31 +++----
 reftable/reader.c         | 108 ++++++++++++-----------
 reftable/readwrite_test.c |   1 -
 reftable/record.c         | 180 +++++++++++++++-----------------------
 reftable/record.h         |  45 ++++------
 reftable/record_test.c    | 162 +++++++++++++++++-----------------
 reftable/stack.c          |  15 ++--
 reftable/stack_test.c     |   3 +-
 reftable/writer.c         |  46 +++++-----
 t/helper/test-reftable.c  |   9 +-
 17 files changed, 360 insertions(+), 376 deletions(-)


base-commit: a8338297339b1ab064e799c15c4fc56c122ef967
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1152%2Fhanwen%2Freftable-coverity-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1152/hanwen/reftable-coverity-v1
Pull-Request: https://github.com/git/git/pull/1152
-- 
gitgitgadget
