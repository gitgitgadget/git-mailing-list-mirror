Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922B8C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 17:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiADRhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 12:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbiADRhE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 12:37:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AE0C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 09:37:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so69511wmj.5
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 09:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=9v6s1d2pjhB4bs4H17gI8bFTqJLmqOT092bN03K0inw=;
        b=mq5IN49so23T4dbZVMN36qPHOwFZuPobYunyLhrdDFqYHIx0DxcKsU+tcbKeC5kod8
         06uzm/NmeVBoxMppmcxdHSfXjdmW8vdlGP5tlnib7tfUQoAnOh+rGgjKBkyA0R3sr/t3
         0Gw36S7EdUTAcFviT/kqwzc3dZUVTpnqck0AciIFMVmwuTDk68ftkhXSaxmd1KhUqrnc
         fxm4KiqJEqtEeFWoQmBn57bzyZMaGf8Hnpg+8R0YON+b62PBrzDyaqtO6uxxaW/geril
         JUd+Lz2XXoR8LlkgPMel+X+49YiugHbdc0RhZRjZ4BRbH2iR15ScLo/RE9rWsyXmab7X
         geUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9v6s1d2pjhB4bs4H17gI8bFTqJLmqOT092bN03K0inw=;
        b=0HgPFEI1Qnq6zGwMrZ1yQvjv9DXWIsm5XpmPn7GMEVBrwg8I5t/ZPNViHohQPUmq51
         s61N3D+MfZ3rfD79HDjaEmz8JmsDomG0+ibaLdWyFKTlYJZtfa3cd9DUjCKUJhRMyX9Q
         rUwYdFoFszsPOAbuZfwLAUFlRZY/orSncj5gtEYUwr+yDgnNePuAM0Pyi4MzzcVEXi0n
         pbU+T2YUozjqMB2w5N5J25XPfaZPqPF3cJqFW/kwB4AiTXBRpdsyJ+gv8zqfBQgx5pr5
         5qV9EHMOHLk26xhhLIYQHLAyAJOnMN0r8pJ6kemklwLtwfrOoIsotpmVF17vkbarNYxt
         kpEA==
X-Gm-Message-State: AOAM533Didy1ATFl5cT0nYvwbrOqrSK1oYcAMZVy8K8dtW62lvwdyLBg
        nZaAjCJQ4nNNuNizYTZzOb+hqAwDW6w=
X-Google-Smtp-Source: ABdhPJyNUUlcoD7QZvR6wWmnfD49PTa+yaZPdMwIVVqXKMCDoOQ5plTtxBseykF7eCOxucUzAopnbw==
X-Received: by 2002:a05:600c:19c9:: with SMTP id u9mr8686028wmq.92.1641317822058;
        Tue, 04 Jan 2022 09:37:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1sm44902544wru.45.2022.01.04.09.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:37:01 -0800 (PST)
Message-Id: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 17:36:51 +0000
Subject: [PATCH 0/9] Sparse index: integrate with 'clean', 'checkout-index', 'update-index'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series continues the work to integrate commands with the sparse index,
adding integrations with 'git clean', 'git checkout-index', and 'git
update-index'. These three commands, while useful in their own right, are
updated mainly because they're used in 'git stash'. A future series will
integrate sparse index with 'stash' directly, but its subcommands must be
integrated to avoid the performance cost of each one expanding and
collapsing the index.

The series is broken up into 4 parts:

 * Patches 1-2 are minor fixups to the 'git reset' sparse index integration
   in response to discussion [1] that came after the series was ready for
   merge to 'next'.
 * Patch 3 integrates 'git clean' with the sparse index.
 * Patches 4-6 integrate 'git checkout-index' with the sparse index and
   introduce a new '--ignore-skip-worktree-bits' option for use with 'git
   checkout-index --all'.
   * This involves changing the behavior of '--all' to respect
     'skip-worktree' by default (i.e., it won't check out 'skip-worktree'
     files). The '--ignore-skip-worktree-bits' option can be specified to
     force checkout of 'skip-worktree' files, if desired.
 * Patches 7-9 integrate 'git update-index' with the sparse index.
   * Note that, although this integrates the sparse index with
     '--cacheinfo', sparse directories still cannot be updated using that
     option (see the prior discussion [2] for more details on why)

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/CABPp-BG0iDHf268UAnRyA=0y0T69YTc+bLMdxCmSbrL8s=9ziA@mail.gmail.com/

[2]
https://lore.kernel.org/git/a075091c-d0d4-db5d-fa21-c9d6c90c343e@gmail.com/

Victoria Dye (9):
  reset: fix validation in sparse index test
  reset: reorder wildcard pathspec conditions
  clean: integrate with sparse index
  checkout-index: expand sparse checkout compatibility tests
  checkout-index: add --ignore-skip-worktree-bits option
  checkout-index: integrate with sparse index
  update-index: add tests for sparse-checkout compatibility
  update-index: integrate with sparse index
  update-index: reduce scope of index expansion in do_reupdate

 Documentation/git-checkout-index.txt     |  11 +-
 builtin/checkout-index.c                 |  40 +++-
 builtin/clean.c                          |   3 +
 builtin/reset.c                          |  12 +-
 builtin/update-index.c                   |  17 +-
 read-cache.c                             |  10 +-
 t/perf/p2000-sparse-operations.sh        |   2 +
 t/t1092-sparse-checkout-compatibility.sh | 230 ++++++++++++++++++++++-
 8 files changed, 306 insertions(+), 19 deletions(-)


base-commit: dcc0cd074f0c639a0df20461a301af6d45bd582e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1109%2Fvdye%2Fsparse%2Fupdate-index_checkout-index_clean-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1109/vdye/sparse/update-index_checkout-index_clean-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1109
-- 
gitgitgadget
