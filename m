Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2C3D47DD
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184345; cv=none; b=RUUymFcXSRiY6qW6LkG0L46GWn5MPoV9GnlaIEua7DDLifWLMcTf9dnAOsVfb1J1ALgGgXKZW5gYnUCiP9/IIB+k48RcStq2YhGvCRUx834PxY2Y+EwFKvp7ykCeF2SsYkqAJ+6/NGtwChq1eArc/LAIj94JMwS5inhpb0MzeCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184345; c=relaxed/simple;
	bh=/Dq8mPnxGIH9b83DMfG63bfJzN8AhtF1kPj1enKJXqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RF0xDEq0VxTIG/FGP7gghsJsUpVObVKjVcjOckBhZD//4Y9GKkXx2gDM9FyW+dZKrzKwHhnXqwWLNlpF/iNimGE47RxhhTZ7xJGkAxycPhkO2p4RDY32w0J948XyOV8yE8B7NT0nuAK/OgNUyatjIzWw2jCX3OeJpat9eE883Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JV+z6Vlv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a7qplw0U; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JV+z6Vlv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a7qplw0U"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 422867A009C;
	Tue, 19 May 2026 05:52:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 19 May 2026 05:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184341;
	 x=1779270741; bh=654p0ZqN4gcK1QkcEluGr92LnsPazzo8Vv4hxIKgg3M=; b=
	JV+z6VlvicUHSBSsiyU68ZnGUXxYBJgOu5uVG7KxYvvvfIMEVZjKQ1RK9ONwizKB
	ekmv6JRmDczGUGPpg86cJPP5zspVRHnSeUh1NErYk0yu0DWSKhf6PuOpvXlZWe8V
	QGq1+gN3Qr6cQ5OMlxb7pIB3P3seZs8SHXM8t5yTS2N+6DcYbKgtp8Erg0SR194H
	XTr9c0cxcdvYu4F9KV1m/+tacvorTKMLTo/xN+jf+aNfoEYxpYDz5RvkIDSJu1DF
	XAIdx4iHlp5CYdvs/g+eybVLGY2suzAOe//L87l3QKHA/ESky0Mi7MY4bgjHFOjM
	i1vxBzzgRu8LDthQxdi0kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184341; x=
	1779270741; bh=654p0ZqN4gcK1QkcEluGr92LnsPazzo8Vv4hxIKgg3M=; b=a
	7qplw0USV2D+IcwNsp91eYCS8oS4cg01WKx4n9vmFpkitsD93MfN6Xgtaw6jePEj
	2aqB1QdFpfHCFXP6MEB5V34oKSfsxezku/ENAmcXWXJmOSh6Pg3RQy4vV5AL2qX+
	suqQ/jdUaTIOylXfU7u6KVw6RD6I6Z/I9VaN5cvXvXKCBET6Uh4dbfphr3Esvzx8
	gXLA7f3YODpCQePHCYhDqCyou0qHUIjDFlRyOanmXYUJnrRIqikWwInhYm0F5nVs
	Zf7BXafwPMkGBxDm2N4vCqCIYF0LXPq7lbriIVvKikJJ4oOZys1o1KfcgSAO5iyv
	NYYdG+39eJ+6UN6t8B8pQ==
X-ME-Sender: <xms:1TIMakYJVxyIsaK7gUjJJbgF2FNeoJwGc2vA3narPzt5Fudilw2fDg>
    <xme:1TIMamS9GJ8ztG0fAT84i3n5Aj85qQPzyKoOlzHx5JYUwJ-OG7HH74a7Bd2tdKhBu
    240DzevFTQ0ktsf-iAm7uunHgi28IvT_60qiR8mheAP-jZuOFhSJQ>
X-ME-Received: <xmr:1TIManQO8-qbXrXvIaZ3rCeqEwyNvl6O7BH2GK_09vL_8IA9ljKGy5YjtE_qjALKtddhcL4LIjljbbS05vlMCEYXxccvGZ7wqsUVnNPxLh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheptggrthesmhgrlhhonhdruggvvh
X-ME-Proxy: <xmx:1TIMaqSJCtmQQpyTaL6UmO87lhI74AoA7hXbIKJvn9G54c0AS4rh5g>
    <xmx:1TIMas6vazF3owERFFYw6R6vcK5VqTwNHMvoJ4TnQiThTbF-Ae6oeg>
    <xmx:1TIMam1IsYQPto2XGpZrjOJgl5XHUPLC-iRcQjhM7quDDQaGdeu5Xg>
    <xmx:1TIManAMQ2fxfvnXZ6BvW8VskxfnSLkfNaLhazBNkF_XYmCwP8iCzw>
    <xmx:1TIMahjRdz58I5ADSqhJ9PGI1ym15DLmlZ2n2d-XuoZMNAvkeWK43rx9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ff07920 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 May 2026 11:52:07 +0200
