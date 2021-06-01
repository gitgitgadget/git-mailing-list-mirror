Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89566C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F21B60FE3
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbhFAVgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 17:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbhFAVgF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 17:36:05 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20536C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 14:34:24 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id me1-20020a17090b17c1b029015f8192660bso372825pjb.7
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=d86vl+KQkO0pbccmIolvyCFcre2XHtd6J1bhMG2z8SA=;
        b=SfrHDTPbdi4HJKkB6xcF6EBiN/7OF4m969f6nRS49sTuIE2h2qHQUKHC4Phj7YmCQS
         2Km2821LF8gKaaHEb/7GicwV2Mz0mxhQvhlrtxEBDxpC81+DVZQLTXg004weIBYmWHKU
         dpna052T88OfbxgETBxOGdg4PsAUs9LtUPBfdosLISdzm/stFMYCtyk63H7/gseevH+N
         caE2LxhALjTXLSOS2u9Z5yEbfOA/5VFkcLAogVuyBaTre9NsuZC9UXF7SdZhKXV/O/cf
         IZMdNlBbT5dwmJbJLkBWBcWzEqOWmBSWNeqvbNBpNi/BAJhhh0uevrOmZP1w+6vxZ3d3
         Sybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=d86vl+KQkO0pbccmIolvyCFcre2XHtd6J1bhMG2z8SA=;
        b=XG8pHC1qVzbw2DR4JkYCgLj3WW/LTLQpYggKWMjXFO0NpZ4G/kzsxfIHrGV3nKa348
         d/CbPHe8BHHUvp1i1natbosQu1O4hayn1GzUHz7//M74b0rPxfet3ah3OVVTaLVi1a1N
         ZfocjS7pOmuIEZGdRmt/JxQSMJQOky35PWYiXfl9RyWTfmjSrxw3p3L3kDnDeQ9lVyzB
         ySL3aGPVmmxoYnQ73mgU5Ij16LTm0pcauQU6tqaxAWF7lp2CMbJUdfbp/lVZJiT/6g6Z
         eD4rb5ekYXQkME++74V8epDTx23X1EapXRCyNbe1QyF+o6z4IOOlFA2ittIiS5TZjNQj
         xhwA==
X-Gm-Message-State: AOAM530+Aa6pl/pTVXeKHWmJE5yDz92lEvoEVR0idMWrAUUvOV0eGDQZ
        qhvgDoKMiPr7+fRt7fSwaUADtXJ8VvY8nALfpqL39FvvHPhQI9mmWV1YZtBh7rRjFMeHM6LRUJR
        nl6rbI1DfCAOU7Xm4awbGman2gd2yV4m9BEIM3SRCzdyBmrwFSsQQb37vxICH3kjN85Kly6FTpS
        Gd
X-Google-Smtp-Source: ABdhPJxHiTekaafPXYcP5Od7uI5ryKRt3nnPvObgJZPQCaAQiNefKUzsxEtG9JfmjzElc2/tgaKpye30IaVdLYBrzdhv
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:1141:: with SMTP id
 d1mr27309970pje.56.1622583263462; Tue, 01 Jun 2021 14:34:23 -0700 (PDT)
Date:   Tue,  1 Jun 2021 14:34:15 -0700
Message-Id: <cover.1622580781.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH 0/4] First steps towards partial clone submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a preliminary step towards supporting partial clone submodules
(e.g., by cloning with --recurse-submodules and having the given filter
propagate to submodules). Even with this patch set, we won't be there
yet (notably, some code in Git access objects in submodules by adding
them as alternates - so lazy-fetching missing objects in submodules
wouldn't work here), but at least this is a first step.

This patch set would also be useful if Git needed to operate on
other repositories (other than in the submodule case), but I can't think
of such a situation right now.

As mentioned, there is still more work that needs to be done. Any help
is appreciated, and as for me, I hope to get back to this in the 3rd
quarter of the year.

Jonathan Tan (4):
  promisor-remote: read partialClone config here
  promisor-remote: support per-repository config
  run-command: move envvar-resetting function
  promisor-remote: teach lazy-fetch in any repo

 Makefile                      |   1 +
 cache.h                       |   1 -
 object-file.c                 |   7 +-
 promisor-remote.c             | 119 +++++++++++++++++++---------------
 promisor-remote.h             |  26 +++++---
 repository.h                  |   4 ++
 run-command.c                 |  10 +++
 run-command.h                 |   7 ++
 setup.c                       |  10 ++-
 submodule.c                   |  14 +---
 t/helper/test-partial-clone.c |  34 ++++++++++
 t/helper/test-tool.c          |   1 +
 t/helper/test-tool.h          |   1 +
 t/t0410-partial-clone.sh      |  24 +++++++
 14 files changed, 177 insertions(+), 82 deletions(-)
 create mode 100644 t/helper/test-partial-clone.c

-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

