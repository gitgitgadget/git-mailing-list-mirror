Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9352F0666
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842984; cv=none; b=fNQ6lZqPNegHJHPvjNox83sxlvNa/dU5NbZJCc6hB1KUGTa2t7ZgbNt8SXnLk9NzHzM96vcbGQOvSzGEgYd//0x2+w8WTHZ1tbL6BBbjy/TvzTXj6pUOJYuqI0lBtD0kX86eWADXnDEOJu84NQAEQgPk+0Cb8rsiM0WYGzAeSnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842984; c=relaxed/simple;
	bh=NHvxwZcxW2mp76nhWshppbQbDaTjhEIuLYDGLbzJc5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMAZBhY0rZfLFeZT5ihmTTNuCBOV9uZi23Y6OdGM41oS3t9v1AY85118yLear3yL0iNKEdyfg2DYiKDV0+06qW6+rd7jT2d0HOfB1b2SeOdJEDA2cncBaTYy/ogfjuPNiR0V+WHmj38xtKrnisvUQuJQERpaFkWB6bR8eyj1GMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goX9W4/2; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goX9W4/2"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7a79efc43e5so519826a34.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 16:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758842982; x=1759447782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCXsc8Zn3wJ6DdUmbr3B3OPBwnmffDcEuY4cyubl2wQ=;
        b=goX9W4/2No1o6+8bFZshRzoYe7GZmrwa1fKFB3RlQADjRF5YvOFLKltzzjv9BVZxZ6
         qPy2Fxu27SARJtA4wABeSID3IDiJ2tP2rJSM/coySQ0rHHRyd1SbRcP7uvqXYDEbvhy4
         qW3well0eI/plhBHJpm++eEvtzyguIu4vncBfL9CuXyILEZjZzjidtnjfBzh5OfcOkQk
         f+bLIX51JFkd+XKVh3k0HdeVUr67CckHptL9cqO7/KPwrFszAuSbfP1M/J8A22g4YKKn
         quVLhbhVBqKE70CLAmbKn6vPQRGPfiiP6e3n9dTVAkcQh2YJboRLToQFexMLQtbW9lkM
         YsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758842982; x=1759447782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCXsc8Zn3wJ6DdUmbr3B3OPBwnmffDcEuY4cyubl2wQ=;
        b=uVVFgi1WjbXH+Sxb3Qkz1LRE8H/IhaFVss2Q2P/Azzc+43FPGQvub20WMk3+ox7pCA
         DtnVw78n0FB2j617dgwnnvESPQIyqisg+CXBK7M8H1ZNMOyxiA65vsIeCupv5hUf+Z8I
         8UYzUGOQ8TgL0nRBXYBGfiZp4+D1EPxbsSio9ZxQ8saeorbdnGI1kn9zOV1oWkUJ2Czh
         0SxRL2f8QlE8c7vBeUm+YFzvjF+fHkGBaXKoZYLwVWOIQ3HsfihHxVdH+HuzD1bpCUwD
         Ctw7znMqnxjo+Hak85dldP/0TH57CkM3cjF77cS939J2HNYD2Rws/IbrGo1cnr0UDOnj
         W3+g==
X-Gm-Message-State: AOJu0Yy8auOFm9htxH3Rs5HPBmMpNZALXNrideAhcCoTFpcdaT/XD1Vr
	bVSt5p7twqzCIOEzPoZ6qRgKpYwX8HaL0tdFJK93+6QvefJGNs+sbe4k8kh7oA==
X-Gm-Gg: ASbGncv4WbhNswVnNdDoU73lH8DbOJJ6B4R0weKuQ3sE9LZggWXMYIaDTAxegWzeYiw
	BEvGH+wCIeGAnuiqlHSMzIfx+c1fVBnwt0pJzWqhNzcdasiyf3ha45OpF3MIt9XWIjWSNsHIxLj
	YXS9nWbKBFdty+/xb4C99b1E1polCM59SclSWu3NPs7Z8g/D1jOr2AxdaaMkqFFT3lBGpXabAWI
	FzFB7EGxmRr5jBTEzXvJoy2u8bhzIz0S5m/zw8rqo1scGbWrlkIF0moOxt8jWX2+xNrLuO57N8v
	Lj8MWCpQ/PC2bKpDBMP8hmsjGj/tURq2TjXAncrBGcN6x2g6vD7D66MqXLiGqCq47puOGtj2c+g
	5SHeIgj0UM3Lk7bhq5pbn1Hw5XUI+swg=
X-Google-Smtp-Source: AGHT+IH4LVv3hUrbrpxpGPZ0hdgQjPcmMxbWdDetXA+b0LvI/ykERuyKWex5KcInzLw95zUFHX+K4w==
X-Received: by 2002:a05:6830:6b0d:b0:79e:9e7:55fe with SMTP id 46e09a7af769-7a04b05e2f3mr482617a34.26.1758842981620;
        Thu, 25 Sep 2025 16:29:41 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7a2402e5d70sm674273a34.36.2025.09.25.16.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:29:41 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 7/7] builtin/repo: add progress meter for stats
Date: Thu, 25 Sep 2025 18:29:28 -0500
Message-ID: <20250925232928.3846-8-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250925232928.3846-1-jltobler@gmail.com>
References: <20250924212426.2930029-1-jltobler@gmail.com>
 <20250925232928.3846-1-jltobler@gmail.com>
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
index e8a02c950b..e553d7aa28 100644
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
@@ -358,8 +359,15 @@ static void stats_keyvalue_print(struct repo_stats *stats, char key_delim,
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
 
@@ -379,13 +387,24 @@ static void stats_count_references(struct ref_stats *stats, struct ref_array *re
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
@@ -404,17 +423,24 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
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
@@ -431,8 +457,12 @@ static void stats_count_objects(struct object_stats *stats,
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
@@ -446,10 +476,12 @@ static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
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
 
@@ -461,8 +493,11 @@ static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
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

