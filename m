Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ACD27B4E4
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308471; cv=none; b=LjTeDO68GIA2q0zmnENjtoi1Um0YPZ4TLwUrWvy2DINI2Fzvh3RIp4Afoi6Zivz3o2CV7eWqj6O0sxfzufbW2zr43g9qUVFfOhmxWCSY5hp9+3PfpyUctGdy/98u+egk+jnAyam2CuYdw7fr+nEmQ80DEwD+fkpvl6zHS0wLiFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308471; c=relaxed/simple;
	bh=IU7JAmpe85nEezgeGYy1mIrIvhh9Te5pw1Fr1aSLb8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQ+uNZLqJlG48xscLsXWTfobnoCT4RNyytCpB8sExmIyT+MeduPv/fIs9oW4/jibYcquwJSltPnEdJIoiF+gruTALILqmesDFW/eB93FQj6xs2RdznoO8awCVD6EZna0iw/yml4feigf0notkAPkR8v9OWExBenum1iyZynhqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfXUjoCI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfXUjoCI"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a286135c8so5749205e9.0
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308467; x=1756913267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XZ3CX8AJxL6dOPNoodIfvnjZ1vr5HVua0kakXUnUXUk=;
        b=YfXUjoCIvCtPuLtNlK5v7vbwkvXZc+BHIVjNGZkSKCy0YOm1wEtXAS31Y4vVBNwDGa
         wHRbig7flLyLnMzfI9EChqFtiTkr8ThLZp341ScIM4U8e6N2hxzlGjPVfjBil2pm1ivr
         uhh4R5HgM974uaFpcvQ21qShXkV/6xJ9XbRxOBhrpOM60VRwXvg3TazgVQBHeUkzjt9O
         gTyb1CCGVtvKze29+wELY/ltFmfPWcUY8mFJyyqYHaQckkAe0TYs+Aneb22YvRC3oMvQ
         TqzTO9sPGx7E5qmj7MdwXNLKf3ryeLaM6vL2BIZ+MAlUV5BHk9hxhTVpFSKuZ2B3hpws
         Ww+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308467; x=1756913267;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZ3CX8AJxL6dOPNoodIfvnjZ1vr5HVua0kakXUnUXUk=;
        b=AmjzlIx2Cza081ZcjN8ARtU7d/xkk1u5Rg/bOrcUAAzuzhpQUW8cpV3olrDjIJVNXp
         EIfNv5m6vcJVdxkG6LzC2EjsK1R+x+CN4KvYyXnM2WtqiFEnqpZKIml66Dn9gm9u3z7+
         IoA6nbZEuEApuyrFi1vrkGOZAyRoTST7bipWj8x2jdLr0ljzm9/IcQN4Y6UipgmZQsDj
         eB3vyU9d/E1ETWIZI/d6gm/QgR/t2SDPmYE0ShS+TmIJ2Vn6ezNx8PfcYg4/HlQfMlgH
         wy6UE+Nl3CnWEDTULgdBrZioUH33Ez4X6jcHLwjzk0IVR52pFT/nW4CyZ3iWIYY0Lar8
         Fsag==
X-Gm-Message-State: AOJu0Yze6N9NNO1OWdLuOdVsuyeSxuCEgUg0wzWISpCBeu9AysNHFeFz
	QmqZvNM7QeikcFxjs1fc+NMiGRkkbXPizVpns1fHTG5gf5YtswFCvV+6+lJ6gg==
X-Gm-Gg: ASbGncvbSU1xsth1Y2bKlRgSmWT2M9R94uZtU5hXjsuOj2XzJjZPYfYR1FB02Paj7f/
	BQ8IGJyW6fHLaUJ6a5jrj9xYvR/sK62znhUsuDusgRS5vMmp9Ha3CORJgwKsWbtWY7K0OZ5dnQ9
	CQUDuL62cGcgMjxsGf2wXP3W4nWcCEDVF1CxeuC9zVccCkQLARGcZqHxvdGiA7jivK+wxCJqP57
	dSspH4fuT9q+3Dm7jOWPJo1IrHbQJ6hyfm7m8fmv7PpQWJDiYHugdnGKMWas6FjUZqGRP5pE8M+
	Isnu0Qdgor3+MrFSe3cZ02/fIEzWjHdN5dTfwgBywFzU0pa6W+pFkg4dAGLiq6F+eHX1EMSk8c/
	GppHZ9gcC4B51zGXft5BtyuSZ25x6cCU2R1xQPs05Zi+LOg==
