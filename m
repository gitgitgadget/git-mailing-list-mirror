Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C0FC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJJQFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJJQEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:04:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44A2D4A
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so626398wmq.4
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MQ58oE1Umdwil9GfkQuI8DXSz4Urq4rklgor+bUEhY=;
        b=ipBhzIOKha2cgVPshs2CJlymvIl/CX+7L4LYSv0gBj8HEhlUPtlG50ZXpaqxd2PtLZ
         IBXyNCK68/CEMRYa3pUHTNSn3jDYrM+wLddNP9mNe+YzAk0RazR0iYgmPTNyMJ3y6jSz
         ppnT/t6+S18OION0WoEUzLoo6cmXPu/PFL0UbRLPYIMP2lhjduYomulAfG9qk1zHB2s3
         EZcySTEjQEj4N1WRoowAPy3Op9FfSjupfKCDFbeSP7+BWTiS/7P3fSEUuZpsK91Mfx4r
         mPE01d4OftPZHacQDmI0ETeTc2SmsyBx4+SSEmnxvtQ4XWPgZeYj+1j14azsPR/cuRY1
         z6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MQ58oE1Umdwil9GfkQuI8DXSz4Urq4rklgor+bUEhY=;
        b=4vHfth7PyV64kgaWSV+QbWp7l3TgbnDEpuRJEDC/VuPI9YcLke++fUFT3ir9CH0aCs
         7DuIeSBHTOV5bhjRelyQHdL9vz0AqtnQDK/I889YzL08JQmi5LE6tNSb2bh7yWVmjcXt
         8B3Brra7qM3D9BHSsFegXBGlDM6F1LWe1Cktg+HHu7z8f+3QEVAjRfK5Qc7UdoFUB4pv
         LbF7u18lGUFAxy9Ahxwh2HP4Fjm69lFXqQrS+rIrHgPZ7SXqvfjsuDMcnL2YgP+Ex83p
         rb3SfcWQNPQF/+jr0BoFh9WCNoIEuIe7ny5+OIqJOEcMni/IRK3zbzxWZ9iXu2nMZ2uq
         GGQA==
X-Gm-Message-State: ACrzQf0Jxw7tsFTh+Ix90IV76I97ZY3bEqLbvhyH1U8JglhPoJ4FjC9z
        sMKGh8EVSGGC4aiZQshIKrTMnI40I+w=
X-Google-Smtp-Source: AMsMyM64ofdZKdtpMgfewTyzVNcB5rCPwGpMwK1fG+2t0AM3IDIOPzuStTRApnTd7bWkdFC0AofrZw==
X-Received: by 2002:a05:600c:1f16:b0:3b4:f20e:6463 with SMTP id bd22-20020a05600c1f1600b003b4f20e6463mr20634883wmb.56.1665417874549;
        Mon, 10 Oct 2022 09:04:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d448b000000b0022efc4322a9sm7860797wrq.10.2022.10.10.09.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:04:33 -0700 (PDT)
Message-Id: <52a575f8a692e6a9de28e7d597945a280b892e0a.1665417859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
References: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
        <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 16:04:19 +0000
Subject: [PATCH v4 11/11] bundle-uri: suppress stderr from remote-https
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
 t/t5558-clone-bundle-uri.sh | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 18b993c207f..6bfba95f872 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -230,6 +230,7 @@ static int download_https_uri_to_file(const char *file, const char *uri)
 	int found_get = 0;
 
 	strvec_pushl(&cp.args, "git-remote-https", uri, NULL);
+	cp.err = -1;
 	cp.in = -1;
 	cp.out = -1;
 
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 9b159078386..9155f31fa2c 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -147,6 +147,8 @@ test_expect_success 'clone bundle list (file, all mode, some failures)' '
 	git clone --bundle-uri="file://$(pwd)/bundle-list" \
 		clone-from clone-all-some 2>err &&
 	! grep "Repository lacks these prerequisite commits" err &&
+	! grep "fatal" err &&
+	grep "warning: failed to download bundle from URI" err &&
 
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-all-some cat-file --batch-check <oids &&
@@ -178,6 +180,8 @@ test_expect_success 'clone bundle list (file, all mode, all failures)' '
 	git clone --bundle-uri="file://$(pwd)/bundle-list" \
 		clone-from clone-all-fail 2>err &&
 	! grep "Repository lacks these prerequisite commits" err &&
+	! grep "fatal" err &&
+	grep "warning: failed to download bundle from URI" err &&
 
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-all-fail cat-file --batch-check <oids &&
@@ -234,7 +238,11 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
 		uri = $HTTPD_URL/bundle-5.bundle
 	EOF
 
-	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-any-fail &&
+	git clone --bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from clone-any-fail 2>err &&
+	! grep "fatal" err &&
+	grep "warning: failed to download bundle from URI" err &&
+
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-any-fail cat-file --batch-check <oids &&
 
@@ -323,7 +331,11 @@ test_expect_success 'clone bundle list (HTTP, any mode)' '
 		uri = $HTTPD_URL/bundle-5.bundle
 	EOF
 
-	git clone --bundle-uri="$HTTPD_URL/bundle-list" clone-from clone-any-http &&
+	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
+		clone-from clone-any-http 2>err &&
+	! grep "fatal" err &&
+	grep "warning: failed to download bundle from URI" err &&
+
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-any-http cat-file --batch-check <oids &&
 
-- 
gitgitgadget
