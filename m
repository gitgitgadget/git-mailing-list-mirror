Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3282E652
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933920; cv=none; b=kaAOaMqi5479jJfDSchFOB/tfcGYGlMVaNbmFTX+NaRh6K5iAPyROFxPvq3XfrOZuwEmqGycQrrXAxI/00wGeTTtdEVdsDWhRljooquRxw+JG/g0FrP8KyYvUxGy1gDKAhtepbnL/qdj5t7EiYj+GMZvt5u1i0Ruav81JU9Crvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933920; c=relaxed/simple;
	bh=yBl6rn+8NhXBo+p5CbvJixqs7wpevVq0lVTnqojL6L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmuIuRI+lK2rvV69nbwPBeHiuTRiXhRkXojJpO4E0Xxbwpb5RATDEr/mt8dFSc0iFRcJZJaCRN9m8LSsfpsnXwBJ+jfB4igeBleZMjnejsjuFZqX2QI88gk0voo4n6MjP/qpeDBDvjln11G8T4FXcTC51sc3/vVBcPcmrFPAmBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XvItfleZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rh/I4GXr; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XvItfleZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rh/I4GXr"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4CF451800173;
	Fri, 17 May 2024 04:18:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 17 May 2024 04:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933917; x=1716020317; bh=BbWc4aFKKU
	mq0OvDhfwO6wG9ew20J1qpN6FkkIBlTf8=; b=XvItfleZfv+SPY3BqQL00q/MRb
	QbNh8Sq6dl/9F7DpE1F/dblEGkRwycvX8SLoW/zejkOhrgIvsUc350COaBS8Wcsx
	vcUtGVcgTyHFRrGQR5Ha2g/louQgrr7JZc6Eu5S5ozMvZbyqYfwC3IXouiOqj7r+
	Nnj2p2L9donQ9c40Cfr3ZCrqpBH3gLzLgw66Z08GOBWdexv+WaWirJH/gDqhwrK0
	rwOKPJG3POmtNc8/8fTHFojOSw4/VHJkDO+hwrCn3zHk1Ji+HTuAEc8YKvLECbHE
	iu/ueULPMm+Q1RNSTov5ySsOinT1A2tBqYb9iKm/brBdGp214ZT3sm/TYt6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933917; x=1716020317; bh=BbWc4aFKKUmq0OvDhfwO6wG9ew20
	J1qpN6FkkIBlTf8=; b=Rh/I4GXrafI+ygZPJAlcjO8TLaKwQcCYWQbvmCw5VujG
	jFPKY0pkuJ5DP3LAN38i5ygvVg80xn0MVJPFhc4DFyIZpxBhN3o3gE0PPvI7e0Ll
	uH+29LHWU1G/B2GK/8dAuhhMCGIUbakyo5SwzRfRQpkLfc4uqagzZWDfSkujZeP1
	Fg+nQC3mdib2sL0FqCQpTAl1TDlVFoMvBzmQCOA8ycnBi7OGcjie+IysIY4MV9ND
	DIXn2byl4+CbLbOOAT4x+iiGD/wtrqODHy6TUvT7lIxfBKubAM3LC0EJ7uT87Lil
	Fnyp9qirIc4PNmzAi1/l3Ph9vtJ6BEA58A8T+KmUbQ==
X-ME-Sender: <xms:3RJHZkwv1-5b2tD2eKtaTZiTsKqqKlXkuK0tvwESoG2xN4n78e0s0Q>
    <xme:3RJHZoSHI9A_32tj4BzIAymUayEFDumRLeq0GIgw3U6H-BZ-62NV90PRe78LO7Kzi
    dH66MbPwdOq_B8TdQ>
