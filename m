Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D9C61F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeCXHrd (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:47:33 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38415 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeCXHpp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:45 -0400
Received: by mail-lf0-f65.google.com with SMTP id u3-v6so483120lff.5
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUbUDnFSrnVPkS++EOliMULVma51WjwuoLPAX4H2jaU=;
        b=mUcEvpeComGtwD9xL38gdZTpEMgMLtLds/u5r8T6upC0JrGbOxJVNw7G9ZfwYIUGNd
         MWS1ddMOaiFbhjSLfCi+/xWNqBPjacdiKiSAWyzdh4uEfbtDb8PotsRI+XncvnKQMWr9
         ssziWq+qm0QAPKgHs2zv1V5DnXCNOwduAdE35e8ZJJHaHzvx7jDXPFnu5q/fdtuNU0Q1
         tUjzsEMSF/bywRz5aHS95t5l7VotAsmWT5cb79FhONDLx9bzoIK+ZVTNuHuucKNukYLE
         epEg+PmFG+/cO1Y2E2gWqw/noXa/SqTgsT2QXEvadm5du0ZfUU8Lr66AmNoUwecb13OR
         NBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUbUDnFSrnVPkS++EOliMULVma51WjwuoLPAX4H2jaU=;
        b=PcpSsmva8rbazsSEWuk+f3K1EbDVVnjjBn63ouQNx3ImdlYlwVDHWhFFVZ4U7ONzrU
         YAtUTEMJ9/qIVwZnaHOT84raalAmFOlIxKnWJdzjs+54hFXnWyqaosSoJY2o3o++HfQL
         YzvOoHUKWzbjIz6aSOyy+Rnx4FFFTeQhGYYDerYrzC/g+tf4YPRTACiwXb2ykB1Gn8Sn
         WsVGAhpGdJ5SlWazYdATdrTaJZ3LdCxJd91id3udPKbPdGcpF9WMQr+TJQ+XYF8R8Kq0
         1TCxFzV805mfg/kzlD7m+ZPa+H3Nvs59YB33bnznZnycPTq4bL5B8HXs0x4jcTK8StLV
         eI9A==
X-Gm-Message-State: AElRT7El68nh5qcfNeosgTfQEc3aFClG4jswqGk7Pi7EHAzYJa387gqo
        atKO2UjfTcYiKEgyHaQUMkE=
X-Google-Smtp-Source: AG47ELteHrCd7MlK8tTK9RVw1usL8LC5TJctTwwJ9vSA62YkrNB1UBcY+Djm+/0lr6h4wtYvibjw0A==
X-Received: by 2002:a19:b588:: with SMTP id g8-v6mr22226440lfk.90.1521877543660;
        Sat, 24 Mar 2018 00:45:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/36] t/helper: merge test-dump-split-index into test-tool
Date:   Sat, 24 Mar 2018 08:44:40 +0100
Message-Id: <20180324074505.19100-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324074505.19100-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
 <20180324074505.19100-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                         |  2 +-
 t/helper/test-dump-split-index.c |  3 +-
 t/helper/test-tool.c             |  1 +
 t/helper/test-tool.h             |  1 +
 t/t0090-cache-tree.sh            |  4 +--
 t/t1700-split-index.sh           | 48 ++++++++++++++++----------------
 6 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/Makefile b/Makefile
index 991bafa6fb..8993cec274 100644
--- a/Makefile
+++ b/Makefile
@@ -659,11 +659,11 @@ TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delta.o
 TEST_BUILTINS_OBJS += test-drop-caches.o
 TEST_BUILTINS_OBJS += test-dump-cache-tree.o
+TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
-TEST_PROGRAMS_NEED_X += test-dump-split-index
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-example-decorate
 TEST_PROGRAMS_NEED_X += test-fake-ssh
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index e44430b699..4e2fdb5e30 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "split-index.h"
 #include "ewah/ewok.h"
@@ -7,7 +8,7 @@ static void show_bit(size_t pos, void *data)
 	printf(" %d", (int)pos);
 }
 
