Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B63201F405
	for <e@80x24.org>; Fri, 21 Dec 2018 13:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390562AbeLUNRl (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 08:17:41 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46541 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390486AbeLUNRk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 08:17:40 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so4622403edt.13
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 05:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8bq9xyrSW5Z8dJ40YIDGFd35cEj/TBz9DwbOhIuZXhI=;
        b=hozr91lzC1r7wBAKBbRdoHe+cQj0aJ2gm7g85HzRajZ6VK5aR8LWF0VIWXa57ME4bB
         qsFCAxw2iy9XfTHQp9qQ3VbZv2xP9DZgMSqMhCdxJuVxcvXBX+NCbIb2zbTBOF2hTIeQ
         sjQXWGQBuNFB174hjfiPzJwCy9UiSgTVv1ACJPx6LOyf5hGPr2MZQ7jK8iLoc01TRwYC
         uOV+bN1TcjmhmwfXlEa2OhqOZs+Q5HgTsJ9n7PtI453LTjFPXQzMJkxU+u2B/osZSilP
         knvHwWVqPYxQR/1/kFAjMbGO74IVYVWwGLf4F44i700k/FTEY4zj3t85ZUeg72rtsHPw
         1zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8bq9xyrSW5Z8dJ40YIDGFd35cEj/TBz9DwbOhIuZXhI=;
        b=lvC+65xxmBQSpwyPthTgBhC3oExGio2ZkTQOsGN+id5i9kgHjcN8EZlkXsjS+bSJSi
         5TwhevllLAh/VPb6I9NcRgo9K1Cas/c0UmtZdcxtlmz71gKUP12qy4acfom2ym1GZgMI
         l/MjMzzW49LZGH5UmtVPUKJubb5oWTUodrF9fUBTiOEpE2z/NXm+YmmM7iA/NaPHBu99
         cxDef8a/nO8dJ4IxVV/vTHSaavFh8Dpr/wyjdMGgezoatAo9FijjSKrjL56/6Q91sy4m
         oEuYDVV3rm6IZjWdYRvD0VBGGWOAtJxKIZ93TOFuNTcv6qOrfKQwd5SDNh89JVoEwy/y
         WYiw==
X-Gm-Message-State: AA+aEWbRJ+fLh6tIMTJZQABgyHxnkNR+n2bJGsz9rOX2L2fbJoJ2ervh
        0Lipk8KqbsiGh4OdLmu+BJD1JNvJiVaOVQ==
X-Google-Smtp-Source: AFSGD/XTumuEntlDkXIxM4NEJpFjqMR16jkLMLl1zG0RFMvUSN1qbsn8cPJDls64bM4YChaUn6bBCQ==
X-Received: by 2002:a50:acc3:: with SMTP id x61mr2365672edc.76.1545398256861;
        Fri, 21 Dec 2018 05:17:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d56sm7146671ede.76.2018.12.21.05.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 05:17:36 -0800 (PST)
Date:   Fri, 21 Dec 2018 05:17:36 -0800 (PST)
X-Google-Original-Date: Fri, 21 Dec 2018 13:17:31 GMT
Message-Id: <175dc7d29a02d4ebf6b964f7821738f4ed2bbe0b.1545398254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.24.git.gitgitgadget@gmail.com>
References: <pull.24.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/4] rebase: move `reset_head()` into a better spot
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Over the next commits, we want to make use of it in `run_am()` (i.e.
running the `--am` backend directly, without detouring to Unix shell
script code) which in turn will be called from `run_specific_rebase()`.

So let's move it before that latter function.

This commit is best viewed using --color-moved.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 238 +++++++++++++++++++++++------------------------
 1 file changed, 119 insertions(+), 119 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b5c99ec10c..e1dfa74ca8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -333,6 +333,125 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
 	}
 }
 