X-ME-Received: <xmr:3RJHZmWj8ef7bHQ0SgeU0IrMwOLyUArhRkIyWzcJ5TWvd65z8ww6PbXHUaF8MdW2zRQzsCh4qgX_fs3aKNSa69fleknNmZrMHO3mAfyIus1IiAYRrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:3RJHZii8rlYw_uJAaO3cAS6X4UvoZmUTEjy8T3DGNXvlAC2o1VUu8w>
    <xmx:3RJHZmDRlUYQzRlXJMvsqNsVgSQA-v7MnBOvUSOejbN61zxDGCnpfw>
    <xmx:3RJHZjICTW2cqx7GEkdnaJTPS8ok9tGhm9vCQaO45VSxQSzarJVxmg>
    <xmx:3RJHZtBseI5PkEjSVhJW8s2Typ8YxJU715lGG0l7BfohDZHI1UOGIQ>
    <xmx:3RJHZhO8LDDVw8vD3e0Cvoq50y7NztQNOe1-_SERKhyz7LkHVV6nBcEo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:18:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0fcb5c59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:18:09 +0000 (UTC)
Date: Fri, 17 May 2024 10:18:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/16] refs: pass repo when retrieving submodule ref store
Message-ID: <d7f8b2f40db4cf586aa5a2bdd038284ae6d1c9d8.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z7mpwzzmRPvC1d87"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--Z7mpwzzmRPvC1d87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Looking up submodule ref stores has two deficiencies:

  - The initialized subrepo will be attributed to `the_repository`.

  - The submodule ref store will be tracked in a global map.

This makes it impossible to have submodule ref stores for a repository
other than `the_repository`.

Modify the function to accept the parent repository as parameter and
move the global map into `struct repository`. Like this it becomes
possible to look up submodule ref stores for arbitrary repositories.

