Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D5339DBE9
	for <git@vger.kernel.org>; Thu, 21 May 2026 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349380; cv=none; b=qYYZd0mBsSPJNKwLEqK8EQnFWNJtVPKOpl3WgP4gLHaEjpwmn3hE3PtP+fLqfUug5TjJokU0CVeCOV1AkEq90HyDGHFNerIMa/qTw+hvas6GY94PJRfyUxDdfLzZdH3Q+9Nelcyi8TZummtf4x7/XjUUD2p1eS+XpD+ooWYF/hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349380; c=relaxed/simple;
	bh=5N6t/w+00AbJxmJoOIw78ukq9DtF/hMcS3Bo2+u1ezs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VLiB4tUsuROL6WcDNZcL7umcFGtcTeC7PKKbL75VMLjVLx6W9ZUpw9zjcwsyESa7F9RW+COvgH8UjY9H8IsKcQYOh/EE54YRSRQTfUhNniKUlHv0fYJXVDTMWwlFFsd2avsVUi+uuJhNULvajW/53Nnkd6J41B8YY/0VktO4v3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gkJVdAv3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kdv0PhC1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gkJVdAv3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kdv0PhC1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A2D0EC0078
	for <git@vger.kernel.org>; Thu, 21 May 2026 03:42:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 21 May 2026 03:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779349377;
	 x=1779435777; bh=bvHQqYkgZtpDNVgopfdx5tBGM5/MVGFs7EEGxPQfx/I=; b=
	gkJVdAv3odcDeeUfY8QJgL4TVx7tyDjmTMn7crnxpDJ0krYhQf0Rc0Wa3wLQP2/0
	UExMEmVvOJGQ9Lt108ZQbvENmq6e6ZZkCkvyAD5v86fi8Ol8J66UVedBfXd7DeJd
	4ffGVD9GNfkIJipuVM/h49oUA5KYUIJ0qLW2XT1XSRRyxDZNmEkpCoDErNpDbnx+
	UN18bZ//YeS4Okqhzfy/M+ZaRvzwgLxihRMVTMWqgY7nWlDUgr7xCZx2OXOZG8ZO
	fYaUsdhFvQhsVXklgRpthh4lqSPLmwVh3Rnlpl5le8aRzlu3E9OEqebHT06ds5NW
	nbEuQ8WSsXxMgIYjzVcw5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779349377; x=
	1779435777; bh=bvHQqYkgZtpDNVgopfdx5tBGM5/MVGFs7EEGxPQfx/I=; b=K
	dv0PhC18MYBnDDHkqViVvfgKdKTaHJQwlQZJOv32R9JeEiZLATAy50/YJPUpGW1o
	2wLYbvsYzMW0AEwuaz6HF+tDM89EqpGxcFT8hjLZYOOLk7oTIz+FxiXe8feCefdi
	jEnf9CGNdgq/tZ6I1WCz6A770RWD0CQzS6D2FN+DPeAfx4NGfXTMIhRYh7K6fTGB
	RW8nE3qjf8s/5J1ujJoRJyx4u7bP2MdrUZpuAepn8n9uRE8HmujSu4IbVVZXfL/7
	WHz9MtDQSys4NL1V4z0zAwQTnhOuj+Yuhlpt1cyEzWyDm3UwQ+ZJatQ9/PGjPEBF
	K+IX32Crb77b/cEv9eZgQ==
X-ME-Sender: <xms:gbcOagTGSh4bbPp_67L9VolH6yg-y-U4CLMxe4SDgLHW27-18iRqQw>
    <xme:gbcOakv8Db5AU1CMKtPIFvXlBBCpthi-z_sm_J_wxHZaj30nWIRNEA0J9qUkZ1NgZ
    sSKn7rO-5vIkPwY4LwrV215h3SR3m_NI7RNVTv679CNsRtykueRqg>
