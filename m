Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D6C21F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeBFAEr (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:04:47 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35893 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeBFAEo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:04:44 -0500
Received: by mail-pg0-f67.google.com with SMTP id x25so137957pge.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vACpuUgyZLO3ZYiwaYiXCyqLmmGNcMQnEm4Za7PQlY8=;
        b=MEjp2FpA2qEPAax7Fgro+kJiUNaFCQ/I5xzahHWpakHbJkj3cCGfz7RF7aYvx8JZSh
         ns9ATyu25JXqLHdtCPhtq5KAe/wRX72x2tsM3mCE2WW1cUM2fel+l5ZRevPmUPnXuWIP
         0I/erCf2gCGzWI7Oq0+bi7MKAr6DHsv+Kv1Anp580AUMf7i/dYy8BbjtyCjQRXJXPIk1
         eKcyZStbQxoY2YoT+E0bbdcM8xbN5t2NpcZnly1HIHlThOMtPLdlxMcOz1sfseJ4G5Pq
         7XXzr7gJr9tZcFdmuzMHJ/DXwDd15RkiFSZiwi97i4TpDMhhIm6ifqlnTqWyi1JuPwaj
         KlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vACpuUgyZLO3ZYiwaYiXCyqLmmGNcMQnEm4Za7PQlY8=;
        b=VPq0dkK0IAY0hOQB30RqkGU+YQeb2IoCQljTgYuj6qwl54bpBBvAAOzlGZTjYG+WtD
         JW50wTQGiIay6+B08UJ4RLaAFqIULs4mVWEWx3+8oJFIGQ9yPausmDhjw1ZwkkLayeR3
         1X4jWLC6P0L8L8ztyUP2JjWjiUUpLWR1ycUGkQml2zWdkVTk/V3jGRR6KwuQY9n7LMAW
         Phlf0hL+G7IDAMJUx29+bpfT48AVz5k2Gj4k5FXUmSkDv0tSNWRGO0Ibq9zCasrc8Eix
         Nu5QToHXuB3l+xHrnF+kx2BrmYrdN47DX1RfjHZJQPBObgi2UpOnd04OCRmyXL7G/yXy
         M/qg==
X-Gm-Message-State: APf1xPCGiBjtVeCP5J/M51aYGRYraUezkqOx3vCGoGLdfhx/oQV8pH2J
        Z4F9QwI74AQ9iPny14yJ0LJ6rab4t1E=
X-Google-Smtp-Source: AH8x224JWlobUoxunTZIw86pBRT8zpgO+CljaL2O4CIJQL+E+7sgMdpgxIaYcE2yWL7JiecmBkxHcQ==
X-Received: by 10.98.14.208 with SMTP id 77mr485351pfo.99.1517875483622;
        Mon, 05 Feb 2018 16:04:43 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id x15sm673635pff.55.2018.02.05.16.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:04:42 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 052/194] refs: add repository argument to get_main_ref_store
Date:   Mon,  5 Feb 2018 15:55:13 -0800
Message-Id: <20180205235735.216710-32-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the get_main_ref_store caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/pack-refs.c       |  3 ++-
 refs.c                    | 67 ++++++++++++++++++++++++-----------------------
 refs.h                    |  4 ++-
 revision.c                |  5 ++--
 t/helper/test-ref-store.c |  3 ++-
 5 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index b106a392a4..f3353564f9 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "refs.h"
+#include "repository.h"
 
 static char const * const pack_refs_usage[] = {
 	N_("git pack-refs [<options>]"),
@@ -17,5 +18,5 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 	};
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
-	return refs_pack_refs(get_main_ref_store(), flags);
+	return refs_pack_refs(get_main_ref_store(the_repository), flags);
 }
diff --git a/refs.c b/refs.c
index 5c26532cbd..c2dee7a69a 100644
--- a/refs.c
+++ b/refs.c
@@ -14,6 +14,7 @@
 #include "tag.h"
 #include "submodule.h"
 #include "worktree.h"
