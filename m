Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA131D5CD1
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983033; cv=none; b=QA+hyaFDalrryCgYi3LViGU4H4JBBLCwHtZRFnYy/wP/6RoWasHcI1V9coXMI9rEkkVX7r2eau0Fe+w+d7ClojVRKduHi4cMCq3IvkfhTzKxcbBwND9iR1112jPuN22cgwxqFrOSlBUwm3dDS5wZJMNGtJD/Ck6QurYXKzuEpgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983033; c=relaxed/simple;
	bh=WV1yaMIN3FwhLuznmmHZ2bX3BZF3IhRNzYQVf9N2+64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smK/0NJPdNBDdcETQK9pEQvRsC0hbdjsloMh6uGmOEaB0Adb1jpoj3u4n+H/jRObUus0mwcQZtk1bkdV3be+sdP/4sjkkQP9FtWwAh6XoGkGX8wvIVQ5/NIUKfHSacoWO5i4OiMMC5FKGs28mOn3klsxlWg3tXbjZ6/XCQyA+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFkZyulu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFkZyulu"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4530921461aso31144475e9.0
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 06:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751983030; x=1752587830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jthzfr/RxIgmwE+HEwkY8jK7EcHiwu+I0cM1eiAIbYo=;
        b=hFkZyuluBNLoSp+BXp1ATIcVVQbebJDIryVTBojKn8Q+W5iF2zpBxhu7C03rFQJ/vU
         PdZIwOF7boBy8aGoZdbFMQziqFWjL6oJ6IDCJNJ11QL+Awuo6uHCZQNYDCbQXroM8MZ3
         nKIFTFVv1GLjhO4+/sne+aY0jT+CSK2ljo6tZmEX9TsRz5f7F2HTP2TiutZctbiSFMlM
         b2FzA7K9vZJdlZycHb8R84c83gmPp9RypiAlXISWasQslSg+lYmEeOSEkKJUtIAW9hG3
         JapQnkON0vuNJl5+qcQk75dpfdQdXTDOQfL/kIn5F+V2Sd1EM3omWKx1GyWgOOwRuohf
         layA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983030; x=1752587830;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jthzfr/RxIgmwE+HEwkY8jK7EcHiwu+I0cM1eiAIbYo=;
        b=PkudS8flN6DLs8Fx/fuksCxGhMHY0syAMIlmxe9MihOs9r1PXRoaKeQI04LtXlT7b9
         Nh0jUdm/Tx6j3/Efn/ChQrkYFJ2B1rnN+/0SH/tm4qMLCBjxSTYdkH4pUtbZs9+Ps/S5
         r4MQrq1Twul+s+Iyr8QzWPbYqOh2v+QvqVMVBig1SnxZYSQXA9mEnS7Xz6gwgpQ+C3bD
         +IUP+++GVOvtiWWzEYxHe8NYVj510egFS69shMHbhfeUc3pvxoPlVHZaZsp65gNyDefO
         /8BHAyaN8Z0XDkwVZ4bQ1jn/MFjkP3hIcFaUXgwfP7pEQWb/xGzNmqwv6k315RR3Y/S0
         NQNA==
X-Gm-Message-State: AOJu0YwYsIprpdkuvkMG/MbEw02w+acvUm3RSr3U7vnakeURU7KgUqHc
	5srhMFDJok2pOZ7wisN2BiSSORZF9Mw+2mmLURzWRPBLzHXUv1423tmbOs+lgg==
X-Gm-Gg: ASbGncuEeETQtb1NjMkW/qCj0CCdmcriVCssrtrk7s8Xcm7WrVsUUOUdyNDtmHpONXO
	EnIV03pVeG7OT6Uwcn8OcuG1+ffNYBnlDUNDoTJvaCBppkWro4D9LI3erglzILFbskZ86g7cFwo
	98N0tKPGMeUVpVZTLO04gNNkKJc5C3A9OtDjImWImQaHHVTI/Yi4earaLafRI25qSMUBiaOtUvU
	3nxuGyLjTLCPJduaVR4Kk41Q+8ql4UIoehxURK5DJ6KKCrhWg8RhKUR4BYPTZE9S+eyBqjU/AmH
	e+Jx05ODcIN9kKYGn9pd3eJWX+GvAP6twi5rI0CEYVKusgMQi1P//UDCn52+R7R9Op9J+LOgPsO
	gbJ+a0rs=
X-Google-Smtp-Source: AGHT+IGLtLEhybP2gi+Wtzm/e3tBpKaKzv1R9QzNnNmr3bxC95oZuwsKlaZYojnhGyq4KAUKlIjFyQ==
X-Received: by 2002:adf:9cc2:0:b0:3b5:e244:52f9 with SMTP id ffacd0b85a97d-3b5e24453b1mr631669f8f.40.1751983029480;
        Tue, 08 Jul 2025 06:57:09 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b470f871casm13089252f8f.45.2025.07.08.06.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:57:09 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/2] commit: print advice when core.commentString=auto
