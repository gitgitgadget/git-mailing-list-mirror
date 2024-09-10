Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E517F4F7
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935358; cv=none; b=PEjoqEZBnZ+B2EGSRyFqzD0lyg55ip19yBY6LXZV1yo4Ew60C4d7JxQ+Qgwquh98sf+fOYxT9WeKCSZiEu/U3WJUGr2NUZC1uqsLFKcmLaUJnH6frHKyXPNHGq7smz22AwZZq8pGjuIKpIPIXVewT+hk9gKALpEipiAYP4YC1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935358; c=relaxed/simple;
	bh=rKvKw3coFFkk+x6m6KQn3G/JMWJJ3SgCHNrLO/laWcQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=T0E1haJgWQroq+gNAOKkxellPHZqoynQqblnrmrVcqDs7+YusMuYOCOH4gDY/dzQLU2IxWbTEpUq9tjJ0zq3yVXkqASgTqy3hTA0lOUHue2imTgRYdt6Gs327cNVdSIXi12o4yT71I6eoOdbbop5ctTXvOH3UGjxR+ijT64n/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTxra8DM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTxra8DM"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d64b27c45so175555166b.3
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935355; x=1726540155; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3DGRIZ4uknVZo5b3VkXakDV8jAIl0BZPL96PynTuv0=;
        b=GTxra8DMj+4y+L9prZfOv71ZpCT9PuVXvZASgmpimBN+2ljbGN9XaSCkeS62zHXzli
         FwkApgR6/4tJAKm0S2Kcfh/vGEt5wrKuPhW80YQiCPNTJLt7jucFJ64z/kgvSZwUmlag
         l5/QRgggLR9FQW7JXPgNG4mY78QZ+PHVB9Lvc55osm3noBUv48DFh3vNSZWuMcj8kvWW
         34TmwExqPajowTGZLn389FG+R0shhuK5zNSiYZdrEM13F8C3yyNJarhYPd8MScLD+xHO
         MUXuftO7oZ8lVWNLhAMgk5n4Psb4XcDA/wAUQN0FbfWwBeWu41tKHyxJPD3pvxvUHM7v
         uw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935355; x=1726540155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3DGRIZ4uknVZo5b3VkXakDV8jAIl0BZPL96PynTuv0=;
        b=M2e1PVQiT1g7DbFWm0rFR7r97UvxmsfqMw1mUoxGniJG4KAfZAnJ1svLpfQav7XAV5
         9dodPrH7Ia0P3HM1cp7A8/8fLyhLvDIdS+VOVOusWJeNJ12bp9uwaHS3BfKT9YoEU7Hp
         u+3viIHR6eCRNVCNCksVRO6WoROguxL+AjbMDMw/VNgLn3LMSZTrtyG2MYzBg7Ar8A5z
         CDXRJrTnsNSIRokERIUiFFjB5EaNsYoEF+AoLKATd3YbVsGlIAIvMyQzlaFeqpXO76B/
         5NjYBIcXRCY2bUPaUeSTBbUpy57xj9yyM7V+4qmHXSZAuBpinYD8HqYdI/Uxgyq84HFI
         KsrQ==
X-Gm-Message-State: AOJu0YzBRXqI5MKJf62+2i1HEhWS2UhVeuXfNn4FADOVEM/RwsdcAc/B
	5+aTBbUNovaYaj9wl0M+iiwCTzJ93T8CidAaAUMi23ltKHsMx2mCOVf4iA==
X-Google-Smtp-Source: AGHT+IEZ8NjXTGiK2DvC8B76hyuHSk3I2kWPcWoCkji/xn05eZh61iPeqstTJQDsrSWtth3BJu6BRA==
X-Received: by 2002:a17:907:934d:b0:a8a:6db5:7e42 with SMTP id a640c23a62f3a-a8a885c0057mr1135869166b.9.1725935355030;
        Mon, 09 Sep 2024 19:29:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25833955sm415520266b.32.2024.09.09.19.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:14 -0700 (PDT)
Message-Id: <9e95914d393ff83054ee419b58b9db4d3560a36c.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:42 +0000
Subject: [PATCH 17/30] survey: add report of "largest" paths
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Since we are already walking our reachable objects using the path-walk API,
let's now collect lists of the paths that contribute most to different
metrics. Specifically, we care about

 * Number of versions.
 * Total size on disk.
 * Total inflated size (no delta or zlib compression).

This information can be critical to discovering which parts of the
repository are causing the most growth, especially on-disk size. Different
packing strategies might help compress data more efficiently, but the toal
inflated size is a representation of the raw size of all snapshots of those
paths. Even when stored efficiently on disk, that size represents how much
information must be processed to complete a command such as 'git blame'.

Since the on-disk size is likely to be fragile, stop testing the exact
output of 'git survey' and check that the correct set of headers is
output.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/survey.c      | 90 +++++++++++++++++++++++++++++++++++++------
 t/t8100-git-survey.sh | 12 +++++-
 2 files changed, 90 insertions(+), 12 deletions(-)

