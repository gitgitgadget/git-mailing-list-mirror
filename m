Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590DAC54E94
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjAWPWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjAWPW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:22:27 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EA529414
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t5so11168302wrq.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNgYHe2+hAaU8wbxFrTySxoshKCEj59J0s/xFDZd5wE=;
        b=bHbsldQ09pXgkv9dti/WWsXfcUZkj6ZMocSZJffaimIqdQWlcUh4MRWRaAiyKNllPJ
         9DaR33XW2zbtyXPQkmWdDZZVwduVD+zdCVh8TfBFgsVYreww/5K6kVw4UAwsdpCBNM25
         GrwD6WOrFrZort7/RIjy9Kj6wTur9gZaoMhKbu9TpQsEYI8jP21hHnMvBoY6Nxl8L737
         v6VC6C2a/CIOhfCCeJIpO8EpUjoE/OTzQW3CIYpL7nbMPxBRA/7k/naYgxk9b7cNb1qg
         5cepX+nMDaehAWs0c08HBQ92BCIqb7ve6RBgUFMcdVb3YujcMQQDiFZnBzWJdZhcCSlK
         Jo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNgYHe2+hAaU8wbxFrTySxoshKCEj59J0s/xFDZd5wE=;
        b=wQWYsBmL3uE0XTauaxjmEKdW3fkDOU7EmBOqEzgQAeeY0ZFesLD7qOaYDb83LAAtnx
         Y2bacx+rp4dLYPU9ExPmTD3hzj6iZ3TgfV4hFpehWkimvdf7thQhmUgadJPkl4GKreEx
         WKl6jyhDjF/2DdGzOIbIbTom+XXrzaXNvzC54dXuzK0sPJvQlGZtF434rLj8XvSCJPoG
         7AO/V+wW5tQOQYpwUv2n8+GflxLrBwFLLV0ZTX8UlUyIt0HmWufFqDZBjqy02GKsRQHs
         TdudtkBMoAABnGHJ4254XtHoX/EAxf100v1s/xJiyMF9/8hxUSMcbGHDPmDzDC9JWfl5
         47vg==
X-Gm-Message-State: AFqh2kq2rj0Y+SjkNyGL5vswRyV3vhc9FlhjXzDWltyzmn+9BtQIWegf
        hP9mUgJqq+yLKIJRC9BiAZeOYkHFw+Q=
X-Google-Smtp-Source: AMrXdXsXKOJ06Fgr73c+N9AesgwoD9XGIGYz44JUAvkR13cTzK57EtxQ/ktV/FhhA7ca/icE0mFM2w==
X-Received: by 2002:adf:f992:0:b0:2bd:fdce:f206 with SMTP id f18-20020adff992000000b002bdfdcef206mr20856060wrr.2.1674487314251;
        Mon, 23 Jan 2023 07:21:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7-20020adfd4c7000000b002baa780f0fasm4909811wrk.111.2023.01.23.07.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:21:53 -0800 (PST)
Message-Id: <427aff4d5e5c85b601f43af8b664515380e11453.1674487310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 15:21:42 +0000
Subject: [PATCH v2 02/10] t5558: add tests for creationToken heuristic
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

As documented in the bundle URI design doc in 2da14fad8fe (docs:
document bundle URI standard, 2022-08-09), the 'creationToken' member of
a bundle URI allows a bundle provider to specify a total order on the
bundles.

Future changes will allow the Git client to understand these members and
modify its behavior around downloading the bundles in that order. In the
meantime, create tests that add creation tokens to the bundle list. For
now, the Git client correctly ignores these unknown keys.

Create a new test helper function, test_remote_https_urls, which filters
GIT_TRACE2_EVENT output to extract a list of URLs passed to
git-remote-https child processes. This can be used to verify the order
of these requests as we implement the creationToken heuristic. For now,
we need to sort the actual output since the current client does not have
a well-defined order that it applies to the bundles.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t5558-clone-bundle-uri.sh | 69 +++++++++++++++++++++++++++++++++++--
 t/test-lib-functions.sh     |  8 +++++
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 9155f31fa2c..474432c8ace 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -285,6 +285,8 @@ test_expect_success 'clone HTTP bundle' '
 '
 
 test_expect_success 'clone bundle list (HTTP, no heuristic)' '
+	test_when_finished rm -f trace*.txt &&
+
 	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
 	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
 	[bundle]
@@ -304,12 +306,26 @@ test_expect_success 'clone bundle list (HTTP, no heuristic)' '
 		uri = $HTTPD_URL/bundle-4.bundle
 	EOF
 
-	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
+	GIT_TRACE2_EVENT="$(pwd)/trace-clone.txt" \
+		git clone --bundle-uri="$HTTPD_URL/bundle-list" \
 		clone-from clone-list-http  2>err &&
 	! grep "Repository lacks these prerequisite commits" err &&
 
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
-	git -C clone-list-http cat-file --batch-check <oids
+	git -C clone-list-http cat-file --batch-check <oids &&
+
+	cat >expect <<-EOF &&
+	$HTTPD_URL/bundle-1.bundle
+	$HTTPD_URL/bundle-2.bundle
+	$HTTPD_URL/bundle-3.bundle
+	$HTTPD_URL/bundle-4.bundle
+	$HTTPD_URL/bundle-list
+	EOF
+
+	# Sort the list, since the order is not well-defined
+	# without a heuristic.
+	test_remote_https_urls <trace-clone.txt | sort >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'clone bundle list (HTTP, any mode)' '
@@ -350,6 +366,55 @@ test_expect_success 'clone bundle list (HTTP, any mode)' '
 	test_cmp expect actual
 '
 
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
+	GIT_TRACE2_EVENT="$(pwd)/trace-clone.txt" git \
+		clone --bundle-uri="$HTTPD_URL/bundle-list" \
+		"$HTTPD_URL/smart/fetch.git" clone-list-http-2 &&
+
+	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
+	git -C clone-list-http-2 cat-file --batch-check <oids &&
+
+	cat >expect <<-EOF &&
+	$HTTPD_URL/bundle-1.bundle
+	$HTTPD_URL/bundle-2.bundle
+	$HTTPD_URL/bundle-3.bundle
+	$HTTPD_URL/bundle-4.bundle
+	$HTTPD_URL/bundle-list
+	EOF
+
+	# Since the creationToken heuristic is not yet understood by the
+	# client, the order cannot be verified at this moment. Sort the
+	# list for consistent results.
+	test_remote_https_urls <trace-clone.txt | sort >actual &&
+	test_cmp expect actual
+'
+
 # Do not add tests here unless they use the HTTP server, as they will
 # not run unless the HTTP dependencies exist.
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f036c4d3003..ace542f4226 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1833,6 +1833,14 @@ test_region () {
 	return 0
 }
 
+# Given a GIT_TRACE2_EVENT log over stdin, writes to stdout a list of URLs
+# sent to git-remote-https child processes.
+test_remote_https_urls() {
+	grep -e '"event":"child_start".*"argv":\["git-remote-https",".*"\]' |
+		sed -e 's/{"event":"child_start".*"argv":\["git-remote-https","//g' \
+		    -e 's/"\]}//g'
+}
+
 # Print the destination of symlink(s) provided as arguments. Basically
 # the same as the readlink command, but it's not available everywhere.
 test_readlink () {
-- 
gitgitgadget

