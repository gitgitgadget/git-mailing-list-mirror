Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1CACE79D2
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 13:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbjITNDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 09:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbjITNDT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 09:03:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC677CA
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:02:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c8321c48fso609107f8f.1
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695214978; x=1695819778; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5h71SHoa2C7sOlVSvRPYarpJMJn94L7mVU3N3sCs4Y=;
        b=KCd4++aOBDFmvJ8T+8E+nQU4Tji8h4zSKPrKY5XAzRW2QIDeRgGLRVdQ0HXp+oH2VQ
         7beKealpN+ONYyYNn0KmQGGdxgu0mytG+ksRo+eLN09m12PqxkovXt8vCbackVQZztKW
         mV4OEmjRgTjSLarGnIlIlmknJWUvNI06gMptbbOF3Jg/BFeARdRwfk3nZFmWnjTjGtHE
         I+YGRb/hYGvyXpQnrOSqLDdqiYUjeZdF2Jpt66KTbXzWcgXH5YR8Nr/6agrEyIhPs8aH
         6WqZMP8Ko71nEhp3mS68Egp9LcglWM9dwJ9Wzp4dUQBtGFCcpgcaj25+ILQLp/OxZwAp
         1Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214978; x=1695819778;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5h71SHoa2C7sOlVSvRPYarpJMJn94L7mVU3N3sCs4Y=;
        b=fEqbx9sauwXsAFeCRDoKhkHMRvTYXOPEN8rN5ux6tFyDXkFBapB3JZwKYeox4gmB8L
         JyP9wzWYVIRvq0eqQRJEUQ16XJDJUixnJ0aLW5uG/5hR9hdAY5TDjkiRaon/b3rCI7Pq
         /XwOFbeH77v0fs2HX+lF9nLXmDsWWspFdPtJfmMx2KMZCAYw5n31AC6NFQsgYDfHb6TU
         fId+79xVbXKvpg+cFgriLHKt5ezqyB1/zr4oVcVAo8C60Xx8AikBODorIrNVTGe0oPzO
         axt8018bcai9g6H6t4bdsUGQPX6IYTCuh8NxOSrY0eRilY5+WUuTKYGugPzgIlfPbm54
         giqQ==
X-Gm-Message-State: AOJu0Yy1uOTFKA+3hrQnLTlv38mqpfsdS3N1i+FLF16uXrwDt2gODo85
        emLfsL8VUokDqhLJBBzdvYQllsCjCaU=
X-Google-Smtp-Source: AGHT+IEOIf/QiFpilbhG+l6xSxNzxDuRVp4NvVKBO11O8LlgEE6jDU77dGUCf71PlcFSIzTsWNXzNw==
X-Received: by 2002:a05:6000:702:b0:320:938:3016 with SMTP id bs2-20020a056000070200b0032009383016mr5736465wrb.18.1695214976575;
        Wed, 20 Sep 2023 06:02:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1-20020adfd221000000b003217c096c1esm408579wrh.73.2023.09.20.06.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:02:56 -0700 (PDT)
Message-ID: <d5669da57e33ff2fbd6fad9e68285c33b43061db.1695214968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
References: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
        <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Sep 2023 13:02:47 +0000
Subject: [PATCH v2 5/6] refs: alternate reftable ref backend implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This introduces the reftable backend as an alternative to the packed
backend.

This is an alternative to the approach which was explored in
https://github.com/git/git/pull/1215/. This alternative is simpler,
because we now longer have to worry about:

- pseudorefs and the HEAD ref
- worktrees
- commands that blur together files and references (cherry-pick, rebase)

This deviates from the spec that in
Documentation/technical/reftable.txt. It might be possible to update the
code such that all writes by default go to reftable directly. Then the
result would be compatible with an implementation that writes only
reftable (the reftable lock would still prevent races), but something
must be done about the HEAD ref (which JGit keeps in reftable too.)
Alternatively, JGit could be adapted to follow this implementation:
despite the code being there for 4 years now, I haven't heard of anyone
using it in production (exactly because CGit does not support it).

For this incremental path, the reftable format is arguably more
complex than necessary, as

- packed-refs doesn't support symrefs
- reflogs aren't moved into reftable

on the other hand, the code is already there, and it's well-structured
and well-tested.

refs/reftable-backend.c was created by cannibalizing the first version
of reftable support (github PR 1215 as mentioned above). It supports
reflogs and symrefs, even though those features are never exercised.

This implementation is a prototype, for the following reasons:

- no considerations of backward compatibility and configuring an
extension
- no support for converting between packed-refs and reftable
- no documentation
- test failures when setting GIT_TEST_REFTABLE=1.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                        |    1 +
 config.mak.uname                |    2 +-
 contrib/workdir/git-new-workdir |    2 +-
 refs/files-backend.c            |   18 +-
 refs/refs-internal.h            |    1 +
 refs/reftable-backend.c         | 1658 +++++++++++++++++++++++++++++++
 refs/reftable-backend.h         |    8 +
 7 files changed, 1686 insertions(+), 4 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100644 refs/reftable-backend.h

diff --git a/Makefile b/Makefile
index 57763093653..272d3f7f1e9 100644
--- a/Makefile
+++ b/Makefile
@@ -1118,6 +1118,7 @@ LIB_OBJS += reflog.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/debug.o
 LIB_OBJS += refs/files-backend.o
+LIB_OBJS += refs/reftable-backend.o
 LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
diff --git a/config.mak.uname b/config.mak.uname
index 3bb03f423a0..843829c02fd 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -743,7 +743,7 @@ vcxproj:
 
 	# Make .vcxproj files and add them
 	perl contrib/buildsystems/generate -g Vcxproj
