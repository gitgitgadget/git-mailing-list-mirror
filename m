Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271FC1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 09:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfF0J32 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 05:29:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39956 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0J32 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 05:29:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so746626pgj.7
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Lm4pFHCblsHG8PFC0oOn5zPdfLuSZk2/nKsJCjWUXc=;
        b=gbx3ZMh40mcRbWIJBaMZwWuoqJGWiybhje7Zn84KS6OnhqeahrObMnrHu9jdZi5JFG
         rh5wD4yHbdepjshsnuWGkkcGn9P/dm/nGMrEcTCcDSloExw5fDmjbzWQP8xHocI0AYCU
         1dvOUOJTMMBv2w3e6HihWnRpgqgMRIUbrdQIQOyLaxl7oASIiTPkqK0L4ehBvw9g/7FU
         lBCxCavS/izpGJUWb4K/zG8HmQWPAmWxreenxi20I/IWMn36ApfPJV1Ekj3RoW3pAUwZ
         A+H4GfkRsfXn3gZVtSaVIeWyM+fn7TKMSNFeMx+cRvtKkcc9g2yb3YUMpy2rhRHGG9e7
         NNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Lm4pFHCblsHG8PFC0oOn5zPdfLuSZk2/nKsJCjWUXc=;
        b=OoIIfDq1ab9C0/tozmUfDt3kbrP6lMvOjYgPLFUMHVEmtoUg65epbS0iUF9oYfdD6k
         J0tIq4FE3dE4Ne1yf06F5VU0F4uSwDjHhLHgdWr8pNGMD0nbq1GbrJQRB0suUTHXpJo0
         hZ8vLYiCIFJiXIakVoAgoVZSWMknk0XjVJx9D4AVNTl579EZ3qErKuT5eygVRU/heQmC
         Nkk/mhi4GJdKPbL1nZ7lxzzCkXqjGFawxfokJs/xJPw2eQcH38DpmUOeNDRjC+wLG9tw
         2n5BZmzRqN8hySTsTc3BeoeJjPBWKrKlrOx2/aPq8mQnnQeXv5x5Hhg/4GllpifWA1EQ
         U9qA==
X-Gm-Message-State: APjAAAVIZAXNFHeaxjembbGrT1ZM2dex9HZ0oOlwtjnwmaBXjoUvG5wU
        p8fe3JnbETs+M2o30p+mY+Q=
X-Google-Smtp-Source: APXvYqxgXZteO7WeeThe7uXKv6w3Xff1p6dD6GuiBSt2MhTzMH8HvW1Onc+knrNe+2c+1tsuUb4Glg==
X-Received: by 2002:a17:90b:f0e:: with SMTP id br14mr4788902pjb.117.1561627767289;
        Thu, 27 Jun 2019 02:29:27 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id w187sm2791241pfb.4.2019.06.27.02.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 02:29:26 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 27 Jun 2019 16:29:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/6] sha1-file.c: remove the_repo from read_object_with_reference()
Date:   Thu, 27 Jun 2019 16:28:47 +0700
Message-Id: <20190627092852.11326-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190627092852.11326-1-pclouds@gmail.com>
References: <20190624095533.22162-1-pclouds@gmail.com>
 <20190627092852.11326-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/cat-file.c     | 3 ++-
 builtin/grep.c         | 6 ++++--
 builtin/pack-objects.c | 3 ++-
 cache.h                | 3 ++-
 fast-import.c          | 9 ++++++---
 sha1-file.c            | 5 +++--
 tree-walk.c            | 7 ++++---
 7 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0f092382e1..995d47c85a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -172,7 +172,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			 * fall-back to the usual case.
 			 */
 		}
-		buf = read_object_with_reference(&oid, exp_type, &size, NULL);
+		buf = read_object_with_reference(the_repository,
+						 &oid, exp_type, &size, NULL);
 		break;
 
 	default:
