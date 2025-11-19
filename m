Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B42ED85D
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586714; cv=pass; b=NjxaB+blaX+J4KwHf8pGsikwAccyyQue/c/qvWzeW3J/GHDCMX0UvoqJ1lp4oTM2Wbpv+wYgZT7+XIOo32VdDQNBSoWM+ukgrKAR8gqN4SBN4yjpuOdO+SJ1rjrzMxxMB0NpxkXgGVm5uLEfQGd2hzPbmPYk0U/bsCWMBGBk2ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586714; c=relaxed/simple;
	bh=rru2umB1aXzeJifrAp3He/DVaLNoz4JHzXHu/V8eTgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUdvPe6PWBODVM+fhoIPaLNZyE5emviUkbGzu3C2sVpaDVwaoLDf6zTIZb96RZytevl1H6+v1Iji+UzDUkfeY8l/HlZ/aS0urGv3M0CFO/7cr9w433BpZ0YrwIYoQsJrTCxVvn9TVjS9TQDQUsumNnPr5wnVvypGDn0EAxuAbGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=c9pwuZvN; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="c9pwuZvN"
ARC-Seal: i=1; a=rsa-sha256; t=1763586682; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gpfKl5cixQUUFt9/SWHwtiaH2dMilCq6KqJ0oLSKu8SsNA6rVSPePcRhHy9FZeSdehkSFOK0H3oTefoRIz3OzgD6yloVscbiVd3TwH3zOWKGWMBoSNsOuNlykUb+l1J2fUPAKty7LjolZrQ7GdGmh1jRgstcdTW7S9KxrxnRkNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763586682; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=I2ZzRiN8ajRIrkhUhTrNgcI82/lOMkgXjG8ceog0Z6E=; 
	b=JuAgKVtRY0DgjopCN/XjFDnYFjKqsFZER4MXnYEBf9rZVkr9ipdXaHEuh2Nc6Qihkf6a7XZJOvmUYpS5g2rqTB/lSHT12pVNxOQF6Wbg8NK/ikz7A7dT/LluIWrXK/nRxomPvoXwetYEBtLb5NO9kgiBqG/8N8f5vFXz1DCtl6A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763586682;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=I2ZzRiN8ajRIrkhUhTrNgcI82/lOMkgXjG8ceog0Z6E=;
	b=c9pwuZvN7LVN0CD8Ulwc2DnKZVf4E5s+UgAJsvoAPu/yDa1IqcgcneagVR4LPmzL
	J1yEVFSWKjFk/YuodEtpaMv7RS/36S/qyHWpdaJOQ5hECo0VicwC9R3bJxWgJA/cKtA
	jtPxT8AdHTIPHZsrD2NXEiYsqKR8gn4AQCjnjVOY=
Received: by mx.zohomail.com with SMTPS id 1763586681063445.442122553526;
	Wed, 19 Nov 2025 13:11:21 -0800 (PST)
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
Subject: [PATCH v5 3/7] submodule: always validate gitdirs inside submodule_name_to_gitdir
Date: Wed, 19 Nov 2025 23:10:26 +0200
Message-ID: <20251119211030.2008441-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119211030.2008441-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
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

This also makes parallel operations a bit safer due to checking and
erroring out each time the unified API detects a problem instead of
having one extra hardcoded validation check in submodule--helper.c.

It simplifies the API usage as well since users who don't have to
validate the submodule_name_to_gitdir() result themselves anymore
and reduces the risks of API users forgetting to validate.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c | 21 ---------------------
 submodule.c                 | 30 ++++++------------------------
 submodule.h                 |  5 -----
 3 files changed, 6 insertions(+), 50 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2873b2780e..9914ca0786 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1703,10 +1703,6 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		clone_data_path = to_free = xstrfmt("%s/%s", repo_get_work_tree(the_repository),
 						    clone_data->path);
 
-	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
-		die(_("refusing to create/use '%s' in another submodule's "
-		      "git dir"), sm_gitdir);
-
 	if (!file_exists(sm_gitdir)) {
 		if (clone_data->require_init && !stat(clone_data_path, &st) &&
 		    !is_empty_dir(clone_data_path))
@@ -1780,23 +1776,6 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		free(path);
 	}
 
-	/*
-	 * We already performed this check at the beginning of this function,
-	 * before cloning the objects. This tries to detect racy behavior e.g.
-	 * in parallel clones, where another process could easily have made the
-	 * gitdir nested _after_ it was created.
-	 *
-	 * To prevent further harm coming from this unintentionally-nested
-	 * gitdir, let's disable it by deleting the `HEAD` file.
-	 */
-	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0) {
-		char *head = xstrfmt("%s/HEAD", sm_gitdir);
-		unlink(head);
-		free(head);
-		die(_("refusing to create/use '%s' in another submodule's "
-		      "git dir"), sm_gitdir);
-	}
-
 	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
 
 	p = repo_submodule_path(the_repository, clone_data_path, "config");
diff --git a/submodule.c b/submodule.c
index 35c55155f7..8ef028f26b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2153,30 +2153,11 @@ int submodule_move_head(const char *path, const char *super_prefix,
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
 		if (old_head) {
-			if (!submodule_uses_gitfile(path))
-				absorb_git_dir_into_superproject(path,
-								 super_prefix);
-			else {
-				char *dotgit = xstrfmt("%s/.git", path);
-				char *git_dir = xstrdup(read_gitfile(dotgit));
-
-				free(dotgit);
-				if (validate_submodule_git_dir(git_dir,
-							       sub->name) < 0)
-					die(_("refusing to create/use '%s' in "
-					      "another submodule's git dir"),
-					    git_dir);
-				free(git_dir);
-			}
+			absorb_git_dir_into_superproject(path, super_prefix);
 		} else {
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
 
@@ -2256,7 +2237,7 @@ int submodule_move_head(const char *path, const char *super_prefix,
 	return ret;
 }
 
-int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
+static int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
 {
 	size_t len = strlen(git_dir), suffix_len = strlen(submodule_name);
 	char *p;
@@ -2355,9 +2336,6 @@ static void relocate_single_git_dir_into_superproject(const char *path,
 		die(_("could not lookup name for submodule '%s'"), path);
 
 	submodule_name_to_gitdir(&new_gitdir, the_repository, sub->name);
-	if (validate_submodule_git_dir(new_gitdir.buf, sub->name) < 0)
-		die(_("refusing to move '%s' into an existing git dir"),
-		    real_old_git_dir);
 	if (safe_create_leading_directories_const(the_repository, new_gitdir.buf) < 0)
 		die(_("could not create directory '%s'"), new_gitdir.buf);
 	real_new_git_dir = real_pathdup(new_gitdir.buf, 1);
@@ -2606,4 +2584,8 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 	 */
 	repo_git_path_append(r, buf, "modules/");
 	strbuf_addstr(buf, submodule_name);
+
+	if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
+		die(_("refusing to create/use '%s' in another submodule's "
+		      "git dir"), buf->buf);
 }
diff --git a/submodule.h b/submodule.h
index b10e16e6c0..0b7692bc20 100644
--- a/submodule.h
+++ b/submodule.h
@@ -137,11 +137,6 @@ int submodule_to_gitdir(struct repository *repo,
 void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 			      const char *submodule_name);
 
-/*
- * Make sure that no submodule's git dir is nested in a sibling submodule's.
- */
-int validate_submodule_git_dir(char *git_dir, const char *submodule_name);
-
 /*
  * Make sure that the given submodule path does not follow symlinks.
  */
-- 
2.51.0

