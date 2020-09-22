Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894F7C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6092071A
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="SD9fu47s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgIVWvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIVWvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:51:04 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8847FC061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:04 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v54so17048487qtj.7
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Knst5igmk+hv7j4VT1wucLKj+2gCA6o9aneFlhHiWT4=;
        b=SD9fu47svj/MPBW5HZ0YTSrZkOJNfqWTdnMVdUpwL8FolAbGZx567PR3MPi+5qe8wG
         j1TSbGNIw57R/biwhV9lK17iEgwF5tsGiyHzgwFPlrIxN201BPd7/OI81aeGEF+7d/tU
         da3f5oEPqaSO+Y93NLq4vzhBp0CEBiIykxVaKD5Jyk8wJ6Uefc7BxeHJWUHDB/hXPLz3
         BEHGbq894QAt1Wz+dlBe9Q70+fsnHk6hzsZf6/A9eaRA+B8rHCxs/d6mkG6poNdFtEca
         m837EYn+bhQtZKJxyWrFz8iuwwgssrHwaoFY/UrLC+1asJoomqkHn2aFIkCmTI//ums5
         oYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Knst5igmk+hv7j4VT1wucLKj+2gCA6o9aneFlhHiWT4=;
        b=cSY9AJNCQSLKmlkCNP/YCj3yTzL1LP+Cg2VrVV6y6ifZeI5ru7Yq40iRvDLQxG3Jmz
         s2g8N5sRF0LZLcYrW1Jvs2Z5JAixpU1keQxxuHq3/ObW/0GksTcKhut+MzhsBe8Aenz2
         RFRJpzlAJ5nWnP80qx7uEDrizRfobQd7mQDhIAuj056XuL5hn/kVv3iJgad7OSGjUnLB
         z28rzeJUPauqB1YKpvURs3vMNWyIXfCr1Wd2uBP0hjKKSXl97rm3bbycFOHy46+4lSHh
         kWcqULADpnOW+QQFx7H2d4889jWHVbfTkUevrbyRUvwrhmnnW8H+lYfJawi4xkY+O08x
         nt8g==
X-Gm-Message-State: AOAM530AVFP4Jnzzw9EosshBMbDRmLCFjfRh2+jghk+pPozR+OpUNugc
        FGjGnKZ/g/091yUz+YO+X5vWNrOV73SYcQ==
X-Google-Smtp-Source: ABdhPJzLbBiNtzDxvVRBsX6KF3bnwWh19Fc0JIysEeuHvKBw2u4at5Oz9+0HRqhZxXjvwhYz+o/jow==
X-Received: by 2002:ac8:5517:: with SMTP id j23mr7205483qtq.47.1600815062879;
        Tue, 22 Sep 2020 15:51:02 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:51:02 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 10/19] unpack-trees: add basic support for parallel checkout
Date:   Tue, 22 Sep 2020 19:49:24 -0300
Message-Id: <af0d790973b1e52da0fc9c4bed95e93d995d68da.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new interface allows us to enqueue some of the entries being
checked out to later call write_entry() for them in parallel. For now,
the parallel checkout machinery is enabled by default and there is no
user configuration, but run_parallel_checkout() just writes the queued
entries in sequence (without spawning additional workers). The next
patch will actually implement the parallelism and, later, we will make
it configurable.

When there are path collisions among the entries being written (which
can happen e.g. with case-sensitive files in case-insensitive file
systems), the parallel checkout code detects the problem and marks the
item with PC_ITEM_COLLIDED. Later, these items are sequentially fed to
checkout_entry() again. This is similar to the way the sequential code
deals with collisions, overwriting the previously checked out entries
with the subsequent ones. The only difference is that, when we start
writing the entries in parallel, we won't be able to determine which of
the colliding entries will survive on disk (for the sequential
algorithm, it is always the last one).

I also experimented with the idea of not overwriting colliding entries,
and it seemed to work well in my simple tests. However, because just one
entry of each colliding group would be actually written, the others
would have null lstat() fields on the index. This might not be a problem
by itself, but it could cause performance penalties for subsequent
commands that need to refresh the index: when the st_size value cached
is 0, read-cache.c:ie_modified() will go to the filesystem to see if the
contents match. As mentioned in the function:

    * Immediately after read-tree or update-index --cacheinfo,
    * the length field is zero, as we have never even read the
    * lstat(2) information once, and we cannot trust DATA_CHANGED
    * returned by ie_match_stat() which in turn was returned by
    * ce_match_stat_basic() to signal that the filesize of the
    * blob changed.  We have to actually go to the filesystem to
    * see if the contents match, and if so, should answer "unchanged".

