Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA02312825
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673371; cv=none; b=k1sK1pOuSuGR/X80sv7qfY2xlZ6SI2/9hvnz/ZPqq84t397hhnKMWF3jlRmsi83g/AbDlDhBBLcSij3c64hBzsGvFHRk/ykhOHSIz8J2HpFQkJG3EINuKca450ozsxvN/qd1YrWI+23e+4CGrquVbu3hOE4GLs2gy8v9Cp2UBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673371; c=relaxed/simple;
	bh=XjOL7aHtz4yCty5gTOl0IGjuZL5axKxz2wuyrQyE4Xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mQprOrlJ2CDZ63G7ZAoUmtlx5D0IMqlebY32oDe7MKo9L3a7CRu+zJJmilM3mJNiQL/Zb1xJF6Nn1XXvV4evpcv8YOMDzYVkD1mWEOTIGgx5rGr4uh6VokFMI5Og/hJYR07pj2QPstU8nza2MIA6tGuhuvj6Ue23J5i4u3xQtuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CfZFOszs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LAaGMWCo; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CfZFOszs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LAaGMWCo"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 2DCC1EC036B;
	Mon, 20 Apr 2026 04:22:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 20 Apr 2026 04:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776673369;
	 x=1776759769; bh=GML/RQQp2xOQ52qLj6Nd9SmYy9rQvzHbIUcVyvgDwIM=; b=
	CfZFOszsxDILXh7pEeIDvWaRH1vfmN2vXu7fYgNtYgX+2ypCgNUXV7a0xh6x4KrD
	E7FdW5Er/VJdJxLevibpEen2kCPmKrLH1jeB7cMeRCt7+40LiaqSHtNmoUAY1zIl
	enmXE0PWutZw16rwQPMBK0PdSV9G+2LAVuJ4QCbit6Yyo3SGJMqKwNHIxYvmwFoO
	3GLNN61GY1P6oPTfpAAviYq7BQCocEZqb8MuVuV+mnY6xarknTMY4rS3qdk4K6Zb
	nV0gdL/00kYwC2+uPQRxl1F3jKM+1KtIz0x/Gc5CTAJLMGnasvvhe3m3HVbVUnuQ
	FuQySzVdFk6cYkM+q/GYtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776673369; x=
	1776759769; bh=GML/RQQp2xOQ52qLj6Nd9SmYy9rQvzHbIUcVyvgDwIM=; b=L
	AaGMWCo5m/BXTNg8Jl2pBiPIGzWJKYG4lGDS8rbhu721Ohyg4d0hZ3jAMvrwvVdB
	Gzb3ChRgWaZR0O6z4jjJdGKzhXWK9y/6UKSnz8Cw+a+ArI6T5DVnQTE+8HNt0mLK
	eRAK63/IZdXuN9Y5gniVOYbK5y0aztELdJKvfElGOTcELELRQ3m+cQNJjVl97FI9
	nfOZol9S5Lk4m8NLMK0fSJCBsfZSSoa6+WBl9qk2UI051UJr5YwtM8CFFtxzc53i
	9MjKkIqpdD9UmSP42nl6afYYXngvSr0YuzvdTVG9D9edcEyT3DftbdZ9mijawvfr
	98DIESzjJYMPzyHd0CPSQ==
X-ME-Sender: <xms:WeLlaWnZcG3D0yPdveXxv7XOcFm_buUcAV2v5edbAK_lmxThBLUNLg>
    <xme:WeLlaU2oW9pglJbtRU-SoAIJVz4m-MdEU1AAORsxzoGgpw8BYEZ2p0xc4dZNEN4AK
    6VTT-roPvsN2o2Rs7PVd7Uw8-j_9qm6L6QGHyr3RW2qbjxUihK7>
X-ME-Received: <xmr:WeLlaZrkIa2ZX41lPPIrWFPvomXSJN-ylNCTM4IktRSIIZVcLJ53xkEVs5-bBs9YtG4rIl2CLU0HeRRXXQ_85VDrOOIfPVoX3KpCmcvUrA26>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WeLlaZe_6E3XkY3u23cjzpVTWHj_ElS7cg_RZobwZYsYdh7GCt68-A>
    <xmx:WeLlaQpzsIbJNF5KyT3FuZZYjWmQQLO-xLfQEPCZxSWSmPTGJ8Id1g>
    <xmx:WeLlaSFFSuiU3rkisn8VkkdSyEFTRO8Ug80Nns1i0aoIsvOsTdEVLw>
    <xmx:WeLlaYsoEoLIeZ7w5gdJ6XxWj6c4o9UELMTfDYXME8Rlg9pWtgb79g>
    <xmx:WeLlaVIPfVZD7CAstbJ0doAEXKzcdR2LROVOVSJiF_BoLfpng9d0EvPB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:22:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d4b3ddb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:22:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 10:22:32 +0200
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
Message-Id: <20260420-pks-setup-wo-the-repository-v1-2-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

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
2.54.0.rc2.529.gd9106f7525.dirty