X-Google-Smtp-Source: AGHT+IFlpLNINzN9yNdld+Lz6rN4Df0CXbFb6ezDF3WUVxFm420o/jBcQZ/bwp0Jgq0OyR+H8eHy2Q==
X-Received: by 2002:a05:600c:6298:b0:458:bade:72c5 with SMTP id 5b1f17b1804b1-45b6870dde7mr55713915e9.8.1756308467106;
        Wed, 27 Aug 2025 08:27:47 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211bd7sm21511597f8f.38.2025.08.27.08.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:27:46 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 2/3] config: warn on core.commentString=auto
Date: Wed, 27 Aug 2025 16:27:29 +0100
Message-ID: <e92511ce21c9211964e7f18964a927166fb411ae.1756308431.git.phillip.wood@dunelm.org.uk>
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

As support for this setting was deprecated in the last commit print a
warning (or die when WITH_BREAKING_CHANGES is enabled) if it is set.
Avoid bombarding the user with warnings by only printing it (a)
when running commands that call "git commit" and (b) only once per
command. Some scaffolding is added to repo_read_config() to allow
it to detect deprecated config settings and warn about them. As both
"core.commentChar" and "core.commentString" set the comment character
we record which one of them is used and tailor the warning message
appropriately.

Note the odd combination of die_message() followed by die(NULL)
is to allow the next commit to insert a call to advise() in the middle.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c              |   3 +
 builtin/merge.c               |   3 +
 builtin/rebase.c              |   3 +
 builtin/revert.c              |   7 +++
 config.c                      | 115 +++++++++++++++++++++++++++++++++-
 environment.c                 |   1 +
 environment.h                 |   1 +
 repository.c                  |   1 +
 repository.h                  |   3 +
 t/t3404-rebase-interactive.sh |   7 ++-
 t/t7502-commit-porcelain.sh   |  17 ++++-
 11 files changed, 157 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d25cc07a355..f821fdcfcc3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1783,6 +1783,9 @@ int cmd_commit(int argc,
 	show_usage_with_options_if_asked(argc, argv,
 					 builtin_commit_usage, builtin_commit_options);
 
+#ifndef WITH_BREAKING_CHANGES
+	warn_on_auto_comment_char = true;
+#endif /* !WITH_BREAKING_CHANGES */
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
diff --git a/builtin/merge.c b/builtin/merge.c
index dc4cb8fb14d..794cb7bb269 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1378,6 +1378,9 @@ int cmd_merge(int argc,
 	show_usage_with_options_if_asked(argc, argv,
 					 builtin_merge_usage, builtin_merge_options);
 
+#ifndef WITH_BREAKING_CHANGES
+	warn_on_auto_comment_char = true;
+#endif /* !WITH_BREAKING_CHANGES */
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 72a52bdfb98..962917ec480 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1242,6 +1242,9 @@ int cmd_rebase(int argc,
 					 builtin_rebase_usage,
 					 builtin_rebase_options);
 
+#ifndef WITH_BREAKING_CHANGES
+	warn_on_auto_comment_char = true;
+#endif /* !WITH_BREAKING_CHANGES */
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
diff --git a/builtin/revert.c b/builtin/revert.c
index e07c2217fe8..b197848bb0a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -4,6 +4,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "diff.h"
+#include "environment.h"
 #include "gettext.h"
 #include "revision.h"
 #include "rerere.h"
@@ -285,6 +286,9 @@ int cmd_revert(int argc,
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
 
+#ifndef WITH_BREAKING_CHANGES
+	warn_on_auto_comment_char = true;
+#endif /* !WITH_BREAKING_CHANGES */
 	opts.action = REPLAY_REVERT;
 	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, prefix, &opts);
@@ -302,6 +306,9 @@ struct repository *repo UNUSED)
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
 
+#ifndef WITH_BREAKING_CHANGES
+	warn_on_auto_comment_char = true;
+#endif /* !WITH_BREAKING_CHANGES */
 	opts.action = REPLAY_PICK;
 	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, prefix, &opts);
diff --git a/config.c b/config.c
index 97ffef42700..18b42197095 100644
--- a/config.c
+++ b/config.c
@@ -11,6 +11,7 @@
 #include "date.h"
 #include "branch.h"
 #include "config.h"
+#include "dir.h"
 #include "parse.h"
 #include "convert.h"
 #include "environment.h"
@@ -1951,10 +1952,110 @@ int git_configset_get_pathname(struct config_set *set, const char *key, char **d
 		return 1;
 }
 