X-ME-Received: <xmr:gbcOajc55pdD1RTEycy3eAFY5zueXxsiYTkapPVRMKRRK560I13x6hpLnoD2nJ2NIFDattyefaB0I38wYABVQEmMaznYW4iBtK_7hDdxf4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:gbcOapJHl13MaC4FmfVliTZoCPEBFBNYNgdF4I2yx_q7yMKMW3cBJw>
    <xmx:gbcOapaac_u4Hx_BJO83as88PcwmVg5TMF5RK5_XIWS3q0bOC7eL-A>
    <xmx:gbcOasuCDkWRL720V4taaGaSnwz4T8m3Lwm752qQRWB-CWT-OHvTTw>
    <xmx:gbcOausb0xx1tJZSFahf8edgXY-BXZ7uKeJjk2bXi7oXvBGeXEB95Q>
    <xmx:gbcOaoSfFIL-kX6sW1ot1tIJyLXsArzanVf4chCSPou5uUaCDxyWBCFq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 03:42:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 058cc948 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 07:42:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 09:42:35 +0200
Subject: [PATCH 8/8] setup: construct object database in
 `apply_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-setup-centralize-odb-creation-v1-8-f130d2a7e8ae@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
In-Reply-To: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

With the preceding changes we now always construct the repository's
object database before applying the repository format. Remove this
duplication by constructing it in `apply_repository_format()` instead.

Note that we create the object database _after_ having set up the
repository's hash algorithm, but _before_ setting the compat hash
algorithm. This is intentional:

  - Constructing the object database may require knowledge of its
    intended object format.

  - Setting up the compatibility hash requires the object database to be
    initialized already, because we immediately read the loose object
    map.

The first point is sensible, the second maybe a little less so. Ideally,
it should be the responsibility of the object database itself to
initialize any data structures required for the compatibility hash. But
this would require further changes, so this is kept as-is for now.

Further note that this requires us to move handling of the environment
variables GIT_OBJECT_DIRECTORY and GIT_ALTERNATE_OBJECT_DIRECTORIES into
the repository format, as well. This allows the caller more flexibility
around whether or not those environment variables are being honored, as
we do do want to respect them in "setup.c", but not in "repository.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c |  4 +---
 setup.c      | 45 +++++++++++++++++++++------------------------
 setup.h      | 10 ++++++++++
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/repository.c b/repository.c
index 61dfbb8be6..187dd471c4 100644
--- a/repository.c
+++ b/repository.c
@@ -291,13 +291,11 @@ int repo_init(struct repository *repo,
 	if (read_repository_format_from_commondir(&format, repo->commondir))
 		goto error;
 
-	if (apply_repository_format(repo, &format, &err) < 0) {
+	if (apply_repository_format(repo, &format, 0, &err) < 0) {
 		warning("%s", err.buf);
 		goto error;
 	}
 
-	repo->objects = odb_new(repo, NULL, NULL);
-
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
diff --git a/setup.c b/setup.c
index 4a8d6230b1..513fc88749 100644
--- a/setup.c
+++ b/setup.c
@@ -1752,12 +1752,22 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 
 int apply_repository_format(struct repository *repo,
 			    const struct repository_format *format,
+			    enum apply_repository_format_flags flags,
 			    struct strbuf *err)
 {
+	char *object_directory = NULL, *alternate_object_directories = NULL;
+
 	if (verify_repository_format(format, err) < 0)
 		return -1;
 
+	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV) {
+		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
+		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
+	}
+
 	repo_set_hash_algo(repo, format->hash_algo);
+	repo->objects = odb_new(repo, object_directory,
+				alternate_object_directories);
 	repo_set_compat_hash_algo(repo, format->compat_hash_algo);
 	repo_set_ref_storage_format(repo,
 				    format->ref_storage_format,
@@ -1773,6 +1783,8 @@ int apply_repository_format(struct repository *repo,
 	repo->repository_format_precious_objects =
 		format->precious_objects;
 
+	free(alternate_object_directories);
+	free(object_directory);
 	return 0;
 }
 
@@ -1785,7 +1797,8 @@ int apply_repository_format(struct repository *repo,
  * If successful and fmt is not NULL, fill fmt with data.
  */
 static void check_and_apply_repository_format(struct repository *repo,
-					      struct repository_format *fmt)
+					      struct repository_format *fmt,
+					      enum apply_repository_format_flags flags)
 {
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	struct strbuf err = STRBUF_INIT;
@@ -1794,7 +1807,7 @@ static void check_and_apply_repository_format(struct repository *repo,
 		fmt = &repo_fmt;
 
 	check_repository_format_gently(repo_get_git_dir(repo), fmt, NULL);
-	if (apply_repository_format(repo, fmt, &err) < 0)
+	if (apply_repository_format(repo, fmt, flags, &err) < 0)
 		die("%s", err.buf);
 	startup_info->have_repository = 1;
 
@@ -1874,15 +1887,9 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 	}
 
 	if (is_git_directory(".")) {
-		struct strvec to_free = STRVEC_INIT;
-
 		set_git_dir(repo, ".", 0);
-		repo->objects = odb_new(repo,
-					getenv_safe(&to_free, DB_ENVIRONMENT),
-					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
-		check_and_apply_repository_format(repo, NULL);
-
-		strvec_clear(&to_free);
+		check_and_apply_repository_format(repo, NULL,
+						  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
 		return path;
 	}
 
@@ -2034,8 +2041,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	    startup_info->have_repository ||
 	    /* GIT_DIR_EXPLICIT */
 	    getenv(GIT_DIR_ENVIRONMENT)) {
-		struct strvec to_free = STRVEC_INIT;
-
 		if (!repo->gitdir) {
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
@@ -2046,17 +2051,13 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
 
-			repo->objects = odb_new(repo,
-						getenv_safe(&to_free, DB_ENVIRONMENT),
-						getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
-			if (apply_repository_format(repo, &repo_fmt, &err) < 0)
+			if (apply_repository_format(repo, &repo_fmt,
+						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 				die("%s", err.buf);
 
 			clear_repository_format(&repo_fmt);
 			strbuf_release(&err);
 		}
-
-		strvec_clear(&to_free);
 	}
 	/*
 	 * Since precompose_string_if_needed() needs to look at
@@ -2805,7 +2806,6 @@ int init_db(struct repository *repo,
 	int exist_ok = flags & INIT_DB_EXIST_OK;
 	char *original_git_dir = real_pathdup(git_dir, 1);
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
-	struct strvec to_free = STRVEC_INIT;
 
 	if (real_git_dir) {
 		struct stat st;
@@ -2826,16 +2826,14 @@ int init_db(struct repository *repo,
 	}
 	startup_info->have_repository = 1;
 
-	repo->objects = odb_new(repo, getenv_safe(&to_free, DB_ENVIRONMENT),
-				getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
-
 	/*
 	 * Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_and_apply_repository_format(repo, &repo_fmt);
+	check_and_apply_repository_format(repo, &repo_fmt,
+					  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
 
 	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
@@ -2892,7 +2890,6 @@ int init_db(struct repository *repo,
 	}
 
 	clear_repository_format(&repo_fmt);
-	strvec_clear(&to_free);
 	free(original_git_dir);
 	return 0;
 }
diff --git a/setup.h b/setup.h
index 5ed92f53fa..821b55aca0 100644
--- a/setup.h
+++ b/setup.h
@@ -221,6 +221,15 @@ void clear_repository_format(struct repository_format *format);
 int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err);
 
+enum apply_repository_format_flags {
+	/*
+	 * Honor environment variables when applying the repository format to
+	 * the repository. For now, this only covers environment variables that
+	 * relate to the object database.
+	 */
+	APPLY_REPOSITORY_FORMAT_HONOR_ENV = (1 << 0),
+};
+
 /*
  * Apply the given repository format to the repo. This initializes extensions
  * and basic data structures required for normal operation. Returns 0 on
@@ -228,6 +237,7 @@ int verify_repository_format(const struct repository_format *format,
  */
 int apply_repository_format(struct repository *repo,
 			    const struct repository_format *format,
+			    enum apply_repository_format_flags flags,
 			    struct strbuf *err);
 
 const char *get_template_dir(const char *option_template);

-- 
2.54.0.771.g3ed373ac14.dirty

