Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0D9C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJJQFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJJQEh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:04:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A9A72EC2
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a10so17674791wrm.12
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYW3zycOqTCDitrkH8zzTbna0A6MArjZTyJjdXk1MNU=;
        b=PqbA2bEPmSaTpJ2ZXlwZC5eH5C6pzCk1gRIL1f5sk39TnMvYZt9PyIqBFKAzXGvbEf
         c2dOGebCwoI8I8y7A8yFbJEcV85RlOAuiARBDWJSWwJIMIJmA7LY++gf1V2qa0XHGOcp
         OzCwrTjeiSSNg3Q1rDHAJjWeyTVPS7CEYSyFiP5SAsGT0fvvNfqGp0kMJNBu6q7YbFij
         y1sc85sYxnVu+JXEluPXzmY4NKbNBwIZHTFht9B3+gsEu2sBk/veJKlYycUlJZXo9aIK
         +vgIqSpiaKBgT8qhznm2ImsDmOlVPMEcjeDjkK+fcC+JGk9c/aT8ckwt9lQswttAPZ8u
         8E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYW3zycOqTCDitrkH8zzTbna0A6MArjZTyJjdXk1MNU=;
        b=vuxBg/9lBvuI3rF/lgs6VSSpxDmFxebcnIoAFZUHcuse+NIq54S14LRgXDU9oyYD2g
         0Orn9No87ekBKFKswQ26C8nI00mfgkMHhImEC8VtuGsbZlZNsmFYjQdBPGJWfDCGrBzs
         o6N3tke0JBfZ+IEFoIIfkryDz3kI0fGFTjWQ61IsgcYhbH72zVRI0fqIxd2tegstmogY
         N4Xg6bChawQbocmWYNRTvNg/cCexGj7QqjemYsU78b5gADOXGnIrYo9OKzxr9w1Hdd3T
         WYFOrLb0lMfQ/xjTHLGEzeXDiUv8BLRYe9bbfv1+rhEfBIlKwu2PRJfLQsV0HvWgYSwo
         +Hyg==
X-Gm-Message-State: ACrzQf3mGEIWgLVHJMHdKVJTRH/MFDAmuB8N62drTqqO6K9gs4cf8Hm8
        aI0Upgni8CAdPxFmbDd3luvt/1ksP5k=
X-Google-Smtp-Source: AMsMyM5kCSSgFFmM6X6oYEYTt9PYbJEL6ExY7ckQSEu3eQWxr+W+ORT6+RqLxtCGmo47sL3XaAU0sA==
X-Received: by 2002:a05:6000:1888:b0:22f:a5af:c9c5 with SMTP id a8-20020a056000188800b0022fa5afc9c5mr6708754wri.631.1665417872200;
        Mon, 10 Oct 2022 09:04:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bv10-20020a0560001f0a00b00228fa832b7asm9115702wrb.52.2022.10.10.09.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:04:31 -0700 (PDT)
Message-Id: <6b9c764c6b3b6e69fef47716bdbd8d705e4d479a.1665417859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
References: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
        <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 16:04:17 +0000
Subject: [PATCH v4 09/11] bundle-uri: fetch a list of bundles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When the content at a given bundle URI is not understood as a bundle
(based on inspecting the initial content), then Git currently gives up
and ignores that content. Independent bundle providers may want to split
up the bundle content into multiple bundles, but still make them
available from a single URI.

Teach Git to attempt parsing the bundle URI content as a Git config file
providing the key=value pairs for a bundle list. Git then looks at the
mode of the list to see if ANY single bundle is sufficient or if ALL
bundles are required. The content at the selected URIs are downloaded
and the content is inspected again, creating a recursive process.

To guard the recursion against malformed or malicious content, limit the
recursion depth to a reasonable four for now. This can be converted to a
configured value in the future if necessary. The value of four is twice
as high as expected to be useful (a bundle list is unlikely to point to
more bundle lists).

