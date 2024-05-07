Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340BB7A715
	for <git@vger.kernel.org>; Tue,  7 May 2024 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065925; cv=none; b=ua4fHZyNS8CGcO9ApHaDPmoeYZzKzAWjCSb9reIo8Tb0bLP1GDh/QYuwDoSb9g32v716xl15lx0GbIM07fr3GiCdXYGN4+1ErGoVSiyxWhbAgBQaK9q6xf2EsDR0mwIxF25Tu1WWS/EDGrQibkq994dCxRPbvJlfdETkpyJTbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065925; c=relaxed/simple;
	bh=SxxzSw4oqeJQJH/ziPsStIAuzHDqebZi+kNS2mxSwaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krXJ+mlj02Pnd2nWd4AQZb0qWrmBoz00FpvyUNnxmVbU8e0B8LHvFtpZlSOiN5MLgyV/319wUWV7tBci0JLjHbFZ9axUoGYzWX2diBfI+LbVUXKSP13/D4L50v9j5rCLhM6kBE3hcaLIVkrTVqXLKJqM4YqnkIG+mUyAM9qwB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K1Vj+vrH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSAgmXaF; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K1Vj+vrH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSAgmXaF"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 0262E1C0012C;
	Tue,  7 May 2024 03:11:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 May 2024 03:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715065917; x=1715152317; bh=to3If3lai9
	9NotsqWpUw2Og8JB5P9fUWRBmYg+QlltA=; b=K1Vj+vrHJ7MirvRIAL/W9Q6aTr
	NIDbya5Jb2rOaN07XSVXlQLq4UtrkcIRV8QFCQcXRSfnaPdM7WKFTqXa0CXARYd9
	9+mzyM/XkQr8nUK/H/T+OBPCuZ6Hn16Kx47FCba/9OuNsGTwXT7+ASo3ST3oTYB+
	u4F8mnbMhpIiLmzbLV1VpcMD8DYvLWOk9qPA95j2UhPxqwu87myN+LE4JRd1E1q7
	HGVpWeufVpPuxiS/DrONjtVfE7u7W4Lctm/bxUY3OUJauRmEWAc8oxQt9RUk1bqQ
	4chDWtpR8KozE1409OE7QQobQBWbITSHcN5IvbXk93g7onYLPObLoAfUDe6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715065917; x=1715152317; bh=to3If3lai99NotsqWpUw2Og8JB5P
	9fUWRBmYg+QlltA=; b=CSAgmXaFC/zlXhVVLseNrnhKVJ4fL9cP6XZxmDr3pIDr
	vxsgdsYF8n9WnL2hYogmeLt1NeZ/atQzTBVXaDEv2IKPFzhQg/Pu6izBArruRder
	eoXeB8UgYBCin4QAPdf5p5VPGmZnYJbK9OIDnxJY4ooyx+tD+HRtz9eAJQGhbcoR
	ZBvYtCp+D7CsX5oupC25oFUCfGwVf9AkAUVg2yfBwggT0HXPWTST+m20MxbGV4v9
	Ili7W8GCVjPLYZN5Uf9rnDw/N2xmjEazeEhncb/s5aSUaT/Vyt23Hm7JSMxGNEcW
	FDlO9XQnAKnEknzIDrJN4e40TcpI8PAkKGoIoybxcg==
X-ME-Sender: <xms:PdQ5Zh7tEWt6kL8z8bT5mkWIADRt2MlPKJiKuKwJs-_z0BDKA-IdJA>
    <xme:PdQ5Zu4FSZV7yC2mcrN37eyXY1DOfNlMYLRO3TqLvX7aAZxP6DGjvh9H6MP6L7AG4
    HlUQvEWyMPmQZ1qEg>
X-ME-Received: <xmr:PdQ5ZoeyM_5-UrbdWyL_HtoJVQmySq_BlABwgUqmsbJFcyevuLhORmC6Pg3nveYsZQDBZBQo02q4NhjFE3qK5n6EmN87Dz8X_Ev0FB9YBV0mL5PhLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:PdQ5ZqK5v5moCT4A_1yxPRlHFSzHYHXpCsQpQhwE6RMhNB1CYb_nSw>
    <xmx:PdQ5ZlJaBZGlUBFx3cmDH5NComZEMMybMnFK07Tz_huRCGFWoAkNeg>
    <xmx:PdQ5Zjy9625KKJRBEPjym8jQNMhAX95WxxkhGVv3bTyfnKgHfuDg7A>
    <xmx:PdQ5ZhIMUfSBQ6CV-jFmT7od7P2NV5QTG99bWTJ52zBJTLaj3uu2jA>
    <xmx:PdQ5ZiFLfRZF3K0NYiOFQAz9IUPLcUjP73XBfDzmg5b47a5Bh__HV77a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 03:11:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 58fb0b2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 07:11:48 +0000 (UTC)
Date: Tue, 7 May 2024 09:11:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, James Liu <james@jamesliu.io>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 4/5] cocci: apply rules to rewrite callers of "refs"
 interfaces
Message-ID: <5109468b356637b8b4521a3e96ba228622804ca0.1715065736.git.ps@pks.im>
References: <cover.1714717057.git.ps@pks.im>
 <cover.1715065736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G/JN29aAunD/EJ1X"
Content-Disposition: inline
In-Reply-To: <cover.1715065736.git.ps@pks.im>


--G/JN29aAunD/EJ1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Apply the rules that rewrite callers of "refs" interfaces to explicitly
pass `struct ref_store`. The resulting patch has been applied with the
`--whitespace=3Dfix` option.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-interactive.c           | 17 +++++++----
 bisect.c                    | 25 ++++++++++-----
 blame.c                     |  4 +--
 branch.c                    |  5 +--
 builtin/am.c                | 38 ++++++++++++++---------
 builtin/bisect.c            | 44 +++++++++++++++-----------
 builtin/blame.c             |  4 +--
 builtin/branch.c            | 49 ++++++++++++++++-------------
 builtin/checkout.c          | 35 +++++++++++++--------
 builtin/clone.c             | 36 +++++++++++++---------
 builtin/describe.c          |  3 +-
 builtin/fast-import.c       | 11 ++++---
 builtin/fetch.c             | 20 ++++++++----
 builtin/fsck.c              | 11 +++++--
 builtin/gc.c                |  3 +-
 builtin/log.c               |  6 ++--
 builtin/merge.c             | 34 +++++++++++++--------
 builtin/name-rev.c          |  5 +--
 builtin/notes.c             | 26 +++++++++-------
 builtin/pack-objects.c      | 10 ++++--
 builtin/pull.c              |  2 +-
 builtin/rebase.c            | 18 ++++++-----
 builtin/receive-pack.c      | 15 ++++++---
 builtin/reflog.c            | 25 ++++++++-------
 builtin/remote.c            | 37 +++++++++++++---------
 builtin/repack.c            |  7 +++--
 builtin/replace.c           |  9 +++---
 builtin/reset.c             | 13 +++++---
 builtin/rev-parse.c         | 25 ++++++++++-----
 builtin/show-branch.c       | 22 ++++++++-----
 builtin/show-ref.c          | 19 ++++++++----
 builtin/stash.c             | 23 ++++++++------
 builtin/submodule--helper.c |  7 +++--
 builtin/symbolic-ref.c      | 13 +++++---
 builtin/tag.c               | 11 ++++---
 builtin/update-index.c      |  2 +-
 builtin/update-ref.c        | 21 ++++++++-----
 builtin/worktree.c          | 19 +++++++-----
 bundle-uri.c                | 12 +++++---
 bundle.c                    |  2 +-
 commit-graph.c              |  3 +-
 commit.c                    |  3 +-
 config.c                    |  3 +-
 delta-islands.c             |  3 +-
 fetch-pack.c                |  6 ++--
 fmt-merge-msg.c             |  4 ++-
 help.c                      |  5 +--
 http-backend.c              | 13 +++++---
 log-tree.c                  |  9 ++++--
 ls-refs.c                   | 10 +++---
 midx-write.c                |  3 +-
 negotiator/default.c        |  3 +-
 negotiator/skipping.c       |  3 +-
 notes-cache.c               |  6 ++--
 notes-merge.c               |  2 +-
 notes-utils.c               |  7 +++--
 notes.c                     |  5 +--
 reachable.c                 |  5 +--
 ref-filter.c                | 35 +++++++++++++++------
 reflog-walk.c               | 27 +++++++++++-----
 reflog.c                    | 20 +++++++-----
 refs.c                      |  9 ++++--
 remote.c                    | 38 ++++++++++++++---------
 reset.c                     | 29 ++++++++++--------
 revision.c                  | 27 ++++++++++------
 sequencer.c                 | 61 ++++++++++++++++++++-----------------
 server-info.c               |  3 +-
 setup.c                     |  2 +-
 shallow.c                   | 16 ++++++----
 submodule.c                 |  6 ++--
 transport-helper.c          | 29 ++++++++++--------
 transport.c                 | 16 ++++++----
 upload-pack.c               | 20 +++++++-----
 walker.c                    |  6 ++--
 wt-status.c                 | 22 +++++++------
 75 files changed, 711 insertions(+), 436 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index e17602b5e4..b5d6cd689a 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -532,8 +532,9 @@ static int get_modified_files(struct repository *r,
 			      size_t *binary_count)
 {
 	struct object_id head_oid;
-	int is_initial =3D !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-					     &head_oid, NULL);
+	int is_initial =3D !refs_resolve_ref_unsafe(get_main_ref_store(the_reposi=
tory),
+						  "HEAD", RESOLVE_REF_READING,
+						  &head_oid, NULL);
 	struct collection_status s =3D { 0 };
 	int i;
=20
@@ -761,8 +762,10 @@ static int run_revert(struct add_i_state *s, const str=
uct pathspec *ps,
 	size_t count, i, j;
=20
 	struct object_id oid;
-	int is_initial =3D !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
-					     NULL);
+	int is_initial =3D !refs_resolve_ref_unsafe(get_main_ref_store(the_reposi=
tory),
+						  "HEAD", RESOLVE_REF_READING,
+						  &oid,
+						  NULL);
 	struct lock_file index_lock;
 	const char **paths;
 	struct tree *tree;
@@ -990,8 +993,10 @@ static int run_diff(struct add_i_state *s, const struc=
t pathspec *ps,
 	ssize_t count, i;
=20
 	struct object_id oid;
-	int is_initial =3D !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
-					     NULL);
+	int is_initial =3D !refs_resolve_ref_unsafe(get_main_ref_store(the_reposi=
tory),
+						  "HEAD", RESOLVE_REF_READING,
+						  &oid,
+						  NULL);
 	if (get_modified_files(s->r, INDEX_ONLY, files, ps, NULL, NULL) < 0)
 		return -1;
=20
diff --git a/bisect.c b/bisect.c
index 29aae879b8..4ea703bec1 100644
--- a/bisect.c
+++ b/bisect.c
@@ -469,7 +469,8 @@ static int register_ref(const char *refname, const stru=
ct object_id *oid,
=20
 static int read_bisect_refs(void)
 {
-	return for_each_ref_in("refs/bisect/", register_ref, NULL);
+	return refs_for_each_ref_in(get_main_ref_store(the_repository),
+				    "refs/bisect/", register_ref, NULL);
 }
=20
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
@@ -709,7 +710,7 @@ static enum bisect_error error_if_skipped_commits(struc=
t commit_list *tried,
 static int is_expected_rev(const struct object_id *oid)
 {
 	struct object_id expected_oid;
-	if (read_ref("BISECT_EXPECTED_REV", &expected_oid))
+	if (refs_read_ref(get_main_ref_store(the_repository), "BISECT_EXPECTED_RE=
V", &expected_oid))
 		return 0;
 	return oideq(oid, &expected_oid);
 }
@@ -721,11 +722,14 @@ enum bisect_error bisect_checkout(const struct object=
_id *bisect_rev,
 	struct pretty_print_context pp =3D {0};
 	struct strbuf commit_msg =3D STRBUF_INIT;
=20
-	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_=
DIE_ON_ERR);
+	refs_update_ref(get_main_ref_store(the_repository), NULL,
+			"BISECT_EXPECTED_REV", bisect_rev, NULL, 0,
+			UPDATE_REFS_DIE_ON_ERR);
=20
 	if (no_checkout) {
-		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
-			   UPDATE_REFS_DIE_ON_ERR);
+		refs_update_ref(get_main_ref_store(the_repository), NULL,
+				"BISECT_HEAD", bisect_rev, NULL, 0,
+				UPDATE_REFS_DIE_ON_ERR);
 	} else {
 		struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
@@ -1027,7 +1031,8 @@ enum bisect_error bisect_next_all(struct repository *=
r, const char *prefix)
 	 * If no_checkout is non-zero, the bisection process does not
 	 * checkout the trial commit but instead simply updates BISECT_HEAD.
 	 */
-	int no_checkout =3D ref_exists("BISECT_HEAD");
+	int no_checkout =3D refs_ref_exists(get_main_ref_store(the_repository),
+					  "BISECT_HEAD");
 	unsigned bisect_flags =3D 0;
=20
 	read_bisect_terms(&term_bad, &term_good);
@@ -1178,10 +1183,14 @@ int bisect_clean_state(void)
=20
 	/* There may be some refs packed during bisection */
 	struct string_list refs_for_removal =3D STRING_LIST_INIT_NODUP;
-	for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_remov=
al);
+	refs_for_each_ref_in(get_main_ref_store(the_repository),
+			     "refs/bisect", mark_for_removal,
+			     (void *) &refs_for_removal);
 	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
 	string_list_append(&refs_for_removal, xstrdup("BISECT_EXPECTED_REV"));
-	result =3D delete_refs("bisect: remove", &refs_for_removal, REF_NO_DEREF);
+	result =3D refs_delete_refs(get_main_ref_store(the_repository),
+				  "bisect: remove", &refs_for_removal,
+				  REF_NO_DEREF);
 	refs_for_removal.strdup_strings =3D 1;
 	string_list_clear(&refs_for_removal, 0);
 	unlink_or_warn(git_path_bisect_ancestors_ok());
diff --git a/blame.c b/blame.c
index 1a16d4eb6a..33586b9777 100644
--- a/blame.c
+++ b/blame.c
@@ -2700,7 +2700,7 @@ static struct commit *dwim_reverse_initial(struct rev=
_info *revs,
 		return NULL;
=20
 	/* Do we have HEAD? */
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
+	if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", =
RESOLVE_REF_READING, &head_oid, NULL))
 		return NULL;
 	head_commit =3D lookup_commit_reference_gently(revs->repo,
 						     &head_oid, 1);
@@ -2803,7 +2803,7 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 		if (sb->final) {
 			parent_oid =3D &sb->final->object.oid;
 		} else {
-			if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
+			if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD"=
, RESOLVE_REF_READING, &head_oid, NULL))
 				die("no such ref: HEAD");
 			parent_oid =3D &head_oid;
 		}
diff --git a/branch.c b/branch.c
index e4a738fc7b..a83f7ecf89 100644
--- a/branch.c
+++ b/branch.c
@@ -377,7 +377,7 @@ int validate_branchname(const char *name, struct strbuf=
 *ref)
 		exit(code);
 	}
=20
-	return ref_exists(ref->buf);
+	return refs_ref_exists(get_main_ref_store(the_repository), ref->buf);
 }
=20
 static int initialized_checked_out_branches;
