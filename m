Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FE801F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeBFAH7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:07:59 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34358 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeBFAH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:07:57 -0500
Received: by mail-pg0-f41.google.com with SMTP id s73so150680pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ir0hkxKp06lyjpW+N3OnlzR0oShw90IT9FdI40kBm0o=;
        b=hxfdPkfWQ3oVE1pvxsvJroq80TmaTmmXyB6Rln3hqP+b65bxSDwXtxtNQW3lGTymwl
         rmP2Ws5isvsDtTRaWPqQjsf8qVq7w4WXVqWYmTMQ+m7TKo4QSJJZuLx6oIiIzY42MfET
         GG4oKNB3p2EQ+Tk22taXdllyKU1L3obVwzf4CMrS+q+CPq+Um+qdRXUBL68Osx/lIIvx
         DBQfU7nxAC/HHUqt4KjrizeKfoJpSZEqH0ZF9lyzRXnPqqPl1NrnP76riCVjR52NSSIy
         xRcyYuVzaZfFZvRoejCUt51bFXLUdDqttB8r4kuqFZRXsBtBOFGJhOh6b63F1H2IKB48
         Gh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ir0hkxKp06lyjpW+N3OnlzR0oShw90IT9FdI40kBm0o=;
        b=HAgzw9QAeD6/oJ3pAM4JMm+ODnPSYGW/zfjSD0nKVGkr/fRQG4b83FEhFFOMiTWSVu
         PAWC83H3fCObZSwwW+swKTVHZE5yHVXbk2NOHhWmgHPJSxpFeJqbj6o8R5iQsr2lPe5I
         35EPaupbswdwsPfRRE0RmprUslVr6i6eFO1OGko1kphy1Dw0inB/LlQ4PvSJlug11PJ4
         w+t+7b3cf8XdaVRL+8M71t9U1IBXo+wOlhGrx+hIxtXaeJ0O9Nig6m/LSnoyO/1TtzMn
         R4OV0rs0HpUTvIk1XWA6Qn6hYJ82cQaDEvBVefTjrnAupCjPkW98RcUYV9aVdpCcYQEg
         O25Q==
X-Gm-Message-State: APf1xPBldeNbskqxiiqufbN2Yh7fxh4xTWLbBeG4m31q7i9Y3mi70RN8
        fgpPcTxoyglUZwBccwwy8UFM5hCFeDQ=
X-Google-Smtp-Source: AH8x227h6J4zWsdgcvB63thlVskFh+ACX9GkO0vwqxy0mhfRQ4x2JYMAK/CIbwha9dbe3rfgPMp8cw==
X-Received: by 10.98.35.211 with SMTP id q80mr525948pfj.64.1517875675596;
        Mon, 05 Feb 2018 16:07:55 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 77sm18686905pfz.167.2018.02.05.16.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:07:54 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 065/194] object-store: add repository argument to sha1_object_info
Date:   Mon,  5 Feb 2018 15:55:26 -0800
Message-Id: <20180205235735.216710-45-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of sha1_object_info
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

