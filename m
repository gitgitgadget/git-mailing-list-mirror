Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5390CC636D4
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 13:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjAaNaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjAaN3j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 08:29:39 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0FE4DCE0
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:31 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n13so3330085wmr.4
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji80PUlPvKQbAIOn0OsU1g9u7Sp2n3XxcsOBLiRJA50=;
        b=KjPNiBaUyMIcCjaqZ91MAL2z9VGYxq8ZB2XCKdb7g6NSsE6eWXEkOXfDsubWzoI0eq
         WhJJL6kZjrHOoddEOr6/q9RtqZxDIpbIp7odqxjPuv+hbwk/CzVYKdcsNNPUGE9LccWL
         MNJEj+LFvZ+nOKQCSlC7GM+atloX6baN/FHkYpPVmr3tUDi3QqsEoAIS8RZJ09yM1ZkB
         uGa76qftBrmmJyu0sOZ0ZrliF+wfc7inw5OKa5hhGm4NW6QYp/xoeybEjjoJLLcSPwYS
         Mc7FRfUcTNJPPk3A0fzMJzyQYITcYN0jN9Y8T/Efc8yydsSwAR+Mn2dglRyIWYNznziF
         PTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji80PUlPvKQbAIOn0OsU1g9u7Sp2n3XxcsOBLiRJA50=;
        b=EUKsDNLYt2zktGC10PIbhuUD1j4c2iks5zmIq4oWo3NVt7nm3AJ/l9ify0k9xO0ztm
         YYDIMZ/g5ZmvGDF/g+0JF3V/LWRhtf50cEw+nHTs19lK1afCb7sySo4cZiDtBZNjjtIT
         ibk4f2Dvk2valPt8I7dHEGy9jyxEDYxbiQRQ/bnqKEShzQRhZSpGnqLyj2EG61mb6Zyj
         sqfQB0Oy6Ctu697qswW0b6zDQ3+MF97qqyzDa3uTke412DxLRQcI8rfwvfaFStGnq8Us
         0X+Oogl4hZ8nolFwJzvJgh4Iqaa+ImBxvbNfgB8JTdzyxxTiBr8/P3JuI4NpNNM1Uujl
         aUew==
X-Gm-Message-State: AO0yUKUEs321tZJKvfxA8NYaTLM8JlS0omsmggGdgqIdypwehUcs6wjn
        H1/WNIUfeJNprAFMvO3nd85X2WHWtRI=
X-Google-Smtp-Source: AK7set+qu0nccDBqiD41AbpS3TibvCPfqA3DRrCvP3swpbJRKH8C05wvJkPzNUQvqddk84L89GISsA==
X-Received: by 2002:a05:600c:1c9c:b0:3de:d9f:3025 with SMTP id k28-20020a05600c1c9c00b003de0d9f3025mr79021wms.0.1675171769975;
        Tue, 31 Jan 2023 05:29:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iz16-20020a05600c555000b003dd1aa227afsm3385663wmb.31.2023.01.31.05.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:29:29 -0800 (PST)
Message-Id: <4e0465efd19798e7a14d653440233b9b3319b6de.1675171760.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 13:29:18 +0000
Subject: [PATCH v3 10/11] bundle-uri: store fetch.bundleCreationToken
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

When a bundle list specifies the "creationToken" heuristic, the Git
client downloads the list and then starts downloading bundles in
descending creationToken order. This process stops as soon as all
downloaded bundles can be applied to the repository (because all
required commits are present in the repository or in the downloaded
bundles).

When checking the same bundle list twice, this strategy requires
downloading the bundle with the maximum creationToken again, which is
wasteful. The creationToken heuristic promises that the client will not
have a use for that bundle if its creationToken value is at most the
previous creationToken value.

To prevent these wasteful downloads, create a fetch.bundleCreationToken
config setting that the Git client sets after downloading bundles. This
value allows skipping that maximum bundle download when this config
value is the same value (or larger).

To test that this works correctly, we can insert some "duplicate"
fetches into existing tests and demonstrate that only the bundle list is
downloaded.

