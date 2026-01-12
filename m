Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191F357A5E
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222789; cv=none; b=ptvpYU7IzIpko6Qm5bRS4vCNHy3hciMiP2+FjYUuQjcXblVHogcc1/tMzRE+fJojbjj1e5WnTcwAtWam1S9jAA8apUz1fSiTaLrpw53qp6ZvJXzvTHIdZFkmaD8DvguYHycy5vsu7mye29heFCAYTd6N8u+8hjRRMKMCx6ba4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222789; c=relaxed/simple;
	bh=9+WpJgIpZJnDLESPld9GvUYlqONZuxA+aDN9S1Hqtxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NxDvtt1dHDlBk9ORvFd/YtMRsOXiBZRfAnmWM9wPd+DewJ6w0qk5yM2nxIU3K3gzIfn4kvyU9Pi4ygzpSVCmZdzpJj1SdKKt5dIv4zvvI7K8Wb87FAIoM21/Dj1Ds1mLbZz2Z4jVT1xiJTl77D7o0diHgYQxTUeGdtIQNaISYaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWJOpO34; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWJOpO34"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc305552so4672069f8f.0
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 04:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768222786; x=1768827586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ehnR3BkzWZoScxZ6lKUmhgYCu98zSnfc/O2EnCtP+g=;
        b=fWJOpO34PoHp67ZVBxGJs/PGHNFzPxg52Yr0Mh/BKxrnCXjOQ3F+pXCj8eIDHtD/fc
         zn7K8IGX+NN9uBsedmGSJ8Ox0/ch1p6Ub3TIadRop7dlBVN9210eTxYqZwJBeNePIQRn
         63tp15cvLs217AcHDNaDJwVqZU3u0CTIGI2cjZLgU4qYArvJxYTyOGRD+MAT3EGY6bkE
         VvR7zMlGtCGzVx4UyPFUfBxWqRfRuAfCcEUM8wLFZLqcWboPm+L8H3PvYUHA1MFw0O2r
         n0MrQs1OnR0OGunoAKaTIxWKnSCfh1v4bF6zoZ+X9exlsBP+ccYnzDfLMx2q2kvoyYER
         IA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222786; x=1768827586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ehnR3BkzWZoScxZ6lKUmhgYCu98zSnfc/O2EnCtP+g=;
        b=mJ7YPLDZ96ybNbNB+x/AmuziFfhPowB/QNvCka3QaaKBKQ6EFHWUAnvS8J+eYDhq1k
         zVQPYgnfFq2CiqVrg1qvvHZLBm4oGuhZzn/g7IiJn0Nj4v+XisFTy3OqroLEYIRcXXwk
         HeXbtNGb/yjBTc9r15Pam/UnI4XXhB7bAPa37OVwsKgNyOkNj+tajfOhZAOHYmfebC4A
         YqXFwSQweR/fWYjRloDsYqWzKTO0LeHl7WHEPLp2HHdMWeSeTSZW0mZprCQroVu9JVno
         Cm2xOZ046jWjqtne0j+KkAHC77gNdvFtIoUOP7CJVfOFY2bRAMLHIFR7RYgSqZHwJiNE
         x4Nw==
X-Gm-Message-State: AOJu0YwMuck2lz5w4mGlAmPkJNs0YE9R7bg0X/3/tJa7ABRF4/cjV47e
	AeoHFAlO7nsXnVlIQGXqRHlVB1NGA2CY/8fA8pwiJeo4wmW7jegYVc1V
X-Gm-Gg: AY/fxX7axkwDg5GmeTWc+FEYY1eCVE2Td5p5uwgYUVchHNd8n4M6Dyqgu3tMqfmV737
	ygM7oXWwixam79liqvzLMQq/JienAcfL1AwvBIsBG0qbrpGTsSU/dcRci2E9LocB5dh4H2PDBDV
	0yU9/nPcS3g1OWIzr4Yc/SHSlVL+uB382Elc0P+jTlgoulL687c4V8Za4hBc46By/lD3V+iIirY
	C0dcojoO9FDV+r/wZhywOfiSulLM4IjS6qaxzEOsIjFk+9YPaqD/U56X+MngaH+lW9yskmShITl
	PGjMXYdeuEp6/UUGHpWb7QY+FFFl4R9SnerKa4EE9XOtIoMNjKxLfVBZHJ9rdVDASzxpxKhsSqm
	0aS4yeZz3uf1U/BfRkyFXSK855ZwI4clGhwFxZyN9GVYaZ9cykifK4B/w7iSlbL5z7GrlEtljj6
	khYjXd
X-Google-Smtp-Source: AGHT+IE3i3Z0jNjU3kqPntzE3m/zWxn1AFXHh/ZIA4Wfw5BsytCT4kzuGJUjysbsYB+33kaS9zC4zQ==
X-Received: by 2002:a05:6000:22c7:b0:430:f255:14b3 with SMTP id ffacd0b85a97d-432c379b302mr20056188f8f.43.1768222785811;
        Mon, 12 Jan 2026 04:59:45 -0800 (PST)