Date: Tue,  8 Jul 2025 14:56:52 +0100
Message-ID: <83d0d3ece86811452614ee5e567481588b135632.1751983009.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Support for this config setting was deprecated in the last commit
so print some advice to help the user update their config settings
when they are using this setting. The advice message explains that the
setting is deprecated and will be removed in future. It also shows the
commands that the user needs to run to either unset core.commentChar
and core.commentString completely or to change the current setting
to a fixed comment string.

In order to generate this advice we need to parse the config with a
callback that records each file where either of the keys is set and
whether a key occurs more that once in a given file. This lets us
generate the list of commands to remove all the keys and also tells us
which key the "auto" setting comes from. The hard coding of some
filenames in add_config_scope_arg() is unfortunate but as this temporary
code that will be removed when Git 3.0 is released I decided it wasn't
worth adding functions to get the name of the local and worktree config
files.

As we want the user to update their config we do not provide a way for
this advice to be disabled other than changing the value of
core.commentChar or core.commentString.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c            | 188 ++++++++++++++++++++++++++++++++++++
 t/t7502-commit-porcelain.sh |  28 +++++-
 2 files changed, 215 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8794b24572b..21839db7fce 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -41,6 +41,8 @@
 #include "commit-reach.h"
 #include "commit-graph.h"
 #include "pretty.h"
+#include "quote.h"
+#include "strmap.h"
 #include "trailer.h"
 
 static const char * const builtin_commit_usage[] = {
@@ -684,12 +686,198 @@ static int author_date_is_interesting(void)
 }
 
 #ifndef WITH_BREAKING_CHANGES
