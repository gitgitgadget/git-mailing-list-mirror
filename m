Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B7C20954
	for <e@80x24.org>; Fri,  1 Dec 2017 22:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbdLAWu1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 17:50:27 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:46378 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdLAWuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 17:50:25 -0500
Received: by mail-io0-f194.google.com with SMTP id x129so12893392iod.13
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 14:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PPAw6oMnepN3EFVx89a3Td1fi+7lbnUx+WLpSi8bwws=;
        b=kcO1Om8ziIzmAWDb6DIkt3ynftjDVDJBc+Qf7ZnQzk5Z5qiNmynNWDugrH37OPVAJb
         H3XIvI90cqPiugWiZJU8/Vn/EnEWLJlGLz7/Qr9RrINnAgSWx5FaxUfzER5sfU0t9gnf
         44y37Bf+jLUEyxl/MQnbf202ZAr8a+nHWMK0wxCx0hw1/dGQPwWvlA5hR7A4zbyJ9hdK
         RQ3jLmTXKDoD4fz5q9E+uEgsP3KpZECNh+HBNTTBnXb2dRWcywpcXbIpOAKa0Q4EV68r
         o8nX1HmoPR3oZgvyZvSK6kB05KXpYAi6Z6u33hK78BQMbVKyVORbNnC6kZhQbp8JARei
         5unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PPAw6oMnepN3EFVx89a3Td1fi+7lbnUx+WLpSi8bwws=;
        b=nOCic0OJdFv8TYSBa4/7H+vjAlLaCi/KJF35O78bvJk79LDiSAtYATtGSJlHjVt2Yq
         rd5tVUDT+bOEfSYbStCQCd3N04mmZDxZqniAYn6Fg5RU+x5OV/tlc6I5GoHth2jZlhNI
         FsAXxSUz2BWBTd4NcSsjVNX+pGRA8TUzqDs2vo96yip9si//n7W42vfRJWWeGaW5njzI
         8tzrQPgb0Sq/uf9o6Ryv2SbdpAdPlIB33jTgG3BLwKn1B5EPvsw1TklPU8/VX+NQibqz
         QbwnRYlwxnaalyPAjhlDsIFfGyXyU8LSrRAOMmRNbjS7piQKC3lpp7ZxVUm//CF34+xL
         OYsA==
X-Gm-Message-State: AJaThX66n+WIDSaoMl++tS94eVoR8cKlekyZG0tIrrLDjXzLVrqNXYeA
        Hm8KKqpMmVETTZ3Vzj4oxyb6nLot8xY=
X-Google-Smtp-Source: AGs4zMYXPZvyXjTgv7WJYdyDiAOK2BZHTMPmAP0lf5irzaQiKkYCqwqJeaYS4b0S6Phhgp8Ju1MKOg==
X-Received: by 10.107.136.229 with SMTP id s98mr15133574ioi.294.1512168624451;
        Fri, 01 Dec 2017 14:50:24 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id p17sm3420475iod.15.2017.12.01.14.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Dec 2017 14:50:23 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jacob.keller@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [WIP 2/2] submodule: read-only super-backed ref backend
Date:   Fri,  1 Dec 2017 14:50:07 -0800
Message-Id: <bba84ff0be9c2cbd87bff77a481a74698d90062f.1512168087.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.1.273.g588edb5b8.dirty
In-Reply-To: <cover.1512168087.git.jonathantanmy@google.com>
References: <cover.1512168087.git.jonathantanmy@google.com>
In-Reply-To: <cover.1512168087.git.jonathantanmy@google.com>
References: <cover.1512168087.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that a few major parts are still missing:
 - special handling of the current branch of the superproject
 - writing (whether "refs/..." to the superproject as an index change or
   a commit, or non-"refs/..." directly to the subproject like usual)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile                       |   1 +
 refs.c                         |  11 +-
 refs/refs-internal.h           |   1 +
 refs/sp-backend.c              | 261 +++++++++++++++++++++++++++++++++++++++++
 submodule.c                    |  43 +++++--
 submodule.h                    |   2 +
 t/t1406-submodule-ref-store.sh |  26 ++++
 7 files changed, 331 insertions(+), 14 deletions(-)
 create mode 100644 refs/sp-backend.c

diff --git a/Makefile b/Makefile
index e53750ca0..74120b5d7 100644
--- a/Makefile
+++ b/Makefile
@@ -858,6 +858,7 @@ LIB_OBJS += refs/files-backend.o
 LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