@@ -623,7 +623,8 @@ void create_branch(struct repository *r,
 		msg =3D xstrfmt("branch: Reset to %s", start_name);
 	else
 		msg =3D xstrfmt("branch: Created from %s", start_name);
-	transaction =3D ref_transaction_begin(&err);
+	transaction =3D ref_store_transaction_begin(get_main_ref_store(the_reposi=
tory),
+						  &err);
 	if (!transaction ||
 		ref_transaction_update(transaction, ref.buf,
 					&oid, forcing ? NULL : null_oid(),
diff --git a/builtin/am.c b/builtin/am.c
index 022cae2e8d..c62c5a6f71 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1001,7 +1001,8 @@ static void am_setup(struct am_state *state, enum pat=
ch_format patch_format,
=20
 	if (mkdir(state->dir, 0777) < 0 && errno !=3D EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir);
-	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
+	refs_delete_ref(get_main_ref_store(the_repository), NULL,
+			"REBASE_HEAD", NULL, REF_NO_DEREF);
=20
 	if (split_mail(state, patch_format, paths, keep_cr) < 0) {
 		am_destroy(state);
@@ -1081,12 +1082,15 @@ static void am_setup(struct am_state *state, enum p=
atch_format patch_format,
 	if (!repo_get_oid(the_repository, "HEAD", &curr_head)) {
 		write_state_text(state, "abort-safety", oid_to_hex(&curr_head));
 		if (!state->rebasing)
-			update_ref("am", "ORIG_HEAD", &curr_head, NULL, 0,
-				   UPDATE_REFS_DIE_ON_ERR);
+			refs_update_ref(get_main_ref_store(the_repository),
+					"am", "ORIG_HEAD", &curr_head, NULL,
+					0,
+					UPDATE_REFS_DIE_ON_ERR);
 	} else {
 		write_state_text(state, "abort-safety", "");
 		if (!state->rebasing)
-			delete_ref(NULL, "ORIG_HEAD", NULL, 0);
+			refs_delete_ref(get_main_ref_store(the_repository),
+					NULL, "ORIG_HEAD", NULL, 0);
 	}
=20
 	/*
@@ -1119,7 +1123,8 @@ static void am_next(struct am_state *state)
=20
 	oidclr(&state->orig_commit);
 	unlink(am_path(state, "original-commit"));
-	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
+	refs_delete_ref(get_main_ref_store(the_repository), NULL,
+			"REBASE_HEAD", NULL, REF_NO_DEREF);
=20
 	if (!repo_get_oid(the_repository, "HEAD", &head))
 		write_state_text(state, "abort-safety", oid_to_hex(&head));
@@ -1466,8 +1471,9 @@ static int parse_mail_rebase(struct am_state *state, =
const char *mail)
=20
 	oidcpy(&state->orig_commit, &commit_oid);
 	write_state_text(state, "original-commit", oid_to_hex(&commit_oid));
-	update_ref("am", "REBASE_HEAD", &commit_oid,
-		   NULL, REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
+	refs_update_ref(get_main_ref_store(the_repository), "am",
+			"REBASE_HEAD", &commit_oid,
+			NULL, REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
=20
 	return 0;
 }
@@ -1697,8 +1703,9 @@ static void do_commit(const struct am_state *state)
 	strbuf_addf(&sb, "%s: %.*s", reflog_msg, linelen(state->msg),
 			state->msg);
=20
-	update_ref(sb.buf, "HEAD", &commit, old_oid, 0,
-		   UPDATE_REFS_DIE_ON_ERR);
+	refs_update_ref(get_main_ref_store(the_repository), sb.buf, "HEAD",
+			&commit, old_oid, 0,
+			UPDATE_REFS_DIE_ON_ERR);
=20
 	if (state->rebasing) {
 		FILE *fp =3D xfopen(am_path(state, "rewritten"), "a");
@@ -2175,7 +2182,8 @@ static void am_abort(struct am_state *state)
=20
 	am_rerere_clear();
=20
-	curr_branch =3D resolve_refdup("HEAD", 0, &curr_head, NULL);
+	curr_branch =3D refs_resolve_refdup(get_main_ref_store(the_repository),
+					  "HEAD", 0, &curr_head, NULL);
 	has_curr_head =3D curr_branch && !is_null_oid(&curr_head);
 	if (!has_curr_head)
 		oidcpy(&curr_head, the_hash_algo->empty_tree);
@@ -2188,11 +2196,13 @@ static void am_abort(struct am_state *state)
 		die(_("failed to clean index"));
=20
 	if (has_orig_head)
-		update_ref("am --abort", "HEAD", &orig_head,
-			   has_curr_head ? &curr_head : NULL, 0,
-			   UPDATE_REFS_DIE_ON_ERR);
+		refs_update_ref(get_main_ref_store(the_repository),
+				"am --abort", "HEAD", &orig_head,
+				has_curr_head ? &curr_head : NULL, 0,
+				UPDATE_REFS_DIE_ON_ERR);
 	else if (curr_branch)
-		delete_ref(NULL, curr_branch, NULL, REF_NO_DEREF);
+		refs_delete_ref(get_main_ref_store(the_repository), NULL,
+				curr_branch, NULL, REF_NO_DEREF);
=20
 	free(curr_branch);
 	am_destroy(state);
diff --git a/builtin/bisect.c b/builtin/bisect.c
index f69c3f7e43..a58432b9d9 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -243,7 +243,7 @@ static int bisect_reset(const char *commit)
 		strbuf_addstr(&branch, commit);
 	}
=20
-	if (branch.len && !ref_exists("BISECT_HEAD")) {
+	if (branch.len && !refs_ref_exists(get_main_ref_store(the_repository), "B=
ISECT_HEAD")) {
 		struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
 		cmd.git_cmd =3D 1;
@@ -302,8 +302,8 @@ static int bisect_write(const char *state, const char *=
rev,
 		goto finish;
 	}
=20
-	if (update_ref(NULL, tag.buf, &oid, NULL, 0,
-		       UPDATE_REFS_MSG_ON_ERR)) {
+	if (refs_update_ref(get_main_ref_store(the_repository), NULL, tag.buf, &o=
id, NULL, 0,
+			    UPDATE_REFS_MSG_ON_ERR)) {
 		res =3D -1;
 		goto finish;
 	}
@@ -416,11 +416,12 @@ static void bisect_status(struct bisect_state *state,
 	char *bad_ref =3D xstrfmt("refs/bisect/%s", terms->term_bad);
 	char *good_glob =3D xstrfmt("%s-*", terms->term_good);
=20
-	if (ref_exists(bad_ref))
+	if (refs_ref_exists(get_main_ref_store(the_repository), bad_ref))
 		state->nr_bad =3D 1;
=20
-	for_each_glob_ref_in(inc_nr, good_glob, "refs/bisect/",
-			     (void *) &state->nr_good);
+	refs_for_each_glob_ref_in(get_main_ref_store(the_repository), inc_nr,
+				  good_glob, "refs/bisect/",
+				  (void *) &state->nr_good);
=20
 	free(good_glob);
 	free(bad_ref);
@@ -574,9 +575,11 @@ static int prepare_revs(struct bisect_terms *terms, st=
ruct rev_info *revs)
 	reset_revision_walk();
 	repo_init_revisions(the_repository, revs, NULL);
 	setup_revisions(0, NULL, revs, NULL);
-	for_each_glob_ref_in(add_bisect_ref, bad, "refs/bisect/", &cb);
+	refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
+				  add_bisect_ref, bad, "refs/bisect/", &cb);
 	cb.object_flags =3D UNINTERESTING;
-	for_each_glob_ref_in(add_bisect_ref, good, "refs/bisect/", &cb);
+	refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
+				  add_bisect_ref, good, "refs/bisect/", &cb);
 	if (prepare_revision_walk(revs))
 		res =3D error(_("revision walk setup failed\n"));
=20
@@ -636,7 +639,7 @@ static int bisect_successful(struct bisect_terms *terms)
 	char *bad_ref =3D xstrfmt("refs/bisect/%s",terms->term_bad);
 	int res;
=20
-	read_ref(bad_ref, &oid);
+	refs_read_ref(get_main_ref_store(the_repository), bad_ref, &oid);
 	commit =3D lookup_commit_reference_by_name(bad_ref);
 	repo_format_commit_message(the_repository, commit, "%s", &commit_name,
 				   &pp);
@@ -779,7 +782,8 @@ static enum bisect_error bisect_start(struct bisect_ter=
ms *terms, int argc,
 	/*
 	 * Verify HEAD
 	 */
-	head =3D resolve_ref_unsafe("HEAD", 0, &head_oid, &flags);
+	head =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+				       "HEAD", 0, &head_oid, &flags);
 	if (!head)
 		if (repo_get_oid(the_repository, "HEAD", &head_oid))
 			return error(_("bad HEAD - I need a HEAD"));
@@ -838,8 +842,8 @@ static enum bisect_error bisect_start(struct bisect_ter=
ms *terms, int argc,
 			res =3D error(_("invalid ref: '%s'"), start_head.buf);
 			goto finish;
 		}
-		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
-			       UPDATE_REFS_MSG_ON_ERR)) {
+		if (refs_update_ref(get_main_ref_store(the_repository), NULL, "BISECT_HE=
AD", &oid, NULL, 0,
+				    UPDATE_REFS_MSG_ON_ERR)) {
 			res =3D BISECT_FAILED;
 			goto finish;
 		}
@@ -972,7 +976,7 @@ static enum bisect_error bisect_state(struct bisect_ter=
ms *terms, int argc,
 		oid_array_append(&revs, &commit->object.oid);
 	}
=20
-	if (read_ref("BISECT_EXPECTED_REV", &expected))
+	if (refs_read_ref(get_main_ref_store(the_repository), "BISECT_EXPECTED_RE=
V", &expected))
 		verify_expected =3D 0; /* Ignore invalid file contents */
=20
 	for (i =3D 0; i < revs.nr; i++) {
@@ -982,7 +986,9 @@ static enum bisect_error bisect_state(struct bisect_ter=
ms *terms, int argc,
 		}
 		if (verify_expected && !oideq(&revs.oid[i], &expected)) {
 			unlink_or_warn(git_path_bisect_ancestors_ok());
-			delete_ref(NULL, "BISECT_EXPECTED_REV", NULL, REF_NO_DEREF);
+			refs_delete_ref(get_main_ref_store(the_repository),
+					NULL, "BISECT_EXPECTED_REV", NULL,
+					REF_NO_DEREF);
 			verify_expected =3D 0;
 		}
 	}
@@ -1179,13 +1185,15 @@ static int verify_good(const struct bisect_terms *t=
erms, const char *command)
 	struct object_id good_rev;
 	struct object_id current_rev;
 	char *good_glob =3D xstrfmt("%s-*", terms->term_good);
-	int no_checkout =3D ref_exists("BISECT_HEAD");
+	int no_checkout =3D refs_ref_exists(get_main_ref_store(the_repository),
+					  "BISECT_HEAD");
=20
-	for_each_glob_ref_in(get_first_good, good_glob, "refs/bisect/",
-			     &good_rev);
+	refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
+				  get_first_good, good_glob, "refs/bisect/",
+				  &good_rev);
 	free(good_glob);
=20
-	if (read_ref(no_checkout ? "BISECT_HEAD" : "HEAD", &current_rev))
+	if (refs_read_ref(get_main_ref_store(the_repository), no_checkout ? "BISE=
CT_HEAD" : "HEAD", &current_rev))
 		return -1;
=20
 	res =3D bisect_checkout(&good_rev, no_checkout);
diff --git a/builtin/blame.c b/builtin/blame.c
index 9aa74680a3..6bc7aa6085 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1093,8 +1093,8 @@ int cmd_blame(int argc, const char **argv, const char=
 *prefix)
 		struct commit *head_commit;
 		struct object_id head_oid;
=20
-		if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-					&head_oid, NULL) ||
+		if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD",=
 RESOLVE_REF_READING,
+					     &head_oid, NULL) ||
 		    !(head_commit =3D lookup_commit_reference_gently(revs.repo,
 							     &head_oid, 1)))
 			die("no such ref: HEAD");
diff --git a/builtin/branch.c b/builtin/branch.c
index dd3e3a7dc0..e32ccc4332 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -148,8 +148,8 @@ static int branch_merged(int kind, const char *name,
=20
 		if (upstream &&
 		    (reference_name =3D reference_name_to_free =3D
-		     resolve_refdup(upstream, RESOLVE_REF_READING,
-				    &oid, NULL)) !=3D NULL)
+		     refs_resolve_refdup(get_main_ref_store(the_repository), upstream, R=
ESOLVE_REF_READING,
+					 &oid, NULL)) !=3D NULL)
 			reference_rev =3D lookup_commit_reference(the_repository,
 								&oid);
 	}
@@ -272,21 +272,24 @@ static int delete_branches(int argc, const char **arg=
v, int force, int kinds,
 			}
 		}
=20
-		target =3D resolve_refdup(name,
-					RESOLVE_REF_READING
-					| RESOLVE_REF_NO_RECURSE
-					| RESOLVE_REF_ALLOW_BAD_NAME,
-					&oid, &flags);
+		target =3D refs_resolve_refdup(get_main_ref_store(the_repository),
+					     name,
+					     RESOLVE_REF_READING
+					     | RESOLVE_REF_NO_RECURSE
+					     | RESOLVE_REF_ALLOW_BAD_NAME,
+					     &oid, &flags);
 		if (!target) {
 			if (remote_branch) {
 				error(_("remote-tracking branch '%s' not found"), bname.buf);
 			} else {
 				char *virtual_name =3D mkpathdup(fmt_remotes, bname.buf);
-				char *virtual_target =3D resolve_refdup(virtual_name,
-							RESOLVE_REF_READING
-							| RESOLVE_REF_NO_RECURSE
-							| RESOLVE_REF_ALLOW_BAD_NAME,
-							&oid, &flags);
+				char *virtual_target =3D refs_resolve_refdup(get_main_ref_store(the_re=
pository),
+									   virtual_name,
+									   RESOLVE_REF_READING
+									   | RESOLVE_REF_NO_RECURSE
+									   | RESOLVE_REF_ALLOW_BAD_NAME,
+									   &oid,
+									   &flags);
 				FREE_AND_NULL(virtual_name);
=20
 				if (virtual_target)
@@ -317,13 +320,13 @@ static int delete_branches(int argc, const char **arg=
v, int force, int kinds,
 		free(target);
 	}
=20
-	if (delete_refs(NULL, &refs_to_delete, REF_NO_DEREF))
+	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_d=
elete, REF_NO_DEREF))
 		ret =3D 1;
=20
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref =3D item->util;
 		char *name =3D item->string;
-		if (!ref_exists(name)) {
+		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname =3D name + branch_name_pos;
 			if (!quiet)
 				printf(remote_branch
@@ -499,7 +502,8 @@ static void print_ref_list(struct ref_filter *filter, s=
truct ref_sorting *sortin
 static void print_current_branch_name(void)
 {
 	int flags;
-	const char *refname =3D resolve_ref_unsafe("HEAD", 0, NULL, &flags);
+	const char *refname =3D refs_resolve_ref_unsafe(get_main_ref_store(the_re=
pository),
+						      "HEAD", 0, NULL, &flags);
 	const char *shortname;
 	if (!refname)
 		die(_("could not resolve HEAD"));
@@ -580,7 +584,7 @@ static void copy_or_rename_branch(const char *oldname, =
const char *newname, int
 		 * Bad name --- this could be an attempt to rename a
 		 * ref that we used to allow to be created by accident.
 		 */
-		if (ref_exists(oldref.buf))
+		if (refs_ref_exists(get_main_ref_store(the_repository), oldref.buf))
 			recovery =3D 1;
 		else {
 			int code =3D die_message(_("invalid branch name: '%s'"), oldname);
@@ -601,7 +605,7 @@ static void copy_or_rename_branch(const char *oldname, =
const char *newname, int
 		}
 	}
=20
-	if ((copy || !(oldref_usage & IS_HEAD)) && !ref_exists(oldref.buf)) {
+	if ((copy || !(oldref_usage & IS_HEAD)) && !refs_ref_exists(get_main_ref_=
store(the_repository), oldref.buf)) {
 		if (oldref_usage & IS_HEAD)
 			die(_("no commit on branch '%s' yet"), oldname);
 		else
@@ -632,9 +636,9 @@ static void copy_or_rename_branch(const char *oldname, =
const char *newname, int
 			    oldref.buf, newref.buf);
=20
 	if (!copy && !(oldref_usage & IS_ORPHAN) &&
-	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
+	    refs_rename_ref(get_main_ref_store(the_repository), oldref.buf, newre=
f.buf, logmsg.buf))
 		die(_("branch rename failed"));
-	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
+	if (copy && refs_copy_existing_ref(get_main_ref_store(the_repository), ol=
dref.buf, newref.buf, logmsg.buf))
 		die(_("branch copy failed"));
=20
 	if (recovery) {
@@ -786,7 +790,8 @@ int cmd_branch(int argc, const char **argv, const char =
*prefix)
=20
 	track =3D git_branch_track;
=20
-	head =3D resolve_refdup("HEAD", 0, &head_oid, NULL);
+	head =3D refs_resolve_refdup(get_main_ref_store(the_repository), "HEAD",
+				   0, &head_oid, NULL);
 	if (!head)
 		die(_("failed to resolve HEAD as a valid ref"));
 	if (!strcmp(head, "HEAD"))
@@ -891,7 +896,7 @@ int cmd_branch(int argc, const char **argv, const char =
*prefix)
 		}
=20
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
-		if (!ref_exists(branch_ref.buf))
+		if (!refs_ref_exists(get_main_ref_store(the_repository), branch_ref.buf))
 			error((!argc || branch_checked_out(branch_ref.buf))
 			      ? _("no commit on branch '%s' yet")
 			      : _("no branch named '%s'"),
@@ -936,7 +941,7 @@ int cmd_branch(int argc, const char **argv, const char =
*prefix)
 			die(_("no such branch '%s'"), argv[0]);
 		}
=20
-		if (!ref_exists(branch->refname)) {
+		if (!refs_ref_exists(get_main_ref_store(the_repository), branch->refname=
)) {
 			if (!argc || branch_checked_out(branch->refname))
 				die(_("no commit on branch '%s' yet"), branch->name);
 			die(_("branch '%s' does not exist"), branch->name);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 71e6036aab..3944a9fcba 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -646,7 +646,8 @@ static int checkout_paths(const struct checkout_opts *o=
pts,
 		rollback_lock_file(&lock_file);
 	}
=20
-	read_ref_full("HEAD", 0, &rev, NULL);
+	refs_read_ref_full(get_main_ref_store(the_repository), "HEAD", 0,
+			   &rev, NULL);
 	head =3D lookup_commit_reference_gently(the_repository, &rev, 1);
=20
 	errs |=3D post_checkout_hook(head, head, 0);
@@ -958,7 +959,8 @@ static void update_refs_for_switch(const struct checkou=
t_opts *opts,
 				int ret;
 				struct strbuf err =3D STRBUF_INIT;
=20
-				ret =3D safe_create_reflog(refname, &err);
+				ret =3D refs_create_reflog(get_main_ref_store(the_repository),
+							 refname, &err);
 				if (ret) {
 					fprintf(stderr, _("Can not do reflog for '%s': %s\n"),
 						opts->new_orphan_branch, err.buf);
@@ -999,8 +1001,10 @@ static void update_refs_for_switch(const struct check=
out_opts *opts,
 	if (!strcmp(new_branch_info->name, "HEAD") && !new_branch_info->path && !=
opts->force_detach) {
 		/* Nothing to do. */
 	} else if (opts->force_detach || !new_branch_info->path) {	/* No longer o=
n any branch. */
-		update_ref(msg.buf, "HEAD", &new_branch_info->commit->object.oid, NULL,
-			   REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
+		refs_update_ref(get_main_ref_store(the_repository), msg.buf,
+				"HEAD", &new_branch_info->commit->object.oid,
+				NULL,
+				REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old_branch_info->path &&
 			    advice_enabled(ADVICE_DETACHED_HEAD) && !opts->force_detach)
@@ -1008,7 +1012,7 @@ static void update_refs_for_switch(const struct check=
out_opts *opts,
 			describe_detached_head(_("HEAD is now at"), new_branch_info->commit);
 		}
 	} else if (new_branch_info->path) {	/* Switch branches. */
-		if (create_symref("HEAD", new_branch_info->path, msg.buf) < 0)
+		if (refs_create_symref(get_main_ref_store(the_repository), "HEAD", new_b=
ranch_info->path, msg.buf) < 0)
 			die(_("unable to update HEAD"));
 		if (!opts->quiet) {
 			if (old_branch_info->path && !strcmp(new_branch_info->path, old_branch_=
info->path)) {
@@ -1029,8 +1033,9 @@ static void update_refs_for_switch(const struct check=
out_opts *opts,
 			}
 		}
 		if (old_branch_info->path && old_branch_info->name) {
-			if (!ref_exists(old_branch_info->path) && reflog_exists(old_branch_info=
->path))
-				delete_reflog(old_branch_info->path);
+			if (!refs_ref_exists(get_main_ref_store(the_repository), old_branch_inf=
o->path) && refs_reflog_exists(get_main_ref_store(the_repository), old_bran=
ch_info->path))
+				refs_delete_reflog(get_main_ref_store(the_repository),
+						   old_branch_info->path);
 		}
 	}
 	remove_branch_state(the_repository, !opts->quiet);
@@ -1129,7 +1134,8 @@ static void orphaned_commit_warning(struct commit *ol=
d_commit, struct commit *ne
 	object->flags &=3D ~UNINTERESTING;
 	add_pending_object(&revs, object, oid_to_hex(&object->oid));
=20
-	for_each_ref(add_pending_uninteresting_ref, &revs);
+	refs_for_each_ref(get_main_ref_store(the_repository),
+			  add_pending_uninteresting_ref, &revs);
 	if (new_commit)
 		add_pending_oid(&revs, "HEAD",
 				&new_commit->object.oid,
@@ -1159,7 +1165,8 @@ static int switch_branches(const struct checkout_opts=
 *opts,
 	trace2_cmd_mode("branch");
=20
 	memset(&old_branch_info, 0, sizeof(old_branch_info));
-	old_branch_info.path =3D resolve_refdup("HEAD", 0, &rev, &flag);
+	old_branch_info.path =3D refs_resolve_refdup(get_main_ref_store(the_repos=
itory),
+						   "HEAD", 0, &rev, &flag);
 	if (old_branch_info.path)
 		old_branch_info.commit =3D lookup_commit_reference_gently(the_repository=
, &rev, 1);
 	if (!(flag & REF_ISSYMREF))
@@ -1247,7 +1254,7 @@ static void setup_new_branch_info_and_source_tree(
 	setup_branch_path(new_branch_info);
=20
 	if (!check_refname_format(new_branch_info->path, 0) &&
-	    !read_ref(new_branch_info->path, &branch_rev))
+	    !refs_read_ref(get_main_ref_store(the_repository), new_branch_info->p=
ath, &branch_rev))
 		oidcpy(rev, &branch_rev);
 	else
 		/* not an existing branch */
@@ -1466,7 +1473,8 @@ static int switch_unborn_to_new_branch(const struct c=
heckout_opts *opts)
 	if (!opts->new_branch)
 		die(_("You are on a branch yet to be born"));
 	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
-	status =3D create_symref("HEAD", branch_ref.buf, "checkout -b");
+	status =3D refs_create_symref(get_main_ref_store(the_repository),
+				    "HEAD", branch_ref.buf, "checkout -b");
 	strbuf_release(&branch_ref);
 	if (!opts->quiet)
 		fprintf(stderr, _("Switched to a new branch '%s'\n"),
@@ -1553,7 +1561,8 @@ static void die_if_switching_to_a_branch_in_use(struc=
t checkout_opts *opts,
=20
 	if (opts->ignore_other_worktrees)
 		return;
-	head_ref =3D resolve_refdup("HEAD", 0, NULL, &flags);
+	head_ref =3D refs_resolve_refdup(get_main_ref_store(the_repository),
+				       "HEAD", 0, NULL, &flags);
 	if (head_ref && (!(flags & REF_ISSYMREF) || strcmp(head_ref, full_ref)))
 		die_if_checked_out(full_ref, 1);
 	free(head_ref);
@@ -1634,7 +1643,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		struct object_id rev;
 		int flag;
=20
-		if (!read_ref_full("HEAD", 0, &rev, &flag) &&
+		if (!refs_read_ref_full(get_main_ref_store(the_repository), "HEAD", 0, &=
rev, &flag) &&
 		    (flag & REF_ISSYMREF) && is_null_oid(&rev))
 			return switch_unborn_to_new_branch(opts);
 	}
diff --git a/builtin/clone.c b/builtin/clone.c
index 74ec14542e..f279b84a84 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -539,7 +539,8 @@ static void write_remote_refs(const struct ref *local_r=
efs)
 	struct ref_transaction *t;
 	struct strbuf err =3D STRBUF_INIT;
=20
-	t =3D ref_transaction_begin(&err);
+	t =3D ref_store_transaction_begin(get_main_ref_store(the_repository),
+					&err);
 	if (!t)
 		die("%s", err.buf);
=20
@@ -570,8 +571,9 @@ static void write_followtags(const struct ref *refs, co=
nst char *msg)
 						     OBJECT_INFO_QUICK |
 						     OBJECT_INFO_SKIP_FETCH_OBJECT))
 			continue;
-		update_ref(msg, ref->name, &ref->old_oid, NULL, 0,
-			   UPDATE_REFS_DIE_ON_ERR);
+		refs_update_ref(get_main_ref_store(the_repository), msg,
+				ref->name, &ref->old_oid, NULL, 0,
+				UPDATE_REFS_DIE_ON_ERR);
 	}
 }
=20
@@ -623,9 +625,9 @@ static void update_remote_refs(const struct ref *refs,
 		struct strbuf head_ref =3D STRBUF_INIT;
 		strbuf_addstr(&head_ref, branch_top);
 		strbuf_addstr(&head_ref, "HEAD");
-		if (create_symref(head_ref.buf,
-				  remote_head_points_at->peer_ref->name,
-				  msg) < 0)
+		if (refs_create_symref(get_main_ref_store(the_repository), head_ref.buf,
+				       remote_head_points_at->peer_ref->name,
+				       msg) < 0)
 			die(_("unable to update %s"), head_ref.buf);
 		strbuf_release(&head_ref);
 	}
@@ -637,33 +639,36 @@ static void update_head(const struct ref *our, const =
struct ref *remote,
 	const char *head;
 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
-		if (create_symref("HEAD", our->name, NULL) < 0)
+		if (refs_create_symref(get_main_ref_store(the_repository), "HEAD", our->=
name, NULL) < 0)
 			die(_("unable to update HEAD"));
 		if (!option_bare) {
-			update_ref(msg, "HEAD", &our->old_oid, NULL, 0,
-				   UPDATE_REFS_DIE_ON_ERR);
+			refs_update_ref(get_main_ref_store(the_repository),
+					msg, "HEAD", &our->old_oid, NULL, 0,
+					UPDATE_REFS_DIE_ON_ERR);
 			install_branch_config(0, head, remote_name, our->name);
 		}
 	} else if (our) {
 		struct commit *c =3D lookup_commit_reference(the_repository,
 							   &our->old_oid);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
-		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NO_DEREF,
-			   UPDATE_REFS_DIE_ON_ERR);
+		refs_update_ref(get_main_ref_store(the_repository), msg,
+				"HEAD", &c->object.oid, NULL, REF_NO_DEREF,
+				UPDATE_REFS_DIE_ON_ERR);
 	} else if (remote) {
 		/*
 		 * We know remote HEAD points to a non-branch, or
 		 * HEAD points to a branch but we don't know which one.
 		 * Detach HEAD in all these cases.
 		 */
-		update_ref(msg, "HEAD", &remote->old_oid, NULL, REF_NO_DEREF,
-			   UPDATE_REFS_DIE_ON_ERR);
+		refs_update_ref(get_main_ref_store(the_repository), msg,
+				"HEAD", &remote->old_oid, NULL, REF_NO_DEREF,
+				UPDATE_REFS_DIE_ON_ERR);
 	} else if (unborn && skip_prefix(unborn, "refs/heads/", &head)) {
 		/*
 		 * Unborn head from remote; same as "our" case above except
 		 * that we have no ref to update.
 		 */
-		if (create_symref("HEAD", unborn, NULL) < 0)
+		if (refs_create_symref(get_main_ref_store(the_repository), "HEAD", unbor=
n, NULL) < 0)
 			die(_("unable to update HEAD"));
 		if (!option_bare)
 			install_branch_config(0, head, remote_name, unborn);
@@ -704,7 +709,8 @@ static int checkout(int submodule_progress, int filter_=
submodules)
 	if (option_no_checkout)
 		return 0;
=20
-	head =3D resolve_refdup("HEAD", RESOLVE_REF_READING, &oid, NULL);
+	head =3D refs_resolve_refdup(get_main_ref_store(the_repository), "HEAD",
+				   RESOLVE_REF_READING, &oid, NULL);
 	if (!head) {
 		warning(_("remote HEAD refers to nonexistent ref, "
 			  "unable to checkout"));
diff --git a/builtin/describe.c b/builtin/describe.c
index d6c77a714f..e63fa8d84e 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -638,7 +638,8 @@ int cmd_describe(int argc, const char **argv, const cha=
r *prefix)
 	}
=20
 	hashmap_init(&names, commit_name_neq, NULL, 0);
-	for_each_rawref(get_name, NULL);
+	refs_for_each_rawref(get_main_ref_store(the_repository), get_name,
+			     NULL);
 	if (!hashmap_get_size(&names) && !always)
 		die(_("No names found, cannot describe anything."));
=20
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index dc5a9d32dd..184cfa9f57 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1604,10 +1604,11 @@ static int update_branch(struct branch *b)
=20
 	if (is_null_oid(&b->oid)) {
 		if (b->delete)
-			delete_ref(NULL, b->name, NULL, 0);
+			refs_delete_ref(get_main_ref_store(the_repository),
+					NULL, b->name, NULL, 0);
 		return 0;
 	}
-	if (read_ref(b->name, &old_oid))
+	if (refs_read_ref(get_main_ref_store(the_repository), b->name, &old_oid))
 		oidclr(&old_oid);
 	if (!force_update && !is_null_oid(&old_oid)) {
 		struct commit *old_cmit, *new_cmit;
@@ -1631,7 +1632,8 @@ static int update_branch(struct branch *b)
 			return -1;
 		}
 	}
-	transaction =3D ref_transaction_begin(&err);
+	transaction =3D ref_store_transaction_begin(get_main_ref_store(the_reposi=
tory),
+						  &err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, &b->oid, &old_oid,
 				   0, msg, &err) ||
@@ -1665,7 +1667,8 @@ static void dump_tags(void)
 	struct strbuf err =3D STRBUF_INIT;
 	struct ref_transaction *transaction;
=20
-	transaction =3D ref_transaction_begin(&err);
+	transaction =3D ref_store_transaction_begin(get_main_ref_store(the_reposi=
tory),
+						  &err);
 	if (!transaction) {
 		failure |=3D error("%s", err.buf);
 		goto cleanup;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5857d860db..3829d66b40 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -340,7 +340,8 @@ static void find_non_local_tags(const struct ref *refs,
 	refname_hash_init(&remote_refs);
 	create_fetch_oidset(head, &fetch_oids);
=20
-	for_each_ref(add_one_refname, &existing_refs);
+	refs_for_each_ref(get_main_ref_store(the_repository), add_one_refname,
+			  &existing_refs);
=20
 	/*
 	 * If we already have a transaction, then we need to filter out all
@@ -614,7 +615,9 @@ static struct ref *get_ref_map(struct remote *remote,
=20
 			if (!existing_refs_populated) {
 				refname_hash_init(&existing_refs);
-				for_each_ref(add_one_refname, &existing_refs);
+				refs_for_each_ref(get_main_ref_store(the_repository),
+						  add_one_refname,
+						  &existing_refs);
 				existing_refs_populated =3D 1;
 			}
=20
@@ -659,7 +662,8 @@ static int s_update_ref(const char *action,
 	 * lifecycle.
 	 */
 	if (!transaction) {
-		transaction =3D our_transaction =3D ref_transaction_begin(&err);
+		transaction =3D our_transaction =3D ref_store_transaction_begin(get_main=
_ref_store(the_repository),
+									    &err);
 		if (!transaction) {
 			ret =3D STORE_REF_ERROR_OTHER;
 			goto out;
@@ -1393,7 +1397,9 @@ static int prune_refs(struct display_state *display_s=
tate,
 			for (ref =3D stale_refs; ref; ref =3D ref->next)
 				string_list_append(&refnames, ref->name);
=20
-			result =3D delete_refs("fetch: prune", &refnames, 0);
+			result =3D refs_delete_refs(get_main_ref_store(the_repository),
+						  "fetch: prune", &refnames,
+						  0);
 			string_list_clear(&refnames, 0);
 		}
 	}
@@ -1479,7 +1485,8 @@ static void add_negotiation_tips(struct git_transport=
_options *smart_options)
 			continue;
 		}
 		old_nr =3D oids->nr;
-		for_each_glob_ref(add_oid, s, oids);
+		refs_for_each_glob_ref(get_main_ref_store(the_repository),
+				       add_oid, s, oids);
 		if (old_nr =3D=3D oids->nr)
 			warning("ignoring --negotiation-tip=3D%s because it does not match any =
refs",
 				s);
@@ -1655,7 +1662,8 @@ static int do_fetch(struct transport *transport,
 			   config->display_format);
=20
 	if (atomic_fetch) {
-		transaction =3D ref_transaction_begin(&err);
+		transaction =3D ref_store_transaction_begin(get_main_ref_store(the_repos=
itory),
+							  &err);
 		if (!transaction) {
 			retcode =3D -1;
 			goto cleanup;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index f892487c9b..d13a226c2e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -514,7 +514,9 @@ static int fsck_handle_reflog(const char *logname, void=
 *cb_data)
 	struct strbuf refname =3D STRBUF_INIT;
=20
 	strbuf_worktree_ref(cb_data, &refname, logname);
-	for_each_reflog_ent(refname.buf, fsck_handle_reflog_ent, refname.buf);
+	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+				 refname.buf, fsck_handle_reflog_ent,
+				 refname.buf);
 	strbuf_release(&refname);
 	return 0;
 }
@@ -563,7 +565,8 @@ static void get_default_heads(void)
 	const char *head_points_at;
 	struct object_id head_oid;
=20
-	for_each_rawref(fsck_handle_ref, NULL);
+	refs_for_each_rawref(get_main_ref_store(the_repository),
+			     fsck_handle_ref, NULL);
=20
 	worktrees =3D get_worktrees();
 	for (p =3D worktrees; *p; p++) {
@@ -712,7 +715,9 @@ static int fsck_head_link(const char *head_ref_name,
 	if (verbose)
 		fprintf_ln(stderr, _("Checking %s link"), head_ref_name);
=20
-	*head_points_at =3D resolve_ref_unsafe(head_ref_name, 0, head_oid, NULL);
+	*head_points_at =3D refs_resolve_ref_unsafe(get_main_ref_store(the_reposi=
tory),
+						  head_ref_name, 0, head_oid,
+						  NULL);
 	if (!*head_points_at) {
 		errors_found |=3D ERROR_REFS;
 		return error(_("invalid %s"), head_ref_name);
diff --git a/builtin/gc.c b/builtin/gc.c
index d3b5ca9bb1..054fca7835 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -907,7 +907,8 @@ static int should_write_commit_graph(void)
 	if (data.limit < 0)
 		return 1;
=20
-	result =3D for_each_ref(dfs_on_ref, &data);
+	result =3D refs_for_each_ref(get_main_ref_store(the_repository),
+				   dfs_on_ref, &data);
=20
 	repo_clear_commit_marks(the_repository, SEEN);
=20
diff --git a/builtin/log.c b/builtin/log.c
index 4da7399905..b17dd8b40a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2226,8 +2226,10 @@ int cmd_format_patch(int argc, const char **argv, co=
nst char *prefix)
=20
 		if (check_head) {
 			const char *ref, *v;
-			ref =3D resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-						 NULL, NULL);
+			ref =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+						      "HEAD",
+						      RESOLVE_REF_READING,
+						      NULL, NULL);
 			if (ref && skip_prefix(ref, "refs/heads/", &v))
 				branch_name =3D xstrdup(v);
 			else
diff --git a/builtin/merge.c b/builtin/merge.c
index 6f4fec87fc..c9af4cab6c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -449,8 +449,10 @@ static void finish(struct commit *head_commit,
 		if (verbosity >=3D 0 && !merge_msg.len)
 			printf(_("No merge message -- not updating HEAD\n"));
 		else {
-			update_ref(reflog_message.buf, "HEAD", new_head, head,
-				   0, UPDATE_REFS_DIE_ON_ERR);
+			refs_update_ref(get_main_ref_store(the_repository),
+					reflog_message.buf, "HEAD", new_head,
+					head,
+					0, UPDATE_REFS_DIE_ON_ERR);
 			/*
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
@@ -547,7 +549,7 @@ static void merge_name(const char *remote, struct strbu=
f *msg)
 		struct strbuf truname =3D STRBUF_INIT;
 		strbuf_addf(&truname, "refs/heads/%s", remote);
 		strbuf_setlen(&truname, truname.len - len);
-		if (ref_exists(truname.buf)) {
+		if (refs_ref_exists(get_main_ref_store(the_repository), truname.buf)) {
 			strbuf_addf(msg,
 				    "%s\t\tbranch '%s'%s of .\n",
 				    oid_to_hex(&remote_head->object.oid),
@@ -1252,7 +1254,7 @@ static int merging_a_throwaway_tag(struct commit *com=
mit)
 	 */
 	tag_ref =3D xstrfmt("refs/tags/%s",
 			  ((struct tag *)merge_remote_util(commit)->obj)->tag);
-	if (!read_ref(tag_ref, &oid) &&
+	if (!refs_read_ref(get_main_ref_store(the_repository), tag_ref, &oid) &&
 	    oideq(&oid, &merge_remote_util(commit)->obj->oid))
 		is_throwaway_tag =3D 0;
 	else
@@ -1284,7 +1286,9 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch =3D branch_to_free =3D resolve_refdup("HEAD", 0, &head_oid, NULL);
+	branch =3D branch_to_free =3D refs_resolve_refdup(get_main_ref_store(the_=
repository),
+						      "HEAD", 0, &head_oid,
+						      NULL);
 	if (branch)
 		skip_prefix(branch, "refs/heads/", &branch);
=20
@@ -1325,8 +1329,10 @@ int cmd_merge(int argc, const char **argv, const cha=
r *prefix)
 		if (!file_exists(git_path_merge_head(the_repository)))
 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
=20
-		if (!read_ref("MERGE_AUTOSTASH", &stash_oid))
-			delete_ref("", "MERGE_AUTOSTASH", &stash_oid, REF_NO_DEREF);
+		if (!refs_read_ref(get_main_ref_store(the_repository), "MERGE_AUTOSTASH"=
, &stash_oid))
+			refs_delete_ref(get_main_ref_store(the_repository),
+					"", "MERGE_AUTOSTASH", &stash_oid,
+					REF_NO_DEREF);
=20
 		/* Invoke 'git reset --merge' */
 		ret =3D cmd_reset(nargc, nargv, prefix);
@@ -1379,7 +1385,7 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 		else
 			die(_("You have not concluded your merge (MERGE_HEAD exists)."));
 	}
-	if (ref_exists("CHERRY_PICK_HEAD")) {
+	if (refs_ref_exists(get_main_ref_store(the_repository), "CHERRY_PICK_HEAD=
")) {
 		if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists=
).\n"
 			    "Please, commit your changes before you merge."));
@@ -1450,8 +1456,10 @@ int cmd_merge(int argc, const char **argv, const cha=
r *prefix)
=20
 		remote_head_oid =3D &remoteheads->item->object.oid;
 		read_empty(remote_head_oid);
-		update_ref("initial pull", "HEAD", remote_head_oid, NULL, 0,
-			   UPDATE_REFS_DIE_ON_ERR);
+		refs_update_ref(get_main_ref_store(the_repository),
+				"initial pull", "HEAD", remote_head_oid, NULL,
+				0,
+				UPDATE_REFS_DIE_ON_ERR);
 		goto done;
 	}
=20
@@ -1531,8 +1539,10 @@ int cmd_merge(int argc, const char **argv, const cha=
r *prefix)
 		free(list);
 	}
=20
-	update_ref("updating ORIG_HEAD", "ORIG_HEAD",
-		   &head_commit->object.oid, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	refs_update_ref(get_main_ref_store(the_repository),
+			"updating ORIG_HEAD", "ORIG_HEAD",
+			&head_commit->object.oid, NULL, 0,
+			UPDATE_REFS_DIE_ON_ERR);
=20
 	if (remoteheads && !common) {
 		/* No common ancestors found. */
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index ad9930c831..70e9ec4e47 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -296,7 +296,8 @@ static void add_to_tip_table(const struct object_id *oi=
d, const char *refname,
 	char *short_refname =3D NULL;
=20
 	if (shorten_unambiguous)
-		short_refname =3D shorten_unambiguous_ref(refname, 0);
+		short_refname =3D refs_shorten_unambiguous_ref(get_main_ref_store(the_re=
pository),
+							     refname, 0);
 	else if (skip_prefix(refname, "refs/heads/", &refname))
 		; /* refname already advanced */
 	else
@@ -647,7 +648,7 @@ int cmd_name_rev(int argc, const char **argv, const cha=
r *prefix)
=20
 	adjust_cutoff_timestamp_for_slop();
=20
-	for_each_ref(name_ref, &data);
+	refs_for_each_ref(get_main_ref_store(the_repository), name_ref, &data);
 	name_tips(&string_pool);
=20
 	if (annotate_stdin) {
diff --git a/builtin/notes.c b/builtin/notes.c
index cb011303e6..a5ce90d9f9 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -794,9 +794,9 @@ static int merge_abort(struct notes_merge_options *o)
 	 * notes_merge_abort() to remove .git/NOTES_MERGE_WORKTREE.
 	 */
=20
-	if (delete_ref(NULL, "NOTES_MERGE_PARTIAL", NULL, 0))
+	if (refs_delete_ref(get_main_ref_store(the_repository), NULL, "NOTES_MERG=
E_PARTIAL", NULL, 0))
 		ret +=3D error(_("failed to delete ref NOTES_MERGE_PARTIAL"));
-	if (delete_ref(NULL, "NOTES_MERGE_REF", NULL, REF_NO_DEREF))
+	if (refs_delete_ref(get_main_ref_store(the_repository), NULL, "NOTES_MERG=
E_REF", NULL, REF_NO_DEREF))
 		ret +=3D error(_("failed to delete ref NOTES_MERGE_REF"));
 	if (notes_merge_abort(o))
 		ret +=3D error(_("failed to remove 'git notes merge' worktree"));
@@ -834,7 +834,8 @@ static int merge_commit(struct notes_merge_options *o)
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
=20
 	o->local_ref =3D local_ref_to_free =3D
-		resolve_refdup("NOTES_MERGE_REF", 0, &oid, NULL);
+		refs_resolve_refdup(get_main_ref_store(the_repository),
+				    "NOTES_MERGE_REF", 0, &oid, NULL);
 	if (!o->local_ref)
 		die(_("failed to resolve NOTES_MERGE_REF"));
=20
@@ -847,9 +848,10 @@ static int merge_commit(struct notes_merge_options *o)
 				   &pretty_ctx);
 	strbuf_trim(&msg);
 	strbuf_insertstr(&msg, 0, "notes: ");
-	update_ref(msg.buf, o->local_ref, &oid,
-		   is_null_oid(&parent_oid) ? NULL : &parent_oid,
-		   0, UPDATE_REFS_DIE_ON_ERR);
+	refs_update_ref(get_main_ref_store(the_repository), msg.buf,
+			o->local_ref, &oid,
+			is_null_oid(&parent_oid) ? NULL : &parent_oid,
+			0, UPDATE_REFS_DIE_ON_ERR);
=20
 	free_notes(t);
 	strbuf_release(&msg);
@@ -961,14 +963,16 @@ static int merge(int argc, const char **argv, const c=
har *prefix)
=20
 	if (result >=3D 0) /* Merge resulted (trivially) in result_oid */
 		/* Update default notes ref with new commit */
-		update_ref(msg.buf, default_notes_ref(), &result_oid, NULL, 0,
-			   UPDATE_REFS_DIE_ON_ERR);
+		refs_update_ref(get_main_ref_store(the_repository), msg.buf,
+				default_notes_ref(), &result_oid, NULL, 0,
+				UPDATE_REFS_DIE_ON_ERR);
 	else { /* Merge has unresolved conflicts */
 		struct worktree **worktrees;
 		const struct worktree *wt;
 		/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
-		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", &result_oid, NULL,
-			   0, UPDATE_REFS_DIE_ON_ERR);
+		refs_update_ref(get_main_ref_store(the_repository), msg.buf,
+				"NOTES_MERGE_PARTIAL", &result_oid, NULL,
+				0, UPDATE_REFS_DIE_ON_ERR);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
 		worktrees =3D get_worktrees();
 		wt =3D find_shared_symref(worktrees, "NOTES_MERGE_REF",
@@ -977,7 +981,7 @@ static int merge(int argc, const char **argv, const cha=
r *prefix)
 			die(_("a notes merge into %s is already in-progress at %s"),
 			    default_notes_ref(), wt->path);
 		free_worktrees(worktrees);
-		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
+		if (refs_create_symref(get_main_ref_store(the_repository), "NOTES_MERGE_=
REF", default_notes_ref(), NULL))
 			die(_("failed to store link to current notes ref (%s)"),
 			    default_notes_ref());
 		fprintf(stderr, _("Automatic notes merge failed. Fix conflicts in %s "
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index baf0090fc8..cd2396896d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -939,7 +939,8 @@ static struct object_entry **compute_write_order(void)
 	/*
 	 * Mark objects that are at the tip of tags.
 	 */
-	for_each_tag_ref(mark_tagged, NULL);
+	refs_for_each_tag_ref(get_main_ref_store(the_repository), mark_tagged,
+			      NULL);
=20
 	if (use_delta_islands) {
 		max_layers =3D compute_pack_layers(&to_pack);
@@ -4093,7 +4094,9 @@ static void mark_bitmap_preferred_tips(void)
 		return;
=20
 	for_each_string_list_item(item, preferred_tips) {
-		for_each_ref_in(item->string, mark_bitmap_preferred_tip, NULL);
+		refs_for_each_ref_in(get_main_ref_store(the_repository),
+				     item->string, mark_bitmap_preferred_tip,
+				     NULL);
 	}
 }
=20
@@ -4588,7 +4591,8 @@ int cmd_pack_objects(int argc, const char **argv, con=
st char *prefix)
 	}
 	cleanup_preferred_base();
 	if (include_tag && nr_result)
-		for_each_tag_ref(add_ref_tag, NULL);
+		refs_for_each_tag_ref(get_main_ref_store(the_repository),
+				      add_ref_tag, NULL);
 	stop_progress(&progress_state);
 	trace2_region_leave("pack-objects", "enumerate-objects",
 			    the_repository);
diff --git a/builtin/pull.c b/builtin/pull.c
index 72cbb76d52..26a0806969 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -611,7 +611,7 @@ static int pull_into_void(const struct object_id *merge=
_head,
 				  merge_head, 0))
 		return 1;
=20
-	if (update_ref("initial pull", "HEAD", merge_head, curr_head, 0, UPDATE_R=
EFS_DIE_ON_ERR))
+	if (refs_update_ref(get_main_ref_store(the_repository), "initial pull", "=
HEAD", merge_head, curr_head, 0, UPDATE_REFS_DIE_ON_ERR))
 		return 1;
=20
 	return 0;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 891f28468e..4399896d90 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -252,7 +252,7 @@ static int init_basic_state(struct replay_opts *opts, c=
onst char *head_name,
 	if (!is_directory(merge_dir()) && mkdir_in_gitdir(merge_dir()))
 		return error_errno(_("could not create temporary %s"), merge_dir());
=20
-	delete_reflog("REBASE_HEAD");
+	refs_delete_reflog(get_main_ref_store(the_repository), "REBASE_HEAD");
=20
 	interactive =3D fopen(path_interactive(), "w");
 	if (!interactive)
@@ -514,8 +514,10 @@ static int finish_rebase(struct rebase_options *opts)
 	struct strbuf dir =3D STRBUF_INIT;
 	int ret =3D 0;
=20
-	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
-	delete_ref(NULL, "AUTO_MERGE", NULL, REF_NO_DEREF);
+	refs_delete_ref(get_main_ref_store(the_repository), NULL,
+			"REBASE_HEAD", NULL, REF_NO_DEREF);
+	refs_delete_ref(get_main_ref_store(the_repository), NULL,
+			"AUTO_MERGE", NULL, REF_NO_DEREF);
 	apply_autostash(state_dir_path("autostash", opts));
 	/*
 	 * We ignore errors in 'git maintenance run --auto', since the
@@ -1623,7 +1625,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 		/* Is it a local branch? */
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "refs/heads/%s", branch_name);
-		if (!read_ref(buf.buf, &branch_oid)) {
+		if (!refs_read_ref(get_main_ref_store(the_repository), buf.buf, &branch_=
oid)) {
 			die_if_checked_out(buf.buf, 1);
 			options.head_name =3D xstrdup(buf.buf);
 			options.orig_head =3D
@@ -1640,8 +1642,8 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 	} else if (argc =3D=3D 0) {
 		/* Do not need to switch branches, we are already on it. */
 		options.head_name =3D
-			xstrdup_or_null(resolve_ref_unsafe("HEAD", 0, NULL,
-					 &flags));
+			xstrdup_or_null(refs_resolve_ref_unsafe(get_main_ref_store(the_reposito=
ry), "HEAD", 0, NULL,
+								&flags));
 		if (!options.head_name)
 			die(_("No such ref: %s"), "HEAD");
 		if (flags & REF_ISSYMREF) {
@@ -1735,7 +1737,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 			if (!(options.flags & REBASE_NO_QUIET))
 				; /* be quiet */
 			else if (!strcmp(branch_name, "HEAD") &&
-				 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
+				 refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", 0=
, NULL, &flag))
 				puts(_("HEAD is up to date."));
 			else
 				printf(_("Current branch %s is up to date.\n"),
@@ -1745,7 +1747,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 		} else if (!(options.flags & REBASE_NO_QUIET))
 			; /* be quiet */
 		else if (!strcmp(branch_name, "HEAD") &&
-			 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
+			 refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", 0,=
 NULL, &flag))
 			puts(_("HEAD is up to date, rebase forced."));
 		else
 			printf(_("Current branch %s is up to date, rebase "
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e8d7df14b6..dd0e22d729 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1566,7 +1566,7 @@ static const char *update(struct command *cmd, struct=
 shallow_info *si)
 		struct strbuf err =3D STRBUF_INIT;
 		if (!parse_object(the_repository, old_oid)) {
 			old_oid =3D NULL;
-			if (ref_exists(name)) {
+			if (refs_ref_exists(get_main_ref_store(the_repository), name)) {
 				rp_warning("allowing deletion of corrupt ref");
 			} else {
 				rp_warning("deleting a non-existent ref");
@@ -1693,7 +1693,8 @@ static void check_aliased_update(struct command *cmd,=
 struct string_list *list)
 	int flag;
=20
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
-	dst_name =3D resolve_ref_unsafe(buf.buf, 0, NULL, &flag);
+	dst_name =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+					   buf.buf, 0, NULL, &flag);
 	check_aliased_update_internal(cmd, list, dst_name, flag);
 	strbuf_release(&buf);
 }
@@ -1829,7 +1830,8 @@ static void execute_commands_non_atomic(struct comman=
d *commands,
 		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
 			continue;
=20
-		transaction =3D ref_transaction_begin(&err);
+		transaction =3D ref_store_transaction_begin(get_main_ref_store(the_repos=
itory),
+							  &err);
 		if (!transaction) {
 			rp_error("%s", err.buf);
 			strbuf_reset(&err);
@@ -1857,7 +1859,8 @@ static void execute_commands_atomic(struct command *c=
ommands,
 	struct strbuf err =3D STRBUF_INIT;
 	const char *reported_error =3D "atomic push failure";
=20
-	transaction =3D ref_transaction_begin(&err);
+	transaction =3D ref_store_transaction_begin(get_main_ref_store(the_reposi=
tory),
+						  &err);
 	if (!transaction) {
 		rp_error("%s", err.buf);
 		strbuf_reset(&err);
@@ -1983,7 +1986,9 @@ static void execute_commands(struct command *commands,
 	check_aliased_updates(commands);
=20
 	free(head_name_to_free);
-	head_name =3D head_name_to_free =3D resolve_refdup("HEAD", 0, NULL, NULL);
+	head_name =3D head_name_to_free =3D refs_resolve_refdup(get_main_ref_stor=
e(the_repository),
+							    "HEAD", 0, NULL,
+							    NULL);
=20
 	if (run_proc_receive &&
 	    run_proc_receive_hook(commands, push_options))
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 060eb3377e..b4650cea16 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -364,11 +364,12 @@ static int cmd_reflog_expire(int argc, const char **a=
rgv, const char *prefix)
 			};
=20
 			set_reflog_expiry_param(&cb.cmd,  item->string);
-			status |=3D reflog_expire(item->string, flags,
-						reflog_expiry_prepare,
-						should_prune_fn,
-						reflog_expiry_cleanup,
-						&cb);
+			status |=3D refs_reflog_expire(get_main_ref_store(the_repository),
+						     item->string, flags,
+						     reflog_expiry_prepare,
+						     should_prune_fn,
+						     reflog_expiry_cleanup,
+						     &cb);
 		}
 		string_list_clear(&collected.reflogs, 0);
 	}
@@ -382,11 +383,12 @@ static int cmd_reflog_expire(int argc, const char **a=
rgv, const char *prefix)
 			continue;
 		}
 		set_reflog_expiry_param(&cb.cmd, ref);
-		status |=3D reflog_expire(ref, flags,
-					reflog_expiry_prepare,
-					should_prune_fn,
-					reflog_expiry_cleanup,
-					&cb);
+		status |=3D refs_reflog_expire(get_main_ref_store(the_repository),
+					     ref, flags,
+					     reflog_expiry_prepare,
+					     should_prune_fn,
+					     reflog_expiry_cleanup,
+					     &cb);
 		free(ref);
 	}
 	return status;
@@ -437,7 +439,8 @@ static int cmd_reflog_exists(int argc, const char **arg=
v, const char *prefix)
 	refname =3D argv[0];
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die(_("invalid ref format: %s"), refname);
-	return !reflog_exists(refname);
+	return !refs_reflog_exists(get_main_ref_store(the_repository),
+				   refname);
 }
=20
 /*
diff --git a/builtin/remote.c b/builtin/remote.c
index 8412d12fa5..ff70d6835a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -240,7 +240,7 @@ static int add(int argc, const char **argv, const char =
*prefix)
 		strbuf_reset(&buf2);
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", name, master);
=20
-		if (create_symref(buf.buf, buf2.buf, "remote add"))
+		if (refs_create_symref(get_main_ref_store(the_repository), buf.buf, buf2=
=2Ebuf, "remote add"))
 			return error(_("Could not setup master '%s'"), master);
 	}
=20
@@ -376,7 +376,7 @@ static int get_ref_states(const struct ref *remote_refs=
, struct ref_states *stat
 	for (ref =3D fetch_map; ref; ref =3D ref->next) {
 		if (omit_name_by_refspec(ref->name, &states->remote->fetch))
 			string_list_append(&states->skipped, abbrev_branch(ref->name));
-		else if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
+		else if (!ref->peer_ref || !refs_ref_exists(get_main_ref_store(the_repos=
itory), ref->peer_ref->name))
 			string_list_append(&states->new_refs, abbrev_branch(ref->name));
 		else
 			string_list_append(&states->tracked, abbrev_branch(ref->name));
@@ -598,8 +598,9 @@ static int read_remote_branches(const char *refname,
 	strbuf_addf(&buf, "refs/remotes/%s/", rename->old_name);
 	if (starts_with(refname, buf.buf)) {
 		item =3D string_list_append(rename->remote_branches, refname);
-		symref =3D resolve_ref_unsafe(refname, RESOLVE_REF_READING,
-					    NULL, &flag);
+		symref =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+						 refname, RESOLVE_REF_READING,
+						 NULL, &flag);
 		if (symref && (flag & REF_ISSYMREF)) {
 			item->util =3D xstrdup(symref);
 			rename->symrefs_nr++;
@@ -789,7 +790,8 @@ static int mv(int argc, const char **argv, const char *=
prefix)
 	 * First remove symrefs, then rename the rest, finally create
 	 * the new symrefs.
 	 */
-	for_each_ref(read_remote_branches, &rename);
+	refs_for_each_ref(get_main_ref_store(the_repository),
+			  read_remote_branches, &rename);
 	if (show_progress) {
 		/*
 		 * Count symrefs twice, since "renaming" them is done by
@@ -805,7 +807,7 @@ static int mv(int argc, const char **argv, const char *=
prefix)
 		if (refs_read_symbolic_ref(get_main_ref_store(the_repository), item->str=
ing,
 					   &referent))
 			continue;
-		if (delete_ref(NULL, item->string, NULL, REF_NO_DEREF))
+		if (refs_delete_ref(get_main_ref_store(the_repository), NULL, item->stri=
ng, NULL, REF_NO_DEREF))
 			die(_("deleting '%s' failed"), item->string);
=20
 		strbuf_release(&referent);
@@ -823,7 +825,7 @@ static int mv(int argc, const char **argv, const char *=
prefix)
 		strbuf_reset(&buf2);
 		strbuf_addf(&buf2, "remote: renamed %s to %s",
 				item->string, buf.buf);
-		if (rename_ref(item->string, buf.buf, buf2.buf))
+		if (refs_rename_ref(get_main_ref_store(the_repository), item->string, bu=
f.buf, buf2.buf))
 			die(_("renaming '%s' failed"), item->string);
 		display_progress(progress, ++refs_renamed_nr);
 	}
@@ -843,7 +845,7 @@ static int mv(int argc, const char **argv, const char *=
prefix)
 		strbuf_reset(&buf3);
 		strbuf_addf(&buf3, "remote: renamed %s to %s",
 				item->string, buf.buf);
-		if (create_symref(buf.buf, buf2.buf, buf3.buf))
+		if (refs_create_symref(get_main_ref_store(the_repository), buf.buf, buf2=
=2Ebuf, buf3.buf))
 			die(_("creating '%s' failed"), buf.buf);
 		display_progress(progress, ++refs_renamed_nr);
 	}
@@ -917,11 +919,14 @@ static int rm(int argc, const char **argv, const char=
 *prefix)
 	 * refs, which are invalidated when deleting a branch.
 	 */
 	cb_data.remote =3D remote;
-	result =3D for_each_ref(add_branch_for_removal, &cb_data);
+	result =3D refs_for_each_ref(get_main_ref_store(the_repository),
+				   add_branch_for_removal, &cb_data);
 	strbuf_release(&buf);
=20
 	if (!result)
-		result =3D delete_refs("remote: remove", &branches, REF_NO_DEREF);
+		result =3D refs_delete_refs(get_main_ref_store(the_repository),
+					  "remote: remove", &branches,
+					  REF_NO_DEREF);
 	string_list_clear(&branches, 0);
=20
 	if (skipped.nr) {
@@ -1010,7 +1015,8 @@ static int get_remote_ref_states(const char *name,
 			get_push_ref_states(remote_refs, states);
 		transport_disconnect(transport);
 	} else {
-		for_each_ref(append_ref_to_tracked_list, states);
+		refs_for_each_ref(get_main_ref_store(the_repository),
+				  append_ref_to_tracked_list, states);
 		string_list_sort(&states->tracked);
 		get_push_ref_states_noquery(states);
 	}
@@ -1407,7 +1413,7 @@ static int set_head(int argc, const char **argv, cons=
t char *prefix)
 			head_name =3D xstrdup(states.heads.items[0].string);
 		free_remote_ref_states(&states);
 	} else if (opt_d && !opt_a && argc =3D=3D 1) {
-		if (delete_ref(NULL, buf.buf, NULL, REF_NO_DEREF))
+		if (refs_delete_ref(get_main_ref_store(the_repository), NULL, buf.buf, N=
ULL, REF_NO_DEREF))
 			result |=3D error(_("Could not delete %s"), buf.buf);
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
@@ -1415,9 +1421,9 @@ static int set_head(int argc, const char **argv, cons=
t char *prefix)
 	if (head_name) {
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
 		/* make sure it's valid */
-		if (!ref_exists(buf2.buf))
+		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
 			result |=3D error(_("Not a valid ref: %s"), buf2.buf);
-		else if (create_symref(buf.buf, buf2.buf, "remote set-head"))
+		else if (refs_create_symref(get_main_ref_store(the_repository), buf.buf,=
 buf2.buf, "remote set-head"))
 			result |=3D error(_("Could not setup %s"), buf.buf);
 		else if (opt_a)
 			printf("%s/HEAD set to %s\n", argv[0], head_name);
@@ -1457,7 +1463,8 @@ static int prune_remote(const char *remote, int dry_r=
un)
 	string_list_sort(&refs_to_prune);
=20
 	if (!dry_run)
-		result |=3D delete_refs("remote: prune", &refs_to_prune, 0);
+		result |=3D refs_delete_refs(get_main_ref_store(the_repository),
+					   "remote: prune", &refs_to_prune, 0);
=20
 	for_each_string_list_item(item, &states.stale) {
 		const char *refname =3D item->util;
diff --git a/builtin/repack.c b/builtin/repack.c
index 15e4cccc45..43491a4cbf 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -706,11 +706,14 @@ static void midx_snapshot_refs(struct tempfile *f)
=20
 		data.preferred =3D 1;
 		for_each_string_list_item(item, preferred)
-			for_each_ref_in(item->string, midx_snapshot_ref_one, &data);
+			refs_for_each_ref_in(get_main_ref_store(the_repository),
+					     item->string,
+					     midx_snapshot_ref_one, &data);
 		data.preferred =3D 0;
 	}
=20
-	for_each_ref(midx_snapshot_ref_one, &data);
+	refs_for_each_ref(get_main_ref_store(the_repository),
+			  midx_snapshot_ref_one, &data);
=20
 	if (close_tempfile_gently(f)) {
 		int save_errno =3D errno;
diff --git a/builtin/replace.c b/builtin/replace.c
index da59600ad2..bc2a948c80 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -130,7 +130,7 @@ static int for_each_replace_name(const char **argv, eac=
h_replace_name_fn fn)
 		strbuf_addstr(&ref, oid_to_hex(&oid));
 		full_hex =3D ref.buf + base_len;
=20
-		if (read_ref(ref.buf, &oid)) {
+		if (refs_read_ref(get_main_ref_store(the_repository), ref.buf, &oid)) {
 			error(_("replace ref '%s' not found"), full_hex);
 			had_error =3D 1;
 			continue;
@@ -145,7 +145,7 @@ static int for_each_replace_name(const char **argv, eac=
h_replace_name_fn fn)
 static int delete_replace_ref(const char *name, const char *ref,
 			      const struct object_id *oid)
 {
-	if (delete_ref(NULL, ref, oid, 0))
+	if (refs_delete_ref(get_main_ref_store(the_repository), NULL, ref, oid, 0=
))
 		return 1;
 	printf_ln(_("Deleted replace ref '%s'"), name);
 	return 0;
@@ -163,7 +163,7 @@ static int check_ref_valid(struct object_id *object,
 	if (check_refname_format(ref->buf, 0))
 		return error(_("'%s' is not a valid ref name"), ref->buf);
=20
-	if (read_ref(ref->buf, prev))
+	if (refs_read_ref(get_main_ref_store(the_repository), ref->buf, prev))
 		oidclr(prev);
 	else if (!force)
 		return error(_("replace ref '%s' already exists"), ref->buf);
@@ -198,7 +198,8 @@ static int replace_object_oid(const char *object_ref,
 		return -1;
 	}
=20
-	transaction =3D ref_transaction_begin(&err);
+	transaction =3D ref_store_transaction_begin(get_main_ref_store(the_reposi=
tory),
+						  &err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, repl, &prev,
 				   0, NULL, &err) ||
diff --git a/builtin/reset.c b/builtin/reset.c
index 1d62ff6332..bf23fe78fa 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -307,13 +307,16 @@ static int reset_refs(const char *rev, const struct o=
bject_id *oid)
 	if (!repo_get_oid(the_repository, "HEAD", &oid_orig)) {
 		orig =3D &oid_orig;
 		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
-		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
-			   UPDATE_REFS_MSG_ON_ERR);
+		refs_update_ref(get_main_ref_store(the_repository), msg.buf,
+				"ORIG_HEAD", orig, old_orig, 0,
+				UPDATE_REFS_MSG_ON_ERR);
 	} else if (old_orig)
-		delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
+		refs_delete_ref(get_main_ref_store(the_repository), NULL,
+				"ORIG_HEAD", old_orig, 0);
 	set_reflog_message(&msg, "updating HEAD", rev);
-	update_ref_status =3D update_ref(msg.buf, "HEAD", oid, orig, 0,
-				       UPDATE_REFS_MSG_ON_ERR);
+	update_ref_status =3D refs_update_ref(get_main_ref_store(the_repository),
+					    msg.buf, "HEAD", oid, orig, 0,
+					    UPDATE_REFS_MSG_ON_ERR);
 	strbuf_release(&msg);
 	return update_ref_status;
 }
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2b28d43939..5f79ec6338 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -160,8 +160,9 @@ static void show_rev(int type, const struct object_id *=
oid, const char *name)
 			case 1: /* happy */
 				if (abbrev_ref) {
 					char *old =3D full;
-					full =3D shorten_unambiguous_ref(full,
-						abbrev_ref_strict);
+					full =3D refs_shorten_unambiguous_ref(get_main_ref_store(the_reposito=
ry),
+									    full,
+									    abbrev_ref_strict);
 					free(old);
 				}
 				show_with_type(type, full);
@@ -599,9 +600,12 @@ static int opt_with_value(const char *arg, const char =
*opt, const char **value)
 static void handle_ref_opt(const char *pattern, const char *prefix)
 {
 	if (pattern)
-		for_each_glob_ref_in(show_reference, pattern, prefix, NULL);
+		refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
+					  show_reference, pattern, prefix,
+					  NULL);
 	else
-		for_each_ref_in(prefix, show_reference, NULL);
+		refs_for_each_ref_in(get_main_ref_store(the_repository),
+				     prefix, show_reference, NULL);
 	clear_ref_exclusions(&ref_excludes);
 }
=20
@@ -898,7 +902,8 @@ int cmd_rev_parse(int argc, const char **argv, const ch=
ar *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
-				for_each_ref(show_reference, NULL);
+				refs_for_each_ref(get_main_ref_store(the_repository),
+						  show_reference, NULL);
 				clear_ref_exclusions(&ref_excludes);
 				continue;
 			}
@@ -908,8 +913,14 @@ int cmd_rev_parse(int argc, const char **argv, const c=
har *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
-				for_each_fullref_in("refs/bisect/bad", NULL, show_reference, NULL);
-				for_each_fullref_in("refs/bisect/good", NULL, anti_reference, NULL);
+				refs_for_each_fullref_in(get_main_ref_store(the_repository),
+							 "refs/bisect/bad",
+							 NULL, show_reference,
+							 NULL);
+				refs_for_each_fullref_in(get_main_ref_store(the_repository),
+							 "refs/bisect/good",
+							 NULL, anti_reference,
+							 NULL);
 				continue;
 			}
 			if (opt_with_value(arg, "--branches", &arg)) {
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index b01ec761d2..d72f4cb98d 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -479,13 +479,15 @@ static void snarf_refs(int head, int remotes)
 	if (head) {
 		int orig_cnt =3D ref_name_cnt;
=20
-		for_each_ref(append_head_ref, NULL);
+		refs_for_each_ref(get_main_ref_store(the_repository),
+				  append_head_ref, NULL);
 		sort_ref_range(orig_cnt, ref_name_cnt);
 	}
 	if (remotes) {
 		int orig_cnt =3D ref_name_cnt;
=20
-		for_each_ref(append_remote_ref, NULL);
+		refs_for_each_ref(get_main_ref_store(the_repository),
+				  append_remote_ref, NULL);
 		sort_ref_range(orig_cnt, ref_name_cnt);
 	}
 }
@@ -549,7 +551,8 @@ static void append_one_rev(const char *av)
=20
 		match_ref_pattern =3D av;
 		match_ref_slash =3D count_slashes(av);
-		for_each_ref(append_matching_ref, NULL);
+		refs_for_each_ref(get_main_ref_store(the_repository),
+				  append_matching_ref, NULL);
 		if (saved_matches =3D=3D ref_name_cnt &&
 		    ref_name_cnt < MAX_REVS)
 			error(_("no matching refs with %s"), av);
@@ -740,9 +743,11 @@ int cmd_show_branch(int ac, const char **av, const cha=
r *prefix)
 		if (ac =3D=3D 0) {
 			static const char *fake_av[2];
=20
-			fake_av[0] =3D resolve_refdup("HEAD",
-						    RESOLVE_REF_READING, &oid,
-						    NULL);
+			fake_av[0] =3D refs_resolve_refdup(get_main_ref_store(the_repository),
+							 "HEAD",
+							 RESOLVE_REF_READING,
+							 &oid,
+							 NULL);
 			fake_av[1] =3D NULL;
 			av =3D fake_av;
 			ac =3D 1;
@@ -815,8 +820,9 @@ int cmd_show_branch(int ac, const char **av, const char=
 *prefix)
 			snarf_refs(all_heads, all_remotes);
 	}
=20
-	head =3D resolve_refdup("HEAD", RESOLVE_REF_READING,
-			      &head_oid, NULL);
+	head =3D refs_resolve_refdup(get_main_ref_store(the_repository), "HEAD",
+				   RESOLVE_REF_READING,
+				   &head_oid, NULL);
=20
 	if (with_current_branch && head) {
 		int has_head =3D 0;
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 3c521dbfd4..151ef35134 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -129,7 +129,8 @@ static int cmd_show_ref__exclude_existing(const struct =
exclude_existing_options
 	char buf[1024];
 	int patternlen =3D opts->pattern ? strlen(opts->pattern) : 0;
=20
-	for_each_ref(add_existing, &existing_refs);
+	refs_for_each_ref(get_main_ref_store(the_repository), add_existing,
+			  &existing_refs);
 	while (fgets(buf, sizeof(buf), stdin)) {
 		char *ref;
 		int len =3D strlen(buf);
@@ -173,7 +174,7 @@ static int cmd_show_ref__verify(const struct show_one_o=
ptions *show_one_opts,
 		struct object_id oid;
=20
 		if ((starts_with(*refs, "refs/") || refname_is_safe(*refs)) &&
-		    !read_ref(*refs, &oid)) {
+		    !refs_read_ref(get_main_ref_store(the_repository), *refs, &oid)) {
 			show_one(show_one_opts, *refs, &oid);
 		}
 		else if (!show_one_opts->quiet)
@@ -205,14 +206,20 @@ static int cmd_show_ref__patterns(const struct patter=
ns_options *opts,
 		show_ref_data.patterns =3D patterns;
=20
 	if (opts->show_head)
-		head_ref(show_ref, &show_ref_data);
+		refs_head_ref(get_main_ref_store(the_repository), show_ref,
+			      &show_ref_data);
 	if (opts->heads_only || opts->tags_only) {
 		if (opts->heads_only)
-			for_each_fullref_in("refs/heads/", NULL, show_ref, &show_ref_data);
+			refs_for_each_fullref_in(get_main_ref_store(the_repository),
+						 "refs/heads/", NULL,
+						 show_ref, &show_ref_data);
 		if (opts->tags_only)
-			for_each_fullref_in("refs/tags/", NULL, show_ref, &show_ref_data);
+			refs_for_each_fullref_in(get_main_ref_store(the_repository),
+						 "refs/tags/", NULL, show_ref,
+						 &show_ref_data);
 	} else {
-		for_each_ref(show_ref, &show_ref_data);
+		refs_for_each_ref(get_main_ref_store(the_repository),
+				  show_ref, &show_ref_data);
 	}
 	if (!show_ref_data.found_match)
 		return 1;
diff --git a/builtin/stash.c b/builtin/stash.c
index 7751bca868..0a15ce287e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -196,7 +196,7 @@ static int get_stash_info(struct stash_info *info, int =
argc, const char **argv)
 		commit =3D argv[0];
=20
 	if (!commit) {
-		if (!ref_exists(ref_stash)) {
+		if (!refs_ref_exists(get_main_ref_store(the_repository), ref_stash)) {
 			fprintf_ln(stderr, _("No stash entries found."));
 			return -1;
 		}
@@ -244,7 +244,8 @@ static int do_clear_stash(void)
 	if (repo_get_oid(the_repository, ref_stash, &obj))
 		return 0;
=20
-	return delete_ref(NULL, ref_stash, &obj, 0);
+	return refs_delete_ref(get_main_ref_store(the_repository), NULL,
+			       ref_stash, &obj, 0);
 }
=20
 static int clear_stash(int argc, const char **argv, const char *prefix)
@@ -687,7 +688,8 @@ static int reject_reflog_ent(struct object_id *ooid UNU=
SED,
=20
 static int reflog_is_empty(const char *refname)
 {
-	return !for_each_reflog_ent(refname, reject_reflog_ent, NULL);
+	return !refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+					 refname, reject_reflog_ent, NULL);
 }
=20
 static int do_drop_stash(struct stash_info *info, int quiet)
@@ -824,7 +826,7 @@ static int list_stash(int argc, const char **argv, cons=
t char *prefix)
 			     git_stash_list_usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT);
=20
-	if (!ref_exists(ref_stash))
+	if (!refs_ref_exists(get_main_ref_store(the_repository), ref_stash))
 		return 0;
=20
 	cp.git_cmd =3D 1;
@@ -998,10 +1000,10 @@ static int do_store_stash(const struct object_id *w_=
commit, const char *stash_ms
 	if (!stash_msg)
 		stash_msg =3D "Created via \"git stash store\".";
=20
-	if (update_ref(stash_msg, ref_stash, w_commit, NULL,
-		       REF_FORCE_CREATE_REFLOG,
-		       quiet ? UPDATE_REFS_QUIET_ON_ERR :
-		       UPDATE_REFS_MSG_ON_ERR)) {
+	if (refs_update_ref(get_main_ref_store(the_repository), stash_msg, ref_st=
ash, w_commit, NULL,
+			    REF_FORCE_CREATE_REFLOG,
+			    quiet ? UPDATE_REFS_QUIET_ON_ERR :
+			    UPDATE_REFS_MSG_ON_ERR)) {
 		if (!quiet) {
 			fprintf_ln(stderr, _("Cannot update %s with %s"),
 				   ref_stash, oid_to_hex(w_commit));
@@ -1384,7 +1386,8 @@ static int do_create_stash(const struct pathspec *ps,=
 struct strbuf *stash_msg_b
 		goto done;
 	}
=20
-	branch_ref =3D resolve_ref_unsafe("HEAD", 0, NULL, &flags);
+	branch_ref =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+					     "HEAD", 0, NULL, &flags);
 	if (flags & REF_ISSYMREF)
 		skip_prefix(branch_ref, "refs/heads/", &branch_name);
 	head_short_sha1 =3D repo_find_unique_abbrev(the_repository,
@@ -1566,7 +1569,7 @@ static int do_push_stash(const struct pathspec *ps, c=
onst char *stash_msg, int q
 		goto done;
 	}
=20
-	if (!reflog_exists(ref_stash) && do_clear_stash()) {
+	if (!refs_reflog_exists(get_main_ref_store(the_repository), ref_stash) &&=
 do_clear_stash()) {
 		ret =3D -1;
 		if (!quiet)
 			fprintf_ln(stderr, _("Cannot initialize stash"));
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e4e18adb57..4be79eab23 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2390,7 +2390,9 @@ static int remote_submodule_branch(const char *path, =
const char **branch)
 	}
=20
 	if (!strcmp(*branch, ".")) {
-		const char *refname =3D resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+		const char *refname =3D refs_resolve_ref_unsafe(get_main_ref_store(the_r=
epository),
+							      "HEAD", 0, NULL,
+							      NULL);
=20
 		if (!refname)
 			return die_message(_("No such ref: %s"), "HEAD");
@@ -2796,7 +2798,8 @@ static int push_check(int argc, const char **argv, co=
nst char *prefix UNUSED)
 	argv++;
 	argc--;
 	/* Get the submodule's head ref and determine if it is detached */
-	head =3D resolve_refdup("HEAD", 0, &head_oid, NULL);
+	head =3D refs_resolve_refdup(get_main_ref_store(the_repository), "HEAD",
+				   0, &head_oid, NULL);
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
 	if (!strcmp(head, "HEAD"))
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index c9defe4d2e..b2b0a41fb6 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -18,7 +18,8 @@ static int check_symref(const char *HEAD, int quiet, int =
shorten, int recurse, i
 	const char *refname;
=20
 	resolve_flags =3D (recurse ? 0 : RESOLVE_REF_NO_RECURSE);
-	refname =3D resolve_ref_unsafe(HEAD, resolve_flags, NULL, &flag);
+	refname =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+					  HEAD, resolve_flags, NULL, &flag);
=20
 	if (!refname)
 		die("No such ref: %s", HEAD);
@@ -31,7 +32,9 @@ static int check_symref(const char *HEAD, int quiet, int =
shorten, int recurse, i
 	if (print) {
 		char *to_free =3D NULL;
 		if (shorten)
-			refname =3D to_free =3D shorten_unambiguous_ref(refname, 0);
+			refname =3D to_free =3D refs_shorten_unambiguous_ref(get_main_ref_store=
(the_repository),
+									 refname,
+									 0);
 		puts(refname);
 		free(to_free);
 	}
@@ -66,7 +69,8 @@ int cmd_symbolic_ref(int argc, const char **argv, const c=
har *prefix)
 			die("Cannot delete %s, not a symbolic ref", argv[0]);
 		if (!strcmp(argv[0], "HEAD"))
 			die("deleting '%s' is not allowed", argv[0]);
-		return delete_ref(NULL, argv[0], NULL, REF_NO_DEREF);
+		return refs_delete_ref(get_main_ref_store(the_repository),
+				       NULL, argv[0], NULL, REF_NO_DEREF);
 	}
=20
 	switch (argc) {
@@ -79,7 +83,8 @@ int cmd_symbolic_ref(int argc, const char **argv, const c=
har *prefix)
 			die("Refusing to point HEAD outside of refs/");
 		if (check_refname_format(argv[1], REFNAME_ALLOW_ONELEVEL) < 0)
 			die("Refusing to set '%s' to invalid ref '%s'", argv[0], argv[1]);
-		ret =3D !!create_symref(argv[0], argv[1], msg);
+		ret =3D !!refs_create_symref(get_main_ref_store(the_repository),
+					   argv[0], argv[1], msg);
 		break;
 	default:
 		usage_with_options(git_symbolic_ref_usage, options);
diff --git a/builtin/tag.c b/builtin/tag.c
index 9a33cb50b4..424a03ad18 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -87,7 +87,7 @@ static int for_each_tag_name(const char **argv, each_tag_=
name_fn fn,
 	for (p =3D argv; *p; p++) {
 		strbuf_reset(&ref);
 		strbuf_addf(&ref, "refs/tags/%s", *p);
-		if (read_ref(ref.buf, &oid)) {
+		if (refs_read_ref(get_main_ref_store(the_repository), ref.buf, &oid)) {
 			error(_("tag '%s' not found."), *p);
 			had_error =3D 1;
 			continue;
@@ -116,13 +116,13 @@ static int delete_tags(const char **argv)
 	struct string_list_item *item;
=20
 	result =3D for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
-	if (delete_refs(NULL, &refs_to_delete, REF_NO_DEREF))
+	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_d=
elete, REF_NO_DEREF))
 		result =3D 1;
=20
 	for_each_string_list_item(item, &refs_to_delete) {
 		const char *name =3D item->string;
 		struct object_id *oid =3D item->util;
-		if (!ref_exists(name))
+		if (!refs_ref_exists(get_main_ref_store(the_repository), name))
 			printf(_("Deleted tag '%s' (was %s)\n"),
 				item->string + 10,
 				repo_find_unique_abbrev(the_repository, oid, DEFAULT_ABBREV));
@@ -630,7 +630,7 @@ int cmd_tag(int argc, const char **argv, const char *pr=
efix)
 	if (strbuf_check_tag_ref(&ref, tag))
 		die(_("'%s' is not a valid tag name."), tag);
=20
-	if (read_ref(ref.buf, &prev))
+	if (refs_read_ref(get_main_ref_store(the_repository), ref.buf, &prev))
 		oidclr(&prev);
 	else if (!force)
 		die(_("tag '%s' already exists"), tag);
@@ -657,7 +657,8 @@ int cmd_tag(int argc, const char **argv, const char *pr=
efix)
 			   path);
 	}
=20
-	transaction =3D ref_transaction_begin(&err);
+	transaction =3D ref_store_transaction_begin(get_main_ref_store(the_reposi=
tory),
+						  &err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, &object, &prev,
 				   create_reflog ? REF_FORCE_CREATE_REFLOG : 0,
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7bcaa1476c..9c9c24b831 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -682,7 +682,7 @@ static int do_reupdate(const char **paths,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, paths);
=20
-	if (read_ref("HEAD", &head_oid))
+	if (refs_read_ref(get_main_ref_store(the_repository), "HEAD", &head_oid))
 		/* If there is no HEAD, that means it is an initial
 		 * commit.  Update everything in the index.
 		 */
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index e46afbc46d..896bac36ab 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -397,7 +397,8 @@ static void update_refs_stdin(void)
 	struct ref_transaction *transaction;
 	int i, j;
=20
-	transaction =3D ref_transaction_begin(&err);
+	transaction =3D ref_store_transaction_begin(get_main_ref_store(the_reposi=
tory),
+						  &err);
 	if (!transaction)
 		die("%s", err.buf);
=20
@@ -464,7 +465,8 @@ static void update_refs_stdin(void)
 			 * get a "start".
 			 */
 			state =3D cmd->state;
-			transaction =3D ref_transaction_begin(&err);
+			transaction =3D ref_store_transaction_begin(get_main_ref_store(the_repo=
sitory),
+								  &err);
 			if (!transaction)
 				die("%s", err.buf);
=20
@@ -571,11 +573,14 @@ int cmd_update_ref(int argc, const char **argv, const=
 char *prefix)
 		 * For purposes of backwards compatibility, we treat
 		 * NULL_SHA1 as "don't care" here:
 		 */
-		return delete_ref(msg, refname,
-				  (oldval && !is_null_oid(&oldoid)) ? &oldoid : NULL,
-				  default_flags);
+		return refs_delete_ref(get_main_ref_store(the_repository),
+				       msg, refname,
+				       (oldval && !is_null_oid(&oldoid)) ? &oldoid : NULL,
+				       default_flags);
 	else
-		return update_ref(msg, refname, &oid, oldval ? &oldoid : NULL,
-				  default_flags | create_reflog_flag,
-				  UPDATE_REFS_DIE_ON_ERR);
+		return refs_update_ref(get_main_ref_store(the_repository),
+				       msg, refname, &oid,
+				       oldval ? &oldoid : NULL,
+				       default_flags | create_reflog_flag,
+				       UPDATE_REFS_DIE_ON_ERR);
 }
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7c6c72536b..108cfa156a 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -433,7 +433,7 @@ static int add_worktree(const char *path, const char *r=
efname,
=20
 	/* is 'refname' a branch or commit? */
 	if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
-	    ref_exists(symref.buf)) {
+	    refs_ref_exists(get_main_ref_store(the_repository), symref.buf)) {
 		is_branch =3D 1;
 		if (!opts->force)
 			die_if_checked_out(symref.buf, 0);
@@ -605,7 +605,7 @@ static void print_preparing_worktree_line(int detach,
 	} else {
 		struct strbuf s =3D STRBUF_INIT;
 		if (!detach && !strbuf_check_branch_ref(&s, branch) &&
-		    ref_exists(s.buf))
+		    refs_ref_exists(get_main_ref_store(the_repository), s.buf))
 			fprintf_ln(stderr, _("Preparing worktree (checking out '%s')"),
 				  branch);
 		else {
@@ -647,9 +647,9 @@ static int first_valid_ref(const char *refname UNUSED,
  */
 static int can_use_local_refs(const struct add_opts *opts)
 {
-	if (head_ref(first_valid_ref, NULL)) {
+	if (refs_head_ref(get_main_ref_store(the_repository), first_valid_ref, NU=
LL)) {
 		return 1;
-	} else if (for_each_branch_ref(first_valid_ref, NULL)) {
+	} else if (refs_for_each_branch_ref(get_main_ref_store(the_repository), f=
irst_valid_ref, NULL)) {
 		if (!opts->quiet) {
 			struct strbuf path =3D STRBUF_INIT;
 			struct strbuf contents =3D STRBUF_INIT;
@@ -689,7 +689,7 @@ static int can_use_remote_refs(const struct add_opts *o=
pts)
 {
 	if (!guess_remote) {
 		return 0;
-	} else if (for_each_remote_ref(first_valid_ref, NULL)) {
+	} else if (refs_for_each_remote_ref(get_main_ref_store(the_repository), f=
irst_valid_ref, NULL)) {
 		return 1;
 	} else if (!opts->force && remote_get(NULL)) {
 		die(_("No local or remote refs exist despite at least one remote\n"
@@ -747,7 +747,8 @@ static const char *dwim_branch(const char *path, const =
char **new_branch)
 	UNLEAK(branchname);
=20
 	branch_exists =3D !strbuf_check_branch_ref(&ref, branchname) &&
-			ref_exists(ref.buf);
+			refs_ref_exists(get_main_ref_store(the_repository),
+					ref.buf);
 	strbuf_release(&ref);
 	if (branch_exists)
 		return branchname;
@@ -838,7 +839,7 @@ static int add(int ac, const char **av, const char *pre=
fix)
=20
 		if (!opts.force &&
 		    !strbuf_check_branch_ref(&symref, new_branch) &&
-		    ref_exists(symref.buf))
+		    refs_ref_exists(get_main_ref_store(the_repository), symref.buf))
 			die_if_checked_out(symref.buf, 0);
 		strbuf_release(&symref);
 	}
@@ -974,7 +975,9 @@ static void show_worktree(struct worktree *wt, int path=
_maxlen, int abbrev_len)
 		if (wt->is_detached)
 			strbuf_addstr(&sb, "(detached HEAD)");
 		else if (wt->head_ref) {
-			char *ref =3D shorten_unambiguous_ref(wt->head_ref, 0);
+			char *ref =3D refs_shorten_unambiguous_ref(get_main_ref_store(the_repos=
itory),
+								 wt->head_ref,
+								 0);
 			strbuf_addf(&sb, "[%s]", ref);
 			free(ref);
 		} else
diff --git a/bundle-uri.c b/bundle-uri.c
index ca32050a78..91b3319a5c 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -395,11 +395,13 @@ static int unbundle_from_file(struct repository *r, c=
onst char *file)
 		strbuf_setlen(&bundle_ref, bundle_prefix_len);
 		strbuf_addstr(&bundle_ref, branch_name);
=20
-		has_old =3D !read_ref(bundle_ref.buf, &old_oid);
-		update_ref("fetched bundle", bundle_ref.buf, oid,
-			   has_old ? &old_oid : NULL,
-			   REF_SKIP_OID_VERIFICATION,
-			   UPDATE_REFS_MSG_ON_ERR);
+		has_old =3D !refs_read_ref(get_main_ref_store(the_repository),
+					 bundle_ref.buf, &old_oid);
+		refs_update_ref(get_main_ref_store(the_repository),
+				"fetched bundle", bundle_ref.buf, oid,
+				has_old ? &old_oid : NULL,
+				REF_SKIP_OID_VERIFICATION,
+				UPDATE_REFS_MSG_ON_ERR);
 	}
=20
 	bundle_header_release(&header);
diff --git a/bundle.c b/bundle.c
index a9744da255..95367c2d0a 100644
--- a/bundle.c
+++ b/bundle.c
@@ -389,7 +389,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_=
info *revs)
 		if (repo_dwim_ref(the_repository, e->name, strlen(e->name),
 				  &oid, &ref, 0) !=3D 1)
 			goto skip_write_ref;
-		if (read_ref_full(e->name, RESOLVE_REF_READING, &oid, &flag))
+		if (refs_read_ref_full(get_main_ref_store(the_repository), e->name, RESO=
LVE_REF_READING, &oid, &flag))
 			flag =3D 0;
 		display_ref =3D (flag & REF_ISSYMREF) ? e->name : ref;
=20
diff --git a/commit-graph.c b/commit-graph.c
index 45417d7412..c4c156ff52 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1845,7 +1845,8 @@ int write_commit_graph_reachable(struct object_direct=
ory *odb,
 		data.progress =3D start_delayed_progress(
 			_("Collecting referenced commits"), 0);
=20
-	for_each_ref(add_ref_to_set, &data);
+	refs_for_each_ref(get_main_ref_store(the_repository), add_ref_to_set,
+			  &data);
=20
 	stop_progress(&data.progress);
=20
diff --git a/commit.c b/commit.c
index 1a479a997c..1d08951007 100644
--- a/commit.c
+++ b/commit.c
@@ -1070,7 +1070,8 @@ struct commit *get_fork_point(const char *refname, st=
ruct commit *commit)
=20
 	memset(&revs, 0, sizeof(revs));
 	revs.initial =3D 1;
-	for_each_reflog_ent(full_refname, collect_one_reflog_ent, &revs);
+	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+				 full_refname, collect_one_reflog_ent, &revs);
=20
 	if (!revs.nr)
 		add_one_commit(&oid, &revs);
diff --git a/config.c b/config.c
index ae3652b08f..e8f30dfe83 100644
--- a/config.c
+++ b/config.c
@@ -303,7 +303,8 @@ static int include_by_branch(const char *cond, size_t c=
ond_len)
 	int ret;
 	struct strbuf pattern =3D STRBUF_INIT;
 	const char *refname =3D !the_repository->gitdir ?
-		NULL : resolve_ref_unsafe("HEAD", 0, NULL, &flags);
+		NULL : refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+					       "HEAD", 0, NULL, &flags);
 	const char *shortname;
=20
 	if (!refname || !(flags & REF_ISSYMREF)	||
diff --git a/delta-islands.c b/delta-islands.c
index f7e079425f..4ac3c10551 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -488,7 +488,8 @@ void load_delta_islands(struct repository *r, int progr=
ess)
=20
 	git_config(island_config_callback, &ild);
 	ild.remote_islands =3D kh_init_str();
-	for_each_ref(find_island_for_ref, &ild);
+	refs_for_each_ref(get_main_ref_store(the_repository),
+			  find_island_for_ref, &ild);
 	free_config_regexes(&ild);
 	deduplicate_islands(ild.remote_islands, r);
 	free_remote_islands(ild.remote_islands);
diff --git a/fetch-pack.c b/fetch-pack.c
index 091f9a80a9..8e8f3bba32 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -290,7 +290,8 @@ static void mark_tips(struct fetch_negotiator *negotiat=
or,
 	int i;
=20
 	if (!negotiation_tips) {
-		for_each_rawref(rev_list_insert_ref_oid, negotiator);
+		refs_for_each_rawref(get_main_ref_store(the_repository),
+				     rev_list_insert_ref_oid, negotiator);
 		return;
 	}
=20
@@ -793,7 +794,8 @@ static void mark_complete_and_common_ref(struct fetch_n=
egotiator *negotiator,
 	 */
 	trace2_region_enter("fetch-pack", "mark_complete_local_refs", NULL);
 	if (!args->deepen) {
-		for_each_rawref(mark_complete_oid, NULL);
+		refs_for_each_rawref(get_main_ref_store(the_repository),
+				     mark_complete_oid, NULL);
 		for_each_cached_alternate(NULL, mark_alternate_complete);
 		commit_list_sort_by_date(&complete);
 		if (cutoff)
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index ae201e21db..7d144b803a 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -661,7 +661,9 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
=20
 	/* learn the commit that we merge into and the current branch name */
 	current_branch =3D current_branch_to_free =3D
-		resolve_refdup("HEAD", RESOLVE_REF_READING, &head_oid, NULL);
+		refs_resolve_refdup(get_main_ref_store(the_repository),
+				    "HEAD", RESOLVE_REF_READING, &head_oid,
+				    NULL);
 	if (!current_branch)
 		die("No current branch");
=20
diff --git a/help.c b/help.c
index 2dbe57b413..1d057aa607 100644
--- a/help.c
+++ b/help.c
@@ -800,7 +800,7 @@ static int append_similar_ref(const char *refname,
 	if (starts_with(refname, "refs/remotes/") &&
 	    !strcmp(branch, cb->base_ref))
 		string_list_append_nodup(cb->similar_refs,
-					 shorten_unambiguous_ref(refname, 1));
+					 refs_shorten_unambiguous_ref(get_main_ref_store(the_repository), ref=
name, 1));
 	return 0;
 }
=20
@@ -811,7 +811,8 @@ static struct string_list guess_refs(const char *ref)
=20
 	ref_cb.base_ref =3D ref;
 	ref_cb.similar_refs =3D &similar_refs;
-	for_each_ref(append_similar_ref, &ref_cb);
+	refs_for_each_ref(get_main_ref_store(the_repository),
+			  append_similar_ref, &ref_cb);
 	return similar_refs;
 }
=20
diff --git a/http-backend.c b/http-backend.c
index 1ed1e29d07..5b65287ac9 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -559,7 +559,8 @@ static void get_info_refs(struct strbuf *hdr, char *arg=
 UNUSED)
=20
 	} else {
 		select_getanyfile(hdr);
-		for_each_namespaced_ref(NULL, show_text_ref, &buf);
+		refs_for_each_namespaced_ref(get_main_ref_store(the_repository),
+					     NULL, show_text_ref, &buf);
 		send_strbuf(hdr, "text/plain", &buf);
 	}
 	strbuf_release(&buf);
@@ -571,9 +572,10 @@ static int show_head_ref(const char *refname, const st=
ruct object_id *oid,
 	struct strbuf *buf =3D cb_data;
=20
 	if (flag & REF_ISSYMREF) {
-		const char *target =3D resolve_ref_unsafe(refname,
-							RESOLVE_REF_READING,
-							NULL, NULL);
+		const char *target =3D refs_resolve_ref_unsafe(get_main_ref_store(the_re=
pository),
+							     refname,
+							     RESOLVE_REF_READING,
+							     NULL, NULL);
=20
 		if (target)
 			strbuf_addf(buf, "ref: %s\n", strip_namespace(target));
@@ -589,7 +591,8 @@ static void get_head(struct strbuf *hdr, char *arg UNUS=
ED)
 	struct strbuf buf =3D STRBUF_INIT;
=20
 	select_getanyfile(hdr);
-	head_ref_namespaced(show_head_ref, &buf);
+	refs_head_ref_namespaced(get_main_ref_store(the_repository),
+				 show_head_ref, &buf);
 	send_strbuf(hdr, "text/plain", &buf);
 	strbuf_release(&buf);
 }
diff --git a/log-tree.c b/log-tree.c
index 16031b44e7..41416de4e3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -232,8 +232,10 @@ void load_ref_decorations(struct decoration_filter *fi=
lter, int flags)
 		}
 		decoration_loaded =3D 1;
 		decoration_flags =3D flags;
-		for_each_ref(add_ref_decoration, filter);
-		head_ref(add_ref_decoration, filter);
+		refs_for_each_ref(get_main_ref_store(the_repository),
+				  add_ref_decoration, filter);
+		refs_head_ref(get_main_ref_store(the_repository),
+			      add_ref_decoration, filter);
 		for_each_commit_graft(add_graft_decoration, filter);
 	}
 }
@@ -277,7 +279,8 @@ static const struct name_decoration *current_pointed_by=
_HEAD(const struct name_d
 		return NULL;
=20
 	/* Now resolve and find the matching current branch */
-	branch_name =3D resolve_ref_unsafe("HEAD", 0, NULL, &rru_flags);
+	branch_name =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository=
),
+					      "HEAD", 0, NULL, &rru_flags);
 	if (!branch_name || !(rru_flags & REF_ISSYMREF))
 		return NULL;
=20
diff --git a/ls-refs.c b/ls-refs.c
index 819cbefee3..8e3ffff811 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -95,9 +95,11 @@ static int send_ref(const char *refname, const struct ob=
ject_id *oid,
 		strbuf_addf(&data->buf, "unborn %s", refname_nons);
 	if (data->symrefs && flag & REF_ISSYMREF) {
 		struct object_id unused;
-		const char *symref_target =3D resolve_ref_unsafe(refname, 0,
-							       &unused,
-							       &flag);
+		const char *symref_target =3D refs_resolve_ref_unsafe(get_main_ref_store=
(the_repository),
+								    refname,
+								    0,
+								    &unused,
+								    &flag);
=20
 		if (!symref_target)
 			die("'%s' is a symref but it is not?", refname);
@@ -126,7 +128,7 @@ static void send_possibly_unborn_head(struct ls_refs_da=
ta *data)
 	int oid_is_null;
=20
 	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
-	if (!resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag))
+	if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), namespac=
ed.buf, 0, &oid, &flag))
 		return; /* bad ref */
 	oid_is_null =3D is_null_oid(&oid);
 	if (!oid_is_null ||
diff --git a/midx-write.c b/midx-write.c
index 65e69d2de7..9d096d5a28 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -755,7 +755,8 @@ static struct commit **find_commits_for_midx_bitmap(uin=
t32_t *indexed_commits_nr
 		read_refs_snapshot(refs_snapshot, &revs);
 	} else {
 		setup_revisions(0, NULL, &revs, NULL);
-		for_each_ref(add_ref_to_pending, &revs);
+		refs_for_each_ref(get_main_ref_store(the_repository),
+				  add_ref_to_pending, &revs);
 	}
=20
 	/*
diff --git a/negotiator/default.c b/negotiator/default.c
index 9a5b696327..518b3c43b2 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -192,6 +192,7 @@ void default_negotiator_init(struct fetch_negotiator *n=
egotiator)
 	ns->rev_list.compare =3D compare_commits_by_commit_date;
=20
 	if (marked)
-		for_each_ref(clear_marks, NULL);
+		refs_for_each_ref(get_main_ref_store(the_repository),
+				  clear_marks, NULL);
 	marked =3D 1;
 }
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 5b91520430..b7e008c2fd 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -261,6 +261,7 @@ void skipping_negotiator_init(struct fetch_negotiator *=
negotiator)
 	data->rev_list.compare =3D compare;
=20
 	if (marked)
-		for_each_ref(clear_marks, NULL);
+		refs_for_each_ref(get_main_ref_store(the_repository),
+				  clear_marks, NULL);
 	marked =3D 1;
 }
diff --git a/notes-cache.c b/notes-cache.c
index 0e1d5b1ac7..038db01ca0 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -17,7 +17,7 @@ static int notes_cache_match_validity(struct repository *=
r,
 	struct strbuf msg =3D STRBUF_INIT;
 	int ret;
=20
-	if (read_ref(ref, &oid) < 0)
+	if (refs_read_ref(get_main_ref_store(the_repository), ref, &oid) < 0)
 		return 0;
=20
 	commit =3D lookup_commit_reference_gently(r, &oid, 1);
@@ -66,8 +66,8 @@ int notes_cache_write(struct notes_cache *c)
 	if (commit_tree(c->validity, strlen(c->validity), &tree_oid, NULL,
 			&commit_oid, NULL, NULL) < 0)
 		return -1;
-	if (update_ref("update notes cache", c->tree.update_ref, &commit_oid,
-		       NULL, 0, UPDATE_REFS_QUIET_ON_ERR) < 0)
+	if (refs_update_ref(get_main_ref_store(the_repository), "update notes cac=
he", c->tree.update_ref, &commit_oid,
+			    NULL, 0, UPDATE_REFS_QUIET_ON_ERR) < 0)
 		return -1;
=20
 	return 0;
diff --git a/notes-merge.c b/notes-merge.c
index 51282934ae..6a9a139b12 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -562,7 +562,7 @@ int notes_merge(struct notes_merge_options *o,
 	       o->local_ref, o->remote_ref);
=20
 	/* Dereference o->local_ref into local_sha1 */
-	if (read_ref_full(o->local_ref, 0, &local_oid, NULL))
+	if (refs_read_ref_full(get_main_ref_store(the_repository), o->local_ref, =
0, &local_oid, NULL))
 		die("Failed to resolve local notes ref '%s'", o->local_ref);
 	else if (!check_refname_format(o->local_ref, 0) &&
 		is_null_oid(&local_oid))
diff --git a/notes-utils.c b/notes-utils.c
index 6197a5a455..e33aa86c4b 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -23,7 +23,7 @@ void create_notes_commit(struct repository *r,
 	if (!parents) {
 		/* Deduce parent commit from t->ref */
 		struct object_id parent_oid;
-		if (!read_ref(t->ref, &parent_oid)) {
+		if (!refs_read_ref(get_main_ref_store(the_repository), t->ref, &parent_o=
id)) {
 			struct commit *parent =3D lookup_commit(r, &parent_oid);
 			if (repo_parse_commit(r, parent))
 				die("Failed to find/parse commit %s", t->ref);
@@ -55,8 +55,9 @@ void commit_notes(struct repository *r, struct notes_tree=
 *t, const char *msg)
=20
 	create_notes_commit(r, t, NULL, buf.buf, buf.len, &commit_oid);
 	strbuf_insertstr(&buf, 0, "notes: ");
-	update_ref(buf.buf, t->update_ref, &commit_oid, NULL, 0,
-		   UPDATE_REFS_DIE_ON_ERR);
+	refs_update_ref(get_main_ref_store(the_repository), buf.buf,
+			t->update_ref, &commit_oid, NULL, 0,
+			UPDATE_REFS_DIE_ON_ERR);
=20
 	strbuf_release(&buf);
 }
diff --git a/notes.c b/notes.c
index fed1eda80c..53ca25c814 100644
--- a/notes.c
+++ b/notes.c
@@ -945,7 +945,8 @@ void string_list_add_refs_by_glob(struct string_list *l=
ist, const char *glob)
 {
 	assert(list->strdup_strings);
 	if (has_glob_specials(glob)) {
-		for_each_glob_ref(string_list_add_one_ref, glob, list);
+		refs_for_each_glob_ref(get_main_ref_store(the_repository),
+				       string_list_add_one_ref, glob, list);
 	} else {
 		struct object_id oid;
 		if (repo_get_oid(the_repository, glob, &oid))
@@ -1029,7 +1030,7 @@ void init_notes(struct notes_tree *t, const char *not=
es_ref,
 	if (flags & NOTES_INIT_EMPTY ||
 	    repo_get_oid_treeish(the_repository, notes_ref, &object_oid))
 		return;
-	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oid))
+	if (flags & NOTES_INIT_WRITABLE && refs_read_ref(get_main_ref_store(the_r=
epository), notes_ref, &object_oid))
 		die("Cannot use notes ref %s", notes_ref);
 	if (get_tree_entry(the_repository, &object_oid, "", &oid, &mode))
 		die("Failed to read notes tree referenced by %s (%s)",
diff --git a/reachable.c b/reachable.c
index 3b85add243..1224b30008 100644
--- a/reachable.c
+++ b/reachable.c
@@ -363,10 +363,11 @@ void mark_reachable_objects(struct rev_info *revs, in=
t mark_reflog,
 	add_index_objects_to_pending(revs, 0);
=20
 	/* Add all external refs */
-	for_each_ref(add_one_ref, revs);
+	refs_for_each_ref(get_main_ref_store(the_repository), add_one_ref,
+			  revs);
=20
 	/* detached HEAD is not included in the list above */
-	head_ref(add_one_ref, revs);
+	refs_head_ref(get_main_ref_store(the_repository), add_one_ref, revs);
 	other_head_refs(add_one_ref, revs);
=20
 	/* rebase autostash and orig-head */
diff --git a/ref-filter.c b/ref-filter.c
index eab4beba16..31cc096644 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -895,7 +895,9 @@ static int head_atom_parser(struct ref_format *format U=
NUSED,
 {
 	if (arg)
 		return err_no_arg(err, "HEAD");
-	atom->u.head =3D resolve_refdup("HEAD", RESOLVE_REF_READING, NULL, NULL);
+	atom->u.head =3D refs_resolve_refdup(get_main_ref_store(the_repository),
+					   "HEAD", RESOLVE_REF_READING, NULL,
+					   NULL);
 	return 0;
 }
=20
@@ -2135,7 +2137,9 @@ static const char *rstrip_ref_components(const char *=
refname, int len)
 static const char *show_ref(struct refname_atom *atom, const char *refname)
 {
 	if (atom->option =3D=3D R_SHORT)
-		return shorten_unambiguous_ref(refname, warn_ambiguous_refs);
+		return refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+						    refname,
+						    warn_ambiguous_refs);
 	else if (atom->option =3D=3D R_LSTRIP)
 		return lstrip_ref_components(refname, atom->lstrip);
 	else if (atom->option =3D=3D R_RSTRIP)
@@ -2338,8 +2342,10 @@ static int populate_value(struct ref_array_item *ref=
, struct strbuf *err)
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
=20
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
-		ref->symref =3D resolve_refdup(ref->refname, RESOLVE_REF_READING,
-					     NULL, NULL);
+		ref->symref =3D refs_resolve_refdup(get_main_ref_store(the_repository),
+						  ref->refname,
+						  RESOLVE_REF_READING,
+						  NULL, NULL);
 		if (!ref->symref)
 			ref->symref =3D xstrdup("");
 	}
@@ -2640,7 +2646,8 @@ static int for_each_fullref_in_pattern(struct ref_fil=
ter *filter,
 		 * prefixes like "refs/heads/" etc. are stripped off,
 		 * so we have to look at everything:
 		 */
-		return for_each_fullref_in("", NULL, cb, cb_data);
+		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
+						"", NULL, cb, cb_data);
 	}
=20
 	if (filter->ignore_case) {
@@ -2649,7 +2656,8 @@ static int for_each_fullref_in_pattern(struct ref_fil=
ter *filter,
 		 * so just return everything and let the caller
 		 * sort it out.
 		 */
-		return for_each_fullref_in("", NULL, cb, cb_data);
+		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
+						"", NULL, cb, cb_data);
 	}
=20
 	if (!filter->name_patterns[0]) {
@@ -3060,11 +3068,17 @@ static int do_filter_refs(struct ref_filter *filter=
, unsigned int type, each_ref
 		 * of filter_ref_kind().
 		 */
 		if (filter->kind =3D=3D FILTER_REFS_BRANCHES)
-			ret =3D for_each_fullref_in("refs/heads/", NULL, fn, cb_data);
+			ret =3D refs_for_each_fullref_in(get_main_ref_store(the_repository),
+						       "refs/heads/", NULL,
+						       fn, cb_data);
 		else if (filter->kind =3D=3D FILTER_REFS_REMOTES)
-			ret =3D for_each_fullref_in("refs/remotes/", NULL, fn, cb_data);
+			ret =3D refs_for_each_fullref_in(get_main_ref_store(the_repository),
+						       "refs/remotes/", NULL,
+						       fn, cb_data);
 		else if (filter->kind =3D=3D FILTER_REFS_TAGS)
-			ret =3D for_each_fullref_in("refs/tags/", NULL, fn, cb_data);
+			ret =3D refs_for_each_fullref_in(get_main_ref_store(the_repository),
+						       "refs/tags/", NULL, fn,
+						       cb_data);
 		else if (filter->kind & FILTER_REFS_REGULAR)
 			ret =3D for_each_fullref_in_pattern(filter, fn, cb_data);
=20
@@ -3074,7 +3088,8 @@ static int do_filter_refs(struct ref_filter *filter, =
unsigned int type, each_ref
 		 */
 		if (!ret && (filter->kind !=3D FILTER_REFS_KIND_MASK) &&
 		    (filter->kind & FILTER_REFS_DETACHED_HEAD))
-			head_ref(fn, cb_data);
+			refs_head_ref(get_main_ref_store(the_repository), fn,
+				      cb_data);
 	}
=20
 	clear_contains_cache(&filter->internal.contains_cache);
diff --git a/reflog-walk.c b/reflog-walk.c
index 66484f4f32..f11b97e889 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -67,24 +67,32 @@ static struct complete_reflogs *read_complete_reflog(co=
nst char *ref)
 	struct complete_reflogs *reflogs =3D
 		xcalloc(1, sizeof(struct complete_reflogs));
 	reflogs->ref =3D xstrdup(ref);
-	for_each_reflog_ent(ref, read_one_reflog, reflogs);
+	refs_for_each_reflog_ent(get_main_ref_store(the_repository), ref,
+				 read_one_reflog, reflogs);
 	if (reflogs->nr =3D=3D 0) {
 		const char *name;
 		void *name_to_free;
-		name =3D name_to_free =3D resolve_refdup(ref, RESOLVE_REF_READING,
-						     NULL, NULL);
+		name =3D name_to_free =3D refs_resolve_refdup(get_main_ref_store(the_rep=
ository),
+							  ref,
+							  RESOLVE_REF_READING,
+							  NULL, NULL);
 		if (name) {
-			for_each_reflog_ent(name, read_one_reflog, reflogs);
+			refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+						 name, read_one_reflog,
+						 reflogs);
 			free(name_to_free);
 		}
 	}
 	if (reflogs->nr =3D=3D 0) {
 		char *refname =3D xstrfmt("refs/%s", ref);
-		for_each_reflog_ent(refname, read_one_reflog, reflogs);
+		refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+					 refname, read_one_reflog, reflogs);
 		if (reflogs->nr =3D=3D 0) {
 			free(refname);
 			refname =3D xstrfmt("refs/heads/%s", ref);
-			for_each_reflog_ent(refname, read_one_reflog, reflogs);
+			refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+						 refname, read_one_reflog,
+						 reflogs);
 		}
 		free(refname);
 	}
@@ -174,7 +182,8 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 	else {
 		if (*branch =3D=3D '\0') {
 			free(branch);
-			branch =3D resolve_refdup("HEAD", 0, NULL, NULL);
+			branch =3D refs_resolve_refdup(get_main_ref_store(the_repository),
+						     "HEAD", 0, NULL, NULL);
 			if (!branch)
 				die("no current branch");
=20
@@ -236,7 +245,9 @@ void get_reflog_selector(struct strbuf *sb,
 	if (shorten) {
 		if (!commit_reflog->reflogs->short_ref)
 			commit_reflog->reflogs->short_ref
-				=3D shorten_unambiguous_ref(commit_reflog->reflogs->ref, 0);
+				=3D refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+							       commit_reflog->reflogs->ref,
+							       0);
 		printed_ref =3D commit_reflog->reflogs->short_ref;
 	} else {
 		printed_ref =3D commit_reflog->reflogs->ref;
diff --git a/reflog.c b/reflog.c
index 647f3ca398..8861c2d606 100644
--- a/reflog.c
+++ b/reflog.c
@@ -343,7 +343,8 @@ void reflog_expiry_prepare(const char *refname,
 	case UE_ALWAYS:
 		return;
 	case UE_HEAD:
-		for_each_ref(push_tip_to_list, &cb->tips);
+		refs_for_each_ref(get_main_ref_store(the_repository),
+				  push_tip_to_list, &cb->tips);
 		for (elem =3D cb->tips; elem; elem =3D elem->next)
 			commit_list_insert(elem->item, &cb->mark_list);
 		break;
@@ -416,19 +417,22 @@ int reflog_delete(const char *rev, enum expire_reflog=
_flags flags, int verbose)
 	recno =3D strtoul(spec + 2, &ep, 10);
 	if (*ep =3D=3D '}') {
 		cmd.recno =3D -recno;
-		for_each_reflog_ent(ref, count_reflog_ent, &cmd);
+		refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+					 ref, count_reflog_ent, &cmd);
 	} else {
 		cmd.expire_total =3D approxidate(spec + 2);
-		for_each_reflog_ent(ref, count_reflog_ent, &cmd);
+		refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+					 ref, count_reflog_ent, &cmd);
 		cmd.expire_total =3D 0;
 	}
=20
 	cb.cmd =3D cmd;
-	status |=3D reflog_expire(ref, flags,
-				reflog_expiry_prepare,
-				should_prune_fn,
-				reflog_expiry_cleanup,
-				&cb);
+	status |=3D refs_reflog_expire(get_main_ref_store(the_repository), ref,
+				     flags,
+				     reflog_expiry_prepare,
+				     should_prune_fn,
+				     reflog_expiry_cleanup,
+				     &cb);
=20
  cleanup:
 	free(ref);
diff --git a/refs.c b/refs.c
index 00bcc72719..d398731d74 100644
--- a/refs.c
+++ b/refs.c
@@ -487,7 +487,8 @@ static int warn_if_dangling_symref(const char *refname,
 	if (!(flags & REF_ISSYMREF))
 		return 0;
=20
-	resolves_to =3D resolve_ref_unsafe(refname, 0, NULL, NULL);
+	resolves_to =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository=
),
+					      refname, 0, NULL, NULL);
 	if (!resolves_to
 	    || (d->refname
 		? strcmp(resolves_to, d->refname)
@@ -508,7 +509,8 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt=
, const char *refname)
 	data.refname =3D refname;
 	data.refnames =3D NULL;
 	data.msg_fmt =3D msg_fmt;
-	for_each_rawref(warn_if_dangling_symref, &data);
+	refs_for_each_rawref(get_main_ref_store(the_repository),
+			     warn_if_dangling_symref, &data);
 }
=20
 void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct str=
ing_list *refnames)
@@ -519,7 +521,8 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fm=
t, const struct string_li
 	data.refname =3D NULL;
 	data.refnames =3D refnames;
 	data.msg_fmt =3D msg_fmt;
-	for_each_rawref(warn_if_dangling_symref, &data);
+	refs_for_each_rawref(get_main_ref_store(the_repository),
+			     warn_if_dangling_symref, &data);
 }
=20
 int refs_for_each_tag_ref(struct ref_store *refs, each_ref_fn fn, void *cb=
_data)
diff --git a/remote.c b/remote.c
index 2b650b813b..ec8c158e60 100644
--- a/remote.c
+++ b/remote.c
@@ -1198,8 +1198,10 @@ static char *guess_ref(const char *name, struct ref =
*peer)
 {
 	struct strbuf buf =3D STRBUF_INIT;
=20
-	const char *r =3D resolve_ref_unsafe(peer->name, RESOLVE_REF_READING,
-					   NULL, NULL);
+	const char *r =3D refs_resolve_ref_unsafe(get_main_ref_store(the_reposito=
ry),
+						peer->name,
+						RESOLVE_REF_READING,
+						NULL, NULL);
 	if (!r)
 		return NULL;
=20
@@ -1316,9 +1318,10 @@ static int match_explicit(struct ref *src, struct re=
f *dst,
 	if (!dst_value) {
 		int flag;
=20
-		dst_value =3D resolve_ref_unsafe(matched_src->name,
-					       RESOLVE_REF_READING,
-					       NULL, &flag);
+		dst_value =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+						    matched_src->name,
+						    RESOLVE_REF_READING,
+						    NULL, &flag);
 		if (!dst_value ||
 		    ((flag & REF_ISSYMREF) &&
 		     !starts_with(dst_value, "refs/heads/")))
@@ -1882,7 +1885,7 @@ const char *branch_get_upstream(struct branch *branch=
, struct strbuf *err)
 		 * or because it is not a real branch, and get_branch
 		 * auto-vivified it?
 		 */
-		if (!ref_exists(branch->refname))
+		if (!refs_ref_exists(get_main_ref_store(the_repository), branch->refname=
))
 			return error_buf(err, _("no such branch: '%s'"),
 					 branch->name);
 		return error_buf(err,
@@ -2168,13 +2171,13 @@ static int stat_branch_pair(const char *branch_name=
, const char *base,
 	struct strvec argv =3D STRVEC_INIT;
=20
 	/* Cannot stat if what we used to build on no longer exists */
-	if (read_ref(base, &oid))
+	if (refs_read_ref(get_main_ref_store(the_repository), base, &oid))
 		return -1;
 	theirs =3D lookup_commit_reference(the_repository, &oid);
 	if (!theirs)
 		return -1;
=20
-	if (read_ref(branch_name, &oid))
+	if (refs_read_ref(get_main_ref_store(the_repository), branch_name, &oid))
 		return -1;
 	ours =3D lookup_commit_reference(the_repository, &oid);
 	if (!ours)
@@ -2278,7 +2281,8 @@ int format_tracking_info(struct branch *branch, struc=
t strbuf *sb,
 		upstream_is_gone =3D 1;
 	}
=20
-	base =3D shorten_unambiguous_ref(full_base, 0);
+	base =3D refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+					    full_base, 0);
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2358,7 +2362,8 @@ struct ref *get_local_heads(void)
 {
 	struct ref *local_refs =3D NULL, **local_tail =3D &local_refs;
=20
-	for_each_ref(one_local_ref, &local_tail);
+	refs_for_each_ref(get_main_ref_store(the_repository), one_local_ref,
+			  &local_tail);
 	return local_refs;
 }
=20
@@ -2468,7 +2473,8 @@ struct ref *get_stale_heads(struct refspec *rs, struc=
t ref *fetch_map)
 	for (ref =3D fetch_map; ref; ref =3D ref->next)
 		string_list_append(&ref_names, ref->name);
 	string_list_sort(&ref_names);
-	for_each_ref(get_stale_heads_cb, &info);
+	refs_for_each_ref(get_main_ref_store(the_repository),
+			  get_stale_heads_cb, &info);
 	string_list_clear(&ref_names, 0);
 	return stale_refs;
 }
@@ -2553,7 +2559,7 @@ static int remote_tracking(struct remote *remote, con=
st char *refname,
 	dst =3D apply_refspecs(&remote->fetch, refname);
 	if (!dst)
 		return -1; /* no tracking ref for refname at remote */
-	if (read_ref(dst, oid))
+	if (refs_read_ref(get_main_ref_store(the_repository), dst, oid))
 		return -1; /* we know what the tracking ref is but we cannot read it */
=20
 	*dst_refname =3D dst;
@@ -2659,12 +2665,16 @@ static int is_reachable_in_reflog(const char *local=
, const struct ref *remote)
 	 * Get the timestamp from the latest entry
 	 * of the remote-tracking ref's reflog.
 	 */
-	for_each_reflog_ent_reverse(remote->tracking_ref, peek_reflog, &date);
+	refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repository),
+					 remote->tracking_ref, peek_reflog,
+					 &date);
=20
 	cb.remote_commit =3D commit;
 	cb.local_commits =3D &arr;
 	cb.remote_reflog_timestamp =3D date;
-	ret =3D for_each_reflog_ent_reverse(local, check_and_collect_until, &cb);
+	ret =3D refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repositor=
y),
+					       local, check_and_collect_until,
+					       &cb);
=20
 	/* We found an entry in the reflog. */
 	if (ret > 0)
diff --git a/reset.c b/reset.c
index d619cb7115..59ebb1f842 100644
--- a/reset.c
+++ b/reset.c
@@ -47,11 +47,13 @@ static int update_refs(const struct reset_head_opts *op=
ts,
 				strbuf_addstr(&msg, "updating ORIG_HEAD");
 				reflog_orig_head =3D msg.buf;
 			}
-			update_ref(reflog_orig_head, "ORIG_HEAD",
-				   orig_head ? orig_head : head,
-				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
+			refs_update_ref(get_main_ref_store(the_repository),
+					reflog_orig_head, "ORIG_HEAD",
+					orig_head ? orig_head : head,
+					old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
 		} else if (old_orig)
-			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
+			refs_delete_ref(get_main_ref_store(the_repository),
+					NULL, "ORIG_HEAD", old_orig, 0);
 	}
=20
 	if (!reflog_head) {
@@ -60,16 +62,19 @@ static int update_refs(const struct reset_head_opts *op=
ts,
 		reflog_head =3D msg.buf;
 	}
 	if (!switch_to_branch)
-		ret =3D update_ref(reflog_head, "HEAD", oid, head,
-				 detach_head ? REF_NO_DEREF : 0,
-				 UPDATE_REFS_MSG_ON_ERR);
+		ret =3D refs_update_ref(get_main_ref_store(the_repository),
+				      reflog_head, "HEAD", oid, head,
+				      detach_head ? REF_NO_DEREF : 0,
+				      UPDATE_REFS_MSG_ON_ERR);
 	else {
-		ret =3D update_ref(reflog_branch ? reflog_branch : reflog_head,
-				 switch_to_branch, oid, NULL, 0,
-				 UPDATE_REFS_MSG_ON_ERR);
+		ret =3D refs_update_ref(get_main_ref_store(the_repository),
+				      reflog_branch ? reflog_branch : reflog_head,
+				      switch_to_branch, oid, NULL, 0,
+				      UPDATE_REFS_MSG_ON_ERR);
 		if (!ret)
-			ret =3D create_symref("HEAD", switch_to_branch,
-					    reflog_head);
+			ret =3D refs_create_symref(get_main_ref_store(the_repository),
+						 "HEAD", switch_to_branch,
+						 reflog_head);
 	}
 	if (!ret && run_hook)
 		run_hooks_l("post-checkout",
diff --git a/revision.c b/revision.c
index 7e45f765d9..7ddf0f151a 100644
--- a/revision.c
+++ b/revision.c
@@ -1738,7 +1738,8 @@ void add_reflogs_to_pending(struct rev_info *revs, un=
signed flags)
 	cb.all_revs =3D revs;
 	cb.all_flags =3D flags;
 	cb.wt =3D NULL;
-	for_each_reflog(handle_one_reflog, &cb);
+	refs_for_each_reflog(get_main_ref_store(the_repository),
+			     handle_one_reflog, &cb);
=20
 	if (!revs->single_worktree)
 		add_other_reflogs_to_pending(&cb);
@@ -1979,9 +1980,9 @@ static const char *lookup_other_head(struct object_id=
 *oid)
 	};
=20
 	for (i =3D 0; i < ARRAY_SIZE(other_head); i++)
-		if (!read_ref_full(other_head[i],
-				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				oid, NULL)) {
+		if (!refs_read_ref_full(get_main_ref_store(the_repository), other_head[i=
],
+					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+					oid, NULL)) {
 			if (is_null_oid(oid))
 				die(_("%s exists but is a symbolic ref"), other_head[i]);
 			return other_head[i];
@@ -2789,7 +2790,8 @@ static int handle_revision_pseudo_opt(struct rev_info=
 *revs,
 	} else if ((argcount =3D parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref(handle_one_ref, optarg, &cb);
+		refs_for_each_glob_ref(get_main_ref_store(the_repository),
+				       handle_one_ref, optarg, &cb);
 		clear_ref_exclusions(&revs->ref_excludes);
 		return argcount;
 	} else if ((argcount =3D parse_long_opt("exclude", argv, &optarg))) {
@@ -2804,7 +2806,9 @@ static int handle_revision_pseudo_opt(struct rev_info=
 *revs,
 			return error(_("options '%s' and '%s' cannot be used together"),
 				     "--exclude-hidden", "--branches");
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
+		refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
+					  handle_one_ref, optarg,
+					  "refs/heads/", &cb);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (skip_prefix(arg, "--tags=3D", &optarg)) {
 		struct all_refs_cb cb;
@@ -2812,7 +2816,9 @@ static int handle_revision_pseudo_opt(struct rev_info=
 *revs,
 			return error(_("options '%s' and '%s' cannot be used together"),
 				     "--exclude-hidden", "--tags");
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
+		refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
+					  handle_one_ref, optarg,
+					  "refs/tags/", &cb);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (skip_prefix(arg, "--remotes=3D", &optarg)) {
 		struct all_refs_cb cb;
@@ -2820,7 +2826,9 @@ static int handle_revision_pseudo_opt(struct rev_info=
 *revs,
 			return error(_("options '%s' and '%s' cannot be used together"),
 				     "--exclude-hidden", "--remotes");
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, optarg, "refs/remotes/", &cb);
+		refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
+					  handle_one_ref, optarg,
+					  "refs/remotes/", &cb);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
@@ -2911,7 +2919,8 @@ static void NORETURN diagnose_missing_default(const c=
har *def)
 	int flags;
 	const char *refname;
=20
-	refname =3D resolve_ref_unsafe(def, 0, NULL, &flags);
+	refname =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+					  def, 0, NULL, &flags);
 	if (!refname || !(flags & REF_ISSYMREF) || (flags & REF_ISBROKEN))
 		die(_("your current branch appears to be broken"));
=20
diff --git a/sequencer.c b/sequencer.c
index 88de4dc20f..19421cbdb8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -266,7 +266,7 @@ static struct update_ref_record *init_update_ref_record=
(const char *ref)
 	oidcpy(&rec->after, null_oid());
=20
 	/* This may fail, but that's fine, we will keep the null OID. */
-	read_ref(ref, &rec->before);
+	refs_read_ref(get_main_ref_store(the_repository), ref, &rec->before);
=20
 	return rec;
 }
@@ -440,7 +440,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 			char *eol =3D strchr(p, '\n');
 			if (eol)
 				*eol =3D '\0';
-			if (delete_ref("(rebase) cleanup", p, NULL, 0) < 0) {
+			if (refs_delete_ref(get_main_ref_store(the_repository), "(rebase) clean=
up", p, NULL, 0) < 0) {
 				warning(_("could not delete '%s'"), p);
 				ret =3D -1;
 			}
@@ -661,7 +661,8 @@ static int fast_forward_to(struct repository *r,
=20
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
=20
-	transaction =3D ref_transaction_begin(&err);
+	transaction =3D ref_store_transaction_begin(get_main_ref_store(the_reposi=
tory),
+						  &err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD",
 				   to, unborn && !is_rebase_i(opts) ?
@@ -841,11 +842,12 @@ static int is_index_unchanged(struct repository *r)
 	struct index_state *istate =3D r->index;
 	const char *head_name;
=20
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
+	if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", =
RESOLVE_REF_READING, &head_oid, NULL)) {
 		/* Check to see if this is an unborn branch */
-		head_name =3D resolve_ref_unsafe("HEAD",
-			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-			&head_oid, NULL);
+		head_name =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+						    "HEAD",
+						    RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+						    &head_oid, NULL);
 		if (!head_name ||
 			!starts_with(head_name, "refs/heads/") ||
 			!is_null_oid(&head_oid))
@@ -1294,7 +1296,8 @@ int update_head_with_reflog(const struct commit *old_=
head,
 		strbuf_addch(&sb, '\n');
 	}
=20
-	transaction =3D ref_transaction_begin(err);
+	transaction =3D ref_store_transaction_begin(get_main_ref_store(the_reposi=
tory),
+						  err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", new_head,
 				   old_head ? &old_head->object.oid : null_oid(),
@@ -1720,8 +1723,8 @@ static int try_to_commit(struct repository *r,
=20
 static int write_rebase_head(struct object_id *oid)
 {
-	if (update_ref("rebase", "REBASE_HEAD", oid,
-		       NULL, REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
+	if (refs_update_ref(get_main_ref_store(the_repository), "rebase", "REBASE=
_HEAD", oid,
+			    NULL, REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
 		return error(_("could not update %s"), "REBASE_HEAD");
=20
 	return 0;
@@ -2455,12 +2458,12 @@ static int do_pick_commit(struct repository *r,
 	if ((command =3D=3D TODO_PICK || command =3D=3D TODO_REWORD ||
 	     command =3D=3D TODO_EDIT) && !opts->no_commit &&
 	    (res =3D=3D 0 || res =3D=3D 1) &&
-	    update_ref(NULL, "CHERRY_PICK_HEAD", &commit->object.oid, NULL,
-		       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
+	    refs_update_ref(get_main_ref_store(the_repository), NULL, "CHERRY_PIC=
K_HEAD", &commit->object.oid, NULL,
+			    REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
 		res =3D -1;
 	if (command =3D=3D TODO_REVERT && ((opts->no_commit && res =3D=3D 0) || r=
es =3D=3D 1) &&
-	    update_ref(NULL, "REVERT_HEAD", &commit->object.oid, NULL,
-		       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
+	    refs_update_ref(get_main_ref_store(the_repository), NULL, "REVERT_HEA=
D", &commit->object.oid, NULL,
+			    REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
 		res =3D -1;
=20
 	if (res) {
@@ -3364,7 +3367,7 @@ static int rollback_single_pick(struct repository *r)
 	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
 	    !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
 		return error(_("no cherry-pick or revert in progress"));
-	if (read_ref_full("HEAD", 0, &head_oid, NULL))
+	if (refs_read_ref_full(get_main_ref_store(the_repository), "HEAD", 0, &he=
ad_oid, NULL))
 		return error(_("cannot resolve HEAD"));
 	if (is_null_oid(&head_oid))
 		return error(_("cannot abort from a branch yet to be born"));
@@ -3375,7 +3378,7 @@ static int skip_single_pick(void)
 {
 	struct object_id head;
=20
-	if (read_ref_full("HEAD", 0, &head, NULL))
+	if (refs_read_ref_full(get_main_ref_store(the_repository), "HEAD", 0, &he=
ad, NULL))
 		return error(_("cannot resolve HEAD"));
 	return reset_merge(&head);
 }
@@ -3891,7 +3894,7 @@ static struct commit *lookup_label(struct repository =
*r, const char *label,
=20
 	strbuf_reset(buf);
 	strbuf_addf(buf, "refs/rewritten/%.*s", len, label);
-	if (!read_ref(buf->buf, &oid)) {
+	if (!refs_read_ref(get_main_ref_store(the_repository), buf->buf, &oid)) {
 		commit =3D lookup_commit_object(r, &oid);
 	} else {
 		/* fall back to non-rewritten ref or commit */
@@ -3987,9 +3990,10 @@ static int do_reset(struct repository *r,
 		ret =3D error(_("could not write index"));
=20
 	if (!ret)
-		ret =3D update_ref(reflog_message(opts, "reset", "'%.*s'",
-						len, name), "HEAD", &oid,
-				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+		ret =3D refs_update_ref(get_main_ref_store(the_repository), reflog_messa=
ge(opts, "reset", "'%.*s'",
+											 len, name),
+				      "HEAD", &oid,
+				      NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 cleanup:
 	free((void *)desc.buffer);
 	if (ret < 0)
@@ -4471,7 +4475,7 @@ static int do_update_ref(struct repository *r, const =
char *refname)
 	for_each_string_list_item(item, &list) {
 		if (!strcmp(item->string, refname)) {
 			struct update_ref_record *rec =3D item->util;
-			if (read_ref("HEAD", &rec->after))
+			if (refs_read_ref(get_main_ref_store(the_repository), "HEAD", &rec->aft=
er))
 				return -1;
 			break;
 		}
@@ -5031,15 +5035,15 @@ static int pick_commits(struct repository *r,
 			}
 			msg =3D reflog_message(opts, "finish", "%s onto %s",
 				head_ref.buf, buf.buf);
-			if (update_ref(msg, head_ref.buf, &head, &orig,
-				       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
+			if (refs_update_ref(get_main_ref_store(the_repository), msg, head_ref.b=
uf, &head, &orig,
+					    REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
 				res =3D error(_("could not update %s"),
 					head_ref.buf);
 				goto cleanup_head_ref;
 			}
 			msg =3D reflog_message(opts, "finish", "returning to %s",
 				head_ref.buf);
-			if (create_symref("HEAD", head_ref.buf, msg)) {
+			if (refs_create_symref(get_main_ref_store(the_repository), "HEAD", head=
_ref.buf, msg)) {
 				res =3D error(_("could not update HEAD to %s"),
 					head_ref.buf);
 				goto cleanup_head_ref;
@@ -6209,10 +6213,11 @@ static int add_decorations_to_list(const struct com=
mit *commit,
 				   struct todo_add_branch_context *ctx)
 {
 	const struct name_decoration *decoration =3D get_name_decoration(&commit-=
>object);
-	const char *head_ref =3D resolve_ref_unsafe("HEAD",
-						  RESOLVE_REF_READING,
-						  NULL,
-						  NULL);
+	const char *head_ref =3D refs_resolve_ref_unsafe(get_main_ref_store(the_r=
epository),
+						       "HEAD",
+						       RESOLVE_REF_READING,
+						       NULL,
+						       NULL);
=20
 	while (decoration) {
 		struct todo_item *item;
diff --git a/server-info.c b/server-info.c
index e2fe0f9143..6feaa457c5 100644
--- a/server-info.c
+++ b/server-info.c
@@ -175,7 +175,8 @@ static int add_info_ref(const char *path, const struct =
object_id *oid,
=20
 static int generate_info_refs(struct update_info_ctx *uic)
 {
-	return for_each_ref(add_info_ref, uic);
+	return refs_for_each_ref(get_main_ref_store(the_repository),
+				 add_info_ref, uic);
 }
=20
 static int update_info_refs(int force)
diff --git a/setup.c b/setup.c
index f4b32f76e3..b0ed643b55 100644
--- a/setup.c
+++ b/setup.c
@@ -2001,7 +2001,7 @@ void create_reference_database(unsigned int ref_stora=
ge_format,
 			die(_("invalid initial branch name: '%s'"),
 			    initial_branch);
=20
-		if (create_symref("HEAD", ref, NULL) < 0)
+		if (refs_create_symref(get_main_ref_store(the_repository), "HEAD", ref, =
NULL) < 0)
 			exit(1);
 		free(ref);
 	}
diff --git a/shallow.c b/shallow.c
index 7ff50dd0da..a0b181ba8a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -678,8 +678,10 @@ void assign_shallow_commits_to_refs(struct shallow_inf=
o *info,
 	 * connect to old refs. If not (e.g. force ref updates) it'll
 	 * have to go down to the current shallow commits.
 	 */
-	head_ref(mark_uninteresting, NULL);
-	for_each_ref(mark_uninteresting, NULL);
+	refs_head_ref(get_main_ref_store(the_repository), mark_uninteresting,
+		      NULL);
+	refs_for_each_ref(get_main_ref_store(the_repository),
+			  mark_uninteresting, NULL);
=20
 	/* Mark potential bottoms so we won't go out of bound */
 	for (i =3D 0; i < nr_shallow; i++) {
@@ -782,8 +784,8 @@ static void post_assign_shallow(struct shallow_info *in=
fo,
 	info->nr_theirs =3D dst;
=20
 	memset(&ca, 0, sizeof(ca));
-	head_ref(add_ref, &ca);
-	for_each_ref(add_ref, &ca);
+	refs_head_ref(get_main_ref_store(the_repository), add_ref, &ca);
+	refs_for_each_ref(get_main_ref_store(the_repository), add_ref, &ca);
=20
 	/* Remove unreachable shallow commits from "ours" */
 	for (i =3D dst =3D 0; i < info->nr_ours; i++) {
@@ -822,8 +824,10 @@ int delayed_reachability_test(struct shallow_info *si,=
 int c)
 			struct commit_array ca;
=20
 			memset(&ca, 0, sizeof(ca));
-			head_ref(add_ref, &ca);
-			for_each_ref(add_ref, &ca);
+			refs_head_ref(get_main_ref_store(the_repository),
+				      add_ref, &ca);
+			refs_for_each_ref(get_main_ref_store(the_repository),
+					  add_ref, &ca);
 			si->commits =3D ca.commits;
 			si->nr_commits =3D ca.nr;
 		}
diff --git a/submodule.c b/submodule.c
index ce2d032521..bdd75faa44 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1233,7 +1233,8 @@ int push_unpushed_submodules(struct repository *r,
 		char *head;
 		struct object_id head_oid;
=20
-		head =3D resolve_refdup("HEAD", 0, &head_oid, NULL);
+		head =3D refs_resolve_refdup(get_main_ref_store(the_repository),
+					   "HEAD", 0, &head_oid, NULL);
 		if (!head)
 			die(_("Failed to resolve HEAD as a valid ref."));
=20
@@ -1271,7 +1272,8 @@ static int append_oid_to_array(const char *ref UNUSED,
 void check_for_new_submodule_commits(struct object_id *oid)
 {
 	if (!initialized_fetch_ref_tips) {
-		for_each_ref(append_oid_to_array, &ref_tips_before_fetch);
+		refs_for_each_ref(get_main_ref_store(the_repository),
+				  append_oid_to_array, &ref_tips_before_fetch);
 		initialized_fetch_ref_tips =3D 1;
 	}
=20
diff --git a/transport-helper.c b/transport-helper.c
index 8d284b24d5..780fcaf529 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -551,7 +551,7 @@ static int fetch_with_import(struct transport *transpor=
t,
 		else
 			private =3D xstrdup(name);
 		if (private) {
-			if (read_ref(private, &posn->old_oid) < 0)
+			if (refs_read_ref(get_main_ref_store(the_repository), private, &posn->o=
ld_oid) < 0)
 				die(_("could not read ref %s"), private);
 			free(private);
 		}
@@ -923,8 +923,10 @@ static int push_update_refs_status(struct helper_data =
*data,
 			private =3D apply_refspecs(&data->rs, ref->name);
 			if (!private)
 				continue;
-			update_ref("update by helper", private, &(ref->new_oid),
-				   NULL, 0, 0);
+			refs_update_ref(get_main_ref_store(the_repository),
+					"update by helper", private,
+					&(ref->new_oid),
+					NULL, 0, 0);
 			free(private);
 		} else {
 			for (report =3D ref->report; report; report =3D report->next) {
@@ -934,11 +936,12 @@ static int push_update_refs_status(struct helper_data=
 *data,
 							 : ref->name);
 				if (!private)
 					continue;
-				update_ref("update by helper", private,
-					   report->new_oid
-					   ? report->new_oid
-					   : &(ref->new_oid),
-					   NULL, 0, 0);
+				refs_update_ref(get_main_ref_store(the_repository),
+						"update by helper", private,
+						report->new_oid
+						? report->new_oid
+						: &(ref->new_oid),
+						NULL, 0, 0);
 				free(private);
 			}
 		}
@@ -1105,9 +1108,11 @@ static int push_refs_with_export(struct transport *t=
ransport,
 					int flag;
=20
 					/* Follow symbolic refs (mainly for HEAD). */
-					name =3D resolve_ref_unsafe(ref->peer_ref->name,
-								  RESOLVE_REF_READING,
-								  &oid, &flag);
+					name =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+								       ref->peer_ref->name,
+								       RESOLVE_REF_READING,
+								       &oid,
+								       &flag);
 					if (!name || !(flag & REF_ISSYMREF))
 						name =3D ref->peer_ref->name;
=20
@@ -1252,7 +1257,7 @@ static struct ref *get_refs_list_using_list(struct tr=
ansport *transport,
 		if (eon) {
 			if (has_attribute(eon + 1, "unchanged")) {
 				(*tail)->status |=3D REF_STATUS_UPTODATE;
-				if (read_ref((*tail)->name, &(*tail)->old_oid) < 0)
+				if (refs_read_ref(get_main_ref_store(the_repository), (*tail)->name, &=
(*tail)->old_oid) < 0)
 					die(_("could not read ref %s"),
 					    (*tail)->name);
 			}
diff --git a/transport.c b/transport.c
index df518ead70..0ad04b77fd 100644
--- a/transport.c
+++ b/transport.c
@@ -100,8 +100,9 @@ static void set_upstreams(struct transport *transport, =
struct ref *refs,
 		/* Follow symbolic refs (mainly for HEAD). */
 		localname =3D ref->peer_ref->name;
 		remotename =3D ref->name;
-		tmp =3D resolve_ref_unsafe(localname, RESOLVE_REF_READING,
-					 NULL, &flag);
+		tmp =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+					      localname, RESOLVE_REF_READING,
+					      NULL, &flag);
 		if (tmp && flag & REF_ISSYMREF &&
 			starts_with(tmp, "refs/heads/"))
 			localname =3D tmp;
@@ -543,10 +544,12 @@ static void update_one_tracking_ref(struct remote *re=
mote, char *refname,
 		if (verbose)
 			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
 		if (deletion)
-			delete_ref(NULL, rs.dst, NULL, 0);
+			refs_delete_ref(get_main_ref_store(the_repository),
+					NULL, rs.dst, NULL, 0);
 		else
-			update_ref("update by push", rs.dst, new_oid,
-				   NULL, 0, 0);
+			refs_update_ref(get_main_ref_store(the_repository),
+					"update by push", rs.dst, new_oid,
+					NULL, 0, 0);
 		free(rs.dst);
 	}
 }
@@ -814,7 +817,8 @@ void transport_print_push_status(const char *dest, stru=
ct ref *refs,
 	if (transport_color_config() < 0)
 		warning(_("could not parse transport.color.* config"));
=20
-	head =3D resolve_refdup("HEAD", RESOLVE_REF_READING, NULL, NULL);
+	head =3D refs_resolve_refdup(get_main_ref_store(the_repository), "HEAD",
+				   RESOLVE_REF_READING, NULL, NULL);
=20
 	if (verbose) {
 		for (ref =3D refs; ref; ref =3D ref->next)
diff --git a/upload-pack.c b/upload-pack.c
index 902144b9d3..8fbd138515 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -618,7 +618,8 @@ static void for_each_namespaced_ref_1(each_ref_fn fn,
 	if (allow_hidden_refs(data->allow_uor))
 		excludes =3D hidden_refs_to_excludes(&data->hidden_refs);
=20
-	for_each_namespaced_ref(excludes, fn, data);
+	refs_for_each_namespaced_ref(get_main_ref_store(the_repository),
+				     excludes, fn, data);
 }
=20
=20
@@ -873,7 +874,8 @@ static void deepen(struct upload_pack_data *data, int d=
epth)
 		 * Checking for reachable shallows requires that our refs be
 		 * marked with OUR_REF.
 		 */
-		head_ref_namespaced(check_ref, data);
+		refs_head_ref_namespaced(get_main_ref_store(the_repository),
+					 check_ref, data);
 		for_each_namespaced_ref_1(check_ref, data);
=20
 		get_reachable_list(data, &reachable_shallows);
@@ -1288,7 +1290,8 @@ static int find_symref(const char *refname,
=20
 	if ((flag & REF_ISSYMREF) =3D=3D 0)
 		return 0;
-	symref_target =3D resolve_ref_unsafe(refname, 0, NULL, &flag);
+	symref_target =3D refs_resolve_ref_unsafe(get_main_ref_store(the_reposito=
ry),
+						refname, 0, NULL, &flag);
 	if (!symref_target || (flag & REF_ISSYMREF) =3D=3D 0)
 		die("'%s' is a symref but it is not?", refname);
 	item =3D string_list_append(cb_data, strip_namespace(refname));
@@ -1413,13 +1416,15 @@ void upload_pack(const int advertise_refs, const in=
t stateless_rpc,
 	if (data.timeout)
 		data.daemon_mode =3D 1;
=20
-	head_ref_namespaced(find_symref, &data.symref);
+	refs_head_ref_namespaced(get_main_ref_store(the_repository),
+				 find_symref, &data.symref);
=20
 	if (advertise_refs || !data.stateless_rpc) {
 		reset_timeout(data.timeout);
 		if (advertise_refs)
 			data.no_done =3D 1;
-		head_ref_namespaced(send_ref, &data);
+		refs_head_ref_namespaced(get_main_ref_store(the_repository),
+					 send_ref, &data);
 		for_each_namespaced_ref_1(send_ref, &data);
 		if (!data.sent_capabilities) {
 			const char *refname =3D "capabilities^{}";
@@ -1433,7 +1438,8 @@ void upload_pack(const int advertise_refs, const int =
stateless_rpc,
 		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {
-		head_ref_namespaced(check_ref, &data);
+		refs_head_ref_namespaced(get_main_ref_store(the_repository),
+					 check_ref, &data);
 		for_each_namespaced_ref_1(check_ref, &data);
 	}
=20
@@ -1511,7 +1517,7 @@ static int parse_want_ref(struct packet_writer *write=
r, const char *line,
=20
 		strbuf_addf(&refname, "%s%s", get_git_namespace(), refname_nons);
 		if (ref_is_hidden(refname_nons, refname.buf, hidden_refs) ||
-		    read_ref(refname.buf, &oid)) {
+		    refs_read_ref(get_main_ref_store(the_repository), refname.buf, &oid)=
) {
 			packet_writer_error(writer, "unknown ref %s", refname_nons);
 			die("unknown ref %s", refname_nons);
 		}
diff --git a/walker.c b/walker.c
index c0fd632d92..74bc049d4c 100644
--- a/walker.c
+++ b/walker.c
@@ -286,7 +286,8 @@ int walker_fetch(struct walker *walker, int targets, ch=
ar **target,
 	ALLOC_ARRAY(oids, targets);
=20
 	if (write_ref) {
-		transaction =3D ref_transaction_begin(&err);
+		transaction =3D ref_store_transaction_begin(get_main_ref_store(the_repos=
itory),
+							  &err);
 		if (!transaction) {
 			error("%s", err.buf);
 			goto done;
@@ -294,7 +295,8 @@ int walker_fetch(struct walker *walker, int targets, ch=
ar **target,
 	}
=20
 	if (!walker->get_recover) {
-		for_each_ref(mark_complete, NULL);
+		refs_for_each_ref(get_main_ref_store(the_repository),
+				  mark_complete, NULL);
 		commit_list_sort_by_date(&complete);
 	}
=20
diff --git a/wt-status.c b/wt-status.c
index bdfc23e2ae..ff4be071ca 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -145,7 +145,8 @@ void wt_status_prepare(struct repository *r, struct wt_=
status *s)
 	s->show_untracked_files =3D SHOW_NORMAL_UNTRACKED_FILES;
 	s->use_color =3D -1;
 	s->relative_paths =3D 1;
-	s->branch =3D resolve_refdup("HEAD", 0, NULL, NULL);
+	s->branch =3D refs_resolve_refdup(get_main_ref_store(the_repository),
+					"HEAD", 0, NULL, NULL);
 	s->reference =3D "HEAD";
 	s->fp =3D stdout;
 	s->index_file =3D get_index_file();
@@ -976,7 +977,8 @@ static int stash_count_refs(struct object_id *ooid UNUS=
ED,
 static int count_stash_entries(void)
 {
 	int n =3D 0;
-	for_each_reflog_ent("refs/stash", stash_count_refs, &n);
+	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+				 "refs/stash", stash_count_refs, &n);
 	return n;
 }
=20
@@ -1304,10 +1306,10 @@ static int split_commit_in_progress(struct wt_statu=
s *s)
 	    !s->branch || strcmp(s->branch, "HEAD"))
 		return 0;
=20
-	if (read_ref_full("HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-			  &head_oid, &head_flags) ||
-	    read_ref_full("ORIG_HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECUR=
SE,
-			  &orig_head_oid, &orig_head_flags))
+	if (refs_read_ref_full(get_main_ref_store(the_repository), "HEAD", RESOLV=
E_REF_READING | RESOLVE_REF_NO_RECURSE,
+			       &head_oid, &head_flags) ||
+	    refs_read_ref_full(get_main_ref_store(the_repository), "ORIG_HEAD", R=
ESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+			       &orig_head_oid, &orig_head_flags))
 		return 0;
 	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
 		return 0;
@@ -1679,7 +1681,7 @@ static void wt_status_get_detached_from(struct reposi=
tory *r,
 	char *ref =3D NULL;
=20
 	strbuf_init(&cb.buf, 0);
-	if (for_each_reflog_ent_reverse("HEAD", grab_1st_switch, &cb) <=3D 0) {
+	if (refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repository), =
"HEAD", grab_1st_switch, &cb) <=3D 0) {
 		strbuf_release(&cb.buf);
 		return;
 	}
@@ -2087,7 +2089,8 @@ static void wt_shortstatus_print_tracking(struct wt_s=
tatus *s)
 		upstream_is_gone =3D 1;
 	}
=20
-	short_base =3D shorten_unambiguous_ref(base, 0);
+	short_base =3D refs_shorten_unambiguous_ref(get_main_ref_store(the_reposi=
tory),
+						  base, 0);
 	color_fprintf(s->fp, header_color, "...");
 	color_fprintf(s->fp, branch_color_remote, "%s", short_base);
 	free(short_base);
@@ -2220,7 +2223,8 @@ static void wt_porcelain_v2_print_tracking(struct wt_=
status *s)
 		ab_info =3D stat_tracking_info(branch, &nr_ahead, &nr_behind,
 					     &base, 0, s->ahead_behind_flags);
 		if (base) {
-			base =3D shorten_unambiguous_ref(base, 0);
+			base =3D refs_shorten_unambiguous_ref(get_main_ref_store(the_repository=
),
+							    base, 0);
 			fprintf(s->fp, "# branch.upstream %s%c", base, eol);
 			free((char *)base);
=20
--=20
2.45.0


--G/JN29aAunD/EJ1X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY51DgACgkQVbJhu7ck
PpR+ABAAhyJokzv6no+kXIN7jW97K2uUV3RNWxahmchLlm41iXsjOtlGxwp2FF6q
7i815rJ7tfzraS0rm6l6WGOM2Flitj1z8FWWbXUH/uPg6IuQuMSRZJ6niEwMesEQ
LD0IXQWgNyrakJfmV68XkDt6bTIpYmKD6/tXgi4QQa/OeqfoE1PNNKrYwtA8NL10
bmWveHVrA1Nq+sWopsWgzdEWw0eIXrRe/+7E1MmGLVCliAPxiKM2pPK7Q7R86+YW
SmIvY3z5IhkDa5/+inJp02KraTpMMKB4jq/6sZcRzFuxTGYnGqm32UDv/5FrHjQI
UFfYGqbV3nFd21UEHicsr9VVR4a+HBXqZ6vJu1w6X6I8XsPcLSdMsC3VYSYLhOlh
wh5PivjuzxnvQ7w1esZVmSZqvCJmHiI0KoJP1w4qA1hJ0lYqkK0L7Sc9UC2Tuyk5
yjrtbk8FHtLR2KDsR9nw1i5G2Frn5kRvpR7NgH96hE8eJdzlDdZL/mBoUO3X8Y+u
Z/7j0UZx2ZdsAlmw/r3EMOrQwcXJoCVnpzeAvSB1f3jdB64it7FQLtSE4VqvR/uw
r5QSmTrazBIqOLEzEIUtyygKY0gXFLdfe7BJXbosyIBNNU5n+XcX2mnHlNg3Bo9D
+oCRy/bGwvLXlxWkV4hMYP+8s7lO+DMLmihn6KUBqgFd8118I6w=
=Iyom
-----END PGP SIGNATURE-----

--G/JN29aAunD/EJ1X--
