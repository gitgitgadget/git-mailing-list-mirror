Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827E253355
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308472; cv=none; b=RYul/oCBw0weGbfxQKtP2qX62eqtruSTplGpP1l1OSlPYYgfHSFxV+NJpkH0FUHq20XAwQ+GYQ6knuIzZWK0PCCFXYEezrvpui8wqeyUj92X6CfULg4QSNN7jni+lD3PpDEZ278kh6RNxf7m9GL6XXd0JX4468Swq+/5/XW9PoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308472; c=relaxed/simple;
	bh=71l6u11Jgo/G5A8N39Eo6S6CqJXQbA0HoZoFE1HWvfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RORvBpzzaXmSmLsIM7YlhTZiwmu5uw9pNJV3ha1BzaKoEUGJqaypjMeDPJad/6SXTjadtIJGgC5GktRcr9oInvEHC9t3rdOp0iAXVEcKq6yO7xwWNBRXw6OOe2nn6QqHfeJ75M4v5PyKIsbiqvYUpt/uAu7HfvSMTaCgjou/r2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5V95mtE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5V95mtE"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c6743a10e3so3026333f8f.0
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308468; x=1756913268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZMEGlB/tuT73XjaXm0vjoqzQlvNJv3UVICJfG9X6Dck=;
        b=X5V95mtEVksjeOmInPPeYZhVF3DTv+qClYNR+rnEinPgUDbBLRbPqm/l2oiRqFuv7t
         UiYQtp9U1TyzWJ5LLdFnShEk9mFvY7R5JsZn8Gp9VcK/1SnTAwntBWsE3W6JOcaixdjb
         M03e2mYKMqQ968nEpgC1Z8YM02aEz3Kn/rihbmiGer3i9GoQJiv9qBUTXUfyMvhCss4g
         OB85AkR5if1Y+yXQdRziUFJvTPf+mneWPWYhxJT2dxyduegXz26RTwizA5DrLi1WkezY
         p0fvmEygonoCzRHjaxwmNzI1ZNinc/hD/kQWRCJhyprYXGIqzN1GBSGcQJh+t2oMYGwl
         2T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308468; x=1756913268;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMEGlB/tuT73XjaXm0vjoqzQlvNJv3UVICJfG9X6Dck=;
        b=MdMcuFMj8SHYrB1Iryg4flZwaMyycf58vu1p0C1mcl3LBZYDL+apJIs1ZC42pTr8A5
         EpFLsFlusT3MB1vIXndYHbEgTQ5Cl1FPLuoPkeXvghj+BFSK1s4g1+F2V84KLLgzZlSQ
         oi0pVUNwVYGIBohr/c8dYDNEBQ3I/Hg+puZbSvr+xs5F+SiTLjCgHhrjW/DYYBxPxBdo
         yjiA/AQNc9rJ/TYDfYMFjeEne5wXssj51/M6YGJhSdjE2lYDNT+WFWiLpuBPiaZ1TXOi
         JfbEHidMKR1cPhwvOkDt/M3/FkwF0vJlX7VimOYWa/tPZ75bPeBVsaUK//mr1P2/YkN9
         r3rg==
X-Gm-Message-State: AOJu0YyX2+GR1YXwQE5cmtdUPDfm8yBi5hwcodTUJ4oS/A+MW/1StVhd
	Q60pBFaLdHhsLw2N+6O5zDZN/XvXDedbDJ0RbQvlEHJ/SAEJBLfVU6+NTmm2sg==
X-Gm-Gg: ASbGncs+dQlEt7Y1EXFhcYYPfREdJpxRG2HgNg+RHXaL9htIjNFR412vV76gskT5asG
	LLNpDSScHcOJJw9VzGDDGNMngmnRDcAvLJ32Hbpl7iUMtqUk+37feQ/IFDnH1VPNVLBMiHlj1/f
	uYTU+YwjJ6wNhf7PVKpEPb8wxpztskv3e7r2P71CudCtKq/9TH3f8WXwq5eHD7mu6YjF/T+LvKZ
	z5FxvcALAiioXX9WRlTXbipEgM+4UO3gEI2KHxbuJZpGFu1AnMsWiFWF8fg9QNF6zxm7wl1np5t
	hfGkxLS1XARLzPvLr4GpLlmk9IIiefcwac/qXDhlI4rUz2LRl3W2WnlxVmY5GqbCGG5pX53IvwQ
	1i+r0T1dvZyMjmlxnrfc0jJiUaTmGZDk7G5qURBrUdf+XCw==
X-Google-Smtp-Source: AGHT+IE8akgPvLkxUUNUG77mroe0ywPgqHQq5tXI7gwSucyIVSn563LXlCC9T7DhGCdWXkllmo9/0w==
X-Received: by 2002:a05:6000:420d:b0:3c8:e9d3:c380 with SMTP id ffacd0b85a97d-3c8e9d3d035mr10047044f8f.0.1756308467996;
        Wed, 27 Aug 2025 08:27:47 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211bd7sm21511597f8f.38.2025.08.27.08.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:27:47 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 3/3] commit: print advice when core.commentString=auto
Date: Wed, 27 Aug 2025 16:27:30 +0100
Message-ID: <39d824db4aba5c2b70e5e9b2d86125de2e9605fc.1756308431.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1756308431.git.phillip.wood@dunelm.org.uk>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk> <cover.1756308431.git.phillip.wood@dunelm.org.uk>
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
 config.c                      | 196 ++++++++++++++++++++++++++++++++--
 t/t3404-rebase-interactive.sh |  12 ++-
 t/t7502-commit-porcelain.sh   |  37 ++++++-
 3 files changed, 234 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index 18b42197095..18dcf341d58 100644
--- a/config.c
+++ b/config.c
@@ -8,6 +8,7 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
+#include "advice.h"
 #include "date.h"
 #include "branch.h"
 #include "config.h"
@@ -1955,9 +1956,51 @@ int git_configset_get_pathname(struct config_set *set, const char *key, char **d
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
 
 static const char *comment_key_name(unsigned id)
 {
@@ -1973,10 +2016,10 @@ static const char *comment_key_name(unsigned id)
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
@@ -1988,7 +2031,135 @@ static void comment_char_callback(const char *key, const char *value,
 
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
@@ -2000,18 +2171,26 @@ struct repo_config {
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
@@ -2031,6 +2210,7 @@ static void check_auto_comment_char_config(struct comment_char_config *config)
 
 	warning(_("Support for '%s=auto' is deprecated and will be removed in "
 		  "Git 3.0"), comment_key_name(config->last_key_id));
+	add_comment_char_advice(repo, config);
 }
 #endif /* WITH_BREAKING_CHANGES */
 
@@ -2039,7 +2219,8 @@ static void check_deprecated_config(struct repo_config *config)
 	if (!config->repo->check_deprecated_config)
 			return;
 
-	check_auto_comment_char_config(&config->comment_char_config);
+	check_auto_comment_char_config(config->repo,
+				       &config->comment_char_config);
 }
 
 static int repo_config_callback(const char *key, const char *value,
@@ -2082,6 +2263,7 @@ static void repo_read_config(struct repository *repo)
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

