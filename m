From: Stefan Haller <stefan@haller-berlin.de>
Subject: [PATCH 1/2] gitk: Fix error message when clicking on a connecting line
Date: Thu,  4 Oct 2012 22:50:16 +0200
Message-ID: <1349383817-14457-2-git-send-email-stefan@haller-berlin.de>
References: <506956E1.1080303@viscovery.net>
 <1349383817-14457-1-git-send-email-stefan@haller-berlin.de>
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:41:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJti3-00033L-Ak
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757303Ab2JDUvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 16:51:00 -0400
Received: from server90.greatnet.de ([83.133.96.186]:45020 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757271Ab2JDUu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 16:50:59 -0400
Received: from localhost.localdomain (dslb-088-073-094-229.pools.arcor-ip.net [88.73.94.229])
	by server90.greatnet.de (Postfix) with ESMTPA id EE4872C4074;
	Thu,  4 Oct 2012 22:50:57 +0200 (CEST)
X-Mailer: git-send-email 1.8.0.rc0.36.gef0f079
In-Reply-To: <1349383817-14457-1-git-send-email-stefan@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207017>

When clicking on the line that connects two commit nodes, gitk
would bring up an error dialog saying "can't read "cflist_top":
no such variable".

This fixes a regression that was introduced with b967135 ("gitk:
Synchronize highlighting in file view when scrolling diff").

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 gitk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gitk b/gitk
index 379582a..8935284 100755
--- a/gitk
+++ b/gitk
@@ -7958,6 +7958,8 @@ proc changediffdisp {} {
 proc highlightfile {cline} {
     global cflist cflist_top
 
+    if {![info exists cflist_top]} return
+
     $cflist tag remove highlight $cflist_top.0 "$cflist_top.0 lineend"
     $cflist tag add highlight $cline.0 "$cline.0 lineend"
     $cflist see $cline.0
-- 
1.8.0.rc0.36.gef0f079