-	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
+	git add -f git.sln {*,*/lib,*/libreftable,t/helper/*}/*.vcxproj
 
 	# Generate the LinkOrCopyBuiltins.targets and LinkOrCopyRemoteHttp.targets file
 	(echo '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">' && \
diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 888c34a5215..989197aace0 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -79,7 +79,7 @@ trap cleanup $siglist
 # create the links to the original repo.  explicitly exclude index, HEAD and
 # logs/HEAD from the list since they are purely related to the current working
 # directory, and should not be shared.
-for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn
+for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn reftable
 do
 	# create a containing directory if needed
 	case $x in
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5d288bf38bb..2cd596bbeba 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,4 +1,5 @@
 #include "../git-compat-util.h"
+#include "../abspath.h"
 #include "../config.h"
 #include "../copy.h"
 #include "../environment.h"
@@ -9,6 +10,7 @@
 #include "refs-internal.h"
 #include "ref-cache.h"
 #include "packed-backend.h"
+#include "reftable-backend.h"
 #include "../ident.h"
 #include "../iterator.h"
 #include "../dir-iterator.h"
@@ -98,13 +100,25 @@ static struct ref_store *files_ref_store_create(struct repository *repo,
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
 	struct strbuf sb = STRBUF_INIT;
+	int has_reftable, has_packed;
 
 	base_ref_store_init(ref_store, repo, gitdir, &refs_be_files);
 	refs->store_flags = flags;
 	get_common_dir_noenv(&sb, gitdir);
 	refs->gitcommondir = strbuf_detach(&sb, NULL);
-	refs->packed_ref_store =
-		packed_ref_store_create(repo, refs->gitcommondir, flags);
+
+	strbuf_addf(&sb, "%s/reftable", refs->gitcommondir);
+	has_reftable = is_directory(sb.buf);
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
+	has_packed = file_exists(sb.buf);
+
+	if (!has_packed && !has_reftable)
+		has_reftable = git_env_bool("GIT_TEST_REFTABLE", 0);
+
+	refs->packed_ref_store = has_reftable
+		? git_reftable_ref_store_create(repo, refs->gitcommondir, flags)
+		: packed_ref_store_create(repo, refs->gitcommondir, flags);
 
 	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
 	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0a15e8a2ac8..13bd9c79f3c 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -699,6 +699,7 @@ struct ref_storage_be {
 };
 
 extern struct ref_storage_be refs_be_files;
+extern struct ref_storage_be refs_be_reftable;
 extern struct ref_storage_be refs_be_packed;
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
new file mode 100644
index 00000000000..16064fff198
--- /dev/null
+++ b/refs/reftable-backend.c
@@ -0,0 +1,1658 @@
+#include "../git-compat-util.h"
+#include "../abspath.h"
+#include "../chdir-notify.h"
+#include "../config.h"
+#include "../environment.h"
+#include "../hash.h"
+#include "../hex.h"
+#include "../iterator.h"
+#include "../ident.h"
+#include "../lockfile.h"
+#include "../object.h"
+#include "../path.h"
+#include "../refs.h"
+#include "../reftable/reftable-stack.h"
+#include "../reftable/reftable-record.h"
+#include "../reftable/reftable-error.h"
+#include "../reftable/reftable-blocksource.h"
+#include "../reftable/reftable-reader.h"
+#include "../reftable/reftable-iterator.h"
+#include "../reftable/reftable-merged.h"
+#include "../reftable/reftable-generic.h"
+#include "../worktree.h"
+#include "refs-internal.h"
+#include "reftable-backend.h"
+#include "../repository.h"
+
+extern struct ref_storage_be refs_be_reftable;
+
+struct git_reftable_ref_store {
+	struct ref_store base;
+	unsigned int store_flags;
+
+	int err;
+	char *repo_dir;
+	char *reftable_dir;
+
+	struct reftable_stack *main_stack;
+
+	struct reftable_write_options write_options;
+};
+
+static struct reftable_stack *stack_for(struct git_reftable_ref_store *store,
+					const char *refname)
+{
+	return store->main_stack;
+}
+
+static int should_log(const char *refname)
+{
+	return log_all_ref_updates != LOG_REFS_NONE &&
+	       (log_all_ref_updates == LOG_REFS_ALWAYS ||
+		log_all_ref_updates == LOG_REFS_UNSET ||
+		should_autocreate_reflog(refname));
+}
+
+static const char *bare_ref_name(const char *ref)
+{
+	const char *stripped;
+	parse_worktree_ref(ref, NULL, NULL, &stripped);
+	return stripped;
+}
+
+static int git_reftable_read_raw_ref(struct ref_store *ref_store,
+				     const char *refname, struct object_id *oid,
+				     struct strbuf *referent,
+				     unsigned int *type, int *failure_errno);
+
+static void clear_reftable_log_record(struct reftable_log_record *log)
+{
+	switch (log->value_type) {
+	case REFTABLE_LOG_UPDATE:
+		/* when we write log records, the hashes are owned by a struct
+		 * oid */
+		log->value.update.old_hash = NULL;
+		log->value.update.new_hash = NULL;
+		break;
+	case REFTABLE_LOG_DELETION:
+		break;
+	}
+	reftable_log_record_release(log);
+}
+
+static void fill_reftable_log_record(struct reftable_log_record *log)
+{
+	const char *info = git_committer_info(0);
+	struct ident_split split = { NULL };
+	int result = split_ident_line(&split, info, strlen(info));
+	int sign = 1;
+	assert(0 == result);
+
+	reftable_log_record_release(log);
+	log->value_type = REFTABLE_LOG_UPDATE;
+	log->value.update.name =
+		xstrndup(split.name_begin, split.name_end - split.name_begin);
+	log->value.update.email =
+		xstrndup(split.mail_begin, split.mail_end - split.mail_begin);
+	log->value.update.time = atol(split.date_begin);
+	if (*split.tz_begin == '-') {
+		sign = -1;
+		split.tz_begin++;
+	}
+	if (*split.tz_begin == '+') {
+		sign = 1;
+		split.tz_begin++;
+	}
+
+	log->value.update.tz_offset = sign * atoi(split.tz_begin);
+}
+
+struct ref_store *git_reftable_ref_store_create(struct repository *repo,
+						const char *gitdir,
+						unsigned int store_flags)
+{
+	struct git_reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
+	struct ref_store *ref_store = (struct ref_store *)refs;
+	struct strbuf sb = STRBUF_INIT;
+	int shared = get_shared_repository();
+	if (shared < 0)
+		shared = -shared;
+
+	refs->write_options.block_size = 4096;
+	refs->write_options.hash_id = the_hash_algo->format_id;
+	if (shared && (shared & 0600))
+		refs->write_options.default_permissions = shared;
+
+	/* XXX should this use `path` or `gitdir.buf` ? */
+	base_ref_store_init(ref_store, repo, gitdir, &refs_be_reftable);
+	refs->store_flags = store_flags;
+	strbuf_addf(&sb, "%s/reftable", gitdir);
+	refs->reftable_dir = xstrdup(sb.buf);
+	safe_create_dir(refs->reftable_dir, 1);
+
+	refs->base.repo = repo;
+	strbuf_reset(&sb);
+
+	refs->err = reftable_new_stack(&refs->main_stack, refs->reftable_dir,
+				       refs->write_options);
+	assert(refs->err != REFTABLE_API_ERROR);
+
+	strbuf_release(&sb);
+
+	/* TODO something with chdir_notify_reparent() ? */
+
+	return ref_store;
+}
+
+static int git_reftable_init_db(struct ref_store *ref_store, struct strbuf *err)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	safe_create_dir(refs->reftable_dir, 1);
+	return 0;
+}
+
+struct git_reftable_iterator {
+	struct ref_iterator base;
+	struct reftable_iterator iter;
+	struct reftable_ref_record ref;
+	struct object_id oid;
+	struct ref_store *ref_store;
+
+	unsigned int flags;
+	int err;
+	const char *prefix;
+};
+
+static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct git_reftable_iterator *ri =
+		(struct git_reftable_iterator *)ref_iterator;
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ri->ref_store;
+
+	while (ri->err == 0) {
+		int signed_flags = 0;
+		ri->err = reftable_iterator_next_ref(&ri->iter, &ri->ref);
+		if (ri->err) {
+			break;
+		}
+
+		ri->base.flags = 0;
+
+		if (!strcmp(ri->ref.refname, "HEAD")) {
+			/*
+			  HEAD should not be produced by default.Other
+			  pseudorefs (FETCH_HEAD etc.) shouldn't be
+			  stored in reftables at all.
+			 */
+			continue;
+		}
+		ri->base.refname = ri->ref.refname;
+		if (ri->prefix &&
+		    strncmp(ri->prefix, ri->ref.refname, strlen(ri->prefix))) {
+			ri->err = 1;
+			break;
+		}
+		if (ri->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+		    parse_worktree_ref(ri->base.refname, NULL, NULL, NULL) !=
+			    REF_WORKTREE_CURRENT)
+			continue;
+
+		if (ri->flags & DO_FOR_EACH_INCLUDE_BROKEN &&
+		    check_refname_format(ri->base.refname,
+					 REFNAME_ALLOW_ONELEVEL)) {
+			/* This is odd, as REF_BAD_NAME and REF_ISBROKEN are
+			   orthogonal, but it's what the spec says and the
+			   files-backend does. */
+			ri->base.flags |= REF_BAD_NAME | REF_ISBROKEN;
+			break;
+		}
+
+		switch (ri->ref.value_type) {
+		case REFTABLE_REF_VAL1:
+			oidread(&ri->oid, ri->ref.value.val1);
+			break;
+		case REFTABLE_REF_VAL2:
+			oidread(&ri->oid, ri->ref.value.val2.value);
+			break;
+		case REFTABLE_REF_SYMREF:
+			ri->base.flags = REF_ISSYMREF;
+			break;
+		default:
+			abort();
+		}
+
+		ri->base.oid = &ri->oid;
+		if (!(ri->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+		    !ref_resolves_to_object(ri->base.refname, refs->base.repo,
+					    ri->base.oid, ri->base.flags)) {
+			continue;
+		}
+
+		/* Arguably, resolving recursively following symlinks should be
+		 * lifted to refs.c because it is shared between reftable and
+		 * the files backend, but it's here now.
+		 */
+		if (!refs_resolve_ref_unsafe(ri->ref_store, ri->ref.refname,
+					     RESOLVE_REF_READING, &ri->oid,
+					     &signed_flags)) {
+			ri->base.flags = signed_flags;
+			if (ri->ref.value_type == REFTABLE_REF_SYMREF &&
+			    ri->flags & DO_FOR_EACH_OMIT_DANGLING_SYMREFS)
+				continue;
+
+			if (ri->ref.value_type == REFTABLE_REF_SYMREF &&
+			    !(ri->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+			    (ri->base.flags & REF_ISBROKEN)) {
+				continue;
+			}
+
+			if (is_null_oid(&ri->oid)) {
+				oidclr(&ri->oid);
+				ri->base.flags |= REF_ISBROKEN;
+			}
+		}
+		break;
+	}
+
+	if (ri->err > 0) {
+		return ITER_DONE;
+	}
+	if (ri->err < 0) {
+		return ITER_ERROR;
+	}
+
+	return ITER_OK;
+}
+
+static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				      struct object_id *peeled)
+{
+	struct git_reftable_iterator *ri =
+		(struct git_reftable_iterator *)ref_iterator;
+	if (ri->ref.value_type == REFTABLE_REF_VAL2) {
+		oidread(peeled, ri->ref.value.val2.target_value);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int reftable_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct git_reftable_iterator *ri =
+		(struct git_reftable_iterator *)ref_iterator;
+	reftable_ref_record_release(&ri->ref);
+	reftable_iterator_destroy(&ri->iter);
+	return 0;
+}
+
+static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
+	reftable_ref_iterator_advance, reftable_ref_iterator_peel,
+	reftable_ref_iterator_abort
+};
+
+static struct ref_iterator *
+git_reftable_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
+				const char **exclude_patterns_TODO,
+				unsigned int flags)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct git_reftable_iterator *ri = xcalloc(1, sizeof(*ri));
+
+	if (refs->err < 0) {
+		ri->err = refs->err;
+	} else {
+		struct reftable_merged_table *mt =
+			reftable_stack_merged_table(refs->main_stack);
+		ri->err = reftable_merged_table_seek_ref(mt, &ri->iter, prefix);
+	}
+
+	base_ref_iterator_init(&ri->base, &reftable_ref_iterator_vtable, 1);
+	ri->prefix = prefix;
+	ri->base.oid = &ri->oid;
+	ri->flags = flags;
+	ri->ref_store = ref_store;
+	return &ri->base;
+}
+
+static struct ref_transaction *git_reftable_transaction_begin(struct ref_store *ref_store,
+							      struct strbuf *errbuf)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_addition *add = NULL;
+	struct ref_transaction *transaction = NULL;
+	struct reftable_stack *stack = refs->main_stack;
+
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_new_addition(&add, stack);
+	if (err) {
+		strbuf_addf(errbuf, "reftable: transaction begin: %s",
+			    reftable_error_str(err));
+		goto done;
+	}
+
+	CALLOC_ARRAY(transaction, 1);
+	transaction->backend_data = add;
+done:
+	return transaction;
+}
+
+static int git_reftable_transaction_prepare(struct ref_store *ref_store,
+					    struct ref_transaction *transaction,
+					    struct strbuf *errbuf)
+{
+	transaction->state = REF_TRANSACTION_PREPARED;
+	return 0;
+}
+
+static int git_reftable_transaction_abort(struct ref_store *ref_store,
+					  struct ref_transaction *transaction,
+					  struct strbuf *err)
+{
+	struct reftable_addition *add =
+		(struct reftable_addition *)transaction->backend_data;
+	reftable_addition_destroy(add);
+	transaction->backend_data = NULL;
+
+	/* XXX. Shouldn't this be handled generically in refs.c? */
+	transaction->state = REF_TRANSACTION_CLOSED;
+	return 0;
+}
+
+static int reftable_check_old_oid(struct ref_store *refs, const char *refname,
+				  struct object_id *want_oid)
+{
+	struct object_id out_oid;
+	int out_flags = 0;
+	const char *resolved = refs_resolve_ref_unsafe(
+		refs, refname, RESOLVE_REF_READING, &out_oid, &out_flags);
+	if (is_null_oid(want_oid) != !resolved) {
+		return REFTABLE_LOCK_ERROR;
+	}
+
+	if (resolved && !oideq(&out_oid, want_oid)) {
+		return REFTABLE_LOCK_ERROR;
+	}
+
+	return 0;
+}
+
+static int ref_update_cmp(const void *a, const void *b)
+{
+	return strcmp((*(struct ref_update **)a)->refname,
+		      (*(struct ref_update **)b)->refname);
+}
+
+static int write_transaction_table(struct reftable_writer *writer, void *arg)
+{
+	struct ref_transaction *transaction = (struct ref_transaction *)arg;
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)transaction->ref_store;
+	struct reftable_stack *stack =
+		stack_for(refs, transaction->updates[0]->refname);
+	uint64_t ts = reftable_stack_next_update_index(stack);
+	int err = 0;
+	int i = 0;
+	int log_count = 0;
+	struct reftable_log_record *logs =
+		calloc(transaction->nr, sizeof(*logs));
+	struct ref_update **sorted =
+		malloc(transaction->nr * sizeof(struct ref_update *));
+	struct reftable_merged_table *mt = reftable_stack_merged_table(stack);
+	struct reftable_table tab = { NULL };
+	struct reftable_ref_record ref = { NULL };
+	reftable_table_from_merged_table(&tab, mt);
+	COPY_ARRAY(sorted, transaction->updates, transaction->nr);
+	QSORT(sorted, transaction->nr, ref_update_cmp);
+	reftable_writer_set_limits(writer, ts, ts);
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = sorted[i];
+		struct reftable_log_record *log = &logs[log_count];
+		struct object_id old_id = *null_oid();
+
+		log->value.update.new_hash = NULL;
+		log->value.update.old_hash = NULL;
+		if ((u->flags & REF_FORCE_CREATE_REFLOG) ||
+		    should_log(u->refname))
+			log_count++;
+		fill_reftable_log_record(log);
+
+		log->update_index = ts;
+		log->value_type = REFTABLE_LOG_UPDATE;
+		log->refname = xstrdup(u->refname);
+		log->value.update.new_hash = u->new_oid.hash;
+		log->value.update.message =
+			xstrndup(u->msg, refs->write_options.block_size / 2);
+
+		err = reftable_table_read_ref(&tab, u->refname, &ref);
+		if (err < 0)
+			goto done;
+		else if (err > 0) {
+			err = 0;
+		}
+
+		/* XXX if this is a symref (say, HEAD), should we deref the
+		 * symref and check the update.old_hash against the referent? */
+		if (ref.value_type == REFTABLE_REF_VAL2 ||
+		    ref.value_type == REFTABLE_REF_VAL1)
+			oidread(&old_id, ref.value.val1);
+
+		/* XXX fold together with the old_id check below? */
+		log->value.update.old_hash = old_id.hash;
+		if (u->flags & REF_LOG_ONLY) {
+			continue;
+		}
+
+		if (u->flags & REF_HAVE_NEW) {
+			struct reftable_ref_record ref = { NULL };
+			struct object_id peeled;
+
+			int peel_error = peel_object(&u->new_oid, &peeled);
+			ref.refname = (char *)u->refname;
+			ref.update_index = ts;
+
+			if (!peel_error) {
+				ref.value_type = REFTABLE_REF_VAL2;
+				ref.value.val2.target_value = peeled.hash;
+				ref.value.val2.value = u->new_oid.hash;
+			} else if (!is_null_oid(&u->new_oid)) {
+				ref.value_type = REFTABLE_REF_VAL1;
+				ref.value.val1 = u->new_oid.hash;
+			}
+
+			err = reftable_writer_add_ref(writer, &ref);
+			if (err < 0) {
+				goto done;
+			}
+		}
+	}
+
+	for (i = 0; i < log_count; i++) {
+		err = reftable_writer_add_log(writer, &logs[i]);
+		logs[i].value.update.new_hash = NULL;
+		logs[i].value.update.old_hash = NULL;
+		clear_reftable_log_record(&logs[i]);
+		if (err < 0) {
+			goto done;
+		}
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_ref_record_release(&ref);
+	free(logs);
+	free(sorted);
+	return err;
+}
+
+static int git_reftable_transaction_finish(struct ref_store *ref_store,
+					   struct ref_transaction *transaction,
+					   struct strbuf *errmsg)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)transaction->ref_store;
+	struct reftable_addition *add =
+		(struct reftable_addition *)transaction->backend_data;
+	int err = 0;
+	int i;
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = transaction->updates[i];
+		if (u->flags & REF_HAVE_OLD) {
+			err = reftable_check_old_oid(transaction->ref_store,
+						     u->refname, &u->old_oid);
+			if (err < 0) {
+				goto done;
+			}
+		}
+	}
+	if (transaction->nr) {
+		err = reftable_addition_add(add, &write_transaction_table,
+					    transaction);
+		if (err < 0) {
+			goto done;
+		}
+	}
+
+	err = reftable_addition_commit(add);
+
+	if (!err)
+		err = reftable_stack_auto_compact(refs->main_stack);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_addition_destroy(add);
+	transaction->state = REF_TRANSACTION_CLOSED;
+	transaction->backend_data = NULL;
+	if (err) {
+		strbuf_addf(errmsg, "reftable: transaction failure: %s",
+			    reftable_error_str(err));
+		return -1;
+	}
+	return err;
+}
+
+static int
+git_reftable_transaction_initial_commit(struct ref_store *ref_store,
+					struct ref_transaction *transaction,
+					struct strbuf *errmsg)
+{
+	int err = git_reftable_transaction_prepare(ref_store, transaction,
+						   errmsg);
+	if (err)
+		return err;
+
+	return git_reftable_transaction_finish(ref_store, transaction, errmsg);
+}
+
+struct write_delete_refs_arg {
+	struct git_reftable_ref_store *refs;
+	struct reftable_stack *stack;
+	struct string_list *refnames;
+	const char *logmsg;
+	unsigned int flags;
+};
+
+static int write_delete_refs_table(struct reftable_writer *writer, void *argv)
+{
+	struct write_delete_refs_arg *arg =
+		(struct write_delete_refs_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	int err = 0;
+	int i = 0;
+
+	reftable_writer_set_limits(writer, ts, ts);
+	for (i = 0; i < arg->refnames->nr; i++) {
+		struct reftable_ref_record ref = {
+			.refname = (char *)arg->refnames->items[i].string,
+			.value_type = REFTABLE_REF_DELETION,
+			.update_index = ts,
+		};
+		err = reftable_writer_add_ref(writer, &ref);
+		if (err < 0) {
+			return err;
+		}
+	}
+
+	for (i = 0; i < arg->refnames->nr; i++) {
+		struct reftable_log_record log = {
+			.update_index = ts,
+		};
+		struct reftable_ref_record current = { NULL };
+		fill_reftable_log_record(&log);
+		log.update_index = ts;
+		log.refname = xstrdup(arg->refnames->items[i].string);
+		if (!should_log(log.refname)) {
+			continue;
+		}
+		log.value.update.message = xstrndup(
+			arg->logmsg, arg->refs->write_options.block_size / 2);
+		log.value.update.new_hash = NULL;
+		log.value.update.old_hash = NULL;
+		if (reftable_stack_read_ref(arg->stack, log.refname,
+					    &current) == 0) {
+			log.value.update.old_hash =
+				reftable_ref_record_val1(&current);
+		}
+		err = reftable_writer_add_log(writer, &log);
+		log.value.update.old_hash = NULL;
+		reftable_ref_record_release(&current);
+
+		clear_reftable_log_record(&log);
+		if (err < 0) {
+			return err;
+		}
+	}
+	return 0;
+}
+
+static int git_reftable_delete_refs(struct ref_store *ref_store,
+				    const char *msg,
+				    struct string_list *refnames,
+				    unsigned int flags)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(
+		refs, refnames->nr ? refnames->items[0].string : NULL);
+	struct write_delete_refs_arg arg = {
+		.refs = refs,
+		.stack = stack,
+		.refnames = refnames,
+		.logmsg = msg,
+		.flags = flags,
+	};
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+
+	string_list_sort(refnames);
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+	err = reftable_stack_add(stack, &write_delete_refs_table, &arg);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+static int git_reftable_pack_refs(struct ref_store *ref_store,
+				  struct pack_refs_opts *opts)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+
+	int err = refs->err;
+	if (err < 0) {
+		return err;
+	}
+	err = reftable_stack_compact_all(refs->main_stack, NULL);
+	if (err == 0)
+		err = reftable_stack_clean(refs->main_stack);
+
+	return err;
+}
+
+struct write_create_symref_arg {
+	struct git_reftable_ref_store *refs;
+	struct reftable_stack *stack;
+	const char *refname;
+	const char *target;
+	const char *logmsg;
+};
+
+static int write_create_symref_table(struct reftable_writer *writer, void *arg)
+{
+	struct write_create_symref_arg *create =
+		(struct write_create_symref_arg *)arg;
+	uint64_t ts = reftable_stack_next_update_index(create->stack);
+	int err = 0;
+
+	struct reftable_ref_record ref = {
+		.refname = (char *)create->refname,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = (char *)create->target,
+		.update_index = ts,
+	};
+	reftable_writer_set_limits(writer, ts, ts);
+	err = reftable_writer_add_ref(writer, &ref);
+	if (err == 0) {
+		struct reftable_log_record log = { NULL };
+		struct object_id new_oid;
+		struct object_id old_oid;
+
+		fill_reftable_log_record(&log);
+		log.refname = xstrdup(create->refname);
+		if (!should_log(log.refname)) {
+			return err;
+		}
+		log.update_index = ts;
+		log.value.update.message =
+			xstrndup(create->logmsg,
+				 create->refs->write_options.block_size / 2);
+		if (refs_resolve_ref_unsafe(
+			    (struct ref_store *)create->refs, create->refname,
+			    RESOLVE_REF_READING, &old_oid, NULL)) {
+			log.value.update.old_hash = old_oid.hash;
+		}
+
+		if (refs_resolve_ref_unsafe((struct ref_store *)create->refs,
+					    create->target, RESOLVE_REF_READING,
+					    &new_oid, NULL)) {
+			log.value.update.new_hash = new_oid.hash;
+		}
+
+		if (log.value.update.old_hash ||
+		    log.value.update.new_hash) {
+			err = reftable_writer_add_log(writer, &log);
+		}
+		log.refname = NULL;
+		log.value.update.message = NULL;
+		log.value.update.old_hash = NULL;
+		log.value.update.new_hash = NULL;
+		clear_reftable_log_record(&log);
+	}
+	return err;
+}
+
+static int git_reftable_create_symref(struct ref_store *ref_store,
+				      const char *refname, const char *target,
+				      const char *logmsg)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct write_create_symref_arg arg = { .refs = refs,
+					       .stack = stack,
+					       .refname = refname,
+					       .target = target,
+					       .logmsg = logmsg };
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+	err = reftable_stack_add(stack, &write_create_symref_table, &arg);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+struct write_rename_arg {
+	struct git_reftable_ref_store *refs;
+	struct reftable_stack *stack;
+	const char *oldname;
+	const char *newname;
+	const char *logmsg;
+};
+
+static int write_rename_table(struct reftable_writer *writer, void *argv)
+{
+	struct write_rename_arg *arg = (struct write_rename_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	struct reftable_ref_record old_ref = { NULL };
+	struct reftable_ref_record new_ref = { NULL };
+	int err = reftable_stack_read_ref(arg->stack, arg->oldname, &old_ref);
+	struct reftable_ref_record todo[2] = {
+		{
+			.refname = (char *)arg->oldname,
+			.update_index = ts,
+			.value_type = REFTABLE_REF_DELETION,
+		},
+		old_ref,
+	};
+
+	if (err) {
+		goto done;
+	}
+
+	/* git-branch supports a --force, but the check is not atomic. */
+	if (!reftable_stack_read_ref(arg->stack, arg->newname, &new_ref)) {
+		goto done;
+	}
+
+	reftable_writer_set_limits(writer, ts, ts);
+
+	todo[1].update_index = ts;
+	todo[1].refname = (char *)arg->newname;
+
+	err = reftable_writer_add_refs(writer, todo, 2);
+	if (err < 0) {
+		goto done;
+	}
+
+	if (reftable_ref_record_val1(&old_ref)) {
+		uint8_t *val1 = reftable_ref_record_val1(&old_ref);
+		struct reftable_log_record todo[2] = { { NULL } };
+		int firstlog = 0;
+		int lastlog = 2;
+		char *msg = xstrndup(arg->logmsg,
+				     arg->refs->write_options.block_size / 2);
+		fill_reftable_log_record(&todo[0]);
+		fill_reftable_log_record(&todo[1]);
+
+		todo[0].refname = xstrdup(arg->oldname);
+		todo[0].update_index = ts;
+		todo[0].value.update.message = msg;
+		todo[0].value.update.old_hash = val1;
+		todo[0].value.update.new_hash = NULL;
+
+		todo[1].refname = xstrdup(arg->newname);
+		todo[1].update_index = ts;
+		todo[1].value.update.old_hash = NULL;
+		todo[1].value.update.new_hash = val1;
+		todo[1].value.update.message = xstrdup(msg);
+
+		if (!should_log(todo[1].refname)) {
+			lastlog--;
+		}
+		if (!should_log(todo[0].refname)) {
+			firstlog++;
+		}
+		err = reftable_writer_add_logs(writer, &todo[firstlog],
+					       lastlog - firstlog);
+
+		clear_reftable_log_record(&todo[0]);
+		clear_reftable_log_record(&todo[1]);
+		if (err < 0) {
+			goto done;
+		}
+
+	} else {
+		/* XXX what should we write into the reflog if we rename a
+		 * symref? */
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_ref_record_release(&new_ref);
+	reftable_ref_record_release(&old_ref);
+	return err;
+}
+
+static int write_copy_table(struct reftable_writer *writer, void *argv)
+{
+	struct write_rename_arg *arg = (struct write_rename_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	struct reftable_ref_record old_ref = { NULL };
+	struct reftable_ref_record new_ref = { NULL };
+	struct reftable_log_record log = { NULL };
+	struct reftable_iterator it = { NULL };
+	int err = reftable_stack_read_ref(arg->stack, arg->oldname, &old_ref);
+	if (err) {
+		goto done;
+	}
+
+	/* git-branch supports a --force, but the check is not atomic. */
+	if (reftable_stack_read_ref(arg->stack, arg->newname, &new_ref) == 0) {
+		goto done;
+	}
+
+	reftable_writer_set_limits(writer, ts, ts);
+
+	FREE_AND_NULL(old_ref.refname);
+	old_ref.refname = xstrdup(arg->newname);
+	old_ref.update_index = ts;
+	err = reftable_writer_add_ref(writer, &old_ref);
+	if (err < 0) {
+		goto done;
+	}
+
+	/* XXX this copies the entire reflog history. Is this the right
+	 * semantics? should clear out existing reflog entries for oldname? */
+	if (!should_log(arg->newname))
+		goto done;
+
+	err = reftable_merged_table_seek_log(
+		reftable_stack_merged_table(arg->stack), &it, arg->oldname);
+	if (err < 0) {
+		goto done;
+	}
+	while (1) {
+		int err = reftable_iterator_next_log(&it, &log);
+		if (err < 0) {
+			goto done;
+		}
+
+		if (err > 0 || strcmp(log.refname, arg->oldname)) {
+			break;
+		}
+		FREE_AND_NULL(log.refname);
+		log.refname = xstrdup(arg->newname);
+		reftable_writer_add_log(writer, &log);
+		reftable_log_record_release(&log);
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_ref_record_release(&new_ref);
+	reftable_ref_record_release(&old_ref);
+	reftable_log_record_release(&log);
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+static int git_reftable_rename_ref(struct ref_store *ref_store,
+				   const char *oldrefname,
+				   const char *newrefname, const char *logmsg)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, newrefname);
+	struct write_rename_arg arg = {
+		.refs = refs,
+		.stack = stack,
+		.oldname = oldrefname,
+		.newname = newrefname,
+		.logmsg = logmsg,
+	};
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_add(stack, &write_rename_table, &arg);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+static int git_reftable_copy_ref(struct ref_store *ref_store,
+				 const char *oldrefname, const char *newrefname,
+				 const char *logmsg)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, newrefname);
+	struct write_rename_arg arg = {
+		.refs = refs,
+		.stack = stack,
+		.oldname = oldrefname,
+		.newname = newrefname,
+		.logmsg = logmsg,
+	};
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_add(stack, &write_copy_table, &arg);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+struct git_reftable_reflog_ref_iterator {
+	struct ref_iterator base;
+	struct reftable_iterator iter;
+	struct reftable_log_record log;
+	struct object_id oid;
+	struct git_reftable_ref_store *refs;
+
+	/* Used when iterating over worktree & main */
+	struct reftable_merged_table *merged;
+	char *last_name;
+};
+
+static int
+git_reftable_reflog_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct git_reftable_reflog_ref_iterator *ri =
+		(struct git_reftable_reflog_ref_iterator *)ref_iterator;
+
+	while (1) {
+		int flags = 0;
+		int err = reftable_iterator_next_log(&ri->iter, &ri->log);
+
+		if (err > 0) {
+			return ITER_DONE;
+		}
+		if (err < 0) {
+			return ITER_ERROR;
+		}
+
+		ri->base.refname = ri->log.refname;
+		if (ri->last_name &&
+		    !strcmp(ri->log.refname, ri->last_name)) {
+			/* we want the refnames that we have reflogs for, so we
+			 * skip if we've already produced this name. This could
+			 * be faster by seeking directly to
+			 * reflog@update_index==0.
+			 */
+			continue;
+		}
+
+		if (!refs_resolve_ref_unsafe(&ri->refs->base, ri->log.refname,
+					     0, &ri->oid, &flags)) {
+			error("bad ref for %s", ri->log.refname);
+			continue;
+		}
+
+		free(ri->last_name);
+		ri->last_name = xstrdup(ri->log.refname);
+		ri->base.oid = &ri->oid;
+		ri->base.flags = flags;
+		return ITER_OK;
+	}
+}
+
+static int
+git_reftable_reflog_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				      struct object_id *peeled)
+{
+	BUG("not supported.");
+	return -1;
+}
+
+static int
+git_reftable_reflog_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct git_reftable_reflog_ref_iterator *ri =
+		(struct git_reftable_reflog_ref_iterator *)ref_iterator;
+	reftable_log_record_release(&ri->log);
+	reftable_iterator_destroy(&ri->iter);
+	if (ri->merged)
+		reftable_merged_table_free(ri->merged);
+	return 0;
+}
+
+static struct ref_iterator_vtable git_reftable_reflog_ref_iterator_vtable = {
+	git_reftable_reflog_ref_iterator_advance,
+	git_reftable_reflog_ref_iterator_peel,
+	git_reftable_reflog_ref_iterator_abort
+};
+
+static struct ref_iterator *
+git_reftable_reflog_iterator_begin(struct ref_store *ref_store)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct git_reftable_reflog_ref_iterator *ri = xcalloc(1, sizeof(*ri));
+	struct reftable_stack *stack = refs->main_stack;
+	struct reftable_merged_table *mt =
+		reftable_stack_merged_table(stack);
+	int err = reftable_merged_table_seek_log(mt, &ri->iter, "");
+
+	ri->refs = refs;
+	if (err < 0) {
+		free(ri);
+		/* XXX how to handle errors in iterator_begin()? */
+		return NULL;
+	}
+	base_ref_iterator_init(&ri->base,
+			       &git_reftable_reflog_ref_iterator_vtable, 1);
+	ri->base.oid = &ri->oid;
+
+	return (struct ref_iterator *)ri;
+}
+
+static int git_reftable_for_each_reflog_ent_newest_first(
+	struct ref_store *ref_store, const char *refname, each_reflog_ent_fn fn,
+	void *cb_data)
+{
+	struct reftable_iterator it = { NULL };
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_merged_table *mt = NULL;
+	int err = 0;
+	struct reftable_log_record log = { NULL };
+
+	if (refs->err < 0) {
+		return refs->err;
+	}
+	refname = bare_ref_name(refname);
+
+	mt = reftable_stack_merged_table(stack);
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+	while (err == 0) {
+		struct object_id old_oid;
+		struct object_id new_oid;
+		const char *full_committer = "";
+
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			err = 0;
+			break;
+		}
+		if (err < 0) {
+			break;
+		}
+
+		if (strcmp(log.refname, refname)) {
+			break;
+		}
+
+		oidread(&old_oid, log.value.update.old_hash);
+		oidread(&new_oid, log.value.update.new_hash);
+
+		if (is_null_oid(&old_oid) && is_null_oid(&new_oid)) {
+			/* placeholder for existence. */
+			continue;
+		}
+
+		full_committer = fmt_ident(log.value.update.name,
+					   log.value.update.email,
+					   WANT_COMMITTER_IDENT,
+					   /*date*/ NULL, IDENT_NO_DATE);
+		err = fn(&old_oid, &new_oid, full_committer,
+			 log.value.update.time, log.value.update.tz_offset,
+			 log.value.update.message, cb_data);
+		if (err)
+			break;
+	}
+
+	reftable_log_record_release(&log);
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+static int git_reftable_for_each_reflog_ent_oldest_first(
+	struct ref_store *ref_store, const char *refname, each_reflog_ent_fn fn,
+	void *cb_data)
+{
+	struct reftable_iterator it = { NULL };
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_merged_table *mt = NULL;
+	struct reftable_log_record *logs = NULL;
+	int cap = 0;
+	int len = 0;
+	int err = 0;
+	int i = 0;
+
+	if (refs->err < 0) {
+		return refs->err;
+	}
+	refname = bare_ref_name(refname);
+	mt = reftable_stack_merged_table(stack);
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+
+	while (err == 0) {
+		struct reftable_log_record log = { NULL };
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			err = 0;
+			break;
+		}
+		if (err < 0) {
+			break;
+		}
+
+		if (strcmp(log.refname, refname)) {
+			break;
+		}
+
+		if (len == cap) {
+			cap = 2 * cap + 1;
+			logs = realloc(logs, cap * sizeof(*logs));
+		}
+
+		logs[len++] = log;
+	}
+
+	for (i = len; i--;) {
+		struct reftable_log_record *log = &logs[i];
+		struct object_id old_oid;
+		struct object_id new_oid;
+		const char *full_committer = "";
+
+		oidread(&old_oid, log->value.update.old_hash);
+		oidread(&new_oid, log->value.update.new_hash);
+
+		if (is_null_oid(&old_oid) && is_null_oid(&new_oid)) {
+			/* placeholder for existence. */
+			continue;
+		}
+
+		full_committer = fmt_ident(log->value.update.name,
+					   log->value.update.email,
+					   WANT_COMMITTER_IDENT, NULL,
+					   IDENT_NO_DATE);
+		err = fn(&old_oid, &new_oid, full_committer,
+			 log->value.update.time, log->value.update.tz_offset,
+			 log->value.update.message, cb_data);
+		if (err) {
+			break;
+		}
+	}
+
+	for (i = 0; i < len; i++) {
+		reftable_log_record_release(&logs[i]);
+	}
+	free(logs);
+
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+static int git_reftable_reflog_exists(struct ref_store *ref_store,
+				      const char *refname)
+{
+	struct reftable_iterator it = { NULL };
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_merged_table *mt = reftable_stack_merged_table(stack);
+	struct reftable_log_record log = { NULL };
+	int err = refs->err;
+
+	if (err < 0) {
+		goto done;
+	}
+
+	refname = bare_ref_name(refname);
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+	if (err) {
+		goto done;
+	}
+	err = reftable_iterator_next_log(&it, &log);
+	if (err) {
+		goto done;
+	}
+
+	if (strcmp(log.refname, refname)) {
+		err = 1;
+	}
+
+done:
+	reftable_iterator_destroy(&it);
+	reftable_log_record_release(&log);
+	return !err;
+}
+
+struct write_reflog_existence_arg {
+	struct git_reftable_ref_store *refs;
+	const char *refname;
+	struct reftable_stack *stack;
+};
+
+static int write_reflog_existence_table(struct reftable_writer *writer,
+					void *argv)
+{
+	struct write_reflog_existence_arg *arg =
+		(struct write_reflog_existence_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	struct reftable_log_record log = { NULL };
+
+	int err = reftable_stack_read_log(arg->stack, arg->refname, &log);
+	if (err <= 0) {
+		goto done;
+	}
+
+	reftable_writer_set_limits(writer, ts, ts);
+
+	log.refname = (char *)arg->refname;
+	log.update_index = ts;
+	log.value_type = REFTABLE_LOG_UPDATE;
+	err = reftable_writer_add_log(writer, &log);
+
+	/* field is not malloced */
+	log.refname = NULL;
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_log_record_release(&log);
+	return err;
+}
+
+static int git_reftable_create_reflog(struct ref_store *ref_store,
+				      const char *refname,
+				      struct strbuf *errmsg)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct write_reflog_existence_arg arg = {
+		.refs = refs,
+		.stack = stack,
+		.refname = refname,
+	};
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_add(stack, &write_reflog_existence_table, &arg);
+
+done:
+	return err;
+}
+
+struct write_reflog_delete_arg {
+	struct reftable_stack *stack;
+	const char *refname;
+};
+
+static int write_reflog_delete_table(struct reftable_writer *writer, void *argv)
+{
+	struct write_reflog_delete_arg *arg = argv;
+	struct reftable_merged_table *mt =
+		reftable_stack_merged_table(arg->stack);
+	struct reftable_log_record log = { NULL };
+	struct reftable_iterator it = { NULL };
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	int err = reftable_merged_table_seek_log(mt, &it, arg->refname);
+
+	reftable_writer_set_limits(writer, ts, ts);
+	while (err == 0) {
+		struct reftable_log_record tombstone = {
+			.refname = (char *)arg->refname,
+			.update_index = REFTABLE_LOG_DELETION,
+		};
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			err = 0;
+			break;
+		}
+
+		if (err < 0 || strcmp(log.refname, arg->refname)) {
+			break;
+		}
+		if (log.value_type == REFTABLE_LOG_DELETION)
+			continue;
+
+		tombstone.update_index = log.update_index;
+		err = reftable_writer_add_log(writer, &tombstone);
+	}
+
+	reftable_log_record_release(&log);
+	return err;
+}
+
+static int git_reftable_delete_reflog(struct ref_store *ref_store,
+				      const char *refname)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct write_reflog_delete_arg arg = {
+		.stack = stack,
+		.refname = refname,
+	};
+	int err = reftable_stack_add(stack, &write_reflog_delete_table, &arg);
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+struct reflog_expiry_arg {
+	struct reftable_stack *stack;
+	struct reftable_log_record *records;
+	int len;
+	const char *refname;
+};
+
+static int write_reflog_expiry_table(struct reftable_writer *writer, void *argv)
+{
+	struct reflog_expiry_arg *arg = (struct reflog_expiry_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	int i = 0;
+	int live_records = 0;
+	uint64_t max_ts = 0;
+	for (i = 0; i < arg->len; i++) {
+		if (arg->records[i].value_type == REFTABLE_LOG_UPDATE)
+			live_records++;
+
+		if (max_ts < arg->records[i].update_index)
+			max_ts = arg->records[i].update_index;
+	}
+
+	reftable_writer_set_limits(writer, ts, ts);
+	if (live_records == 0) {
+		struct reftable_log_record log = {
+			.refname = (char *)arg->refname,
+			.update_index = max_ts + 1,
+			.value_type = REFTABLE_LOG_UPDATE,
+			/* existence dummy has null new/old oid */
+		};
+		int err;
+		if (log.update_index < ts)
+			log.update_index = ts;
+
+		err = reftable_writer_add_log(writer, &log);
+		if (err) {
+			return err;
+		}
+	}
+
+	for (i = 0; i < arg->len; i++) {
+		int err = reftable_writer_add_log(writer, &arg->records[i]);
+		if (err) {
+			return err;
+		}
+	}
+	return 0;
+}
+
+static int git_reftable_reflog_expire(
+	struct ref_store *ref_store, const char *refname, unsigned int flags,
+	reflog_expiry_prepare_fn prepare_fn,
+	reflog_expiry_should_prune_fn should_prune_fn,
+	reflog_expiry_cleanup_fn cleanup_fn, void *policy_cb_data)
+{
+	/*
+	  For log expiry, we write tombstones in place of the expired entries,
+	  This means that the entries are still retrievable by delving into the
+	  stack, and expiring entries paradoxically takes extra memory.
+
+	  This memory is only reclaimed when some operation issues a
+	  git_reftable_pack_refs(), which will compact the entire stack and get
+	  rid of deletion entries.
+
+	  It would be better if the refs backend supported an API that sets a
+	  criterion for all refs, passing the criterion to pack_refs().
+
+	  On the plus side, because we do the expiration per ref, we can easily
+	  insert the reflog existence dummies.
+	*/
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_merged_table *mt = NULL;
+	struct reflog_expiry_arg arg = {
+		.stack = stack,
+		.refname = refname,
+	};
+	struct reftable_log_record *logs = NULL;
+	struct reftable_log_record *rewritten = NULL;
+	struct reftable_ref_record ref_record = { NULL };
+	int logs_len = 0;
+	int logs_cap = 0;
+	int i = 0;
+	uint8_t *last_hash = NULL;
+	struct reftable_iterator it = { NULL };
+	struct reftable_addition *add = NULL;
+	int err = 0;
+	struct object_id oid = { 0 };
+	if (refs->err < 0) {
+		return refs->err;
+	}
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	mt = reftable_stack_merged_table(stack);
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+	if (err < 0) {
+		goto done;
+	}
+
+	err = reftable_stack_new_addition(&add, stack);
+	if (err) {
+		goto done;
+	}
+	if (!reftable_stack_read_ref(stack, refname, &ref_record)) {
+		uint8_t *hash = reftable_ref_record_val1(&ref_record);
+		if (hash)
+			oidread(&oid, hash);
+	}
+
+	prepare_fn(refname, &oid, policy_cb_data);
+	while (1) {
+		struct reftable_log_record log = { NULL };
+		int err = reftable_iterator_next_log(&it, &log);
+		if (err < 0) {
+			goto done;
+		}
+
+		if (err > 0 || strcmp(log.refname, refname)) {
+			break;
+		}
+
+		if (logs_len >= logs_cap) {
+			int new_cap = logs_cap * 2 + 1;
+			logs = realloc(logs, new_cap * sizeof(*logs));
+			logs_cap = new_cap;
+		}
+		logs[logs_len++] = log;
+	}
+
+	rewritten = calloc(logs_len, sizeof(*rewritten));
+	for (i = logs_len - 1; i >= 0; i--) {
+		struct object_id ooid;
+		struct object_id noid;
+		struct reftable_log_record *dest = &rewritten[i];
+
+		*dest = logs[i];
+		oidread(&ooid, logs[i].value.update.old_hash);
+		oidread(&noid, logs[i].value.update.new_hash);
+
+		if (should_prune_fn(&ooid, &noid, logs[i].value.update.email,
+				    (timestamp_t)logs[i].value.update.time,
+				    logs[i].value.update.tz_offset,
+				    logs[i].value.update.message,
+				    policy_cb_data)) {
+			dest->value_type = REFTABLE_LOG_DELETION;
+		} else {
+			if ((flags & EXPIRE_REFLOGS_REWRITE) &&
+			    last_hash) {
+				dest->value.update.old_hash = last_hash;
+			}
+			last_hash = logs[i].value.update.new_hash;
+		}
+	}
+
+	arg.records = rewritten;
+	arg.len = logs_len;
+	err = reftable_addition_add(add, &write_reflog_expiry_table, &arg);
+	if (err < 0) {
+		goto done;
+	}
+
+	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
+		/* future improvement: we could skip writing records that were
+		 * not changed. */
+		err = reftable_addition_commit(add);
+	}
+
+done:
+	if (add) {
+		cleanup_fn(policy_cb_data);
+	}
+	assert(err != REFTABLE_API_ERROR);
+	reftable_addition_destroy(add);
+	for (i = 0; i < logs_len; i++)
+		reftable_log_record_release(&logs[i]);
+	free(logs);
+	free(rewritten);
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+static int git_reftable_read_raw_ref(struct ref_store *ref_store,
+				     const char *refname, struct object_id *oid,
+				     struct strbuf *referent,
+				     unsigned int *type, int *failure_errno)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_ref_record ref = { NULL };
+	int err = 0;
+
+	refname = bare_ref_name(refname); /* XXX - in which other cases should
+					     we do this? */
+	if (refs->err < 0) {
+		return refs->err;
+	}
+
+	/* This is usually not needed, but Git doesn't signal to ref backend if
+	   a subprocess updated the ref DB.  So we always check.
+	*/
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_read_ref(stack, refname, &ref);
+	if (err > 0) {
+		*failure_errno = ENOENT;
+		err = -1;
+		goto done;
+	}
+	if (err < 0) {
+		goto done;
+	}
+
+	if (ref.value_type == REFTABLE_REF_SYMREF) {
+		strbuf_reset(referent);
+		strbuf_addstr(referent, ref.value.symref);
+		*type |= REF_ISSYMREF;
+	} else if (reftable_ref_record_val1(&ref)) {
+		oidread(oid, reftable_ref_record_val1(&ref));
+	} else {
+		/* We got a tombstone, which should not happen. */
+		BUG("Got reftable_ref_record with value type %d",
+		    ref.value_type);
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_ref_record_release(&ref);
+	return err;
+}
+
+static int git_reftable_read_symbolic_ref(struct ref_store *ref_store,
+					  const char *refname,
+					  struct strbuf *referent)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_ref_record ref = { NULL };
+	int err = 0;
+
+	err = reftable_stack_read_ref(stack, refname, &ref);
+	if (err == 0 && ref.value_type == REFTABLE_REF_SYMREF) {
+		strbuf_addstr(referent, ref.value.symref);
+	} else {
+		err = -1;
+	}
+
+	reftable_ref_record_release(&ref);
+	return err;
+}
+
+struct ref_storage_be refs_be_reftable = {
+	.next = &refs_be_files,
+	.name = "reftable",
+	.init = git_reftable_ref_store_create,
+	.init_db = git_reftable_init_db,
+	.transaction_begin = git_reftable_transaction_begin,
+	.transaction_prepare = git_reftable_transaction_prepare,
+	.transaction_finish = git_reftable_transaction_finish,
+	.transaction_abort = git_reftable_transaction_abort,
+	.initial_transaction_commit = git_reftable_transaction_initial_commit,
+
+	.pack_refs = git_reftable_pack_refs,
+	.create_symref = git_reftable_create_symref,
+	.delete_refs = git_reftable_delete_refs,
+	.rename_ref = git_reftable_rename_ref,
+	.copy_ref = git_reftable_copy_ref,
+
+	.iterator_begin = git_reftable_ref_iterator_begin,
+	.read_raw_ref = git_reftable_read_raw_ref,
+	.read_symbolic_ref = git_reftable_read_symbolic_ref,
+
+	.reflog_iterator_begin = git_reftable_reflog_iterator_begin,
+	.for_each_reflog_ent = git_reftable_for_each_reflog_ent_oldest_first,
+	.for_each_reflog_ent_reverse =
+		git_reftable_for_each_reflog_ent_newest_first,
+	.reflog_exists = git_reftable_reflog_exists,
+	.create_reflog = git_reftable_create_reflog,
+	.delete_reflog = git_reftable_delete_reflog,
+	.reflog_expire = git_reftable_reflog_expire,
+};
diff --git a/refs/reftable-backend.h b/refs/reftable-backend.h
new file mode 100644
index 00000000000..bf5fd42229a
--- /dev/null
+++ b/refs/reftable-backend.h
@@ -0,0 +1,8 @@
+#ifndef REFS_REFTABLE_BACKEND_H
+#define REFS_REFTABLE_BACKEND_H
+
+struct ref_store *git_reftable_ref_store_create(struct repository *repo,
+						const char *gitdir,
+						unsigned int store_flags);
+
+#endif /* REFS_REFTABLE_BACKEND_H */
-- 
gitgitgadget

