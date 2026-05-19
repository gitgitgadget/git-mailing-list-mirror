Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA23480969
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184377; cv=none; b=h/gX1VxGBcYo6jQcmufFTQfudYfNnksOduFEp9rkPgnejX9hF0Z5Yf3jSbP+MvTIrg9uEjN2ucyZ0cagaUeMMmiICoGhyuZkTdXuFmni7aO3PxPIGQhnKW88BsReQVmq6I1zPeNb00ldHs6LY0WzNGR1np6hmFvaagzuyppVMXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184377; c=relaxed/simple;
	bh=gIexqYvS5Z+p63Psi3E+MkEYUuAqAvi3jFkpux5JaKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pjaAZswTbnhsqgsoFSI0UEBWkzaiHl6glDIeFYB8fa3yVPGnbETPxVMDMpQ7h3T23GHhRoi1Qo5OX6h0mO0PopDSWl1Frbs7rKFX5l3gevnhYY25CvXLKXEH5mXe/TdgTSL1vCQVk1KLxy2NCiZF5Npug7au7uIeXRILA/TXHaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DwGfkG1K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lhmkxrs3; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DwGfkG1K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lhmkxrs3"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id EDAC31D000B8;
	Tue, 19 May 2026 05:52:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 19 May 2026 05:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184371;
	 x=1779270771; bh=Zxz0a2PPZDX277oAHkKobOxAuGeJaXm2q4lh8nI7ttk=; b=
	DwGfkG1K752wvOzbTGPgIrrj3E0RJnVnxpXSiGsnm7bheetcS5YbY9C7jWTEs2fz
	asIx1tw9bvhCn8i4p/7+yhpXtTZPgJhu73RiGQhkPepL6jA+E+vdb2Ke8pur7YWF
	oTPV+uBzm1rA20sKVOHAEoojHE2VnveSTbmJl01aRRoFERy96vlrNLwb04gaZtXk
	8yrp35GjOMvK+i7ILwI8BeSnCGG+tXvzXvssqqVp/hjimkJ2pstJ57uACqXLnjjb
	S8EugUZNBUzXBlDSZPM0oo1jdgbNKJtwMmYvmQQs4LUJ5NsypGW+PVCatTLsgTqh
	5wvDsrpBle7L0ZkHjbtz0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184371; x=
	1779270771; bh=Zxz0a2PPZDX277oAHkKobOxAuGeJaXm2q4lh8nI7ttk=; b=l
	hmkxrs3P2LXeM4V6xBOyMXUC/h1U/wCT4PA47IGvjDPd8dJr3fq9KgXAzxov8waV
	iJs2WUFM1yd6Jb1ff6g16XdRVCbKlkzh7CEOLpPjdivWq0974C/wG7Zq5D/eF8lD
	evgI9wTaCQXe9OGnuxkGEABWjUUisDOZVmjhUWwgW3kXonyFwdevV4ZQWKRCmw/h
	DATUpWgoAkp3Hu1SQCsRFoLxef+cAxpbCNpNlSsCJcG5IoT2rr/V6yqC9h3hNlc8
	opJK+d7j8lhhROmSIuIkOg6IJRH5fbKrBmK4CSwbbq4Lo25XJi6N8Z3Rp1wk1diS
	D4ep3u/w2BFTqRPJS+dGg==
X-ME-Sender: <xms:8zIMaqY6_Vteip7ZDC2y5kwgc1y30VhQhJqgHFVzhHDlIqtFpJqDfA>
    <xme:8zIMakQDuM0SVESACZkKT98rjxRjMjviXoN0Y-rH_gNvZGCTFvhVyw9ghGQlOadXB
    MFPnpZy1zOxNZHKzF9kfAmugbUCtrFE2cXtARnE_cw2ZuEmgkNfZA>
X-ME-Received: <xmr:8zIMatQOC4hCxBQvKlphp_4IHbKOgav7Hzu6KGPXgkFUHP9fq9P329uTYF6E1_jpnbxlqObW461NmT_96ajl1r2dmOgHX317478it0n_KAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptggrthesmhgrlhhonhdruggvvh
X-ME-Proxy: <xmx:8zIMaoTyGOWnQ9nC-TbVclrtwnwzRnQvcWFE4v_QL_gmjKcGTDyosA>
    <xmx:8zIMai6XRzSpBeCG_P9IUD-fjnu8FeRuDKmJzOLAqKrJidS0DpSdZw>
    <xmx:8zIMak0Ms9p0Xv4cqsY4T1UpiC-4Rc9ZHpDaS4NiXx8dnKHpYzGFAg>
    <xmx:8zIMatCyfm6Vo8ay1k1GyOOeyNYMD2Ex6CyjWIDk_yadkB80gB4GcQ>
    <xmx:8zIMavgKL3sBuB44Nm0AqGLBVRAuPi9XcgXkzDqYns-Ey30eL4Y9Bynr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d891856 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 May 2026 11:52:19 +0200
