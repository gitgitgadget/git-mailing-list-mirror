Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC012E1C0
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846678; cv=none; b=FhlLObdmIn9wAFmeqr5euzMkTTvotiw9G7N4DvwGz5PONQ288SPy4XRDye31qvAuNk7s1LAuYPCqggXcwbhABnWxggOdd53P2JsIJugn+GcIRD+Rl8zA8Raaq9rKeeUyPVQsG5WD6WhKowYyiLY1xxbG768GB0zPp4Is2tCMDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846678; c=relaxed/simple;
	bh=DmKzALg+xAvZPK6Jlu02OUQsqfCa9FW8dDp0qQTRRQg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P87b4G/p6tacZcwHlAsdjmvn/u2jOTyhik1uKQOzag1RP1HXmFgwzmELc5pudah5WHBLUO6D/bg9KowH9xWBSetJizw4+qx5lkOAh0XOEseF8PlAb3U+NOmEsZ+w3Yyc3Ryiyuecy9qiaPCLSSAOctjxont1yoaKtHoZweZwi8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F+99qccj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QNR+J4iS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F+99qccj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QNR+J4iS"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2E6391380E32
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:04:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 16 May 2024 04:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846676; x=1715933076; bh=QCipGYi0nV
	ixXlMW9UEz6Rbo3Slnuhx6CiMW1POtWZo=; b=F+99qccjp6pwUzyQ2sUZXqMsg8
	vSCaO8TxTqjAXGoDmjBIMu4t3aMGQbTAnp9Vydcy2U7HfbWaShzY4qkKzHCJ75Rs
	mqIGMBFjAnqw8MU+adqOlSr16VwPc3U0GlIk5ZYYr7EBqx7FzO0cmZlCd58BAXVV
	2iIBrUqhsaVRen4Nea/TQwIyaq7uWxC442sn08k/BeAvZwekSXOnjdxfgu7bt7Ts
	Fm2Taoia/Wvxen83BjDoR0+jAac+QVN2bi5GWwTZ5kL6gI4/OeJycIhBkvEe8rL4
	g2tawmuAHG2xsSISStkl33mw7LJKfzTIjguHubW6lt/zxDOu3ThyLU0icf1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846676; x=1715933076; bh=QCipGYi0nVixXlMW9UEz6Rbo3Sln
	uhx6CiMW1POtWZo=; b=QNR+J4iSdvoR1qBTjUwFRwOdEXgp/HAwRdKBwbJtXsoF
	xYHNGxNygi16brLDVj7ASQDEvAFThKjkTeMNsWRGBhWm0+GC+weBDWD/dYpv1PHA
	ftMVQ6FAHQEyPNht66kLEJPFbEVlrN36u6cibnAH00piUUQh8MT5TyxejQHZ1mI+
	HUD5ffPSb5cMFAleV73GjukasR9b5sXkIxYtV+RJBqjMsDCGqhM53WcuAPo0rX9e
	eJ72T8XI/6ybAMyvl94x4YibQwemQ4LyPKZe36+tx7hUrykB6mapyWjN/sDcwK5U
	mLbT2Jo7enghv4rZqyYjAeiDgi9qOEtG8MQgjymuWg==
X-ME-Sender: <xms:E75FZvs_HJqunVISkRiOoZFMb1fFJnrX-Ld4TQinanUaNUMIegE6Rw>
    <xme:E75FZgfc3OzeomBuL9q1BcnwHkPsjOrcKoIjKX2xpRiJoE8D5tEIW_UwcwPolCJQ7
    i0_dd2hTDdDcV3jQQ>
X-ME-Received: <xmr:E75FZixRjCd3k6jIA1CwOUziNgSGkWVWQYVlx3QCkydecu-i22qS9VGIq9L7bNmVdijE-fO8ZtFUhO24Nns67ZHlHqlkUQg-Fses_B9rrICvXCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:E75FZuODHynR6yDIOqG0Ynz9eWKGPmCrnLws-T-W08OKRH2zsOSfdw>
    <xmx:FL5FZv_dcH7vjWJJhj11kKuAo0tz8y9p845fGsBEQb4WFE0bQcx47A>
    <xmx:FL5FZuU7fIe7z6YZ7E3e47ZgXkjnfscbKwxZnqH-MQTlQJIcgslLzw>
    <xmx:FL5FZgfQbo2hh4b9-VIv8_yDQ1RbWUrbiP08ouU6SQODg0ZzMQAITA>
    <xmx:FL5FZpkIIAi0gmKyMjHuXC1sp9O7OnS2xVO1c-aJGtX4xguIba5GEqgi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:04:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 00ae21b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:04:10 +0000 (UTC)
Date: Thu, 16 May 2024 10:04:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/16] refs: pass repo when retrieving submodule ref store
Message-ID: <1d48289809d5bff3d168b42b2b7f150e3ee953e2.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PzrmJmvcWMNYi8I+"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--PzrmJmvcWMNYi8I+
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
index 542acb25ff..86008ce7b4 100644
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
index 5ecdfb16dc..fc1a873e8a 100644
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
index cc1fe6e633..3c3f9a3555 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -706,7 +706,7 @@ extern struct ref_storage_be refs_be_packed;
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


--PzrmJmvcWMNYi8I+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvhAACgkQVbJhu7ck
PpQmIg/9EkbbLvi61QC1ruDacPRcCm1GwVHvE3S/9tdvgpI+lyAVKdHWD6oywWbI
RUv3FXczGWh0ihTOlSI35tHwF0OKlNVyRpfmNPKoGd8CVuaGKJljDsMjaHIfpuxS
//PQkz2CdWIEXhx1AsLFe61EmODJLnR0NpGUeDyZmgABMj4wo1SYpGm/D2ekzTgS
SoFBRyOz8XWr03v2IPd95zcOaeXce3TBX+1lEIXWqcnbE9fzlfM3a2Nq7yxU/cXI
JOMQNcld+Ez/04twIDu4kLpCSR2nRXid9ME5wPdqaUEZnu2WObyObUlSh37yBDJe
bl+pfwGA4ExV0faGUykJFrOyIJQNLeOEduwrsVuA+4HI7aS7pGvDcrw+tfMJVgYK
UJ4kS3K3QFpVNlc2g/8HAteR2fMQf1trekKABOVH1URSBbS40nejE17BQDUu/qiZ
OmCpNPu3WGvvG25q05KIcgC/wRIacJqx8YJ86/ctXW/ejNRiTZRYQd/7EkmtvaQa
djlCVdPiY2y6XYaUqIWnqE15mXdSpIxF4237dufUWqCQYs5nJ530G5vWp6inXosx
ThvpO8POPIGtwZ9ydrwXRVg6Kp2I5J2VziHmrvXIma7hXdp7IIZuM+oneXfT7TGe
x8kptroE817Uu55HAn39MuQ7TbC3sx+cNgWo++LgrPr7ube9t+g=
=Wq0t
-----END PGP SIGNATURE-----

--PzrmJmvcWMNYi8I+--