+#define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
+
+#define RESET_HEAD_DETACH (1<<0)
+#define RESET_HEAD_HARD (1<<1)
+
+static int reset_head(struct object_id *oid, const char *action,
+		      const char *switch_to_branch, unsigned flags,
+		      const char *reflog_orig_head, const char *reflog_head)
+{
+	unsigned detach_head = flags & RESET_HEAD_DETACH;
+	unsigned reset_hard = flags & RESET_HEAD_HARD;
+	struct object_id head_oid;
+	struct tree_desc desc[2] = { { NULL }, { NULL } };
+	struct lock_file lock = LOCK_INIT;
+	struct unpack_trees_options unpack_tree_opts;
+	struct tree *tree;
+	const char *reflog_action;
+	struct strbuf msg = STRBUF_INIT;
+	size_t prefix_len;
+	struct object_id *orig = NULL, oid_orig,
+		*old_orig = NULL, oid_old_orig;
+	int ret = 0, nr = 0;
+
+	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
+		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
+
+	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
+		ret = -1;
+		goto leave_reset_head;
+	}
+
+	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
+		ret = error(_("could not determine HEAD revision"));
+		goto leave_reset_head;
+	}
+
+	if (!oid)
+		oid = &head_oid;
+
+	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
+	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
+	unpack_tree_opts.head_idx = 1;
+	unpack_tree_opts.src_index = the_repository->index;
+	unpack_tree_opts.dst_index = the_repository->index;
+	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
+	unpack_tree_opts.update = 1;
+	unpack_tree_opts.merge = 1;
+	if (!detach_head)
+		unpack_tree_opts.reset = 1;
+
+	if (read_index_unmerged(the_repository->index) < 0) {
+		ret = error(_("could not read index"));
+		goto leave_reset_head;
+	}
+
+	if (!reset_hard && !fill_tree_descriptor(&desc[nr++], &head_oid)) {
+		ret = error(_("failed to find tree of %s"),
+			    oid_to_hex(&head_oid));
+		goto leave_reset_head;
+	}
+
+	if (!fill_tree_descriptor(&desc[nr++], oid)) {
+		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
+		goto leave_reset_head;
+	}
+
+	if (unpack_trees(nr, desc, &unpack_tree_opts)) {
+		ret = -1;
+		goto leave_reset_head;
+	}
+
+	tree = parse_tree_indirect(oid);
+	prime_cache_tree(the_repository->index, tree);
+
+	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0) {
+		ret = error(_("could not write index"));
+		goto leave_reset_head;
+	}
+
+	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
+	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
+	prefix_len = msg.len;
+
+	if (!get_oid("ORIG_HEAD", &oid_old_orig))
+		old_orig = &oid_old_orig;
+	if (!get_oid("HEAD", &oid_orig)) {
+		orig = &oid_orig;
+		if (!reflog_orig_head) {
+			strbuf_addstr(&msg, "updating ORIG_HEAD");
+			reflog_orig_head = msg.buf;
+		}
+		update_ref(reflog_orig_head, "ORIG_HEAD", orig, old_orig, 0,
+			   UPDATE_REFS_MSG_ON_ERR);
+	} else if (old_orig)
+		delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
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
+		ret = create_symref("HEAD", switch_to_branch, msg.buf);
+		if (!ret)
+			ret = update_ref(reflog_head, "HEAD", oid, NULL, 0,
+					 UPDATE_REFS_MSG_ON_ERR);
+	}
+
+leave_reset_head:
+	strbuf_release(&msg);
+	rollback_lock_file(&lock);
+	while (nr)
+		free((void *)desc[--nr].buffer);
+	return ret;
+}
+
 static const char *resolvemsg =
 N_("Resolve all conflicts manually, mark them as resolved with\n"
 "\"git add/rm <conflicted_files>\", then run \"git rebase --continue\".\n"
@@ -526,125 +645,6 @@ static int run_specific_rebase(struct rebase_options *opts)
 	return status ? -1 : 0;
 }
 
-#define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
-
-#define RESET_HEAD_DETACH (1<<0)
-#define RESET_HEAD_HARD (1<<1)
-
-static int reset_head(struct object_id *oid, const char *action,
-		      const char *switch_to_branch, unsigned flags,
-		      const char *reflog_orig_head, const char *reflog_head)
-{
-	unsigned detach_head = flags & RESET_HEAD_DETACH;
-	unsigned reset_hard = flags & RESET_HEAD_HARD;
-	struct object_id head_oid;
-	struct tree_desc desc[2] = { { NULL }, { NULL } };
-	struct lock_file lock = LOCK_INIT;
-	struct unpack_trees_options unpack_tree_opts;
-	struct tree *tree;
-	const char *reflog_action;
-	struct strbuf msg = STRBUF_INIT;
-	size_t prefix_len;
-	struct object_id *orig = NULL, oid_orig,
-		*old_orig = NULL, oid_old_orig;
-	int ret = 0, nr = 0;
-
-	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
-		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
-
-	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
-		ret = -1;
-		goto leave_reset_head;
-	}
-
-	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
-		ret = error(_("could not determine HEAD revision"));
-		goto leave_reset_head;
-	}
-
-	if (!oid)
-		oid = &head_oid;
-
-	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
-	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
-	unpack_tree_opts.head_idx = 1;
-	unpack_tree_opts.src_index = the_repository->index;
-	unpack_tree_opts.dst_index = the_repository->index;
-	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
-	unpack_tree_opts.update = 1;
-	unpack_tree_opts.merge = 1;
-	if (!detach_head)
-		unpack_tree_opts.reset = 1;
-
-	if (read_index_unmerged(the_repository->index) < 0) {
-		ret = error(_("could not read index"));
-		goto leave_reset_head;
-	}
-
-	if (!reset_hard && !fill_tree_descriptor(&desc[nr++], &head_oid)) {
-		ret = error(_("failed to find tree of %s"),
-			    oid_to_hex(&head_oid));
-		goto leave_reset_head;
-	}
-
-	if (!fill_tree_descriptor(&desc[nr++], oid)) {
-		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
-		goto leave_reset_head;
-	}
-
-	if (unpack_trees(nr, desc, &unpack_tree_opts)) {
-		ret = -1;
-		goto leave_reset_head;
-	}
-
-	tree = parse_tree_indirect(oid);
-	prime_cache_tree(the_repository->index, tree);
-
-	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0) {
-		ret = error(_("could not write index"));
-		goto leave_reset_head;
-	}
-
-	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
-	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
-	prefix_len = msg.len;
-
-	if (!get_oid("ORIG_HEAD", &oid_old_orig))
-		old_orig = &oid_old_orig;
-	if (!get_oid("HEAD", &oid_orig)) {
-		orig = &oid_orig;
-		if (!reflog_orig_head) {
-			strbuf_addstr(&msg, "updating ORIG_HEAD");
-			reflog_orig_head = msg.buf;
-		}
-		update_ref(reflog_orig_head, "ORIG_HEAD", orig, old_orig, 0,
-			   UPDATE_REFS_MSG_ON_ERR);
-	} else if (old_orig)
-		delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
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
-		ret = create_symref("HEAD", switch_to_branch, msg.buf);
-		if (!ret)
-			ret = update_ref(reflog_head, "HEAD", oid, NULL, 0,
-					 UPDATE_REFS_MSG_ON_ERR);
-	}
-
-leave_reset_head:
-	strbuf_release(&msg);
-	rollback_lock_file(&lock);
-	while (nr)
-		free((void *)desc[--nr].buffer);
-	return ret;
-}
-
 static int rebase_config(const char *var, const char *value, void *data)
 {
 	struct rebase_options *opts = data;
-- 
gitgitgadget

