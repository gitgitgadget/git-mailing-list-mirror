Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C400C48BCD
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D57B61261
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhFEBbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 21:31:13 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:35333 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhFEBbN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 21:31:13 -0400
Received: by mail-wm1-f51.google.com with SMTP id h5-20020a05600c3505b029019f0654f6f1so8352540wmq.0
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 18:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VGq3U1Kw2tBAmhfBkUHQlXKdQUETBnKOSsnDPu7HWys=;
        b=sAmeXj+qcIeBgRzj5mgDSngWNvSYTlBzaZfz6/qrWoBeGsyyjeD1ieb4lu9rRM/3c0
         WJnNcOH/4WyeNIlJUAq9ClcbnOJnHZYnqFTgDjV8+S8ex+el5TqcwLXVyjmUsZBziT/l
         8AKPX6ZpUBtTaV3vlfhMCglO53Dt9je3AsLpOSKD8GM1T/cohrvhzzDNfmkSqvh5axRp
         vDqB8Jk0H7EEKyv/PoDFxIeEGO2XAVXC9GNlQQLujA05h/fhs+X86wsD9B//DkXP13Co
         Av5xzVPz4mkWMheOlW9LG61yp1LKCcCqzgCPnQUYiySjbaeJIvyjIqtRYqgdJbV1Y1MU
         JUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VGq3U1Kw2tBAmhfBkUHQlXKdQUETBnKOSsnDPu7HWys=;
        b=OskmDVJNZ0by0jPYY4nVRNlne5Re+SWadACs5+OSHzSrAR4A/yW65rTnYNiHFVz+tX
         rVxGaMxGRsdkObNvapG20RSdUAuUKrJdfHqR1Z/rnDL00PkZrx00YABwVnghk3I295yg
         5wxIpi/d/iLXrk1XE87nZF8MwYr/jvd9usyw+tta+ohfodnkvD5ZPUwMJcugxgrrwVzw
         ci2S6bs3mO9YNJcnK/0m+BTqUhkOZCnYfMSNG5cy3q4OIHvVGw95RTNz4QZMszYEqc3D
         2f95nnqcZM41/lk8FPjIPE/HJSDGznqpNQFN/CafrwimzoTZ5rbtJSpH592TE/PcHI0H
         Skhg==
X-Gm-Message-State: AOAM530X2O0LCnOhlMRvoT3fVw99eIdmucU5YLKePueR47q7+bRbCuq5
        d7jf4cWwp99PmCE6UUYL7+iUdfoxyAQ=
X-Google-Smtp-Source: ABdhPJxSieVl8zRLmeJnspi9P5x8G95wUDI5S6gmT7qHy3F+9Oq5eTXf5JBoG3ci/1xQ3fj6sVhhPQ==
X-Received: by 2002:a05:600c:b50:: with SMTP id k16mr5982311wmr.137.1622856488728;
        Fri, 04 Jun 2021 18:28:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m132sm7157037wmf.10.2021.06.04.18.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:28:08 -0700 (PDT)
Message-Id: <f4ade3996d3f2ee5d0ce52469062a1b3290f5b11.1622856485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.969.git.1622856485.gitgitgadget@gmail.com>
References: <pull.969.git.1622856485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Jun 2021 01:28:03 +0000
Subject: [PATCH 4/5] diffcore-rename: use a different prefetch for basename
 comparisons
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge-ort was designed to minimize the amount of data needed and used,
and several changes were made to diffcore-rename to take advantage of
extra metadata to enable this data minimization (particularly the
relevant_sources variable for skipping "irrelevant" renames).  This
effort obviously succeeded in drastically reducing computation times,
but should also theoretically allow partial clones to download much less
information.  Previously, though, the "prefetch" command used in
diffcore-rename had never been modified and downloaded many blobs that
were unnecessary for merge-ort.  This commit corrects that.

