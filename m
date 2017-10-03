Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25EE1202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 13:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751717AbdJCNnu (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:43:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:59128 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751315AbdJCNnt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:43:49 -0400
Received: (qmail 29448 invoked by uid 109); 3 Oct 2017 13:43:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 13:43:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7909 invoked by uid 111); 3 Oct 2017 13:43:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:43:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 09:43:47 -0400
Date:   Tue, 3 Oct 2017 09:43:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: [PATCH 06/12] t7502: use diff.noprefix for --verbose test
Message-ID: <20171003134347.v3nhmxhp4wr2em3k@sigill.intra.peff.net>
References: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To check that "status -v" respects diff config, we set
"color.diff" and look at the output of "status". We could
equally well use any diff config. Since color output depends
on a lot of other factors (like whether stdout is a tty, and
how we interpret "always"), let's use a more mundane option.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7502-commit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 725687d5d5..d33a3cb331 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -171,9 +171,9 @@ test_expect_success 'verbose' '
 
 test_expect_success 'verbose respects diff config' '
 
-	test_config color.diff always &&
+	test_config diff.noprefix true &&
 	git status -v >actual &&
-	grep "\[1mdiff --git" actual
+	grep "diff --git negative negative" actual
 '
 
 mesg_with_comment_and_newlines='
-- 
2.14.2.1079.gce6b466188

