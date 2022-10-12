Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA5AC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 12:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJLMx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 08:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJLMxN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 08:53:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972F1C97C4
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bv10so22543698wrb.4
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2n1oOEOH54xL4jFO2BgRG4PT6/KCIkQNTgOeWChEVmg=;
        b=qH4TBTwYjWep+19ldgpjTTDaQohHOGAWVpCnvNAAe1lfhR8yHzILM+E+KsvvEBeW+1
         Xf0ttCtHWqn7j210xBywiogxXgKdBVLmmjUXL6ZrMIrsGrnBOqMPqUWz3EfdeAqAOQNq
         BXIBf4NUCLhN5q+Cxv65JsJtMBe5kyDKWUEWJsZX9UTAjmBeuJo0iF+aH0PIIB8vHsB4
         IMGlhmrdK1OxrAdfPzanyyerI9nDkAJhdVwm9r5x/h/tfal14mesX5EP2myYzP9kJsYe
         ynPP4rPcaIVat2x6prNYNymUi2IQilXd/Fpp6DAvGbRog+HR74Aq4t9xSl5GY59PdbdH
         UHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2n1oOEOH54xL4jFO2BgRG4PT6/KCIkQNTgOeWChEVmg=;
        b=pf8gvEx3m8zhoELTclKQH+wdzk1IkiqayoAaKpX0yZ+c0FN00OPGkFcAsF9/N0Ithk
         kc0lzu6nxhJgKs4v7WAWEVmhNvg7LQar/bpRdMdL/mgYIws0g60BXzpijJFJckTPq1UN
         xNfG09qjOoqGekalQNkT8Yp6bCXV3lllSGp3fAfSnHCdRQb/MuNnG/lx0E3xSqE5UbfI
         9WPLEup/i0rI2EBcbNUDbt7i2l9xStzQ6JjmNOITnAlsVQRD44a1JYtVqsDb3pXxyiiN
         Wbjna1lEbZhyOPvypU5hXKJWkh4+Dfa8bgW+QPSjluoD/JWlrlqUxHhbmj8Gq8Ehc3mQ
         laMw==
X-Gm-Message-State: ACrzQf1xF3JPn5DdsCvImxxMQ9iOlUP3MLi58gyumOetrO9nIMuuy58a
        ecwjd1FjTa4/fPTH+mP+iJR7vSab9Ss=
X-Google-Smtp-Source: AMsMyM5+Wp9s8yJn/3Ri2eS5L1xfwmBGChLWZpZYKCReuquVB0F4yzg4wJjCG2jst3Xa3DBIwmNUlg==
X-Received: by 2002:a05:6000:2c1:b0:22e:7507:a182 with SMTP id o1-20020a05600002c100b0022e7507a182mr18032972wry.550.1665579176909;
        Wed, 12 Oct 2022 05:52:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d4591000000b0022e32f4c06asm13388473wrq.11.2022.10.12.05.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:52:56 -0700 (PDT)
Message-Id: <5729ff2af4bb56a68624b7942b8afa67601adb43.1665579160.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 12:52:39 +0000
Subject: [PATCH v5 12/12] bundle-uri: suppress stderr from remote-https
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
index d872acf5ab0..79a914f961b 100644
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
