Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E175C54EBD
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 20:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbjAFUhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbjAFUgy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 15:36:54 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A2F1108
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 12:36:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bn26so2384429wrb.0
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 12:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIBYOHqWOzrPXhcBU3xFIgt6lHh/eGSCsYdpxJTxxbs=;
        b=Zt7L0eTIKIWaN7sGE81G741E3JW2NgN+aAtpNWalrpcxyBfaIch7kKXRcOHc2VwCSB
         WV/gRAaNg8GSsWgNHmCE21344aD4wRYtsIlycPhSKQBqqxMFsDfj8dxNF8G9f63B1K5s
         Dy5YExlkz2DxhI+L6sMZQmwYyUbgRGQ0XztMpW/t4dTM1qrdjLxG1dDN+BUkyK7xez1B
         qq021lSwqsoO1nL/veWqgtsMt1ejtPV8Lk5lcZTBlhoiIDIYaodDZ/Lx2XRoqMhdTlCe
         KjFRZXZOuQC7Y+N3qN4BKL8aWIkZ4W0NqnU+tP/5phw6FYxQRjIzCFsMKxX0SbjAB4on
         dQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIBYOHqWOzrPXhcBU3xFIgt6lHh/eGSCsYdpxJTxxbs=;
        b=EfL+J1csDfsmE1FA85Nq3jPEWTPBrQZBgqvy5T9B3MYLuZfG3rGp/db+nNZd5PRGff
         zmIqOM4Exg+yC35kJc/CbWitxs1Jwlf8b0gFir7IVIGAw+NwzNTdm6vRSWkSN6E2N485
         zfPyJ5ayjJZah4fSvK52YvVWwVkKI+eln4UIOEUFzGfRv4K9WqPkcX9yjWNvE/5U8QEZ
         583Ys6fm+SYXciIXLl0E463adAKAQ1XUBrEQPzI49bovBGtc7bLO02XyR1P2U28nRhNz
         sl3XwZRJIPvOsbTlfCqQpcqSzz0ebqF5a7ZPXxEWEKk2/sl0soBWMcNPt2+cGXmN3xcH
         EqPQ==
X-Gm-Message-State: AFqh2krdfVAdSvrbZ7RpVmG2zamB9NF4dEtjI3wgQgpXjAkKgVyCa9aW
        eiKB+u5zh6zv1nVEkcQ2gfG+mFrfxh4=
X-Google-Smtp-Source: AMrXdXtoVCHQGLH3n6iOLBMRKWbviJR9XqTx/Sy8r1dXnbWlF2bPaWywbH0+SnQYGCeQdE1qZib8RA==
X-Received: by 2002:a5d:6e09:0:b0:2bb:31da:f3ea with SMTP id h9-20020a5d6e09000000b002bb31daf3eamr1568536wrz.9.1673037410374;
        Fri, 06 Jan 2023 12:36:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7-20020a056000120700b00241dd5de644sm2090717wrx.97.2023.01.06.12.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:36:50 -0800 (PST)
Message-Id: <57c0174d3752fb61a05e0653de9d3057616ed16a.1673037405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Jan 2023 20:36:41 +0000
Subject: [PATCH 4/8] bundle-uri: download in creationToken order
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
 bundle-uri.c                | 140 +++++++++++++++++++++++++++++++++++-
 t/t5558-clone-bundle-uri.sh |  41 ++++++++++-
 t/t5601-clone.sh            |  50 +++++++++++++
 3 files changed, 227 insertions(+), 4 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 63e2cc21057..b30c85ba6f2 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -434,6 +434,124 @@ static int download_bundle_to_file(struct remote_bundle_info *bundle, void *data
 	return 0;
 }
 
