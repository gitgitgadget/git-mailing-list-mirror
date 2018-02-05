Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478301F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeBFALR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:11:17 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:43981 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeBFALO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:11:14 -0500
Received: by mail-pg0-f54.google.com with SMTP id f6so133101pgs.10
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xHUjqAf+fT7paahgxqFHz0/a7i22q2k7QEI0iA1W8x0=;
        b=rNxeiDuNTd8Lju6JhNRTgUFRiyEtaWGc5Xkp0nzWtoGU8zbTC5gLkzC2sGSzzxo2DB
         Dia5yjFKPFvQpeHZfRmvG9K+AfapS3jnXKaHgdH3jTVM3sZOMjbltX39xMTJhyajSZcV
         CPrhUfdXsvOWAppChLBhZteFN5tHbePC3FcHLYz1v+iuDZdFQ32UvdlUxOW3DMAimSMC
         yx+ffyXXw5WGitm4Stu4pECG3BceR12iZzVo67diWr0TtcZmMAwpteDRAjkAYXQQiSa+
         HQK7C/Q6qwilM3sjaCw+a+qfCyeXqNP4D+AoL8aP3z0Pq1YeeQvJ1dK6L0/diE6AMDfE
         Tgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xHUjqAf+fT7paahgxqFHz0/a7i22q2k7QEI0iA1W8x0=;
        b=DCxSmbjeavRC/aYknLcaSlAeAhSrHhKrXvVYXLTX2Mt/BDSi8Y2Or9a2Kh67jQbtMk
         wfMIZANDApNJ50OCYEcllQK3MlVs4i4ZNgzXRwcOcbd9UsWYQYqLSD8IFllcd/923EH1
         itTob73csJbwLRu69UBKQpN3N/FFPr/X2AHC/mBddFyybYPtV44+P0wTb0gLhURl3p/S
         OuW30+el9oVbKNFBNrHE6b0MBgQnpHPJicxLA+rPa5blWr1IQQRz/YIgI/Gwd/3izxBM
         mSeuX9Z2jyvQFJFtI7qHTWBtmlL+IawN8LNBb+qIYw/Pmg6w17/KzAyDG791285unR9L
         +nYQ==
X-Gm-Message-State: APf1xPCQAYdrPmcSNxV2WXCGProWzpyNZZkJKbNn3EGJJ3FwqEkWbq+b
        F9RhoKAuNOuClpz0Vlb/L1yRVvhUvAY=
X-Google-Smtp-Source: AH8x226bdvFr4/AlwMSOMC4mFaTjy3PhDUBxM5jpLSeJZeZnbEAN2x/ykffMyRamfkKc5gnKHYKpkA==
X-Received: by 10.101.91.66 with SMTP id y2mr428537pgr.11.1517875872668;
        Mon, 05 Feb 2018 16:11:12 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i194sm3744632pfe.145.2018.02.05.16.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:11:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 080/194] object: add repository argument to parse_object
Date:   Mon,  5 Feb 2018 15:55:41 -0800
Message-Id: <20180205235735.216710-60-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of parse_object
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Add the cocci patch that converted the callers.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/diff-tree.c                    |  3 ++-
 builtin/diff.c                         |  2 +-
 builtin/fast-export.c                  |  2 +-
 builtin/fmt-merge-msg.c                |  6 ++++--
 builtin/fsck.c                         |  4 ++--
 builtin/log.c                          |  3 ++-
 builtin/name-rev.c                     |  7 ++++---
 builtin/receive-pack.c                 |  6 +++---
 builtin/reflog.c                       |  3 ++-
 builtin/rev-list.c                     |  2 +-
 bundle.c                               |  3 ++-
 commit.c                               |  5 +++--
 contrib/coccinelle/object_parser.cocci |  6 ++++++
 fetch-pack.c                           | 16 +++++++++-------
 fsck.c                                 |  3 ++-
 http-backend.c                         |  2 +-
 http-push.c                            |  6 ++++--
 log-tree.c                             |  7 ++++---
 merge-recursive.c                      |  4 +++-
 object.c                               |  4 ++--
 object.h                               |  3 ++-
 pretty.c                               |  2 +-
 ref-filter.c                           |  3 ++-
 reflog-walk.c                          |  3 ++-
 refs/files-backend.c                   |  2 +-
 remote.c                               |  4 ++--
 revision.c                             | 12 ++++++------
 server-info.c                          |  2 +-
 sha1_name.c                            | 14 +++++++-------
 tag.c                                  |  5 +++--
 tree.c                                 |  5 +++--
 upload-pack.c                          |  9 +++++----
 walker.c                               |  3 ++-
 33 files changed, 95 insertions(+), 66 deletions(-)
 create mode 100644 contrib/coccinelle/object_parser.cocci

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index b775a75647..1f78308e33 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -5,6 +5,7 @@
 #include "log-tree.h"
 #include "builtin.h"
 #include "submodule.h"
