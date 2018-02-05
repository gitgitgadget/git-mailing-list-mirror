Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 928A61F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeBFAOz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:14:55 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38072 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeBFAOx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:14:53 -0500
Received: by mail-pg0-f65.google.com with SMTP id l18so152211pgc.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=slWVEIdYmQJl0B71QRxwPUQlM2umz9fyymChI6q2fFo=;
        b=t9lLnIQUFD6YsaI5K2V316YLNqXK5VGvFyKGKUVOpVmswbFS0uCI09j0nNqonAxuUx
         Wy2qk7ZUuhLbZ3u233Yk1ghpbavL4I/ZMj+Qa+adNEZqauqjloGNNWPbe8Gg3YX/xQW/
         /FqKDdkP/3SvJ09XMBVfxvhd+oxbmGSRLRDfVhdkuu42+URVyrvg/5cGeNCxEEAIoXoe
         myqsTR0NdszKtFl2I84QP7Yxh2X0ah6xrKQ6pihwvXmRAQIkUKiEUYFVCQZT19EfTq/U
         tAsqJKEwN7aYZGsCvVP2FRK0TczmitK3t1oIjFHTobEPt09LGSM7xfSLcWj8e9lJ1a2Z
         U6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=slWVEIdYmQJl0B71QRxwPUQlM2umz9fyymChI6q2fFo=;
        b=YCLHN2y0DMs91t4Tf39x4MhEGDA+ssnCxGeSnSNHAijnokUIjf8bYF5DTFxzAOPi3b
         m7vTJH8bcOr5Mg/aOUAXEx1YAYNJ64GCyI7EdmYm93yNvrZWN/yDHFj1U70/hSjYvrlD
         sZYZBVOQASqtyyC1OxIqza7DQbQA9MyGbRUhqcwQrVVr8Qc70gDHGxSkYUQiyoFWteNd
         LXPGd4BhdDG9zT+fX1NSLcIf7B6v1wD6rPKY3i+hCSq+h8kgsm4BHKMvrRlYq4Yt9qJN
         wE9BWITmTLH4EUSe711/El7/v/sgtdnfOVek78k3kn39Q3N30xGFKCBspS8D5lQkDo5t
         mn0A==
X-Gm-Message-State: APf1xPCE5NFzRWWbuM4ANGOZM8bJ/9jJ1C3qiPr/Ow9M7+5Owltojduq
        znSL2bbzavnTPj3vFJvdY9Ywi8SlRNU=
X-Google-Smtp-Source: AH8x224mvgNfYHVKCcRCJOxNVRQQX7PvrAXi7ItopugHeY5P9+FgSoaUXiA6tSoy0bVL7Ij2G118vA==
X-Received: by 10.101.101.83 with SMTP id a19mr434730pgw.192.1517876092860;
        Mon, 05 Feb 2018 16:14:52 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 204sm18060744pfu.44.2018.02.05.16.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:14:52 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 095/194] object: add repository argument to register_commit_graft
Date:   Mon,  5 Feb 2018 15:55:56 -0800
Message-Id: <20180205235735.216710-75-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of register_commit_graft to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/blame.c                        | 3 ++-
 commit.c                               | 4 ++--
 commit.h                               | 3 ++-
 contrib/coccinelle/object_parser.cocci | 8 ++++++++
 shallow.c                              | 3 ++-
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 005f55aaa2..815b0c75ed 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "repository.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
@@ -490,7 +491,7 @@ static int read_ancestry(const char *graft_file)
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
 		struct commit_graft *graft = read_graft_line(&buf);
 		if (graft)
-			register_commit_graft(graft, 0);
+			register_commit_graft(the_repository, graft, 0);
 	}
 	fclose(fp);
 	strbuf_release(&buf);
diff --git a/commit.c b/commit.c
index f10a882d87..ce18e41e33 100644
--- a/commit.c
+++ b/commit.c
@@ -113,7 +113,7 @@ static int commit_graft_pos_the_repository(const unsigned char *sha1)
 			commit_graft_sha1_access);
 }
 
-int register_commit_graft(struct commit_graft *graft, int ignore_dups)
+int register_commit_graft_the_repository(struct commit_graft *graft, int ignore_dups)
 {
 	int pos = commit_graft_pos(the_repository, graft->oid.hash);
 
@@ -189,7 +189,7 @@ static int read_graft_file(const char *graft_file)
 		struct commit_graft *graft = read_graft_line(&buf);
 		if (!graft)
 			continue;
-		if (register_commit_graft(graft, 1))
+		if (register_commit_graft(the_repository, graft, 1))
 			error("duplicate graft data: %s", buf.buf);
 	}
 	fclose(fp);
diff --git a/commit.h b/commit.h
index 20ad5acabc..c8c5aafcb1 100644
--- a/commit.h
+++ b/commit.h
@@ -176,7 +176,8 @@ struct commit_graft {
 typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
 struct commit_graft *read_graft_line(struct strbuf *line);
-int register_commit_graft(struct commit_graft *, int);
+#define register_commit_graft(r, g, i) register_commit_graft_##r(g, i)
+int register_commit_graft_the_repository(struct commit_graft *, int);
 struct commit_graft *lookup_commit_graft(const struct object_id *oid);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index 60f93c30c4..fc56a90934 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -90,3 +90,11 @@ expression E;
  lookup_commit(
 +the_repository,
  E)
+
+@@
+expression E;
+expression F;
+@@
+ register_commit_graft(
++the_repository,
+ E, F)
diff --git a/shallow.c b/shallow.c
index 97c483239a..925db794fd 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "tempfile.h"
 #include "lockfile.h"
 #include "object-store.h"
@@ -38,7 +39,7 @@ int register_shallow(const struct object_id *oid)
 	graft->nr_parent = -1;
 	if (commit && commit->object.parsed)
 		commit->parents = NULL;
-	return register_commit_graft(graft, 0);
+	return register_commit_graft(the_repository, graft, 0);
 }
 
 int is_repository_shallow(void)
-- 
2.15.1.433.g936d1b9894.dirty

