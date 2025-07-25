Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622E12EE97B
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460660; cv=none; b=TrHW8UwnW+Ly4gI0p9SQQjpN/ZoW3rLuRepFp9OpE4b4am/D5bzBfzGcD6jJn2TC2vUBO8Q4VUlOYGuM/oyqbSBd06PSoW36rsbygbs1E1H3s+1qbSVDAQXZclqOS2Ar7gHc2tuJNfW1rAtY4bZYVZXkkEB9xH/qABRSwa4T0w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460660; c=relaxed/simple;
	bh=UXwggx9k+7ngRMyosw65/iIEoOHC6DxoIZYMMDJgjGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bC+S83Jwjk+UVZKVQPhBFxjPCizpn1Ub6BPnf8HcC5jKRbH5XJ0FzwQQ66/K5+W036jYUmCwnEq3jhfZb5Yju4ZpX8dPApONHLyH/CGwvNRIcLhP8krrtYUnauM3khGsB5euFlecUcqTML1V3KEGSNZLlfphHjcSmya+Gbxmaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLNqc68f; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLNqc68f"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b391ca6146eso2074356a12.3
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753460659; x=1754065459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZCW8iLawx1LgOvD0eVw1urI881UEEaGY01hDBF9wV4=;
        b=LLNqc68fcBJy3m0YSYCSFD9OtJdak+5lJBzoWTEp3gCy17jx6C6FV/Y+zEyiRzSS3D
         LDri7T9y0ldiI6LSddLLndKdu1dKBAIjRA0izFgj3mq7zC/l6auccwb0mv3juBO7VeSv
         9Vf/0Ksebttb0QYSQvmzFQTZhCV7Y9JFXyQoGy+2O4tQhajt9uZEQCl2lTe+B7S4pBIN
         Vf8m1WcOjXbVc9DEORq0+eBtTg9T91MRoIThTP0zpLug5cNJX6MBss0x7XuHwZo8BYfL
         L6gmY8YRR1aNXyOvtUReIQZQqWh+RnmpqmY2tuSAp0Yn8qzlA7Ib68MIzHwev6UvvrgM
         jUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460659; x=1754065459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZCW8iLawx1LgOvD0eVw1urI881UEEaGY01hDBF9wV4=;
        b=sip5DNJqCsN8d4qexsahJj4HDvZWmiEqgkblXckgBFieA+V3igGFEcKjEIMFTxiEoT
         Tp4eLVOeXWaYUEgFiWQpvgHFubFxaVK+D/UB782Fngc/6u+YKrByFLLOJk8M5kWj/0/O
         Hqn3B2uD4SWJqnRTEiE3pLEaNlZqWLA8/vXAGzwtjqZjhL/iiaSGmwWLPZG3gBuof8iy
         c1YjnneDrKfQ2yHMUloCHcp4koTm5OXrS5edfuzi6Tfa2BL5oHQMU7uk94amG0mJ8nnA
         1Qjp2opdeAr1rqyyJkUvq7zV6L3PPbm4Q6uDarDs+AGysg6fN/dh6Ud5K8lEaQjOMxZ2
         Bu4w==
X-Gm-Message-State: AOJu0YxYqNQzaPy7fQkMAe/Z+5WQYzph/m/fNhGzZiWjDYrD0Ya+qKWh
	WsvLRLb4ikpXZ+XyCkyoSWZIYI1l9QiW0ef89CpUFjSVvzRmDJRWjcL6q877ig==
X-Gm-Gg: ASbGnctw+Vkfspqq34EEZHm2tFXJU5pcu6sgWP0FKViqCs56Iq6vmujMIX2cPx8zqw/
	QIYRFXzrefBfw9DkJdPNCf6yAvuNWiEM5Zvl/f4nIf5EcJDA1pOX/K6DEiHLYdZx13lbhucS7Rk
	aC6Z1TFhIG2QFt/I4ZysSN/0sfFa3YyZTHVWj9E7gYgWkrVxcUF8cafssu6m7ai3bruBz0rqsK2
	QrZ3l1x694qSWMc9Vs3GIbnfnqPbuUIZYHNp+WPHMSBI+Y5s+/+Hcv3RvcMFWM8zYpyK33qGxb1
	i5DD6zBvx51IqmAZ4/3DG/hXZwYB7VWuLjET/5Im7jaGJeyU5Omf8UZ2QN/OGBrTCrvKEAXRr3M
	Mc+6aRGnjXzkhmWG/zfG5kET5GEwRcPi8IuA=
X-Google-Smtp-Source: AGHT+IE1f1N7Un77843jq3bzhPBofLcXSEuwZV5AWlRZFEKux+GQ9kxjiTFubqzx+vyJ2sWHY0VSJg==
X-Received: by 2002:a17:903:2b10:b0:234:f1ac:c036 with SMTP id d9443c01a7336-23fb31c4de1mr40404145ad.50.1753460658627;
        Fri, 25 Jul 2025 09:24:18 -0700 (PDT)
