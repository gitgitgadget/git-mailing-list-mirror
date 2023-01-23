Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F11C54E94
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjAWPWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjAWPW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:22:28 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DEF1EFED
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so10886052wmb.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J4PiALmbk8tjvT2I+N+9ZJNQzshR/5SGaQZobABn5U=;
        b=XJ8899WGegiDvaIpApPo7kFVj1fUwf4F62m48Xyu92xiDrr/hU7K4aswld9+hoT4G0
         JkDGXX+J0Y9+SluqoG9tx+ylmUkf/cKGWX2HmwfDm/ICuUIBou5f1LAQpJs4JV3VZA7l
         sRbYUHx3tt8a1X5LqvfB+3RLshHo3lgtMDbvjsCUC73ni4SEFDa+0px3exqeWE3mxECz
         q0aw6f9LmeqnNlXLNgl6xZrJBdw2tx8qGAcNS6apOEge1/7f2o6iuBXIJEdFCKMBKD2X
         BjQ3o463z5ee0wKKsCsBY/fEGMzB66KqxvDRaRlRj8ykC06usu+w9FQbOdhqr4BZhuAB
         YY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1J4PiALmbk8tjvT2I+N+9ZJNQzshR/5SGaQZobABn5U=;
        b=UpzbsysVsxCvBnx1zr/a3cC2LKS6qY3L7TwVkv4blX6lbhysovm5vNzt0FTwYUr7Vp
         aX+Z1fvv+ve7/LQi/JVywIKFWWJeVcuLnQ/YjqroKkLhpfFIWoFtKspDoAVmKES0NiF1
         gzNv4zy92yd2BijvPShYyusDJsdOVsq23VCY/cmCuSw/MJHYvlo+hyDAKJXLb75Ip86I
         7qIeq6UdkKmFW/nYSMNm6QmUrYZ7D8tJdFGbkXukvufUtm3D+dIWGEPFc+rGEIyMxltp
         BAs7pJfV/75NcAwf9MH65rA11asge16i2ofNMc9ZQ1PhIPVHQZj3adGbDC2PNVFlvY7l
         Sozg==
X-Gm-Message-State: AFqh2krkK+jXVs4IvKAhWeOA8xeb/9rhxyAKPmcPuo3tuTaKZ22HoccM
        RhyBXqVwnsDg3ZmH4/JuQ57N03ffYbE=
X-Google-Smtp-Source: AMrXdXupz0lGnHD2QyPm3xC7pWCocGl+v0ijGrramcRHYA9mwFduZFuNzniG1LzddsISWd65FN35ew==
X-Received: by 2002:a05:600c:5405:b0:3d3:5709:68e8 with SMTP id he5-20020a05600c540500b003d3570968e8mr23925558wmb.36.1674487316774;
        Mon, 23 Jan 2023 07:21:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3-20020a7bc043000000b003d1d5a83b2esm10719073wmc.35.2023.01.23.07.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:21:56 -0800 (PST)
Message-Id: <7cfaa3c518cbedb65c585cc02015bb21ae24e9fa.1674487310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 15:21:45 +0000
Subject: [PATCH v2 05/10] bundle-uri: download in creationToken order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The creationToken heuristic provides an ordering on the bundles
advertised by a bundle list. Teach the Git client to download bundles
differently when this heuristic is advertised.

The bundles in the list are sorted by their advertised creationToken
values, then downloaded in decreasing order. This avoids the previous
strategy of downloading bundles in an arbitrary order and attempting
to apply them (likely failing in the case of required commits) until
discovering the order through attempted unbundling.

During a fresh 'git clone', it may make sense to download the bundles in
increasing order, since that would prevent the need to attempt
unbundling a bundle with required commits that do not exist in our empty
object store. The cost of testing an unbundle is quite low, and instead
the chosen order is optimizing for a future bundle download during a
'git fetch' operation with a non-empty object store.

Since the Git client continues fetching from the Git remote after
downloading and unbundling bundles, the client's object store can be
ahead of the bundle provider's object store. The next time it attempts
to download from the bundle list, it makes most sense to download only
the most-recent bundles until all tips successfully unbundle. The
strategy implemented here provides that short-circuit where the client
downloads a minimal set of bundles.

However, we are not satisfied by the naive approach of downloading
bundles until one successfully unbundles, expecting the earlier bundles
to successfully unbundle now. The example repository in t5558
demonstrates this well:

 ---------------- bundle-4

       4
      / \
 ----|---|------- bundle-3
     |   |
     |   3
     |   |
 ----|---|------- bundle-2
     |   |
     2   |
     |   |
 ----|---|------- bundle-1
      \ /
       1
       |
 (previous commits)

In this repository, if we already have the objects for bundle-1 and then
try to fetch from this list, the naive approach will fail. bundle-4
requires both bundle-3 and bundle-2, though bundle-3 will successfully
unbundle without bundle-2. Thus, the algorithm needs to keep this in
mind.

A later implementation detail will store the maximum creationToken seen
during such a bundle download, and the client will avoid downloading a
bundle unless its creationToken is strictly greater than that stored
value. For now, if the client seeks to download from an identical
bundle list since its previous download, it will download the
most-recent bundle then stop since its required commits are already in
the object store.

