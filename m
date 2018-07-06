Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E512D1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeGFAx1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:53:27 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36026 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753442AbeGFAx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:53:26 -0400
Received: by mail-qt0-f196.google.com with SMTP id f1-v6so8713406qti.3
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9+BZH2Uw1zXaowIJpYzKJ0/C+Cq4J8PI8GPxPwXWs4Q=;
        b=S/8/Rfb8T0iajWyt2rKY06YVszM+ERm2d3rx+aFaaR87RlYEtIRRjyTQaEt/ZNquUv
         xkGaDNPE99iLFZ3l09b/Qh6qIU1zLYQkhvGikLUbCuk6Q9p1yO4AwiBI+XQJ8LCS0/XH
         9fsLUlu/1Lnu92SKzxD1zAxhpdJM89dA46xZMXg+Sn1jSFfT7cCuvDMRzTIrcdVPlx6i
         2l7vsE/X4iyNuk2oMkwQGMi3dhRbWm0TVp1v37Z0dqJeKAaPS7Spxdi2jFPupeFnQ7yD
         Lno4zgcr1q3gb1PR8VsxSpAvzT9bfOHRoZM0x9uk/DLKbuP81jv5MAnKapBr0ZKtsCXS
         U2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9+BZH2Uw1zXaowIJpYzKJ0/C+Cq4J8PI8GPxPwXWs4Q=;
        b=FYV30icGn72BQLv1WzySRJpcdExEljAEK2k4TFPgJKZSdZ4DCzBUbsuv+2ZNqGS+Xp
         15+CG9cL13qEygxrVKXIjagHes6a5cy/PhmLYOxhzIfT91XRvwHT351upPYy28FsMefE
         yTjx/T8f7pzq6tovaPTPCUqSRvB0PkN+d2j6djxsinO5PU3cku81EO7LnTYdVBX/ncze
         Rw3Sfi5OII24ycDaPPA3cdGOJx9M/Zu/mzFC88yaIIpJsaGb53yOjzdsHZdG9LfJPaMD
         x3aB4ztaeUt/njyrdOOEyCelXJmQad8OYkAUbdKMqfCA1Z3njs6FNrJ/6O5zjCT2jvax
         cWIw==
X-Gm-Message-State: APt69E03imwKrY6oWqgRTbmm5fiCpcr4q16/Dfz7xrq0qG2H074j5woB
        sagbH5B0/WX1D4+JTieE43exE6Hq
X-Google-Smtp-Source: AAOMgpcbUOYDbxchYd8AnxKnnUNKepyPO9Kk8OeBwniHoxuI2zfzg7Q/1bYMKzJK1RNDG4ANkKkGmg==
X-Received: by 2002:ac8:509:: with SMTP id u9-v6mr7270329qtg.97.1530838405945;
        Thu, 05 Jul 2018 17:53:25 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:53:25 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 00/24] Multi-pack-index (MIDX)
Date:   Thu,  5 Jul 2018 20:52:57 -0400
Message-Id: <20180706005321.124643-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback on v2. I cleaned up the patch to respond to all
that feedback. I'll include the version diff in a follow-up email.

You can see the CI builds for Linux, Mac, and Windows linked from the
GitHub pull request [1].

Biggest changes in this version:

* Deleted the extra static method.

* Use $(...) instead of `...` in test script

* Fixed spaces in tabbing (hopefully I caught them all)

* Cleaned up some inter-patch diff issues

* `...` quotes in git-multi-pack-index.txt

* Replace FREE_AND_NULL() with free() when obvious that a variable is
  going out of scope

* Due to how Windows handles open file handles when replacing a
  lockfile, be sure to close the midx before writing a new one.

I do still want to revisit the "order by fanout" vs "merge sort"
discussion that we had on v1, but this series is very big already. I'd
like to come back to that as a follow-up.

Thanks,
-Stolee

[1] https://github.com/gitgitgadget/git/pull/5

Derrick Stolee (24):
  multi-pack-index: add design document
  multi-pack-index: add format details
  multi-pack-index: add builtin
  multi-pack-index: add 'write' verb
  midx: write header information to lockfile
  multi-pack-index: load into memory
  multi-pack-index: expand test data
  packfile: generalize pack directory list
  multi-pack-index: read packfile list
  multi-pack-index: write pack names in chunk
  midx: read pack names into array
  midx: sort and deduplicate objects from packfiles
  midx: write object ids in a chunk
  midx: write object id fanout chunk
  midx: write object offsets
  config: create core.multiPackIndex setting
  midx: prepare midxed_git struct
  midx: read objects from multi-pack-index
  midx: use midx in abbreviation calculations
  midx: use existing midx when writing new one
  midx: use midx in approximate_object_count
  midx: prevent duplicate packfile loads
  packfile: skip loading index if in multi-pack-index
  midx: clear midx on repack

 .gitignore                                   |   3 +-
 Documentation/config.txt                     |   4 +
 Documentation/git-multi-pack-index.txt       |  56 ++
 Documentation/technical/multi-pack-index.txt | 109 +++
 Documentation/technical/pack-format.txt      |  77 ++
 Makefile                                     |   3 +
 builtin.h                                    |   1 +
 builtin/multi-pack-index.c                   |  46 +
 builtin/repack.c                             |   8 +
 cache.h                                      |   1 +
 command-list.txt                             |   1 +
 config.c                                     |   5 +
 environment.c                                |   1 +
 git.c                                        |   1 +
 midx.c                                       | 896 +++++++++++++++++++
 midx.h                                       |  20 +
 object-store.h                               |  33 +
 packfile.c                                   | 169 +++-
 packfile.h                                   |   9 +
 sha1-name.c                                  |  70 ++
 t/helper/test-read-midx.c                    |  54 ++
 t/helper/test-tool.c                         |   1 +
 t/helper/test-tool.h                         |   1 +
 t/t5319-multi-pack-index.sh                  | 191 ++++
 24 files changed, 1717 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/git-multi-pack-index.txt
 create mode 100644 Documentation/technical/multi-pack-index.txt
 create mode 100644 builtin/multi-pack-index.c
 create mode 100644 midx.c
 create mode 100644 midx.h
 create mode 100644 t/helper/test-read-midx.c
 create mode 100755 t/t5319-multi-pack-index.sh


base-commit: 53f9a3e157dbbc901a02ac2c73346d375e24978c
-- 
2.18.0.118.gd4f65b8d14

