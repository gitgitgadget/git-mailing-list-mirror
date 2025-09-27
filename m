Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4202E8B67
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758984664; cv=none; b=j11c6Amknm98U3f0XeavdmN3aT/DUePM5Aa+sleRr1cIwdpdMdaK3K8s2KzDnIG0Dk9D+aPaALCQhpjBUjzLzm/e1kgWm3XeGfHSfx6KSlmRGhh0cWkSYjOlUdYpydOWema8eXqQ8QJTssWJsjbNJEUeVAWbqCJLLcqPoJsOW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758984664; c=relaxed/simple;
	bh=aTVFqWSDM8Zlv8dOrqy6045qEcjTwc8669rfMaQBf9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mloPlW3SUyDGsITGpT6tNEUGoUH/aHE69RnfeplR3fAqW9oaeZlQqrldqXtkWwNKXpzSHigcYtc9OweQVwfU8uH3BVqe29OnXHwdPmsge93ihsCaSHWn+UGZcEOTYAOnE428IhxO5nlBLIz2ftkj8ytjltjh6dNz5miscrEZRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9ggk9bK; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9ggk9bK"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6218fc7c6b7so894196eaf.1
        for <git@vger.kernel.org>; Sat, 27 Sep 2025 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758984662; x=1759589462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNRHT6DSYM3V3PM8NVOfDog2iPcACmhzKA2eEFpTeNw=;
        b=a9ggk9bK1vFLaq8MN/bvvC0ZRyaHn5SHQbr2obNheWdSeWkjJOk0CuXrQfpvi/BF9k
         L0nyBGGnZpoy5EgYcfRzHR/sdEj1abM2g5DsQSD9Bvoc8MKTx4fwHXM8NSICd8eSdt+z
         Gm6N5d2g+J3yC1jImtJe0NoUtXFLgtm7rOA26jlhFte+PLYO1RnJUlWq+CAkRREV8gNp
         i1q55upsd43snu5yP/yidp2aS0JlelIveFiPxYCXznxy7R0jgHtDcSR5wDprw+WZSTkJ
         YcnfkJdJrTZWDH4VjY/nVnrmTIH1Gg2gWTAwpMUb+9e6LR/ly38NOV8MkDXaWVTUC+1a
         aI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758984662; x=1759589462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNRHT6DSYM3V3PM8NVOfDog2iPcACmhzKA2eEFpTeNw=;
        b=DpVTXsL102FEVGaI1PLrFbTFC53UaDmjekum3GBtRkW0bn9tjzL67rkI5SibtfpnlK
         ppCcPIjK1JsT89lo3JB57FOyzoaf3CmiCkTiRkH/HXQXiu2AVm7ky/63+/0pHz1rsYuc
         7HOlArTIs/CUADs2wdiEDiV/fZcM8zb7cH+5Vtr/S3ZBR6XUbDGv9HRzQM6dlzaT7l0d
         odl4L65MSJBGEgll7HdoRWvyx3jRo+68L2AAXV6A4ZxVrAaWrzj+Mniav3tC8zTaBIqk
         IMnt57sbfeJLooCsuZy9XRtbzrQL/SHjy1KGWHCyZ6NMBHF+B1fSSWdn0A7+K1VE8vpu
         y4YA==
X-Gm-Message-State: AOJu0Yz/LNCylBr3+v+avxhLTP/fkBtwXSNjBmV+yi0DsSJOLN80XdtG
	qHLU47RegTLPlAG4G4yCk7rK14tUEEpocwNXFz4DbHRQpYmYRUJsH6tCDtCvPw==
X-Gm-Gg: ASbGncskG/4/IoKa/elWyldzFckPjw3b6DA2HLm6ShHgknvGn42lVYhVLDVu+68UJpO
	kzaKKiMRoXciUDJ7vx+PpphSKs2KxVMrJqv/hFyaChSrZ1sL92H4NLRhNy8lCLwKWcE/EtaC+25
	vcYV3XnVlOrJxjwHxOL7uccxcNtzAzHB9wSUdUlDopEjlO0qotoFLiVmcc0/pozDr1ySLED0WC1
	TCedXBM0eCmDjQZi+DYhTKyRb8xVbwhCvvCAsbzGgxLeN7w/1zKH5N3b3TUiGlSm5va0sygBbpi
	lWtemTuPUZFJ3CaGK91P+EkPtDyDQH0uPfDmTiUw0on4OXSETPu23qdRLNa9RhGPr9yQWGqvgZ3
	ePMsyrQ7kX+H/IyYK9lqPP3S6pzGhqrA=
