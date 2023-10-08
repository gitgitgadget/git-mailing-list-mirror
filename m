Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE82E95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbjJHGpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344477AbjJHGpi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18B3DB
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405361bb94eso35009195e9.0
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747533; x=1697352333; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGI8+vztJPrMdR1lrGVvQffEmPzH6w8udXZBqRCNW2s=;
        b=B8NaaNMQPMVbjQAM4mEXR07YWTiuaCt3iNJf6G6AUIGly3Yq2uIBG82OxiGBgSFUDI
         p1+UKBcaDSeB92U1zuB4bH9g56r8ZNoC9L9QcNaj4YEONmo2RjwxoXEMK6kQQxTIaWlC
         Lx9HUwESHT42TwO96EkAshZiDoSo2kuWL6J5djP1b3KjzMBttwwcueeM8K0lFI10TVUK
         7I/e+HEplHW499MlgMc8YzA1IeNl8gaVigc2p/DLfJb4wRi11/9aDBm0EKu166a6xhm7
         MgtIlDpJWaNzWugTeGi87xqAkBpVXtQS779w3CLEFI6elTap0bpHuxHG9JSsOnJQf/Yg
         9NlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747533; x=1697352333;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGI8+vztJPrMdR1lrGVvQffEmPzH6w8udXZBqRCNW2s=;
        b=O5t3WOPPUeJ7XfBSFqv3ZH58KSNr/upx5x7YUSCzXXwJ+09NO5QXNxt88e7vsIBwAG
         lfwMV9Njmwm/XYT+y/lQ7l4pWZ/FpP9bXhnAGEy268B86UI0eV6xpwq1aoPQvDXIg4qj
         av5Rvw82WfICJ0/H+U3JbsBsdjKhk57H6lrd4zGwdp4SsYI8M8kWy2euUIrHNKD0MXJW
         7uTBjwJMjrAbC0UDUuwj81wKg2x9IJuQm53yAWIh8ZBX3M9xJ1Rv3QSgBQHy3IVWGqme
         ieMcv1ugYUTg7DDqnh9jPAD4aQ0Q3nXEuKh5FIYePoSE6Uv6pt/7nDHmRyFqtWR4M3t0
         PMkA==
X-Gm-Message-State: AOJu0YwtoxxkXjnwjGu+pnTpdhgt784aw8W5ZkYQoGtO87cXtn0uGtz7
        mZbnxur2N9uCNtWpWme+7Fegz7X8va0=
X-Google-Smtp-Source: AGHT+IHfROA13QGnaakCi6QOvQwQupCNbMjarzwi1V1Acy2TXy2YHKvJ3B9aIFuD6JGh8MNW7IQb/w==
X-Received: by 2002:a05:600c:204f:b0:3fe:238e:b23b with SMTP id p15-20020a05600c204f00b003fe238eb23bmr10995445wmg.36.1696747532759;
        Sat, 07 Oct 2023 23:45:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c028f00b00406443c8b4fsm10071342wmk.19.2023.10.07.23.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:32 -0700 (PDT)
Message-ID: <fffcf580b29153a3c4c7ead3abfb2b621d3a0d46.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:05 +0000
Subject: [PATCH 03/25] documentation: fix typos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Diff best viewed with --color-diff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/fsck-msgids.txt                 | 2 +-
 Documentation/git-get-tar-commit-id.txt       | 2 +-
 Documentation/git-grep.txt                    | 2 +-
 Documentation/git-upload-pack.txt             | 2 +-
 Documentation/gitformat-chunk.txt             | 2 +-
 Documentation/gitformat-pack.txt              | 4 ++--
 Documentation/gitprotocol-capabilities.txt    | 2 +-
 Documentation/technical/commit-graph.txt      | 2 +-
 Documentation/technical/parallel-checkout.txt | 4 ++--
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 09b0aecbf86..8505c244bcf 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -174,7 +174,7 @@
 	(FATAL) Missing end-of-line in the object header.
 
 `zeroPaddedDate`::
-	(ERROR) Found a zero padded date in an author/commiter line.
+	(ERROR) Found a zero padded date in an author/committer line.
 
 `zeroPaddedFilemode`::
 	(WARN) Found a zero padded filemode in a tree.
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
index ac44d85b0b5..b537bb45b13 100644
--- a/Documentation/git-get-tar-commit-id.txt
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -20,7 +20,7 @@ and extract the commit ID stored in it.  It reads only the first
 1024 bytes of input, thus its runtime is not influenced by the size
 of the tar archive very much.
 
