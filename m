Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D789257844
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 04:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274776; cv=none; b=IugxQy5SXKbyz6RO5jGjZUaaLa7FOf69MauJ28xB546U2K7kVJv+Q8zETEFs++Ruqbtsj4HaM8/frtQrpqo9jeEQHVuhyynBN0Miy+bsavF+LjI8c++CRIl6ANKxlxzRrD3P/Pxq86k7gqBLlwFl9UncngYn4aHSY0i6EGaiYYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274776; c=relaxed/simple;
	bh=6EmKWHG49Ut4fzgcvXtiZzthhrRtQNcq342aQXRs1rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0dmV+GfpAAiBHe7YnA8Q+D9X5A+GQmMsrw/MVvLL8qrEESDzE+GzgSQG89DxKnayOJeQu9mXuCdo5617e3JUTumZtj0xh7MG/Bv6Ed0eCMss8U+Q16UfEWyMP5/A+GiGEPlgMRgSJ+yCwob0Uh+5u9WwzT+E10Ur78DrQPgwnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8jxBKrF; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8jxBKrF"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4863a7dac63so319590b6e.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 21:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782274773; x=1782879573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/jCMCQKghfSi6QxJ7WPmpZ3rY5dkPSHosCSvzt5GhE=;
        b=i8jxBKrFEXzGIk/nl4lUzXy3cajUCcK78aABQxJzYxucS0Y22BXosKjxAAE6XT7wJk
         defSG92QuKaLtTSzrHEccVw42V9yrOBcnqf42pE/Q3iewMVecUrVQMD3x9mVsbA54BWc
         U3Ge/WF/1WZ8QMhpWDtRaT+cMu9eXzIyr76fpEI/ftZ9klnvVulZxzJg7A7+bXf5om75
         0oK0SuvwJFp2VUdoveJOvmk5oWjmpeuJM12Iz+ANvyhBjW7cl/Iyb99RPMcUMPn9sCOh
         PknfQS1xtV1eYaJb04XP2hy69mebetjwvOsKKcA6P2wWuiG5hK7U2X53CFZAlXoTfUiY
         z4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782274773; x=1782879573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/jCMCQKghfSi6QxJ7WPmpZ3rY5dkPSHosCSvzt5GhE=;
        b=CeuDeUYNRRCcq46Fr6YtAtb4qABBBZ0MRT64vbTnW5RXHhz9Q73RLdSVZMQ+j0PNJA
         c1wqAIayAHqsXp5BnDchmUjQhO66LUw8PRtxJ91iaRVZ4AF3zD9mcnwR5bxoOgAjfBfb
         YEuL+9MYBG+qStO9HjWwG2/5tPEs4iL3iXjHz3OlOGlTf7031HEwuX8pxCA+vcdfUoPq
         ft0sREHheL7fQ4mVnf89MV/JkXMfzHIK5j3HtRmAz0dR45utqBiIAZJ5VkOnfnL0yKiU
         2kISfajKJbln+3JDdTwM8okYVPgbyd8+Jz2kYPCOUXAE0aJkj5nx1GlzkemMDJ6qHOt0
         sbUg==
X-Gm-Message-State: AOJu0Yx2h0RclZ6+Zaw2QWpLDjFPBeJJzNXJmLWflVc0efJ3B4++Nm6S
	0jqn0qK1SeTX9W81NPbx3Y+jJCNqASQ7cqbDKFagrJoRR5wpHsNgCMURWwEFWg==
X-Gm-Gg: AfdE7ckWqCSt1576FcGXB8wTNargrBqZRKtEYNWTAxSkKbr6ty4GvUl4PKo4jwwjx49
	KZqtwIFkAGa3bxOk2+3JHj3Bdw/b3RRjZdhCz8+lY9dY5BacqLq/uyzMr6x5bAat+DFk7WAmOn6
	IupxCuq54JPYHdVXsRHBCoFtdhYAgdTwd5c5PMcRBEhYYBL49X/qi+AiTFCSEm4C+SenbhZ9t+M
	f249EZu1heJ9330TKdj+nE7O1V+aEmtyG8meqPK5Rvc3KA1bI/uhkt0LenertsrADORipHo1LSo
	Aly97eRGBT0FrV0I0c731YM7o5i7F55KoU4CXAGRf8Ai9JsRZf92BbK/m7a6VR/NWygn1rvaVWQ
	MBKtS4Oeh8RnSLqAz6jbtlHy6tKi85XaZ6qKRCUliym4tYCkOBenWK0ySSG7FbmgPuQORuy4Ixk
	xsyfyDC9b78gSrMM3JHKW8
