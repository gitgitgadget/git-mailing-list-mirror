From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 4/4] t0050: Add test for case insensitive add
Date: Sun, 11 May 2008 18:16:42 +0200
Message-ID: <1210522602-4724-4-git-send-email-prohaska@zib.de>
References: <1210522602-4724-1-git-send-email-prohaska@zib.de>
 <1210522602-4724-2-git-send-email-prohaska@zib.de>
 <1210522602-4724-3-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 18:18:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvEFZ-0008VV-Ux
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 18:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbYEKQRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 12:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753671AbYEKQRX
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 12:17:23 -0400
Received: from mailer.zib.de ([130.73.108.11]:62456 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754109AbYEKQQy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 12:16:54 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m4BGGiJK004673;
	Sun, 11 May 2008 18:16:44 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m4BGGgDX019981;
	Sun, 11 May 2008 18:16:43 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1210522602-4724-3-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81781>

Add should recognize if a file is added with a different case and add
the file using its original name.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t0050-filesystem.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 399b45d..0e33c4b 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -77,6 +77,16 @@ $test_case 'merge (case change)' '
 
 '
 
+$test_case 'add (with different case)' '
+
+	git reset --hard initial &&
+	rm camelcase &&
+	echo 1 >CamelCase &&
+	git add CamelCase &&
+	test $(git-ls-files | grep -i camelcase | wc -l) = 1
+
+'
+
 test_expect_success "setup unicode normalization tests" '
 
   test_create_repo unicode &&
-- 
1.5.5.1.313.g9decb
