Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB10C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 13:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjAaNaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAaN3j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 08:29:39 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E34FAF6
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:31 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t7so5848730wrp.5
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m2umidPNl80fZh/ciSYwAKmAA9i57f7nRwRJBm5MTw=;
        b=goxExLHGtTZpa3yblohuCqd1Va6yHyWZJ4/X//1PuEXDVbRMNJhjL5Gud2SDRVJz+6
         LrNn/Srj1w73GzRimSEEfdR26zKOWnMyIeuRofGkUUKrDx4DKWWz5xDCu0n6HuywDw5R
         EVF4O/jcmpVWwFOPE8uA4KpJjfWHdv1P6rNTA2DRlItXj/inLZZl5u5jPCvD0F1jSMx7
         W017E9BExzP27YzvnS1BCNRY5GMmltGafnO5ffQSXPjuBAzBBdH3/QudfMCKsG8MPX/Z
         eaBR5V9Jo+ILca9Mep2FYOhELtolr3+aSq+tDRkXWWc4ZWUVyZLrEwLgnYXqMbhW8sxT
         4+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6m2umidPNl80fZh/ciSYwAKmAA9i57f7nRwRJBm5MTw=;
        b=lc4Vqgc4ldnG8rxP6m9LrVVHrEic+Yg0Ob7FQRmWjQDE/z1U+C8xI9vD1MvPmnfkRM
         He1RNin0Q89ETBPuLSGkYfVkXw2TVsHeb0a1kTz3zMsHsj2IpLLmIS7l+/ttQYAAT2IC
         K1Q5UzG3rQcayaU79DcfektfgAs+hn5dXHoknW208zPZIM7kD32SuFMWOyzNbtm2Bnx8
         rJ5eNjta40m256SleMplRsA1r8XKIGVJkXsSEnszmKGek2W8KYu7PHdPON90DgRBTFLA
         Bou2QYdka/Qb1m/RQAQImAmAcyOq4BIuiZUHiyZBWd86eUQWosQZgyORwyR2hU/eH9ef
         1Lrg==
X-Gm-Message-State: AO0yUKUY+1ByWJp7Dqtevavpbs3FZonICvvNSW7JwF5vTSOL/vzh8OP7
        g5TzwQcXth3pqqL9q2hmyKWUz8nAGS0=
X-Google-Smtp-Source: AK7set/OR1F4vt60bXk1KLguQN90G8U6PghPP2vv9JzkHUMKt2SroNPzyZNGuYNofKwYo6QZKYYL/Q==
X-Received: by 2002:adf:fe4e:0:b0:2bf:be8b:32e with SMTP id m14-20020adffe4e000000b002bfbe8b032emr19256633wrs.17.1675171769197;
        Tue, 31 Jan 2023 05:29:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d67c9000000b00294176c2c01sm14683084wrw.86.2023.01.31.05.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:29:28 -0800 (PST)
Message-Id: <314c60f2ae4cf54a0d99cc4e6d8c4edd77fd6b22.1675171760.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 13:29:17 +0000
Subject: [PATCH v3 09/11] fetch: fetch from an external bundle URI
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

When a user specifies a URI via 'git clone --bundle-uri', that URI may
be a bundle list that advertises a 'bundle.heuristic' value. In that
case, the Git client stores a 'fetch.bundleURI' config value storing
that URI.

Teach 'git fetch' to check for this config value and download bundles
from that URI before fetching from the Git remote(s). Likely, the bundle
provider has configured a heuristic (such as "creationToken") that will
allow the Git client to download only a portion of the bundles before
continuing the fetch.

Since this URI is completely independent of the remote server, we want
to be sure that we connect to the bundle URI before creating a
connection to the Git remote. We do not want to hold a stateful
connection for too long if we can avoid it.

To test that this works correctly, extend the previous tests that set
'fetch.bundleURI' to do follow-up fetches. The bundle list is updated
incrementally at each phase to demonstrate that the heuristic avoids
downloading older bundles. This includes the middle fetch downloading
the objects in bundle-3.bundle from the Git remote, and therefore not
needing that bundle in the third fetch.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/fetch.c             |   6 ++
 t/t5558-clone-bundle-uri.sh | 113 +++++++++++++++++++++++++++++++++++-
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7378cafeec9..0477c379369 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -29,6 +29,7 @@
 #include "commit-graph.h"
 #include "shallow.h"
 #include "worktree.h"
