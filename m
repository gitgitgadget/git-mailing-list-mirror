Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DD3C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 03:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4CF206DB
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 03:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYFIFIHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfLEDpJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 22:45:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36815 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfLEDpI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 22:45:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so1749543wru.3
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 19:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yzKh8Saucvfiuk1JpzV3uvy/VON9lDgoU/4pgwfmQL8=;
        b=QYFIFIHVmfb2qxxOUcx0zVpgHvQSeSenvGZLOr+XGy9iKAZVIpavs9z57P5DjKE+C6
         A4ExFvzGB+G3gJNOjs+C9uA8ky3j6Py6kpV13Yzuzu4IcaT3Y1/fe8a78g4TZj0wi5F/
         EBI01eUR2Td2mBJtc+DD1k0dyz2XhhtN6KCYR41qpeIdVhocIAiyOEMG6wBWvCww/tFT
         y5Kc+LHgKoSEw/p1tohx1TmfNYwLMX3Rh/898dxV0M3cueH4K6WT/zk7dWGC2VJULHUW
         h8j5RnxZZOl35Ha+qXvAmcezkiFRvWaCaoX9pH5ukNttDzzFzH952YyYmbtBjjTg3oV7
         KJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yzKh8Saucvfiuk1JpzV3uvy/VON9lDgoU/4pgwfmQL8=;
        b=OHJSOp/roDqLzo8RMUoykY9ZslSRwRbg174Dw5rh6+H9UGe2IqBIkdgpWW6WnsBRhv
         v7KqOF1B7TCE1fN1SwtEI34hpYbgzEJU9EKJnnjlLG/lw0wH/NJaerTZPTUAujEKk2wD
         QHdwUBs7UyuSkWuz0OApugX5zpgrZ7pfAyA476OV88/uisEv8Hggqt2f4I79nYciI0DW
         fn8Vra7zoKBQUYRH85LaYtZL0kDmpUB1Yc17OH8FJM+3079BJTGMBfm2g8P4WPEyjJZ8
         38vxZ+k3lkoDz2do1UQA4ZertJU9Fi/Y8zeQUTEOjyP1m17NAuaEA0cLpZYe/0BKfFAy
         hSJA==
X-Gm-Message-State: APjAAAWRm8nYdw3sMaVMd9eaYb9bqsCAnLvvORp4tuC2Q/kEEv0WfxNP
        wj+dHLsc77UfMprBj7FjilnG2bFJ
X-Google-Smtp-Source: APXvYqyQBSrbixboHX67NcTarR/grW4pl1vvNw+RszF0mou8UPBbs+hwgAJ+5roSny9x+zFPOGMtUQ==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr7695992wrc.175.1575517505353;
        Wed, 04 Dec 2019 19:45:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16sm11522038wru.0.2019.12.04.19.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 19:45:04 -0800 (PST)
Message-Id: <abb9e55ad5ef72242ee97e03316827b55ef2f4c8.1575517503.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.482.git.1575517503.gitgitgadget@gmail.com>
References: <pull.482.git.1575517503.gitgitgadget@gmail.com>
From:   "ryenus via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Dec 2019 03:45:03 +0000
Subject: [PATCH 1/1] fix-typo: consecutive-word duplications
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, ryenus <ryenus@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ryenus <ryenus@gmail.com>

Correct unintentional duplication(s) of words, such as "the the",
and "can can" etc.

In certain cases, the repeated words are suspicious but actually ok,
and if some alternative wording exists and might be an improvement,
then the alternative wording is used, for example:
"we didn't do so so far" becomes "we didn't do that so far".

Signed-off-by: ryenus <ryenus@gmail.com>
---
 Documentation/RelNotes/2.13.0.txt | 2 +-
 Documentation/RelNotes/2.7.3.txt  | 2 +-
 Makefile                          | 2 +-
 convert.c                         | 2 +-
 graph.c                           | 2 +-
 submodule-config.c                | 2 +-
 t/t5314-pack-cycle-detection.sh   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/RelNotes/2.13.0.txt b/Documentation/RelNotes/2.13.0.txt
