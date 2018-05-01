Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB1E1FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeEAVek (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:34:40 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46114 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeEAVeR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:34:17 -0400
Received: by mail-pg0-f66.google.com with SMTP id z4-v6so9080277pgu.13
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RSAgRbt086pHDMhW3HVnQJ+99SA4l6bMilyy/0X/jvA=;
        b=e0e4FM6Fl6SGi1Bl8Z6zJnrbW4hCgyjlZZ35dzlx7NRy5pNqozbJil0+cfpfLv2UEL
         tm+HiVjkOWvRTAPCJ+Z8sChzVcCDYYsgS5/BmDqKGn7YdnV9D+2oOAMSlS8JsGv4DTvI
         A8r2gEhEi36Q4fjje4eO+BwIqk4d74SDCnf2DK3j4HevGPVd5ccL4ytf47eGCeU44ZYy
         fOcjxFFMT6jNai9MRQlR22DGi8RhgnkqstzTnsqj2Wa5o0g9OrFxTZn6z+cfl0creMuV
         b8N4I57z/CBEtVFbaq8P3Dl4f9Jnp3xFmcPQ12T53uuXu8BJzg4a2K2sgN/Oe6Og4eUn
         tNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RSAgRbt086pHDMhW3HVnQJ+99SA4l6bMilyy/0X/jvA=;
        b=tbMweAlJgocBrHaAiFnGcVvHr8dsciNX5bP4dBiNSsfzPdiQFfhPR5+eT5CVbRTYiB
         xywIL6vZGUmmXkJa+j2muTiWktBMG8+7Su8MYAVBnBzUt5DruCxYO2CGsY6K7oIwdnZS
         j2CowwixHi2dmPqVYNqeVRv6Oi6/I/+lftpA1lWqST4n0WXJfiklZ8dt6l+muEEQnlXh
         s38M0W3YhHVM4NgizrEzavM5nR1vrerUmX8IIscjrnPXVl/jUXmPBS6ZGhoL9QONG2pH
         MtMkXB7RNMFR2OqfgiVgDD9TMvmQjuhHtYOcRpTVieiJNzVxXZ1ZdeSjSguhd+yUvi2Q
         Bzow==
X-Gm-Message-State: ALQs6tCJK61gwlRonTjyM6YQMNpBYAdA8ew3tyZZ03FACxlNR8EboqMG
        NQlU/g/hG8GAX2IEzPyrHQwCJqjeLL0=
X-Google-Smtp-Source: AB8JxZqruPlrPFfG8sliqAaQEmxYTpzUbcorOVc0RvK23SVmTNRyQMepnpVr7uKEzfvkpJSDhU06ew==
X-Received: by 10.98.159.21 with SMTP id g21mr16733400pfe.207.1525210456626;
        Tue, 01 May 2018 14:34:16 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f21sm18460985pfa.106.2018.05.01.14.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 14:34:16 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/13] alloc: add repository argument to alloc_commit_node
Date:   Tue,  1 May 2018 14:33:56 -0700
Message-Id: <20180501213403.14643-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alloc.c           | 2 +-
 blame.c           | 2 +-
 cache.h           | 3 ++-
 commit.c          | 2 +-
 merge-recursive.c | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/alloc.c b/alloc.c
index 2c8d1430758..9e2b897ec1d 100644
--- a/alloc.c
+++ b/alloc.c
@@ -88,7 +88,7 @@ unsigned int alloc_commit_index(void)
 	return count++;
 }
 
-void *alloc_commit_node(void)
+void *alloc_commit_node_the_repository(void)
 {
 	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
 	c->object.type = OBJ_COMMIT;
diff --git a/blame.c b/blame.c
index dfa24473dc6..ba9b18e7542 100644
--- a/blame.c
+++ b/blame.c
@@ -161,7 +161,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 
 	read_cache();
 	time(&now);
-	commit = alloc_commit_node();
+	commit = alloc_commit_node(the_repository);
 	commit->object.parsed = 1;
 	commit->date = now;
 	parent_tail = &commit->parents;
diff --git a/cache.h b/cache.h
index 1717d07a2c5..bf6e8c87d83 100644
--- a/cache.h
+++ b/cache.h
@@ -1768,7 +1768,8 @@ void encode_85(char *buf, const unsigned char *data, int bytes);
 extern void *alloc_blob_node_the_repository(void);
 #define alloc_tree_node(r) alloc_tree_node_##r()
 extern void *alloc_tree_node_the_repository(void);
-extern void *alloc_commit_node(void);
+#define alloc_commit_node(r) alloc_commit_node_##r()
+extern void *alloc_commit_node_the_repository(void);
 extern void *alloc_tag_node(void);
 extern void *alloc_object_node(void);
 extern void alloc_report(void);
diff --git a/commit.c b/commit.c
index 9106acf0aad..a9a43e79bae 100644
--- a/commit.c
+++ b/commit.c
@@ -51,7 +51,7 @@ struct commit *lookup_commit(const struct object_id *oid)
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
-				     alloc_commit_node());
+				     alloc_commit_node(the_repository));
 	return object_as_type(obj, OBJ_COMMIT, 0);
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 0c0d48624da..6dac8908648 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -98,7 +98,7 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 
 static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
 {
-	struct commit *commit = alloc_commit_node();
+	struct commit *commit = alloc_commit_node(the_repository);
 
 	set_merge_remote_desc(commit, comment, (struct object *)commit);
 	commit->tree = tree;
-- 
2.17.0.441.gb46fe60e1d-goog

