Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE69C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A70C206DB
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMTqx+FJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgC3Abu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 20:31:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56133 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbgC3Abs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 20:31:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id r16so202019wmg.5
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 17:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b09N7vSxma0z7ZkQvyBSUo7VU222X1/gp1zj6yECZGU=;
        b=oMTqx+FJ8L/OD6Eb2IVCN1oIJwBMlWS79uNrLxa6doHvOPzcnu02xfqRNOoaFz+sdM
         Q1Tu5CrbtZKn+1F2B31KrqMf5n6jNA+13xp70oZxIq8vHA6lJdTqYMmeFt7EBkbOBAln
         t9By7kSbL3bCSNJdbVPrWsPTRHivKb77oTHw/0w+FXMxKWFwywZ9l9ymxNyId0AHfjML
         66WnjVhwe0lPBkbGsikPbJ4PXGcCsxmkTC26HrRpyYyIsTPvjF9teo9i8zCKcuxZUBQs
         4l67TAhwYfo8fOdlgwm0w1HE9sT5w76P5bDGIO+qOreX82JWL6fj+c/wzSpeiOVn7DEz
         7Mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b09N7vSxma0z7ZkQvyBSUo7VU222X1/gp1zj6yECZGU=;
        b=g5mBDctUxGmIvsXE6NRNOpgH/eCDGi43DLopLLRctf3WqZLxNwIKfMBW6HqdF8AxTe
         FTG5be2xTIyls5Tf56lKsUTVB1HyANlXFbQ8xg5o2CdgGBJePWleWHjPPk4ICCigM+dP
         cBG3XYl48b8MtLRr+LK8+lUdPNyAFGZpCUCuVJEtizd1G/oYPCo35QVPt8R8nPQGUv05
         cOtigDp3WwkiFO/85u/2Tz3nm5RBrPoiqjg5aMo2BgCDi5G/ywZAmv3TQ3RWiRl+Itxz
         64ceO9rtUmD0fnHxTWFHJ0KJ8th0LmqZ2v8cTOlq5kQfYZ/LHW/WNcetvYOfHz9uS4Ds
         QWrQ==
X-Gm-Message-State: ANhLgQ0fBWkXT/lhfJYN8D8izzI7kHmS/M6jUGxBFsdKlhX/H/WLusUP
        kjzF0b/6ZBDwZLce8f12iIph5rH9
X-Google-Smtp-Source: ADFU+vsT1dpx2G+OV7atAlHulZLG/QCQtuGS3eg9kez32ycboZ93ns2sf0rshCLHjoiaS7MxHuIs5g==
X-Received: by 2002:a1c:3241:: with SMTP id y62mr10999887wmy.66.1585528305235;
        Sun, 29 Mar 2020 17:31:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k83sm8633163wma.3.2020.03.29.17.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 17:31:44 -0700 (PDT)
Message-Id: <2d4c0b2da38632424c8bd31ccb2037e0676c3c74.1585528298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
References: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Mar 2020 00:31:27 +0000
Subject: [PATCH v3 05/16] diff: halt tree-diff early after max_changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When computing the changed-paths bloom filters for the commit-graph,
we limit the size of the filter by restricting the number of paths
in the diff. Instead of computing a large diff and then ignoring the
result, it is better to halt the diff computation early.

Create a new "max_changes" option in struct diff_options. If non-zero,
then halt the diff computation after discovering strictly more changed
paths. This includes paths corresponding to trees that change.

Use this max_changes option in the bloom filter calculations. This
reduces the time taken to compute the filters for the Linux kernel
repo from 2m50s to 2m35s. On a large internal repository with ~500
commits that perform tree-wide changes, the time reduced from
6m15s to 3m48s.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 bloom.c     | 4 +++-
 diff.h      | 5 +++++
 tree-diff.c | 6 ++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/bloom.c b/bloom.c
index 881a9841ede..a16eee92331 100644
--- a/bloom.c
+++ b/bloom.c
@@ -133,6 +133,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 	int i;
 	struct diff_options diffopt;
+	int max_changes = 512;
 
 	if (bloom_filters.slab_size == 0)
 		return NULL;
@@ -141,6 +142,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
+	diffopt.max_changes = max_changes;
 	diff_setup_done(&diffopt);
 
 	if (c->parents)
@@ -149,7 +151,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
 	diffcore_std(&diffopt);
 
-	if (diff_queued_diff.nr <= 512) {
+	if (diff_queued_diff.nr <= max_changes) {
 		struct hashmap pathmap;
 		struct pathmap_hash_entry *e;
 		struct hashmap_iter iter;
diff --git a/diff.h b/diff.h
index 6febe7e3656..9443dc1b003 100644
--- a/diff.h
+++ b/diff.h
@@ -285,6 +285,11 @@ struct diff_options {
 	/* Number of hexdigits to abbreviate raw format output to. */
 	int abbrev;
 
+	/* If non-zero, then stop computing after this many changes. */
+	int max_changes;
+	/* For internal use only. */
+	int num_changes;
+
 	int ita_invisible_in_index;
 /* white-space error highlighting */
 #define WSEH_NEW (1<<12)
diff --git a/tree-diff.c b/tree-diff.c
index 33ded7f8b3e..f3d303c6e54 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -434,6 +434,9 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		if (diff_can_quit_early(opt))
 			break;
 
+		if (opt->max_changes && opt->num_changes > opt->max_changes)
+			break;
+
 		if (opt->pathspec.nr) {
 			skip_uninteresting(&t, base, opt);
 			for (i = 0; i < nparent; i++)
@@ -518,6 +521,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 
 			/* t↓ */
 			update_tree_entry(&t);
+			opt->num_changes++;
 		}
 
 		/* t > p[imin] */
@@ -535,6 +539,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		skip_emit_tp:
 			/* ∀ pi=p[imin]  pi↓ */
 			update_tp_entries(tp, nparent);
+			opt->num_changes++;
 		}
 	}
 
@@ -552,6 +557,7 @@ struct combine_diff_path *diff_tree_paths(
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt)
 {
+	opt->num_changes = 0;
 	p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt);
 
 	/*
-- 
gitgitgadget

