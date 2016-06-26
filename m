Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED8D520179
	for <e@80x24.org>; Sun, 26 Jun 2016 12:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbcFZMZV (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 08:25:21 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33181 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbcFZMZL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 08:25:11 -0400
Received: by mail-pa0-f67.google.com with SMTP id ts6so13036990pac.0
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 05:25:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TIfUGAJxydjGtJLouapsVhyOQjoWhwa6fCf7CWZygNU=;
        b=DpqaHhUHV1PWGDbNiii8y7GU5ETAGKqqa8bDRSsuXOu010Mba9HMPHHD6QVAF8NOtQ
         JN1kvp536npNVBHeq1FUQIeSEe2OEXLgWdY5Wnpf3D/8ZJBlcRXsIUlSukeGWfmQGa4q
         jjjXSkE42FnUOZfv0azpQRmC8UHIOhMIfmFX665wrPXFNn6Loo1YYJiUL8i6yZr6Fo6G
         EdjmGCe7GoGlYTSoQlwvhWa7nx0a41cI4q/9fDLY6oyR/0+Mew+LfGiRYOOMQMb1lRd1
         7qVsn+LdnwQEDfLf6SzUGvhacOCupHpQ7vRoEFUrc4tFcWgzy2yjyGmkTEKxVhGjV6Zd
         piUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TIfUGAJxydjGtJLouapsVhyOQjoWhwa6fCf7CWZygNU=;
        b=d5aS24C0+8uFewLtGAS2fRJf6EJUmQXJvDZqk9qmEFblJN/GXBnhatqkiHS1HyTxPq
         VReeSyZdF5lkOmpAlb2aS6pht9QiYCFtQWz8VHFjDd94sNy9dzz4qDvDVnckVD3wimul
         4/ESrn37CdI2wbTPU9el/wLEPJS2HbpqLvFufBQC39MDGlMM9qOeL+NuuQxY64x6/tFX
         MYVI3OcjqOSKASe8uAzeygL5GJFA2PEXPrvZic9N1q6Lod3G0LFb9VCNb6r7SasPDJ2D
         904ykscHxIQHrWAzv3dsxyPuuqcCv5UFLm1x12KeoL6+H49LcplZUD0+swCqJkWo4bS/
         hGjA==
X-Gm-Message-State: ALyK8tIG3Wky5zHN5KL17IZHQyosJYWFwCPdiWKsS1H833LJ650KJQTjhNAfqfD0DCR1Yw==
X-Received: by 10.66.132.45 with SMTP id or13mr24202493pab.79.1466943910377;
        Sun, 26 Jun 2016 05:25:10 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id e9sm4633670pfg.2.2016.06.26.05.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 05:25:09 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	sunshine@sunshineco.com
Subject: [PATCH v3 2/6] t6030: explicitly test for bisection cleanup
Date:	Sun, 26 Jun 2016 17:53:52 +0530
Message-Id: <20160626122356.28999-3-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160626122356.28999-1-pranit.bauva@gmail.com>
References: <20160626122356.28999-1-pranit.bauva@gmail.com>
In-Reply-To: <20160607205454.22576-1-pranit.bauva@gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is not an improvement in the test coverage but it helps in making
it explicit as to what exactly would be the error as other tests are
focussed on testing other things.

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

