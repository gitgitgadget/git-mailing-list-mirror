Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898C351FD3
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071204; cv=none; b=OApFBlmMfXWisv2FWgMT7tArvQjFg9JpNRxPw0lzcBsdxQ/qaoVdHXCqufvO/8VblLAM+cONxeY4eDUSui69jyf7A1rA1oEqf0i7wGr9vL7w/7SAQTKIEUSQjYr37y2EYOzb7HeFyrFmA0gxbSJ/Wkohz4wcwZDgzivTf+XXSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071204; c=relaxed/simple;
	bh=Y/1z9mDbttwF1Oz9EGCM4ypi1gylJIj2DGdKNiShjwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBTm08ys9MOV/kV/Ez4jkzZ9MkuGbhKeRfFhXbD3vRDdlGatm8R+PIWHy/WeVK3OGY9HO3LCaVdbiY03wWfForEj+6PrSPLIiHngcWAXaz8/L5cWVU7aY2Kx2DIOh36qCdWfzPjjpOezghuUf9kaSFa2wKD3tyvGzq0KC+ShMOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYaXzsmC; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYaXzsmC"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c28c21aba1so2798311a34.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071201; x=1761676001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlLexj9kVo9nI+S8Wt+HjSuhCHHLaFQn5Ne3aHbuLgM=;
        b=QYaXzsmCNfjxlUh5x4m/W2dZ3aSlG3JZfybBkGEOlMN6e1d23t/Whgy1UOGUWArpYg
         +/WucbXg/m4oTEa4bG3vU7t02oy679XpeQqIJdxAeEajgx0XEZF+ganlgzwPO4hJhCJL
         UtWc3k+EqfkjMDW0MsJgKKNLi1Rob+vQ6pKel2Xlwxh8QoIokdNE7ai0Bbj3Olq3SoQx
         ocI32l+nrVekqoaJ72T2Qtd1r7/xYeKMSIXA0PCZ4dLbEWBwes63zx/Zp9FqV0fwKeEk
         dEo6lSJIdogl3oqGsUWeE4q4QVbDjVvGsmh3uTiBw2xIBeFvbLi1Tbsog9RaXCHATMxo
         gTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071201; x=1761676001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlLexj9kVo9nI+S8Wt+HjSuhCHHLaFQn5Ne3aHbuLgM=;
        b=IRFvt7GSxDLoJwt3P0141WpH+lV5RArbQRipBTcEBdXbCI5Acpdg8t7RaaZz2FbMra
         OVZO2P5SyMpvRwy3qrc9Oh2tSgkj4dMM5qkSTXQGLKrnwqh8zRa49u+QU2aWvkvGQFL4
         n3hAsoFfk92HiPsV+snCkbWZw/RBIRO+TAQVMvxBim2zFJKiIF7YBuYMeALj8+qKg75a
         Xy7JTdbfemew+5W8L1slXxqdzMyJvMdQHy8nuP8e6qUpGUPWOMCFtc8jEeZTj/5TxkXB
         5Xv9Xh2dbPh8mc90yH+vjqpsuRQb0pzSieBGdDeM6EAQ4GyNf7Z/YGkpk1CnZWzA4Fqm
         i/5Q==
X-Gm-Message-State: AOJu0YzBTlZnsv5zDE/g0kmJZuFqClkVzYNpaqwt8zPasnyW5jILgXPk
	ZnhDpROv7WyLWj3iu47FeewlyULIK5p2xBoRWo3U6QGDBRCCfIxcerKglU0OsA==
X-Gm-Gg: ASbGncvB3kS36iuenwDmWlZyEN7eW6afHNpsTSLOZAxiiDd5nn0cUcCnloSt2zsSHdX
	ZatFYdSsJzklBKut8uW5oncmbzf1ozXIS4NgI1YtG1fEw0bO7zghf8vP0jsmjr0v/CmewOE3W8c
	buQCGprLjvI9ytRgypl5JPPnXUL39mkc0ODrN9zNr39kMMRtW8/7BmmlkK2rOXe8vj6KTZcaNMx
	lxh0obZUZ0xdpsi2m6Nghr2nBglcfSHo6nKqKCw36RlbDaFZZbe847OsT6TDCYQOtCNCVptf7Ey
	yQGh6WUTTPlbbUt0LzgF60/A5KpCpqJU1Dl2tI/kxv5M5XL9EcsRZyOc+RYERBrgU23b4RHT4ZC
	jStsS2j0IZTNAKbnRWjvc2adenn+wmVUsb6uo2t/kNsKw1XtR4qdZSke90BYi++tD7NkBIzpjii
	T/0xg8ekgx
X-Google-Smtp-Source: AGHT+IFgMjmJSTOhIi69ugRRSOobO1PUoFW4e9OEenh59JclpQ/L9sUjmUyu9Ht36IBlCWQqBcI1SQ==
X-Received: by 2002:a05:6808:320a:b0:43f:61b6:2ab9 with SMTP id 5614622812f47-443a2f114f4mr8218565b6e.15.1761071201328;
        Tue, 21 Oct 2025 11:26:41 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443df722e5csm2795853b6e.24.2025.10.21.11.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:26:40 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v6 7/7] builtin/repo: add progress meter for structure stats
