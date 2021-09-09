Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF7FC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9445861100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243845AbhIISsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241991AbhIISso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:48:44 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9862AC061764
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:33 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s22-20020a056a001c5600b0041028eb25a5so1831938pfw.12
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4tS4DRsgjpwdgFsFff6RsK+obxaacP+TnajYgC8Gt/g=;
        b=d+luBvS3QFIOM35YoSt6d73LTBkgB/vwoBykwbR08cj/3V76E8DJjGGTeEmZoe9Dpr
         iCJ2RkqOHHFnv0i5Ui/WkxboRjQ5rnjixLJQJGU2A8Nse8AsqC/79p/8SSwOeDi70E2d
         T7dENSrx8GhRDzbi560K7C1VpDQp8HgY5P3vfJ760xle0YE9sQyGbgEjIpuP6/mD/lD2
         aJnda4YNh6kG+W67xqpsUVrWmCzaoXWZS8N3tKnAuzewb6HTsnFhnHJPmWBTsSIpooMo
         Doii3Z7cANgEmBadAwDrnXLzTu54dpSmkPAW/vwN6lB1Qs8PEhhXOs2YGGYM+u9rkigy
         pfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4tS4DRsgjpwdgFsFff6RsK+obxaacP+TnajYgC8Gt/g=;
        b=HPuHuVZG9H/cvw9gKVYHmgkmxyMR0ewQyklWhzWNNJ51tFbj1DOZquL2cwFU25LJQe
         WBATtFqCaJBfxQd+UsoLYyuAu1d4loR8WlNSmNP3qFfFkK9KAFcg73N2Jh4i6IajhQUD
         rHTjOD1mfz93qbcie5rPZVsGnLIWfHHlkrBuzsyZqO3ALlTkupdsKvECAitreftK0FmL
         FOzfbX2xNZA2LHkwGnMqRpz6x+2JG4jrN44YnYAUbjdqGwyl0NMQdgaZC18sMbcwqAcR
         045ez6d0p4wdTHMnCuS5oclx+pG7IGMy/3qH8NjsaOfm5Pck3lX/+LJUfVOMsYi9KZ7l
         p57Q==
X-Gm-Message-State: AOAM533zt/hEPPHUlr0AfUShVN5CFhbbKhw/GTtP8hWsYCtcL45QrnBa
        Z15Vm1GBRqEXgk22VXLZcWDyEmScjVCUcpDLs85VcoiUsI+d6tzsKfYpY1Xfb3z9KVSQ+LqsnDs
        EoRQEHWrm92VKu8MfBvKLCDLVx5pvJ/TayTod6KjEbFh/AR6zzgW77FN8sjh1LCwssJF3GPIGDL
        4J
X-Google-Smtp-Source: ABdhPJye/6Yu+oQwVTAj9m8GyTyVvToiK1obEj8XsXL+f2dLJ6ytbpVQ2vJpldLrLdEpQUaxJU8K/JcctwNaTjF1/L26
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:ac43:: with SMTP id
 z3mr3914263pgn.402.1631213253010; Thu, 09 Sep 2021 11:47:33 -0700 (PDT)
Date:   Thu,  9 Sep 2021 11:47:26 -0700
In-Reply-To: <cover.1631123754.git.jonathantanmy@google.com>
Message-Id: <cover.1631212893.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1631123754.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 0/3] More add_submodule_odb() cleanup in merge code
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is on jt/grep-wo-submodule-odb-as-alternate (unlike version 1)
because that branch introduces another usage of repo_submodule_init(),
and I need to update it.

The main change from version 1 is that I have introduced a patch (patch
2) that teaches repo_submodule_init() to support submodules with
unabsorbed gitdirs, which means that I no longer need the original patch
1 that updated t6437 to absorb all git dirs.

Once again, all these patches work under
GIT_TEST_MERGE_ALGORITHM=recursive and GIT_TEST_MERGE_ALGORITHM=ort (and
when that envvar is unset, for good measure).

I have also tested it with the "DO NOT SUBMIT" patch 3 from version 1.

Jonathan Tan (3):
  submodule: remove unnecessary unabsorbed fallback
  repository: support unabsorbed in repo_submodule_init
  revision: remove "submodule" from opt struct

 builtin/grep.c                               |  5 +-
 builtin/ls-files.c                           |  4 +-
 builtin/submodule--helper.c                  |  7 +--
 merge-ort.c                                  | 53 +++++++++++++-------
 merge-recursive.c                            | 49 +++++++++++-------
 repository.c                                 | 21 ++++----
 repository.h                                 | 15 +++---
 revision.c                                   | 16 ++----
 revision.h                                   |  1 -
 submodule.c                                  | 24 ++-------
 t/helper/test-submodule-nested-repo-config.c |  4 +-
 11 files changed, 102 insertions(+), 97 deletions(-)

-- 
2.33.0.309.g3052b89438-goog

