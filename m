Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5893F1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 09:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfFXJzs (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 05:55:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37919 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfFXJzs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 05:55:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id z75so4225193pgz.5
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 02:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oau9ChYwus5zBZ9qNQz6XQdfI75xvPhKioP2Mmxr0jU=;
        b=sk0hY18T0VOCK4JHmIbFu0dGOOmDZdBi3AfyjcwLW8toEXS/FhmOL4A1zRQYcFq2op
         J99J1c7xUCxsvbBt4SyVJRKYdZEGbyCQwUwTKgg2VB+dcguYIuoDSlBuZqB+kUpvVv+P
         2minG97ZYD69Ega9VBF2n67VzaKbYlD5xjun5sJ/crMGiQFJT2/dc1HegspySOta7P5N
         AkPrjGk3iZWiMGZFrpG7tobdRYBTmN9YNGYMcllKEtph24xTaY+/f63WTzPeT/ym2LDU
         hEdDGvpbJvULicKWvTSNCg9EWeAWV609dL6nBcRl136epNfKHEwalAkOoypESCjFdO0L
         kUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oau9ChYwus5zBZ9qNQz6XQdfI75xvPhKioP2Mmxr0jU=;
        b=jSsl2DspNG+7kbFeCs9IO58f6vflQnVgVhvJk+Gesfw/ephowT0ZTRsLNnk+DCeqL4
         YNIrRLn7LWlSkH9uPTiuLyxaSmJDGgD9My+ObAXIPNzjKAlDS1FluerZIFTp8VZrSN+8
         /E4+p7dgm4Qt3ozjFWbpy8j5+3yvYajU185bQCJpmIJJOATGujZZylDeN4l/UEwbFWuf
         jV5R4qAcakKnygXk5XogyHQOsnjJKPwg7YlIIxiZtGyMrgvy7LaGkR588eXD8fUfRxG8
         dg8jAj4FMPB8ghr2shC1DDhp9mgO1M/kqJd5Y1ybUshgZ6X5twzgRaW3YiQqFUfL5Lpo
         mKiA==
X-Gm-Message-State: APjAAAU/FRm+DDKYYZVAg/iJzUKs8NbrI5trqgoAtG2vC4Empse/SBwM
        m8K+CTUrVDCMqWHEPFuTE5ahiK0/
X-Google-Smtp-Source: APXvYqzckC9Su7FFBIEO+lBgARDW1J4jL8P1XFHEiimRBqagOi+cfAWQFkhd5QSEuCdr6hQ0DtpI0w==
X-Received: by 2002:a65:4cc4:: with SMTP id n4mr4171574pgt.307.1561370147308;
        Mon, 24 Jun 2019 02:55:47 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id 1sm10644769pfe.102.2019.06.24.02.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 02:55:46 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 16:55:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/6] sha1-file.c: remove the_repo from read_object_with_reference()
Date:   Mon, 24 Jun 2019 16:55:28 +0700
Message-Id: <20190624095533.22162-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190624095533.22162-1-pclouds@gmail.com>
References: <20190624095533.22162-1-pclouds@gmail.com>
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
index 580fd38f41..85da7ee542 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -458,7 +458,8 @@ static int grep_submodule(struct grep_opt *opt,
 		object = parse_object_or_die(oid, oid_to_hex(oid));
 
 		grep_read_lock();
-		data = read_object_with_reference(&object->oid, tree_type,
+		data = read_object_with_reference(opt->repo,
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

