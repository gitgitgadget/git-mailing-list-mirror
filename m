Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538C9C54EBD
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 20:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjAFUhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbjAFUg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 15:36:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E465C69
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 12:36:55 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w13so1085465wrk.9
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 12:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t09YYaN+3bG2L5eWzA6YZ5DcQ7O7CDvB75rZF5nKMAg=;
        b=TpJKzU6rE+bbPYkF8z/6iSovApRMCPKhBMIgCTcyErIOg026uITu0J/gWbyqrw5J9Z
         Ze738Dd5/ePWSKn3b/B0p8GhjEq9p2gJN3jgeOqvTBiePzaFUY1wkg2qBU9wNvuXJQaS
         /2PbQ9pyOgfoza6+n10y/O/i2ILnzjLT7EIgHtcTCSiQC9nv8i9sd7lgwJnAKvdheU+p
         JCt4/qQuD1D4znCHoEM8ezKjtQua/8Ioets0V6ypvRxVv44AvWmdEOvTdx4HE2PmlTd2
         9L4jemd788hatj5aoXtYTV+9uxCvj3hQQrKR0klXjZ1Wf71jHSmR/gFqyQ/r2hR9zXCs
         Mkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t09YYaN+3bG2L5eWzA6YZ5DcQ7O7CDvB75rZF5nKMAg=;
        b=32KmevQ9cwCUIzFDKjvBRCXjtok49VtGBOCKL93VRuz47KAJdQQh63U2kg9V1JfhSO
         qDN+LTQpt243R80AqoWsIaAVV7OXBdIvlWacJRyIHovF4wBLcVg7I1uTnYOElxT8a85S
         YnaD+YaxLaOONktBNZ+9ewyJrCNUG9ywbYD01fonhpqbEwdEJjI19Krp218TyWYgHA2C
         Bn7NmmvuZ9awfHTpRYTTHxkWFuRrBRv416bGYpdBze0kAvgKE4ucTNcGAK51XHc3qMgT
         p3+pg6ERtWs/atcToYasrfGKFwnyLF4CVZ1C2qoxPXK8jbtndeSuGDii7cOkJb5ecuGD
         IZpQ==
X-Gm-Message-State: AFqh2kpUUZ++YBFyP+77elvxDOD2ISoIveJXDN9oHwfdoS7meEtEn2CJ
        gcftEsrLos1teLjCcDzvwOmmVbWu+9U=
X-Google-Smtp-Source: AMrXdXtbWZHTeemlQEMs6JF6JoZwLXC1BycOLHUAEf/H6zDOnKcxndiFrsYiPMfGwcvODIuG02AFUA==
X-Received: by 2002:a5d:56c1:0:b0:288:d139:3690 with SMTP id m1-20020a5d56c1000000b00288d1393690mr21767085wrw.67.1673037413444;
        Fri, 06 Jan 2023 12:36:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11-20020adf9dcb000000b00268aae5fb5bsm2133957wre.3.2023.01.06.12.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:36:53 -0800 (PST)
Message-Id: <51f210ddeb46fb06e885dc384a486c4bb16ad8cd.1673037405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Jan 2023 20:36:45 +0000
Subject: [PATCH 8/8] bundle-uri: store fetch.bundleCreationToken
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
have a use for that bundle if its creationToken value is the at most the
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
 Documentation/config/fetch.txt |  8 ++++++++
 bundle-uri.c                   | 35 ++++++++++++++++++++++++++++++++--
 t/t5558-clone-bundle-uri.sh    | 25 +++++++++++++++++++++++-
 3 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index 4f796218aab..96755ba148b 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -104,3 +104,11 @@ fetch.bundleURI::
 	first running `git fetch --bundle-uri=<uri>` immediately before
 	`git fetch <args>`. See details of the `--bundle-uri` option in
 	linkgit:git-fetch[1].
