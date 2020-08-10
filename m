Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D22FC433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF88F206DA
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="hZ+ssJXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHJVfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHJVfk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:35:40 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A39EC061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:39 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x12so8007583qtp.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x6GQoMBXSvbFGOIPMm6h5bCv2EstWxxEOMbYw9I3O/4=;
        b=hZ+ssJXMtFL5IuV4X0KFOUCtZoCb/MbCTwSmKYVlJh9bYVPa5Y/OrGO4Qgn562wu9O
         BIYzIn7REt4KCgTC0uw4m0kHWJFab/tu/wA+2AXMSWG6oQXOuBfz+pn46i7/yPKieAVh
         tlBPo/khgpiDe8GG6GYA73m3+6gkXc6JlmxpdWaJ3/Ci7Q34y7LSHuAExP68Q5BtIfko
         F+EfK2MieBBuC4dVYjJh99mZ08yxq3IM9rPJuOog3rQcU9jEaAWGPrrUKJ3A3N8tP4N9
         vLSoeQXq0cXq/bBBeSW/h0/UXtFijz6FOnwjN+JUc9jHL6xM86wJZkQwjCgCQXGe4TyS
         u2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6GQoMBXSvbFGOIPMm6h5bCv2EstWxxEOMbYw9I3O/4=;
        b=mm7MqVV2j38cTx8s7qR0TyCkicoJ4IFN7IsmY/L1SGi2feV0qzQJWkrycTuI5vGgQU
         /sssBYxiUnJnAumS1rPlBEy/em3yGLPapEZV03c12NWeQ2+b9iLZU7OtUvLwk7dk33LG
         26ZSG21xhtdrwoj2J7HmXt4oTO/x+nPZmW8Fh3eeYJWzFQmUNul2LJ6EY3o0hL2bYrp1
         wL9CTDMBudRyelv0bJBprd9hrobrn7GEO1XX9d1mq96sem40K+rgi2HMlTfT6fMpBh5u
         Hc5lXp7kQSezZjAeq+oH32gLS0zavLgRrK/fBLmtRDbrwpJWD9nU82jXoc4c+lR84zx1
         iakw==
X-Gm-Message-State: AOAM532mMveIjX+B3vpsJmYOswuaDj8zazIkcdRGwzl1cSPV3EwUvrAc
        IQQSOHAVu8d/5lL5MHXP0uxge1OHnQs=
X-Google-Smtp-Source: ABdhPJwFOPm844bt5X7x41QY2xCoKpOfUle9RbuKEe8fmliC0retMpIIus4UJT6XEG/s2frXI3BuhA==
X-Received: by 2002:ac8:6901:: with SMTP id e1mr29594501qtr.352.1597095338218;
        Mon, 10 Aug 2020 14:35:38 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:35:37 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 17/21] parallel-checkout: avoid stat() calls in workers
Date:   Mon, 10 Aug 2020 18:33:25 -0300
Message-Id: <79de52b6952441e77d7276243b4b2ebe7ca16a1f.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current parallel checkout implementation requires the workers to
stat() the path components of each entry before writing, to make sure
they are all real directories and not symlinks or something else. The
stat() info is cached, so this procedure should not be so bad
performance-wise. But the exact same check is already done by the main
process, before enqueueing the entries for parallel checkout, to remove
files that were in the way and create the leading dirs. The reason we
still need the second check is that, in case of path collisions, a
symlink X could be created after an entry x/f was enqueued, leading the
parallel worker to wrongly create the file at X/f. If we postpone the
symlinks' checkouts, though, we can avoid the need of these stat() calls
in the workers. Other types of path collisions are still possible, such
as a regular file X being written before the worker tries to write x/f.
But that's OK, since the parallel checkout machinery will check the
return of open() to detect such collisions (which would not be possible
for the symlink case, as open() would succeed).

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c             | 10 +++++++
 parallel-checkout.c | 71 ++++++++++++++++++++++++++++-----------------
 parallel-checkout.h |  8 +++++
 unpack-trees.c      |  4 ++-
 4 files changed, 65 insertions(+), 28 deletions(-)

diff --git a/entry.c b/entry.c
index b6c808dffa..6208df23df 100644
--- a/entry.c
+++ b/entry.c
@@ -477,6 +477,16 @@ int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
 		return write_entry(ce, topath, ca, state, 1);
 	}
 
+	/*
+	 * If a regular file x/f is queued for parallel checkout and a symlink
+	 * X is created now, the worker could wrongly create the file at X/f
+	 * due to path collision. Thus, symlinks are only created after
+	 * parallel-eligible entries.
+	 */
+	if (parallel_checkout_status() == PC_ACCEPTING_ENTRIES &&
+	    S_ISLNK(ce->ce_mode))
+		enqueue_symlink_checkout(ce, nr_checkouts);
+
 	strbuf_reset(&path);
 	strbuf_add(&path, state->base_dir, state->base_dir_len);
 	strbuf_add(&path, ce->name, ce_namelen(ce));
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 78bf2de5ea..fee93460c1 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -140,6 +140,44 @@ static void advance_progress_meter(void)
 	}
 }
 