-If no commit ID is found, 'git get-tar-commit-id' quietly exists with a
+If no commit ID is found, 'git get-tar-commit-id' quietly exits with a
 return code of 1.  This can happen if the archive had not been created
 using 'git archive' or if the first parameter of 'git archive' had been
 a tree ID instead of a commit ID or tag.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index dabdbe8471d..0d0103c780a 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -337,7 +337,7 @@ The `--threads` option (and the grep.threads configuration) will be ignored when
 
 When grepping the object store (with `--cached` or giving tree objects), running
 with multiple threads might perform slower than single threaded if `--textconv`
-is given and there're too many text conversions. So if you experience low
+is given and there are too many text conversions. So if you experience low
 performance in this case, it might be desirable to use `--threads=1`.
 
 CONFIGURATION
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index b656b475675..7ad60bc3485 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -26,7 +26,7 @@ OPTIONS
 -------
 
 --[no-]strict::
-	Do not try <directory>/.git/ if <directory> is no Git directory.
+	Do not try <directory>/.git/ if <directory> is not a Git directory.
 
 --timeout=<n>::
 	Interrupt transfer after <n> seconds of inactivity.
diff --git a/Documentation/gitformat-chunk.txt b/Documentation/gitformat-chunk.txt
index 57202ede273..76ea678398a 100644
--- a/Documentation/gitformat-chunk.txt
+++ b/Documentation/gitformat-chunk.txt
@@ -42,7 +42,7 @@ Each row consists of a 4-byte chunk identifier (ID) and an 8-byte offset.
 Each integer is stored in network-byte order.
 
 The chunk identifier `ID[i]` is a label for the data stored within this
-fill from `OFFSET[i]` (inclusive) to `OFFSET[i+1]` (exclusive). Thus, the
+file from `OFFSET[i]` (inclusive) to `OFFSET[i+1]` (exclusive). Thus, the
 size of the `i`th chunk is equal to the difference between `OFFSET[i+1]`
 and `OFFSET[i]`. This requires that the chunk data appears contiguously
 in the same order as the table of contents.
diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index 870e00f2982..42afb953e8c 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -17,8 +17,8 @@ $GIT_DIR/objects/pack/multi-pack-index
 DESCRIPTION
 -----------
 
-The Git pack format is now Git stores most of its primary repository
-data. Over the lietime af a repository loose objects (if any) and
+The Git pack format is how Git stores most of its primary repository
+data. Over the lietime of a repository loose objects (if any) and
 smaller packs are consolidated into larger pack(s). See
 linkgit:git-gc[1] and linkgit:git-pack-objects[1].
 
diff --git a/Documentation/gitprotocol-capabilities.txt b/Documentation/gitprotocol-capabilities.txt
index 5d5e39a7039..9adda577e51 100644
--- a/Documentation/gitprotocol-capabilities.txt
+++ b/Documentation/gitprotocol-capabilities.txt
@@ -273,7 +273,7 @@ request include-tag only has to do with the client's desires for tag
 data, whether or not a server had advertised objects in the
 refs/tags/* namespace.
 
-Servers MUST pack the tags if their referrant is packed and the client
+Servers MUST pack the tags if their referent is packed and the client
 has requested include-tags.
 
 Clients MUST be prepared for the case where a server has ignored
diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index 86fed0de0f7..2c26e95e51a 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -136,7 +136,7 @@ Design Details
 
 - Commit grafts and replace objects can change the shape of the commit
   history. The latter can also be enabled/disabled on the fly using
-  `--no-replace-objects`. This leads to difficultly storing both possible
+  `--no-replace-objects`. This leads to difficulty storing both possible
   interpretations of a commit id, especially when computing generation
   numbers. The commit-graph will not be read or written when
   replace-objects or grafts are present.
diff --git a/Documentation/technical/parallel-checkout.txt b/Documentation/technical/parallel-checkout.txt
index 91a5eb26efd..1a5fe09b51d 100644
--- a/Documentation/technical/parallel-checkout.txt
+++ b/Documentation/technical/parallel-checkout.txt
@@ -148,7 +148,7 @@ information, the main process handles the results in two steps:
 
 - First, it updates the in-memory index with the `lstat()` information
   sent by the workers. (This must be done first as this information
-  might me required in the following step.)
+  might be required in the following step.)
 
 - Then it writes the items which collided on disk (i.e. items marked
   with `PC_ITEM_COLLIDED`). More on this below.
@@ -232,7 +232,7 @@ conversion and re-encoding, are eligible for parallel checkout.
 Ineligible entries are checked out by the classic sequential codepath
 *before* spawning workers.
 
-Note: submodules's files are also eligible for parallel checkout (as
+Note: submodules' files are also eligible for parallel checkout (as
 long as they don't fall into any of the excluding categories mentioned
 above). But since each submodule is checked out in its own child
 process, we don't mix the superproject's and the submodules' files in
-- 
gitgitgadget

