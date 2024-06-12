Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2631C16D33D
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182445; cv=none; b=RI688sFOqeqAKtJfzOhH4hk6BmQC7h8knOfUcGk7VGZ//4/zz3qx6WZp4tRbm9NF1jLBTBINvIKYcqA4QjSDADhO4hxPdhqwb5MvSkAboSaIU4oOiEZonrA5qVT7U6SxwRFsOp8rodYBqvm8hYQspq6dJtCnjo7up0+UJSB7quI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182445; c=relaxed/simple;
	bh=a157vvETqaxQji7Kz0EE1WawvRtizV/1iea0THL6lxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPngwFCt9GmXUUGqg409BJ2yrhsO5kw6PoGvbCXCmRm6sKCDIBe3hQjMP+3OuP4CMBa8BT8RdPgpWuHs80RUSklFH4C38Tib+1zX44yKfO9sL+kfxEQWw5dkTPw/7N2sKT/zuxag81hbMT8QjHHKfwWY/sGtlH20v4jTxf2hBE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgvxSDjX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgvxSDjX"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f44b45d6abso52462145ad.0
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718182441; x=1718787241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bkn1rgtJyWG2X2ste7ME4B7+fDrBNCZK01I3YMBmExI=;
        b=PgvxSDjXUqsaZvLP9AGM2P4/c7mbPmy0YlcpMpbbSPLidhanqvIwYDh3SIimY/ZmWJ
         NrA/8BryWXJjacXFP1/JCgj+w52zeLgNmhQ8BQGI1JDt3gDaB1C/9iirCf99j56Hn+Uw
         WJw7Crwa3VURAQfUs6zGu++y4werb4B5pq111gDMIsZWDyTR6hj5PyUTnqa9T1rYOl1W
         f8QCbWZy6tAIyw8qY4Anc7TtB0ItPMz6Tc6oIeivMgCIiMUJuIPg5HimfnuihE0Ua1M4
         xxQ0WnSSovVO1lFhAfaNrndrGffCE53sbgl5/ltfVQj39DVT4wuAN2QYYroR7p1V3VXd
         uucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718182441; x=1718787241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bkn1rgtJyWG2X2ste7ME4B7+fDrBNCZK01I3YMBmExI=;
        b=mSVDxRfDkKa3Ol7xyQ2GMz8Vv2OecZ6iqaxE+2A4gpMLGCDOMC0glBuLRgZWT4EzcF
         ohJyU7ia/qM7VNRGDPhXGm8soYiXusGGyABso3Ig8UUyaQdEE/NsNHr51hy7LfL1ZRPE
         F3g9P/cXWY6EE7aqk/XuoZ3FZ0vgvrsv1Vxk6I+TIUhpj/w5f/VTpk4df0LYDevS9Bp2
         lqTzfZZy05lA+vmuL8ovbKVHe0BJTspLsBuj77Wj92ZcXWRv39ScyS1Yk9ALZXJALXME
         mL2VFziaCp4aTrk5X+rBhpgxHsFORQ8tEyBpMVQgUe7Y1LN7R4fM8FKQMj/5dRk+txqi
         a0cQ==
X-Gm-Message-State: AOJu0YyYy8IwCr/V3cbJe43MppXDH3BmjodFnsnTGiMkYmNjJA/vx8RT
	50Tk+NEsU+wtVdjtSmhQejO1zP5JXcdev4dtMy1kM2gldgr+MYvwkpSrPET4
X-Google-Smtp-Source: AGHT+IHlT7iQZbdZOu1PJMdoq/t5sQwHi/0Xu8eZ7MvT2F5m751+ai9dTZfIxxFJinYP7CAJk3eQtA==
X-Received: by 2002:a17:903:1c3:b0:1f4:977e:bf with SMTP id d9443c01a7336-1f83b6a1a4cmr15218575ad.19.1718182441146;
        Wed, 12 Jun 2024 01:54:01 -0700 (PDT)
Received: from ArchLinux.localdomain ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6eccc0bd0sm84066855ad.105.2024.06.12.01.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:54:00 -0700 (PDT)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [GSoC][PATCH v2 0/7] ref consistency check infra setup
Date: Wed, 12 Jun 2024 16:53:42 +0800
Message-ID: <20240612085349.710785-1-shejialuo@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240530122753.1114818-1-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch sets up the ref consistency check infrastructure. We need to
integrate the fsck error messages. However, the git-fsck(1) is highly
coupled with the object database. And it uses `git_fsck_config` to
initialize the `fsck_options->fsck_msg_type`. For my implementation, I
do not add some new files into `fsck_options` due to the following
reasons:

1. The fileds in `fsck_options` are all related to objects. We only can
reuse the `fsck_msg_type` and `strict` member, adding some ref-related
fileds into `fsck_options` will break the semantics.
2. We may laterc hange `fsck_options` and `fsck_objs_options`.

The code for integrating fsck error messages for refs may be a liitle
redudant now, but if we change the `fsck_options`, it will be way
complicated.

