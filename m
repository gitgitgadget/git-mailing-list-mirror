Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1C63E63B7
	for <git@vger.kernel.org>; Mon, 18 May 2026 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096709; cv=none; b=Tgl6qZ3rFiUSZQU64dgzDJiR0WwRK1DFhuzXcLXlw+j8i4L+IZWsLho4qBQRy0Ic6jGnrh9sF0nsT6ydeMf/Quk3hVAiyE2jfkv9OwH0NeeW0ugU7BeOD+gBot4t8Sf3xkE2F8PNyDt0+//vzJ2Wl/0xvfMF8CnyWYFGd2ju5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096709; c=relaxed/simple;
	bh=xFTt5NbxVusqsD/on85mRQbUa8SnYJQT4JqT/PsKjIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mqKnN4mG04MFmcr97jDragJ9n3mYg9KtKjIVyL8wJgpkfCQ8vQPlOm2tPdKq10AEoRf8aqkDgTkoWrKi+4CNf6iTJh/W0AUm3lSaZ4GZt1Wo3MoJlv/OuJDJBK4aIEdh0JD3DJ7xtCiCDjoPDYO48aRXZrDslPjxjrcgpn1+zjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QrAfdez6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VEyyrjKS; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QrAfdez6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VEyyrjKS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A84A91D00061;
	Mon, 18 May 2026 05:31:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 18 May 2026 05:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096707;
	 x=1779183107; bh=YUQ8rxgA2B/JABnh3C9+BQGGT+GoNLxX9mdbHyGP7Sk=; b=
	QrAfdez6Ow9+dM9pIcIkBM6xv2UV2AF9LVlNXKZrazAqN5ni4cZWhqeKDGBubNOT
	0XgEdzFxJ84g2ochw8YVLRQaHr1jnoj3GE9hSG0S3S/p6h+UTr65Ngcoz4ZCb+MX
	w7pgyanwQwJeQ5kt3urFty9tGrNe+RteXpv48MFG5uVzib4W5Mul8imwdPEWOotv
	4DR5P+mS+nJ1gwodkBRLr3YQ6yakeHxK88eAZqAGSZMpT7ERx41QUUW34bBLytYP
	E89+9Znhbu0Gz0yaeh8o2jAiDeAOCKjnaxX+sFvD7Dx1WXo9/FipitdhD6lmWtm4
	xytDtgqp98Psi/Eq4bTzvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096707; x=
	1779183107; bh=YUQ8rxgA2B/JABnh3C9+BQGGT+GoNLxX9mdbHyGP7Sk=; b=V
	EyyrjKSR6eCExGMq3iGWl9Nh3NCvaKN93O/HcNpSlH3db85bAOh6DhhSqrePlRJC
	c5chA1/WRmhX8jEh6qDn0938xmcZeiiRBf830UDHz+OSHTq/z1q/DsPcSJ53mLoU
	TLgKROJa0VRUMYnGiziOf3nU3KEb325ylEDaR4vrpKhcf/A8jEZPqkUpI7WnBiZO
	IqYpBzGTe9q9mfNSgsSgMV+/+Aw9bkFTp0thuPv2pcLZLUo9FQDMh/JEK+IdhpC6
	exwAKoCfg32cjAB0soJfYd0k7acHBMmDAN59YS83V2EFakbndbkjK42vT35vdHzw
	Ro9vMJa0g3n8pzrlQ4RiA==
X-ME-Sender: <xms:g9wKanasDPAznIcnvXvUS6X2UeMZFd8qRFy8kNCDhegyD1--ie2fpQ>
    <xme:g9wKatRYTARjn31HbKgU4N_Zagt15GPngr2BXj71VWx7hCKgCN7EzPmRjrW7MjXgP
    s6S2YyN9wk78hQqYhVLgDQnNL9YnvPtYQeNEPUzSkk8GponwxjHVg>
X-ME-Received: <xmr:g9wKaiTd0sqiOFL11UXSyrEgHsd4UkJwXHchbHv3zneRezOlottevrneiolRf_lu6ipPNvQQaK92JQ5hzvdWOWkpW1urei9AQc-RnFTmVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeelgeejhfdvfffhffeluedukeetleelffffvddttdduteduhefgvdelhffffeefgfen
    ucffohhmrghinhepvhdupghonhhlhigpvgigthgvnhhsihhonhhsrdhnrhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrg
    htsehmrghlohhnrdguvghvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:g9wKapSqR2nFt8AqsrzXy0tZE2EyNxsQX5LLI9WUGNmti3c-3aBJTg>
    <xmx:g9wKav5VSgTdhB7FP8SvESoSwyGK_rAJJL004AfNGqrMZ6Vz0MUuVQ>
    <xmx:g9wKat0qDSvz3OO-NP2ePglSQbJkwRVtX4X8H64VHySU8A3X8OD2bQ>
    <xmx:g9wKaiAWE6k66SsS9uqxbXOwBh6ex4LW_IPSGaiCnfiMDiBbtakl2Q>
    <xmx:g9wKaoiW3a_Du87LTSXZQi6-BYf1eqptQYKkfNQkI2x6gqqmN17Uq4og>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:31:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1b4c513c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 09:31:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 18 May 2026 11:31:07 +0200
Subject: [PATCH v2 16/18] setup: stop using `the_repository` in
 `initialize_repository_version()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-pks-setup-wo-the-repository-v2-16-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
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

