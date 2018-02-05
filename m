Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DA5B1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeBFAMM (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:12:12 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45920 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeBFAMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:12:09 -0500
Received: by mail-pg0-f67.google.com with SMTP id m136so130502pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/6fKbyolcmyuITaHRtf0LGjRau4iMquXZpwVJsZiq9A=;
        b=Ypu08pko8fSA0u417Ks4BD7CNb/ZNCsdGK/LrvBQ2ZrleruskvYM4/zRBBNX8upAzv
         +wE1pPis1wCmQgkXASxwYCXtfj7779ms7qlJdUPbzkJBYb4Lh0e1QaREzhPK7AlVZgaC
         SI7d5AubJtbdrgAeI1zu1TunwRLh/fpe/bLGG8U4NMCtW8+s4P/IPxdiYN+G8KHxYUJ2
         BRRAsa+GfbCsJ9dTJd2zK+F4jecejfrj80Kh0wR9MNs33tsCPGsf1eBRBp74CwBAbUjL
         v0/Zn4y+Emls3mZRkz4M9PCj1TtBD20Y4fqWUbYymI29i6EINxyL7a0FSkVDYMZ4ce5M
         lUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/6fKbyolcmyuITaHRtf0LGjRau4iMquXZpwVJsZiq9A=;
        b=AxWC/71llKkS/V/t1XiP8KS3lo3NhsY7OqV9jBRYGJTjkwaW9mbPjN2BWbTpbbereg
         aDjcdUKnxk/Sk4TO0lsMGI62QYTvaQ7qm5GNKYMFPVWROcMoD96asoeDCPefyS/4KhrM
         x59icbydlPraS5LWACnhE6SsWH+vwIdqPC8dIbLqFjMCUnRpAoQwulyNmeLzwsR2BBfy
         jzLpAQLJA+d3ljrK1QOrs9L3Mv3sXUSEuASeQtEq73yBt9dzgZo7nOEEm7Er19oGsDqY
         bBqd0LF9dsJwn3DdlN0BTeRWnAwY7a+WdXk8Tq1hZYuVihuhLl1ibk5F/3z9z1+bGcLL
         ybsQ==
X-Gm-Message-State: APf1xPBcI+KuWWtAYJvdJ3CU/FGDXJ1hr6cmnvxOqf/AZxDDLwsdDdcH
        mD3cNKQp/FyvtLGpUPLPADNBuQu9meU=
X-Google-Smtp-Source: AH8x224H0VNWGMgV0sqSBA2pSqBqxU9azjaZSOYc/BJticC3oWPg6JT/mmamEC6r8EZMzvanOjlgZw==
X-Received: by 10.99.102.193 with SMTP id a184mr428316pgc.141.1517875927985;
        Mon, 05 Feb 2018 16:12:07 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id u67sm18365198pfd.169.2018.02.05.16.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:12:07 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 084/194] blob: add repository argument to lookup_blob
Date:   Mon,  5 Feb 2018 15:55:45 -0800
Message-Id: <20180205235735.216710-64-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of lookup_blob
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Add the cocci patch that converted the callers.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blob.c                                 | 2 +-
 blob.h                                 | 3 ++-
 builtin/describe.c                     | 2 +-
 builtin/fast-export.c                  | 2 +-
 builtin/fsck.c                         | 3 ++-
 builtin/index-pack.c                   | 2 +-
 builtin/merge-tree.c                   | 3 ++-
 builtin/unpack-objects.c               | 2 +-
 contrib/coccinelle/object_parser.cocci | 7 +++++++
 fsck.c                                 | 2 +-
 http-push.c                            | 3 ++-
 list-objects.c                         | 2 +-
 object.c                               | 4 ++--
 reachable.c                            | 2 +-
 revision.c                             | 4 ++--
 tag.c                                  | 2 +-
 walker.c                               | 3 ++-
 17 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/blob.c b/blob.c
index a9f3aa2ec8..25faf3e692 100644
--- a/blob.c
+++ b/blob.c
@@ -4,7 +4,7 @@
 
 const char *blob_type = "blob";
 
