Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F2F020282
	for <e@80x24.org>; Fri, 23 Jun 2017 15:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754453AbdFWPQ4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 11:16:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34232 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754431AbdFWPQy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 11:16:54 -0400
Received: by mail-wr0-f193.google.com with SMTP id k67so13225126wrc.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=agl77tFLf4sPFyrP1FkmUSIFpj3++FFqqjn4HYn5//k=;
        b=n6cJba9yEMdVKMl0Bz565N4Vfj9o7595u4kBpFngNwruPZBBC1zyvrxMqyyyTJItd0
         /0RyWQp4SZfzqAmFhp5IB/eCv+GS+R7G2d8mX81cIYUK9uHLp70A+qiwazbXGBB/mg8A
         wHZDleTjpiyArR4u0jLVITAwvIj8RRhxxCd0LyT7dkWQXiu74YeLMG5GWS2bKTGJJlql
         poJcR/SCkwD0EPYPKwemK/dRlqOQ7bkbe48lnQXRrmBYq/c0jD+BstnBjI2ONN0xAaUO
         USTTeQscGrzRib58wLMmdlm8zlbsqH85nS2rKwTxeRBPYpmpN+yUdKpDEXkJLAfrnauk
         UmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=agl77tFLf4sPFyrP1FkmUSIFpj3++FFqqjn4HYn5//k=;
        b=nyW795O/ujZOYi8XmVZ7Ozx6dO+2PRlcHpiDaWEoBEDHCb1Xe6y0ccPFTpyoZWJRy+
         l4CsWbNmLIaVHLfwXdfAEbyw06vK5YgVmLAxzkt3ggRuEVq2EjUU1gS/w05XVq+KytPQ
         NoYsmGmPuFo4YkbgyIJ6YvWf76hpTpLZtL+YHv2CIKF5Pryyqejb0LhRMd2sFW08G9GM
         IOSDQH5Y3byZ6qnpbJDCKc8Fq5j0pTsUdWd3H/Y6GI2oNeAbPmcI6PoWz9xtTe1k6OOZ
         RzJpggo738Hf13Mv7z0i7KMw+InTWM0KqaWHwgq8SkGFFCT1CU64RxB9CGG83j99KNci
         yCvw==
X-Gm-Message-State: AKS2vOxeuG68mkdUr5lcBUF9zdwquVhQweHqTJnDMQqz9c9e1eT3o8oY
        WjEBCk4dzuWNtCvO
X-Received: by 10.223.138.167 with SMTP id y36mr6462524wry.93.1498231012886;
        Fri, 23 Jun 2017 08:16:52 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id z75sm4405186wmz.8.2017.06.23.08.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 08:16:52 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/3] t1301: move modebits() to test-lib-functions.sh
Date:   Fri, 23 Jun 2017 17:16:39 +0200
Message-Id: <20170623151640.24082-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.519.g0a0746bea4
In-Reply-To: <20170623151640.24082-1-chriscool@tuxfamily.org>
References: <20170623151640.24082-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the modebits() function can be useful outside t1301,
let's move it into test-lib-functions.sh, and while at
it let's rename it test_modebits().

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
2.13.1.519.g0a0746bea4

