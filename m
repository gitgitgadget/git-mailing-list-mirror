Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8FEE95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344532AbjJHGqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344488AbjJHGpo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088C910D
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so34358565e9.0
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747540; x=1697352340; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IAJEOSh67K5kR7rcBvLR4OfyWJsJjOXllWYuZ0je3c=;
        b=SAMVKk+XIF0A+CnqeGkj7c+8LPwOtD3IJ/oRY/YndLUHMYcObd2wN6TRoizK7PxgUu
         mFOPxL9TWPjJGsOC3eNrfOStw7IvXy+mELJMpdp8q44E6nZi6b3l5ggoUJLZkUOogip9
         weX1vUVzQNnBgVsNLJ9Mjl9erU/YoeR3n7yN8ZnZ17GzaC0Bz0AwjPNyIR3QlOLZsNc2
         0grM/GhXEOlY2XAm/7K/I9kwZXWbfBQLykCcYQrG+3rNtKOrAH/6r6mtrI8GnxqdkwO3
         fwwPu3W0jp/0Dl/tBxrdyOSq9bDtxKKwwrboE6ZzLTUGRkB7EX4MNTOHBeQmZkZ605IJ
         3cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747540; x=1697352340;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IAJEOSh67K5kR7rcBvLR4OfyWJsJjOXllWYuZ0je3c=;
        b=BiXwVEjvTLqzmgMv7ITBdizfvPNh8ELl0nOJEu4UeZp13VIqDukKUcx2jtDq+LUZyw
         zZu6QIXJIU2W0rYvIiJBmTth6AS1aydaefuK/DmxfIDRA4W/iqZ9tXP5ekdraDsJMIF4
         2TtvDjW9CAMH9/DwVgi5PEnuARcUEve3IFDW5r/KFjL7TXu4t5uTAHAyVxMtcJxtxnnD
         HzeZaGtb4VvTRn8OMGun+sySLhjMeicTOJlsdqDf3BYAfEHntkgwTUsiAg4opQuGkMM1
         9GMjOWJ+4Crpl1XBqX+gmuXwiL0vxsjilsjB3JyCSyKpwCrkKBknWN40/R3869+0vXTg
         50yA==
X-Gm-Message-State: AOJu0YwMOd3F4kpbFteJ/YXrewYDAWBmNz4IiWBGUBHMxmAllIXfYg5Z
        THb0DSLlHCcc3WWrdeMYavtAxmip5dw=
X-Google-Smtp-Source: AGHT+IGdgNDwgGYWIGs/Upnpqo6r9b81ub1oa4Ul6jDmPTfBUJdZLv9rtHTRvNzLpx00SNhfvAmYjg==
X-Received: by 2002:a7b:cd8e:0:b0:406:45c1:a657 with SMTP id y14-20020a7bcd8e000000b0040645c1a657mr10555263wmj.6.1696747539758;
        Sat, 07 Oct 2023 23:45:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2-20020a5d4802000000b0031fe0576460sm6017837wrq.11.2023.10.07.23.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:39 -0700 (PDT)
Message-ID: <2677abed19ecfcfb9c4ebf9613da24798da98ed3.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:16 +0000
Subject: [PATCH 14/25] documentation: fix choice of article
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
 Documentation/config.txt                  | 2 +-
 Documentation/diff-generate-patch.txt     | 2 +-
 Documentation/howto/maintain-git.txt      | 2 +-
 Documentation/pretty-options.txt          | 2 +-
 Documentation/technical/bitmap-format.txt | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9273c7f1c65..99affec5a01 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -103,7 +103,7 @@ was found.  See below for examples.
 Conditional includes
 ~~~~~~~~~~~~~~~~~~~~
 
-You can conditionally include a config file from another by setting a
+You can conditionally include a config file from another by setting an
 `includeIf.<condition>.path` variable to the name of the file to be
 included.
 
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 65e0b1646e1..4b307cb51bb 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -156,7 +156,7 @@ format, `/dev/null` is used to signal created or deleted
 files.
 +
 However, if the --combined-all-paths option is provided, instead of a
-two-line from-file/to-file you get a N+1 line from-file/to-file header,
+two-line from-file/to-file you get an N+1 line from-file/to-file header,
 where N is the number of parents in the merge commit:
 
        --- a/file
diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index 29c473e5e04..013014bbef6 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -411,7 +411,7 @@ Preparing a "merge-fix"
 
 A merge of two topics may not textually conflict but still have
 conflict at the semantic level. A classic example is for one topic
-to rename an variable and all its uses, while another topic adds a
+to rename a variable and all its uses, while another topic adds a
 new use of the variable under its old name. When these two topics
 are merged together, the reference to the variable newly added by
 the latter topic will still use the old name in the result.
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 335395b727f..15c6f2705d4 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -73,7 +73,7 @@ environment overrides). See linkgit:git-config[1] for more details.
 With an optional '<ref>' argument, use the ref to find the notes
 to display.  The ref can specify the full refname when it begins
 with `refs/notes/`; when it begins with `notes/`, `refs/` and otherwise
-`refs/notes/` is prefixed to form a full name of the ref.
+`refs/notes/` is prefixed to form the full name of the ref.
 +
 Multiple --notes options can be combined to control which notes are
 being displayed. Examples: "--notes=foo" will show only notes from
diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 687c58cebcc..f761828f106 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -126,7 +126,7 @@ Each entry contains the following:
 	** {empty}
 	1-byte XOR-offset: ::
 	    The xor offset used to compress this bitmap. For an entry
-	    in position `x`, a XOR offset of `y` means that the actual
+	    in position `x`, an XOR offset of `y` means that the actual
 	    bitmap representing this commit is composed by XORing the
 	    bitmap for this entry with the bitmap in entry `x-y` (i.e.
 	    the bitmap `y` entries before this one).
-- 
gitgitgadget

