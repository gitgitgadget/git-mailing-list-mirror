Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD891F859
	for <e@80x24.org>; Wed,  7 Sep 2016 23:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbcIGXvV (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 19:51:21 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36642 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbcIGXvU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 19:51:20 -0400
Received: by mail-pf0-f174.google.com with SMTP id 128so11374789pfb.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 16:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=A59viY0dXUnfZgx5FTD7ZSEFb+7AEgHGgMU2uFwONX8=;
        b=eXWs+oY1cZTMIEYvMoUHNABdAuaK9C3XMgkiMwvkDNPg4v+GlTtFtxWpdtSLxdHjqf
         rmghg8xAKDKInFD3G6X5Kz7le1zyvw0PdZ1kTZZUsQqg4mF1BRiI1qrsXmUUcnrf6oKk
         Q5Bvt3kLGh4ZmiywWRisC+L1nvmpBxeq3KBhTNZIz4Go5YkujHxvEgOaTV7mwD/QgRH6
         rbcYLXwdp0xPx8jdIkzMS3M3tm1rh2dGmTduRDCylac5eYqO+jpmIRlejNM+Q++E6daB
         mQ4hYVbsVAlFBuodkjaTtE5uZvk6cpfukNRaUZEzG14lbHBdp2h8SM52UZ7p60Vu0TaG
         1ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=A59viY0dXUnfZgx5FTD7ZSEFb+7AEgHGgMU2uFwONX8=;
        b=PvO7ju+r+LCKWuttHPFrGrr9XubhMAie1M+0TM2chEP8b4BMxLOzP4zRgAhffb5OVZ
         7s/o7Klp+eJLEzvqiZwk2w8HATfhxgO/XC6qrQsT7d7d2gOmKjWbliGOHTDOFnRcF7T2
         0cAuBhxP3w3uS+nrTan+V8dYI2opvOFksMDvBdKDXY8rq5gm9xKVeZ1+PaTcwa6CR4FC
         hHB/CYJtSRe2UdBNMZL38G2HNUdQnUj5KhoL0a0srNiNr0r7OWBmISmawy6sqclDsql7
         pSEhD3CD27Wi2yaFhyEZWrpgZIueZAa8KBGTnPT/8pXcmjbAx5VmNulc/oFHf6vgTx/0
         EF/w==
X-Gm-Message-State: AE9vXwMXDWaGPjRSWOzjGW2Zr33ydcVl1li8Po/Ktc78O0TBtsB0HBD//y80EeVMtF+vErDP
X-Received: by 10.98.24.70 with SMTP id 67mr5338035pfy.52.1473292279400;
        Wed, 07 Sep 2016 16:51:19 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id 29sm13825669pfp.88.2016.09.07.16.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 16:51:18 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        spearce@spearce.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com
Subject: [PATCH v3 1/2] tests: move test_lazy_prereq JGIT to test-lib.sh
Date:   Wed,  7 Sep 2016 16:50:56 -0700
Message-Id: <360866f27d0bfcefca99b79c33daa9df2b82cee9.1473291819.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1473291819.git.jonathantanmy@google.com>
References: <cover.1473291819.git.jonathantanmy@google.com>
In-Reply-To: <cover.1473291819.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com> <cover.1473291819.git.jonathantanmy@google.com>
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

