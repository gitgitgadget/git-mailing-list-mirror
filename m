From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] mergetool: avoid misleading message "Resetting to default..."
Date: Thu, 18 Oct 2007 12:25:34 +0200
Message-ID: <11927031342272-git-send-email-prohaska@zib.de>
References: <4591BA15-EB6B-4058-A2D0-879556481E59@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Oct 18 12:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiSZg-0007SD-M9
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 12:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760482AbXJRKZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 06:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760827AbXJRKZp
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 06:25:45 -0400
Received: from mailer.zib.de ([130.73.108.11]:62826 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760482AbXJRKZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 06:25:44 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9IAPYog002067;
	Thu, 18 Oct 2007 12:25:42 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9IAPYA4006120;
	Thu, 18 Oct 2007 12:25:34 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <4591BA15-EB6B-4058-A2D0-879556481E59@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61511>

If no mergetool is configured in the configuration variable
merge.tool the resetting message should not be printed.

This is fixed. The message is only printed if a tool is configured
but the entry in merge.tool is invalid.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-mergetool.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 94511f9..a68b403 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -334,7 +334,7 @@ init_merge_tool_path() {
 
 if test -z "$merge_tool"; then
     merge_tool=`git config merge.tool`
-    if ! valid_tool "$merge_tool"; then
+    if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
 	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
 	    echo >&2 "Resetting to default..."
 	    unset merge_tool
-- 
1.5.3.4.222.g2830
