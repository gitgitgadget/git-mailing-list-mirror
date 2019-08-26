Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB8E71F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 01:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfHZBoS (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:44:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58328 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729064AbfHZBoS (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 21:44:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9793861386;
        Mon, 26 Aug 2019 01:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566783857;
        bh=Zevcrff+5grEzVWpQvl/rVLpLocwjlh6iPcNEHurD8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Qf+4Qp/PO1irPP1TjCiELYqNH/ruCUVkvKrxTelgSTprrlKnkSIOYyoY0jC8Jcmud
         v0EmNaR6k2H+imuvi8Ubc7UDEn5p0dcZLsyn8TgjpLOOLEqCMcZWoizPsZBWX+JecA
         NTu/70TjGf/gQC5dGvYwCBOHyqraPE6P/fzzC3/UGjdpPJcwtWvSRmBJd1cgpPJjl2
         E7vrEl6Teu0QTQ5N/BMqGXwK/yCW/nEDJd2gHdXlHmYDGNFSxTIEe7+G+sKo1BXx+R
         TivQvJth//A+9gTE0iMkqXCDdihtLa1KbZZ0y9owPGdP0ET8seLBt4E7P63kaRrEhq
         6pneRKONLjROa2fbshgwBcGu+ekZiqXDSm4DflCh3lLy9bZ3FzBTxj3aHd1MbhQZXP
         ePMWopiIt2hh12IM4Rst6z4vniJSyPHSFCTKqdd/RcF69M2C2mMNf1jGKTXxS1yblw
         3KvTlAwqQ8jc27mXUh5DiklyCHsoVd2NxyLhNSswKy0VgcnljpO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 12/14] t4000: make hash size independent
Date:   Mon, 26 Aug 2019 01:43:42 +0000
Message-Id: <20190826014344.16008-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c
In-Reply-To: <20190826014344.16008-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
 <20190826014344.16008-1-sandals@crustytoothpaste.net>
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