+#include "repository.h"
 
 static struct rev_info log_tree_opt;
 
@@ -68,7 +69,7 @@ static int diff_tree_stdin(char *line)
 	line[len-1] = 0;
 	if (parse_oid_hex(line, &oid, &p))
 		return -1;
-	obj = parse_object(&oid);
+	obj = parse_object(the_repository, &oid);
 	if (!obj)
 		return -1;
 	if (obj->type == OBJ_COMMIT)
diff --git a/builtin/diff.c b/builtin/diff.c
index 16bfb22f73..ed6092ef1a 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -393,7 +393,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		const char *name = entry->name;
 		int flags = (obj->flags & UNINTERESTING);
 		if (!obj->parsed)
-			obj = parse_object(&obj->oid);
+			obj = parse_object(the_repository, &obj->oid);
 		obj = deref_tag(obj, NULL, 0);
 		if (!obj)
 			die(_("invalid object '%s' given."), name);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d4e53908c6..6140caf8d8 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -798,7 +798,7 @@ static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
 
 		/* handle nested tags */
 		while (tag && tag->object.type == OBJ_TAG) {
-			parse_object(&tag->object.oid);
+			parse_object(the_repository, &tag->object.oid);
 			string_list_append(&extra_refs, full_name)->util = tag;
 			tag = (struct tag *)tag->tagged;
 		}
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 9dd5c85831..dd74251690 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -11,6 +11,7 @@
 #include "branch.h"
 #include "fmt-merge-msg.h"
 #include "gpg-interface.h"
