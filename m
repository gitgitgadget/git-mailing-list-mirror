Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DFC374F1
	for <git@vger.kernel.org>; Wed, 14 May 2025 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747188083; cv=none; b=tdlrxnqC59mSGIOo1iofNr2yvFoybEN1GuPT7YFwf7m1EOj3aII5bozjuie5dfKXFf4+PCCvqnwa4+2opAQjeWheUcFq0NjAi2Bg6MDgQciwB8SmavqZZr5YdRyu+LK1OaWmimOa5plqSvpcK1/Uad7xMDEMoVE227vZ3pKklzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747188083; c=relaxed/simple;
	bh=/Ucm4Zh7Qt3tekEIW0DANqdF+oVrT468JS6LcHAFK8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyFLvVWxAu1sgLkBcPthwRC+Fm8hrHR6aOh/jVxmq2ndbLA/42Rr0YlsTqKa76yvPqo4F9Pm/xoQduLbWrz3YQO+4PMLTWm6Kf/dWXCra9aY9UDVYSBXEnQ2GQL+VG7tTgFj0fYk7H5F1kuo5j7mpRbXPxhP8kUnmwht3gBQ1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME8/HPck; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME8/HPck"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22fa414c478so35675895ad.0
        for <git@vger.kernel.org>; Tue, 13 May 2025 19:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747188080; x=1747792880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KJ5O3UXdUB35fI43iM3QQGGfX/atuJHwxx9HwDDLJk=;
        b=ME8/HPckp1q8RSNOmxIPGE08YdE0a8XxEh4oYxTT9MmM4qRU6kn/rysETty1yGt+0d
         qkcFm01TdRKOSXexTVwD50fcKLtfErHpELb8VH+Ut+sxIX91nHlcS13zhLebr3LiCBfb
         vvRhZ+rdBK0aHrhRLcgr/ZMJeWRg+oOhO5AxznSZGtfFnrcU22Kh0v9svflD0Qhjq2h+
         TkEWV8PrAnNsXeN9FfTvnaIjnN5zZ97ObX9eB/Gwwk0KtNgDjgsvYyX3EKTR9O2+oVMw
         6UZZt5YZhR+Z1MmWKqOlqnAGcUbqulpKaKsemxrIqKwxLjiNRj2SMnftV5HurL25cJgb
         sFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747188080; x=1747792880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KJ5O3UXdUB35fI43iM3QQGGfX/atuJHwxx9HwDDLJk=;
        b=QVOTlaeUr75Vv7crrpSuV/AV1bfWNKfIXXGub5jC2/HOaUxdBMXBP2Oxw1VaFPt6vY
         vsnSgeoDnT68yTtz76pjKCVk8h9zfD+W73p5zkA/3oJT5ya9a2w7KOv+HpOHl8bb8fVO
         VSPA1Z0O5HEp1enY+ckAgd9GSpWE43dVqOWzkTVmRIKIkwE62rSjgTZ0YvEDxLRy98/Y
         jO5LnPHmQPft9x4BeXjsE3LzQcDyIvCHxSKPF9TTVq6B8AU3krHYMb6OW19e+96tsKa7
         L30Klabsj7FZ2Z1sZgiYmApGiQSASk7L3nEzdMqQyUodWVWD09HHzFTO5v+QiIYhxywU
         QAiQ==
X-Gm-Message-State: AOJu0YwGuVfXljhhcZTwIFJOgsbSZgqLT/Ug5amOhPo6nG1iBjxqMlHb
	EEHhFK7Ffo9wA8miVVC6AQsokQGUxQv5FqtpjZDGGajIU7Wdm/ls2uPUMw==
X-Gm-Gg: ASbGncsbm1ayGCQySlNdD77Ce/C0BoYFwbHFoTUieo/vzCxJZST/yiyK3ShrlQjEPYY
	nbJSubp24nma5d3Phc6Bn+KhRidnWWvzw9RjyUzk0shiPQA+iLkSENedKz7V73ftlYG+OS7lP5p
	82daQ8fit9UHW6JyPGP2NdY81KkOKygDVZ6zlyeDsLnQlt+Y4rmA9Nd1b7aDkog/V8y+KgXimdx
	+7M/O3VZkN8C085ZkNUcihQRNFoiwlZTQaTjb7UYjm+hIPE9A7UjQlIWDu42+FYM35dv6o8RLW6
	LI/AtEAKHe97qdpGqgMIWeJ4KZ36QOLWFt0Ops24kKR84xRKYhJWYhGscBUocEjtcuE=
X-Google-Smtp-Source: AGHT+IGw7yol5SFxwwjjh1ZDEQMo/i23fLJw2QMcMyB8ReO949tYQBbnRyjkwIRNoTFzjuK22mf2hQ==
X-Received: by 2002:a17:903:2443:b0:223:2630:6b82 with SMTP id d9443c01a7336-231981058d0mr27091825ad.10.1747188079716;
        Tue, 13 May 2025 19:01:19 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c43sm88888395ad.139.2025.05.13.19.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 19:01:19 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com