When doing basename comparisons, we want to fetch only the objects that
will be used for basename comparisons.  If after basename fetching this
leaves us with no more relevant sources (or no more destinations), then
we won't need to do the full inexact rename detection and can skip
downloading additional source and destination files.  Even if we have to
do that later full inexact rename detection, irrelevant sources are
culled after basename matching and before the full inexact rename
detection, so we can still avoid downloading the blobs for irrelevant
sources.  Rename prefetch() to inexact_prefetch(), and introduce a
new basename_prefetch() to take advantage of this.

If we modify the testcase from commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2021-01-23)
to pass
    --sparse --filter=blob:none
to the clone command, and use the new trace2 "fetch_count" output from
a few commits ago to track both the number of fetch subcommands invoked
and the number of objects fetched across all those fetches, then for
the mega-renames testcase we observe the following:

BEFORE this commit, rebasing 35 patches:
    strategy     # of fetches    total # of objects fetched
    ---------    ------------    --------------------------
    recursive    62              11423
    ort          30              11391

AFTER this commit, rebasing the same 35 patches:
    ort          32                 63

This means that the new code only needs to download less than 2 blobs
per patch being rebased.  That is especially interesting given that the
repository at the start only had approximately half a dozen TOTAL blobs
downloaded to start with (because the default sparse-checkout of just
the toplevel directory was in use).

So, for this particular linux kernel testcase that involved ~26,000
renames on the upstream side (drivers/ -> pilots/) across which 35
patches were being rebased, this change reduces the number of blobs that
need to be downloaded by a factor of ~180.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c              | 101 +++++++++++++++++++++++++++------
 t/t6421-merge-partial-clone.sh |   4 +-
 2 files changed, 85 insertions(+), 20 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index e13e52046026..4ef0459cfb50 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -87,13 +87,13 @@ struct diff_score {
 	short name_score;
 };
 
