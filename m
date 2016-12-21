Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CF731FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 21:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759131AbcLUVds (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 16:33:48 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:62982 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759073AbcLUVdq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 16:33:46 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tkSZb5y6yz5tlK;
        Wed, 21 Dec 2016 22:33:43 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5A3D32222;
        Wed, 21 Dec 2016 22:33:43 +0100 (CET)
Subject: [PATCH 4/2] t5615-alternate-env: double-quotes in file names do not
 work on Windows
To:     Jeff King <peff@peff.net>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
 <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
 <d9d2580c-a2e5-d9f3-1f56-6814b2b2285d@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <00b6235d-c1bc-30c2-6539-6c78c4ce9eb0@kdbg.org>
Date:   Wed, 21 Dec 2016 22:33:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <d9d2580c-a2e5-d9f3-1f56-6814b2b2285d@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Protect a recently added test case with !MINGW.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I don't remember why I did not notice this failure sooner.
 Perhaps I did, but then ran out of time to debug it...

 The patch should go on top of jk/quote-env-path-list-component.

 t/t5615-alternate-env.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
index 69fd8f8911..26ebb0375d 100755
--- a/t/t5615-alternate-env.sh
+++ b/t/t5615-alternate-env.sh
@@ -79,7 +79,7 @@ test_expect_success 'mix of quoted and unquoted alternates' '
 	$two blob
 '
 
-test_expect_success 'broken quoting falls back to interpreting raw' '
+test_expect_success !MINGW 'broken quoting falls back to interpreting raw' '
 	mv one.git \"one.git &&
 	check_obj \"one.git/objects <<-EOF
 	$one blob
-- 
2.11.0.79.gf6b77ca

