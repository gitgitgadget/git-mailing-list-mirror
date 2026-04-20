Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC9383C70
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673423; cv=none; b=WZSdEgq6k1fU41JzQveTaAnm9wxBBjxYD0uE1Rdx9pYlVQGEG2C76GhMZo8tQwNvpMqMlPixYMb9VJdHFTTOjB7C/c1m6u43Zqr+WCAu4iUrZSWqKmeJOitYG7j5MBf69Nl0t3LpTve9HxqJh1CtiviBTum8D7EIk2KwB57DvHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673423; c=relaxed/simple;
	bh=mkBl1/udBqXzq7wnI84eAdpFq4BDRMYATzJ7NsWJ7Jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G+c3ayswOkGGrAQjUZ00hAWIxI/gNh5pIkg1NcLc430sQnlDduXQRU0bG5dt3cT3Xkrc4qPu5Zt2mv3Y+gp30rWV08YB7Gn9wBEPsLJBwy1m8vYiliUqw1icA5lpa0ZpNiT+7TJfzwKONOby5HKptJxZX1o02Y7IgRH3oIETJiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vVWYY/+h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FQMXHXFA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vVWYY/+h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FQMXHXFA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E1AFC1400123;
	Mon, 20 Apr 2026 04:23:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 20 Apr 2026 04:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776673421;
	 x=1776759821; bh=GHOQCa8VsTdUBKj9Xnqh7KQDmTJVaG6fUZmUzgk16pk=; b=
	vVWYY/+h0ElXtbBR00QXHfEjrpRCTaJ1sTA5cn8z6Rxupc976n0n5Nrapp/oY9fa
	5wcjo8OzqewCHgOVHY/oL2k0kSNH0nAuzG9Ot7htsBfqXEF22frQYJnmbMTar8fl
	I/0T7XXvycZ8v/VmAigp0Yd3ar2kd0dnVODy10ZsfNCJpkLfyKYINOtIBOrsvLB8
	za4Aiapi2T0oBMO7hMCa7gGD/2iSDfnSXFQ8JXE2rMzLW8WH8qibnBFrlj6nJc9o
	+Y7MBOs3tvTh8dvo4HdVUPeBNJW/rafSesiYqZjm7SGYahNyvrMQNcVMdcOpmOx4
	CfWXB90ruOGWksOECkDdUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776673421; x=
	1776759821; bh=GHOQCa8VsTdUBKj9Xnqh7KQDmTJVaG6fUZmUzgk16pk=; b=F
	QMXHXFAA0DkYcETUsuEuoLOOD1tD+6px+759ZOCNBNsxEWXyNt0cua4gcFn5pgf9
	dNbpi0/bQrjoshHO7VdMDkuFg2RsWgPsINpa/w3oL/Q/ZZz4nizvSadSzqPCsCkb
	Z0ZGNDoESa9t5KzqNDjjCS098UUJhTmNmFhla2vYSyA31rYkvHOwenScqot4GrsT
	LRGVPlE+00tzPkcSmA7NIlsDhkXSfbOKIjNn0e/1CKWknWIoFSpU5bTqeQ9QmD+D
	VFI5Fa5BXdrJzCoG9aDGvdTyIWvQ5q3LnilZLaDBa9y8xNvw9TdeZHn82F67sKd/
	+bifkojmqIAWw6ujVS2VA==
X-ME-Sender: <xms:jeLlacPjdwpvGu9odF03i_I50jP6iaeeWXFsqSE4ZNy5v89pk8Stmg>
    <xme:jeLlaZ_sn6C-sRiE4Eq5nw6-zwn9IK1mV6Wg1JjsRNPbPaTjKn-iZ8MZ8sYMmMtN9
    ycNLdhkNWgK7hOe6Be5-xPvFm83QIosAGScavc3LE56Kb7oaJ5YxQ>
X-ME-Received: <xmr:jeLlaYSnLIXvNpkjJzz5wVnz7wahDhE0DP6N9WSXVQPtbQQ8L9zbGv-ppZLo8NfDK9EMvt31LKWY2z5o3vuV05I6OsbcAmuKaudO_PoejmwP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:jeLlaTn5U5G1nfkGcwOSUERbKbXPlNUL-Uejy49LGHO11CnZa5eGxA>
    <xmx:jeLlaQSJdy4K2ZBYU_rfIZIRhWI4rT8fB3lgJFm2YYH2GJjTIwUKPA>
    <xmx:jeLlaZM8RURmLFzp1kGe-PyvXj38_ZjSykPV-tqVwssmHCYYnHWEuw>
    <xmx:jeLlaRXwVR-ET58352tf2a9kmaP5RxSscct2QdqVkTP7tIM0lNmuXw>
    <xmx:jeLlabzaVnVQInJ-GKd-nt_iTM2u9u5aU0duLNCiG-quRAyhX8khTK3u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:23:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc0a4f0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:23:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 10:22:48 +0200
Subject: [PATCH 18/18] setup: stop using `the_repository` in `init_db()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-pks-setup-wo-the-repository-v1-18-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

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
index 8616f5e619..1847111616 100644
--- a/setup.c
+++ b/setup.c
@@ -2769,7 +2769,8 @@ static void repository_format_configure(struct repository *repo,
 				    repo_fmt->ref_storage_payload);
 }
 
-int init_db(const char *git_dir, const char *real_git_dir,
+int init_db(struct repository *repo,
+	    const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash,
 	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch,
@@ -2789,13 +2790,13 @@ int init_db(const char *git_dir, const char *real_git_dir,
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
 
@@ -2805,27 +2806,27 @@ int init_db(const char *git_dir, const char *real_git_dir,
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
@@ -2833,29 +2834,29 @@ int init_db(const char *git_dir, const char *real_git_dir,
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
2.54.0.rc2.529.gd9106f7525.dirty

