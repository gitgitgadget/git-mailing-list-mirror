Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870CCC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347563AbiCHOk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347556AbiCHOkX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:40:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D1338D89
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:39:26 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id x15so28862750wru.13
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q8+BEG3NwnoERyq+lPMXDfKtOelfHmetpKek56q/MYw=;
        b=a1ci3vq0vpooecJ2NPweWk3cdVUExJpaQF5/42WKZWxMFAp75IT5Dzlp4yAYjPTFKv
         ylnrcq/aiH20RrYjG/u6mt2GSSB8MkD2QUqDubq6p+ynAFuiIdjUE1rMuADNEirfNLn/
         epZKt0ko4kQUm1ZtZtstoEcjawRYijhOAiVyuw+dpt7Vc3iDYZe5BkbwaF/3AukNuv7t
         dX34zmPxCK19bnjS4Bkc+8c9hQCWqGquEXnQ/HQj/9mNi3I5wgqWQvoz+dGF93HjLsmx
         iaJla6x3fFvPz1szA9yYARFNmPLjcwXqTeVq0YN1MKIPuuBEVMYBvkK6l8M0jlo4inp0
         uBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q8+BEG3NwnoERyq+lPMXDfKtOelfHmetpKek56q/MYw=;
        b=s+HhexJpvj2ZIOB4VZ58PzXPf8FLbzefaBqHE2q0Ea1Uk5NVB8vDqisognBZqJBp+I
         o9PjUuDB1WVOC+XTNr83jq/NPruskjYxNARmfaGDoQ+WW7EQSdkm1sQzX0CUFzgQ2P3k
         +IK9rvJJJfwitjyykVX2OyEXtpb/EHvpg4/UdpGv6LPDoZwgsPpZdMMynZGsQu3KUHBN
         FzVUCM2/0RBZeFytJr/WMmog7pmj+YcKuudNjVbTx4Q+KWzYc8vHrkQG2axrihdETVMZ
         KtEDK6v9Tw66NkDm+iNjBbg3IeUjDSKXy9dhORpTwVGilGVE4JINvMczRQ5xqYbpZmtj
         vLJw==
X-Gm-Message-State: AOAM532bLXktkDalTIPF68nzySUnB52P+8uOkuLgEclhqLpVpvfKF/ad
        07Suxq8mhXgSRcR1SzWvvNSvI7lrNGU=
X-Google-Smtp-Source: ABdhPJxEdUJ8mr3GOkYgkYpZ2NxgrjuMR+kMOP0n/JxgfeGdlvcRVJ1PWkiT2TmJfhiBL24BPg0kzQ==
X-Received: by 2002:a5d:56cd:0:b0:1ee:3248:525b with SMTP id m13-20020a5d56cd000000b001ee3248525bmr12023573wrw.124.1646750364545;
        Tue, 08 Mar 2022 06:39:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b001f1f7b814d7sm5974998wru.69.2022.03.08.06.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:39:23 -0800 (PST)
