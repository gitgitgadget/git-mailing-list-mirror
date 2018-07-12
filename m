Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12E91F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbeGLTvf (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:35 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38688 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732395AbeGLTvf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:35 -0400
Received: by mail-qt0-f195.google.com with SMTP id c5-v6so25154297qth.5
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+324KRRHlZFkPTu7zwTrmDa5LOGdDxdODej836/x3+w=;
        b=Nk4v7Fo/4v+XSXhXe/GPN1aW4B+A7szUE63iRCjD99XJ4OYisbYOnCYzzah3UmheKw
         IFBMYogGt1AyQS+apTi9++wcVlzohXQNbuCVY2k82p7Nh8BgpqfNcClPWQM5/iDdJuMd
         vp+uq7XZcpn/+xsNFytpuyal8yJwXy2R8AcZ0k82mvgvhgA81k6Kwz9cjuVPtwPzbHqh
         moUqeJa1Tte8cMGPrBgmtageZCV5YGMbUx7TwPhNubSEVzzPvNftcbkx7HFwsZ/7ES0c
         GvfYc1VGIZyBQjcW9cCdfcYQ2V0adHXnSeAlXJfxZqdj99hyRVuXUk69iccTCEAaPtDl
         kcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+324KRRHlZFkPTu7zwTrmDa5LOGdDxdODej836/x3+w=;
        b=o2x87iyqExtb9FW0DCwp6PXKPrym/3XxentCnaZOfifacL6c80uKlGgEPPCM80lJn3
         qpB8s30Y6ZISqwG55eKJxtwSE8GyvoiRzxunM8uekywKu3Oflm3jKb3uB5qGElzCzLIm
         hr6vR8h9LGfad4PQt2ebFWgMnjJGzw5rovLcmuRiDg2lYBUoYtEeBU05abOZ5CFgO5XO
         UzxDzgZh2M4kLV8D1A2ENRFRoFKqMTUykBBUPLrj845E6Un2RwD5MNMudAQDqIjq8IuG
         +MrggvUQWm7KjgwqH+Sj9M+OlS9bKroBwtoXUE1QOPpy5N1GLebUVF+cmiCRWRPvz47G
         UYdA==
X-Gm-Message-State: AOUpUlG2k2mF1tobYFLM5CF64d0VQFd2X1FRF9ng2l/s0Rl8G7PGebl6
        454dtwgaH/ss2jdTFddF6QdC4+Wn/KA=
X-Google-Smtp-Source: AAOMgpesdNC6MsqchF0YTfJ0uxwmQo2jwcd9iBPGvX6G7zQtVYNxDb+bqUArCd/48ERV6CDreqPUZA==
X-Received: by 2002:aed:2381:: with SMTP id j1-v6mr3222643qtc.413.1531424434876;
        Thu, 12 Jul 2018 12:40:34 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:34 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 16/23] config: create core.multiPackIndex setting
Date:   Thu, 12 Jul 2018 15:39:33 -0400
Message-Id: <20180712193940.21065-17-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The core.multiPackIndex config setting controls the multi-pack-
index (MIDX) feature. If false, the setting will disable all reads
from the multi-pack-index file.

Read this config setting in the new prepare_multi_pack_index_one()
which is called during prepare_packed_git(). This check is run once
per repository.

Add comparison commands in t5319-multi-pack-index.sh to check
typical Git behavior remains the same as the config setting is turned
on and off. This currently includes 'git rev-list' and 'git log'
commands to trigger several object database reads. Currently, these
would only catch an error in the prepare_multi_pack_index_one(), but
with later commits will catch errors in object lookups, abbreviations,
and approximate object counts.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

midx: prepare midxed_git struct

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt    |  5 ++++
 midx.c                      | 25 ++++++++++++++++++
 midx.h                      |  5 ++++
 object-store.h              |  7 +++++
 packfile.c                  |  6 ++++-
 t/t5319-multi-pack-index.sh | 51 +++++++++++++++++++++++++++----------
 6 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a9..25f817ca42 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -908,6 +908,11 @@ core.commitGraph::
 	Enable git commit graph feature. Allows reading from the
 	commit-graph file.
 
+core.multiPackIndex::
+	Use the multi-pack-index file to track multiple packfiles using a
+	single index. See link:technical/multi-pack-index.html[the
+	multi-pack-index design document].
+
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
diff --git a/midx.c b/midx.c
index e83110ae92..4090cf4ca4 100644
--- a/midx.c
+++ b/midx.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "csum-file.h"
 #include "dir.h"
 #include "lockfile.h"
@@ -177,6 +178,30 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	return NULL;
 }
 
+int prepare_multi_pack_index_one(struct repository *r, const char *object_dir)
+{
+	struct multi_pack_index *m = r->objects->multi_pack_index;
+	struct multi_pack_index *m_search;
+	int config_value;
+
+	if (repo_config_get_bool(r, "core.multipackindex", &config_value) ||
+	    !config_value)
+		return 0;
+
+	for (m_search = m; m_search; m_search = m_search->next)
+		if (!strcmp(object_dir, m_search->object_dir))
+			return 1;
+
+	r->objects->multi_pack_index = load_multi_pack_index(object_dir);
+
+	if (r->objects->multi_pack_index) {
+		r->objects->multi_pack_index->next = m;
+		return 1;
+	}
+
+	return 0;
+}
+
 static size_t write_midx_header(struct hashfile *f,
 				unsigned char num_chunks,
 				uint32_t num_packs)
