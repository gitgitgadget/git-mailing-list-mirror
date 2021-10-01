Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56676C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4204761A50
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353345AbhJAKG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353287AbhJAKGy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:06:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09835C06177E
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:05:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s21so14577048wra.7
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9BCMdg5tfYIYrNE05cC1agH/brDhnMABkAtWHVeRW5s=;
        b=GFZb+UEyVsv9etlFYg4Z9GSF0QeiXqqtTsEILhkCPxItTLjcwWdmXzq2ssJlj8r2Qp
         btmddN3/iiLocpxdZ4XSovcwO3cBbQVP2p6cEw3/xghJ4RyuZ8yEZAszZzSLI3BbaESi
         oTvGwTdT0qkw92vePtjuZkyHB3aVipOHziXPzU3cc5nOyzK2SCzfymAy9/ozgs+YwMUG
         cC+3Kcr5uZUBosF960sjfTice0eaL+N6i5BPYGtPLPDx6Nm1lyREhTVtBb3zX6Vm99PX
         7kAWHtSQ/XVALge0RsAM0XYTKDWpH4PG2y51qFNZRiUnjV5uH4YQMKLVkvGX0IoF9L4X
         BgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9BCMdg5tfYIYrNE05cC1agH/brDhnMABkAtWHVeRW5s=;
        b=gzhi+BVxn8EMdQdCvS0S7GGO+wMwJ3elJa/buiXEeBmlH5TM51m2cGC2sqQz5eFi52
         Sw6KqujzX/mbJEzqF+zHa8tvJSSAsIBztyQywfw9Rqnn19dTO+bHHyxMdEc3uKqBUdCs
         yYrlzfLjzcxIP+y6WcUbwAFsfD4jzVo4VHiZbLgQxWk8EIbouIBenvV1SgpMck6I9for
         CItf8JTy82ySP5Ma607UVIvQWMdQQpZl0X/0PcUEf64iBAtiLFoVNia9cZwUGZil0Jd0
         nyhmdWMS00ljYeNlZFSEoMPyd1v9unAhXHe3EHhoI1rZvQrsQeQMF8Wx1rR633cTNA2e
         Jhgw==
X-Gm-Message-State: AOAM531DValgQRddzabLNvYc7rwDbW+l2l1t+0oPYwn1JAhqy0+LY2UQ
        MN6RHTJlX/KNWEUwlPJPVJ17R4Il3ww=
X-Google-Smtp-Source: ABdhPJxyy2tU1Y2j74POVfy1BPyY7m7SHsE0A/Uyk7Pr4X5FgW8rqaMoNwdHXLUbhVOvLvWeh8IJ7g==
X-Received: by 2002:adf:bbc3:: with SMTP id z3mr7851185wrg.10.1633082707432;
        Fri, 01 Oct 2021 03:05:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1sm6258717wrr.72.2021.10.01.03.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:05:07 -0700 (PDT)
Message-Id: <0744c3d143b5c2020267c5f9ad7da9303d7a7835.1633082702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 10:04:56 +0000
Subject: [PATCH 05/11] reset_head(): factor out ref updates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In the next commit we will stop trying to update HEAD when we are just
clearing changes from the working tree. Move the code that updates the
refs to its own function in preparation for that.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 reset.c | 112 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 62 insertions(+), 50 deletions(-)

diff --git a/reset.c b/reset.c
index 9ab007c0c34..668c7639127 100644
--- a/reset.c
+++ b/reset.c
@@ -8,26 +8,75 @@
 #include "tree.h"
 #include "unpack-trees.h"
 
