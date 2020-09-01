Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AACC28E83
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8032083B
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0M5LcIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIAK6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIAK6L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 06:58:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A993C061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 03:58:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so1014003wrt.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UcOMbTvFWRDPbaIV9Tkm/0kWg+MmmiVXkZlm8a03sV8=;
        b=P0M5LcINp+z7euK0o8sZ/OFXjc0wGGhYTbvQEn3KWzc+kLqDLA+ukJ9EfkYI5OYjog
         I9sv/7Khz3/19AHrMEB6wW4cGI9sJvHfnDT4RdmbzHmnxdBdMBbpt5+DlzL0+BT+j5GE
         14auGXAwqsuTsemAwv88b3Zat0WgzlPDbkI3ZpXc1VIK6gYOop6uw9EK31CMleG6eNU6
         xbgeIs1mRagIdqOUIqQejKlsOvJACzMpDzuzXQqg5F5uDYQyWpBmIMxwD1gw8Irq128V
         G7muDXQdqFk0OvZasmK7WyBPgKHxNLbYYAzeV+Eu89CLdTXdSqzB6GaHBm98mQLmLoVY
         q3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UcOMbTvFWRDPbaIV9Tkm/0kWg+MmmiVXkZlm8a03sV8=;
        b=OVDD13Rgl9zf5XbzCTCyG6+VBTG2GKHwiuX4nc4uX8d4x0nu8u11pJLgH03r7uZIA6
         3GA9WH03VppH2ZQ9vGkEkfhqdNS2+4XRkCCtmwOP+DxLYiaFxKp4/uq94emuM8nsp5jH
         3iPdPZQUEGC+wsH3hnXiR3vb7O4jg5njEipq8sDS+O63n/VG1jEUFlFTJ62ls3Ql1M14
         qrMj8IUyKPGOMI6Hf/M3/sGais1ZAO/HxykP/VRAgGZg//MMX03p7ovVlUvtDMivwEwK
         l+CxS/n+78i4Hvrh2nXEjicAiyFvlz+3iehh0tJxO0DB1JmAOpeG0BR11ZxM0FBkSszf
         Yx1g==
X-Gm-Message-State: AOAM530KGH7CJe5dVxhzHZva/0bU18rkA3ngdwhGT91D/7+iMd+v6Gm0
        QARG4k6X72PulfqPU4zeLvbO9iSN76s=
X-Google-Smtp-Source: ABdhPJxmJvbtnTvFpsYYhYotlQlkFiVXDcB07Vh0ukCaTSkv0L6VLr/lEbQB8kicyAyWs0ISlvW68g==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr1300740wrp.187.1598957887869;
        Tue, 01 Sep 2020 03:58:07 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-378-135.w86-199.abo.wanadoo.fr. [86.199.233.135])
        by smtp.googlemail.com with ESMTPSA id x16sm1705875wrq.62.2020.09.01.03.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:58:06 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 00/11] Rewrite the remaining merge strategies from shell to C
