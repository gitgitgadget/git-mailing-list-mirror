Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D6A2D7D3A
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673417; cv=none; b=QtqzR7akt1r6sMqoijWX4owEZ1C5g1JMh9llboYGixni2Tj3XGxSYzy6yY1RfwX67kX7M/pTU0ofU5rBMwpUh9ytQMrNdVsxS47BcKnDWrpoq+/5XQeE03VtiycY1nGmQA3P37mXBkJesiKulwF4wjNQTrvb1ssDFZJAtU/Tlws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673417; c=relaxed/simple;
	bh=/9xO57Z+07y5z2HY8SCkVJaziXaahsTCTmFTuYAf2vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8uOJyRyVe/yYSUrcR309/olFHDuSs+YjE8GC8ztmHRQ8olXdAxilKhKJFNQVeGqPVnCRP/DJ9YR9jDG+N19ziA6+DwVASKFsgpOgzsM6GtTAzLuw5IuVZu9QJ1dF6nhJVmgSZjMtgum6uOc6rfunHg2qSJdpjINeX+0eaMfsfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eRvzQ7+H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A7m49f37; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eRvzQ7+H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A7m49f37"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BBD0FEC036B;
	Mon, 20 Apr 2026 04:23:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 20 Apr 2026 04:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776673415;
	 x=1776759815; bh=DI1Z+zGEgIXbQOdmQttwogrmJRZzM8FEGc72vVe/MnM=; b=
	eRvzQ7+HmtxIy/zDuOWgeg9EHTpT6uzcdiPJOdYLGkLs2hVu6cMYRqFAR9GSGRpa
	gBrCV+8QT2Xe53hraVlEQUJRWo5uaD8WwyJ+UG5bNNfaaMII1a9IZpWuMHaZucsD
	V0bRE49VL7RpP4iggvQOf8Y5WWjMTwhFkai3U2WJA0ha+NXfZmjugo7bv4NoMmfT
	EBJyPgVnvbJEu+oSIGfX5v6YNMXVY/zhz3Pm+m5qzVjFeQQwInl9hWGIeoDptsBI
	c7ajNIBqjjqEQWeyyOLmNxLF49dmtDla5q5F9gSMyFN00UPVY3+l0e9FDCHC3gpr
	YGg2p/yE6FYGL5tzPfGQdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776673415; x=
	1776759815; bh=DI1Z+zGEgIXbQOdmQttwogrmJRZzM8FEGc72vVe/MnM=; b=A
	7m49f37bSjyMOOan3QWPRqWObLGA4NH1kpPl1xn7l5boCxLUGBaqoZtHgXmbSYvn
	ott2JI4lUm+p1qsHLvcXt9AosyadOjEGSZ2kr+nkP3KlivAVLVGy80kol5Rmuq+o
	ZYGa0yHv2pC6dc0vnZGhUARbjTNivkmBsy4R3+fcTgD3chRrcVts4Qoj2p6coTTh
	ZTSrs6zou6mIglHBcw3bayakH9t8pM0Cps2/M23N4faoOrwUSNIW44Jd6sbcF4cS
	8GPzZAflBtDfN/2KDJzSJd4o5P2/1rMFgRvfmc8cMtzDbGFLcnD5q93+HPJYU7OJ
	AYY1NTNKixei0qQMqu7HA==
X-ME-Sender: <xms:h-LlaXH8x05QwkRgRqQaYRMy5FX5dDzayJfvFeoba2KUdXStvWW3WQ>
    <xme:h-LlabXCTlG2_Gf1WIXYoj5SRWDX5miHvOJVjrTi-49Q6dJwsNdFXudd3wURWfzh_
    xLdeHzTMMxmzK113MB88THXNUq0RodoG7QHr6pyFkPJbpAkTsPf>
X-ME-Received: <xmr:h-LlaeKSPUSqVL04R_jwHj0MOjWiuG-iYeWWgnsl3bUhOCGkYNlQqjsss_JyWyCNcdYoc3HU9f1zlBxeovPvr290pOsK18Ey3TT3pwk2Z9WN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epleegjefhvdffhfffleeuudekteelleffffdvtddtudetudehgfdvlefhffeffefgnecu
    ffhomhgrihhnpehvudgpohhnlhihpggvgihtvghnshhiohhnshdrnhhrnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:h-LlaT-kpp26Wvbyi3GqxFIAur9ZTmmeSojLujbOTEtrOnBzvBokng>
    <xmx:h-LlaZK-2ZB6NR9p_cM06qJVxWGzPceHKyF909RpU4AUpCnarp5_EA>
    <xmx:h-LlaQmeG-fg73hrP3Nn7jYrn940tsXhjhvD4BhCcZeLrLrbxhRpdg>
    <xmx:h-LlaVNz9TwUut5vTHVTYU34PTpfmiGVkK1MzIYfhRDKZeX1aXHQUQ>
    <xmx:h-LlaZpnXliTzWCLiGxGBr5AVvXkbLxSslpdorY_QvAql-CYvKI-7CEu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:23:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d53c42c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:23:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 10:22:46 +0200
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
Message-Id: <20260420-pks-setup-wo-the-repository-v1-16-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

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
index 803d482849..f1d640ea74 100644
--- a/setup.c
+++ b/setup.c
@@ -2376,7 +2376,8 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 	return 1;
 }
 
-void initialize_repository_version(int hash_algo,
+void initialize_repository_version(struct repository *repo,
+				   int hash_algo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit)
 {
@@ -2393,35 +2394,35 @@ void initialize_repository_version(int hash_algo,
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
@@ -2431,17 +2432,17 @@ void initialize_repository_version(int hash_algo,
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
@@ -2542,7 +2543,7 @@ static int create_default_files(struct repository *repo,
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
2.54.0.rc2.529.gd9106f7525.dirty

