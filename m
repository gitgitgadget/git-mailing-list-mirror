Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED97C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CD7217BA
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtAVzAPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgBEW4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:56:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40376 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgBEW4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:56:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so4783973wmi.5
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 14:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nr46BanJzdBPRgc/KAUMH4nTU42ApIb+xIqTBU98VXI=;
        b=CtAVzAPfY2NKDTl9tCKqvKVls08oX9Qo8w/DSlGNhKlxuDXgLmj3cd+apceq1Ozm/c
         56711HqQb8j9poBIiOfsYEPi4DM2AKhMzKtpQqGptReFdtHI/+45p4nR8VcdnzNudavu
         k1/9BZUmJwsLqbvwMI9l0UgW2TJOeupJYAx6z+JjuHT97X5OwBa9lz+tu7cqQi3lBPbF
         apbnY48LK/rT+pMw0rfFLj7JgnfrLicvbBTd46Zi9xXB2ZOXDdLAKVcTORE64wd+TZUz
         nzPZz6CdNaMHMawZAmdgIARwpibePSKZRwkPUa83Q6Wc9nedvJLga2ToG2S3BMJskK/B
         eR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nr46BanJzdBPRgc/KAUMH4nTU42ApIb+xIqTBU98VXI=;
        b=QEIcRyMuzO2iQNzb9dihzqyI4v2Hf32NqFtPzoiKqGGiS3fyxMF+p0hfFdvdXICaQU
         cT8E/SeFkIxQrG7+LPT5ZawHYfHTku2eJJSLAo+J2qJH2EyIUsfkZ/CF8k5yWbUhkn/y
         povmNUIMa2S99bI7HYevQxOe3xCgX8BEhpv7W/SuXYX7Xu4iDuq+rPpOn25PBkeBuRth
         0k3owtNjj+411jc5yrHb3XsU6ijOF73DAYQeXrZDdF3Ni80/OJuPJgmwk7hJz1ECh/6k
         nr8dteOyGTuAJGbhOiDWGu4KWLTs/fmCAZMSTXo5KR4lzKYBTZzApcaf+zjRkp+EfJi5
         wmew==
X-Gm-Message-State: APjAAAVmge0p4R3yLhVhdMB+0orlB3SsS9NbmJexKIot93hGZgksjpiP
        Y2LW077XJSlTo0iE1FV34f0kwTsJ
X-Google-Smtp-Source: APXvYqygchkPkykmrh0ZyYaG/xHB7JvD8cWmCrmFMDElq4yQdE9FYpgcidcB5dabtpVl3UUkyMPCxw==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr8893179wmg.16.1580943393878;
        Wed, 05 Feb 2020 14:56:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm1525963wrt.91.2020.02.05.14.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:56:33 -0800 (PST)
Message-Id: <a698c04a78cf2988fb822e0aa532989f925e0a9e.1580943390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Feb 2020 22:56:22 +0000
Subject: [PATCH v2 03/11] diff: halt tree-diff early after max_changes
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
index 6082193a75..818382c03b 100644
--- a/bloom.c
+++ b/bloom.c
@@ -134,6 +134,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 	int i;
 	struct diff_options diffopt;
+	int max_changes = 512;
 
 	if (!bloom_filters.slab_size)
 		return NULL;
@@ -142,6 +143,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
+	diffopt.max_changes = max_changes;
 	diff_setup_done(&diffopt);
 
 	if (c->parents)
@@ -150,7 +152,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
 	diffcore_std(&diffopt);
 
-	if (diff_queued_diff.nr <= 512) {
+	if (diff_queued_diff.nr <= max_changes) {
 		struct hashmap pathmap;
 		struct pathmap_hash_entry* e;
 		struct hashmap_iter iter;
diff --git a/diff.h b/diff.h
index 6febe7e365..9443dc1b00 100644
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
index 33ded7f8b3..f3d303c6e5 100644
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

