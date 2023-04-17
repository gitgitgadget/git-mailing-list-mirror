Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20739C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 16:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjDQQWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 12:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjDQQVv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 12:21:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB29DAD11
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:21:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso20109958wmq.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681748507; x=1684340507;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhyBznFkIqvGexVnZFVC2f2hnlMta/niQqiKb/ru0HM=;
        b=o9nSnc3sptsZ3U4PBLB2tY5J5V9ywnzGo4DOVU1kkCsmZgSoeYAp8PmmJgO6VjVcXK
         zo0RUvzAv+0VMTo5DY0Mxho2EVH/h4hC1eaQriDrQNVoMhaQn5wv+7UYJ+xo2i7UW/tP
         rUq1RwaOZX9XAhPXtQ/Qr+U5LpoAyRedcTWfyNOB89uwCAdf/AXfmfiwYSjm4uL0E278
         VDVakRUn7GJD6tLcgLpaDSj6CrrEPAMnV9qJFDZXrbqvco/5/XkEtcrun7D61jIvoqWV
         /fx+UN5tBq8BVmTtm+SnU+JzECheLOhpUVXVRUw6PvWGbtJJjL4XxAky3MFSY2V6R904
         zCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681748507; x=1684340507;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhyBznFkIqvGexVnZFVC2f2hnlMta/niQqiKb/ru0HM=;
        b=PBF5qTWRle3C2jEUab4Iv+xykGSLXC55x2AS8TcDiVuCgMvAzezrTbgAqzYTq0Rt+a
         9I8ANDL9+mmc9+WCEPqwZxrZCkv/VI+7opkFX+eZjlvcDjBuEJRJEjdf4bn0plHAZXge
         06zvX+cZ7UCMvfGBojMA1Gon9TepHl+UHYDPIga+eTWsBniOKcY0TyrVUn6yfKCyj28Z
         9y+0jeU8tPyPgPiQl1sWD9anVGAunK9WlfdAyq6qf8VcTHiECYMv/Mdbu+q4LUMpvIQ4
         bg/+3UtjDrcNXQsHppFpPywO9E87gc6MPVU8yt6XHthYPA/qJkV6uccJen5GMHAiQ9BV
         Dn7Q==
X-Gm-Message-State: AAQBX9dlz47ORa/IZFD0xURb+kk5G9fhCbqAETlhFqt8gSw3LK3au3XG
        1nDnr3Lh25HSja/Jm+h/Tf3JYrXc4NM=
X-Google-Smtp-Source: AKy350ZjCWAlrdHGGZj+yjD8uY9ZMTPiPepigw66M77IjecGvluxc4RfI9T62X4A6pa+fE/JyCqZ0g==
X-Received: by 2002:a7b:cb07:0:b0:3f0:5519:9049 with SMTP id u7-20020a7bcb07000000b003f055199049mr11463983wmj.8.1681748506837;
        Mon, 17 Apr 2023 09:21:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d5644000000b002f02df4c7a3sm10831162wrw.30.2023.04.17.09.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 09:21:46 -0700 (PDT)
Message-Id: <7d894d859ef109091b86bc4e2e4f6cea0e808370.1681748502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Apr 2023 16:21:41 +0000
Subject: [PATCH 4/4] fsck: validate .rev file header
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

While parsing a .rev file, we check the header information to be sure it
makes sense. This happens before doing any additional validation such as
a checksum or value check. In order to differentiate between a bad
header and a non-existent file, we need to update the API for loading a
reverse index.

Make load_pack_revindex_from_disk() non-static and specify that a
positive value means "the file does not exist" while other errors during
parsing are negative values. Since an invalid header prevents setting up
the structures we would use for further validations, we can stop at that
point.

The place where we can distinguish between a missing file and a corrupt
file is inside load_revindex_from_disk(), which is used both by pack
rev-indexes and multi-pack-index rev-indexes. Some tests in t5326
demonstrate that it is critical to take some conditions to allow
positive error signals.

