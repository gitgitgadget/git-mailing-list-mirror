Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12E9C38142
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjAWPXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjAWPWd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:22:33 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CEC2A169
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:04 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso8831440wms.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfnOow34r53R8ZEx76D1TLBXZKqDDbz6TSPtoa9Dcf8=;
        b=BTj13uRnuveZKAHLsUnmMvKXqdpxVvYP8avC5qBLFHFO5j4GJqvE3FNGcgFbF1mZkm
         jJVcn2S52oHxS/UpEQMK+fox99URPV5qLlq9UAv+BUd5peGwiL5/H+e4J+864hLHIySf
         SdVOxHDyZNSwUP20kksA3TRnbSk0LFJ0SWNUCJMet5R5IPNhcITJKNXtWcrdZD/GtsQ8
         CLsJGg69w8BCbFZiNJCwhc+Y1Ij77KoXibWLKj+GmNFkYCjcEHxmnT0rkk7vxKhSFJOc
         4MDVj60ADNkfIz+bCmMl32DaweuuH9VmVhxds/YPh212lxrt3UhKFU3UBP4nHICn9Mxh
         gbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfnOow34r53R8ZEx76D1TLBXZKqDDbz6TSPtoa9Dcf8=;
        b=PXJ1UivzW3xmGryFJp3wfRhCr64Qao4sziwSdGVrAJirCs2DrHoVljA+SgZQraY2hn
         DtLfmn2hPNZEGG8VTE6fmftk5JtmyoIn66BbxXkR/ep/ga6gpbniM75gBKqnbVkVahqR
         2xP2DsaPidzJBgJHJTES4RvFNn3En/uGowU/lFX7tILIIoTD2HIldkCW3pa3yH2Ukv65
         ct8y/knYcutY84lhAldBy7JpM/FuF3y4UydvQ2jtP8rS8bJk90HF6Kr5Y5qqrUXo1L9U
         0JvNF0TLTChQqDLGCTvtdttWGQgxufZQgDsx4ooJ4QylqzqfvCneBgc6IiMgZWT4rRCM
         DGcg==
X-Gm-Message-State: AFqh2kr1wAiOvq6+mo0raN1A/CDADoz/5Zh27AcERJq+BQjo2Wblzn+Z
        I6kqtdNE8M74eVYoyP8fE6N9xkReojc=
X-Google-Smtp-Source: AMrXdXs6uuMkWwO2gYBN5kE+RzZMjxgOzmbvzEt9yHkG9oRlX0bRhlZwQbC6aAcqf2VoK/84vI7c8Q==
X-Received: by 2002:a05:600c:1d8e:b0:3d1:fcb4:4074 with SMTP id p14-20020a05600c1d8e00b003d1fcb44074mr25307300wms.22.1674487320140;
        Mon, 23 Jan 2023 07:22:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003db01178b62sm12365005wmp.40.2023.01.23.07.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:21:59 -0800 (PST)
Message-Id: <6a1504b1c3a24b45d48c093285dfcc9a3d6afd68.1674487310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 15:21:49 +0000
Subject: [PATCH v2 09/10] bundle-uri: store fetch.bundleCreationToken
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
index 162a9276f31..691853b2c56 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -487,6 +487,8 @@ static int fetch_bundles_by_token(struct repository *r,
 {
 	int cur;
 	int move_direction = 0;
+	const char *creationTokenStr;
+	uint64_t maxCreationToken = 0, newMaxCreationToken = 0;
 	struct bundle_list_context ctx = {
 		.r = r,
 		.list = list,
@@ -500,8 +502,27 @@ static int fetch_bundles_by_token(struct repository *r,
 
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
@@ -522,6 +543,16 @@ static int fetch_bundles_by_token(struct repository *r,
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
@@ -561,6 +592,9 @@ static int fetch_bundles_by_token(struct repository *r,
 				 */
 				move_direction = -1;
 				bundle->unbundled = 1;
+
+				if (bundle->creationToken > newMaxCreationToken)
+					newMaxCreationToken = bundle->creationToken;
 			}
 		}
 
@@ -575,14 +609,24 @@ stack_operation:
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

