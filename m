Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE9A15A8
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975351; cv=none; b=qunUf2zo8TA9fCUoxsJ5vscPICD2qNEMhNkpOlmqdkZknqWIQjBaT9S/01sRxDQVe+XPipHLgzEhZUxBU282XXQK9eIbaeaDAU0ZWm9Nm4br+WlRIWaR4tUjiG7s8NFPFWCsVFaW3hDw5RFM4YmCdVbquVz9AvK5WN8ZwN3bX5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975351; c=relaxed/simple;
	bh=+uzJ80ZfZ+vGurE9mIbucd3TOkNVgmwAcKeIJA/GYTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5QYjFpPjY3dFZ4A9OJu04+merwLKGEF9b2hsfch2m9CDQk3D5w1pYfPNabL1HyINAZbgKwnyt5Y2O1XXrXVM+KmLHpJd0B9dQLWbvBF4jWr0jC+r7bgO2KDn9qTDkLdt9xjVYxfIlWn3FrwpIGrHk218YxghHus9uVOYsN8grw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSNhIQ+p; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSNhIQ+p"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so7635675e9.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753975348; x=1754580148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bIhxW+mFusqJdvIbDZ/Sakw6XhhE6vMf0By5jxVls1c=;
        b=gSNhIQ+poAiqUUROG0jJv/fugGgsPQtaaNQXNZrBrCsppmJdcFVw69076wgpSVlS1a
         wdcb7r76S0zN12sYqO/4MZNYV1dcL51Ive/valqqN30lkScQ6Ng7obv8918d0mCRYhBB
         zdKxME2sCHJFqrNUQY8uPDNSHGcC1wDhCSQTVKxYd6yJXsurbyFvna0bxi0lXPo72mZJ
         /qHNcLv2cblyNbzeilpLYp6WT86ejY8ckFwn1c99AiHCukL13Zgfab8CKEldLW479OtZ
         b5qPFVjbzMlzY5SbKoL3CKgGYaSjhmYLxc+3epR/qpDpNgrl7AHk0hLguvKuTjlpSk6v
         7CsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753975348; x=1754580148;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIhxW+mFusqJdvIbDZ/Sakw6XhhE6vMf0By5jxVls1c=;
        b=lY7ywJdKlz9glmCJBH+QZbGodVE/ZAmA4y6zqgBVy/uQBUnOpqTx7hje/ErAPe8xdh
         8oR3krCdo2pdvgHx/EqaEKOHLyVoE7uQKBGzc1Qu/7wCHmdnznD5I9PA5ndMpqHwT0Si
         PzBnyKEVV24vMYXJdZf4k+zlcmbuEfZlxiJ8we4yRQyoWPe7HczOBGfYExi0XpQhH2Il
         7hSZJqNZOx8qMUswff6gAQuEq55F75+YlxUX7SDDWNcYOPV0I1OlcNC7eOaQ8cyDpxyo
         umPMXgu1zObzx9mJeozYwynR9U5cerqX4WEz+o2kzuzCq5We1zwtS9q9vqvpvPU1yPOZ
         89NQ==
X-Gm-Message-State: AOJu0YyHS9dMAuwNLIFUt9yC/qJL+wyECHs4YLI+fRvhvYO5QhrvUumr
	K1BHEMIVPSfAUMvOxEzFkQOJ7t/AD6gNLMfxPxI91P8HYGS0k9J/T+vaSLqunQ==
