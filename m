Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA202BD590
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749413; cv=none; b=OU1guPxYSTwb4fAjq3ti9aGzcKPOlzKyvEl6B5MzqGDjouWu9SI0iolMNgH8q/TVels9/b8yQQBYO99Cq6+mVRIWPh3UsfTmyfH+ZTuwt4mm65/Cx/iyaiI8G+p6bWJ3EhtN3UCLkOCDjkE3ZRGmU9pgh8bYaNcSciEi6d6rZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749413; c=relaxed/simple;
	bh=R9P6xsrWCSDbbWrFg8qWoqvzJRXJ6GHnCeKdGz7uQrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwOJirv0uYzbUOIrwFPKdaPxK8IbbcmWgD5kaMFfcmSmXDdOVrXWPmVbYFB4HwEw7o5Fwlg7knE0+dfjWX0dQ6oYoZquYIE3ePymi53V8W82JE0gzvgF5fQSAdBvtcMrF76FvpKGBexqxVLx9TFEtVgGFV1dgL5J8V9uLKQuCBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FXG0mV+i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gr4ZXdCh; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FXG0mV+i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gr4ZXdCh"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 326D41D0015E
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 17 Jul 2025 06:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749411;
	 x=1752835811; bh=wlcWY82cge3+20mj85OzdMAevJSwRZvCBJEV0pu243U=; b=
	FXG0mV+i2o71FSK/C9LsPWmm11TmHti7mH33QxzvOl+4GudskiBqfp8Ig2wPD/GE
	El+PeRBA4XFWYMsa5Ki9rOJTkfWSf+FN4if1ZxXIeqYucgfaIogjx56uerDVlpag
	rnPGwDQhbPeA1TgKryI1aYr+X+BC2goEyyJxc8B1xSOZ2ouwQXa/cT1JaZWtB8Ii
	R8m0LNDIBL3qpwQnUrCeCcKPLMExUVJZRlwHFgHw5MdeHff+QgAkHUHzFPZKX7fP
	iim180o1pMWZkSKIJFpxbEHtiA4y3HCFp/dVFOnSI9edFR8iBPZqilrOhnUO8rAa
	03Oacbscts5yJ776rHjgLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749411; x=
	1752835811; bh=wlcWY82cge3+20mj85OzdMAevJSwRZvCBJEV0pu243U=; b=G
	r4ZXdChQ2suz8QkETjY4seYQ5Ge1j/3wCScXXRGqXpcSVHqoHAacS4bX1zx2SdyY
	PJIAorQcYd7afuDc9f8697TW3uqngXVlwTeXm5I+LhP8ZBIhsebTBn4lRB27Pfm8
	Zc8Q1Cz/88AD/sRCtq4/MLncNUWOt62VsPo52nxvhDseyI4KxqgniwQwSiR4QB5c
	S29NQ+ZTwisZcyJlFnkt5k697awfMqrevI1s65xToQa0BqwOi0uKepVJA/9KTTpA
	djXUItPfoBUsAHYySJk914ArlpdNC1CNzq3LHR7/3SAbeIary1chtiXjtQZ1epkm
	McM7WsMoaUghl1+F14EAw==
X-ME-Sender: <xms:YtV4aDpph81rUttvpmRlh0mL78jq69S4Ga5et0QiKcdx8BZCkrrTVw>
    <xme:YtV4aPpUzPTRjCJ305rCYiecAuRK4VllPxDhdBoR7LC1o4Yc9M1HmuPpVm_pVL7VB
    2HJGPVk0yx6flUkDg>
