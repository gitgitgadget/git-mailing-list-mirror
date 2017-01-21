Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93CE61F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 21:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbdAUV7n (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 16:59:43 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38706 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751418AbdAUV7j (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Jan 2017 16:59:39 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 02CA5280AF;
        Sat, 21 Jan 2017 21:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485035966;
        bh=Idy/ULemsTZHEe7FB4WTjyfACxjeXvs+7fogbk2yyEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0TY9WhxbJ1I6qTWQQdGAFqdKm/0JncbVQLHkYnBBvFHoggaWP/seWq5RcR+58m8Ye
         clbcRQieehO1n38MtsRvTi7+9s8ifzdYSg7W+PzShidjBLw6y7Z3B2l3o0DCU+nv7M
         CG5d49pCiRVcRW5H4aW1dmMdGGdwLfSLhTkhDTTsyfeq/F/SWFkjgVlYv+MxbERyXa
         ekrZHW1VQ/7rXPUVJLWOmheMHvIMigEPoSqNwSZWlJOAOxJu9UewHRR9FIx/tZOC24
         skVTmgjZe5D3spamF7hj2doNB9S0c+fV7J741o6c+k1nFvnCYvVADvkYOJ2LPkPYRS
         wtTMNykc2QNld8xIjv9cKbcQJQKVIR7bBYDuywgRqGO/AQ268a1PdCNriTcHH7SSDy
         +UzT1RSs5D2QzwIqrIPc1fY33yYixGVapvT5DwQuOB9kkTQfGrgoVZxrbhRaiEgwWu
         7JiObiiq1QlAusWcnfhlrE3luy5m4SQJppoVRSGIg1mj4dUtxpO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH 3/7] Documentation: remove unneeded argument in cat-texi.perl
Date:   Sat, 21 Jan 2017 21:59:08 +0000
Message-Id: <20170121215912.246691-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170121215912.246691-1-sandals@crustytoothpaste.net>
References: <20170121215912.246691-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The newly-added use of the warnings pragma exposes that the $menu[0]
argument to printf has long been silently ignored, since there is no
format specifier for it.  It doesn't appear that the argument is
actually needed, either: there is no reason to insert the name of one
particular documentation page anywhere in the header that's being
generated.

Remove the unused argument, and since the format specification
functionality is no longer needed, convert the printf to a simple print.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/cat-texi.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/cat-texi.perl b/Documentation/cat-texi.perl
index 1bc84d3c7..14d2f8341 100755
--- a/Documentation/cat-texi.perl
+++ b/Documentation/cat-texi.perl
@@ -20,7 +20,7 @@ while (<STDIN>) {
 }
 close $tmp;
 
-printf '\input texinfo
+print '\input texinfo
 @setfilename gitman.info
 @documentencoding UTF-8
 @dircategory Development
@@ -31,7 +31,7 @@ printf '\input texinfo
 @top Git Manual Pages
 @documentlanguage en
 @menu
-', $menu[0];
+';
 
 for (@menu) {
 	print "* ${_}::\n";