Add tests that exercise this behavior, but we will expand upon these
tests when incremental downloads during 'git fetch' make use of
creationToken values.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                | 156 +++++++++++++++++++++++++++++++++++-
 t/t5558-clone-bundle-uri.sh |  40 +++++++--
 t/t5601-clone.sh            |  46 +++++++++++
 3 files changed, 233 insertions(+), 9 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index f46ab5c1743..39acd856fb9 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -453,6 +453,139 @@ static int download_bundle_to_file(struct remote_bundle_info *bundle, void *data
 	return 0;
 }
 
+struct bundles_for_sorting {
+	struct remote_bundle_info **items;
+	size_t alloc;
+	size_t nr;
+};
+
+static int append_bundle(struct remote_bundle_info *bundle, void *data)
+{
+	struct bundles_for_sorting *list = data;
+	list->items[list->nr++] = bundle;
+	return 0;
+}
+
+/**
+ * For use in QSORT() to get a list sorted by creationToken
+ * in decreasing order.
+ */
+static int compare_creation_token_decreasing(const void *va, const void *vb)
+{
+	const struct remote_bundle_info * const *a = va;
+	const struct remote_bundle_info * const *b = vb;
+
+	if ((*a)->creationToken > (*b)->creationToken)
+		return -1;
+	if ((*a)->creationToken < (*b)->creationToken)
+		return 1;
+	return 0;
+}
+
+static int fetch_bundles_by_token(struct repository *r,
+				  struct bundle_list *list)
+{
+	int cur;
+	int move_direction = 0;
+	struct bundle_list_context ctx = {
+		.r = r,
+		.list = list,
+		.mode = list->mode,
+	};
+	struct bundles_for_sorting bundles = {
+		.alloc = hashmap_get_size(&list->bundles),
+	};
+
+	ALLOC_ARRAY(bundles.items, bundles.alloc);
+
+	for_all_bundles_in_list(list, append_bundle, &bundles);
+
+	QSORT(bundles.items, bundles.nr, compare_creation_token_decreasing);
+
+	/*
+	 * Attempt to download and unbundle the minimum number of bundles by
+	 * creationToken in decreasing order. If we fail to unbundle (after
+	 * a successful download) then move to the next non-downloaded bundle
+	 * and attempt downloading. Once we succeed in applying a bundle,
+	 * move to the previous unapplied bundle and attempt to unbundle it
+	 * again.
+	 *
+	 * In the case of a fresh clone, we will likely download all of the
+	 * bundles before successfully unbundling the oldest one, then the
+	 * rest of the bundles unbundle successfully in increasing order
+	 * of creationToken.
+	 *
+	 * If there are existing objects, then this process may terminate
+	 * early when all required commits from "new" bundles exist in the
+	 * repo's object store.
+	 */
+	cur = 0;
+	while (cur >= 0 && cur < bundles.nr) {
+		struct remote_bundle_info *bundle = bundles.items[cur];
+		if (!bundle->file) {
+			/*
+			 * Not downloaded yet. Try downloading.
+			 *
+			 * Note that bundle->file is non-NULL if a download
+			 * was attempted, even if it failed to download.
+			 */
+			if (fetch_bundle_uri_internal(ctx.r, bundle, ctx.depth + 1, ctx.list)) {
+				/* Mark as unbundled so we do not retry. */
+				bundle->unbundled = 1;
+
+				/* Try looking deeper in the list. */
+				move_direction = 1;
+				goto stack_operation;
+			}
+
+			/* We expect bundles when using creationTokens. */
+			if (!is_bundle(bundle->file, 1)) {
+				warning(_("file downloaded from '%s' is not a bundle"),
+					bundle->uri);
+				break;
+			}
+		}
+
+		if (bundle->file && !bundle->unbundled) {
+			/*
+			 * This was downloaded, but not successfully
+			 * unbundled. Try unbundling again.
+			 */
+			if (unbundle_from_file(ctx.r, bundle->file)) {
+				/* Try looking deeper in the list. */
+				move_direction = 1;
+			} else {
+				/*
+				 * Succeeded in unbundle. Retry bundles
+				 * that previously failed to unbundle.
+				 */
+				move_direction = -1;
+				bundle->unbundled = 1;
+			}
+		}
+
+		/*
+		 * Else case: downloaded and unbundled successfully.
+		 * Skip this by moving in the same direction as the
+		 * previous step.
+		 */
+
+stack_operation:
+		/* Move in the specified direction and repeat. */
+		cur += move_direction;
+	}
+
+	free(bundles.items);
+
+	/*
+	 * We succeed if the loop terminates because 'cur' drops below
+	 * zero. The other case is that we terminate because 'cur'
+	 * reaches the end of the list, so we have a failure no matter
+	 * which bundles we apply from the list.
+	 */
+	return cur >= 0;
+}
+
 static int download_bundle_list(struct repository *r,
 				struct bundle_list *local_list,
 				struct bundle_list *global_list,
@@ -490,7 +623,15 @@ static int fetch_bundle_list_in_config_format(struct repository *r,
 		goto cleanup;
 	}
 
-	if ((result = download_bundle_list(r, &list_from_bundle,
+	/*
+	 * If this list uses the creationToken heuristic, then the URIs
+	 * it advertises are expected to be bundles, not nested lists.
+	 * We can drop 'global_list' and 'depth'.
+	 */
+	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN) {
+		result = fetch_bundles_by_token(r, &list_from_bundle);
+		global_list->heuristic = BUNDLE_HEURISTIC_CREATIONTOKEN;
+	} else if ((result = download_bundle_list(r, &list_from_bundle,
 					   global_list, depth)))
 		goto cleanup;
 
@@ -632,6 +773,14 @@ int fetch_bundle_list(struct repository *r, struct bundle_list *list)
 	int result;
 	struct bundle_list global_list;
 
+	/*
+	 * If the creationToken heuristic is used, then the URIs
+	 * advertised by 'list' are not nested lists and instead
+	 * direct bundles. We do not need to use global_list.
+	 */
+	if (list->heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN)
+		return fetch_bundles_by_token(r, list);
+
 	init_bundle_list(&global_list);
 
 	/* If a bundle is added to this global list, then it is required. */
@@ -640,7 +789,10 @@ int fetch_bundle_list(struct repository *r, struct bundle_list *list)
 	if ((result = download_bundle_list(r, list, &global_list, 0)))
 		goto cleanup;
 
-	result = unbundle_all_bundles(r, &global_list);
+	if (list->heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN)
+		result = fetch_bundles_by_token(r, list);
+	else
+		result = unbundle_all_bundles(r, &global_list);
 
 cleanup:
 	for_all_bundles_in_list(&global_list, unlink_bundle, NULL);
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 474432c8ace..6f9417a0afb 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -401,17 +401,43 @@ test_expect_success 'clone bundle list (http, creationToken)' '
 	git -C clone-list-http-2 cat-file --batch-check <oids &&
 
 	cat >expect <<-EOF &&
-	$HTTPD_URL/bundle-1.bundle
-	$HTTPD_URL/bundle-2.bundle
-	$HTTPD_URL/bundle-3.bundle
+	$HTTPD_URL/bundle-list
 	$HTTPD_URL/bundle-4.bundle
+	$HTTPD_URL/bundle-3.bundle
+	$HTTPD_URL/bundle-2.bundle
+	$HTTPD_URL/bundle-1.bundle
+	EOF
+
+	test_remote_https_urls <trace-clone.txt >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone incomplete bundle list (http, creationToken)' '
+	test_when_finished rm -f trace*.txt &&
+
+	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = bundle-1.bundle
+		creationToken = 1
+	EOF
+
+	GIT_TRACE2_EVENT=$(pwd)/trace-clone.txt \
+	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
+		--single-branch --branch=base --no-tags \
+		"$HTTPD_URL/smart/fetch.git" clone-token-http &&
+
+	cat >expect <<-EOF &&
 	$HTTPD_URL/bundle-list
+	$HTTPD_URL/bundle-1.bundle
 	EOF
 
-	# Since the creationToken heuristic is not yet understood by the
-	# client, the order cannot be verified at this moment. Sort the
-	# list for consistent results.
-	test_remote_https_urls <trace-clone.txt | sort >actual &&
+	test_remote_https_urls <trace-clone.txt >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 1928ea1dd7c..b7d5551262c 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -831,6 +831,52 @@ test_expect_success 'auto-discover multiple bundles from HTTP clone' '
 	grep -f pattern trace.txt
 '
 
+test_expect_success 'auto-discover multiple bundles from HTTP clone: creationToken heuristic' '
+	test_when_finished rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/repo4.git" &&
+	test_when_finished rm -rf clone-heuristic trace*.txt &&
+
+	test_commit -C src newest &&
+	git -C src bundle create "$HTTPD_DOCUMENT_ROOT_PATH/newest.bundle" HEAD~1..HEAD &&
+	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo4.git" &&
+
+	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/repo4.git/config" <<-EOF &&
+	[uploadPack]
+		advertiseBundleURIs = true
+
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "everything"]
+		uri = $HTTPD_URL/everything.bundle
+		creationtoken = 1
+
+	[bundle "new"]
+		uri = $HTTPD_URL/new.bundle
+		creationtoken = 2
+
+	[bundle "newest"]
+		uri = $HTTPD_URL/newest.bundle
+		creationtoken = 3
+	EOF
+
+	GIT_TRACE2_EVENT="$(pwd)/trace-clone.txt" \
+		git -c protocol.version=2 \
+		    -c transfer.bundleURI=true clone \
+		"$HTTPD_URL/smart/repo4.git" clone-heuristic &&
+
+	cat >expect <<-EOF &&
+	$HTTPD_URL/newest.bundle
+	$HTTPD_URL/new.bundle
+	$HTTPD_URL/everything.bundle
+	EOF
+
+	# We should fetch all bundles in the expected order.
+	test_remote_https_urls <trace-clone.txt >actual &&
+	test_cmp expect actual
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-- 
gitgitgadget