So, if we have N entries in a colliding group and we decide to write and
lstat() only one of them, every subsequent git-status will have to read,
convert, and hash the written file N - 1 times, to check that the N - 1
unwritten entries are dirty. By checking out all colliding entries (like
the sequential code does), we only pay the overhead once.

Co-authored-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Note: currently, we have to check leading directories again before
writing each parallel-eligible entry, as explained in the respective
code comment. But I plan to remove this extra work on part II,
postponing the checkout of symlinks to *after* the parallel-eligible
entries.

 Makefile            |   1 +
 entry.c             |  17 +-
 parallel-checkout.c | 368 ++++++++++++++++++++++++++++++++++++++++++++
 parallel-checkout.h |  27 ++++
 unpack-trees.c      |   6 +-
 5 files changed, 416 insertions(+), 3 deletions(-)
 create mode 100644 parallel-checkout.c
 create mode 100644 parallel-checkout.h

diff --git a/Makefile b/Makefile
index f1b1bc8aa0..3edcdc534c 100644
--- a/Makefile
+++ b/Makefile
@@ -932,6 +932,7 @@ LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
 LIB_OBJS += packfile.o
 LIB_OBJS += pager.o
+LIB_OBJS += parallel-checkout.o
 LIB_OBJS += parse-options-cb.o
 LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
diff --git a/entry.c b/entry.c
index 9d79a5671f..6676954431 100644
--- a/entry.c
+++ b/entry.c
@@ -7,6 +7,7 @@
 #include "progress.h"
 #include "fsmonitor.h"
 #include "entry.h"
+#include "parallel-checkout.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -426,8 +427,17 @@ static void mark_colliding_entries(const struct checkout *state,
 	for (i = 0; i < state->istate->cache_nr; i++) {
 		struct cache_entry *dup = state->istate->cache[i];
 
-		if (dup == ce)
-			break;
+		if (dup == ce) {
+			/*
+			 * Parallel checkout creates the files in no particular
+			 * order. So the other side of the collision may appear
+			 * after the given cache_entry in the array.
+			 */
+			if (parallel_checkout_status() == PC_RUNNING)
+				continue;
+			else
+				break;
+		}
 
 		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
 			continue;
@@ -536,6 +546,9 @@ int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
 		ca = &ca_buf;
 	}
 
+	if (!enqueue_checkout(ce, ca))
+		return 0;
+
 	return write_entry(ce, path.buf, ca, state, 0);
 }
 