+#include "bundle-uri.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
@@ -2109,6 +2110,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	int i;
+	const char *bundle_uri;
 	struct string_list list = STRING_LIST_INIT_DUP;
 	struct remote *remote = NULL;
 	int result = 0;
@@ -2194,6 +2196,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (dry_run)
 		write_fetch_head = 0;
 
+	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri) &&
+	    fetch_bundle_uri(the_repository, bundle_uri, NULL))
+		warning(_("failed to fetch bundles from '%s'"), bundle_uri);
+
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index b2d15e141ca..7deeb4b8ad1 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -440,7 +440,55 @@ test_expect_success 'clone incomplete bundle list (http, creationToken)' '
 	EOF
 
 	test_remote_https_urls <trace-clone.txt >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	# We now have only one bundle ref.
+	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	EOF
+	test_cmp expect refs &&
+
+	# Add remaining bundles, exercising the "deepening" strategy
+	# for downloading via the creationToken heurisitc.
+	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle "bundle-2"]
+		uri = bundle-2.bundle
+		creationToken = 2
+
+	[bundle "bundle-3"]
+		uri = bundle-3.bundle
+		creationToken = 3
+
+	[bundle "bundle-4"]
+		uri = bundle-4.bundle
+		creationToken = 4
+	EOF
+
+	GIT_TRACE2_EVENT="$(pwd)/trace1.txt" \
+		git -C clone-token-http fetch origin --no-tags \
+		refs/heads/merge:refs/heads/merge &&
+
+	cat >expect <<-EOF &&
+	$HTTPD_URL/bundle-list
+	$HTTPD_URL/bundle-4.bundle
+	$HTTPD_URL/bundle-3.bundle
+	$HTTPD_URL/bundle-2.bundle
+	EOF
+
+	test_remote_https_urls <trace1.txt >actual &&
+	test_cmp expect actual &&
+
+	# We now have all bundle refs.
+	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	refs/bundles/merge
+	refs/bundles/right
+	EOF
+	test_cmp expect refs
 '
 
 test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
@@ -477,6 +525,69 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 	cat >expect <<-\EOF &&
 	refs/bundles/base
 	EOF
+	test_cmp expect refs &&
+
+	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle "bundle-2"]
+		uri = bundle-2.bundle
+		creationToken = 2
+	EOF
+
+	# Fetch the objects for bundle-2 _and_ bundle-3.
+	GIT_TRACE2_EVENT="$(pwd)/trace1.txt" \
+		git -C fetch-http-4 fetch origin --no-tags \
+		refs/heads/left:refs/heads/left \
+		refs/heads/right:refs/heads/right &&
+
+	cat >expect <<-EOF &&
+	$HTTPD_URL/bundle-list
+	$HTTPD_URL/bundle-2.bundle
+	EOF
+
+	test_remote_https_urls <trace1.txt >actual &&
+	test_cmp expect actual &&
+
+	# received left from bundle-2
+	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect refs &&
+
+	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle "bundle-3"]
+		uri = bundle-3.bundle
+		creationToken = 3
+
+	[bundle "bundle-4"]
+		uri = bundle-4.bundle
+		creationToken = 4
+	EOF
+
+	# This fetch should skip bundle-3.bundle, since its objects are
+	# already local (we have the requisite commits for bundle-4.bundle).
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		git -C fetch-http-4 fetch origin --no-tags \
+		refs/heads/merge:refs/heads/merge &&
+
+	cat >expect <<-EOF &&
+	$HTTPD_URL/bundle-list
+	$HTTPD_URL/bundle-4.bundle
+	EOF
+
+	test_remote_https_urls <trace2.txt >actual &&
+	test_cmp expect actual &&
+
+	# received merge ref from bundle-4, but right is missing
+	# because we did not download bundle-3.
+	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	refs/bundles/merge
+	EOF
 	test_cmp expect refs
 '
 
-- 
gitgitgadget

