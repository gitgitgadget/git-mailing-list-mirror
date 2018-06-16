Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68781F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754919AbeFPFmE (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:04 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39308 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754008AbeFPFmD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:03 -0400
Received: by mail-lf0-f65.google.com with SMTP id t2-v6so11122948lfd.6
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZEnVBc+wjx+Nyuuyn+MV+U/Te3ff5MEPOfgBV1z46c=;
        b=eAeMV82s5FAdD3XKB+2jPOrMqpywzKWz1G5P3xlmQnfyTCdq0UeyC+BWBGOf37y7Zb
         w1m4+dQAJBpJErQk+BfrpSaXM8uGVsgzSADN8TGIZt6dy56dJNMm4cpuxdi70ezNZBeM
         LqGLH6RCtsZLA+zpinvDcxtxtmr9oLRQYBFFF+GQfNdwUsvjPoNaQ6ViDWu3KgaTe2tw
         O8+zQr6pj8LhFZPnilZMNggS6h2d7x8cv7EdG2WONKfKJa7lnoAzmsHTmgTkTNnlV91G
         Vn77gR0E/S8X24yp5IfPhGc2GHK3/ViWybNdXfzQgjMKEmjSnrHDQGitVzfjknHcOG2e
         kIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZEnVBc+wjx+Nyuuyn+MV+U/Te3ff5MEPOfgBV1z46c=;
        b=mpNwuUoy6kGBuk33tJE0uikWI7mQcsgYbruzvzwLkBNHBe8g5vFkQmTs7tePe1K2ux
         seikRLAVdd0nZ95jwHBHF2td0NK9kP8Ulua1LuK1Lrs4IeE5w2mf3rTpzUWS+mF7gHfp
         UOC4pZA2G1zXYQvnOfxvEa08LM9BYek28K45hv5f6wycqy2hUZpYCQSqy/fR9cLt5bAf
         Hlv1IN1SInM5YcoHVd9wMzalkRG81uHu0EjeAWyMgVtx1wLDI+mjEQi32wXyhIw94YwZ
         I+V1v8J8RGV555ieLRG4vSj4Rp75NI53sbYJ0Z1PRRdjCX1VetIUocTCM9bxzC51okYW
         TK6A==
X-Gm-Message-State: APt69E3jFLUhadh+/FfdVhYoZ42h2ABSM8ck/pHdrxFPNq3IA/4/vRRp
        ut+1hFLoFzkYmA6o0D1pzjmtRg==
X-Google-Smtp-Source: ADUXVKLOOqQLplTgrEhV4Avaw81x9Ce6ZaLsJ1TnkT887CyPw67BBedAI1+a5NWXOhmWte9fa5Uc6w==
X-Received: by 2002:a19:f71a:: with SMTP id z26-v6mr2618970lfe.137.1529127721111;
        Fri, 15 Jun 2018 22:42:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/15] Kill the_index part 1, expose it
Date:   Sat, 16 Jun 2018 07:41:42 +0200
Message-Id: <20180616054157.32433-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the beginning of the end of the_index. The problem with
the_index is it lets library code anywhere access it freely. This is
not good because from high level you may not realize that the_index is
being used while you don't want to touch index at all, or you want to
use a different index instead.

This is a long series, 86 patches [1], so I'm going to split and
submit it in 15-20 patches at a time. The first two parts are trivial
though and could be safely fast tracked if needed.

This is the first part, which kills the use of index compat macros
outside builtin/ and expose the_index in all library code. Later on we
will ban the_index from one file each time until it's gone for good.

"struct index_state *" will be passed from builtin/ through the call
chain to the function that needs it. In some cases, "struct
repository *" will be passed instead when the whole operation spans
more than just the index.  By the end, the_index becomes part of
"index compat macros" and cannot be used outside builtin/

Part one is mechanical conversion with the help of coccinelle. The
only real patches are the first and the last one.

[1] https://gitlab.com/pclouds/git/commits/really-kill-the-index

Nguyễn Thái Ngọc Duy (15):
  contrib: add cocci script to replace index compat macros
  apply.c: stop using index compat macros
  blame.c: stop using index compat macros
  check-racy.c: stop using index compat macros
  diff-lib.c: stop using index compat macros
  diff.c: stop using index compat macros
  entry.c: stop using index compat macros
  merge-recursive.c: stop using index compat macros
  merge.c: stop using index compat macros
  rerere.c: stop using index compat macros
  revision.c: stop using index compat macros
  sequencer.c: stop using index compat macros
  sha1-name.c: stop using index compat macros
  wt-status.c: stop using index compat macros
  cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch

 apply.c                               |  34 ++---
 attr.c                                |   1 -
 blame.c                               |  19 +--
 builtin/add.c                         |   1 +
 builtin/am.c                          |   1 +
 builtin/check-attr.c                  |   1 +
 builtin/check-ignore.c                |   1 +
 builtin/checkout-index.c              |   1 +
 builtin/checkout.c                    |   1 +
 builtin/clean.c                       |   1 +
 builtin/commit.c                      |   1 +
 builtin/describe.c                    |   1 +
 builtin/diff-files.c                  |   1 +
 builtin/diff-index.c                  |   1 +
 builtin/diff-tree.c                   |   1 +
 builtin/diff.c                        |   1 +
 builtin/fsck.c                        |   1 +
 builtin/ls-files.c                    |   1 -
 builtin/merge-index.c                 |   1 +
 builtin/merge-ours.c                  |   1 +
 builtin/merge.c                       |   1 +
 builtin/mv.c                          |   1 +
 builtin/pull.c                        |   1 +
 builtin/read-tree.c                   |   1 +
 builtin/reset.c                       |   1 +
 builtin/rev-parse.c                   |   1 +
 builtin/rm.c                          |   1 +
 builtin/submodule--helper.c           |   1 +
 builtin/update-index.c                |   1 +
 cache.h                               |   2 +-
 check-racy.c                          |  10 +-
 contrib/coccinelle/index-compat.cocci | 184 ++++++++++++++++++++++++++
 convert.c                             |   1 -
 diff-lib.c                            |   8 +-
 diff.c                                |  12 +-
 dir.c                                 |   1 -
 entry.c                               |   3 +-
 merge-recursive.c                     |  65 ++++-----
 merge.c                               |  14 +-
 name-hash.c                           |   1 -
 pathspec.c                            |   1 -
 read-cache.c                          |   1 -
 rerere.c                              |  36 ++---
 revision.c                            |  14 +-
 sequencer.c                           |  32 ++---
 sha1-name.c                           |  22 +--
 submodule.c                           |   1 -
 t/helper/test-dump-untracked-cache.c  |   1 +
 t/helper/test-tool.h                  |   2 +
 tree.c                                |   1 -
 unpack-trees.c                        |   1 -
 wt-status.c                           |  24 ++--
 52 files changed, 363 insertions(+), 154 deletions(-)
 create mode 100644 contrib/coccinelle/index-compat.cocci

-- 
2.18.0.rc0.333.g22e6ee6cdf

