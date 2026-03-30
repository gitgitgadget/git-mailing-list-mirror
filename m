Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12E3D47A3
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876708; cv=none; b=QoNvrWO7zeDxmGkKv82aBBxzjoIQFho/DkPXxd4rWvF/DqnovXHixqnhHh4djwkWIqJajoFtwTRJqGB7I0ICJc4GT9s/7jFPRlKZyHtkL3pQd7Fr5JYqbURKqSFRhUh89WIDM4iraUjlFQnOM1NbBM1uqIYMJFtvpBIUNF/ToVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876708; c=relaxed/simple;
	bh=eZMtguxrBE0lxXPyQcFDSbtCG2YUIbzpgOAgqZvRp4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDUmMuzPue7PiuHBn+TkYnhvIwkEHaXjcIlh8pYoncgFWIsGJPqce3Eh2+hnEZU2DVusAixskxzq1Rlz8Xj05elF9/7BXIuyd0pgNz6tQy4Nt8z6Fwja9V9R2UGFPtR9liJXMXxoxK4C/oLw/WXZCx8x+HkOgMmKOgwrtLAYIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f2q2Usq6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CnoG8Fpe; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f2q2Usq6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CnoG8Fpe"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 713571D001A8
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 09:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876706;
	 x=1774963106; bh=qik5bcr4Fn6xRzSYDmIj1Ow/0dYgMn7RQ0asnoXPpGE=; b=
	f2q2Usq6nj0IqXhzfNgAAFMNNSTBcUBeerZAQPDvIgmq2/h3B+BZwQM6Dvnmeq/2
	kEUfiSLBOT3oTjGarkT/gMjSzocg7XaZb8qboli6ceWklSGffOArbld2gqBbFhAO
	4nFzNKNJcK1s4W4JT/Op4Qw3yV7mP//ReInteo7XJPYRB2oOc0bgNUAiy/qLdPVW
	6UTe1TztVbtj/06Rx74N2PsQ8JqtLM5ttz870HI/mhCoOr/qVmdwZaGYqowXlJmy
	KXruSoLQwEPD2N/UVqe9Twz1qzajda/WMM34q9YNWWq5/GCt7tVSqjnGowGIgwav
	GVKWIJR1xR912KoYMV0tqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876706; x=
	1774963106; bh=qik5bcr4Fn6xRzSYDmIj1Ow/0dYgMn7RQ0asnoXPpGE=; b=C
	noG8FpeHNUbTWYwnvrNZAVP1SGdSbdl7G4obnA9Nw42ARut3JGYAusZiHuWBSY28
	ya8kX6k77ALXwo/48FTKmP91Ye0N9QvLxwwjyeiROeyiVqSSdW3dDTQtVNAlzpJb
	UBL0KpAi1DDVMfBHIlwhgpKxy5qGC5O9f8TGRJuj3ld3U8ECn5p/O954b0Eou4F6
	Gk1K3QRgID5kpqG7hOMJGBBWH4uGn86W/3q4Lvn+G7zc7ZWu3XBzAjUqibrVrw06
	tgo8+Wx8m+bFkcgrEHbB8rrxm4DqGAW6qutM7hHUFuUf8Xe9bV340/bKijlxU52z
	KVrZn4OzT+0uTCjwJFHpg==
X-ME-Sender: <xms:InjKafRyNPOhgod5FoDLhhwpIVOKhW2VqoLxTGCE9due9xs5vyRZbg>
    <xme:InjKaXs-LOSyFPyV6BIfrTWasDEQILC2Ye1c4cSYVxFD93UH0dRM0Lp6uAnYmzAEl
    FFVYZHbsKdMT_0Qu__9qF14Zb0whzcjJsbBberJUTsF47bg4e4lmio>
X-ME-Received: <xmr:InjKaaeHf6aWmJmoNoNtl8fat6yQgPrz__P1d1KD9GUmGXYuPT5gQkPNnrrlckb1swOJuE4ijvxDw0tCAqhq-DO30AlZHw_PtnEir6golEkWJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpeelgeejhfdvfffhffeluedukeetleelffffvddttdduteduhefgvdelhfff
    feefgfenucffohhmrghinhepvhdupghonhhlhigpvgigthgvnhhsihhonhhsrdhnrhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:InjKaUJNlsCcKbq5unLgX4sQFyp_z5L_KQc3dF0yKGYxBs2VSRkwAA>
    <xmx:InjKaYYmZR8gll0Tu7R5zOx6xz_poTjKzBc-a19FU6u-DtC6ZB4FPA>
    <xmx:InjKafu34LclNFnw0f7E0lffBPUEk2nb7q3R_-LAFtv7s4keDULZcA>
    <xmx:InjKaVvhXIRvmXY6c00XRhUo48o8SalYMGPc8z5GMTjpAcrLydZkHw>
    <xmx:InjKaTRxoDbuEyiCS4p9ZzHomC9NyAbxE5GPPcYX1RinZKi8s1sZhBLY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 04354cf1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:18:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:38 +0200
Subject: [PATCH 16/18] setup: stop using `the_repository` in
 `initialize_repository_version()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-16-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

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
index 16cd7b029b..663ef0b524 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1227,7 +1227,7 @@ int cmd_clone(int argc,
 	 *
 	 * This is sufficient for Git commands to discover the Git directory.
 	 */
-	initialize_repository_version(GIT_HASH_UNKNOWN,
+	initialize_repository_version(the_repository, GIT_HASH_UNKNOWN,
 				      the_repository->ref_storage_format, 1);
 
 	refs_create_refdir_stubs(the_repository, git_dir, NULL);
@@ -1440,7 +1440,7 @@ int cmd_clone(int argc,
 	 * ours to the same thing.
 	 */
 	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
-	initialize_repository_version(hash_algo, the_repository->ref_storage_format, 1);
+	initialize_repository_version(the_repository, hash_algo, the_repository->ref_storage_format, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
 	create_reference_database(NULL, 1);
 
diff --git a/refs.c b/refs.c
index e66cf4861d..6a49ef8a1c 100644
--- a/refs.c
+++ b/refs.c
@@ -3450,7 +3450,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	 * repository format so that clients will use the new ref store.
 	 * We also need to swap out the repository's main ref store.
 	 */
-	initialize_repository_version(hash_algo_by_ptr(repo->hash_algo), format, 1);
+	initialize_repository_version(the_repository, hash_algo_by_ptr(repo->hash_algo), format, 1);
 
 	/*
 	 * Unset the old ref store and release it. `get_main_ref_store()` will
diff --git a/setup.c b/setup.c
index c32d6e96bb..1570749b4a 100644
--- a/setup.c
+++ b/setup.c
@@ -2382,7 +2382,8 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 	return 1;
 }
 
-void initialize_repository_version(int hash_algo,
+void initialize_repository_version(struct repository *repo,
+				   int hash_algo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit)
 {
@@ -2399,35 +2400,35 @@ void initialize_repository_version(int hash_algo,
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
@@ -2437,17 +2438,17 @@ void initialize_repository_version(int hash_algo,
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
@@ -2548,7 +2549,7 @@ static int create_default_files(struct repository *repo,
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
2.53.0.1185.g05d4b7b318.dirty

