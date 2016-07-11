Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B73B1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 17:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbcGKRXb (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 13:23:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36659 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932496AbcGKRX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 13:23:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so15280084wma.3
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 10:23:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XTxgg9MlrbKn2PR+sAziaU/CI5fTYSmnpSIAhfNOZoY=;
        b=xLMk/rx91RMh9Gf+N0Y/EPXJgf2am38jehig/t+FCQY8wXKzQ7kmP1SVil9UVMD8aH
         mZ2Nh6Y5AmGDRiAsX6AwooNzSUeHtfhlQDOEjraUgSaZWJatQhew9o+k4xkXrW2ALL1s
         kcsu8RgFFN2Gp0RnoYf9rLbVfd4Wff+i45J8wNn1+vNOFtCuHdIaR5XE6URSUZuEG03W
         1Jmsfq3HjGbQ8RAmHDZk/mWe+FX7OA321tZARR7PKE8aeveQUikNkVm9fdPdUM8qFMWJ
         jLoCXwxL4xUWLym45x3mkw/Fl9pSSY3vSnBPwuvirbsD4YG1j8U+JAbZxIBaRxz+TTrR
         JTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XTxgg9MlrbKn2PR+sAziaU/CI5fTYSmnpSIAhfNOZoY=;
        b=cI2V05Di9FEuVs6g5n7SrqjRB0/F+TNNab/l5jLcrGXZuN3jCJLKF5u1jiT0MD396s
         UnFqa46fXj504aDh0ccjARcY+Dz7AKaOvzzW4NBOkqHsSOu8lpOkUt5OynJ//pImXswI
         HOlgC2HvSi7BJVynnk/rj9Q1TF7EIKmKUEOsUSOblM/qCugLeSrsz2FbFxyjeDH99zC7
         gWmk5jMpBFkgXAkbfW6fTxYXm0l2deuJp/TlZNmp/FV884k/TbjTXvcC+hh0tAc3I7sW
         tMoROPvJHIQ61GiUVp9765TQikbhLZ0QTsnfp7mhxyC2eRWJK06Iq+KRa3CVijOcCqoR
         Y8xg==
X-Gm-Message-State: ALyK8tJRTy0/V608qswePxXDCb5cGQzXEK8I7kAzAgFa5EZkPaZg5CRRv+tBIVUx8rRPQA==
X-Received: by 10.28.41.195 with SMTP id p186mr21271095wmp.41.1468257806237;
        Mon, 11 Jul 2016 10:23:26 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id si2sm829442wjb.19.2016.07.11.10.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jul 2016 10:23:25 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 7/8] t1700: add tests for core.splitIndex
Date:	Mon, 11 Jul 2016 19:22:53 +0200
Message-Id: <20160711172254.13439-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.250.g7087ccc.dirty
In-Reply-To: <20160711172254.13439-1-chriscool@tuxfamily.org>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 8aef49f..f1af0d5 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -200,4 +200,41 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'set core.splitIndex config variable to true' '
+	git config core.splitIndex true &&
+	: >three &&
+	git update-index --add three &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	three
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+EOF
+	test_cmp ls-files.expect ls-files.actual &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+replacements:
+deletions:
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'set core.splitIndex config variable to false' '
+	git config core.splitIndex false &&
+	git update-index --force-remove three &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+EOF
+	test_cmp ls-files.expect ls-files.actual &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+not a split index
+EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.9.0.250.g7087ccc.dirty

