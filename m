Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38471E95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344473AbjJHGpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbjJHGpi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ED4DF
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so34143145e9.3
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747533; x=1697352333; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4Dy/UDmc7b3agjq8hRYZ6jPICQ2BfHP2QU8D4RgPII=;
        b=MhnYsigRD1daN8UhuzstokdFOJfjJ6FYXoVNvFqa2XJLmyAawcueRz5aNyV8bY/wid
         T2mkJPaktjskGndDdUSlkDUO9kP94RGFO/Ye8fdz2EMed7qM0oEXTUZb6BgIzeZqQr8l
         0jgTZSjxciRc032fOQcDlkZYSEQgEymMuxRzAX0Kja9fcAR6moBGHHx3ZtUBfXQUqxST
         OQa+hzk7zz7Ajik3sjEWZA8qmYMwMu1BcGHDNOKeaGHVKlpmhAemsu8azOuRk5OeVeb+
         2Lz48OBT5202BcQ9VW5w+YacuHzZkmg1xEoI7uhicXqaaveyxW1H6gaIEjmqNPEBX7LZ
         O+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747533; x=1697352333;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4Dy/UDmc7b3agjq8hRYZ6jPICQ2BfHP2QU8D4RgPII=;
        b=SYylYVMNRJs57t9qZTMDrygY9NAksPZ2Og59f9RBjaO+0e8Y/0GFRMatOrUjbhzD3i
         sOj1ZEYHg5af/jtV0RqSlI7CdC01HvqAXy3rl5FGUJtzVHzHnN6Pl6aZcDdCHuTzEPyP
         m1vieqzb9FTO4EkIFOC4P2GjQC3Go5ViNGt+hMroLfSce0a01MoBaYpS+odUoHXyQlzK
         hzYkECSbd1ND1lTHg21J7Z41LAMxvu/mIblgl/QJhTVm/tLofLrSj2bq047HfR63dT5E
         T3O5dnV6dN93pWKXj4x5jUZ+oTLvQ1IKs9uv7cAVELsJf8a7lVqXYZJ/k1e+slJqMwN2
         A8Ng==
X-Gm-Message-State: AOJu0YzmsddASrgzHHYp6jGRQEnYKlbj9mUXERO9cW+M3MKH7441J3r8
        ILt+f/pNyLT+rQJ0ACWg8Y+gdwHbPg8=
X-Google-Smtp-Source: AGHT+IFXG5FbBOyuQ03w6kZ/cEkTgewPP/3yuvNR/dy7kvqpiSMlDloA35lqWJq2DzikIP8U+M6e9Q==
X-Received: by 2002:a5d:614b:0:b0:31c:8c93:61e3 with SMTP id y11-20020a5d614b000000b0031c8c9361e3mr10182779wrt.60.1696747533303;
        Sat, 07 Oct 2023 23:45:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm6000103wrn.101.2023.10.07.23.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:33 -0700 (PDT)
Message-ID: <5ea4a160bdeb55043ada7e2497b97aba449ed615.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:06 +0000
Subject: [PATCH 04/25] documentation: fix apostrophe usage
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
 Documentation/config/index.txt     | 2 +-
 Documentation/config/pack.txt      | 2 +-
 Documentation/config/submodule.txt | 2 +-
 Documentation/git-mktag.txt        | 2 +-
 Documentation/git-rm.txt           | 2 +-
 Documentation/gitprotocol-pack.txt | 2 +-
 Documentation/pull-fetch-param.txt | 2 +-
 Documentation/technical/rerere.txt | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
index 23c7985eb40..3eff4203603 100644
--- a/Documentation/config/index.txt
+++ b/Documentation/config/index.txt
@@ -23,7 +23,7 @@ index.threads::
 	Specifies the number of threads to spawn when loading the index.
 	This is meant to reduce index load time on multiprocessor machines.
 	Specifying 0 or 'true' will cause Git to auto-detect the number of
-	CPU's and set the number of threads accordingly. Specifying 1 or
+	CPUs and set the number of threads accordingly. Specifying 1 or
 	'false' will disable multithreading. Defaults to 'true'.
 
 index.version::
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index dcd4c871b3a..6308f21e03d 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -74,7 +74,7 @@ pack.threads::
 	warning. This is meant to reduce packing time on multiprocessor
 	machines. The required amount of memory for the delta search window
 	is however multiplied by the number of threads.
-	Specifying 0 will cause Git to auto-detect the number of CPU's
+	Specifying 0 will cause Git to auto-detect the number of CPUs
 	and set the number of threads accordingly.
 
 pack.indexVersion::
diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index 665419fa135..0672d991172 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -35,7 +35,7 @@ submodule.<name>.ignore::
 	a submodule as modified. When set to "all", it will never be considered
 	modified (but it will nonetheless show up in the output of status and
 	commit when it has been staged), "dirty" will ignore all changes
-	to the submodules work tree and
+	to the submodule's work tree and
 	takes only differences between the HEAD of the submodule and the commit
 	recorded in the superproject into account. "untracked" will additionally
 	let submodules with modified tracked files in their work tree show up.
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index b2a2e80d421..cd8fe9169e8 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Reads a tag contents on standard input and creates a tag object. The
+Reads a tag's contents on standard input and creates a tag object. The
 output is the new tag's <object> identifier.
 
 This command is mostly equivalent to linkgit:git-hash-object[1]
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 81bc23f3cdb..363a26934f5 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -163,7 +163,7 @@ will be staged (unless --cached or -n are used).
 
 A submodule is considered up to date when the HEAD is the same as
 recorded in the index, no tracked files are modified and no untracked
-files that aren't ignored are present in the submodules work tree.
+files that aren't ignored are present in the submodule's work tree.
 Ignored files are deemed expendable and won't stop a submodule's work
 tree from being removed.
 
diff --git a/Documentation/gitprotocol-pack.txt b/Documentation/gitprotocol-pack.txt
index dd4108b7a3b..01391cb300d 100644
--- a/Documentation/gitprotocol-pack.txt
+++ b/Documentation/gitprotocol-pack.txt
@@ -137,7 +137,7 @@ an absolute path in the remote filesystem.
 		    v
     ssh user@example.com "git-upload-pack '/project.git'"
 
-In a "user@host:path" format URI, its relative to the user's home
+In a "user@host:path" format URI, it's relative to the user's home
 directory, because the Git client will run:
 
      git clone user@example.com:project.git
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 95a7390b2c7..26bf06d991b 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -71,7 +71,7 @@ refspec (or `--force`).
 Unlike when pushing with linkgit:git-push[1], any updates outside of
 `refs/{tags,heads}/*` will be accepted without `+` in the refspec (or
 `--force`), whether that's swapping e.g. a tree object for a blob, or
-a commit for another commit that's doesn't have the previous commit as
+a commit for another commit that doesn't have the previous commit as
 an ancestor etc.
 +
 Unlike when pushing with linkgit:git-push[1], there is no
diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
index be58f1bee36..3f9259cb1e4 100644
--- a/Documentation/technical/rerere.txt
+++ b/Documentation/technical/rerere.txt
@@ -76,7 +76,7 @@ examples would both result in the following normalized conflict:
 Sorting hunks
 ~~~~~~~~~~~~~
 
-As before, lets imagine that a common ancestor had a file with line A
+As before, let's imagine that a common ancestor had a file with line A
 its early part, and line X in its late part.  And then four branches
 are forked that do these things:
 
-- 
gitgitgadget