+struct sorted_bundle_list {
+	struct remote_bundle_info **items;
+	size_t alloc;
+	size_t nr;
+};
+
+static int insert_bundle(struct remote_bundle_info *bundle, void *data)
+{
+	struct sorted_bundle_list *list = data;
+	list->items[list->nr++] = bundle;
+	return 0;
+}
+
+static int compare_creation_token(const void *va, const void *vb)
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
+	int pop_or_push = 0;
+	struct bundle_list_context ctx = {
+		.r = r,
+		.list = list,
+		.mode = list->mode,
+	};
+	struct sorted_bundle_list sorted = {
+		.alloc = hashmap_get_size(&list->bundles),
+	};
+
+	ALLOC_ARRAY(sorted.items, sorted.alloc);
+
+	for_all_bundles_in_list(list, insert_bundle, &sorted);
+
+	QSORT(sorted.items, sorted.nr, compare_creation_token);
+
+	/*
+	 * Use a stack-based approach to download the bundles and attempt
+	 * to unbundle them in decreasing order by creation token. If we
+	 * fail to unbundle (after a successful download) then move to the
+	 * next non-downloaded bundle (push to the stack) and attempt
+	 * downloading. Once we succeed in applying a bundle, move to the
+	 * previous unapplied bundle (pop the stack) and attempt to unbundle
+	 * it again.
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
+	while (cur >= 0 && cur < sorted.nr) {
+		struct remote_bundle_info *bundle = sorted.items[cur];
+		if (!bundle->file) {
+			/* Not downloaded yet. Try downloading. */
+			if (download_bundle_to_file(bundle, &ctx)) {
+				/* Failure. Push to the stack. */
+				pop_or_push = 1;
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
+				/* Failed to unbundle. Push to stack. */
+				pop_or_push = 1;
+			} else {
+				/* Succeeded in unbundle. Pop stack. */
+				pop_or_push = -1;
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
+		cur += pop_or_push;
+	}
+
+	free(sorted.items);
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
@@ -471,7 +589,14 @@ static int fetch_bundle_list_in_config_format(struct repository *r,
 		goto cleanup;
 	}
 
-	if ((result = download_bundle_list(r, &list_from_bundle,
+	/*
+	 * If this list uses the creationToken heuristic, then the URIs
+	 * it advertises are expected to be bundles, not nested lists.
+	 * We can drop 'global_list' and 'depth'.
+	 */
+	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN)
+		result = fetch_bundles_by_token(r, &list_from_bundle);
+	else if ((result = download_bundle_list(r, &list_from_bundle,
 					   global_list, depth)))
 		goto cleanup;
 
@@ -613,6 +738,14 @@ int fetch_bundle_list(struct repository *r, struct bundle_list *list)
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
@@ -621,7 +754,10 @@ int fetch_bundle_list(struct repository *r, struct bundle_list *list)
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
index 328caeeae9a..d7461ec907e 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -368,6 +368,8 @@ test_expect_success 'clone bundle list (HTTP, any mode)' '
 '
 
 test_expect_success 'clone bundle list (http, creationToken)' '
+	test_when_finished rm -f trace*.txt &&
+
 	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
 	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
 	[bundle]
@@ -392,10 +394,45 @@ test_expect_success 'clone bundle list (http, creationToken)' '
 		creationToken = 4
 	EOF
 
-	git clone --bundle-uri="$HTTPD_URL/bundle-list" . clone-list-http-2 &&
+	GIT_TRACE2_EVENT=$(pwd)/trace-clone.txt \
+	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
+		clone-from clone-list-http-2 &&
 
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
-	git -C clone-list-http-2 cat-file --batch-check <oids
+	git -C clone-list-http-2 cat-file --batch-check <oids &&
+
+	for b in 1 2 3 4
+	do
+		test_bundle_downloaded bundle-$b.bundle trace-clone.txt ||
+			return 1
+	done
+'
+
+test_expect_success 'clone bundle list (http, creationToken)' '
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
+
+	[bundle "bundle-2"]
+		uri = bundle-2.bundle
+		creationToken = 2
+	EOF
+
+	GIT_TRACE2_EVENT=$(pwd)/trace-clone.txt \
+	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
+		clone-from clone-token-http &&
+
+	test_bundle_downloaded bundle-1.bundle trace-clone.txt &&
+	test_bundle_downloaded bundle-2.bundle trace-clone.txt
 '
 
 # Do not add tests here unless they use the HTTP server, as they will
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 1928ea1dd7c..57476b6e6d7 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -831,6 +831,56 @@ test_expect_success 'auto-discover multiple bundles from HTTP clone' '
 	grep -f pattern trace.txt
 '
 
+# Usage: test_bundle_downloaded <bundle-id> <trace-filename>
+test_bundle_downloaded () {
+	cat >pattern <<-EOF &&
+	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/$1.bundle"\]
+	EOF
+	grep -f pattern "$2"
+}
+
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
+	# We should fetch all bundles
+	for b in everything new newest
+	do
+		test_bundle_downloaded $b trace-clone.txt || return 1
+	done
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-- 
gitgitgadget