+#include "repository.h"
 
 /*
  * List of all available backends
@@ -207,7 +208,7 @@ char *refs_resolve_refdup(struct ref_store *refs,
 char *resolve_refdup(const char *refname, int resolve_flags,
 		     struct object_id *oid, int *flags)
 {
-	return refs_resolve_refdup(get_main_ref_store(),
+	return refs_resolve_refdup(get_main_ref_store(the_repository),
 				   refname, resolve_flags,
 				   oid, flags);
 }
@@ -229,7 +230,7 @@ int refs_read_ref_full(struct ref_store *refs, const char *refname,
 
 int read_ref_full(const char *refname, int resolve_flags, struct object_id *oid, int *flags)
 {
-	return refs_read_ref_full(get_main_ref_store(), refname,
+	return refs_read_ref_full(get_main_ref_store(the_repository), refname,
 				  resolve_flags, oid, flags);
 }
 
@@ -376,7 +377,7 @@ int refs_for_each_tag_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 
 int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_tag_ref(get_main_ref_store(), fn, cb_data);
+	return refs_for_each_tag_ref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
 int refs_for_each_branch_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
@@ -386,7 +387,7 @@ int refs_for_each_branch_ref(struct ref_store *refs, each_ref_fn fn, void *cb_da
 
 int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_branch_ref(get_main_ref_store(), fn, cb_data);
+	return refs_for_each_branch_ref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
 int refs_for_each_remote_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
@@ -396,7 +397,7 @@ int refs_for_each_remote_ref(struct ref_store *refs, each_ref_fn fn, void *cb_da
 
 int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_remote_ref(get_main_ref_store(), fn, cb_data);
+	return refs_for_each_remote_ref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
@@ -731,7 +732,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 	struct strbuf err = STRBUF_INIT;
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
-		assert(refs == get_main_ref_store());
+		assert(refs == get_main_ref_store(the_repository));
 		return delete_pseudoref(refname, old_oid);
 	}
 
@@ -753,7 +754,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 int delete_ref(const char *msg, const char *refname,
 	       const struct object_id *old_oid, unsigned int flags)
 {
-	return refs_delete_ref(get_main_ref_store(), msg, refname,
+	return refs_delete_ref(get_main_ref_store(the_repository), msg, refname,
 			       old_oid, flags);
 }
 
@@ -929,7 +930,7 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
-	return ref_store_transaction_begin(get_main_ref_store(), err);
+	return ref_store_transaction_begin(get_main_ref_store(the_repository), err);
 }
 
 void ref_transaction_free(struct ref_transaction *transaction)
@@ -1061,7 +1062,7 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 	int ret = 0;
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
-		assert(refs == get_main_ref_store());
+		assert(refs == get_main_ref_store(the_repository));
 		ret = write_pseudoref(refname, new_oid, old_oid, &err);
 	} else {
 		t = ref_store_transaction_begin(refs, &err);
@@ -1100,7 +1101,7 @@ int update_ref(const char *msg, const char *refname,
 	       const struct object_id *old_oid,
 	       unsigned int flags, enum action_on_err onerr)
 {
-	return refs_update_ref(get_main_ref_store(), msg, refname, new_oid,
+	return refs_update_ref(get_main_ref_store(the_repository), msg, refname, new_oid,
 			       old_oid, flags, onerr);
 }
 
@@ -1321,7 +1322,7 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 
 int head_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_head_ref(get_main_ref_store(), fn, cb_data);
+	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
 struct ref_iterator *refs_ref_iterator_begin(
@@ -1380,7 +1381,7 @@ int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref(get_main_ref_store(), fn, cb_data);
+	return refs_for_each_ref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
@@ -1391,7 +1392,7 @@ int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref_in(get_main_ref_store(), prefix, fn, cb_data);
+	return refs_for_each_ref_in(get_main_ref_store(the_repository), prefix, fn, cb_data);
 }
 
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
@@ -1400,7 +1401,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
 
 	if (broken)
 		flag = DO_FOR_EACH_INCLUDE_BROKEN;
-	return do_for_each_ref(get_main_ref_store(),
+	return do_for_each_ref(get_main_ref_store(the_repository),
 			       prefix, fn, 0, flag, cb_data);
 }
 
@@ -1417,7 +1418,7 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 
 int for_each_replace_ref_the_repository(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_main_ref_store(),
+	return do_for_each_ref(get_main_ref_store(the_repository),
 			       git_replace_ref_base, fn,
 			       strlen(git_replace_ref_base),
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
@@ -1428,7 +1429,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
-	ret = do_for_each_ref(get_main_ref_store(),
+	ret = do_for_each_ref(get_main_ref_store(the_repository),
 			      buf.buf, fn, 0, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
@@ -1442,7 +1443,7 @@ int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_rawref(get_main_ref_store(), fn, cb_data);
+	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
 int refs_read_raw_ref(struct ref_store *ref_store,
@@ -1548,7 +1549,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 /* backend functions */
 int refs_init_db(struct strbuf *err)
 {
-	struct ref_store *refs = get_main_ref_store();
+	struct ref_store *refs = get_main_ref_store(the_repository);
 
 	return refs->be->init_db(refs, err);
 }