+struct symlink_checkout_item {
+	struct cache_entry *ce;
+	int *nr_checkouts;
+};
+
+static struct symlink_checkout_item *symlink_queue = NULL;
+static size_t symlink_queue_nr = 0, symlink_queue_alloc = 0;
+
+void enqueue_symlink_checkout(struct cache_entry *ce, int *nr_checkouts)
+{
+	assert(S_ISLNK(ce->ce_mode));
+	ALLOC_GROW(symlink_queue, symlink_queue_nr + 1, symlink_queue_alloc);
+	symlink_queue[symlink_queue_nr].ce = ce;
+	symlink_queue[symlink_queue_nr].nr_checkouts = nr_checkouts;
+	symlink_queue_nr++;
+}
+
+size_t symlink_queue_size(void)
+{
+	return symlink_queue_nr;
+}
+
+static int checkout_symlink_queue(struct checkout *state)
+{
+	size_t i;
+	int ret = 0;
+
+	for (i = 0; i < symlink_queue_nr; ++i) {
+		struct symlink_checkout_item *sci = &symlink_queue[i];
+		ret |= checkout_entry(sci->ce, state, NULL, sci->nr_checkouts);
+		advance_progress_meter();
+	}
+
+	FREE_AND_NULL(symlink_queue);
+	symlink_queue_nr = symlink_queue_alloc = 0;
+	return ret;
+}
+
 static int handle_results(struct checkout *state)
 {
 	int ret = 0;
@@ -257,16 +295,6 @@ static int close_and_clear(int *fd)
 	return ret;
 }
 
-static int check_leading_dirs(const char *path, int len, int prefix_len)
-{
-	const char *slash = path + len;
-
-	while (slash > path && *slash != '/')
-		slash--;
-
-	return has_dirs_only_path(path, slash - path, prefix_len);
-}
-
 void write_checkout_item(struct checkout *state, struct checkout_item *ci)
 {
 	unsigned int mode = (ci->ce->ce_mode & 0100) ? 0777 : 0666;
@@ -276,27 +304,15 @@ void write_checkout_item(struct checkout *state, struct checkout_item *ci)
 	strbuf_add(&path, state->base_dir, state->base_dir_len);
 	strbuf_add(&path, ci->ce->name, ci->ce->ce_namelen);
 
-	/*
-	 * At this point, leading dirs should have already been created. But if
-	 * a symlink being checked out has collided with one of the dirs, due to
-	 * file system folding rules, it's possible that the dirs are no longer
-	 * present. So we have to check again, and report any path collisions.
-	 */
-	if (!check_leading_dirs(path.buf, path.len, state->base_dir_len)) {
-		ci->status = CI_RETRY;
-		goto out;
-	}
-
 	fd = open(path.buf, O_WRONLY | O_CREAT | O_EXCL, mode);
 
 	if (fd < 0) {
-		if (errno == EEXIST || errno == EISDIR) {
+		if (errno == EEXIST || errno == EISDIR || errno == ENOENT ||
+		    errno == ENOTDIR) {
 			/*
 			 * Errors which probably represent a path collision.
 			 * Suppress the error message and mark the ci to be
-			 * retried later, sequentially. ENOTDIR and ENOENT are
-			 * also interesting, but check_leading_dirs() should
-			 * have already caught these cases.
+			 * retried later, sequentially.
 			 */
 			ci->status = CI_RETRY;
 		} else {
@@ -523,7 +539,7 @@ static int run_checkout_sequentially(struct checkout *state)
 		if (ci->status != CI_RETRY)
 			advance_progress_meter();
 	}
-	return handle_results(state);
+	return handle_results(state) | checkout_symlink_queue(state);
 }
 
 int run_parallel_checkout(struct checkout *state, int num_workers, int threshold,
@@ -553,7 +569,8 @@ int run_parallel_checkout(struct checkout *state, int num_workers, int threshold
 	workers = setup_workers(state, num_workers);
 	gather_results_from_workers(workers, num_workers);
 	finish_workers(workers, num_workers);
-	ret = handle_results(state);
+	ret |= handle_results(state);
+	ret |= checkout_symlink_queue(state);
 
 done:
 	finish_parallel_checkout();
diff --git a/parallel-checkout.h b/parallel-checkout.h
index 2b81a5db6c..a4f7e5b7bd 100644
--- a/parallel-checkout.h
+++ b/parallel-checkout.h
@@ -29,6 +29,14 @@ void get_parallel_checkout_configs(int *num_workers, int *threshold);
 int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca);
 size_t pc_queue_size(void);
 
+/*
+ * Enqueues a symlink to be checked out *sequentially* after the parallel
+ * checkout finishes. This is done to avoid path collisions with leading dirs,
+ * which could make parallel workers write a file to the wrong place.
+ */
+void enqueue_symlink_checkout(struct cache_entry *ce, int *nr_checkouts);
+size_t symlink_queue_size(void);
+
 /*
  * Write all the queued entries, returning 0 on success. If the number of
  * entries is below the specified threshold, the operation is performed
diff --git a/unpack-trees.c b/unpack-trees.c
index dcb40dc8fa..01928d3d65 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -472,6 +472,7 @@ static int check_updates(struct unpack_trees_options *o,
 
 		if (ce->ce_flags & CE_UPDATE) {
 			size_t last_pc_queue_size = pc_queue_size();
+			size_t last_symlink_queue_size = symlink_queue_size();
 
 			if (ce->ce_flags & CE_WT_REMOVE)
 				BUG("both update and delete flags are set on %s",
@@ -479,7 +480,8 @@ static int check_updates(struct unpack_trees_options *o,
 			ce->ce_flags &= ~CE_UPDATE;
 			errs |= checkout_entry(ce, &state, NULL, NULL);
 
-			if (last_pc_queue_size == pc_queue_size())
+			if (last_pc_queue_size == pc_queue_size() &&
+			    last_symlink_queue_size == symlink_queue_size())
 				display_progress(progress, ++cnt);
 		}
 	}
-- 
2.27.0