+#include "repository.h"
 
 static const char * const fmt_merge_msg_usage[] = {
 	N_("git fmt-merge-msg [-m <message>] [--log[=<n>] | --no-log] [--file <file>]"),
@@ -343,7 +344,8 @@ static void shortlog(const char *name,
 	const struct object_id *oid = &origin_data->oid;
 	int limit = opts->shortlog_len;
 
-	branch = deref_tag(parse_object(oid), oid_to_hex(oid), GIT_SHA1_HEXSZ);
+	branch = deref_tag(parse_object(the_repository, oid), oid_to_hex(oid),
+			   GIT_SHA1_HEXSZ);
 	if (!branch || branch->type != OBJ_COMMIT)
 		return;
 
@@ -563,7 +565,7 @@ static void find_merge_parents(struct merge_parents *result,
 		 * "name" here and we do not want to contaminate its
 		 * util field yet.
 		 */
-		obj = parse_object(&oid);
+		obj = parse_object(the_repository, &oid);
 		parent = (struct commit *)peel_to_type(NULL, 0, obj, OBJ_COMMIT);
 		if (!parent)
 			continue;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index f5e3c51077..9408ae5cc6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -437,7 +437,7 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 {
 	struct object *obj;
 
-	obj = parse_object(oid);
+	obj = parse_object(the_repository, oid);
 	if (!obj) {
 		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
 		errors_found |= ERROR_REACHABLE;
@@ -593,7 +593,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 		fprintf(stderr, "Checking cache tree\n");
 
 	if (0 <= it->entry_count) {
-		struct object *obj = parse_object(&it->oid);
+		struct object *obj = parse_object(the_repository, &it->oid);
 		if (!obj) {
 			error("%s: invalid sha1 pointer in cache-tree",
 			      oid_to_hex(&it->oid));
diff --git a/builtin/log.c b/builtin/log.c
index de723fffc6..2c3579b1f7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -29,6 +29,7 @@
 #include "mailmap.h"
 #include "gpg-interface.h"
 #include "progress.h"
+#include "repository.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -613,7 +614,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			rev.shown_one = 1;
 			if (ret)
 				break;
-			o = parse_object(&t->tagged->oid);
+			o = parse_object(the_repository, &t->tagged->oid);
 			if (!o)
 				ret = error(_("Could not read object %s"),
 					    oid_to_hex(&t->tagged->oid));
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 9e088ebd11..c6b253eefb 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "commit.h"
 #include "tag.h"
@@ -187,7 +188,7 @@ static int tipcmp(const void *a_, const void *b_)
 
 static int name_ref(const char *path, const struct object_id *oid, int flags, void *cb_data)
 {
-	struct object *o = parse_object(oid);
+	struct object *o = parse_object(the_repository, oid);
 	struct name_ref_data *data = cb_data;
 	int can_abbreviate_output = data->tags_only && data->name_only;
 	int deref = 0;
@@ -245,7 +246,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 		struct tag *t = (struct tag *) o;
 		if (!t->tagged)
 			break; /* broken repository */
-		o = parse_object(&t->tagged->oid);
+		o = parse_object(the_repository, &t->tagged->oid);
 		deref = 1;
 		taggerdate = t->date;
 	}
@@ -434,7 +435,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		}
 
 		commit = NULL;
-		object = parse_object(&oid);
+		object = parse_object(the_repository, &oid);
 		if (object) {
 			struct object *peeled = deref_tag(object, *argv, 0);
 			if (peeled && peeled->type == OBJ_COMMIT)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 744fe29366..22d805a8ff 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1107,8 +1107,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		struct object *old_object, *new_object;
 		struct commit *old_commit, *new_commit;
 
-		old_object = parse_object(old_oid);
-		new_object = parse_object(new_oid);
+		old_object = parse_object(the_repository, old_oid);
+		new_object = parse_object(the_repository, new_oid);
 
 		if (!old_object || !new_object ||
 		    old_object->type != OBJ_COMMIT ||
@@ -1131,7 +1131,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 
 	if (is_null_oid(new_oid)) {
 		struct strbuf err = STRBUF_INIT;
-		if (!parse_object(old_oid)) {
+		if (!parse_object(the_repository, old_oid)) {
 			old_oid = NULL;
 			if (ref_exists(name)) {
 				rp_warning("Allowing deletion of corrupt ref.");
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 4b525c4448..18145d5494 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "lockfile.h"
 #include "object-store.h"
+#include "repository.h"
 #include "commit.h"
 #include "refs.h"
 #include "dir.h"
@@ -128,7 +129,7 @@ static int commit_is_complete(struct commit *commit)
 		struct commit_list *parent;
 
 		c = (struct commit *)object_array_pop(&study);
-		if (!c->object.parsed && !parse_object(&c->object.oid))
+		if (!c->object.parsed && !parse_object(the_repository, &c->object.oid))
 			c->object.flags |= INCOMPLETE;
 
 		if (c->object.flags & INCOMPLETE) {
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 969efde30c..3c2ae454ea 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -222,7 +222,7 @@ static void finish_object(struct object *obj, const char *name, void *cb_data)
 	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid))
 		finish_object__ma(obj);
 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
-		parse_object(&obj->oid);
+		parse_object(the_repository, &obj->oid);
 }
 
 static void show_object(struct object *obj, const char *name, void *cb_data)
diff --git a/bundle.c b/bundle.c
index d9376b7c77..1b5f1beb3b 100644
--- a/bundle.c
+++ b/bundle.c
@@ -2,6 +2,7 @@
 #include "lockfile.h"
 #include "bundle.h"
 #include "object-store.h"
+#include "repository.h"
 #include "object.h"
 #include "commit.h"
 #include "diff.h"
@@ -143,7 +144,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	init_revisions(&revs, NULL);
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
-		struct object *o = parse_object(&e->oid);
+		struct object *o = parse_object(the_repository, &e->oid);
 		if (o) {
 			o->flags |= PREREQ_MARK;
 			add_pending_object(&revs, o, e->name);
diff --git a/commit.c b/commit.c
index b60906d3f9..742d710c86 100644
--- a/commit.c
+++ b/commit.c
@@ -23,7 +23,8 @@ const char *commit_type = "commit";
 struct commit *lookup_commit_reference_gently(const struct object_id *oid,
 					      int quiet)
 {
-	struct object *obj = deref_tag(parse_object(oid), NULL, 0);
+	struct object *obj = deref_tag(parse_object(the_repository, oid),
+				       NULL, 0);
 
 	if (!obj)
 		return NULL;
@@ -1606,7 +1607,7 @@ struct commit *get_merge_parent(const char *name)
 	struct object_id oid;
 	if (get_oid(name, &oid))
 		return NULL;
-	obj = parse_object(&oid);
+	obj = parse_object(the_repository, &oid);
 	commit = (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
 	if (commit && !commit->util)
 		set_merge_remote_desc(commit, name, obj);
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
new file mode 100644
index 0000000000..a9afe4bf7a
--- /dev/null
+++ b/contrib/coccinelle/object_parser.cocci
@@ -0,0 +1,6 @@
+@@
+expression E;
+@@
+ parse_object(
++ the_repository,
+ E)
diff --git a/fetch-pack.c b/fetch-pack.c
index 9c189ff3ec..0f7aeabb64 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -82,7 +82,7 @@ static void cache_one_alternate(const char *refname,
 				void *vcache)
 {
 	struct alternate_object_cache *cache = vcache;
-	struct object *obj = parse_object(oid);
+	struct object *obj = parse_object(the_repository, oid);
 
 	if (!obj || (obj->flags & ALTERNATE))
 		return;
@@ -124,7 +124,8 @@ static void rev_list_push(struct commit *commit, int mark)
 
 static int rev_list_insert_ref(const char *refname, const struct object_id *oid)
 {
-	struct object *o = deref_tag(parse_object(oid), refname, 0);
+	struct object *o = deref_tag(parse_object(the_repository, oid),
+				     refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
 		rev_list_push((struct commit *)o, SEEN);
@@ -141,7 +142,8 @@ static int rev_list_insert_ref_oid(const char *refname, const struct object_id *
 static int clear_marks(const char *refname, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
-	struct object *o = deref_tag(parse_object(oid), refname, 0);
+	struct object *o = deref_tag(parse_object(the_repository, oid),
+				     refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
 		clear_commit_marks((struct commit *)o,
@@ -430,7 +432,7 @@ static int find_common(struct fetch_pack_args *args,
 				if (!lookup_object(oid.hash))
 					die(_("object not found: %s"), line);
 				/* make sure that it is parsed as shallow */
-				if (!parse_object(&oid))
+				if (!parse_object(the_repository, &oid))
 					die(_("error in object: %s"), line);
 				if (unregister_shallow(&oid))
 					die(_("no shallow found: %s"), line);
@@ -561,14 +563,14 @@ static struct commit_list *complete;
 
 static int mark_complete(const struct object_id *oid)
 {
-	struct object *o = parse_object(oid);
+	struct object *o = parse_object(the_repository, oid);
 
 	while (o && o->type == OBJ_TAG) {
 		struct tag *t = (struct tag *) o;
 		if (!t->tagged)
 			break; /* broken repository */
 		o->flags |= COMPLETE;
-		o = parse_object(&t->tagged->oid);
+		o = parse_object(the_repository, &t->tagged->oid);
 	}
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
@@ -721,7 +723,7 @@ static int everything_local(struct fetch_pack_args *args,
 						OBJECT_INFO_QUICK))
 			continue;
 
-		o = parse_object(&ref->old_oid);
+		o = parse_object(the_repository, &ref->old_oid);
 		if (!o)
 			continue;
 
diff --git a/fsck.c b/fsck.c
index d106714bf5..843ddc1035 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "object-store.h"
+#include "repository.h"
 #include "object.h"
 #include "blob.h"
 #include "tree.h"
@@ -462,7 +463,7 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
 		return -1;
 
 	if (obj->type == OBJ_NONE)
-		parse_object(&obj->oid);
+		parse_object(the_repository, &obj->oid);
 
 	switch (obj->type) {
 	case OBJ_BLOB:
diff --git a/http-backend.c b/http-backend.c
index 4950078c93..b76c8c4f3d 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -435,7 +435,7 @@ static int show_text_ref(const char *name, const struct object_id *oid,
 {
 	const char *name_nons = strip_namespace(name);
 	struct strbuf *buf = cb_data;
-	struct object *o = parse_object(oid);
+	struct object *o = parse_object(the_repository, oid);
 	if (!o)
 		return 0;
 
diff --git a/http-push.c b/http-push.c
index 34c5d030b7..b4c3cd1cd7 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "object-store.h"
 #include "commit.h"
 #include "tag.h"
@@ -14,6 +15,7 @@
 #include "argv-array.h"
 #include "packfile.h"
 
+
 #ifdef EXPAT_NEEDS_XMLPARSE_H
 #include <xmlparse.h>
 #else
@@ -722,7 +724,7 @@ static void one_remote_object(const struct object_id *oid)
 
 	obj = lookup_object(oid->hash);
 	if (!obj)
-		obj = parse_object(oid);
+		obj = parse_object(the_repository, oid);
 
 	/* Ignore remote objects that don't exist locally */
 	if (!obj)
@@ -1455,7 +1457,7 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 		return;
 	}
 
-	o = parse_object(&ref->old_oid);
+	o = parse_object(the_repository, &ref->old_oid);
 	if (!o) {
 		fprintf(stderr,
 			"Unable to parse object %s for remote ref %s\n",
diff --git a/log-tree.c b/log-tree.c
index b2fff6b5f6..57d5e5f56d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "diff.h"
 #include "object-store.h"
+#include "repository.h"
 #include "commit.h"
 #include "tag.h"
 #include "graph.h"
@@ -111,13 +112,13 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 			warning("invalid replace ref %s", refname);
 			return 0;
 		}
-		obj = parse_object(&original_oid);
+		obj = parse_object(the_repository, &original_oid);
 		if (obj)
 			add_name_decoration(DECORATION_GRAFTED, "replaced", obj);
 		return 0;
 	}
 
-	obj = parse_object(oid);
+	obj = parse_object(the_repository, oid);
 	if (!obj)
 		return 0;
 
@@ -138,7 +139,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 		if (!obj)
 			break;
 		if (!obj->parsed)
-			parse_object(&obj->oid);
+			parse_object(the_repository, &obj->oid);
 		add_name_decoration(DECORATION_REF_TAG, refname, obj);
 	}
 	return 0;
diff --git a/merge-recursive.c b/merge-recursive.c
index 620e4f653c..e2c434c305 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -9,6 +9,7 @@
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "object-store.h"
+#include "repository.h"
 #include "commit.h"
 #include "blob.h"
 #include "builtin.h"
@@ -2151,7 +2152,8 @@ static struct commit *get_ref(const struct object_id *oid, const char *name)
 {
 	struct object *object;
 
-	object = deref_tag(parse_object(oid), name, strlen(name));
+	object = deref_tag(parse_object(the_repository, oid), name,
+			   strlen(name));
 	if (!object)
 		return NULL;
 	if (object->type == OBJ_TREE)
diff --git a/object.c b/object.c
index 18ea8cf574..c1154039df 100644
--- a/object.c
+++ b/object.c
@@ -234,14 +234,14 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
 struct object *parse_object_or_die(const struct object_id *oid,
 				   const char *name)
 {
-	struct object *o = parse_object(oid);
+	struct object *o = parse_object(the_repository, oid);
 	if (o)
 		return o;
 
 	die(_("unable to parse object: %s"), name ? name : oid_to_hex(oid));
 }
 
-struct object *parse_object(const struct object_id *oid)
+struct object *parse_object_the_repository(const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
diff --git a/object.h b/object.h
index 2cff106ff7..e5cad09fad 100644
--- a/object.h
+++ b/object.h
@@ -109,7 +109,8 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet);
  *
  * Returns NULL if the object is missing or corrupt.
  */
-struct object *parse_object(const struct object_id *oid);
+#define parse_object(r, oid) parse_object_##r(oid)
+struct object *parse_object_the_repository(const struct object_id *oid);
 
 /*
  * Like parse_object, but will die() instead of returning NULL. If the
diff --git a/pretty.c b/pretty.c
index f7ce490230..478af1a860 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1146,7 +1146,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	/* these depend on the commit */
 	if (!commit->object.parsed)
-		parse_object(&commit->object.oid);
+		parse_object(the_repository, &commit->object.oid);
 
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
diff --git a/ref-filter.c b/ref-filter.c
index 0a106b888d..1d0bad5e36 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -4,6 +4,7 @@
 #include "refs.h"
 #include "wildmatch.h"
 #include "object-store.h"
+#include "repository.h"
 #include "commit.h"
 #include "remote.h"
 #include "color.h"
@@ -1818,7 +1819,7 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
 
 	if (oid_array_lookup(points_at, oid) >= 0)
 		return oid;
-	obj = parse_object(oid);
+	obj = parse_object(the_repository, oid);
 	if (!obj)
 		die(_("malformed object at '%s'"), refname);
 	if (obj->type == OBJ_TAG)
diff --git a/reflog-walk.c b/reflog-walk.c
index 5008bbf6ad..3561a8b955 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -305,7 +305,8 @@ static struct commit *next_reflog_commit(struct commit_reflog *log)
 {
 	for (; log->recno >= 0; log->recno--) {
 		struct reflog_info *entry = &log->reflogs->items[log->recno];
-		struct object *obj = parse_object(&entry->noid);
+		struct object *obj = parse_object(the_repository,
+						  &entry->noid);
 
 		if (obj && obj->type == OBJ_COMMIT)
 			return (struct commit *)obj;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f75d960e19..932fdc1f0b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1658,7 +1658,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 	struct object *o;
 	int fd;
 
-	o = parse_object(oid);
+	o = parse_object(the_repository, oid);
 	if (!o) {
 		strbuf_addf(err,
 			    "trying to write ref '%s' with nonexistent object %s",
diff --git a/remote.c b/remote.c
index fd8cd8ce77..2abc6baf84 100644
--- a/remote.c
+++ b/remote.c
@@ -1980,12 +1980,12 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 	 * Both new and old must be commit-ish and new is descendant of
 	 * old.  Otherwise we require --force.
 	 */
-	o = deref_tag(parse_object(old_oid), NULL, 0);
+	o = deref_tag(parse_object(the_repository, old_oid), NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	old = (struct commit *) o;
 
-	o = deref_tag(parse_object(new_oid), NULL, 0);
+	o = deref_tag(parse_object(the_repository, new_oid), NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	new = (struct commit *) o;
diff --git a/revision.c b/revision.c
index e98bdf2ac7..5ccfc50447 100644
--- a/revision.c
+++ b/revision.c
@@ -184,7 +184,7 @@ void add_head_to_pending(struct rev_info *revs)
 	struct object *obj;
 	if (get_oid("HEAD", &oid))
 		return;
-	obj = parse_object(&oid);
+	obj = parse_object(the_repository, &oid);
 	if (!obj)
 		return;
 	add_pending_object(revs, obj, "HEAD");
@@ -196,7 +196,7 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 {
 	struct object *object;
 
-	object = parse_object(oid);
+	object = parse_object(the_repository, oid);
 	if (!object) {
 		if (revs->ignore_missing)
 			return object;
@@ -231,7 +231,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			add_pending_object(revs, object, tag->tag);
 		if (!tag->tagged)
 			die("bad tag");
-		object = parse_object(&tag->tagged->oid);
+		object = parse_object(the_repository, &tag->tagged->oid);
 		if (!object) {
 			if (revs->ignore_missing_links || (flags & UNINTERESTING))
 				return NULL;
@@ -1222,7 +1222,7 @@ static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	if (!is_null_oid(oid)) {
-		struct object *o = parse_object(oid);
+		struct object *o = parse_object(the_repository, oid);
 		if (o) {
 			o->flags |= cb->all_flags;
 			/* ??? CMDLINEFLAGS ??? */
@@ -1549,8 +1549,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 		*dotdot = '\0';
 	}
 
-	a_obj = parse_object(&a_oid);
-	b_obj = parse_object(&b_oid);
+	a_obj = parse_object(the_repository, &a_oid);
+	b_obj = parse_object(the_repository, &b_oid);
 	if (!a_obj || !b_obj)
 		return dotdot_missing(arg, dotdot, revs, symmetric);
 
diff --git a/server-info.c b/server-info.c
index 6cd1506e5e..fd7ed2a383 100644
--- a/server-info.c
+++ b/server-info.c
@@ -56,7 +56,7 @@ static int add_info_ref(const char *path, const struct object_id *oid,
 			int flag, void *cb_data)
 {
 	FILE *fp = cb_data;
-	struct object *o = parse_object(oid);
+	struct object *o = parse_object(the_repository, oid);
 	if (!o)
 		return -1;
 
diff --git a/sha1_name.c b/sha1_name.c
index 190710c638..0139b480a3 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -259,7 +259,7 @@ static int disambiguate_committish_only(const struct object_id *oid, void *cb_da
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(parse_object(oid), NULL, 0);
+	obj = deref_tag(parse_object(the_repository, oid), NULL, 0);
 	if (obj && obj->type == OBJ_COMMIT)
 		return 1;
 	return 0;
@@ -283,7 +283,7 @@ static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(parse_object(oid), NULL, 0);
+	obj = deref_tag(parse_object(the_repository, oid), NULL, 0);
 	if (obj && (obj->type == OBJ_TREE || obj->type == OBJ_COMMIT))
 		return 1;
 	return 0;
@@ -894,7 +894,7 @@ struct object *peel_to_type(const char *name, int namelen,
 	if (name && !namelen)
 		namelen = strlen(name);
 	while (1) {
-		if (!o || (!o->parsed && !parse_object(&o->oid)))
+		if (!o || (!o->parsed && !parse_object(the_repository, &o->oid)))
 			return NULL;
 		if (expected_type == OBJ_ANY || o->type == expected_type)
 			return o;
@@ -967,12 +967,12 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	if (get_oid_1(name, sp - name - 2, &outer, lookup_flags))
 		return -1;
 
-	o = parse_object(&outer);
+	o = parse_object(the_repository, &outer);
 	if (!o)
 		return -1;
 	if (!expected_type) {
 		o = deref_tag(o, name, sp - name - 2);
-		if (!o || (!o->parsed && !parse_object(&o->oid)))
+		if (!o || (!o->parsed && !parse_object(the_repository, &o->oid)))
 			return -1;
 		oidcpy(oid, &o->oid);
 		return 0;
@@ -1099,7 +1099,7 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
 			  int flag, void *cb_data)
 {
 	struct commit_list **list = cb_data;
-	struct object *object = parse_object(oid);
+	struct object *object = parse_object(the_repository, oid);
 	if (!object)
 		return 0;
 	if (object->type == OBJ_TAG) {
@@ -1145,7 +1145,7 @@ static int get_oid_oneline(const char *prefix, struct object_id *oid,
 		int matches;
 
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
-		if (!parse_object(&commit->object.oid))
+		if (!parse_object(the_repository, &commit->object.oid))
 			continue;
 		buf = get_commit_buffer(commit, NULL);
 		p = strstr(buf, "\n\n");
diff --git a/tag.c b/tag.c
index 7b32afd123..5207f70885 100644
--- a/tag.c
+++ b/tag.c
@@ -68,7 +68,8 @@ struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == OBJ_TAG)
 		if (((struct tag *)o)->tagged)
-			o = parse_object(&((struct tag *)o)->tagged->oid);
+			o = parse_object(the_repository,
+					 &((struct tag *)o)->tagged->oid);
 		else
 			o = NULL;
 	if (!o && warn) {
@@ -82,7 +83,7 @@ struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 struct object *deref_tag_noverify(struct object *o)
 {
 	while (o && o->type == OBJ_TAG) {
-		o = parse_object(&o->oid);
+		o = parse_object(the_repository, &o->oid);
 		if (o && o->type == OBJ_TAG && ((struct tag *)o)->tagged)
 			o = ((struct tag *)o)->tagged;
 		else
diff --git a/tree.c b/tree.c
index 653339db03..62d78fb4ba 100644
--- a/tree.c
+++ b/tree.c
@@ -7,6 +7,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "tree-walk.h"
+#include "repository.h"
 
 const char *tree_type = "tree";
 
@@ -242,7 +243,7 @@ void free_tree_buffer(struct tree *tree)
 
 struct tree *parse_tree_indirect(const struct object_id *oid)
 {
-	struct object *obj = parse_object(oid);
+	struct object *obj = parse_object(the_repository, oid);
 	do {
 		if (!obj)
 			return NULL;
@@ -255,6 +256,6 @@ struct tree *parse_tree_indirect(const struct object_id *oid)
 		else
 			return NULL;
 		if (!obj->parsed)
-			parse_object(&obj->oid);
+			parse_object(the_repository, &obj->oid);
 	} while (1);
 }
diff --git a/upload-pack.c b/upload-pack.c
index 6db85ecdc4..b076cbc5f7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -3,6 +3,7 @@
 #include "refs.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "repository.h"
 #include "object-store.h"
 #include "tag.h"
 #include "object.h"
@@ -299,7 +300,7 @@ static int got_oid(const char *hex, struct object_id *oid)
 	if (!has_object_file(oid))
 		return -1;
 
-	o = parse_object(oid);
+	o = parse_object(the_repository, oid);
 	if (!o)
 		die("oops (%s)", oid_to_hex(oid));
 	if (o->type == OBJ_COMMIT) {
@@ -337,7 +338,7 @@ static int reachable(struct commit *want)
 			break;
 		}
 		if (!commit->object.parsed)
-			parse_object(&commit->object.oid);
+			parse_object(the_repository, &commit->object.oid);
 		if (commit->object.flags & REACHABLE)
 			continue;
 		commit->object.flags |= REACHABLE;
@@ -758,7 +759,7 @@ static void receive_needs(void)
 			struct object *object;
 			if (get_oid_hex(arg, &oid))
 				die("invalid shallow line: %s", line);
-			object = parse_object(&oid);
+			object = parse_object(the_repository, &oid);
 			if (!object)
 				continue;
 			if (object->type != OBJ_COMMIT)
@@ -824,7 +825,7 @@ static void receive_needs(void)
 		if (parse_feature_request(features, "include-tag"))
 			use_include_tag = 1;
 
-		o = parse_object(&oid_buf);
+		o = parse_object(the_repository, &oid_buf);
 		if (!o) {
 			packet_write_fmt(1,
 					 "ERR upload-pack: not our ref %s",
diff --git a/walker.c b/walker.c
index 49b6a96e6e..492aea906f 100644
--- a/walker.c
+++ b/walker.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "walker.h"
+#include "repository.h"
 #include "object-store.h"
 #include "commit.h"
 #include "tree.h"
@@ -181,7 +182,7 @@ static int loop(struct walker *walker)
 			}
 		}
 		if (!obj->type)
-			parse_object(&obj->oid);
+			parse_object(the_repository, &obj->oid);
 		if (process_object(walker, obj))
 			return -1;
 	}
-- 
2.15.1.433.g936d1b9894.dirty

