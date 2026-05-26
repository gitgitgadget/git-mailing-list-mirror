Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272093C1976
	for <git@vger.kernel.org>; Tue, 26 May 2026 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775041; cv=none; b=SgQ1nbx6b24S7mqBbG3FCes5VOg++1Td5+XX8YqA4NVvpKFnGzKPdTLNSSq7+pzSkRTZ2CDVpps1SanyvPiMyCQO0FI1AHloBoG0G19ygZe3A/6bgiZj1v0Dh7eS9BWuMFHWgX2+qHfUK6TjIDp0GTcCz9mNhAi5uin3BXemVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775041; c=relaxed/simple;
	bh=CDbvr2ibRCNZFdhAU16vtEtOBFO0YaAxApiF9VThXek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NZWNrD0m4rHfhlW2+jugYZKwpjOTvl0oHr2Nk2KyR1T98G1KLwm6ovxl9JRYMOVH8yUFan85rQLiUzj01MfvdRO1etLtgvARVFoAS6JA06Y8HJoVWcNgGHj70L2BtlsLz4wypw2/5nOUg5psPK63gsM3lSkht05EWIfaoGAUbAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jSGrzRjr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gqWjmrL/; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jSGrzRjr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gqWjmrL/"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 803A97A0112;
	Tue, 26 May 2026 01:57:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 26 May 2026 01:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779775036;
	 x=1779861436; bh=64fAQ4FOAeFMeo3MBAzrJInYjtdGwr6QTmvIV4MQfAU=; b=
	jSGrzRjrN09xEyPRHKYNcEVI0r95BYduC2CHLbzBo1w8eo6JWr6zPJF5r09az1Vb
	zD3TIRoxxo29Ri+tzM9bldOGmTLy/N+FbCnuANbapvD+mue+DntzbqSEMocEG6/K
	fTpU+XcJczyzv7+N0QvQq4aAMgUxEGwIFRvvatlY78gyx0odYmOSyASAKwQE7twL
	xIqPMpiB5npVP5zPQVt2mgFiIOBw4foFcl3+KQMPq2PR3M8hsuMvBOGoOv9BJKIN
	5kaMqz2mIJArCiLBoc79E/H2bTHRkemhH+3pI1F5AvvexEy4SLdONHzHjvTm3Tyg
	EiuaOAmDbZhRIaKw+sDRmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779775036; x=
	1779861436; bh=64fAQ4FOAeFMeo3MBAzrJInYjtdGwr6QTmvIV4MQfAU=; b=g
	qWjmrL/pWzubjuVYXdLtMI7IFOTIRL1zn8K64HbPkQwG2lwSx3J4SsKEK2EHNW7M
	YEnX4lGPjS/iTvU7z2RsdTfPPPNv4DHvj9wqqG4tqZJOrytJMHm7VWr1dSp7x1PL
	miG+nRzGL6tVAF2z2k92SzHvLSmFhuMQ1jS/HSw0pZSLgHfCFabfSFN7BH1ED+D8
	Y+82eA/gdutX0A7nf52Xj6o7JDT3LLPhytXVch0RpIhVPzdob1hPYAq+ZhUwJWC3
	aO9BvUUY8AQbi/8ETP9In31mz+g25PB2pw32zDskgAxEwW6fgx5FFgeMu6Cwbi0w
	1pAqdJvjbJJlMomhsYlCg==
X-ME-Sender: <xms:PDYVamzx28LAC_D5QuV0qoBDQor-knIVN9EnBH_6Khle3AWLLf8PnQ>
    <xme:PDYVapvK7nvVBxBAPQmLjaEY2tFcV7A_nLi64V05yCa5Qp7E0S3Ml4P9x8PXBhih0
    WK_zqvy2s2RhJjnmhOSQOWGAOKxnaGiy4Sjgj_8afRKgT5ZZSUdMw>
