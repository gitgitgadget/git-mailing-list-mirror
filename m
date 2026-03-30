Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FDB23AE62
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876672; cv=none; b=qyCF4oo9hwBRCDC/xxJOAoLk1KE+RDK/YhC68rlVjD8cWyqHyUkEpabOrLQbZNgPhMqnG7J56VlZSGlQABbVh9LqQTULdbWnAw3ZcvOW6aDuFXO0eUTaDsnyHrbvEkzntKLBF+3OrNR+vKYOknuXmg7pN7YAQqrfrkf9hqQZDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876672; c=relaxed/simple;
	bh=4uEwPl/C2mcGx28wb6jJjbPUQn+e0eFQX7xWDXz5Oe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBPbrJHa7Y9xfpePvT4bDUx/d7cFt+YROCJUsS619l1v4tBdvvOKKVeqEC65L3MzRwfXEFmc5vn60/Ibmqh37peXWXydqjS4YXE4hsF8UyfIBLspedw49Het3eM3ONMAkao7arBhIXHN/wfU7w0DoegNZ6gsuskVrLDB8TQea4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GRgkegFs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJZmGmOB; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GRgkegFs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJZmGmOB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E2C2D7A0060
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:17:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 30 Mar 2026 09:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876670;
	 x=1774963070; bh=OnLofRHgnfQCRIeb5Zd3eMCxaCUhKcElT8FDN55599U=; b=
	GRgkegFslOTAt/EhXl4DAdMqa6C78RyP+sanOWlZnWC3gFzMQh2YfQ+adso0Ubgu
	6WSTYcK+p6qCwPnTFHv4Iki6BncS8VUGFSMAKFemPgnHoxBZU1+nzMCYrg6aXe4H
	fKO+k2ZvSxmafPPP/j/UeGVwvT8wd88bmuL5eWvXBcJ/F5nkPPlwme72ZtfZckEX
	vyXRXOymMc7amj2n4I+g80KlfAHZWp7KUoK/BUfFwFosJKIY7osxrJOwOAXBqJZ3
	vq2iJGoaGtfuf20PJV5vfaBHmug6QtHo/pRXGgcrxB38SsB4tX3WVmJeCLo4LtxU
	3+ZGg6NUxWDIQToaZzuKzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876670; x=
	1774963070; bh=OnLofRHgnfQCRIeb5Zd3eMCxaCUhKcElT8FDN55599U=; b=X
	JZmGmOBrDvg/YDz2KwGOf9cD8IT93ZxtoBGJtIhq3/YokS5MVZlN/bk3ZsliSf45
	cM1fnspmp5xMQwiOFONFSmKdnT2G0ASuKyZaaAup1kjf/I4iGD12ehJpdIFcazZE
	tgdTnoUT/KCWMVgfb/B0zPS++Ktz+lJE/gHNU4xlhi7vCfeLf4GGrN75ARFTQNw8
	NoPCFuP7kOZklt+OUqkyLxPz/UPJ5fRmNmGGBglU7M+0VY0BLecEmkl39C/Ea8of
	XBGG489b1NXsMT0xdkq37WfrxbjlP6PTtlzDcLgxQgVuQxnOBodhR2r0AbgcpiyB
	E1hH2K3FOWirIJ5WQAgtQ==
X-ME-Sender: <xms:_nfKaaB6aU2gVcH1PH6Dk0oIXxRT0pQrzpAfs50w45WakK2nMrFFag>
    <xme:_nfKabcKNSywvXS2TMQgrrX50AQ2W2X36EmxtjmIYr7Nq0f04u0BkwRIeX96BuDhp
    YY42oZPkn0g5NlQKEipm9j9QySH3mGxU6PMKjNOnx6ms5ZnRrBJ6Q>
X-ME-Received: <xmr:_nfKaTNlDInmO-kelLGSSeR6XlfosXZ6kkq_Bl6cxP3zk88mBDS_VLzlp-xmHv_BG-_EqLlCt5OuF-ttRqyhm6siB0xwgxgGRWya5e9utdcwcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:_nfKad5prGqHQuRPq8CyMhFwucWRviZ3PzyGIFzMcJCX71jEa5XcBA>
    <xmx:_nfKafJ8UxDbXkasK8EhTRyzpUopnmXk_wN7h6Ci-wG_NQ7Y2VeKWw>
    <xmx:_nfKafeLkMI4zqwXz_cJoHfC9tzIrkdzhn3gsnYjS7gTeKEXUmr7Ew>
    <xmx:_nfKaaeL_v24Ggpbdr1i4cYnqpORplVzuFUSqkyQr54-GXGyJVUx8Q>
    <xmx:_nfKadDsJgm3XOOcc9JS90i03TyMMW9XtpkPgEQvqqwed9eGmKMBz_i2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:17:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d933197 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:17:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:24 +0200
