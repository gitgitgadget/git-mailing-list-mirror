Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E8C1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 19:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753588AbeFGTEb (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 15:04:31 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32894 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeFGTE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 15:04:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so5366556pfi.0
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+v4av3x3q3R/s8Mcd1LpfQHysi8zkEGBy41sAvZDHTM=;
        b=bmgehWSaUPCg+xHJmCFus4O88L2t2/CGIagyvrDOU7olHghUzB0pj/+vfuXh+Thrs7
         zIZ27UUFgWrUokI5qseG9Ks3KBHTWeUJNwRnsVJxwWHF3yoELWQnb6KxseRiEYWR6Acv
         1GewrXd9SEhKtPUwluyLTT0wlESPzKikHYdXhZtG0tBdDFWyuBHrDUVRodxQObV791tI
         3/KjjoC2+izaUX7YywFlFhBRWpswVRXh+G/DGHfCvIWU4VKZ+N2UfXmSggcxtETVdH96
         x1ubc4SZVgV6KzKAcuNRLQWDbThQu6tgSJ3dfu7lix7sYl7MZDLNv25ISNojUHMZ0Mw+
         bSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+v4av3x3q3R/s8Mcd1LpfQHysi8zkEGBy41sAvZDHTM=;
        b=TKKuWexc4xwkR8vOhMi0Fx7YKQrMcSAyE9f5codOSvZcJnJovo0pg+gU9Hb8MojB47
         zPBqL4XeZfRFndn0qaFZ0yIbPpeMKq07jf7IPsxhEXBzj8vrwwEK1oMbKafxbtktX+Th
         CpW/Q3O2DAAKQm0jGMjFxnwgOWDxqYV6SHoN4ZgU8Z5BEtzygS0No/hXOq+VQyt7Vbi9
         H1eNwwFvpk0gGTl00oxZQ8erSSojYKLFKur7pfToZ13i33PLoVa1IBSVhwJDcvuzxSmZ
         h80fZr2+hb4poCiJpOzpyJg8YnYG78VknMRnPKSs1Ja68WSuBM2GVPGpNAyRqauH6R/L
         UO9g==
X-Gm-Message-State: APt69E06noGhXRNqcwzUUSGxNLvMi67v4bFs5ViVJDILHkUzVN3B3ir4
        mbKopVBDbGMikvuqArNiUSZLu+rg9Ks=
X-Google-Smtp-Source: ADUXVKLWWCHDEOSrMc2hlEacVqPFALvR1+rtTc36dcu2BtG/nPpDzkwxOzDdBPbL8OVQn1AgxXDGCw==
X-Received: by 2002:a62:f206:: with SMTP id m6-v6mr2826460pfh.171.1528398265935;
        Thu, 07 Jun 2018 12:04:25 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id x2-v6sm16324624pfn.11.2018.06.07.12.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 12:04:24 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [PATCH 2/2] pack-bitmap: add free function
Date:   Thu,  7 Jun 2018 12:04:14 -0700
Message-Id: <b9be1d0371e5dc694e5e7ac88a900f985faabec8.1528397984.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528397984.git.jonathantanmy@google.com>
References: <cover.1528397984.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function to free struct bitmap_index instances, and use it where
needed (except when rebuild_existing_bitmaps() is used, since it creates
references to the bitmaps within the struct bitmap_index passed to it).

Note that the hashes field in struct bitmap_index is not freed because
it points to another field within the same struct. The documentation for
that field has been updated to clarify that.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/pack-objects.c |  1 +
 builtin/rev-list.c     |  2 ++
 pack-bitmap-write.c    |  4 ++++
 pack-bitmap.c          | 35 +++++++++++++++++++++++++++++------
 pack-bitmap.h          |  1 +
 5 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d064f944b..896e41300 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2945,6 +2945,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 	}
 
 	traverse_bitmap_commit_list(bitmap_git, &add_object_entry_from_bitmap);
+	free_bitmap_index(bitmap_git);
 	return 0;
 }
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index cce42ae1d..62776721f 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -521,6 +521,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 				if (max_count >= 0 && max_count < commit_count)
 					commit_count = max_count;
 				printf("%d\n", commit_count);
