Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 447011F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbeGQMkm (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 08:40:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39578 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731537AbeGQMjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so1006040wre.6
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 05:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ZYHdLLAC/kpYTF2zrZEyY5qA1GSgA0qoYEM6+s/Sd80=;
        b=UE4VV2E9AFLPjIuczcVxHA8TixfILDKH+9PmW2teociqZpFgw5yRRT1mnQA4a1L3Wj
         up91k8opxFWEXR3sJMOk/Zfwv2OhckkHcYQlkAXkSTE5GvBInj0gWfU9ZfbNnnV3CSRH
         Noma051dhswqTUcvPbrAB3MFZx7C4GClTeSylswnbSMiQgbRPME/zNCNhsx/juDoay3T
         1piAeebvkH3hv9k4yLQgtMryYSFQeVfRN5UicZPwalMXQriGztwL5BFionyVPQyYVCdE
         4cGKEoSKa53ROeC23lP+8GwvtqQwU9ybC93HApKUI27IQBy7p1B8dKgNoHY2TTFJCjIO
         yM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ZYHdLLAC/kpYTF2zrZEyY5qA1GSgA0qoYEM6+s/Sd80=;
        b=ADLg9ySJTUIplHridcqf+M2j9jJxVA2fpSl/do9H+++ud+61ET26MoATauCw7dikW2
         48zTXDJ6EKroZN6Ryo8IbtGxymbL4cJVlPtxc5/Fh/hBI7JPs1XLEB36irm0LNxLkzwJ
         mIJ8rWnNdYYTuzE70u3wo6qUpknutp7dNmtTJ2iIa2P82RpEpk+2X/k+GIjdnOksOCMM
         +YY8cl/FDDTqGan54YjzcF0OodFC1ddjRdz8799EetgYM1sV1/kCu6de6rlHpeNC6aDj
         3zc6ii/pUKYiEevRmnlNmD88BkbbnusiHctEfnlnxBj81GOE0lJopt7Be466PhQewZpb
         DaEg==
X-Gm-Message-State: AOUpUlHacBiSmc67iSypETGFjQC8WhTvbNzPuUeg4RZTOng6YtV/CudQ
        1OZqx/5K9hiGyiOfPxSgYW8Spg==
X-Google-Smtp-Source: AAOMgpftt2JgRUJpOVcptWJIV9Bz0F0CvixmvHKy6m4HCfiC3kZOT7Hwc3R/vSH0mYNRBO7Enj4HYQ==
X-Received: by 2002:a5d:41c1:: with SMTP id e1-v6mr1192383wrq.25.1531829207590;
        Tue, 17 Jul 2018 05:06:47 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-157-218.residential.rdsnet.ro. [5.13.157.218])
        by smtp.gmail.com with ESMTPSA id d4-v6sm542099wrp.51.2018.07.17.05.06.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 05:06:47 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 2/6] tree-walk: Add three new gentle helpers
Date:   Tue, 17 Jul 2018 15:06:32 +0300
Message-Id: <b1f385105f790cafc65c26699282919a2735d4bd.1531778417.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.184.ga79db55c2.dirty
In-Reply-To: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
References: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add `get_tree_entry_gently()`, `find_tree_entry_gently()`
and `get_tree_entry_follow_symlinks_gently()`, which will
make `get_oid()` to be more gently.

