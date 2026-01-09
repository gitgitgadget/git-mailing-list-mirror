Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE86E33D4F5
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993966; cv=none; b=CK0r1dsB62OMBrRqIZWUjeqqUWvShjhyjj0gkBju7eR3z+m+9WIhynxyvoGVp60/XCmET1N+DoufmaawX2ayxSO58QU2GVwR1rDKrNrnXqnxaxp0D6LvRiqmX2ia5x77pLX042IZ3E7uZqJTLcfzR6O6aoTb++fA67JGXHKRz7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993966; c=relaxed/simple;
	bh=TYsM34z8qvrnaGSzkOngQSxmJa6kkM51DVufZi68zm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyADlBi0IFE8rE4R0HbpvNFZpf1L5SBN4poXxQQNYwK0af254yGMnogETP+M16DDAH+nTr0y3Ra2MEBa4tTQ69Ub6H2Hjz2r47zhK3r2RRT7pB5Q9stOfZid/hAFdTbl7M2mrT4EAPZyesmjR7jIrTSI+aPfYMvuADG7MfaQUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agKDn+8F; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agKDn+8F"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5636784883bso868007e0c.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 13:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767993964; x=1768598764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fmhqsdERzyOHmKvJLKzNHd0atlIu8Wm2gnVhM5BwHQ=;
        b=agKDn+8F1HgMHaJaacJeimhIKAUXZELRNa27z6dFjVqMCgdZZRSzHakfg8DeeMKblc
         7Kx7hCfKou2oJyZ+skQEB671Q0a9uUDP7AaEWSZrHMlsCvGy/BfLJl1JNNOCnY7uvg33
         HyQ5tG3buQmkkuK/SIjXKBNXeDyasipBB9yMKVs1du5ddTkPu9MsNbU+qNXXO6KTDcOs
         I4g+mZ3eOWlzTSNlk7hCMW3hThWhOGfz3exXc1bpnINNeFG5QgA8d679TVG6Nk3CEEoU
         kcJ9DJuIZ6DM4Ay4xNxoWrU3W55Nz4VqGCM3unuCTr0zkgvM2tRFgLuZkN5wMQI+peYr
         xrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767993964; x=1768598764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4fmhqsdERzyOHmKvJLKzNHd0atlIu8Wm2gnVhM5BwHQ=;
        b=TVKAO2JsvS8JXSpAKBI0lXbTVipu89akm9mb6T4xrNtlDzIY37yWrM0QpxOUNsoFLB
         tEnVY2J1jkqPjUGDYdCamqOlU/pwZBIcId30GQQWZVrD6UqlWr6rZUvv99JG4LfBxCO+
         tWr7hRbkQLmZLIdaI61AW+uiSHgJofaWihbiYrOTCLok546YDWsdNjkcQyKvh2cBHqvg
         NDOxjrxjESPjfW8lVcDUpORF/wN+LjnRxhGRniQ4/lq5PHE5VxFetvf1AWRquTJwtZqI
         7eSpX5AuV+v+GT9kNgAycvTdlB/RvWbWt3hs07oSAN3TMpn4SnXO/+ntBBPWubW753f1
         jFxA==
X-Gm-Message-State: AOJu0YyyBL5QcpO5/tXkvHFcLgFQVDWDVenbBAXS0DfZstj5CjBt/nrs
	I8hBEQEjwP3CAFGedThgOW3Lo9vxRY2ytoYX8Pz7wwioTk7+1Drou9K7KkUAeA==
X-Gm-Gg: AY/fxX4NQRbWuTffbsJGntbCS2QaY95lJGD5IB/GmHJCIUiswk237C6pl6Q8hSopQGy
	eCfwKr1O+Kxr1h0i8FfUeZFo6iJFqaGnMTBDLG7N1CR5sNUH8ooCbA4CUDJogPczqSE2AVbZDFt
	2x/ZvbYpIKBEn/Thr99IFhEWmfoBN2g4UBIRck8CQE0ynkb5c6BYiL0RTTkemtEAjy+QcMCYdiV
	WRTX1e6dCmkVGKAq5oT8/1Xd9iXxezfgnGFdiemIjI5SHZYiBkwhlKaWZCG7IJMnJ1wIJ40nEg0
	XJBVILBHAcYnS9D6jYP6yy66VwVQIjvLHQmRWRzO6pQgeJY6t9g4WgvV/Sy+yKiTNs+MrmycmbP
	bMvuLPcF4RdfqkrvxwXdcEF5J0H2EZGCQ/R59eb95abO9RfJz3elXkhsxPxFOLWqJsRDJRi1XtL
	veBhSqWRrI7XE2Kwgw9CXCKmwafoBRqxKDv/vYAu6LgnWyV60GtMhfvhVZ
X-Google-Smtp-Source: AGHT+IHk0559ZFawv7jPrXcD9+7AsBdZBEznDO+TTJb6sxe2ytvocNBNIcu3eo74NAypCYxPQD3Ljg==
X-Received: by 2002:a05:6122:4f9c:b0:559:60b8:fa81 with SMTP id 71dfb90a1353d-56347d3a0c9mr4880214e0c.4.1767993963707;
        Fri, 09 Jan 2026 13:26:03 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:b77d:586:c136:4246:ee92:fdfb])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a443e32sm10595955e0c.22.2026.01.09.13.26.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Jan 2026 13:26:03 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v3 1/2] repo: add a default output format to enum output_format
