Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C48C63797
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 20:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjAFUhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbjAFUgy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 15:36:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A368510ED
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 12:36:49 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id z5so1299834wrt.6
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 12:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATlPuguJQCgNGrlBOBW0JFI7+ezP6FpbBehy6jtZDK8=;
        b=Amsd6pJTknMtM7tQISe6pbAmb5jyKGy/h83L3ocjr/p5Pj8Kv95rko7WKyg3YozRjQ
         uonTSVdscDwILDLHQiLPZU295Ik0GXdc0JoILxPmQ+Kz4+ZZe9VVkI0pIJdR7GDV7VsI
         qPmGS47c7BQx77PqEDcisFNFI3npX2sFG5Ak73jYp4bA1Fy12SNmVq7gpc3n4rGyq4a8
         QOhPhYoREMKMfnc9JnSRZ7Rqe0HXv2J9A4Cy2nLLO0aY5wCvmg5PuONeXJyDdI+989Gw
         rcjrqL3zMQRKrxnjN4qubvjYaGGNvknl05vaHgCe5gdbSy2mcrz/PJWw3O05OOdLCUxz
         xANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATlPuguJQCgNGrlBOBW0JFI7+ezP6FpbBehy6jtZDK8=;
        b=q0bqZ+mdLpuhiXDGrto7Y2u5W7bMRagyA604NfU6bF0GKxpU/P2pJxb/FzsArbeh5q
         OzlF+FG5+I+Y+byD+fIgjVY17Wq+Lpwh558CfkEUaf3NFBqSo6GGTCjSc7g8Y5CCdOxH
         kRZRtTrFcXhloGDAuQM/xqC8SZ3065NngaMybtKmxJZQxrPth765hXQtAXXknDsYbHzH
         YKEoX4e7qc0YSqX74w2E6G4nLecfgmBSl3n5FXD10YSe6YYAPfnzzBmi9F4Qve4lZ7Tq
         IIJfv3YDFVYJOWdKAQQNBg2m3lI5TE3wZ61SOcw4dMk4KFeFehiBrdEK+ZJAzbLjjrEs
         J1QQ==
X-Gm-Message-State: AFqh2kqQ87uasmpknies4+aUMOPr4mCvTy73gjNSymc4tkF/RqGlXcvL
        EfLLoiDsxxfybvLQBEMI5O3oNSmJohE=
X-Google-Smtp-Source: AMrXdXtPrrDYoa0cSIbJwUz6pQ0TWA8P2pARYfkoHtPo5WBIPeCsT2WdXLXIeVXbkFeJR14SBzripQ==
X-Received: by 2002:adf:dd4c:0:b0:25e:2dae:260e with SMTP id u12-20020adfdd4c000000b0025e2dae260emr34624406wrm.24.1673037407913;
        Fri, 06 Jan 2023 12:36:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4-20020adfee44000000b0029100e8dedasm2117422wro.28.2023.01.06.12.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:36:47 -0800 (PST)
Message-Id: <39eed9148782c37f5184c5fff7d0e4d1a7a2a1fe.1673037405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Jan 2023 20:36:38 +0000
Subject: [PATCH 1/8] t5558: add tests for creationToken heuristic
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

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t5558-clone-bundle-uri.sh | 52 +++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 9155f31fa2c..328caeeae9a 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -284,7 +284,17 @@ test_expect_success 'clone HTTP bundle' '
 	test_config -C clone-http log.excludedecoration refs/bundle/
 '
 
+# usage: test_bundle_downloaded <bundle-name> <trace-file>
+test_bundle_downloaded () {
+	cat >pattern <<-EOF &&
+	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/$1"\]
+	EOF
+	grep -f pattern "$2"
+}
+
 test_expect_success 'clone bundle list (HTTP, no heuristic)' '
+	test_when_finished rm -f trace*.txt &&
+
 	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
 	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
 	[bundle]
@@ -304,12 +314,19 @@ test_expect_success 'clone bundle list (HTTP, no heuristic)' '
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
+	for b in 1 2 3 4
+	do
+		test_bundle_downloaded bundle-$b.bundle trace-clone.txt ||
+			return 1
+	done
 '
 
 test_expect_success 'clone bundle list (HTTP, any mode)' '
@@ -350,6 +367,37 @@ test_expect_success 'clone bundle list (HTTP, any mode)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone bundle list (http, creationToken)' '
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
+	git clone --bundle-uri="$HTTPD_URL/bundle-list" . clone-list-http-2 &&
+
+	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
+	git -C clone-list-http-2 cat-file --batch-check <oids
+'
+
 # Do not add tests here unless they use the HTTP server, as they will
 # not run unless the HTTP dependencies exist.
 
-- 
gitgitgadget

