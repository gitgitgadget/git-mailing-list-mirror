Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2A350293
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325158; cv=none; b=EQMgQNQVQuCmdL6ShiFQpEJbrRPcqwE5DU3pLBa/rCmNJplKOzymHyqw8EnRV5j5d7JcMbVFANdBt6cgz3+SehgaSMuxkyIve3+p+QZlEpoK8F9OO4ve5pCwwGezGpcHBBtc4dN5n//xsWMN07KM6J71CPbfKZnoAkyRLqdJX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325158; c=relaxed/simple;
	bh=R4e6L/1pKVvmYXL5UCcxLQNp8nkX253Q/zEOkdAtCSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HqUP6aQoRJhSnUlJ7Z82A8EkcCoHWPWeJ/jAxo2Xw2JHZI+1BAAcT5P0SaeR51phsWDh9slMSrrPlL1huTPkrsBrsZm3VHXe1Ow6lfcb+ZYAWhQGU9vpOqHyNSpn8vM5wAnkaj3h2Dt3t0hpDYvgjvanYs1WtOnhU7n5L7580aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVBMk71L; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVBMk71L"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47774d3536dso500425e9.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768325155; x=1768929955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0JOatWKxMuks4VyNpOX+31sb5dYc7LZweJD3KC+IU0=;
        b=nVBMk71LNaqKcJdljYrMcmbldWiCUjjyogHQF53Gk8zmNKx9d/F4k0hq9AFR/KE//G
         GuGKs+4e2uweaScMztrZHWuXQhEsTXZ+JEb7qhNPw64aI3GuOVBd4NBXGvbtWw61YhtC
         tV/aqIyR6DRnQvNctC4xAgLTFt1EiNsZnySarG4nqSt0t3fCwwuqQIBmR8mNoSEQFZ0e
         f7yPomNyQMLUtGwYZTPgpl0qjF5P2dRbEOavLls0fYzvvr4XipT79tM/pER3+zOwTuHn
         wVOPn0VWHxEDa4Ee91SJcXIdyXY2SvZOW+s8MQOuSpnH+fa0yKiYcXWT37d0SxyUSID1
         Q3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325155; x=1768929955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f0JOatWKxMuks4VyNpOX+31sb5dYc7LZweJD3KC+IU0=;
        b=YqJ6t/OXXIZfWc5e/dQEiYBqQwq42YTVgILkicIAuRihx5fVeJY7yyoemrk32eM0pn
         nlwDMj5BrKdjz1V+xHsecYDstx0lSecXDFz6Eq7L1gM2EfXd3/4aRd/4KzJJfOnX74bX
         sVCIKw8UuL/enD0IwoO7TNfelxIa/cOCcWtyB5sKGUZAyzrlUFOP6jZ5TuVUZmpXxBq7
         i4t/Zu6tkZz0WoQkQLr8kjA1KtZVd4yhqPaIW3SYStOa9ixjhQgXCNAeoah5AFXbPPp+
         IlMeEAa9BO4NCebGUm9UMxK4NwXVEHywZhrCRU8HK7HcZtK9Uf3nZljr1mlskETDefTm
         IAsw==
X-Gm-Message-State: AOJu0YwvYBmsnoC4isReT1qoYsKC17dHYrQHV3EJk8ySudMjcaCp2K5W
	rkRNLYQ7fDc2JCIPDMB1kQjF5Jxmn3wrqh3WfKfhln/+HfoQdNEC/34NjLIT0dcP
X-Gm-Gg: AY/fxX4fmduKQV3B0/q6//JuOdKfjV+p9q+HZ/HsS6GOzUawN3cNC5eTHRXQFOYWu2Z
	AZr8ZYV7E+hL1swD45VnPn6eWgYI0yH4hD3oJTOC0ivXgvYt2CKL40xhKfaHi7mPiS+1gLb4IQ8
	NJZhSvAZyxOpfEdMn8AxgtkLTgDQ7omcRQ24iLJgQ/ZqcjT4dpSdNEO4RSIejJUIuwVRjDycQ0A
	8AzKsx/hEz6hj9TnnqKRL1KGx4EbYHpBcAWx5WgUPbQ08IKXR1FDt3m5XN8DVr4LHx1NT+YhuVt
	Rj0G7/oMOqy6ikrflWICFQtRWWrLUMZjf4+ZL5X5L7T6yznvToIbjKPVwPnbbs/0R/VVdp68N+G
	jTZjCm0j0rHF7YO+Q4lD0CGj2qiwbnSKcbgE8qCGMp/3PDyqQkZWVgPk2hyEhRfsTV5Ws5A6q65
	aeFjJj
X-Google-Smtp-Source: AGHT+IFi1dcSPJDfDpdxxEOpBirDYv8Jy1KMlyuhanXJLA1Tr1qFquRinnxf/UMGpzFFxoVNC5fTXA==
X-Received: by 2002:a05:600c:82c3:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47ed7b76cd1mr38328315e9.0.1768325155235;
        Tue, 13 Jan 2026 09:25:55 -0800 (PST)