Received: from ubuntu ([102.91.81.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e180csm37684801f8f.10.2026.01.12.04.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:59:45 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [Outreachy PATCH RFC 3/3] environment: move "branch.autoSetupMerge" into `struct config_values`
Date: Mon, 12 Jan 2026 13:59:25 +0100
Message-Id: <2ea3bd7816624bc03426ded68ddd1e9c15f19127.1768217572.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768217572.git.belkid98@gmail.com>
References: <cover.1768217572.git.belkid98@gmail.com>
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

Move this value into `struct config_values` which holds all values
parsed by `git_default_config()` and can be accessed per
repo via `git_default_config()`. This would mean we do not have to remove
code from `git_default_branch_config()`, thereby retaining the same
behaviour.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 builtin/branch.c            |  2 +-
 builtin/checkout.c          |  2 +-
 builtin/push.c              |  2 +-
 builtin/submodule--helper.c |  2 +-
 config.c                    |  5 +++++
 config.h                    |  4 ++++
 environment.c               | 10 +++++-----
 repository.c                |  1 +
 8 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c577b5d20f..6dde426e90 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -795,7 +795,7 @@ int cmd_branch(int argc,
 	if (!sorting_options.nr)
 		string_list_append(&sorting_options, "refname");
 
-	track = git_branch_track;
+	track = the_repository->cfg_values->git_branch_track;
 
 	head = refs_resolve_refdup(get_main_ref_store(the_repository), "HEAD",
 				   0, &head_oid, NULL);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 261699e2f5..0b8aa6b45a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1631,7 +1631,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 			die(_("'%s' cannot be used with '%s'"), "--detach", "-t");
 	} else if (opts->track == BRANCH_TRACK_UNSPECIFIED)
-		opts->track = git_branch_track;
+		opts->track = the_repository->cfg_values->git_branch_track;
 
 	if (new_branch_info->name && !new_branch_info->commit)
 		die(_("Cannot switch branch to a non-commit '%s'"),
diff --git a/builtin/push.c b/builtin/push.c
index 5b6cebbb85..14967002ae 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -162,7 +162,7 @@ static NORETURN void die_push_simple(struct branch *branch,
 		advice_pushdefault_maybe = _("\n"
 				 "To choose either option permanently, "
 				 "see push.default in 'git help config'.\n");
-	if (git_branch_track != BRANCH_TRACK_SIMPLE)
+	if (the_repository->cfg_values->git_branch_track != BRANCH_TRACK_SIMPLE)
 		advice_automergesimple_maybe = _("\n"
 				 "To avoid automatically configuring "
 				 "an upstream branch when its name\n"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d537ab087a..0e2226b3c8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3128,7 +3128,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix,
 	};
 
 	repo_config(the_repository, git_default_config, NULL);
-	track = git_branch_track;
+	track = the_repository->cfg_values->git_branch_track;
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (argc != 3)
diff --git a/config.c b/config.c
index 8b882f64ae..c19df32ad6 100644
--- a/config.c
+++ b/config.c
@@ -1766,6 +1766,11 @@ void config_values_clear(struct config_values *cfg)
 	free(cfg->attributes_file_path);
 }
 
+void config_values_init_defaults(struct config_values *cfg)
+{
+	cfg->git_branch_track = BRANCH_TRACK_REMOTE;
+}
+
 void git_configset_init(struct config_set *set)
 {
 	hashmap_init(&set->config_hash, config_set_element_cmp, NULL, 0);
diff --git a/config.h b/config.h
index 21d65c440e..62032346e3 100644
--- a/config.h
+++ b/config.h
@@ -5,6 +5,7 @@
 #include "string-list.h"
 #include "repository.h"
 #include "parse.h"
+#include "branch.h"
 
 /**
  * The config API gives callers a way to access Git configuration files
@@ -142,6 +143,8 @@ struct config_values {
 	char *attributes_file_path;
 	int sparse_checkout;
 
+	/* branch config values */
+	enum branch_track git_branch_track;
 };
 #define CONFIG_CONTEXT_INIT { 0 }
 
@@ -195,6 +198,7 @@ int git_config_from_blob_oid(config_fn_t fn, const char *name,
 void git_config_push_parameter(const char *text);
 void git_config_push_env(const char *spec);
 int git_config_from_parameters(config_fn_t fn, void *data);
+void config_values_init_defaults(struct config_values *cfg);
 void config_values_clear(struct config_values *cfg);
 
 /*
diff --git a/environment.c b/environment.c
index 15b63cdc4a..207e63f519 100644
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
@@ -607,18 +606,19 @@ static int git_default_i18n_config(const char *var, const char *value)
 
 static int git_default_branch_config(const char *var, const char *value)
 {
+	struct config_values *cfg = the_repository->cfg_values;
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
diff --git a/repository.c b/repository.c
index 3ad944e71c..98237eceaa 100644
--- a/repository.c
+++ b/repository.c
@@ -56,6 +56,7 @@ void initialize_repository(struct repository *repo)
 	repo->parsed_objects = parsed_object_pool_new(repo);
 	ALLOC_ARRAY(repo->index, 1);
 	CALLOC_ARRAY(repo->cfg_values, 1);
+	config_values_init_defaults(repo->cfg_values);
 	index_state_init(repo->index, repo);
 	repo->check_deprecated_config = true;
 
-- 
2.34.1

