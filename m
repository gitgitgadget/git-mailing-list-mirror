Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDB451F404
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeHZNpj (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33518 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeHZNph (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id s12-v6so10019389ljj.0
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UM41TiqC/eBBiaRd0WldTZckTizvRWeLUxdnQPgQ3hY=;
        b=knqJtoY/ZsOyN7QJKzeaKQmgo03pR45auLzTPjQCoAa+JIcFU52kh88p4crfY6rCeW
         VsoISTBdIZIBj+qNmHQGfUIIMjproB4tWX/2GYF0PHnqGxY1Ez0Zy9JdGqBW5OJNEPb4
         WR6B/LbiGh9QBNHchhcxtTDt46s+R3f7rCb3DovMs7tycYsSzNXQ4iDhZ16nsqwF8BIa
         m9eIuxztyDCcHuPMy9Ki0JjK2qXpfNU69zPBE9rW3CnLGyCZn7RredpnmrKrwKQIUGvh
         ex+dxbxpQbXL5KfRGvM2eGrbL4xsliLQCbAKnTTbmiGwx7zUdvoGLbpt08t7Rwn4aLQn
         54FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UM41TiqC/eBBiaRd0WldTZckTizvRWeLUxdnQPgQ3hY=;
        b=LWw/ZF1fmjTWbnlx12MridunWneNhKNhxYH9Ikl2ups7w7id5bY0Vso6DSlw1SrZQz
         ZfkKp6xXSuRwpw6RVfdEUqjenQxaluRJ/g+z52qWerBpRX/cswNSJWvXc1w1Qwpd/GzK
         B8gsPgU8gPinBOsZQdZcMJVTB2szt7k2IYVq872DBKNPo+c32a+K12jckoCJ/wE8wGmX
         ujZ8ngn/V0MDQ3P7bW0ij8z0BPcKq/MfJO7FUsM/7DYVXcG00M4nhA/SlLEqftDcxzSg
         rm0Tcd77mSrOyJoYY2tOhyrdfhqhtVKhJW9TxMV7OVGwCBlz4tzT1vrPQf0O07DnxxZ0
         DZUg==
X-Gm-Message-State: APzg51C7YEQ5CHZdvzjsM+AQIK7bVR5QjXHV5ADYjaQxKA1i3kpym6np
        Mw7uBkrFo/4G2yYw3iijQuFjKFl3
X-Google-Smtp-Source: ANB0VdZKNQQIJKpydwvwFh/vV7jWEDB/aSpAGSOTdwUznX1OJOa14iiDeA8t5iQZW+4neYx99hxZoQ==
X-Received: by 2002:a2e:750d:: with SMTP id q13-v6mr5509053ljc.148.1535277808514;
        Sun, 26 Aug 2018 03:03:28 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:27 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/21] merge.c: remove implicit dependency on the_index
Date:   Sun, 26 Aug 2018 12:03:04 +0200
Message-Id: <20180826100314.5137-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/merge.c |  8 +++++---
 builtin/pull.c  |  7 +++++--
 cache.h         |  6 ++++--
 merge.c         | 20 +++++++++++---------
 sequencer.c     |  6 +++---
 5 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 0a37d5ef2c..a56754db5c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -728,8 +728,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			die(_("unable to write %s"), get_index_file());
 		return clean ? 0 : 1;
 	} else {
-		return try_merge_command(strategy, xopts_nr, xopts,
-						common, head_arg, remoteheads);
+		return try_merge_command(the_repository,
+					 strategy, xopts_nr, xopts,
+					 common, head_arg, remoteheads);
 	}
 }
 
@@ -1470,7 +1471,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			goto done;
 		}
 
