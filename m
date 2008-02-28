Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 11479 invoked by uid 111); 28 Feb 2008 06:33:20 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 28 Feb 2008 01:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbYB1GdQ (ORCPT <rfc822;peff@peff.net>);
	Thu, 28 Feb 2008 01:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbYB1GdG
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 01:33:06 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:42260
	"EHLO randymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751199AbYB1GdD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Feb 2008 01:33:03 -0500
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a5.g.dreamhost.com (Postfix) with ESMTP id 4653090D0F;
	Wed, 27 Feb 2008 22:33:02 -0800 (PST)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>
Subject: [PATCH 3/3] Add test for filter-branch on a subdirectory that's been added and deleted and re-added
Date:	Thu, 28 Feb 2008 01:32:59 -0500
Message-Id: <1204180379-21767-3-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.4.3.233.g52eaf
In-Reply-To: <1204180379-21767-2-git-send-email-kevin@sb.org>
References: <1204180379-21767-1-git-send-email-kevin@sb.org>
 <1204180379-21767-2-git-send-email-kevin@sb.org>
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
1.5.4.3.233.g52eaf

