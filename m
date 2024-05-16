Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB04120A
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846688; cv=none; b=Xn5yN+RM0Ev5LMgqirqYjTtaegGP3A8Y+sNc/RTbNDmg6Rh2sFCiYPXxoermiUPXlo4LOOUjhbyXl582OXQUscPb0kVhaQjJ3lm9dLPCgXfVAvMV1tVndV++F0594ZEYoEVGwE4FdNhoSEmNO22i3Xq87NBEGE/+XZaWs6yvl/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846688; c=relaxed/simple;
	bh=epyjz92EAI/ahcGjHrQ84R0qQia5zZQ2G9z4iXLLsyM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUWKT7ec9RoTqy3hmz+F4TIIf61fO8eozTtDtrFzCLf4zl+rOWOkHbM75NQjAcD+3orfX3L1NJumff6twIRK4hNdpWkRX3oJkHPHCRrRZrx/erhS3eQwIfQEv2wmdm2gO9q1/kmSMSEBEai+2U2OtdtuBVicCOtxoOwLMVN1BeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P6R3U65j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPPmTR4s; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P6R3U65j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPPmTR4s"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1F2BF1380282
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:04:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 16 May 2024 04:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846686; x=1715933086; bh=NLAe59edwt
	AOnW2lmFNFEWPU3g+vYB+mgdu3sG0MIyI=; b=P6R3U65jGWyWkbh5JvwP+T1b65
	fKbzzDF9JZDfBOy8trJgXeld/jIy9lIPURw9WKjvuwuoaCgKnaopg+ryGM/l39sZ
	7Ksl3upcv9/5BKrW+6+bM0ejS1TCV6gEcHqFXpMIdJoqYsUDTC1QD2j5yUlD76er
	UuFZP2Izol6iidQzxeE2tbDdZOVII74fnOXHSy1M0k+J7EyzgbZB0hbysdFtYPIw
	mXBZQQWeMQ19buBIKS5wnKXrDv5NcaZlEClbvQe2bhSTGo49qIwt27ROoIoNKQRW
	rGr7sKQh6dj6lvfHEd4Hf/+yRpSl8dPaQmLt3oKc/M7iZ63+fjHL6dgJjYEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846686; x=1715933086; bh=NLAe59edwtAOnW2lmFNFEWPU3g+v
	YB+mgdu3sG0MIyI=; b=XPPmTR4stgXBt2kqF6om76bms4HvdRegq0mNnl3DKoZM
	IR0C1//4b/aUQuWBKICF8eMsFH3VO/IDU7mjJGengBSxWrNFdzS+rKDUdm8W0BhE
	hbuquyBkUXQyhKeOrY5OgPKPaSp7qnFuiNHB9BQwZ80BnuEabuqYcCQXGwcQ/M4Q
	iu4bjiSL0b3ZPoMgXh9qSav58+B6lhNcflLAN59Q1569D4MxzpisATEjLllf4Pjl
	ge8124lUVUiKYIsFlZOrHpTKwQTy+KDTvBWK9WG7Ga9kt7Sz/P/IZJQW+wf/Hh6m
	tVascJ9GA1BI7/I+vejIousGoUNbUrS8OLTlE7SjOA==
X-ME-Sender: <xms:Hb5FZuQfMIzUcHfLdV197OxCa6wEqSttiRxWdH6scA7OKwh8akQYEA>
    <xme:Hb5FZjyISlPEFxD2kysJXD_aXfjQXu2JRCu607qr_sVr5PjTFwUGcXCulhGoCE7BX
    XwhTHCburXGw5jaNA>
X-ME-Received: <xmr:Hb5FZr1B0gNOqpxwDk8CadfBy_pXPu18J4xp8brCE74pFPolv1qKxfC-DR3qzjEnXuusetfW8OFECBMCm-SlWV03B4zXd1PQbhNAXa6eHLOX37Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Hb5FZqA3tUyx9t0_XdJJfm3piYv8frgEWKO4f6hA4h_9uShA8nHKHw>
    <xmx:Hb5FZngz5rxUHYU63GTERc8qkcYXCDe8T2Iq9Gp6PM84ko_dojYupA>
    <xmx:Hb5FZmpWyEOyXS8XauaXxYl7TO00PVPQDsvm1rm0FJCiqJdBjKEdHw>
    <xmx:Hb5FZqiYReLaJQtVgGunDt3EYNwR2N9Bmf6AKKosxQXpDf1vdwJ8_A>
    <xmx:Hr5FZvaWX_ZeLWZ-JSFRe8vMi6_2j7N0MKxXr7R56X7BFHgOw1tE9em_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:04:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id dd335ec2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:04:20 +0000 (UTC)
Date: Thu, 16 May 2024 10:04:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/16] refs: retrieve worktree ref stores via associated
 repository
Message-ID: <4d55dbbceb2162aab1ee83f5efe752f6a721bc8f.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tzgTf8yUjWl9m5Xh"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--tzgTf8yUjWl9m5Xh
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
index 40e241216e..03bf5d0e69 100644
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


--tzgTf8yUjWl9m5Xh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvhoACgkQVbJhu7ck
PpTxpBAAmzuGEaitOtIOgUHeM0VpO2ki4zYyQZQi3Zds2XG9GpJGmYL01SFpG3cm
zJC9/vfH/806kZB+yeOwJS+BWlDk6wRiOrOg0wDZ7JTvwC4OzpudeOBdC7RWVKEU
cJtjdyg+DRbwsPlNPCeYGg8IBc1IIWlP9OxVxgULdQo/NG6xURAgUFWR3DTx9HfZ
qILO11nOEVCAL7Y/Dtynl7oqyr551OzXkVpIjnlu2e14AlrAYURNGEK/a4jw+cbk
yPXXspF99b6vbKVZ+ANquIsFZV0aL88NeVWUoc8ZnpzEEqaINJYwB51WqAZyIhfv
JVZuOFJRqI5VQemK+HgfOkwebvHzMXuNnQ6oOXVgOEyHvXFzwLvfFJR1hBNysn7+
70+t7sli8vk4PHC14FXK/1lhn6juS5FfByVGGSMuCRAjF4Zbqu7tFAc8jaZRjN4K
+CJECUD4ei8zNpPXzJa307fP4aspGjxJFuwb4wgApA/vjRpxOT2S4V2RpKUWyqyP
5E3Ck0H1hO2iLXqPsOju23C2LDxjUG0fPCQxaZM8+jBu+wMyn2mk+yvzFJAPmzG6
ec/lnLyd0s552WRVNwZBWMYOB4CVzSoq+nu/t7UJvd4hvcqK53hy4KffKy8s5BR0
Ag6VNngGru4NmhTEh/FuhRSjyncAwd6c8RVVwc2IaDp9sZXB60A=
=mU+R
-----END PGP SIGNATURE-----

--tzgTf8yUjWl9m5Xh--
