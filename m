Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7268C54E94
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjAWPXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjAWPWr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:22:47 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F72A16C
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:04 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g10so9303457wmo.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvZ0O/bBZenXrlPhO3RM5S4lF2nqmNMOi1HZFOAXj0E=;
        b=DI7qGFgjU2RVZ2H8f53B6PCVy7Ujk7rHJrpZkJzohzAw15JweGkfOeA0ucsckRzZ70
         h4sA5WeDyTEskuhbrqQq3x81GB4F2tVFcMI/h2hQrSsHpaW4tSrB3qmZEVfq/NpKEeYH
         kyQqk6C/XkhyJEUUDnhy+xkKqfdnw49Ml7YqLIfGZQCsAhJDXP6rMQQiFyquVdTYJYc3
         2Ahw8FQHvr/em1KDiBlzWjUanohbwMmNC0AgSULf27Ub5sVlyYrH6pUqYlQ6CucvXyyo
         mIXiGsVEgxEsh1EgUDp+3odAArS4XwkE/qRhxgTPZb3PDMPt4gHx13mSWlY11RhmSf7x
         Xq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvZ0O/bBZenXrlPhO3RM5S4lF2nqmNMOi1HZFOAXj0E=;
        b=G/Hns8DEFga8RMsZPkAEFfMPkzh48EnmV3DUZg9wV6OZOrKn2m9YRxX7HG+D9voCF9
         pAsSLoXzpkgq43OhpmfQNlIoIdY+wBChdMIFkl7T/KdstTQy8GWWlbp4w+H9eXdhTeIy
         acwjKJ/PPLoVCbmMg6j/9SPyRmlBfBsUTCab8u/6tyS+bpgibuEZlYjwi4PaIPTWfIK7
         vvtCrJOShiHTGnLDzEZo0MpIc/AypOwyCrJrcE2FjkCzmTv2KiYUUnEfvfutoC38Co8I
         q1DRVocHn8C00bjaY1rWwegbHT6/htY/iKrzWt9a9v70KWen09IrcZwOsd3mT5XBL9jS
         hYlQ==
X-Gm-Message-State: AFqh2krctK+NePVZq6JXJm4X2w1Oc3rcpNRnQE23IycmR3sBWAazseot
        fLJVHt7exanBMBCAZPgHWkO2gV4UZuM=
X-Google-Smtp-Source: AMrXdXs+eeUbNoq1oKL13wyZWiZcXlgV3vY8S4SOet6u36cdyDN10q2afWpLHLveCE7yV2hzrcWc/A==
X-Received: by 2002:a05:600c:3b02:b0:3da:1bb0:4d71 with SMTP id m2-20020a05600c3b0200b003da1bb04d71mr32449632wms.11.1674487319327;
        Mon, 23 Jan 2023 07:21:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003db12112fcfsm12367626wms.4.2023.01.23.07.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:21:58 -0800 (PST)
Message-Id: <59e57e049683e42248c270b3bfcad2d72769219d.1674487310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 15:21:48 +0000
Subject: [PATCH v2 08/10] fetch: fetch from an external bundle URI
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
 builtin/fetch.c             |   7 +++
 t/t5558-clone-bundle-uri.sh | 113 +++++++++++++++++++++++++++++++++++-
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7378cafeec9..f101e454dc9 100644
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
@@ -2194,6 +2196,11 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (dry_run)
 		write_fetch_head = 0;
 
+	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri)) {
+		if (fetch_bundle_uri(the_repository, bundle_uri, NULL))
+			warning(_("failed to fetch bundles from '%s'"), bundle_uri);
+	}
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