-struct blob *lookup_blob(const struct object_id *oid)
+struct blob *lookup_blob_the_repository(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
diff --git a/blob.h b/blob.h
index 4460616831..08bc34487a 100644
--- a/blob.h
+++ b/blob.h
@@ -9,7 +9,8 @@ struct blob {
 	struct object object;
 };
 
-struct blob *lookup_blob(const struct object_id *oid);
+#define lookup_blob(r, o) lookup_blob_##r(o)
+struct blob *lookup_blob_the_repository(const struct object_id *oid);
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 3b0b204b1e..2add1e8d83 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -499,7 +499,7 @@ static void describe(const char *arg, int last_one)
 
 	if (cmit)
 		describe_commit(&oid, &sb);
-	else if (lookup_blob(&oid))
+	else if (lookup_blob(the_repository, &oid))
 		describe_blob(oid, &sb);
 	else
 		die(_("%s is neither a commit nor blob"), arg);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 642bafdd30..14a27d539f 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -236,7 +236,7 @@ static void export_blob(const struct object_id *oid)
 
 	if (anonymize) {
 		buf = anonymize_blob(&size);
-		object = (struct object *)lookup_blob(oid);
+		object = (struct object *)lookup_blob(the_repository, oid);
 		eaten = 0;
 	} else {
 		buf = read_sha1_file(oid->hash, &type, &size);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7645418821..79da01d338 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -778,7 +778,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			mode = active_cache[i]->ce_mode;
 			if (S_ISGITLINK(mode))
 				continue;
-			blob = lookup_blob(&active_cache[i]->oid);
+			blob = lookup_blob(the_repository,
+					   &active_cache[i]->oid);
 			if (!blob)
 				continue;
 			obj = &blob->object;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b9851ad69d..67db12fc43 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -834,7 +834,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 	if (strict) {
 		read_lock();
 		if (type == OBJ_BLOB) {
-			struct blob *blob = lookup_blob(oid);
+			struct blob *blob = lookup_blob(the_repository, oid);
 			if (blob)
 				blob->object.flags |= FLAG_CHECKED;
 			else
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index ba51ad55a8..41f1ae30cc 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -2,6 +2,7 @@
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "object-store.h"
+#include "repository.h"
 #include "blob.h"
 #include "exec_cmd.h"
 #include "merge-blobs.h"
@@ -169,7 +170,7 @@ static struct merge_list *create_entry(unsigned stage, unsigned mode, const stru
 	res->stage = stage;
 	res->path = path;
 	res->mode = mode;
-	res->blob = lookup_blob(oid);
+	res->blob = lookup_blob(the_repository, oid);
 	return res;
 }
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e26f673a15..8d13c5145c 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -252,7 +252,7 @@ static void write_object(unsigned nr, enum object_type type,
 		added_object(nr, type, buf, size);
 		free(buf);
 
-		blob = lookup_blob(&obj_list[nr].oid);
+		blob = lookup_blob(the_repository, &obj_list[nr].oid);
 		if (blob)
 			blob->object.flags |= FLAG_WRITTEN;
 		else
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index d57b0f16d4..3bc38d2faa 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -1,3 +1,10 @@
+@@
+expression E;
+@@
+ lookup_blob(
++the_repository,
+ E)
+
 @@
 expression E;
 @@
diff --git a/fsck.c b/fsck.c
index 843ddc1035..6d04981735 100644
--- a/fsck.c
+++ b/fsck.c
@@ -367,7 +367,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			result = options->walk(obj, OBJ_TREE, data, options);
 		}
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
-			obj = (struct object *)lookup_blob(entry.oid);
+			obj = (struct object *)lookup_blob(the_repository, entry.oid);
 			if (name && obj)
 				put_object_name(options, obj, "%s%s", name,
 					entry.path);
diff --git a/http-push.c b/http-push.c
index 5149c1b425..6c60b12ad1 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1310,7 +1310,8 @@ static struct object_list **process_tree(struct tree *tree,
 			p = process_tree(lookup_tree(entry.oid), p);
 			break;
 		case OBJ_BLOB:
-			p = process_blob(lookup_blob(entry.oid), p);
+			p = process_blob(lookup_blob(the_repository, entry.oid),
+					 p);
 			break;
 		default:
 			/* Subproject commit - not in this repository */
diff --git a/list-objects.c b/list-objects.c
index 0966cdc9fa..c11dc1281b 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -139,7 +139,7 @@ static void process_tree(struct rev_info *revs,
 					cb_data);
 		else
 			process_blob(revs,
-				     lookup_blob(entry.oid),
+				     lookup_blob(the_repository, entry.oid),
 				     show, base, entry.path,
 				     cb_data, filter_fn, filter_data);
 	}
diff --git a/object.c b/object.c
index 225679188b..e0dac087c8 100644
--- a/object.c
+++ b/object.c
@@ -190,7 +190,7 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
 
 	obj = NULL;
 	if (type == OBJ_BLOB) {
-		struct blob *blob = lookup_blob(oid);
+		struct blob *blob = lookup_blob(the_repository, oid);
 		if (blob) {
 			if (parse_blob_buffer(blob, buffer, size))
 				return NULL;
@@ -263,7 +263,7 @@ struct object *parse_object_the_repository(const struct object_id *oid)
 			error("sha1 mismatch %s", oid_to_hex(oid));
 			return NULL;
 		}
-		parse_blob_buffer(lookup_blob(oid), NULL, 0);
+		parse_blob_buffer(lookup_blob(the_repository, oid), NULL, 0);
 		return lookup_object(the_repository, oid->hash);
 	}
 
diff --git a/reachable.c b/reachable.c
index 4007c6428b..943e4518c2 100644
--- a/reachable.c
+++ b/reachable.c
@@ -92,7 +92,7 @@ static void add_recent_object(const struct object_id *oid,
 		obj = (struct object *)lookup_tree(oid);
 		break;
 	case OBJ_BLOB:
-		obj = (struct object *)lookup_blob(oid);
+		obj = (struct object *)lookup_blob(the_repository, oid);
 		break;
 	default:
 		die("unknown object type for %s: %s",
diff --git a/revision.c b/revision.c
index 5ccfc50447..a7b57e3452 100644
--- a/revision.c
+++ b/revision.c
@@ -67,7 +67,7 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 			mark_tree_uninteresting(lookup_tree(entry.oid));
 			break;
 		case OBJ_BLOB:
-			mark_blob_uninteresting(lookup_blob(entry.oid));
+			mark_blob_uninteresting(lookup_blob(the_repository, entry.oid));
 			break;
 		default:
 			/* Subproject commit - not in this repository */
@@ -1321,7 +1321,7 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
 		if (S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		blob = lookup_blob(&ce->oid);
+		blob = lookup_blob(the_repository, &ce->oid);
 		if (!blob)
 			die("unable to add index blob to traversal");
 		add_pending_object_with_path(revs, &blob->object, "",
diff --git a/tag.c b/tag.c
index 3712ef7867..4cf449303b 100644
--- a/tag.c
+++ b/tag.c
@@ -146,7 +146,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	bufptr = nl + 1;
 
 	if (!strcmp(type, blob_type)) {
-		item->tagged = (struct object *)lookup_blob(&oid);
+		item->tagged = (struct object *)lookup_blob(the_repository, &oid);
 	} else if (!strcmp(type, tree_type)) {
 		item->tagged = (struct object *)lookup_tree(&oid);
 	} else if (!strcmp(type, commit_type)) {
diff --git a/walker.c b/walker.c
index 492aea906f..f5a221d48e 100644
--- a/walker.c
+++ b/walker.c
@@ -54,7 +54,8 @@ static int process_tree(struct walker *walker, struct tree *tree)
 				obj = &tree->object;
 		}
 		else {
-			struct blob *blob = lookup_blob(entry.oid);
+			struct blob *blob = lookup_blob(the_repository,
+							entry.oid);
 			if (blob)
 				obj = &blob->object;
 		}
-- 
2.15.1.433.g936d1b9894.dirty