Date:   Tue,  1 Sep 2020 12:56:54 +0200
Message-Id: <20200901105705.6059-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a effort to reduce the number of shell scripts in git's codebase, I
propose this patch series converting the two remaining merge strategies,
resolve and octopus, from shell to C.  This will enable slightly better
performance, better integration with git itself (no more forking to
perform these operations), better portability (Windows and shell scripts
don't mix well).

Three scripts are actually converted: first git-merge-one-file.sh, then
git-merge-resolve.sh, and finally git-merge-octopus.sh.  Not only they
are converted, but they also are modified to operate without forking,
and then libified so they can be used by git without spawning another
process.

The first patch is not important to make the whole series work, but I
made this patch while working on it.

This series keeps the commands `git merge-one-file', `git
merge-resolve', and `git merge-octopus', so any script depending on them
should keep working without any changes.

This series is based on d9cd433147 (po: add missing letter for French
message, 2020-08-27).  The tip is tagged as
"rewrite-merge-strategies-v2" at https://github.com/agrn/git.

Changes since v1:

 - Merged commits rewriting and libifying scripts.

 - Introduce checks in merge-one-file to check that file modes are
   correct.

 - Use ll_merge() instead of xdl_merge().

 - merge-index does no longer fork to call git-merge-one-file.

 - Remove usage of the_index in merge-one-file.c.

 - Mark more strings for translation.

 - Carry more comments from the original scripts.

 - Use GIT_MAX_HEXSZ instead of hardcoding 60.

Alban Gruin (11):
  t6027: modernise tests
  merge-one-file: rewrite in C
  merge-index: libify merge_one_path() and merge_all()
  merge-index: don't fork if the requested program is
    `git-merge-one-file'
  merge-resolve: rewrite in C
  merge-recursive: move better_branch_name() to merge.c
  merge-octopus: rewrite in C
  merge: use the "resolve" strategy without forking
  merge: use the "octopus" strategy without forking
  sequencer: use the "resolve" strategy without forking
  sequencer: use the "octopus" merge strategy without forking

 Makefile                        |   7 +-
 builtin.h                       |   3 +
 builtin/merge-index.c           | 102 ++----
 builtin/merge-octopus.c         |  65 ++++
 builtin/merge-one-file.c        |  85 +++++
 builtin/merge-recursive.c       |  16 +-
 builtin/merge-resolve.c         |  69 ++++
 builtin/merge.c                 |   9 +-
 cache.h                         |   2 +-
 git-merge-octopus.sh            | 112 ------
 git-merge-one-file.sh           | 167 ---------
 git-merge-resolve.sh            |  54 ---
 git.c                           |   3 +
 merge-strategies.c              | 594 ++++++++++++++++++++++++++++++++
 merge-strategies.h              |  44 +++
 merge.c                         |  12 +
 sequencer.c                     |  16 +-
 t/t6407-merge-binary.sh         |  27 +-
 t/t6415-merge-dir-to-symlink.sh |   2 +-
 19 files changed, 942 insertions(+), 447 deletions(-)
 create mode 100644 builtin/merge-octopus.c
 create mode 100644 builtin/merge-one-file.c
 create mode 100644 builtin/merge-resolve.c
 delete mode 100755 git-merge-octopus.sh
 delete mode 100755 git-merge-one-file.sh
 delete mode 100755 git-merge-resolve.sh
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

Range-diff against v1:
 1:  50e15b5243 !  1:  28c8fd11b6 t6027: modernise tests
    @@ Commit message
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
    - ## t/t6027-merge-binary.sh ##
    -@@ t/t6027-merge-binary.sh: test_description='ask merge-recursive to merge binary files'
    + ## t/t6407-merge-binary.sh ##
    +@@ t/t6407-merge-binary.sh: test_description='ask merge-recursive to merge binary files'
      . ./test-lib.sh
      
      test_expect_success setup '
    @@ t/t6027-merge-binary.sh: test_description='ask merge-recursive to merge binary f
      	cat "$TEST_DIRECTORY"/test-binary-1.png >m &&
      	git add m &&
      	git ls-files -s | sed -e "s/ 0	/ 1	/" >E1 &&
    -@@ t/t6027-merge-binary.sh: test_expect_success setup '
    +@@ t/t6407-merge-binary.sh: test_expect_success setup '
      '
      
      test_expect_success resolve '
 2:  08a337738e <  -:  ---------- merge-one-file: rewrite in C
 3:  5da78d5de1 <  -:  ---------- merge-one-file: remove calls to external processes
 4:  11c0da9e13 <  -:  ---------- merge-one-file: use error() instead of fprintf(stderr, ...)
 5:  df28965c8e <  -:  ---------- merge-one-file: libify merge_one_file()
 -:  ---------- >  2:  f5ab0fdf0a merge-one-file: rewrite in C
 6:  84f2f2946a !  3:  7f3ce7da17 merge-index: libify merge_one_path() and merge_all()
    @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const ch
     
      ## merge-strategies.c ##
     @@
    - #include "cache.h"
      #include "dir.h"
    + #include "ll-merge.h"
      #include "merge-strategies.h"
     +#include "run-command.h"
      #include "xdiff-interface.h"
    @@ merge-strategies.c: int merge_strategies_one_file(struct repository *r,
     +		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
     +		     void *data)
     +{
    -+	char ownbuf[3][60] = {{0}};
    ++	char ownbuf[3][GIT_MAX_HEXSZ] = {{0}};
     +	const char *arguments[] = { (char *)data, "", "", "", path,
     +				    ownbuf[0], ownbuf[1], ownbuf[2],
     +				    NULL };
 7:  1f864a4840 <  -:  ---------- merge-resolve: rewrite in C
 8:  3517990e6a <  -:  ---------- merge-resolve: remove calls to external processes
 9:  9831fe1729 <  -:  ---------- merge-resolve: libify merge_resolve()
 -:  ---------- >  4:  07e6a6aaef merge-index: don't fork if the requested program is `git-merge-one-file'
 -:  ---------- >  5:  117d4fc840 merge-resolve: rewrite in C
10:  99d42e8ea1 =  6:  4fc955962b merge-recursive: move better_branch_name() to merge.c
11:  3182673ea7 <  -:  ---------- merge-octopus: rewrite in C
12:  8f4cfcefb7 <  -:  ---------- merge-octopus: remove calls to external processes
13:  d4dba22988 <  -:  ---------- merge-octopus: libify merge_octopus()
 -:  ---------- >  7:  e7b9e15b34 merge-octopus: rewrite in C
14:  bbe50cd770 =  8:  cd0662201d merge: use the "resolve" strategy without forking
15:  b7aff6fb3a =  9:  0525ff0183 merge: use the "octopus" strategy without forking
16:  c1cdcce3a9 = 10:  6fbf599ba4 sequencer: use the "resolve" strategy without forking
17:  e68765cdc7 = 11:  2c2dc3cc62 sequencer: use the "octopus" merge strategy without forking
-- 
2.28.0.370.g2c2dc3cc62

