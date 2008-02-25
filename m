Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 12415 invoked by uid 111); 25 Feb 2008 19:45:29 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 25 Feb 2008 14:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577AbYBYTpW (ORCPT <rfc822;peff@peff.net>);
	Mon, 25 Feb 2008 14:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755560AbYBYTpW
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 14:45:22 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:57013 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755191AbYBYTpV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 14:45:21 -0500
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id 6156A18DA98;
	Mon, 25 Feb 2008 11:45:19 -0800 (PST)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>
Subject: [PATCH] Add test for filter-branch on a subdirectory that's been added and deleted and re-added
Date:	Mon, 25 Feb 2008 14:45:18 -0500
Message-Id: <1203968718-88226-1-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.4.3.222.gb0bf5
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

---
 t/t7003-filter-branch.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 868babc..9972343 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -179,4 +179,17 @@ test_expect_success 'Name needing quotes' '
 
 '
 
+test_expect_success 'Subdirectory filter on non-contiguous folder' '
+	mkdir foo &&
+	touch foo/bar &&
+	git add foo &&
+	git commit -m "Adding foo" &&
+	git rm -r foo &&
+	git commit -m "Removing foo" &&
+	mkdir foo &&
+	touch foo/bar &&
+	git commit -m "Re-adding foo" &&
+	git filter-branch --subdirectory-filter foo
+'
+
 test_done
-- 
1.5.4.3.222.gb0bf5