Subject: [PATCH v3 15/18] setup: stop using `the_repository` in
 `check_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-pks-setup-wo-the-repository-v3-15-a00d8ea8b07f@pks.im>
References: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Stop using `the_repository` in `check_repository_format()` and instead
accept the repository as a parameter. The injection of `the_repository`
is thus bumped one level higher, where callers now pass it in
explicitly.

Furthermore, the function is never used outside "setup.c". Drop its
declaration in "setup.h" and make it static. Note that this requires us
to reorder the function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 58 +++++++++++++++++++++++++++++++++-------------------------
 setup.h | 10 ----------
 2 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/setup.c b/setup.c
index ed0c14e98e..406984b62c 100644
--- a/setup.c
+++ b/setup.c
@@ -1758,6 +1758,37 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 	return result;
 }
 
+/*
+ * Check the repository format version in the path found in repo_get_git_dir(repo),
+ * and die if it is a version we don't understand. Generally one would
+ * set_git_dir() before calling this, and use it only for "are we in a valid
+ * repo?".
+ *
+ * If successful and fmt is not NULL, fill fmt with data.
+ */
+static void check_repository_format(struct repository *repo, struct repository_format *fmt)
+{
+	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	if (!fmt)
+		fmt = &repo_fmt;
+	check_repository_format_gently(repo, repo_get_git_dir(repo), fmt, NULL);
+	startup_info->have_repository = 1;
+	repo_set_hash_algo(repo, fmt->hash_algo);
+	repo_set_compat_hash_algo(repo, fmt->compat_hash_algo);
+	repo_set_ref_storage_format(repo,
+				    fmt->ref_storage_format,
+				    fmt->ref_storage_payload);
+	repo->repository_format_worktree_config =
+		fmt->worktree_config;
+	repo->repository_format_submodule_path_cfg =
+		fmt->submodule_path_cfg;
+	repo->repository_format_relative_worktrees =
+		fmt->relative_worktrees;
+	repo->repository_format_partial_clone =
+		xstrdup_or_null(fmt->partial_clone);
+	clear_repository_format(&repo_fmt);
+}
+
 const char *enter_repo(struct repository *repo, const char *path, unsigned flags)
 {
 	static struct strbuf validated_path = STRBUF_INIT;
@@ -1832,7 +1863,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 
 	if (is_git_directory(".")) {
 		set_git_dir(repo, ".", 0);
-		check_repository_format(NULL);
+		check_repository_format(repo, NULL);
 		return path;
 	}
 
@@ -2107,29 +2138,6 @@ int git_config_perm(const char *var, const char *value)
 	return -(i & 0666);
 }
 
-void check_repository_format(struct repository_format *fmt)
-{
-	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
-	if (!fmt)
-		fmt = &repo_fmt;
-	check_repository_format_gently(the_repository, repo_get_git_dir(the_repository), fmt, NULL);
-	startup_info->have_repository = 1;
-	repo_set_hash_algo(the_repository, fmt->hash_algo);
-	repo_set_compat_hash_algo(the_repository, fmt->compat_hash_algo);
-	repo_set_ref_storage_format(the_repository,
-				    fmt->ref_storage_format,
-				    fmt->ref_storage_payload);
-	the_repository->repository_format_worktree_config =
-		fmt->worktree_config;
-	the_repository->repository_format_submodule_path_cfg =
-		fmt->submodule_path_cfg;
-	the_repository->repository_format_relative_worktrees =
-		fmt->relative_worktrees;
-	the_repository->repository_format_partial_clone =
-		xstrdup_or_null(fmt->partial_clone);
-	clear_repository_format(&repo_fmt);
-}
-
 /*
  * Returns the "prefix", a path to the current working directory
  * relative to the work tree root, or NULL, if the current working
@@ -2804,7 +2812,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_repository_format(&repo_fmt);
+	check_repository_format(the_repository, &repo_fmt);
 
 	repository_format_configure(the_repository, &repo_fmt, hash, ref_storage_format);
 
diff --git a/setup.h b/setup.h
index b779661ce7..a820041af0 100644
--- a/setup.h
+++ b/setup.h
@@ -221,16 +221,6 @@ void clear_repository_format(struct repository_format *format);
 int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err);
 
-/*
- * Check the repository format version in the path found in repo_get_git_dir(the_repository),
- * and die if it is a version we don't understand. Generally one would
- * set_git_dir() before calling this, and use it only for "are we in a valid
- * repo?".
- *
- * If successful and fmt is not NULL, fill fmt with data.
- */
-void check_repository_format(struct repository_format *fmt);
-
 const char *get_template_dir(const char *option_template);
 
 #define INIT_DB_QUIET      (1 << 0)

-- 
2.54.0.771.g3ed373ac14.dirty

