Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AC2320193
	for <e@80x24.org>; Wed,  2 Nov 2016 18:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756388AbcKBSRy (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 14:17:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:37579 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752710AbcKBSRy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 14:17:54 -0400
Received: (qmail 8595 invoked by uid 109); 2 Nov 2016 18:17:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 18:17:53 +0000
Received: (qmail 4776 invoked by uid 111); 2 Nov 2016 18:18:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 14:18:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 14:17:51 -0400
Date:   Wed, 2 Nov 2016 14:17:51 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 1/4] t0021: use write_script to create rot13 shell script
Message-ID: <20161102181751.trxsns5pxqk73ukc@sigill.intra.peff.net>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This avoids us fooling around with $SHELL_PATH and the
executable bit ourselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0021-conversion.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index a20b9f58e..dfde22549 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -6,13 +6,11 @@ test_description='blob conversion via gitattributes'
 
 TEST_ROOT="$(pwd)"
 
-cat <<EOF >"$TEST_ROOT/rot13.sh"
-#!$SHELL_PATH
+write_script <<\EOF "$TEST_ROOT/rot13.sh"
 tr \
   'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' \
   'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
 EOF
-chmod +x "$TEST_ROOT/rot13.sh"
 
 generate_random_characters () {
 	LEN=$1
-- 
2.11.0.rc0.258.gf434c15