Subject: [PATCH v3 03/18] setup: stop using `the_repository` in
 `is_inside_work_tree()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-pks-setup-wo-the-repository-v3-3-a00d8ea8b07f@pks.im>
References: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Similar as with the preceding commit, `is_inside_work_tree()` determines
whether the current working directory is located inside the worktree of
`the_repository`. Perform the same refactoring by dropping the caching
mechanism and injecting the repository that shall be checked.

Note that, same as in the preceding commit, we're also resolving the
worktree path via `realpath()`. In theory this step is not necessary as
we always set the worktree path via `repo_set_worktree()`, and that
function already resolves the path for us. But resolving the path a
second time is unlikely to matter performance-wise, and it feels fragile
to rely on the repository's worktree path being absolute. We thus
perform the same extra step even though it's ultimately not required.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/ls-files.c  |  2 +-
 builtin/rev-parse.c |  4 ++--
 object-name.c       |  2 +-
 setup.c             | 25 ++++++++++++++-----------
 setup.h             |  2 +-
 submodule.c         |  2 +-
 6 files changed, 20 insertions(+), 17 deletions(-)

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
index a216be63cf..2fcd6851d1 100644
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
index 21dcdc4a0e..37a9ce8e87 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1703,7 +1703,7 @@ static char *resolve_relative_path(struct repository *r, const char *rel)
 	if (!starts_with(rel, "./") && !starts_with(rel, "../"))
 		return NULL;
 
-	if (r != the_repository || !is_inside_work_tree())
+	if (r != the_repository || !is_inside_work_tree(the_repository))
 		die(_("relative path syntax can't be used outside working tree"));
 
 	/* die() inside prefix_path() if resolved path is outside worktree */
diff --git a/setup.c b/setup.c
index 80f3ba0d62..041e08b98d 100644
--- a/setup.c
+++ b/setup.c
@@ -26,7 +26,6 @@
 #include "trace2.h"
 #include "worktree.h"
 
-static int inside_work_tree = -1;
 static int work_tree_config_is_bogus;
 enum allowed_bare_repo {
 	ALLOWED_BARE_REPO_EXPLICIT = 0,
@@ -298,7 +297,7 @@ void verify_filename(const char *prefix,
  */
 void verify_non_filename(const char *prefix, const char *arg)
 {
-	if (!is_inside_work_tree() || is_inside_git_dir(the_repository))
+	if (!is_inside_work_tree(the_repository) || is_inside_git_dir(the_repository))
 		return;
 	if (*arg == '-')
 		return; /* flag */
@@ -477,11 +476,20 @@ int is_inside_git_dir(struct repository *repo)
 	return ret;
 }
 
-int is_inside_work_tree(void)
+int is_inside_work_tree(struct repository *repo)
 {
-	if (inside_work_tree < 0)
-		inside_work_tree = is_inside_dir(repo_get_work_tree(the_repository));
-	return inside_work_tree;
+	struct strbuf buf = STRBUF_INIT;
+	const char *worktree;
+	int ret;
+
+	worktree = repo_get_work_tree(repo);
+	if (!worktree)
+		return 0;
+
+	ret = is_inside_dir(strbuf_realpath(&buf, worktree, 1));
+
+	strbuf_release(&buf);
+	return ret;
 }
 
 void setup_work_tree(void)
@@ -798,13 +806,10 @@ static int check_repository_format_gently(struct repository *repo,
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
 
@@ -1251,7 +1256,6 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 	set_git_work_tree(".");
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
 		set_git_dir(repo, gitdir, 0);
-	inside_work_tree = 1;
 	if (offset >= cwd->len)
 		return NULL;
 
@@ -1286,7 +1290,6 @@ static const char *setup_bare_git_dir(struct repository *repo,
 		return setup_explicit_git_dir(repo, gitdir, cwd, repo_fmt, nongit_ok);
 	}
 
-	inside_work_tree = 0;
 	if (offset != cwd->len) {
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
diff --git a/setup.h b/setup.h
index 115bda647c..71d3f91883 100644
--- a/setup.h
+++ b/setup.h
@@ -5,7 +5,7 @@
 #include "string-list.h"
 
 int is_inside_git_dir(struct repository *repo);
-int is_inside_work_tree(void);
+int is_inside_work_tree(struct repository *repo);
 int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 int get_common_dir(struct strbuf *sb, const char *gitdir);
 
diff --git a/submodule.c b/submodule.c
index b1a0363f9d..a939ff5072 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2620,7 +2620,7 @@ int get_superproject_working_tree(struct strbuf *buf)
 	int code;
 	ssize_t len;
 
-	if (!is_inside_work_tree())
+	if (!is_inside_work_tree(the_repository))
 		/*
 		 * FIXME:
 		 * We might have a superproject, but it is harder

-- 
2.54.0.771.g3ed373ac14.dirty

