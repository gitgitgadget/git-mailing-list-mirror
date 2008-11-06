From: david@statichacks.org
Subject: [PATCH] Added test case for mirror to not push stash refs
Date: Thu,  6 Nov 2008 09:39:14 -0800
Message-ID: <1225993154-3685-1-git-send-email-david@statichacks.org>
References: <20081028212327.GA25358@sigill.intra.peff.net>
Cc: David Bryson <david@statichacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 18:40:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky8qS-00015x-4r
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 18:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbYKFRjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 12:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbYKFRjR
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 12:39:17 -0500
Received: from cryptobackpack.org ([64.105.32.74]:57152 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYKFRjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 12:39:16 -0500
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id D056C10D0219; Thu,  6 Nov 2008 09:39:15 -0800 (PST)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	DNS_FROM_SECURITYSAGE autolearn=no version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id 5EE2410D0023;
	Thu,  6 Nov 2008 09:39:15 -0800 (PST)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id 1EC93164FD6; Thu,  6 Nov 2008 09:39:14 -0800 (PST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <20081028212327.GA25358@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100251>

From: David Bryson <david@statichacks.org>

This test case checks to make sure mirror does not push stashed refs

---
 t/t5517-push-mirror.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index ea49ded..bb263cd 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -123,6 +123,16 @@ test_expect_success 'push mirror adds, updates and removes branches together' '
 
 '
 
+test_expect_success 'push mirror does not push stash refs' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo foo >foo && git add foo && git commit -m 'foo' &&
+		echo bar >foo && git stash save 'WIP' &&
+		git push --mirror up
+	)
+'
 
 # TAG tests
 test_expect_success 'push mirror creates new tags' '
-- 
1.6.0.1
