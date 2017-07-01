Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96A9D201A0
	for <e@80x24.org>; Sat,  1 Jul 2017 00:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbdGAA2r (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 20:28:47 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35526 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdGAA2p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 20:28:45 -0400
Received: by mail-pf0-f173.google.com with SMTP id c73so74248540pfk.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 17:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=58CScvg2AnfeDayBLOTmLmD5lJEl4h7CxPk3fTGw3sk=;
        b=bdZ8vpuGxb49HS+8DVxoUv/wAmL5JMvvpZshLacPZFO5MyOiXpUh1fSDz31lIBaUbW
         TTfZKBTNsizxdpb2ErNif1y6UA8+7HGgPZw5uwYI3g9d+67gbxySAj/8Y/+EKQvtld8w
         oZi5rone4n8jt4R3pQzA7vtQuzEoZGhMD7oaSOpMRuPJVghkFiQo2aG+GCw//RYxwuPW
         zr22YqOxadgM13XNV8NfM5lBCb9kChln7wa8NUnNo/RAjkxs4rrQlpcNxptyvyTdV2tY
         nzbxfW5wminpYv4rEiry4Fn5zlbb0on0QyzOlvj5a5lrmj0hvoB+BmDVlYUuPlzY43xj
         yDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=58CScvg2AnfeDayBLOTmLmD5lJEl4h7CxPk3fTGw3sk=;
        b=PU/O9pUcHLIyySIDSTzeWeAUVD4//RIikreStfr9ScRnluhTXpDAErd0rlnIuxkHuN
         HTlJoKmpf6DLaBb0CQXGTQOaeUqwqJ9XtMduQ8rdBAZf8KVIPni26aAY3efJZoYzG6wa
         ra90OEwrJGKFvFVSa9V5QLgyNnn9LJry3o0rmET7PY/FlRAtjggT5KVmpnzajLqdynpV
         motkWpyUWWZ7LU+ltPiKkIX2svTfapePCmIts0gF9wf5/WKk2q95FMULa9i6YCodF3D/
         9+UcL5YCSIefU8L0JezEncCcw0svumD9JDD1LRdPUyD6myZM0frVLd31w0jTcjSwpZEU
         SoEQ==
X-Gm-Message-State: AKS2vOxAneP3NYvfR+0JV072Y6KE3WoIVGp5eIThaea/zmkFSHF8SDmy
        Aum3TgQbQBML72OzHdgRBQ==
X-Received: by 10.98.103.18 with SMTP id b18mr25113928pfc.171.1498868924286;
        Fri, 30 Jun 2017 17:28:44 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:cc8b:7c8c:8e14:f9b5])
        by smtp.gmail.com with ESMTPSA id s87sm176558pfa.86.2017.06.30.17.28.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 17:28:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/10] builtin/difftool.c: drop hashmap_cmp_fn cast
Date:   Fri, 30 Jun 2017 17:28:30 -0700
Message-Id: <20170701002838.22785-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170701002838.22785-1-sbeller@google.com>
References: <20170701002838.22785-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/difftool.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index a1a26ba891..8864d846f8 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -131,10 +131,12 @@ struct working_tree_entry {
 };
 
 static int working_tree_entry_cmp(const void *unused_cmp_data,
-				  struct working_tree_entry *a,
-				  struct working_tree_entry *b,
-				  void *unused_keydata)
+				  const void *entry,
+				  const void *entry_or_key,
+				  const void *unused_keydata)
 {
+	const struct working_tree_entry *a = entry;
+	const struct working_tree_entry *b = entry_or_key;
 	return strcmp(a->path, b->path);
 }
 
@@ -149,9 +151,13 @@ struct pair_entry {
 };
 
 static int pair_cmp(const void *unused_cmp_data,
-		    struct pair_entry *a, struct pair_entry *b,
-		    void *unused_keydata)
+		    const void *entry,
+		    const void *entry_or_key,
+		    const void *unused_keydata)
 {
+	const struct pair_entry *a = entry;
+	const struct pair_entry *b = entry_or_key;
+
 	return strcmp(a->path, b->path);
 }
 
@@ -179,9 +185,13 @@ struct path_entry {
 };
 
 static int path_entry_cmp(const void *unused_cmp_data,
-			  struct path_entry *a, struct path_entry *b,
-			  void *key)
+			  const void *entry,
+			  const void *entry_or_key,
+			  const void *key)
 {
+	const struct path_entry *a = entry;
+	const struct path_entry *b = entry_or_key;
+
 	return strcmp(a->path, key ? key : b->path);
 }
 
@@ -372,10 +382,9 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	rdir_len = rdir.len;
 	wtdir_len = wtdir.len;
 
-	hashmap_init(&working_tree_dups,
-		     (hashmap_cmp_fn)working_tree_entry_cmp, NULL, 0);
-	hashmap_init(&submodules, (hashmap_cmp_fn)pair_cmp, NULL, 0);
-	hashmap_init(&symlinks2, (hashmap_cmp_fn)pair_cmp, NULL, 0);
+	hashmap_init(&working_tree_dups, working_tree_entry_cmp, NULL, 0);
+	hashmap_init(&submodules, pair_cmp, NULL, 0);
+	hashmap_init(&symlinks2, pair_cmp, NULL, 0);
 
 	child.no_stdin = 1;
 	child.git_cmd = 1;
@@ -585,10 +594,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	 * in the common case of --symlinks and the difftool updating
 	 * files through the symlink.
 	 */
-	hashmap_init(&wt_modified, (hashmap_cmp_fn)path_entry_cmp,
-		     NULL, wtindex.cache_nr);
-	hashmap_init(&tmp_modified, (hashmap_cmp_fn)path_entry_cmp,
-		     NULL, wtindex.cache_nr);
+	hashmap_init(&wt_modified, path_entry_cmp, NULL, wtindex.cache_nr);
+	hashmap_init(&tmp_modified, path_entry_cmp, NULL, wtindex.cache_nr);
 
 	for (i = 0; i < wtindex.cache_nr; i++) {
 		struct hashmap_entry dummy;
-- 
2.13.0.31.g9b732c453e

