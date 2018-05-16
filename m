Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B27F61F406
	for <e@80x24.org>; Wed, 16 May 2018 22:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeEPWWA (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:22:00 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:44856 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbeEPWVq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:21:46 -0400
Received: by mail-pl0-f44.google.com with SMTP id e6-v6so1224819plt.11
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wCziY7N5hMMfK+NiT+AHAuDoZ1Fkqm0v3IdlQAD1EOk=;
        b=gD4pRm1Qkb0vhcxZ/S6wxjXwddgXACrx1OcsCX1zW29n1jKl77UMINp6VhPLDU2zvn
         cIbXDd6NmedXsHecMe6Svfi7jDqF+FIR6zcS/6TgayC1FOackjE4jk2HGy4i9fRby27I
         7jk9qkdEeIBKcz5gmT8GGCD6avU/DjiBmrCkWo0zfItJy/DLYbwwLJPV2D/41jI+9qQD
         egLDbQfd5e4b6vuu3VE+b1565N5N2iKFr2GBMSABPy2sjKRBnWdiwb57XtKKtwVjb/sT
         LklNsZvdXuRVfMfxU3+4/zBxT6IfB7sYKpnMRuHfs1O3IwaspL0iO5O3qMAQjG9bK/iI
         jh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wCziY7N5hMMfK+NiT+AHAuDoZ1Fkqm0v3IdlQAD1EOk=;
        b=b6vzb1Bn7b0Y3TtbxtTH+T5fpmW2eNIYhDDAHn/hGiC/8lx+shlhaPG3Os+4fPds5z
         ZQIhxLV0QqAjU8FGOMFnEzbU0liQXGkDzoYWl9Xas1kE5sz/iDlwCHmabuzH6kMKmERI
         3WemdMYCpi28svQMLpHVsFNLJZ44HV7wloR6C0K00g1YtLWwP3yF9aWU6zqGdMzvWR9a
         KS1roKxXGBkMcPIJClLgCA/nZCk3mpgdcpNNu3iU1S651BbhoPUNsmkvBss4xiHbR4r9
         uwhjBnsrqlTvgw8JjDUWay2RJUlTAYW0XBptSx4IKUYZOj/Y0BPMkryBsb778fgSOfYC
         RUzA==
X-Gm-Message-State: ALKqPwfWdDWUTAswDPFqhwuZdPYKZIiaZ4cyHAQiKr+ruz/cKaAqFmz7
        qqUUszIPkA7YT7oQeuAY/y2vDA==
X-Google-Smtp-Source: AB8JxZpA0GS4gPWiqv5TEToaQ4RVax7tcxW+tQ28gio2wJOjOC0fzf5d0Z2FRUy0NZznQvbUnGcA0Q==
X-Received: by 2002:a17:902:8a95:: with SMTP id p21-v6mr2687734plo.325.1526509305164;
        Wed, 16 May 2018 15:21:45 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 73-v6sm6836775pfo.153.2018.05.16.15.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 15:21:44 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com
Subject: [PATCH 10/11] test helpers: switch to repo_read_index_or_die
Date:   Wed, 16 May 2018 15:21:17 -0700
Message-Id: <20180516222118.233868-11-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180516222118.233868-1-sbeller@google.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/helper/test-dump-cache-tree.c      |  5 ++---
 t/helper/test-dump-untracked-cache.c |  4 ++--
 t/helper/test-lazy-init-name-hash.c  | 11 ++++++-----
 t/helper/test-read-cache.c           |  3 ++-
 t/helper/test-scrap-cache-tree.c     |  4 ++--
 t/helper/test-write-cache.c          |  3 ++-
 6 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 98a4891f1dc..a58c26084dd 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -2,7 +2,7 @@
 #include "cache.h"
 #include "tree.h"
 #include "cache-tree.h"
-
+#include "repository.h"
 
 static void dump_one(struct cache_tree *it, const char *pfx, const char *x)
 {
@@ -60,8 +60,7 @@ int cmd__dump_cache_tree(int ac, const char **av)
 	struct index_state istate;
 	struct cache_tree *another = cache_tree();
 	setup_git_directory();
-	if (read_cache() < 0)
-		die("unable to read index file");
+	repo_read_index_or_die(the_repository);
 	istate = the_index;
 	istate.cache_tree = another;
 	cache_tree_update(&istate, WRITE_TREE_DRY_RUN);
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index d7c55c2355e..171ba143c9a 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "repository.h"
 
 static int compare_untracked(const void *a_, const void *b_)
 {
@@ -47,8 +48,7 @@ int cmd_main(int ac, const char **av)
 	ignore_untracked_cache_config = 1;
 
 	setup_git_directory();
-	if (read_cache() < 0)
-		die("unable to read index file");
+	repo_read_index_or_die(the_repository);
 	uc = the_index.untracked;
 	if (!uc) {
 		printf("no untracked cache\n");
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index b99a37080d9..e25bfe27ab9 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "parse-options.h"
+#include "repository.h"
 
 static int single;
 static int multi;
@@ -32,7 +33,7 @@ static void dump_run(void)
 	struct dir_entry *dir;
 	struct cache_entry *ce;
 
-	read_cache();
+	repo_read_index_or_die(the_repository);
 	if (single) {
 		test_lazy_init_name_hash(&the_index, 0);
 	} else {
@@ -70,7 +71,7 @@ static uint64_t time_runs(int try_threaded)
 
 	for (i = 0; i < count; i++) {
 		t0 = getnanotime();
-		read_cache();
+		repo_read_index_or_die(the_repository);
 		t1 = getnanotime();
 		nr_threads_used = test_lazy_init_name_hash(&the_index, try_threaded);
 		t2 = getnanotime();
@@ -117,7 +118,7 @@ static void analyze_run(void)
 	int i;
 	int nr;
 
-	read_cache();
+	repo_read_index_or_die(the_repository);
 	cache_nr_limit = the_index.cache_nr;
 	discard_cache();
 
@@ -132,7 +133,7 @@ static void analyze_run(void)
 			nr = cache_nr_limit;
 
 		for (i = 0; i < count; i++) {
-			read_cache();
+			repo_read_index_or_die(the_repository);
 			the_index.cache_nr = nr; /* cheap truncate of index */
 			t1s = getnanotime();
 			test_lazy_init_name_hash(&the_index, 0);
@@ -141,7 +142,7 @@ static void analyze_run(void)
 			the_index.cache_nr = cache_nr_limit;
 			discard_cache();
 
-			read_cache();
+			repo_read_index_or_die(the_repository);
 			the_index.cache_nr = nr; /* cheap truncate of index */
 			t1m = getnanotime();
 			nr_threads_used = test_lazy_init_name_hash(&the_index, 1);
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index d674c88ba09..7a4a91bf328 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "repository.h"
 
 int cmd__read_cache(int argc, const char **argv)
 {
@@ -8,7 +9,7 @@ int cmd__read_cache(int argc, const char **argv)
 		cnt = strtol(argv[1], NULL, 0);
 	setup_git_directory();
 	for (i = 0; i < cnt; i++) {
-		read_cache();
+		repo_read_index_or_die(the_repository);
 		discard_cache();
 	}
 	return 0;
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index d26d3e7c8b1..401917abb49 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -3,6 +3,7 @@
 #include "lockfile.h"
 #include "tree.h"
 #include "cache-tree.h"
+#include "repository.h"
 
 static struct lock_file index_lock;
 
@@ -10,8 +11,7 @@ int cmd__scrap_cache_tree(int ac, const char **av)
 {
 	setup_git_directory();
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
-	if (read_cache() < 0)
-		die("unable to read index file");
+	repo_read_index_or_die(the_repository);
 	active_cache_tree = NULL;
 	if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		die("unable to write index file");
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index 017dc303800..6fd750da254 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "lockfile.h"
+#include "repository.h"
 
 static struct lock_file index_lock;
 
@@ -10,7 +11,7 @@ int cmd__write_cache(int argc, const char **argv)
 	if (argc == 2)
 		cnt = strtol(argv[1], NULL, 0);
 	setup_git_directory();
-	read_cache();
+	repo_read_index_or_die(the_repository);
 	for (i = 0; i < cnt; i++) {
 		lockfd = hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 		if (0 <= lockfd) {
-- 
2.17.0.582.gccdcbd54c44.dirty

