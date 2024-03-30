Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A4E4E1D5
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838795; cv=none; b=rWAAN1s8Y6v3f8j+ul2ZuyiBsUjMEAicwij1VV1M2pBA0ELPxG7j3luYnqAIPcqiLq4augjiJwA0/TC7AutCVxo/ZZYIItGXn/rXGXj8MCZ/XvKUGH6CWdDNkIp0oeubmTBG6H0ve5jWCkv2dKFt7NkHyvSXONNCBhdv9On1LrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838795; c=relaxed/simple;
	bh=Tws7TOSnZBWgkZ/eo81LbUggM1WVsWpzpqgrqB/rEbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtpcDCIdzF0+mizv17rDNV9uvPK8JMChNSnabGmHxhu2+eCxZCvl6Fm7SqKcS4R+TWpj/b7LvmQTQet8+2XsSPl9/6WVDcv6RmnXV4zG4STqOMghgL+BWruU10uHTGPFNSrkMIJLzCYk6QdrFJL4M+2hZTA4UoQj1QYsrqeMHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0fYMZvT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0fYMZvT"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4e38f941c6so188260466b.2
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711838791; x=1712443591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enREyFM6NlyvigxTvwLNTRHQeKZUYTTd/s2po/Qtlr4=;
        b=K0fYMZvTREuDa/mQ+bi8JpiyzwMhoQkOzPuNwu8KuFqZL3e+TstpfcjzRK4RalrENC
         mjSBJA+bmjA0Ef+ikmhpdUxV63RLCWN+lG6kyjHGs0M6rH9zO2ICRm5tEm1p/v8oNekV
         eFbMWw9MdyK9SY0fsKBcMpQY36GzNKe9a78iHk9qIq5+stOO8fbuCQHpnc/HaHRcVDxD
         wYpIQUE+RqgSPdKoKC65yy6zQeEA0f3fPgW4Fc+hCfRIDJZoeEZNqjmunznJ0u2c/4i7
         iu0wqfEsyiK6TR828lrEp5rfp/oF4oBRBa0huP6w/WUeaG0FvgTYubJrtlCImC6xZw3T
         8X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711838791; x=1712443591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enREyFM6NlyvigxTvwLNTRHQeKZUYTTd/s2po/Qtlr4=;
        b=Xr5f483sHLXDfla90BLd72JC+kIoAm36Q54GnTOQyEq5OtrMfYFem9egXjE7hZepsP
         vzKWjQeO1f1Wfl+9bNQ1T3t4mSyYv9d42rnNjfnQGptXy2Kirlm5qG1lti1CmhSZwpTL
         EaryaF8acov3c3bYFiMLLG4QjbW6qZktXDz2gjwmBZJRDBuGuBS9rxD9nIhcdNvUEpak
         tf7EX9qF5KLR1FyN2FQe8N7hy2BIlCCrLYkTfZjLwgp/dyC2y4r/mXYv++gd78l5AT4A
         c+2D5vtGZIA+rt9BDNKcz4fyPWzrJ5mWkISSrxMAiJbSTLIiU10C1U/J7L4IUokxA/rA
         dBbg==
X-Gm-Message-State: AOJu0YzFuell8vF753AAe+tRd0+XPfx/+Qx0qGKJnAVVxvsrNWsZ04SF
	F3fU9FUNAwzhfgYvkLJ1v+vO2ONWY3IfytR7F2P0c4CBQ1a0A2kzCKXH0pkO2YE=
X-Google-Smtp-Source: AGHT+IFNeZZZUY3UiImvZoH1QATci+Ndu/woxcmaBtXpSlY3TCH8g9KU9Bciq5KgRf6HoJW7yURl7A==
X-Received: by 2002:a17:906:eec3:b0:a4e:1036:7da5 with SMTP id wu3-20020a170906eec300b00a4e10367da5mr3988704ejb.70.1711838790806;
        Sat, 30 Mar 2024 15:46:30 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:9f01:e67d:4cf3:c3bc])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090637d300b00a46cc48ab07sm3533580ejc.221.2024.03.30.15.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 15:46:30 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 4/8] refs: accept symref in `ref_transaction_add_update`