X-Received: by 2002:a05:6808:14d4:b0:489:9e42:484 with SMTP id 5614622812f47-4907818d27dmr1126473b6e.7.1782274773158;
        Tue, 23 Jun 2026 21:19:33 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aedf21f5fsm8111799b6e.12.2026.06.23.21.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 21:19:32 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 6/6] builtin/receive-pack: stage incoming objects via ODB transactions
Date: Tue, 23 Jun 2026 23:19:20 -0500
Message-ID: <20260624041920.2601961-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.54.0.105.g59ff4886a5
In-Reply-To: <20260624041920.2601961-1-jltobler@gmail.com>
References: <20260624041920.2601961-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Objects received by git-receive-pack(1) are quarantined in a temporary
"incoming" directory and migrated into the object database prior to the
reference updates. The quarantine is currently managed through
`tmp_objdir` directly. In a pluggable ODB future, how exactly an object
gets written to a transaction may vary for a given ODB source. Refactor
git-receive-pack(1) to use the ODB transaction interfaces to manage the
object staging area in a more agnostic manner accordingly.

Note that the temporary directory created for git-receive-pack(1) is
eagerly created and uses a different prefix name. This behavior is
special cased in the "files" backend by having `odb_transaction_begin()`
callers that require this behavior provide an `ODB_TRANSACTION_RECEIVE`
flag.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/add.c            |  2 +-
 builtin/receive-pack.c   | 46 ++++++++++++++++------------------------
 builtin/unpack-objects.c |  2 +-
 builtin/update-index.c   |  2 +-
 cache-tree.c             |  2 +-
 object-file.c            | 22 ++++++++++++++++---
 object-file.h            |  4 +++-
 odb/source-files.c       |  5 +++--
 odb/source-inmemory.c    |  3 ++-
 odb/source-loose.c       |  3 ++-
 odb/source.h             |  9 +++++---
 odb/transaction.c        |  5 +++--
 odb/transaction.h        | 13 ++++++++----
 read-cache.c             |  2 +-
 14 files changed, 70 insertions(+), 50 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 3d5d9cfdb9..60ffbede2b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -581,7 +581,7 @@ int cmd_add(int argc,
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
-	odb_transaction_begin_or_die(repo->objects, &transaction);
+	odb_transaction_begin_or_die(repo->objects, &transaction, 0);
 
 	ps_matched = xcalloc(pathspec.nr, 1);
 	if (add_renormalize)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 19eb6a1b61..ee8e03e2ab 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -112,8 +112,6 @@ static enum {
 } use_keepalive;
 static int keepalive_in_sec = 5;
 
-static struct tmp_objdir *tmp_objdir;
-
 static struct proc_receive_ref {
 	unsigned int want_add:1,
 		     want_delete:1,
@@ -959,8 +957,8 @@ static int run_receive_hook(struct command *commands,
 		strvec_push(&opt.env, "GIT_PUSH_OPTION_COUNT");
 	}
 
-	if (tmp_objdir)
-		strvec_pushv(&opt.env, tmp_objdir_env(tmp_objdir));
+	if (the_repository->objects->transaction)
+		strvec_pushv(&opt.env, odb_transaction_env(the_repository->objects->transaction));
 
 	prepare_push_cert_sha1(&opt);
 
@@ -1363,7 +1361,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 		    !delayed_reachability_test(si, i))
 			oid_array_append(&extra, &si->shallow->oid[i]);
 
-	opt.env = tmp_objdir_env(tmp_objdir);
+	opt.env = odb_transaction_env(the_repository->objects->transaction);
 	setup_alternate_shallow(&shallow_lock, &opt.shallow_file, &extra);
 	if (check_connected(command_singleton_iterator, cmd, &opt)) {
 		rollback_shallow_file(the_repository, &shallow_lock);
@@ -1802,7 +1800,7 @@ static void set_connectivity_errors(struct command *commands,
 			/* to be checked in update_shallow_ref() */
 			continue;
 
-		opt.env = tmp_objdir_env(tmp_objdir);
+		opt.env = odb_transaction_env(the_repository->objects->transaction);
 		if (!check_connected(command_singleton_iterator, &singleton,
 				     &opt))
 			continue;
@@ -2057,7 +2055,7 @@ static void execute_commands(struct command *commands,
 		data.si = si;
 		opt.err_fd = err_fd;
 		opt.progress = err_fd && !quiet;
-		opt.env = tmp_objdir_env(tmp_objdir);
+		opt.env = odb_transaction_env(the_repository->objects->transaction);
 		opt.exclude_hidden_refs_section = "receive";
 
 		if (check_connected(iterate_receive_command_list, &data, &opt))
@@ -2106,14 +2104,13 @@ static void execute_commands(struct command *commands,
 	 * Now we'll start writing out refs, which means the objects need
 	 * to be in their final positions so that other processes can see them.
 	 */
-	if (tmp_objdir_migrate(tmp_objdir) < 0) {
+	if (odb_transaction_commit(the_repository->objects->transaction)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
 			if (!cmd->error_string)
 				cmd->error_string = "unable to migrate objects to permanent storage";
 		}
 		return;
 	}
-	tmp_objdir = NULL;
 
 	check_aliased_updates(commands);
 
@@ -2326,7 +2323,8 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
 }
 
-static const char *unpack(int err_fd, struct shallow_info *si)
+static const char *unpack(int err_fd, struct shallow_info *si,
+			  struct odb_transaction *transaction)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -2351,20 +2349,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		strvec_push(&child.args, alt_shallow_file);
 	}
 
-	tmp_objdir = tmp_objdir_create(the_repository, "incoming");
-	if (!tmp_objdir) {
-		if (err_fd > 0)
-			close(err_fd);
-		return "unable to create temporary object directory";
-	}
-	strvec_pushv(&child.env, tmp_objdir_env(tmp_objdir));
-
-	/*
-	 * Normally we just pass the tmp_objdir environment to the child
-	 * processes that do the heavy lifting, but we may need to see these
-	 * objects ourselves to set up shallow information.
-	 */
-	tmp_objdir_add_as_alternate(tmp_objdir);
+	strvec_pushv(&child.env, odb_transaction_env(transaction));
 
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
 		strvec_push(&child.args, "unpack-objects");
@@ -2431,13 +2416,14 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 	return NULL;
 }
 
-static const char *unpack_with_sideband(struct shallow_info *si)
+static const char *unpack_with_sideband(struct shallow_info *si,
+					struct odb_transaction *transaction)
 {
 	struct async muxer;
 	const char *ret;
 
 	if (!use_sideband)
-		return unpack(0, si);
+		return unpack(0, si, transaction);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2446,7 +2432,7 @@ static const char *unpack_with_sideband(struct shallow_info *si)
 	if (start_async(&muxer))
 		return NULL;
 
-	ret = unpack(muxer.in, si);
+	ret = unpack(muxer.in, si, transaction);
 
 	finish_async(&muxer);
 	return ret;
@@ -2623,6 +2609,7 @@ int cmd_receive_pack(int argc,
 	struct oid_array ref = OID_ARRAY_INIT;
 	struct shallow_info si;
 	struct packet_reader reader;
+	struct odb_transaction *transaction = NULL;
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("quiet")),
@@ -2707,7 +2694,10 @@ int cmd_receive_pack(int argc,
 		if (!si.nr_ours && !si.nr_theirs)
 			shallow_update = 0;
 		if (!delete_only(commands)) {
-			unpack_status = unpack_with_sideband(&si);
+			if (odb_transaction_begin(the_repository->objects, &transaction, ODB_TRANSACTION_RECEIVE))
+				unpack_status = "unable to start ODB transaction";
+			else
+				unpack_status = unpack_with_sideband(&si, transaction);
 			update_shallow_info(commands, &si, &ref);
 		}
 		use_keepalive = KEEPALIVE_ALWAYS;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index d0136cdd99..c3d0fc7507 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -598,7 +598,7 @@ static void unpack_all(void)
 		progress = start_progress(the_repository,
 					  _("Unpacking objects"), nr_objects);
 	CALLOC_ARRAY(obj_list, nr_objects);
-	odb_transaction_begin_or_die(the_repository->objects, &transaction);
+	odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 17f3ea284c..bf6ea60ef4 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1124,7 +1124,7 @@ int cmd_update_index(int argc,
 	 * Allow the object layer to optimize adding multiple objects in
 	 * a batch.
 	 */
-	odb_transaction_begin_or_die(the_repository->objects, &transaction);
+	odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
 	while (ctx.argc) {
 		if (parseopt_state != PARSE_OPT_DONE)
 			parseopt_state = parse_options_step(&ctx, options,
diff --git a/cache-tree.c b/cache-tree.c
index 1a7dfed9cf..ed05acc4c7 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -490,7 +490,7 @@ int cache_tree_update(struct index_state *istate, int flags)
 
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", istate->repo);
-	odb_transaction_begin_or_die(the_repository->objects, &transaction);
+	odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
 	odb_transaction_commit(transaction);
diff --git a/object-file.c b/object-file.c
index 14064d188a..e7958753ec 100644
--- a/object-file.c
+++ b/object-file.c
@@ -497,6 +497,7 @@ struct odb_transaction_files {
 
 	struct tmp_objdir *objdir;
 	struct transaction_packfile packfile;
+	const char *prefix;
 };
 
 static int odb_transaction_files_prepare(struct odb_transaction *base)
@@ -513,7 +514,7 @@ static int odb_transaction_files_prepare(struct odb_transaction *base)
 	if (!transaction || transaction->objdir)
 		return 0;
 
-	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
+	transaction->objdir = tmp_objdir_create(base->source->odb->repo, transaction->prefix);
 	if (!transaction->objdir)
 		return -1;
 
@@ -1391,7 +1392,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 			struct object_database *odb = the_repository->objects;
 			struct odb_transaction *transaction;
 
-			odb_transaction_begin_or_die(odb, &transaction);
+			odb_transaction_begin_or_die(odb, &transaction, 0);
 			ret = odb_transaction_write_object_stream(odb->transaction,
 								  &stream,
 								  xsize_t(st->st_size),
@@ -1702,7 +1703,8 @@ static const char **odb_transaction_files_env(struct odb_transaction *base)
 }
 
 int odb_transaction_files_begin(struct odb_source *source,
-				struct odb_transaction **out)
+				struct odb_transaction **out,
+				enum odb_transaction_flags flags)
 {
 	struct odb_transaction_files *transaction;
 	struct object_database *odb = source->odb;
@@ -1717,6 +1719,20 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction->base.commit = odb_transaction_files_commit;
 	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
 	transaction->base.env = odb_transaction_files_env;
+
+	transaction->prefix = "bulk-fsync";
+	if (flags & ODB_TRANSACTION_RECEIVE) {
+		/*
+		 * ODB transactions for git-receive-pack(1) eagerly create a
+		 * temporary directory and use a different prefix.
+		 */
+		transaction->prefix = "incoming";
+		if (odb_transaction_files_prepare(&transaction->base)) {
+			free(transaction);
+			return -1;
+		}
+	}
+
 	*out = &transaction->base;
 
 	return 0;
diff --git a/object-file.h b/object-file.h
index ac927fec07..fe098d54cb 100644
--- a/object-file.h
+++ b/object-file.h
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "odb.h"
 #include "odb/source-loose.h"
+#include "odb/transaction.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
@@ -198,6 +199,7 @@ struct odb_transaction;
  * pending, out is set to NULL.
  */
 int odb_transaction_files_begin(struct odb_source *source,
-				struct odb_transaction **out);
+				struct odb_transaction **out,
+				enum odb_transaction_flags flags);
 
 #endif /* OBJECT_FILE_H */
diff --git a/odb/source-files.c b/odb/source-files.c
index 2545bd81d4..534f48aad9 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -180,9 +180,10 @@ static int odb_source_files_write_object_stream(struct odb_source *source,
 }
 
 static int odb_source_files_begin_transaction(struct odb_source *source,
-					      struct odb_transaction **out)
+					      struct odb_transaction **out,
+					      enum odb_transaction_flags flags)
 {
-	return odb_transaction_files_begin(source, out);
+	return odb_transaction_files_begin(source, out, flags);
 }
 
 static int odb_source_files_read_alternates(struct odb_source *source,
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index e004566d76..9644d9d474 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -304,7 +304,8 @@ static int odb_source_inmemory_freshen_object(struct odb_source *source,
 }
 
 static int odb_source_inmemory_begin_transaction(struct odb_source *source UNUSED,
-						 struct odb_transaction **out UNUSED)
+						 struct odb_transaction **out UNUSED,
+						 enum odb_transaction_flags flags UNUSED)
 {
 	return error("in-memory source does not support transactions");
 }
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 66e6bb8d3f..57c91986b4 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -638,7 +638,8 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 }
 
 static int odb_source_loose_begin_transaction(struct odb_source *source UNUSED,
-					      struct odb_transaction **out UNUSED)
+					      struct odb_transaction **out UNUSED,
+					      enum odb_transaction_flags flags UNUSED)
 {
 	/* TODO: this is a known omission that we'll want to address eventually. */
 	return error("loose source does not support transactions");
diff --git a/odb/source.h b/odb/source.h
index 2192a101b8..3790d03ff2 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -3,6 +3,7 @@
 
 #include "object.h"
 #include "odb.h"
+#include "odb/transaction.h"
 
 enum odb_source_type {
 	/*
@@ -228,7 +229,8 @@ struct odb_source {
 	 * negative error code otherwise.
 	 */
 	int (*begin_transaction)(struct odb_source *source,
-				 struct odb_transaction **out);
+				 struct odb_transaction **out,
+				 enum odb_transaction_flags flags);
 
 	/*
 	 * This callback is expected to read the list of alternate object
@@ -467,9 +469,10 @@ static inline int odb_source_write_alternate(struct odb_source *source,
  * Returns 0 on success, a negative error code otherwise.
  */
 static inline int odb_source_begin_transaction(struct odb_source *source,
-					       struct odb_transaction **out)
+					       struct odb_transaction **out,
+					       enum odb_transaction_flags flags)
 {
-	return source->begin_transaction(source, out);
+	return source->begin_transaction(source, out, flags);
 }
 
 #endif
diff --git a/odb/transaction.c b/odb/transaction.c
index 20d3f43f54..34c212020c 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -3,7 +3,8 @@
 #include "odb/transaction.h"
 
 int odb_transaction_begin(struct object_database *odb,
-			  struct odb_transaction **out)
+			  struct odb_transaction **out,
+			  enum odb_transaction_flags flags)
 {
 	int ret;
 
@@ -12,7 +13,7 @@ int odb_transaction_begin(struct object_database *odb,
 		return 0;
 	}
 
-	ret = odb_source_begin_transaction(odb->sources, out);
+	ret = odb_source_begin_transaction(odb->sources, out, flags);
 	odb->transaction = *out;
 
 	return ret;
diff --git a/odb/transaction.h b/odb/transaction.h
index 536458297b..78392ff13d 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -4,7 +4,6 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "odb.h"
-#include "odb/source.h"
 
 /*
  * A transaction may be started for an object database prior to writing new
@@ -44,6 +43,10 @@ struct odb_transaction {
 	const char **(*env)(struct odb_transaction *transaction);
 };
 
+enum odb_transaction_flags {
+	ODB_TRANSACTION_RECEIVE = (1 << 0),
+};
+
 /*
  * Starts an ODB transaction and returns it via `out`. Subsequent objects are
  * written to the transaction and not committed until odb_transaction_commit()
@@ -51,12 +54,14 @@ struct odb_transaction {
  * error. If the ODB already has a pending transaction, `out` is set to NULL.
  */
 int odb_transaction_begin(struct object_database *odb,
-			  struct odb_transaction **out);
+			  struct odb_transaction **out,
+			  enum odb_transaction_flags flags);
 
 static inline void odb_transaction_begin_or_die(struct object_database *odb,
-						struct odb_transaction **out)
+						struct odb_transaction **out,
+						enum odb_transaction_flags flags)
 {
-	if (odb_transaction_begin(odb, out))
+	if (odb_transaction_begin(odb, out, flags))
 		die(_("failed to start ODB transaction"));
 }
 
diff --git a/read-cache.c b/read-cache.c
index db0bfa60fe..35bfb25576 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -4042,7 +4042,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	 * This function is invoked from commands other than 'add', which
 	 * may not have their own transaction active.
 	 */
-	odb_transaction_begin_or_die(repo->objects, &transaction);
+	odb_transaction_begin_or_die(repo->objects, &transaction, 0);
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	odb_transaction_commit(transaction);
 
-- 
2.54.0.105.g59ff4886a5