Add tests that check the three header values.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/fsck.c           | 10 ++++++++--
 pack-bitmap.c            |  4 ++--
 pack-revindex.c          |  5 +++--
 pack-revindex.h          |  8 ++++++++
 t/t5325-reverse-index.sh | 15 +++++++++++++++
 5 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2ab78129bde..2414190c049 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -872,8 +872,14 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	}
 
 	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
-		if (!load_pack_revindex(the_repository, p) &&
-		    verify_pack_revindex(p)) {
+		int load_error = load_pack_revindex_from_disk(p);
+
+		if (load_error < 0) {
+			error(_("unable to load rev-index for pack '%s'"), p->pack_name);
+			res = ERROR_PACK_REV_INDEX;
+		} else if (!load_error &&
+			   !load_pack_revindex(the_repository, p) &&
+			   verify_pack_revindex(p)) {
 			error(_("invalid rev-index for pack '%s'"), p->pack_name);
 			res = ERROR_PACK_REV_INDEX;
 		}
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 38b35c48237..3828aab612a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -379,7 +379,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		goto cleanup;
 	}
 
-	if (load_midx_revindex(bitmap_git->midx) < 0) {
+	if (load_midx_revindex(bitmap_git->midx)) {
 		warning(_("multi-pack bitmap is missing required reverse index"));
 		goto cleanup;
 	}
@@ -2140,7 +2140,7 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 
 	if (!bitmap_is_midx(bitmap_git))
 		load_reverse_index(r, bitmap_git);
-	else if (load_midx_revindex(bitmap_git->midx) < 0)
+	else if (load_midx_revindex(bitmap_git->midx))
 		BUG("rebuild_existing_bitmaps: missing required rev-cache "
 		    "extension");
 
diff --git a/pack-revindex.c b/pack-revindex.c
index 62a9846470c..146334e2c96 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -212,7 +212,8 @@ static int load_revindex_from_disk(char *revindex_name,
 	fd = git_open(revindex_name);
 
 	if (fd < 0) {
-		ret = -1;
+		/* "No file" means return 1. */
+		ret = 1;
 		goto cleanup;
 	}
 	if (fstat(fd, &st)) {
@@ -264,7 +265,7 @@ cleanup:
 	return ret;
 }
 
-static int load_pack_revindex_from_disk(struct packed_git *p)
+int load_pack_revindex_from_disk(struct packed_git *p)
 {
 	char *revindex_name;
 	int ret;
diff --git a/pack-revindex.h b/pack-revindex.h
index c8861873b02..6dd47efea10 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -51,6 +51,14 @@ struct repository;
  */
 int load_pack_revindex(struct repository *r, struct packed_git *p);
 
+/*
+ * Specifically load a pack revindex from disk.
+ *
+ * Returns 0 on success, 1 on "no .rev file", and -1 when there is an
+ * error parsing the .rev file.
+ */
+int load_pack_revindex_from_disk(struct packed_git *p);
+
 /*
  * verify_pack_revindex verifies that the on-disk rev-index for the given
  * pack-file is the same that would be created if written from scratch.
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 5c3c80f88f0..431a603ca0e 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -190,4 +190,19 @@ test_expect_success 'fsck catches invalid row position' '
 		"invalid rev-index position"
 '
 
+test_expect_success 'fsck catches invalid header: magic number' '
+	corrupt_rev_and_verify 1 "\07" \
+		"reverse-index file .* has unknown signature"
+'
+
+test_expect_success 'fsck catches invalid header: version' '
+	corrupt_rev_and_verify 7 "\02" \
+		"reverse-index file .* has unsupported version"
+'
+
+test_expect_success 'fsck catches invalid header: hash function' '
+	corrupt_rev_and_verify 11 "\03" \
+		"reverse-index file .* has unsupported hash id"
+'
+
 test_done
-- 
gitgitgadget
