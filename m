Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B424B28
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769255740; cv=none; b=tDy57aqBjeijeTbEbhWJRukjQZu3EyWXH2hNSoQIqFCf6qZ1F8/olwDhh+ENVub5zABgCgITfHlfFnfuhK+ln24GDQeUrhbuQS9vkyrueBmw46tJh4pr+jPhvLEFtMvJ72xlDh1fugQsYde1Ur1BIO9oFnPGFERo+JOTochoc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769255740; c=relaxed/simple;
	bh=dQFLH1oWDHSyKOjchYFFOSbSbDEYlOAgWgOJwZe4pq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nrwlu0oeFIKVw726CGN7NBAXiEC6m3U+TaQNwOHWseGVt7b7Dv8DhC3Xzs4GzEy7sMGeekGocuwwH/urw+vfLANgJgSOls0cX7QEf8Agxe5+abttbRuoM+Of1dv9pVaU+eBpZKBQBaJ7mWVIYkldqyzO/krpjaJ4Njh4Yxc4zF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKB1XAXJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKB1XAXJ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801bc32725so23400325e9.0
        for <git@vger.kernel.org>; Sat, 24 Jan 2026 03:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769255738; x=1769860538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z90x8NhpwuGZk5ylIYQyIuRBrW2yXllDH7tDZpAl11o=;
        b=LKB1XAXJZgqi/HE3zV0/Y4ri7uO2JajhbbTtSqzabra3krLtrn6P/C0+181VlfSRc2
         Bpf7yN6lhbMWA+SeV05XUyzTBPS7McuzihC96afr5pQLGLW++JRSTEaYHHsCUiaFvoDO
         DmvOZWzUvRNpQpeozw9z5CMIPLR+7iaX7x74wlW9+tx+Rx7lkiRGk4aoUGc8SrusEQQy
         mRwg4eiKRXuIY/EiH7cVuJJ8nkJfAWLx+MQe8lLxqIc4EmrerAV+RlOKXOAKQxj2BW6R
         8w0bG1KyYcpt9lO+PTG+FlC+SQXXu2tSRm3DW18e/7V/r647GRWwV1EzcN4j/5AlvnBB
         oixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769255738; x=1769860538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z90x8NhpwuGZk5ylIYQyIuRBrW2yXllDH7tDZpAl11o=;
        b=vK+/0LUKRUEK1I7fX6sm8DwXZUH9zHeJEj78h9lytTq8SLAulFhFBMnVjLOniFog5N
         jsTi6d8Gr1WU7rg5mGXKOXBsXnsID5ZyFZdcbdH5+Z7nL6F0dPf4FtsHXPbJMJRKTAOL
         3zQHBL7EHOxfxsEpYt9JEkKs9l011SFe9w14b5cxqX3hdRhXTACkOKs017U9WYymtB/H
         TDUHrSaDxSeRwTHlM71WJxeNFCnhT6Uz2dUz4gAYVODnPjd1BT2OumCVUbLOwzxtCViQ
         2C5kS9SKPVRvz7pERadpJawW0p2m+XZng5rZYgtGSH/Jx955Q7od59wRrNp2vs96cXjY
         NfGQ==
X-Gm-Message-State: AOJu0YxU5yFKAB40TT0mjzEOYmeWndUQbd7Xx5tCtuAb7IxQUQHy2gKc
	mj70ges/F81ULMXcHCpEfpRolQCcUzpzXvTZkRu6lslxbuGobBnPA5uf
X-Gm-Gg: AZuq6aJfJHqI+xIPqKrRQQ9btyaZ5oUVr5S+E6c742mdZl3Otiv+udmK8Mt72qWDHvL
	2vqrkzR98X1fX8VnX1lX9XmImwJ0+V5gIxodfIHVlM1VmA4CXhO7K6elrZap+R9+5DHiqq4wg8X
	QG6FERx0ZoLvwwAMJSiI3sDMHtUrdvKQDXVFxOB0AEQAkPmPbn23TCagQBiFckS+hcQLdyGeW2l
	SYWxidgNgKM1JC+FVuF/gNN8nP4E3vzAgx4Bg4B/UamL3VKd4900dRHYYGUTYLM5VTsFrenIf8W
	/Gg2byILov0QkHbL+a3+5lrw8nknIKV9YatwKetgjfMNtWAoxtJcRo/npJrn+L1+Q4jqi1vawAp
	1ej4Gz6D35YNAqDvA8JATyzG/LbCCI17QlV/TOpvX4V6RlxeZC+DLx+cwnqsc0Na8V/fKkLo93K
	230wM=