X-Google-Smtp-Source: AGHT+IHBD8Pp/L9qefZzaJK8tuJex3kMy9i0BPh2BLtsXtIVa6aVOBf5Sx3BeKJeymBENYf3tfFesQ==
X-Received: by 2002:a05:6808:2112:b0:439:1c13:4585 with SMTP id 5614622812f47-43f4cddb4cdmr5667409b6e.20.1758984662069;
        Sat, 27 Sep 2025 07:51:02 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f51258cf1sm1345401b6e.29.2025.09.27.07.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 07:51:01 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 7/7] builtin/repo: add progress meter for stats
Date: Sat, 27 Sep 2025 09:50:49 -0500
Message-ID: <20250927145049.723341-8-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250927145049.723341-1-jltobler@gmail.com>
References: <20250925232928.3846-1-jltobler@gmail.com>
 <20250927145049.723341-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using the stats subcommand for git-repo(1), evaluating a repository
may take some time depending on its shape. Add a progress meter to
provide feedback to the user about what is happening. The progress meter
is enabled by default when the command is executed from a tty. It can
also be explicitly enabled/disabled via the --[no-]progress option.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c        | 47 +++++++++++++++++++++++++++++++++++++------
 t/t1901-repo-stats.sh | 20 ++++++++++++++++++
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 6f41c9ada2..c5fe9901ec 100644
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
@@ -360,8 +361,15 @@ static void stats_keyvalue_print(struct repo_stats *stats, char key_delim,
 	fflush(stdout);
 }
 
-static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
+static void stats_count_references(struct ref_stats *stats, struct ref_array *refs,
+				   struct repository *repo, int show_progress)
 {
+	struct progress *progress = NULL;
+
+	if (show_progress)
+		progress = start_delayed_progress(repo, _("Counting references"),
+						  refs->nr);
+
 	for (int i = 0; i < refs->nr; i++) {
 		struct ref_array_item *ref = refs->items[i];
 
@@ -381,13 +389,24 @@ static void stats_count_references(struct ref_stats *stats, struct ref_array *re
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
@@ -406,17 +425,24 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 		BUG("invalid object type");
 	}
 
+	object_count = get_total_object_count(stats);
+	display_progress(data->progress, object_count);
+
 	return 0;
 }
 
 static void stats_count_objects(struct object_stats *stats,
-				struct ref_array *refs, struct rev_info *revs)
+				struct ref_array *refs, struct rev_info *revs,
+				struct repository *repo, int show_progress)
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
@@ -433,8 +459,12 @@ static void stats_count_objects(struct object_stats *stats,
 		}
 	}
 
+	if (show_progress)
+		data.progress = start_delayed_progress(repo, _("Counting objects"), 0);
+
 	walk_objects_by_path(&info);
 	path_walk_info_clear(&info);
+	stop_progress(&data.progress);
 }
 
 static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
@@ -448,10 +478,12 @@ static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
 	struct repo_stats stats = { 0 };
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
 
@@ -463,8 +495,11 @@ static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
 	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
 		die(_("unable to filter refs"));
 
-	stats_count_references(&stats.refs, &refs);
-	stats_count_objects(&stats.objects, &refs, &revs);
+	if (show_progress < 0)
+		show_progress = isatty(2);
+
+	stats_count_references(&stats.refs, &refs, repo, show_progress);
+	stats_count_objects(&stats.objects, &refs, &revs, repo, show_progress);
 
 	switch (format) {
 	case FORMAT_TABLE:
diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
index 2409edae4f..03d6db479f 100755
--- a/t/t1901-repo-stats.sh
+++ b/t/t1901-repo-stats.sh
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
+		GIT_PROGRESS_DELAY=0 git repo stats --progress >out 2>err &&
+
+		test_file_not_empty out &&
+		test_grep "Counting references: 100% (2/2), done." err &&
+		test_grep "Counting objects: 3, done." err &&
+
+		GIT_PROGRESS_DELAY=0 git repo stats --no-progress >out 2>err &&
+
+		test_file_not_empty out &&
+		test_line_count = 0 err
+	)
+'
+
 test_done
-- 
2.51.0.193.g4975ec3473b

