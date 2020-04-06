Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6248EC2BB54
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EA8224F9
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2CGzb64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgDFRAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:00:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42306 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbgDFRAG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:00:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id cw6so346008edb.9
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lKRmXl/SCDI8E+Ga3COYKCQR4IKS00g3pKKk/jGMaB4=;
        b=u2CGzb64qEPOgS75JqIJowWLwPr7cp0uUE0B2q3GHmjRgMdVec7E0dlU3xPMpkqh9h
         4duRIoY3PPFijbpTritfDyG4sSPwO16Pfrq40jjQjwQH6DwcL0bNJ3vtp7yKu505q2lB
         eo0JdAgUDq+wnrbJ6oevG7uI6qt15q4kYJWlig7OVBGM3hIfVgJjdlTCAO04SICOUf0n
         kzKVqZ1JsF0brujnqiJx0K+PRZuIyqJzIuYqSzwVLUFFmneFydE10g31alh8pWckT26J
         brSxrwlX/E7eABHhHOBkfnxHZU76k/USLC7LAih2BQ9eJtOF76fBI8d9y2JyINazuG/w
         vruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lKRmXl/SCDI8E+Ga3COYKCQR4IKS00g3pKKk/jGMaB4=;
        b=bbf5T6b+wxnZbodrtrmLf8nWUf+Tc7L145T5EoIKvaZjboxLyND7TRJzGbp1GdwBc6
         Tz/oBnSh1GOYBfx8pWtS+fpmMVr+O6czlqiP41VLPuuMxFN+t9tHwUlaIpW9xDa8NOc3
         u8lhRXfXg+HxTR6h7atnCkiLJMAR1PAr3JNF7qmohKdsUZDyKtfp5iN6MWE6iZx86svK
         LaBp7a6ua5V21jgOO8BS94CbNrqs44YRX+TEHoDRDFDCbw4kIBG6Pt0hDUTKkxD4ChY4
         CQkFB2WrU6P7HBKY1Czzb5t5F23/q0iW0NVitIz1w2KII6a1NpceTAo8KUmtkcYUZ2sG
         wi6Q==
X-Gm-Message-State: AGi0PubFNgSVNy1UohteFdQkAtuYN+vAFrvjFSrtyntS7pa1PmMnLg6f
        4UZSy4NL/HRK4kBnoRKq89xPp/w9
X-Google-Smtp-Source: APiQypKGtUGO9jRLMALnVqGDh+2Q6Y6AsM861Y78pc/2MCoFDmC+h84GTzKKXXgtf0u+FBX4gCM00A==
X-Received: by 2002:a50:c341:: with SMTP id q1mr20797761edb.247.1586192402982;
        Mon, 06 Apr 2020 10:00:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b11sm2461524edj.20.2020.04.06.10.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 10:00:02 -0700 (PDT)
Message-Id: <5ed16f35fed43018ce441adfff55b85967d3918c.1586192395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
        <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Apr 2020 16:59:48 +0000
Subject: [PATCH v4 08/15] commit-graph: examine commits by generation number
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

When running 'git commit-graph write --changed-paths', we sort the
commits by pack-order to save time when computing the changed-paths
bloom filters. This does not help when finding the commits via the
'--reachable' flag.

If not using pack-order, then sort by generation number before
examining the diff. Commits with similar generation are more likely
to have many trees in common, making the diff faster.

On the Linux kernel repository, this change reduced the computation
time for 'git commit-graph write --reachable --changed-paths' from
3m00s to 1m37s.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 commit-graph.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 31b06f878ce..732c81fa1b2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -70,6 +70,25 @@ static int commit_pos_cmp(const void *va, const void *vb)
 	       commit_pos_at(&commit_pos, b);
 }
 
+static int commit_gen_cmp(const void *va, const void *vb)
+{
+	const struct commit *a = *(const struct commit **)va;
+	const struct commit *b = *(const struct commit **)vb;
+
+	/* lower generation commits first */
+	if (a->generation < b->generation)
+		return -1;
+	else if (a->generation > b->generation)
+		return 1;
+
+	/* use date as a heuristic when generations are equal */
+	if (a->date < b->date)
+		return -1;
+	else if (a->date > b->date)
+		return 1;
+	return 0;
+}
+
 char *get_commit_graph_filename(struct object_directory *obj_dir)
 {
 	return xstrfmt("%s/info/commit-graph", obj_dir->path);
@@ -815,7 +834,8 @@ struct write_commit_graph_context {
 		 report_progress:1,
 		 split:1,
 		 check_oids:1,
-		 changed_paths:1;
+		 changed_paths:1,
+		 order_by_pack:1;
 
 	const struct split_commit_graph_opts *split_opts;
 	size_t total_bloom_filter_data_size;
@@ -1178,7 +1198,11 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 
 	ALLOC_ARRAY(sorted_commits, ctx->commits.nr);
 	COPY_ARRAY(sorted_commits, ctx->commits.list, ctx->commits.nr);
-	QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);
+
+	if (ctx->order_by_pack)
+		QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);
+	else
+		QSORT(sorted_commits, ctx->commits.nr, commit_gen_cmp);
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = sorted_commits[i];
@@ -1884,6 +1908,7 @@ int write_commit_graph(struct object_directory *odb,
 	}
 
 	if (pack_indexes) {
+		ctx->order_by_pack = 1;
 		if ((res = fill_oids_from_packs(ctx, pack_indexes)))
 			goto cleanup;
 	}
@@ -1893,8 +1918,10 @@ int write_commit_graph(struct object_directory *odb,
 			goto cleanup;
 	}
 
-	if (!pack_indexes && !commit_hex)
+	if (!pack_indexes && !commit_hex) {
+		ctx->order_by_pack = 1;
 		fill_oids_from_all_packs(ctx);
+	}
 
 	close_reachable(ctx);
 
-- 
gitgitgadget