X-Received: by 2002:a05:600c:1c28:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4804c9bfa86mr107836925e9.28.1769255737515;
        Sat, 24 Jan 2026 03:55:37 -0800 (PST)
Received: from ubuntu ([102.88.77.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470287c3sm216209365e9.3.2026.01.24.03.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 03:55:37 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v4 3/3] environment: move "branch.autoSetupMerge" into `struct repo_config_values`
Date: Sat, 24 Jan 2026 12:55:06 +0100
Message-Id: <c74973d6e97745451ef54616a3d35d0e2a67cf8a.1769252118.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1769252118.git.belkid98@gmail.com>
References: <cover.1769252118.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config value `brach.autoSetupMerge` is parsed in
`git_default_branch_config()` and stored in the global variable
`git_branch_track`. This global variable can be overwritten
by another repository when multiple Git repos run in the the same process.

Move this value into `struct repo_config_values` in the_repository to
retain current behaviours and move towards libifying Git.
Since the variable is no longer a global variable, it has been renamed to
`branch_track` in the struct `repo_config_values`.

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
 environment.c               | 12 +++++++-----
 environment.h               |  4 ++++
 7 files changed, 15 insertions(+), 11 deletions(-)

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
index c577b5d20f..7d27951a7e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -795,7 +795,7 @@ int cmd_branch(int argc,
 	if (!sorting_options.nr)
 		string_list_append(&sorting_options, "refname");
 
-	track = git_branch_track;
+	track = the_repository->config_values.branch_track;
 
 	head = refs_resolve_refdup(get_main_ref_store(the_repository), "HEAD",
 				   0, &head_oid, NULL);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 261699e2f5..ba6fea9aee 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1631,7 +1631,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 			die(_("'%s' cannot be used with '%s'"), "--detach", "-t");
 	} else if (opts->track == BRANCH_TRACK_UNSPECIFIED)
-		opts->track = git_branch_track;
+		opts->track = the_repository->config_values.branch_track;
 
 	if (new_branch_info->name && !new_branch_info->commit)
 		die(_("Cannot switch branch to a non-commit '%s'"),
diff --git a/builtin/push.c b/builtin/push.c
index 5b6cebbb85..7be20a1035 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -162,7 +162,7 @@ static NORETURN void die_push_simple(struct branch *branch,
 		advice_pushdefault_maybe = _("\n"
 				 "To choose either option permanently, "
 				 "see push.default in 'git help config'.\n");
-	if (git_branch_track != BRANCH_TRACK_SIMPLE)
+	if (the_repository->config_values.branch_track != BRANCH_TRACK_SIMPLE)
 		advice_automergesimple_maybe = _("\n"
 				 "To avoid automatically configuring "
 				 "an upstream branch when its name\n"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d537ab087a..f2b6f027d7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3128,7 +3128,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix,
 	};
 
 	repo_config(the_repository, git_default_config, NULL);
-	track = git_branch_track;
+	track = the_repository->config_values.branch_track;
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (argc != 3)
diff --git a/environment.c b/environment.c
index 269cac6d6e..de8721657e 100644
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
+			cfg->branch_track = BRANCH_TRACK_ALWAYS;
 			return 0;
 		} else if (value && !strcmp(value, "inherit")) {
-			git_branch_track = BRANCH_TRACK_INHERIT;
+			cfg->branch_track = BRANCH_TRACK_INHERIT;
 			return 0;
 		} else if (value && !strcmp(value, "simple")) {
-			git_branch_track = BRANCH_TRACK_SIMPLE;
+			cfg->branch_track = BRANCH_TRACK_SIMPLE;
 			return 0;
 		}
-		git_branch_track = git_config_bool(var, value);
+		cfg->branch_track = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "branch.autosetuprebase")) {
@@ -761,4 +762,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 {
 	cfg->attributes_file = NULL;
 	cfg->apply_sparse_checkout = 0;
+	cfg->branch_track = BRANCH_TRACK_REMOTE;
 }
diff --git a/environment.h b/environment.h
index ddce69c6ba..27161d56ab 100644
--- a/environment.h
+++ b/environment.h
@@ -2,6 +2,7 @@
 #define ENVIRONMENT_H
 
 #include "repo-settings.h"
+#include "branch.h"
 
 /* Double-check local_repo_env below if you add to this list. */
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
@@ -88,6 +89,9 @@ struct repo_config_values {
 	/* section "core" config values */
 	char *attributes_file;
 	int apply_sparse_checkout;
+
+	/* section "branch" config values */
+	enum branch_track branch_track;
 };
 
 /*
-- 
2.34.1

