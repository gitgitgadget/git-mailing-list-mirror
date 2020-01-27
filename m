Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3256C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 14:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6CA20716
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 14:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP8nWQ9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgA0OWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:22:35 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:39405 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0OWf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 09:22:35 -0500
Received: by mail-wr1-f53.google.com with SMTP id y11so11520342wrt.6
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 06:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s3ggNCYeBahu6er+JQ4lo86OeMpNq0bqueBpGO6mlmc=;
        b=aP8nWQ9wDf5SrXvTreRL0Ie4I3zJ+qZajNo8vPLxCXK0RNbDHQQDKR6Utti8OmYGAE
         IhyfX5zNDD600qiUn0XaZ+9/Ck0HrE9GRq3PgGg5XJGOQZgwwqEH2orhYn64BJvTntlm
         Ij/so2MnG9yf2vogMnaHKpCOqYJXobPcvb/etwyYU7mrZFq0xMiu1zDqYz/+pR0Zqko6
         a0Wgc4LdBi1KnSoDRJ7Ve0UA+NRk34YFGX9kf6CAPyu6+Q23sGjpDVqkIx4ABeopjer/
         4R+pAD5OA2QYYmh0IhkkdLOiqBguaD7HXBaBFGjpwJhYl1wAPTyjUzIZ+JYMekTf31SN
         z0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s3ggNCYeBahu6er+JQ4lo86OeMpNq0bqueBpGO6mlmc=;
        b=R+Ex3PD2XMJiCiWIq2AVPutPxYfxdyQUQFGlC3YOAvhYNckKc5u2DExex1yJaB+XZ+
         Et58NIjEFn6n7UEjnMCJDmYgE8sbhxGHDzCwH12F9vNLaszxK8cGKQGeGag0iSmbL3aO
         urA3t7He1qLgwQSyewvpbxCAs62g4QRcBvw/2yPFbVwBJh71HbXFMEjDEevy5JuDgkqZ
         tDi2MabS/EgeOeA/3il+tTB3vvmQZyk0FaSOZu+JwP1BByaYAdxHMjWf0wAoOtS5JrI6
         hEwhpkKnqlpf42g7PKUT178PtEFd3hEUCZEgHLhUkgLyVkaVeYUqjXlItQsPc7OYNrb6
         006Q==
X-Gm-Message-State: APjAAAUbXiHA1sZDUEYVUVpo79QMZzop2xI1RibThTtzHLdXguF7PGt/
        TdMm+HvMbWfTJ1/ikGkQNsnwE57o
X-Google-Smtp-Source: APXvYqyTI6mkIAGVst9jNX6vMGnyl7nH1hEjQlYu7zKK0k5rIR/fs3tBfArhAtG5KLx6XYX6O50cSA==
X-Received: by 2002:adf:b648:: with SMTP id i8mr21970332wre.91.1580134951067;
        Mon, 27 Jan 2020 06:22:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm19074505wmm.15.2020.01.27.06.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 06:22:30 -0800 (PST)
Message-Id: <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
        <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jan 2020 14:22:24 +0000
Subject: [PATCH v2 5/5] Reftable support for git-core
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

For background, see the previous commit introducing the library.

TODO:

 * Resolve the design problem with reflog expiry.
 * Resolve spots marked with XXX