Date: Fri,  9 Jan 2026 17:31:52 -0300
Message-ID: <20260109211554.90828-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "default" as an option for --format in both git-repo-info and
git-repo-structure. Using `--format=default` makes those commands use
their default output format.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 19 ++++++++++++-------
 builtin/repo.c              | 18 ++++++++++++++----
 t/t1900-repo.sh             | 12 ++++++++++++
 t/t1901-repo-structure.sh   | 22 ++++++++++++++++++++++
 4 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 7d70270dfa..fa0e6600af 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,8 +8,8 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
-git repo structure [--format=(table|keyvalue|nul) | -z]
+git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]
+git repo structure [--format=(default|table|keyvalue|nul) | -z]
 
 DESCRIPTION
 -----------
@@ -19,7 +19,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [--format=(keyvalue|nul) | -z] [--all | <key>...]`::
+`info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
@@ -30,11 +30,14 @@ requested. The `--all` flag requests the values for all the available keys.
 The output format can be chosen through the flag `--format`. Two formats are
 supported:
 +
+`default`:::
+	synonym for `keyvalue`.
+
 `keyvalue`:::
 	output key-value pairs one per line using the `=` character as
 	the delimiter between the key and the value. Values containing "unusual"
 	characters are quoted as explained for the configuration variable
-	`core.quotePath` (see linkgit:git-config[1]). This is the default.
+	`core.quotePath` (see linkgit:git-config[1]).
 
 `nul`:::
 	similar to `keyvalue`, but using a newline character as the delimiter
@@ -44,7 +47,7 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
-`structure [--format=(table|keyvalue|nul) | -z]`::
+`structure [--format=(default|table|keyvalue|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
 +
@@ -56,10 +59,12 @@ supported:
 The output format can be chosen through the flag `--format`. Three formats are
 supported:
 +
+`default`:::
+	synonym for `table`.
+
 `table`:::
 	Outputs repository stats in a human-friendly table. This format may
-	change and is not intended for machine parsing. This is the default
-	format.
+	change and is not intended for machine parsing.
 
 `keyvalue`:::
 	Each line of output contains a key-value pair for a repository stat.
diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..306d3fa2df 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -17,14 +17,15 @@
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
-	"git repo structure [--format=(table|keyvalue|nul) | -z]",
+	"git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]",
+	"git repo structure [--format=(default|table|keyvalue|nul) | -z]",
 	NULL
 };
 
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
 enum output_format {
+	FORMAT_DEFAULT,
 	FORMAT_TABLE,
 	FORMAT_KEYVALUE,
 	FORMAT_NUL_TERMINATED,
@@ -161,6 +162,8 @@ static int parse_format_cb(const struct option *opt,
 		*format = FORMAT_KEYVALUE;
 	else if (!strcmp(arg, "table"))
 		*format = FORMAT_TABLE;
+	else if (!strcmp(arg, "default"))
+		*format = FORMAT_DEFAULT;
 	else
 		die(_("invalid format '%s'"), arg);
 
@@ -170,7 +173,7 @@ static int parse_format_cb(const struct option *opt,
 static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
-	enum output_format format = FORMAT_KEYVALUE;
+	enum output_format format = FORMAT_DEFAULT;
 	int all_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
@@ -185,6 +188,10 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+
+	if (format == FORMAT_DEFAULT)
+		format = FORMAT_KEYVALUE;
+
 	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
 		die(_("unsupported output format"));
 
@@ -638,7 +645,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	struct stats_table table = {
 		.rows = STRING_LIST_INIT_DUP,
 	};
-	enum output_format format = FORMAT_TABLE;
+	enum output_format format = FORMAT_DEFAULT;
 	struct repo_structure stats = { 0 };
 	struct rev_info revs;
 	int show_progress = -1;
@@ -658,6 +665,9 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	if (argc)
 		usage(_("too many arguments"));
 
+	if (format == FORMAT_DEFAULT)
+		format = FORMAT_TABLE;
+
 	repo_init_revisions(repo, &revs, prefix);
 
 	if (show_progress < 0)
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 51d55f11a5..e6670f0f58 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -131,4 +131,16 @@ test_expect_success 'git repo info --all <key> aborts' '
 	test_cmp expect actual
 '
 
+test_expect_success '--format=default is a synonym for --format=keyvalue' '
+	git repo info --all --format=keyvalue >expect &&
+	git repo info --all --format=default >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--format=default resets the format' '
+	git repo info --all >expect &&
+	git repo info --all --format=nul --format=default >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 17ff164b05..9c5054c8db 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -181,4 +181,26 @@ test_expect_success 'progress meter option' '
 	)
 '
 
+test_expect_success '--format=default is a synonym for --format=table' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git repo structure --format=table >expect &&
+		git repo structure --format=default >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--format=default resets the format' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git repo structure >expect &&
+		git repo structure --format=nul --format=default >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.50.1 (Apple Git-155)