Message-Id: <888774f6f28b291c928041a32c3df360cee13d10.1646750359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 14:39:11 +0000
Subject: [PATCH v3 04/12] pack-bitmap: drop filter in prepare_bitmap_walk()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Now that all consumers of prepare_bitmap_walk() have populated the
'filter' member of 'struct rev_info', we can drop that extra parameter
from the method and access it directly from the 'struct rev_info'.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/pack-objects.c |  2 +-
 builtin/rev-list.c     |  8 +++-----
 pack-bitmap.c          | 20 +++++++++-----------
 pack-bitmap.h          |  2 --
 reachable.c            |  2 +-
 5 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 256d9b1798f..57f2cf49696 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3651,7 +3651,7 @@ static int pack_options_allow_reuse(void)
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
-	if (!(bitmap_git = prepare_bitmap_walk(revs, revs->filter, 0)))
+	if (!(bitmap_git = prepare_bitmap_walk(revs, 0)))
 		return -1;
 
 	if (pack_options_allow_reuse() &&
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 6f2b91d304e..556e78aebb9 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -434,8 +434,7 @@ static int try_bitmap_count(struct rev_info *revs,
 	 */
 	max_count = revs->max_count;
 
-	bitmap_git = prepare_bitmap_walk(revs, revs->filter,
-					 filter_provided_objects);
+	bitmap_git = prepare_bitmap_walk(revs, filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
 
@@ -463,8 +462,7 @@ static int try_bitmap_traversal(struct rev_info *revs,
 	if (revs->max_count >= 0)
 		return -1;
 
-	bitmap_git = prepare_bitmap_walk(revs, revs->filter,
-					 filter_provided_objects);
+	bitmap_git = prepare_bitmap_walk(revs, filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
 
@@ -481,7 +479,7 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
 	if (!show_disk_usage)
 		return -1;
 
-	bitmap_git = prepare_bitmap_walk(revs, revs->filter, filter_provided_objects);
+	bitmap_git = prepare_bitmap_walk(revs, filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9c666cdb8bd..613f2797cdf 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -739,8 +739,7 @@ static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
 static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 				   struct rev_info *revs,
 				   struct object_list *roots,
-				   struct bitmap *seen,
-				   struct list_objects_filter_options *filter)
+				   struct bitmap *seen)
 {
 	struct bitmap *base = NULL;
 	int needs_walk = 0;
@@ -823,7 +822,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		show_data.bitmap_git = bitmap_git;
 		show_data.base = base;
 
-		traverse_commit_list_filtered(filter, revs,
+		traverse_commit_list_filtered(revs->filter, revs,
 					      show_commit, show_object,
 					      &show_data, NULL);
 
@@ -1219,7 +1218,6 @@ static int can_filter_bitmap(struct list_objects_filter_options *filter)
 }
 
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
-					 struct list_objects_filter_options *filter,
 					 int filter_provided_objects)
 {
 	unsigned int i;
@@ -1240,7 +1238,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	if (revs->prune)
 		return NULL;
 
-	if (!can_filter_bitmap(filter))
+	if (!can_filter_bitmap(revs->filter))
 		return NULL;
 
 	/* try to open a bitmapped pack, but don't parse it yet
@@ -1297,8 +1295,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 
 	if (haves) {
 		revs->ignore_missing_links = 1;
-		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL,
-					    filter);
+		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
 		reset_revision_walk();
 		revs->ignore_missing_links = 0;
 
@@ -1306,8 +1303,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 			BUG("failed to perform bitmap walk");
 	}
 
-	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap,
-				    filter);
+	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap);
 
 	if (!wants_bitmap)
 		BUG("failed to perform bitmap walk");
@@ -1315,8 +1311,10 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	if (haves_bitmap)
 		bitmap_and_not(wants_bitmap, haves_bitmap);
 
-	filter_bitmap(bitmap_git, (filter && filter_provided_objects) ? NULL : wants,
-		      wants_bitmap, filter);
+	filter_bitmap(bitmap_git,
+		      (revs->filter && filter_provided_objects) ? NULL : wants,
+		      wants_bitmap,
+		      revs->filter);
 
 	bitmap_git->result = wants_bitmap;
 	bitmap_git->haves = haves_bitmap;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 19a63fa1abc..3d3ddd77345 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -10,7 +10,6 @@
 struct commit;
 struct repository;
 struct rev_info;
-struct list_objects_filter_options;
 
 static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};
 
@@ -54,7 +53,6 @@ void test_bitmap_walk(struct rev_info *revs);
 int test_bitmap_commits(struct repository *r);
 int test_bitmap_hashes(struct repository *r);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
-					 struct list_objects_filter_options *filter,
 					 int filter_provided_objects);
 uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git);
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
diff --git a/reachable.c b/reachable.c
index 84e3d0d75ed..b9f4ad886ef 100644
--- a/reachable.c
+++ b/reachable.c
@@ -205,7 +205,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	cp.progress = progress;
 	cp.count = 0;
 
-	bitmap_git = prepare_bitmap_walk(revs, NULL, 0);
+	bitmap_git = prepare_bitmap_walk(revs, 0);
 	if (bitmap_git) {
 		traverse_bitmap_commit_list(bitmap_git, revs, mark_object_seen);
 		free_bitmap_index(bitmap_git);
-- 
gitgitgadget

