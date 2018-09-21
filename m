Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224D91F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390616AbeIUVrd (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:47:33 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:44205 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390577AbeIUVrd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:47:33 -0400
Received: by mail-lf1-f50.google.com with SMTP id g24-v6so11862794lfb.11
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxys4FXyLHILA5IhU21VxggMeZUY9vNzWoCtLCopIb8=;
        b=e9bx8x30+BMOb11z5s8vX/lBS/cRmEpQ1wJnVmT0QMzeS5Me4guEqVRahV8zFDAfBX
         EW66pGCA9SAij6+NMBZbUdsbNQAaY/oElOP9RjL9rvHvyH4bOF5VwRP5xePq2tgnaoLq
         ah9U9nJwUz43Cbm9yrmtOXG1O3YX22GcyaTGOuvu73BgNUpl8ZAaZZxvCCVIn6dicj7n
         KRZYI8ByBo1d0bcqjE4ezG6mSZsNpePAMtv6jhwOUHy7yt8xhmvCiLhL3SDixKHR7IQW
         z5KFVDVt4PyCbYWuEcXICyLpLvg26rypcDYaQBow3qgCDy9fgiuyI20GDx9qZTbgaeZa
         /4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxys4FXyLHILA5IhU21VxggMeZUY9vNzWoCtLCopIb8=;
        b=Xfg7VDZ9NDwjby88SOCkk2TJ2uXbrpmqOXiRQhxFCW/lFRcZc4p85KZKfRpuy1o8uj
         xIm0w4WXCsUjMtH1dRgPzgsaolsvMUCrZexpofoxVTOzDC2mojXNXDG+P7SrzTyylkcx
         q8tBHCtYLnZZ1Pm7PrROYmh6tJihBuDoKk7QAEW4vL0qOrDnUV2vqT3Deo20cnoTQJat
         9Wg/lKdY0ATklm5KY4GutMOZucZcZFLbfsxkXOCYhZVE2k+2pmPtCawW/7rvYT18TeW8
         QMSVdzqh+6Txs5mTDgqDNz5U8hkMG59cr9OVntwo0Kv12dpb9xV9fH/phw95VzwuYhG0
         QCVQ==
X-Gm-Message-State: APzg51DozytzJZgWRsaVnnnDm3kZ60De/tvY1Ry1rRElAnNzBbS6ciEz
        nZWFZ9QpelSy135ltuYJvsU=
X-Google-Smtp-Source: ANB0VdYKKh6JBALbSwNsGMOHrSyJTa3bNNrmg2AJCcFmzSMy+XV4UwjWUkqNWTc0yJMunBJLPlZkkA==
X-Received: by 2002:a19:c513:: with SMTP id w19-v6mr23288441lfe.113.1537545480464;
        Fri, 21 Sep 2018 08:58:00 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o19-v6sm2192978lfk.30.2018.09.21.08.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:57:59 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH v5 11/23] ll-merge.c: remove implicit dependency on the_index
Date:   Fri, 21 Sep 2018 17:57:27 +0200
Message-Id: <20180921155739.14407-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.640.gcd3aa10a8a
In-Reply-To: <20180921155739.14407-1-pclouds@gmail.com>
References: <20180915161759.8272-1-pclouds@gmail.com>
 <20180921155739.14407-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c            |  9 ++++++---
 builtin/checkout.c |  3 ++-
 diff.c             |  2 +-
 ll-merge.c         | 17 +++++++++--------
 ll-merge.h         |  5 ++++-
 merge-blobs.c      |  3 ++-
 merge-recursive.c  |  3 ++-
 notes-merge.c      |  3 ++-
 rerere.c           | 10 ++++++----
 9 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/apply.c b/apply.c
index e485fbc6bc..ea111ab13f 100644
--- a/apply.c
+++ b/apply.c
@@ -3467,7 +3467,8 @@ static int load_preimage(struct apply_state *state,
 	return 0;
 }
 