Received: from ubuntu ([102.91.81.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f69dsm412383055e9.1.2026.01.13.09.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:25:54 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v2 3/3] environment: move "branch.autoSetupMerge" into `struct repo_config_values`
Date: Tue, 13 Jan 2026 17:44:02 +0100
Message-Id: <6e54e22ac7096f26e774acc4740bcb135496fb69.1768318762.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768318762.git.belkid98@gmail.com>
References: <cover.1768318762.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config value `brach.autoSetupMerge` is parsed in
`git_default_branch_config()` and stored in the global variable
`git_branch_track`. This global variable can cause unexpected behaviours
when multiple Git repos run in the the same process.

Move this value into `struct repo_config_values` which holds all values
parsed by `git_default_config()` and can be accessed per
repo via `git_default_config()`. This would retain the same
behaviours while achieving repository scoped access.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 branch.h                    |  2 --
 builtin/branch.c            |  2 +-
 builtin/checkout.c          |  2 +-
 builtin/push.c              |  2 +-
 builtin/submodule--helper.c |  2 +-
 environment.c               | 16 +++++++++++-----
 environment.h               |  6 ++++++
 repository.c                |  1 +
 8 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/branch.h b/branch.h
index ec2f35fda4..3dc6e2a0ff 100644
--- a/branch.h
+++ b/branch.h
@@ -15,8 +15,6 @@ enum branch_track {
 	BRANCH_TRACK_SIMPLE,
 };
 
-extern enum branch_track git_branch_track;
-
 /* Functions for acting on the information about branches. */
 
 /**
diff --git a/builtin/branch.c b/builtin/branch.c
index c577b5d20f..d75114b41c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -795,7 +795,7 @@ int cmd_branch(int argc,
 	if (!sorting_options.nr)
 		string_list_append(&sorting_options, "refname");
 
-	track = git_branch_track;
+	track = the_repository->config_values.git_branch_track;
 
 	head = refs_resolve_refdup(get_main_ref_store(the_repository), "HEAD",
 				   0, &head_oid, NULL);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 261699e2f5..6c1cb9713c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1631,7 +1631,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 			die(_("'%s' cannot be used with '%s'"), "--detach", "-t");
 	} else if (opts->track == BRANCH_TRACK_UNSPECIFIED)
-		opts->track = git_branch_track;
+		opts->track = the_repository->config_values.git_branch_track;
 
 	if (new_branch_info->name && !new_branch_info->commit)
 		die(_("Cannot switch branch to a non-commit '%s'"),
diff --git a/builtin/push.c b/builtin/push.c
index 5b6cebbb85..68105ecb2d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -162,7 +162,7 @@ static NORETURN void die_push_simple(struct branch *branch,
 		advice_pushdefault_maybe = _("\n"
 				 "To choose either option permanently, "
 				 "see push.default in 'git help config'.\n");
-	if (git_branch_track != BRANCH_TRACK_SIMPLE)
+	if (the_repository->config_values.git_branch_track != BRANCH_TRACK_SIMPLE)
 		advice_automergesimple_maybe = _("\n"
 				 "To avoid automatically configuring "
 				 "an upstream branch when its name\n"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d537ab087a..7239722e48 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3128,7 +3128,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix,
 	};
 
 	repo_config(the_repository, git_default_config, NULL);
-	track = git_branch_track;
+	track = the_repository->config_values.git_branch_track;
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (argc != 3)
diff --git a/environment.c b/environment.c
index 65919a6c52..437d14e1ae 100644
--- a/environment.c
+++ b/environment.c
@@ -66,7 +66,6 @@ enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding;
-enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
@@ -607,18 +606,20 @@ static int git_default_i18n_config(const char *var, const char *value)
 
 static int git_default_branch_config(const char *var, const char *value)
 {
+	struct repo_config_values *cfg = &the_repository->config_values;
+
 	if (!strcmp(var, "branch.autosetupmerge")) {
 		if (value && !strcmp(value, "always")) {
-			git_branch_track = BRANCH_TRACK_ALWAYS;
+			cfg->git_branch_track = BRANCH_TRACK_ALWAYS;
 			return 0;
 		} else if (value && !strcmp(value, "inherit")) {
-			git_branch_track = BRANCH_TRACK_INHERIT;
+			cfg->git_branch_track = BRANCH_TRACK_INHERIT;
 			return 0;
 		} else if (value && !strcmp(value, "simple")) {
-			git_branch_track = BRANCH_TRACK_SIMPLE;
+			cfg->git_branch_track = BRANCH_TRACK_SIMPLE;
 			return 0;
 		}
-		git_branch_track = git_config_bool(var, value);
+		cfg->git_branch_track = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "branch.autosetuprebase")) {
@@ -756,3 +757,8 @@ int git_default_config(const char *var, const char *value,
 	/* Add other config variables here and to Documentation/config.adoc. */
 	return 0;
 }
+
+void repo_config_values_init(struct repo_config_values *cfg)
+{
+	cfg->git_branch_track = BRANCH_TRACK_REMOTE;
+}
diff --git a/environment.h b/environment.h
index 5caf73b4b8..bfcdffe836 100644
--- a/environment.h
+++ b/environment.h
@@ -2,6 +2,7 @@
 #define ENVIRONMENT_H
 
 #include "repo-settings.h"
+#include "branch.h"
 
 /* Double-check local_repo_env below if you add to this list. */
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
@@ -89,6 +90,9 @@ struct repo_config_values {
 	/* core config values */
 	char *attributes_file_path;
 	int sparse_checkout;
+
+	/* branch config values */
+	enum branch_track git_branch_track;
 };
 
 /*
@@ -114,6 +118,8 @@ const char *strip_namespace(const char *namespaced_ref);
 int git_default_config(const char *, const char *,
 		       const struct config_context *, void *);
 
+void repo_config_values_init(struct repo_config_values *cfg);
+
 /*
  * TODO: All the below state either explicitly or implicitly relies on
  * `the_repository`. We should eventually get rid of these and make the
diff --git a/repository.c b/repository.c
index c7e75215ac..d308cd78bf 100644
--- a/repository.c
+++ b/repository.c
@@ -57,6 +57,7 @@ void initialize_repository(struct repository *repo)
 	ALLOC_ARRAY(repo->index, 1);
 	index_state_init(repo->index, repo);
 	repo->check_deprecated_config = true;
+	repo_config_values_init(&repo->config_values);
 
 	/*
 	 * When a command runs inside a repository, it learns what
-- 
2.34.1

