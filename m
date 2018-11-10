Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F111F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeKJPda (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:30 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38992 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbeKJPd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so3377683ljh.6
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SDWpSOdb99Zwx5bOtWBYgoGktOMB92CBT8AUvbJBEkc=;
        b=TRyuxQt5CIHzc3U1wnGJuB/OrxaxgEZvHVcQNk+N/5qz/u77nJ71QmWCQpiCIXxthW
         zpJGzIvlXf27apuer+E4yM+p9osUPpff3gnysVL9USK4KdpzpoguJFpH9x/E5W31B8t5
         y6ZCx7b3dJSK4L/zjVIZ5s8hstaQObWk7MQGf4fKrncoVM8X9XWwGYRvmW6hF1/AaSXu
         CAO5MvFmjS/jF+5BGuqF8pWVm5xsb2vN3tswTXtjK41OhVkogbG+YCRkTNtsnJM/SP7z
         ib39PYQS/8c6TdEKrLdhrsrb9/X7PoEZ7PrNS+g6Wtc9YxtNQSiEGtRAq7qal3HK0Wgh
         pFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SDWpSOdb99Zwx5bOtWBYgoGktOMB92CBT8AUvbJBEkc=;
        b=Vf0mK3MjGRAaZjA8X3qQ5olw2+6BRAKGP33PPgbilB+h672K3nkqoyfK2iFacJC4dv
         SMRxpAxJBSqriPkw5ycw9b+k+u5LwRvCJlqCUOdgQX1yMoIAPQFZmnpnmpRkwKTRmoeh
         1i8Klio5+UvuRaNBpootxvNd1ESzGB/BTzoeh3x4uoF33GWGoYmw9wVpTM7vxY/3ay5n
         wuSsKjyGWZXkrwnWgXPD25VOrNp2LXjuDcZLXj6GEsRF9Wse3Zdslb4FyufuVaQvRMFr
         g2DDNDvR0XTpuXcaltBbC0A1ChY+YoTnb/D3gO/jHPgMxcb0cF+uN/w2cKBWrerchPdi
         4uSw==
X-Gm-Message-State: AGRZ1gJxi4VGd8GEsaxMOysViKZVn8+qKD0hG08PiTAYaqkvALV3UQC6
        5QIdxgUVTqDvHsuom1vU42IQK+Kh
X-Google-Smtp-Source: AJdET5c+y+NYz0ikSx/BjuJkZVgFKZ0OP+2J2Aikev6zp6KYefUPEhAgDN1fn98+ZPmZV1ZHyescWg==
X-Received: by 2002:a2e:b1ca:: with SMTP id e10-v6mr7978370lja.16.1541828981092;
        Fri, 09 Nov 2018 21:49:41 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:40 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 20/22] pack-*.c: remove the_repository references
Date:   Sat, 10 Nov 2018 06:49:08 +0100
Message-Id: <20181110054910.10568-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c |  2 +-
 pack-bitmap-write.c    |  6 +++---
 pack-bitmap.c          | 13 +++++++------
 pack-bitmap.h          |  3 ++-
 pack-objects.c         |  6 ++++--
 pack-objects.h         |  5 ++++-
 6 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7812c2b1f3..8abfb69e2d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3481,7 +3481,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	prepare_packing_data(&to_pack);
+	prepare_packing_data(the_repository, &to_pack);
 
 	if (progress)
 		progress_state = start_progress(_("Enumerating objects"), 0);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 9d1b951697..5566e94abe 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -77,7 +77,7 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
 			break;
 
 		default:
-			real_type = oid_object_info(the_repository,
+			real_type = oid_object_info(to_pack->repo,
 						    &entry->idx.oid, NULL);
 			break;
 		}
@@ -262,7 +262,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	if (writer.show_progress)
 		writer.progress = start_progress("Building bitmaps", writer.selected_nr);
 
-	repo_init_revisions(the_repository, &revs, NULL);
+	repo_init_revisions(to_pack->repo, &revs, NULL);
 	revs.tag_objects = 1;
 	revs.tree_objects = 1;
 	revs.blob_objects = 1;
@@ -363,7 +363,7 @@ static int date_compare(const void *_a, const void *_b)
 void bitmap_writer_reuse_bitmaps(struct packing_data *to_pack)
 {
 	struct bitmap_index *bitmap_git;
-	if (!(bitmap_git = prepare_bitmap_git()))
+	if (!(bitmap_git = prepare_bitmap_git(to_pack->repo)))
 		return;
 
 	writer.reused = kh_init_sha1();
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5848cc93aa..4695aaf6b4 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -328,14 +328,15 @@ static int load_pack_bitmap(struct bitmap_index *bitmap_git)
 	return -1;
 }
 
