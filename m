Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9B4224EA
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933930; cv=none; b=t5GizyrhGm/dm0OGWaoVWINOpfPfynYSoBz/AdNMg5MJE89kJ4Ugpg1PtNxYuGI6G0iIr3+5vVxERS4dfwXqwX8Q8c/N1FntbpFJxPHlkJDC9OLBkxzQpCcVagDtG7RSc8Jdtpbl3082z3QsFofNwbkjOp3c53aT6qyhPqkn6OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933930; c=relaxed/simple;
	bh=v7TyzD+cC6z4P993xZgNx5dVRQ7iqtkPEFB4wP6FE1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giyY0lsIdItGjVN6cYkBTaZoeKDGaSqWrwp8Uk8SIbBBBRTnqhvDe9z2QdAdGWvgzea21RwtRYylOs+5HeX8/k/x6SfoDiYr/2ZjufE5c7tuZOOWi4slqPaHq6Irrl8UU6qX5TbCAtH9ZsHk8EwrhPVTRsqAgyrf5oYEhsBZoRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VeFZB87Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PQDk0fz8; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VeFZB87Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PQDk0fz8"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 3996C1C000BD;
	Fri, 17 May 2024 04:18:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 17 May 2024 04:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933927; x=1716020327; bh=hPdlKqhlJi
	EU/6hG+PgkICY95T4pKZJYzrhmctHRoo8=; b=VeFZB87YvvqduaHCsnth1VE9C9
	rMm7FMgB6/cT+vdFMMZx+8/Yn46w2ffyYpr+xJgdtsuL3M/fL5DliIo2Got10qid
	CE2R5tW77Sjc5prMo7xF6tyH49at2l9LTr0H8BxO/gLVoZz4YeXNiAoCmjB81jBL
	IRGQk/r2rtst/d50plZP2acioUGDuSTdWFQMvK4F7U4Eb/7g38QSsDDsmSSGVQ98
	wyMnxtYLPHef3sETpBt1R9kUufzK0HeWnbxf5fbWZrAS7huqh8wuU23mECCsmKnc
	aH8OW7nTQPcz/ZIM1auSbyEcl0gGdC0ak2uQOIJHM/QMMUWr/CIbeGc2DBUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933927; x=1716020327; bh=hPdlKqhlJiEU/6hG+PgkICY95T4p
	KZJYzrhmctHRoo8=; b=PQDk0fz8pCEM0EuNAeSivkK7uAg5r0/T7zNotfQd+8ux
	XtF3QWF11v6K9FAZWycq9/gta0PK4bKSBG21jhy8xLVnLyyWdNHsd8ReifGTR94h
	mTawFwcDmx0tIgC6JAfbsoPSH9Skpk2+sRUoy0P4kRpgFTbFSebnj+KNTw0V7CGY
	0qs/QwPfBGwGt2rdjNz86wdcxbxR8KDnVYdizGT+YlAC4Wo81GyoiLYTb/PiXb+K
	JnerOx4/SB8UPtTw399unbHeFOqNDaqQnIBTtrJpXA9Cd84EVYtZj/opIhnOnHGw
	4FzjYAF4u4ezdtz2P8ja9da8omrRDPVm4CPPm84n1Q==
X-ME-Sender: <xms:5xJHZsTy6bGi6tBo36XtzRWM8Q6IeIci-QlgFEyGZqN8p-mTRvywmQ>
    <xme:5xJHZpyRXv1CBnECBk_M7pcrKR0Gl8EV81qE8KLRz5GsCEyBsGWgtgfu4fp2B8NXE
    GOnvx8LmYiRB8fQMQ>
