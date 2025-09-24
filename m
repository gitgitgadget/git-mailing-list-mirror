Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E1288CA3
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749079; cv=none; b=IA/Kq2/aU9SfO36xMWajh2r7BNM/7et9xSbJMT84GjzolFpIeupoKZoFDedVPKiJcIII+m/eAEJXCaIZA8M+zVua5YlmZ5yJa64W3jLrfMo7DfJXd07+0vBhtPBXfEB2SrsevrPQj7SQ+xXKxyX7kDEW8JNoA7mqvRoH/nUNSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749079; c=relaxed/simple;
	bh=qb25BHUUlwzKKqE2J1bYkkh7nZJwXKaOLpqxncXiGnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAoDH87ON1GMBtHWbNZCnonlNCiEzCoPmTWIoslv2x22W4IXpzSd9T/GomGOLT+M2k/1+QgLwmgN0/kF1POlt2MFgMybbyIJvsP4oBXo/yq6f6UNlEsaO7YuI9x7DwFRQVgjnsiAy/eMxTkFA/ktWoKfKNc/zaswjw1AjxZw0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMoxqqL9; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMoxqqL9"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-79d36a6298dso121328a34.0
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758749076; x=1759353876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSE3jDquAhholQuGkd2iTspLEKR/4EMSgN5stoXdtrA=;
        b=WMoxqqL9ipaOLdXNN3tu2XI2QsM1dv3PcPdCm2dvJMfkKlBiVzA9CKLNjJIqGNh2Rw
         ckukT/kkhKpSbn7VqsCW0F0+G9vzV2kIwP9eEStVuyjxWzI7N2QXBd8YGgdPyEUaKyGk
         dmtsHcBi1cZO1eYxVIw50Bt2/+WJ39Uy26BvrUzL9nHjtz6mLo+0lvuB1oZ+PkcZZcaN
         Re72TxVBOnzSxb6nb0TSNLq7Y6J8AjFs5FGHSjaQUjEuIP6dZ6/e1IySHIvFw03JJ8tO
         ovtN5gfRkSwqOYtp+YD/jjRN4yCMjME6cD7Tensnz1esCXxzWhjo8Q1Zu1pnG8YjsOO0
         gk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758749076; x=1759353876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSE3jDquAhholQuGkd2iTspLEKR/4EMSgN5stoXdtrA=;
        b=XZ8MpTw7jtLz6EWBLV5aGJUIElXP8HE+TuOc5VV6FJRB1pERZ+4sUGvEGCUtOD9808
         3dUe9xC5zFbFO0OkyuzitlsY8d3ZUNAHYmT/3/OF0mcahxHg5W/WsPZeHGF7dXd7dD/f
         fJhWJxOetfqEHTRXoYV1rvVwaKSopFA4W/eqaqC/7RQzjvuSEhqvjvk4Dh2FG808cQi5
         /OBvPJ9YBpLzxTuZvB+I8N8TERf66a2Qt4VbXEt01KxmvwSWrUJfRgwfcWfnD9Se3AuK
         jrUDyze10MKEpos3PWD7j0lizYE8g5mGMXFl0b+FMd/NbinekF8DqbhXgD/HP3Sx9KjG
         /srQ==
X-Gm-Message-State: AOJu0YxXPz4rnbDQuMYv6JexbbMbIk+n7d/lSmAYHu7jRHWFGtPGdwHL
	YFeKwpV0j+QV9DQDgXXdYkAd/5DQpXQ+hJycnnrIXwtSbH8MXOfGWpbof+mc+Q==
X-Gm-Gg: ASbGncvc5RaayEXds8njXJE3SkPsbpsvGvSa+vYe3AiGIAj6LyHra9H3HsellYQyFuA
	GZYh0/ZzKWzdqlPfyWE8XPWw8ODxWSIusiScoYNsTK2BtbB19t+WH5GaMtVBctnj3yt6PyuXD4k
	3YHTi0iLmCbDdPBLF+EJku5VemmS4/vReHB3Tnv/W5HJqThAzfISgbtue6J+eC4q3sXEVXvNn9E
	O2ARYfyZvWOvaVSjLT4xCtJSjWqiJInrPmoAL1B9wcDqj7sR2n0Um110qjHSB5kK7prFtZW+Q81
	l1cpcdqzQAg1uU6pygXL6dT4ZJYCuzf2AZzWP/qFno/cHzVn4dOfUOZjc4soPSbrr4AsXbsb4kj
	sUFcmKwAVaXZMIBkKkABAfhKCqqRFrAfpljkoS9mqtw==
X-Google-Smtp-Source: AGHT+IHTwQ2wjAFi+ekhK1Wp1oyTmEf2zkaW5VYLVhidEQE3kVDFaUBH+02tmjLnmXKYO53wN1Tr6A==
X-Received: by 2002:a05:6808:11d1:b0:43d:24b0:a08d with SMTP id 5614622812f47-43f4cdcd30bmr574413b6e.25.1758749076317;
        Wed, 24 Sep 2025 14:24:36 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f46f5dbdcsm400117b6e.12.2025.09.24.14.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:24:35 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 6/6] builtin/repo: add progress meter for stats
Date: Wed, 24 Sep 2025 16:24:26 -0500
Message-ID: <20250924212426.2930029-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250924212426.2930029-1-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250924212426.2930029-1-jltobler@gmail.com>
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
 builtin/repo.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index fe7d43f78e..fdc8af92dc 100644
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
@@ -344,8 +345,14 @@ static void stats_keyvalue_print(struct repo_stats *stats, char key_delim,
 	strbuf_release(&buf);
 }
 
-static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
+static void stats_count_references(struct ref_stats *stats, struct ref_array *refs,
+				   struct repository *repo, int show_progress)
 {
+	struct progress *progress = NULL;
+
+	if (show_progress)
+		progress = start_progress(repo, _("Counting references"), refs->nr);
+
 	for (int i = 0; i < refs->nr; i++) {
 		struct ref_array_item *ref = refs->items[i];
 
@@ -365,13 +372,24 @@ static void stats_count_references(struct ref_stats *stats, struct ref_array *re
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
@@ -390,17 +408,24 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 		BUG("invalid object type");
 	}
 
+	object_count = stats->tags + stats->commits + stats->trees + stats->blobs;
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
@@ -417,8 +442,12 @@ static void stats_count_objects(struct object_stats *stats,
 		}
 	}
 
+	if (show_progress)
+		data.progress = start_progress(repo, _("Counting Objects"), 0);
+
 	walk_objects_by_path(&info);
 	path_walk_info_clear(&info);
+	stop_progress(&data.progress);
 }
 
 static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
@@ -432,10 +461,12 @@ static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
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
 
@@ -444,8 +475,11 @@ static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
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
-- 
2.51.0.193.g4975ec3473b