X-Gm-Gg: ASbGncu1LtPlqFvdDYrNQUXuKI+AN4m9YOTkg8Jm9Vs9crSvxfwO4Vr4LqiE54nV8iW
	esyYD+NfmdCEmBD5tcSIQDSacKH36vEZO4ocel6w6QE26f9IFfFJhrmSU93qDjMlk/XN8sf4Y54
	VSP60K2+B/VaqJ6TlxfllPQdQMdNHgTt81Edp3UbxgdHFuhLl6+lhbaaV5E6BQZwkYb3ACu3upT
	kin07RyybRkqqRpfMMuBmbUQYNSBefS4Un7bAYY+JVSmgItWP2QKcDtoH4KYJ4u4XJXpHBEtzai
	ZFMo+s5APRNzeYePrSGlznjCN6zcBo2iW4/BKC8bwe2iy+MthzWPINo6pznIVgN3hJQJOtwfdIe
	f8iMQozjwyEJ7uVz0TNbnY0M4R4ZSBZCUVuwlbR4bQK2J
X-Google-Smtp-Source: AGHT+IF9viGFBCCwY5ekHdHIvELYbGTlcXhdwCwqaimOawJYLmB3VESxtBi/LOlQAsoysAbShDNgLw==
X-Received: by 2002:a05:600c:3d8d:b0:456:f22:ca49 with SMTP id 5b1f17b1804b1-458a17e6e41mr26439685e9.0.1753975347728;
        Thu, 31 Jul 2025 08:22:27 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533e6sm2842426f8f.35.2025.07.31.08.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:22:27 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 3/3] commit: print advice when core.commentString=auto
Date: Thu, 31 Jul 2025 16:21:55 +0100
Message-ID: <0e7c08b15e5923ae03f5630a8286c7dcebdbcfb9.1753975294.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1753975294.git.phillip.wood@dunelm.org.uk>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk> <cover.1753975294.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add some advice on how to change the config settings when
"core.commentString=auto" or "core.commentChar=auto". The advice
includes instructions for clearing the config setting or setting a
fixed comment string. To try and be as specific as possible, the advice
is customized based on the user's config. If "core.commentString=auto"
is set in the system config and the user does not have write
access then the advice omits the instructions to clear the config
and recommends changing the global config instead. An alternative
approach would be to advise the user to run "git config --show-origin"
and leave them to figure out how to fix it themselves but that seems
rather unfriendly. As we're forcing them to update their config we
should try and make that as easy as possible.

In order to generate this advice we need to record each file where
either of the config keys is set and whether a key occurs more that
once in a given file. This lets us generate the list of commands to
remove all the keys and also tells us which key the "auto" setting
comes from.

As we want the user to update their config we do not provide a way
for this advice to be disabled other than changing the value of
"core.commentChar" or "core.commentString".

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 config.c                      | 195 ++++++++++++++++++++++++++++++++--
 t/t3404-rebase-interactive.sh |  12 ++-
 t/t7502-commit-porcelain.sh   |  37 ++++++-
 3 files changed, 233 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index c36ead76005..e04cb386161 100644