The previous logic for downloading bundles by creationToken worked even
if the bundle list was empty, but now we have logic that depends on the
first entry of the list. Terminate early in the (non-sensical) case of
an empty bundle list.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/fetch.txt | 16 ++++++++++++
 bundle-uri.c                   | 48 ++++++++++++++++++++++++++++++++--
 t/t5558-clone-bundle-uri.sh    | 29 +++++++++++++++++++-
 3 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index 244f44d460f..568f0f75b30 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -104,3 +104,19 @@ fetch.bundleURI::
 	linkgit:git-clone[1]. `git clone --bundle-uri` will set the
 	`fetch.bundleURI` value if the supplied bundle URI contains a bundle
 	list that is organized for incremental fetches.
++
+If you modify this value and your repository has a `fetch.bundleCreationToken`
+value, then remove that `fetch.bundleCreationToken` value before fetching from
+the new bundle URI.
+
+fetch.bundleCreationToken::
+	When using `fetch.bundleURI` to fetch incrementally from a bundle
+	list that uses the "creationToken" heuristic, this config value
+	stores the maximum `creationToken` value of the downloaded bundles.
+	This value is used to prevent downloading bundles in the future
+	if the advertised `creationToken` is not strictly larger than this
+	value.
++
+The creation token values are chosen by the provider serving the specific
+bundle URI. If you modify the URI at `fetch.bundleURI`, then be sure to
+remove the value for the `fetch.bundleCreationToken` value before fetching.
diff --git a/bundle-uri.c b/bundle-uri.c
index 7a1b6d94bf5..d6f7df7350f 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -481,6 +481,8 @@ static int fetch_bundles_by_token(struct repository *r,
 {
 	int cur;
 	int move_direction = 0;
+	const char *creationTokenStr;
+	uint64_t maxCreationToken = 0, newMaxCreationToken = 0;
 	struct bundle_list_context ctx = {
 		.r = r,
 		.list = list,
@@ -494,8 +496,27 @@ static int fetch_bundles_by_token(struct repository *r,
 
 	for_all_bundles_in_list(list, append_bundle, &bundles);
 
+	if (!bundles.nr) {
+		free(bundles.items);
+		return 0;
+	}
+
 	QSORT(bundles.items, bundles.nr, compare_creation_token_decreasing);
 
+	/*
+	 * If fetch.bundleCreationToken exists, parses to a uint64t, and
+	 * is not strictly smaller than the maximum creation token in the
+	 * bundle list, then do not download any bundles.
+	 */
+	if (!repo_config_get_value(r,
+				   "fetch.bundlecreationtoken",
+				   &creationTokenStr) &&
+	    sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) == 1 &&
+	    bundles.items[0]->creationToken <= maxCreationToken) {
+		free(bundles.items);
+		return 0;
+	}
+
 	/*
 	 * Attempt to download and unbundle the minimum number of bundles by
 	 * creationToken in decreasing order. If we fail to unbundle (after
@@ -516,6 +537,16 @@ static int fetch_bundles_by_token(struct repository *r,
 	cur = 0;
 	while (cur >= 0 && cur < bundles.nr) {
 		struct remote_bundle_info *bundle = bundles.items[cur];
+
+		/*
+		 * If we need to dig into bundles below the previous
+		 * creation token value, then likely we are in an erroneous
+		 * state due to missing or invalid bundles. Halt the process
+		 * instead of continuing to download extra data.
+		 */
+		if (bundle->creationToken <= maxCreationToken)
+			break;
+
 		if (!bundle->file) {
 			/*
 			 * Not downloaded yet. Try downloading.
@@ -555,6 +586,9 @@ static int fetch_bundles_by_token(struct repository *r,
 				 */
 				move_direction = -1;
 				bundle->unbundled = 1;
+
+				if (bundle->creationToken > newMaxCreationToken)
+					newMaxCreationToken = bundle->creationToken;
 			}
 		}
 
@@ -569,14 +603,24 @@ move:
 		cur += move_direction;
 	}
 
-	free(bundles.items);
-
 	/*
 	 * We succeed if the loop terminates because 'cur' drops below
 	 * zero. The other case is that we terminate because 'cur'
 	 * reaches the end of the list, so we have a failure no matter
 	 * which bundles we apply from the list.
 	 */
+	if (cur < 0) {
+		struct strbuf value = STRBUF_INIT;
+		strbuf_addf(&value, "%"PRIu64"", newMaxCreationToken);
+		if (repo_config_set_multivar_gently(ctx.r,
+						    "fetch.bundleCreationToken",
+						    value.buf, NULL, 0))
+			warning(_("failed to store maximum creation token"));
+
+		strbuf_release(&value);
+	}
+
+	free(bundles.items);
 	return cur >= 0;
 }
 
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 7deeb4b8ad1..9c2b7934b9b 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -433,6 +433,7 @@ test_expect_success 'clone incomplete bundle list (http, creationToken)' '
 		"$HTTPD_URL/smart/fetch.git" clone-token-http &&
 
 	test_cmp_config -C clone-token-http "$HTTPD_URL/bundle-list" fetch.bundleuri &&
