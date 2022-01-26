Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F189EC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiAZNGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbiAZNGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:06:04 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777FCC06175F
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:06:00 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u15so25702228wrt.3
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1Qzug0zMX4BPYb3vEGxT+fDS55Fyebv1lJAK6BLnZok=;
        b=H9oMjjcnkZfWYSrvkyDlKUHlI852sulAIr5MdZ5o2JROR8KxYKAG2sqZ7NRfaLv25G
         ww+OFVgc0ebZ5eTcCmqpyKVU6nMwbK8RWDvs0WGQx0nLuCfY9t7E6ZNTEMjVQa4T6AfH
         hHogovJYjTGMxsgVKJEd6QE0LDBZ72oxAdQ/rHFRiVxjYM7vdIL991Q761NhDiVLZggP
         B9hOJjvWCEiVDArlJ8NC5vkO7mKU4KvYCM9e4o7vR0TRJW30QlUAPC//QIZR0aJJKH1y
         vtQoSTBbu1g2TVgSZahzVyqm+3R51O678mEZaqtgoRxekIc8ioJn+w/s936LZWTXvbXy
         0qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1Qzug0zMX4BPYb3vEGxT+fDS55Fyebv1lJAK6BLnZok=;
        b=dSBJ68bFFZDZeVbOX+n6oCo+XOp8e/i8SoGZQXyl7lVc8hzhoZi5E9ybzJ5VHgZF0S
         Rp3sWP5djpMPa7ThKp0Q2zpIlB7We76Ad08rAxYDPkKYXAexh6oSEigO/5bFg+Tw3Frr
         SEHgumAYQnD+uwUzBYa0cTWSEyNX0cvem+jyZfmI1aw77Lwtq5f6LdEB0TOobpoAi5ic
         lC63CfVt9eq5yyGV7/Ak+cmzTUJyTq6tJWSYYNlySzNUM1zGpdTEw41V/3kpEt90os9W
         LbscVLc5MwEMVKGeD/srqC/xEgP2zrfFnPIQafehkHoHdCYcGsaFebhYZJWyoFapcibi
         /mTw==
X-Gm-Message-State: AOAM532p3KraGnKmhpgk+8dHwXskM/2r/2HpxP0xZok0g64ebuoxr2Oz
        K8zJNRfkKZhtHWDZHLnCgSam9FwHqcM=
X-Google-Smtp-Source: ABdhPJwiIwYuPtonDLDwpHxElt7jTG0U+gCfF9ZnBsWl0UAq/VYzKOdoW2UqlO965SVYUsPLBnBDhw==
X-Received: by 2002:a5d:5849:: with SMTP id i9mr2604644wrf.33.1643202358792;
        Wed, 26 Jan 2022 05:05:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o27sm3247509wms.4.2022.01.26.05.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:05:58 -0800 (PST)
Message-Id: <dd3a22384d23e670bea0abeab6c32c463a542a94.1643202349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 13:05:44 +0000
Subject: [PATCH v3 09/14] create_autostash(): remove unneeded parameter
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

The default_reflog parameter of create_autostash() is passed to
reset_head(). However as creating a stash does not involve updating
any refs the parameter is not used by reset_head(). Removing the
parameter from create_autostash() simplifies the callers.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/merge.c  | 6 ++----
 builtin/rebase.c | 8 ++++----
 sequencer.c      | 5 ++---
 sequencer.h      | 3 +--
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index ea3112e0c0b..cb0e4e22258 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1565,8 +1565,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		if (autostash)
 			create_autostash(the_repository,
-					 git_path_merge_autostash(the_repository),
-					 "merge");
+					 git_path_merge_autostash(the_repository));
 		if (checkout_fast_forward(the_repository,
 					  &head_commit->object.oid,
 					  &commit->object.oid,
@@ -1637,8 +1636,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	if (autostash)
 		create_autostash(the_repository,
-				 git_path_merge_autostash(the_repository),
-				 "merge");
+				 git_path_merge_autostash(the_repository));
 
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_STRICT);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 82be965915c..3d78b5c8bef 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1657,10 +1657,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (repo_read_index(the_repository) < 0)
 		die(_("could not read index"));
 
-	if (options.autostash) {
-		create_autostash(the_repository, state_dir_path("autostash", &options),
-				 DEFAULT_REFLOG_ACTION);
-	}
+	if (options.autostash)
+		create_autostash(the_repository,
+				 state_dir_path("autostash", &options));
+
 
 	if (require_clean_work_tree(the_repository, "rebase",
 				    _("Please commit or stash them."), 1, 1)) {
diff --git a/sequencer.c b/sequencer.c
index 3d3c3fbe305..78d203dec47 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4094,8 +4094,7 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
-void create_autostash(struct repository *r, const char *path,
-		      const char *default_reflog_action)
+void create_autostash(struct repository *r, const char *path)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
@@ -4132,7 +4131,7 @@ void create_autostash(struct repository *r, const char *path,
 		write_file(path, "%s", oid_to_hex(&oid));
 		printf(_("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
-			       default_reflog_action) < 0)
+			       NULL) < 0)
 			die(_("could not reset --hard"));
 
 		if (discard_index(r->index) < 0 ||
diff --git a/sequencer.h b/sequencer.h
index 05a7d2ba6b3..da64473636b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -197,8 +197,7 @@ void commit_post_rewrite(struct repository *r,
 			 const struct commit *current_head,
 			 const struct object_id *new_head);
 
-void create_autostash(struct repository *r, const char *path,
-		      const char *default_reflog_action);
+void create_autostash(struct repository *r, const char *path);
 int save_autostash(const char *path);
 int apply_autostash(const char *path);
 int apply_autostash_oid(const char *stash_oid);
-- 
gitgitgadget

