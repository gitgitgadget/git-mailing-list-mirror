Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5FF2F2735
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279754; cv=none; b=q+918cWkuI0mXw1kNM+DL+DjTgP40TlFU+wpy+M2+TWaPNV0Ae1ujZKIPjeFZVp78TtzllGsvFKvYbuEIRHYPURUSIMtJnvWiWXBdaSc7rcOfDxvXH7tCBJFOPvBZcObMm5Ev5aWdDCeRA/qCDscf6IMHRTEzULWOuTlQUgky5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279754; c=relaxed/simple;
	bh=R7tbYm0DkoDjtVGZfm2QlNs+L78Pf8caLGU7mSe28z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rF0/A3hwjGWob4h9p84ZOaXdm25xWWuwwjpXLgYrvb3iRCAjqYdw4ViWidpnJ3hQWY3BRR33bJmCtMFOii1QMe/T/X+fiabQF1ajzAFJiqAgdLuaSL65mRjH2k+FybijVHGCuJSg9PXwzxZDJG+FhcYav5IHiBmtaMGE0UVmyEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C3Ak+WfV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VJ3AyaGG; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C3Ak+WfV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VJ3AyaGG"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B01BEC19D2;
	Wed, 23 Jul 2025 10:09:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Jul 2025 10:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279751;
	 x=1753366151; bh=4p86StaBTsbyRourUDZbVv97MXKz/5pukNFFHJSVqYQ=; b=
	C3Ak+WfVdIhr2pn64x/F6OWGeH4+wI3bATJnjJzZn5RhwEi50pFxaGXZ8enlDqf9
	vaYC4S+P6BGZyTNvJ4wvsuhoiXfZ8VWzaTBWprRBkmAqRkX5wlA/6y2aGK345LcQ
	zzh/dAkv4B85ZOM0J8xTsTT+Y5Hq6VUxYfG7gMOFFyzOBvvSBV0Rzb74d9P7j1Zy
	9uXCfskeXXwA/RkgwoNVBfPLfmFY/LXlpuMzSlY93uzxXV6p+0BoXQAZ8xyU+TtX
	J+1O6WKCyzOLfrqaCtG4PX3Pe7ynKPsL8tPuE7+Q37W4HvNTOxDgzHn6DYI54z8v
	T/kVGyYBmNgC882sHo/8iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279751; x=
	1753366151; bh=4p86StaBTsbyRourUDZbVv97MXKz/5pukNFFHJSVqYQ=; b=V
	J3AyaGGPgSK281TH9ADqY0ou9GlWTelZuP4tweul/Kx/y+QoOW6MaoZFUJNVm6b9
	udOniLf/+sDe09dyrgqoJDT62NFoWR4QjTFvl5oNvV6edfqvDixVnjwGwb+oZ2Ce
	pFs/A+AlaJ2EpEUi88Zu5WfqIoE9FYQBYWY5stK/AtoCw9kCKFpfJ15rKdYjt0BB
	49SV4K0oW+yneKiIONLVH5twWjvPTEeMCkAUhUBP82UBX/91s9kHglISPGgOGErS
	1twa05oRvMX0+Gwd/OtBFRrhMX+a3pZW1dggcLud3tkDFzy2Mix65Y4x0e0c3vvS
	TVCuJxLex9KsI3RUMFY2w==
X-ME-Sender: <xms:B-2AaAnLNz8t_5E64hamaBi-5u1ydXvnitSBjCN5c91JE74d6GiBsw>
    <xme:B-2AaAB_wDljbOoPhI563mbhgZnaI2NkfrenXmNN2mHjDjQBUBelaDwvX_Nr1Ci1v
    HyFBzCUjY5ACMpEIQ>
X-ME-Received: <xmr:B-2AaAdc6sSzfMEASctVMFq-24-5NYjHpbD3qgbRUcXXIHBb8ecjVZmCg4YREkHsYPNF0i-aEN4I9usTpWIuVnTLgIPesGUEAQnjtcyimpP_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:B-2AaLL2sTic2_3nf9h6qscUxkRojTwpVScqzA_EbcRuUrWwh7L55Q>
    <xmx:B-2AaDfhGW37LXDizyB75Qut9SPCYvBk-FS8xd_MAh2XYZmNE4FLBQ>
    <xmx:B-2AaC0BpeAXM1f8MzzoP7m6pegpPBik9dhIxLk1OciHlXvIs_0TKA>
    <xmx:B-2AaMjlnbIeTr6oprnRLv22RajViibaYuCgcCM9-bBKMe5zQOd3ug>
    <xmx:B-2AaG0gaMgQuTxIqLCmkz15N2Y-QOFkoiu5tKGpaVaQ6Rhaar0m5n7e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:09:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e39b17ab (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:09:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:34 +0200
Subject: [PATCH v2 13/21] config: drop `git_config_set_gently()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-13-1502d60d3867@pks.im>
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
2.50.1.552.g942d659e1b.dirty