--- a/config.c
+++ b/config.c
@@ -1956,9 +1956,51 @@ int git_configset_get_pathname(struct config_set *set, const char *key, char **d
 struct comment_char_config {
 	unsigned last_key_id;
 	bool auto_set;
+	bool auto_set_in_file;
+	struct strintmap key_flags;
+	size_t alloc, nr;
+	struct comment_char_config_item {
+		unsigned key_id;
+		char *path;
+		enum config_scope scope;
+	} *item;
 };
 
-#define COMMENT_CHAR_CFG_INIT { 0 }
+#define COMMENT_CHAR_CFG_INIT {			\
+		.key_flags = STRINTMAP_INIT,	\
+	}
+
+static void comment_char_config_release(struct comment_char_config *config)
+{
+	strintmap_clear(&config->key_flags);
+	for (size_t i = 0; i < config->nr; i++)
+		free(config->item[i].path);
+	free(config->item);
+}
+
+/* Used to track whether the key occurs more than once in a given file */
+#define KEY_SEEN_ONCE 1u
+#define KEY_SEEN_TWICE 2u
+#define COMMENT_KEY_SHIFT(id) (2 * (id))
+#define COMMENT_KEY_MASK(id) (3u << COMMENT_KEY_SHIFT(id))
+
+static void set_comment_key_flags(struct comment_char_config *config,
+				  const char *path, unsigned id, unsigned value)
+{
+	unsigned old = strintmap_get(&config->key_flags, path);
+	unsigned new = (old & ~COMMENT_KEY_MASK(id)) |
+				value << COMMENT_KEY_SHIFT(id);
+
+	strintmap_set(&config->key_flags, path, new);
+}
+
+static unsigned get_comment_key_flags(struct comment_char_config *config,
+				      const char *path, unsigned id)
+{
+	unsigned value = strintmap_get(&config->key_flags, path);
+
+	return (value & COMMENT_KEY_MASK(id)) >> COMMENT_KEY_SHIFT(id);
+}
 
 static const char* comment_key_name(unsigned id)
 {
@@ -1974,10 +2016,10 @@ static const char* comment_key_name(unsigned id)
 }
 
 static void comment_char_callback(const char *key, const char *value,
-				  const struct config_context *ctx UNUSED,
-				  void *data)
+				  const struct config_context *ctx, void *data)
 {
 	struct comment_char_config *config = data;
+	const struct key_value_info *kvi = ctx->kvi;
 	unsigned key_id;
 
 	if (!strcmp(key, "core.commentchar"))
@@ -1989,7 +2031,135 @@ static void comment_char_callback(const char *key, const char *value,
 
 	config->last_key_id = key_id;
 	config->auto_set = value && !strcmp(value, "auto");
-}
+	if (kvi->origin_type != CONFIG_ORIGIN_FILE) {
+		return;
+	} else if (get_comment_key_flags(config, kvi->filename, key_id)) {
+		set_comment_key_flags(config, kvi->filename, key_id,
+				      KEY_SEEN_TWICE);
+	} else {
+		struct comment_char_config_item *item;
+
+		ALLOC_GROW_BY(config->item, config->nr, 1, config->alloc);
+		item = &config->item[config->nr - 1];
+		item->key_id = key_id;
+		item->scope = kvi->scope;
+		item->path = xstrdup(kvi->filename);
+		set_comment_key_flags(config, kvi->filename, key_id,
+				      KEY_SEEN_ONCE);
+	}
+	config->auto_set_in_file = config->auto_set;
+}
+
+static void add_config_scope_arg(struct repository *repo, struct strbuf *buf,
+				 struct comment_char_config_item *item)
+{
+	char *global_config = git_global_config();
+	char *system_config = git_system_config();
+
+	if (item->scope == CONFIG_SCOPE_SYSTEM && access(item->path, W_OK)) {
+		/*
+		 * If the user cannot write to the system config recommend
+		 * setting the global config instead.
+		 */
+		strbuf_addstr(buf, "--global ");
+	} else if (fspatheq(item->path, system_config)) {
+		strbuf_addstr(buf, "--system ");
+	} else if (fspatheq(item->path, global_config)) {
+		strbuf_addstr(buf, "--global ");
+	} else if (fspatheq(item->path,
+			    mkpath("%s/config",
+				   repo_get_git_dir(repo)))) {
+		; /* --local is the default */
+	} else if (fspatheq(item->path,
+			    mkpath("%s/config.worktree",
+				   repo_get_common_dir(repo)))) {
+		strbuf_addstr(buf, "--worktree ");
+	} else {
+		const char *path = item->path;
+		const char *home = getenv("HOME");
+
+		strbuf_addstr(buf, "--file ");
+		if (home && !fspathncmp(path, home, strlen(home))) {
+			path += strlen(home);
+			if (!fspathncmp(path, "/", 1))
+				path++;
+			strbuf_addstr(buf, "~/");
+		}
+		sq_quote_buf_pretty(buf, path);
+		strbuf_addch(buf, ' ');
+	}
+
+	free(global_config);
+	free(system_config);
+}
+
+static bool can_unset_comment_char_config(struct comment_char_config *config)
+{
+	for (size_t i = 0; i < config->nr; i++) {
+		struct comment_char_config_item *item = &config->item[i];
+
+		if (item->scope == CONFIG_SCOPE_SYSTEM &&
+		    access(item->path, W_OK))
+			return false;
+	}
+
+	return true;
+}
+
+static void add_unset_auto_comment_char_advice(struct repository *repo,
+					       struct comment_char_config *config)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!can_unset_comment_char_config(config))
+		return;
+
+	for (size_t i = 0; i < config->nr; i++) {
+		struct comment_char_config_item *item = &config->item[i];
+
+		strbuf_addstr(&buf, "    git config unset ");
+		add_config_scope_arg(repo, &buf, item);
+		if (get_comment_key_flags(config, item->path, item->key_id) == KEY_SEEN_TWICE)
+			strbuf_addstr(&buf, "--all ");
+		strbuf_addf(&buf, "%s\n", comment_key_name(item->key_id));
+	}
+	advise(_("\nTo use the default comment string (#) please run\n\n%s"),
+	       buf.buf);
+	strbuf_release(&buf);
+}
+
+static void add_comment_char_advice(struct repository *repo,
+				    struct comment_char_config *config)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct comment_char_config_item *item;
+	/* TRANSLATORS this is a place holder for the value of core.commentString */
+	const char *placeholder = _("<comment string>");
+
+	/*
+	 * If auto is set in the last file that we saw advise the user how to
+	 * update their config.
+	 */
+	if (!config->auto_set_in_file)
+		return;
+
+	add_unset_auto_comment_char_advice(repo, config);
+	item = &config->item[config->nr - 1];
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "    git config set ");
+	add_config_scope_arg(repo, &buf, item);
+	strbuf_addf(&buf, "%s %s\n", comment_key_name(item->key_id),
+		    placeholder);
+	advise(_("\nTo set a custom comment string please run\n\n"
+		 "%s\nwhere '%s' is the string you wish to use.\n"),
+	       buf.buf, placeholder);
+	strbuf_release(&buf);
+}
+
+#undef KEY_SEEN_ONCE
+#undef KEY_SEEN_TWICE
+#undef COMMENT_KEY_SHIFT
+#undef COMMENT_KEY_MASK
 
 struct repo_config {
 	struct repository *repo;
@@ -2001,18 +2171,26 @@ struct repo_config {
 		.repo = repo_,					\
 	};
 
+static void repo_config_release(struct repo_config *config)
+{
+	comment_char_config_release(&config->comment_char_config);
+}
+
 #ifdef WITH_BREAKING_CHANGES
-static void check_auto_comment_char_config(struct comment_char_config *config)
+static void check_auto_comment_char_config(struct repository *repo,
+					   struct comment_char_config *config)
 {
 	if (!config->auto_set)
 		return;
 
 	die_message(_("Support for '%s=auto' has been removed in Git 3.0"),
 		    comment_key_name(config->last_key_id));
+	add_comment_char_advice(repo, config);
 	die(NULL);
 }
 #else
-static void check_auto_comment_char_config(struct comment_char_config *config)
+static void check_auto_comment_char_config(struct repository *repo,
+					   struct comment_char_config *config)
 {
 	extern bool warn_on_auto_comment_char;
 	const char *DEPRECATED_CONFIG_ENV =
@@ -2032,6 +2210,7 @@ static void check_auto_comment_char_config(struct comment_char_config *config)
 
 	warning(_("Support for '%s=auto' is deprecated and will be removed in "
 		  "Git 3.0"), comment_key_name(config->last_key_id));
+	add_comment_char_advice(repo, config);
 }
 #endif /* WITH_BREAKING_CHANGES */
 
@@ -2040,7 +2219,8 @@ static void check_deprecated_config(struct repo_config *config)
 	if (!config->repo->check_deprecated_config)
 			return;
 
-	check_auto_comment_char_config(&config->comment_char_config);
+	check_auto_comment_char_config(config->repo,
+				       &config->comment_char_config);
 }
 
 static int repo_config_callback(const char *key, const char *value,
@@ -2083,6 +2263,7 @@ static void repo_read_config(struct repository *repo)
 		 */
 		die(_("unknown error occurred while reading the configuration files"));
 	check_deprecated_config(&config);
+	repo_config_release(&config);
 }
 
 static void git_config_check_init(struct repository *repo)
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3b2a46c25ce..cc97628d810 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1186,9 +1186,19 @@ test_expect_success !WITH_BREAKING_CHANGES 'rebase -i respects core.commentchar=
 		test_set_editor "$(pwd)/copy-edit-script.sh" &&
 		git rebase -i HEAD^ 2>err
 	) &&
