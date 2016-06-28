Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742852018B
	for <e@80x24.org>; Tue, 28 Jun 2016 18:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbcF1ST7 (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:19:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36372 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbcF1STz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:19:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id c82so7984507wme.3
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 11:19:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G7znJTIl05k4xaP42oqXWHg2IufC9g9EWoW09BPFm/Q=;
        b=m15EbbleUFCrOBKFEyKTV+J8jExlvgrH2ZYYfn3jkbmLR8BVgSo3iH/wsgihGyF3n5
         ngneYhNBJNDwHqaBtmXhgs1BhEPwMaMgnQCA7qej+RPOMPJXbjmxg4YwmbzKzF4KX3IR
         U853SvUyUm9g6sTo07A7rJJvEq8/OuO14dRzprUJeEDk8KfGgRNVXnDsIOX8mOmzOmOo
         CwPu69/H+Cy6GVFDRn5Nki4DilO8xocADJT19e//7Mqru/DpSLdjiWSCA9tFBaOdmeZF
         zFVkeKCuMgUnoIVNUfe8Ql9LNAH9y3b4i7peKrvemu3RdSLtmDLSv6WmqRwQyE0frwh1
         TRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G7znJTIl05k4xaP42oqXWHg2IufC9g9EWoW09BPFm/Q=;
        b=WB3bnws1lJYodUBNIheBRBc2eomLr1DuSpeXHWjRr27Vh7IKQpbuh/g33KlWRjqt0z
         BoBQiuYA20kl9c8eJJ9nzcPBOFnmgiG1RZqyKB3e5KOc8C5/c1xql/mK5Sikvt0NfeWj
         lcO8GKVqSHHlchDyT/OTBEx5Q/FsDuOakeB9zy5R3e+me/ECsJPyVbibxVm3i9NgOPOF
         3gwZOJl4RmZcn8AxCcH+GEKRutmt5Q0KgsT2ZT55woZzl2xxgqOIjzeGx0k3o/euPTed
         T2o0XJeC/mbkyX+vVn4899n+UqKdv2oUwws/zXrF7hEDhdJPWnBZEpM47gSMEb1WLmxj
         45FA==
X-Gm-Message-State: ALyK8tLX1RfRMl/Q6cn3pMsKqybelzxltnc9y5rSb3+EF9y3UJzhM5SN1S3njcoTioa0Iw==
X-Received: by 10.28.176.7 with SMTP id z7mr4660448wme.17.1467137993681;
        Tue, 28 Jun 2016 11:19:53 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id yr4sm2061048wjc.18.2016.06.28.11.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 11:19:52 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v2 05/10] t0400: add test for 'put' command
Date:	Tue, 28 Jun 2016 20:19:28 +0200
Message-Id: <20160628181933.24620-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.11.g990c140
In-Reply-To: <20160628181933.24620-1-chriscool@tuxfamily.org>
References: <20160628181933.24620-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 0f1bb97..6c6da5c 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -57,4 +57,13 @@ test_expect_success 'helper can retrieve alt objects' '
 	test_cmp expect actual
 '
 
+test_expect_success 'helper can add objects to alt repo' '
+	hash=$(echo "Hello odb!" | git hash-object -w -t blob --stdin) &&
+	test -f .git/objects/$(echo $hash | sed "s#..#&/#") &&
+	size=$(git cat-file -s "$hash") &&
+	git cat-file blob "$hash" | ./odb-helper put "$hash" "$size" blob &&
+	alt_size=$(cd alt-repo && git cat-file -s "$hash") &&
+	test "$size" -eq "$alt_size"
+'
+
 test_done
-- 
2.9.0.rc2.11.g990c140

