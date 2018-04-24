Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B0461F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeDXV7W (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:59:22 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:37336 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeDXV7T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:59:19 -0400
Received: by mail-pg0-f51.google.com with SMTP id a13so7383469pgu.4
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qNFihDFB90+wYawwx4T6/QSxL1Niw9xpqhtFRyk59aM=;
        b=fvdb6R8Lk5KF5cFqbmW+VJKzNf8gkznVWAuY20veJ1E3m7A4EcozTRopeBzQrVb5cp
         +ZKv9GFqKwvXLCESm1FaExsweRparcMeCoyWDVLTt9rwNDAF1KpcVw4Gd3rjq9SoJdMc
         hFdactwAGOPKZv3lUfu+Sr+HE7MjeYiGOSX4O1g2TFkfng8Syg1THII5yfzFYfDvesaq
         dWOizkBXjjT0+o3JlpaPUfyccqSSRFM/0DidbMhVGZBNR6BbViKOPDkhhVhBE2yE4UUZ
         hstizyWsvYJVchIUaSlwFd+CioZvWuIx56AQli8rnIK1wmdOpRXBlBnO/7JVr6ci8Gv3
         UHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qNFihDFB90+wYawwx4T6/QSxL1Niw9xpqhtFRyk59aM=;
        b=JCglQX0IXdSN8ii7E9RG0WH2r/Wztcpzcb3hgKc1vc3xuBPFrWOOsqF1VeU+epOORW
         mKGFapN7vMRL0xgbW1tigfXz+KURJlw+kY3pMkTxvuDRAWnMuUO0bUSU+G1lO7oR9yBQ
         Jw09OVX7T8WHoQFKuJ5gvTv2lTL/hhIvyNCINGLT3VpU+GcUNYf68l5HwutyBgZV2Jwv
         /RwCz9V1M3Kn42W7263OVw4OUfXa8YQttem8BnkfKdcdUegiHSikA+iCXufZQdHVxew4
         Gde8DT1gh/WqguDtM/IA5C0iJRaiigmgpKeVvFfbj+jujgqL6cUfyoe5Fat3A/02L4CX
         JqeQ==
X-Gm-Message-State: ALQs6tC/YUP+TP4Qh61Px3e/7LSPM2wNzhe+yFhE2dEGrJ0XfqvdYWCP
        4T8i/78wNuwcbgySeDstye9veC9KLl0=
X-Google-Smtp-Source: AIpwx48SYh8qm/gB2H3z2oR2VRfiNUeZOKSMqx8IGZimC94wZB1/qJgAGjjGyCo29Z6FhpcncnNRUQ==
X-Received: by 10.99.97.8 with SMTP id v8mr21552696pgb.245.1524607157258;
        Tue, 24 Apr 2018 14:59:17 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id w26sm35803779pfi.17.2018.04.24.14.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:59:16 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     bmwill@google.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/9] cache.h: add repository argument to oid_object_info
