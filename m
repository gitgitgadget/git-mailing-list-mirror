Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE0175D4F
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009005; cv=none; b=mfH5Q6NkjB94HTS+sYdsHbPMPv0dYerqA8Xm1/iURSqwjYiBt/YV5iL90bmHASFinJOmdL3oJmc72GzjWr+8IUNWnB2DYY0fCxwm7MGo+0I7KOjO08PFQVS2vVxZ5N2mKrQTBxSad9vT4uK8rx+1goPV6cgiIFuTLob1W0GU6tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009005; c=relaxed/simple;
	bh=U9J5P0oCJzY32aGIm9ibRn0px/mBMJPwQUTois44z6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIas3GUwomyxZizQGIZ60Eggy2Cuec9VfxFrwvybwE1hX7NQ7b79jA/ZV4kUD+yTj54AXhfPixA4+sniR3M0uyKgZTwwjdcc+WD4gim14DphOLyKRLQcA33J8Ot21efk5tx8/oZWe7rSr9nSGz/TiGSsgebhNv3r0gk9deGsTQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZLHZ3dGx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iUvMm/bS; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZLHZ3dGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iUvMm/bS"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 208CA1380277;
	Fri, 30 Aug 2024 05:10:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 30 Aug 2024 05:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725009003; x=1725095403; bh=5yq6q6JNiw
	d4+YshgH/avjb7HWZjW0RZYeknNET2kqE=; b=ZLHZ3dGxc9UmBK8JP7pLvq5tMp
	4l1WziSoe/V+3TrvFBYHKLLej3/25qkcZZoIegosFwe/8EjK9zCpTmkCxFdro4yU
	LgI9gWRPDdL6LGaB6WpX41Kce6RxKdyUSKh+uex+TcbWeOuokykiid2Va/y1eldU
	g/dxsjvGNHtmQo6e2PcTb0gQXvOml/DFAy060lSIKA1EBnSsVBVymJ7S+BgRzTr0
	gyRV+inoqDEhxw5Y3U47wtgFqv20SDsgfQZ7jrU3jjKf18Z+whb/FY+pM+V75iKo
	bSuCS6IWOZ6brjUBdrpLXlB0ewIm6w0KfJ/zU78OSo2xRuH8J2/Se+Va9Fhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725009003; x=1725095403; bh=5yq6q6JNiwd4+YshgH/avjb7HWZj
	W0RZYeknNET2kqE=; b=iUvMm/bSO4m4gBu67tYSemLOneOKf1HelUTyR/1oNwZD
	yMcEDcDAtGBlIVVE8f1dP+Qt67zksIbR8FIqCtDWUOUTB08o7y9Hp7pJs6aZJXj0
	X/Vjg8k1l1YLZ+yGyJX4DDYm05e64PC9nHK+frOVGEomgMucaXUO4GJrjV6pcaDi
	/NxVVzat98rBvCttOta6hJyAjtT8mjordK3yBgahyXzrE8vvt67MY+CuWCYr8Mqh
	bJHT6hmI7mL6kUCBSh7Do10ZMwZGqN1Tj8i8z7fpmqhPJUoDDmOsQ5jXABNHNlRv
	LOfc65U4Hk2sQq7eB6SYyi58mzFJ0nSEuinyj7DhHg==
X-ME-Sender: <xms:aozRZhQrIPvc8jhXsdDaZwydVm9fLajmTflUmo6-H3KUGY6-UU1Oog>
    <xme:aozRZqxrzClkIxnUmV7m4Wepp9jhB7TyaVt37ttsnswu02WDmLGZiGFbXPBkJuS_q
    7mHudmqliodtqDLJQ>
X-ME-Received: <xmr:aozRZm24ttany2bXREQ9-N9G_y7JWeKP-HjNjHQ9hnIbLcHZrnI1zuIMZ2sdcyIwodrBXu5P0ZPUpdb7_YHfDQQrldFqROYb-3XdCaiGhf4Se6yw8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:a4zRZpDg3WS26011XyDRsXzAVV_JRn2p2_BD7GOraqLKcqCVQc26uw>
    <xmx:a4zRZqjBPWvPb1IZPUbjU_nVfeOMEi8f7uuCSAg-qq2b70hs4nJZdw>
    <xmx:a4zRZtoAD93ztR_aVCZSKJ5mA8z8lI6qlggHSuhFXx4_Xi9nkLdCUQ>
    <xmx:a4zRZljKvOE7oMO_rxQCh5R4szqWgbJLnRQnFKgxJ1JZQmvXScA07w>
    <xmx:a4zRZidMrJY7etFLZu7VBqenIxDH9lqUIpSP_d_mTXfLrWGOiR0Ge76i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:10:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bc156321 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:51 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:10:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 21/21] environment: stop storing "core.notesRef" globally