diff --git a/builtin/survey.c b/builtin/survey.c
index ad467e9a88c..90b041967c8 100644
--- a/builtin/survey.c
+++ b/builtin/survey.c
@@ -80,7 +80,6 @@ struct survey_report_object_size_summary {
 typedef int (*survey_top_size_cmp)(struct survey_report_object_size_summary *s1,
 				   struct survey_report_object_size_summary *s2);
 
-MAYBE_UNUSED
 static int cmp_by_nr(struct survey_report_object_size_summary *s1,
 		     struct survey_report_object_size_summary *s2)
 {
@@ -91,7 +90,6 @@ static int cmp_by_nr(struct survey_report_object_size_summary *s1,
 	return 0;
 }
 
-MAYBE_UNUSED
 static int cmp_by_disk_size(struct survey_report_object_size_summary *s1,
 			    struct survey_report_object_size_summary *s2)
 {
@@ -102,7 +100,6 @@ static int cmp_by_disk_size(struct survey_report_object_size_summary *s1,
 	return 0;
 }
 
-MAYBE_UNUSED
 static int cmp_by_inflated_size(struct survey_report_object_size_summary *s1,
 				struct survey_report_object_size_summary *s2)
 {
@@ -126,7 +123,6 @@ struct survey_report_top_sizes {
 	size_t alloc;
 };
 
-MAYBE_UNUSED
 static void init_top_sizes(struct survey_report_top_sizes *top,
 			   size_t limit, const char *name,
 			   survey_top_size_cmp cmp)
@@ -146,7 +142,6 @@ static void clear_top_sizes(struct survey_report_top_sizes *top)
 	free(top->data);
 }
 
-MAYBE_UNUSED
 static void maybe_insert_into_top_size(struct survey_report_top_sizes *top,
 				       struct survey_report_object_size_summary *summary)
 {
@@ -182,6 +177,10 @@ struct survey_report {
 	struct survey_report_object_summary reachable_objects;
 
 	struct survey_report_object_size_summary *by_type;
+
+	struct survey_report_top_sizes *top_paths_by_count;
+	struct survey_report_top_sizes *top_paths_by_disk;
+	struct survey_report_top_sizes *top_paths_by_inflate;
 };
 
 #define REPORT_TYPE_COMMIT 0
@@ -423,6 +422,13 @@ static void survey_report_object_sizes(const char *title,
 	clear_table(&table);
 }
 
+static void survey_report_plaintext_sorted_size(
+		struct survey_report_top_sizes *top)
+{
+	survey_report_object_sizes(top->name,  _("Path"),
+				   top->data, top->nr);
+}
+
 static void survey_report_plaintext(struct survey_context *ctx)
 {
 	printf("GIT SURVEY for \"%s\"\n", ctx->repo->worktree);
@@ -433,6 +439,21 @@ static void survey_report_plaintext(struct survey_context *ctx)
 				   _("Object Type"),
 				   ctx->report.by_type,
 				   REPORT_TYPE_COUNT);
+
+	survey_report_plaintext_sorted_size(
+		&ctx->report.top_paths_by_count[REPORT_TYPE_TREE]);
+	survey_report_plaintext_sorted_size(
+		&ctx->report.top_paths_by_count[REPORT_TYPE_BLOB]);
+
+	survey_report_plaintext_sorted_size(
+		&ctx->report.top_paths_by_disk[REPORT_TYPE_TREE]);
+	survey_report_plaintext_sorted_size(
+		&ctx->report.top_paths_by_disk[REPORT_TYPE_BLOB]);
+
+	survey_report_plaintext_sorted_size(
+		&ctx->report.top_paths_by_inflate[REPORT_TYPE_TREE]);
+	survey_report_plaintext_sorted_size(
+		&ctx->report.top_paths_by_inflate[REPORT_TYPE_BLOB]);
 }
 
 static void survey_report_json(struct survey_context *ctx)
@@ -673,7 +694,8 @@ static void increment_totals(struct survey_context *ctx,
 
 static void increment_object_totals(struct survey_context *ctx,
 				    struct oid_array *oids,
-				    enum object_type type)
+				    enum object_type type,
+				    const char *path)
 {
 	struct survey_report_object_size_summary *total;
 	struct survey_report_object_size_summary summary = { 0 };
@@ -701,6 +723,27 @@ static void increment_object_totals(struct survey_context *ctx,
 	total->disk_size += summary.disk_size;
 	total->inflated_size += summary.inflated_size;
 	total->num_missing += summary.num_missing;
+
+	if (type == OBJ_TREE || type == OBJ_BLOB) {
+		int index = type == OBJ_TREE ?
+			    REPORT_TYPE_TREE : REPORT_TYPE_BLOB;
+		struct survey_report_top_sizes *top;
+
+		/*
+		 * Temporarily store (const char *) here, but it will
+		 * be duped if inserted and will not be freed.
+		 */
+		summary.label = (char *)path;
+
+		top = ctx->report.top_paths_by_count;
+		maybe_insert_into_top_size(&top[index], &summary);
+
+		top = ctx->report.top_paths_by_disk;
+		maybe_insert_into_top_size(&top[index], &summary);
+
+		top = ctx->report.top_paths_by_inflate;
+		maybe_insert_into_top_size(&top[index], &summary);
+	}
 }
 
 static int survey_objects_path_walk_fn(const char *path,
@@ -712,7 +755,7 @@ static int survey_objects_path_walk_fn(const char *path,
 
 	increment_object_counts(&ctx->report.reachable_objects,
 				type, oids->nr);
-	increment_object_totals(ctx, oids, type);
+	increment_object_totals(ctx, oids, type, path);
 
 	ctx->progress_nr += oids->nr;
 	display_progress(ctx->progress, ctx->progress_nr);
@@ -757,6 +800,34 @@ static int iterate_tag_chain(struct survey_context *ctx,
 	return -1;
 }
 
+static void initialize_report(struct survey_context *ctx)
+{
+	const int top_limit = 100;
+
+	CALLOC_ARRAY(ctx->report.by_type, REPORT_TYPE_COUNT);
+	ctx->report.by_type[REPORT_TYPE_COMMIT].label = xstrdup(_("Commits"));
+	ctx->report.by_type[REPORT_TYPE_TREE].label = xstrdup(_("Trees"));
+	ctx->report.by_type[REPORT_TYPE_BLOB].label = xstrdup(_("Blobs"));
+
+	CALLOC_ARRAY(ctx->report.top_paths_by_count, REPORT_TYPE_COUNT);
+	init_top_sizes(&ctx->report.top_paths_by_count[REPORT_TYPE_TREE],
+		       top_limit, _("TOP DIRECTORIES BY COUNT"), cmp_by_nr);
+	init_top_sizes(&ctx->report.top_paths_by_count[REPORT_TYPE_BLOB],
+		       top_limit, _("TOP FILES BY COUNT"), cmp_by_nr);
+
+	CALLOC_ARRAY(ctx->report.top_paths_by_disk, REPORT_TYPE_COUNT);
+	init_top_sizes(&ctx->report.top_paths_by_disk[REPORT_TYPE_TREE],
+		       top_limit, _("TOP DIRECTORIES BY DISK SIZE"), cmp_by_disk_size);
+	init_top_sizes(&ctx->report.top_paths_by_disk[REPORT_TYPE_BLOB],
+		       top_limit, _("TOP FILES BY DISK SIZE"), cmp_by_disk_size);
+
+	CALLOC_ARRAY(ctx->report.top_paths_by_inflate, REPORT_TYPE_COUNT);
+	init_top_sizes(&ctx->report.top_paths_by_inflate[REPORT_TYPE_TREE],
+		       top_limit, _("TOP DIRECTORIES BY INFLATED SIZE"), cmp_by_inflated_size);
+	init_top_sizes(&ctx->report.top_paths_by_inflate[REPORT_TYPE_BLOB],
+		       top_limit, _("TOP FILES BY INFLATED SIZE"), cmp_by_inflated_size);
+}
+
 static void survey_phase_objects(struct survey_context *ctx)
 {
 	struct rev_info revs = REV_INFO_INIT;
@@ -774,10 +845,7 @@ static void survey_phase_objects(struct survey_context *ctx)
 	info.blobs = 1;
 	info.tags = 1;
 
-	CALLOC_ARRAY(ctx->report.by_type, REPORT_TYPE_COUNT);
-	ctx->report.by_type[REPORT_TYPE_COMMIT].label = xstrdup(_("Commits"));
-	ctx->report.by_type[REPORT_TYPE_TREE].label = xstrdup(_("Trees"));
-	ctx->report.by_type[REPORT_TYPE_BLOB].label = xstrdup(_("Blobs"));
+	initialize_report(ctx);
 
 	repo_init_revisions(ctx->repo, &revs, "");
 
diff --git a/t/t8100-git-survey.sh b/t/t8100-git-survey.sh
index f8af9601214..c2dab0033f9 100755
--- a/t/t8100-git-survey.sh
+++ b/t/t8100-git-survey.sh
@@ -60,7 +60,17 @@ test_expect_success 'git survey (default)' '
 	      Blobs |    10 |       191 |           101
 	EOF
 
-	test_cmp expect out
+	lines=$(wc -l <expect) &&
+	head -n $lines out >out-trimmed &&
+	test_cmp expect out-trimmed &&
+
+	for type in "DIRECTORIES" "FILES"
+	do
+		for metric in "COUNT" "DISK SIZE" "INFLATED SIZE"
+		do
+			grep "TOP $type BY $metric" out || return 1
+		done || return 1
+	done
 '
 
 test_done
-- 
gitgitgadget