-struct prefetch_options {
+struct inexact_prefetch_options {
 	struct repository *repo;
 	int skip_unmodified;
 };
-static void prefetch(void *prefetch_options)
+static void inexact_prefetch(void *prefetch_options)
 {
-	struct prefetch_options *options = prefetch_options;
+	struct inexact_prefetch_options *options = prefetch_options;
 	int i;
 	struct oid_array to_fetch = OID_ARRAY_INIT;
 
@@ -816,6 +816,78 @@ static int idx_possible_rename(char *filename, struct dir_rename_info *info)
 	return idx;
 }
 
+struct basename_prefetch_options {
+	struct repository *repo;
+	struct strintmap *relevant_sources;
+	struct strintmap *sources;
+	struct strintmap *dests;
+	struct dir_rename_info *info;
+};
+static void basename_prefetch(void *prefetch_options)
+{
+	struct basename_prefetch_options *options = prefetch_options;
+	struct strintmap *relevant_sources = options->relevant_sources;
+	struct strintmap *sources = options->sources;
+	struct strintmap *dests = options->dests;
+	struct dir_rename_info *info = options->info;
+	int i;
+	struct oid_array to_fetch = OID_ARRAY_INIT;
+
+	/*
+	 * TODO: The following loops mirror the code/logic from
+	 * find_basename_matches(), though not quite exactly.  Maybe
+	 * abstract the iteration logic out somehow?
+	 */
+	for (i = 0; i < rename_src_nr; ++i) {
+		char *filename = rename_src[i].p->one->path;
+		const char *base = NULL;
+		intptr_t src_index;
+		intptr_t dst_index;
+
+		/* Skip irrelevant sources */
+		if (relevant_sources &&
+		    !strintmap_contains(relevant_sources, filename))
+			continue;
+
+		/*
+		 * If the basename is unique among remaining sources, then
+		 * src_index will equal 'i' and we can attempt to match it
+		 * to a unique basename in the destinations.  Otherwise,
+		 * use directory rename heuristics, if possible.
+		 */
+		base = get_basename(filename);
+		src_index = strintmap_get(sources, base);
+		assert(src_index == -1 || src_index == i);
+
+		if (strintmap_contains(dests, base)) {
+			struct diff_filespec *one, *two;
+
+			/* Find a matching destination, if possible */
+			dst_index = strintmap_get(dests, base);
+			if (src_index == -1 || dst_index == -1) {
+				src_index = i;
+				dst_index = idx_possible_rename(filename, info);
+			}
+			if (dst_index == -1)
+				continue;
+
+			/* Ignore this dest if already used in a rename */
+			if (rename_dst[dst_index].is_rename)
+				continue; /* already used previously */
+
+			one = rename_src[src_index].p->one;
+			two = rename_dst[dst_index].p->two;
+
+			/* Add the pairs */
+			diff_add_if_missing(options->repo, &to_fetch, two);
+			diff_add_if_missing(options->repo, &to_fetch, one);
+		}
+	}
+
+	promisor_remote_get_direct(options->repo, to_fetch.oid, to_fetch.nr);
+	oid_array_clear(&to_fetch);
+}
+
 static int find_basename_matches(struct diff_options *options,
 				 int minimum_score,
 				 struct dir_rename_info *info,
@@ -860,19 +932,12 @@ static int find_basename_matches(struct diff_options *options,
 		.missing_object_cb = NULL,
 		.missing_object_data = NULL
 	};
-	/*
-	 * The prefeteching stuff wants to know if it can skip prefetching
-	 * blobs that are unmodified...and will then do a little extra work
-	 * to verify that the oids are indeed different before prefetching.
-	 * Unmodified blobs are only relevant when doing copy detection;
-	 * when limiting to rename detection, diffcore_rename[_extended]()
-	 * will never be called with unmodified source paths fed to us, so
-	 * the extra work necessary to check if rename_src entries are
-	 * unmodified would be a small waste.
-	 */
-	struct prefetch_options prefetch_options = {
+	struct basename_prefetch_options prefetch_options = {
 		.repo = options->repo,
-		.skip_unmodified = 0
+		.relevant_sources = relevant_sources,
+		.sources = &sources,
+		.dests = &dests,
+		.info = info
 	};
 
 	/*
@@ -911,7 +976,7 @@ static int find_basename_matches(struct diff_options *options,
 	}
 
 	if (options->repo == the_repository && has_promisor_remote()) {
-		dpf_options.missing_object_cb = prefetch;
+		dpf_options.missing_object_cb = basename_prefetch;
 		dpf_options.missing_object_data = &prefetch_options;
 	}
 
@@ -1282,7 +1347,7 @@ void diffcore_rename_extended(struct diff_options *options,
 		.missing_object_cb = NULL,
 		.missing_object_data = NULL
 	};
-	struct prefetch_options prefetch_options = {
+	struct inexact_prefetch_options prefetch_options = {
 		.repo = options->repo
 	};
 
@@ -1449,7 +1514,7 @@ void diffcore_rename_extended(struct diff_options *options,
 	/* Finish setting up dpf_options */
 	prefetch_options.skip_unmodified = skip_unmodified;
 	if (options->repo == the_repository && has_promisor_remote()) {
-		dpf_options.missing_object_cb = prefetch;
+		dpf_options.missing_object_cb = inexact_prefetch;
 		dpf_options.missing_object_data = &prefetch_options;
 	}
 
diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index 028d876be2c8..fb7eb18cc80c 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -206,7 +206,7 @@ test_setup_repo () {
 #
 #   Summary: 2 fetches (1 for 2 objects, 1 for 1 object)
 #
-test_expect_merge_algorithm failure failure 'Objects downloaded for single relevant rename' '
+test_expect_merge_algorithm failure success 'Objects downloaded for single relevant rename' '
 	test_setup_repo &&
 	git clone --sparse --filter=blob:none "file://$(pwd)/server" objects-single &&
 	(
@@ -293,7 +293,7 @@ test_expect_merge_algorithm failure failure 'Objects downloaded for single relev
 #      this are not all that common.)
 #   Summary: 1 fetches for 6 objects
 #
-test_expect_merge_algorithm failure failure 'Objects downloaded when a directory rename triggered' '
+test_expect_merge_algorithm failure success 'Objects downloaded when a directory rename triggered' '
 	test_setup_repo &&
 	git clone --sparse --filter=blob:none "file://$(pwd)/server" objects-dir &&
 	(
-- 
gitgitgadget

