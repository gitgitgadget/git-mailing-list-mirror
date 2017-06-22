Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3401FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 19:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbdFVTCV (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:02:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33965 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753697AbdFVTCU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:02:20 -0400
Received: by mail-wr0-f195.google.com with SMTP id k67so6821681wrc.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XRvAjM/CY2eP+V4C22Hb8e7ofDCV6u0JWvnF1UmZMRw=;
        b=hqpm6z847PKIpLR0GjDrOoC1mKL/AZPNCmJ6zl2KpkK7OfnF1vIubzTdZsb3O/pgXU
         FWrBpslpXvt0rJUMPOo6v0kQJmfu4CKV7HVZuGYe41bWxHWh9Wzb8bN6X4Kt5+RCZmvD
         EpTxEXSKIgWTas+jSULJYQvh1H2sFK96QAnNzu41GeD327Y3y9Yxv6b8N1A63H0g4rp1
         Xt0ebef2k9+I7/bWGuSNvS53ekX454iucKeM+sn5zOs+mJNUTvLzjJhx3AQ/Y28ZJ+m5
         IoKpPyQ2EdQfV0oMSk51VGKCx8Iv2z6tbLuRxtXxbTonoQnKSqYA3XHgMVWbJSSvYbna
         kUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XRvAjM/CY2eP+V4C22Hb8e7ofDCV6u0JWvnF1UmZMRw=;
        b=YNA2Ur0PJ0Bi9bNgfOuNqZl7fgxurUXXXCNV8/1780rD13DUN989ERT64jF90LbEdW
         TrHcwFN3ZTJoFL4kYACZ0AkuhITWTXQg6w3xUX0kYgdsvbhwq0ZvMmoseRkE8UXdvuQA
         3eOjj8NHGdplnPhGZyhhp3ab+v1md2NUH9Rmg7fdpJalhJhLw0IIQs7BKgTsfFOWsTXd
         gT7Y90VPlRNx7HAw0IsnwcKusEwDvhscOYu5wsO+DscsP9E1fbNS4ky4stbsOPZCg27y
         GJjEl8RsLJVHEuTGkMhEWNr9PLKU9pHMQqfC5A7q5FaGHE7xVLBa+3laEssJjCuGO53c
         t43w==
X-Gm-Message-State: AKS2vOxx4WTVTcsdP0A2synETFJZd7ycOW+/GtKqHW9pLch8Mb5O/jmK
        RpyyDoobgUb7WKzO
X-Received: by 10.28.230.153 with SMTP id e25mr2688679wmi.41.1498158138257;
        Thu, 22 Jun 2017 12:02:18 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 32sm2771112wry.31.2017.06.22.12.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 12:02:16 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] t1301: move movebits() to test-lib-functions.sh
Date:   Thu, 22 Jun 2017 21:01:57 +0200
Message-Id: <20170622190158.13265-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.516.g05ec6e13aa
In-Reply-To: <20170622190158.13265-1-chriscool@tuxfamily.org>
References: <20170622190158.13265-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the movebits() function can be useful outside t1301,
let's move it into test-lib-functions.sh, and while at
it let's rename it test_movebits().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1301-shared-repo.sh  | 18 +++++++-----------
 t/test-lib-functions.sh |  5 +++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 1312004f8c..dfece751b5 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -19,10 +19,6 @@ test_expect_success 'shared = 0400 (faulty permission u-w)' '
 	)
 '
 
-modebits () {
-	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
-}
-
 for u in 002 022
 do
 	test_expect_success POSIXPERM "shared=1 does not clear bits preset by umask $u" '
@@ -88,7 +84,7 @@ do
 
 		rm -f .git/info/refs &&
 		git update-server-info &&
-		actual="$(modebits .git/info/refs)" &&
+		actual="$(test_modebits .git/info/refs)" &&
 		verbose test "x$actual" = "x-$y"
 
 	'
@@ -98,7 +94,7 @@ do
 
 		rm -f .git/info/refs &&
 		git update-server-info &&
-		actual="$(modebits .git/info/refs)" &&
+		actual="$(test_modebits .git/info/refs)" &&
 		verbose test "x$actual" = "x-$x"
 
 	'
@@ -111,7 +107,7 @@ test_expect_success POSIXPERM 'info/refs respects umask in unshared repo' '
 	umask 002 &&
 	git update-server-info &&
 	echo "-rw-rw-r--" >expect &&
-	modebits .git/info/refs >actual &&
+	test_modebits .git/info/refs >actual &&
 	test_cmp expect actual
 '
 
@@ -177,7 +173,7 @@ test_expect_success POSIXPERM 'remote init does not use config from cwd' '
 	umask 0022 &&
 	git init --bare child.git &&
 	echo "-rw-r--r--" >expect &&
-	modebits child.git/config >actual &&
+	test_modebits child.git/config >actual &&
 	test_cmp expect actual
 '
 
@@ -187,7 +183,7 @@ test_expect_success POSIXPERM 're-init respects core.sharedrepository (local)' '
 	echo whatever >templates/foo &&
 	git init --template=templates &&
 	echo "-rw-rw-rw-" >expect &&
-	modebits .git/foo >actual &&
+	test_modebits .git/foo >actual &&
 	test_cmp expect actual
 '
 
@@ -198,7 +194,7 @@ test_expect_success POSIXPERM 're-init respects core.sharedrepository (remote)'
 	test_path_is_missing child.git/foo &&
 	git init --bare --template=../templates child.git &&
 	echo "-rw-rw-rw-" >expect &&
-	modebits child.git/foo >actual &&
+	test_modebits child.git/foo >actual &&
 	test_cmp expect actual
 '
 
@@ -209,7 +205,7 @@ test_expect_success POSIXPERM 'template can set core.sharedrepository' '
 	cp .git/config templates/config &&
 	git init --bare --template=../templates child.git &&
 	echo "-rw-rw-rw-" >expect &&
-	modebits child.git/HEAD >actual &&
+	test_modebits child.git/HEAD >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 5ee124332a..db622c3555 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -216,6 +216,11 @@ test_chmod () {
 	git update-index --add "--chmod=$@"
 }
 
+# Get the modebits from a file.
+test_modebits () {
+	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
+}
+
 # Unset a configuration variable, but don't fail if it doesn't exist.
 test_unconfig () {
 	config_dir=
-- 
2.13.1.516.g05ec6e13aa