+static int update_refs(const struct object_id *oid, const char *switch_to_branch,
+		       const char *reflog_head, const char *reflog_orig_head,
+		       const char *default_reflog_action, unsigned flags)
+{
+	unsigned detach_head = flags & RESET_HEAD_DETACH;
+	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
+	struct object_id *orig = NULL, oid_orig, *old_orig = NULL, oid_old_orig;
+	struct strbuf msg = STRBUF_INIT;
+	const char *reflog_action;
+	size_t prefix_len;
+	int ret;
+
+	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
+	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
+	prefix_len = msg.len;
+
+	if (update_orig_head) {
+		if (!get_oid("ORIG_HEAD", &oid_old_orig))
+			old_orig = &oid_old_orig;
+		if (!get_oid("HEAD", &oid_orig)) {
+			orig = &oid_orig;
+			if (!reflog_orig_head) {
+				strbuf_addstr(&msg, "updating ORIG_HEAD");
+				reflog_orig_head = msg.buf;
+			}
+			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
+				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
+		} else if (old_orig)
+			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
+	}
+
+	if (!reflog_head) {
+		strbuf_setlen(&msg, prefix_len);
+		strbuf_addstr(&msg, "updating HEAD");
+		reflog_head = msg.buf;
+	}
+	if (!switch_to_branch)
+		ret = update_ref(reflog_head, "HEAD", oid, orig,
+				 detach_head ? REF_NO_DEREF : 0,
+				 UPDATE_REFS_MSG_ON_ERR);
+	else {
+		ret = update_ref(reflog_head, switch_to_branch, oid,
+				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+		if (!ret)
+			ret = create_symref("HEAD", switch_to_branch,
+					    reflog_head);
+	}
+	if (!ret && run_hook)
+		run_hook_le(NULL, "post-checkout",
+			    oid_to_hex(orig ? orig : null_oid()),
+			    oid_to_hex(oid), "1", NULL);
+	strbuf_release(&msg);
+	return ret;
+}
+
 int reset_head(struct repository *r, struct object_id *oid,
 	       const char *switch_to_branch, unsigned flags,
 	       const char *reflog_orig_head, const char *reflog_head,
 	       const char *default_reflog_action)
 {
-	unsigned detach_head = flags & RESET_HEAD_DETACH;
 	unsigned reset_hard = flags & RESET_HEAD_HARD;
-	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
-	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
 	struct object_id head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
 	struct unpack_trees_options unpack_tree_opts = { 0 };
 	struct tree *tree;
-	const char *action, *reflog_action;
-	struct strbuf msg = STRBUF_INIT;
-	size_t prefix_len;
-	struct object_id *orig = NULL, oid_orig,
-		*old_orig = NULL, oid_old_orig;
+	const char *action;
 	int ret = 0, nr = 0;
 
 	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
@@ -47,7 +96,9 @@ int reset_head(struct repository *r, struct object_id *oid,
 		oid = &head_oid;
 
 	if (refs_only)
-		goto reset_head_refs;
+		return update_refs(oid, switch_to_branch, reflog_head,
+				   reflog_orig_head, default_reflog_action,
+				   flags);
 
 	action = reset_hard ? "reset" : "checkout";
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
@@ -90,49 +141,10 @@ int reset_head(struct repository *r, struct object_id *oid,
 		goto leave_reset_head;
 	}
 
-reset_head_refs:
-	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
-	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
-	prefix_len = msg.len;
-
-	if (update_orig_head) {
-		if (!get_oid("ORIG_HEAD", &oid_old_orig))
-			old_orig = &oid_old_orig;
-		if (!get_oid("HEAD", &oid_orig)) {
-			orig = &oid_orig;
-			if (!reflog_orig_head) {
-				strbuf_addstr(&msg, "updating ORIG_HEAD");
-				reflog_orig_head = msg.buf;
-			}
-			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
-				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
-		} else if (old_orig)
-			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
-	}
-
-	if (!reflog_head) {
-		strbuf_setlen(&msg, prefix_len);
-		strbuf_addstr(&msg, "updating HEAD");
-		reflog_head = msg.buf;
-	}
-	if (!switch_to_branch)
-		ret = update_ref(reflog_head, "HEAD", oid, orig,
-				 detach_head ? REF_NO_DEREF : 0,
-				 UPDATE_REFS_MSG_ON_ERR);
-	else {
-		ret = update_ref(reflog_head, switch_to_branch, oid,
-				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
-		if (!ret)
-			ret = create_symref("HEAD", switch_to_branch,
-					    reflog_head);
-	}
-	if (!ret && run_hook)
-		run_hook_le(NULL, "post-checkout",
-			    oid_to_hex(orig ? orig : null_oid()),
-			    oid_to_hex(oid), "1", NULL);
+	ret = update_refs(oid, switch_to_branch, reflog_head, reflog_orig_head,
+			  default_reflog_action, flags);
 
 leave_reset_head:
-	strbuf_release(&msg);
 	rollback_lock_file(&lock);
 	clear_unpack_trees_porcelain(&unpack_tree_opts);
 	while (nr)
-- 
gitgitgadget

