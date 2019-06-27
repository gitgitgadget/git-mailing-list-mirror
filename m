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
	by dcvr.yhbt.net (Postfix) with ESMTP id C20521F461
	for <e@80x24.org>; Thu, 27 Jun 2019 09:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfF0J3n (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 05:29:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43999 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0J3m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 05:29:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so739948pgv.10
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S63AW2pJtLusv23Kpz1HokqIZylsQ2eZ3S/YyuC2ld8=;
        b=qU+4VZR0Teq9+NYeTxUSKyWhL3f08tKx+xp2scz6sVOTu3fQyGp+lC6jKcQpPqfsM0
         MAJQVpCOLcDpO5MGeWv20QiGGBLwEfzHpvx+uHy/1+SrZEJn4h7hVrtbVBgbtjXAUO4x
         tPcCYo1/E8301/2ABTaqTWg39KGZT7hxhDgroi3o6XabQF6LUNhw9p67KDppv+/vJrtr
         qm48ICR07xwTBvTsJTDwqWv5nQ4RJAWHJ3f6gWW0Mwliqa77YLTnZPlPLwUwWxcOapst
         vALi6IpGF3AwHkrnAysU6mzJFZ5kv4qsXHRaTgeOKOLlcZ7FeqKMMNkyDrAY9DUrmQ3f
         xjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S63AW2pJtLusv23Kpz1HokqIZylsQ2eZ3S/YyuC2ld8=;
        b=NGr4mIEsbSaBEBheMsFxWCFc7jhux+C4hCmRwgs4Y4aq6rvJ4D5woqAto2gHpbB/ZD
         e2jDYmqvqB2OBZ7THP8iUa5+6pyLmUF2qBrdZDjQqpR2eicZncGeGxw9vGpbqV1Q/Ha2
         jSHStRie4fi9OB+QUwA47rqxVhjRPpnvcNXqA6+t3UlzMUekH0MBGQdvrq08Faw4hyDr
         CykoULdwF4A4glgW48qL4omyXg7oQQJNO2IHOUTte2j9xQQS475Dv3wIkLe3SRuirIh4
         eDT2c/H4J2fZNvWCpgxpVOguOHJb6EpcvJ9dYmXEqAn4Cqkgy0zIucICLVtHk4sCwNVb
         yhxg==
X-Gm-Message-State: APjAAAX+7X/Mk+ZWY1pRsLO4ia4yLLSrmSdY9tR17jFAqdapvqzWmSyk
        hdMay/s34bMuUSS9wePdGzk=
X-Google-Smtp-Source: APXvYqwX9/Y0oAJmbWtbtMWh/Z6DzwXF4yI91DSqWpXleZUkZSEF2+jdQXTneP8yq90fYBhpBCe9tQ==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr5051004pjr.116.1561627781661;
        Thu, 27 Jun 2019 02:29:41 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id e189sm2334915pfh.50.2019.06.27.02.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 02:29:41 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 27 Jun 2019 16:29:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 4/6] tree-walk.c: remove the_repo from get_tree_entry_follow_symlinks()
Date:   Thu, 27 Jun 2019 16:28:50 +0700
Message-Id: <20190627092852.11326-5-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1-name.c | 10 +---------
 tree-walk.c | 12 ++++++++----
 tree-walk.h |  2 +-
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index e8fb215e5c..3c9fa10af8 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1890,16 +1890,8 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			new_filename = resolve_relative_path(repo, filename);
 			if (new_filename)
 				filename = new_filename;
-			/*
-			 * NEEDSWORK: Eventually get_tree_entry*() should
-			 * learn to take struct repository directly and we
-			 * would not need to inject submodule odb to the
-			 * in-core odb.
-			 */
-			if (repo != the_repository)
-				add_to_alternates_memory(repo->objects->odb->path);
 			if (flags & GET_OID_FOLLOW_SYMLINKS) {
-				ret = get_tree_entry_follow_symlinks(&tree_oid,
+				ret = get_tree_entry_follow_symlinks(repo, &tree_oid,
 					filename, oid, &oc->symlink_path,
 					&oc->mode);
 			} else {
diff --git a/tree-walk.c b/tree-walk.c
index 506e12a031..c20b62f49e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -593,7 +593,10 @@ int get_tree_entry(struct repository *r,
  * See the code for enum get_oid_result for a description of
  * the return values.
  */
-enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned short *mode)
+enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
+		struct object_id *tree_oid, const char *name,
+		struct object_id *result, struct strbuf *result_path,
+		unsigned short *mode)
 {
 	int retval = MISSING_OBJECT;
 	struct dir_state *parents = NULL;
@@ -617,7 +620,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, c
 			void *tree;
 			struct object_id root;
 			unsigned long size;
-			tree = read_object_with_reference(the_repository,
+			tree = read_object_with_reference(r,
 							  &current_tree_oid,
 							  tree_type, &size,
 							  &root);
@@ -687,7 +690,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, c
 		}
 
 		/* Look up the first (or only) path component in the tree. */
-		find_result = find_tree_entry(the_repository, &t, namebuf.buf,
+		find_result = find_tree_entry(r, &t, namebuf.buf,
 					      &current_tree_oid, mode);
 		if (find_result) {
 			goto done;
@@ -731,7 +734,8 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, c
 			 */
 			retval = DANGLING_SYMLINK;
 
-			contents = read_object_file(&current_tree_oid, &type,
+			contents = repo_read_object_file(r,
+						    &current_tree_oid, &type,
 						    &link_len);
 
 			if (!contents)
diff --git a/tree-walk.h b/tree-walk.h
index 639f79187f..2a5db29e8f 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -53,7 +53,7 @@ struct traverse_info;
 typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
 int traverse_trees(struct index_state *istate, int n, struct tree_desc *t, struct traverse_info *info);
 
-enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned short *mode);
+enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r, struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned short *mode);
 
 struct traverse_info {
 	const char *traverse_path;
-- 
2.22.0.rc0.322.g2b0371e29a

