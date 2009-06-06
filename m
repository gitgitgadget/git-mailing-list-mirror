From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit 3/4] Avoid submenus with merely 1 entry
Date: Sat,  6 Jun 2009 13:57:50 +0200
Message-ID: <1244289471-698-4-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 13:59:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCuXz-0007Qq-Et
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 13:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbZFFL6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 07:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753395AbZFFL6V
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 07:58:21 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:59870 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401AbZFFL6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 07:58:18 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 688831049D227;
	Sat,  6 Jun 2009 13:58:20 +0200 (CEST)
Received: from [89.59.108.98] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MCuXU-0006b6-00; Sat, 06 Jun 2009 13:58:20 +0200
X-Mailer: git-send-email 1.6.3.2.213.g30b07
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19NE/RCMRq2+ASBB8XFTL4Xbs+aaqe+Rt1EB1Fn
	ooAucnAOWjHwysMy+RFHpsETjvQql/KP1SmEeplzlAncfOUBn4
	fd5GSXLakXPLNUJW4QEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120911>

Display the branch/tag in the main context menu in these cases, where
only the last branch/tag would go into a submenu.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 src/mainimpl.cpp |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/mainimpl.cpp b/src/mainimpl.cpp
index 24b4ef1..38bbfbe 100644
--- a/src/mainimpl.cpp
+++ b/src/mainimpl.cpp
@@ -1197,7 +1197,8 @@ void MainImpl::doContexPopup(SCRef sha) {
 			contextMenu.addSeparator();
 
 		FOREACH_SL (it, bn) {
-			if (cntMenuEntries(contextMenu) < MAX_MENU_ENTRIES)
+			if (cntMenuEntries(contextMenu) < MAX_MENU_ENTRIES
+					|| (*it == bn.last() && contextSubMenu.isEmpty() && tn.empty()))
 				act = contextMenu.addAction(*it);
 			else
 				act = contextSubMenu.addAction(*it);
@@ -1211,7 +1212,8 @@ void MainImpl::doContexPopup(SCRef sha) {
 				contextMenu.addSeparator();
 
 		FOREACH_SL (it, tn) {
-			if (cntMenuEntries(contextMenu) < MAX_MENU_ENTRIES)
+			if (cntMenuEntries(contextMenu) < MAX_MENU_ENTRIES
+					|| (*it == tn.last() && contextSubMenu.isEmpty()))
 				act = contextMenu.addAction(*it);
 			else
 				act = contextSubMenu.addAction(*it);
-- 
1.6.3.2.213.g30b07
