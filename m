Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239463A255F
	for <git@vger.kernel.org>; Thu, 21 May 2026 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349371; cv=none; b=auPn+qqQyRYpckVw8vAhpPqzmGNm9JPmSNfB++YKokhbnfH4xiR05xLtn85xy3CEKKGjM8yFEb2kbLUxp3L5z3knaAwRcDwAwLpuawvuxtnjqrvz6MhXSPkbk4S8RklxPSOJrwsV/4/miQCzoy3VccSx0eX+1hbJT+XWB1Qk3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349371; c=relaxed/simple;
	bh=pjICnQn1H4TKN1RiD9DhswHLjrMvtCoAX9vAAMbaCQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGxv3NwsUjdju3ttumx2D0Ea5ZRyVpSl9iv3ZNN1hsFCV+XZZpf4TR7ibfqieRH+NpRoq+4dsvaeq27IFGjHS40mUEYEp60ethQcwZ1N8+L217GcPtOKrSkyAFzHQ5ObSWiG5S7eiVx/H4uMvXRvl3pSiIQzauWol/qmSLEHa1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BU2inhK6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJUSpgE1; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BU2inhK6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJUSpgE1"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B8B7140006C
	for <git@vger.kernel.org>; Thu, 21 May 2026 03:42:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 21 May 2026 03:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779349369;
	 x=1779435769; bh=Clp37CFXYxOHTJsAOKNpQdnoiqOUNp8oIc8ZT72BdGM=; b=
	BU2inhK6KB3hShQZe43jkEwS0bcNlP8r7rnKEna7SRFbOYicQgkXkrK0cQa0Tay1
	B/SsnPDtHlCHdcbCVQxk64jkQRk7hEUl7NCzwCqM5xv75FZlEJpB3/fVlBzqpKF4
	02TcjXma7r7VXYxLZgLz7bQ7BoE5VOU4VpW9AMBwZcq2t1Uaw5I+DVgPSVa7fyny
	yWU7bxeWipPoElW3iJfEhnM+lvH/8H2uJ/OV8c9ULHOpLHg/lr4RJzmIM5H+belV
	PdBe4dB6+t4d4qyTU1IfilbZRo0pxDvUnRxztrgCopKWjgQTJCXjTUzG9a1+JEC5
	9YK6urYhysaRu2JcK90HIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779349369; x=
	1779435769; bh=Clp37CFXYxOHTJsAOKNpQdnoiqOUNp8oIc8ZT72BdGM=; b=Z
	JUSpgE1SnHJn0SDH5yLZsgYnUvN6uxUaUWOldxDxHTq/jBIT8rOVBujB3DUgD4Rr
	ZPz3f5asddrxAgM/Shz7P4Dw53maYdhm/MYoU58zIcsQ31DdB0J/ZRH0dccl1qEr
	KJss8F8ELIAdAxkTkSf29LmZ6WxSUO3Bgf6EsLhybYHpynOb7puZMsuqYQCOO5Uk
	vmKLNsWknbll2GAvuT1epcwtQUGQUFQ4ythNnKtplCKZrdCDIQVo+kVr8QD8mMYq
	zW0EzyssIKFNLvGdMrh03/U0WVqlLUpzHRqfckO6zF3Hcyv2TtT6kpMAsxShErHw
	9Gk54rveKCs5QvQ4fUyCA==
X-ME-Sender: <xms:ebcOalOvgMSdG6TTTBh3D4i5vq8dfM3UN0cUpbzN-5jRvXbqijEG6Q>
    <xme:ebcOau5Mc4lQez_O0_1FY34E7JihQVQyfiPq-qYaLGtmPRmlaMjRFDDhwuvmKkJFf
    WW2XUNsKCL9dNQBEnTIK_QkONcd-qYzQiHfUqA0HzrAAWxxFRc2r3g>
X-ME-Received: <xmr:ebcOap4AwOig02QBZsHsmUH21W4Dn5YV59fVyXavRKrjKkFRaHyliJXF-tdc9_EBDJwf-rz7OKFUS82haJW-tm1dqxiZZoyZ6Mt48mg80xs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:ebcOam24a5g9OJdwqNr9Ukk_EzdQsRxLt2MdcydN34EA4kyOvoYXPA>
    <xmx:ebcOatVpMNmHG0ineMBXt_98QFhKYgydj1yow570lcNi3G4I9ya2Kw>
    <xmx:ebcOap5auQB48A8vxrOjcsU3aRjfMLWL-r-xAv218foUss8ZUgoPIw>
    <xmx:ebcOasKS_HL-fa5-6OdzY7A9GGd1I7IkfzNhtQ2Eb4Q5tbhNJAOgzQ>
    <xmx:ebcOah_9Il6q29MBWm1uftsTrxZA0FOo4KR-4vcAPRDrQJGY4g4Elo9C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 03:42:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id affd8bab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 07:42:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 09:42:32 +0200
Subject: [PATCH 5/8] setup: stop creating the object database in
 `setup_git_env()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-setup-centralize-odb-creation-v1-5-f130d2a7e8ae@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
In-Reply-To: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.54.0.771.g3ed373ac14.dirty

