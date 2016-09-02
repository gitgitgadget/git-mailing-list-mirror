Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299FA1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 22:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbcIBWGq (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 18:06:46 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33758 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbcIBWGq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 18:06:46 -0400
Received: by mail-pf0-f179.google.com with SMTP id g202so23006302pfb.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 15:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=A59viY0dXUnfZgx5FTD7ZSEFb+7AEgHGgMU2uFwONX8=;
        b=bYQJsR+LmZ2T+D4YeCBDAtcNC0bF9yrbP7YRA4DdMoPhdagTEyO9d2UeKaW7UCeN6J
         jU3N2PgXhRUM/x43WTd7+jVbvXybzWK/Ih1pqOoFMaYTe/iw9cnLr8C8NZZq9kyz1jJM
         /KLP9Cy5GVb+l6Rj9EkACpc8dUJnUn7WWfz6R6OxzNlGjDiGNlcGgXk6ZlEYr0r+V4vL
         vnXUxnV5vC3qjsqOW/n5rn0HbbYuOOO+Al63TuVDzm9qMYKMVjXBGJI5mjIKKoJ4abOm
         CzhccxP+c4Z+I9wCmv1h199m2n0zrkj82QqzZNREJHLO8WanVNdRVHdb7iva1CU3tbX+
         CZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=A59viY0dXUnfZgx5FTD7ZSEFb+7AEgHGgMU2uFwONX8=;
        b=QOCC8rOWAH58Cq10rh7dwAEoqCuPoklSWrwsFHmwZSrFiqpfR6bnwdpMFCiWKQeCBC
         o4419cz1s57Ysw7VxBCME9+3f/4MZEPisE4kfl0Bg2Lt1O2ylymfq19oiLdKOJtKYnP+
         AE+NsSokpwoAXKLEfamggteX08deQrzPm5jPuPLq5PBnLAw5uPlWnor4i3tkXDUxOq+q
         IHMU+maXL2aCUzukWnfcoN2Aq1xDSDnyybrulPLsloggz/Rra61/75apKVGrzEn6hIeH
         13Ux2Ldnr3oriSSJhPhpY7yU0v1Jq354MxPunUMpZleYZRK86rnEF3ir1i1LvSi9653C
         MyHA==
X-Gm-Message-State: AE9vXwO7oLpMM5pWtNNf5BsYvP7T9HWId6oJbRYsUyAMi2BDgzqQlCGEf4GU7HWiwHItkNjM
X-Received: by 10.98.100.67 with SMTP id y64mr40377130pfb.84.1472854005216;
        Fri, 02 Sep 2016 15:06:45 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id h86sm17007557pfh.46.2016.09.02.15.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 15:06:44 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        spearce@spearce.org, sbeller@google.com, peff@peff.net
Subject: [PATCH v2 1/2] tests: move test_lazy_prereq JGIT to test-lib.sh
Date:   Fri,  2 Sep 2016 15:06:11 -0700
Message-Id: <360866f27d0bfcefca99b79c33daa9df2b82cee9.1472853827.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1472853827.git.jonathantanmy@google.com>
References: <cover.1472853827.git.jonathantanmy@google.com>
In-Reply-To: <cover.1472853827.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com> <cover.1472853827.git.jonathantanmy@google.com>
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