Subject: [PATCH v3] submodule: prevent overwriting .gitmodules entry on path reuse
Date: Wed, 14 May 2025 07:31:08 +0530
Message-ID: <20250514020108.24396-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <xmqq7c2kgp8e.fsf@gitster.g>
References: <xmqq7c2kgp8e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a submodule is added at a path that previously hosted another submodule
(e.g., 'child'), Git reuses the submodule name derived from the path and
updates the corresponding entry in .gitmodules. This can silently overwrite
existing configuration if the old submodule was only moved (e.g., to
'child_old') without renaming the submodule.

Teach `module_add()` to look up the chosen submodule name in the
repository existing submodule config.  If that name is already in
use and points at a *different* path, we now die with an error,
prompting the user to supply `--name`. Increment the name to an
appropriate unique name (Like file system) when --force is called upon.

Add helper `submodule_active_matches_path()` so we can
re-implement the old “is this path already covered by
submodule.active?” logic without re-reading the config twice.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/submodule--helper.c | 62 ++++++++++++++++++++++++++++++-------
 t/t7400-submodule-basic.sh  | 23 ++++++++++++++
 2 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116dd..ef9e733cfb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -32,6 +32,8 @@
 #include "advice.h"
 #include "branch.h"
 #include "list-objects-filter-options.h"
+#include "wildmatch.h"
+#include "strbuf.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -3323,6 +3325,23 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
 	return ret;
 }
 
+static int submodule_active_matches_path(const char *path)
+{
+	const struct string_list *values;
+	size_t i;
+
+	if (git_config_get_string_multi("submodule.active", &values))
+		return 0;
+
+	for (i = 0; i < values->nr; i++) {
+		const char *pat = values->items[i].string;
+		if (!wildmatch(pat, path, 0))
+			return 1;
+	}
+
+	return 0;
+}
+
 static void configure_added_submodule(struct add_data *add_data)
 {
 	char *key;
@@ -3370,17 +3389,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get("submodule.active")) {
-		/*
-		 * If the submodule being added isn't already covered by the
-		 * current configured pathspec, set the submodule's active flag
-		 */
-		if (!is_submodule_active(the_repository, add_data->sm_path)) {
-			key = xstrfmt("submodule.%s.active", add_data->sm_name);
-			git_config_set_gently(key, "true");
-			free(key);
-		}
-	} else {
+	if (!submodule_active_matches_path(add_data->sm_path)) {
 		key = xstrfmt("submodule.%s.active", add_data->sm_name);
 		git_config_set_gently(key, "true");
 		free(key);
@@ -3443,7 +3452,11 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
 	struct add_data add_data = ADD_DATA_INIT;
 	const char *ref_storage_format = NULL;
+	const struct submodule *existing;
 	char *to_free = NULL;
+	struct strbuf buf = STRBUF_INIT;
+	int i;
+	int allocated_sm_name = 0;
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
 			   N_("branch of repository to add as submodule")),
@@ -3546,6 +3559,31 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	if(!add_data.sm_name)
 		add_data.sm_name = add_data.sm_path;
 
+	existing = submodule_from_name(the_repository,
+					null_oid(the_hash_algo),
+					add_data.sm_name);
+
+	if (existing && strcmp(existing->path, add_data.sm_path)) {
+		if (!force) {
+			die(_("submodule name '%s' already used for path '%s'"),
+			add_data.sm_name, existing->path);
+		}
+
+		/* --force: build <name><n> until unique */
+		for (i = 1; ; i++) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
+			if (!submodule_from_name(the_repository,
+						null_oid(the_hash_algo),
+						buf.buf)) {
+				break;
+			}
+		}
+
+		add_data.sm_name = strbuf_detach(&buf, NULL);
+		allocated_sm_name = 1;
+	}
+
 	if (check_submodule_name(add_data.sm_name))
 		die(_("'%s' is not a valid submodule name"), add_data.sm_name);
 
@@ -3561,6 +3599,8 @@ static int module_add(int argc, const char **argv, const char *prefix,
 
 	ret = 0;
 cleanup:
+	if (allocated_sm_name)
+		free((char *)add_data.sm_name);
 	free(add_data.sm_path);
 	free(to_free);
 	strbuf_release(&sb);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d6a501d453..5c3f471338 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1482,4 +1482,27 @@ test_expect_success '`submodule init` and `init.templateDir`' '
 	)
 '
 
+test_expect_success 'submodule add fails when name is reused' '
+	git init test-submodule &&
+	(
+		cd test-submodule &&
+		git commit --allow-empty -m "initial commit" &&
+
+		git init ../child-origin &&
+		git -C ../child-origin commit --allow-empty -m "initial commit" &&
+
+		git submodule add ../child-origin child &&
+		git commit -m "Add submodule child" &&
+
+		git mv child child_old &&
+		git commit -m "Move child to child_old" &&
+
+		# Create another submodule repo
+		git init ../child2-origin &&
+		git -C ../child2-origin commit --allow-empty -m "initial commit" &&
+
+		test_must_fail git submodule add ../child2-origin child
+	)
+'
+
 test_done
-- 
2.49.GIT