After integrating the fsck error messages, setup the consistency check
infrastructure like patch v1. And introduce a new subcommand for builtin
git-refs and in git-fsck(1), use a child process to call this
subcommand.

At last, like patch v1, implement the consistency check for files
backend and corresponding unit tests.

Because I have added more commits compare to v1. So I provide the
innerdiff between the v1 and v2.

Thanks,
Jialuo

shejialuo (7):
  fsck: add refs check interfaces to interface with fsck error levels
  refs: set up ref consistency check infrastructure
  builtin/refs: add verify subcommand
  builtin/fsck: add `git-refs verify` child process
  files-backend: add unified interface for refs scanning
  fsck: add ref name check for files backend
  fsck: add ref content check for files backend

 Documentation/fsck-msgids.txt |  12 ++
 Documentation/git-refs.txt    |  11 ++
 builtin/fsck.c                |  17 +++
 builtin/refs.c                |  45 +++++++
 fsck.c                        |  69 ++++++++++
 fsck.h                        |  43 ++++++-
 refs.c                        |   7 +-
 refs.h                        |   8 ++
 refs/debug.c                  |   9 ++
 refs/files-backend.c          | 234 +++++++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 ++
 refs/refs-internal.h          |  11 +-
 refs/reftable-backend.c       |   8 ++
 t/t0602-reffiles-fsck.sh      | 211 ++++++++++++++++++++++++++++++
 14 files changed, 685 insertions(+), 8 deletions(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

Interdiff between patch v1 and patch v2:
diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 5edc06c658..69f86c5345 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -19,6 +19,12 @@
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
+`badRefName`::
+	(ERROR) A ref has a bad name.
+
+`badRefSha`::
+	(ERROR) A ref has a bad sha.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
@@ -34,6 +40,9 @@
 `badType`::
 	(ERROR) Found an invalid object type.
 
+`danglingSymref`::
+	(WARN) Found a dangling symref.
+
 `duplicateEntries`::
 	(ERROR) A tree contains duplicate file entries.
 
@@ -176,6 +185,9 @@
 `symlinkTargetMissing`::
 	(ERROR) Unable to read symbolic link target's blob.
 
+`trailingRefContent`::
+	(WARN) A ref content has trailing contents.
+
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
-
diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
index 5b99e04385..f9d36ea19d 100644
--- a/Documentation/git-refs.txt
+++ b/Documentation/git-refs.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git refs migrate' --ref-format=<format> [--dry-run]
+'git refs verify' [--strict] [--verbose]
 
 DESCRIPTION
 -----------
@@ -22,6 +23,9 @@ COMMANDS
 migrate::
 	Migrate ref store between different formats.
 
+verify::
+	Verify reference database consistency.
+
 OPTIONS
 -------
 
@@ -39,6 +43,13 @@ include::ref-storage-format.txt[]
 	can be used to double check that the migration works as expected before
 	performing the actual migration.
 
+--strict::
+	Enable more strict checking, every WARN severity for the `Fsck Messages`
+	be seen as ERROR.
+
+--verbose::
+	When verifying the reference database consistency, be chatty.
+
 KNOWN LIMITATIONS
 -----------------
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 65a26e2d1b..10d73f534f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -896,6 +896,21 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	return res;
 }
 
