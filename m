Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC646C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD12420730
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5KnInSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgBEW4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:56:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36098 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbgBEW4h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:56:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so4814212wma.1
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 14:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sQSNmiCGyIX95dlpjpWFXqC5wEIPaYSlbzJEC+A8DBo=;
        b=j5KnInSCgwYcS2v9M36Zn8r7h+F7Qvf8JzqEiWKV3JE3hlFJJpK/LxlRSnKp5KVYQU
         0R+hsNa62CJfAVxd/kZVPMzX0SAepsZcau1KJLfdOzfHas4yH1hOLKTQyiS0pfw4cXk3
         80BJg4TwtvosCi51Agp66kDn0Xhza/uW+vjMa92fImmz9hHMX4d0c3O1f+mDTMyj9ULW
         x8KUCsGwYyYm8EHsfLwoE9qPTxBdAzjqYyufvW88a8uttgx4a+VTIjI1tUEmwRYDl1YT
         fHemWeS2xt0MT07+jZ04bJ4m50OelyEJYLEWIzoioYPRTHWd3y9Dt1BZniDmwi3yarTO
         OrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sQSNmiCGyIX95dlpjpWFXqC5wEIPaYSlbzJEC+A8DBo=;
        b=Nv1xA0r1U0obSyvYWHhh+v3nfHnkpJs2u+qv6xn/ecaDbyJ0m6CLD3znHrtGmWni0P
         4SdGZUeWWjCruEFZGMMo+l6MCB+Xj7w791GBV8zLdcrYjOWphNT38igE+1rIImXTpZDC
         Mx9NsTmoK3WILITANq0a4g1FH1mQVZtutgnUswXMM73IMrHyGH4y1JOgo1qFSuqCjFa0
         f4VKldYARnLOqgKVt4rDJMBK52sgp/kC7gYYWF7pBVZvrZFMwYxZfnPCYNbHyYue2lkR
         YQMu4ofRSpS5fUqMqkKadwhMm5uscZS7EsXV+n//eZYxq0seZ9CLFRofQj0YTNiRnsN7
         fFzg==
X-Gm-Message-State: APjAAAWZUW19htxUxp1I3/wa5CoZ0vr3MuEmqh7BsziGOMrdFjf0Q5RR
        hAGpChwhB8LomVqT5DaMWkAfrd3e
X-Google-Smtp-Source: APXvYqxuXkOHZvnHyq7CSIkgY0viXoAIeXnaInL0BJRpHAQGDbiwT/+ag5HFqHAEQ50HXrQecZGcWg==
X-Received: by 2002:a1c:5441:: with SMTP id p1mr8628929wmi.161.1580943395291;
        Wed, 05 Feb 2020 14:56:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d23sm1729948wra.30.2020.02.05.14.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:56:34 -0800 (PST)
Message-Id: <78e8e49c3a1131ffacf660603de60729b3dbadc9.1580943390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
From:   "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Feb 2020 22:56:24 +0000
Subject: [PATCH v2 05/11] commit-graph: examine changed-path objects in pack
 order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        garimasigit@gmail.com, jnareb@gmail.com,
        christian.couder@gmail.com, emilyshaffer@gmail.com,
        gitster@pobox.com, Garima Singh <garima.singh@microsoft.com>,
        Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Looking at the diff of commit objects in pack order is much faster than
in sha1 order, as it gives locality to the access of tree deltas
(whereas sha1 order is effectively random). Unfortunately the
commit-graph code sorts the commits (several times, sometimes as an oid
and sometimes a pointer-to-commit), and we ultimately traverse in sha1
order.

Instead, let's remember the position at which we see each commit, and
traverse in that order when looking at bloom filters. This drops my time
for "git commit-graph write --changed-paths" in linux.git from ~4
minutes to ~1.5 minutes.

Probably the "--reachable" code path would want something similar.

Or alternatively, we could use a different data structure (either a
hash, or maybe even just a bit in "struct commit") to keep track of
which oids we've seen, etc instead of sorting. And then we could keep
the original order.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 commit-graph.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 724bfcffc4..e125511a1c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -17,6 +17,7 @@
 #include "replace-object.h"
 #include "progress.h"
 #include "bloom.h"
+#include "commit-slab.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -46,6 +47,29 @@
 /* Remember to update object flag allocation in object.h */
 #define REACHABLE       (1u<<15)
 
+/* Keep track of the order in which commits are added to our list. */
+define_commit_slab(commit_pos, int);
+static struct commit_pos commit_pos = COMMIT_SLAB_INIT(1, commit_pos);
+
+static void set_commit_pos(struct repository *r, const struct object_id *oid)
+{
+	static int32_t max_pos;
+	struct commit *commit = lookup_commit(r, oid);
+
+	if (!commit)
+		return; /* should never happen, but be lenient */
+
+	*commit_pos_at(&commit_pos, commit) = max_pos++;
+}
+
+static int commit_pos_cmp(const void *va, const void *vb)
+{
+	const struct commit *a = *(const struct commit **)va;
+	const struct commit *b = *(const struct commit **)vb;
+	return commit_pos_at(&commit_pos, a) -
+	       commit_pos_at(&commit_pos, b);
+}
+
 char *get_commit_graph_filename(const char *obj_dir)
 {
 	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
@@ -1027,6 +1051,8 @@ static int add_packed_commits(const struct object_id *oid,
 	oidcpy(&(ctx->oids.list[ctx->oids.nr]), oid);
 	ctx->oids.nr++;
 
+	set_commit_pos(ctx->r, oid);
+
 	return 0;
 }
 
@@ -1147,6 +1173,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct progress *progress = NULL;
+	struct commit **sorted_by_pos;
 
 	load_bloom_filters();
 
@@ -1155,13 +1182,18 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			_("Computing commit diff Bloom filters"),
 			ctx->commits.nr);
 
+	ALLOC_ARRAY(sorted_by_pos, ctx->commits.nr);
+	COPY_ARRAY(sorted_by_pos, ctx->commits.list, ctx->commits.nr);
+	QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);
+
 	for (i = 0; i < ctx->commits.nr; i++) {
-		struct commit *c = ctx->commits.list[i];
+		struct commit *c = sorted_by_pos[i];
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
 		ctx->total_bloom_filter_data_size += sizeof(uint64_t) * filter->len;
 		display_progress(progress, i + 1);
 	}
 
+	free(sorted_by_pos);
 	stop_progress(&progress);
 }
 
-- 
gitgitgadget