diff --git a/parallel-checkout.c b/parallel-checkout.c
new file mode 100644
index 0000000000..7dc8ab2a67
--- /dev/null
+++ b/parallel-checkout.c
@@ -0,0 +1,368 @@
+#include "cache.h"
+#include "entry.h"
+#include "parallel-checkout.h"
+#include "streaming.h"
+
+enum pc_item_status {
+	PC_ITEM_PENDING = 0,
+	PC_ITEM_WRITTEN,
+	/*
+	 * The entry could not be written because there was another file
+	 * already present in its path or leading directories. Since
+	 * checkout_entry_ca() removes such files from the working tree before
+	 * enqueueing the entry for parallel checkout, it means that there was
+	 * a path collision among the entries being written.
+	 */
+	PC_ITEM_COLLIDED,
+	PC_ITEM_FAILED,
+};
+
+struct parallel_checkout_item {
+	/* pointer to a istate->cache[] entry. Not owned by us. */
+	struct cache_entry *ce;
+	struct conv_attrs ca;
+	struct stat st;
+	enum pc_item_status status;
+};
+
+struct parallel_checkout {
+	enum pc_status status;
+	struct parallel_checkout_item *items;
+	size_t nr, alloc;
+};
+
+static struct parallel_checkout parallel_checkout = { 0 };
+
+enum pc_status parallel_checkout_status(void)
+{
+	return parallel_checkout.status;
+}
+
+void init_parallel_checkout(void)
+{
+	if (parallel_checkout.status != PC_UNINITIALIZED)
+		BUG("parallel checkout already initialized");
+
+	parallel_checkout.status = PC_ACCEPTING_ENTRIES;
+}
+
+static void finish_parallel_checkout(void)
+{
+	if (parallel_checkout.status == PC_UNINITIALIZED)
+		BUG("cannot finish parallel checkout: not initialized yet");
+
+	free(parallel_checkout.items);
+	memset(&parallel_checkout, 0, sizeof(parallel_checkout));
+}
+
+static int is_eligible_for_parallel_checkout(const struct cache_entry *ce,
+					     const struct conv_attrs *ca)
+{
+	enum conv_attrs_classification c;
+
+	if (!S_ISREG(ce->ce_mode))
+		return 0;
+
+	c = classify_conv_attrs(ca);
+	switch (c) {
+	case CA_CLASS_INCORE:
+		return 1;
+
+	case CA_CLASS_INCORE_FILTER:
+		/*
+		 * It would be safe to allow concurrent instances of
+		 * single-file smudge filters, like rot13, but we should not
+		 * assume that all filters are parallel-process safe. So we
+		 * don't allow this.
+		 */
+		return 0;
+
+	case CA_CLASS_INCORE_PROCESS:
+		/*
+		 * The parallel queue and the delayed queue are not compatible,
+		 * so they must be kept completely separated. And we can't tell
+		 * if a long-running process will delay its response without
+		 * actually asking it to perform the filtering. Therefore, this
+		 * type of filter is not allowed in parallel checkout.
+		 *
+		 * Furthermore, there should only be one instance of the
+		 * long-running process filter as we don't know how it is
+		 * managing its own concurrency. So, spreading the entries that
+		 * requisite such a filter among the parallel workers would
+		 * require a lot more inter-process communication. We would
+		 * probably have to designate a single process to interact with
+		 * the filter and send all the necessary data to it, for each
+		 * entry.
+		 */
+		return 0;
+
+	case CA_CLASS_STREAMABLE:
+		return 1;
+
+	default:
+		BUG("unsupported conv_attrs classification '%d'", c);
+	}
+}
+
+int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca)
+{
+	struct parallel_checkout_item *pc_item;
+
+	if (parallel_checkout.status != PC_ACCEPTING_ENTRIES ||
+	    !is_eligible_for_parallel_checkout(ce, ca))
+		return -1;
+
+	ALLOC_GROW(parallel_checkout.items, parallel_checkout.nr + 1,
+		   parallel_checkout.alloc);
+
+	pc_item = &parallel_checkout.items[parallel_checkout.nr++];
+	pc_item->ce = ce;
+	memcpy(&pc_item->ca, ca, sizeof(pc_item->ca));
+	pc_item->status = PC_ITEM_PENDING;
+
+	return 0;
+}
+
+static int handle_results(struct checkout *state)
+{
+	int ret = 0;
+	size_t i;
+	int have_pending = 0;
+
+	/*
+	 * We first update the successfully written entries with the collected
+	 * stat() data, so that they can be found by mark_colliding_entries(),
+	 * in the next loop, when necessary.
+	 */
+	for (i = 0; i < parallel_checkout.nr; ++i) {
+		struct parallel_checkout_item *pc_item = &parallel_checkout.items[i];
+		if (pc_item->status == PC_ITEM_WRITTEN)
+			update_ce_after_write(state, pc_item->ce, &pc_item->st);
+	}
+
+	for (i = 0; i < parallel_checkout.nr; ++i) {
+		struct parallel_checkout_item *pc_item = &parallel_checkout.items[i];
+
+		switch(pc_item->status) {
+		case PC_ITEM_WRITTEN:
+			/* Already handled */
+			break;
+		case PC_ITEM_COLLIDED:
+			/*
+			 * The entry could not be checked out due to a path
+			 * collision with another entry. Since there can only
+			 * be one entry of each colliding group on the disk, we
+			 * could skip trying to check out this one and move on.
+			 * However, this would leave the unwritten entries with
+			 * null stat() fields on the index, which could
+			 * potentially slow down subsequent operations that
+			 * require refreshing it: git would not be able to
+			 * trust st_size and would have to go to the filesystem
+			 * to see if the contents match (see ie_modified()).
+			 *
+			 * Instead, let's pay the overhead only once, now, and
+			 * call checkout_entry_ca() again for this file, to
+			 * have it's stat() data stored in the index. This also
+			 * has the benefit of adding this entry and its
+			 * colliding pair to the collision report message.
+			 * Additionally, this overwriting behavior is consistent
+			 * with what the sequential checkout does, so it doesn't
+			 * add any extra overhead.
+			 */
+			ret |= checkout_entry_ca(pc_item->ce, &pc_item->ca,
+						 state, NULL, NULL);
+			break;
+		case PC_ITEM_PENDING:
+			have_pending = 1;
+			/* fall through */
+		case PC_ITEM_FAILED:
+			ret = -1;
+			break;
+		default:
+			BUG("unknown checkout item status in parallel checkout");
+		}
+	}
+
+	if (have_pending)
+		error(_("parallel checkout finished with pending entries"));
+
+	return ret;
+}
+
+static int reset_fd(int fd, const char *path)
+{
+	if (lseek(fd, 0, SEEK_SET) != 0)
+		return error_errno("failed to rewind descriptor of %s", path);
+	if (ftruncate(fd, 0))
+		return error_errno("failed to truncate file %s", path);
+	return 0;
+}
+
+static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
+			       const char *path, struct checkout *state)
+{
+	int ret;
+	struct stream_filter *filter;
+	struct strbuf buf = STRBUF_INIT;
+	char *new_blob;
+	unsigned long size;
+	size_t newsize = 0;
+	ssize_t wrote;
+
+	/* Sanity check */
+	assert(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
+
+	filter = get_stream_filter_ca(&pc_item->ca, &pc_item->ce->oid);
+	if (filter) {
+		if (stream_blob_to_fd(fd, &pc_item->ce->oid, filter, 1)) {
+			/* On error, reset fd to try writing without streaming */
+			if (reset_fd(fd, path))
+				return -1;
+		} else {
+			return 0;
+		}
+	}
+
+	new_blob = read_blob_entry(pc_item->ce, &size);
+	if (!new_blob)
+		return error("unable to read sha1 file of %s (%s)", path,
+			     oid_to_hex(&pc_item->ce->oid));
+
+	/*
+	 * checkout metadata is used to give context for external process
+	 * filters. Files requiring such filters are not eligible for parallel
+	 * checkout, so pass NULL.
+	 */
+	ret = convert_to_working_tree_ca(&pc_item->ca, pc_item->ce->name,
+					 new_blob, size, &buf, NULL);
+
+	if (ret) {
+		free(new_blob);
+		new_blob = strbuf_detach(&buf, &newsize);
+		size = newsize;
+	}
+
+	wrote = write_in_full(fd, new_blob, size);
+	free(new_blob);
+	if (wrote < 0)
+		return error("unable to write file %s", path);
+
+	return 0;
+}
+
+static int close_and_clear(int *fd)
+{
+	int ret = 0;
+
+	if (*fd >= 0) {
+		ret = close(*fd);
+		*fd = -1;
+	}
+
+	return ret;
+}
+
+static int check_leading_dirs(const char *path, int len, int prefix_len)
+{
+	const char *slash = path + len;
+
+	while (slash > path && *slash != '/')
+		slash--;
+
+	return has_dirs_only_path(path, slash - path, prefix_len);
+}
+
+static void write_pc_item(struct parallel_checkout_item *pc_item,
+			  struct checkout *state)
+{
+	unsigned int mode = (pc_item->ce->ce_mode & 0100) ? 0777 : 0666;
+	int fd = -1, fstat_done = 0;
+	struct strbuf path = STRBUF_INIT;
+
+	strbuf_add(&path, state->base_dir, state->base_dir_len);
+	strbuf_add(&path, pc_item->ce->name, pc_item->ce->ce_namelen);
+
+	/*
+	 * At this point, leading dirs should have already been created. But if
+	 * a symlink being checked out has collided with one of the dirs, due to
+	 * file system folding rules, it's possible that the dirs are no longer
+	 * present. So we have to check again, and report any path collisions.
+	 */
+	if (!check_leading_dirs(path.buf, path.len, state->base_dir_len)) {
+		pc_item->status = PC_ITEM_COLLIDED;
+		goto out;
+	}
+
+	fd = open(path.buf, O_WRONLY | O_CREAT | O_EXCL, mode);
+
+	if (fd < 0) {
+		if (errno == EEXIST || errno == EISDIR) {
+			/*
+			 * Errors which probably represent a path collision.
+			 * Suppress the error message and mark the item to be
+			 * retried later, sequentially. ENOTDIR and ENOENT are
+			 * also interesting, but check_leading_dirs() should
+			 * have already caught these cases.
+			 */
+			pc_item->status = PC_ITEM_COLLIDED;
+		} else {
+			error_errno("failed to open file %s", path.buf);
+			pc_item->status = PC_ITEM_FAILED;
+		}
+		goto out;
+	}
+
+	if (write_pc_item_to_fd(pc_item, fd, path.buf, state)) {
+		/* Error was already reported. */
+		pc_item->status = PC_ITEM_FAILED;
+		goto out;
+	}
+
+	fstat_done = fstat_checkout_output(fd, state, &pc_item->st);
+
+	if (close_and_clear(&fd)) {
+		error_errno("unable to close file %s", path.buf);
+		pc_item->status = PC_ITEM_FAILED;
+		goto out;
+	}
+
+	if (state->refresh_cache && !fstat_done && lstat(path.buf, &pc_item->st) < 0) {
+		error_errno("unable to stat just-written file %s",  path.buf);
+		pc_item->status = PC_ITEM_FAILED;
+		goto out;
+	}
+
+	pc_item->status = PC_ITEM_WRITTEN;
+
+out:
+	/*
+	 * No need to check close() return. At this point, either fd is already
+	 * closed, or we are on an error path, that has already been reported.
+	 */
+	close_and_clear(&fd);
+	strbuf_release(&path);
+}
+
+static void write_items_sequentially(struct checkout *state)
+{
+	size_t i;
+
+	for (i = 0; i < parallel_checkout.nr; ++i)
+		write_pc_item(&parallel_checkout.items[i], state);
+}
+
+int run_parallel_checkout(struct checkout *state)
+{
+	int ret;
+
+	if (parallel_checkout.status != PC_ACCEPTING_ENTRIES)
+		BUG("cannot run parallel checkout: uninitialized or already running");
+
+	parallel_checkout.status = PC_RUNNING;
+
+	write_items_sequentially(state);
+	ret = handle_results(state);
+
+	finish_parallel_checkout();
+	return ret;
+}
diff --git a/parallel-checkout.h b/parallel-checkout.h
new file mode 100644
index 0000000000..e6d6fc01ea
--- /dev/null
+++ b/parallel-checkout.h
@@ -0,0 +1,27 @@
+#ifndef PARALLEL_CHECKOUT_H
+#define PARALLEL_CHECKOUT_H
+
+struct cache_entry;
+struct checkout;
+struct conv_attrs;
+
+enum pc_status {
+	PC_UNINITIALIZED = 0,
+	PC_ACCEPTING_ENTRIES,
+	PC_RUNNING,
+};
+
+enum pc_status parallel_checkout_status(void);
+void init_parallel_checkout(void);
+
+/*
+ * Return -1 if parallel checkout is currently not enabled or if the entry is
+ * not eligible for parallel checkout. Otherwise, enqueue the entry for later
+ * write and return 0.
+ */
+int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca);
+
+/* Write all the queued entries, returning 0 on success.*/
+int run_parallel_checkout(struct checkout *state);
+
+#endif /* PARALLEL_CHECKOUT_H */
diff --git a/unpack-trees.c b/unpack-trees.c
index a511fadd89..1b1da7485a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -17,6 +17,7 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 #include "entry.h"
+#include "parallel-checkout.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -438,7 +439,6 @@ static int check_updates(struct unpack_trees_options *o,
 	if (should_update_submodules())
 		load_gitmodules_file(index, &state);
 
-	enable_delayed_checkout(&state);
 	if (has_promisor_remote()) {
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
@@ -461,6 +461,9 @@ static int check_updates(struct unpack_trees_options *o,
 					   to_fetch.oid, to_fetch.nr);
 		oid_array_clear(&to_fetch);
 	}
+
+	enable_delayed_checkout(&state);
+	init_parallel_checkout();
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -474,6 +477,7 @@ static int check_updates(struct unpack_trees_options *o,
 		}
 	}
 	stop_progress(&progress);
+	errs |= run_parallel_checkout(&state);
 	errs |= finish_delayed_checkout(&state, NULL);
 	git_attr_set_direction(GIT_ATTR_CHECKIN);
 
-- 
2.28.0