X-ME-Received: <xmr:YtV4aJlLRlpmI55WPrknZjRKA-rLbjgQ2yQBYEBdkjmUXkWvowoxFJxiuAzdKCaq9PVHL9vQ3nO4FEruGdLPlRCbIrLqm01UCgXyMzWvKkVq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:YtV4aJGbCpjIQKcabOMh1-iQ-fWZnjhZFvwFvZ6h4pcgBaZCaQBixg>
    <xmx:YtV4aKpvny1Kj5vDW21Og-qB2aoMDEhID6cuSNM9PvBwc5Gh3JMh3Q>
    <xmx:YtV4aN5Q7BaFXCfP3QQeo_8wUb9WmEU05XybGsrqINf-Mg66xrizSg>
    <xmx:YtV4aA6Cgfwbwrl2U_GRabN8H3s1FqjE9atjJg3M4IsKT1mAZHrAaQ>
    <xmx:Y9V4aMDGx18xuGI6BJGIZGGPYR1OpI4bjVzflP0ZQBwAz8Hq8oqQuWpP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 672d5d21 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:50:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:33 +0200
Subject: [PATCH 13/21] config: drop `git_config_set_gently()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-13-d888e4a17de1@pks.im>
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
In-Reply-To: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In 036876a1067 (config: hide functions using `the_repository` by
default, 2024-08-13) we have moved around a bunch of functions in the
config subsystem that depend on `the_repository`. Those function have
been converted into mere wrappers around their equivalent function that
takes in a repository as parameter, and the intent was that we'll
eventually remove those wrappers to make the dependency on the global
repository variable explicit at the callsite.

Follow through with that intent and remove `git_config_set_gently()`.
All callsites are adjusted so that they use
`repo_config_set_gently(the_repository, ...)` instead. While some
callsites might already have a repository available, this mechanical
conversion is the exact same as the current situation and thus cannot
cause any regression. Those sites should eventually be cleaned up in a
later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c                    |  6 +++---
 builtin/clone.c             |  2 +-
 builtin/remote.c            |  8 ++++----
 builtin/submodule--helper.c | 14 +++++++-------
 config.h                    |  5 -----
 scalar.c                    |  4 ++--
 setup.c                     |  4 ++--
 worktree.c                  |  4 ++--
 8 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/branch.c b/branch.c
index b4811671fc7..3dc237adf6c 100644
--- a/branch.c
+++ b/branch.c
@@ -116,7 +116,7 @@ static int install_branch_config_multiple_remotes(int flag, const char *local,
 			}
 
 	strbuf_addf(&key, "branch.%s.remote", local);
-	if (git_config_set_gently(key.buf, origin ? origin : ".") < 0)
+	if (repo_config_set_gently(the_repository, key.buf, origin ? origin : ".") < 0)
 		goto out_err;
 
 	strbuf_reset(&key);
@@ -127,7 +127,7 @@ static int install_branch_config_multiple_remotes(int flag, const char *local,
 	 * more than one is provided, use CONFIG_REGEX_NONE to preserve what
 	 * we've written so far.
 	 */
-	if (git_config_set_gently(key.buf, NULL) < 0)
+	if (repo_config_set_gently(the_repository, key.buf, NULL) < 0)
 		goto out_err;
 	for_each_string_list_item(item, remotes)
 		if (git_config_set_multivar_gently(key.buf, item->string, CONFIG_REGEX_NONE, 0) < 0)
@@ -136,7 +136,7 @@ static int install_branch_config_multiple_remotes(int flag, const char *local,
 	if (rebasing) {
 		strbuf_reset(&key);
 		strbuf_addf(&key, "branch.%s.rebase", local);
-		if (git_config_set_gently(key.buf, "true") < 0)
+		if (repo_config_set_gently(the_repository, key.buf, "true") < 0)
 			goto out_err;
 	}
 	strbuf_release(&key);
diff --git a/builtin/clone.c b/builtin/clone.c
index 34eea11db4d..0d7dd5e8ec9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1467,7 +1467,7 @@ int cmd_clone(int argc,
 			warning(_("failed to fetch objects from bundle URI '%s'"),
 				bundle_uri);
 		else if (has_heuristic)
-			git_config_set_gently("fetch.bundleuri", bundle_uri);
+			repo_config_set_gently(the_repository, "fetch.bundleuri", bundle_uri);
 
 		remote_state_clear(the_repository->remote_state);
 		free(the_repository->remote_state);
diff --git a/builtin/remote.c b/builtin/remote.c
index 826b2dcfd04..5c4dfc98afa 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -694,8 +694,8 @@ static void handle_push_default(const char* old_name, const char* new_name)
 	if (push_default.scope >= CONFIG_SCOPE_COMMAND)
 		; /* pass */
 	else if (push_default.scope >= CONFIG_SCOPE_LOCAL) {
-		int result = git_config_set_gently("remote.pushDefault",
-						   new_name);
+		int result = repo_config_set_gently(the_repository, "remote.pushDefault",
+						    new_name);
 		if (new_name && result && result != CONFIG_NOTHING_SET)
 			die(_("could not set '%s'"), "remote.pushDefault");
 		else if (!new_name && result && result != CONFIG_NOTHING_SET)
@@ -934,7 +934,7 @@ static int rm(int argc, const char **argv, const char *prefix,
 				strbuf_reset(&buf);
 				strbuf_addf(&buf, "branch.%s.%s",
 						item->string, *k);
-				result = git_config_set_gently(buf.buf, NULL);
+				result = repo_config_set_gently(the_repository, buf.buf, NULL);
 				if (result && result != CONFIG_NOTHING_SET)
 					die(_("could not unset '%s'"), buf.buf);
 			}
@@ -942,7 +942,7 @@ static int rm(int argc, const char **argv, const char *prefix,
 		if (info->push_remote_name && !strcmp(info->push_remote_name, remote->name)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.pushremote", item->string);
-			result = git_config_set_gently(buf.buf, NULL);
+			result = repo_config_set_gently(the_repository, buf.buf, NULL);
 			if (result && result != CONFIG_NOTHING_SET)
 				die(_("could not unset '%s'"), buf.buf);
 		}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0be737ac4ff..710a2a2004e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -458,7 +458,7 @@ static void init_submodule(const char *path, const char *prefix,
 	 */
 	if (!is_submodule_active(the_repository, path)) {
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
-		git_config_set_gently(sb.buf, "true");
+		repo_config_set_gently(the_repository, sb.buf, "true");
 		strbuf_reset(&sb);
 	}
 
@@ -484,7 +484,7 @@ static void init_submodule(const char *path, const char *prefix,
 			free(oldurl);
 		}
 
-		if (git_config_set_gently(sb.buf, url))
+		if (repo_config_set_gently(the_repository, sb.buf, url))
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
 		if (!(flags & OPT_QUIET))
@@ -506,7 +506,7 @@ static void init_submodule(const char *path, const char *prefix,
 			upd = submodule_update_type_to_string(sub->update_strategy.type);
 		}
 
-		if (git_config_set_gently(sb.buf, upd))
+		if (repo_config_set_gently(the_repository, sb.buf, upd))
 			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
 	}
 	strbuf_release(&sb);
@@ -1262,7 +1262,7 @@ static void sync_submodule(const char *path, const char *prefix,
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
-	if (git_config_set_gently(sb.buf, super_config_url))
+	if (repo_config_set_gently(the_repository, sb.buf, super_config_url))
 		die(_("failed to register url for submodule path '%s'"),
 		      displaypath);
 
@@ -3309,7 +3309,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
 
 	key = xstrfmt("submodule.%s.url", add_data->sm_name);
-	git_config_set_gently(key, add_data->realrepo);
+	repo_config_set_gently(the_repository, key, add_data->realrepo);
 	free(key);
 
 	add_submod.git_cmd = 1;
@@ -3356,12 +3356,12 @@ static void configure_added_submodule(struct add_data *add_data)
 		 */
 		if (!is_submodule_active(the_repository, add_data->sm_path)) {
 			key = xstrfmt("submodule.%s.active", add_data->sm_name);
-			git_config_set_gently(key, "true");
+			repo_config_set_gently(the_repository, key, "true");
 			free(key);
 		}
 	} else {
 		key = xstrfmt("submodule.%s.active", add_data->sm_name);
-		git_config_set_gently(key, "true");
+		repo_config_set_gently(the_repository, key, "true");
 		free(key);
 	}
 }
diff --git a/config.h b/config.h
index b4f79d4d4cc..90977441c3b 100644
--- a/config.h
+++ b/config.h
@@ -734,11 +734,6 @@ static inline int git_config_get_pathname(const char *key, char **dest)
 	return repo_config_get_pathname(the_repository, key, dest);
 }
 
-static inline int git_config_set_gently(const char *key, const char *value)
-{
-	return repo_config_set_gently(the_repository, key, value);
-}
-
 static inline void git_config_set(const char *key, const char *value)
 {
 	repo_config_set(the_repository, key, value);
diff --git a/scalar.c b/scalar.c
index 07f855c9913..c09c5ca194e 100644
--- a/scalar.c
+++ b/scalar.c
@@ -103,7 +103,7 @@ static int set_scalar_config(const struct scalar_config *config, int reconfigure
 	if ((reconfigure && config->overwrite_on_reconfigure) ||
 	    repo_config_get_string(the_repository, config->key, &value)) {
 		trace2_data_string("scalar", the_repository, config->key, "created");
-		res = git_config_set_gently(config->key, config->value);
+		res = repo_config_set_gently(the_repository, config->key, config->value);
 	} else {
 		trace2_data_string("scalar", the_repository, config->key, "exists");
 		res = 0;
@@ -322,7 +322,7 @@ static int set_config(const char *fmt, ...)
 	value = strchr(buf.buf, '=');
 	if (value)
 		*(value++) = '\0';
-	res = git_config_set_gently(buf.buf, value);
+	res = repo_config_set_gently(the_repository, buf.buf, value);
 	strbuf_release(&buf);
 
 	return res;
diff --git a/setup.c b/setup.c
index a06bb921b3a..a05c348dcdf 100644
--- a/setup.c
+++ b/setup.c
@@ -2236,13 +2236,13 @@ void initialize_repository_version(int hash_algo,
 		git_config_set("extensions.objectformat",
 			       hash_algos[hash_algo].name);
 	else if (reinit)
-		git_config_set_gently("extensions.objectformat", NULL);
+		repo_config_set_gently(the_repository, "extensions.objectformat", NULL);
 
 	if (ref_storage_format != REF_STORAGE_FORMAT_FILES)
 		git_config_set("extensions.refstorage",
 			       ref_storage_format_to_name(ref_storage_format));
 	else if (reinit)
-		git_config_set_gently("extensions.refstorage", NULL);
+		repo_config_set_gently(the_repository, "extensions.refstorage", NULL);
 
 	if (reinit) {
 		struct strbuf config = STRBUF_INIT;
diff --git a/worktree.c b/worktree.c
index c34b9eb74e5..981a2713374 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1013,7 +1013,7 @@ int init_worktree_config(struct repository *r)
 	 */
 	if (r->repository_format_worktree_config)
 		return 0;
-	if ((res = git_config_set_gently("extensions.worktreeConfig", "true")))
+	if ((res = repo_config_set_gently(the_repository, "extensions.worktreeConfig", "true")))
 		return error(_("failed to set extensions.worktreeConfig setting"));
 
 	common_config_file = xstrfmt("%s/config", r->commondir);
@@ -1077,7 +1077,7 @@ void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitdir,
 	if (use_relative_paths && !the_repository->repository_format_relative_worktrees) {
 		if (upgrade_repository_format(1) < 0)
 			die(_("unable to upgrade repository format to support relative worktrees"));
-		if (git_config_set_gently("extensions.relativeWorktrees", "true"))
+		if (repo_config_set_gently(the_repository, "extensions.relativeWorktrees", "true"))
 			die(_("unable to set extensions.relativeWorktrees setting"));
 		the_repository->repository_format_relative_worktrees = 1;
 	}

-- 
2.50.1.465.gcb3da1c9e6.dirty

