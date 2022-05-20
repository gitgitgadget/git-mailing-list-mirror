Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226D2C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353072AbiETSmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353012AbiETSlH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAB620BCF
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n6so4996477wms.0
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C2loti5NN/J1UqXaUEJC+qCF2iAcXU4wiSeLPbl4a1s=;
        b=LJDjMsOzQYmYjUYwznT7+r7/ec4JuCOH5bnwPG/vSj7eVjEuhSDBc/Q+r6Nzy2mLOc
         oQUvvPgKi19JEnexllb/elI8T+o0/HWx/Le28mJ5T8Dc2aPzdb12NkAEzwN5ERv8LJTm
         oMVsMI0dTeM1VU708Chco9TbUUzVZcp8wfPmpPrYw/rU7R/+/N+8oYwU1Dg4jmU5id0n
         dtoG9pCHrXQ7vrkcqhwrM/nxmTTXUKZugyWSTkAMnoCQNInb3iKq5Y8Mth64Ga6LRwIZ
         iqk6RMXS+tL92HErARYaKnsIwRn6mzSD7hYCfJ/MMOX4T8d2H4KehKTtFMM/iU9/iwom
         nDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C2loti5NN/J1UqXaUEJC+qCF2iAcXU4wiSeLPbl4a1s=;
        b=yi8evb8qnlEvuYYoGsbZbmDtqoTPRsKDqucWIb0kZNVnBU6gbpzYnhjRv6hgId9fPM
         sN9nRCCd8ZbxvHcPxRPyHonyUFXhGAbFczyBdUWmDzQY6QFbV8X/ncxZ01+GUBuiQzpW
         nzfMe+loYlz2b4v/dQVgDijJPiiuMrb+1//d2hRHAq33QbW8D9e/05tblvp5PUqsRrct
         dKIRlSG7UC5kuVJ0iSH9GxOB9hLKEzBWltMIrjBAU5RmEIHr1uCNcjqP9TSc9R9WKIHU
         WHWD/pRaL+Q7ls0wtD6AmOGvC/v85yAYw0pOKVx2rYdZlwbElh4oTs1CTL83bRUrVeLm
         2a+Q==
X-Gm-Message-State: AOAM530j/Cks3kowu4DxKy0CgN1tYtFLomM6kAlKYH0uHrHG7xgEbHqA
        M2oxc4LgShN+eyMHF1A6++qUr/3Mulo=
X-Google-Smtp-Source: ABdhPJyFJzp7YkRwKMfPhMBJginN2SONEA2+DiXXvhICqdq93ySFis7dsDz1adisNnFs4V53MO4nNQ==
X-Received: by 2002:a05:600c:1d18:b0:394:6469:abec with SMTP id l24-20020a05600c1d1800b003946469abecmr9454840wms.89.1653072061278;
        Fri, 20 May 2022 11:41:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10-20020a7bc10a000000b00397099b8cffsm2713412wmi.1.2022.05.20.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:41:00 -0700 (PDT)
Message-Id: <ceb253ec445b7275943e1c04ac51f12869271e91.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:33 +0000
Subject: [PATCH 15/24] bundle-uri: fetch a list of bundles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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

RFC TODO: add tests for this feature right now.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 213 ++++++++++++++++++++++++++++++++++++++++++++++-----
 bundle-uri.h |   6 ++
 2 files changed, 200 insertions(+), 19 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index ab4b6385fc0..601e6e87822 100644
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
 
@@ -336,18 +337,102 @@ static int unbundle_from_file(struct repository *r, const char *file)
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
@@ -355,31 +440,121 @@ static int fetch_bundle_uri_internal(struct repository *r,
 		return -1;
 	}
 
-	find_temp_filename(&filename);
-	if ((result = copy_uri_to_file(uri, filename.buf)))
+	if (!bundle->file.len)
+		find_temp_filename(&bundle->file);
+	if ((result = copy_uri_to_file(bundle->uri, bundle->file.buf)))
 		goto cleanup;
 
-	if ((result = !is_bundle(filename.buf, 0)))
-		goto cleanup;
-
-	if ((result = unbundle_from_file(r, filename.buf)))
+	if ((result = !is_bundle(bundle->file.buf, 1))) {
+		result = fetch_bundle_list_in_config_format(
+				r, list, bundle, depth);
 		goto cleanup;
+	}
 
-	git_config_set_multivar_gently("log.excludedecoration",
-					"refs/bundle/",
-					"refs/bundle/",
-					CONFIG_FLAGS_FIXED_VALUE |
-					CONFIG_FLAGS_MULTI_REPLACE);
+	/* Copy the bundle and insert it into the global list. */
+	CALLOC_ARRAY(bcopy, 1);
+	bcopy->id = xstrdup(bundle->id);
+	strbuf_init(&bcopy->file, 0);
+	strbuf_add(&bcopy->file, bundle->file.buf, bundle->file.len);
+	strbuf_detach(&bundle->file, NULL);
+	hashmap_entry_init(&bcopy->ent, strhash(bcopy->id));
+	hashmap_add(&list->bundles, &bcopy->ent);
 
 cleanup:
-	unlink(filename.buf);
-	strbuf_release(&filename);
+	if (bundle->file.len)
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
+	if (ctx.failure_count) {
+		warning(_("failed to unbundle %d bundles"),
+			ctx.failure_count);
+		return -1;
+	}
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
index b0183870336..adce5dc07e2 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -36,6 +36,12 @@ struct remote_bundle_info {
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
-- 
gitgitgadget

