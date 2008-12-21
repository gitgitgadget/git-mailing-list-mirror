From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] doc/git-fsck: change the way for getting heads' SHA1s
Date: Sun, 21 Dec 2008 17:30:22 +0100
Message-ID: <200812211730.22466.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Dec 21 17:31:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LERDS-0001P7-MR
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 17:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbYLUQaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 11:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbYLUQaR
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 11:30:17 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:53972 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbYLUQaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 11:30:16 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 09A12F7F6C9A;
	Sun, 21 Dec 2008 17:30:15 +0100 (CET)
Received: from [91.19.14.55] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LERC2-00050c-00; Sun, 21 Dec 2008 17:30:14 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/Phh7ngiPWFV/9rG2TKKdFjrtw7cc1oMniu3RK
	OsYOTne/dL1fx8Hp2MaSp1j16RT8ACbNmPs9u2gQeG53vHFuSo
	A4Xqi9g7lN8mNCZ0pMLQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103704>

The straightforward way with using 'cat .git/refs/heads/*' doesn't work
with packed refs as well as branches of the form topic/topic1. So let's
use git-for-each-ref for getting the heads' SHA1s in this example.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/git-fsck.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index d5a7647..287c4fc 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -79,7 +79,8 @@ that aren't readable from any of the specified head nodes.
 
 So for example
 
-	git fsck --unreachable HEAD $(cat .git/refs/heads/*)
+	git fsck --unreachable HEAD \
+		$(git for-each-ref --format="%(objectname)" refs/heads)
 
 will do quite a _lot_ of verification on the tree. There are a few
 extra validity tests to be added (make sure that tree objects are
-- 
1.6.1.rc3.54.g7bef0
