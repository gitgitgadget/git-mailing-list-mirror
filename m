Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D811FC3
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279758; cv=none; b=C9zPvpzghR5dqXksepbHtcGzhwSLgaBRCikHRoFs3xxT5pDUrmKU33TxuGEVh6fG4H/9igt72223hUqSGFgt71OpkDs+xDuVbn6UmiBXNLHgSrxdKjky07IjnEjQ76gbG7RFpt06G3vw54XlLp2b9vaMM0t+SOstdXhYYHcuetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279758; c=relaxed/simple;
	bh=zGZFNTHgo6G8Dm1RJ6sxV9oT0QqgeKwv+/dWQvy5bGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mMbGii0E3OF074INEyF86wMeE8xtp34MWy1vszPBZwOX9LlDfiXeuG+6DOf40LrWmC6UdKpDnBCNSSwZ170pD8Sr1RbWQP4CmypHmfXFjgTjuLkig/OFszOsRfHZJXCoKeHHrPpjPTbWuvAU1yLLtB2mdZ6dH8rH2+2SbqiurBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SYfwwh4i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPoqgQXk; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SYfwwh4i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPoqgQXk"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F409EC1C17;
	Wed, 23 Jul 2025 10:09:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Jul 2025 10:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279754;
	 x=1753366154; bh=hh6vvSqnSvQhfddEyE6oaraQfMkA47KUx4+Jt59Jdm8=; b=
	SYfwwh4i9THv/+cQzjKay4NV5X6nZgQv3iv6HG/rekh4KxeYQxicKsn7FpeMW5xr
	cf1Px2UO8A9KMIBubZf48azH5imHLUX6QFCvhtuvyk+9wlyD31ssOhUW2TzrSNEo
	M5t85TC7uMyRpQiRGZmQo754rsqXx63Qjx/RHAUh+GwDES143tcqk3xiRJhTiCD7
	CRnlBPWJWEuS4vRT0Y79pEIQ7zWObTkjbH0Y3TNJf+2uIGgpuwSfc3cnWuba5sHW
	hkycZh/D4vmGfDYABA/eKXfskYoDm2APKeHhtXoc+nGXQdMChWIT282UfMDo6DRT
	4USBy5drIP6NTgAdb2h/Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279754; x=
	1753366154; bh=hh6vvSqnSvQhfddEyE6oaraQfMkA47KUx4+Jt59Jdm8=; b=X
	PoqgQXktG6MBn/AbdKxiJ7TxVPf2s+MgY5vHLtk/YXbjr4PKcBJifva+XaMQgH+S
	4B8RjPf7gJ6rXTKGaok3xP4fvV+cP+nWNy+HX/mqzYDufTaN5wJWnUbdgxOfzBno
	kfTYFADuR14I57pMC3K1OiD4M46olYStpOsvKh/K9T7pa4kbvLZZC1AhjP0fpjCJ
	9CPYHEfBek7C3PTStWLSFCuPP2iPzcLy9xQ/9z+iydjEb9rrVWdT5eFoHQMHFrd/
	T6sr0sHIcsmbJTEhQMA3ZE+myqZomZ3wy3qhURaeX2hgoDmRcNzTk6yBLkv5yOWK
	8/le/ou7gRrA+8dCy2UOA==
X-ME-Sender: <xms:Cu2AaFOK4_oVJKRclc_kJhZzGy6BMS3IZZtJsjNvNXfGxFcfpRYYXg>
    <xme:Cu2AaIJt9fM1ZiczffNoXeDmhahBA_8FqP2WjEqP65wnD_3wOLfnu7dpNkYCMQpuW
    cfgIilFZG9V66R2iw>
X-ME-Received: <xmr:Cu2AaGG1lDdnyHa-o2jdzT2d_yVZwp43CKkFUAI0LJYj2QcuJA_xjc2R99DjTmSngmX8Bt83_hpSTtg4YR13DmEbczqUNCr_1lXigEvALcvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Cu2AaATeeIIwjPq0GvKnHwNa14eTMG8h91bRKWyHDMW_oAQd4VSXBg>
    <xmx:Cu2AaCELNuYnpSwjESnnHKz80_FnWzFYZuQvlnJYwD_yJnWYQFjwZw>
    <xmx:Cu2AaM8VA09_u57lh74nNmGF9xIY6D6yrXPt4hNdhZ0RLXEMVfWX-A>
    <xmx:Cu2AaMI6jrhaPFdVTTWAhtzJlZROSQ4hhTfDfH_AY3qMDT4HMxc6DQ>
    <xmx:Cu2AaFdE4Wco62v6zQeGU6K1mHlfMdxQlp1029WKKuQ_FvLrT7ZZ6WvY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:09:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a6e1318 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:09:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:35 +0200