diff --git a/builtin/grep.c b/builtin/grep.c
index 580fd38f41..560051784e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -458,7 +458,8 @@ static int grep_submodule(struct grep_opt *opt,
 		object = parse_object_or_die(oid, oid_to_hex(oid));
 
 		grep_read_lock();
-		data = read_object_with_reference(&object->oid, tree_type,
+		data = read_object_with_reference(&subrepo,
+						  &object->oid, tree_type,
 						  &size, NULL);
 		grep_read_unlock();
 
@@ -623,7 +624,8 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		int hit, len;
 
 		grep_read_lock();
-		data = read_object_with_reference(&obj->oid, tree_type,
+		data = read_object_with_reference(opt->repo,
+						  &obj->oid, tree_type,
 						  &size, NULL);
 		grep_read_unlock();
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b2be8869c2..a030c24a4a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1428,7 +1428,8 @@ static void add_preferred_base(struct object_id *oid)
 	if (window <= num_preferred_base++)
 		return;
 
-	data = read_object_with_reference(oid, tree_type, &size, &tree_oid);
+	data = read_object_with_reference(the_repository, oid,
+					  tree_type, &size, &tree_oid);
 	if (!data)
 		return;
 
diff --git a/cache.h b/cache.h
index bf20337ef4..cd84cc9bbe 100644
--- a/cache.h
+++ b/cache.h
@@ -1500,7 +1500,8 @@ int df_name_compare(const char *name1, int len1, int mode1, const char *name2, i
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-void *read_object_with_reference(const struct object_id *oid,
+void *read_object_with_reference(struct repository *r,
+				 const struct object_id *oid,
 				 const char *required_type,
 				 unsigned long *size,
 				 struct object_id *oid_ret);
diff --git a/fast-import.c b/fast-import.c
index 76a7bd3699..3970b50acc 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2410,7 +2410,8 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 		oidcpy(&commit_oid, &commit_oe->idx.oid);
 	} else if (!get_oid(p, &commit_oid)) {
 		unsigned long size;
-		char *buf = read_object_with_reference(&commit_oid,
+		char *buf = read_object_with_reference(the_repository,
+						       &commit_oid,
 						       commit_type, &size,
 						       &commit_oid);
 		if (!buf || size < the_hash_algo->hexsz + 6)
@@ -2482,7 +2483,8 @@ static void parse_from_existing(struct branch *b)
 		unsigned long size;
 		char *buf;
 
-		buf = read_object_with_reference(&b->oid, commit_type, &size,
+		buf = read_object_with_reference(the_repository,
+						 &b->oid, commit_type, &size,
 						 &b->oid);
 		parse_from_commit(b, buf, size);
 		free(buf);
@@ -2560,7 +2562,8 @@ static struct hash_list *parse_merge(unsigned int *count)
 			oidcpy(&n->oid, &oe->idx.oid);
 		} else if (!get_oid(from, &n->oid)) {
 			unsigned long size;
-			char *buf = read_object_with_reference(&n->oid,
+			char *buf = read_object_with_reference(the_repository,
+							       &n->oid,
 							       commit_type,
 							       &size, &n->oid);
 			if (!buf || size < the_hash_algo->hexsz + 6)
diff --git a/sha1-file.c b/sha1-file.c
index 888b6024d5..59b2e40cf3 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1505,7 +1505,8 @@ void *read_object_file_extended(struct repository *r,
 	return NULL;
 }
 
-void *read_object_with_reference(const struct object_id *oid,
+void *read_object_with_reference(struct repository *r,
+				 const struct object_id *oid,
 				 const char *required_type_name,
 				 unsigned long *size,
 				 struct object_id *actual_oid_return)
@@ -1521,7 +1522,7 @@ void *read_object_with_reference(const struct object_id *oid,
 		int ref_length = -1;
 		const char *ref_type = NULL;
 
-		buffer = read_object_file(&actual_oid, &type, &isize);
+		buffer = repo_read_object_file(r, &actual_oid, &type, &isize);
 		if (!buffer)
 			return NULL;
 		if (type == required_type) {
diff --git a/tree-walk.c b/tree-walk.c
index ec32a47b2e..0c7722b220 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -87,7 +87,7 @@ void *fill_tree_descriptor(struct tree_desc *desc, const struct object_id *oid)
 	void *buf = NULL;
 
 	if (oid) {
-		buf = read_object_with_reference(oid, tree_type, &size, NULL);
+		buf = read_object_with_reference(the_repository, oid, tree_type, &size, NULL);
 		if (!buf)
 			die("unable to read tree %s", oid_to_hex(oid));
 	}
@@ -542,7 +542,7 @@ int get_tree_entry(const struct object_id *tree_oid, const char *name, struct ob
 	unsigned long size;
 	struct object_id root;
 
-	tree = read_object_with_reference(tree_oid, tree_type, &size, &root);
+	tree = read_object_with_reference(the_repository, tree_oid, tree_type, &size, &root);
 	if (!tree)
 		return -1;
 
@@ -609,7 +609,8 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, c
 			void *tree;
 			struct object_id root;
 			unsigned long size;
-			tree = read_object_with_reference(&current_tree_oid,
+			tree = read_object_with_reference(the_repository,
+							  &current_tree_oid,
 							  tree_type, &size,
 							  &root);
 			if (!tree)
-- 
2.22.0.rc0.322.g2b0371e29a