Date: Tue, 21 Oct 2025 13:26:01 -0500
Message-ID: <20251021182601.2687284-8-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20251021182601.2687284-1-jltobler@gmail.com>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using the structure subcommand for git-repo(1), evaluating a
repository may take some time depending on its shape. Add a progress
meter to provide feedback to the user about what is happening. The
progress meter is enabled by default when the command is executed from a
tty. It can also be explicitly enabled/disabled via the --[no-]progress
option.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c            | 46 ++++++++++++++++++++++++++++++++++-----
 t/t1901-repo-structure.sh | 20 +++++++++++++++++
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 1754cc7e5d..9d4749f79b 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -4,6 +4,7 @@
 #include "environment.h"
 #include "parse-options.h"
 #include "path-walk.h"
+#include "progress.h"
 #include "quote.h"
 #include "ref-filter.h"
 #include "refs.h"
@@ -362,6 +363,7 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 struct count_references_data {
 	struct ref_stats *stats;
 	struct rev_info *revs;
+	struct progress *progress;
 };
 
 static int count_references(const char *refname,
@@ -371,6 +373,7 @@ static int count_references(const char *refname,
 {
 	struct count_references_data *data = cb_data;
 	struct ref_stats *stats = data->stats;
+	size_t ref_count;
 
 	switch (ref_kind_from_refname(refname)) {
 	case FILTER_REFS_BRANCHES:
@@ -395,26 +398,41 @@ static int count_references(const char *refname,
 	 */
 	add_pending_oid(data->revs, NULL, oid, 0);
 
+	ref_count = get_total_reference_count(stats);
+	display_progress(data->progress, ref_count);
+
 	return 0;
 }
 
 static void structure_count_references(struct ref_stats *stats,
 				       struct rev_info *revs,
-				       struct repository *repo)
+				       struct repository *repo,
+				       int show_progress)
 {
 	struct count_references_data data = {
 		.stats = stats,
 		.revs = revs,
 	};
 
+	if (show_progress)
+		data.progress = start_delayed_progress(repo,
+						       _("Counting references"), 0);
+
 	refs_for_each_ref(get_main_ref_store(repo), count_references, &data);
+	stop_progress(&data.progress);
 }
 
+struct count_objects_data {
+	struct object_stats *stats;
+	struct progress *progress;
+};
 
 static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			 enum object_type type, void *cb_data)
 {
-	struct object_stats *stats = cb_data;
+	struct count_objects_data *data = cb_data;
+	struct object_stats *stats = data->stats;
+	size_t object_count;
 
 	switch (type) {
 	case OBJ_TAG:
@@ -433,20 +451,31 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 		BUG("invalid object type");
 	}
 
+	object_count = get_total_object_count(stats);
+	display_progress(data->progress, object_count);
+
 	return 0;
 }
 
 static void structure_count_objects(struct object_stats *stats,
-				    struct rev_info *revs)
+				    struct rev_info *revs,
+				    struct repository *repo, int show_progress)
 {
 	struct path_walk_info info = PATH_WALK_INFO_INIT;
+	struct count_objects_data data = {
+		.stats = stats,
+	};
 
 	info.revs = revs;
 	info.path_fn = count_objects;
-	info.path_fn_data = stats;
+	info.path_fn_data = &data;
+
+	if (show_progress)
+		data.progress = start_delayed_progress(repo, _("Counting objects"), 0);
 
 	walk_objects_by_path(&info);
 	path_walk_info_clear(&info);
+	stop_progress(&data.progress);
 }
 
 static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
@@ -458,10 +487,12 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	enum output_format format = FORMAT_TABLE;
 	struct repo_structure stats = { 0 };
 	struct rev_info revs;
+	int show_progress = -1;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
 			       PARSE_OPT_NONEG, parse_format_cb),
+		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 		OPT_END()
 	};
 
@@ -471,8 +502,11 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 
 	repo_init_revisions(repo, &revs, prefix);
 
-	structure_count_references(&stats.refs, &revs, repo);
-	structure_count_objects(&stats.objects, &revs);
+	if (show_progress < 0)
+		show_progress = isatty(2);
+
+	structure_count_references(&stats.refs, &revs, repo, show_progress);
+	structure_count_objects(&stats.objects, &revs, repo, show_progress);
 
 	switch (format) {
 	case FORMAT_TABLE:
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 14bd8aede5..36a71a144e 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -106,4 +106,24 @@ test_expect_success 'keyvalue and nul format' '
 	)
 '
 
+test_expect_success 'progress meter option' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit foo &&
+
+		GIT_PROGRESS_DELAY=0 git repo structure --progress >out 2>err &&
+
+		test_file_not_empty out &&
+		test_grep "Counting references: 2, done." err &&
+		test_grep "Counting objects: 3, done." err &&
+
+		GIT_PROGRESS_DELAY=0 git repo structure --no-progress >out 2>err &&
+
+		test_file_not_empty out &&
+		test_line_count = 0 err
+	)
+'
+
 test_done
-- 
2.51.0.193.g4975ec3473b