Date: Sat, 30 Mar 2024 23:46:19 +0100
Message-ID: <20240330224623.579457-5-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330224623.579457-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The `ref_transaction_add_update` function obtains ref information and
flags to create a `ref_update` and add it to the transaction at hand.

To extend symref support in transactions, we need to also accept the
symref and process it. While we handle the processing in upcoming
commits. In this commit, let's add the paramater to the function.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 branch.c                |  2 +-
 builtin/fast-import.c   |  6 +++---
 builtin/fetch.c         |  2 +-
 builtin/receive-pack.c  |  2 +-
 builtin/replace.c       |  2 +-
 builtin/tag.c           |  2 +-
 builtin/update-ref.c    |  2 +-
 refs.c                  | 16 ++++++++--------
 refs.h                  |  9 +++++++--
 refs/files-backend.c    | 14 +++++++-------
 refs/refs-internal.h    | 12 +++++++++---
 refs/reftable-backend.c |  4 ++--
 sequencer.c             |  6 +++---
 walker.c                |  2 +-
 14 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/branch.c b/branch.c
index 621019fcf4..266dcb6a89 100644
--- a/branch.c
+++ b/branch.c
@@ -627,7 +627,7 @@ void create_branch(struct repository *r,
 	if (!transaction ||
 		ref_transaction_update(transaction, ref.buf,
 					&oid, forcing ? NULL : null_oid(),
-					0, msg, &err) ||
+					0, msg, NULL, &err) ||
 		ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 71a195ca22..96c3fd5a30 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1648,7 +1648,7 @@ static int update_branch(struct branch *b)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, &b->oid, &old_oid,
-				   0, msg, &err) ||
+				   0, msg, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
@@ -1688,8 +1688,8 @@ static void dump_tags(void)
 		strbuf_reset(&ref_name);
 		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
 
-		if (ref_transaction_update(transaction, ref_name.buf,
-					   &t->oid, NULL, 0, msg, &err)) {
+		if (ref_transaction_update(transaction, ref_name.buf, &t->oid,
+					   NULL, 0, msg, NULL, &err)) {
 			failure |= error("%s", err.buf);
 			goto cleanup;
 		}
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 46a793411a..5a8a58b6fa 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -667,7 +667,7 @@ static int s_update_ref(const char *action,
 
 	ret = ref_transaction_update(transaction, ref->name, &ref->new_oid,
 				     check_old ? &ref->old_oid : NULL,
-				     0, msg, &err);
+				     0, msg, NULL, &err);
 	if (ret) {
 		ret = STORE_REF_ERROR_OTHER;
 		goto out;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 56d8a77ed7..5318bc4b58 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1596,7 +1596,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 					   namespaced_name,
 					   new_oid, old_oid,
 					   0, "push",
-					   &err)) {
+					   NULL, &err)) {
 			rp_error("%s", err.buf);
 			ret = "failed to update ref";
 		} else {
diff --git a/builtin/replace.c b/builtin/replace.c
index da59600ad2..b3281758d0 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -201,7 +201,7 @@ static int replace_object_oid(const char *object_ref,
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, repl, &prev,
-				   0, NULL, &err) ||
+				   0, NULL, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		res = error("%s", err.buf);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 19a7e06bf4..8de32535de 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -624,7 +624,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, &object, &prev,
 				   create_reflog ? REF_FORCE_CREATE_REFLOG : 0,
-				   reflog_msg.buf, &err) ||
+				   reflog_msg.buf, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		if (path)
 			fprintf(stderr,
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 61338a01ec..3807cf4106 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -205,7 +205,7 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 	if (ref_transaction_update(transaction, refname,
 				   &new_oid, have_old ? &old_oid : NULL,
 				   update_flags | create_reflog_flag,
-				   msg, &err))
+				   msg, NULL, &err))
 		die("%s", err.buf);
 
 	update_flags = default_flags;
