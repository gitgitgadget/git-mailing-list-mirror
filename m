From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Some logging of errors GUI's.
Date: Tue, 14 Apr 2009 01:26:01 +0200
Message-ID: <1239665161-24033-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Apr 14 01:27:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtVZ0-00037z-3g
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 01:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbZDMX0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 19:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbZDMX0I
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 19:26:08 -0400
Received: from mail.dewire.com ([83.140.172.130]:6444 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbZDMX0H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 19:26:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F08C114915DA;
	Tue, 14 Apr 2009 01:26:03 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oKOYLwaTy01p; Tue, 14 Apr 2009 01:26:03 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 0BE77148899B;
	Tue, 14 Apr 2009 01:26:02 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116502>

Though, hopefully rare, we might want to have errors logged.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../GitCompareFileRevisionEditorInput.java         |    2 ++
 .../egit/ui/internal/dialogs/CommitDialog.java     |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
index 49d4a42..88c867d 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
@@ -35,6 +35,7 @@
 import org.eclipse.team.internal.ui.synchronize.LocalResourceTypedElement;
 import org.eclipse.team.ui.synchronize.SaveableCompareEditorInput;
 import org.eclipse.ui.IWorkbenchPage;
+import org.spearce.egit.core.Activator;
 
 /**
  * The input provider for the compare editor when working on resources
@@ -327,6 +328,7 @@ private String getContentIdentifier(ITypedElement element){
 						return TeamUIMessages.CompareFileRevisionEditorInput_1;
 					}
 				} catch (CoreException e) {
+					Activator.logError("Problem getting content identifier", e);
 				}
 			} else {
 				return fileRevisionElement.getContentIdentifier();
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index e6bd02d..ce7196f 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -59,6 +59,7 @@
 import org.eclipse.team.core.history.IFileRevision;
 import org.eclipse.team.internal.ui.history.FileRevisionTypedElement;
 import org.eclipse.ui.model.WorkbenchLabelProvider;
+import org.spearce.egit.core.Activator;
 import org.spearce.egit.core.GitProvider;
 import org.spearce.egit.core.internal.storage.GitFileHistoryProvider;
 import org.spearce.egit.core.project.RepositoryMapping;
@@ -434,6 +435,8 @@ private static String getFileStatus(IFile file) {
 			}
 
 		} catch (Exception e) {
+			Activator.logError("Problem in finding file status", e);
+			prefix = e.getMessage();
 		}
 
 		return prefix;
-- 
1.6.2.2.446.gfbdc0
