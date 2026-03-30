Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB59E2248A3
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876714; cv=none; b=htbyQMBWLxf/AxDwUNZhH3b2BITccQhH4E/MQVFMxeoI5j6Op3mK1yyQ1Ul600P2wEnr4Ys1xtOYJh0Clp8Wa8Qx6ogwwRF4fnLFKrYJ3j5OgG7XmJl6Cuaoumb2IvnJdFxxdFFLTib07qFCeo79s4fRbGLVSXwdv/kILuBBleU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876714; c=relaxed/simple;
	bh=TyR62wFrNqOAo8j+LRKBCC5wzymXHt6gF5Vq7pdbMsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mEe9fHFlAB0pdJRtnQeQ9XFw/wMZM4dPojm8TZIxOGj2tBtmKD7covH39rNErzK3txlC3MB2J59L3/Qin1D7fa2o1fK1uR4EpxK5WOpAHkTb6gkzWVG7Dj7+p1fHyhbaYU3bgfvqtEHNqzUwQe8Xrdjj6971xMSgfAEmDihD5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ow4vb4LA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fuVya71H; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ow4vb4LA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fuVya71H"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 57D611D00190
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 30 Mar 2026 09:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876712;
	 x=1774963112; bh=+9FMdvnt9r2A7fKivaNIc0ttZCn/XHtIwC5pd969zrM=; b=
	ow4vb4LAvBFOLWlqnZUSaoRXe/qL7sYK7PCpOt6mMiHVV56XoECbgOuBEUBV0yAB
	DWYC1I8i1Q9oUNLBsvw8xjSbu7wr9Dvn8Dgdi+E58YC7xucFEDAIURF8JFyB6gS7
	YgV/Hg3B0yeX7Lo4eQFOboYU722G5dETaag48OiWLtK+Hs/5g6xVNR1rRUf349re
	Fq6FyUe5ntz5WZfKSt+fCtukPUO6aqhqX2X5MKRz+Hvy2VykZIwcRZFgSNyKos9d
	KssbAngfD9KYpUl8Xmt74qDWa/DY+WuoYeUSCfRg6BTKB8ZtYeD+IPPjHL+NLBsK
	1iVaoOSalX8MyubgMKFCNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876712; x=
	1774963112; bh=+9FMdvnt9r2A7fKivaNIc0ttZCn/XHtIwC5pd969zrM=; b=f
	uVya71H+hGrh3NICADoYQj9idPRSav1p2ocRjiNN+xFvn7zNa+lxGclK78c5EGix
	3ICQCCOn492lmlQDdIckU4IWJyx8ak3XhQM9+cfATXx/hhhLxduh7T5KrMYrt7oi
	Eg/69DZI17QP6ZRUeRTMvXV1iPJWz+fLw7L4sM7v0V/tC2ClLo8SUcpFz2Ky0Ssu
	TYZg+TlDxWMvhsiz82Jt1b8Hwa900ui3dav5dDEfQA2C3DaAm6dTYkfhm2MSz3Iu
	kajONPxV+pOWMqmBqsP5lFPyp9AIc+Z4EoJf+/2cakj/1zFettp+E/X+RB7WXVfo
	xHUXV5CByqASZ6BeU7Zkg==
X-ME-Sender: <xms:KHjKaWBBKJPCk7bYSltuvWEIVRME66JKZX_HLa16Fs5a9BhjTKGeQw>
    <xme:KHjKaXcqAP4re4EiGCVTgTGXzQFGSQch2UvaJhVF3dE964Oiar6QuIStV3itiU6-Y
    txe-LmovZy3bZ6T9ZlK2ob-t4WbrJ3NZ5_BEuaBHTbCgcdJJIQ0>
X-ME-Received: <xmr:KHjKafNpDyDkfN6ViYCRzCcl897XKva4Fbs-_U-9w_uPX5Pgir4D7_E2K1V31kVao4-leJ42CFJ7o6HcGbuviz902rAJZFjLvppQsA_99DEf0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:KHjKaZ7vOU6udJ1nr3BtAYKhVLX_dIjW_2HiB1UqcfVY-0uceKGFKA>
    <xmx:KHjKabLvv-YtlGKzkalw-aapWNYGItRW6_jICMgEphPSRBClvlVl0A>
    <xmx:KHjKabfn1cbFHkv8xyFJm5Fkjs_nvUGPhj2vFgzhTZJZ4Olr2Tf9oA>
    <xmx:KHjKaWcc9TQChInwb9uNVFFJYjQYQMlv7ncYMC-JSnEvIP4Ex5yl5g>
    <xmx:KHjKaZBiIYavb6cJntLPpRlLjELpcQjN-Y6TttyEnKc3PfS0RWwkWga6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ebd56cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:18:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:40 +0200
