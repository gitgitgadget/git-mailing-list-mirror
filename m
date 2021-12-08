Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E865C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhLHPBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbhLHPBl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:01:41 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D50C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:58:09 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t9so4543040wrx.7
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0i+OqEyIp2gUhDcYmneCi2OS4t/v4DnKLlcRCSms98Y=;
        b=R3En04CuYau5t2Rq2bF4gJTHLso294UqJ1oFQJmYW8gjiJ2OzKy1mMdOIaphVj4Kmd
         or5o1KMeTIJA1XScywu9S/e7+yQ4HU/Lq+qJteEUEbzmYwBeVFuKpHoysjh0ZmK2VJNj
         Axlk3yiShgsP3QYIuWuO5f/WCde2UOgKEbLwzWSq7NoqqXXSebdQDGqVU3RBOzPVuxXm
         o/O3s37o/IZ2wlXpksBhz44KRBEtJ5UZNkIX6xGmkAmNAfkxLs/hX78EqTLFwGP+VDaP
         P7gBs7zQ02HDyNgG7I9gbNFFSMghoaixC0H8wQ5RwCV9N9lxATO0XdPHoZRyTo7ojF2j
         LVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0i+OqEyIp2gUhDcYmneCi2OS4t/v4DnKLlcRCSms98Y=;
        b=HACN7gsbDywVyq7glw++iiHdX7LYFDc4Ik4W28FtQgBwlYbzW72zAEFQ6BXUfjYqWT
         5umqjQVCA4zHHQg3HO4Rgxpu1UYv5/9Wb3aSUV2qyyqLo10Uv4rZQrGYMJSi2FpN6iRF
         A/O4QgedeC/c3gl3adLsAo9fA34T3zN9MPHHeaxgrljtvwxhXbkg4onGsg5qaT6/UvDk
         7cmfo+h3Bk02eUEx7g7EA+1BGhJbOQ1pnjr16Jo/T4qTtzsxzk46+fJxoq4BTcUfd59a
         UADe2p2VdWLwTJAcoCmzg7RptPSjghX2AEOUR4vmMm0WZVYdKyNHg+o5/VlDsM77hRzc
         xAQQ==
X-Gm-Message-State: AOAM532jmuJlhE6kn/wuUCAwdrIMbLLQ++tMA4/fdyL/3G48mVPBh+7i
        Uz1wcsSlr+Q30QQ0NWq5tGDnHWL97RM=
X-Google-Smtp-Source: ABdhPJzlMUH0RwmA3/785ibybdnbzuCAxzl8nprjvHufW8yeSyoajd/Rj23xFqrv3MXHGfJpMynOgA==
X-Received: by 2002:a05:6000:47:: with SMTP id k7mr58180542wrx.485.1638975487675;
        Wed, 08 Dec 2021 06:58:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm3802615wri.45.2021.12.08.06.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:58:07 -0800 (PST)
Message-Id: <32ffa98c1bcc0350fbbf6ce8c1bec5827bcb2594.1638975482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 14:57:53 +0000
Subject: [PATCH v2 06/14] reset_head(): remove action parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The only use of the action parameter is to setup the error messages
for unpack_trees(). All but two cases pass either "checkout" or
"reset". The case that passes "reset --hard" would be better passing
"reset" so that the error messages match the builtin reset command
like all the other callers that are doing a reset. The case that
passes "Fast-forwarded" is only updating HEAD and so the parameter is
unused in that case as it does not call unpack_trees(). The value to
pass to setup_unpack_trees_porcelain() can be determined by checking
whether flags contains RESET_HEAD_HARD without the caller having to
specify it.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 14 +++++++-------
 reset.c          |  5 +++--
 reset.h          |  2 +-
 sequencer.c      |  3 +--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index f5c37b7d4a5..2e5a535b54e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -583,7 +583,7 @@ static int move_to_original_branch(struct rebase_options *opts)
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
 	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
 		    opts->head_name);
