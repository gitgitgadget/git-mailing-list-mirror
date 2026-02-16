Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1ED3148B4
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259950; cv=none; b=HCMf7QrJYV/wI7YIZPAyTtHccC6dyFp9GPNW0I1/Ug+Xhbi4JpfHJJcsqNvwkK1VhNynkR5PPXUxUvJLT8d2y+PlgCSb+GunQlBz1qr6PlmJ8+osDOLWFw9ukveObpIVx9HtVEhjl7AD7q+UjafCSznVREc+5Td31E/dSEgssfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259950; c=relaxed/simple;
	bh=onpbucq9XEm7tONQBXLXYQYqe5KfbREv5FEkJm1Jes4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SP0EuGPz6JvrCQJmkwryLtrES6S2bEmYMwdq8fsvXt7j+BHUu5I1qD7xL1IpMSzKcDXsUrIDkp7n1e9xSMXCm/tBg0ZgeMHGPUmmulQqBL7rtyC/KEVDsEEvgKb1HnWtfAxfla016CZiiyvYMQlwawRmVuDsAPavKU9hTRJVw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcNt7Awg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcNt7Awg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48068127f00so36170225e9.3
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 08:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771259947; x=1771864747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyiEBWPLAXMilDQFsISUdy2H0+kkhpVXZIWynlrom3M=;
        b=mcNt7Awg061g28ZTWLkw4AgLKMApCxFeDvuh4sGX3KkhmI09XvtLTx1fpqTzwy+lHg
         pe54BoUrMR7cs4e/Qov6BRlzFLaL8lWmZSn1jWTZpbiXMx47TbIOtlCtVqLAAeY0c6CN
         jZP3H4Uf4NUJC3tGRKfQr/l/rKErWl7XXkdB3AH8gdKyrBlNMmZsR96x3NHrL//aMLyS
         kIe73ZALQ3S27TkYWZhLFUzumrzDkleh0iyLfxyOSWd/GFxL1ZO1L9M//DZrD7BXyIZm
         FHc+Nq1UxPNIg+OsgUYP6j24Juu7piJl3HBE+v00z8MtE6IFPh99buWmRsiNwCYHCjaw
         tsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771259947; x=1771864747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MyiEBWPLAXMilDQFsISUdy2H0+kkhpVXZIWynlrom3M=;
        b=xPkmfuExSsrK9uxwzXTcYEBRKvixu4Tt65iS+r21Y3gZ2BAUK8PDwBs8ZmrtBpYWKR
         iLwCFx0PBIMHdAYTGxdI0DytyEUW9mdk/O51+YhQFXxR/Bj8WftWoO+0oWyGEs+9SkOt
         jJsGuF8XJ0FaqRYPD1SEIYMsM4jTI3gHTz75SvGk4eQoBWKHiPeTx7JHgzFWks9RJSsN
         nyRWURv0oAn7gvBdUdyNPJJHgNLaNqk1Q07ExE1haZroViXXNxFt0n7RbtFHwIlq8X7Q
         fXWEnVhPU4SGUGByF83c97Y8WN/5Vn3l9OKPWKOrY6dMq+qaw6yC+s8+dWJIJ+SP2n61
         fXow==
X-Gm-Message-State: AOJu0YwDxFtgajRyRTgke4mvp3Qhbq92x+sjyOaCBTN8XlffN3IJNC9i
	WBWDPG/ASVK9ccWPGweBpp6AIwZElOcSjyUEoIU4A8Y13Y3sTtuWGlSv
X-Gm-Gg: AZuq6aLb45Qv3jG8bjCdaLwCL3oNr69Fm6sF17TJX8syRJloYJSOEHy/ysiq92v+93x
	yKko00mNVtxYant3QxhYUOK5w+HA3EguNjOQ9XrXWKjbL6ytENu+e8EAB5pbE0J7V8sDTxeeA8K
	Bydz29kLJu2w9tpB2Th3upFBgSQgqLJwMJy0oomb4M/88R/WoXM94oP9zaajqtBigQSdZm3Lr1R
	/LUxonU+/pHEzY7IVu5LsrogHJmw0X2kU5sAJ8vCMBZad6Zmu2m9v0nA4LnQSBk6KjU7wNLjt7I
	SCPGAFO+dvnW9oyiBJQSiA7Zw8RFmGMIVPq3uwL6lZuVWLjpLGVT6AUwyS8wBytlw+mp8rgtoAE
	GqADz7sl8Jh4oV4wFnBPs5HmE4cC6xO6N+/JcX+Btye9kfTP+CywTLbKhRjyVI7i9eaZnb6S5Zq
	A3MMDWtShKzA0aWQ==