+				free_bitmap_index(bitmap_git);
 				return 0;
 			}
 		} else if (revs.max_count < 0 &&
@@ -528,6 +529,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			struct bitmap_index *bitmap_git;
 			if ((bitmap_git = prepare_bitmap_walk(&revs))) {
 				traverse_bitmap_commit_list(bitmap_git, &show_object_fast);
+				free_bitmap_index(bitmap_git);
 				return 0;
 			}
 		}
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 03e122563..7896fedd3 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -367,6 +367,10 @@ void bitmap_writer_reuse_bitmaps(struct packing_data *to_pack)
 	writer.reused = kh_init_sha1();
 	rebuild_existing_bitmaps(bitmap_git, to_pack, writer.reused,
 				 writer.show_progress);
+	/*
+	 * NEEDSWORK: rebuild_existing_bitmaps() makes writer.reused reference
+	 * some bitmaps in bitmap_git, so we can't free the latter.
+	 */
 }
 
 static struct ewah_bitmap *find_reused_bitmap(const unsigned char *sha1)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 7795444b0..c06b19f49 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -66,7 +66,7 @@ struct bitmap_index {
 	/* Number of bitmapped commits */
 	uint32_t entry_count;
 
-	/* Name-hash cache (or NULL if not present). */
+	/* If not NULL, this is a name-hash cache pointing into map. */
 	uint32_t *hashes;
 
 	/*
@@ -350,6 +350,7 @@ struct bitmap_index *prepare_bitmap_git(void)
 	if (!open_pack_bitmap(bitmap_git) && !load_pack_bitmap(bitmap_git))
 		return bitmap_git;
 
+	free_bitmap_index(bitmap_git);
 	return NULL;
 }
 
@@ -690,7 +691,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 	/* try to open a bitmapped pack, but don't parse it yet
 	 * because we may not need to use it */
 	if (open_pack_bitmap(bitmap_git) < 0)
-		return NULL;
+		goto cleanup;
 
 	for (i = 0; i < revs->pending.nr; ++i) {
 		struct object *object = revs->pending.objects[i].item;
@@ -723,11 +724,11 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 	 * optimize here
 	 */
 	if (haves && !in_bitmapped_pack(bitmap_git, haves))
-		return NULL;
+		goto cleanup;
 
 	/* if we don't want anything, we're done here */
 	if (!wants)
-		return NULL;
+		goto cleanup;
 
 	/*
 	 * now we're going to use bitmaps, so load the actual bitmap entries
@@ -735,7 +736,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 	 * becomes invalidated and we must perform the revwalk through bitmaps
 	 */
 	if (!bitmap_git->loaded && load_pack_bitmap(bitmap_git) < 0)
-		return NULL;
+		goto cleanup;
 
 	object_array_clear(&revs->pending);
 
@@ -761,6 +762,10 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 
 	bitmap_free(haves_bitmap);
 	return bitmap_git;
+
+cleanup:
+	free_bitmap_index(bitmap_git);
+	return NULL;
 }
 
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
@@ -1001,7 +1006,7 @@ void test_bitmap_walk(struct rev_info *revs)
 	else
 		fprintf(stderr, "Mismatch!\n");
 
-	bitmap_free(result);
+	free_bitmap_index(bitmap_git);
 }
 
 static int rebuild_bitmap(uint32_t *reposition,
@@ -1093,3 +1098,21 @@ int rebuild_existing_bitmaps(struct bitmap_index *bitmap_git,
 	bitmap_free(rebuild);
 	return 0;
 }
+
+void free_bitmap_index(struct bitmap_index *b)
+{
+	if (!b)
+		return;
+
+	if (b->map)
+		munmap(b->map, b->map_size);
+	ewah_pool_free(b->commits);
+	ewah_pool_free(b->trees);
+	ewah_pool_free(b->blobs);
+	ewah_pool_free(b->tags);
+	kh_destroy_sha1(b->bitmaps);
+	free(b->ext_index.objects);
+	free(b->ext_index.hashes);
+	bitmap_free(b->result);
+	free(b);
+}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 19f70043a..4555907de 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -48,6 +48,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
 				       uint32_t *entries, off_t *up_to);
 int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
 			     khash_sha1 *reused_bitmaps, int show_progress);
+void free_bitmap_index(struct bitmap_index *);
 
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(unsigned char *sha1);
-- 
2.17.0.768.g1526ddbba1.dirty

