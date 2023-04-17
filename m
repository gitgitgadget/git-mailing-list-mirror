Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BD7C77B7A
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 16:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjDQQVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDQQVr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 12:21:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085AB4ECE
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:21:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f0aabd1040so45820355e9.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681748504; x=1684340504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/kM71VJN5RJKFSYvsOZB4R+xGsWdJ66FfZktqdO5m0=;
        b=pQ7rHxcOwm9fV1ZFcU7CLaDJ8MVd22ppcCTlMMBgECFG9Vf6KYcWJ/shZ/Ce/I+99v
         OnXF6Yj6k7PsWtuNa3gdVvpVRK4OqaFRkhl4hlfWzY0lssxKa49BLjLANVXrxI38QwWN
         DgO+QCBIHiAkCFc1SGZPIA/4y3L16a6XY2ryWzspv7fG7M9k+P/0exD4XWx+sSHbnI6h
         rBwgNeFmsaloUIXgE3ap7uEj2D9LUDVUNWHBMFU92lkfOanGDVvSAvyg1MYlWbj2dtpW
         Zrdpy5BgFRkSfTlYfta8GOkkcrhI6Z+z3y7lUUnuasfuCtCzCbFXrd4HbpPffMa6pj3g
         o16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681748504; x=1684340504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/kM71VJN5RJKFSYvsOZB4R+xGsWdJ66FfZktqdO5m0=;
        b=jTn1F/mO2r8AlPcls+6CmmLoaqDF1u5ROee53Mu+ED6FcPIldt41SR7w+ZhtojeLRx
         fLSUj19/bDXchIsd0RWGGSOxRf4yQKcBTcHLg4Q4/flv+i7zYirJJIhrxhfAu531Gnis
         hvv+Gp1JViAQMG/tfGAkRtaX7rdTzvZI6LO7mKpHZ85cYATMmHu8d3Fzk9mC2pe90Jar
         gN9Oz75XZnRMrmiltuXk5Kib7D6FNxrtAAN2XB6Z4FIsKACak7ZAAm4RfBcmq8txPByQ
         hMG7FSKXDIrFWYhYATgVdTMdmmemNoU0Pjmns0VbIDIVyhcu4/n+m3gMHRrMjuOtB8mf
         GAwA==
X-Gm-Message-State: AAQBX9efyWmEWiWZAia5VlkydEmuHebSNNpZ+Xo8rIiFkfbTq2YL/Ij5
        0JuZuY+XJLAA37L4lYXLTgUOXQByLP0=
X-Google-Smtp-Source: AKy350Z9jrNygJb7q8mYO9iTTUryY6DEgmzA1y+UEL9dapYxlaIBdv4p+SEeVWqADjjvKJ2G46awUw==
X-Received: by 2002:a05:6000:51:b0:2ef:21da:d611 with SMTP id k17-20020a056000005100b002ef21dad611mr6081240wrx.22.1681748504080;
        Mon, 17 Apr 2023 09:21:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d17-20020a056000115100b002fa6929eb83sm3086551wrx.21.2023.04.17.09.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 09:21:43 -0700 (PDT)
Message-Id: <6bc3c56453ee2d0263210c233dbc946b5dbdcb4d.1681748502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Apr 2023 16:21:38 +0000
Subject: [PATCH 1/4] fsck: create scaffolding for rev-index checks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'fsck' builtin checks many of Git's on-disk data structures, but
does not currently validate the pack rev-index files (a .rev file to
pair with a .pack and .idx file).

Before doing a more-involved check process, create the scaffolding
within builtin/fsck.c to have a new error type and add that error type
when the API method verify_pack_revindex() returns an error. That method
does nothing currently, but we will add checks to it in later changes.

For now, check that 'git fsck' succeeds without any errors in the normal
case. Future checks will be paired with tests that corrupt the .rev file
appropriately.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/fsck.c           | 30 ++++++++++++++++++++++++++++++
 pack-revindex.c          | 11 +++++++++++
 pack-revindex.h          |  8 ++++++++
 t/t5325-reverse-index.sh | 14 ++++++++++++++
 4 files changed, 63 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 095b39d3980..2ab78129bde 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -24,6 +24,7 @@
 #include "resolve-undo.h"
 #include "run-command.h"
 #include "worktree.h"
+#include "pack-revindex.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -53,6 +54,7 @@ static int name_objects;
 #define ERROR_REFS 010
 #define ERROR_COMMIT_GRAPH 020
 #define ERROR_MULTI_PACK_INDEX 040
+#define ERROR_PACK_REV_INDEX 0100
 
 static const char *describe_object(const struct object_id *oid)
 {
@@ -856,6 +858,32 @@ static int mark_packed_for_connectivity(const struct object_id *oid,
 	return 0;
 }
 
+static int check_pack_rev_indexes(struct repository *r, int show_progress)
+{
+	struct progress *progress = NULL;
+	uint32_t pack_count = 0;
+	int res = 0;
+
+	if (show_progress) {
+		for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next)
+			pack_count++;
+		progress = start_delayed_progress("Verifying reverse pack-indexes", pack_count);
+		pack_count = 0;
+	}
+
+	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
+		if (!load_pack_revindex(the_repository, p) &&
+		    verify_pack_revindex(p)) {
+			error(_("invalid rev-index for pack '%s'"), p->pack_name);
+			res = ERROR_PACK_REV_INDEX;
+		}
+		display_progress(progress, ++pack_count);
+	}
+	stop_progress(&progress);
+
+	return res;
+}
+
 static char const * const fsck_usage[] = {
 	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
 	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
@@ -1019,6 +1047,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		free_worktrees(worktrees);
 	}
 
+	errors_found |= check_pack_rev_indexes(the_repository, show_progress);
+
 	check_connectivity();
 
 	if (the_repository->settings.core_commit_graph) {
diff --git a/pack-revindex.c b/pack-revindex.c
index 29f5358b256..c3f2aaa3fea 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -301,6 +301,17 @@ int load_pack_revindex(struct repository *r, struct packed_git *p)
 	return -1;
 }
 
+/*
+ * verify_pack_revindex verifies that the on-disk rev-index for the given
+ * pack-file is the same that would be created if written from scratch.
+ *
+ * A negative number is returned on error.
+ */
+int verify_pack_revindex(struct packed_git *p)
+{
+	return 0;
+}
+
 int load_midx_revindex(struct multi_pack_index *m)
 {
 	struct strbuf revindex_name = STRBUF_INIT;
diff --git a/pack-revindex.h b/pack-revindex.h
index 46e834064e1..c8861873b02 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -51,6 +51,14 @@ struct repository;
  */
 int load_pack_revindex(struct repository *r, struct packed_git *p);
 
+/*
+ * verify_pack_revindex verifies that the on-disk rev-index for the given
+ * pack-file is the same that would be created if written from scratch.
+ *
+ * A negative number is returned on error.
+ */
+int verify_pack_revindex(struct packed_git *p);
+
 /*
  * load_midx_revindex loads the '.rev' file corresponding to the given
  * multi-pack index by mmap-ing it and assigning pointers in the
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 0548fce1aa6..206c412f50b 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -131,4 +131,18 @@ test_expect_success 'revindex in-memory vs on-disk' '
 		test_cmp on-disk in-core
 	)
 '
+
+test_expect_success 'fsck succeeds on good rev-index' '
+	test_when_finished rm -fr repo &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit commit &&
+		git -c pack.writeReverseIndex=true repack -ad &&
+		git fsck 2>err &&
+		test_must_be_empty err
+	)
+'
+
 test_done
-- 
gitgitgadget

