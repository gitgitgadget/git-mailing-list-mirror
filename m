Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E25332070C
	for <e@80x24.org>; Wed,  6 Jul 2016 20:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755651AbcGFU0s (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 16:26:48 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35323 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbcGFU0q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 16:26:46 -0400
Received: by mail-pf0-f194.google.com with SMTP id t190so22636619pfb.2
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 13:26:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pZ70TH4wii961kT2KaKdE+GU4b2kC6pycMvWHiMoemQ=;
        b=nHiEatxtBCqfLvXLvvrhUWSDKrONgPRQWD5cs48TIT5jWEH+vERceUI4x4z6pG9X68
         qtvmJtRmJFmvCvMxg0nKlsOoU+H5XUohbrmRPSXt97uVhuClmcBDQ6OGFa6UXWkP0XkV
         i/R10ZhpxIbRhnZec3xdnG2ZhnnPpntziqSKYdL2YhG0Ha9S8HP3SbCMXSAe3mhBjtan
         EzKs2Dz3oT57QKEooB0uK756OQQqw288y0d8rRuKrOOP/sV7Zl16NE3YKBKMk8jrqJ0e
         4wW1+pvP27BvElza2Ac9t/LGxUOccq385GdA7fVsFgeaqczSEIT8clEM1aKxJ/71Dpn+
         yGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pZ70TH4wii961kT2KaKdE+GU4b2kC6pycMvWHiMoemQ=;
        b=Js873X9trcp/8QdyUP+xu5LSlrcPTYV/MMyG+D+GbUD312LnRRVGWi3zANIe/GnqQJ
         eAHXa0cRfDAp3EtgXYSBzQ7qJl4dq4u1O3vgn9Ph3W5qg36QzIsGsXsAMaqAmCIRUjk4
         bl/GbdbdTmfpF4K0OF6OzjfpRHkTlpkWEbA3cgtx73T/tb172rDbhGfro9uOyHlXYX2/
         eSAXvfuthxw9h7ye7N120ZzQNbzbEQyO/kIUTOdmU7dwYdTENdkK6esbyNm9HvUcy+8w
         D2RseQeWVm+0WoCJgBSEYB531UU+P1ZIHmHkjithjcfbpwX2WptalhDJc9dAlxPbE/Fm
         3Cew==
X-Gm-Message-State: ALyK8tKIDLvYiZFawnjap8L+Ebw0dT+GaHiUOQ84nhJg/J9gLr0IRkJCEaasjAuA7xaipg==
X-Received: by 10.98.216.199 with SMTP id e190mr45261831pfg.76.1467836805857;
        Wed, 06 Jul 2016 13:26:45 -0700 (PDT)
Received: from localhost.localdomain ([27.106.54.176])
        by smtp.gmail.com with ESMTPSA id a87sm6272459pfc.63.2016.07.06.13.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jul 2016 13:26:45 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	sunshine@sunshineco.com
Subject: [PATCH v4 2/6] t6030: explicitly test for bisection cleanup
Date:	Thu,  7 Jul 2016 01:55:19 +0530
Message-Id: <20160706202523.9850-3-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160706202523.9850-1-pranit.bauva@gmail.com>
References: <20160626122356.28999-1-pranit.bauva@gmail.com>
 <20160706202523.9850-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Add test to explicitly check that 'git bisect reset' is working as
expected. This is already covered implicitly by the test suite.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
I faced this problem while converting `bisect_clean_state` and the tests
where showing breakages but it wasn't clear as to where exactly are they
breaking. This will patch  will help in that. Also I tested the test
coverage of the test suite before this patch and it covers this (I did
this by purposely changing names of files in git-bisect.sh and running
the test suite).

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index e74662b..a17f7a6 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -894,4 +894,21 @@ test_expect_success 'bisect start takes options and revs in any order' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git bisect reset cleans bisection state properly' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect reset &&
+	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	test_path_is_missing "$GIT_DIR/BISECT_EXPECTED_REV" &&
+	test_path_is_missing "$GIT_DIR/BISECT_ANCESTORS_OK" &&
+	test_path_is_missing "$GIT_DIR/BISECT_LOG" &&
+	test_path_is_missing "$GIT_DIR/BISECT_RUN" &&
+	test_path_is_missing "$GIT_DIR/BISECT_TERMS" &&
+	test_path_is_missing "$GIT_DIR/head-name" &&
+	test_path_is_missing "$GIT_DIR/BISECT_HEAD" &&
+	test_path_is_missing "$GIT_DIR/BISECT_START"
+'
+
 test_done
-- 
2.9.0