@@ -1556,7 +1557,7 @@ int refs_init_db(struct strbuf *err)
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       struct object_id *oid, int *flags)
 {
-	return refs_resolve_ref_unsafe(get_main_ref_store(), refname,
+	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository), refname,
 				       resolve_flags, oid, flags);
 }
 
@@ -1652,7 +1653,7 @@ static struct ref_store *ref_store_init(const char *gitdir,
 	return refs;
 }
 
-struct ref_store *get_main_ref_store(void)
+struct ref_store *get_main_ref_store_the_repository(void)
 {
 	if (main_ref_store)
 		return main_ref_store;
@@ -1727,7 +1728,7 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 	const char *id;
 
 	if (wt->is_current)
-		return get_main_ref_store();
+		return get_main_ref_store(the_repository);
 
 	id = wt->id ? wt->id : "/";
 	refs = lookup_ref_store_map(&worktree_ref_stores, id);
@@ -1783,7 +1784,7 @@ int refs_peel_ref(struct ref_store *refs, const char *refname,
 
 int peel_ref(const char *refname, struct object_id *oid)
 {
-	return refs_peel_ref(get_main_ref_store(), refname, oid);
+	return refs_peel_ref(get_main_ref_store(the_repository), refname, oid);
 }
 
 int refs_create_symref(struct ref_store *refs,
@@ -1799,7 +1800,7 @@ int refs_create_symref(struct ref_store *refs,
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-	return refs_create_symref(get_main_ref_store(), ref_target,
+	return refs_create_symref(get_main_ref_store(the_repository), ref_target,
 				  refs_heads_master, logmsg);
 }
 
@@ -2007,7 +2008,7 @@ int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 
 int for_each_reflog(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_reflog(get_main_ref_store(), fn, cb_data);
+	return refs_for_each_reflog(get_main_ref_store(the_repository), fn, cb_data);
 }
 
 int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
@@ -2022,7 +2023,7 @@ int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
 				void *cb_data)
 {
-	return refs_for_each_reflog_ent_reverse(get_main_ref_store(),
+	return refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repository),
 						refname, fn, cb_data);
 }
 
@@ -2035,7 +2036,7 @@ int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn,
 			void *cb_data)
 {
-	return refs_for_each_reflog_ent(get_main_ref_store(), refname,
+	return refs_for_each_reflog_ent(get_main_ref_store(the_repository), refname,
 					fn, cb_data);
 }
 
@@ -2046,7 +2047,7 @@ int refs_reflog_exists(struct ref_store *refs, const char *refname)
 
 int reflog_exists(const char *refname)
 {
-	return refs_reflog_exists(get_main_ref_store(), refname);
+	return refs_reflog_exists(get_main_ref_store(the_repository), refname);
 }
 
 int refs_create_reflog(struct ref_store *refs, const char *refname,
@@ -2058,7 +2059,7 @@ int refs_create_reflog(struct ref_store *refs, const char *refname,
 int safe_create_reflog(const char *refname, int force_create,
 		       struct strbuf *err)
 {
-	return refs_create_reflog(get_main_ref_store(), refname,
+	return refs_create_reflog(get_main_ref_store(the_repository), refname,
 				  force_create, err);
 }
 
@@ -2069,7 +2070,7 @@ int refs_delete_reflog(struct ref_store *refs, const char *refname)
 
 int delete_reflog(const char *refname)
 {
-	return refs_delete_reflog(get_main_ref_store(), refname);
+	return refs_delete_reflog(get_main_ref_store(the_repository), refname);
 }
 
 int refs_reflog_expire(struct ref_store *refs,
@@ -2092,7 +2093,7 @@ int reflog_expire(const char *refname, const struct object_id *oid,
 		  reflog_expiry_cleanup_fn cleanup_fn,
 		  void *policy_cb_data)
 {
-	return refs_reflog_expire(get_main_ref_store(),
+	return refs_reflog_expire(get_main_ref_store(the_repository),
 				  refname, oid, flags,
 				  prepare_fn, should_prune_fn,
 				  cleanup_fn, policy_cb_data);
@@ -2115,7 +2116,7 @@ int refs_delete_refs(struct ref_store *refs, const char *msg,
 int delete_refs(const char *msg, struct string_list *refnames,
 		unsigned int flags)
 {
-	return refs_delete_refs(get_main_ref_store(), msg, refnames, flags);
+	return refs_delete_refs(get_main_ref_store(the_repository), msg, refnames, flags);
 }
 
 int refs_rename_ref(struct ref_store *refs, const char *oldref,
@@ -2126,7 +2127,7 @@ int refs_rename_ref(struct ref_store *refs, const char *oldref,
 
 int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 {
-	return refs_rename_ref(get_main_ref_store(), oldref, newref, logmsg);
+	return refs_rename_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
 }
 
 int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
@@ -2137,5 +2138,5 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 
 int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg)
 {
-	return refs_copy_existing_ref(get_main_ref_store(), oldref, newref, logmsg);
+	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
 }
diff --git a/refs.h b/refs.h
index 546fa9e65a..ab3d2bec2f 100644
--- a/refs.h
+++ b/refs.h
@@ -760,7 +760,9 @@ int reflog_expire(const char *refname, const struct object_id *oid,
 
 int ref_storage_backend_exists(const char *name);
 
-struct ref_store *get_main_ref_store(void);
+#define get_main_ref_store(r) \
+	get_main_ref_store_##r()
+struct ref_store *get_main_ref_store_the_repository(void);
 /*
  * Return the ref_store instance for the specified submodule. For the
  * main repository, use submodule==NULL; such a call cannot fail. For
diff --git a/revision.c b/revision.c
index 9ede92c09e..e98bdf2ac7 100644
--- a/revision.c
+++ b/revision.c
@@ -7,6 +7,7 @@
 #include "diff.h"
 #include "refs.h"
 #include "revision.h"
+#include "repository.h"
 #include "graph.h"
 #include "grep.h"
 #include "reflog-walk.h"
@@ -1280,7 +1281,7 @@ void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 
 	cb.all_revs = revs;
 	cb.all_flags = flags;
-	cb.refs = get_main_ref_store();
+	cb.refs = get_main_ref_store(the_repository);
 	for_each_reflog(handle_one_reflog, &cb);
 
 	if (!revs->single_worktree)
@@ -2168,7 +2169,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 			die("BUG: --single-worktree cannot be used together with submodule");
 		refs = get_submodule_ref_store(submodule);
 	} else
-		refs = get_main_ref_store();
+		refs = get_main_ref_store(the_repository);
 
 	/*
 	 * NOTE!
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 4b96dfe12f..93ea6f781e 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -2,6 +2,7 @@
 #include "alternates.h"
 #include "refs.h"
 #include "worktree.h"
+#include "repository.h"
 
 static const char *notnull(const char *arg, const char *name)
 {
@@ -22,7 +23,7 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 	if (!argv[0]) {
 		die("ref store required");
 	} else if (!strcmp(argv[0], "main")) {
-		*refs = get_main_ref_store();
+		*refs = get_main_ref_store(the_repository);
 	} else if (skip_prefix(argv[0], "submodule:", &gitdir)) {
 		struct strbuf sb = STRBUF_INIT;
 		int ret;
-- 
2.15.1.433.g936d1b9894.dirty