Example use:

  $ ~/vc/git/git init
  warning: templates not found in /usr/local/google/home/hanwen/share/git-core/templates
  Initialized empty Git repository in /tmp/qz/.git/
  $ echo q > a
  $ ~/vc/git/git add a
  $ ~/vc/git/git commit -mx
  fatal: not a git repository (or any of the parent directories): .git
  [master (root-commit) 373d969] x
   1 file changed, 1 insertion(+)
   create mode 100644 a
  $ ~/vc/git/git show-ref
  373d96972fca9b63595740bba3898a762778ba20 HEAD
  373d96972fca9b63595740bba3898a762778ba20 refs/heads/master
  $ ls -l .git/reftable/
  total 12
  -rw------- 1 hanwen primarygroup  126 Jan 23 20:08 000000000001-000000000001.ref
  -rw------- 1 hanwen primarygroup 4277 Jan 23 20:08 000000000002-000000000002.ref
  $ go run ~/vc/reftable/cmd/dump.go  -table /tmp/qz/.git/reftable/000000000002-000000000002.ref
  ** DEBUG **
  name /tmp/qz/.git/reftable/000000000002-000000000002.ref, sz 4209: 'r' reftable.readerOffsets{Present:true, Offset:0x0, IndexOffset:0x0}, 'o' reftable.readerOffsets{Present:false, Offset:0x0, IndexOffset:0x0} 'g' reftable.readerOffsets{Present:true, Offset:0x1000, IndexOffset:0x0}
  ** REFS **
  reftable.RefRecord{RefName:"refs/heads/master", UpdateIndex:0x2, Value:[]uint8{0x37, 0x3d, 0x96, 0x97, 0x2f, 0xca, 0x9b, 0x63, 0x59, 0x57, 0x40, 0xbb, 0xa3, 0x89, 0x8a, 0x76, 0x27, 0x78, 0xba, 0x20}, TargetValue:[]uint8(nil), Target:""}
  ** LOGS **
  reftable.LogRecord{RefName:"HEAD", UpdateIndex:0x2, New:[]uint8{0x37, 0x3d, 0x96, 0x97, 0x2f, 0xca, 0x9b, 0x63, 0x59, 0x57, 0x40, 0xbb, 0xa3, 0x89, 0x8a, 0x76, 0x27, 0x78, 0xba, 0x20}, Old:[]uint8{0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, Name:"Han-Wen Nienhuys", Email:"hanwen@google.com", Time:0x5e29ef27, TZOffset:100, Message:"commit (initial): x\n"}

Change-Id: I225ee6317b7911edf9aa95f43299f6c7c4511914
Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                |  23 +-
 refs.c                  |  18 +-
 refs.h                  |   2 +
 refs/refs-internal.h    |   1 +
 refs/reftable-backend.c | 812 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 852 insertions(+), 4 deletions(-)
 create mode 100644 refs/reftable-backend.c

diff --git a/Makefile b/Makefile
index 09f98b777c..4f0bcbfbcb 100644
--- a/Makefile
+++ b/Makefile
@@ -813,6 +813,7 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
+REFTABLE_LIB = reftable/libreftable.a
 
 GENERATED_H += command-list.h
 
@@ -958,6 +959,7 @@ LIB_OBJS += rebase-interactive.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/files-backend.o
+LIB_OBJS += refs/reftable-backend.o
 LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
@@ -1162,7 +1164,7 @@ THIRD_PARTY_SOURCES += compat/regex/%
 THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB)
+GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2343,11 +2345,27 @@ VCSSVN_OBJS += vcs-svn/fast_export.o
 VCSSVN_OBJS += vcs-svn/svndiff.o
 VCSSVN_OBJS += vcs-svn/svndump.o
 
+REFTABLE_OBJS += reftable/basics.o
+REFTABLE_OBJS += reftable/block.o
+REFTABLE_OBJS += reftable/bytes.o
+REFTABLE_OBJS += reftable/file.o
+REFTABLE_OBJS += reftable/iter.o
+REFTABLE_OBJS += reftable/merged.o
+REFTABLE_OBJS += reftable/pq.o
+REFTABLE_OBJS += reftable/reader.o
+REFTABLE_OBJS += reftable/record.o
+REFTABLE_OBJS += reftable/slice.o
+REFTABLE_OBJS += reftable/stack.o
+REFTABLE_OBJS += reftable/tree.o
+REFTABLE_OBJS += reftable/writer.o
+
+
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	$(XDIFF_OBJS) \
 	$(VCSSVN_OBJS) \
 	$(FUZZ_OBJS) \
+	$(REFTABLE_OBJS) \
 	common-main.o \
 	git.o
 ifndef NO_CURL