Message-ID: <a0b75c4bc99c83748d793d311764535fc193a470.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725008897.git.ps@pks.im>

Stop storing the "core.notesRef" config value globally. Instead,
retrieve the value in `default_notes_ref()`. The code is never called in
a hot loop anyway, so doing this on every invocation should be perfectly
fine.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/notes.c | 22 ++++++++++++++--------
 config.c        |  8 --------
 environment.c   |  1 -
 environment.h   |  2 --
 notes.c         | 21 +++++++++++++--------
 notes.h         |  3 ++-
 6 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 04f9dfb7fbd..5d594a07240 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -897,6 +897,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 			      1, PARSE_OPT_NONEG),
 		OPT_END()
 	};
+	char *notes_ref;
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_notes_merge_usage, 0);
@@ -924,7 +925,8 @@ static int merge(int argc, const char **argv, const char *prefix)
 	if (do_commit)
 		return merge_commit(&o);
 
-	o.local_ref = default_notes_ref();
+	notes_ref = default_notes_ref(the_repository);
+	o.local_ref = notes_ref;
 	strbuf_addstr(&remote_ref, argv[0]);
 	expand_loose_notes_ref(&remote_ref);
 	o.remote_ref = remote_ref.buf;
@@ -953,7 +955,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 	}
 
 	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
-		    remote_ref.buf, default_notes_ref());
+		    remote_ref.buf, notes_ref);
 	strbuf_add(&(o.commit_msg), msg.buf + 7, msg.len - 7); /* skip "notes: " */
 
 	result = notes_merge(&o, t, &result_oid);
@@ -961,7 +963,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 	if (result >= 0) /* Merge resulted (trivially) in result_oid */
 		/* Update default notes ref with new commit */
 		refs_update_ref(get_main_ref_store(the_repository), msg.buf,
-				default_notes_ref(), &result_oid, NULL, 0,
+				notes_ref, &result_oid, NULL, 0,
 				UPDATE_REFS_DIE_ON_ERR);
 	else { /* Merge has unresolved conflicts */
 		struct worktree **worktrees;
@@ -973,14 +975,14 @@ static int merge(int argc, const char **argv, const char *prefix)
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
 		worktrees = get_worktrees();
 		wt = find_shared_symref(worktrees, "NOTES_MERGE_REF",
-					default_notes_ref());
+					notes_ref);
 		if (wt)
 			die(_("a notes merge into %s is already in-progress at %s"),
-			    default_notes_ref(), wt->path);
+			    notes_ref, wt->path);
 		free_worktrees(worktrees);
-		if (refs_update_symref(get_main_ref_store(the_repository), "NOTES_MERGE_REF", default_notes_ref(), NULL))
+		if (refs_update_symref(get_main_ref_store(the_repository), "NOTES_MERGE_REF", notes_ref, NULL))
 			die(_("failed to store link to current notes ref (%s)"),
-			    default_notes_ref());
+			    notes_ref);
 		fprintf(stderr, _("Automatic notes merge failed. Fix conflicts in %s "
 				  "and commit the result with 'git notes merge --commit', "
 				  "or abort the merge with 'git notes merge --abort'.\n"),
@@ -988,6 +990,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 	}
 
 	free_notes(t);
+	free(notes_ref);
 	strbuf_release(&remote_ref);
 	strbuf_release(&msg);
 	return result < 0; /* return non-zero on conflicts */
@@ -1084,6 +1087,7 @@ static int prune(int argc, const char **argv, const char *prefix)
 static int get_ref(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = { OPT_END() };
+	char *notes_ref;
 	argc = parse_options(argc, argv, prefix, options,
 			     git_notes_get_ref_usage, 0);
 
@@ -1092,7 +1096,9 @@ static int get_ref(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_get_ref_usage, options);
 	}
 
-	puts(default_notes_ref());
+	notes_ref = default_notes_ref(the_repository);
+	puts(notes_ref);
+	free(notes_ref);
 	return 0;
 }
 
diff --git a/config.c b/config.c
index 53c68f3da61..1266eab0860 100644
--- a/config.c
+++ b/config.c
@@ -1555,14 +1555,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return git_config_string(&check_roundtrip_encoding, var, value);
 	}
 
