Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F781369A0
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259224; cv=none; b=kcwW/zZPZRGOpQOBkArOuvuadkjkMTjhtYkMDnD9TrsYLOZtfQRNFES4G11RKhmfBF/N1aMl1v0oBem4Nvzi9QEDA270zTLPgatX33SPbl2BBaloaKE1PLYNAtQwTdUFeuUceb77Q3z66wuKQI/jTzhrdM0k/9ij4nwPs23pwOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259224; c=relaxed/simple;
	bh=+RLKdhrQsyLqM0vzcZml/VdepRJBk8sKiCZmDXb1fr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOj/vhKDXUUXoBI1Ut1O1HD/qmOSAvVJodN8dCKOWCI5xuewJIx0eHo4WltkVHjyrPLmT9Y+YF32I4LwNrDQPqeB+yFcMM8DkFWnIDAzm3nzqn5A6yxUgphnY189Uf0IBXq6zvB8rSJW8EpX9fe1ecN0r6bGl9g4KmBfVdht1wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m0b6WbhR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7FTrowg; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m0b6WbhR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7FTrowg"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 61FDC18000AC;
	Thu, 13 Jun 2024 02:13:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jun 2024 02:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259220; x=1718345620; bh=gBGuOqDJ4G
	n+/BM3idoZUMSqejSFd11/s8U9NM+PFUk=; b=m0b6WbhRK57cOXwbIcgfHz6/qB
	HZYVaNc7XnvXpUvmj7OFPe406/a/exfC0HWY4FiBwgYv/CaFaWmjKgMKfjFzhZi0
	OBr52ASDxMJba840mc3C+IPHAtEcv8LeEGlzBKZKbuPJKrQH5gim4Prz6Rb+pf//
	CbDgx1ED+Gh2yQYEW1ORqF88g+BThXwskw1kVtG+LAJgMO0qVJKfnXCbcUZMDP4z
	MTQgFlrgVGCCd1avf8bng9fvfFCOfd65cEnFSZ0T01VYQam6uW7jubbwhQ5QySq1
	NG9X1mphS/J8Q4P8E+TDJEVTQm2WVulYKl+uUlnWR5VcYJ5F93OMJdvw5nnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259220; x=1718345620; bh=gBGuOqDJ4Gn+/BM3idoZUMSqejSF
	d11/s8U9NM+PFUk=; b=Z7FTrowggQNcFzlUd4G6gKj8bdfq9+KoLUJLuAu50U4R
	snapKHsdnT9oPGOGeFJgy/zNd4LeDpWcnQremaJd6rN9vMhMRiy+EvXuWQrvnmas
	WK5krJPt8yKsPH8mtmbVT8ejRUaMZYVQShzDapZ9rVLM6AsjfnfYXNEMCK9407WS
	hGVKEmrzaKRRybZ6Hncw0rl42SaGd73Kwm9yun/GiQAP3pynP1MxoQ3vFaSrL/m2
	DzMDku8RexcJRg4zF+DcVnLWOiUXIkEQCLe4VQrwMMIhIhAv0A4J3YA8mo9oLgmd
	iIVytSCTyt5xJLUi2PYjcQIeyeVykWrh5ADdImQ02g==
X-ME-Sender: <xms:E45qZgueR_GG6PWIaetJlhPqiH0oWuyi7Rg7hwzk4ieoQRzipjh5Pw>
    <xme:E45qZtdIlpd-KpAI-Z8QR4YwO8JAZfmSpzOyQ8_PeoRGY5AZJJK75YDFLVfgbOmR6
    jf-3Rr0HoZl1d8P-w>
X-ME-Received: <xmr:E45qZryFAiBW8rjzGUhfJXkt0Ocz4vonbKCmx5XHZRHMWYx1lpKtjJlZAsKO4wR844owWCQNXckkc7DdxB3jqxbL7z2gG8Jo1Ht8fhnvSd6_DwbPFGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheekkeehteffgfeljefgueetgefhudeikedttdegjeelieefieehkeffueekleeg
    necuffhomhgrihhnpehvrghlvddrthgrrhhgvghtpdhuphgurghtvgdrnhgvfidpuhhpug
    grthgvrdgvmhgrihhlnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:E45qZjNFbXva4kQKSiyKVWodtRQeMxnxk_Wdoy9D9FnypQCyekKYbw>
    <xmx:E45qZg8N-vr-8DV8K1NtmXrtf0I3AVpGKEh3UCmGPSDkH1_y_fMjwQ>
    <xmx:E45qZrWl7RDYYVcVGZELE2vXN6rmSy3wB_Mbdy_ZuiCkgARpRdZN5Q>
    <xmx:E45qZpe9ieN_lkgcUsyK57LdAG4UmTBb5WLqM0AzJAJJkMA7sagoFA>
    <xmx:FI5qZvYsXwyVvU40BmE9CLoGt4uIL2E_b_5ifGUtEW4h553EvZgseuNu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:13:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3747dab8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:13:25 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:13:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 03/20] hash: require hash algorithm in `oidread()` and
 `oidclr()`
Message-ID: <403ea4485b3aef6f0160f968336cc4d7db9f6dad.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gt2sbAU77m3sa4Nd"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--gt2sbAU77m3sa4Nd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both `oidread()` and `oidclr()` use `the_repository` to derive the hash
function that shall be used. Require callers to pass in the hash
algorithm to get rid of this implicit dependency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c                          |  2 +-
 blame.c                          |  2 +-
 builtin/am.c                     |  8 +++----
 builtin/fast-export.c            |  2 +-
 builtin/fast-import.c            | 39 +++++++++++++++++---------------
 builtin/fetch-pack.c             |  4 ++--
 builtin/index-pack.c             |  5 ++--
 builtin/log.c                    |  2 +-
 builtin/merge.c                  |  4 ++--
 builtin/notes.c                  |  2 +-
 builtin/pack-objects.c           |  3 ++-
 builtin/pack-redundant.c         |  2 +-
 builtin/patch-id.c               |  6 ++---
 builtin/pull.c                   |  6 ++---
 builtin/receive-pack.c           |  2 +-
 builtin/replace.c                |  2 +-
 builtin/rm.c                     |  2 +-
 builtin/tag.c                    |  2 +-
 builtin/unpack-objects.c         |  6 ++---
 builtin/update-ref.c             |  8 +++----
 cache-tree.c                     |  3 ++-
 commit-graph.c                   | 17 +++++++++-----
 diff-lib.c                       |  4 ++--
 diff.c                           |  6 ++---
 dir.c                            |  6 ++---
 hash-ll.h                        | 14 ++++++++++++
 hash.h                           | 17 --------------
 http-push.c                      |  2 +-
 http-walker.c                    |  2 +-
 match-trees.c                    |  2 +-
 midx.c                           |  3 ++-
 notes-merge.c                    |  6 ++---
 notes.c                          |  8 +++----
 object-file-convert.c            |  2 +-
 object-file.c                    |  4 ++--
 packfile.c                       | 10 ++++----
 read-cache.c                     |  8 ++++---
 refs.c                           |  6 ++---
 refs/files-backend.c             |  6 ++---
 refs/packed-backend.c            |  6 ++---
 refs/reftable-backend.c          | 37 ++++++++++++++++++------------
 remote.c                         |  8 +++----
 resolve-undo.c                   |  3 ++-
 sequencer.c                      |  4 ++--
 split-index.c                    |  2 +-
 submodule-config.c               |  2 +-
 t/helper/test-submodule-config.c |  2 +-
 tree-walk.c                      |  4 ++--
 48 files changed, 163 insertions(+), 140 deletions(-)

