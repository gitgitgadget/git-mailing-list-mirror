Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2E91FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbdCFJv5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:51:57 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36309 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbdCFJvh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:51:37 -0500
Received: by mail-wr0-f194.google.com with SMTP id l37so20948649wrc.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tfLOpdbmM4s4Hes0s+Xmn8aSmHQlwRaoaYGkBSiX6Pc=;
        b=vKYePI+JYhhldrGwQmFU0LTu3tNzoiJDjMkdz7TARO/6orm66WgqzcvBPxDD8YHgEm
         LtwipYF9jErHvXTk01A3AD4nyuwobpokRKR74ztFJgfogaAoeU26yVkIuORp7gdk4oGD
         RUhFVGheBY55+pCG0lsmsAx9TSfmIzyaaypVEXaRpUIhqYIQ9GnvpU5Maje3D+hbmwvG
         NEn5mMLRLYHa/nQM2/InqTvbrWDiBsspLlB+nareS7KA3eVZHcZv3hAFGWNk09l5xsfJ
         cX5ThqPEz5PiTo4sT+OiQjG1EeMxN7nvUg2oYnn5DI25urnFDmmD0Ond7Xul98OEU1y9
         UoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tfLOpdbmM4s4Hes0s+Xmn8aSmHQlwRaoaYGkBSiX6Pc=;
        b=LP9cUpehnw8ym6bD0yi5doAKVMxoX6REyiGJRoSDytSREXkT9EGBMwyOJxILt4Biw8
         ECMmfHLXrB4041S5OrsNzKCi25eCUsg6gKK5mt1Bcnh13NzIL5KaKOUzeLBxNjIA2dzd
         FgBGqzII3kRJmL8xWbc9n0t8/rJmFVNPqG2+cWG5wT6sFPpFzaK3t8jBMLEMaRMbzl8y
         g4bmtzEDj739+TCpg5hl5+JyYrg7I+E2rjtrLheYjdClYYOyxc5/R35XhIOrAcXC0fcv
         UijBBf6tLaotFqLxIsmopPmloF0EtVOZOC6EjLKTamaHfcdm0kmKfPXxeIDBxsMTgYmG
         jXVw==
X-Gm-Message-State: AMke39mZngAG4JNamMi+pwV4sSCLd7mrnQ0b6Rmf1rlOrOKe+PlBhB1XEy23ebDjSE5Jhw==
X-Received: by 10.223.139.12 with SMTP id n12mr13155940wra.176.1488793354646;
        Mon, 06 Mar 2017 01:42:34 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:33 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 12/22] t1700: add tests for splitIndex.maxPercentChange
Date:   Mon,  6 Mar 2017 10:41:53 +0100
Message-Id: <20170306094203.28250-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 9d7c01c3e1..00a64bed97 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -254,4 +254,76 @@ test_expect_success 'set core.splitIndex config variable to false' '
 	test_cmp expect actual
 '
 
+test_expect_success 'set core.splitIndex config variable to true' '
+	git config core.splitIndex true &&
+	: >three &&
+	git update-index --add three &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual &&
+	: >four &&
+	git update-index --add four &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	four
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
+	git config --unset splitIndex.maxPercentChange &&
+	: >five &&
+	git update-index --add five &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual &&
+	: >six &&
+	git update-index --add six &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	six
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check splitIndex.maxPercentChange set to 0' '
+	git config splitIndex.maxPercentChange 0 &&
+	: >seven &&
+	git update-index --add seven &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual &&
+	: >eight &&
+	git update-index --add eight &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.12.0.206.g74921e51d6.dirty