-	sed -n "s/^warning: //p" err >actual &&
+	sed -n "s/^hint: *\$//p; s/^hint: //p; s/^warning: //p" err >actual &&
 	cat >expect <<-EOF &&
 	Support for ${SQ}core.commentChar=auto${SQ} is deprecated and will be removed in Git 3.0
+
+	To use the default comment string (#) please run
+
+	    git config unset core.commentChar
+
+	To set a custom comment string please run
+
+	    git config set core.commentChar <comment string>
+
+	where ${SQ}<comment string>${SQ} is the string you wish to use.
 	EOF
 	test_cmp expect actual &&
 	test -z "$(grep -ve "^#" -e "^\$" -e "^pick" edit-script)"
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index a9dc1e416d1..05f6da4ad98 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -958,10 +958,31 @@ test_expect_success 'commit --status with custom comment character' '
 
 test_expect_success !WITH_BREAKING_CHANGES 'switch core.commentchar' '
 	test_commit "#foo" foo &&
-	GIT_EDITOR=.git/FAKE_EDITOR git -c core.commentChar=auto commit --amend 2>err &&
-	sed -n "s/^warning: //p" err >actual &&
+	cat >config-include <<-\EOF &&
+	[core]
+	    commentString=:
+	    commentString=%
+	    commentChar=auto
+	EOF
+	test_when_finished "rm config-include" &&
+	test_config include.path "$(pwd)/config-include" &&
+	test_config core.commentChar ! &&
+	GIT_EDITOR=.git/FAKE_EDITOR git commit --amend 2>err &&
+	sed -n "s/^hint: *\$//p; s/^hint: //p; s/^warning: //p" err >actual &&
 	cat >expect <<-EOF &&
 	Support for ${SQ}core.commentChar=auto${SQ} is deprecated and will be removed in Git 3.0
+
+	To use the default comment string (#) please run
+
+	    git config unset core.commentChar
+	    git config unset --file ~/config-include --all core.commentString
+	    git config unset --file ~/config-include core.commentChar
+
+	To set a custom comment string please run
+
+	    git config set --file ~/config-include core.commentChar <comment string>
+
+	where ${SQ}<comment string>${SQ} is the string you wish to use.
 	EOF
 	test_cmp expect actual &&
 	test_grep "^; Changes to be committed:" .git/COMMIT_EDITMSG
@@ -990,9 +1011,19 @@ EOF
 test_expect_success WITH_BREAKING_CHANGES 'core.commentChar=auto is rejected' '
 	test_config core.commentChar auto &&
 	test_must_fail git rev-parse --git-dir 2>err &&
-	sed -n "s/^fatal: //p" err >actual &&
+	sed -n "s/^hint: *\$//p; s/^hint: //p; s/^fatal: //p" err >actual &&
 	cat >expect <<-EOF &&
 	Support for ${SQ}core.commentChar=auto${SQ} has been removed in Git 3.0
+
+	To use the default comment string (#) please run
+
+	    git config unset core.commentChar
+
+	To set a custom comment string please run
+
+	    git config set core.commentChar <comment string>
+
+	where ${SQ}<comment string>${SQ} is the string you wish to use.
 	EOF
 	test_cmp expect actual
 '
-- 
2.49.0.897.gfad3eb7d210

