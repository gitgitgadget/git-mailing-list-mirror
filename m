Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21BFC433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 12:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJDMew (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 08:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJDMek (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 08:34:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D44D11A
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 05:34:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l8so8790089wmi.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=2lVQAMTa7TAa45djrtZD5zZRLaPcjv6iq7dd0SZ24uk=;
        b=lNpTb5OWYddZN9bzO/sQtLfBl4OemCbY/lyrG42XIZKB/n2xG4t1JF415DSdsGkDDu
         a00yQYHHjuPceSlIAFwZNpRcGRkeFhrQRUCsepa5HkOLPrsHeWSUTQMGx5H0J4unPH9G
         Ob7vjPY68S3Hm1kKlE0i2bkZYZI/UsFel9eHuHFMZGpd1LHE6nj+UEWKYrpiU199Eaa0
         E3v+rpH3uWP9zxK3RdqS49MKo53GtSPGqNUqoJsK0eR9ft4JkDXtl9kYlN41CZf5lToM
         HAQT5decp9dtTByFNLaBMK81UjlvV6PJR2QpAPZkuv86kFks8N9CMOflUtvu1jJrHSsj
         KCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2lVQAMTa7TAa45djrtZD5zZRLaPcjv6iq7dd0SZ24uk=;
        b=KqIknfeq7JFVuPpJj6uEfdJtboJPStJqpUOR08uO4IeGac+5OVZWOPkPUKelykDhEV
         gw2qRKncSSDLgq9eszCqiXm/RbpIRmcIDlka1ixc0Z/U7RyVOnGjyx/lYlI9VvT3sEaN
         RedbIDS7naG4Ht1pZCAb2O4DNA0ftVKP+gWbB2Uxv7AxeIP+mo5PhNHK9PaeUhAvEK0c
         Lh2+v29LzTJqX15G17/1+snGKnL/WmeNlK/trZFJMXC5Zm+Ramqcma4PoqTMWLSCZ7he
         ZydC3Ct0y5t7smo26bS02vHjzTxzveyVzdFujxSFCicxDy4HDusDwOovnOJrh0FGBlxn
         nuZg==
X-Gm-Message-State: ACrzQf31NTx67D5zZgdmHRMmOoG/vRvFc1t2jjUgtCeUzdkw8S2+LRY8
        E1EetCeRXuavzmFCMVi0QtFB6Gx8mqg=
X-Google-Smtp-Source: AMsMyM7WPdKD1ftTtlnoJZzPcnV0S1A7NjO/+LQhD95xvemOAkXpSOV7TYssC8xbsNG9lSgzThhseA==
X-Received: by 2002:a05:600c:ace:b0:3b4:621f:93f4 with SMTP id c14-20020a05600c0ace00b003b4621f93f4mr9806502wmr.8.1664886872875;
        Tue, 04 Oct 2022 05:34:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19550432wma.6.2022.10.04.05.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 05:34:32 -0700 (PDT)
Message-Id: <d84544859e4a0e40b3692cf2e838f38734589114.1664886861.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
References: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
        <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 12:34:20 +0000
Subject: [PATCH v3 9/9] bundle-uri: suppress stderr from remote-https
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When downloading bundles from a git-remote-https subprocess, the bundle
URI logic wants to be opportunistic and download as much as possible and
work with what did succeed. This is particularly important in the "any"
mode, where any single bundle success will work.

If the URI is not available, the git-remote-https process will die()
with a "fatal:" error message, even though that error is not actually
fatal to the super process. Since stderr is passed through, it looks
like a fatal error to the user.

Suppress stderr to avoid these errors from bubbling to the surface. The
bundle URI API adds its own warning() messages on these failures.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                |  1 +
 t/t5558-clone-bundle-uri.sh | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index aaa1848044a..92af0eae224 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -230,6 +230,7 @@ static int download_https_uri_to_file(const char *file, const char *uri)
 	int found_get = 0;
 
 	strvec_pushl(&cp.args, "git-remote-https", uri, NULL);
+	cp.err = -1;
 	cp.in = -1;
 	cp.out = -1;
 
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 9690f19386f..a0ef0588e21 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -122,7 +122,11 @@ test_expect_success 'clone bundle list (file, any mode)' '
 		uri = $HTTPD_URL/bundle-5.bundle
 	EOF
 
-	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-any-file &&
+	git clone --bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from clone-any-file 2>err &&
+	! grep "fatal" err &&
+	grep "warning: failed to download bundle from URI" err &&
+
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-any-file cat-file --batch-check <oids
 '
@@ -205,7 +209,11 @@ test_expect_success 'clone bundle list (HTTP, any mode)' '
 		uri = $HTTPD_URL/bundle-5.bundle
 	EOF
 
-	git clone --bundle-uri="$HTTPD_URL/bundle-list" clone-from clone-any-http &&
+	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
+		clone-from clone-any-http 2>err &&
+	! grep "fatal" err &&
+	grep "warning: failed to download bundle from URI" err &&
+
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-any-http cat-file --batch-check <oids
 '
-- 
gitgitgadget