+struct comment_char_cfg {
+	unsigned last_key_id;
+	int auto_set_in_file;
+	struct strintmap key_flags;
+	size_t alloc, nr;
+	struct comment_char_cfg_item {
+		unsigned key_id;
+		char *path;
+		enum config_scope scope;
+	} *item;
+};
+
+#define COMMENT_CHAR_CFG_INIT { .key_flags = STRINTMAP_INIT }
+
+static void comment_char_cfg_release(struct comment_char_cfg *cfg)
+{
+	strintmap_clear(&cfg->key_flags);
+	for (size_t i = 0; i < cfg->nr; i++)
+		free(cfg->item[i].path);
+	free(cfg->item);
+}
+
+/* Used to track whether the key occurs more than once in a given file */
+#define KEY_SEEN_ONCE 1u
+#define KEY_SEEN_TWICE 2u
+#define COMMENT_KEY_SHIFT(id) (2 * (id))
+#define COMMENT_KEY_MASK(id) (3u << COMMENT_KEY_SHIFT(id))
+
+static void set_comment_key_flags(struct comment_char_cfg *cfg,
+				  const char *path, unsigned id, unsigned value)
+{
+	unsigned old = strintmap_get(&cfg->key_flags, path);
+	unsigned new = (old & ~COMMENT_KEY_MASK(id)) |
+				value << COMMENT_KEY_SHIFT(id);
+
+	strintmap_set(&cfg->key_flags, path, new);
+}
+
+static unsigned get_comment_key_flags(struct comment_char_cfg *cfg,
+				      const char *path, unsigned id)
+{
+	unsigned value = strintmap_get(&cfg->key_flags, path);
+
+	return (value & COMMENT_KEY_MASK(id)) >> COMMENT_KEY_SHIFT(id);
+}
+
+static const char* comment_key_name(unsigned id)
+{
+	static const char *name[] = {
+		"core.commentChar", "core.commentString",
+	};
+
+	if (id >= ARRAY_SIZE(name))
+		BUG("invalid comment key id");
+
+	return name[id];
+}
+
+static int comment_char_config_cb(const char *key, const char *value,
+				  const struct config_context *ctx, void *data)
+{
+	struct comment_char_cfg *cfg = data;
+	const struct key_value_info *kvi = ctx->kvi;
+	unsigned key_id;
+
+	if (!strcmp(key, "core.commentchar"))
+		key_id = 0;
+	else if (!strcmp(key, "core.commentstring"))
+		key_id = 1;
+	else
+		return 0;
+
+	cfg->last_key_id = key_id;
+	if (!kvi->path) {
+		return 0;
+	} else if (get_comment_key_flags(cfg, kvi->path, key_id)) {
+		set_comment_key_flags(cfg, kvi->path, key_id, KEY_SEEN_TWICE);
+	} else {
+		struct comment_char_cfg_item *item;
+
+		ALLOC_GROW_BY(cfg->item, cfg->nr, 1, cfg->alloc);
+		item = &cfg->item[cfg->nr - 1];
+		item->key_id = key_id;
+		item->scope = kvi->scope;
+		item->path = xstrdup(kvi->path);
+		set_comment_key_flags(cfg, kvi->path, key_id, KEY_SEEN_ONCE);
+	}
+	cfg->auto_set_in_file =	value && !strcmp(value, "auto");
+
+	return 0;
+}
+
+static void add_config_scope_arg(struct strbuf *buf,
+				 struct comment_char_cfg_item *item)
+{
+	char *global_config = git_global_config();
+	char *system_config = git_system_config();
+
+	if (fspatheq(item->path, system_config)) {
+		strbuf_addstr(buf, "--system ");
+	} else if (fspatheq(item->path, global_config)) {
+		strbuf_addstr(buf, "--global ");
+	} else if (fspatheq(item->path,
+			    mkpath("%s/config",
+				   repo_get_git_dir(the_repository)))) {
+		; /* --local is the default */
+	} else if (fspatheq(item->path,
+			    mkpath("%s/config.worktree",
+				   repo_get_common_dir(the_repository)))) {
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
+static void add_optional_comment_char_advice(struct comment_char_cfg *cfg)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct comment_char_cfg_item *item;
+	/* TRANSLATORS this is a place holder for the value of core.commentString */
+	const char *placeholder = _("<comment string>");
+
+	/*
+	 * If auto is set in the last file that we saw advise the user how to
+	 * update their config.
+	 */
+	if (!cfg->auto_set_in_file)
+		return;
+
+	for (size_t i = 0; i < cfg->nr; i++) {
+		item = &cfg->item[i];
+
+		strbuf_addstr(&buf, "    git config unset ");
+		add_config_scope_arg(&buf, item);
+		if (get_comment_key_flags(cfg, item->path, item->key_id) == KEY_SEEN_TWICE)
+			strbuf_addstr(&buf, "--all ");
+		strbuf_addf(&buf, "%s\n", comment_key_name(item->key_id));
+	}
+	advise(_("\nTo use the default comment string (#) please run\n\n%s"),
+	       buf.buf);
+
+	item = &cfg->item[cfg->nr - 1];
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "    git config set ");
+	add_config_scope_arg(&buf, item);
+	strbuf_addf(&buf, "%s %s\n", comment_key_name(item->key_id),
+		    placeholder);
+	advise(_("\nTo set a custom comment string please run\n\n"
+		 "%s\nwhere '%s' is the string you wish to use.\n"),
+	       buf.buf, placeholder);
+	strbuf_release(&buf);
+}
+
+static void advise_auto_comment_char(void)
+{
+	struct comment_char_cfg cfg = COMMENT_CHAR_CFG_INIT;
+	struct config_options opts = {
+		.commondir = repo_get_common_dir(the_repository),
+		.git_dir = repo_get_git_dir(the_repository),
+		.respect_includes = 1,
+	};
+
+	config_with_options(comment_char_config_cb, &cfg, NULL, the_repository,
+			    &opts);
+	advise(_("Support for '%s=auto' is deprecated and will be removed in "
+		 "git 3.0\n"), comment_key_name(cfg.last_key_id));
+	add_optional_comment_char_advice(&cfg);
+	comment_char_cfg_release(&cfg);
+}
+
 static void adjust_comment_line_char(const struct strbuf *sb)
 {
 	char candidates[] = "#;@!$%^&|:";
 	char *candidate;
 	const char *p;
 
+	advise_auto_comment_char();
+
 	if (!memchr(sb->buf, candidates[0], sb->len)) {
 		free(comment_line_str_to_free);
 		comment_line_str = comment_line_str_to_free =
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 65b4519a715..c8c00d316be 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -958,7 +958,33 @@ test_expect_success 'commit --status with custom comment character' '
 
 test_expect_success !WITH_BREAKING_CHANGES 'switch core.commentchar' '
 	test_commit "#foo" foo &&
-	GIT_EDITOR=.git/FAKE_EDITOR git -c core.commentChar=auto commit --amend &&
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
+	sed -n "/^hint: *\$/s///p; /^hint: /s///p" err >actual &&
+	cat >expect <<-EOF &&
+	Support for ${SQ}core.commentChar=auto${SQ} is deprecated and will be removed in git 3.0
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
+	EOF
+	test_cmp expect actual &&
 	test_grep "^; Changes to be committed:" .git/COMMIT_EDITMSG
 '
 
-- 
2.49.0.897.gfad3eb7d210

