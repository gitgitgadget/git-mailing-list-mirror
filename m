Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7EFC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 15:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiHVPTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 11:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiHVPTC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 11:19:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219FF474E4
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:13:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k9so13638631wri.0
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=o6qIvDIhR8I3oqqIZBfgHkhY6OLZE7XHU3hOwCi8wqM=;
        b=dVuuyZEM0qVfppTGEH3kIXIFmBqteDuhUG4b8wh1g9lEnPUh8k6Omkvwc7ISO1KFSJ
         Ubl/o32BoZM9Nd2duOZZkT1Are3jXZh6BlEuf8PYkqnslWiCsWbxnZJrl7mAbYz/lNFz
         jtoECL3AiAtUF34jlhdlpnbb81Ksp41RQllio2BIZUuwXDCgfVGdMUZtM2zcdH4prgB9
         it3XzPzrou0XXu1taH7G6phwEzwCnhcRM7IutCDj9aXd0NgV2td4pN2sv10KN2B2VJ1z
         Z3zR/n0n2AAIiNgabeooy2oI3g9W4oR4mt0r9Hyr6Y9PC3qYyfmyV0tLMpe/qYsZwzPA
         dWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=o6qIvDIhR8I3oqqIZBfgHkhY6OLZE7XHU3hOwCi8wqM=;
        b=4T0mHi+lo6oJmNg+IgqeVnHFAU0ddPur2IvneilY04XC10kK4w+h/t5BO7zjeIUj6Y
         GyO5oDQHoLwdHDYYN7HvdR9UKk6pfvDj2DeO6OnDF11BFushSFI0CyFHLuc0mokj64Hq
         PQstdQ99eUVACmDE3xzVbt8B8uwF5ZZDA6VrZkmBDJ/NUgmZstr41TXlHnMeY2lrH1Tr
         AfisjkfbQeFIzPs6n/x79fk0iTAtBCe094xfUUkZ/TBAaZx6OKnNZmWjaHv3IenWCSub
         QC1tvcvcXG63azl4TNztOyNlI4cnmYoUvpJHc+MN1JYxz3jSlhoqOaV8r1OGDYradFsz
         Xp4w==
X-Gm-Message-State: ACgBeo1AirW8IvNglHGyPTzevv5fS/KBrR02epqRxODjHJpoTKYgogaj
        zilq02xCO1hGFyStwnvZuQhrK/KkWXA=
X-Google-Smtp-Source: AA6agR5ws4M5Qc2FADVFn1N9Sk41V+DSkk3C5sHiz7Weu/VV8lTi0md/SO+FTBqL++Hb+FeY6eDsIw==
X-Received: by 2002:a5d:6d8a:0:b0:225:2e6c:8a1b with SMTP id l10-20020a5d6d8a000000b002252e6c8a1bmr5622663wrs.647.1661181182531;
        Mon, 22 Aug 2022 08:13:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c35c600b003a626055569sm15179057wmq.16.2022.08.22.08.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:13:02 -0700 (PDT)
Message-Id: <7b45c06cc9e0294311d9f00d40eb1fa4f8f146f9.1661181174.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 15:12:54 +0000
Subject: [PATCH 7/7] bundle-uri: fetch a list of bundles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
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
 bundle-uri.c                | 211 +++++++++++++++++++++++++++++++++---
 bundle-uri.h                |   6 +
 t/t5558-clone-bundle-uri.sh |  93 ++++++++++++++++
 3 files changed, 293 insertions(+), 17 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index c9f3df28b2f..37867afca27 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -35,9 +35,10 @@ void init_bundle_list(struct bundle_list *list)
 static int clear_remote_bundle_info(struct remote_bundle_info *bundle,
 				    void *data)
 {
-	free(bundle->id);
-	free(bundle->uri);
+	FREE_AND_NULL(bundle->id);
+	FREE_AND_NULL(bundle->uri);
 	strbuf_release(&bundle->file);
+	bundle->unbundled = 0;
 	return 0;
 }
 