diff --git a/apply.c b/apply.c
index 901b67e625..528939abb6 100644
--- a/apply.c
+++ b/apply.c
@@ -3680,7 +3680,7 @@ static int try_threeway(struct apply_state *state,
 	if (status) {
 		patch->conflicted_threeway =3D 1;
 		if (patch->is_new)
-			oidclr(&patch->threeway_stage[0]);
+			oidclr(&patch->threeway_stage[0], the_repository->hash_algo);
 		else
 			oidcpy(&patch->threeway_stage[0], &pre_oid);
 		oidcpy(&patch->threeway_stage[1], &our_oid);
diff --git a/blame.c b/blame.c
index 33586b9777..a80f5e2e61 100644
--- a/blame.c
+++ b/blame.c
@@ -1246,7 +1246,7 @@ static int fill_blob_sha1_and_mode(struct repository =
*r,
 		goto error_out;
 	return 0;
  error_out:
-	oidclr(&origin->blob_oid);
+	oidclr(&origin->blob_oid, the_repository->hash_algo);
 	origin->mode =3D S_IFINVALID;
 	return -1;
 }
diff --git a/builtin/am.c b/builtin/am.c
index 36839029d2..45c305ec86 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -408,7 +408,7 @@ static void am_load(struct am_state *state)
 	read_commit_msg(state);
=20
 	if (read_state_file(&sb, state, "original-commit", 1) < 0)
-		oidclr(&state->orig_commit);
+		oidclr(&state->orig_commit, the_repository->hash_algo);
 	else if (get_oid_hex(sb.buf, &state->orig_commit) < 0)
 		die(_("could not parse %s"), am_path(state, "original-commit"));
=20
@@ -1121,7 +1121,7 @@ static void am_next(struct am_state *state)
 	unlink(am_path(state, "author-script"));
 	unlink(am_path(state, "final-commit"));
=20
-	oidclr(&state->orig_commit);
+	oidclr(&state->orig_commit, the_repository->hash_algo);
 	unlink(am_path(state, "original-commit"));
 	refs_delete_ref(get_main_ref_store(the_repository), NULL,
 			"REBASE_HEAD", NULL, REF_NO_DEREF);
@@ -2151,11 +2151,11 @@ static int safe_to_abort(const struct am_state *sta=
te)
 		if (get_oid_hex(sb.buf, &abort_safety))
 			die(_("could not parse %s"), am_path(state, "abort-safety"));
 	} else
-		oidclr(&abort_safety);
+		oidclr(&abort_safety, the_repository->hash_algo);
 	strbuf_release(&sb);
=20
 	if (repo_get_oid(the_repository, "HEAD", &head))
-		oidclr(&head);
+		oidclr(&head, the_repository->hash_algo);
=20
 	if (oideq(&head, &abort_safety))
 		return 1;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 4693d18cc9..4b6e8c6832 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -415,7 +415,7 @@ static char *generate_fake_oid(void)
 	struct object_id oid;
 	char *hex =3D xmallocz(GIT_MAX_HEXSZ);
=20
-	oidclr(&oid);
+	oidclr(&oid, the_repository->hash_algo);
 	put_be32(oid.hash + hashsz - 4, counter++);
 	return oid_to_hex_r(hex, &oid);
 }
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index d1c0243d04..12543488f3 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1279,8 +1279,10 @@ static void load_tree(struct tree_entry *root)
 		e->versions[0].mode =3D e->versions[1].mode;
 		e->name =3D to_atom(c, strlen(c));
 		c +=3D e->name->str_len + 1;
-		oidread(&e->versions[0].oid, (unsigned char *)c);
-		oidread(&e->versions[1].oid, (unsigned char *)c);
+		oidread(&e->versions[0].oid, (unsigned char *)c,
+			the_repository->hash_algo);
+		oidread(&e->versions[1].oid, (unsigned char *)c,
+			the_repository->hash_algo);
 		c +=3D the_hash_algo->rawsz;
 	}
 	free(buf);