-static int three_way_merge(struct image *image,
+static int three_way_merge(struct apply_state *state,
+			   struct image *image,
 			   char *path,
 			   const struct object_id *base,
 			   const struct object_id *ours,
@@ -3483,7 +3484,9 @@ static int three_way_merge(struct image *image,
 	status = ll_merge(&result, path,
 			  &base_file, "base",
 			  &our_file, "ours",
-			  &their_file, "theirs", NULL);
+			  &their_file, "theirs",
+			  state->repo->index,
+			  NULL);
 	free(base_file.ptr);
 	free(our_file.ptr);
 	free(their_file.ptr);
@@ -3595,7 +3598,7 @@ static int try_threeway(struct apply_state *state,
 	clear_image(&tmp_image);
 
 	/* in-core three-way merge between post and our using pre as base */
-	status = three_way_merge(image, patch->new_name,
+	status = three_way_merge(state, image, patch->new_name,
 				 &pre_oid, &our_oid, &post_oid);
 	if (status < 0) {
 		if (state->apply_verbosity > verbosity_silent)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 29ef50013d..cd9be50161 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -208,7 +208,8 @@ static int checkout_merged(int pos, const struct checkout *state)
 	 * merge.renormalize set, too
 	 */
 	status = ll_merge(&result_buf, path, &ancestor, "base",
-			  &ours, "ours", &theirs, "theirs", NULL);
+			  &ours, "ours", &theirs, "theirs",
+			  state->istate, NULL);
 	free(ancestor.ptr);
 	free(ours.ptr);
 	free(theirs.ptr);
diff --git a/diff.c b/diff.c
index 1bcc0818df..a06c3b070c 100644
--- a/diff.c
+++ b/diff.c
@@ -3637,7 +3637,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	data.lineno = 0;
 	data.o = o;
 	data.ws_rule = whitespace_rule(attr_path);
-	data.conflict_marker_size = ll_merge_marker_size(attr_path);
+	data.conflict_marker_size = ll_merge_marker_size(o->repo->index, attr_path);
 
 	if (fill_mmfile(o->repo, &mf1, one) < 0 ||
 	    fill_mmfile(o->repo, &mf2, two) < 0)
diff --git a/ll-merge.c b/ll-merge.c
index 0e2800f7bb..c339ef8ae8 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -336,10 +336,10 @@ static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr
 	return &ll_merge_drv[LL_TEXT_MERGE];
 }
 
-static void normalize_file(mmfile_t *mm, const char *path)
+static void normalize_file(mmfile_t *mm, const char *path, struct index_state *istate)
 {
 	struct strbuf strbuf = STRBUF_INIT;
-	if (renormalize_buffer(&the_index, path, mm->ptr, mm->size, &strbuf)) {
+	if (renormalize_buffer(istate, path, mm->ptr, mm->size, &strbuf)) {
 		free(mm->ptr);
 		mm->size = strbuf.len;
 		mm->ptr = strbuf_detach(&strbuf, NULL);
@@ -351,6 +351,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *ancestor, const char *ancestor_label,
 	     mmfile_t *ours, const char *our_label,
 	     mmfile_t *theirs, const char *their_label,
+	     struct index_state *istate,
 	     const struct ll_merge_options *opts)
 {
 	static struct attr_check *check;
@@ -363,15 +364,15 @@ int ll_merge(mmbuffer_t *result_buf,
 		opts = &default_opts;
 
 	if (opts->renormalize) {
-		normalize_file(ancestor, path);
-		normalize_file(ours, path);
-		normalize_file(theirs, path);
+		normalize_file(ancestor, path, istate);
+		normalize_file(ours, path, istate);
+		normalize_file(theirs, path, istate);
 	}
 
 	if (!check)
 		check = attr_check_initl("merge", "conflict-marker-size", NULL);
 
-	if (!git_check_attr(&the_index, path, check)) {
+	if (!git_check_attr(istate, path, check)) {
 		ll_driver_name = check->items[0].value;
 		if (check->items[1].value) {
 			marker_size = atoi(check->items[1].value);
@@ -391,14 +392,14 @@ int ll_merge(mmbuffer_t *result_buf,
 			  opts, marker_size);
 }
 
-int ll_merge_marker_size(const char *path)
+int ll_merge_marker_size(struct index_state *istate, const char *path)
 {
 	static struct attr_check *check;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 
 	if (!check)
 		check = attr_check_initl("conflict-marker-size", NULL);
-	if (!git_check_attr(&the_index, path, check) && check->items[0].value) {
+	if (!git_check_attr(istate, path, check) && check->items[0].value) {
 		marker_size = atoi(check->items[0].value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
diff --git a/ll-merge.h b/ll-merge.h
index b72b19921e..6c6e22e40d 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -7,6 +7,8 @@
 
 #include "xdiff/xdiff.h"
 
+struct index_state;
+
 struct ll_merge_options {
 	unsigned virtual_ancestor : 1;
 	unsigned variant : 2;	/* favor ours, favor theirs, or union merge */
@@ -19,8 +21,9 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *ancestor, const char *ancestor_label,
 	     mmfile_t *ours, const char *our_label,
 	     mmfile_t *theirs, const char *their_label,
+	     struct index_state *istate,
 	     const struct ll_merge_options *opts);
 
-int ll_merge_marker_size(const char *path);
+int ll_merge_marker_size(struct index_state *istate, const char *path);
 
 #endif
diff --git a/merge-blobs.c b/merge-blobs.c
index fabb8c19ce..668fb2e05d 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -41,7 +41,8 @@ static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our
 	 * common ancestor.
 	 */
 	merge_status = ll_merge(&res, path, base, NULL,
-				our, ".our", their, ".their", NULL);
+				our, ".our", their, ".their",
+				&the_index, NULL);
 	if (merge_status < 0)
 		return NULL;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 939843e815..7edcda4db0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1083,7 +1083,8 @@ static int merge_3way(struct merge_options *o,
 	read_mmblob(&src2, &b->oid);
 
 	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
-				&src1, name1, &src2, name2, &ll_opts);
+				&src1, name1, &src2, name2,
+				&the_index, &ll_opts);
 
 	free(base_name);
 	free(name1);
diff --git a/notes-merge.c b/notes-merge.c
index 9b154a5da6..432edfb89a 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -348,7 +348,8 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
 	read_mmblob(&remote, &p->remote);
 
 	status = ll_merge(&result_buf, oid_to_hex(&p->obj), &base, NULL,
-			  &local, o->local_ref, &remote, o->remote_ref, NULL);
+			  &local, o->local_ref, &remote, o->remote_ref,
+			  &the_index, NULL);
 
 	free(base.ptr);
 	free(local.ptr);
diff --git a/rerere.c b/rerere.c
index c7787aa07f..e65d8fc06f 100644
--- a/rerere.c
+++ b/rerere.c
@@ -478,7 +478,7 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 {
 	int hunk_no = 0;
 	struct rerere_io_file io;
-	int marker_size = ll_merge_marker_size(path);
+	int marker_size = ll_merge_marker_size(&the_index, path);
 
 	memset(&io, 0, sizeof(io));
 	io.io.getline = rerere_file_getline;
@@ -641,7 +641,8 @@ static int try_merge(const struct rerere_id *id, const char *path,
 		 * A three-way merge. Note that this honors user-customizable
 		 * low-level merge driver settings.
 		 */
-		ret = ll_merge(result, path, &base, NULL, cur, "", &other, "", NULL);
+		ret = ll_merge(result, path, &base, NULL, cur, "", &other, "",
+			       &the_index, NULL);
 
 	free(base.ptr);
 	free(other.ptr);
@@ -960,7 +961,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	const struct cache_entry *ce;
 	int pos, len, i, hunk_no;
 	struct rerere_io_mem io;
-	int marker_size = ll_merge_marker_size(path);
+	int marker_size = ll_merge_marker_size(&the_index, path);
 
 	/*
 	 * Reproduce the conflicted merge in-core
@@ -995,7 +996,8 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	 */
 	ll_merge(&result, path, &mmfile[0], NULL,
 		 &mmfile[1], "ours",
-		 &mmfile[2], "theirs", NULL);
+		 &mmfile[2], "theirs",
+		 &the_index, NULL);
 	for (i = 0; i < 3; i++)
 		free(mmfile[i].ptr);
 
-- 
2.19.0.640.gcd3aa10a8a