+	test_cmp_config -C clone-token-http 1 fetch.bundlecreationtoken &&
 
 	cat >expect <<-EOF &&
 	$HTTPD_URL/bundle-list
@@ -468,6 +469,7 @@ test_expect_success 'clone incomplete bundle list (http, creationToken)' '
 	GIT_TRACE2_EVENT="$(pwd)/trace1.txt" \
 		git -C clone-token-http fetch origin --no-tags \
 		refs/heads/merge:refs/heads/merge &&
+	test_cmp_config -C clone-token-http 4 fetch.bundlecreationtoken &&
 
 	cat >expect <<-EOF &&
 	$HTTPD_URL/bundle-list
@@ -511,6 +513,7 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 		"$HTTPD_URL/smart/fetch.git" fetch-http-4 &&
 
 	test_cmp_config -C fetch-http-4 "$HTTPD_URL/bundle-list" fetch.bundleuri &&
+	test_cmp_config -C fetch-http-4 1 fetch.bundlecreationtoken &&
 
 	cat >expect <<-EOF &&
 	$HTTPD_URL/bundle-list
@@ -538,6 +541,7 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 		git -C fetch-http-4 fetch origin --no-tags \
 		refs/heads/left:refs/heads/left \
 		refs/heads/right:refs/heads/right &&
+	test_cmp_config -C fetch-http-4 2 fetch.bundlecreationtoken &&
 
 	cat >expect <<-EOF &&
 	$HTTPD_URL/bundle-list
@@ -555,6 +559,18 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 	EOF
 	test_cmp expect refs &&
 
+	# No-op fetch
+	GIT_TRACE2_EVENT="$(pwd)/trace1b.txt" \
+		git -C fetch-http-4 fetch origin --no-tags \
+		refs/heads/left:refs/heads/left \
+		refs/heads/right:refs/heads/right &&
+
+	cat >expect <<-EOF &&
+	$HTTPD_URL/bundle-list
+	EOF
+	test_remote_https_urls <trace1b.txt >actual &&
+	test_cmp expect actual &&
+
 	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
 	[bundle "bundle-3"]
 		uri = bundle-3.bundle
@@ -570,6 +586,7 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
 		git -C fetch-http-4 fetch origin --no-tags \
 		refs/heads/merge:refs/heads/merge &&
+	test_cmp_config -C fetch-http-4 4 fetch.bundlecreationtoken &&
 
 	cat >expect <<-EOF &&
 	$HTTPD_URL/bundle-list
@@ -588,7 +605,17 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 	refs/bundles/left
 	refs/bundles/merge
 	EOF
-	test_cmp expect refs
+	test_cmp expect refs &&
+
+	# No-op fetch
+	GIT_TRACE2_EVENT="$(pwd)/trace2b.txt" \
+		git -C fetch-http-4 fetch origin &&
+
+	cat >expect <<-EOF &&
+	$HTTPD_URL/bundle-list
+	EOF
+	test_remote_https_urls <trace2b.txt >actual &&
+	test_cmp expect actual
 '
 
 # Do not add tests here unless they use the HTTP server, as they will
-- 
gitgitgadget