Subject: [PATCH v2 14/21] config: drop `git_config_set()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-14-1502d60d3867@pks.im>
References: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
In-Reply-To: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

In 036876a1067 (config: hide functions using `the_repository` by
default, 2024-08-13) we have moved around a bunch of functions in the
config subsystem that depend on `the_repository`. Those function have
been converted into mere wrappers around their equivalent function that
takes in a repository as parameter, and the intent was that we'll
eventually remove those wrappers to make the dependency on the global
repository variable explicit at the callsite.

Follow through with that intent and remove `git_config_set()`. All
callsites are adjusted so that they use `repo_config_set(the_repository,
...)` instead. While some callsites might already have a repository
available, this mechanical conversion is the exact same as the current
situation and thus cannot cause any regression. Those sites should
eventually be cleaned up in a later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/branch.c              |  2 +-
 builtin/clone.c               |  8 ++++----
 builtin/gc.c                  |  4 ++--
 builtin/remote.c              | 16 ++++++++--------
 compat/precompose_utf8.c      |  4 ++--
 config.c                      |  2 +-
 config.h                      |  5 -----
 list-objects-filter-options.c |  6 +++---
 setup.c                       | 30 +++++++++++++++---------------
 9 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 08e50bf77b3..5de0691d18d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -699,7 +699,7 @@ static int edit_branch_description(const char *branch_name)
 
 	strbuf_addf(&name, "branch.%s.description", branch_name);
 	if (buf.len || exists)
-		git_config_set(name.buf, buf.len ? buf.buf : NULL);
+		repo_config_set(the_repository, name.buf, buf.len ? buf.buf : NULL);
 	strbuf_release(&name);
 	strbuf_release(&buf);
 
diff --git a/builtin/clone.c b/builtin/clone.c
index 0d7dd5e8ec9..f025a8f19e0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -827,7 +827,7 @@ static void write_refspec_config(const char *src_ref_prefix,
 
 			if (option_mirror) {
 				strbuf_addf(&key, "remote.%s.mirror", remote_name);
-				git_config_set(key.buf, "true");
+				repo_config_set(the_repository, key.buf, "true");
 				strbuf_reset(&key);
 			}
 		}
@@ -1294,18 +1294,18 @@ int cmd_clone(int argc,
 			src_ref_prefix = "refs/";
 		strbuf_addstr(&branch_top, src_ref_prefix);
 
-		git_config_set("core.bare", "true");
+		repo_config_set(the_repository, "core.bare", "true");
 	} else if (!option_rev) {
 		strbuf_addf(&branch_top, "refs/remotes/%s/", remote_name);
 	}
 
 	strbuf_addf(&key, "remote.%s.url", remote_name);
-	git_config_set(key.buf, repo);
+	repo_config_set(the_repository, key.buf, repo);
 	strbuf_reset(&key);
 
 	if (!option_tags) {
 		strbuf_addf(&key, "remote.%s.tagOpt", remote_name);
-		git_config_set(key.buf, "--no-tags");
+		repo_config_set(the_repository, key.buf, "--no-tags");
 		strbuf_reset(&key);
 	}
 
diff --git a/builtin/gc.c b/builtin/gc.c
index fa62e4f2627..c0fe4e73087 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1913,11 +1913,11 @@ static int maintenance_register(int argc, const char **argv, const char *prefix,
 				   options);
 
 	/* Disable foreground maintenance */
-	git_config_set("maintenance.auto", "false");
+	repo_config_set(the_repository, "maintenance.auto", "false");
 
 	/* Set maintenance strategy, if unset */
 	if (repo_config_get(the_repository, "maintenance.strategy"))
-		git_config_set("maintenance.strategy", "incremental");
+		repo_config_set(the_repository, "maintenance.strategy", "incremental");
 
 	if (!repo_config_get_string_multi(the_repository, key, &list)) {
 		for_each_string_list_item(item, list) {
diff --git a/builtin/remote.c b/builtin/remote.c
index 5c4dfc98afa..827639e0398 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -209,7 +209,7 @@ static int add(int argc, const char **argv, const char *prefix,
 		die(_("'%s' is not a valid remote name"), name);
 
 	strbuf_addf(&buf, "remote.%s.url", name);
-	git_config_set(buf.buf, url);
+	repo_config_set(the_repository, buf.buf, url);
 
 	if (!mirror || mirror & MIRROR_FETCH) {
 		strbuf_reset(&buf);
@@ -225,14 +225,14 @@ static int add(int argc, const char **argv, const char *prefix,
 	if (mirror & MIRROR_PUSH) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.mirror", name);
-		git_config_set(buf.buf, "true");
+		repo_config_set(the_repository, buf.buf, "true");
 	}
 
 	if (fetch_tags != TAGS_DEFAULT) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.tagOpt", name);
-		git_config_set(buf.buf,
-			       fetch_tags == TAGS_SET ? "--tags" : "--no-tags");
+		repo_config_set(the_repository, buf.buf,
+				fetch_tags == TAGS_SET ? "--tags" : "--no-tags");
 	}
 
 	if (fetch && fetch_remote(name)) {
@@ -802,12 +802,12 @@ static int mv(int argc, const char **argv, const char *prefix,
 		if (info->remote_name && !strcmp(info->remote_name, rename.old_name)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
-			git_config_set(buf.buf, rename.new_name);
+			repo_config_set(the_repository, buf.buf, rename.new_name);
 		}
 		if (info->push_remote_name && !strcmp(info->push_remote_name, rename.old_name)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.pushRemote", item->string);
-			git_config_set(buf.buf, rename.new_name);
+			repo_config_set(the_repository, buf.buf, rename.new_name);
 		}
 	}
 
@@ -1503,7 +1503,7 @@ static int set_head(int argc, const char **argv, const char *prefix,
 		struct strbuf config_name = STRBUF_INIT;
 		strbuf_addf(&config_name,
 			"remote.%s.followremotehead", remote->name);
-		git_config_set(config_name.buf, "warn");
+		repo_config_set(the_repository, config_name.buf, "warn");
 		strbuf_release(&config_name);
 	}
 
@@ -1793,7 +1793,7 @@ static int set_url(int argc, const char **argv, const char *prefix,
 			git_config_set_multivar(name_buf.buf, newurl,
 						       "^$", 0);
 		else
-			git_config_set(name_buf.buf, newurl);
+			repo_config_set(the_repository, name_buf.buf, newurl);
 		goto out;
 	}
 
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 3985ed108eb..43b3be01143 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -56,8 +56,8 @@ void probe_utf8_pathname_composition(void)
 		close(output_fd);
 		repo_git_path_replace(the_repository, &path, "%s", auml_nfd);
 		precomposed_unicode = access(path.buf, R_OK) ? 0 : 1;
-		git_config_set("core.precomposeunicode",
-			       precomposed_unicode ? "true" : "false");
+		repo_config_set(the_repository, "core.precomposeunicode",
+				precomposed_unicode ? "true" : "false");
 		repo_git_path_replace(the_repository, &path, "%s", auml_nfc);
 		if (unlink(path.buf))
 			die_errno(_("failed to unlink '%s'"), path.buf);
diff --git a/config.c b/config.c
index 095a17bd429..285cab0ce2a 100644
--- a/config.c
+++ b/config.c
@@ -2748,7 +2748,7 @@ void git_die_config(struct repository *r, const char *key, const char *err, ...)
 }
 
 /*
- * Find all the stuff for git_config_set() below.
+ * Find all the stuff for repo_config_set() below.
  */
 
 struct config_store_data {
diff --git a/config.h b/config.h
index 90977441c3b..43d06c279e3 100644
--- a/config.h
+++ b/config.h
@@ -734,11 +734,6 @@ static inline int git_config_get_pathname(const char *key, char **dest)
 	return repo_config_get_pathname(the_repository, key, dest);
 }
 
-static inline void git_config_set(const char *key, const char *value)
-{
-	repo_config_set(the_repository, key, value);
-}
-
 static inline int git_config_set_in_file_gently(
 	const char *config_filename,
 	const char *key,
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 948376d42d0..7420bf81fe0 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -350,7 +350,7 @@ void partial_clone_register(
 
 		/* Add promisor config for the remote */
 		cfg_name = xstrfmt("remote.%s.promisor", remote);
-		git_config_set(cfg_name, "true");
+		repo_config_set(the_repository, cfg_name, "true");
 		free(cfg_name);
 	}
 
@@ -360,8 +360,8 @@ void partial_clone_register(
 	 */
 	filter_name = xstrfmt("remote.%s.partialclonefilter", remote);
 	/* NEEDSWORK: 'expand' result leaking??? */
-	git_config_set(filter_name,
-		       expand_list_objects_filter_spec(filter_options));
+	repo_config_set(the_repository, filter_name,
+			expand_list_objects_filter_spec(filter_options));
 	free(filter_name);
 
 	/* Make sure the config info are reset */
diff --git a/setup.c b/setup.c
index a05c348dcdf..98ddbf377f9 100644
--- a/setup.c
+++ b/setup.c
@@ -815,7 +815,7 @@ int upgrade_repository_format(int target_version)
 	}
 
 	strbuf_addf(&repo_version, "%d", target_version);
-	git_config_set("core.repositoryformatversion", repo_version.buf);
+	repo_config_set(the_repository, "core.repositoryformatversion", repo_version.buf);
 
 	ret = 1;
 
@@ -2233,14 +2233,14 @@ void initialize_repository_version(int hash_algo,
 		target_version = GIT_REPO_VERSION_READ;
 
 	if (hash_algo != GIT_HASH_SHA1_LEGACY && hash_algo != GIT_HASH_UNKNOWN)
-		git_config_set("extensions.objectformat",
-			       hash_algos[hash_algo].name);
+		repo_config_set(the_repository, "extensions.objectformat",
+				hash_algos[hash_algo].name);
 	else if (reinit)
 		repo_config_set_gently(the_repository, "extensions.objectformat", NULL);
 
 	if (ref_storage_format != REF_STORAGE_FORMAT_FILES)
-		git_config_set("extensions.refstorage",
-			       ref_storage_format_to_name(ref_storage_format));
+		repo_config_set(the_repository, "extensions.refstorage",
+				ref_storage_format_to_name(ref_storage_format));
 	else if (reinit)
 		repo_config_set_gently(the_repository, "extensions.refstorage", NULL);
 
@@ -2259,7 +2259,7 @@ void initialize_repository_version(int hash_algo,
 	}
 
 	strbuf_addf(&repo_version, "%d", target_version);
-	git_config_set("core.repositoryformatversion", repo_version.buf);
+	repo_config_set(the_repository, "core.repositoryformatversion", repo_version.buf);
 
 	strbuf_release(&repo_version);
 }
@@ -2375,17 +2375,17 @@ static int create_default_files(const char *template_path,
 		if (filemode && !reinit && (st1.st_mode & S_IXUSR))
 			filemode = 0;
 	}
-	git_config_set("core.filemode", filemode ? "true" : "false");
+	repo_config_set(the_repository, "core.filemode", filemode ? "true" : "false");
 
 	if (is_bare_repository())
-		git_config_set("core.bare", "true");
+		repo_config_set(the_repository, "core.bare", "true");
 	else {
-		git_config_set("core.bare", "false");
+		repo_config_set(the_repository, "core.bare", "false");
 		/* allow template config file to override the default */
 		if (repo_settings_get_log_all_ref_updates(the_repository) == LOG_REFS_UNSET)
-			git_config_set("core.logallrefupdates", "true");
+			repo_config_set(the_repository, "core.logallrefupdates", "true");
 		if (needs_work_tree_config(original_git_dir, work_tree))
-			git_config_set("core.worktree", work_tree);
+			repo_config_set(the_repository, "core.worktree", work_tree);
 	}
 
 	if (!reinit) {
@@ -2398,12 +2398,12 @@ static int create_default_files(const char *template_path,
 		    S_ISLNK(st1.st_mode))
 			unlink(path.buf); /* good */
 		else
-			git_config_set("core.symlinks", "false");
+			repo_config_set(the_repository, "core.symlinks", "false");
 
 		/* Check if the filesystem is case-insensitive */
 		repo_git_path_replace(the_repository, &path, "CoNfIg");
 		if (!access(path.buf, F_OK))
-			git_config_set("core.ignorecase", "true");
+			repo_config_set(the_repository, "core.ignorecase", "true");
 		probe_utf8_pathname_composition();
 	}
 
@@ -2639,8 +2639,8 @@ int init_db(const char *git_dir, const char *real_git_dir,
 			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_EVERYBODY);
 		else
 			BUG("invalid value for shared_repository");
-		git_config_set("core.sharedrepository", buf);
-		git_config_set("receive.denyNonFastforwards", "true");
+		repo_config_set(the_repository, "core.sharedrepository", buf);
+		repo_config_set(the_repository, "receive.denyNonFastforwards", "true");
 	}
 
 	if (!(flags & INIT_DB_QUIET)) {

-- 
2.50.1.552.g942d659e1b.dirty