+struct comment_char_config {
+	unsigned last_key_id;
+	bool auto_set;
+};
+
+#define COMMENT_CHAR_CFG_INIT { 0 }
+
+static const char *comment_key_name(unsigned id)
+{
+	static const char *name[] = {
+		"core.commentChar",
+		"core.commentString",
+	};
+
+	if (id >= ARRAY_SIZE(name))
+		BUG("invalid comment key id");
+
+	return name[id];
+}
+
+static void comment_char_callback(const char *key, const char *value,
+				  const struct config_context *ctx UNUSED,
+				  void *data)
+{
+	struct comment_char_config *config = data;
+	unsigned key_id;
+
+	if (!strcmp(key, "core.commentchar"))
+		key_id = 0;
+	else if (!strcmp(key, "core.commentstring"))
+		key_id = 1;
+	else
+		return;
+
+	config->last_key_id = key_id;
+	config->auto_set = value && !strcmp(value, "auto");
+}
+
+struct repo_config {
+	struct repository *repo;
+	struct comment_char_config comment_char_config;
+};
+
+#define REPO_CONFIG_INIT(repo_) {				\
+		.comment_char_config = COMMENT_CHAR_CFG_INIT,	\
+		.repo = repo_,					\
+	};
+
+#ifdef WITH_BREAKING_CHANGES
+static void check_auto_comment_char_config(struct comment_char_config *config)
+{
+	if (!config->auto_set)
+		return;
+
+	die_message(_("Support for '%s=auto' has been removed in Git 3.0"),
+		    comment_key_name(config->last_key_id));
+	die(NULL);
+}
+#else
+static void check_auto_comment_char_config(struct comment_char_config *config)
+{
+	extern bool warn_on_auto_comment_char;
+	const char *DEPRECATED_CONFIG_ENV =
+				"GIT_AUTO_COMMENT_CHAR_CONFIG_WARNING_GIVEN";
+
+	if (!config->auto_set || !warn_on_auto_comment_char)
+		return;
+
+	/*
+	 * Use an environment variable to ensure that subprocesses do not repeat
+	 * the warning.
+	 */
+	if (git_env_bool(DEPRECATED_CONFIG_ENV, false))
+		return;
+
+	setenv(DEPRECATED_CONFIG_ENV, "true", true);
+
+	warning(_("Support for '%s=auto' is deprecated and will be removed in "
+		  "Git 3.0"), comment_key_name(config->last_key_id));
+}
+#endif /* WITH_BREAKING_CHANGES */
+
+static void check_deprecated_config(struct repo_config *config)
+{
+	if (!config->repo->check_deprecated_config)
+			return;
+
+	check_auto_comment_char_config(&config->comment_char_config);
+}
+
+static int repo_config_callback(const char *key, const char *value,
+				const struct config_context *ctx, void *data)
+{
+	struct repo_config *config = data;
+
+	comment_char_callback(key, value, ctx, &config->comment_char_config);
+	return config_set_callback(key, value, ctx, config->repo->config);
+}
+
 /* Functions use to read configuration from a repository */
 static void repo_read_config(struct repository *repo)
 {
 	struct config_options opts = { 0 };
+	struct repo_config config = REPO_CONFIG_INIT(repo);
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
@@ -1966,8 +2067,8 @@ static void repo_read_config(struct repository *repo)
 		git_configset_clear(repo->config);
 
 	git_configset_init(repo->config);
-	if (config_with_options(config_set_callback, repo->config, NULL,
-				repo, &opts) < 0)
+	if (config_with_options(repo_config_callback, &config, NULL, repo,
+				&opts) < 0)
 		/*
 		 * config_with_options() normally returns only
 		 * zero, as most errors are fatal, and
@@ -1980,6 +2081,7 @@ static void repo_read_config(struct repository *repo)
 		 * immediately.
 		 */
 		die(_("unknown error occurred while reading the configuration files"));
+	check_deprecated_config(&config);
 }
 
 static void git_config_check_init(struct repository *repo)
@@ -2667,6 +2769,14 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
 	char *contents = NULL;
 	size_t contents_sz;
 	struct config_store_data store = CONFIG_STORE_INIT;
+	bool saved_check_deprecated_config = r->check_deprecated_config;
+
+	/*
+	 * Do not warn or die if there are deprecated config settings as
+	 * we want the user to be able to change those settings by running
+	 * "git config".
+	 */
+	r->check_deprecated_config = false;
 
 	validate_comment_string(comment);
 