+LIB_OBJS += refs/sp-backend.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
diff --git a/refs.c b/refs.c
index 339d4318e..1f7922733 100644
--- a/refs.c
+++ b/refs.c
@@ -1575,12 +1575,17 @@ static struct ref_store *lookup_ref_store_map(struct hashmap *map,
 static struct ref_store *ref_store_init(const char *gitdir,
 					unsigned int flags)
 {
-	const char *be_name = "files";
-	struct ref_storage_be *be = find_ref_storage_backend(be_name);
+	struct ref_storage_be *be;
 	struct ref_store *refs;
 
+	if (getenv("USE_SP")) {
+		be = &refs_be_sp;
+	} else {
+		be = &refs_be_files;
+	}
+
 	if (!be)
-		die("BUG: reference backend %s is unknown", be_name);
+		die("BUG: reference backend %s is unknown", "files");
 
 	refs = be->init(gitdir, flags);
 	return refs;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index dd834314b..a8ec03d90 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -651,6 +651,7 @@ struct ref_storage_be {
 
 extern struct ref_storage_be refs_be_files;
 extern struct ref_storage_be refs_be_packed;
+extern struct ref_storage_be refs_be_sp;
 
 /*
  * A representation of the reference store for the main repository or
diff --git a/refs/sp-backend.c b/refs/sp-backend.c
new file mode 100644
index 000000000..31e8cec4b
--- /dev/null
+++ b/refs/sp-backend.c
@@ -0,0 +1,261 @@
+#include "../cache.h"
+#include "../config.h"
+#include "../refs.h"
+#include "refs-internal.h"
+#include "ref-cache.h"
+#include "packed-backend.h"
+#include "../iterator.h"
+#include "../dir-iterator.h"
+#include "../lockfile.h"
+#include "../object.h"
+#include "../dir.h"
+#include "../submodule.h"
+
+/*
+ * Future: need to be in "struct repository"
+ * when doing a full libification.
+ */
+struct sp_ref_store {
+	struct ref_store base;
+	unsigned int store_flags;
+
+	/*
+	 * Ref store of this repository (the submodule), used only for the
+	 * reflog.
+	 */
+	struct ref_store *files;
+
+	/*
+	 * Ref store of the superproject, for refs.
+	 */
+	struct ref_store *files_superproject;
+};
+
+/*
+ * Create a new submodule ref cache and add it to the internal
+ * set of caches.
+ */
+static struct ref_store *sp_init(const char *gitdir, unsigned int flags)
+{
+	struct sp_ref_store *refs = xcalloc(1, sizeof(*refs));
+	struct ref_store *ref_store = (struct ref_store *)refs;
+
+	base_ref_store_init(ref_store, &refs_be_sp);
+	refs->store_flags = flags;
+	refs->files = refs_be_files.init(gitdir, flags);
+
+	return ref_store;
+}
+
+/*
+ * Downcast ref_store to sp_ref_store. Die if ref_store is not a
+ * sp_ref_store. required_flags is compared with ref_store's
+ * store_flags to ensure the ref_store has all required capabilities.
+ * "caller" is used in any necessary error messages.
+ */
+static struct sp_ref_store *sp_downcast(struct ref_store *ref_store,
+					      unsigned int required_flags,
+					      const char *caller)
+{
+	struct sp_ref_store *refs;
+
+	if (ref_store->be != &refs_be_sp)
+		die("BUG: ref_store is type \"%s\" not \"sp\" in %s",
+		    ref_store->be->name, caller);
+
+	refs = (struct sp_ref_store *)ref_store;
+
+	if ((refs->store_flags & required_flags) != required_flags)
+		die("BUG: operation %s requires abilities 0x%x, but only have 0x%x",
+		    caller, required_flags, refs->store_flags);
+
+	return refs;
+}
+
+static int sp_read_raw_ref(struct ref_store *ref_store,
+			      const char *refname, struct object_id *oid,
+			      struct strbuf *referent, unsigned int *type)
+{
+	struct sp_ref_store *refs;
+
+	refs = sp_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
+
+	if (!starts_with(refname, "refs/")) {
+		return refs_read_raw_ref(refs->files, refname, oid, referent, type);
+	}
+
+	/* read from the superproject instead */
+	return get_superproject_gitlink_oid(refname, oid);
+}
+
+static struct ref_iterator *sp_ref_iterator_begin(
+		struct ref_store *ref_store,
+		const char *prefix, unsigned int flags)
+{
+	return empty_ref_iterator_begin();
+}
+
+static int sp_pack_refs(struct ref_store *ref_store, unsigned int flags)
+{
+	/* no op */
+	return 0;
+}
+
+static int sp_delete_refs(struct ref_store *ref_store, const char *msg,
+			     struct string_list *refnames, unsigned int flags)
+{
+	/* unsupported */
+	return -1;
+}
+
+static int sp_rename_ref(struct ref_store *ref_store,
+			    const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
+{
+	/* unsupported */
+	return -1;
+}
+
+static int sp_copy_ref(struct ref_store *ref_store,
+			    const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
+{
+	/* unsupported */
+	return -1;
+}
+
+static int sp_create_reflog(struct ref_store *ref_store,
+			       const char *refname, int force_create,
+			       struct strbuf *err)
+{
+	struct sp_ref_store *refs =
+		sp_downcast(ref_store, REF_STORE_WRITE, "create_reflog");
+	return refs_create_reflog(refs->files, refname, force_create, err);
+}
+
+static int sp_create_symref(struct ref_store *ref_store,
+			       const char *refname, const char *target,
+			       const char *logmsg)
+{
+	/* unsupported */
+	return -1;
+}
+
+static int sp_reflog_exists(struct ref_store *ref_store,
+			       const char *refname)
+{
+	struct sp_ref_store *refs =
+		sp_downcast(ref_store, REF_STORE_READ, "reflog_exists");
+	return refs_reflog_exists(refs->files, refname);
+}
+
+static int sp_delete_reflog(struct ref_store *ref_store,
+			       const char *refname)
+{
+	struct sp_ref_store *refs =
+		sp_downcast(ref_store, REF_STORE_WRITE, "delete_reflog");
+	return refs_delete_reflog(refs->files, refname);
+}
+
+static int sp_for_each_reflog_ent_reverse(struct ref_store *ref_store,
+					     const char *refname,
+					     each_reflog_ent_fn fn,
+					     void *cb_data)
+{
+	struct sp_ref_store *refs =
+		sp_downcast(ref_store, REF_STORE_READ,
+			       "for_each_reflog_ent_reverse");
+	return refs_for_each_reflog_ent_reverse(refs->files, refname, fn, cb_data);
+}
+
+static int sp_for_each_reflog_ent(struct ref_store *ref_store,
+				     const char *refname,
+				     each_reflog_ent_fn fn, void *cb_data)
+{
+	struct sp_ref_store *refs =
+		sp_downcast(ref_store, REF_STORE_READ,
+			       "for_each_reflog_ent");
+	return refs_for_each_reflog_ent(refs->files, refname, fn, cb_data);
+}
+
+static struct ref_iterator *sp_reflog_iterator_begin(struct ref_store *ref_store)
+{
+	struct sp_ref_store *refs =
+		sp_downcast(ref_store, REF_STORE_READ,
+			       "reflog_iterator_begin");
+	return refs->files->be->reflog_iterator_begin(refs->files);
+}
+
+static int sp_transaction_prepare(struct ref_store *ref_store,
+				     struct ref_transaction *transaction,
+				     struct strbuf *err)
+{
+	return -1;
+}
+
+static int sp_transaction_finish(struct ref_store *ref_store,
+				    struct ref_transaction *transaction,
+				    struct strbuf *err)
+{
+	return -1;
+}
+
+static int sp_transaction_abort(struct ref_store *ref_store,
+				   struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	return -1;
+}
+
+static int sp_initial_transaction_commit(struct ref_store *ref_store,
+					    struct ref_transaction *transaction,
+					    struct strbuf *err)
+{
+	return -1;
+}
+
+static int sp_reflog_expire(struct ref_store *ref_store,
+			       const char *refname, const struct object_id *oid,
+			       unsigned int flags,
+			       reflog_expiry_prepare_fn prepare_fn,
+			       reflog_expiry_should_prune_fn should_prune_fn,
+			       reflog_expiry_cleanup_fn cleanup_fn,
+			       void *policy_cb_data)
+{
+	struct sp_ref_store *refs =
+		sp_downcast(ref_store, REF_STORE_WRITE, "reflog_expire");
+	return refs_reflog_expire(refs->files, refname, oid, flags, prepare_fn, should_prune_fn, cleanup_fn, policy_cb_data);
+}
+
+static int sp_init_db(struct ref_store *ref_store, struct strbuf *err)
+{
+	return 0;
+}
+
+struct ref_storage_be refs_be_sp = {
+	NULL,
+	"sp",
+	sp_init,
+	sp_init_db,
+	sp_transaction_prepare,
+	sp_transaction_finish,
+	sp_transaction_abort,
+	sp_initial_transaction_commit,
+
+	sp_pack_refs,
+	sp_create_symref,
+	sp_delete_refs,
+	sp_rename_ref,
+	sp_copy_ref,
+
+	sp_ref_iterator_begin,
+	sp_read_raw_ref,
+
+	sp_reflog_iterator_begin,
+	sp_for_each_reflog_ent,
+	sp_for_each_reflog_ent_reverse,
+	sp_reflog_exists,
+	sp_create_reflog,
+	sp_delete_reflog,
+	sp_reflog_expire
+};
diff --git a/submodule.c b/submodule.c
index ce511180e..1ffaeec82 100644
--- a/submodule.c
+++ b/submodule.c
@@ -471,6 +471,7 @@ static void prepare_submodule_repo_env_no_git_dir(struct argv_array *out)
 void prepare_submodule_repo_env(struct argv_array *out)
 {
 	prepare_submodule_repo_env_no_git_dir(out);
+	argv_array_pushf(out, "USE_SP");
 	argv_array_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
 			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }
@@ -1986,7 +1987,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
  * Return 0 if successful, 1 if not (for example, if the parent
  * directory is not a repo or an unrelated one).
  */
-int get_superproject_entry(const char **full_name)
+static int get_superproject_entry(const char *ref, const char **full_name, struct object_id *oid)
 {
 	static struct strbuf sb = STRBUF_INIT;
 
@@ -2016,9 +2017,11 @@ int get_superproject_entry(const char **full_name)
 	prepare_submodule_repo_env(&cp.env_array);
 	argv_array_pop(&cp.env_array);
 
-	argv_array_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
-			"ls-files", "-z", "--stage", "--full-name", "--",
-			subpath, NULL);
+	argv_array_pushl(&cp.args, "--literal-pathspecs", "-C", "..", NULL);
+	if (ref)
+		argv_array_pushl(&cp.args, "ls-tree", "-z", "--full-name", "-r", ref, subpath, NULL);
+	else
+		argv_array_pushl(&cp.args, "ls-files", "-z", "--full-name", "--stage", "--", subpath, NULL);
 	strbuf_reset(&sb);
 
 	cp.no_stdin = 1;
@@ -2037,13 +2040,24 @@ int get_superproject_entry(const char **full_name)
 	if (starts_with(sb.buf, "160000")) {
 		/*
 		 * There is a superproject having this repo as a submodule.
-		 * The format is <mode> SP <hash> SP <stage> TAB <full name> \0,
-		 * We're only interested in the name after the tab.
+		 * The format is:
+		 * [ls-tree] <mode> SP <type> SP <hash> TAB <full name> \0
+		 * [ls-files] <mode> SP <hash> SP <stage> TAB <full name> \0
 		 */
-		char *tab = strchr(sb.buf, '\t');
-		if (!tab)
-			die("BUG: ls-files returned line with no tab");
-		*full_name = tab + 1;
+		if (full_name) {
+			char *tab = strchr(sb.buf, '\t');
+			if (!tab)
+				die("BUG: ls-files returned line with no tab");
+			*full_name = tab + 1;
+		}
+		if (oid) {
+			char *space = strchr(sb.buf, ' ');
+			const char *p;
+			if (ref)
+				space = strchr(space + 1, ' ');
+			if (parse_oid_hex(space + 1, oid, &p))
+				die("BUG: Could not read OID: %s", space + 1);
+		}
 		return 0;
 	}
 
@@ -2063,7 +2077,7 @@ const char *get_superproject_working_tree(void)
 	size_t len;
 	const char *ret;
 
-	if (get_superproject_entry(&full_name))
+	if (get_superproject_entry(NULL, &full_name, NULL))
 		return NULL;
 
 	super_wt = xstrdup(xgetcwd());
@@ -2075,6 +2089,13 @@ const char *get_superproject_working_tree(void)
 	return ret;
 }
 
+int get_superproject_gitlink_oid(const char *ref, struct object_id *oid)
+{
+	if (get_superproject_entry(ref, NULL, oid))
+		return 1;
+	return 0;
+}
+
 /*
  * Put the gitdir for a submodule (given relative to the main
  * repository worktree) into `buf`, or return -1 on error.
diff --git a/submodule.h b/submodule.h
index 29ab302cc..3a836beab 100644
--- a/submodule.h
+++ b/submodule.h
@@ -140,4 +140,6 @@ extern void absorb_git_dir_into_superproject(const char *prefix,
  */
 extern const char *get_superproject_working_tree(void);
 
+extern int get_superproject_gitlink_oid(const char *ref, struct object_id *oid);
+
 #endif
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index c32d4cc46..46ba7a272 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -98,4 +98,30 @@ test_expect_success 'create-reflog() not allowed' '
 	test_must_fail $RUN create-reflog HEAD 1
 '
 
+test_expect_success 'ref backend based on superproject data' '
+	rm -rf sub super &&
+
+	git init sub &&
+	test_commit -C sub first &&
+	test_commit -C sub second &&
+
+	git init super &&
+
+	# master branch in superproject, submodule at second
+	git -C super submodule add ../sub sub &&
+	git -C super commit -m x &&
+
+	# anotherbranch in superproject, submodule at first
+	git -C super checkout -b anotherbranch &&
+	git -C super/sub checkout first &&
+	git -C super commit -a -m x &&
+
+	# Notice that rev-parse can parse "anotherbranch" and see that it
+	# points to first, even though a branch with the name "anotherbranch"
+	# is only defined in the superproject
+	git -C sub rev-parse first >expect &&
+	USE_SP=1 git -C super/sub rev-parse anotherbranch >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.15.0.531.g2ccb3012c9-goog

