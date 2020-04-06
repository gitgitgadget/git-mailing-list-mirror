Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53641C2BA1E
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D0123109
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak80gn5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgDFRAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:00:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33336 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbgDFRAB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:00:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id z65so420344ede.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=FRD2He6QxktMG+aTOAQrG527MhkS5lh/8e411M8pfiQ=;
        b=ak80gn5bsaAy9KF0+FqrybtFOhpPnP42vxL6xd3JNPMMbiOgrozgsc9nmfTOt0wCIQ
         niq8gR55m0lZOR5ooOOriYvr/14hpL56/DQ2Iy5kcXJiWwsYnhZAkVTmKWADlc6edbke
         N1r0pfdq1lIqBmUmdz865bXfqUoQtPqgr7GLAIoJ2lPpcoIaQHmAanzAA2kTs1qMU1XY
         7IzO09W1yqUwtngjp1romgHHv1bMTW1WOxxKbgxPlH06azi5jHtyZ0KbUL83mC8+mz1p
         wqOTGxoSEVavkBKeBjQcbShmXgeZAVx8I9Xsjx/jDr4AWoO6VjI7Hwih4/EQFGevy8Pg
         /VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=FRD2He6QxktMG+aTOAQrG527MhkS5lh/8e411M8pfiQ=;
        b=iwCRL6HwRYXiZyhTBf0QknAwmhbjGfL/54XUECrA/e/lk3jyRprOI69sJk1GP2+tWu
         DZeBjnYaz1lI/iuK9UjM7Omhx++/u6w+029+uPPpH9PPEAZJLvVtJsi/zmtcfsXP91Z0
         N0oOxuPiFT7aSMcnt73jnTg5t4t5KqFq+qU3IjibfxeY+xjFFFSWpkvr4EcAorNcos+Q
         NoVHR27EuSQ+i5SLA0ul7kHXTswCPVCP/VfoqCixTEFevdEIH8QbrKoUAQo6aPc3H7yJ
         uGHsU4R7JQP3XoxYDf+ORFtVSBo0Jz1Cor0LkgdN1WKNO64BrSzYLwuSFc1JG79Ouw4U
         y2/A==
X-Gm-Message-State: AGi0PubRoaaKV8lK8YgQ+d8qqtF8xbwFzHqd37ixsP3eskyJV5RMlgPS
        0SC4flBb19lK8g0bsQMw3JwUaSxi
X-Google-Smtp-Source: APiQypLU3wp5omYXWdbe41D0c9aPNNmX74Ub/IFEXMImHi0j2l0OD7sna/NQt1sJFyus2aPpw1Ougg==
X-Received: by 2002:a05:6402:c0d:: with SMTP id co13mr19185232edb.266.1586192396327;
        Mon, 06 Apr 2020 09:59:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm2504650edm.96.2020.04.06.09.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:59:55 -0700 (PDT)
Message-Id: <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Apr 2020 16:59:40 +0000
Subject: [PATCH v4 00/15] Changed Paths Bloom Filters
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey! 

The commit graph feature brought in a lot of performance improvements across
multiple commands. However, file based history continues to be a performance
pain point, especially in large repositories. 

Adopting changed path Bloom filters has been discussed on the list before,
and a prototype version was worked on by SZEDER Gábor, Jonathan Tan and Dr.
Derrick Stolee [1]. This series is based on Dr. Stolee's proof of concept in
[2]

With the changes in this series, git users will be able to choose to write
Bloom filters to the commit-graph using the following command:

'git commit-graph write --changed-paths'

Subsequent 'git log -- path' commands will use these computed Bloom filters
to decided which commits are worth exploring further to produce the history
of the provided path. 

Cost of computing and writing Bloom filters
===========================================

Computing and writing Bloom filters to the commit graph for the first time
implies computing the diffs and the resulting Bloom filters for all the
commits in the repository. This adds a non trivial amount of time to run
time. Every subsequent run is incremental i.e. we reuse the previously
computed Bloom filters. So this is a one time cost. 

Time taken by 'git commit-graph write' with and w/o --changed-paths, speed
up in 'git log -- path' with computed Bloom filters (see a):- 

-------------------------------------------------------------------------
| Repo        | w/o --changed-paths | with --changed-paths | Speed up   |
-------------------------------------------------------------------------
| git [3]     | 0.9 seconds         | 7 seconds            | 2x to 6x   |
| linux [4]   | 16 seconds          | 1 minute 8 seconds   | 2x to 6x   | 
| android [5] | 9 seconds           | 48 seconds           | 2x to 6x   |
| AzDo(see b) | 1 minute            | 5 minutes 2 seconds  | 10x to 30x |
-------------------------------------------------------------------------

a) We tested the performance of git log -- path with randomly chosen paths
of varying depths in each repo. The speed up depends on how deep the files
are in the hierarchy and how often a file has been touched in the commit
history.

b) This internal repository has about 420k commits, 183k files distributed
across 34k folders, the size on disk is about 17 GiB. The most massive gains
on this repository were for files 6-12 levels deep in the tree. 

c) These numbers were collected on a Windows machine, except for the linux
repo which was tested on a Linux machine. 