Subject: [PATCH 02/18] setup: stop using `the_repository` in
 `is_inside_worktree()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-2-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

The function `is_inside_worktree()` verifies whether or not the current
working directory is located inside the worktree of `the_repository`.
This is done by taking the worktree path and verifying that it's a
prefix of the current working directory.

This information is cached so that we don't have to re-do this change
multiple times. Furthermore, we proactively set the value in multiple
locations so that we don't even have to perform the check when we have
discovered the repository.

While we could simply move the caching variable into the repository, the
current layout doesn't really feel sensible in the first place:

  - It can easily lead to false positives or negatives if at any point
    in time we may switch the current working directory.

  - We don't call the function in a hot loop, and neither is it overly
    expensive to compute.

Drop the caching infrastructure and instead compute the property ad-hoc
via an injected repository.

Note that there is one small gotcha: we sometimes may end up with
relative directory paths, and if so `is_inside_dir()` might fail. This
wasn't an issue before because of how we proactively set the cached
value during repository discovery. Now that we stop doing that it
becomes a problem though, but it is worked around by resolving the
repository directory via `realpath()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/ls-files.c  |  2 +-
 builtin/rev-parse.c |  4 ++--
 object-name.c       |  2 +-
 setup.c             | 18 +++++++-----------
 setup.h             |  2 +-
 submodule.c         |  2 +-
 6 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b148607f7a..09d95111b3 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -703,7 +703,7 @@ int cmd_ls_files(int argc,
 	if (dir.exclude_per_dir)
 		exc_given = 1;
 
-	if (require_work_tree && !is_inside_work_tree())
+	if (require_work_tree && !is_inside_work_tree(repo))
 		setup_work_tree();
 
 	if (recurse_submodules &&
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 01a62800e8..9629e1ccf7 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1006,7 +1006,7 @@ int cmd_rev_parse(int argc,
 			}
 			if (!strcmp(arg, "--show-cdup")) {
 				const char *pfx = prefix;
-				if (!is_inside_work_tree()) {
+				if (!is_inside_work_tree(the_repository)) {
 					const char *work_tree =
 						repo_get_work_tree(the_repository);
 					if (work_tree)
@@ -1068,7 +1068,7 @@ int cmd_rev_parse(int argc,
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-work-tree")) {
-				printf("%s\n", is_inside_work_tree() ? "true"
+				printf("%s\n", is_inside_work_tree(the_repository) ? "true"
 						: "false");
 				continue;
 			}
diff --git a/object-name.c b/object-name.c
index e5adec4c9d..7b7e546b1f 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1990,7 +1990,7 @@ static char *resolve_relative_path(struct repository *r, const char *rel)
 	if (!starts_with(rel, "./") && !starts_with(rel, "../"))
 		return NULL;
 
-	if (r != the_repository || !is_inside_work_tree())
+	if (r != the_repository || !is_inside_work_tree(the_repository))
 		die(_("relative path syntax can't be used outside working tree"));
 
 	/* die() inside prefix_path() if resolved path is outside worktree */
diff --git a/setup.c b/setup.c
index ba2898473a..4df65ba2e8 100644
--- a/setup.c
+++ b/setup.c
@@ -27,7 +27,6 @@
 #include "worktree.h"
 
 static int inside_git_dir = -1;
-static int inside_work_tree = -1;
 static int work_tree_config_is_bogus;
 enum allowed_bare_repo {
 	ALLOWED_BARE_REPO_EXPLICIT = 0,
@@ -299,7 +298,7 @@ void verify_filename(const char *prefix,
  */
 void verify_non_filename(const char *prefix, const char *arg)
 {
-	if (!is_inside_work_tree() || is_inside_git_dir())
+	if (!is_inside_work_tree(the_repository) || is_inside_git_dir())
 		return;
 	if (*arg == '-')
 		return; /* flag */
@@ -477,11 +476,13 @@ int is_inside_git_dir(void)
 	return inside_git_dir;
 }
 
-int is_inside_work_tree(void)
+int is_inside_work_tree(struct repository *repo)
 {
-	if (inside_work_tree < 0)
-		inside_work_tree = is_inside_dir(repo_get_work_tree(the_repository));
-	return inside_work_tree;
+	static struct strbuf buf = STRBUF_INIT;
+	const char *worktree = repo_get_work_tree(repo);
+	if (!worktree)
+		return 0;
+	return is_inside_dir(strbuf_realpath(&buf, worktree, 1));
 }
 
 void setup_work_tree(void)
@@ -798,13 +799,10 @@ static int check_repository_format_gently(struct repository *repo,
 	if (!has_common) {
 		if (candidate->is_bare != -1) {
 			is_bare_repository_cfg = candidate->is_bare;
-			if (is_bare_repository_cfg == 1)
-				inside_work_tree = -1;
 		}
 		if (candidate->work_tree) {
 			free(git_work_tree_cfg);
 			git_work_tree_cfg = xstrdup(candidate->work_tree);
-			inside_work_tree = -1;
 		}
 	}
 
@@ -1252,7 +1250,6 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
 		set_git_dir(repo, gitdir, 0);
 	inside_git_dir = 0;
-	inside_work_tree = 1;
 	if (offset >= cwd->len)
 		return NULL;
 
@@ -1288,7 +1285,6 @@ static const char *setup_bare_git_dir(struct repository *repo,
 	}
 
 	inside_git_dir = 1;
-	inside_work_tree = 0;
 	if (offset != cwd->len) {
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
diff --git a/setup.h b/setup.h
index 80bc6e5f07..7c0aa75319 100644
--- a/setup.h
+++ b/setup.h
@@ -5,7 +5,7 @@
 #include "string-list.h"
 
 int is_inside_git_dir(void);
-int is_inside_work_tree(void);
+int is_inside_work_tree(struct repository *repo);
 int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 int get_common_dir(struct strbuf *sb, const char *gitdir);
 
diff --git a/submodule.c b/submodule.c
index e20537ba8d..46116cee88 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2622,7 +2622,7 @@ int get_superproject_working_tree(struct strbuf *buf)
 	int code;
 	ssize_t len;
 
-	if (!is_inside_work_tree())
+	if (!is_inside_work_tree(the_repository))
 		/*
 		 * FIXME:
 		 * We might have a superproject, but it is harder

-- 
2.53.0.1185.g05d4b7b318.dirty

