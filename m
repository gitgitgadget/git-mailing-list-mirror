Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A124F1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 12:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbcG2MnT (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 08:43:19 -0400
Received: from mout1.wup.tal.de ([195.8.227.225]:54331 "EHLO mout1.wup.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbcG2MnS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 08:43:18 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jul 2016 08:43:18 EDT
Received: from point.localnet (mue-88-130-92-095.dsl.tropolys.de [88.130.92.95])
	(Authenticated sender: ib@wtal.de)
	by smtp.tal.de (Postfix) with ESMTPA id 138D48004CC6
	for <git@vger.kernel.org>; Fri, 29 Jul 2016 14:35:28 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.30) id
 1bT70j-3cX-00 for <git@vger.kernel.org>; Fri, 29 Jul 2016 14:35:29 +0200
Message-ID: <579b4ca1.18da2703.bm000@wupperonline.de>
From:	=?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
To:	git@vger.kernel.org
Subject: [PATCH] Fix failing test t3700-add.sh
Date:	Fri, 29 Jul 2016 14:31:28 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: blueMail/Linux 1.5
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

At the time of the test xfoo1 already exists and is a link.
As a result, the check for file mode 100644 fails.

Create not yet existing file xfoo instead.

Signed-off-by: Ingo Brückl <ib@wupperonline.de>
---
 t/t3700-add.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 4865304..aee61b9 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -342,12 +342,12 @@ test_expect_success 'git add --chmod=+x stages a non-executable file with +x' '
 '

 test_expect_success 'git add --chmod=-x stages an executable file with -x' '
-	echo foo >xfoo1 &&
-	chmod 755 xfoo1 &&
-	git add --chmod=-x xfoo1 &&
-	case "$(git ls-files --stage xfoo1)" in
-	100644" "*xfoo1) echo pass;;
-	*) echo fail; git ls-files --stage xfoo1; (exit 1);;
+	echo foo >xfoo &&
+	chmod 755 xfoo &&
+	git add --chmod=-x xfoo &&
+	case "$(git ls-files --stage xfoo)" in
+	100644" "*xfoo) echo pass;;
+	*) echo fail; git ls-files --stage xfoo; (exit 1);;
 	esac
 '

--
2.9.2