diff --git a/midx.h b/midx.h
index e15966272f..9bcfc82d2e 100644
--- a/midx.h
+++ b/midx.h
@@ -1,7 +1,11 @@
 #ifndef __MIDX_H__
 #define __MIDX_H__
 
+#include "repository.h"
+
 struct multi_pack_index {
+	struct multi_pack_index *next;
+
 	int fd;
 
 	const unsigned char *data;
@@ -25,6 +29,7 @@ struct multi_pack_index {
 };
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir);
+int prepare_multi_pack_index_one(struct repository *r, const char *object_dir);
 
 int write_midx_file(const char *object_dir);
 
diff --git a/object-store.h b/object-store.h
index 13a766aea8..c2b162489a 100644
--- a/object-store.h
+++ b/object-store.h
@@ -105,6 +105,13 @@ struct raw_object_store {
 	 */
 	struct oidmap *replace_map;
 
+	/*
+	 * private data
+	 *
+	 * should only be accessed directly by packfile.c and midx.c
+	 */
+	struct multi_pack_index *multi_pack_index;
+
 	/*
 	 * private data
 	 *
diff --git a/packfile.c b/packfile.c
index 3d652212c6..5d4493dbf4 100644
--- a/packfile.c
+++ b/packfile.c
@@ -15,6 +15,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "object-store.h"
+#include "midx.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -935,10 +936,13 @@ static void prepare_packed_git(struct repository *r)
 
 	if (r->objects->packed_git_initialized)
 		return;
+	prepare_multi_pack_index_one(r, r->objects->objectdir);
 	prepare_packed_git_one(r, r->objects->objectdir, 1);
 	prepare_alt_odb(r);
-	for (alt = r->objects->alt_odb_list; alt; alt = alt->next)
+	for (alt = r->objects->alt_odb_list; alt; alt = alt->next) {
+		prepare_multi_pack_index_one(r, alt->path);
 		prepare_packed_git_one(r, alt->path, 0);
+	}
 	rearrange_packed_git(r);
 	prepare_packed_git_mru(r);
 	r->objects->packed_git_initialized = 1;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 4a4fa26f7a..601e28a2f0 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -3,6 +3,8 @@
 test_description='multi-pack-indexes'
 . ./test-lib.sh
 
+objdir=.git/objects
+
 midx_read_expect () {
 	NUM_PACKS=$1
 	NUM_OBJECTS=$2
@@ -76,18 +78,35 @@ test_expect_success 'create objects' '
 '
 
 test_expect_success 'write midx with one v1 pack' '
-	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
-	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
-	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 1 18 4 .
+	pack=$(git pack-objects --index-version=1 $objdir/pack/test <obj-list) &&
+	test_when_finished rm $objdir/pack/test-$pack.pack \
+		$objdir/pack/test-$pack.idx $objdir/pack/multi-pack-index &&
+	git multi-pack-index --object-dir=$objdir write &&
+	midx_read_expect 1 18 4 $objdir
 '
 
+midx_git_two_modes() {
+	git -c core.multiPackIndex=false $1 >expect &&
+	git -c core.multiPackIndex=true $1 >actual &&
+	test_cmp expect actual
+}
+
+compare_results_with_midx() {
+	MSG=$1
+	test_expect_success "check normal git operations: $MSG" '
+		midx_git_two_modes "rev-list --objects --all" &&
+		midx_git_two_modes "log --raw"
+	'
+}
+
 test_expect_success 'write midx with one v2 pack' '
-	git pack-objects --index-version=2,0x40 pack/test <obj-list &&
-	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 1 18 4 .
+	git pack-objects --index-version=2,0x40 $objdir/pack/test <obj-list &&
+	git multi-pack-index --object-dir=$objdir write &&
+	midx_read_expect 1 18 4 $objdir
 '
 
+compare_results_with_midx "one v2 pack"
+
 test_expect_success 'add more objects' '
 	for i in $(test_seq 6 10)
 	do
@@ -97,25 +116,31 @@ test_expect_success 'add more objects' '
 '
 
 test_expect_success 'write midx with two packs' '
-	git pack-objects --index-version=1 pack/test-2 <obj-list &&
-	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 2 34 4 .
+	git pack-objects --index-version=1 $objdir/pack/test-2 <obj-list &&
+	git multi-pack-index --object-dir=$objdir write &&
+	midx_read_expect 2 34 4 $objdir
 '
 
+compare_results_with_midx "two packs"
+
 test_expect_success 'add more packs' '
 	for j in $(test_seq 11 20)
 	do
 		generate_objects $j &&
 		commit_and_list_objects &&
-		git pack-objects --index-version=2 pack/test-pack <obj-list
+		git pack-objects --index-version=2 $objdir/pack/test-pack <obj-list
 	done
 '
 
+compare_results_with_midx "mixed mode (two packs + extra)"
+
 test_expect_success 'write midx with twelve packs' '
-	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 12 74 4 .
+	git multi-pack-index --object-dir=$objdir write &&
+	midx_read_expect 12 74 4 $objdir
 '
 
+compare_results_with_midx "twelve packs"
+
 # usage: corrupt_data <file> <pos> [<data>]
 corrupt_data () {
 	file=$1
-- 
2.18.0.118.gd4f65b8d14