X-ME-Received: <xmr:PDYValuOFbT4mvRjoRerLHIMPAe-4uHJd2OlMAilAABjLtR8MSXLTAl4_zFTPYxvMPlVw9w5i_iCyROc7-tSNPTSPSzpIgCzgSwAf_WijA>
X-ME-Proxy-Cause: dmFkZTENDWPlIMehrI0p5s3nwkhC94E3+Vziz2RDPzn8dE1M2zUbfRmFf4UZfcnyV6gcS+
    CxVZxxC3667h+nAhR6pqpNggMXlVeZYl4wzEaI+cHAj5vReVVsTehM35WU8cFIvMy7RAR2
    sq0fQV5df/lYICvHIopy1DHD/0D9dQZ+yGFyfl6DCWWUsVYBztrbDdiCcnBYzMAu7+IeCJ
    IjvSOmbtjdbu+S0zT14pNcqslKmSRNuzmYU57jfQ53GS85OjSTswjgKmMrEguMgZ2qBqI0
    mjGPmHfCy62a9sJdy7nxYZhhmNtd2tZhnvvTcAoLqkPtY+35gVYtxanNVk7O0FGv4PbDAp
    mAnaqpT9j6qv7+LI2jWFx//65ow7KyG5DaGMKQ888W03hFKdeCgTS7zhqYXyy3sgZuMR07
    lB3L0vyQZVxGV3MEeNkU8ZZKK4cOqZsNPWY1dWNMqJ/M6VONpv8TQRQ6DcUCUchMsBO3hu
    utDAVmU5G4s0t/vruP/6+oDZw08Mid3RyZ/FLN8Bnuk/D7cMYjJxHfQWfUU7VVT/GcqOMv
    MWrNFEmlWir8PyzIZQtiB6KqMNLi4n3YtjCyXSSB5E9c0GIz4zjnkZQwat2i2ya+Du9sNk
    W4Frn4WmJvSqGqWd6k20vwYJNZ/6IUlcg3xkTbFEApeGWNA3hsxV9ue9ku+g
X-ME-Proxy: <xmx:PDYVamPiwRmjUa-OzRLFHA32WRNVMKknPIZHuQpAu0WXUAJyfdZ71A>
    <xmx:PDYVar3RlyCBL9WuVzE7-cPtU2vgOd1maQq-zOk8JFBZ7eQyOcDqzw>
    <xmx:PDYVaqOc4ZFsoG4mwD3CGouySNi7sDQ7fRisB4VcyzdyPJxRf69trg>
    <xmx:PDYVaj0t4f2EL1R9m_K3fP77DeXk2rAmQDxBDXnyxib9rwAxz3zw3Q>
    <xmx:PDYVah2i4p6KIKLu1H45U4wCYiBuQKSzKQZDeHdSQcb39NYaeir3s7jj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 01:57:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 941f0598 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 May 2026 05:57:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 May 2026 07:57:00 +0200