Date:   Tue, 24 Apr 2018 14:59:02 -0700
Message-Id: <20180424215910.22201-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424215910.22201-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of oid_object_info
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 archive-tar.c            |  2 +-
 archive-zip.c            |  3 ++-
 blame.c                  |  4 ++--
 builtin/blame.c          |  2 +-
 builtin/cat-file.c       |  6 +++---
 builtin/describe.c       |  2 +-
 builtin/fast-export.c    |  2 +-
 builtin/fetch.c          |  2 +-
 builtin/fsck.c           |  3 ++-
 builtin/index-pack.c     |  4 ++--
 builtin/ls-tree.c        |  2 +-
 builtin/mktree.c         |  2 +-
 builtin/pack-objects.c   |  8 +++++---
 builtin/prune.c          |  3 ++-
 builtin/replace.c        | 11 ++++++-----
 builtin/tag.c            |  4 ++--
 builtin/unpack-objects.c |  2 +-
 cache.h                  |  3 ++-
 diff.c                   |  3 ++-
 fast-import.c            | 14 +++++++++-----
 list-objects-filter.c    |  2 +-
 object.c                 |  2 +-
 pack-bitmap-write.c      |  3 ++-
 packfile.c               |  2 +-
 reachable.c              |  2 +-
 refs.c                   |  2 +-
 remote.c                 |  2 +-
 sequencer.c              |  3 ++-
 sha1_file.c              |  4 ++--
 sha1_name.c              | 12 ++++++------
 submodule.c              |  2 +-
 tag.c                    |  2 +-
 32 files changed, 67 insertions(+), 53 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 3563bcb9f2..f93409324f 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -276,7 +276,7 @@ static int write_tar_entry(struct archiver_args *args,
 		memcpy(header.name, path, pathlen);
 
 	if (S_ISREG(mode) && !args->convert &&
-	    oid_object_info(oid, &size) == OBJ_BLOB &&
+	    oid_object_info(the_repository, oid, &size) == OBJ_BLOB &&
 	    size > big_file_threshold)
 		buffer = NULL;
 	else if (S_ISLNK(mode) || S_ISREG(mode)) {
diff --git a/archive-zip.c b/archive-zip.c
index 6b20bce4d1..74f3fe9103 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -325,7 +325,8 @@ static int write_zip_entry(struct archiver_args *args,
 		compressed_size = 0;
 		buffer = NULL;
 	} else if (S_ISREG(mode) || S_ISLNK(mode)) {
-		enum object_type type = oid_object_info(oid, &size);
+		enum object_type type = oid_object_info(the_repository, oid,
+							&size);
 
 		method = 0;
 		attr2 = S_ISLNK(mode) ? ((mode | 0777) << 16) :
diff --git a/blame.c b/blame.c
index 78c9808bd1..dfa24473dc 100644
--- a/blame.c
+++ b/blame.c
@@ -81,7 +81,7 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 		unsigned mode;
 
 		if (!get_tree_entry(commit_oid, path, &blob_oid, &mode) &&
-		    oid_object_info(&blob_oid, NULL) == OBJ_BLOB)
+		    oid_object_info(the_repository, &blob_oid, NULL) == OBJ_BLOB)
 			return;
 	}
 
@@ -504,7 +504,7 @@ static int fill_blob_sha1_and_mode(struct blame_origin *origin)
 		return 0;
 	if (get_tree_entry(&origin->commit->object.oid, origin->path, &origin->blob_oid, &origin->mode))
 		goto error_out;
-	if (oid_object_info(&origin->blob_oid, NULL) != OBJ_BLOB)
+	if (oid_object_info(the_repository, &origin->blob_oid, NULL) != OBJ_BLOB)
 		goto error_out;
 	return 0;
  error_out:
diff --git a/builtin/blame.c b/builtin/blame.c
index db38c0b307..bfdf7cc132 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -655,7 +655,7 @@ static int is_a_rev(const char *name)
 
 	if (get_oid(name, &oid))
 		return 0;
-	return OBJ_NONE < oid_object_info(&oid, NULL);
+	return OBJ_NONE < oid_object_info(the_repository, &oid, NULL);
 }
 
 int cmd_blame(int argc, const char **argv, const char *prefix)
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4ecdb9ff54..b8ecbea98e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -116,7 +116,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		/* else fallthrough */
 
 	case 'p':
-		type = oid_object_info(&oid, NULL);
+		type = oid_object_info(the_repository, &oid, NULL);
 		if (type < 0)
 			die("Not a valid object name %s", obj_name);
 