-	if (!strcmp(var, "core.notesref")) {
-		if (!value)
-			return config_error_nonbool(var);
-		free(notes_ref_name);
-		notes_ref_name = xstrdup(value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.editor")) {
 		FREE_AND_NULL(editor_program);
 		return git_config_string(&editor_program, var, value);
diff --git a/environment.c b/environment.c
index 9dd000cda36..a2ce9980818 100644
--- a/environment.c
+++ b/environment.c
@@ -67,7 +67,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
-char *notes_ref_name;
 int grafts_keep_true_parents;
 int core_apply_sparse_checkout;
 int core_sparse_checkout_cone;
diff --git a/environment.h b/environment.h
index aa38133da9c..923e12661e1 100644
--- a/environment.h
+++ b/environment.h
@@ -203,8 +203,6 @@ enum object_creation_mode {
 };
 extern enum object_creation_mode object_creation_mode;
 
-extern char *notes_ref_name;
-
 extern int grafts_keep_true_parents;
 
 extern int repository_format_precious_objects;
diff --git a/notes.c b/notes.c
index da42df282d5..f4f18daf07e 100644
--- a/notes.c
+++ b/notes.c
@@ -992,15 +992,16 @@ static int notes_display_config(const char *k, const char *v,
 	return 0;
 }
 
-const char *default_notes_ref(void)
+char *default_notes_ref(struct repository *repo)
 {
-	const char *notes_ref = NULL;
+	char *notes_ref = NULL;
+
 	if (!notes_ref)
-		notes_ref = getenv(GIT_NOTES_REF_ENVIRONMENT);
+		notes_ref = xstrdup_or_null(getenv(GIT_NOTES_REF_ENVIRONMENT));
 	if (!notes_ref)
-		notes_ref = notes_ref_name; /* value of core.notesRef config */
+		repo_config_get_string(repo, "core.notesref", &notes_ref);
 	if (!notes_ref)
-		notes_ref = GIT_NOTES_DEFAULT_REF;
+		notes_ref = xstrdup(GIT_NOTES_DEFAULT_REF);
 	return notes_ref;
 }
 
@@ -1010,13 +1011,14 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	struct object_id oid, object_oid;
 	unsigned short mode;
 	struct leaf_node root_tree;
+	char *to_free = NULL;
 
 	if (!t)
 		t = &default_notes_tree;
 	assert(!t->initialized);
 
 	if (!notes_ref)
-		notes_ref = default_notes_ref();
+		notes_ref = to_free = default_notes_ref(the_repository);
 	update_ref_namespace(NAMESPACE_NOTES, xstrdup(notes_ref));
 
 	if (!combine_notes)
@@ -1033,7 +1035,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 
 	if (flags & NOTES_INIT_EMPTY ||
 	    repo_get_oid_treeish(the_repository, notes_ref, &object_oid))
-		return;
+		goto out;
 	if (flags & NOTES_INIT_WRITABLE && refs_read_ref(get_main_ref_store(the_repository), notes_ref, &object_oid))
 		die("Cannot use notes ref %s", notes_ref);
 	if (get_tree_entry(the_repository, &object_oid, "", &oid, &mode))
@@ -1043,6 +1045,9 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	oidclr(&root_tree.key_oid, the_repository->hash_algo);
 	oidcpy(&root_tree.val_oid, &oid);
 	load_subtree(t, &root_tree, t->root, 0);
+
+out:
+	free(to_free);
 }
 
 struct notes_tree **load_notes_trees(struct string_list *refs, int flags)
@@ -1105,7 +1110,7 @@ void load_display_notes(struct display_notes_opt *opt)
 
 	if (!opt || opt->use_default_notes > 0 ||
 	    (opt->use_default_notes == -1 && !opt->extra_notes_refs.nr)) {
-		string_list_append(&display_notes_refs, default_notes_ref());
+		string_list_append_nodup(&display_notes_refs, default_notes_ref(the_repository));
 		display_ref_env = getenv(GIT_NOTES_DISPLAY_REF_ENVIRONMENT);
 		if (display_ref_env) {
 			string_list_add_refs_from_colon_sep(&display_notes_refs,
diff --git a/notes.h b/notes.h
index 235216944bc..6dc6d7b2654 100644
--- a/notes.h
+++ b/notes.h
@@ -4,6 +4,7 @@
 #include "string-list.h"
 
 struct object_id;
+struct repository;
 struct strbuf;
 
 /*
@@ -70,7 +71,7 @@ extern struct notes_tree {
  * 3. The value of the core.notesRef config variable, if set
  * 4. GIT_NOTES_DEFAULT_REF (i.e. "refs/notes/commits")
  */
-const char *default_notes_ref(void);
+char *default_notes_ref(struct repository *repo);
 
 /*
  * Flags controlling behaviour of notes tree initialization
-- 
2.46.0.421.g159f2d50e7.dirty