+
+fetch.bundleCreationToken::
+	When using `fetch.bundleURI` to fetch incrementally from a bundle
+	list that uses the "creationToken" heuristic, this config value
+	stores the maximum `creationToken` value of the downloaded bundles.
+	This value is used to prevent downloading bundles in the future
+	if the advertised `creationToken` is not strictly larger than this
+	value.
diff --git a/bundle-uri.c b/bundle-uri.c
index 1dbbbb980eb..98655bd6721 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -464,6 +464,8 @@ static int fetch_bundles_by_token(struct repository *r,
 {
 	int cur;
 	int pop_or_push = 0;
+	const char *creationTokenStr;
+	uint64_t maxCreationToken;
 	struct bundle_list_context ctx = {
 		.r = r,
 		.list = list,
@@ -477,8 +479,27 @@ static int fetch_bundles_by_token(struct repository *r,
 
 	for_all_bundles_in_list(list, insert_bundle, &sorted);
 
+	if (!sorted.nr) {
+		free(sorted.items);
+		return 0;
+	}
+
 	QSORT(sorted.items, sorted.nr, compare_creation_token);
 
+	/*
+	 * If fetch.bundleCreationToken exists, parses to a uint64t, and
+	 * is not strictly smaller than the maximum creation token in the
+	 * bundle list, then do not download any bundles.
+	 */
+	if (!repo_config_get_value(r,
+				   "fetch.bundlecreationtoken",
+				   &creationTokenStr) &&
+	    sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) == 1 &&
+	    sorted.items[0]->creationToken <= maxCreationToken) {
+		free(sorted.items);
+		return 0;
+	}
+
 	/*
 	 * Use a stack-based approach to download the bundles and attempt
 	 * to unbundle them in decreasing order by creation token. If we
@@ -541,14 +562,24 @@ stack_operation:
 		cur += pop_or_push;
 	}
 
-	free(sorted.items);
-
 	/*
 	 * We succeed if the loop terminates because 'cur' drops below
 	 * zero. The other case is that we terminate because 'cur'
 	 * reaches the end of the list, so we have a failure no matter
 	 * which bundles we apply from the list.
 	 */
+	if (cur < 0) {
+		struct strbuf value = STRBUF_INIT;
+		strbuf_addf(&value, "%"PRIu64"", sorted.items[0]->creationToken);
+		if (repo_config_set_multivar_gently(ctx.r,
+						    "fetch.bundleCreationToken",
+						    value.buf, NULL, 0))
+			warning(_("failed to store maximum creation token"));
+
+		strbuf_release(&value);
+	}
+
+	free(sorted.items);
 	return cur >= 0;
 }
 
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 3f4d61a915c..0604d721f1b 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -455,6 +455,7 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 		"$HTTPD_URL/smart/fetch.git" fetch-http-4 &&
 
 	test_cmp_config -C fetch-http-4 "$HTTPD_URL/bundle-list" fetch.bundleuri &&
+	test_cmp_config -C fetch-http-4 1 fetch.bundlecreationtoken &&
 
 	# The clone should copy two files: the list and bundle-1.
 	test_bundle_downloaded bundle-list trace-clone.txt &&
@@ -479,6 +480,8 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 		refs/heads/left:refs/heads/left \
 		refs/heads/right:refs/heads/right &&
 
+	test_cmp_config -C fetch-http-4 2 fetch.bundlecreationtoken &&
+
 	# This fetch should copy two files: the list and bundle-2.
 	test_bundle_downloaded bundle-list trace1.txt &&
 	test_bundle_downloaded bundle-2.bundle trace1.txt &&
@@ -492,6 +495,15 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 	EOF
 	test_cmp expect refs &&
 
+	# No-op fetch
+	GIT_TRACE2_EVENT="$(pwd)/trace1b.txt" \
+		git -C fetch-http-4 fetch origin --no-tags \
+		refs/heads/left:refs/heads/left \
+		refs/heads/right:refs/heads/right &&
+	test_bundle_downloaded bundle-list trace1b.txt &&
+	! test_bundle_downloaded bundle-1.bundle trace1b.txt &&
+	! test_bundle_downloaded bundle-2.bundle trace1b.txt &&
+
 	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
 	[bundle "bundle-3"]
 		uri = bundle-3.bundle
@@ -508,6 +520,8 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 		git -C fetch-http-4 fetch origin --no-tags \
 		refs/heads/merge:refs/heads/merge &&
 
+	test_cmp_config -C fetch-http-4 4 fetch.bundlecreationtoken &&
+
 	# This fetch should copy three files: the list, bundle-3, and bundle-4.
 	test_bundle_downloaded bundle-list trace2.txt &&
 	test_bundle_downloaded bundle-4.bundle trace2.txt &&
@@ -524,7 +538,16 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 	refs/bundles/left
 	refs/bundles/merge
 	EOF
-	test_cmp expect refs
+	test_cmp expect refs &&
+
+	# No-op fetch
+	GIT_TRACE2_EVENT="$(pwd)/trace2b.txt" \
+		git -C fetch-http-4 fetch origin &&
+	test_bundle_downloaded bundle-list trace2b.txt &&
+	! test_bundle_downloaded bundle-1.bundle trace2b.txt &&
+	! test_bundle_downloaded bundle-2.bundle trace2b.txt &&
+	! test_bundle_downloaded bundle-3.bundle trace2b.txt &&
+	! test_bundle_downloaded bundle-4.bundle trace2b.txt
 '
 
 # Do not add tests here unless they use the HTTP server, as they will
-- 
gitgitgadget