diff --git a/refs.c b/refs.c
index 55d2e0b2cb..69b89a1aa2 100644
--- a/refs.c
+++ b/refs.c
@@ -1228,7 +1228,7 @@ struct ref_update *ref_transaction_add_update(
 		const char *refname, unsigned int flags,
 		const struct object_id *new_oid,
 		const struct object_id *old_oid,
-		const char *msg)
+		const char *msg, const char *symref)
 {
 	struct ref_update *update;
 
@@ -1254,7 +1254,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const struct object_id *new_oid,
 			   const struct object_id *old_oid,
 			   unsigned int flags, const char *msg,
-			   struct strbuf *err)
+			   const char *symref, struct strbuf *err)
 {
 	assert(err);
 
@@ -1280,7 +1280,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
 
 	ref_transaction_add_update(transaction, refname, flags,
-				   new_oid, old_oid, msg);
+				   new_oid, old_oid, msg, symref);
 	return 0;
 }
 
@@ -1295,7 +1295,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 		return 1;
 	}
 	return ref_transaction_update(transaction, refname, new_oid,
-				      null_oid(), flags, msg, err);
+				      null_oid(), flags, msg, NULL, err);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
@@ -1308,7 +1308,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 		BUG("delete called with old_oid set to zeros");
 	return ref_transaction_update(transaction, refname,
 				      null_oid(), old_oid,
-				      flags, msg, err);
+				      flags, msg, NULL, err);
 }
 
 int ref_transaction_verify(struct ref_transaction *transaction,
@@ -1320,8 +1320,8 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 	if (!old_oid)
 		BUG("verify called with old_oid set to NULL");
 	return ref_transaction_update(transaction, refname,
-				      NULL, old_oid,
-				      flags, NULL, err);
+				      NULL, old_oid, flags,
+				      NULL, NULL, err);
 }
 
 int refs_update_ref(struct ref_store *refs, const char *msg,
@@ -1336,7 +1336,7 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 	t = ref_store_transaction_begin(refs, &err);
 	if (!t ||
 	    ref_transaction_update(t, refname, new_oid, old_oid, flags, msg,
-				   &err) ||
+				   NULL, &err) ||
 	    ref_transaction_commit(t, &err)) {
 		ret = 1;
 		ref_transaction_free(t);
diff --git a/refs.h b/refs.h
index 298caf6c61..073653d1a4 100644
--- a/refs.h
+++ b/refs.h
@@ -694,13 +694,18 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  */
 #define REF_SKIP_REFNAME_VERIFICATION (1 << 11)
 
+/*
+ * Used to denote a symbolic reference update.
+ */
+#define REF_UPDATE_SYMREF (1 << 12)
+
 /*
  * Bitmask of all of the flags that are allowed to be passed in to
  * ref_transaction_update() and friends:
  */
 #define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS                                  \
 	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION | \
-	 REF_SKIP_REFNAME_VERIFICATION)
+	 REF_SKIP_REFNAME_VERIFICATION | REF_UPDATE_SYMREF)
 
 /*
  * Add a reference update to transaction. `new_oid` is the value that
@@ -721,7 +726,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const struct object_id *new_oid,
 			   const struct object_id *old_oid,
 			   unsigned int flags, const char *msg,
-			   struct strbuf *err);
+			   const char *symref, struct strbuf *err);
 
 /*
  * Add a reference creation to transaction. new_oid is the value that
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3f0f9521cb..4dbe73c106 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1198,7 +1198,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	ref_transaction_add_update(
 			transaction, r->name,
 			REF_NO_DEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_IS_PRUNING,
-			null_oid(), &r->oid, NULL);
+			null_oid(), &r->oid, NULL, NULL);
 	if (ref_transaction_commit(transaction, &err))
 		goto cleanup;
 
@@ -1292,8 +1292,8 @@ static int files_pack_refs(struct ref_store *ref_store,
 		 * packed-refs transaction:
 		 */
 		if (ref_transaction_update(transaction, iter->refname,
-					   iter->oid, NULL,
-					   REF_NO_DEREF, NULL, &err))
+					   iter->oid, NULL, REF_NO_DEREF,
+					   NULL, NULL, &err))
 			die("failure preparing to create packed reference %s: %s",
 			    iter->refname, err.buf);
 