-int cmd_main(int ac, const char **av)
+int cmd__dump_split_index(int ac, const char **av)
 {
 	struct split_index *si;
 	int i;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 3d8d9ed1ce..26ae209cd5 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -14,6 +14,7 @@ static struct test_cmd cmds[] = {
 	{ "delta", cmd__delta },
 	{ "drop-caches", cmd__drop_caches },
 	{ "dump-cache-tree", cmd__dump_cache_tree },
+	{ "dump-split-index", cmd__dump_split_index },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "sha1", cmd__sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 2a0d034adf..e8363e851f 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -8,6 +8,7 @@ int cmd__date(int argc, const char **argv);
 int cmd__delta(int argc, const char **argv);
 int cmd__drop_caches(int argc, const char **argv);
 int cmd__dump_cache_tree(int argc, const char **argv);
+int cmd__dump_split_index(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index f81e3deead..3266209e41 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -246,9 +246,9 @@ test_expect_success 'switching trees does not invalidate shared index' '
 	git update-index --split-index &&
 	>split &&
 	git add split &&
-	test-dump-split-index .git/index | grep -v ^own >before &&
+	test-tool dump-split-index .git/index | grep -v ^own >before &&
 	git commit -m "as-is" &&
-	test-dump-split-index .git/index | grep -v ^own >after &&
+	test-tool dump-split-index .git/index | grep -v ^own >after &&
 	test_cmp before after
 '
 
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index b778975de8..ec179fbaf7 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -11,7 +11,7 @@ sane_unset GIT_FSMONITOR_TEST
 test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
 	git update-index --split-index &&
-	test-dump-split-index .git/index >actual &&
+	test-tool dump-split-index .git/index >actual &&
 	indexversion=$(test-index-version <.git/index) &&
 	if test "$indexversion" = "4"
 	then
@@ -39,7 +39,7 @@ test_expect_success 'add one file' '
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	base $base
 	100644 $EMPTY_BLOB 0	one
@@ -57,8 +57,8 @@ test_expect_success 'disable split index' '
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
-	BASE=$(test-dump-split-index .git/index | grep "^own" | sed "s/own/base/") &&
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	BASE=$(test-tool dump-split-index .git/index | grep "^own" | sed "s/own/base/") &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	not a split index
 	EOF
@@ -73,7 +73,7 @@ test_expect_success 'enable split index again, "one" now belongs to base index"'
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	$BASE
 	replacements:
@@ -91,7 +91,7 @@ test_expect_success 'modify original file, base index untouched' '
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	q_to_tab >expect <<-EOF &&
 	$BASE
 	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
@@ -111,7 +111,7 @@ test_expect_success 'add another file, which stays index' '
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	q_to_tab >expect <<-EOF &&
 	$BASE
 	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
@@ -130,7 +130,7 @@ test_expect_success 'remove file not in base index' '
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	q_to_tab >expect <<-EOF &&
 	$BASE
 	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
@@ -147,7 +147,7 @@ test_expect_success 'remove file in base index' '
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	$BASE
 	replacements:
@@ -165,7 +165,7 @@ test_expect_success 'add original file back' '
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	$BASE
 	100644 $EMPTY_BLOB 0	one
@@ -195,7 +195,7 @@ test_expect_success 'unify index, two files remain' '
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	not a split index
 	EOF
@@ -229,8 +229,8 @@ test_expect_success 'set core.splitIndex config variable to true' '
 	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
-	BASE=$(test-dump-split-index .git/index | grep "^base") &&
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	$BASE
 	replacements:
@@ -248,7 +248,7 @@ test_expect_success 'set core.splitIndex config variable to false' '
 	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	not a split index
 	EOF
@@ -259,8 +259,8 @@ test_expect_success 'set core.splitIndex config variable to true' '
 	git config core.splitIndex true &&
 	: >three &&
 	git update-index --add three &&
-	BASE=$(test-dump-split-index .git/index | grep "^base") &&
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	$BASE
 	replacements:
@@ -269,7 +269,7 @@ test_expect_success 'set core.splitIndex config variable to true' '
 	test_cmp expect actual &&
 	: >four &&
 	git update-index --add four &&
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	$BASE
 	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	four
@@ -283,8 +283,8 @@ test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
 	git config --unset splitIndex.maxPercentChange &&
 	: >five &&
 	git update-index --add five &&
-	BASE=$(test-dump-split-index .git/index | grep "^base") &&
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	$BASE
 	replacements:
@@ -293,7 +293,7 @@ test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
 	test_cmp expect actual &&
 	: >six &&
 	git update-index --add six &&
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	$BASE
 	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	six
@@ -307,8 +307,8 @@ test_expect_success 'check splitIndex.maxPercentChange set to 0' '
 	git config splitIndex.maxPercentChange 0 &&
 	: >seven &&
 	git update-index --add seven &&
-	BASE=$(test-dump-split-index .git/index | grep "^base") &&
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	$BASE
 	replacements:
@@ -317,8 +317,8 @@ test_expect_success 'check splitIndex.maxPercentChange set to 0' '
 	test_cmp expect actual &&
 	: >eight &&
 	git update-index --add eight &&
-	BASE=$(test-dump-split-index .git/index | grep "^base") &&
-	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	$BASE
 	replacements:
-- 
2.17.0.rc0.348.gd5a49e0b6f

