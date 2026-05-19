Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D818D36308D
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184378; cv=none; b=VLDEEUtcs3jdEQ4q1I6puZ25zQOexnxIT75mYYrlUCW+70aBzJD9IqmisH0qmxwK14eYe8sUpQUkLUsmTBEpiSezRdbqHv1n5HwbFJjoAHzFtBjRV539eh2Itap61cN1AFIWt2fM/liOiDm9oikqDCRcDClb2gto7ACZ4RTeatA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184378; c=relaxed/simple;
	bh=xFTt5NbxVusqsD/on85mRQbUa8SnYJQT4JqT/PsKjIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nU2nvnYN2zV6HBjMItrBpDxmun4NYCTDW2ZaAndLQlO5ejWMB/Er2vuIv928dspilCY19Ik7we7e7q2jpQkMzR8KnifI8l719Ahjz5aOuwP4IAHVgE8QyheyyVi02G/eBAwe5glJEgWtr0IQqbNPrXiXNTb4+o7Nwm6Iqmn+CWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QiM+zl8o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bC7u3rHw; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QiM+zl8o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bC7u3rHw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 791CC1D000AA;
	Tue, 19 May 2026 05:52:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 05:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184374;
	 x=1779270774; bh=YUQ8rxgA2B/JABnh3C9+BQGGT+GoNLxX9mdbHyGP7Sk=; b=
	QiM+zl8oB7z0jSDDJNrCLVvR0KTzTmuB/Cq3TY/uQ7PXbYxn9oMEnYOQESSRbLfW
	RZAp9cKr7bflmtUQQHILcrATjWX/LW7pJ2/UxsGGhS2xD3JkBjCZihfDOSAaO7fT
	g0hbAkH4YEzgKQzSeorgUJ/5FP5+I07YpVM1qKp3he9ENDJS5N01oBYAhdqGi4Hh
	2SSmInFRiD8eqVyuu1u+bRGaYsZDkqEKR1dCOWVCNu0u856bNfspmVaQsQSfC0Pk
	88QKpd9kfNRyJ3HeUaz5rPN+N1VBVKK0aje5hLodQHT0SocUThttPAVgcEE/V4jv
	MuUciWF0nlo4BJ1MuMtKaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184374; x=
	1779270774; bh=YUQ8rxgA2B/JABnh3C9+BQGGT+GoNLxX9mdbHyGP7Sk=; b=b
	C7u3rHwqR+/lQIZa12zOkmHAymVqkyJCRHdsEjLr1o230nHhJeS0cub9FG66KLZY
	N7zK2nTxpy+X1yQICLrlAA7J2RiQJ3KJY8LN16DSGUTxb2opQwbTch0W8sCktp/X
	JhM+Sj8W6SUJpAqlozpfMP4E17zMZNhGHkg7t5esEqZKJJK0TjobmyxvXMPLymSA
	jzG7mO7C3POG8Q2/ye9jhAynKIG0Ph4ui2z4DgRmoJrx3lMG5yea4hT8tqVRYRL5
	3HCAaFCNzAmACeMwVtHiggOdeWS6oZMMj9ChE1yodJ9dgZHMkqpHgGZCYNOyGctz
	JsRHltSnxLOtiSTwkdscg==
X-ME-Sender: <xms:9jIMap9XTl6RCk9frZMhBSkOPgvkiQmPPvZs3qCeinhdf3STfhKZ1w>
    <xme:9jIMakkP1U1tOP3Q1UT4S_TSjDyUj1WzK9f8s5GpccmXchsUDCs95u7L8SdEcyQp_
    A8Yc9f-bgPWT6-7DW-1LoQtiBKi1h6P42116Yv1A-fnnK3ptumfZfQ>
X-ME-Received: <xmr:9jIMavWq0ZecM4Nv2D7E1-qMRyo92i2Z56JXu9QWJ78ABLxMpoFNL__d7PGRh531vWx_kaLbIxR7wQ4kkDgJ3dTfSdUTZ1N5CjQ0yHwICG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeelgeejhfdvfffhffeluedukeetleelffffvddttdduteduhefgvdelhffffeefgfen
    ucffohhmrghinhepvhdupghonhhlhigpvgigthgvnhhsihhonhhsrdhnrhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9jIMapESW5kmNPKMm-huU5_sg30V8-7I6Cf2k0ZdMTZ7rhlZxDocjg>
    <xmx:9jIMarfqNi9bTDaRH50PNBc7nIu5LeOZi2nsvZavy9NODuSou-Zp3Q>
    <xmx:9jIMaqKz8od5n6XjHN-FPzZ_VVKs3cWnT-2cuVByZ1j5rJBoqLwmCA>
    <xmx:9jIMagFQS1tbMOSbDDnDSm7eejm4iFIOSXWXM-JoBIooHe8pjIPayg>
    <xmx:9jIMat3SWIbvJ3Dt_dxR3jCUvJB_pjPDV8somxffjpNYrHhQ3FzNyADN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 93116837 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 May 2026 11:52:20 +0200
