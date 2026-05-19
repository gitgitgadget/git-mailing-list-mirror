Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48372481238
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184381; cv=none; b=UCDDLZQwnAnmKbriLdmdXk2ykYC7pC2C29Qy6WtUNOKvN1ZNRBhvZmTZTx/GzfJbk4drnKifqGUDNvgDpoYU520c/7RnpTto4C+EYnn8EPPMFQkPvKGuQ45s7pRLM1T4RQ9+zGmNTtV6amOCVBprKpvJkVr15DM6u7nKxN9Qvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184381; c=relaxed/simple;
	bh=MCNpuyvkUSgyKqegzvQLwEiis2HkJHvIdrzIWqC3Cus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SzwCEBxSovnQ71FHZgIUB9h3YxOJGTnEJWSVwoh2abs3NLO3z+C1Xb03ki/SEZkzDKzTbxSOhDj27xttemL7q9XzG2hFeKHOQMdbZoTQC9QpdjtoFbG1uUARoX5r+XVbFa+1x2sSoe/fJE6s5ZSN61MsCDWe6PpnoxuUI4zw7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GVZ0qL7E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IyB5nWnu; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GVZ0qL7E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IyB5nWnu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9816E7A0052;
	Tue, 19 May 2026 05:52:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 19 May 2026 05:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184379;
	 x=1779270779; bh=Fz0/yM4BuD0pqSv5J+mgrPbvhq2FtZKxxIFPYZMC77M=; b=
	GVZ0qL7EyH8b/BLiLDsLaBuWqrK5METdmLlKOvTIL6OTpaNcSalpjE+9skwgeYpF
	5dvFczBMMr8nRBfPzb++QGilmL14qeSUAIMWPxhdwTOgDxC9AY+66fU/QLUzOtS1
	3DHHiZ0jXmf0HAgi9gvOBfHaN6BBg27tMZZblMHBvIMx3iwTd318AN4WwBOYUIiQ
	vKqChR9al1VQi5t/XG0hL/0y2ZH72nbd+xp48V7zvSYoRQmOEvKrTA0BNUw9vXQb
	JxYi0HLWVSg6ROvBwKKNLQpXt8zWZgjNsxRquqdzxoflgqY+nL+KIqsl9654wjD+
	v3hSSME9H6yRDoQsKUa0Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184379; x=
	1779270779; bh=Fz0/yM4BuD0pqSv5J+mgrPbvhq2FtZKxxIFPYZMC77M=; b=I
	yB5nWnuqsKKMTmr31Nrr3Uk1w7hrT7aNkRXm+NMdji8RXZNedLajiilMnfxFcfJD
	GlvOaT/sQBBoLxZh7kmXAdfu2yywV84r250WPaFwWzocvE+dpiXPvkSLsB4x/595
	r98flHu4F7eAnFECTK/iXx48tvGjQg6wNw5MiZxEBoz2O2GhN7gjEKxYaIKa71Bx
	zpXGQhaeVNR+TBkGWYY/X07TCzn5YABUoWS14XMvcPqAZH70Y/U+diHQmnCb+N90
	4B8/AigjU2WxUTLZbXTMiY1nJQG7E/RMuSi3hVT6eF5umVp+rZXTlHUKAVyQ9MOs
	xiBCrgYLUwCxPLgscFVBg==
X-ME-Sender: <xms:-zIMahz06VD0KrUajwW9B5surB-xMHAKBmNcU1yPwiY0zlNyN-2m9A>
    <xme:-zIMaoL-6hHZjqg8tCxZNVQQJG-MYxtjWM05geHjO84uqHdsqqC1Wo8dTDw_-4n-N
    s7ebCCcToT1sP9qQbxpfsl6jjPmjd4RiDMY4y6V8C-Jmjrh6Oft>
X-ME-Received: <xmr:-zIMajq8ocCXBlOFEUGnJa-yHYvUSnaQYEYJpjM0LRKA_H8WBUyQILkKa4vc3cAVheYbn7alc03nbvimOB9N68HhL1-MJzIDYyfz9xTe0xM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-zIMavJqEqv7lOHZDtauuVvvleWPzMbO3DSVCH-inzLo9fkfAZXdGg>
    <xmx:-zIMagSyGgsIy2I2guxfdmI4WkcQ4YEpaBOBjY0JuJ4RIDgvjT7tpQ>
    <xmx:-zIMamu9-U0_nx89H2ZGOgdG5FYayOzWWGLF2C3fbzv92orVthGoNg>
    <xmx:-zIMapYQYVIkjUKzHkps2Icawzp9ZEY6gwpmVyQePE6Vi3GSV7ywZQ>
    <xmx:-zIManbZ9QuBA8wcD0KtpcVvjzkTSg6JLWP9VGRNCS4EGpHh30ORySEP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d674353c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 May 2026 11:52:22 +0200
Subject: [PATCH v3 18/18] setup: stop using `the_repository` in `init_db()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-pks-setup-wo-the-repository-v3-18-a00d8ea8b07f@pks.im>
References: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

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
index 53a41629e6..d60d1b60bc 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1186,7 +1186,7 @@ int cmd_clone(int argc,
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
index 9c49319568..6aee839d8c 100644
--- a/setup.c
+++ b/setup.c
@@ -2778,7 +2778,8 @@ static void repository_format_configure(struct repository *repo,
 				    repo_fmt->ref_storage_payload);
 }
 
-int init_db(const char *git_dir, const char *real_git_dir,
+int init_db(struct repository *repo,
+	    const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash,
 	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch,
@@ -2798,13 +2799,13 @@ int init_db(const char *git_dir, const char *real_git_dir,
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
 
@@ -2814,27 +2815,27 @@ int init_db(const char *git_dir, const char *real_git_dir,
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
@@ -2842,29 +2843,29 @@ int init_db(const char *git_dir, const char *real_git_dir,
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
2.54.0.771.g3ed373ac14.dirty