X-ME-Received: <xmr:5xJHZp1_RlMck7Azj4qXx03W86QBenyLksKXtxwWt2d9h7NhsvDS6anmFdY1-UCJnCTAnYyRsEYNFmL-5U16N3F_m-SA2hB5WWrZkGYlCKYP7l_7yA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:5xJHZgDQSttYLPrpeLSpZv6ZxEtCYq256_Sxzvp9YClqyu-Z_hFiMQ>
    <xmx:5xJHZlhU_pEZ7PBuOUqK93gknph4p3yHUejAh6YH8FVBm2KJT-aKJQ>
    <xmx:5xJHZsqVFzt134ewmTNeHvlrrVewtb90yJa_ih1ehU0_I2oGrd4q_w>
    <xmx:5xJHZojUcw42IVlqWDgwLacV8-pvNSDnlc-dX9LHDMK2ZoiX7fvwPg>
    <xmx:5xJHZqsq7UVHd3sUAzOR1AwiAsPuA0R2SinqcOlBAeeGpVLkY98V48H3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:18:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b9db5046 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:18:19 +0000 (UTC)
Date: Fri, 17 May 2024 10:18:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/16] refs: retrieve worktree ref stores via associated
 repository
Message-ID: <977f3a8510c96b8f278852ef240e19c759a53d2c.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="08WNyKAgoPsAJm2j"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--08WNyKAgoPsAJm2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Similar as with the preceding commit, the worktree ref stores are always
looked up via `the_repository`. Also, again, those ref stores are stored
in a global map.

Refactor the code so that worktrees have a pointer to their repository.
Like this, we can move the global map into `struct repository` and stop
using `the_repository`. With this change, we can now in theory look up
worktree ref stores for repositories other than `the_repository`. In
practice, the worktree code will need further changes to look up
arbitrary worktrees.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c       | 27 ++++++++++++++-------------
 repository.c |  4 ++++
 repository.h |  6 ++++++
 worktree.c   |  2 ++
 worktree.h   |  2 ++
 5 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 7703b7781c..70e712fcef 100644
--- a/refs.c
+++ b/refs.c
@@ -1960,9 +1960,6 @@ int repo_resolve_gitlink_ref(struct repository *r,
 	return 0;
 }
=20
-/* A strmap of ref_stores, stored by worktree id: */
-static struct strmap worktree_ref_stores;
-
 /*
  * Look up a ref store by name. If that ref_store hasn't been
  * registered yet, return NULL.
@@ -2091,25 +2088,29 @@ struct ref_store *get_worktree_ref_store(const stru=
ct worktree *wt)
 	const char *id;
=20
 	if (wt->is_current)
-		return get_main_ref_store(the_repository);
+		return get_main_ref_store(wt->repo);
=20
 	id =3D wt->id ? wt->id : "/";
-	refs =3D lookup_ref_store_map(&worktree_ref_stores, id);
+	refs =3D lookup_ref_store_map(&wt->repo->worktree_ref_stores, id);
 	if (refs)
 		return refs;
=20
-	if (wt->id)
-		refs =3D ref_store_init(the_repository,
-				      git_common_path("worktrees/%s", wt->id),
+	if (wt->id) {
+		struct strbuf common_path =3D STRBUF_INIT;
+		strbuf_git_common_path(&common_path, wt->repo,
+				      "worktrees/%s", wt->id);
+		refs =3D ref_store_init(wt->repo, common_path.buf,
 				      REF_STORE_ALL_CAPS);
-	else
-		refs =3D ref_store_init(the_repository,
-				      get_git_common_dir(),
+		strbuf_release(&common_path);
+	} else {
+		refs =3D ref_store_init(wt->repo, wt->repo->commondir,
 				      REF_STORE_ALL_CAPS);
+	}
=20
 	if (refs)
-		register_ref_store_map(&worktree_ref_stores, "worktree",
-				       refs, id);
+		register_ref_store_map(&wt->repo->worktree_ref_stores,
+				       "worktree", refs, id);
+
 	return refs;
 }
=20
diff --git a/repository.c b/repository.c
index bb9b9e2b52..d29b0304fb 100644
--- a/repository.c
+++ b/repository.c
@@ -337,6 +337,10 @@ void repo_clear(struct repository *repo)
 		ref_store_release(e->value);
 	strmap_clear(&repo->submodule_ref_stores, 1);
=20
+	strmap_for_each_entry(&repo->worktree_ref_stores, &iter, e)
+		ref_store_release(e->value);
+	strmap_clear(&repo->worktree_ref_stores, 1);
+
 	repo_clear_path_cache(&repo->cached_paths);
 }
=20
diff --git a/repository.h b/repository.h
index 0389df0461..4bd8969005 100644
--- a/repository.h
+++ b/repository.h
@@ -116,6 +116,12 @@ struct repository {
 	 */
 	struct strmap submodule_ref_stores;
