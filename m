Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1CCC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiKGSh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiKGShI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:37:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89AD25EB6
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:34 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so10220998wmb.2
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXI9YmLxXYusnxMb67gNbNOoBleGXrQo9qZsXx3Cr5k=;
        b=S1O6mLCcV17f6TZnxH2sapwhbTmbM4wAepF77iHwv+VcObita3pfXzSpkcIjmEJOT3
         z+iyRf0E/mzhVS+NjrqGdEnQjgTUdeO4pwubkngBcmV32h8op0rGteJMNwgfZFL6CPci
         ZC/W+ciIedPE97vdfjDlwxpWbM0KE091H17RyxbxV29g7tXn6qidXxOdf+oUmsX0Zxse
         darvX9LkgX/MSmkXlmuDXXbv9Qu+DHvkb7MCPoV9VDTyE8GxH+i1hm1Q4Pd0KVQkrtiF
         z52ZwALnC3j/WPeXbq99FGUxxVlTGVQoKQCT2w0vNW6/toNGBWGpIM0LMwjt1otFvEgD
         Wk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXI9YmLxXYusnxMb67gNbNOoBleGXrQo9qZsXx3Cr5k=;
        b=GY1xEvTZ8Ns4zAY/0JazA0dJRVeoGOPWlcT2/q/lBzd9CicwUQJSvTiAfMmwhil3dB
         e1LMGYnli+IJl2SDl0fnjLGxchlGAuJ+b38N9K7Dgybk6VVseQZh4cBM+dQMrBUScO4e
         vPfEUExTzrXPYMiL0Tz5bKQND8OEcI+RVo2Bb+xt/fosBJjJzmBA0mg7vbNtbojU2uLs
         c2UDcSSIN3pqmaHXV9LMRhRil2HqYV/LD/vgzuCO3xlPDZQGVGQL/0JK1omAZuhOaqqr
         E5HgC8Z90wVAQ3dulsHtV0f+4EZfCtSdDVmvBsrLtylDL0gUswMFkipI0dlnxqPIPOHq
         z28A==
X-Gm-Message-State: ACrzQf1jlOYaoBcY/BogV6ctzU5yDINun8+sVfHy8YcjdEXRMIBJ21ZS
        bUaG3vowsmERnQ1t+DJ7k6hR4hPceh0=
X-Google-Smtp-Source: AMsMyM7fijAUeBuP8Za3sOJDZBAjFnJHeCSaxop0vmY2fjsOmWPRc3TWFzfvVJ/TISMVd7NiSFQqYA==
X-Received: by 2002:a05:600c:5d3:b0:3cf:6bbf:9ee3 with SMTP id p19-20020a05600c05d300b003cf6bbf9ee3mr29721765wmd.15.1667846193077;
        Mon, 07 Nov 2022 10:36:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b003b95ed78275sm9506329wms.20.2022.11.07.10.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:32 -0800 (PST)
Message-Id: <5aa0d4080291dda854fc1ea7655037822b53111a.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:36:01 +0000
Subject: [PATCH 27/30] t*: skip packed-refs v2 over http tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The GIT_TEST_PACKED_REFS_VERSION=2 environment variable helps us test
the packed-refs file format in its v2 version. This variable makes the
Git process act as if the extensions.refFormat config key has
"packed-v2" in its list. This means that if the environment variable is
removed, the repository is in a bad state. This is sufficient for most
test cases.

However, tests that fetch over HTTP appear to lose this environment
variable when executed through the HTTP server. Since the repositories
are created via Git commands in the tests, the packed-refs files end up
in the v2 format, but the server processes do not understand this and
start serving empty payloads since they do not recognize any refs.

The preferred long-term solution would be to ensure that the GIT_TEST_*
environment variable persists into the HTTP server. However, these tests
are not exercising any particularly tricky parts of the packed-refs file
format. It may not be worth the effort to pass the environment variable
and instead we can unset the environment variable (with a comment
explaining why) in these tests.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t5539-fetch-http-shallow.sh | 7 +++++++
 t/t5541-http-push-smart.sh    | 7 +++++++
 t/t5542-push-http-shallow.sh  | 7 +++++++
 t/t5551-http-fetch-smart.sh   | 7 +++++++
 t/t5558-clone-bundle-uri.sh   | 7 +++++++
 5 files changed, 35 insertions(+)

diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 3ea75d34ca0..5e3b4304367 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -5,6 +5,13 @@ test_description='fetch/clone from a shallow clone over http'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+# If GIT_TEST_PACKED_REFS_VERSION=2, then the packed-refs file will
+# be written in v2 format without extensions.refFormat=packed-v2. This
+# causes issues for the HTTP server which does not carry over the
+# environment variable to the server process.
+GIT_TEST_PACKED_REFS_VERSION=0
+export GIT_TEST_PACKED_REFS_VERSION
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index fbad2d5ff5e..495437dd3c7 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -7,6 +7,13 @@ test_description='test smart pushing over http via http-backend'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+# If GIT_TEST_PACKED_REFS_VERSION=2, then the packed-refs file will
+# be written in v2 format without extensions.refFormat=packed-v2. This
+# causes issues for the HTTP server which does not carry over the
+# environment variable to the server process.
+GIT_TEST_PACKED_REFS_VERSION=0
+export GIT_TEST_PACKED_REFS_VERSION
+
 . ./test-lib.sh
 
 ROOT_PATH="$PWD"
diff --git a/t/t5542-push-http-shallow.sh b/t/t5542-push-http-shallow.sh
index c2cc83182f9..c47b18b9faa 100755
--- a/t/t5542-push-http-shallow.sh
+++ b/t/t5542-push-http-shallow.sh
@@ -5,6 +5,13 @@ test_description='push from/to a shallow clone over http'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+# If GIT_TEST_PACKED_REFS_VERSION=2, then the packed-refs file will
+# be written in v2 format without extensions.refFormat=packed-v2. This
+# causes issues for the HTTP server which does not carry over the
+# environment variable to the server process.
+GIT_TEST_PACKED_REFS_VERSION=0
+export GIT_TEST_PACKED_REFS_VERSION
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 6a38294a476..61f2e90eabe 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -4,6 +4,13 @@ test_description='test smart fetching over http via http-backend'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+# If GIT_TEST_PACKED_REFS_VERSION=2, then the packed-refs file will
+# be written in v2 format without extensions.refFormat=packed-v2. This
+# causes issues for the HTTP server which does not carry over the
+# environment variable to the server process.
+GIT_TEST_PACKED_REFS_VERSION=0
+export GIT_TEST_PACKED_REFS_VERSION
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 9155f31fa2c..3e35322155e 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -2,6 +2,13 @@
 
 test_description='test fetching bundles with --bundle-uri'
 
+# If GIT_TEST_PACKED_REFS_VERSION=2, then the packed-refs file will
+# be written in v2 format without extensions.refFormat=packed-v2. This
+# causes issues for the HTTP server which does not carry over the
+# environment variable to the server process.
+GIT_TEST_PACKED_REFS_VERSION=0
+export GIT_TEST_PACKED_REFS_VERSION
+
 . ./test-lib.sh
 
 test_expect_success 'fail to clone from non-existent file' '
-- 
gitgitgadget