index 2a47b4cb0c..496a68192f 100644
--- a/Documentation/RelNotes/2.13.0.txt
+++ b/Documentation/RelNotes/2.13.0.txt
@@ -38,7 +38,7 @@ UI, Workflows & Features
 
  * Deletion of a branch "foo/bar" could remove .git/refs/heads/foo
    once there no longer is any other branch whose name begins with
-   "foo/", but we didn't do so so far.  Now we do.
+   "foo/", but we didn't do that so far.  Now we do.
 
  * When "git merge" detects a path that is renamed in one history
    while the other history deleted (or modified) it, it now reports
diff --git a/Documentation/RelNotes/2.7.3.txt b/Documentation/RelNotes/2.7.3.txt
index 6adf038915..f618d71efd 100644
--- a/Documentation/RelNotes/2.7.3.txt
+++ b/Documentation/RelNotes/2.7.3.txt
@@ -20,7 +20,7 @@ Fixes since v2.7.2
    tests.
 
  * "git show 'HEAD:Foo[BAR]Baz'" did not interpret the argument as a
-   rev, i.e. the object named by the the pathname with wildcard
+   rev, i.e. the object named by the pathname with wildcard
    characters in a tree object.
 
  * "git rev-parse --git-common-dir" used in the worktree feature
diff --git a/Makefile b/Makefile
index 44997f6f57..664ab01b1c 100644
--- a/Makefile
+++ b/Makefile
@@ -481,7 +481,7 @@ all::
 #
 # When DEVELOPER is set, DEVOPTS can be used to control compiler
 # options.  This variable contains keywords separated by
-# whitespace. The following keywords are are recognized:
+# whitespace. The following keywords are recognized:
 #
 #    no-error:
 #
diff --git a/convert.c b/convert.c
index 797e0bd0b1..25d9338429 100644
--- a/convert.c
+++ b/convert.c
@@ -15,7 +15,7 @@
  *
  * This should use the pathname to decide on whether it wants to do some
  * more interesting conversions (automatic gzip/unzip, general format
- * conversions etc etc), but by default it just does automatic CRLF<->LF
+ * conversions etc), but by default it just does automatic CRLF<->LF
  * translation when the "text" attribute or "auto_crlf" option is set.
  */
 
diff --git a/graph.c b/graph.c
index e3fd0ea5f8..5da111f567 100644
--- a/graph.c
+++ b/graph.c
@@ -218,7 +218,7 @@ struct git_graph {
 	int merge_layout;
 	/*
 	 * The number of columns added to the graph by the current commit. For
-	 * 2-way and octopus merges, this is is usually one less than the
+	 * 2-way and octopus merges, this is usually one less than the
 	 * number of parents:
 	 *
 	 * 		| | |			| |    \
diff --git a/submodule-config.c b/submodule-config.c
index 401a9b2382..6bb8e65c26 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -618,7 +618,7 @@ static void submodule_cache_check_init(struct repository *repo)
 
 /*
  * Note: This function is private for a reason, the '.gitmodules' file should
- * not be used as as a mechanism to retrieve arbitrary configuration stored in
+ * not be used as a mechanism to retrieve arbitrary configuration stored in
  * the repository.
  *
  * Runs the provided config function on the '.gitmodules' file found in the
diff --git a/t/t5314-pack-cycle-detection.sh b/t/t5314-pack-cycle-detection.sh
index e525466de0..0aec8619e2 100755
--- a/t/t5314-pack-cycle-detection.sh
+++ b/t/t5314-pack-cycle-detection.sh
@@ -53,7 +53,7 @@ immediately after the lookup for "dummy".
 
 
 
-# Create a pack containing the the tree $1 and blob $1:file, with
+# Create a pack containing the tree $1 and blob $1:file, with
 # the latter stored as a delta against $2:file.
 #
 # We convince pack-objects to make the delta in the direction of our choosing
-- 
gitgitgadget