Note that this also adds a new reference to `the_repository` in
`resolve_gitlink_ref()`, which is part of the refs interfaces. This will
get adjusted in the next patch.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c |  6 ++++--
 refs.c                      | 22 +++++++---------------
 refs.h                      |  3 ++-
 refs/refs-internal.h        |  2 +-
 repository.c                |  8 ++++++++
 repository.h                |  8 ++++++++
 submodule.c                 |  3 ++-
 t/helper/test-ref-store.c   |  2 +-
 8 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e604cb5ddb..5076a33500 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -679,7 +679,8 @@ static void status_submodule(const char *path, const st=
ruct object_id *ce_oid,
 			     displaypath);
 	} else if (!(flags & OPT_CACHED)) {
 		struct object_id oid;
-		struct ref_store *refs =3D get_submodule_ref_store(path);
+		struct ref_store *refs =3D repo_get_submodule_ref_store(the_repository,
+								      path);
=20
 		if (!refs) {
 			print_status(flags, '-', path, ce_oid, displaypath);
@@ -903,7 +904,8 @@ static void generate_submodule_summary(struct summary_c=
b *info,
=20
 	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
 		if (S_ISGITLINK(p->mod_dst)) {
-			struct ref_store *refs =3D get_submodule_ref_store(p->sm_path);
+			struct ref_store *refs =3D repo_get_submodule_ref_store(the_repository,
+									      p->sm_path);
=20
 			if (refs)
 				refs_head_ref(refs, handle_submodule_head_ref, &p->oid_dst);
diff --git a/refs.c b/refs.c
index 01e8453930..1d660d5ace 100644
--- a/refs.c
+++ b/refs.c
@@ -1949,8 +1949,7 @@ int resolve_gitlink_ref(const char *submodule, const =
char *refname,
 	struct ref_store *refs;
 	int flags;
=20
-	refs =3D get_submodule_ref_store(submodule);
-
+	refs =3D repo_get_submodule_ref_store(the_repository, submodule);
 	if (!refs)
 		return -1;
=20
@@ -1960,9 +1959,6 @@ int resolve_gitlink_ref(const char *submodule, const =
char *refname,
 	return 0;
 }
=20
-/* A strmap of ref_stores, stored by submodule name: */
-static struct strmap submodule_ref_stores;
-
 /* A strmap of ref_stores, stored by worktree id: */
 static struct strmap worktree_ref_stores;
=20
@@ -2036,7 +2032,8 @@ static void register_ref_store_map(struct strmap *map,
 		BUG("%s ref_store '%s' initialized twice", type, name);
 }
=20
-struct ref_store *get_submodule_ref_store(const char *submodule)
+struct ref_store *repo_get_submodule_ref_store(struct repository *repo,
+					       const char *submodule)
 {
 	struct strbuf submodule_sb =3D STRBUF_INIT;
 	struct ref_store *refs;
@@ -2057,7 +2054,7 @@ struct ref_store *get_submodule_ref_store(const char =
*submodule)
 		/* We need to strip off one or more trailing slashes */
 		submodule =3D to_free =3D xmemdupz(submodule, len);
=20
-	refs =3D lookup_ref_store_map(&submodule_ref_stores, submodule);
+	refs =3D lookup_ref_store_map(&repo->submodule_ref_stores, submodule);
 	if (refs)
 		goto done;
=20
@@ -2069,20 +2066,15 @@ struct ref_store *get_submodule_ref_store(const cha=
r *submodule)
 		goto done;
=20
 	subrepo =3D xmalloc(sizeof(*subrepo));
-	/*
-	 * NEEDSWORK: Make get_submodule_ref_store() work with arbitrary
-	 * superprojects other than the_repository. This probably should be
-	 * done by making it take a struct repository * parameter instead of a
-	 * submodule path.
-	 */
-	if (repo_submodule_init(subrepo, the_repository, submodule,
+
+	if (repo_submodule_init(subrepo, repo, submodule,
 				null_oid())) {
 		free(subrepo);
 		goto done;
 	}
 	refs =3D ref_store_init(subrepo, submodule_sb.buf,
 			      REF_STORE_READ | REF_STORE_ODB);
-	register_ref_store_map(&submodule_ref_stores, "submodule",
+	register_ref_store_map(&repo->submodule_ref_stores, "submodule",
 			       refs, submodule);
=20
 done:
diff --git a/refs.h b/refs.h
index b11c250e8a..346a81e9e3 100644
--- a/refs.h
+++ b/refs.h
@@ -954,7 +954,8 @@ struct ref_store *get_main_ref_store(struct repository =
*r);
  * For backwards compatibility, submodule=3D=3D"" is treated the same as
  * submodule=3D=3DNULL.
  */
-struct ref_store *get_submodule_ref_store(const char *submodule);
+struct ref_store *repo_get_submodule_ref_store(struct repository *repo,
+					       const char *submodule);
 struct ref_store *get_worktree_ref_store(const struct worktree *wt);
=20
 /*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 8624477e19..178a355eb0 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -705,7 +705,7 @@ extern struct ref_storage_be refs_be_packed;
 /*
  * A representation of the reference store for the main repository or
  * a submodule. The ref_store instances for submodules are kept in a
- * hash map; see get_submodule_ref_store() for more info.
+ * hash map; see repo_get_submodule_ref_store() for more info.
  */
 struct ref_store {
 	/* The backend describing this ref_store's storage scheme: */
diff --git a/repository.c b/repository.c
index c50849fd83..bb9b9e2b52 100644
--- a/repository.c
+++ b/repository.c
@@ -14,6 +14,7 @@
 #include "sparse-index.h"
 #include "trace2.h"
 #include "promisor-remote.h"
+#include "refs.h"
=20
 /* The main repository */
 static struct repository the_repo;
@@ -289,6 +290,9 @@ static void repo_clear_path_cache(struct repo_path_cach=
e *cache)
=20
 void repo_clear(struct repository *repo)
 {
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+
 	FREE_AND_NULL(repo->gitdir);
 	FREE_AND_NULL(repo->commondir);
 	FREE_AND_NULL(repo->graft_file);
@@ -329,6 +333,10 @@ void repo_clear(struct repository *repo)
 		FREE_AND_NULL(repo->remote_state);
 	}
=20
+	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
+		ref_store_release(e->value);
+	strmap_clear(&repo->submodule_ref_stores, 1);
+
 	repo_clear_path_cache(&repo->cached_paths);
 }
=20
diff --git a/repository.h b/repository.h
index 41ed22543a..0389df0461 100644
--- a/repository.h
+++ b/repository.h
@@ -1,6 +1,8 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
=20
+#include "strmap.h"
+
 struct config_set;
 struct fsmonitor_settings;
 struct git_hash_algo;
@@ -108,6 +110,12 @@ struct repository {
 	 */
 	struct ref_store *refs_private;
=20
+	/*
+	 * A strmap of ref_stores, stored by submodule name, accessible via
+	 * `repo_get_submodule_ref_store()`.
+	 */
+	struct strmap submodule_ref_stores;
+
 	/*
 	 * Contains path to often used file names.
 	 */
diff --git a/submodule.c b/submodule.c
index f6313cd99f..759cf1e1cd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -99,7 +99,8 @@ int is_staging_gitmodules_ok(struct index_state *istate)
 static int for_each_remote_ref_submodule(const char *submodule,
 					 each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_remote_ref(get_submodule_ref_store(submodule),
+	return refs_for_each_remote_ref(repo_get_submodule_ref_store(the_reposito=
ry,
+								     submodule),
 					fn, cb_data);
 }
=20
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 82bbf6e2e6..a5a7609811 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -82,7 +82,7 @@ static const char **get_store(const char **argv, struct r=
ef_store **refs)
 		add_to_alternates_memory(sb.buf);
 		strbuf_release(&sb);
=20
-		*refs =3D get_submodule_ref_store(gitdir);
+		*refs =3D repo_get_submodule_ref_store(the_repository, gitdir);
 	} else if (skip_prefix(argv[0], "worktree:", &gitdir)) {
 		struct worktree **p, **worktrees =3D get_worktrees();
=20
--=20
2.45.1.190.g19fe900cfc.dirty


--Z7mpwzzmRPvC1d87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEtkACgkQVbJhu7ck
PpQlzRAAq4MIeXnY9oSuPuGn+oilG8OrI3Zmcq0F8vxwrOebqrh3/IUBRvdg+3fh
oahQ/PkHfINwFKdRslrpYHiD3bZmVxzLaHB2XjQupd9HSC3iXwWUcZdy84pz+q0G
bTrgO/EpGgSC9PTlHtxIvPIHOJtJIn2OLM04lcGyVnsg97ubF7U0kpRf2IEQbeyg
vCCRxO/m4tWL2x42De37g77m1WCPVzW/yZBHGyEhy/JoGikeur+g3+cV7q9KkVK0
Li7G8QmS4fN28ejYeGeHD/bpRbZ8cLai7HMt0cY40OvNFQWU0BUMm6j366HimFYa
Ghl6Ol5B0pcKQV6FjAPxn16xfV81Adl1VSgnxlx1s1BYAvezC01iMy3kf8uXE+B7
MC4lZsd/SJPWbAz2p8Uf5dBZruC7benVuoP8JvipEf/X+ZDJ0fHpDNcfsYoer1Nd
TkL+xW05qnbK8pNb0J/Uqm1KHQmpbDpeHHUovXp5TL4h0FrIbUB++PnK5+I0/2yJ
CZ9DXZ/CuWRstI6De30tF6pVRsGd4h48qI2ISiDAYpd7t0OdOdoOcbwJxtlKv2Mm
pMyLZ9J+tycUGvERa69Qp/cfVMaPZCHoP0No2Qof0wRpB4AYqmd96Yc4E6eexzxW
a4BrP6fC3LHCLpxn3YoPYqFaCn0jFfnd3U/XXU8l3qSAY60BZR0=
=hioK
-----END PGP SIGNATURE-----

--Z7mpwzzmRPvC1d87--
