From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 08/10] git p4 test: cleanup_git should make a new $git
Date: Wed, 27 Jun 2012 08:01:01 -0400
Message-ID: <1340798463-14499-9-git-send-email-pw@padd.com>
References: <1340798463-14499-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 14:04:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjqyQ-0006WX-Bf
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 14:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805Ab2F0MDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 08:03:51 -0400
Received: from honk.padd.com ([74.3.171.149]:52793 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756682Ab2F0MDu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 08:03:50 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id C459AD02;
	Wed, 27 Jun 2012 05:03:46 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 453A931383; Wed, 27 Jun 2012 08:03:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.130.gb957a79
In-Reply-To: <1340798463-14499-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200721>

For convenience, leave one in place at the end of each
test so that it is not necessary to build a new one.  This
makes it consistent with $cli.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh           | 3 ++-
 t/t9800-git-p4-basic.sh   | 1 +
 t/t9806-git-p4-options.sh | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 4c5b1f6..0bc3566 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -86,5 +86,6 @@ kill_p4d() {
 }
 
 cleanup_git() {
-	rm -rf "$git"
+	rm -rf "$git" &&
+	mkdir "$git"
 }
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 60c1f57..234f727 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -270,6 +270,7 @@ test_expect_success 'wildcard files submit back to p4, delete' '
 '
 
 test_expect_success 'clone bare' '
+	rm -rf "$git" &&
 	git p4 clone --dest="$git" --bare //depot &&
 	test_when_finished cleanup_git &&
 	(
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index a37c6cb..fa40cc8 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -149,7 +149,6 @@ test_expect_success 'clone --use-client-spec' '
 	cleanup_git &&
 
 	# same thing again, this time with variable instead of option
-	mkdir "$git" &&
 	(
 		cd "$git" &&
 		git init &&
-- 
1.7.11.1.69.gd505fd2
