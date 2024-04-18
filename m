Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85CB15F407
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442480; cv=none; b=BOerh/FpWq4hmtP3vd5IEGZ8INrDmjElB/9gLcwn+RxfmBDL0YbesEQGNIdho7P9Nl62VMFQ7Lmg+4lLTnA7N6S58/WCisZctFsnTTt4CeDvu3hCgKmgGYqY6MlE+CtdQEsjOvBAN7cJAFAPtyKu7LEr837ykPD/tRBlKIxxPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442480; c=relaxed/simple;
	bh=K4RGzecjXDJDpUDoxHbkG2A1Y1Il3mO2CcWX4jEh46U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0MoUqD02Dy1bfz7wAuDr6ICVWuy62SuXFmYAHNqIl/N0J+LvqbqTdzfyOSdwjXQAsblBga5mNBTYLiHvK+VSA6mOriFLtYSXAmr+A5WYqfjQaUm1jBDtOrHQBRSupnJNu/tFcpqGdS5CV1oo5VbaaGGngAUFQ76gc8N3cfcu9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lpbTyI6z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTx7Z4qP; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lpbTyI6z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTx7Z4qP"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id D9B87138023F;
	Thu, 18 Apr 2024 08:14:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 18 Apr 2024 08:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713442477; x=1713528877; bh=PorwP+WNqP
	ccDtxN72Wzj69yLMQ8Q/cs5BvwLPJzZ1M=; b=lpbTyI6zvDsSQPOOwJRqM5uv48
	aCtBPyzbKZNngc3y5aJ6JF9uniWhBPWDkfrftud71yNiSq9R/YSr/Hh40Jng+ml5
	3v3yyXsmbO9sudEWnMl9AKvEG8m518tVc26AT96O6clDvOm4hM0cH8SHbFz+LSG3
	O4ZW2l5qinXlhu+pzqC1/BPZa0nrKyqfeAx+RMQNWtDjTyry2B2rnKd5gLAbI6kL
	Fcy55W424c8nz5SYWowtMdnwigXCDYWeu3tUUE11RvF3ASIsVsUklhns+imsSTmY
	fEvcDRLFAQ3rPCvFTOcXsOpRiED9EmHH4TRYftqTl0Bh7RMqBPu33GmfbGKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713442477; x=1713528877; bh=PorwP+WNqPccDtxN72Wzj69yLMQ8
	Q/cs5BvwLPJzZ1M=; b=HTx7Z4qPrBzuf6sxaIMss5JTLuv9pz6aLzo4dZkZJcm7
	GIX8IZMWOq7lewkiblioaIX4oD4oFrIiihQSW5KiVPs/L5wZ7IyGk24GYOSMjIFD
	M0sV0ttowLH1Z7iRC2gmzfqLFL/ombc0v7BcsEB71GYdyG3AeWTnM4EEQkmt8Kr3
	Jo4toDZcPYtuOwNe5pYfueLnFo/wiCeclMsbGC6qTaW28r5iX4ynHfhKyspwaJ2s
	cSvCATCDyZuW4rfxKGwM6w+j59rM/cOuSO0kSOdd22ADBE+qet7sRw1XFjVq8n6u
	5T4Bj+W2oVIeyxSXMkxDLnSHRyqx8dGKEP49K8alhA==
X-ME-Sender: <xms:rQ4hZmo37zJmxlhCqTjT6sIZ4o91FNNq68Ka5HC6hGM9g4DPFZN30w>
    <xme:rQ4hZkrwUeUQu6OjidO8Resf6bkVA02LplMpbbe_KpY5sELQS2xe4RMAs66mETFML
    dqrbq5G_EryAptaFw>
X-ME-Received: <xmr:rQ4hZrMjXunKjihd_Ppb0_WPZ0CsSCGcCFpXQSZJMlgOfBkVJV0GY-C9j0ZR9JzO5mM0C0jN5BqiQQ6lF2BeYKSTXrDFr7BG12dF_ne-YDDDwR43Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:rQ4hZl5xD1nD-pWqLTuRiMvJIKWqEXdj-E4Vkslb9vdTnYEYyP5OaA>
    <xmx:rQ4hZl59WQ61efOm2hUZymHiC1LmERKh7-_HNaU0N37LZoaQ3mPpCg>
    <xmx:rQ4hZlhxSxqsy6PcO1IXDr_P9G7jgqIpYMscfSbmznFtAnK08EPX_A>
    <xmx:rQ4hZv7jsTnOfeKS559nnMeYKLTP4BfM-fL7eIeO6iW8NvhB7LzPtw>
    <xmx:rQ4hZo20MPdVI0XVFzBwLxae8L0hBodvi2-PEdeuJCAkMSzAqkogJE49>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 08:14:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eab053f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 12:14:11 +0000 (UTC)
Date: Thu, 18 Apr 2024 14:14:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/6] repository: drop `initialize_the_repository()`
Message-ID: <ed722b9b4b2d0d173eff2945812e6a15d6470c38.1713442061.git.ps@pks.im>
References: <cover.1713180749.git.ps@pks.im>
 <cover.1713442061.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zUY4l2rDfvpxaqsw"
Content-Disposition: inline
In-Reply-To: <cover.1713442061.git.ps@pks.im>


--zUY4l2rDfvpxaqsw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Now that we have dropped `the_index`, `initialize_the_repository()`
doesn't really do a lot anymore except for setting up the pointer for
`the_repository` and then calling `initialize_repository()`. The former
can be replaced by statically initializing the pointer though, which
basically makes this function moot.

