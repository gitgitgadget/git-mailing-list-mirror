Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480502DAFBB
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562747; cv=none; b=ge50ZQvTE78ydd8GXb5UUMuwjmuY94mHJK/e4vvPOD2YPTLtJ/7wNrM3ESUkLatsCf0zg8KuvtViX9gt1H2Xh7KFBmHGD3UbGv+4rz87wo3j30ncJLsWhcz+pogYYJF863UL4Dt+zptfN+LevNy6MdfePDW450lJq15/srlb36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562747; c=relaxed/simple;
	bh=g05vTJeyxaUV3sxP6Pu/j9WNAX2qlu/fgcrcwzz9f2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0zlxn2tvGDwoGwjteau0P5meqV2KJJFj5R7jzxNHrthw0tErSk/KQkn9KbiEDQysKrb8LCXOgMd3jBId0Q5PwlzdFJbSO7hvzUJCBYEZ/Yys8KHrqFfD/D68yQgYN4k9DilXcyKaZfucazEe+VSAtBvcwNqqk3eOVv59C5XRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLq/KEQL; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLq/KEQL"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-355102ff142so19218fac.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760562744; x=1761167544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aojgg6YF9FaNgR80hsYH2+jOYnhgUq9+sHgKVFMY9Eg=;
        b=fLq/KEQLcBuM+f3FV2XH3BhjFkLgb2KxqcDq0O+o9cwufb6uBcZfJfvhw6+0um8+DF
         Kb8PtxVyXPkPkWmB+MZ0Z9Jm3cUGuSDW3DQ0GSO89kIJr3y6NFIOFOKTWcJe9Dj+ImKc
         pQOzBIN3ZYNXidzZpY3pMeKJkyBj7multFdOEwFYM4f5M2EfLL0AxfrCv+o5JxP0oQzg
         T8rD8D++Ivydls0tIJmJi8hMCzkZWSDjQjLLETwKqnCyZAUKjiPD15NdgbfDKhw6LjfA
         +QaxGor4M10nKnAmnEHwYlgtpLkA77RGagt29EOvgrdiRpfpJcM/g4rDebIlLPe2zHDU
         Se8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562744; x=1761167544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aojgg6YF9FaNgR80hsYH2+jOYnhgUq9+sHgKVFMY9Eg=;
        b=HyRsPol3BOKy5PaskHw0VZO9/u6wXAPVa2aCJ6AJOKDwVXVjAEQxR/iHrMPG6xtItV
         OLg7qMJ8pmAWUDTc45iaQNsHXjyH9XxIxDihdqEkAdyoHiNtgLuaozwCYH8AuVnX7RGk
         5laGh/cd+iNuupX91IdBJr6HgjYw8gMwGVGfmgq69FGJqlPJG0Hr367IjC1zodUFPFzZ
         eq6hw2no2zYHosEeePL6oI2CSQA/7mYt5PKwuDMJauyn1Xf0KMkHkDjOgwtZSh+OKR1T
         ovnPR98hifHx3oNvLan+yahOTzJv7Iu5kH1mFQbPD4QAHLYhLO0ihVnkQAsfKnsyvq+l
         AhSA==
X-Gm-Message-State: AOJu0YyfHfOaNXQzPgklAS/tCmr4Xok8lb4rnwLm861ijAwfpTCq+Xj7
	ba1rdqTpcI7IyF/keMRIoCYaex9QiT6vpOPBzXqz5r3OAnrF1kjpfrVQMBohkA==
X-Gm-Gg: ASbGnct+j7vWc8U6ufuT+e4tJqdSPHHFF19yscusPVbmHOBGQdfKy9t8o+6vHN5vYGZ
	+qIdoSrp+g/pq0gd9n+5J33VZCCAF6saRjTAuOrepTu07l0ZL3DaOJX2H+cuLbqMYckGjaH6pHw
	WdKvIzsYABhGZFeti7dwJAftFgEW7wkfExqoU2A1GzGJ/EDWqxpfnGvmgm80+tbwonuvTYKPL7q
	LgEwVwG6hPBlFRL9uxbfrsCyEyfFYs5I9K0YLiYr7A793MLUNe66SpTFr7qhU3mbsOhf8ly06MG
	kWItKFtRhegEBnq0PakGiBRC1E1JiYbYFUNnoiIIuVTFv0misIXSqvQOwCSSg5UdMKrXmKkWk5b
	yLGBxDkZM2uBSTZwodANfpUaozh897Rtug9oWpIiQBXv37K02Rteo3Ldv7LAfN+FUWLnNRlXA+9
	u9MQ3GUdPd
