Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E197C4332F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071166103B
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhJDAsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 20:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhJDAsF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 20:48:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BAAC0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 17:46:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t8so27584903wri.1
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 17:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Wj0RakNelq9rnhUSK25nBPEi8uhFEcpAIS1ohQxQLw=;
        b=Z6SplVh3Xt1KXfk7XIjWbF20HyjiPyGdOg+jClm1MlJThqA0s5Ib7eOjvQK4zk0+28
         kgYUV2jTooTnIW4rqngVSYMlJV6dX/BrmYPeCSuL9YMQEq0ji6hiPZCAYNhGs9fA/Y2q
         e3jqO5aPJoi+/m7REtDfh/zGokp6T6gK3znEC1vmMcF5Kk+HNpLlufO4tc3rmIop0XC8
         kVMAA+BJ6QEjDAFYO4wtZUpVY4n+/e+L5LfFioIvzcNWW1MaO2x4AsXD5g+U6abVpdJm
         mhrQ5QD5K6qsSDx2ckBJdBRQUhZAFZxONXFrZa+F0EHETxbkDF1lp7T341WGTrlaSZAm
         AYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Wj0RakNelq9rnhUSK25nBPEi8uhFEcpAIS1ohQxQLw=;
        b=2FLpN3otFtiaauV8QZp43DzB3npOv2EGywsMoyV+6afyCczGqmrW4EIiCvN0p33zpH
         KU8nzWqPHth79S/LXci5rd91WXJAnIuDJnqXeWJ9qYXXWjYCgr7K/TgKX+yR5rmsfMcj
         LkhGzbjoAffBqpzhYpuM9TrYrNgd9oG103Hmj5TNfpEyNJ3g+eMxfrwCZZmbU/CzQnHy
         vTWHRkmOT133Alh5HChYnjXnVmjJ2bfic8wIUnE/0g/Ro6usgxWqFI6/NLdI3n3uTXwS
         aVK/JdBHnSloJw79QnrSJqkwtJFbE1EztNHuycHwGcGPDEd9gHUAmDXi+6o8bnChwc3C
         PSKA==
X-Gm-Message-State: AOAM530O38YNpRX9Kt1uzCzqWQJnSoDWmhBNcx8UFTO21ooAqkU0AATR
        8YAKUclspMjmzWm0ZxqkzhG5dZ3+9UepAw==
X-Google-Smtp-Source: ABdhPJzyWfKEYnM+LHeQTt0p/VCvOsG7r21Kr6QkPO6DGk9ckOv3JPPZB1/cuG/VsopYltGo937SYg==
X-Received: by 2002:adf:a14a:: with SMTP id r10mr11014698wrr.377.1633308375277;
        Sun, 03 Oct 2021 17:46:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm13526773wrc.55.2021.10.03.17.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 17:46:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] unpack-trees & dir APIs: fix memory leaks
Date:   Mon,  4 Oct 2021 02:46:01 +0200
Message-Id: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes memory leaks in the unpack-trees and dir APIs for
all their callers. There's been a discussion between myself & Elijah
on his en/removing-untracked-fixes series[1] about the memory leak
fixing aspect of his series.

I've got locally queued patches that fix widespread memory leaks in
the test suite and make much of it pass under SANITIZE=leak, once the
common leaks in revisions.c (git rev-list/show/log etc.), "checkout",
"dir" and "unpack-trees" are fixed a lot of tests become entirely
leak-free, as much code that needs to setup various basic things will
require one of those commands.

I think that the more narrow fixes[2] to the memory leaks around
unpack-trees in Elijah's series[3] are better skipped and that series
rebased on top of this one (I'll submit an RFC version of his that is
rebased on this as a follow-up).

I.e. his solves a very small amount of the memory leaks in this area,
whereas this is something I've got running as part of end-to-end
SANITIZE=leak testing, so I think that the difference in approaches we
picked when it comes to fixing them is likely because of that.

E.g. continuing to allocate the "struct dir_struct" on the heap in his
version[4] in his is, I think, something that makes more sense for
fixes that haven't pulled at the thread of how much merge-recursive.c
is making that question of ownerhip confusing. There's also changen in
his that'll become simpler as the complexity of the underlying APIs
has gone away, e.g. [6].