Subject: [PATCH 18/18] setup: stop using `the_repository` in `init_db()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-18-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Stop using `the_repository` in `init_db()` and instead accept
the repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c   |  2 +-
 builtin/init-db.c |  2 +-
 setup.c           | 43 ++++++++++++++++++++++---------------------
 setup.h           |  3 ++-
 4 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d864022214..bc35a3c0b1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1184,7 +1184,7 @@ int cmd_clone(int argc,
 	 * repository, and reference backends may persist that information into
 	 * their on-disk data structures.
 	 */
-	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
+	init_db(the_repository, git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
 		ref_storage_format, NULL,
 		do_not_override_repo_unix_permissions, INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
 
diff --git a/builtin/init-db.c b/builtin/init-db.c
index e626b0d8b7..c55517ad94 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -252,7 +252,7 @@ int cmd_init_db(int argc,
 	}
 
 	flags |= INIT_DB_EXIST_OK;
-	ret = init_db(git_dir, real_git_dir, template_dir, hash_algo,
+	ret = init_db(the_repository, git_dir, real_git_dir, template_dir, hash_algo,
 		      ref_storage_format, initial_branch,
 		      init_shared_repository, flags);
 
diff --git a/setup.c b/setup.c
index efac2dd7b5..67bede8b9d 100644
--- a/setup.c
+++ b/setup.c
@@ -2775,7 +2775,8 @@ static void repository_format_configure(struct repository *repo,
 				    repo_fmt->ref_storage_payload);
 }
 
-int init_db(const char *git_dir, const char *real_git_dir,
+int init_db(struct repository *repo,
+	    const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash,
 	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch,
@@ -2795,13 +2796,13 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		if (!exist_ok && !stat(real_git_dir, &st))
 			die(_("%s already exists"), real_git_dir);
 
-		set_git_dir(the_repository, real_git_dir, 1);
-		git_dir = repo_get_git_dir(the_repository);
+		set_git_dir(repo, real_git_dir, 1);
+		git_dir = repo_get_git_dir(repo);
 		separate_git_dir(git_dir, original_git_dir);
 	}
 	else {
-		set_git_dir(the_repository, git_dir, 1);
-		git_dir = repo_get_git_dir(the_repository);
+		set_git_dir(repo, git_dir, 1);
+		git_dir = repo_get_git_dir(repo);
 	}
 	startup_info->have_repository = 1;
 
@@ -2811,27 +2812,27 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_repository_format(the_repository, &repo_fmt);
+	check_repository_format(repo, &repo_fmt);
 
-	repository_format_configure(the_repository, &repo_fmt, hash, ref_storage_format);
+	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
 	/*
 	 * Ensure `core.hidedotfiles` is processed. This must happen after we
 	 * have set up the repository format such that we can evaluate
 	 * includeIf conditions correctly in the case of re-initialization.
 	 */
-	repo_config(the_repository, git_default_core_config, NULL);
+	repo_config(repo, git_default_core_config, NULL);
 
-	safe_create_dir(the_repository, git_dir, 0);
+	safe_create_dir(repo, git_dir, 0);
 
-	reinit = create_default_files(the_repository, template_dir, original_git_dir,
+	reinit = create_default_files(repo, template_dir, original_git_dir,
 				      &repo_fmt, init_shared_repository);
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
-		create_reference_database(the_repository, initial_branch, flags & INIT_DB_QUIET);
-	create_object_directory(the_repository);
+		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
+	create_object_directory(repo);
 
-	if (repo_settings_get_shared_repository(the_repository)) {
+	if (repo_settings_get_shared_repository(repo)) {
 		char buf[10];
 		/* We do not spell "group" and such, so that
 		 * the configuration can be read by older version
@@ -2839,29 +2840,29 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		 * and compatibility values for PERM_GROUP and
 		 * PERM_EVERYBODY.
 		 */
-		if (repo_settings_get_shared_repository(the_repository) < 0)
+		if (repo_settings_get_shared_repository(repo) < 0)
 			/* force to the mode value */
-			xsnprintf(buf, sizeof(buf), "0%o", -repo_settings_get_shared_repository(the_repository));
-		else if (repo_settings_get_shared_repository(the_repository) == PERM_GROUP)
+			xsnprintf(buf, sizeof(buf), "0%o", -repo_settings_get_shared_repository(repo));
+		else if (repo_settings_get_shared_repository(repo) == PERM_GROUP)
 			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_GROUP);
-		else if (repo_settings_get_shared_repository(the_repository) == PERM_EVERYBODY)
+		else if (repo_settings_get_shared_repository(repo) == PERM_EVERYBODY)
 			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_EVERYBODY);
 		else
 			BUG("invalid value for shared_repository");
-		repo_config_set(the_repository, "core.sharedrepository", buf);
-		repo_config_set(the_repository, "receive.denyNonFastforwards", "true");
+		repo_config_set(repo, "core.sharedrepository", buf);
+		repo_config_set(repo, "receive.denyNonFastforwards", "true");
 	}
 
 	if (!(flags & INIT_DB_QUIET)) {
 		int len = strlen(git_dir);
 
 		if (reinit)
-			printf(repo_settings_get_shared_repository(the_repository)
+			printf(repo_settings_get_shared_repository(repo)
 			       ? _("Reinitialized existing shared Git repository in %s%s\n")
 			       : _("Reinitialized existing Git repository in %s%s\n"),
 			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
 		else
-			printf(repo_settings_get_shared_repository(the_repository)
+			printf(repo_settings_get_shared_repository(repo)
 			       ? _("Initialized empty shared Git repository in %s%s\n")
 			       : _("Initialized empty Git repository in %s%s\n"),
 			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
diff --git a/setup.h b/setup.h
index 21737e9bd6..9409326fe4 100644
--- a/setup.h
+++ b/setup.h
@@ -227,7 +227,8 @@ const char *get_template_dir(const char *option_template);
 #define INIT_DB_EXIST_OK   (1 << 1)
 #define INIT_DB_SKIP_REFDB (1 << 2)
 
-int init_db(const char *git_dir, const char *real_git_dir,
+int init_db(struct repository *repo,
+	    const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash_algo,
 	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch, int init_shared_repository,

-- 
2.53.0.1185.g05d4b7b318.dirty