Since `get_tree_entry()` is used in more than 20 places,
adding a new parameter will make this commit harder to read.
In every place it is called there will need to be an additional
0 parameter at the end of the call. The solution to avoid this is
to rename the function in `get_tree_entry_gently()` which gets
an additional `flags` variable. A new `get_tree_entry()`
will call `get_tree_entry_gently()` with `flags` being 0.
This way, no additional changes will be needed.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 sha1-name.c |   2 +-
 tree-walk.c | 108 +++++++++++++++++++++++++++++++++++++++++++---------
 tree-walk.h |   3 +-
 3 files changed, 94 insertions(+), 19 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 60d9ef3c7..d741e1129 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1721,7 +1721,7 @@ static int get_oid_with_context_1(const char *name,
 			if (flags & GET_OID_FOLLOW_SYMLINKS) {
 				ret = get_tree_entry_follow_symlinks(&tree_oid,
 					filename, oid, &oc->symlink_path,
-					&oc->mode);
+					&oc->mode, flags);
 			} else {
 				ret = get_tree_entry(&tree_oid, filename, oid,
 						     &oc->mode);
diff --git a/tree-walk.c b/tree-walk.c
index 8f5090862..2925eaec2 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -491,7 +491,9 @@ struct dir_state {
 	struct object_id oid;
 };
 
-static int find_tree_entry(struct tree_desc *t, const char *name, struct object_id *result, unsigned *mode)
+static int find_tree_entry(struct tree_desc *t, const char *name,
+				  struct object_id *result, unsigned *mode,
+				  int flags)
 {
 	int namelen = strlen(name);
 	while (t->size) {
@@ -501,7 +503,11 @@ static int find_tree_entry(struct tree_desc *t, const char *name, struct object_
 
 		oid = tree_entry_extract(t, &entry, mode);
 		entrylen = tree_entry_len(&t->entry);
-		update_tree_entry(t);
+
+		if (!(flags & GET_OID_GENTLY))
+			update_tree_entry(t);
+		else if (update_tree_entry_gently(t))
+			return -1;
 		if (entrylen > namelen)
 			continue;
 		cmp = memcmp(name, entry, entrylen);
@@ -521,19 +527,28 @@ static int find_tree_entry(struct tree_desc *t, const char *name, struct object_
 			oidcpy(result, oid);
 			return 0;
 		}
-		return get_tree_entry(oid, name + entrylen, result, mode);
+		return get_tree_entry_gently(oid, name + entrylen, result, mode, flags);
 	}
 	return -1;
 }
 
-int get_tree_entry(const struct object_id *tree_oid, const char *name, struct object_id *oid, unsigned *mode)
+int get_tree_entry_gently(const struct object_id *tree_oid, const char *name,
+			  struct object_id *oid, unsigned *mode, int flags)
 {
 	int retval;
 	void *tree;
 	unsigned long size;
 	struct object_id root;
 
-	tree = read_object_with_reference(tree_oid, tree_type, &size, &root);
+	if (!(flags & GET_OID_GENTLY)) {
+		tree = read_object_with_reference(tree_oid, tree_type, &size, &root);
+	} else {
+		struct object_info oi = OBJECT_INFO_INIT;
+
+		oi.contentp = tree;
+		if (oid_object_info_extended(the_repository, tree_oid, &oi, 0) < 0)
+			return -1;
+	}
 	if (!tree)
 		return -1;
 
@@ -547,13 +562,27 @@ int get_tree_entry(const struct object_id *tree_oid, const char *name, struct ob
 		retval = -1;
 	} else {
 		struct tree_desc t;
-		init_tree_desc(&t, tree, size);
-		retval = find_tree_entry(&t, name, oid, mode);
+		if (!(flags & GET_OID_GENTLY)) {
+			init_tree_desc(&t, tree, size);
+		} else {
+			if (init_tree_desc_gently(&t, tree, size)) {
+				retval = -1;
+				goto done;
+			}
+		}
+		retval = find_tree_entry(&t, name, oid, mode, flags);
 	}
+done:
 	free(tree);
 	return retval;
 }
 
+int get_tree_entry(const struct object_id *tree_oid, const char *name,
+		   struct object_id *oid, unsigned *mode)
+{
+	return get_tree_entry_gently(tree_oid, name, oid, mode, 0);
+}
+
 /*
  * This is Linux's built-in max for the number of symlinks to follow.
  * That limit, of course, does not affect git, but it's a reasonable
@@ -576,7 +605,7 @@ int get_tree_entry(const struct object_id *tree_oid, const char *name, struct ob
  * See the code for enum follow_symlink_result for a description of
  * the return values.
  */
-enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned *mode)
+enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned *mode, int flags)
 {
 	int retval = MISSING_OBJECT;
 	struct dir_state *parents = NULL;
@@ -600,9 +629,21 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tre
 			void *tree;
 			struct object_id root;
 			unsigned long size;
-			tree = read_object_with_reference(&current_tree_oid,
-							  tree_type, &size,
-							  &root);
+			if (!(flags & GET_OID_GENTLY)) {
+				tree = read_object_with_reference(&current_tree_oid,
+								  tree_type, &size,
+								  &root);
+			} else {
+				struct object_info oi = OBJECT_INFO_INIT;
+
+				oi.contentp = tree;
+				if (oid_object_info_extended(the_repository,
+				    &current_tree_oid, &oi, 0) < 0) {
+					retval = MISSING_OBJECT;
+					goto done;
+				}
+			}
+
 			if (!tree)
 				goto done;
 
@@ -622,7 +663,14 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tre
 				goto done;
 
 			/* descend */
-			init_tree_desc(&t, tree, size);
+			if (!(flags & GET_OID_GENTLY)) {
+				init_tree_desc(&t, tree, size);
+			} else {
+				if (init_tree_desc_gently(&t, tree, size)) {
+					retval = MISSING_OBJECT;
+					goto done;
+				}
+			}
 		}
 
 		/* Handle symlinks to e.g. a//b by removing leading slashes */
