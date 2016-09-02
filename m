Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0257620193
	for <e@80x24.org>; Fri,  2 Sep 2016 17:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933177AbcIBRPu (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 13:15:50 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33077 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933163AbcIBRPr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 13:15:47 -0400
Received: by mail-pf0-f176.google.com with SMTP id g202so21118018pfb.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=A59viY0dXUnfZgx5FTD7ZSEFb+7AEgHGgMU2uFwONX8=;
        b=AukY+emL+WLKrefg1zjoRmttGLjqjJ+XCfbbb50/hqMIFWwfha8M5tbtX9p3y7pAsz
         QBnebfplXzi3kctay49F++hW3GwXhNQlO3/t9rzp6xbiBgl6b8VVH+ffWu5wFS3FC+QJ
         HaYVHkLfLRdh5dxhaSpEnzA4v6bveJ3bUXCbjM7QZ1yJoiFtCp4clpz7vli0NuUOx8+s
         NFpUPheiBB3+nve3tf96Up+lay3e7M1wXD8sTAjYARUIaL1kMq9adDfMYIMFI3TPfPGi
         1VR1SSH7UzZwv4ru/2FvN3UHXKKH9tLih5+BhCQBbEi89jSeZ/tOIOiAr7zQaEZdEAYa
         LtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=A59viY0dXUnfZgx5FTD7ZSEFb+7AEgHGgMU2uFwONX8=;
        b=T0ENaM72DFYmscuf8K8c50uC+s5f/txEudWEIGmiSjlBzdZ+Op0E0bOqt19g1cKfHI
         fAesODBjrnSLjQdCBrEpEkyAiOPpX/yoexj9ATcMD/1k5gjLKWnJ9z9DiQBCyC6Ur5rT
         nT9xws3ZDKwg5PmIMgeZTrooGtVS24Gb7wH+2UFIZK7vVwqjai7N07mnz09O8gBal3ik
         sFR80ZeMjcp0LJLby2WPJJHErctgzT+7S2uWdEhQtF7kQFz9fQPWC2nl5MyUUoRYgSHf
         7tcnxABDa0IpraRGCmt/u3GjcEAZj3uM/NozMDQ8+yee7jxWCFGqcCf3RRq76kY/q2x5
         rxBg==
X-Gm-Message-State: AE9vXwP5YzAJFng6tutOIQaXBGwEkvQWINv3S+MIa3n6o9dF1os/fRKwvyxHytyTU9/4ALc3
X-Received: by 10.98.17.152 with SMTP id 24mr38231795pfr.13.1472836545733;
        Fri, 02 Sep 2016 10:15:45 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id v16sm13914710pfd.32.2016.09.02.10.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 10:15:44 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/2] tests: move test_lazy_prereq JGIT to test-lib.sh
Date:   Fri,  2 Sep 2016 10:15:38 -0700
Message-Id: <360866f27d0bfcefca99b79c33daa9df2b82cee9.1472836026.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1472836026.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
In-Reply-To: <cover.1472836026.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This enables JGIT to be used as a prereq in invocations of
test_expect_success (and other functions) in other test scripts.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5310-pack-bitmaps.sh | 4 ----
 t/test-lib.sh           | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 3893afd..1e376ea 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -158,10 +158,6 @@ test_expect_success 'pack with missing parent' '
 	git pack-objects --stdout --revs <revs >/dev/null
 '
 
-test_lazy_prereq JGIT '
-	type jgit
-'
-
 test_expect_success JGIT 'we can read jgit bitmaps' '
 	git clone . compat-jgit &&
 	(
diff --git a/t/test-lib.sh b/t/test-lib.sh
index d731d66..c9c1037 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1072,6 +1072,10 @@ test_lazy_prereq NOT_ROOT '
 	test "$uid" != 0
 '
 
+test_lazy_prereq JGIT '
+	type jgit
+'
+
 # SANITY is about "can you correctly predict what the filesystem would
 # do by only looking at the permission bits of the files and
 # directories?"  A typical example of !SANITY is running the test
-- 
2.8.0.rc3.226.g39d4020