-static int open_pack_bitmap(struct bitmap_index *bitmap_git)
+static int open_pack_bitmap(struct repository *r,
+			    struct bitmap_index *bitmap_git)
 {
 	struct packed_git *p;
 	int ret = -1;
 
 	assert(!bitmap_git->map);
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = get_all_packs(r); p; p = p->next) {
 		if (open_pack_bitmap_1(bitmap_git, p) == 0)
 			ret = 0;
 	}
@@ -343,11 +344,11 @@ static int open_pack_bitmap(struct bitmap_index *bitmap_git)
 	return ret;
 }
 
-struct bitmap_index *prepare_bitmap_git(void)
+struct bitmap_index *prepare_bitmap_git(struct repository *r)
 {
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_pack_bitmap(bitmap_git) && !load_pack_bitmap(bitmap_git))
+	if (!open_pack_bitmap(r, bitmap_git) && !load_pack_bitmap(bitmap_git))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
@@ -690,7 +691,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 	/* try to open a bitmapped pack, but don't parse it yet
 	 * because we may not need to use it */
-	if (open_pack_bitmap(bitmap_git) < 0)
+	if (open_pack_bitmap(revs->repo, bitmap_git) < 0)
 		goto cleanup;
 
 	for (i = 0; i < revs->pending.nr; ++i) {
@@ -955,7 +956,7 @@ void test_bitmap_walk(struct rev_info *revs)
 	struct bitmap_test_data tdata;
 	struct bitmap_index *bitmap_git;
 
-	if (!(bitmap_git = prepare_bitmap_git()))
+	if (!(bitmap_git = prepare_bitmap_git(revs->repo)))
 		die("failed to load bitmap indexes");
 
 	if (revs->pending.nr != 1)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 189dd68ad3..8418ba8c79 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -6,6 +6,7 @@
 #include "pack-objects.h"
 
 struct commit;
+struct repository;
 struct rev_info;
 
 struct bitmap_disk_header {
@@ -39,7 +40,7 @@ typedef int (*show_reachable_fn)(
 
 struct bitmap_index;
 
-struct bitmap_index *prepare_bitmap_git(void);
+struct bitmap_index *prepare_bitmap_git(struct repository *r);
 void count_bitmap_commit_list(struct bitmap_index *, uint32_t *commits,
 			      uint32_t *trees, uint32_t *blobs, uint32_t *tags);
 void traverse_bitmap_commit_list(struct bitmap_index *,
diff --git a/pack-objects.c b/pack-objects.c
index b6cdbb0166..9c45842df3 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -99,7 +99,7 @@ static void prepare_in_pack_by_idx(struct packing_data *pdata)
 	 * (i.e. in_pack_idx also zero) should return NULL.
 	 */
 	mapping[cnt++] = NULL;
-	for (p = get_all_packs(the_repository); p; p = p->next, cnt++) {
+	for (p = get_all_packs(pdata->repo); p; p = p->next, cnt++) {
 		if (cnt == nr) {
 			free(mapping);
 			return;
@@ -133,8 +133,10 @@ void oe_map_new_pack(struct packing_data *pack,
 }
 
 /* assume pdata is already zero'd by caller */
-void prepare_packing_data(struct packing_data *pdata)
+void prepare_packing_data(struct repository *r, struct packing_data *pdata)
 {
+	pdata->repo = r;
+
 	if (git_env_bool("GIT_TEST_FULL_IN_PACK_ARRAY", 0)) {
 		/*
 		 * do not initialize in_pack_by_idx[] to force the
diff --git a/pack-objects.h b/pack-objects.h
index 86ee93feb4..9e6af3f24f 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -5,6 +5,8 @@
 #include "thread-utils.h"
 #include "pack.h"
 
+struct repository;
+
 #define DEFAULT_DELTA_CACHE_SIZE (256 * 1024 * 1024)
 
 #define OE_DFS_STATE_BITS	2
@@ -127,6 +129,7 @@ struct object_entry {
 };
 
 struct packing_data {
+	struct repository *repo;
 	struct object_entry *objects;
 	uint32_t nr_objects, nr_alloc;
 
@@ -165,7 +168,7 @@ struct packing_data {
 	unsigned char *layer;
 };
 
-void prepare_packing_data(struct packing_data *pdata);
+void prepare_packing_data(struct repository *r, struct packing_data *pdata);
 
 static inline void packing_data_lock(struct packing_data *pdata)
 {
-- 
2.19.1.1231.g84aef82467