To test this scenario, create an interesting bundle topology where three
incremental bundles are built on top of a single full bundle. By using a
merge commit, the two middle bundles are "independent" in that they do
not require each other in order to unbundle themselves. They each only
need the base bundle. The bundle containing the merge commit requires
both of the middle bundles, though. This leads to some interesting
decisions when unbundling, especially when we later implement heuristics
that promote downloading bundles until the prerequisite commits are
satisfied.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                | 203 ++++++++++++++++++++++++++---
 bundle-uri.h                |  13 ++
 t/t5558-clone-bundle-uri.sh | 248 ++++++++++++++++++++++++++++++++++++
 3 files changed, 448 insertions(+), 16 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index ad5baabdd94..c0a6fb05fad 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -37,6 +37,8 @@ static int clear_remote_bundle_info(struct remote_bundle_info *bundle,
 {
 	FREE_AND_NULL(bundle->id);
 	FREE_AND_NULL(bundle->uri);
+	FREE_AND_NULL(bundle->file);
+	bundle->unbundled = 0;
 	return 0;
 }
 
@@ -340,18 +342,117 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	return result;
 }
 
+struct bundle_list_context {
+	struct repository *r;
+	struct bundle_list *list;
+	enum bundle_list_mode mode;
+	int count;
+	int depth;
+};
+
+/*
+ * This early definition is necessary because we use indirect recursion:
+ *
+ * While iterating through a bundle list that was downloaded as part
+ * of fetch_bundle_uri_internal(), iterator methods eventually call it
+ * again, but with depth + 1.
+ */
+static int fetch_bundle_uri_internal(struct repository *r,
+				     struct remote_bundle_info *bundle,
+				     int depth,
+				     struct bundle_list *list);
+
+static int download_bundle_to_file(struct remote_bundle_info *bundle, void *data)
+{
+	int res;
+	struct bundle_list_context *ctx = data;
+
+	if (ctx->mode == BUNDLE_MODE_ANY && ctx->count)
+		return 0;
+
+	res = fetch_bundle_uri_internal(ctx->r, bundle, ctx->depth + 1, ctx->list);
+
+	/*
+	 * Only increment count if the download succeeded. If our mode is
+	 * BUNDLE_MODE_ANY, then we will want to try other URIs in the
+	 * list in case they work instead.
+	 */
+	if (!res)
+		ctx->count++;
+
+	/*
+	 * To be opportunistic as possible, we continue iterating and
+	 * download as many bundles as we can, so we can apply the ones
+	 * that work, even in BUNDLE_MODE_ALL mode.
+	 */
+	return 0;
+}
+
+static int download_bundle_list(struct repository *r,
+				struct bundle_list *local_list,
+				struct bundle_list *global_list,
+				int depth)
+{
+	struct bundle_list_context ctx = {
+		.r = r,
+		.list = global_list,
+		.depth = depth + 1,
+		.mode = local_list->mode,
+	};
+
+	return for_all_bundles_in_list(local_list, download_bundle_to_file, &ctx);
+}
+
+static int fetch_bundle_list_in_config_format(struct repository *r,
+					      struct bundle_list *global_list,
+					      struct remote_bundle_info *bundle,
+					      int depth)
+{
+	int result;
+	struct bundle_list list_from_bundle;
+
+	init_bundle_list(&list_from_bundle);
+
+	if ((result = bundle_uri_parse_config_format(bundle->uri,
+						     bundle->file,
+						     &list_from_bundle)))
+		goto cleanup;
+
+	if (list_from_bundle.mode == BUNDLE_MODE_NONE) {
+		warning(_("unrecognized bundle mode from URI '%s'"),
+			bundle->uri);
+		result = -1;
+		goto cleanup;
+	}
+
+	if ((result = download_bundle_list(r, &list_from_bundle,
+					   global_list, depth)))
+		goto cleanup;
+
+cleanup:
+	clear_bundle_list(&list_from_bundle);
+	return result;
+}
+
 /**
  * This limits the recursion on fetch_bundle_uri_internal() when following
  * bundle lists.
  */
 static int max_bundle_uri_depth = 4;
 
