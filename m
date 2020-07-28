Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFE7C433E8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381362075D
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YiPpJ8qX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgG1XfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40852 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730024AbgG1XfG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:06 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8E4AC6101C;
        Tue, 28 Jul 2020 23:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979302;
        bh=Q12wOxJbdk6gJKEFGWWzYzA596jdmVCNFoN+euD0r/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=YiPpJ8qXuxpNB4f+3OJsc6JZsXB43bZW06TdC/kB7QryiP68BOhhO8BXClRfpNrY0
         Sbhg46JnhE7E9BXPHhFJtxBkaSRGsJz/7rOfYrwJeloCe22wSpm+c61Q8jSFO+sHS1
         cf/ZlcA1K+4DwU3OD8XJ9L6V2zUeT3cBAU9hN9+zedkIOlLFUxNNE1BwrTwSdmAnc4
         b96u1Wc8h/2nUeYsV1zdpJ8cYYKh6G+AGSdxjkauOcc7K4pgj2MX3zCd6VClmsE3Ql
         yXJlJqC1IJ/bmV2rkvAbS8HSp+9Gd0/l5y0LZsB2lF//GhHT+bmrdcj1EZGvh7pJJD
         Fraa4aEHMghjzfhZyrOFE9syz1rXDXyWCegEiUNBjj2bQQP+BSIMtN+bhDLlm3d9uw
         AgScYjst8wXw0cyLi1JviG61kuTNP3mqRJFPWYnEf+PhoNiRrLnNlXVm3joD4ssqYV
         t6yL9ixOot8pV0OEoP/EElw2Fa6ix4uSYDN+Y8tl0QVU24B7h4b
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 17/39] t7508: use $ZERO_OID instead of hard-coded constant
Date:   Tue, 28 Jul 2020 23:34:24 +0000
Message-Id: <20200728233446.3066485-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the ZERO_OID variable to abbreviate the all-zeros object ID for
maintainability and to avoid depending on a specific size for the hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7508-status.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 8e969f3e36..e81759319f 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -837,7 +837,7 @@ EOF
 '
 
 cat >expect <<EOF
-:100644 100644 $EMPTY_BLOB 0000000000000000000000000000000000000000 M	dir1/modified
+:100644 100644 $EMPTY_BLOB $ZERO_OID M	dir1/modified
 EOF
 test_expect_success 'status refreshes the index' '
 	touch dir2/added &&