Received: from fedora ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe5740d9sm704335ad.200.2025.07.25.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:24:18 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 1/2] submodule: prevent overwriting .gitmodules on path reuse
Date: Fri, 25 Jul 2025 21:54:01 +0530
Message-ID: <20250725162402.92098-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.50.GIT
In-Reply-To: <20250725162402.92098-1-jayatheerthkulkarni2005@gmail.com>
References: <20250724152418.45226-1-jayatheerthkulkarni2005@gmail.com>
 <20250725162402.92098-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding a submodule at a path that previously hosted
another submodule (e.g., 'child') reuses the submodule
name derived from the path. If the original submodule
was only moved (e.g., to 'child_old') and not renamed,
this silently overwrites its configuration in .gitmodules.

This behavior loses user configuration and causes
confusion when the original submodule is expected
to remain intact. It assumes that the path-derived
name is always safe to reuse, even though the name
might still be in use elsewhere in the repository.

Teach module_add() to check if the computed submodule
name already exists in the repository's submodule config,
and if so, refuse the operation unless the user explicitly
renames the submodule or uses the --force option,
which will automatically generate a unique name by
appending a number (e.g., child1).

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-submodule.adoc |  7 +++++++
 builtin/submodule--helper.c      | 26 ++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh       | 22 ++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index 87d8e0f0c5..503c84a200 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -307,6 +307,13 @@ OPTIONS
 --force::
 	This option is only valid for add, deinit and update commands.
 	When running add, allow adding an otherwise ignored submodule path.
+	This option is also used to bypass a check that the submodule's name
+	is not already in use. By default, 'git submodule add' will fail if
+	the proposed name (which is derived from the path) is already registered
+	for another submodule in the repository. Using '--force' allows the command
+	to proceed by automatically generating a unique name by appending a number
+	to the conflicting name (e.g., if a submodule named 'child' exists, it will
+	try 'child1', and so on).
 	When running deinit the submodule working trees will be removed even
 	if they contain local changes.
 	When running update (only effective with the checkout procedure),
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d8a6fa47e5..9406e732c4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3423,6 +3423,9 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	struct add_data add_data = ADD_DATA_INIT;
 	const char *ref_storage_format = NULL;
 	char *to_free = NULL;
+	const struct submodule *existing;
+	struct strbuf buf = STRBUF_INIT;
+	char *sm_name_to_free = NULL;
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
 			   N_("branch of repository to add as submodule")),
@@ -3525,6 +3528,28 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	if(!add_data.sm_name)
 		add_data.sm_name = add_data.sm_path;
 
+	existing = submodule_from_name(the_repository,
+					null_oid(the_hash_algo),
+					add_data.sm_name);
+	
+	if (existing && strcmp(existing->path, add_data.sm_path)) {
+		if (!force) {
+			die(_("submodule name '%s' already used for path '%s'"),
+			    add_data.sm_name, existing->path);
+		}
+		/* --force: build <name><n> until unique */
+		for (int i = 1; ; i++) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
+			if (!submodule_from_name(the_repository,
+						null_oid(the_hash_algo),
+						buf.buf)) {
+				break;
+			}
+		}
+		add_data.sm_name = sm_name_to_free = strbuf_detach(&buf, NULL);
+	}
+
 	if (check_submodule_name(add_data.sm_name))
 		die(_("'%s' is not a valid submodule name"), add_data.sm_name);
 
@@ -3540,6 +3565,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
 
 	ret = 0;
 cleanup:
+	free(sm_name_to_free);
 	free(add_data.sm_path);
 	free(to_free);
 	strbuf_release(&sb);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d6a501d453..0743ccdfe2 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1482,4 +1482,26 @@ test_expect_success '`submodule init` and `init.templateDir`' '
 	)
 '
 
+test_expect_success 'submodule add fails when name is reused' '
+	git init test-submodule &&
+	(
+		cd test-submodule &&
+		git commit --allow-empty -m init &&
+
+		git init ../child-origin &&
+		git -C ../child-origin commit --allow-empty -m init &&
+
+		git submodule add ../child-origin child &&
+		git commit -m "Add submodule child" &&
+
+		git mv child child_old &&
+		git commit -m "Move child to child_old" &&
+
+		git init ../child2-origin &&
+		git -C ../child2-origin commit --allow-empty -m init &&
+		test_must_fail git submodule add ../child2-origin child 2>err &&
+		test_grep "submodule name '\''child'\'' already used for path '\''child_old'\''" err
+	)
+'
+
 test_done
-- 
2.50.GIT