X-Received: by 2002:a05:600c:4f50:b0:477:af8d:203a with SMTP id 5b1f17b1804b1-48373a662a4mr170387565e9.27.1771259947183;
        Mon, 16 Feb 2026 08:39:07 -0800 (PST)
Received: from ubuntu ([102.88.77.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370ac3564sm244899165e9.5.2026.02.16.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 08:39:06 -0800 (PST)
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
Subject: [Outreachy PATCH v7 3/3] environment: move "branch.autoSetupMerge" into `struct repo_config_values`
Date: Mon, 16 Feb 2026 17:38:27 +0100
Message-Id: <c3ecfa63b918dc508295d23cbf78d5b60f73ff91.1771258573.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1771258573.git.belkid98@gmail.com>
References: <cover.1771258573.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config value `branch.autoSetupMerge` is parsed in
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
 builtin/branch.c            |  3 ++-
 builtin/checkout.c          |  3 ++-
 builtin/push.c              |  3 ++-
 builtin/submodule--helper.c |  3 ++-
 environment.c               | 12 +++++++-----
 environment.h               |  4 ++++
 7 files changed, 19 insertions(+), 11 deletions(-)

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
index c577b5d20f..a1a43380d0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -724,6 +724,7 @@ int cmd_branch(int argc,
 	static struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	int ret;
 
 	struct option options[] = {
@@ -795,7 +796,7 @@ int cmd_branch(int argc,
 	if (!sorting_options.nr)
 		string_list_append(&sorting_options, "refname");
 
-	track = git_branch_track;
+	track = cfg->branch_track;
 
 	head = refs_resolve_refdup(get_main_ref_store(the_repository), "HEAD",
 				   0, &head_oid, NULL);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 261699e2f5..ea728e733c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1588,6 +1588,7 @@ static void die_if_switching_to_a_branch_in_use(struct checkout_opts *opts,
 static int checkout_branch(struct checkout_opts *opts,
 			   struct branch_info *new_branch_info)
 {
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	int noop_switch = (!new_branch_info->name &&
 			   !opts->new_branch &&
 			   !opts->force_detach);
@@ -1631,7 +1632,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 			die(_("'%s' cannot be used with '%s'"), "--detach", "-t");
 	} else if (opts->track == BRANCH_TRACK_UNSPECIFIED)
-		opts->track = git_branch_track;
+		opts->track = cfg->branch_track;
 
 	if (new_branch_info->name && !new_branch_info->commit)
 		die(_("Cannot switch branch to a non-commit '%s'"),
diff --git a/builtin/push.c b/builtin/push.c
index 5b6cebbb85..7100ffba5d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -151,6 +151,7 @@ static NORETURN void die_push_simple(struct branch *branch,
 	const char *advice_pushdefault_maybe = "";
 	const char *advice_automergesimple_maybe = "";
 	const char *short_upstream = branch->merge[0]->src;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	skip_prefix(short_upstream, "refs/heads/", &short_upstream);
 
@@ -162,7 +163,7 @@ static NORETURN void die_push_simple(struct branch *branch,
 		advice_pushdefault_maybe = _("\n"
 				 "To choose either option permanently, "
 				 "see push.default in 'git help config'.\n");
-	if (git_branch_track != BRANCH_TRACK_SIMPLE)
+	if (cfg->branch_track != BRANCH_TRACK_SIMPLE)
 		advice_automergesimple_maybe = _("\n"
 				 "To avoid automatically configuring "
 				 "an upstream branch when its name\n"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d537ab087a..594cd107b3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3126,9 +3126,10 @@ static int module_create_branch(int argc, const char **argv, const char *prefix,
 		N_("git submodule--helper create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"),
 		NULL
 	};
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	repo_config(the_repository, git_default_config, NULL);
-	track = git_branch_track;
+	track = cfg->branch_track;
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (argc != 3)
diff --git a/environment.c b/environment.c
index 390af1ce54..1bc3adb75b 100644
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
+	struct repo_config_values *cfg = repo_config_values(the_repository);
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
index 2e24160322..4bfd798757 100644
--- a/environment.h
+++ b/environment.h
@@ -2,6 +2,7 @@
 #define ENVIRONMENT_H
 
 #include "repo-settings.h"
+#include "branch.h"
 
 /* Double-check local_repo_env below if you add to this list. */
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
@@ -89,6 +90,9 @@ struct repo_config_values {
 	/* section "core" config values */
 	char *attributes_file;
 	int apply_sparse_checkout;
+
+	/* section "branch" config values */
+	enum branch_track branch_track;
 };
 
 struct repo_config_values *repo_config_values(struct repository *repo);
-- 
2.34.1

