Received: from sender4-pp-g125.zoho.com (sender4-pp-g125.zoho.com [136.143.188.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25CA3876BE
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244071; cv=pass; b=Q0N4ECz1h0KoPnDuRRPHI+7UFkwQAa2uOybM6cpfYBCLohm21aZlSAksoPoFrnLesFEJra+4DUuH3tWYFbY0e5zSJB84EHysExreyR4he6Vkct4GAkLI83f2CT4qhSe51JQEjLkEw1RrPbA4HC9Qz9jVeYfhp0k/gCAkustlVlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244071; c=relaxed/simple;
	bh=LaFngUp94QtSLZ8KDX1B0DJn5lw5+lumdEMa/WEcYgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrxY8TVqNe4d1ZnI7zrjvDilcXkYp71curClnvHYqTk/b/5M3uTIhSvlinjRnxRmn6mLA7Aez4jgkAxes3xKlNRXAqIKh123VO20DVO9cUC7y9/0jDnJiQLHa2aT0oVYaFe5+CyCFnUx+ZiN0gZNpwV8GeCPiJuX7DVAnXVyn58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=B03gcbgu; arc=pass smtp.client-ip=136.143.188.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="B03gcbgu"
ARC-Seal: i=1; a=rsa-sha256; t=1768244056; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CWYI0Ky4TYtEw/1wiMUvEBbKr7Tw0gmijNW0q0bQ06uOaSS6yWkWpSjtf40mks7YLZfpS8qgwGOvlh+FuXRAkpqY+Czfj22DFuT9zEbZ+4G0v+FkvycqXcoE3tFw9bpBG2AxGHf94c2MGerHMB5b9RQuk2aTl3AeAlcQsmF7lqw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768244056; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YUvFWzUt2LB8vATsze0cAKMZd2Y8Kx017VZ4SKEwaEg=; 
	b=BbFv8dnkM4GuA0ct5u+6w/OJuOA/JO+htxQka4xpfuZC3XjC+BoQQnwrJ0RKmrEKDvPio4IzTOANhwgdsU8IB3fmcIbgvT32SGWdmDQ9j946G92EfBgq/zFQbcSAZh/ydbQLQmeyJhDvK4splmD6EG7IAEkRIitPy+FHAf7i88k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768244056;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YUvFWzUt2LB8vATsze0cAKMZd2Y8Kx017VZ4SKEwaEg=;
	b=B03gcbguF7V/0IHTwuSY+afcRJh23tpwZHG7RXp3eJeYW6FCwIlQ4ij0LjiBCngS
	Mt+pxcReyb3I1XEagvskTJM/CPUMUImqQQbp6nyxyf8TFOAdadPwDeSdWrV45deGxk2
	8bk7vbsaBpGIbvD+jubggOJ3YJ67MthTi0o7f5wM=
Received: by mx.zohomail.com with SMTPS id 1768244053469209.34050775588378;
	Mon, 12 Jan 2026 10:54:13 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v9 02/11] submodule: always validate gitdirs inside submodule_name_to_gitdir
Date: Mon, 12 Jan 2026 20:46:23 +0200
Message-ID: <20260112184632.1334495-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112184632.1334495-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260112184632.1334495-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Move the ad-hoc validation checks sprinkled across the source tree,
after calling submodule_name_to_gitdir() into the function proper,
which now always validates the gitdir before returning it.

This simplifies the API and helps to:
1. Avoid redundant validation calls after submodule_name_to_gitdir().
2. Avoid the risk of callers forgetting to validate.
3. Ensure gitdir paths provided by users via configs are always valid
   (config gitdir paths are added in a subsequent commit).

The validation function can still be called as many times as needed
outside submodule_name_to_gitdir(), for example we keep two calls
which are still required, to avoid parallel clone races by re-running
the validation in builtin/submodule-helper.c.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c |  4 ----
 submodule.c                 | 12 ++++--------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6686714e56..aff3f9135e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1699,10 +1699,6 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		clone_data_path = to_free = xstrfmt("%s/%s", repo_get_work_tree(the_repository),
 						    clone_data->path);
 
-	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
-		die(_("refusing to create/use '%s' in another submodule's "
-		      "git dir"), sm_gitdir);
-
 	if (!file_exists(sm_gitdir)) {
 		if (clone_data->require_init && !stat(clone_data_path, &st) &&
 		    !is_empty_dir(clone_data_path))
diff --git a/submodule.c b/submodule.c
index 40a5c6fb9d..f645372a18 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2166,11 +2166,6 @@ int submodule_move_head(const char *path, const char *super_prefix,
 			struct strbuf gitdir = STRBUF_INIT;
 			submodule_name_to_gitdir(&gitdir, the_repository,
 						 sub->name);
-			if (validate_submodule_git_dir(gitdir.buf,
-						       sub->name) < 0)
-				die(_("refusing to create/use '%s' in another "
-				      "submodule's git dir"),
-				    gitdir.buf);
 			connect_work_tree_and_git_dir(path, gitdir.buf, 0);
 			strbuf_release(&gitdir);
 
@@ -2349,9 +2344,6 @@ static void relocate_single_git_dir_into_superproject(const char *path,
 		die(_("could not lookup name for submodule '%s'"), path);
 
 	submodule_name_to_gitdir(&new_gitdir, the_repository, sub->name);
-	if (validate_submodule_git_dir(new_gitdir.buf, sub->name) < 0)
-		die(_("refusing to move '%s' into an existing git dir"),
-		    real_old_git_dir);
 	if (safe_create_leading_directories_const(the_repository, new_gitdir.buf) < 0)
 		die(_("could not create directory '%s'"), new_gitdir.buf);
 	real_new_git_dir = real_pathdup(new_gitdir.buf, 1);
@@ -2600,4 +2592,8 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 	 */
 	repo_git_path_append(r, buf, "modules/");
 	strbuf_addstr(buf, submodule_name);
+
+	if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
+		die(_("refusing to create/use '%s' in another submodule's "
+		      "git dir"), buf->buf);
 }
-- 
2.52.0