+static void fsck_refs(void)
+{
+	struct child_process refs_verify = CHILD_PROCESS_INIT;
+	child_process_init(&refs_verify);
+	refs_verify.git_cmd = 1;
+	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
+	if (verbose)
+		strvec_push(&refs_verify.args, "--verbose");
+	if (check_strict)
+		strvec_push(&refs_verify.args, "--strict");
+
+	if (run_command(&refs_verify))
+		errors_found |= ERROR_REFS;
+}
+
 static char const * const fsck_usage[] = {
 	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
 	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
@@ -1065,10 +1080,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	check_connectivity();
 
-	if (refs_fsck(get_main_ref_store(the_repository))) {
-		error("ref database is corrupt");
-		errors_found |= ERROR_REFS;
-	}
+	fsck_refs();
 
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
-
diff --git a/builtin/refs.c b/builtin/refs.c
index 46dcd150d4..82ed0d57c1 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -1,4 +1,6 @@
 #include "builtin.h"
+#include "config.h"
+#include "fsck.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "repository.h"
@@ -7,6 +9,9 @@
 #define REFS_MIGRATE_USAGE \
 	N_("git refs migrate --ref-format=<format> [--dry-run]")
 
+#define REFS_VERIFY_USAGE \
+	N_("git refs verify [--strict] [--verbose]")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 {
 	const char * const migrate_usage[] = {
@@ -58,15 +63,55 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 	return err;
 }
 
+static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
+{
+	const char * const verify_usage[] = {
+		REFS_VERIFY_USAGE,
+		NULL,
+	};
+	int ret = 0;
+	unsigned int verbose = 0, strict = 0;
+	struct fsck_refs_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
+	struct option options[] = {
+		OPT__VERBOSE(&verbose, N_("be verbose")),
+		OPT_BOOL(0, "strict", &strict, N_("enable strict checking")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	if (verbose)
+		fsck_refs_options.verbose = 1;
+	if (strict)
+		fsck_refs_options.strict = 1;
+
+	git_config(git_fsck_refs_config, &fsck_refs_options);
+	prepare_repo_settings(the_repository);
+
+	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
+
+	/*
+	 * Explicitly free the allocated array. This is necessary because
+	 * this program is executed as child process of git-fsck(1) and the
+	 * allocated array may not freed when git-fsck(1) aborts somewhere.
+	 */
+	free(fsck_refs_options.msg_type);
+	return ret;
+}
+
 int cmd_refs(int argc, const char **argv, const char *prefix)
 {
 	const char * const refs_usage[] = {
 		REFS_MIGRATE_USAGE,
+		REFS_VERIFY_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option opts[] = {
 		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
+		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
 		OPT_END(),
 	};
 
diff --git a/fsck.c b/fsck.c
index 8ef962199f..13528c646e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1249,6 +1249,20 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 		      type);
 }
 
+int fsck_refs_error_function(struct fsck_refs_options *o UNUSED,
+			     const char *name,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id UNUSED,
+			     const char *message)
+{
+	if (msg_type == FSCK_WARN) {
+		warning("%s: %s", name, message);
+		return 0;
+	}
+	error("%s: %s", name, message);
+	return 1;
+}
+
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid,
 			enum object_type object_type UNUSED,
@@ -1323,6 +1337,61 @@ int fsck_finish(struct fsck_options *options)
 	return ret;
 }
 
+int fsck_refs_report(struct fsck_refs_options *o,
+		     const char *name,
+		     enum fsck_msg_id msg_id,
+		     const char *fmt, ...)
+{
+	va_list ap;
+	struct strbuf sb = STRBUF_INIT;
+	enum fsck_msg_type msg_type =
+		fsck_msg_type(msg_id, (struct fsck_options*)o);
+	int ret = 0;
+
+	if (msg_type == FSCK_IGNORE)
+		return 0;
+
+	if (msg_type == FSCK_FATAL)
+		msg_type = FSCK_ERROR;
+	else if (msg_type == FSCK_INFO)
+		msg_type = FSCK_WARN;
+
+	prepare_msg_ids();
+	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	ret = o->error_func(o, name, msg_type, msg_id, sb.buf);
+	strbuf_release(&sb);
+	va_end(ap);
+
+	return ret;
+}
+
+int git_fsck_refs_config(const char *var, const char *value,
+			 const struct config_context *ctx, void *cb)
+{
+	struct fsck_refs_options *options = cb;
+	const char *msg_id;
+
+	/*
+	 * We don't check the value of fsck.skiplist here, because it
+	 * is specific to object database, not reference database.
+	 */
+	if (strcmp(var, "fsck.skiplist") == 0) {
+		return 0;
+	}
+
+	if (skip_prefix(var, "fsck.", &msg_id)) {
+		if (!value)
+			return config_error_nonbool(var);
+		fsck_set_msg_type((struct fsck_options*)options, msg_id, value);
+		return 0;
+	}
+
+	return git_default_config(var, value, ctx, cb);
+}
+
 int git_fsck_config(const char *var, const char *value,
 		    const struct config_context *ctx, void *cb)
 {
diff --git a/fsck.h b/fsck.h
index 17fa2dda5d..5a55a567b0 100644
--- a/fsck.h
+++ b/fsck.h
@@ -31,6 +31,8 @@ enum fsck_msg_type {
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
+	FUNC(BAD_REF_NAME, ERROR) \
+	FUNC(BAD_REF_SHA, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
@@ -68,11 +70,13 @@ enum fsck_msg_type {
 	FUNC(SYMLINK_TARGET_BLOB, ERROR) \
 	/* warnings */ \
 	FUNC(EMPTY_NAME, WARN) \
+	FUNC(DANGLING_SYMREF, WARN) \
 	FUNC(FULL_PATHNAME, WARN) \
 	FUNC(HAS_DOT, WARN) \
 	FUNC(HAS_DOTDOT, WARN) \
 	FUNC(HAS_DOTGIT, WARN) \
 	FUNC(NULL_SHA1, WARN) \
+	FUNC(TRAILING_REF_CONTENT, WARN) \
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
 	FUNC(LARGE_PATHNAME, WARN) \
@@ -96,6 +100,7 @@ enum fsck_msg_id {
 };
 #undef MSG_ID
 
+struct fsck_refs_options;
 struct fsck_options;
 struct object;
 
@@ -107,6 +112,21 @@ void fsck_set_msg_type(struct fsck_options *options,
 void fsck_set_msg_types(struct fsck_options *options, const char *values);
 int is_valid_msg_type(const char *msg_id, const char *msg_type);
 
+/*
+ * callback function for fsck refs and reflogs.
+ */
+typedef int (*fsck_refs_error)(struct fsck_refs_options *o,
+			       const char *name,
+			       enum fsck_msg_type msg_type,
+			       enum fsck_msg_id msg_id,
+			       const char *message);
+
+int fsck_refs_error_function(struct fsck_refs_options *o,
+			     const char *name,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id,
+			     const char *message);
+
 /*
  * callback function for fsck_walk
  * type is the expected type of the object or OBJ_ANY
@@ -135,11 +155,22 @@ int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
 
+struct fsck_refs_options {
+	enum fsck_msg_type *msg_type;
+	unsigned strict:1;
+	fsck_refs_error error_func;
+	unsigned verbose:1;
+};
+
+#define FSCK_REFS_OPTIONS_DEFAULT { \
+	.error_func = fsck_refs_error_function, \
+}
+
 struct fsck_options {
+	enum fsck_msg_type *msg_type;
+	unsigned strict:1;
 	fsck_walk_func walk;
 	fsck_error error_func;
-	unsigned strict:1;
-	enum fsck_msg_type *msg_type;
 	struct oidset skiplist;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
@@ -221,6 +252,12 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+__attribute__((format (printf, 4, 5)))
+int fsck_refs_report(struct fsck_refs_options *o,
+		     const char *name,
+		     enum fsck_msg_id msg_id,
+		     const char *fmt, ...);
+
 /*
  * Subsystem for storing human-readable names for each object.
  *
@@ -247,6 +284,8 @@ const char *fsck_describe_object(struct fsck_options *options,
 				 const struct object_id *oid);
 
 struct key_value_info;
+int git_fsck_refs_config(const char *var, const char *value,
+			 const struct config_context *ctx, void *cb);
 /*
  * git_config() callback for use by fsck-y tools that want to support
  * fsck.<msg> fsck.skipList etc.
diff --git a/refs.c b/refs.c
index 06e191a316..1325f83269 100644
--- a/refs.c
+++ b/refs.c
@@ -316,9 +316,9 @@ int check_refname_format(const char *refname, int flags)
 	return check_or_sanitize_refname(refname, flags, NULL);
 }
 
-int refs_fsck(struct ref_store *refs)
+int refs_fsck(struct ref_store *refs, struct fsck_refs_options *o)
 {
-	return refs->be->fsck(refs);
+	return refs->be->fsck(refs, o);
 }
 
 void sanitize_refname_component(const char *refname, struct strbuf *out)
@@ -1744,7 +1744,7 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	}
 
 	result = parse_loose_ref_contents(content.buf, oid, referent, type,
-					  failure_errno);
+					  failure_errno, NULL);
 
 done:
 	strbuf_release(&full_path);
diff --git a/refs.h b/refs.h
index 55160085b6..5a042695f5 100644
--- a/refs.h
+++ b/refs.h
@@ -3,6 +3,7 @@
 
 #include "commit.h"
 
+struct fsck_refs_options;
 struct object_id;
 struct ref_store;
 struct repository;
@@ -548,9 +549,11 @@ int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *cb_dat
 int check_refname_format(const char *refname, int flags);
 
 /*
-  * Return 0 iff all refs in filesystem are consistent.
-*/
-int refs_fsck(struct ref_store *refs);
+ * Check the reference database for consistency. Return 0 if refs and
+ * reflogs are consistent, and non-zero otherwise. The errors will be
+ * written to stderr.
+ */
+int refs_fsck(struct ref_store *refs, struct fsck_refs_options *o);
 
 /*
  * Apply the rules from check_refname_format, but mutate the result until it
diff --git a/refs/debug.c b/refs/debug.c
index 547d9245b9..110a264522 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -419,6 +419,13 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 	return res;
 }
 
+static int debug_fsck(struct ref_store *ref_store,
+		      struct fsck_refs_options *o)
+{
+	trace_printf_key(&trace_refs, "fsck\n");
+	return 0;
+}
+
 struct ref_storage_be refs_be_debug = {
 	.name = "debug",
 	.init = NULL,
@@ -451,4 +458,6 @@ struct ref_storage_be refs_be_debug = {
 	.create_reflog = debug_create_reflog,
 	.delete_reflog = debug_delete_reflog,
 	.reflog_expire = debug_reflog_expire,
+
+	.fsck = debug_fsck,
 };
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5520a12a67..17d3e433f1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -4,6 +4,7 @@
 #include "../gettext.h"
 #include "../hash.h"
 #include "../hex.h"
+#include "../fsck.h"
 #include "../refs.h"
 #include "refs-internal.h"
 #include "ref-cache.h"
@@ -548,7 +549,7 @@ static int read_ref_internal(struct ref_store *ref_store, const char *refname,
 	strbuf_rtrim(&sb_contents);
 	buf = sb_contents.buf;
 
-	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr);
+	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr, NULL);
 
 out:
 	if (ret && !myerr)
@@ -584,7 +585,7 @@ static int files_read_symbolic_ref(struct ref_store *ref_store, const char *refn
 
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno)
+			     int *failure_errno, unsigned int *trailing)
 {
 	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
@@ -606,6 +607,10 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 		*failure_errno = EINVAL;
 		return -1;
 	}
+
+	if (trailing && (*p != '\0' && *p != '\n'))
+		*trailing = 1;
+
 	return 0;
 }
 
@@ -829,10 +834,8 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		 */
 		if (refs_verify_refname_available(
 				    refs->packed_ref_store, refname,
-				    extras, NULL, err)) {
-			ret = TRANSACTION_NAME_CONFLICT;
+				    extras, NULL, err))
 			goto error_return;
-		}
 	}
 
 	ret = 0;
@@ -3404,117 +3407,223 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 	return ret;
 }
 
-typedef int (*files_fsck_refs_fn)(const char *refs_check_dir,
-				struct dir_iterator *iter);
-
-static int files_fsck_refs_name(const char *refs_check_dir,
+/*
+ * For refs and reflogs, they share a unified interface when scanning
+ * the whole directory. This function is used as the callback for each
+ * regular file or symlink in the directory.
+ */
+typedef int (*files_fsck_refs_fn)(struct fsck_refs_options *o,
+				  const char *gitdir,
+				  const char *refs_check_dir,
+				  struct dir_iterator *iter);
+
+static int files_fsck_refs_name(struct fsck_refs_options *o,
+				const char *gitdir UNUSED,
+				const char *refs_check_dir,
 				struct dir_iterator *iter)
 {
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
 	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
-		error(_("%s/%s: invalid refname format"), refs_check_dir, iter->basename);
-		return -1;
+		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
+		ret = fsck_refs_report(o, sb.buf,
+				       FSCK_MSG_BAD_REF_NAME,
+				       "invalid refname format");
 	}
 
-	return 0;
+	strbuf_release(&sb);
+	return ret;
 }
 
-static int files_fsck_refs_content(const char *refs_check_dir,
-				struct dir_iterator *iter)
+static int files_fsck_symref(struct fsck_refs_options *o,
+			     struct strbuf *refname,
+			     struct strbuf *path)
 {
-	struct strbuf ref_content = STRBUF_INIT;
+	struct stat st;
+	int ret = 0;
 
-	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
-		error(_("%s/%s: unable to read the ref"), refs_check_dir, iter->basename);
-		goto clean;
+	if (lstat(path->buf, &st) < 0) {
+		ret = fsck_refs_report(o, refname->buf,
+				       FSCK_MSG_DANGLING_SYMREF,
+				       "point to non-existent ref");
+		goto out;
 	}
 
-	/*
-	 * Case 1: check if the ref content length is valid and the last
-	 * character is a newline.
-	 */
-	if (ref_content.len != the_hash_algo->hexsz + 1 ||
-			ref_content.buf[ref_content.len - 1] != '\n') {
-		goto failure;
+	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
+		ret = fsck_refs_report(o, refname->buf,
+				       FSCK_MSG_DANGLING_SYMREF,
+				       "point to invalid object");
+		goto out;
 	}
+out:
+	return ret;
+}
+
+static int files_fsck_refs_content(struct fsck_refs_options *o,
+				   const char *gitdir,
+				   const char *refs_check_dir,
+				   struct dir_iterator *iter)
+{
+	struct strbuf path = STRBUF_INIT,
+		      refname = STRBUF_INIT,
+		      ref_content = STRBUF_INIT,
+		      referent = STRBUF_INIT;
+	unsigned int trailing = 0;
+	int failure_errno = 0;
+	unsigned int type = 0;
+	struct object_id oid;
+	int ret = 0;
+
+	strbuf_addbuf(&path, &iter->path);
+	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
 
 	/*
-	 * Case 2: the content should be range of [0-9a-f].
+	 * If the file is a symlink, we need to only check the connectivity
+	 * of the destination object.
 	 */
-	for (size_t i = 0; i < the_hash_algo->hexsz; i++) {
-		if (!isdigit(ref_content.buf[i]) &&
-				(ref_content.buf[i] < 'a' || ref_content.buf[i] > 'f')) {
-			goto failure;
+	if (S_ISLNK(iter->st.st_mode)) {
+		strbuf_strip_file_from_path(&path);
+		ret = strbuf_readlink(&ref_content,
+				      iter->path.buf, iter->st.st_size);
+		if (ret < 0) {
+			ret = error_errno(_("could not read link '%s'"),
+					  iter->path.buf);
+			goto clean;
 		}
+		strbuf_addbuf(&path, &ref_content);
+		strbuf_reset(&ref_content);
+
+		ret = files_fsck_symref(o, &refname, &path);
+		goto clean;
 	}
 
-	strbuf_release(&ref_content);
-	return 0;
+	if (strbuf_read_file(&ref_content, path.buf, 0) < 0) {
+		ret = error_errno(_("%s/%s: unable to read the ref"),
+				  refs_check_dir, iter->relative_path);
+		goto clean;
+	}
+
+	if (parse_loose_ref_contents(ref_content.buf, &oid,
+				     &referent, &type,
+				     &failure_errno, &trailing)) {
+		ret = fsck_refs_report(o, refname.buf,
+				       FSCK_MSG_BAD_REF_SHA,
+				       "invalid ref content");
+		goto clean;
+	}
 
-failure:
-	error(_("%s/%s: invalid ref content"), refs_check_dir, iter->basename);
+	/*
+	 * If the ref is a symref, we need to check the destination name and
+	 * connectivity.
+	 */
+	if (referent.len && (type & REF_ISSYMREF)) {
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s/%s", gitdir, referent.buf);
+
+		if (check_refname_format(referent.buf, 0)) {
+			ret = fsck_refs_report(o, refname.buf,
+					       FSCK_MSG_DANGLING_SYMREF,
+					       "point to invalid refname");
+			goto clean;
+		}
+
+		ret = files_fsck_symref(o, &refname, &path);
+		goto clean;
+	} else {
+		/*
+		 * Only regular refs could have a trailing garbage. Should
+		 * be reported as a warning.
+		 */
+		if (trailing) {
+			ret = fsck_refs_report(o, refname.buf,
+					       FSCK_MSG_TRAILING_REF_CONTENT,
+					       "trailing garbage in ref");
+			goto clean;
+		}
+	}
 
 clean:
+	strbuf_release(&path);
+	strbuf_release(&refname);
 	strbuf_release(&ref_content);
-	return -1;
+	strbuf_release(&referent);
+	return ret;
 }
 
-static int files_fsck_refs(struct ref_store *ref_store,
-				const char* refs_check_dir,
-				files_fsck_refs_fn *fsck_refs_fns)
+static int files_fsck_refs_dir(struct ref_store *ref_store,
+			       struct fsck_refs_options *o,
+			       const char *refs_check_dir,
+			       files_fsck_refs_fn *fsck_refs_fns)
 {
-	struct dir_iterator *iter;
+	const char *gitdir = ref_store->gitdir;
 	struct strbuf sb = STRBUF_INIT;
-	int ret = 0;
+	struct dir_iterator *iter;
 	int iter_status;
+	int ret = 0;
 
-	strbuf_addf(&sb, "%s/%s", ref_store->gitdir, refs_check_dir);
+	strbuf_addf(&sb, "%s/%s", gitdir, refs_check_dir);
 
 	iter = dir_iterator_begin(sb.buf, 0);
 
-	/*
-	 * The current implementation does not care about the worktree, the worktree
-	 * may have no refs/heads or refs/tags directory. Simply return 0 now.
-	*/
 	if (!iter) {
-		return 0;
+		ret = error_errno("cannot open directory %s", sb.buf);
+		goto out;
 	}
 
 	while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
 		if (S_ISDIR(iter->st.st_mode)) {
 			continue;
-		} else if (S_ISREG(iter->st.st_mode)) {
-			for (files_fsck_refs_fn *fsck_refs_fn = fsck_refs_fns;
-					*fsck_refs_fn; fsck_refs_fn++) {
-				ret |= (*fsck_refs_fn)(refs_check_dir, iter);
+		} else if (S_ISREG(iter->st.st_mode) ||
+			   S_ISLNK(iter->st.st_mode)) {
+			if (o->verbose)
+				fprintf_ln(stderr, "Checking %s/%s",
+					   refs_check_dir, iter->relative_path);
+			for (size_t i = 0; fsck_refs_fns[i]; i++) {
+				if (fsck_refs_fns[i](o, gitdir, refs_check_dir, iter))
+					ret = -1;
 			}
 		} else {
-			error(_("unexpected file type for '%s'"), iter->basename);
-			ret = -1;
+			ret = error(_("unexpected file type for '%s'"),
+				    iter->basename);
 		}
 	}
 
-	if (iter_status != ITER_DONE) {
-		ret = -1;
-		error(_("failed to iterate over '%s'"), sb.buf);
-	}
+	if (iter_status != ITER_DONE)
+		ret = error(_("failed to iterate over '%s'"), sb.buf);
 
+out:
 	strbuf_release(&sb);
-
 	return ret;
 }
 
-static int files_fsck(struct ref_store *ref_store)
+static int files_fsck_refs(struct ref_store *ref_store,
+			   struct fsck_refs_options *o)
 {
-	int ret = 0;
-
-	files_fsck_refs_fn fsck_refs_fns[] = {
+	int ret;
+	files_fsck_refs_fn fsck_refs_fns[]= {
 		files_fsck_refs_name,
 		files_fsck_refs_content,
 		NULL
 	};
 
-	ret = files_fsck_refs(ref_store, "refs/heads",fsck_refs_fns)
-	    | files_fsck_refs(ref_store, "refs/tags", fsck_refs_fns);
+	if (o->verbose)
+		fprintf_ln(stderr, "Checking references consistency");
+
+	ret = files_fsck_refs_dir(ref_store, o, "refs", fsck_refs_fns);
+
+	return ret;
+}
+
+static int files_fsck(struct ref_store *ref_store,
+		      struct fsck_refs_options *o)
+{
+	int ret;
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_READ, "fsck");
+
+	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
+	ret = files_fsck_refs(ref_store, o);
 
 	return ret;
 }
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3de0fd59a7..db152053f8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1733,7 +1733,8 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
-static int packed_fsck(struct ref_store *ref_store)
+static int packed_fsck(struct ref_store *ref_store,
+		       struct fsck_refs_options *o)
 {
 	return 0;
 }
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 16d92b252e..eb3a7cdcc1 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -4,6 +4,7 @@
 #include "refs.h"
 #include "iterator.h"
 
+struct fsck_refs_options;
 struct ref_transaction;
 
 /*
@@ -650,7 +651,8 @@ typedef int read_raw_ref_fn(struct ref_store *ref_store, const char *refname,
 typedef int read_symbolic_ref_fn(struct ref_store *ref_store, const char *refname,
 				 struct strbuf *referent);
 
-typedef int fsck_fn(struct ref_store *ref_store);
+typedef int fsck_fn(struct ref_store *ref_store,
+		    struct fsck_refs_options *o);
 
 struct ref_storage_be {
 	const char *name;
@@ -707,11 +709,12 @@ struct ref_store {
 
 /*
  * Parse contents of a loose ref file. *failure_errno maybe be set to EINVAL for
- * invalid contents.
+ * invalid contents. Also trailing is set to 1 when there is any bytes after the
+ * hex.
  */
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno);
+			     int *failure_errno, unsigned int *trailing);
 
 /*
  * Fill in the generic part of refs and add it to our collection of
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8f0ce5aed0..7f606faa9e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2242,7 +2242,8 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	return ret;
 }
 
-static int reftable_be_fsck(struct ref_store *ref_store)
+static int reftable_be_fsck(struct ref_store *ref_store,
+			    struct fsck_refs_options *o)
 {
 	return 0;
 }
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 1c6c3804ff..94cb93bf92 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 test_description='Test reffiles backend consistency check'
 
@@ -21,15 +21,15 @@ test_expect_success 'ref name should be checked' '
 		git tag tag-1 &&
 		git commit --allow-empty -m second &&
 		git checkout -b branch-2 &&
-		git tag tag-2
+		git tag tag-2 &&
+		git tag multi_hierarchy/tag-2
 	) &&
 	(
 		cd repo &&
 		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
 		test_must_fail git fsck 2>err &&
 		cat >expect <<-EOF &&
-		error: refs/heads/.branch-1: invalid refname format
-		error: ref database is corrupt
+		error: refs/heads/.branch-1: badRefName: invalid refname format
 		EOF
 		rm $branch_dir_prefix/.branch-1 &&
 		test_cmp expect err
@@ -39,8 +39,7 @@ test_expect_success 'ref name should be checked' '
 		cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
 		test_must_fail git fsck 2>err &&
 		cat >expect <<-EOF &&
-		error: refs/tags/tag-1.lock: invalid refname format
-		error: ref database is corrupt
+		error: refs/tags/tag-1.lock: badRefName: invalid refname format
 		EOF
 		rm $tag_dir_prefix/tag-1.lock &&
 		test_cmp expect err
@@ -50,15 +49,24 @@ test_expect_success 'ref name should be checked' '
 		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
 		test_must_fail git fsck 2>err &&
 		cat >expect <<-EOF &&
-		error: refs/heads/@: invalid refname format
-		error: ref database is corrupt
+		error: refs/heads/@: badRefName: invalid refname format
 		EOF
 		rm $branch_dir_prefix/@ &&
 		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/@ &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/multi_hierarchy/@: badRefName: invalid refname format
+		EOF
+		rm $tag_dir_prefix/multi_hierarchy/@ &&
+		test_cmp expect err
 	)
 '
 
-test_expect_success 'ref content should be checked' '
+test_expect_success 'ref name check should be adapted into fsck messages' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
@@ -72,13 +80,45 @@ test_expect_success 'ref content should be checked' '
 		git checkout -b branch-2 &&
 		git tag tag-2
 	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+		git -c fsck.badRefName=warn fsck 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/.branch-1: badRefName: invalid refname format
+		EOF
+		rm $branch_dir_prefix/.branch-1 &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+		git -c fsck.badRefName=ignore fsck 2>err &&
+		test_must_be_empty err
+	)
+'
+
+test_expect_success 'regular ref content should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+		git tag tag-1 &&
+		git commit --allow-empty -m second &&
+		git checkout -b branch-2 &&
+		git tag tag-2 &&
+		git checkout -b a/b/tag-2
+	) &&
 	(
 		cd repo &&
 		printf "%s garbage" "$(git rev-parse branch-1)" > $branch_dir_prefix/branch-1-garbage &&
-		test_must_fail git fsck 2>err &&
+		git fsck 2>err &&
 		cat >expect <<-EOF &&
-		error: refs/heads/branch-1-garbage: invalid ref content
-		error: ref database is corrupt
+		warning: refs/heads/branch-1-garbage: trailingRefContent: trailing garbage in ref
 		EOF
 		rm $branch_dir_prefix/branch-1-garbage &&
 		test_cmp expect err
@@ -86,10 +126,9 @@ test_expect_success 'ref content should be checked' '
 	(
 		cd repo &&
 		printf "%s garbage" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-garbage &&
-		test_must_fail git fsck 2>err &&
+		test_must_fail git -c fsck.trailingRefContent=error fsck 2>err &&
 		cat >expect <<-EOF &&
-		error: refs/tags/tag-1-garbage: invalid ref content
-		error: ref database is corrupt
+		error: refs/tags/tag-1-garbage: trailingRefContent: trailing garbage in ref
 		EOF
 		rm $tag_dir_prefix/tag-1-garbage &&
 		test_cmp expect err
@@ -97,34 +136,74 @@ test_expect_success 'ref content should be checked' '
 	(
 		cd repo &&
 		printf "%s    " "$(git rev-parse tag-2)" > $tag_dir_prefix/tag-2-garbage &&
-		test_must_fail git fsck 2>err &&
+		git fsck 2>err &&
 		cat >expect <<-EOF &&
-		error: refs/tags/tag-2-garbage: invalid ref content
-		error: ref database is corrupt
+		warning: refs/tags/tag-2-garbage: trailingRefContent: trailing garbage in ref
 		EOF
 		rm $tag_dir_prefix/tag-2-garbage &&
 		test_cmp expect err
 	) &&
 	(
 		cd repo &&
-		tr -d "\n" < $branch_dir_prefix/branch-1 > $branch_dir_prefix/branch-1-without-newline &&
-		test_must_fail git fsck 2>err &&
+		printf "xfsazqfxcadas" > $tag_dir_prefix/tag-2-bad &&
+		test_must_fail git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: refs/heads/branch-1-without-newline: invalid ref content
-		error: ref database is corrupt
+		error: refs/tags/tag-2-bad: badRefSha: invalid ref content
 		EOF
-		rm $branch_dir_prefix/branch-1-without-newline &&
+		rm $tag_dir_prefix/tag-2-bad &&
 		test_cmp expect err
 	) &&
 	(
 		cd repo &&
-		tr "[:lower:]" "[:upper:]" < $branch_dir_prefix/branch-2 > $branch_dir_prefix/branch-2-upper &&
-		test_must_fail git fsck 2>err &&
+		printf "xfsazqfxcadas" > $branch_dir_prefix/a/b/branch-2-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/a/b/branch-2-bad: badRefSha: invalid ref content
+		EOF
+		rm $branch_dir_prefix/a/b/branch-2-bad &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'symbolic ref content should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+		git tag tag-1
+	) &&
+	(
+		cd repo &&
+		printf "ref: refs/heads/branch-3" > $branch_dir_prefix/branch-2-bad &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-2-bad: danglingSymref: point to non-existent ref
+		EOF
+		rm $branch_dir_prefix/branch-2-bad &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "ref: refs/heads/.branch" > $branch_dir_prefix/branch-2-bad &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-2-bad: danglingSymref: point to invalid refname
+		EOF
+		rm $branch_dir_prefix/branch-2-bad &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "ref: refs/heads" > $branch_dir_prefix/branch-2-bad &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: refs/heads/branch-2-upper: invalid ref content
-		error: ref database is corrupt
+		warning: refs/heads/branch-2-bad: danglingSymref: point to invalid object
 		EOF
-		rm $branch_dir_prefix/branch-2-upper &&
+		rm $branch_dir_prefix/branch-2-bad &&
 		test_cmp expect err
 	)
 '
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index b06c46999d..cc5bbfd732 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -10,7 +10,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_DEFAULT_REF_FORMAT=reftable
 export GIT_TEST_DEFAULT_REF_FORMAT
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 INVALID_OID=$(test_oid 001)
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9de2d95f06..f3c4d28e06 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -596,8 +596,7 @@ test_expect_success 'get bool variable with empty value' '
 
 test_expect_success 'no arguments, but no crash' '
 	test_must_fail git config >output 2>&1 &&
-	echo "error: no action specified" >expect &&
-	test_cmp expect output
+	test_grep usage output
 '
 
 cat > .git/config << EOF
@@ -2835,12 +2834,6 @@ test_expect_success 'specifying multiple modes causes failure' '
 	test_cmp expect err
 '
 
-test_expect_success 'writing to stdin is rejected' '
-	echo "fatal: writing to stdin is not supported" >expect &&
-	test_must_fail git config ${mode_set} --file - foo.bar baz 2>err &&
-	test_cmp expect err
-'
-
 done
 
 test_done

-- 
2.45.2

