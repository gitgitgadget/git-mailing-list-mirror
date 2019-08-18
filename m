Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F26D1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 19:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfHRTVG (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 15:21:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57862 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727160AbfHRTVF (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 15:21:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9BDC060779;
        Sun, 18 Aug 2019 19:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566156064;
        bh=Zevcrff+5grEzVWpQvl/rVLpLocwjlh6iPcNEHurD8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Wozu8qUMXo925Otn4eYE65jHG7qt+z6iFOOy8EAqu8b5J7xtmp4XunkWjX9FAZZxc
         nix/mKdAZLoOFmVEU9XEgyXoyIHBEerJe1Yww+mYZ+Bg1GU4HeBeSDwgrNPcCNrEEx
         9bTewPGyOqzP7mnZqJ9IgMkW4ZlWHwAki+xotl+cRW63sj3M3LYlAZc5gEvRc0JdHd
         cjtOqFqAj3NX13T7tcHE5pmbqDdTYaakEDdCDzJ80p8nhqNh2mzgbCRHxTiZ6aSkx0
         023hvKYevEWpWiAYr94VqqdFc4DArEfrVqzBzbUK29rKJw+di+gTZXEgw2XSiSKUOZ
         V9Xx1FGnbBTdA/z82mv/PilJq/PJudODVvw8dG2ZDO0TGb5Ga2QyMzaG8NMh2NyaBH
         61VQqKUIc2ler3ogXvf06iGHUxY6vBY+ADYoZAhbFiSVFqxLJSwPNr6EFjB1YSeIry
         1A2bN0mrycABz6XF6Uhg6KU41x95siALbOU8oqPX2RLULLSuGug
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 12/14] t4000: make hash size independent
Date:   Sun, 18 Aug 2019 19:16:44 +0000
Message-Id: <20190818191646.868106-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818191646.868106-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $ZERO_OID instead of hard-coding a fixed size all-zeros object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4000-diff-format.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index 8de36b7d12..e5116a76a1 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -78,7 +78,7 @@ test_expect_success 'git diff-files --no-patch --patch shows the patch' '
 
 test_expect_success 'git diff-files --no-patch --patch-with-raw shows the patch and raw data' '
 	git diff-files --no-patch --patch-with-raw >actual &&
-	grep -q "^:100644 100755 .* 0000000000000000000000000000000000000000 M	path0\$" actual &&
+	grep -q "^:100644 100755 .* $ZERO_OID M	path0\$" actual &&
 	tail -n +4 actual >actual-patch &&
 	compare_diff_patch expected actual-patch
 '
