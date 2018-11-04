Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170171F453
	for <e@80x24.org>; Sun,  4 Nov 2018 09:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbeKDTBp (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 14:01:45 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:52668 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbeKDTBp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 14:01:45 -0500
Received: from localhost.localdomain (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 20412335C31;
        Sun,  4 Nov 2018 09:47:21 +0000 (UTC)
From:   =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH 1/2] t/t7510-signed-commit.sh: Add %GP to custom format checks
Date:   Sun,  4 Nov 2018 10:47:09 +0100
Message-Id: <20181104094710.27859-1-mgorny@gentoo.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test %GP in addition to %GF in custom format checks.  With current
keyring, both have the same value.

Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 t/t7510-signed-commit.sh | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 19ccae286..e8377286d 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -176,8 +176,9 @@ test_expect_success GPG 'show good signature with custom format' '
 	13B6F51ECDDE430D
 	C O Mitter <committer@example.com>
 	73D758744BE721698EC54E8713B6F51ECDDE430D
+	73D758744BE721698EC54E8713B6F51ECDDE430D
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS%n%GF" sixth-signed >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
 	test_cmp expect actual
 '
 
@@ -187,8 +188,9 @@ test_expect_success GPG 'show bad signature with custom format' '
 	13B6F51ECDDE430D
 	C O Mitter <committer@example.com>
 
+
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS%n%GF" $(cat forged1.commit) >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" $(cat forged1.commit) >actual &&
 	test_cmp expect actual
 '
 
@@ -198,8 +200,9 @@ test_expect_success GPG 'show untrusted signature with custom format' '
 	61092E85B7227189
 	Eris Discordia <discord@example.net>
 	D4BE22311AD3131E5EDA29A461092E85B7227189
+	D4BE22311AD3131E5EDA29A461092E85B7227189
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS%n%GF" eighth-signed-alt >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
 	test_cmp expect actual
 '
 
@@ -209,8 +212,9 @@ test_expect_success GPG 'show unknown signature with custom format' '
 	61092E85B7227189
 
 
+
 	EOF
-	GNUPGHOME="$GNUPGHOME_NOT_USED" git log -1 --format="%G?%n%GK%n%GS%n%GF" eighth-signed-alt >actual &&
+	GNUPGHOME="$GNUPGHOME_NOT_USED" git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
 	test_cmp expect actual
 '
 
@@ -220,8 +224,9 @@ test_expect_success GPG 'show lack of signature with custom format' '
 
 
 
+
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS%n%GF" seventh-unsigned >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" seventh-unsigned >actual &&
 	test_cmp expect actual
 '
 
@@ -261,8 +266,9 @@ test_expect_success GPG 'show double signature with custom format' '
 
 
 
+
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS%n%GF" $(cat double-commit.commit) >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" $(cat double-commit.commit) >actual &&
 	test_cmp expect actual
 '
 
-- 
2.19.1