@@ -2484,6 +2502,9 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 $(VCSSVN_LIB): $(VCSSVN_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+$(REFTABLE_LIB): $(REFTABLE_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
 export DEFAULT_EDITOR DEFAULT_PAGER
 
 Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
diff --git a/refs.c b/refs.c
index 1ab0bb54d3..26d9637e55 100644
--- a/refs.c
+++ b/refs.c
@@ -20,7 +20,7 @@
 /*
  * List of all available backends
  */
-static struct ref_storage_be *refs_backends = &refs_be_files;
+static struct ref_storage_be *refs_backends = &refs_be_reftable;
 
 static struct ref_storage_be *find_ref_storage_backend(const char *name)
 {
@@ -1839,10 +1839,22 @@ static struct ref_store *lookup_ref_store_map(struct hashmap *map,
 static struct ref_store *ref_store_init(const char *gitdir,
 					unsigned int flags)
 {
-	const char *be_name = "files";
-	struct ref_storage_be *be = find_ref_storage_backend(be_name);
+	struct strbuf refs_path = STRBUF_INIT;
+
+        /* XXX this should probably come from a git config setting and not
+           default to reftable. */
+	const char *be_name = "reftable";
+	struct ref_storage_be *be;
 	struct ref_store *refs;
 
+	strbuf_addstr(&refs_path, gitdir);
+	strbuf_addstr(&refs_path, "/refs");
+
+	if (!is_directory(refs_path.buf)) {
+		be_name = "reftable";
+	}
+	strbuf_release(&refs_path);
+	be = find_ref_storage_backend(be_name);
 	if (!be)
 		BUG("reference backend %s is unknown", be_name);
 
diff --git a/refs.h b/refs.h
index 545029c6d8..99656d2065 100644
--- a/refs.h
+++ b/refs.h
@@ -456,6 +456,8 @@ int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
 				     const char *refname,
 				     each_reflog_ent_fn fn,
 				     void *cb_data);
+
+/* XXX which ordering are these? Newest or oldest first? */
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fc18b12340..2744aa57f2 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -659,6 +659,7 @@ struct ref_storage_be {
 };
 
 extern struct ref_storage_be refs_be_files;
+extern struct ref_storage_be refs_be_reftable;
 extern struct ref_storage_be refs_be_packed;
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
new file mode 100644
index 0000000000..c89884af0c
--- /dev/null
+++ b/refs/reftable-backend.c
@@ -0,0 +1,812 @@
+#include "../cache.h"
+#include "../config.h"
+#include "../refs.h"
+#include "refs-internal.h"
+#include "../iterator.h"
+#include "../lockfile.h"
+#include "../chdir-notify.h"
+
+#include "../reftable/reftable.h"
+
+extern struct ref_storage_be refs_be_reftable;
+
+struct reftable_ref_store {
+	struct ref_store base;
+	unsigned int store_flags;
+
+	int err;
+	char *reftable_dir;
+	char *table_list_file;
+	struct stack *stack;
+};
+
+static void clear_log_record(struct log_record *log)
+{
+	log->old_hash = NULL;
+	log->new_hash = NULL;
+	log->message = NULL;
+	log->ref_name = NULL;
+	log_record_clear(log);
+}
+
+static void fill_log_record(struct log_record *log)
+{
+	const char *info = git_committer_info(0);
+	struct ident_split split = {};
+	int result = split_ident_line(&split, info, strlen(info));
+	int sign = 1;
+	assert(0 == result);
+
+	log_record_clear(log);
+	log->name =
+		xstrndup(split.name_begin, split.name_end - split.name_begin);
+	log->email =
+		xstrndup(split.mail_begin, split.mail_end - split.mail_begin);
+	log->time = atol(split.date_begin);
+	if (*split.tz_begin == '-') {
+		sign = -1;
+		split.tz_begin++;
+	}
+	if (*split.tz_begin == '+') {
+		sign = 1;
+		split.tz_begin++;
+	}
+
+	log->tz_offset = sign * atoi(split.tz_begin);
+}
+
+static struct ref_store *reftable_ref_store_create(const char *path,
+						   unsigned int store_flags)
+{
+	struct reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
+	struct ref_store *ref_store = (struct ref_store *)refs;
+	struct write_options cfg = {
+		.block_size = 4096,
+	};
+	struct strbuf sb = STRBUF_INIT;
+
+	base_ref_store_init(ref_store, &refs_be_reftable);
+	refs->store_flags = store_flags;
+
+	strbuf_addf(&sb, "%s/refs", path);
+	refs->table_list_file = xstrdup(sb.buf);
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/reftable", path);
+	refs->reftable_dir = xstrdup(sb.buf);
+	strbuf_release(&sb);
+
+	refs->err = new_stack(&refs->stack, refs->reftable_dir,
+			      refs->table_list_file, cfg);
+
+	return ref_store;
+}
+
+static int reftable_init_db(struct ref_store *ref_store, struct strbuf *err)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	FILE *f = fopen(refs->table_list_file, "a");
+	if (f == NULL) {
+		return -1;
+	}
+	fclose(f);
+
+	safe_create_dir(refs->reftable_dir, 1);
+	return 0;
+}
+
+struct reftable_iterator {
+	struct ref_iterator base;
+	struct iterator iter;
+	struct ref_record ref;
+	struct object_id oid;
+	struct ref_store *ref_store;
+	char *prefix;
+};
+
+static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	while (1) {
+		struct reftable_iterator *ri =
+			(struct reftable_iterator *)ref_iterator;
+		int err = iterator_next_ref(ri->iter, &ri->ref);
+		if (err > 0) {
+			return ITER_DONE;
+		}
+		if (err < 0) {
+			return ITER_ERROR;
+		}
+
+		ri->base.refname = ri->ref.ref_name;
+		if (ri->prefix != NULL &&
+		    strncmp(ri->prefix, ri->ref.ref_name, strlen(ri->prefix))) {
+			return ITER_DONE;
+		}
+
+		ri->base.flags = 0;
+		if (ri->ref.value != NULL) {
+			memcpy(ri->oid.hash, ri->ref.value, GIT_SHA1_RAWSZ);
+		} else if (ri->ref.target != NULL) {
+			int out_flags = 0;
+			const char *resolved = refs_resolve_ref_unsafe(
+				ri->ref_store, ri->ref.ref_name,
+				RESOLVE_REF_READING, &ri->oid, &out_flags);
+			ri->base.flags = out_flags;
+			if (resolved == NULL &&
+			    !(ri->base.flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+			    (ri->base.flags & REF_ISBROKEN)) {
+				continue;
+			}
+		}
+		ri->base.oid = &ri->oid;
+		return ITER_OK;
+	}
+}
+
+static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				      struct object_id *peeled)
+{
+	struct reftable_iterator *ri = (struct reftable_iterator *)ref_iterator;
+	if (ri->ref.target_value != NULL) {
+		memcpy(peeled->hash, ri->ref.target_value, GIT_SHA1_RAWSZ);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int reftable_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct reftable_iterator *ri = (struct reftable_iterator *)ref_iterator;
+	ref_record_clear(&ri->ref);
+	iterator_destroy(&ri->iter);
+	return 0;
+}
+
+static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
+	reftable_ref_iterator_advance, reftable_ref_iterator_peel,
+	reftable_ref_iterator_abort
+};
+
+static struct ref_iterator *
+reftable_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
+			    unsigned int flags)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct reftable_iterator *ri = xcalloc(1, sizeof(*ri));
+	struct merged_table *mt = NULL;
+	int err = 0;
+	if (refs->err) {
+		/* how to propagate errors? */
+		return NULL;
+	}
+
+	mt = stack_merged_table(refs->stack);
+
+	/* XXX something with flags? */
+	err = merged_table_seek_ref(mt, &ri->iter, prefix);
+	/* XXX what to do with err? */
+	assert(err == 0);
+	base_ref_iterator_init(&ri->base, &reftable_ref_iterator_vtable, 1);
+	ri->base.oid = &ri->oid;
+	ri->ref_store = ref_store;
+	return &ri->base;
+}
+
+static int reftable_transaction_prepare(struct ref_store *ref_store,
+					struct ref_transaction *transaction,
+					struct strbuf *err)
+{
+	return 0;
+}
+
+static int reftable_transaction_abort(struct ref_store *ref_store,
+				      struct ref_transaction *transaction,
+				      struct strbuf *err)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	(void)refs;
+	return 0;
+}
+
+static int ref_update_cmp(const void *a, const void *b)
+{
+	return strcmp(((struct ref_update *)a)->refname,
+		      ((struct ref_update *)b)->refname);
+}
+
+static int reftable_check_old_oid(struct ref_store *refs, const char *refname,
+				  struct object_id *want_oid)
+{
+	struct object_id out_oid = {};
+	int out_flags = 0;
+	const char *resolved = refs_resolve_ref_unsafe(
+		refs, refname, RESOLVE_REF_READING, &out_oid, &out_flags);
+	if (is_null_oid(want_oid) != (resolved == NULL)) {
+		return LOCK_ERROR;
+	}
+
+	if (resolved != NULL && !oideq(&out_oid, want_oid)) {
+		return LOCK_ERROR;
+	}
+
+	return 0;
+}
+
+static int write_transaction_table(struct writer *writer, void *arg)
+{
+	struct ref_transaction *transaction = (struct ref_transaction *)arg;
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)transaction->ref_store;
+	uint64_t ts = stack_next_update_index(refs->stack);
+	int err = 0;
+	/* XXX - are we allowed to mutate the input data? */
+	qsort(transaction->updates, transaction->nr,
+	      sizeof(struct ref_update *), ref_update_cmp);
+	writer_set_limits(writer, ts, ts);
+
+	for (int i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = transaction->updates[i];
+		if (u->flags & REF_HAVE_OLD) {
+			err = reftable_check_old_oid(transaction->ref_store,
+						     u->refname, &u->old_oid);
+			if (err < 0) {
+				goto exit;
+			}
+		}
+	}
+
+	for (int i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = transaction->updates[i];
+		if (u->flags & REF_HAVE_NEW) {
+			struct object_id out_oid = {};
+			int out_flags = 0;
+			/* XXX who owns the memory here? */
+			const char *resolved = refs_resolve_ref_unsafe(
+				transaction->ref_store, u->refname, 0, &out_oid,
+				&out_flags);
+			struct ref_record ref = {};
+			ref.ref_name =
+				(char *)(resolved ? resolved : u->refname);
+			ref.value = u->new_oid.hash;
+			ref.update_index = ts;
+			err = writer_add_ref(writer, &ref);
+			if (err < 0) {
+				goto exit;
+			}
+		}
+	}
+
+	for (int i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = transaction->updates[i];
+		struct log_record log = {};
+		fill_log_record(&log);
+
+		log.ref_name = (char *)u->refname;
+		log.old_hash = u->old_oid.hash;
+		log.new_hash = u->new_oid.hash;
+		log.update_index = ts;
+		log.message = u->msg;
+
+		err = writer_add_log(writer, &log);
+		clear_log_record(&log);
+		if (err < 0) {
+			return err;
+		}
+	}
+exit:
+	return err;
+}
+
+static int reftable_transaction_commit(struct ref_store *ref_store,
+				       struct ref_transaction *transaction,
+				       struct strbuf *errmsg)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	int err = stack_add(refs->stack, &write_transaction_table, transaction);
+	if (err < 0) {
+		strbuf_addf(errmsg, "reftable: transaction failure %s",
+			    error_str(err));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int reftable_transaction_finish(struct ref_store *ref_store,
+				       struct ref_transaction *transaction,
+				       struct strbuf *err)
+{
+	return reftable_transaction_commit(ref_store, transaction, err);
+}
+
+struct write_delete_refs_arg {
+	struct stack *stack;
+	struct string_list *refnames;
+	const char *logmsg;
+	unsigned int flags;
+};
+
+static int write_delete_refs_table(struct writer *writer, void *argv)
+{
+	struct write_delete_refs_arg *arg =
+		(struct write_delete_refs_arg *)argv;
+	uint64_t ts = stack_next_update_index(arg->stack);
+	int err = 0;
+
+	writer_set_limits(writer, ts, ts);
+	for (int i = 0; i < arg->refnames->nr; i++) {
+		struct ref_record ref = {
+			.ref_name = (char *)arg->refnames->items[i].string,
+			.update_index = ts,
+		};
+		err = writer_add_ref(writer, &ref);
+		if (err < 0) {
+			return err;
+		}
+	}
+
+	for (int i = 0; i < arg->refnames->nr; i++) {
+		struct log_record log = {};
+		fill_log_record(&log);
+		log.message = xstrdup(arg->logmsg);
+		log.new_hash = NULL;
+
+		/* XXX should lookup old oid. */
+		log.old_hash = NULL;
+		log.update_index = ts;
+		log.ref_name = (char *)arg->refnames->items[i].string;
+
+		err = writer_add_log(writer, &log);
+		clear_log_record(&log);
+		if (err < 0) {
+			return err;
+		}
+	}
+	return 0;
+}
+
+static int reftable_delete_refs(struct ref_store *ref_store, const char *msg,
+				struct string_list *refnames,
+				unsigned int flags)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct write_delete_refs_arg arg = {
+		.stack = refs->stack,
+		.refnames = refnames,
+		.logmsg = msg,
+		.flags = flags,
+	};
+	return stack_add(refs->stack, &write_delete_refs_table, &arg);
+}
+
+static int reftable_pack_refs(struct ref_store *ref_store, unsigned int flags)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	/* XXX reflog expiry. */
+	return stack_compact_all(refs->stack, NULL);
+}
+
+struct write_create_symref_arg {
+	struct stack *stack;
+	const char *refname;
+	const char *target;
+	const char *logmsg;
+};
+
+static int write_create_symref_table(struct writer *writer, void *arg)
+{
+	struct write_create_symref_arg *create =
+		(struct write_create_symref_arg *)arg;
+	uint64_t ts = stack_next_update_index(create->stack);
+	int err = 0;
+
+	struct ref_record ref = {
+		.ref_name = (char *)create->refname,
+		.target = (char *)create->target,
+		.update_index = ts,
+	};
+	writer_set_limits(writer, ts, ts);
+	err = writer_add_ref(writer, &ref);
+	if (err < 0) {
+		return err;
+	}
+
+	/* XXX reflog? */
+
+	return 0;
+}
+
+static int reftable_create_symref(struct ref_store *ref_store,
+				  const char *refname, const char *target,
+				  const char *logmsg)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct write_create_symref_arg arg = { .stack = refs->stack,
+					       .refname = refname,
+					       .target = target,
+					       .logmsg = logmsg };
+	return stack_add(refs->stack, &write_create_symref_table, &arg);
+}
+
+struct write_rename_arg {
+	struct stack *stack;
+	const char *oldname;
+	const char *newname;
+	const char *logmsg;
+};
+
+static int write_rename_table(struct writer *writer, void *argv)
+{
+	struct write_rename_arg *arg = (struct write_rename_arg *)argv;
+	uint64_t ts = stack_next_update_index(arg->stack);
+	struct ref_record ref = {};
+	int err = stack_read_ref(arg->stack, arg->oldname, &ref);
+	if (err) {
+		goto exit;
+	}
+
+	/* XXX should check that dest doesn't exist? */
+	free(ref.ref_name);
+	ref.ref_name = strdup(arg->newname);
+	writer_set_limits(writer, ts, ts);
+	ref.update_index = ts;
+
+	{
+		struct ref_record todo[2] = {};
+		todo[0].ref_name = (char *)arg->oldname;
+		todo[0].update_index = ts;
+		todo[1] = ref;
+		todo[1].update_index = ts;
+
+		err = writer_add_refs(writer, todo, 2);
+		if (err < 0) {
+			goto exit;
+		}
+	}
+
+	if (ref.value != NULL) {
+		struct log_record todo[2] = {};
+		fill_log_record(&todo[0]);
+		fill_log_record(&todo[1]);
+
+		todo[0].ref_name = (char *)arg->oldname;
+		todo[0].update_index = ts;
+		todo[0].message = (char *)arg->logmsg;
+		todo[0].old_hash = ref.value;
+		todo[0].new_hash = NULL;
+
+		todo[1].ref_name = (char *)arg->newname;
+		todo[1].update_index = ts;
+		todo[1].old_hash = NULL;
+		todo[1].new_hash = ref.value;
+		todo[1].message = (char *)arg->logmsg;
+
+		err = writer_add_logs(writer, todo, 2);
+
+		clear_log_record(&todo[0]);
+		clear_log_record(&todo[1]);
+
+		if (err < 0) {
+			goto exit;
+		}
+
+	} else {
+		/* XXX symrefs? */
+	}
+
+exit:
+	ref_record_clear(&ref);
+	return err;
+}
+
+static int reftable_rename_ref(struct ref_store *ref_store,
+			       const char *oldrefname, const char *newrefname,
+			       const char *logmsg)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct write_rename_arg arg = {
+		.stack = refs->stack,
+		.oldname = oldrefname,
+		.newname = newrefname,
+		.logmsg = logmsg,
+	};
+	return stack_add(refs->stack, &write_rename_table, &arg);
+}
+
+static int reftable_copy_ref(struct ref_store *ref_store,
+			     const char *oldrefname, const char *newrefname,
+			     const char *logmsg)
+{
+	BUG("reftable reference store does not support copying references");
+}
+
+struct reftable_reflog_ref_iterator {
+	struct ref_iterator base;
+	struct iterator iter;
+	struct log_record log;
+	struct object_id oid;
+	char *last_name;
+};
+
+static int
+reftable_reflog_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct reftable_reflog_ref_iterator *ri =
+		(struct reftable_reflog_ref_iterator *)ref_iterator;
+
+	while (1) {
+		int err = iterator_next_log(ri->iter, &ri->log);
+		if (err > 0) {
+			return ITER_DONE;
+		}
+		if (err < 0) {
+			return ITER_ERROR;
+		}
+
+		ri->base.refname = ri->log.ref_name;
+		if (ri->last_name != NULL &&
+		    !strcmp(ri->log.ref_name, ri->last_name)) {
+			continue;
+		}
+
+		free(ri->last_name);
+		ri->last_name = xstrdup(ri->log.ref_name);
+		/* XXX const? */
+		memcpy(&ri->oid.hash, ri->log.new_hash, GIT_SHA1_RAWSZ);
+		return ITER_OK;
+	}
+}
+
+static int reftable_reflog_ref_iterator_peel(struct ref_iterator *ref_iterator,
+					     struct object_id *peeled)
+{
+	BUG("not supported.");
+	return -1;
+}
+
+static int reftable_reflog_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct reftable_reflog_ref_iterator *ri =
+		(struct reftable_reflog_ref_iterator *)ref_iterator;
+	log_record_clear(&ri->log);
+	iterator_destroy(&ri->iter);
+	return 0;
+}
+
+static struct ref_iterator_vtable reftable_reflog_ref_iterator_vtable = {
+	reftable_reflog_ref_iterator_advance, reftable_reflog_ref_iterator_peel,
+	reftable_reflog_ref_iterator_abort
+};
+
+static struct ref_iterator *
+reftable_reflog_iterator_begin(struct ref_store *ref_store)
+{
+	struct reftable_reflog_ref_iterator *ri = xcalloc(sizeof(*ri), 1);
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+
+	struct merged_table *mt = stack_merged_table(refs->stack);
+	int err = merged_table_seek_log(mt, &ri->iter, "");
+	if (err < 0) {
+		free(ri);
+		return NULL;
+	}
+
+	base_ref_iterator_init(&ri->base, &reftable_reflog_ref_iterator_vtable,
+			       1);
+	ri->base.oid = &ri->oid;
+
+	return empty_ref_iterator_begin();
+}
+
+static int
+reftable_for_each_reflog_ent_newest_first(struct ref_store *ref_store,
+					  const char *refname,
+					  each_reflog_ent_fn fn, void *cb_data)
+{
+	struct iterator it = {};
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct merged_table *mt = stack_merged_table(refs->stack);
+	int err = merged_table_seek_log(mt, &it, refname);
+	struct log_record log = {};
+
+	while (err == 0) {
+		err = iterator_next_log(it, &log);
+		if (err != 0) {
+			break;
+		}
+
+		if (strcmp(log.ref_name, refname)) {
+			break;
+		}
+
+		{
+			struct object_id old_oid = {};
+			struct object_id new_oid = {};
+
+			memcpy(&old_oid.hash, log.old_hash, GIT_SHA1_RAWSZ);
+			memcpy(&new_oid.hash, log.new_hash, GIT_SHA1_RAWSZ);
+
+			/* XXX committer = email? name? */
+			if (fn(&old_oid, &new_oid, log.name, log.time,
+			       log.tz_offset, log.message, cb_data)) {
+				err = -1;
+				break;
+			}
+		}
+	}
+
+	log_record_clear(&log);
+	iterator_destroy(&it);
+	if (err > 0) {
+		err = 0;
+	}
+	return err;
+}
+
+static int
+reftable_for_each_reflog_ent_oldest_first(struct ref_store *ref_store,
+					  const char *refname,
+					  each_reflog_ent_fn fn, void *cb_data)
+{
+	struct iterator it = {};
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct merged_table *mt = stack_merged_table(refs->stack);
+	int err = merged_table_seek_log(mt, &it, refname);
+
+	struct log_record *logs = NULL;
+	int cap = 0;
+	int len = 0;
+
+	printf("oldest first\n");
+	while (err == 0) {
+		struct log_record log = {};
+		err = iterator_next_log(it, &log);
+		if (err != 0) {
+			break;
+		}
+
+		if (strcmp(log.ref_name, refname)) {
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
+	for (int i = len; i--;) {
+		struct log_record *log = &logs[i];
+		struct object_id old_oid = {};
+		struct object_id new_oid = {};
+
+		memcpy(&old_oid.hash, log->old_hash, GIT_SHA1_RAWSZ);
+		memcpy(&new_oid.hash, log->new_hash, GIT_SHA1_RAWSZ);
+
+		/* XXX committer = email? name? */
+		if (!fn(&old_oid, &new_oid, log->name, log->time,
+			log->tz_offset, log->message, cb_data)) {
+			err = -1;
+			break;
+		}
+	}
+
+	for (int i = 0; i < len; i++) {
+		log_record_clear(&logs[i]);
+	}
+	free(logs);
+
+	iterator_destroy(&it);
+	if (err > 0) {
+		err = 0;
+	}
+	return err;
+}
+
+static int reftable_reflog_exists(struct ref_store *ref_store,
+				  const char *refname)
+{
+	/* always exists. */
+	return 1;
+}
+
+static int reftable_create_reflog(struct ref_store *ref_store,
+				  const char *refname, int force_create,
+				  struct strbuf *err)
+{
+	return 0;
+}
+
+static int reftable_delete_reflog(struct ref_store *ref_store,
+				  const char *refname)
+{
+	return 0;
+}
+
+static int reftable_reflog_expire(struct ref_store *ref_store,
+				  const char *refname,
+				  const struct object_id *oid,
+				  unsigned int flags,
+				  reflog_expiry_prepare_fn prepare_fn,
+				  reflog_expiry_should_prune_fn should_prune_fn,
+				  reflog_expiry_cleanup_fn cleanup_fn,
+				  void *policy_cb_data)
+{
+	/*
+	  XXX
+
+	  This doesn't fit with the reftable API. If we are expiring for space
+	  reasons, the expiry should be combined with a compaction, and there
+	  should be a policy that can be called for all refnames, not for a
+	  single ref name.
+
+	  If this is for cleaning up individual entries, we'll have to write
+	  extra data to create tombstones.
+	 */
+	return 0;
+}
+
+static int reftable_read_raw_ref(struct ref_store *ref_store,
+				 const char *refname, struct object_id *oid,
+				 struct strbuf *referent, unsigned int *type)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct ref_record ref = {};
+	int err = stack_read_ref(refs->stack, refname, &ref);
+	if (err) {
+		goto exit;
+	}
+	if (ref.target != NULL) {
+		strbuf_reset(referent);
+		strbuf_addstr(referent, ref.target);
+		*type |= REF_ISSYMREF;
+	} else {
+		memcpy(oid->hash, ref.value, GIT_SHA1_RAWSZ);
+	}
+
+exit:
+	ref_record_clear(&ref);
+	return err;
+}
+
+struct ref_storage_be refs_be_reftable = {
+	&refs_be_files,
+	"reftable",
+	reftable_ref_store_create,
+	reftable_init_db,
+	reftable_transaction_prepare,
+	reftable_transaction_finish,
+	reftable_transaction_abort,
+	reftable_transaction_commit,
+
+	reftable_pack_refs,
+	reftable_create_symref,
+	reftable_delete_refs,
+	reftable_rename_ref,
+	reftable_copy_ref,
+
+	reftable_ref_iterator_begin,
+	reftable_read_raw_ref,
+
+	reftable_reflog_iterator_begin,
+	reftable_for_each_reflog_ent_newest_first,
+	reftable_for_each_reflog_ent_oldest_first,
+	reftable_reflog_exists,
+	reftable_create_reflog,
+	reftable_delete_reflog,
+	reftable_reflog_expire
+};
-- 
gitgitgadget
