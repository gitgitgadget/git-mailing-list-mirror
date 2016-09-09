Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D94F1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 20:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754769AbcIIURv (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 16:17:51 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36204 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754739AbcIIURt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 16:17:49 -0400
Received: by mail-pa0-f53.google.com with SMTP id id6so31398957pad.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=A59viY0dXUnfZgx5FTD7ZSEFb+7AEgHGgMU2uFwONX8=;
        b=o+3mVfMIT5r6RHUyEASGCkJksc32CCy5cw5epeP5FGoBehbdklOE0OW9nOVdS/ksAA
         6tHQg8QN9mCOamCnxpmyIeX01ReNgCnrT2vF6cbJlspdHFXRXf2jlhXT8QKWkauYICIy
         dwNxb4gR297EzOGON8Tpkc+t5ZdOnIm7uWLwmoWOGLhJtSrZCZa/6bwws6zu9gSCaGwr
         C8EbuHCVCXwBkJ96hJ+x5W4dkxGxRVOJ54fg+UmpP2xUI7nl+SI/eBh33BCBnLhFoLDv
         x5kDnSaTsqe3PiR9r586ugUmWs9sLy/sFYdtda/FXw/qdXBkYpcSVmTB8hnsyl2hXr4Y
         zixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=A59viY0dXUnfZgx5FTD7ZSEFb+7AEgHGgMU2uFwONX8=;
        b=ah5JhCTqJ5jK5YtP+VGalmAZxsin67l872gK02QGmu2H9fud/d/wtf0+c3vfWBfgws
         913ORVNn0iXeB1yl/n8jCwgJ+uPGllCsqu0Rt9XClyX2MOYFKW0j5zFGnJHg1ghLpOR5
         kGIfLSgGv2bZx4Bl6VuctcvjwxeYrjJkwAdTwIOprfs3mlirEx/NOFdI7zdSowR+k6Ws
         iGE6cou86S/Ru5jQR+/QeVu3iJGdY8gMtWCAsismLaYJdndylx/ysA+kqPnqd189tIvB
         GlACDrYU3rH+O3fIrpLrwdRVzwJkFmX9wTK1I1e7rkJEOt74xhfJ6m5G5meho02erjCI
         5law==
X-Gm-Message-State: AE9vXwPGD+IkagcMPJSoiuyjeKFUX9bCQyIrE/ihUHGFMyckt5rFMjMjgqC2i3CmrxvMVFM9
X-Received: by 10.66.135.175 with SMTP id pt15mr9760280pab.134.1473452263342;
        Fri, 09 Sep 2016 13:17:43 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id s1sm7203690paz.47.2016.09.09.13.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Sep 2016 13:17:41 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        gitster@pobox.com
Subject: [PATCH v5 1/3] tests: move test_lazy_prereq JGIT to test-lib.sh
Date:   Fri,  9 Sep 2016 13:17:35 -0700
Message-Id: <37c4e775948b88b2d5af1caee3a70e36f00bc88a.1473452153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1473452153.git.jonathantanmy@google.com>
References: <cover.1473452153.git.jonathantanmy@google.com>
In-Reply-To: <cover.1473452153.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com> <cover.1473452153.git.jonathantanmy@google.com>
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