-	ret = reset_head(the_repository, NULL, "", opts->head_name,
+	ret = reset_head(the_repository, NULL, opts->head_name,
 			 RESET_HEAD_REFS_ONLY,
 			 orig_head_reflog.buf, head_reflog.buf,
 			 DEFAULT_REFLOG_ACTION);
@@ -674,7 +674,7 @@ static int run_am(struct rebase_options *opts)
 		free(rebased_patches);
 		strvec_clear(&am.args);
 
-		reset_head(the_repository, &opts->orig_head, "checkout",
+		reset_head(the_repository, &opts->orig_head,
 			   opts->head_name, 0,
 			   "HEAD", NULL, DEFAULT_REFLOG_ACTION);
 		error(_("\ngit encountered an error while preparing the "
@@ -820,7 +820,7 @@ static int checkout_up_to_date(struct rebase_options *options)
 	strbuf_addf(&buf, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    options->switch_to);
-	if (reset_head(the_repository, &options->orig_head, "checkout",
+	if (reset_head(the_repository, &options->orig_head,
 		       options->head_name, RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 		       NULL, buf.buf, DEFAULT_REFLOG_ACTION) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
@@ -1272,7 +1272,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 
-		if (reset_head(the_repository, NULL, "reset", NULL, RESET_HEAD_HARD,
+		if (reset_head(the_repository, NULL, NULL, RESET_HEAD_HARD,
 			       NULL, NULL, DEFAULT_REFLOG_ACTION) < 0)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
@@ -1290,7 +1290,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 		if (read_basic_state(&options))
 			exit(1);
-		if (reset_head(the_repository, &options.orig_head, "reset",
+		if (reset_head(the_repository, &options.orig_head,
 			       options.head_name, RESET_HEAD_HARD,
 			       NULL, NULL, DEFAULT_REFLOG_ACTION) < 0)
 			die(_("could not move back to %s"),
@@ -1759,7 +1759,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
-	if (reset_head(the_repository, &options.onto->object.oid, "checkout", NULL,
+	if (reset_head(the_repository, &options.onto->object.oid, NULL,
 		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 		       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 		       NULL, msg.buf, DEFAULT_REFLOG_ACTION))
@@ -1777,7 +1777,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
-		reset_head(the_repository, NULL, "Fast-forwarded", options.head_name,
+		reset_head(the_repository, NULL, options.head_name,
 			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf,
 			   DEFAULT_REFLOG_ACTION);
 		strbuf_release(&msg);
diff --git a/reset.c b/reset.c
index 3537de91f65..7841b2b2a02 100644
--- a/reset.c
+++ b/reset.c
@@ -8,7 +8,7 @@
 #include "tree.h"
 #include "unpack-trees.h"
 
-int reset_head(struct repository *r, struct object_id *oid, const char *action,
+int reset_head(struct repository *r, struct object_id *oid,
 	       const char *switch_to_branch, unsigned flags,
 	       const char *reflog_orig_head, const char *reflog_head,
 	       const char *default_reflog_action)
@@ -23,7 +23,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	struct lock_file lock = LOCK_INIT;
 	struct unpack_trees_options unpack_tree_opts = { 0 };
 	struct tree *tree;
-	const char *reflog_action;
+	const char *action, *reflog_action;
 	struct strbuf msg = STRBUF_INIT;
 	size_t prefix_len;
 	struct object_id *old_orig = NULL, oid_old_orig;
@@ -50,6 +50,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	if (refs_only)
 		goto reset_head_refs;
 
+	action = reset_hard ? "reset" : "checkout";
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
 	unpack_tree_opts.head_idx = 1;
 	unpack_tree_opts.src_index = r->index;
diff --git a/reset.h b/reset.h
index 12f83c78e28..2daec804259 100644
--- a/reset.h
+++ b/reset.h
@@ -12,7 +12,7 @@
 #define RESET_HEAD_REFS_ONLY (1<<3)
 #define RESET_ORIG_HEAD (1<<4)
 
-int reset_head(struct repository *r, struct object_id *oid, const char *action,
+int reset_head(struct repository *r, struct object_id *oid,
 	       const char *switch_to_branch, unsigned flags,
 	       const char *reflog_orig_head, const char *reflog_head,
 	       const char *default_reflog_action);
diff --git a/sequencer.c b/sequencer.c
index ea96837cde3..3d3c3fbe305 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4131,8 +4131,7 @@ void create_autostash(struct repository *r, const char *path,
 			    path);
 		write_file(path, "%s", oid_to_hex(&oid));
 		printf(_("Created autostash: %s\n"), buf.buf);
-		if (reset_head(r, NULL, "reset --hard",
-			       NULL, RESET_HEAD_HARD, NULL, NULL,
+		if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
 			       default_reflog_action) < 0)
 			die(_("could not reset --hard"));
 
-- 
gitgitgadget