@@ -2323,7 +2323,7 @@ static int split_head_update(struct ref_update *update,
 			transaction, "HEAD",
 			update->flags | REF_LOG_ONLY | REF_NO_DEREF,
 			&update->new_oid, &update->old_oid,
-			update->msg);
+			update->msg, NULL);
 
 	/*
 	 * Add "HEAD". This insertion is O(N) in the transaction
@@ -2386,7 +2386,7 @@ static int split_symref_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
 			&update->new_oid, &update->old_oid,
-			update->msg);
+			update->msg, NULL);
 
 	new_update->parent_update = update;
 
@@ -2777,7 +2777,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 					packed_transaction, update->refname,
 					REF_HAVE_NEW | REF_NO_DEREF,
 					&update->new_oid, NULL,
-					NULL);
+					NULL, NULL);
 		}
 	}
 
@@ -3062,7 +3062,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		ref_transaction_add_update(packed_transaction, update->refname,
 					   update->flags & ~REF_HAVE_OLD,
 					   &update->new_oid, &update->old_oid,
-					   NULL);
+					   NULL, NULL);
 	}
 
 	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 56641aa57a..3fccf784d4 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -134,6 +134,12 @@ struct ref_update {
 	unsigned int type;
 	char *msg;
 
+	/*
+	 * If (flags & REF_UPDATE_SYMREF), we update the reference to be a
+	 * symbolic reference and the value is taken from this field.
+	 */
+	char *symref_target;
+
 	/*
 	 * If this ref_update was split off of a symref update via
 	 * split_symref_update(), then this member points at that
@@ -164,8 +170,8 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify
- * that refname is well-formed. new_oid and old_oid are only
- * dereferenced if the REF_HAVE_NEW and REF_HAVE_OLD bits,
+ * that refname is well-formed. new_oid, old_oid, symref are only
+ * dereferenced if the REF_HAVE_NEW, REF_HAVE_OLD and REF_UPDATE_SYMREF bits,
  * respectively, are set in flags.
  */
 struct ref_update *ref_transaction_add_update(
@@ -173,7 +179,7 @@ struct ref_update *ref_transaction_add_update(
 		const char *refname, unsigned int flags,
 		const struct object_id *new_oid,
 		const struct object_id *old_oid,
-		const char *msg);
+		const char *msg, const char *symref);
 
 /*
  * Transaction states.
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 9b53d42541..92f2803e90 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -884,7 +884,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			new_update = ref_transaction_add_update(
 					transaction, "HEAD",
 					u->flags | REF_LOG_ONLY | REF_NO_DEREF,
-					&u->new_oid, &u->old_oid, u->msg);
+					&u->new_oid, &u->old_oid, u->msg, NULL);
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
 
@@ -963,7 +963,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				 */
 				new_update = ref_transaction_add_update(
 						transaction, referent.buf, new_flags,
-						&u->new_oid, &u->old_oid, u->msg);
+						&u->new_oid, &u->old_oid, u->msg, NULL);
 				new_update->parent_update = u;
 
 				/*
diff --git a/sequencer.c b/sequencer.c
index 4e14fa6541..668ea683ee 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -614,7 +614,7 @@ static int fast_forward_to(struct repository *r,
 	    ref_transaction_update(transaction, "HEAD",
 				   to, unborn && !is_rebase_i(opts) ?
 				   null_oid() : from,
-				   0, sb.buf, &err) ||
+				   0, sb.buf, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
@@ -1232,7 +1232,7 @@ int update_head_with_reflog(const struct commit *old_head,
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", new_head,
 				   old_head ? &old_head->object.oid : null_oid(),
-				   0, sb.buf, err) ||
+				   0, sb.buf, NULL, err) ||
 	    ref_transaction_commit(transaction, err)) {
 		ret = -1;
 	}
@@ -3750,7 +3750,7 @@ static int do_label(struct repository *r, const char *name, int len)
 		error(_("could not read HEAD"));
 		ret = -1;
 	} else if (ref_transaction_update(transaction, ref_name.buf, &head_oid,
-					  NULL, 0, msg.buf, &err) < 0 ||
+					  NULL, 0, msg.buf, NULL, &err) < 0 ||
 		   ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		ret = -1;
diff --git a/walker.c b/walker.c
index 65002a7220..33eef703ce 100644
--- a/walker.c
+++ b/walker.c
@@ -326,7 +326,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		if (ref_transaction_update(transaction, refname.buf,
 					   oids + i, NULL, 0,
 					   msg ? msg : "fetch (unknown)",
-					   &err)) {
+					   NULL, &err)) {
 			error("%s", err.buf);
 			goto done;
 		}
-- 
2.43.GIT