+/**
+ * Recursively download all bundles advertised at the given URI
+ * to files. If the file is a bundle, then add it to the given
+ * 'list'. Otherwise, expect a bundle list and recurse on the
+ * URIs in that list according to the list mode (ANY or ALL).
+ */
 static int fetch_bundle_uri_internal(struct repository *r,
-				     const char *uri,
-				     int depth)
+				     struct remote_bundle_info *bundle,
+				     int depth,
+				     struct bundle_list *list)
 {
 	int result = 0;
-	char *filename;
+	struct remote_bundle_info *bcopy;
 
 	if (depth >= max_bundle_uri_depth) {
 		warning(_("exceeded bundle URI recursion limit (%d)"),
@@ -359,36 +460,106 @@ static int fetch_bundle_uri_internal(struct repository *r,
 		return -1;
 	}
 
-	if (!(filename = find_temp_filename())) {
+	if (!bundle->file &&
+	    !(bundle->file = find_temp_filename())) {
 		result = -1;
 		goto cleanup;
 	}
 
-	if ((result = copy_uri_to_file(filename, uri))) {
-		warning(_("failed to download bundle from URI '%s'"), uri);
+	if ((result = copy_uri_to_file(bundle->file, bundle->uri))) {
+		warning(_("failed to download bundle from URI '%s'"), bundle->uri);
 		goto cleanup;
 	}
 
-	if ((result = !is_bundle(filename, 0))) {
-		warning(_("file at URI '%s' is not a bundle"), uri);
+	if ((result = !is_bundle(bundle->file, 1))) {
+		result = fetch_bundle_list_in_config_format(
+				r, list, bundle, depth);
+		if (result)
+			warning(_("file at URI '%s' is not a bundle or bundle list"),
+				bundle->uri);
 		goto cleanup;
 	}
 
-	if ((result = unbundle_from_file(r, filename))) {
-		warning(_("failed to unbundle bundle from URI '%s'"), uri);
-		goto cleanup;
-	}
+	/* Copy the bundle and insert it into the global list. */
+	CALLOC_ARRAY(bcopy, 1);
+	bcopy->id = xstrdup(bundle->id);
+	bcopy->file = xstrdup(bundle->file);
+	hashmap_entry_init(&bcopy->ent, strhash(bcopy->id));
+	hashmap_add(&list->bundles, &bcopy->ent);
 
 cleanup:
-	if (filename)
-		unlink(filename);
-	free(filename);
+	if (result && bundle->file)
+		unlink(bundle->file);
 	return result;
 }
 
+/**
+ * This loop iterator breaks the loop with nonzero return code on the
+ * first successful unbundling of a bundle.
+ */
+static int attempt_unbundle(struct remote_bundle_info *info, void *data)
+{
+	struct repository *r = data;
+
+	if (!info->file || info->unbundled)
+		return 0;
+
+	if (!unbundle_from_file(r, info->file)) {
+		info->unbundled = 1;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int unbundle_all_bundles(struct repository *r,
+				struct bundle_list *list)
+{
+	/*
+	 * Iterate through all bundles looking for ones that can
+	 * successfully unbundle. If any succeed, then perhaps another
+	 * will succeed in the next attempt.
+	 *
+	 * Keep in mind that a non-zero result for the loop here means
+	 * the loop terminated early on a successful unbundling, which
+	 * signals that we can try again.
+	 */
+	while (for_all_bundles_in_list(list, attempt_unbundle, r)) ;
+
+	return 0;
+}
+
+static int unlink_bundle(struct remote_bundle_info *info, void *data)
+{
+	if (info->file)
+		unlink_or_warn(info->file);
+	return 0;
+}
+
 int fetch_bundle_uri(struct repository *r, const char *uri)
 {
-	return fetch_bundle_uri_internal(r, uri, 0);
+	int result;
+	struct bundle_list list;
+	struct remote_bundle_info bundle = {
+		.uri = xstrdup(uri),
+		.id = xstrdup(""),
+	};
+
+	init_bundle_list(&list);
+
+	/* If a bundle is added to this global list, then it is required. */
+	list.mode = BUNDLE_MODE_ALL;
+
+	if ((result = fetch_bundle_uri_internal(r, &bundle, 0, &list)))
+		goto cleanup;
+
+	result = unbundle_all_bundles(r, &list);
+
+cleanup:
+	for_all_bundles_in_list(&list, unlink_bundle, NULL);
+	clear_bundle_list(&list);
+	clear_remote_bundle_info(&bundle, NULL);
+	return result;
 }
 
 /**
diff --git a/bundle-uri.h b/bundle-uri.h
index bc13d4c9929..4dbc269823c 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -28,6 +28,19 @@ struct remote_bundle_info {
 	 * if there was no table of contents.
 	 */
 	char *uri;
+
+	/**
+	 * If the bundle has been downloaded, then 'file' is a
+	 * filename storing its contents. Otherwise, 'file' is
+	 * NULL.
+	 */
+	char *file;
+
+	/**
+	 * If the bundle has been unbundled successfully, then
+	 * this boolean is true.
+	 */
+	unsigned unbundled:1;
 };
 
 #define REMOTE_BUNDLE_INFO_INIT { 0 }
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index ad666a2d28a..a86dc04f528 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -41,6 +41,195 @@ test_expect_success 'clone with file:// bundle' '
 	test_cmp expect actual
 '
 
+# To get interesting tests for bundle lists, we need to construct a
+# somewhat-interesting commit history.
+#
+# ---------------- bundle-4
+#
+#       4
+#      / \
+# ----|---|------- bundle-3
+#     |   |
+#     |   3
+#     |   |
+# ----|---|------- bundle-2
+#     |   |
+#     2   |
+#     |   |
+# ----|---|------- bundle-1
+#      \ /
+#       1
+#       |
+# (previous commits)
+test_expect_success 'construct incremental bundle list' '
+	(
+		cd clone-from &&
+		git checkout -b base &&
+		test_commit 1 &&
+		git checkout -b left &&
+		test_commit 2 &&
+		git checkout -b right base &&
+		test_commit 3 &&
+		git checkout -b merge left &&
+		git merge right -m "4" &&
+
+		git bundle create bundle-1.bundle base &&
+		git bundle create bundle-2.bundle base..left &&
+		git bundle create bundle-3.bundle base..right &&
+		git bundle create bundle-4.bundle merge --not left right
+	)
+'
+
+test_expect_success 'clone bundle list (file, no heuristic)' '
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+
+	[bundle "bundle-2"]
+		uri = file://$(pwd)/clone-from/bundle-2.bundle
+
+	[bundle "bundle-3"]
+		uri = file://$(pwd)/clone-from/bundle-3.bundle
+
+	[bundle "bundle-4"]
+		uri = file://$(pwd)/clone-from/bundle-4.bundle
+	EOF
+
+	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-list-file &&
+	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
+	git -C clone-list-file cat-file --batch-check <oids &&
+
+	git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	refs/bundles/merge
+	refs/bundles/right
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'clone bundle list (file, all mode, some failures)' '
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+
+	# Does not exist. Should be skipped.
+	[bundle "bundle-0"]
+		uri = file://$(pwd)/clone-from/bundle-0.bundle
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+
+	[bundle "bundle-2"]
+		uri = file://$(pwd)/clone-from/bundle-2.bundle
+
+	# No bundle-3 means bundle-4 will not apply.
+
+	[bundle "bundle-4"]
+		uri = file://$(pwd)/clone-from/bundle-4.bundle
+
+	# Does not exist. Should be skipped.
+	[bundle "bundle-5"]
+		uri = file://$(pwd)/clone-from/bundle-5.bundle
+	EOF
+
+	GIT_TRACE2_PERF=1 \
+	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-all-some &&
+	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
+	git -C clone-all-some cat-file --batch-check <oids &&
+
+	git -C clone-all-some for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'clone bundle list (file, all mode, all failures)' '
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+
+	# Does not exist. Should be skipped.
+	[bundle "bundle-0"]
+		uri = file://$(pwd)/clone-from/bundle-0.bundle
+
+	# Does not exist. Should be skipped.
+	[bundle "bundle-5"]
+		uri = file://$(pwd)/clone-from/bundle-5.bundle
+	EOF
+
+	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-all-fail &&
+	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
+	git -C clone-all-fail cat-file --batch-check <oids &&
+
+	git -C clone-all-fail for-each-ref --format="%(refname)" >refs &&
+	! grep "refs/bundles/" refs
+'
+
+test_expect_success 'clone bundle list (file, any mode)' '
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = any
+
+	# Does not exist. Should be skipped.
+	[bundle "bundle-0"]
+		uri = file://$(pwd)/clone-from/bundle-0.bundle
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+
+	# Does not exist. Should be skipped.
+	[bundle "bundle-5"]
+		uri = file://$(pwd)/clone-from/bundle-5.bundle
+	EOF
+
+	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-any-file &&
+	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
+	git -C clone-any-file cat-file --batch-check <oids &&
+
+	git -C clone-any-file for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'clone bundle list (file, any mode, all failures)' '
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = any
+
+	# Does not exist. Should be skipped.
+	[bundle "bundle-0"]
+		uri = $HTTPD_URL/bundle-0.bundle
+
+	# Does not exist. Should be skipped.
+	[bundle "bundle-5"]
+		uri = $HTTPD_URL/bundle-5.bundle
+	EOF
+
+	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-any-fail &&
+	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
+	git -C clone-any-fail cat-file --batch-check <oids &&
+
+	git -C clone-any-fail for-each-ref --format="%(refname)" >refs &&
+	! grep "refs/bundles/" refs
+'
+
 #########################################################################
 # HTTP tests begin here
 
@@ -75,6 +264,65 @@ test_expect_success 'clone HTTP bundle' '
 	test_config -C clone-http log.excludedecoration refs/bundle/
 '
 
+test_expect_success 'clone bundle list (HTTP, no heuristic)' '
+	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+
+	[bundle "bundle-1"]
+		uri = $HTTPD_URL/bundle-1.bundle
+
+	[bundle "bundle-2"]
+		uri = $HTTPD_URL/bundle-2.bundle
+
+	[bundle "bundle-3"]
+		uri = $HTTPD_URL/bundle-3.bundle
+
+	[bundle "bundle-4"]
+		uri = $HTTPD_URL/bundle-4.bundle
+	EOF
+
+	git clone --bundle-uri="$HTTPD_URL/bundle-list" clone-from clone-list-http &&
+	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
+	git -C clone-list-http cat-file --batch-check <oids
+'
+
+test_expect_success 'clone bundle list (HTTP, any mode)' '
+	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle]
+		version = 1
+		mode = any
+
+	# Does not exist. Should be skipped.
+	[bundle "bundle-0"]
+		uri = $HTTPD_URL/bundle-0.bundle
+
+	[bundle "bundle-1"]
+		uri = $HTTPD_URL/bundle-1.bundle
+
+	# Does not exist. Should be skipped.
+	[bundle "bundle-5"]
+		uri = $HTTPD_URL/bundle-5.bundle
+	EOF
+
+	git clone --bundle-uri="$HTTPD_URL/bundle-list" clone-from clone-any-http &&
+	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
+	git -C clone-any-http cat-file --batch-check <oids &&
+
+	git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	refs/bundles/merge
+	refs/bundles/right
+	EOF
+	test_cmp expect actual
+'
+
 # Do not add tests here unless they use the HTTP server, as they will
 # not run unless the HTTP dependencies exist.
 
-- 
gitgitgadget