Subject: [PATCH v2 5/8] setup: stop creating the object database in
 `setup_git_env()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-pks-setup-centralize-odb-creation-v2-5-2fa5b385c13e@pks.im>
References: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
In-Reply-To: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In the preceding commit we have stopped creating the object database in
`repo_set_gitdir()`. But the logic is still somewhat confusing as we
still end up creating it conditionally in `setup_git_dir()`, which is
called multiple times.

Drop the conditional logic and instead create the object database in all
places where we have discovered and configured a repository.

This leads to even more duplication than we already had in the preceding
commit, but an alert reader may notice that we now (almost) always call
`odb_new()` directly before having called `apply_repository_format()`.
The only exception to this is `setup_git_directory_gently()`, where we
also call the function when _not_ applying the repository format. This
will be fixed in the next commit, and once that's done we can then unify
creation of the object database into `apply_repository_format()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/setup.c b/setup.c
index 3bd3f6c592..0dc9fe4565 100644
--- a/setup.c
+++ b/setup.c
@@ -1035,8 +1035,7 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 }
 
 static void setup_git_env_internal(struct repository *repo,
-				   const char *git_dir,
-				   bool skip_initializing_odb)
+				   const char *git_dir)
 {
 	char *git_replace_ref_base;
 	const char *shallow_file;
@@ -1053,10 +1052,6 @@ static void setup_git_env_internal(struct repository *repo,
 	repo_set_gitdir(repo, git_dir, &args);
 	strvec_clear(&to_free);
 
-	if (!skip_initializing_odb)
-		repo->objects = odb_new(repo, getenv_safe(&to_free, DB_ENVIRONMENT),
-					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
-
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		disable_replace_refs();
 	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
@@ -1072,10 +1067,10 @@ static void setup_git_env_internal(struct repository *repo,
 		fetch_if_missing = 0;
 }
 
-static void set_git_dir_1(struct repository *repo, const char *path, bool skip_initializing_odb)
+static void set_git_dir_1(struct repository *repo, const char *path)
 {
 	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
-	setup_git_env_internal(repo, path, skip_initializing_odb);
+	setup_git_env_internal(repo, path);
 }
 
 static void update_relative_gitdir(const char *name UNUSED,
@@ -1089,7 +1084,7 @@ static void update_relative_gitdir(const char *name UNUSED,
 	trace_printf_key(&trace_setup_key,
 			 "setup: move $GIT_DIR to '%s'",
 			 path);
-	set_git_dir_1(repo, path, true);
+	set_git_dir_1(repo, path);
 	free(path);
 }
 
@@ -1102,7 +1097,7 @@ static void set_git_dir(struct repository *repo, const char *path, int make_real
 		path = realpath.buf;
 	}
 
-	set_git_dir_1(repo, path, false);
+	set_git_dir_1(repo, path);
 	if (!is_absolute_path(path))
 		chdir_notify_register(NULL, update_relative_gitdir, repo);
 
@@ -1879,8 +1874,15 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 	}
 
 	if (is_git_directory(".")) {
+		struct strvec to_free = STRVEC_INIT;
+
 		set_git_dir(repo, ".", 0);
+		repo->objects = odb_new(repo,
+					getenv_safe(&to_free, DB_ENVIRONMENT),
+					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
 		check_and_apply_repository_format(repo, NULL);
+
+		strvec_clear(&to_free);
 		return path;
 	}
 
@@ -2032,13 +2034,19 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	    startup_info->have_repository ||
 	    /* GIT_DIR_EXPLICIT */
 	    getenv(GIT_DIR_ENVIRONMENT)) {
+		struct strvec to_free = STRVEC_INIT;
+
 		if (!repo->gitdir) {
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
-			setup_git_env_internal(repo, gitdir, false);
+			setup_git_env_internal(repo, gitdir);
 		}
 
+		repo->objects = odb_new(repo,
+					getenv_safe(&to_free, DB_ENVIRONMENT),
+					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
+
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
 
@@ -2048,6 +2056,8 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			clear_repository_format(&repo_fmt);
 			strbuf_release(&err);
 		}
+
+		strvec_clear(&to_free);
 	}
 	/*
 	 * Since precompose_string_if_needed() needs to look at
@@ -2796,6 +2806,7 @@ int init_db(struct repository *repo,
 	int exist_ok = flags & INIT_DB_EXIST_OK;
 	char *original_git_dir = real_pathdup(git_dir, 1);
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	struct strvec to_free = STRVEC_INIT;
 
 	if (real_git_dir) {
 		struct stat st;
@@ -2816,6 +2827,9 @@ int init_db(struct repository *repo,
 	}
 	startup_info->have_repository = 1;
 
+	repo->objects = odb_new(repo, getenv_safe(&to_free, DB_ENVIRONMENT),
+				getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
+
 	/*
 	 * Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
@@ -2879,6 +2893,7 @@ int init_db(struct repository *repo,
 	}
 
 	clear_repository_format(&repo_fmt);
+	strvec_clear(&to_free);
 	free(original_git_dir);
 	return 0;
 }

-- 
2.54.0.926.g75ba10bac6.dirty

