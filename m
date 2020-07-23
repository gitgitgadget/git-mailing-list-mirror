Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8340C4345C
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AA62053B
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="s3WxN6ME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbgGWBJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:09:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40490 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733147AbgGWBJy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:09:54 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 59C3F60758
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466593;
        bh=YnqhRm5cXPRi/ZkOai5UFwRTufPby2S7+lcAS3bYyKE=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=s3WxN6ME5xbE0ZE8aNABYFP+k2hE5NO0G036FfW6780su7KZoJHXCWqgB4Vmi0QMK
         4z6Z/9xhlh46rmWVt57bRSCiKMnkYAp7HmwUUswfUHG0xfMMYjrBKcwWXU55to1DIR
         bFxuwFIdNnOm4/S5M8IATQdlzPbqdm7weZRgJgt9gjRxUGMbF5J+MM/TYBkz214d7z
         6K2hX2Fp9CxdroVcZi+I5JeyExpkS4BMeL6/WEwXGwUwgRAepx027MA/six0/9HSZ6
         8STAc9gD2Jm3g4sLa3VNmxSzxsaLJpYnruMNfOepmPqBp34zJ2v/DAXzWG1xzaaXR9
         uheBOKBqgXKsPwldg+VUIBhRj2c1ia/kGaQGm92uGr8AGsdNzQnYsb47VgFKX2Oq0V
         UWXWj2pfon/QrdghZAlF0ctuS/99YIMrkflJrYefWLIS0zVWwlD0uvwleBpD9DKRVh
         ZB46vEhUhO3rA62/NZbmyCHmlTgI57fG7qqbjUVkM8fdqtUmTyC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 06/39] t6101: make hash size independent
Date:   Thu, 23 Jul 2020 01:09:10 +0000
Message-Id: <20200723010943.2329634-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $OID_REGEX instead of a hard-coded regular expression.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6101-rev-parse-parents.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 7683e4a114..7531262a5e 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -34,7 +34,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'start is valid' '
-	git rev-parse start | grep "^[0-9a-f]\{40\}$"
+	git rev-parse start | grep "^$OID_REGEX$"
 '
 
 test_expect_success 'start^0' '