Convert callers to instead call `initialize_repository(the_repository)`
and drop `initialize_thee_repository()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 common-main.c                |  2 +-
 oss-fuzz/fuzz-commit-graph.c |  3 ++-
 repository.c                 | 29 +++++++++++++++++++++--------
 repository.h                 |  2 +-
 t/helper/test-read-cache.c   |  2 +-
 5 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/common-main.c b/common-main.c
index 033778b3c5..b86f40600f 100644
--- a/common-main.c
+++ b/common-main.c
@@ -48,7 +48,7 @@ int main(int argc, const char **argv)
 	setlocale(LC_CTYPE, "");
 	git_setup_gettext();
=20
-	initialize_the_repository();
+	initialize_repository(the_repository);
=20
 	attr_start();
=20
diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index 2992079dd9..fe15e2c225 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -11,7 +11,8 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t si=
ze)
 {
 	struct commit_graph *g;
=20
-	initialize_the_repository();
+	initialize_repository(the_repository);
+
 	/*
 	 * Initialize the_repository with commit-graph settings that would
 	 * normally be read from the repository's gitdir. We want to avoid
diff --git a/repository.c b/repository.c
index 089edbffa2..2118f563e3 100644
--- a/repository.c
+++ b/repository.c
@@ -17,22 +17,35 @@
=20
 /* The main repository */
 static struct repository the_repo;
-struct repository *the_repository;
+struct repository *the_repository =3D &the_repo;
=20
-static void initialize_repository(struct repository *repo)
+void initialize_repository(struct repository *repo)
 {
 	repo->objects =3D raw_object_store_new();
 	repo->remote_state =3D remote_state_new();
 	repo->parsed_objects =3D parsed_object_pool_new();
 	ALLOC_ARRAY(repo->index, 1);
 	index_state_init(repo->index, repo);
-}
=20
-void initialize_the_repository(void)
-{
-	the_repository =3D &the_repo;
-	initialize_repository(the_repository);
-	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
+	/*
+	 * Unfortunately, we need to keep this hack around for the time being:
+	 *
+	 *   - Not setting up the hash algorithm for `the_repository` leads to
+	 *     crashes because `the_hash_algo` is a macro that expands to
+	 *     `the_repository->hash_algo`. So if Git commands try to access
+	 *     `the_hash_algo` without a Git directory we crash.
+	 *
+	 *   - Setting up the hash algorithm to be SHA1 by default breaks other
+	 *     commands when running with SHA256.
+	 *
+	 * This is another point in case why having global state is a bad idea.
+	 * Eventually, we should remove this hack and stop setting the hash
+	 * algorithm in this function altogether. Instead, it should only ever
+	 * be set via our repository setup procedures. But that requires more
+	 * work.
+	 */
+	if (repo =3D=3D the_repository)
+		repo_set_hash_algo(repo, GIT_HASH_SHA1);
 }
=20
 static void expand_base_dir(char **out, const char *in,
diff --git a/repository.h b/repository.h
index 6f4af15417..41ed22543a 100644
--- a/repository.h
+++ b/repository.h
@@ -207,7 +207,7 @@ void repo_set_worktree(struct repository *repo, const c=
har *path);
 void repo_set_hash_algo(struct repository *repo, int algo);
 void repo_set_compat_hash_algo(struct repository *repo, int compat_algo);
 void repo_set_ref_storage_format(struct repository *repo, unsigned int for=
mat);
-void initialize_the_repository(void);
+void initialize_repository(struct repository *repo);
 RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktr=
ee);
=20
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 458efa88a6..e803c43ece 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -9,7 +9,7 @@ int cmd__read_cache(int argc, const char **argv)
 	int i, cnt =3D 1;
 	const char *name =3D NULL;
=20
-	initialize_the_repository();
+	initialize_repository(the_repository);
=20
 	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=3D", &name)) {
 		argc--;
--=20
2.44.GIT


--zUY4l2rDfvpxaqsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYhDqgACgkQVbJhu7ck
PpQcbg//WnvytBu4xI5gCu0rjUge1g/YTKKzyF9FolV3pVFtjbegtkQBw6+1PHkp
VPLzxlOE/KNH51o9Z0eMGC5E0uATwZzDEDKnzGSkWibXM0NotN+H9S5T4Ex22/VO
GAiA4s7wuUrP/6x8t7dbuCO1Ak8cgno3uvAeVRk6AHjWFbt3hVk1m2on3Jp2aS+L
smmR8rOQRWS5LCu675b68dOgUwGPjCNNwrUnu/RoPvT559bqcNJDQvYSU1SAwtad
ksHkBgPgCbGkQbUwSsTlKPiCT634MGIqyb1rGN5g3HaRT2eAj+RBP1Sh3g4Sn7vv
3v58xS+rKMc4Zq3BIDMY9NtfLTsLZ1DuUzItMFZFizC6JwPjSDADzMRg0qRPp4fn
D2nx8ZURag9/xp1BaJGu0QdXcEMSXGDBccHZZ3xuEeksahK3BiH2oLgUujb5Mknf
N7uOhS6JXKHbLdx6pG4IWzLhEh7/KjK88IXdghLmM82PgKMxQztTtC8ZrYEsV3Pg
wV+XRUJ6nRzrklU+oFNpejSZ9nv3cWvgCFPaDB5Ba6qiuoU0aazNlO0g4fwZaLM5
NfXS3s+D68EbuYJWf0D0XO938go3Po2HG3VxSTOkHFvinEv7aPV2I6O3bttFXYO2
n3M/JWIBo2EOzlly/8SNRNCevRyuYoT9P3CQ+lCbfREvjnWumOE=
=y7+F
-----END PGP SIGNATURE-----

--zUY4l2rDfvpxaqsw--