X-Google-Smtp-Source: AGHT+IEdvtW4tS0nJuZheqq9rfqyiIwQWwnjoagPVxZcFaUzXNZ5ZgjscXLilJryhFmD+nsZoZH9WQ==
X-Received: by 2002:a05:6870:e309:b0:32d:ecb:51d with SMTP id 586e51a60fabf-3c0f590e90emr14807854fac.16.1760562744129;
        Wed, 15 Oct 2025 14:12:24 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8eecb2bsm5806932fac.20.2025.10.15.14.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:12:23 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 6/6] builtin/repo: add progress meter for structure stats
Date: Wed, 15 Oct 2025 16:12:13 -0500
Message-ID: <20251015211213.361797-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20251015211213.361797-1-jltobler@gmail.com>
References: <20250927145049.723341-1-jltobler@gmail.com>
 <20251015211213.361797-1-jltobler@gmail.com>
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
 builtin/repo.c            | 49 +++++++++++++++++++++++++++++++++------
 t/t1901-repo-structure.sh | 20 ++++++++++++++++
 2 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 6bf93b6da8..763da436ad 100644
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
@@ -355,8 +356,16 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 }
 
 static void structure_count_references(struct ref_stats *stats,
-				       struct ref_array *refs)
+				       struct ref_array *refs,
+				       struct repository *repo,
+				       int show_progress)
 {
+	struct progress *progress = NULL;
+
+	if (show_progress)
+		progress = start_delayed_progress(repo, _("Counting references"),
+						  refs->nr);
+
 	for (int i = 0; i < refs->nr; i++) {
 		struct ref_array_item *ref = refs->items[i];
 
@@ -376,13 +385,24 @@ static void structure_count_references(struct ref_stats *stats,
 		default:
 			BUG("unexpected reference type");
 		}
+
+		display_progress(progress, i + 1);
 	}
+
+	stop_progress(&progress);
 }
 
+struct count_objects_data {
+	struct object_stats *stats;
+	struct progress *progress;
+};
+
 static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			 enum object_type type, void *cb_data)
 {
-	struct object_stats *stats = cb_data;
+	struct count_objects_data *data = cb_data;
+	struct object_stats *stats = data->stats;
+	size_t object_count;
 
 	switch (type) {
 	case OBJ_TAG:
@@ -401,18 +421,24 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 		BUG("invalid object type");
 	}
 
+	object_count = get_total_object_count(stats);
+	display_progress(data->progress, object_count);
+
 	return 0;
 }
 
 static void structure_count_objects(struct object_stats *stats,
-				    struct ref_array *refs,
-				    struct rev_info *revs)
+				    struct ref_array *refs, struct rev_info *revs,
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
 
 	for (int i = 0; i < refs->nr; i++) {
 		struct ref_array_item *ref = refs->items[i];
@@ -429,8 +455,12 @@ static void structure_count_objects(struct object_stats *stats,
 		}
 	}
 
+	if (show_progress)
+		data.progress = start_delayed_progress(repo, _("Counting objects"), 0);
+
 	walk_objects_by_path(&info);
 	path_walk_info_clear(&info);
+	stop_progress(&data.progress);
 }
 
 static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
@@ -444,10 +474,12 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	struct repo_structure stats = { 0 };
 	struct ref_array refs = { 0 };
 	struct rev_info revs;
+	int show_progress = -1;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
 			       PARSE_OPT_NONEG, parse_format_cb),
+		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 		OPT_END()
 	};
 
@@ -459,8 +491,11 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
 		die(_("unable to filter refs"));
 
-	structure_count_references(&stats.refs, &refs);
-	structure_count_objects(&stats.objects, &refs, &revs);
+	if (show_progress < 0)
+		show_progress = isatty(2);
+
+	structure_count_references(&stats.refs, &refs, repo, show_progress);
+	structure_count_objects(&stats.objects, &refs, &revs, repo, show_progress);
 
 	switch (format) {
 	case FORMAT_TABLE:
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 14bd8aede5..5f513feadb 100755
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
+		test_grep "Counting references: 100% (2/2), done." err &&
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

