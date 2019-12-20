Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA65C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035B6218AC
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNuXG1sc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfLTWFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:05:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35520 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfLTWFY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:05:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so9858943edv.2
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 14:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=GqjoywjsgXkIOLG+hauRwpjnXfuWKFTzLJNZD9Q+qw4=;
        b=kNuXG1scSiO60Q2sEw6i/g7QDxnkmFg8ROrP+lBR2KUc3w69WEPIGGh0Ggfak5Ij1B
         HY/iCgaCFSnQA+YpcKevdidtrZ+zCiYE16G26/JsWtNLcDjTxAUuPGcketzbsj3Xp6vg
         NbvM/eNScfJAFJuSuqp2WtILwb+NKvRdwB2f61NeT2G/NkuFKCSECyYWB6x+f2dgko5u
         Y829jHPp9DR9uZBRPc+LPvgp3zipjG8DPV3xDERYk4JxFFfJriqrOQqFuuCVv7I56Zsc
         cnHs0BSTasZnffsqOyvsDZm20jsyGZvBGvjtIHvo6CJMUQ5q4pa/Gh+nv9OaaGm4IjVa
         w26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=GqjoywjsgXkIOLG+hauRwpjnXfuWKFTzLJNZD9Q+qw4=;
        b=PlZFScf+beIUtnrCUwSQWVSLyXP89li2UIGtYTxT4F8jxDlttPdGjJV0TErJwSTa1E
         rOYAA1yuhC7J2Dxy7/5uJc+AgZYHMDpAtH+UyZbY1l7v0SXE7dR99/L4flhbM2Ut7dvh
         H38LnI9qRt55gTlErE4mR6TsEbyz92LBlkF2LbkwQGr+kk9xsST2ug7+l/RmNniqH9r6
         v9hNFI234Wzlt5TNpYi95UUP+741xVz/ebTIuEJoQKMe+SGdvKKx11RGDBzEhawg3CRn
         Ia2CBVtAn2HJUsLvERcm+Ub4jytj8Jji/SXFRTEAZg67D0toUY/tNUnkC5HvyfUnAUE+
         gGRA==
X-Gm-Message-State: APjAAAUIcosmFNQyWvcLKrjtizRcxXyWnDfInc34wqPUL2BDnE12aDD9
        9SE5MokFXHwipU12imw64qk72XYN
X-Google-Smtp-Source: APXvYqyh6QkbV+OERSFEUHTCaUel0UnZ3A9WyyPHtvLuCAoXtlrvzEbkjAEVBiTHMhBz66edaveOoA==
X-Received: by 2002:a17:906:4e46:: with SMTP id g6mr18650829ejw.309.1576879522469;
        Fri, 20 Dec 2019 14:05:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4sm1098636edr.59.2019.12.20.14.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 14:05:21 -0800 (PST)
Message-Id: <pull.497.git.1576879520.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 22:05:11 +0000
Subject: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey! 

The commit graph feature brought in a lot of performance improvements across
multiple commands. However, file based history continues to be a performance
pain point, especially in large repositories. 

Adopting changed path bloom filters has been discussed on the list before,
and a prototype version was worked on by SZEDER Gábor, Jonathan Tan and Dr.
Derrick Stolee [1]. This series is based on Dr. Stolee's approach [2] and
presents an updated and more polished RFC version of the feature. 

Performance Gains: We tested the performance of git log -- path on the git
repo, the linux repo and some internal large repos, with a variety of paths
of varying depths.

On the git and linux repos: We observed a 2x to 5x speed up.

On a large internal repo with files seated 6-10 levels deep in the tree: We
observed 10x to 20x speed ups, with some paths going up to 28 times faster.

Future Work (not included in the scope of this series):

 1. Supporting multiple path based revision walk
 2. Adopting it in git blame logic. 
 3. Interactions with line log git log -L

This series is intended to start the conversation and many of the commit
messages include specific call outs for suggestions and thoughts. 

Cheers! Garima Singh

[1] https://lore.kernel.org/git/20181009193445.21908-1-szeder.dev@gmail.com/
[2] 
https://lore.kernel.org/git/61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com/

Garima Singh (9):
  commit-graph: add --changed-paths option to write
  commit-graph: write changed paths bloom filters
  commit-graph: use MAX_NUM_CHUNKS
  commit-graph: document bloom filter format
  commit-graph: write changed path bloom filters to commit-graph file.
  commit-graph: test commit-graph write --changed-paths
  commit-graph: reuse existing bloom filters during write.
  revision.c: use bloom filters to speed up path based revision walks
  commit-graph: add GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS test flag

 Documentation/git-commit-graph.txt            |   5 +
 .../technical/commit-graph-format.txt         |  17 ++
 Makefile                                      |   1 +
 bloom.c                                       | 257 +++++++++++++++++
 bloom.h                                       |  51 ++++
 builtin/commit-graph.c                        |   9 +-
 ci/run-build-and-tests.sh                     |   1 +
 commit-graph.c                                | 116 +++++++-
 commit-graph.h                                |   9 +-
 revision.c                                    |  67 ++++-
 revision.h                                    |   5 +
 t/README                                      |   3 +
 t/helper/test-read-graph.c                    |   4 +
 t/t4216-log-bloom.sh                          |  77 ++++++
 t/t5318-commit-graph.sh                       |   2 +
 t/t5324-split-commit-graph.sh                 |   1 +
 t/t5325-commit-graph-bloom.sh                 | 258 ++++++++++++++++++
 17 files changed, 875 insertions(+), 8 deletions(-)
 create mode 100644 bloom.c
 create mode 100644 bloom.h
 create mode 100755 t/t4216-log-bloom.sh
 create mode 100755 t/t5325-commit-graph-bloom.sh


base-commit: b02fd2accad4d48078671adf38fe5b5976d77304
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-497%2Fgarimasi514%2FcoreGit-bloomFilters-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-497/garimasi514/coreGit-bloomFilters-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/497
-- 
gitgitgadget