@@ -656,7 +704,15 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tre
 			free(parent->tree);
 			parents_nr--;
 			parent = &parents[parents_nr - 1];
-			init_tree_desc(&t, parent->tree, parent->size);
+			if (!(flags & GET_OID_GENTLY)) {
+				init_tree_desc(&t, parent->tree, parent->size);
+			} else {
+				if (init_tree_desc_gently(&t, parent->tree,
+				    parent->size)) {
+					retval = MISSING_OBJECT;
+					goto done;
+				}
+			}
 			strbuf_remove(&namebuf, 0, remainder ? 3 : 2);
 			continue;
 		}
@@ -670,7 +726,7 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tre
 
 		/* Look up the first (or only) path component in the tree. */
 		find_result = find_tree_entry(&t, namebuf.buf,
-					      &current_tree_oid, mode);
+					      &current_tree_oid, mode, flags);
 		if (find_result) {
 			goto done;
 		}
@@ -713,8 +769,19 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tre
 			 */
 			retval = DANGLING_SYMLINK;
 
-			contents = read_object_file(&current_tree_oid, &type,
-						    &link_len);
+			if (!(flags & GET_OID_GENTLY)) {
+				contents = read_object_file(&current_tree_oid,
+							    &type, &link_len);
+			} else {
+				struct object_info oi = OBJECT_INFO_INIT;
+				oi.contentp = (void*) contents;
+
+				if (oid_object_info_extended(the_repository,
+				    &current_tree_oid, &oi, 0) < 0) {
+					retval = MISSING_OBJECT;
+					goto done;
+				}
+			}
 
 			if (!contents)
 				goto done;
@@ -735,7 +802,14 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tre
 			contents_start = contents;
 
 			parent = &parents[parents_nr - 1];
-			init_tree_desc(&t, parent->tree, parent->size);
+			if (!(flags & GET_OID_GENTLY)) {
+				init_tree_desc(&t, parent->tree, parent->size);
+			} else {
+				if (init_tree_desc_gently(&t, parent->tree, parent->size)) {
+					retval = MISSING_OBJECT;
+					goto done;
+				}
+			}
 			strbuf_splice(&namebuf, 0, len,
 				      contents_start, link_len);
 			if (remainder)
diff --git a/tree-walk.h b/tree-walk.h
index 805f58f00..6f043af6e 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -64,7 +64,7 @@ enum follow_symlinks_result {
 		       */
 };
 
-enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned *mode);
+enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned *mode, int flags);
 
 struct traverse_info {
 	const char *traverse_path;
@@ -79,6 +79,7 @@ struct traverse_info {
 	int show_all_errors;
 };
 
+int get_tree_entry_gently(const struct object_id *, const char *, struct object_id *, unsigned *, int);
 int get_tree_entry(const struct object_id *, const char *, struct object_id *, unsigned *);
 extern char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n);
 extern void setup_traverse_info(struct traverse_info *info, const char *base);
-- 
2.18.0.rc2.184.ga79db55c2.dirty