@@ -1386,7 +1388,7 @@ static void tree_content_replace(
 {
 	if (!S_ISDIR(mode))
 		die("Root cannot be a non-directory");
-	oidclr(&root->versions[0].oid);
+	oidclr(&root->versions[0].oid, the_repository->hash_algo);
 	oidcpy(&root->versions[1].oid, oid);
 	if (root->tree)
 		release_tree_content_recursive(root->tree);
@@ -1445,7 +1447,7 @@ static int tree_content_set(
 				if (S_ISDIR(e->versions[0].mode))
 					e->versions[0].mode |=3D NO_DELTA;
=20
-				oidclr(&root->versions[1].oid);
+				oidclr(&root->versions[1].oid, the_repository->hash_algo);
 				return 1;
 			}
 			if (!S_ISDIR(e->versions[1].mode)) {
@@ -1455,7 +1457,7 @@ static int tree_content_set(
 			if (!e->tree)
 				load_tree(e);
 			if (tree_content_set(e, slash1 + 1, oid, mode, subtree)) {
-				oidclr(&root->versions[1].oid);
+				oidclr(&root->versions[1].oid, the_repository->hash_algo);
 				return 1;
 			}
 			return 0;
@@ -1467,7 +1469,7 @@ static int tree_content_set(
 	e =3D new_tree_entry();
 	e->name =3D to_atom(p, n);
 	e->versions[0].mode =3D 0;
-	oidclr(&e->versions[0].oid);
+	oidclr(&e->versions[0].oid, the_repository->hash_algo);
 	t->entries[t->entry_count++] =3D e;
 	if (*slash1) {
 		e->tree =3D new_tree_content(8);
@@ -1478,7 +1480,7 @@ static int tree_content_set(
 		e->versions[1].mode =3D mode;
 		oidcpy(&e->versions[1].oid, oid);
 	}
-	oidclr(&root->versions[1].oid);
+	oidclr(&root->versions[1].oid, the_repository->hash_algo);
 	return 1;
 }
=20
@@ -1523,7 +1525,8 @@ static int tree_content_remove(
 			if (tree_content_remove(e, slash1 + 1, backup_leaf, 0)) {
 				for (n =3D 0; n < e->tree->entry_count; n++) {
 					if (e->tree->entries[n]->versions[1].mode) {
-						oidclr(&root->versions[1].oid);
+						oidclr(&root->versions[1].oid,
+						       the_repository->hash_algo);
 						return 1;
 					}
 				}
@@ -1542,8 +1545,8 @@ static int tree_content_remove(
 		release_tree_content_recursive(e->tree);
 	e->tree =3D NULL;
 	e->versions[1].mode =3D 0;
-	oidclr(&e->versions[1].oid);
-	oidclr(&root->versions[1].oid);
+	oidclr(&e->versions[1].oid, the_repository->hash_algo);
+	oidclr(&root->versions[1].oid, the_repository->hash_algo);
 	return 1;
 }
=20
@@ -1609,7 +1612,7 @@ static int update_branch(struct branch *b)
 		return 0;
 	}
 	if (refs_read_ref(get_main_ref_store(the_repository), b->name, &old_oid))
-		oidclr(&old_oid);
+		oidclr(&old_oid, the_repository->hash_algo);
 	if (!force_update && !is_null_oid(&old_oid)) {
 		struct commit *old_cmit, *new_cmit;
 		int ret;
@@ -2550,8 +2553,8 @@ static void note_change_n(const char *p, struct branc=
h *b, unsigned char *old_fa
 static void file_change_deleteall(struct branch *b)
 {
 	release_tree_content_recursive(b->branch_tree.tree);
-	oidclr(&b->branch_tree.versions[0].oid);
-	oidclr(&b->branch_tree.versions[1].oid);
+	oidclr(&b->branch_tree.versions[0].oid, the_repository->hash_algo);
+	oidclr(&b->branch_tree.versions[1].oid, the_repository->hash_algo);
 	load_tree(&b->branch_tree);
 	b->num_notes =3D 0;
 }
@@ -2570,8 +2573,8 @@ static void parse_from_commit(struct branch *b, char =
*buf, unsigned long size)
 static void parse_from_existing(struct branch *b)
 {
 	if (is_null_oid(&b->oid)) {
-		oidclr(&b->branch_tree.versions[0].oid);
-		oidclr(&b->branch_tree.versions[1].oid);
+		oidclr(&b->branch_tree.versions[0].oid, the_repository->hash_algo);
+		oidclr(&b->branch_tree.versions[1].oid, the_repository->hash_algo);
 	} else {
 		unsigned long size;
 		char *buf;
@@ -2894,9 +2897,9 @@ static void parse_reset_branch(const char *arg)
=20
 	b =3D lookup_branch(arg);
 	if (b) {
-		oidclr(&b->oid);
-		oidclr(&b->branch_tree.versions[0].oid);
-		oidclr(&b->branch_tree.versions[1].oid);
+		oidclr(&b->oid, the_repository->hash_algo);
+		oidclr(&b->branch_tree.versions[0].oid, the_repository->hash_algo);
+		oidclr(&b->branch_tree.versions[1].oid, the_repository->hash_algo);
 		if (b->branch_tree.tree) {
 			release_tree_content_recursive(b->branch_tree.tree);
 			b->branch_tree.tree =3D NULL;
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 44c05ee86c..af329e8d5c 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -29,11 +29,11 @@ static void add_sought_entry(struct ref ***sought, int =
*nr, int *alloc,
 			; /* <oid>, leave oid as name */
 		} else {
 			/* <ref>, clear cruft from oid */
-			oidclr(&oid);
+			oidclr(&oid, the_repository->hash_algo);
 		}
 	} else {
 		/* <ref>, clear cruft from get_oid_hex */
-		oidclr(&oid);
+		oidclr(&oid, the_repository->hash_algo);
 	}
=20
 	ref =3D alloc_ref(name);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ea727fba16..fd968d673d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -528,7 +528,8 @@ static void *unpack_raw_entry(struct object_entry *obj,
=20
 	switch (obj->type) {
 	case OBJ_REF_DELTA:
-		oidread(ref_oid, fill(the_hash_algo->rawsz));
+		oidread(ref_oid, fill(the_hash_algo->rawsz),
+			the_repository->hash_algo);
 		use(the_hash_algo->rawsz);
 		break;
 	case OBJ_OFS_DELTA:
@@ -1372,7 +1373,7 @@ static struct object_entry *append_obj_to_pack(struct=
 hashfile *f,
 	obj[1].idx.offset +=3D write_compressed(f, buf, size);
 	obj[0].idx.crc32 =3D crc32_end(f);
 	hashflush(f);
-	oidread(&obj->idx.oid, sha1);
+	oidread(&obj->idx.oid, sha1, the_repository->hash_algo);
 	return obj;
 }
=20
diff --git a/builtin/log.c b/builtin/log.c
index 78a247d8a9..ccbda8a005 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1938,7 +1938,7 @@ static void print_bases(struct base_tree_info *bases,=
 FILE *file)
 	free(bases->patch_id);
 	bases->nr_patch_id =3D 0;
 	bases->alloc_patch_id =3D 0;
-	oidclr(&bases->base_commit);
+	oidclr(&bases->base_commit, the_repository->hash_algo);
 }
=20
 static const char *diff_title(struct strbuf *sb,
diff --git a/builtin/merge.c b/builtin/merge.c
index daed2d4e1e..abe66311c7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -494,7 +494,7 @@ static void merge_name(const char *remote, struct strbu=
f *msg)
 	strbuf_branchname(&bname, remote, 0);
 	remote =3D bname.buf;
=20
-	oidclr(&branch_head);
+	oidclr(&branch_head, the_repository->hash_algo);
 	remote_head =3D get_merge_parent(remote);
 	if (!remote_head)
 		die(_("'%s' does not point to a commit"), remote);
@@ -1690,7 +1690,7 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	 * index and working tree polluted.
 	 */
 	if (save_state(&stash))
-		oidclr(&stash);
+		oidclr(&stash, the_repository->hash_algo);
=20
 	for (i =3D 0; i < use_strategies_nr; i++) {
 		int ret, cnt;
diff --git a/builtin/notes.c b/builtin/notes.c
index 7f80b3449b..d9c356e354 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -828,7 +828,7 @@ static int merge_commit(struct notes_merge_options *o)
 	if (partial->parents)
 		oidcpy(&parent_oid, &partial->parents->item->object.oid);
 	else
-		oidclr(&parent_oid);
+		oidclr(&parent_oid, the_repository->hash_algo);
=20
 	CALLOC_ARRAY(t, 1);
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 638f5c57f0..2b00983a99 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2078,7 +2078,8 @@ static void check_object(struct object_entry *entry, =
uint32_t object_index)
 				oidread(&base_ref,
 					use_pack(p, &w_curs,
 						 entry->in_pack_offset + used,
-						 NULL));
+						 NULL),
+					the_repository->hash_algo);
 				have_base =3D 1;
 			}
 			entry->in_pack_header_size =3D used + the_hash_algo->rawsz;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 103c11b9d3..dd9bf35f5b 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -100,7 +100,7 @@ static inline struct llist_item *llist_insert(struct ll=
ist *list,
 					      const unsigned char *oid)
 {
 	struct llist_item *new_item =3D llist_item_get();
-	oidread(&new_item->oid, oid);
+	oidread(&new_item->oid, oid, the_repository->hash_algo);
 	new_item->next =3D NULL;
=20
 	if (after) {
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 583099cacf..d790ae6354 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -70,7 +70,7 @@ static int get_one_patchid(struct object_id *next_oid, st=
ruct object_id *result,
 	git_hash_ctx ctx;
=20
 	the_hash_algo->init_fn(&ctx);
-	oidclr(result);
+	oidclr(result, the_repository->hash_algo);
=20
 	while (strbuf_getwholeline(line_buf, stdin, '\n') !=3D EOF) {
 		char *line =3D line_buf->buf;
@@ -166,7 +166,7 @@ static int get_one_patchid(struct object_id *next_oid, =
struct object_id *result,
 	}
=20
 	if (!found_next)
-		oidclr(next_oid);
+		oidclr(next_oid, the_repository->hash_algo);
=20
 	flush_one_hunk(result, &ctx);
=20
@@ -179,7 +179,7 @@ static void generate_id_list(int stable, int verbatim)
 	int patchlen;
 	struct strbuf line_buf =3D STRBUF_INIT;
=20
-	oidclr(&oid);
+	oidclr(&oid, the_repository->hash_algo);
 	while (!feof(stdin)) {
 		patchlen =3D get_one_patchid(&n, &result, &line_buf, stable, verbatim);
 		flush_current_id(patchlen, &oid, &result);
diff --git a/builtin/pull.c b/builtin/pull.c
index d622202bce..2a73e673f3 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1038,7 +1038,7 @@ int cmd_pull(int argc, const char **argv, const char =
*prefix)
 		die_conclude_merge();
=20
 	if (repo_get_oid(the_repository, "HEAD", &orig_head))
-		oidclr(&orig_head);
+		oidclr(&orig_head, the_repository->hash_algo);
=20
 	if (opt_rebase) {
 		if (opt_autostash =3D=3D -1)
@@ -1053,7 +1053,7 @@ int cmd_pull(int argc, const char **argv, const char =
*prefix)
 				_("Please commit or stash them."), 1, 0);
=20
 		if (get_rebase_fork_point(&rebase_fork_point, repo, *refspecs))
-			oidclr(&rebase_fork_point);
+			oidclr(&rebase_fork_point, the_repository->hash_algo);
 	}
=20
 	if (run_fetch(repo, refspecs))
@@ -1063,7 +1063,7 @@ int cmd_pull(int argc, const char **argv, const char =
*prefix)
 		return 0;
=20
 	if (repo_get_oid(the_repository, "HEAD", &curr_head))
-		oidclr(&curr_head);
+		oidclr(&curr_head, the_repository->hash_algo);
=20
 	if (!is_null_oid(&orig_head) && !is_null_oid(&curr_head) &&
 			!oideq(&orig_head, &curr_head)) {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 01c1f04ece..aa5ba27d17 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -741,7 +741,7 @@ static void prepare_push_cert_sha1(struct child_process=
 *proc)
 		already_done =3D 1;
 		if (write_object_file(push_cert.buf, push_cert.len, OBJ_BLOB,
 				      &push_cert_oid))
-			oidclr(&push_cert_oid);
+			oidclr(&push_cert_oid, the_repository->hash_algo);
=20
 		memset(&sigcheck, '\0', sizeof(sigcheck));
=20
diff --git a/builtin/replace.c b/builtin/replace.c
index ce9f6974d2..1ef833c07f 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -167,7 +167,7 @@ static int check_ref_valid(struct object_id *object,
 		return error(_("'%s' is not a valid ref name"), ref->buf);
=20
 	if (refs_read_ref(get_main_ref_store(the_repository), ref->buf, prev))
-		oidclr(prev);
+		oidclr(prev, the_repository->hash_algo);
 	else if (!force)
 		return error(_("replace ref '%s' already exists"), ref->buf);
 	return 0;
diff --git a/builtin/rm.c b/builtin/rm.c
index d195c16e74..0e79cbab62 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -377,7 +377,7 @@ int cmd_rm(int argc, const char **argv, const char *pre=
fix)
 	if (!force) {
 		struct object_id oid;
 		if (repo_get_oid(the_repository, "HEAD", &oid))
-			oidclr(&oid);
+			oidclr(&oid, the_repository->hash_algo);
 		if (check_local_mod(&oid, index_only))
 			exit(1);
 	}
diff --git a/builtin/tag.c b/builtin/tag.c
index 6e2c0cf342..a1fb218512 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -650,7 +650,7 @@ int cmd_tag(int argc, const char **argv, const char *pr=
efix)
 		die(_("'%s' is not a valid tag name."), tag);
=20
 	if (refs_read_ref(get_main_ref_store(the_repository), ref.buf, &prev))
-		oidclr(&prev);
+		oidclr(&prev, the_repository->hash_algo);
 	else if (!force)
 		die(_("tag '%s' already exists"), tag);
=20
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 0855572c27..08fa2a7a74 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -439,7 +439,7 @@ static void unpack_delta_entry(enum object_type type, u=
nsigned long delta_size,
 	struct object_id base_oid;
=20
 	if (type =3D=3D OBJ_REF_DELTA) {
-		oidread(&base_oid, fill(the_hash_algo->rawsz));
+		oidread(&base_oid, fill(the_hash_algo->rawsz), the_repository->hash_algo=
);
 		use(the_hash_algo->rawsz);
 		delta_data =3D get_data(delta_size);
 		if (!delta_data)
@@ -451,7 +451,7 @@ static void unpack_delta_entry(enum object_type type, u=
nsigned long delta_size,
 			return; /* we are done */
 		else {
 			/* cannot resolve yet --- queue it */
-			oidclr(&obj_list[nr].oid);
+			oidclr(&obj_list[nr].oid, the_repository->hash_algo);
 			add_delta_to_list(nr, &base_oid, 0, delta_data, delta_size);
 			return;
 		}
@@ -500,7 +500,7 @@ static void unpack_delta_entry(enum object_type type, u=
nsigned long delta_size,
 			 * The delta base object is itself a delta that
 			 * has not been resolved yet.
 			 */
-			oidclr(&obj_list[nr].oid);
+			oidclr(&obj_list[nr].oid, the_repository->hash_algo);
 			add_delta_to_list(nr, null_oid(), base_offset,
 					  delta_data, delta_size);
 			return;
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 6cda1c08aa..f8a5b087f8 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -122,7 +122,7 @@ static int parse_next_oid(const char **next, const char=
 *end,
 				goto invalid;
 		} else {
 			/* Without -z, an empty value means all zeros: */
-			oidclr(oid);
+			oidclr(oid, the_repository->hash_algo);
 		}
 	} else {
 		/* With -z, read the next NUL-terminated line */
@@ -142,7 +142,7 @@ static int parse_next_oid(const char **next, const char=
 *end,
 			/* With -z, treat an empty value as all zeros: */
 			warning("%s %s: missing <new-oid>, treating as zero",
 				command, refname);
-			oidclr(oid);
+			oidclr(oid, the_repository->hash_algo);
 		} else {
 			/*
 			 * With -z, an empty non-required value means
@@ -291,7 +291,7 @@ static void parse_cmd_verify(struct ref_transaction *tr=
ansaction,
=20
 	if (parse_next_oid(&next, end, &old_oid, "verify", refname,
 			   PARSE_SHA1_OLD))
-		oidclr(&old_oid);
+		oidclr(&old_oid, the_repository->hash_algo);
=20
 	if (*next !=3D line_termination)
 		die("verify %s: extra input: %s", refname, next);
@@ -564,7 +564,7 @@ int cmd_update_ref(int argc, const char **argv, const c=
har *prefix)
 			 * The empty string implies that the reference
 			 * must not already exist:
 			 */
-			oidclr(&oldoid);
+			oidclr(&oldoid, the_repository->hash_algo);
 		else if (repo_get_oid(the_repository, oldval, &oldoid))
 			die("%s: not a valid old SHA1", oldval);
 	}
diff --git a/cache-tree.c b/cache-tree.c
index 387c0a3e5b..e4255c4d02 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -578,7 +578,8 @@ static struct cache_tree *read_one(const char **buffer,=
 unsigned long *size_p)
 	if (0 <=3D it->entry_count) {
 		if (size < rawsz)
 			goto free_return;
-		oidread(&it->oid, (const unsigned char *)buf);
+		oidread(&it->oid, (const unsigned char *)buf,
+			the_repository->hash_algo);
 		buf +=3D rawsz;
 		size -=3D rawsz;
 	}
diff --git a/commit-graph.c b/commit-graph.c
index 3429156b28..e4eefd83bf 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -475,7 +475,8 @@ struct commit_graph *parse_commit_graph(struct repo_set=
tings *s,
 		FREE_AND_NULL(graph->bloom_filter_settings);
 	}
=20
-	oidread(&graph->oid, graph->data + graph->data_len - graph->hash_len);
+	oidread(&graph->oid, graph->data + graph->data_len - graph->hash_len,
+		the_repository->hash_algo);
=20
 	free_chunkfile(cf);
 	return graph;
@@ -838,7 +839,8 @@ static void load_oid_from_graph(struct commit_graph *g,
=20
 	lex_index =3D pos - g->num_commits_in_base;
=20
-	oidread(oid, g->chunk_oid_lookup + st_mult(g->hash_len, lex_index));
+	oidread(oid, g->chunk_oid_lookup + st_mult(g->hash_len, lex_index),
+		the_repository->hash_algo);
 }
=20
 static struct commit_list **insert_parent_or_die(struct repository *r,
@@ -1080,7 +1082,7 @@ static struct tree *load_tree_for_commit(struct repos=
itory *r,
 	commit_data =3D g->chunk_commit_data +
 			st_mult(GRAPH_DATA_WIDTH, graph_pos - g->num_commits_in_base);
=20
-	oidread(&oid, commit_data);
+	oidread(&oid, commit_data, r->hash_algo);
 	set_commit_tree(c, lookup_tree(r, &oid));
=20
 	return c->maybe_tree;
@@ -2556,7 +2558,8 @@ int write_commit_graph(struct object_directory *odb,
 		struct commit_graph *g =3D ctx->r->objects->commit_graph;
 		for (i =3D 0; i < g->num_commits; i++) {
 			struct object_id oid;
-			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_len, i));
+			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
+				r->hash_algo);
 			oid_array_append(&ctx->oids, &oid);
 		}
 	}
@@ -2675,7 +2678,8 @@ static int verify_one_commit_graph(struct repository =
*r,
 	for (i =3D 0; i < g->num_commits; i++) {
 		struct commit *graph_commit;
=20
-		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_len, i));
+		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
+			r->hash_algo);
=20
 		if (i && oidcmp(&prev_oid, &cur_oid) >=3D 0)
 			graph_report(_("commit-graph has incorrect OID order: %s then %s"),
@@ -2719,7 +2723,8 @@ static int verify_one_commit_graph(struct repository =
*r,
 		timestamp_t generation;
=20
 		display_progress(progress, ++(*seen));
-		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_len, i));
+		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
+			the_repository->hash_algo);
=20
 		graph_commit =3D lookup_commit(r, &cur_oid);
 		odb_commit =3D (struct commit *)create_object(r, &cur_oid, alloc_commit_=
node(r));
diff --git a/diff-lib.c b/diff-lib.c
index 5a5a50c5a1..3fb8d79fef 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -160,7 +160,7 @@ void run_diff_files(struct rev_info *revs, unsigned int=
 option)
 			dpath->next =3D NULL;
 			memcpy(dpath->path, ce->name, path_len);
 			dpath->path[path_len] =3D '\0';
-			oidclr(&dpath->oid);
+			oidclr(&dpath->oid, the_repository->hash_algo);
 			memset(&(dpath->parent[0]), 0,
 			       sizeof(struct combine_diff_parent)*5);
=20
@@ -412,7 +412,7 @@ static int show_modified(struct rev_info *revs,
 		memcpy(p->path, new_entry->name, pathlen);
 		p->path[pathlen] =3D 0;
 		p->mode =3D mode;
-		oidclr(&p->oid);
+		oidclr(&p->oid, the_repository->hash_algo);
 		memset(p->parent, 0, 2 * sizeof(struct combine_diff_parent));
 		p->parent[0].status =3D DIFF_STATUS_MODIFIED;
 		p->parent[0].mode =3D new_entry->ce_mode;
diff --git a/diff.c b/diff.c
index e70301df76..60d1f7be81 100644
--- a/diff.c
+++ b/diff.c
@@ -4567,7 +4567,7 @@ static void diff_fill_oid_info(struct diff_filespec *=
one, struct index_state *is
 		if (!one->oid_valid) {
 			struct stat st;
 			if (one->is_stdin) {
-				oidclr(&one->oid);
+				oidclr(&one->oid, the_repository->hash_algo);
 				return;
 			}
 			if (lstat(one->path, &st) < 0)
@@ -4577,7 +4577,7 @@ static void diff_fill_oid_info(struct diff_filespec *=
one, struct index_state *is
 		}
 	}
 	else
-		oidclr(&one->oid);
+		oidclr(&one->oid, the_repository->hash_algo);
 }
=20
 static void strip_prefix(int prefix_length, const char **namep, const char=
 **otherp)
@@ -6404,7 +6404,7 @@ static int diff_get_patch_id(struct diff_options *opt=
ions, struct object_id *oid
 	the_hash_algo->init_fn(&ctx);
 	memset(&data, 0, sizeof(struct patch_id_t));
 	data.ctx =3D &ctx;
-	oidclr(oid);
+	oidclr(oid, the_repository->hash_algo);
=20
 	for (i =3D 0; i < q->nr; i++) {
 		xpparam_t xpp;
diff --git a/dir.c b/dir.c
index 45be4ad261..5de421c29c 100644
--- a/dir.c
+++ b/dir.c
@@ -1687,7 +1687,7 @@ static void prep_exclude(struct dir_struct *dir,
 		}
=20
 		/* Try to read per-directory file */
-		oidclr(&oid_stat.oid);
+		oidclr(&oid_stat.oid, the_repository->hash_algo);
 		oid_stat.valid =3D 0;
 		if (dir->exclude_per_dir &&
 		    /*
@@ -3794,7 +3794,7 @@ static void read_oid(size_t pos, void *cb)
 		rd->data =3D rd->end + 1;
 		return;
 	}
-	oidread(&ud->exclude_oid, rd->data);
+	oidread(&ud->exclude_oid, rd->data, the_repository->hash_algo);
 	rd->data +=3D the_hash_algo->rawsz;
 }
=20
@@ -3802,7 +3802,7 @@ static void load_oid_stat(struct oid_stat *oid_stat, =
const unsigned char *data,
 			  const unsigned char *sha1)
 {
 	stat_data_from_disk(&oid_stat->stat, data);
-	oidread(&oid_stat->oid, sha1);
+	oidread(&oid_stat->oid, sha1, the_repository->hash_algo);
 	oid_stat->valid =3D 1;
 }
=20
diff --git a/hash-ll.h b/hash-ll.h
index fabdd8ecc7..dbb96369fc 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -284,6 +284,20 @@ static inline void oidcpy(struct object_id *dst, const=
 struct object_id *src)
 	dst->algo =3D src->algo;
 }
=20
+static inline void oidread(struct object_id *oid, const unsigned char *has=
h,
+			   const struct git_hash_algo *algop)
+{
+	memcpy(oid->hash, hash, algop->rawsz);
+	oid->algo =3D hash_algo_by_ptr(algop);
+}
+
+static inline void oidclr(struct object_id *oid,
+			  const struct git_hash_algo *algop)
+{
+	memset(oid->hash, 0, GIT_MAX_RAWSZ);
+	oid->algo =3D hash_algo_by_ptr(algop);
+}
+
 static inline struct object_id *oiddup(const struct object_id *src)
 {
 	struct object_id *dst =3D xmalloc(sizeof(struct object_id));
diff --git a/hash.h b/hash.h
index 714938e2eb..43623a0c86 100644
--- a/hash.h
+++ b/hash.h
@@ -47,23 +47,6 @@ static inline void oidcpy_with_padding(struct object_id =
*dst,
 	dst->algo =3D src->algo;
 }
=20
-static inline void oidclr(struct object_id *oid)
-{
-	memset(oid->hash, 0, GIT_MAX_RAWSZ);
-	oid->algo =3D hash_algo_by_ptr(the_hash_algo);
-}
-
-static inline void oidread_algop(struct object_id *oid, const unsigned cha=
r *hash, const struct git_hash_algo *algop)
-{
-	memcpy(oid->hash, hash, algop->rawsz);
-	oid->algo =3D hash_algo_by_ptr(algop);
-}
-
-static inline void oidread(struct object_id *oid, const unsigned char *has=
h)
-{
-	oidread_algop(oid, hash, the_hash_algo);
-}
-
 static inline int is_empty_blob_oid(const struct object_id *oid)
 {
 	return oideq(oid, the_hash_algo->empty_blob);
diff --git a/http-push.c b/http-push.c
index 1fe51226fd..86de238b84 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1552,7 +1552,7 @@ static void fetch_symref(const char *path, char **sym=
ref, struct object_id *oid)
 	free(url);
=20
 	FREE_AND_NULL(*symref);
-	oidclr(oid);
+	oidclr(oid, the_repository->hash_algo);
=20
 	if (buffer.len =3D=3D 0)
 		return;
diff --git a/http-walker.c b/http-walker.c
index cf7f8c82bc..b7110b6f82 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -152,7 +152,7 @@ static void prefetch(struct walker *walker, unsigned ch=
ar *sha1)
=20
 	newreq =3D xmalloc(sizeof(*newreq));
 	newreq->walker =3D walker;
-	oidread(&newreq->oid, sha1);
+	oidread(&newreq->oid, sha1, the_repository->hash_algo);
 	newreq->repo =3D data->alt;
 	newreq->state =3D WAITING;
 	newreq->req =3D NULL;
diff --git a/match-trees.c b/match-trees.c
index 849b391d3d..50c42e2061 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -229,7 +229,7 @@ static int splice_tree(const struct object_id *oid1, co=
nst char *prefix,
 		    oid_to_hex(oid1));
 	if (*subpath) {
 		struct object_id tree_oid;
-		oidread(&tree_oid, rewrite_here);
+		oidread(&tree_oid, rewrite_here, the_repository->hash_algo);
 		status =3D splice_tree(&tree_oid, subpath, oid2, &subtree);
 		if (status)
 			return status;
diff --git a/midx.c b/midx.c
index bc4797196f..1e75f1a7eb 100644
--- a/midx.c
+++ b/midx.c
@@ -304,7 +304,8 @@ struct object_id *nth_midxed_object_oid(struct object_i=
d *oid,
 	if (n >=3D m->num_objects)
 		return NULL;
=20
-	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n));
+	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n),
+		the_repository->hash_algo);
 	return oid;
 }
=20
diff --git a/notes-merge.c b/notes-merge.c
index 6a9a139b12..801941c2d1 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -240,7 +240,7 @@ static void diff_tree_local(struct notes_merge_options =
*o,
 			 *     (will be overwritten by following addition)
 			 */
 			if (oideq(&mp->local, &uninitialized))
-				oidclr(&mp->local);
+				oidclr(&mp->local, the_repository->hash_algo);
 		} else if (is_null_oid(&p->one->oid)) { /* addition */
 			/*
 			 * Either this is a true addition (1), or it is part
@@ -556,7 +556,7 @@ int notes_merge(struct notes_merge_options *o,
=20
 	assert(o->local_ref && o->remote_ref);
 	assert(!strcmp(o->local_ref, local_tree->ref));
-	oidclr(result_oid);
+	oidclr(result_oid, the_repository->hash_algo);
=20
 	trace_printf("notes_merge(o->local_ref =3D %s, o->remote_ref =3D %s)\n",
 	       o->local_ref, o->remote_ref);
@@ -579,7 +579,7 @@ int notes_merge(struct notes_merge_options *o,
 		 * unborn ref, perform the merge using an empty notes tree.
 		 */
 		if (!check_refname_format(o->remote_ref, 0)) {
-			oidclr(&remote_oid);
+			oidclr(&remote_oid, the_repository->hash_algo);
 			remote =3D NULL;
 		} else {
 			die("Failed to resolve remote notes ref '%s'",
diff --git a/notes.c b/notes.c
index 5296fd863f..3a8da92fb9 100644
--- a/notes.c
+++ b/notes.c
@@ -353,7 +353,7 @@ static void add_non_note(struct notes_tree *t, char *pa=
th,
 	n->next =3D NULL;
 	n->path =3D path;
 	n->mode =3D mode;
-	oidread(&n->oid, sha1);
+	oidread(&n->oid, sha1, the_repository->hash_algo);
 	t->prev_non_note =3D n;
=20
 	if (!t->first_non_note) {
@@ -1036,7 +1036,7 @@ void init_notes(struct notes_tree *t, const char *not=
es_ref,
 		die("Failed to read notes tree referenced by %s (%s)",
 		    notes_ref, oid_to_hex(&object_oid));
=20
-	oidclr(&root_tree.key_oid);
+	oidclr(&root_tree.key_oid, the_repository->hash_algo);
 	oidcpy(&root_tree.val_oid, &oid);
 	load_subtree(t, &root_tree, t->root, 0);
 }
@@ -1146,8 +1146,8 @@ int remove_note(struct notes_tree *t, const unsigned =
char *object_sha1)
 	if (!t)
 		t =3D &default_notes_tree;
 	assert(t->initialized);
-	oidread(&l.key_oid, object_sha1);
-	oidclr(&l.val_oid);
+	oidread(&l.key_oid, object_sha1, the_repository->hash_algo);
+	oidclr(&l.val_oid, the_repository->hash_algo);
 	note_tree_remove(t, t->root, 0, &l);
 	if (is_null_oid(&l.val_oid)) /* no note was removed */
 		return 1;
diff --git a/object-file-convert.c b/object-file-convert.c
index 4f6189095b..f684038f7f 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -56,7 +56,7 @@ static int decode_tree_entry_raw(struct object_id *oid, c=
onst char **path,
 		return -1;
 	*len =3D strlen(*path) + 1;
=20
-	oidread_algop(oid, (const unsigned char *)*path + *len, algo);
+	oidread(oid, (const unsigned char *)*path + *len, algo);
 	return 0;
 }
=20
diff --git a/object-file.c b/object-file.c
index a40300ce4a..c161e3e2a5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1446,7 +1446,7 @@ static int loose_object_info(struct repository *r,
 	int allow_unknown =3D flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
=20
 	if (oi->delta_base_oid)
-		oidclr(oi->delta_base_oid);
+		oidclr(oi->delta_base_oid, the_repository->hash_algo);
=20
 	/*
 	 * If we don't care about type or size, then we don't
@@ -1580,7 +1580,7 @@ static int do_oid_object_info_extended(struct reposit=
ory *r,
 		if (oi->disk_sizep)
 			*(oi->disk_sizep) =3D 0;
 		if (oi->delta_base_oid)
-			oidclr(oi->delta_base_oid);
+			oidclr(oi->delta_base_oid, the_repository->hash_algo);
 		if (oi->type_name)
 			strbuf_addstr(oi->type_name, type_name(co->type));
 		if (oi->contentp)
diff --git a/packfile.c b/packfile.c
index 9156e9122c..ec7312cd20 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1251,7 +1251,7 @@ static int get_delta_base_oid(struct packed_git *p,
 {
 	if (type =3D=3D OBJ_REF_DELTA) {
 		unsigned char *base =3D use_pack(p, w_curs, curpos, NULL);
-		oidread(oid, base);
+		oidread(oid, base, the_repository->hash_algo);
 		return 0;
 	} else if (type =3D=3D OBJ_OFS_DELTA) {
 		uint32_t base_pos;
@@ -1593,7 +1593,7 @@ int packed_object_info(struct repository *r, struct p=
acked_git *p,
 				goto out;
 			}
 		} else
-			oidclr(oi->delta_base_oid);
+			oidclr(oi->delta_base_oid, the_repository->hash_algo);
 	}
=20
 	oi->whence =3D in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
@@ -1917,10 +1917,12 @@ int nth_packed_object_id(struct object_id *oid,
 		return -1;
 	index +=3D 4 * 256;
 	if (p->index_version =3D=3D 1) {
-		oidread(oid, index + st_add(st_mult(hashsz + 4, n), 4));
+		oidread(oid, index + st_add(st_mult(hashsz + 4, n), 4),
+			the_repository->hash_algo);
 	} else {
 		index +=3D 8;
-		oidread(oid, index + st_mult(hashsz, n));
+		oidread(oid, index + st_mult(hashsz, n),
+			the_repository->hash_algo);
 	}
 	return 0;
 }
diff --git a/read-cache.c b/read-cache.c
index 2642ac9558..836f1db721 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1728,7 +1728,7 @@ static int verify_hdr(const struct cache_header *hdr,=
 unsigned long size)
=20
 	end =3D (unsigned char *)hdr + size;
 	start =3D end - the_hash_algo->rawsz;
-	oidread(&oid, start);
+	oidread(&oid, start, the_repository->hash_algo);
 	if (oideq(&oid, null_oid()))
 		return 0;
=20
@@ -1876,7 +1876,8 @@ static struct cache_entry *create_from_disk(struct me=
m_pool *ce_mem_pool,
 	ce->ce_flags =3D flags & ~CE_NAMEMASK;
 	ce->ce_namelen =3D len;
 	ce->index =3D 0;
-	oidread(&ce->oid, (const unsigned char *)ondisk + offsetof(struct ondisk_=
cache_entry, data));
+	oidread(&ce->oid, (const unsigned char *)ondisk + offsetof(struct ondisk_=
cache_entry, data),
+		the_repository->hash_algo);
=20
 	if (expand_name_field) {
 		if (copy_len)
@@ -2249,7 +2250,8 @@ int do_read_index(struct index_state *istate, const c=
har *path, int must_exist)
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
=20
-	oidread(&istate->oid, (const unsigned char *)hdr + mmap_size - the_hash_a=
lgo->rawsz);
+	oidread(&istate->oid, (const unsigned char *)hdr + mmap_size - the_hash_a=
lgo->rawsz,
+		the_repository->hash_algo);
 	istate->version =3D ntohl(hdr->hdr_version);
 	istate->cache_nr =3D ntohl(hdr->hdr_entries);
 	istate->cache_alloc =3D alloc_nr(istate->cache_nr);
diff --git a/refs.c b/refs.c
index 1304d3dd87..6e7caefdcf 100644
--- a/refs.c
+++ b/refs.c
@@ -1822,7 +1822,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store =
*refs,
 			    failure_errno !=3D ENOTDIR)
 				return NULL;
=20
-			oidclr(oid);
+			oidclr(oid, the_repository->hash_algo);
 			if (*flags & REF_BAD_NAME)
 				*flags |=3D REF_ISBROKEN;
 			return refname;
@@ -1832,7 +1832,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store =
*refs,
=20
 		if (!(read_flags & REF_ISSYMREF)) {
 			if (*flags & REF_BAD_NAME) {
-				oidclr(oid);
+				oidclr(oid, the_repository->hash_algo);
 				*flags |=3D REF_ISBROKEN;
 			}
 			return refname;
@@ -1840,7 +1840,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store =
*refs,
=20
 		refname =3D sb_refname.buf;
 		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
-			oidclr(oid);
+			oidclr(oid, the_repository->hash_algo);
 			return refname;
 		}
 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4519b46171..b484b5880d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -246,7 +246,7 @@ static void loose_fill_ref_dir_regular_file(struct file=
s_ref_store *refs,
=20
 	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,
 				     &oid, &flag)) {
-		oidclr(&oid);
+		oidclr(&oid, the_repository->hash_algo);
 		flag |=3D REF_ISBROKEN;
 	} else if (is_null_oid(&oid)) {
 		/*
@@ -263,7 +263,7 @@ static void loose_fill_ref_dir_regular_file(struct file=
s_ref_store *refs,
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!refname_is_safe(refname))
 			die("loose refname is dangerous: %s", refname);
-		oidclr(&oid);
+		oidclr(&oid, the_repository->hash_algo);
 		flag |=3D REF_BAD_NAME | REF_ISBROKEN;
 	}
 	add_entry_to_dir(dir, create_ref_entry(refname, &oid, flag));
@@ -1150,7 +1150,7 @@ static struct ref_lock *lock_ref_oid_basic(struct fil=
es_ref_store *refs,
=20
 	if (!refs_resolve_ref_unsafe(&refs->base, lock->ref_name, 0,
 				     &lock->old_oid, NULL))
-		oidclr(&lock->old_oid);
+		oidclr(&lock->old_oid, the_repository->hash_algo);
 	goto out;
=20
  error_return:
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index c4c1e36aa2..5ab1b21d10 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -894,7 +894,7 @@ static int next_record(struct packed_ref_iterator *iter)
 		if (!refname_is_safe(iter->base.refname))
 			die("packed refname is dangerous: %s",
 			    iter->base.refname);
-		oidclr(&iter->oid);
+		oidclr(&iter->oid, the_repository->hash_algo);
 		iter->base.flags |=3D REF_BAD_NAME | REF_ISBROKEN;
 	}
 	if (iter->snapshot->peeled =3D=3D PEELED_FULLY ||
@@ -919,13 +919,13 @@ static int next_record(struct packed_ref_iterator *it=
er)
 		 * we suppress it if the reference is broken:
 		 */
 		if ((iter->base.flags & REF_ISBROKEN)) {
-			oidclr(&iter->peeled);
+			oidclr(&iter->peeled, the_repository->hash_algo);
 			iter->base.flags &=3D ~REF_KNOWS_PEELED;
 		} else {
 			iter->base.flags |=3D REF_KNOWS_PEELED;
 		}
 	} else {
-		oidclr(&iter->peeled);
+		oidclr(&iter->peeled, the_repository->hash_algo);
 	}
=20
 	return ITER_OK;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 9886fc67a4..57df2aba66 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -217,7 +217,8 @@ static int read_ref_without_reload(struct reftable_stac=
k *stack,
 		strbuf_addstr(referent, ref.value.symref);
 		*type |=3D REF_ISSYMREF;
 	} else if (reftable_ref_record_val1(&ref)) {
-		oidread(oid, reftable_ref_record_val1(&ref));
+		oidread(oid, reftable_ref_record_val1(&ref),
+			the_repository->hash_algo);
 	} else {
 		/* We got a tombstone, which should not happen. */
 		BUG("unhandled reference value type %d", ref.value_type);
@@ -483,15 +484,17 @@ static int reftable_ref_iterator_advance(struct ref_i=
terator *ref_iterator)
=20
 		switch (iter->ref.value_type) {
 		case REFTABLE_REF_VAL1:
-			oidread(&iter->oid, iter->ref.value.val1);
+			oidread(&iter->oid, iter->ref.value.val1,
+				the_repository->hash_algo);
 			break;
 		case REFTABLE_REF_VAL2:
-			oidread(&iter->oid, iter->ref.value.val2.value);
+			oidread(&iter->oid, iter->ref.value.val2.value,
+				the_repository->hash_algo);
 			break;
 		case REFTABLE_REF_SYMREF:
 			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname,
 						     RESOLVE_REF_READING, &iter->oid, &flags))
-				oidclr(&iter->oid);
+				oidclr(&iter->oid, the_repository->hash_algo);
 			break;
 		default:
 			BUG("unhandled reference value type %d", iter->ref.value_type);
@@ -503,7 +506,7 @@ static int reftable_ref_iterator_advance(struct ref_ite=
rator *ref_iterator)
 		if (check_refname_format(iter->ref.refname, REFNAME_ALLOW_ONELEVEL)) {
 			if (!refname_is_safe(iter->ref.refname))
 				die(_("refname is dangerous: %s"), iter->ref.refname);
-			oidclr(&iter->oid);
+			oidclr(&iter->oid, the_repository->hash_algo);
 			flags |=3D REF_BAD_NAME | REF_ISBROKEN;
 		}
=20
@@ -545,7 +548,8 @@ static int reftable_ref_iterator_peel(struct ref_iterat=
or *ref_iterator,
 		(struct reftable_ref_iterator *)ref_iterator;
=20
 	if (iter->ref.value_type =3D=3D REFTABLE_REF_VAL2) {
-		oidread(peeled, iter->ref.value.val2.target_value);
+		oidread(peeled, iter->ref.value.val2.target_value,
+			the_repository->hash_algo);
 		return 0;
 	}
=20
@@ -1776,8 +1780,8 @@ static int yield_log_record(struct reftable_log_recor=
d *log,
 	struct object_id old_oid, new_oid;
 	const char *full_committer;
=20
-	oidread(&old_oid, log->value.update.old_hash);
-	oidread(&new_oid, log->value.update.new_hash);
+	oidread(&old_oid, log->value.update.old_hash, the_repository->hash_algo);
+	oidread(&new_oid, log->value.update.new_hash, the_repository->hash_algo);
=20
 	/*
 	 * When both the old object ID and the new object ID are null
@@ -2178,7 +2182,8 @@ static int reftable_be_reflog_expire(struct ref_store=
 *ref_store,
 	if (ret < 0)
 		goto done;
 	if (reftable_ref_record_val1(&ref_record))
-		oidread(&oid, reftable_ref_record_val1(&ref_record));
+		oidread(&oid, reftable_ref_record_val1(&ref_record),
+			the_repository->hash_algo);
 	prepare_fn(refname, &oid, policy_cb_data);
=20
 	while (1) {
@@ -2193,8 +2198,10 @@ static int reftable_be_reflog_expire(struct ref_stor=
e *ref_store,
 			break;
 		}
=20
-		oidread(&old_oid, log.value.update.old_hash);
-		oidread(&new_oid, log.value.update.new_hash);
+		oidread(&old_oid, log.value.update.old_hash,
+			the_repository->hash_algo);
+		oidread(&new_oid, log.value.update.new_hash,
+			the_repository->hash_algo);
=20
 		/*
 		 * Skip over the reflog existence marker. We will add it back
@@ -2225,8 +2232,10 @@ static int reftable_be_reflog_expire(struct ref_stor=
e *ref_store,
 		struct object_id old_oid, new_oid;
=20
 		*dest =3D logs[i];
-		oidread(&old_oid, logs[i].value.update.old_hash);
-		oidread(&new_oid, logs[i].value.update.new_hash);
+		oidread(&old_oid, logs[i].value.update.old_hash,
+			the_repository->hash_algo);
+		oidread(&new_oid, logs[i].value.update.new_hash,
+			the_repository->hash_algo);
=20
 		if (should_prune_fn(&old_oid, &new_oid, logs[i].value.update.email,
 				    (timestamp_t)logs[i].value.update.time,
@@ -2243,7 +2252,7 @@ static int reftable_be_reflog_expire(struct ref_store=
 *ref_store,
=20
 	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash &&
 	    reftable_ref_record_val1(&ref_record))
-		oidread(&arg.update_oid, last_hash);
+		oidread(&arg.update_oid, last_hash, the_repository->hash_algo);
=20
 	arg.refs =3D refs;
 	arg.records =3D rewritten;
diff --git a/remote.c b/remote.c
index dcb5492c85..1064171085 100644
--- a/remote.c
+++ b/remote.c
@@ -1164,7 +1164,7 @@ static void tail_link_ref(struct ref *ref, struct ref=
 ***tail)
 static struct ref *alloc_delete_ref(void)
 {
 	struct ref *ref =3D alloc_ref("(delete)");
-	oidclr(&ref->new_oid);
+	oidclr(&ref->new_oid, the_repository->hash_algo);
 	return ref;
 }
=20
@@ -2531,7 +2531,7 @@ static int parse_push_cas_option(struct push_cas_opti=
on *cas, const char *arg, i
 	if (!*colon)
 		entry->use_tracking =3D 1;
 	else if (!colon[1])
-		oidclr(&entry->expect);
+		oidclr(&entry->expect, the_repository->hash_algo);
 	else if (repo_get_oid(the_repository, colon + 1, &entry->expect))
 		return error(_("cannot parse expected object name '%s'"),
 			     colon + 1);
@@ -2733,7 +2733,7 @@ static void apply_cas(struct push_cas_option *cas,
 		else if (remote_tracking(remote, ref->name,
 					 &ref->old_oid_expect,
 					 &ref->tracking_ref))
-			oidclr(&ref->old_oid_expect);
+			oidclr(&ref->old_oid_expect, the_repository->hash_algo);
 		else
 			ref->check_reachable =3D cas->use_force_if_includes;
 		return;
@@ -2747,7 +2747,7 @@ static void apply_cas(struct push_cas_option *cas,
 	if (remote_tracking(remote, ref->name,
 			    &ref->old_oid_expect,
 			    &ref->tracking_ref))
-		oidclr(&ref->old_oid_expect);
+		oidclr(&ref->old_oid_expect, the_repository->hash_algo);
 	else
 		ref->check_reachable =3D cas->use_force_if_includes;
 }
diff --git a/resolve-undo.c b/resolve-undo.c
index cd02dc9928..4e6f0e4676 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -93,7 +93,8 @@ struct string_list *resolve_undo_read(const char *data, u=
nsigned long size)
 				continue;
 			if (size < rawsz)
 				goto error;
-			oidread(&ui->oid[i], (const unsigned char *)data);
+			oidread(&ui->oid[i], (const unsigned char *)data,
+				the_repository->hash_algo);
 			size -=3D rawsz;
 			data +=3D rawsz;
 		}
diff --git a/sequencer.c b/sequencer.c
index 30513e87bf..68d62a12ff 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3334,12 +3334,12 @@ static int rollback_is_safe(void)
 		strbuf_release(&sb);
 	}
 	else if (errno =3D=3D ENOENT)
-		oidclr(&expected_head);
+		oidclr(&expected_head, the_repository->hash_algo);
 	else
 		die_errno(_("could not read '%s'"), git_path_abort_safety_file());
=20
 	if (repo_get_oid(the_repository, "HEAD", &actual_head))
-		oidclr(&actual_head);
+		oidclr(&actual_head, the_repository->hash_algo);
=20
 	return oideq(&actual_head, &expected_head);
 }
diff --git a/split-index.c b/split-index.c
index 8c38687c04..058a8f448e 100644
--- a/split-index.c
+++ b/split-index.c
@@ -29,7 +29,7 @@ int read_link_extension(struct index_state *istate,
 	if (sz < the_hash_algo->rawsz)
 		return error("corrupt link extension (too short)");
 	si =3D init_split_index(istate);
-	oidread(&si->base_oid, data);
+	oidread(&si->base_oid, data, the_repository->hash_algo);
 	data +=3D the_hash_algo->rawsz;
 	sz -=3D the_hash_algo->rawsz;
 	if (!sz)
diff --git a/submodule-config.c b/submodule-config.c
index ec45ea67b9..ad43a282da 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -682,7 +682,7 @@ static int gitmodule_oid_from_commit(const struct objec=
t_id *treeish_name,
 	int ret =3D 0;
=20
 	if (is_null_oid(treeish_name)) {
-		oidclr(gitmodules_oid);
+		oidclr(gitmodules_oid, the_repository->hash_algo);
 		return 1;
 	}
=20
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-con=
fig.c
index 9df2f03ac8..4b809d9dca 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -44,7 +44,7 @@ int cmd__submodule_config(int argc, const char **argv)
 		path_or_name =3D arg[1];
=20
 		if (commit[0] =3D=3D '\0')
-			oidclr(&commit_oid);
+			oidclr(&commit_oid, the_repository->hash_algo);
 		else if (repo_get_oid(the_repository, commit, &commit_oid) < 0)
 			die_usage(argc, argv, "Commit not found.");
=20
diff --git a/tree-walk.c b/tree-walk.c
index 6565d9ad99..535a3a2539 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -38,8 +38,8 @@ static int decode_tree_entry(struct tree_desc *desc, cons=
t char *buf, unsigned l
 	desc->entry.path =3D path;
 	desc->entry.mode =3D (desc->flags & TREE_DESC_RAW_MODES) ? mode : canon_m=
ode(mode);
 	desc->entry.pathlen =3D len - 1;
-	oidread_algop(&desc->entry.oid, (const unsigned char *)path + len,
-		      desc->algo);
+	oidread(&desc->entry.oid, (const unsigned char *)path + len,
+		desc->algo);
=20
 	return 0;
 }
--=20
2.45.2.457.g8d94cfb545.dirty


--gt2sbAU77m3sa4Nd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjg8ACgkQVbJhu7ck
PpRJLA//Sjs7tYtINDUnVWazAUI0f3xXaU0MZM+dkgRNiQI9yGaoL347V97Jl0Uh
YwzPm9CVCvWwrwJLu0p3gSgUiYvILRKcgpWBkEEPNXCzeo6cyYlgJqetNQBbhpqW
Fy/ZZWSKClTjASMerRUaH0gFavcNSl+1vg3cdr5s9ujuwYKkgpheMJBfrqZozi8x
/Myzu6VOayAyP3LKsdv7te1etyFEI02WqbjGHOvJHdNfOMkZ0KR8tA3SGpQiX8Oh
pzfjl7xfZnVCpHIxiHxogpQZ3gpNHG30e4JR3efZTEWZhkn0dUj/i7OUTlF+eq+p
9vi3cUz9HMmAJO05sIh2M+sg4ih1ZIjr24tC4Wc7bHJ/5J2QZf8m9WNeYh8Vadl0
iRaYke9cYUsO42wv7OBEvWn9wUsHhKKqINR9g+aAEqS6Mnfqs4R5OjhUzcUKPY0W
+9xbLoHOQ1cU06nqx2iyKgXQfw3Aj0RwGzqrXtD0faZ/aAz+QFs/P84bM9iy+wiP
xmb2bbiwlG13pVJFPRsKDCJ5c4/m+BmRrgMjUJetxa0U1ckDyjwXjOh0EUaskOrF
o069QWZ3vwot+ptE0SIIvsOZCSe0oi8lCerdK3f6oZNYSF9PD09uUbyRYl6smf1t
ZB3/HuoHXqTjM390Lk4WQFWLEzSVlnec3fZ/l2n5aDvMzWqyXwI=
=1sE6
-----END PGP SIGNATURE-----

--gt2sbAU77m3sa4Nd--