@@ -334,18 +335,102 @@ static int unbundle_from_file(struct repository *r, const char *file)
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
+	struct bundle_list_context *ctx = data;
+
+	if (ctx->mode == BUNDLE_MODE_ANY && ctx->count)
+		return 0;
+
+	ctx->count++;
+	return fetch_bundle_uri_internal(ctx->r, bundle, ctx->depth + 1, ctx->list);
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
+	if ((result = parse_bundle_list_in_config_format(bundle->uri,
+							 bundle->file.buf,
+							 &list_from_bundle)))
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
-	struct strbuf filename = STRBUF_INIT;
+	struct remote_bundle_info *bcopy;
 
 	if (depth >= max_bundle_uri_depth) {
 		warning(_("exceeded bundle URI recursion limit (%d)"),
@@ -353,33 +438,125 @@ static int fetch_bundle_uri_internal(struct repository *r,
 		return -1;
 	}
 
-	if ((result = find_temp_filename(&filename)))
+	if (!bundle->file.len &&
+	    (result = find_temp_filename(&bundle->file)))
 		goto cleanup;
 
-	if ((result = copy_uri_to_file(filename.buf, uri))) {
-		warning(_("failed to download bundle from URI '%s'"), uri);
+	if ((result = copy_uri_to_file(bundle->file.buf, bundle->uri))) {
+		warning(_("failed to download bundle from URI '%s'"), bundle->uri);
 		goto cleanup;
 	}
 
-	if ((result = !is_bundle(filename.buf, 0))) {
-		warning(_("file at URI '%s' is not a bundle"), uri);
+	if ((result = !is_bundle(bundle->file.buf, 1))) {
+		result = fetch_bundle_list_in_config_format(
+				r, list, bundle, depth);
+		if (result)
+			warning(_("file at URI '%s' is not a bundle or bundle list"),
+				bundle->uri);
 		goto cleanup;
 	}
 
-	if ((result = unbundle_from_file(r, filename.buf))) {
-		warning(_("failed to unbundle bundle from URI '%s'"), uri);
-		goto cleanup;
-	}
+	/* Copy the bundle and insert it into the global list. */
+	CALLOC_ARRAY(bcopy, 1);
+	bcopy->id = xstrdup(bundle->id);
+	strbuf_init(&bcopy->file, 0);
+	strbuf_add(&bcopy->file, bundle->file.buf, bundle->file.len);
+	hashmap_entry_init(&bcopy->ent, strhash(bcopy->id));
+	hashmap_add(&list->bundles, &bcopy->ent);
 
 cleanup:
-	unlink(filename.buf);
-	strbuf_release(&filename);
+	if (result)
+		unlink(bundle->file.buf);
 	return result;
 }
 
+struct attempt_unbundle_context {
+	struct repository *r;
+	int success_count;
+	int failure_count;
+};
+
+static int attempt_unbundle(struct remote_bundle_info *info, void *data)
+{
+	struct attempt_unbundle_context *ctx = data;
+
+	if (info->unbundled || !unbundle_from_file(ctx->r, info->file.buf)) {
+		ctx->success_count++;
+		info->unbundled = 1;
+	} else {
+		ctx->failure_count++;
+	}
+
+	return 0;
+}
+
+static int unbundle_all_bundles(struct repository *r,
+				struct bundle_list *list)
+{
+	int last_success_count = -1;
+	struct attempt_unbundle_context ctx = {
+		.r = r,
+	};
+
+	/*
+	 * Iterate through all bundles looking for ones that can
+	 * successfully unbundle. If any succeed, then perhaps another
+	 * will succeed in the next attempt.
+	 */
+	while (last_success_count < ctx.success_count) {
+		last_success_count = ctx.success_count;
+
+		ctx.success_count = 0;
+		ctx.failure_count = 0;
+		for_all_bundles_in_list(list, attempt_unbundle, &ctx);
+	}
+
+	if (ctx.success_count)
+		git_config_set_multivar_gently("log.excludedecoration",
+						"refs/bundle/",
+						"refs/bundle/",
+						CONFIG_FLAGS_FIXED_VALUE |
+						CONFIG_FLAGS_MULTI_REPLACE);
+
+	if (ctx.failure_count)
+		warning(_("failed to unbundle %d bundles"),
+			ctx.failure_count);
+
+	return 0;
+}
+
+static int unlink_bundle(struct remote_bundle_info *info, void *data)
+{
+	if (info->file.buf)
+		unlink_or_warn(info->file.buf);
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
+		.id = xstrdup("<root>"),
+		.file = STRBUF_INIT,
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
index 294ac804140..e9d85a6ecfb 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -35,6 +35,12 @@ struct remote_bundle_info {
 	 * an empty string.
 	 */
 	struct strbuf file;
+
+	/**
+	 * If the bundle has been unbundled successfully, then
+	 * this boolean is true.
+	 */
+	unsigned unbundled:1;
 };
 
 #define REMOTE_BUNDLE_INFO_INIT { \
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index ad666a2d28a..592790b49f0 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -41,6 +41,72 @@ test_expect_success 'clone with file:// bundle' '
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
+	git clone --bundle-uri="file://$(pwd)/bundle-list" . clone-list-file &&
+	for oid in $(git -C clone-from for-each-ref --format="%(objectname)")
+	do
+		git -C clone-list-file rev-parse $oid || return 1
+	done
+'
+
+
 #########################################################################
 # HTTP tests begin here
 
@@ -75,6 +141,33 @@ test_expect_success 'clone HTTP bundle' '
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
+	git clone --bundle-uri="$HTTPD_URL/bundle-list" . clone-list-http &&
+	for oid in $(git -C clone-from for-each-ref --format="%(objectname)")
+	do
+		git -C clone-list-http rev-parse $oid || return 1
+	done
+'
+
 # Do not add tests here unless they use the HTTP server, as they will
 # not run unless the HTTP dependencies exist.
 
-- 
gitgitgadget