-		if (checkout_fast_forward(&head_commit->object.oid,
+		if (checkout_fast_forward(the_repository,
+					  &head_commit->object.oid,
 					  &commit->object.oid,
 					  overwrite_ignore)) {
 			ret = 1;
diff --git a/builtin/pull.c b/builtin/pull.c
index 53bc5facfd..9b2f76f9d9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -562,7 +562,9 @@ static int pull_into_void(const struct object_id *merge_head,
 	 * index/worktree changes that the user already made on the unborn
 	 * branch.
 	 */
-	if (checkout_fast_forward(the_hash_algo->empty_tree, merge_head, 0))
+	if (checkout_fast_forward(the_repository,
+				  the_hash_algo->empty_tree,
+				  merge_head, 0))
 		return 1;
 
 	if (update_ref("initial pull", "HEAD", merge_head, curr_head, 0, UPDATE_REFS_DIE_ON_ERR))
@@ -915,7 +917,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"fast-forwarding your working tree from\n"
 			"commit %s."), oid_to_hex(&orig_head));
 
-		if (checkout_fast_forward(&orig_head, &curr_head, 0))
+		if (checkout_fast_forward(the_repository, &orig_head,
+					  &curr_head, 0))
 			die(_("Cannot fast-forward your working tree.\n"
 				"After making sure that you saved anything precious from\n"
 				"$ git diff %s\n"
diff --git a/cache.h b/cache.h
index 31013ce8af..218edaa198 100644
--- a/cache.h
+++ b/cache.h
@@ -1706,10 +1706,12 @@ extern struct startup_info *startup_info;
 
 /* merge.c */
 struct commit_list;
-int try_merge_command(const char *strategy, size_t xopts_nr,
+int try_merge_command(struct repository *repo,
+		const char *strategy, size_t xopts_nr,
 		const char **xopts, struct commit_list *common,
 		const char *head_arg, struct commit_list *remotes);
-int checkout_fast_forward(const struct object_id *from,
+int checkout_fast_forward(struct repository *repo,
+			  const struct object_id *from,
 			  const struct object_id *to,
 			  int overwrite_ignore);
 
diff --git a/merge.c b/merge.c
index e30e03fb84..3c8c769e50 100644
--- a/merge.c
+++ b/merge.c
@@ -14,7 +14,8 @@ static const char *merge_argument(struct commit *commit)
 	return oid_to_hex(commit ? &commit->object.oid : the_hash_algo->empty_tree);
 }
 
-int try_merge_command(const char *strategy, size_t xopts_nr,
+int try_merge_command(struct repository *repo,
+		      const char *strategy, size_t xopts_nr,
 		      const char **xopts, struct commit_list *common,
 		      const char *head_arg, struct commit_list *remotes)
 {
@@ -35,15 +36,16 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
 	argv_array_clear(&args);
 
-	discard_cache();
-	if (read_cache() < 0)
+	discard_index(repo->index);
+	if (read_index(repo->index) < 0)
 		die(_("failed to read the cache"));
-	resolve_undo_clear();
+	resolve_undo_clear_index(repo->index);
 
 	return ret;
 }
 
-int checkout_fast_forward(const struct object_id *head,
+int checkout_fast_forward(struct repository *repo,
+			  const struct object_id *head,
 			  const struct object_id *remote,
 			  int overwrite_ignore)
 {
@@ -54,7 +56,7 @@ int checkout_fast_forward(const struct object_id *head,
 	struct dir_struct dir;
 	struct lock_file lock_file = LOCK_INIT;
 
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(repo->index, REFRESH_QUIET, NULL, NULL, NULL);
 
 	if (hold_locked_index(&lock_file, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
@@ -86,8 +88,8 @@ int checkout_fast_forward(const struct object_id *head,
 	}
 
 	opts.head_idx = 1;
-	opts.src_index = &the_index;
-	opts.dst_index = &the_index;
+	opts.src_index = repo->index;
+	opts.dst_index = repo->index;
 	opts.update = 1;
 	opts.verbose_update = 1;
 	opts.merge = 1;
@@ -101,7 +103,7 @@ int checkout_fast_forward(const struct object_id *head,
 	}
 	clear_unpack_trees_porcelain(&opts);
 
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (write_locked_index(repo->index, &lock_file, COMMIT_LOCK))
 		return error(_("unable to write new index file"));
 	return 0;
 }
diff --git a/sequencer.c b/sequencer.c
index 65d371c746..83c1f0e42b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -470,8 +470,8 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 
-	read_cache();
-	if (checkout_fast_forward(from, to, 1))
+	read_index(&the_index);
+	if (checkout_fast_forward(the_repository, from, to, 1))
 		return -1; /* the callee should have complained already */
 
 	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
@@ -1798,7 +1798,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res |= try_merge_command(opts->strategy,
+		res |= try_merge_command(the_repository, opts->strategy,
 					 opts->xopts_nr, (const char **)opts->xopts,
 					common, oid_to_hex(&head), remotes);
 		free_commit_list(common);
-- 
2.19.0.rc0.337.ge906d732e7