@@ -140,7 +140,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	case 0:
 		if (type_from_string(exp_type) == OBJ_BLOB) {
 			struct object_id blob_oid;
-			if (oid_object_info(&oid, NULL) == OBJ_TAG) {
+			if (oid_object_info(the_repository, &oid, NULL) == OBJ_TAG) {
 				char *buffer = read_object_file(&oid, &type,
 								&size);
 				const char *target;
@@ -151,7 +151,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			} else
 				oidcpy(&blob_oid, &oid);
 
-			if (oid_object_info(&blob_oid, NULL) == OBJ_BLOB)
+			if (oid_object_info(the_repository, &blob_oid, NULL) == OBJ_BLOB)
 				return stream_blob_to_fd(1, &blob_oid, NULL, 0);
 			/*
 			 * we attempted to dereference a tag to a blob
diff --git a/builtin/describe.c b/builtin/describe.c
index de840f96a4..66c497f789 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -502,7 +502,7 @@ static void describe(const char *arg, int last_one)
 
 	if (cmit)
 		describe_commit(&oid, &sb);
-	else if (oid_object_info(&oid, NULL) == OBJ_BLOB)
+	else if (oid_object_info(the_repository, &oid, NULL) == OBJ_BLOB)
 		describe_blob(oid, &sb);
 	else
 		die(_("%s is neither a commit nor blob"), arg);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a15898d641..373c794873 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -947,7 +947,7 @@ static void import_marks(char *input_file)
 		if (last_idnum < mark)
 			last_idnum = mark;
 
-		type = oid_object_info(&oid, NULL);
+		type = oid_object_info(the_repository, &oid, NULL);
 		if (type < 0)
 			die("object not found: %s", oid_to_hex(&oid));
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index dcdfc66f09..73be393b2e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -637,7 +637,7 @@ static int update_local_ref(struct ref *ref,
 	struct branch *current_branch = branch_get(NULL);
 	const char *pretty_ref = prettify_refname(ref->name);
 
-	type = oid_object_info(&ref->new_oid, NULL);
+	type = oid_object_info(the_repository, &ref->new_oid, NULL);
 	if (type < 0)
 		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 087360a675..9d59d7d5a2 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -67,7 +67,8 @@ static const char *printable_type(struct object *obj)
 	const char *ret;
 
 	if (obj->type == OBJ_NONE) {
-		enum object_type type = oid_object_info(&obj->oid, NULL);
+		enum object_type type = oid_object_info(the_repository,
+							&obj->oid, NULL);
 		if (type > 0)
 			object_as_type(obj, type, 0);
 	}
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d81473e722..2d04a596f5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -223,7 +223,7 @@ static unsigned check_object(struct object *obj)
 
 	if (!(obj->flags & FLAG_CHECKED)) {
 		unsigned long size;
-		int type = oid_object_info(&obj->oid, &size);
+		int type = oid_object_info(the_repository, &obj->oid, &size);
 		if (type <= 0)
 			die(_("did not receive expected object %s"),
 			      oid_to_hex(&obj->oid));
@@ -812,7 +812,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 		enum object_type has_type;
 		unsigned long has_size;
 		read_lock();
-		has_type = oid_object_info(oid, &has_size);
+		has_type = oid_object_info(the_repository, oid, &has_size);
 		if (has_type < 0)
 			die(_("cannot read existing object info %s"), oid_to_hex(oid));
 		if (has_type != type || has_size != size)
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index d44b4f9c27..409da4e835 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -94,7 +94,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 			char size_text[24];
 			if (!strcmp(type, blob_type)) {
 				unsigned long size;
-				if (oid_object_info(oid, &size) == OBJ_BAD)
+				if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
 					xsnprintf(size_text, sizeof(size_text),
 						  "BAD");
 				else
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 263c530315..bb76b469fd 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -116,7 +116,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 	}
 
 	/* Check the type of object identified by sha1 */
-	obj_type = oid_object_info(&oid, NULL);
+	obj_type = oid_object_info(the_repository, &oid, NULL);
 	if (obj_type < 0) {
 		if (allow_missing) {
 			; /* no problem - missing objects are presumed to be of the right type */
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4bdae5a1d8..8d4111f748 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1516,7 +1516,8 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	entry->type = oid_object_info(&entry->idx.oid, &entry->size);
+	entry->type = oid_object_info(the_repository, &entry->idx.oid,
+				      &entry->size);
 	/*
 	 * The error condition is checked in prepare_pack().  This is
 	 * to permit a missing preferred base object to be ignored
@@ -1578,7 +1579,8 @@ static void drop_reused_delta(struct object_entry *entry)
 		 * And if that fails, the error will be recorded in entry->type
 		 * and dealt with in prepare_pack().
 		 */
-		entry->type = oid_object_info(&entry->idx.oid, &entry->size);
+		entry->type = oid_object_info(the_repository, &entry->idx.oid,
+					      &entry->size);
 	}
 }
 
@@ -2706,7 +2708,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 static int add_loose_object(const struct object_id *oid, const char *path,
 			    void *data)
 {
-	enum object_type type = oid_object_info(oid, NULL);
+	enum object_type type = oid_object_info(the_repository, oid, NULL);
 
 	if (type < 0) {
 		warning("loose object at %s could not be examined", path);
diff --git a/builtin/prune.c b/builtin/prune.c
index 38ced18dad..518ffbea13 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -50,7 +50,8 @@ static int prune_object(const struct object_id *oid, const char *fullpath,
 	if (st.st_mtime > expire)
 		return 0;
 	if (show_only || verbose) {
-		enum object_type type = oid_object_info(oid, NULL);
+		enum object_type type = oid_object_info(the_repository, oid,
+							NULL);
 		printf("%s %s\n", oid_to_hex(oid),
 		       (type > 0) ? type_name(type) : "unknown");
 	}
diff --git a/builtin/replace.c b/builtin/replace.c
index 237ea656cf..14e142d5a8 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -55,8 +55,9 @@ static int show_reference(const char *refname, const struct object_id *oid,
 			if (get_oid(refname, &object))
 				return error("Failed to resolve '%s' as a valid ref.", refname);
 
-			obj_type = oid_object_info(&object, NULL);
-			repl_type = oid_object_info(oid, NULL);
+			obj_type = oid_object_info(the_repository, &object,
+						   NULL);
+			repl_type = oid_object_info(the_repository, oid, NULL);
 
 			printf("%s (%s) -> %s (%s)\n", refname, type_name(obj_type),
 			       oid_to_hex(oid), type_name(repl_type));
@@ -164,8 +165,8 @@ static int replace_object_oid(const char *object_ref,
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
-	obj_type = oid_object_info(object, NULL);
-	repl_type = oid_object_info(repl, NULL);
+	obj_type = oid_object_info(the_repository, object, NULL);
+	repl_type = oid_object_info(the_repository, repl, NULL);
 	if (!force && obj_type != repl_type)
 		die("Objects must be of the same type.\n"
 		    "'%s' points to a replaced object of type '%s'\n"
@@ -292,7 +293,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	if (get_oid(object_ref, &old_oid) < 0)
 		die("Not a valid object name: '%s'", object_ref);
 
-	type = oid_object_info(&old_oid, NULL);
+	type = oid_object_info(the_repository, &old_oid, NULL);
 	if (type < 0)
 		die("unable to get object type for %s", oid_to_hex(&old_oid));
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 8cff6d0b72..26d7729f57 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -212,7 +212,7 @@ static void create_tag(const struct object_id *object, const char *tag,
 	struct strbuf header = STRBUF_INIT;
 	char *path = NULL;
 
-	type = oid_object_info(object, NULL);
+	type = oid_object_info(the_repository, object, NULL);
 	if (type <= OBJ_NONE)
 	    die(_("bad object type."));
 
@@ -298,7 +298,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 	}
 
 	strbuf_addstr(sb, " (");
-	type = oid_object_info(oid, NULL);
+	type = oid_object_info(the_repository, oid, NULL);
 	switch (type) {
 	default:
 		strbuf_addstr(sb, "object of unknown type");
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index b7755c6cc5..cfe9019f80 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -199,7 +199,7 @@ static int check_object(struct object *obj, int type, void *data, struct fsck_op
 
 	if (!(obj->flags & FLAG_OPEN)) {
 		unsigned long size;
-		int type = oid_object_info(&obj->oid, &size);
+		int type = oid_object_info(the_repository, &obj->oid, &size);
 		if (type != obj->type || type <= 0)
 			die("object of unexpected type");
 		obj->flags |= FLAG_WRITTEN;
diff --git a/cache.h b/cache.h
index 588c4fff9a..6340b2c572 100644
--- a/cache.h
+++ b/cache.h
@@ -1192,7 +1192,8 @@ static inline void *read_object_file(const struct object_id *oid, enum object_ty
 }
 
 /* Read and unpack an object file into memory, write memory to an object file */
-extern int oid_object_info(const struct object_id *, unsigned long *);
+#define oid_object_info(r, o, f) oid_object_info_##r(o, f)
+int oid_object_info_the_repository(const struct object_id *, unsigned long *);
 
 extern int hash_object_file(const void *buf, unsigned long len,
 			    const char *type, struct object_id *oid);
diff --git a/diff.c b/diff.c
index 1289df4b1f..4753170fe1 100644
--- a/diff.c
+++ b/diff.c
@@ -3638,7 +3638,8 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 	else {
 		enum object_type type;
 		if (size_only || (flags & CHECK_BINARY)) {
-			type = oid_object_info(&s->oid, &s->size);
+			type = oid_object_info(the_repository, &s->oid,
+					       &s->size);
 			if (type < 0)
 				die("unable to read %s",
 				    oid_to_hex(&s->oid));
diff --git a/fast-import.c b/fast-import.c
index 99f8f56e8c..afe06bd7c1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1917,7 +1917,8 @@ static void read_marks(void)
 			die("corrupt mark line: %s", line);
 		e = find_object(&oid);
 		if (!e) {
-			enum object_type type = oid_object_info(&oid, NULL);
+			enum object_type type = oid_object_info(the_repository,
+								&oid, NULL);
 			if (type < 0)
 				die("object not found: %s", oid_to_hex(&oid));
 			e = insert_object(&oid);
@@ -2447,7 +2448,8 @@ static void file_change_m(const char *p, struct branch *b)
 		enum object_type expected = S_ISDIR(mode) ?
 						OBJ_TREE: OBJ_BLOB;
 		enum object_type type = oe ? oe->type :
-					oid_object_info(&oid, NULL);
+					oid_object_info(the_repository, &oid,
+							NULL);
 		if (type < 0)
 			die("%s not found: %s",
 					S_ISDIR(mode) ?  "Tree" : "Blob",
@@ -2608,7 +2610,8 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 			die("Not a blob (actually a %s): %s",
 				type_name(oe->type), command_buf.buf);
 	} else if (!is_null_oid(&oid)) {
-		enum object_type type = oid_object_info(&oid, NULL);
+		enum object_type type = oid_object_info(the_repository, &oid,
+							NULL);
 		if (type < 0)
 			die("Blob not found: %s", command_buf.buf);
 		if (type != OBJ_BLOB)
@@ -2895,7 +2898,7 @@ static void parse_new_tag(const char *arg)
 	} else if (!get_oid(from, &oid)) {
 		struct object_entry *oe = find_object(&oid);
 		if (!oe) {
-			type = oid_object_info(&oid, NULL);
+			type = oid_object_info(the_repository, &oid, NULL);
 			if (type < 0)
 				die("Not a valid object: %s", from);
 		} else
@@ -3053,7 +3056,8 @@ static struct object_entry *dereference(struct object_entry *oe,
 	unsigned long size;
 	char *buf = NULL;
 	if (!oe) {
-		enum object_type type = oid_object_info(oid, NULL);
+		enum object_type type = oid_object_info(the_repository, oid,
+							NULL);
 		if (type < 0)
 			die("object not found: %s", oid_to_hex(oid));
 		/* cache it! */
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 0ec83aaf18..ea94fe8af2 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -117,7 +117,7 @@ static enum list_objects_filter_result filter_blobs_limit(
 		assert(obj->type == OBJ_BLOB);
 		assert((obj->flags & SEEN) == 0);
 
-		t = oid_object_info(&obj->oid, &object_length);
+		t = oid_object_info(the_repository, &obj->oid, &object_length);
 		if (t != OBJ_BLOB) { /* probably OBJ_NONE */
 			/*
 			 * We DO NOT have the blob locally, so we cannot
diff --git a/object.c b/object.c
index 66cffaf6e5..5044d08e96 100644
--- a/object.c
+++ b/object.c
@@ -257,7 +257,7 @@ struct object *parse_object(const struct object_id *oid)
 
 	if ((obj && obj->type == OBJ_BLOB && has_object_file(oid)) ||
 	    (!obj && has_object_file(oid) &&
-	     oid_object_info(oid, NULL) == OBJ_BLOB)) {
+	     oid_object_info(the_repository, oid, NULL) == OBJ_BLOB)) {
 		if (check_object_signature(repl, NULL, 0, NULL) < 0) {
 			error("sha1 mismatch %s", oid_to_hex(oid));
 			return NULL;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 41ae27fb19..cd1903e717 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -73,7 +73,8 @@ void bitmap_writer_build_type_index(struct pack_idx_entry **index,
 			break;
 
 		default:
-			real_type = oid_object_info(&entry->idx.oid, NULL);
+			real_type = oid_object_info(the_repository,
+						    &entry->idx.oid, NULL);
 			break;
 		}
 
diff --git a/packfile.c b/packfile.c
index d9914ba723..80c7fa734f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1114,7 +1114,7 @@ static int retry_bad_packed_offset(struct packed_git *p, off_t obj_offset)
 		return OBJ_BAD;
 	nth_packed_object_oid(&oid, p, revidx->nr);
 	mark_bad_packed_object(p, oid.hash);
-	type = oid_object_info(&oid, NULL);
+	type = oid_object_info(the_repository, &oid, NULL);
 	if (type <= OBJ_NONE)
 		return OBJ_BAD;
 	return type;
diff --git a/reachable.c b/reachable.c
index a6ea33a5db..ffb976c33c 100644
--- a/reachable.c
+++ b/reachable.c
@@ -78,7 +78,7 @@ static void add_recent_object(const struct object_id *oid,
 	 * later processing, and the revision machinery expects
 	 * commits and tags to have been parsed.
 	 */
-	type = oid_object_info(oid, NULL);
+	type = oid_object_info(the_repository, oid, NULL);
 	if (type < 0)
 		die("unable to get object info for %s", oid_to_hex(oid));
 
diff --git a/refs.c b/refs.c
index 9b56fa9b81..27c88ba768 100644
--- a/refs.c
+++ b/refs.c
@@ -302,7 +302,7 @@ enum peel_status peel_object(const struct object_id *name, struct object_id *oid
 	struct object *o = lookup_unknown_object(name->hash);
 
 	if (o->type == OBJ_NONE) {
-		int type = oid_object_info(name, NULL);
+		int type = oid_object_info(the_repository, name, NULL);
 		if (type < 0 || !object_as_type(o, type, 0))
 			return PEEL_INVALID;
 	}
diff --git a/remote.c b/remote.c
index 91eb010ca9..481bf933f3 100644
--- a/remote.c
+++ b/remote.c
@@ -1376,7 +1376,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			continue; /* not a tag */
 		if (string_list_has_string(&dst_tag, ref->name))
 			continue; /* they already have it */
-		if (oid_object_info(&ref->new_oid, NULL) != OBJ_TAG)
+		if (oid_object_info(the_repository, &ref->new_oid, NULL) != OBJ_TAG)
 			continue; /* be conservative */
 		item = string_list_append(&src_tag, ref->name);
 		item->util = ref;
diff --git a/sequencer.c b/sequencer.c
index 667f35ebdf..44f0518b9c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2876,7 +2876,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 
 		if (!get_oid(name, &oid)) {
 			if (!lookup_commit_reference_gently(&oid, 1)) {
-				enum object_type type = oid_object_info(&oid,
+				enum object_type type = oid_object_info(the_repository,
+									&oid,
 									NULL);
 				return error(_("%s: can't cherry-pick a %s"),
 					name, type_name(type));
diff --git a/sha1_file.c b/sha1_file.c
index 50a2dc5f0a..93f25c6c6a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1322,7 +1322,7 @@ int oid_object_info_extended_the_repository(const struct object_id *oid, struct
 }
 
 /* returns enum object_type or negative */
-int oid_object_info(const struct object_id *oid, unsigned long *sizep)
+int oid_object_info_the_repository(const struct object_id *oid, unsigned long *sizep)
 {
 	enum object_type type;
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -1988,7 +1988,7 @@ int read_pack_header(int fd, struct pack_header *header)
 
 void assert_oid_type(const struct object_id *oid, enum object_type expect)
 {
-	enum object_type type = oid_object_info(oid, NULL);
+	enum object_type type = oid_object_info(the_repository, oid, NULL);
 	if (type < 0)
 		die("%s is not a valid object", oid_to_hex(oid));
 	if (type != expect)
diff --git a/sha1_name.c b/sha1_name.c
index 5b93bf8da3..b5406b6eb2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -223,7 +223,7 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 
 static int disambiguate_commit_only(const struct object_id *oid, void *cb_data_unused)
 {
-	int kind = oid_object_info(oid, NULL);
+	int kind = oid_object_info(the_repository, oid, NULL);
 	return kind == OBJ_COMMIT;
 }
 
@@ -232,7 +232,7 @@ static int disambiguate_committish_only(const struct object_id *oid, void *cb_da
 	struct object *obj;
 	int kind;
 
-	kind = oid_object_info(oid, NULL);
+	kind = oid_object_info(the_repository, oid, NULL);
 	if (kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
@@ -247,7 +247,7 @@ static int disambiguate_committish_only(const struct object_id *oid, void *cb_da
 
 static int disambiguate_tree_only(const struct object_id *oid, void *cb_data_unused)
 {
-	int kind = oid_object_info(oid, NULL);
+	int kind = oid_object_info(the_repository, oid, NULL);
 	return kind == OBJ_TREE;
 }
 
@@ -256,7 +256,7 @@ static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_
 	struct object *obj;
 	int kind;
 
-	kind = oid_object_info(oid, NULL);
+	kind = oid_object_info(the_repository, oid, NULL);
 	if (kind == OBJ_TREE || kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
@@ -271,7 +271,7 @@ static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_
 
 static int disambiguate_blob_only(const struct object_id *oid, void *cb_data_unused)
 {
-	int kind = oid_object_info(oid, NULL);
+	int kind = oid_object_info(the_repository, oid, NULL);
 	return kind == OBJ_BLOB;
 }
 
@@ -350,7 +350,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	if (ds->fn && !ds->fn(oid, ds->cb_data))
 		return 0;
 
-	type = oid_object_info(oid, NULL);
+	type = oid_object_info(the_repository, oid, NULL);
 	if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(oid);
 		if (commit) {
diff --git a/submodule.c b/submodule.c
index 9a50168b23..bb133e9b93 100644
--- a/submodule.c
+++ b/submodule.c
@@ -818,7 +818,7 @@ static int check_has_commit(const struct object_id *oid, void *data)
 {
 	struct has_commit_data *cb = data;
 
-	enum object_type type = oid_object_info(oid, NULL);
+	enum object_type type = oid_object_info(the_repository, oid, NULL);
 
 	switch (type) {
 	case OBJ_COMMIT:
diff --git a/tag.c b/tag.c
index 86b1dcbb82..3d37c1bd25 100644
--- a/tag.c
+++ b/tag.c
@@ -41,7 +41,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 	unsigned long size;
 	int ret;
 
-	type = oid_object_info(oid, NULL);
+	type = oid_object_info(the_repository, oid, NULL);
 	if (type != OBJ_TAG)
 		return error("%s: cannot verify a non-tag object of type %s.",
 				name_to_report ?
-- 
2.17.0.441.gb46fe60e1d-goog