Subject: [PATCH v3 16/18] setup: stop using `the_repository` in
 `initialize_repository_version()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-pks-setup-wo-the-repository-v3-16-a00d8ea8b07f@pks.im>
References: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Stop using `the_repository` in `initialize_repository_version()` and
instead accept the repository as a parameter. The injection of
`the_repository` is thus bumped one level higher, where callers now pass
it in explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c |  4 ++--
 refs.c          |  2 +-
 setup.c         | 29 +++++++++++++++--------------
 setup.h         |  3 ++-
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 8844e3d481..24fe0eead5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1229,7 +1229,7 @@ int cmd_clone(int argc,
 	 *
 	 * This is sufficient for Git commands to discover the Git directory.
 	 */
-	initialize_repository_version(GIT_HASH_UNKNOWN,
+	initialize_repository_version(the_repository, GIT_HASH_UNKNOWN,
 				      the_repository->ref_storage_format, 1);
 
 	refs_create_refdir_stubs(the_repository, git_dir, NULL);
@@ -1442,7 +1442,7 @@ int cmd_clone(int argc,
 	 * ours to the same thing.
 	 */
 	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
-	initialize_repository_version(hash_algo, the_repository->ref_storage_format, 1);
+	initialize_repository_version(the_repository, hash_algo, the_repository->ref_storage_format, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
 	create_reference_database(NULL, 1);
 
diff --git a/refs.c b/refs.c
index 844785219d..c36a322f4c 100644
--- a/refs.c
+++ b/refs.c
@@ -3453,7 +3453,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	 * repository format so that clients will use the new ref store.
 	 * We also need to swap out the repository's main ref store.
 	 */
-	initialize_repository_version(hash_algo_by_ptr(repo->hash_algo), format, 1);
+	initialize_repository_version(the_repository, hash_algo_by_ptr(repo->hash_algo), format, 1);
 
 	/*
 	 * Unset the old ref store and release it. `get_main_ref_store()` will
diff --git a/setup.c b/setup.c
index 406984b62c..e09483ba34 100644
--- a/setup.c
+++ b/setup.c
@@ -2385,7 +2385,8 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 	return 1;
 }
 
-void initialize_repository_version(int hash_algo,
+void initialize_repository_version(struct repository *repo,
+				   int hash_algo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit)
 {
@@ -2402,35 +2403,35 @@ void initialize_repository_version(int hash_algo,
 	 */
 	if (hash_algo != GIT_HASH_SHA1_LEGACY ||
 	    ref_storage_format != REF_STORAGE_FORMAT_FILES ||
-	    the_repository->ref_storage_payload)
+	    repo->ref_storage_payload)
 		target_version = GIT_REPO_VERSION_READ;
 
 	if (hash_algo != GIT_HASH_SHA1_LEGACY && hash_algo != GIT_HASH_UNKNOWN)
-		repo_config_set(the_repository, "extensions.objectformat",
+		repo_config_set(repo, "extensions.objectformat",
 				hash_algos[hash_algo].name);
 	else if (reinit)
-		repo_config_set_gently(the_repository, "extensions.objectformat", NULL);
+		repo_config_set_gently(repo, "extensions.objectformat", NULL);
 
-	if (the_repository->ref_storage_payload) {
+	if (repo->ref_storage_payload) {
 		struct strbuf ref_uri = STRBUF_INIT;
 
 		strbuf_addf(&ref_uri, "%s://%s",
 			    ref_storage_format_to_name(ref_storage_format),
-			    the_repository->ref_storage_payload);
-		repo_config_set(the_repository, "extensions.refstorage", ref_uri.buf);
+			    repo->ref_storage_payload);
+		repo_config_set(repo, "extensions.refstorage", ref_uri.buf);
 		strbuf_release(&ref_uri);
 	} else if (ref_storage_format != REF_STORAGE_FORMAT_FILES) {
-		repo_config_set(the_repository, "extensions.refstorage",
+		repo_config_set(repo, "extensions.refstorage",
 				ref_storage_format_to_name(ref_storage_format));
 	} else if (reinit) {
-		repo_config_set_gently(the_repository, "extensions.refstorage", NULL);
+		repo_config_set_gently(repo, "extensions.refstorage", NULL);
 	}
 
 	if (reinit) {
 		struct strbuf config = STRBUF_INIT;
 		struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
-		repo_common_path_append(the_repository, &config, "config");
+		repo_common_path_append(repo, &config, "config");
 		read_repository_format(&repo_fmt, config.buf);
 
 		if (repo_fmt.v1_only_extensions.nr)
@@ -2440,17 +2441,17 @@ void initialize_repository_version(int hash_algo,
 		clear_repository_format(&repo_fmt);
 	}
 
-	repo_config_get_bool(the_repository, "init.defaultSubmodulePathConfig",
+	repo_config_get_bool(repo, "init.defaultSubmodulePathConfig",
 			     &default_submodule_path_config);
 	if (default_submodule_path_config) {
 		/* extensions.submodulepathconfig requires at least version 1 */
 		if (target_version == 0)
 			target_version = 1;
-		repo_config_set(the_repository, "extensions.submodulepathconfig", "true");
+		repo_config_set(repo, "extensions.submodulepathconfig", "true");
 	}
 
 	strbuf_addf(&repo_version, "%d", target_version);
-	repo_config_set(the_repository, "core.repositoryformatversion", repo_version.buf);
+	repo_config_set(repo, "core.repositoryformatversion", repo_version.buf);
 
 	strbuf_release(&repo_version);
 }
@@ -2551,7 +2552,7 @@ static int create_default_files(struct repository *repo,
 		adjust_shared_perm(repo, repo_get_git_dir(repo));
 	}
 
-	initialize_repository_version(fmt->hash_algo, fmt->ref_storage_format, reinit);
+	initialize_repository_version(repo, fmt->hash_algo, fmt->ref_storage_format, reinit);
 
 	/* Check filemode trustability */
 	repo_git_path_replace(repo, &path, "config");
diff --git a/setup.h b/setup.h
index a820041af0..c33b675ccf 100644
--- a/setup.h
+++ b/setup.h
@@ -232,7 +232,8 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch, int init_shared_repository,
 	    unsigned int flags);
-void initialize_repository_version(int hash_algo,
+void initialize_repository_version(struct repository *repo,
+				   int hash_algo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit);
 void create_reference_database(const char *initial_branch, int quiet);

-- 
2.54.0.771.g3ed373ac14.dirty

