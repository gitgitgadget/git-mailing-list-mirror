Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495E3C352A3
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198FB20838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AcdMw+iU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBGAxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55558 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbgBGAxg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:36 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 60B686079D;
        Fri,  7 Feb 2020 00:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036815;
        bh=16Rgy4p2DXyJ6z16HIxC/Myn1XohcOeL1MpmP6C7jx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=AcdMw+iUJGOJKMgrESt7fWnilwYlJKRLjxVGya4gpIMAc0YN7SdEVTzwNg629k0U0
         Cr81KdRs93l48JcQ9+PsJjxs5Twdkl9XsdhzbA+1VfiwlM7WLg5nEXQiUuZdtvPVe8
         OwLM74ckttNEtW+8zaNWMl7Xa92ITlGg0xKWHE5EYxZVJsA7urH5M5LgxphG6QFI8/
         TBYCE7g6eHs6ktni/+AihUXzOTXV0dIEDVKHtHvl29JPbDhXDG8MpdlTz3chOqXsdD
         6vdjBJ2/IuEXx9ze7gh+AnX00Ktx2u6TUwsHcnx+GsGbjqx8v3efLPr4tnz286jNMu
         KJs9TMuBH0OLQVxW2Yly6BrdbVpqeNthP2JGbH/g6WQGz9OYOfLk1x84LPXSs1FHQl
         5G8xCLHPgc6KV/rZpVMtvgOuFe8kMclX6IKlXUgAfIakst9oGDEkNiTpR7GPCtnoXI
         FebcwU0sCl6TgoaS0acXPN+i24jIlQE8OKRYretAwLMG5Cm2LfJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/21] t4211: move SHA-1-specific test cases into a directory
Date:   Fri,  7 Feb 2020 00:52:41 +0000
Message-Id: <20200207005254.1495851-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for adding SHA-256 support to this test, let's move the
SHA-1-specific expected output into a directory called "sha1".  This
will allow us to add a similar directory for SHA-256 as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4211-line-log.sh                                 | 2 +-
 t/t4211/{ => sha1}/expect.beginning-of-file         | 0
 t/t4211/{ => sha1}/expect.end-of-file               | 0
 t/t4211/{ => sha1}/expect.move-support-f            | 0
 t/t4211/{ => sha1}/expect.multiple                  | 0
 t/t4211/{ => sha1}/expect.multiple-overlapping      | 0
 t/t4211/{ => sha1}/expect.multiple-superset         | 0
 t/t4211/{ => sha1}/expect.parallel-change-f-to-main | 0
 t/t4211/{ => sha1}/expect.simple-f                  | 0
 t/t4211/{ => sha1}/expect.simple-f-to-main          | 0
 t/t4211/{ => sha1}/expect.simple-main               | 0
 t/t4211/{ => sha1}/expect.simple-main-to-end        | 0
 t/t4211/{ => sha1}/expect.two-ranges                | 0
 t/t4211/{ => sha1}/expect.vanishes-early            | 0
 14 files changed, 1 insertion(+), 1 deletion(-)
 rename t/t4211/{ => sha1}/expect.beginning-of-file (100%)
 rename t/t4211/{ => sha1}/expect.end-of-file (100%)
 rename t/t4211/{ => sha1}/expect.move-support-f (100%)
 rename t/t4211/{ => sha1}/expect.multiple (100%)
 rename t/t4211/{ => sha1}/expect.multiple-overlapping (100%)
 rename t/t4211/{ => sha1}/expect.multiple-superset (100%)
 rename t/t4211/{ => sha1}/expect.parallel-change-f-to-main (100%)
 rename t/t4211/{ => sha1}/expect.simple-f (100%)
 rename t/t4211/{ => sha1}/expect.simple-f-to-main (100%)
 rename t/t4211/{ => sha1}/expect.simple-main (100%)
 rename t/t4211/{ => sha1}/expect.simple-main-to-end (100%)
 rename t/t4211/{ => sha1}/expect.two-ranges (100%)
 rename t/t4211/{ => sha1}/expect.vanishes-early (100%)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 8319163744..63a3bf28a5 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -11,7 +11,7 @@ test_expect_success 'setup (import history)' '
 canned_test_1 () {
 	test_expect_$1 "$2" "
 		git log $2 >actual &&
-		test_cmp \"\$TEST_DIRECTORY\"/t4211/expect.$3 actual
+		test_cmp \"\$TEST_DIRECTORY\"/t4211/sha1/expect.$3 actual
 	"
 }
 
diff --git a/t/t4211/expect.beginning-of-file b/t/t4211/sha1/expect.beginning-of-file
similarity index 100%
rename from t/t4211/expect.beginning-of-file
rename to t/t4211/sha1/expect.beginning-of-file
diff --git a/t/t4211/expect.end-of-file b/t/t4211/sha1/expect.end-of-file
similarity index 100%
rename from t/t4211/expect.end-of-file
rename to t/t4211/sha1/expect.end-of-file
diff --git a/t/t4211/expect.move-support-f b/t/t4211/sha1/expect.move-support-f
similarity index 100%
rename from t/t4211/expect.move-support-f
rename to t/t4211/sha1/expect.move-support-f
diff --git a/t/t4211/expect.multiple b/t/t4211/sha1/expect.multiple
similarity index 100%
rename from t/t4211/expect.multiple
rename to t/t4211/sha1/expect.multiple
diff --git a/t/t4211/expect.multiple-overlapping b/t/t4211/sha1/expect.multiple-overlapping
similarity index 100%
rename from t/t4211/expect.multiple-overlapping
rename to t/t4211/sha1/expect.multiple-overlapping
diff --git a/t/t4211/expect.multiple-superset b/t/t4211/sha1/expect.multiple-superset
similarity index 100%
rename from t/t4211/expect.multiple-superset
rename to t/t4211/sha1/expect.multiple-superset
diff --git a/t/t4211/expect.parallel-change-f-to-main b/t/t4211/sha1/expect.parallel-change-f-to-main
similarity index 100%
rename from t/t4211/expect.parallel-change-f-to-main
rename to t/t4211/sha1/expect.parallel-change-f-to-main
diff --git a/t/t4211/expect.simple-f b/t/t4211/sha1/expect.simple-f
similarity index 100%
rename from t/t4211/expect.simple-f
rename to t/t4211/sha1/expect.simple-f
diff --git a/t/t4211/expect.simple-f-to-main b/t/t4211/sha1/expect.simple-f-to-main
similarity index 100%
rename from t/t4211/expect.simple-f-to-main
rename to t/t4211/sha1/expect.simple-f-to-main
diff --git a/t/t4211/expect.simple-main b/t/t4211/sha1/expect.simple-main
similarity index 100%
rename from t/t4211/expect.simple-main
rename to t/t4211/sha1/expect.simple-main
diff --git a/t/t4211/expect.simple-main-to-end b/t/t4211/sha1/expect.simple-main-to-end
similarity index 100%
rename from t/t4211/expect.simple-main-to-end
rename to t/t4211/sha1/expect.simple-main-to-end
diff --git a/t/t4211/expect.two-ranges b/t/t4211/sha1/expect.two-ranges
similarity index 100%
rename from t/t4211/expect.two-ranges
rename to t/t4211/sha1/expect.two-ranges
diff --git a/t/t4211/expect.vanishes-early b/t/t4211/sha1/expect.vanishes-early
similarity index 100%
rename from t/t4211/expect.vanishes-early
rename to t/t4211/sha1/expect.vanishes-early
