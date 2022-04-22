Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAC1C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443393AbiDVCfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443390AbiDVCfg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:35:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8877B4B435
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b19so9022289wrh.11
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jwYa8NoODylvOmfYEQNNeU9meZTz6udqgzlQ9UufeOk=;
        b=DlBjbtPPrQ7ZFjYztw4bZl6ac8x019/8Sr9u9ps5Ypsggdgc8SQfVR0LwD/oLyiZNw
         Sjh+P1BLZHn4OP7dByJcQ85uWPXnOVOLXI+9WQMegwlVurHRdf/4J2mHqQS+TS1W2DZq
         v82cxaZf259jdyNCSxoStdJQKsJoF1uDhlzyYVkqU5HbV2RagMRr6ao70wf8Zzs1Y048
         cAPmv4fCpb0RbuwWxcjyfDgdqjF7zuW6C3QY/hzcv7Jr9pS4/P8CUlUTnGkmjSwEoZ63
         /ioDBIo0Oy27KywMeFhOk4ZCRNBOelq+RSHenfrW5oO5VT8HkmpNg/d0Kwmm+Sw4hdbE
         5Qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jwYa8NoODylvOmfYEQNNeU9meZTz6udqgzlQ9UufeOk=;
        b=MqulgBoFetkg7hKDQWHp0Zs5Tz67B9bS9iyROZ1PbVrgMZXT5wmcLPvx+TdAwYeRx5
         a+figf81FRvMMbIrxAvM9ziTSTyRy2kCuWEO7bl9O1cBNA5mo1lKn09WtG3p4m4fJGnL
         g+lNpfxWqD5pZg/qf0TuA2IfqtQgmm869pwWGXXufUneFEGluTb39fbKA9G2RqZxvlWj
         pxzdvnlLSTaX8ABrkY8obdcIezbd3S2jWJPVDDIKiNZj8QEQ32XU4sa/6PAGVJ6CREgo
         ZxU/8EdT6qbcOFZoo/jQOiiNV5R2Bd5gX7/KPmdemlyWbC3vlVTRjYzg4tP1b2rjfZZ3
         enug==
X-Gm-Message-State: AOAM530n5l9BvWBhZPV/KcGAYj22u7ygauw/qlw8iO1qurHqCrowNsnH
        ASiqWeMb/CEpljJH3+8JqT2D2p3yGj4=
X-Google-Smtp-Source: ABdhPJymQlK2n1vNfW6ZTb2ALvSQ3bypEnoJNCcuFeOGYMkEFySoqYD1oILjjcsQkwJAWp65gutaFA==
X-Received: by 2002:a05:6000:188b:b0:20a:a7f4:2f8 with SMTP id a11-20020a056000188b00b0020aa7f402f8mr1717891wri.424.1650594755658;
        Thu, 21 Apr 2022 19:32:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d588c000000b0020a9e80d2b1sm566173wrf.107.2022.04.21.19.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:32:35 -0700 (PDT)
Message-Id: <546ae3d67326435c2b4a689f9217639bce660d88.1650594746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
References: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 02:32:24 +0000
Subject: [PATCH v3 7/9] git-sparse-checkout.txt: flesh out pattern set
 sections a bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The "Internals -- Cone Pattern Set" section starts off discussing
patterns, despite the fact that cone mode is about avoiding the
patterns.  This made sense back when non-cone mode was the default and
we started by discussing the full pattern set, but now that we are
changing the default, it makes more sense to discuss cone-mode first and
avoid the full discussion of patterns.  Split this section into two, the
first with details about how cone mode operates, and the second
following the full pattern set section and discussing how the cone mode
patterns used under the hood relate to the full pattern set.

While at it, flesh out the "Internals -- Full Pattern Set" section a bit
to include more examples as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 129 +++++++++++++++++---------
 1 file changed, 85 insertions(+), 44 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index c54437428bb..6e32034511d 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -192,7 +192,40 @@ on this file. The files matching the patterns in the file will
 appear in the working directory, and the rest will not.
 
 
-INTERNALS -- CONE PATTERN SET
+INTERNALS -- CONE MODE HANDLING
+-------------------------------
+
+The "cone mode", which is the default, lets you specify only what
+directories to include.  For any directory specified, all paths below
+that directory will be included, and any paths immediately under
+leading directories (including the toplevel directory) will also be
+included.  Thus, if you specified the directory
+    Documentation/technical/
+then your sparse checkout would contain:
+
+  * all files in the toplevel-directory
+  * all files immediately under Documentation/
+  * all files at any depth under Documentation/technical/
+
+Also, in cone mode, even if no directories are specified, then the
+files in the toplevel directory will be included.
+
+When changing the sparse-checkout patterns in cone mode, Git will inspect each
+tracked directory that is not within the sparse-checkout cone to see if it
+contains any untracked files. If all of those files are ignored due to the
+`.gitignore` patterns, then the directory will be deleted. If any of the
+untracked files within that directory is not ignored, then no deletions will
+occur within that directory and a warning message will appear. If these files
+are important, then reset your sparse-checkout definition so they are included,
+use `git add` and `git commit` to store them, then remove any remaining files
+manually to ensure Git can behave optimally.
+
+See also the "Internals -- Cone Pattern Set" section to learn how the
+directories are transformed under the hood into a subset of the
+Full Pattern Set of sparse-checkout.
+
+
+INTERNALS -- FULL PATTERN SET
 -----------------------------
 
 The full pattern set allows for arbitrary pattern matches and complicated
