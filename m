Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D4EB1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 21:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbcG2VTT (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 17:19:19 -0400
Received: from mout1.wup.tal.de ([195.8.227.225]:57534 "EHLO mout1.wup.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbcG2VTR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 17:19:17 -0400
Received: from point.localnet (mue-88-130-96-149.dsl.tropolys.de [88.130.96.149])
	(Authenticated sender: ib@wtal.de)
	by smtp.tal.de (Postfix) with ESMTPA id 036B98004CD0;
	Fri, 29 Jul 2016 23:19:12 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.30) id
 1bTFBY-6sS-00; Fri, 29 Jul 2016 23:19:12 +0200
Message-ID: <579bc6ca.10e2ad4d.bm000@wupperonline.de>
From:	=?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
To:	git@vger.kernel.org
Subject: [PATCH v2 1/3] Enhance test t3700-add.sh
Date:	Fri, 29 Jul 2016 23:09:52 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: blueMail/Linux 1.5
Cc:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>
Cc:	Johannes Sixt <j6t@kdbg.org>
Cc:	Edward Thomson <ethomson@edwardthomson.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The files to be tested may already exist and be links which will make
the test fail. So ensure that we are working in a clean environment.

Signed-off-by: Ingo Brückl <ib@wupperonline.de>
---
 t/t3700-add.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 4865304..494f5b8 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -333,6 +333,7 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
 '

 test_expect_success 'git add --chmod=+x stages a non-executable file with +x' '
+	rm -f foo1 &&
 	echo foo >foo1 &&
 	git add --chmod=+x foo1 &&
 	case "$(git ls-files --stage foo1)" in
@@ -342,6 +343,7 @@ test_expect_success 'git add --chmod=+x stages a non-executable file with +x' '
 '

 test_expect_success 'git add --chmod=-x stages an executable file with -x' '
+	rm -f xfoo1 &&
 	echo foo >xfoo1 &&
 	chmod 755 xfoo1 &&
 	git add --chmod=-x xfoo1 &&
@@ -354,6 +356,7 @@ test_expect_success 'git add --chmod=-x stages an executable file with -x' '
 test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
 	git config core.filemode 1 &&
 	git config core.symlinks 1 &&
+	rm -f foo2 &&
 	echo foo >foo2 &&
 	git add --chmod=+x foo2 &&
 	case "$(git ls-files --stage foo2)" in
--
2.9.2

