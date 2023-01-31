Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9DFC38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 13:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjAaN3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjAaN31 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 08:29:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D9849565
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so13739165wrg.13
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNgYHe2+hAaU8wbxFrTySxoshKCEj59J0s/xFDZd5wE=;
        b=EAOS+/q+9Zb01DDKv7MZlT4C/ahKNQWMjhqO9JkTkPbPpiQhoVv0f+I99RiM0T+jmy
         IYcN/nuKRFm/6VAFJOZuUAfRmcwSmLT1WJZ/P+Nv4OFcfMcsBTtGqedaSVB41EIi8IGm
         FQckpBfuZ3dF2MBjkFrsWCbBJw8MgBJhztn1s4KgXEKEiau+zFF/IU3SaDd8TObf2sBM
         itI2vUIqM8JNsQhBVlaPleXIIGer0pASeHKXtoOHwcpvf8XL9DIcncqO56If/AaifLVZ
         glYonnaxdQU0nx5m+UOOsfeIiOx8PAqQK98RkRGAYX7gt64IvSJocQM1aoxmAocdBjyI
         7LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNgYHe2+hAaU8wbxFrTySxoshKCEj59J0s/xFDZd5wE=;
        b=RPRm0EKgOYAZ/b+2egxRnEV5JkwANrR9N49w+stpRz7C3CrCbcyTtPJvsQ9WSlYUIM
         58iG0R01kMoR9NiLspePr2kp+BKNtaT5WqCya8kNNVs3LC6jEad95stchezUv29rc2Qe
         Ku47g+aBdRClhGQpD2gTiW8GiihsRGc3jq9i8qJKsqyGt8HRGTjUrYu4shNbMfbVSkdP
         kl+ABKZHiO0JrfkMu/eVjp/8CVOsmc75gNVKdOqOfx9WDjh5B36KbPQRPb7si7AUgVXG
         9/WrqhKa7d4t5buJLVQ3XDhYkEtnBvv2upopgLivPvzKz41GTCpzd5Nn0fl3gESwoVQf
         XuLA==
X-Gm-Message-State: AO0yUKVCgHx4cXnOnK/byGiRvNntmXPjM/mPmgTlewGecEjWJrzReZ4y
        Ayi7fuQmtYccfSXrCy4JQvnVfuayNYQ=
X-Google-Smtp-Source: AK7set/+tRYQtQ3aSt2e1lImfiVLIVWsO9JSiA7g2/7TSezYIPZ8hD75ambD27Eo87VuDpGRFjkZLQ==
X-Received: by 2002:a5d:4dce:0:b0:2bf:dcf5:f486 with SMTP id f14-20020a5d4dce000000b002bfdcf5f486mr9158023wru.29.1675171764236;
        Tue, 31 Jan 2023 05:29:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16-20020adffe90000000b002b8fe58d6desm14370903wrr.62.2023.01.31.05.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:29:23 -0800 (PST)
Message-Id: <45cdf9d13a7e0b1e68932defe46a790f6813ed96.1675171759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 13:29:11 +0000
Subject: [PATCH v3 03/11] t5558: add tests for creationToken heuristic
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

