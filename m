Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B651F403
	for <e@80x24.org>; Thu, 14 Jun 2018 12:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755128AbeFNMb2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 08:31:28 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42800 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755097AbeFNMb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 08:31:27 -0400
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so6239043wrk.9
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 05:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uMvCYsySg04i1pZ6lsGGLp2naV0s3Y7PP/bdWtvAIUo=;
        b=etAAaQqeScF4NGioWTxjxfgISRL4wPvYNLa5BEq81Ysn9M6bPS2bqY/h8THPyMayBP
         mSxbBMGvFQmcxpoC5iKLcQQofXjFYhIsRkg72Umasd/+dRk1a4N8mTtvlc3s9SxFYGvD
         w4yWbc8tKNOQRGKEzrlakOctyxjj0o/EeLzYiR2F9zPcKct0kUXQZ6B51wIFDx+hFn+O
         c5Zk0qCy1R2D2jb3OM/Kg6Bqo+cbeIYTCSEyQKWY24Z05vTUC0HUTY+PK8B8YzlXxPci
         9d5fTpo33Ddoc9o6vOya4DxCfnWgwsSmrzy+46Y81aw4rN1+ZtYQC4w341t6fzHbGxpy
         m1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uMvCYsySg04i1pZ6lsGGLp2naV0s3Y7PP/bdWtvAIUo=;
        b=dHohzKhL7dTfdhKRhAeOHS0Volsfoaw02MEh/pvJPqxkyhwuav6hA2KhrinFtIAlm4
         2Lq//9G/9ywQqd7Jhj4d628fDIheG+aiLDV53nXw89uiomkpslDYQ6HR7axkCIJHyZX0
         IQUf4id6WHVeACer6Z0ZGlbbGWEEfavBr/zwzzr6h4cQUS1JDv2y+dLTpiVh0NwEGtG4
         HiQyVhrhy6YTENP+p7fLhrjB4/AeTqqavszwVhIaRnle5y+9+aAkSkGqjwaBXpbesMFs
         pjmtwkFs4PYIYBOWfsyH/OvXnVCk5i3nJkCjYijQeevMtRllw0SW5JnZgJ2ACdZ3yMpC
         DpJQ==
X-Gm-Message-State: APt69E14b4ox4JBxJNZO9bVoQVmUrLvVZh3DcQiNMsXnomxsev0eXrP2
        aPFMO32uF3+2dbuiRUVoOXNZOQ==
X-Google-Smtp-Source: ADUXVKKso+1LCa/iA8ZBlsDTKsv8vXq6WcEd3NwvrA2tGMZLp35JyrkfW9YMeoRCqGsyEE0StMdUFg==
X-Received: by 2002:adf:8462:: with SMTP id 89-v6mr2294744wrf.138.1528979486083;
        Thu, 14 Jun 2018 05:31:26 -0700 (PDT)
Received: from localhost.localdomain (x4db06284.dyn.telefonica.de. [77.176.98.132])
        by smtp.gmail.com with ESMTPSA id w67-v6sm6281497wmw.0.2018.06.14.05.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 05:31:25 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/4] t/lib-httpd: add the strip_access_log() helper function
Date:   Thu, 14 Jun 2018 14:31:05 +0200
Message-Id: <20180614123107.11608-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <20180614123107.11608-1-szeder.dev@gmail.com>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Four tests in three httpd-related test scripts check the contents of
Apache's 'access.log', and they all do so by running 'sed' with the
exact same script consisting of four s/// commands to strip
uninteresting log fields and to vertically align the requested URLs.

Extract this into a common helper function 'strip_access_log' in
'lib-httpd.sh', and use it in all of those tests.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-httpd.sh              |  9 +++++++++
 t/t5541-http-push-smart.sh  | 14 ++------------
 t/t5551-http-fetch-smart.sh |  7 +------
 t/t5561-http-backend.sh     |  7 +------
 4 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 435a37465a..b6788fea57 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -287,3 +287,12 @@ expect_askpass() {
 	test_cmp "$TRASH_DIRECTORY/askpass-expect" \
 		 "$TRASH_DIRECTORY/askpass-query"
 }
+
+strip_access_log() {
+	sed -e "
+		s/^.* \"//
+		s/\"//
+		s/ [1-9][0-9]*\$//
+		s/^GET /GET  /
+	" "$HTTPD_ROOT_PATH"/access.log
+}
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index c961db814d..a1385800fa 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -43,12 +43,7 @@ test_expect_success 'no empty path components' '
 	cd "$ROOT_PATH" &&
 	git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
 
-	sed -e "
-		s/^.* \"//
-		s/\"//
-		s/ [1-9][0-9]*\$//
-		s/^GET /GET  /
-	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+	strip_access_log >act &&
 
 	# Clear the log, so that it does not affect the "used receive-pack
 	# service" test which reads the log too.
@@ -137,12 +132,7 @@ GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
 EOF
 test_expect_success 'used receive-pack service' '
-	sed -e "
-		s/^.* \"//
-		s/\"//
-		s/ [1-9][0-9]*\$//
-		s/^GET /GET  /
-	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+	strip_access_log >act &&
 	test_cmp exp act
 '
 
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index f5721b4a59..82a4fb5e16 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -98,12 +98,7 @@ GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/repo.git/git-upload-pack HTTP/1.1 200
 EOF
 test_expect_success 'used upload-pack service' '
-	sed -e "
-		s/^.* \"//
-		s/\"//
-		s/ [1-9][0-9]*\$//
-		s/^GET /GET  /
-	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+	strip_access_log >act &&
 	test_cmp exp act
 '
 
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index 90e0d6f0fe..6a0f240e6d 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -123,12 +123,7 @@ GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
 POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
 EOF
 test_expect_success 'server request log matches test results' '
-	sed -e "
-		s/^.* \"//
-		s/\"//
-		s/ [1-9][0-9]*\$//
-		s/^GET /GET  /
-	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+	strip_access_log >act &&
 	test_cmp exp act
 '
 
-- 
2.18.0.rc0.207.ga6211da864

