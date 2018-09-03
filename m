Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 119711F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeICWbs (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:48 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:36730 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbeICWbr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:47 -0400
Received: by mail-lj1-f179.google.com with SMTP id v26-v6so1090497ljj.3
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukx4MKfYMa0IFuAjq3DM0kqCfdEmiy35WcU8i5x4gak=;
        b=mDT2eedo1GX349pEvKjnXuMTa/Iuvz09J5599pBj9+mmLLGcaWBXmUcVv+mR91uS8g
         T4cpQJOH8XpNIsh5pDK9bEgPZzir3DmTYC54XJWg2sebZN9YmRW2QQP9vihQyHXCR4b+
         El52AcJHL24hKVz55eIfLH1fP8cuj8ppW02RDFM5Nmr0mtqJKbJr51Rjfq8clqjCIIh/
         ROq1wrHt6bbZXyhXgwgkZN3fUiqoJ2xbgpGXVu/42GkRgvjyPT9lMuEnrrKBDZ1+uHzx
         26mScjMN5zfZ8Bpk91/7TM9PZVs0hxS76HeL6tC3Q8r553l+E+mVF3HOydMRyo5MPgzF
         SFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukx4MKfYMa0IFuAjq3DM0kqCfdEmiy35WcU8i5x4gak=;
        b=jljLSia8LzLHfzYPRtAmvs1JA020We7l0zOD2p9gmNa0PIJyxpj1H9RlJ9dC4qjABA
         p3bFsSJsAEuF/bO3gM0YAVVFt3chZCXmBjlkqtX2guImKVtvQrm0u1KLi56i1Wg2nkBx
         S1MSAcAq/T7JGPbuw8V2s2Ra9M1OKJlW68oJdqWE9VNNJr0ElhwxurwR1v+9RV6eLsWu
         /S0FczlSShxSqOcETrO7JUvAEuH96YlCSE6ZW2KePTnHyCsOTum1lZzh84gsyaUTi3re
         aifSMAXFeDwgKr5XVe8Qg5DNYB+JBEDvussV0qrsdyRhmZUifKo3e5CsLXdpJuA4Vz24
         MrwQ==
X-Gm-Message-State: APzg51CrMhh+XoTvLAdSAzEdmpqjsmrHBoxrwTCuDzhvpfKRzFQ4uD01
        lvWA8asLBwQ4U4SNGo5BDzaHbLc0
X-Google-Smtp-Source: ANB0Vdb+WAQqS2rHIBnkreEtyCer9XSY148QF/GowqjlyaSa/q54Gr2BnEmIGxbruDrQ69rcf+Bq+Q==
X-Received: by 2002:a2e:87cf:: with SMTP id v15-v6mr17637514ljj.13.1535998226394;
        Mon, 03 Sep 2018 11:10:26 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:25 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 13/24] merge.c: remove implicit dependency on the_index
Date:   Mon,  3 Sep 2018 20:09:21 +0200
Message-Id: <20180903180932.32260-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
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
index 681c127a07..33b7100837 100644
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
index 260e4ee44a..49fe83331c 100644
--- a/cache.h
+++ b/cache.h
@@ -1716,10 +1716,12 @@ extern struct startup_info *startup_info;
 
 /* merge.c */
 struct commit_list;
-int try_merge_command(const char *strategy, size_t xopts_nr,
+int try_merge_command(struct repository *r,
+		const char *strategy, size_t xopts_nr,
 		const char **xopts, struct commit_list *common,
 		const char *head_arg, struct commit_list *remotes);
-int checkout_fast_forward(const struct object_id *from,
+int checkout_fast_forward(struct repository *r,
+			  const struct object_id *from,
 			  const struct object_id *to,
 			  int overwrite_ignore);
 
diff --git a/merge.c b/merge.c
index e30e03fb84..91008f7602 100644
--- a/merge.c
+++ b/merge.c
@@ -14,7 +14,8 @@ static const char *merge_argument(struct commit *commit)
 	return oid_to_hex(commit ? &commit->object.oid : the_hash_algo->empty_tree);
 }
 
-int try_merge_command(const char *strategy, size_t xopts_nr,
+int try_merge_command(struct repository *r,
+		      const char *strategy, size_t xopts_nr,
 		      const char **xopts, struct commit_list *common,
 		      const char *head_arg, struct commit_list *remotes)
 {
@@ -35,15 +36,16 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
 	argv_array_clear(&args);
 
-	discard_cache();
-	if (read_cache() < 0)
+	discard_index(r->index);
+	if (read_index(r->index) < 0)
 		die(_("failed to read the cache"));
-	resolve_undo_clear();
+	resolve_undo_clear_index(r->index);
 
 	return ret;
 }
 
-int checkout_fast_forward(const struct object_id *head,
+int checkout_fast_forward(struct repository *r,
+			  const struct object_id *head,
 			  const struct object_id *remote,
 			  int overwrite_ignore)
 {
@@ -54,7 +56,7 @@ int checkout_fast_forward(const struct object_id *head,
 	struct dir_struct dir;
 	struct lock_file lock_file = LOCK_INIT;
 
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
 
 	if (hold_locked_index(&lock_file, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
@@ -86,8 +88,8 @@ int checkout_fast_forward(const struct object_id *head,
 	}
 
 	opts.head_idx = 1;
-	opts.src_index = &the_index;
-	opts.dst_index = &the_index;
+	opts.src_index = r->index;
+	opts.dst_index = r->index;
 	opts.update = 1;
 	opts.verbose_update = 1;
 	opts.merge = 1;
@@ -101,7 +103,7 @@ int checkout_fast_forward(const struct object_id *head,
 	}
 	clear_unpack_trees_porcelain(&opts);
 
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
 		return error(_("unable to write new index file"));
 	return 0;
 }
diff --git a/sequencer.c b/sequencer.c
index 84bf598c3e..47d0e7b0bd 100644
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