Future Work (not included in the scope of this series)
======================================================

 1. Supporting multiple path based revision walk
 2. Adopting it in git blame logic. 
 3. Interactions with line log git log -L

Cheers! Garima Singh

[1] https://lore.kernel.org/git/20181009193445.21908-1-szeder.dev@gmail.com/

[2] 
https://lore.kernel.org/git/61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com/

[3] https://github.com/git/git

[4] https://github.com/torvalds/linux

[5] https://android.googlesource.com/platform/frameworks/base/

jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net, 
garimasigit@gmail.com,jnareb@gmail.com, christian.couder@gmail.com, 
emilyshaffer@gmail.com,gitster@pobox.com

Derrick Stolee (1):
  diff: halt tree-diff early after max_changes

Garima Singh (13):
  commit-graph: define and use MAX_NUM_CHUNKS
  bloom.c: add the murmur3 hash implementation
  bloom.c: introduce core Bloom filter constructs
  bloom.c: core Bloom filter implementation for changed paths.
  commit-graph: compute Bloom filters for changed paths
  commit-graph: examine commits by generation number
  commit-graph: write Bloom filters to commit graph file
  commit-graph: reuse existing Bloom filters during write
  commit-graph: add --changed-paths option to write subcommand
  revision.c: use Bloom filters to speed up path based revision walks
  revision.c: add trace2 stats around Bloom filter usage
  t4216: add end to end tests for git log with Bloom filters
  commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag

Jeff King (1):
  commit-graph: examine changed-path objects in pack order

 Documentation/git-commit-graph.txt            |   5 +
 .../technical/commit-graph-format.txt         |  30 ++
 Makefile                                      |   2 +
 bloom.c                                       | 275 ++++++++++++++++++
 bloom.h                                       |  90 ++++++
 builtin/commit-graph.c                        |  10 +-
 ci/run-build-and-tests.sh                     |   1 +
 commit-graph.c                                | 213 +++++++++++++-
 commit-graph.h                                |   9 +-
 diff.h                                        |   5 +
 revision.c                                    | 126 +++++++-
 revision.h                                    |  11 +
 t/README                                      |   5 +
 t/helper/test-bloom.c                         |  81 ++++++
 t/helper/test-read-graph.c                    |   4 +
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t0095-bloom.sh                              | 117 ++++++++
 t/t4216-log-bloom.sh                          | 155 ++++++++++
 t/t5318-commit-graph.sh                       |   2 +
 t/t5324-split-commit-graph.sh                 |   1 +
 tree-diff.c                                   |   6 +
 22 files changed, 1139 insertions(+), 11 deletions(-)
 create mode 100644 bloom.c
 create mode 100644 bloom.h
 create mode 100644 t/helper/test-bloom.c
 create mode 100755 t/t0095-bloom.sh
 create mode 100755 t/t4216-log-bloom.sh


base-commit: 3bab5d56259722843359702bc27111475437ad2a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-497%2Fgarimasi514%2FcoreGit-bloomFilters-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-497/garimasi514/coreGit-bloomFilters-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/497

Range-diff vs v3:

  1:  c3ffd9820d5 =  1:  c3ffd9820d5 commit-graph: define and use MAX_NUM_CHUNKS
  2:  a5aa3415c05 =  2:  a5aa3415c05 bloom.c: add the murmur3 hash implementation
  3:  a7702c1afde =  3:  a7702c1afde bloom.c: introduce core Bloom filter constructs
  4:  8304c297520 =  4:  8304c297520 bloom.c: core Bloom filter implementation for changed paths.
  5:  2d4c0b2da38 =  5:  2d4c0b2da38 diff: halt tree-diff early after max_changes
  6:  c38b9b386ef =  6:  c38b9b386ef commit-graph: compute Bloom filters for changed paths
  7:  d24c85c54ef =  7:  d24c85c54ef commit-graph: examine changed-path objects in pack order
  8:  5ed16f35fed =  8:  5ed16f35fed commit-graph: examine commits by generation number
  9:  55824cda89c <  -:  ----------- diff: skip batch object download when possible
 10:  1e4663523de =  9:  ff6b96aad1e commit-graph: write Bloom filters to commit graph file
 11:  68395d4051b ! 10:  cc8022bdf82 commit-graph: reuse existing Bloom filters during write
     @@ bloom.c: struct bloom_filter *get_bloom_filter(struct repository *r,
      +
       	repo_diff_setup(r, &diffopt);
       	diffopt.flags.recursive = 1;
     - 	diffopt.detect_rename = 0;
     + 	diffopt.max_changes = max_changes;
      
       ## bloom.h ##
      @@ bloom.h: struct bloom_filter_settings {
 12:  7e450e45236 = 11:  c8b86c383ab commit-graph: add --changed-paths option to write subcommand
 13:  b18af58aa3e = 12:  617f549ef25 revision.c: use Bloom filters to speed up path based revision walks
 14:  b5eb280178f = 13:  6beaede7159 revision.c: add trace2 stats around Bloom filter usage
 15:  3019ef72881 = 14:  b899df5c98e t4216: add end to end tests for git log with Bloom filters
 16:  213abb5d895 = 15:  5656e8590e9 commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag

-- 
gitgitgadget