@@ -201,31 +234,62 @@ updating the index, where N is the number of patterns and M is the number
 of paths in the index. To combat this performance issue, a more restricted
 pattern set is allowed when `core.sparseCheckoutCone` is enabled.
 
-The accepted patterns in the cone pattern set are:
+The sparse-checkout file uses the same syntax as `.gitignore` files;
+see linkgit:gitignore[5] for details.  Here, though, the patterns are
+usually being used to select which files to include rather than which
+files to exclude.  (However, it can get a bit confusing since
+gitignore-style patterns have negations defined by patterns which
+begin with a '!', so you can also select files to _not_ include.)
+
+For example, to select everything, and then to remove the file
+`unwanted` (so that every file will appear in your working tree except
+the file named `unwanted`):
+
+    git sparse-checkout set --no-cone '/*' '!unwanted'
+
+These patterns are just placed into the
+`$GIT_DIR/info/sparse-checkout` as-is, so the contents of that file
+at this point would be
+
+----------------
+/*
+!unwanted
+----------------
+
+See also the "Sparse Checkout" section of linkgit:git-read-tree[1] to
+learn more about the gitignore-style patterns used in sparse
+checkouts.
+
+
+INTERNALS -- CONE PATTERN SET
+-----------------------------
+
+In cone mode, only directories are accepted, but they are translated into
+the same gitignore-style patterns used in the full pattern set.  We refer
+to the particular patterns used in those mode as being of one of two types:
 
 1. *Recursive:* All paths inside a directory are included.
 
 2. *Parent:* All files immediately inside a directory are included.
 
-In addition to the above two patterns, we also expect that all files in the
-root directory are included. If a recursive pattern is added, then all
-leading directories are added as parent patterns.
-
-By default, when running `git sparse-checkout set` with no directories
-specified, the root directory is added as a parent pattern. At this
-point, the sparse-checkout file contains the following patterns:
+Since cone mode always includes files at the toplevel, when running
+`git sparse-checkout set` with no directories specified, the toplevel
+directory is added as a parent pattern.  At this point, the
+sparse-checkout file contains the following patterns:
 
 ----------------
 /*
 !/*/
 ----------------
 
-This says "include everything in root, but nothing two levels below root."
+This says "include everything immediately under the toplevel
+directory, but nothing at any level below that."
 
-When in cone mode, the `git sparse-checkout set` subcommand takes a list of
-directories. In this mode, the command `git sparse-checkout set A/B/C` sets
-the directory `A/B/C` as a recursive pattern, the directories `A` and `A/B`
-are added as parent patterns. The resulting sparse-checkout file is now
+When in cone mode, the `git sparse-checkout set` subcommand takes a
+list of directories.  The command `git sparse-checkout set A/B/C` sets
+the directory `A/B/C` as a recursive pattern, the directories `A` and
+`A/B` are added as parent patterns. The resulting sparse-checkout file
+is now
 
 ----------------
 /*
@@ -244,11 +308,14 @@ Unless `core.sparseCheckoutCone` is explicitly set to `false`, Git will
 parse the sparse-checkout file expecting patterns of these types. Git will
 warn if the patterns do not match.  If the patterns do match the expected
 format, then Git will use faster hash-based algorithms to compute inclusion
-in the sparse-checkout.
+in the sparse-checkout.  If they do not match, git will behave as though
+`core.sparseCheckoutCone` was false, regardless of its setting.
 
-In the cone mode case, the `git sparse-checkout list` subcommand will list the
-directories that define the recursive patterns. For the example sparse-checkout
-file above, the output is as follows:
+In the cone mode case, despite the fact that full patterns are written
+to the $GIT_DIR/info/sparse-checkout file, the `git sparse-checkout
+list` subcommand will list the directories that define the recursive
+patterns. For the example sparse-checkout file above, the output is as
+follows:
 
 --------------------------
 $ git sparse-checkout list
@@ -260,32 +327,6 @@ case-insensitive check. This corrects for case mismatched filenames in the
 'git sparse-checkout set' command to reflect the expected cone in the working
 directory.
 
-When changing the sparse-checkout patterns in cone mode, Git will inspect each
-tracked directory that is not within the sparse-checkout cone to see if it
-contains any untracked files. If all of those files are ignored due to the
-`.gitignore` patterns, then the directory will be deleted. If any of the
-untracked files within that directory is not ignored, then no deletions will
-occur within that directory and a warning message will appear. If these files
-are important, then reset your sparse-checkout definition so they are included,
-use `git add` and `git commit` to store them, then remove any remaining files
-manually to ensure Git can behave optimally.
-
-
-INTERNALS -- FULL PATTERN SET
------------------------------
-
-By default, the sparse-checkout file uses the same syntax as `.gitignore`
-files.
-
-While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
-files are included, you can also specify what files are _not_ included,
-using negative patterns. For example, to remove the file `unwanted`:
-
-----------------
-/*
-!unwanted
-----------------
-
 
 INTERNALS -- SUBMODULES
 -----------------------
-- 
gitgitgadget