1. https://lore.kernel.org/git/87ilyjviiy.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/0c74285b25311c83bb158cf89a551160a0f3a5d3.1632760428.git.gitgitgadget@gmail.com/
3. https://lore.kernel.org/git/pull.1036.v3.git.1632760428.gitgitgadget@gmail.com/
4. https://lore.kernel.org/git/0d119142778dce8617dd9b2c102b5f5bfdc9dc0f.1632760428.git.gitgitgadget@gmail.com/
6. https://lore.kernel.org/git/f1a0700e598e52d6cdb507fe8a09c4fa9291c982.1632760428.git.gitgitgadget@gmail.com/

Comments on individual patches below:

Ævar Arnfjörð Bjarmason (10):
  unpack-trees.[ch]: define and use a UNPACK_TREES_OPTIONS_INIT

I had this at the end of the v3 of my designated initializer cleanup
series[7]

I think Junio fairly commented that this in isolation looked like it
was going nowhere[8] since we didn' get past initializing "struct
unpack_trees_options" as "{ 0 }", but that'll soon be the case in this
series...

  merge-recursive.c: call a new unpack_trees_options_init() function

Details how merge-recursive.c calls unpack_trees() differently than
every other caller when it comes to "struct unpack_trees_options"
setup.

  unpack-trees.[ch]: embed "dir" in "struct unpack_trees_options"

Elijah's series ends up with a "dir" still heap-allocated in "struct
unpack_trees_options", just dynamically and "privately". Here it's
allocated on the stack (or for merge-recursive.c, as defined in
UNPACK_TREES_OPTIONS_INIT), because we could untangle the
merge-recursive.c edge-case earlier.

  unpack-trees API: don't have clear_unpack_trees_porcelain() reset

Move merge-recursive.c special-snowflake behavior into
merge-recursive.c.

  dir.[ch]: make DIR_INIT mandatory
  dir.c: get rid of lazy initialization

The last caller not using "struct dir_struct" via DIR_INIT goes away,
allowing for untangling the mess I commented on at length in [9].

  unpack-trees API: rename clear_unpack_trees_porcelain()

Just a s/clear_unpack_trees_porcelain/unpack_trees_options_release/g,
since that's what it does now.

  unpack-trees: don't leak memory in verify_clean_subdirectory()
  merge.c: avoid duplicate unpack_trees_options_release() code
  built-ins: plug memory leaks with unpack_trees_options_release()

A lot of memory leak fixes both in unpack-trees.c and its users, only
a subset of this is in Elijah's series.

7. https://lore.kernel.org/git/cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com/
8. https://lore.kernel.org/git/xmqqk0iw4e7v.fsf@gitster.g/
9. https://lore.kernel.org/git/87sfxhohsj.fsf@evledraar.gmail.com/

 add-interactive.c         |  2 +-
 archive.c                 | 12 ++++++++----
 builtin/am.c              | 23 ++++++++++++++---------
 builtin/checkout.c        | 22 ++++++++++++----------
 builtin/clone.c           |  4 ++--
 builtin/commit.c          |  9 ++++++---
 builtin/merge.c           |  9 +++++----
 builtin/read-tree.c       | 28 +++++++++++++++-------------
 builtin/reset.c           | 16 ++++++++++------
 builtin/sparse-checkout.c |  5 ++---
 builtin/stash.c           | 20 ++++++++++++--------
 diff-lib.c                |  8 +++++---
 dir.c                     |  8 --------
 dir.h                     |  6 ++++--
 merge-ort.c               | 12 ++++--------
 merge-recursive.c         |  6 ++++--
 merge.c                   | 23 +++++++++++------------
 reset.c                   |  4 ++--
 sequencer.c               |  3 +--
 unpack-trees.c            | 24 +++++++++++++-----------
 unpack-trees.h            | 17 +++++++++++++----
 21 files changed, 144 insertions(+), 117 deletions(-)

-- 
2.33.0.1404.g83021034c5d