=20
+	/*
+	 * A strmap of ref_stores, stored by worktree id, accessible via
+	 * `get_worktree_ref_store()`.
+	 */
+	struct strmap worktree_ref_stores;
+
 	/*
 	 * Contains path to often used file names.
 	 */
diff --git a/worktree.c b/worktree.c
index cf5eea8c93..12eadacc61 100644
--- a/worktree.c
+++ b/worktree.c
@@ -65,6 +65,7 @@ static struct worktree *get_main_worktree(int skip_readin=
g_head)
 	strbuf_strip_suffix(&worktree_path, "/.git");
=20
 	CALLOC_ARRAY(worktree, 1);
+	worktree->repo =3D the_repository;
 	worktree->path =3D strbuf_detach(&worktree_path, NULL);
 	/*
 	 * NEEDSWORK: If this function is called from a secondary worktree and
@@ -98,6 +99,7 @@ struct worktree *get_linked_worktree(const char *id,
 	strbuf_strip_suffix(&worktree_path, "/.git");
=20
 	CALLOC_ARRAY(worktree, 1);
+	worktree->repo =3D the_repository;
 	worktree->path =3D strbuf_detach(&worktree_path, NULL);
 	worktree->id =3D xstrdup(id);
 	if (!skip_reading_head)
diff --git a/worktree.h b/worktree.h
index f14784a2ff..7cc6d90e66 100644
--- a/worktree.h
+++ b/worktree.h
@@ -6,6 +6,8 @@
 struct strbuf;
=20
 struct worktree {
+	/* The repository this worktree belongs to. */
+	struct repository *repo;
 	char *path;
 	char *id;
 	char *head_ref;		/* NULL if HEAD is broken or detached */
--=20
2.45.1.190.g19fe900cfc.dirty


--08WNyKAgoPsAJm2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEuMACgkQVbJhu7ck
PpRhGg//WOVECc1ZY+j3I+ScqgPWUH20evWDVjPR8u3kxbdJuZoYI0+rm5UMl6s9
iZ19WKvTI4rUrmwW6quNsHfmlxhm1B+flbzC4Tgq+h4gKIWHPgJ1b4FH+BnlmmaB
OiSrzTnf8Xq6eD67EkalXsw1zRp2fSGbv9FxFAJy+pFixzMfX+IjfNxU553PMjOR
TXW/DNTiKzScRHC57KGyHZ3jkjLyxPfnBarMEV+tJX2mXT3dSV7cmNKKIP4aU8m0
BJox4n5e8xl+5ggMFyRiaw1aYok2mXXzVZeoBP/imRzYq1O6040BuTDnichSNilT
1c8WrHNbBP++Z4KBo5y0ft14Y1UBg1l5ZqkOkcUQPL8cEGNJDPINUSNdXaxTsn7e
PrMLuoCepw5b+TukGwtr6uOz9Z5nctNhtSp2RJjOk6mYBHugzUrpePL63vg37ABx
ZKv0IR8sDrg4TzMKmygS8buzBBkKiP5HavMwtJUdG0oTHs7OI+un471wKF3HZZef
LI8rs16mAQWfZndpMiyjAI60lLrCORSNjR3PsbvuRuTeGrXsXy+U4JQvmz3bB3Zj
KYJKPBMYnnaJ+MRTKb66cTk3NK2VARHeaVVLWXyCO3jLT/OA+mfAb1EgtB9mdVIh
mFUn/wjhZd3XM74pyc+b9o46V7qNnDHsmlm+UwQWMIsfmazzYuA=
=E/O1
-----END PGP SIGNATURE-----

--08WNyKAgoPsAJm2j--
