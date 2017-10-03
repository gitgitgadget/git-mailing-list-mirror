Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B62202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 13:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbdJCNpV (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:45:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:59186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751238AbdJCNpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:45:20 -0400
Received: (qmail 29644 invoked by uid 109); 3 Oct 2017 13:45:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 13:45:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7989 invoked by uid 111); 3 Oct 2017 13:45:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:45:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 09:45:18 -0400
Date:   Tue, 3 Oct 2017 09:45:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: [PATCH 10/12] t3205: use --color instead of color.branch=always
Message-ID: <20171003134518.4egfo7oqpemo3a7q@sigill.intra.peff.net>
References: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To test the color output, we must convince "git branch" to
write colors to a non-terminal. We do that now by setting
the color config to "always".  In preparation for the
behavior of "always" changing, let's switch to using the
"--color" command-line option, which is more direct.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3205-branch-color.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t3205-branch-color.sh b/t/t3205-branch-color.sh
index 9343550f50..4f1e16bb44 100755
--- a/t/t3205-branch-color.sh
+++ b/t/t3205-branch-color.sh
@@ -12,7 +12,6 @@ test_expect_success 'set up some sample branches' '
 # choose non-default colors to make sure config
 # is taking effect
 test_expect_success 'set up some color config' '
-	git config color.branch always &&
 	git config color.branch.local blue &&
 	git config color.branch.remote yellow &&
 	git config color.branch.current cyan
@@ -24,7 +23,7 @@ test_expect_success 'regular output shows colors' '
 	  <BLUE>other<RESET>
 	  <YELLOW>remotes/origin/master<RESET>
 	EOF
-	git branch -a >actual.raw &&
+	git branch --color -a >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expect actual
 '
@@ -36,7 +35,7 @@ test_expect_success 'verbose output shows colors' '
 	  <BLUE>other                <RESET> $oid foo
 	  <YELLOW>remotes/origin/master<RESET> $oid foo
 	EOF
-	git branch -v -a >actual.raw &&
+	git branch --color -v -a >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expect actual
 '
-- 
2.14.2.1079.gce6b466188