@@ -2898,6 +3008,7 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
 	if (in_fd >= 0)
 		close(in_fd);
 	config_store_data_clear(&store);
+	r->check_deprecated_config = saved_check_deprecated_config;
 	return ret;
 
 write_err_out:
diff --git a/environment.c b/environment.c
index 4c87876d483..1ffa2ff30b2 100644
--- a/environment.c
+++ b/environment.c
@@ -124,6 +124,7 @@ const char *comment_line_str = "#";
 char *comment_line_str_to_free;
 #ifndef WITH_BREAKING_CHANGES
 int auto_comment_line_char;
+bool warn_on_auto_comment_char;
 #endif /* !WITH_BREAKING_CHANGES */
 
 /* This is set by setup_git_directory_gently() and/or git_default_config() */
diff --git a/environment.h b/environment.h
index e75c4abb388..51898c99cd1 100644
--- a/environment.h
+++ b/environment.h
@@ -210,6 +210,7 @@ extern const char *comment_line_str;
 extern char *comment_line_str_to_free;
 #ifndef WITH_BREAKING_CHANGES
 extern int auto_comment_line_char;
+extern bool warn_on_auto_comment_char;
 #endif /* !WITH_BREAKING_CHANGES */
 
 # endif /* USE_THE_REPOSITORY_VARIABLE */
diff --git a/repository.c b/repository.c
index ecd691181fc..8af73923d34 100644
--- a/repository.c
+++ b/repository.c
@@ -57,6 +57,7 @@ void initialize_repository(struct repository *repo)
 	repo->parsed_objects = parsed_object_pool_new(repo);
 	ALLOC_ARRAY(repo->index, 1);
 	index_state_init(repo->index, repo);
+	repo->check_deprecated_config = true;
 
 	/*
 	 * When a command runs inside a repository, it learns what
diff --git a/repository.h b/repository.h
index 042dc93f0f2..5808a5d6108 100644
--- a/repository.h
+++ b/repository.h
@@ -161,6 +161,9 @@ struct repository {
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
 	unsigned different_commondir:1;
+
+	/* Should repo_config() check for deprecated settings */
+	bool check_deprecated_config;
 };
 
 #ifdef USE_THE_REPOSITORY_VARIABLE
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ce0aebb9a7e..3b2a46c25ce 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1184,8 +1184,13 @@ test_expect_success !WITH_BREAKING_CHANGES 'rebase -i respects core.commentchar=
 	test_when_finished "git rebase --abort || :" &&
 	(
 		test_set_editor "$(pwd)/copy-edit-script.sh" &&
-		git rebase -i HEAD^
+		git rebase -i HEAD^ 2>err
 	) &&
+	sed -n "s/^warning: //p" err >actual &&
+	cat >expect <<-EOF &&
+	Support for ${SQ}core.commentChar=auto${SQ} is deprecated and will be removed in Git 3.0
+	EOF
+	test_cmp expect actual &&
 	test -z "$(grep -ve "^#" -e "^\$" -e "^pick" edit-script)"
 '
 
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 65b4519a715..a9dc1e416d1 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -958,7 +958,12 @@ test_expect_success 'commit --status with custom comment character' '
 
 test_expect_success !WITH_BREAKING_CHANGES 'switch core.commentchar' '
 	test_commit "#foo" foo &&
-	GIT_EDITOR=.git/FAKE_EDITOR git -c core.commentChar=auto commit --amend &&
+	GIT_EDITOR=.git/FAKE_EDITOR git -c core.commentChar=auto commit --amend 2>err &&
+	sed -n "s/^warning: //p" err >actual &&
+	cat >expect <<-EOF &&
+	Support for ${SQ}core.commentChar=auto${SQ} is deprecated and will be removed in Git 3.0
+	EOF
+	test_cmp expect actual &&
 	test_grep "^; Changes to be committed:" .git/COMMIT_EDITMSG
 '
 
@@ -982,4 +987,14 @@ EOF
 	)
 '
 
+test_expect_success WITH_BREAKING_CHANGES 'core.commentChar=auto is rejected' '
+	test_config core.commentChar auto &&
+	test_must_fail git rev-parse --git-dir 2>err &&
+	sed -n "s/^fatal: //p" err >actual &&
+	cat >expect <<-EOF &&
+	Support for ${SQ}core.commentChar=auto${SQ} has been removed in Git 3.0
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.49.0.897.gfad3eb7d210