In the expanded macro the identifier `the_repository` is not actually used,
so the compiler does not catch if the repository.h header is not included
at the call site. call sites needing that #include were identified by
changing the macro to definition to

  #define sha1_object_info(r, sha1, size) \
      (r, sha1_object_info_##r(sha1, size)).

This produces a compiler warning about the left hand side of the comma
operator being unused, which can be suppressed using -Wno-unused-value.

To avoid breaking bisection, do not include this trick in the patch.

There is a large number of callers. The included coccinelle semantic patch
will adapt any new callers in the diff produced by `make coccicheck`.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 archive-tar.c                             |  3 ++-
 archive-zip.c                             |  4 +++-
 blame.c                                   |  5 +++--
 builtin/cat-file.c                        |  6 +++---
 builtin/fast-export.c                     |  3 ++-
 builtin/fetch.c                           |  3 ++-
 builtin/fsck.c                            |  3 ++-
 builtin/index-pack.c                      |  7 +++++--
 builtin/ls-tree.c                         |  3 ++-
 builtin/mktree.c                          |  3 ++-
 builtin/pack-objects.c                    |  9 ++++++---
 builtin/prune.c                           |  3 ++-
 builtin/replace.c                         | 12 +++++++-----
 builtin/tag.c                             |  5 +++--
 builtin/unpack-objects.c                  |  4 +++-
 contrib/coccinelle/sha1_object_info.cocci |  7 +++++++
 diff.c                                    |  4 +++-
 fast-import.c                             | 16 +++++++++++-----
 list-objects-filter.c                     |  2 +-
 object-store.h                            |  5 ++++-
 object.c                                  |  2 +-
 pack-bitmap-write.c                       |  4 +++-
 packfile.c                                |  2 +-
 reachable.c                               |  2 +-
 refs.c                                    |  2 +-
 remote.c                                  |  3 ++-
 sequencer.c                               |  5 ++++-
 sha1_file.c                               |  4 ++--
 sha1_name.c                               | 12 ++++++------
 submodule.c                               |  2 +-
 tag.c                                     |  3 ++-
 31 files changed, 97 insertions(+), 51 deletions(-)
 create mode 100644 contrib/coccinelle/sha1_object_info.cocci

diff --git a/archive-tar.c b/archive-tar.c
index 909347c108..b10c9b8911 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -5,6 +5,7 @@
 #include "config.h"
 #include "tar.h"
 #include "archive.h"
+#include "repository.h"
 #include "object-store.h"
 #include "streaming.h"
 #include "run-command.h"
@@ -277,7 +278,7 @@ static int write_tar_entry(struct archiver_args *args,
 		memcpy(header.name, path, pathlen);
 
 	if (S_ISREG(mode) && !args->convert &&
-	    sha1_object_info(sha1, &size) == OBJ_BLOB &&
+	    sha1_object_info(the_repository, sha1, &size) == OBJ_BLOB &&
 	    size > big_file_threshold)
 		buffer = NULL;
 	else if (S_ISLNK(mode) || S_ISREG(mode)) {
diff --git a/archive-zip.c b/archive-zip.c
index 233fed3a61..03321b9777 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -6,6 +6,7 @@
 #include "archive.h"
 #include "streaming.h"
 #include "utf8.h"
+#include "repository.h"
 #include "object-store.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
@@ -326,7 +327,8 @@ static int write_zip_entry(struct archiver_args *args,
 		compressed_size = 0;
 		buffer = NULL;
 	} else if (S_ISREG(mode) || S_ISLNK(mode)) {
-		enum object_type type = sha1_object_info(sha1, &size);
+		enum object_type type = sha1_object_info(the_repository, sha1,
+							 &size);
 
 		method = 0;
 		attr2 = S_ISLNK(mode) ? ((mode | 0777) << 16) :
diff --git a/blame.c b/blame.c
index 61f0f6bb40..f95a53898d 100644
--- a/blame.c
+++ b/blame.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "refs.h"
+#include "repository.h"
 #include "object-store.h"
 #include "cache-tree.h"
 #include "mergesort.h"
@@ -82,7 +83,7 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 		unsigned mode;
 
 		if (!get_tree_entry(commit_oid->hash, path, blob_oid.hash, &mode) &&
-		    sha1_object_info(blob_oid.hash, NULL) == OBJ_BLOB)
+		    sha1_object_info(the_repository, blob_oid.hash, NULL) == OBJ_BLOB)
 			return;
 	}
 
@@ -507,7 +508,7 @@ static int fill_blob_sha1_and_mode(struct blame_origin *origin)
 			   origin->path,
 			   origin->blob_oid.hash, &origin->mode))
 		goto error_out;
-	if (sha1_object_info(origin->blob_oid.hash, NULL) != OBJ_BLOB)
+	if (sha1_object_info(the_repository, origin->blob_oid.hash, NULL) != OBJ_BLOB)
 		goto error_out;
 	return 0;
  error_out:
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index fdc70aa419..96c834b8f4 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -117,7 +117,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		/* else fallthrough */
 
 	case 'p':
-		type = sha1_object_info(oid.hash, NULL);
+		type = sha1_object_info(the_repository, oid.hash, NULL);
 		if (type < 0)
 			die("Not a valid object name %s", obj_name);
 
@@ -141,7 +141,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	case 0:
 		if (type_from_string(exp_type) == OBJ_BLOB) {
 			struct object_id blob_oid;
-			if (sha1_object_info(oid.hash, NULL) == OBJ_TAG) {
+			if (sha1_object_info(the_repository, oid.hash, NULL) == OBJ_TAG) {
 				char *buffer = read_sha1_file(oid.hash, &type, &size);
 				const char *target;
 				if (!skip_prefix(buffer, "object ", &target) ||
@@ -151,7 +151,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			} else
 				oidcpy(&blob_oid, &oid);
 
-			if (sha1_object_info(blob_oid.hash, NULL) == OBJ_BLOB)
+			if (sha1_object_info(the_repository, blob_oid.hash, NULL) == OBJ_BLOB)
 				return stream_blob_to_fd(1, &blob_oid, NULL, 0);
 			/*
 			 * we attempted to dereference a tag to a blob
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index f76b7bda79..d4e53908c6 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "config.h"
 #include "refs.h"
+#include "repository.h"
 #include "object-store.h"
 #include "commit.h"
 #include "object.h"
@@ -948,7 +949,7 @@ static void import_marks(char *input_file)
 		if (last_idnum < mark)
 			last_idnum = mark;
 
-		type = sha1_object_info(oid.hash, NULL);
+		type = sha1_object_info(the_repository, oid.hash, NULL);
 		if (type < 0)
 			die("object not found: %s", oid_to_hex(&oid));
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9b7202953b..276beebbb1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -5,6 +5,7 @@
 #include "config.h"
 #include "repository.h"
 #include "refs.h"
+#include "repository.h"
 #include "object-store.h"
 #include "commit.h"
 #include "builtin.h"
@@ -624,7 +625,7 @@ static int update_local_ref(struct ref *ref,
 	struct branch *current_branch = branch_get(NULL);
 	const char *pretty_ref = prettify_refname(ref->name);
 
-	type = sha1_object_info(ref->new_oid.hash, NULL);
+	type = sha1_object_info(the_repository, ref->new_oid.hash, NULL);
 	if (type < 0)
 		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 920cc50923..f5e3c51077 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -69,7 +69,8 @@ static const char *printable_type(struct object *obj)
 	const char *ret;
 
 	if (obj->type == OBJ_NONE) {
-		enum object_type type = sha1_object_info(obj->oid.hash, NULL);
+		enum object_type type = sha1_object_info(the_repository,
+							 obj->oid.hash, NULL);
 		if (type > 0)
 			object_as_type(obj, type, 0);
 	}
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1902d4e096..b9851ad69d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -12,6 +12,7 @@
 #include "exec_cmd.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "repository.h"
 #include "object-store.h"
 #include "packfile.h"
 
@@ -222,7 +223,8 @@ static unsigned check_object(struct object *obj)
 
 	if (!(obj->flags & FLAG_CHECKED)) {
 		unsigned long size;
-		int type = sha1_object_info(obj->oid.hash, &size);
+		int type = sha1_object_info(the_repository, obj->oid.hash,
+					    &size);
 		if (type <= 0)
 			die(_("did not receive expected object %s"),
 			      oid_to_hex(&obj->oid));
@@ -811,7 +813,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 		enum object_type has_type;
 		unsigned long has_size;
 		read_lock();
-		has_type = sha1_object_info(oid->hash, &has_size);
+		has_type = sha1_object_info(the_repository, oid->hash,
+					    &has_size);
 		if (has_type < 0)
 			die(_("cannot read existing object info %s"), oid_to_hex(oid));
 		if (has_type != type || has_size != size)
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 78fcced566..d929da03b4 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "repository.h"
 #include "object-store.h"
 #include "blob.h"
 #include "tree.h"
@@ -95,7 +96,7 @@ static int show_tree(const unsigned char *sha1, struct strbuf *base,
 			char size_text[24];
 			if (!strcmp(type, blob_type)) {
 				unsigned long size;
-				if (sha1_object_info(sha1, &size) == OBJ_BAD)
+				if (sha1_object_info(the_repository, sha1, &size) == OBJ_BAD)
 					xsnprintf(size_text, sizeof(size_text),
 						  "BAD");
 				else
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 0f66946618..ccb3a7a897 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -7,6 +7,7 @@
 #include "quote.h"
 #include "tree.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "object-store.h"
 
 static struct treeent {
@@ -117,7 +118,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 	}
 
 	/* Check the type of object identified by sha1 */
-	obj_type = sha1_object_info(sha1, NULL);
+	obj_type = sha1_object_info(the_repository, sha1, NULL);
 	if (obj_type < 0) {
 		if (allow_missing) {
 			; /* no problem - missing objects are presumed to be of the right type */
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7cb73c29ac..79ec5c6842 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1519,7 +1519,8 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	entry->type = sha1_object_info(entry->idx.oid.hash, &entry->size);
+	entry->type = sha1_object_info(the_repository, entry->idx.oid.hash,
+				       &entry->size);
 	/*
 	 * The error condition is checked in prepare_pack().  This is
 	 * to permit a missing preferred base object to be ignored
@@ -1581,7 +1582,8 @@ static void drop_reused_delta(struct object_entry *entry)
 		 * And if that fails, the error will be recorded in entry->type
 		 * and dealt with in prepare_pack().
 		 */
-		entry->type = sha1_object_info(entry->idx.oid.hash,
+		entry->type = sha1_object_info(the_repository,
+					       entry->idx.oid.hash,
 					       &entry->size);
 	}
 }
@@ -2689,7 +2691,8 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 static int add_loose_object(const struct object_id *oid, const char *path,
 			    void *data)
 {
-	enum object_type type = sha1_object_info(oid->hash, NULL);
+	enum object_type type = sha1_object_info(the_repository, oid->hash,
+						 NULL);
 
 	if (type < 0) {
 		warning("loose object at %s could not be examined", path);
diff --git a/builtin/prune.c b/builtin/prune.c
index 52091f299e..7891048b35 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -51,7 +51,8 @@ static int prune_object(const struct object_id *oid, const char *fullpath,
 	if (st.st_mtime > expire)
 		return 0;
 	if (show_only || verbose) {
-		enum object_type type = sha1_object_info(oid->hash, NULL);
+		enum object_type type = sha1_object_info(the_repository,
+							 oid->hash, NULL);
 		printf("%s %s\n", oid_to_hex(oid),
 		       (type > 0) ? typename(type) : "unknown");
 	}
diff --git a/builtin/replace.c b/builtin/replace.c
index 6d27dd73f0..25322d2f73 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -55,8 +55,10 @@ static int show_reference(const char *refname, const struct object_id *oid,
 			if (get_oid(refname, &object))
 				return error("Failed to resolve '%s' as a valid ref.", refname);
 
-			obj_type = sha1_object_info(object.hash, NULL);
-			repl_type = sha1_object_info(oid->hash, NULL);
+			obj_type = sha1_object_info(the_repository,
+						    object.hash, NULL);
+			repl_type = sha1_object_info(the_repository,
+						     oid->hash, NULL);
 
 			printf("%s (%s) -> %s (%s)\n", refname, typename(obj_type),
 			       oid_to_hex(oid), typename(repl_type));
@@ -164,8 +166,8 @@ static int replace_object_oid(const char *object_ref,
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
-	obj_type = sha1_object_info(object->hash, NULL);
-	repl_type = sha1_object_info(repl->hash, NULL);
+	obj_type = sha1_object_info(the_repository, object->hash, NULL);
+	repl_type = sha1_object_info(the_repository, repl->hash, NULL);
 	if (!force && obj_type != repl_type)
 		die("Objects must be of the same type.\n"
 		    "'%s' points to a replaced object of type '%s'\n"
@@ -292,7 +294,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	if (get_oid(object_ref, &old) < 0)
 		die("Not a valid object name: '%s'", object_ref);
 
-	type = sha1_object_info(old.hash, NULL);
+	type = sha1_object_info(the_repository, old.hash, NULL);
 	if (type < 0)
 		die("unable to get object type for %s", oid_to_hex(&old));
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 7ed3506fff..014d7c9e9b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "refs.h"
+#include "repository.h"
 #include "object-store.h"
 #include "tag.h"
 #include "run-command.h"
@@ -211,7 +212,7 @@ static void create_tag(const struct object_id *object, const char *tag,
 	struct strbuf header = STRBUF_INIT;
 	char *path = NULL;
 
-	type = sha1_object_info(object->hash, NULL);
+	type = sha1_object_info(the_repository, object->hash, NULL);
 	if (type <= OBJ_NONE)
 	    die(_("bad object type."));
 
@@ -294,7 +295,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 	}
 
 	strbuf_addstr(sb, " (");
-	type = sha1_object_info(oid->hash, NULL);
+	type = sha1_object_info(the_repository, oid->hash, NULL);
 	switch (type) {
 	default:
 		strbuf_addstr(sb, "object of unknown type");
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 6d03ea2670..ee707068b3 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "repository.h"
 #include "object-store.h"
 #include "object.h"
 #include "delta.h"
@@ -198,7 +199,8 @@ static int check_object(struct object *obj, int type, void *data, struct fsck_op
 
 	if (!(obj->flags & FLAG_OPEN)) {
 		unsigned long size;
-		int type = sha1_object_info(obj->oid.hash, &size);
+		int type = sha1_object_info(the_repository, obj->oid.hash,
+					    &size);
 		if (type != obj->type || type <= 0)
 			die("object of unexpected type");
 		obj->flags |= FLAG_WRITTEN;
diff --git a/contrib/coccinelle/sha1_object_info.cocci b/contrib/coccinelle/sha1_object_info.cocci
new file mode 100644
index 0000000000..800e0581e5
--- /dev/null
+++ b/contrib/coccinelle/sha1_object_info.cocci
@@ -0,0 +1,7 @@
+@@
+expression E;
+expression F;
+@@
+ sha1_object_info(
++the_repository,
+ E, F)
diff --git a/diff.c b/diff.c
index e89c7d9919..08bff6e720 100644
--- a/diff.c
+++ b/diff.c
@@ -13,6 +13,7 @@
 #include "attr.h"
 #include "run-command.h"
 #include "utf8.h"
+#include "repository.h"
 #include "object-store.h"
 #include "userdiff.h"
 #include "submodule-config.h"
@@ -3616,7 +3617,8 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 	else {
 		enum object_type type;
 		if (size_only || (flags & CHECK_BINARY)) {
-			type = sha1_object_info(s->oid.hash, &s->size);
+			type = sha1_object_info(the_repository, s->oid.hash,
+						&s->size);
 			if (type < 0)
 				die("unable to read %s",
 				    oid_to_hex(&s->oid));
diff --git a/fast-import.c b/fast-import.c
index 39cd0b7540..2542f600ef 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1913,7 +1913,9 @@ static void read_marks(void)
 			die("corrupt mark line: %s", line);
 		e = find_object(&oid);
 		if (!e) {
-			enum object_type type = sha1_object_info(oid.hash, NULL);
+			enum object_type type = sha1_object_info(the_repository,
+								 oid.hash,
+								 NULL);
 			if (type < 0)
 				die("object not found: %s", oid_to_hex(&oid));
 			e = insert_object(&oid);
@@ -2443,7 +2445,8 @@ static void file_change_m(const char *p, struct branch *b)
 		enum object_type expected = S_ISDIR(mode) ?
 						OBJ_TREE: OBJ_BLOB;
 		enum object_type type = oe ? oe->type :
-					sha1_object_info(oid.hash, NULL);
+					sha1_object_info(the_repository,
+							 oid.hash, NULL);
 		if (type < 0)
 			die("%s not found: %s",
 					S_ISDIR(mode) ?  "Tree" : "Blob",
@@ -2603,7 +2606,8 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 			die("Not a blob (actually a %s): %s",
 				typename(oe->type), command_buf.buf);
 	} else if (!is_null_oid(&oid)) {
-		enum object_type type = sha1_object_info(oid.hash, NULL);
+		enum object_type type = sha1_object_info(the_repository,
+							 oid.hash, NULL);
 		if (type < 0)
 			die("Blob not found: %s", command_buf.buf);
 		if (type != OBJ_BLOB)
@@ -2890,7 +2894,8 @@ static void parse_new_tag(const char *arg)
 	} else if (!get_oid(from, &oid)) {
 		struct object_entry *oe = find_object(&oid);
 		if (!oe) {
-			type = sha1_object_info(oid.hash, NULL);
+			type = sha1_object_info(the_repository, oid.hash,
+						NULL);
 			if (type < 0)
 				die("Not a valid object: %s", from);
 		} else
@@ -3048,7 +3053,8 @@ static struct object_entry *dereference(struct object_entry *oe,
 	unsigned long size;
 	char *buf = NULL;
 	if (!oe) {
-		enum object_type type = sha1_object_info(oid->hash, NULL);
+		enum object_type type = sha1_object_info(the_repository,
+							 oid->hash, NULL);
 		if (type < 0)
 			die("object not found: %s", oid_to_hex(oid));
 		/* cache it! */
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 4356c45368..180d8729d9 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -117,7 +117,7 @@ static enum list_objects_filter_result filter_blobs_limit(
 		assert(obj->type == OBJ_BLOB);
 		assert((obj->flags & SEEN) == 0);
 
-		t = sha1_object_info(obj->oid.hash, &object_length);
+		t = sha1_object_info(the_repository, obj->oid.hash, &object_length);
 		if (t != OBJ_BLOB) { /* probably OBJ_NONE */
 			/*
 			 * We DO NOT have the blob locally, so we cannot
diff --git a/object-store.h b/object-store.h
index e1e592bdd5..4ff60e3be0 100644
--- a/object-store.h
+++ b/object-store.h
@@ -91,7 +91,10 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
 }
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
-extern int sha1_object_info(const unsigned char *, unsigned long *);
+
+#define sha1_object_info(r, sha1, size) \
+	sha1_object_info_##r(sha1, size)
+extern int sha1_object_info_the_repository(const unsigned char *, unsigned long *);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, struct object_id *oid, unsigned flags);
diff --git a/object.c b/object.c
index a5cafb10e7..40f7c7bdab 100644
--- a/object.c
+++ b/object.c
@@ -256,7 +256,7 @@ struct object *parse_object(const struct object_id *oid)
 
 	if ((obj && obj->type == OBJ_BLOB) ||
 	    (!obj && has_object_file(oid) &&
-	     sha1_object_info(oid->hash, NULL) == OBJ_BLOB)) {
+	     sha1_object_info(the_repository, oid->hash, NULL) == OBJ_BLOB)) {
 		if (check_sha1_signature(repl, NULL, 0, NULL) < 0) {
 			error("sha1 mismatch %s", oid_to_hex(oid));
 			return NULL;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 6a656104af..f684ed5ea2 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "object-store.h"
 #include "commit.h"
 #include "tag.h"
@@ -74,7 +75,8 @@ void bitmap_writer_build_type_index(struct pack_idx_entry **index,
 			break;
 
 		default:
-			real_type = sha1_object_info(entry->idx.oid.hash,
+			real_type = sha1_object_info(the_repository,
+						     entry->idx.oid.hash,
 						     NULL);
 			break;
 		}
diff --git a/packfile.c b/packfile.c
index b73814f2ce..a1c1b1a42e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1092,7 +1092,7 @@ static int retry_bad_packed_offset(struct packed_git *p, off_t obj_offset)
 		return OBJ_BAD;
 	sha1 = nth_packed_object_sha1(p, revidx->nr);
 	mark_bad_packed_object(p, sha1);
-	type = sha1_object_info(sha1, NULL);
+	type = sha1_object_info(the_repository, sha1, NULL);
 	if (type <= OBJ_NONE)
 		return OBJ_BAD;
 	return type;
diff --git a/reachable.c b/reachable.c
index ac5224b9a5..7e7b9525c0 100644
--- a/reachable.c
+++ b/reachable.c
@@ -79,7 +79,7 @@ static void add_recent_object(const struct object_id *oid,
 	 * later processing, and the revision machinery expects
 	 * commits and tags to have been parsed.
 	 */
-	type = sha1_object_info(oid->hash, NULL);
+	type = sha1_object_info(the_repository, oid->hash, NULL);
 	if (type < 0)
 		die("unable to get object info for %s", oid_to_hex(oid));
 
diff --git a/refs.c b/refs.c
index e534ff4256..ddcb4a908f 100644
--- a/refs.c
+++ b/refs.c
@@ -303,7 +303,7 @@ enum peel_status peel_object(const struct object_id *name, struct object_id *oid
 	struct object *o = lookup_unknown_object(name->hash);
 
 	if (o->type == OBJ_NONE) {
-		int type = sha1_object_info(name->hash, NULL);
+		int type = sha1_object_info(the_repository, name->hash, NULL);
 		if (type < 0 || !object_as_type(o, type, 0))
 			return PEEL_INVALID;
 	}
diff --git a/remote.c b/remote.c
index 5112f370c3..fd8cd8ce77 100644
--- a/remote.c
+++ b/remote.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "remote.h"
 #include "refs.h"
+#include "repository.h"
 #include "object-store.h"
 #include "commit.h"
 #include "diff.h"
@@ -1362,7 +1363,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			continue; /* not a tag */
 		if (string_list_has_string(&dst_tag, ref->name))
 			continue; /* they already have it */
-		if (sha1_object_info(ref->new_oid.hash, NULL) != OBJ_TAG)
+		if (sha1_object_info(the_repository, ref->new_oid.hash, NULL) != OBJ_TAG)
 			continue; /* be conservative */
 		item = string_list_append(&src_tag, ref->name);
 		item->util = ref;
diff --git a/sequencer.c b/sequencer.c
index 234addd4e7..311f00acda 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3,6 +3,7 @@
 #include "lockfile.h"
 #include "sequencer.h"
 #include "dir.h"
+#include "repository.h"
 #include "object-store.h"
 #include "object.h"
 #include "commit.h"
@@ -2347,7 +2348,9 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 
 		if (!get_oid(name, &oid)) {
 			if (!lookup_commit_reference_gently(&oid, 1)) {
-				enum object_type type = sha1_object_info(oid.hash, NULL);
+				enum object_type type = sha1_object_info(the_repository,
+									 oid.hash,
+									 NULL);
 				return error(_("%s: can't cherry-pick a %s"),
 					name, typename(type));
 			}
diff --git a/sha1_file.c b/sha1_file.c
index a6df4b61c7..01bdb3cd7a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1310,7 +1310,7 @@ int sha1_object_info_extended_the_repository(const unsigned char *sha1, struct o
 }
 
 /* returns enum object_type or negative */
-int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
+int sha1_object_info_the_repository(const unsigned char *sha1, unsigned long *sizep)
 {
 	enum object_type type;
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -1962,7 +1962,7 @@ int read_pack_header(int fd, struct pack_header *header)
 
 void assert_sha1_type(const unsigned char *sha1, enum object_type expect)
 {
-	enum object_type type = sha1_object_info(sha1, NULL);
+	enum object_type type = sha1_object_info(the_repository, sha1, NULL);
 	if (type < 0)
 		die("%s is not a valid object", sha1_to_hex(sha1));
 	if (type != expect)
diff --git a/sha1_name.c b/sha1_name.c
index 03ce2ff7f2..190710c638 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -243,7 +243,7 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 
 static int disambiguate_commit_only(const struct object_id *oid, void *cb_data_unused)
 {
-	int kind = sha1_object_info(oid->hash, NULL);
+	int kind = sha1_object_info(the_repository, oid->hash, NULL);
 	return kind == OBJ_COMMIT;
 }
 
@@ -252,7 +252,7 @@ static int disambiguate_committish_only(const struct object_id *oid, void *cb_da
 	struct object *obj;
 	int kind;
 
-	kind = sha1_object_info(oid->hash, NULL);
+	kind = sha1_object_info(the_repository, oid->hash, NULL);
 	if (kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
@@ -267,7 +267,7 @@ static int disambiguate_committish_only(const struct object_id *oid, void *cb_da
 
 static int disambiguate_tree_only(const struct object_id *oid, void *cb_data_unused)
 {
-	int kind = sha1_object_info(oid->hash, NULL);
+	int kind = sha1_object_info(the_repository, oid->hash, NULL);
 	return kind == OBJ_TREE;
 }
 
@@ -276,7 +276,7 @@ static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_
 	struct object *obj;
 	int kind;
 
-	kind = sha1_object_info(oid->hash, NULL);
+	kind = sha1_object_info(the_repository, oid->hash, NULL);
 	if (kind == OBJ_TREE || kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
@@ -291,7 +291,7 @@ static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_
 
 static int disambiguate_blob_only(const struct object_id *oid, void *cb_data_unused)
 {
-	int kind = sha1_object_info(oid->hash, NULL);
+	int kind = sha1_object_info(the_repository, oid->hash, NULL);
 	return kind == OBJ_BLOB;
 }
 
@@ -370,7 +370,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	if (ds->fn && !ds->fn(oid, ds->cb_data))
 		return 0;
 
-	type = sha1_object_info(oid->hash, NULL);
+	type = sha1_object_info(the_repository, oid->hash, NULL);
 	if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(oid);
 		if (commit) {
diff --git a/submodule.c b/submodule.c
index f7736ec4b5..dc57c176e8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -818,7 +818,7 @@ static int check_has_commit(const struct object_id *oid, void *data)
 {
 	struct has_commit_data *cb = data;
 
-	enum object_type type = sha1_object_info(oid->hash, NULL);
+	enum object_type type = sha1_object_info(the_repository, oid->hash, NULL);
 
 	switch (type) {
 	case OBJ_COMMIT:
diff --git a/tag.c b/tag.c
index 30798abf1f..7b32afd123 100644
--- a/tag.c
+++ b/tag.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tag.h"
+#include "repository.h"
 #include "object-store.h"
 #include "commit.h"
 #include "tree.h"
@@ -42,7 +43,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 	unsigned long size;
 	int ret;
 
-	type = sha1_object_info(oid->hash, NULL);
+	type = sha1_object_info(the_repository, oid->hash, NULL);
 	if (type != OBJ_TAG)
 		return error("%s: cannot verify a non-tag object of type %s.",
 				name_to_report ?
-- 
2.15.1.433.g936d1b9894.dirty

