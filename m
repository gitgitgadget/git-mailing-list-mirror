From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 21/31] Add canCreateSubdir() heuristic in CloneDestinationPage
Date: Sun, 17 Aug 2008 22:44:02 +0200
Message-ID: <1219005852-21496-22-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-14-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-15-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-16-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-17-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-18-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-19-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-20-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-21-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp9E-00038o-MM
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbYHQUpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754207AbYHQUpl
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:41 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbYHQUpf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:45:35 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uVRm22mOurGkKyeeB+UgPOIjOeA0X0MOwXqOmVUzqbg=;
        b=PG0xgLIvd8bSNwVe4B4VkZxdkw1k6H6mlvCMfwDWZXl/cD+FepGZdxW5aKh0sHxNTF
         aAYMVMdrr/inS0SZi2Lqe28cEH1nsH0fUhFvKKYaHwTDdU7ykE7eoHRWsDcTy+y+O76z
         o+DDuWEJEQ9GM066KwqQog+ixBGVxf544s1Xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CTte9gY+qdEQpJzZmDWGiIyA5zh+PVomWBZXL/ukPSy/kdQazQyRJEUP2ITn30uwBR
         efCdZtvkVKP4vHP9eaqupuDgmnfVnVvlbyAOCTaR7Ig0okgOl3FTJ6KeX/FxQR4s8FEG
         7yLE7bk8LlaQzsQPTbjQ4lW0blNj808d+4xwA=
Received: by 10.103.222.12 with SMTP id z12mr3466840muq.12.1219005934806;
        Sun, 17 Aug 2008 13:45:34 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id g1sm990950muf.8.2008.08.17.13.45.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:45:33 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-21-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92654>

This method provide user with live-feedback when chosen subdirectory
can't be created for sure.

This is only a heuristic (may produce false-positive errors), as it is
problematic to handle File#canWrite() noisy return values for Windows'
Java.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../ui/internal/clone/CloneDestinationPage.java    |   23 ++++++++++++++++++-
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
index 01bf54a..e1e9858 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
@@ -220,9 +220,17 @@ class CloneDestinationPage extends WizardPage {
 			setPageComplete(false);
 			return;
 		}
-		if (new File(dstpath).exists()) {
+		final File dstFile = new File(dstpath);
+		if (dstFile.exists()) {
 			setErrorMessage(NLS.bind(UIText.CloneDestinationPage_errorExists,
-					new File(dstpath).getName()));
+					dstFile.getName()));
+			setPageComplete(false);
+			return;
+		}
+		final File absoluteFile = dstFile.getAbsoluteFile();
+		if (!canCreateSubdir(absoluteFile.getParentFile())) {
+			setErrorMessage(NLS.bind(UIText.GitCloneWizard_errorCannotCreate,
+					dstFile.getPath()));
 			setPageComplete(false);
 			return;
 		}
@@ -243,6 +251,17 @@ class CloneDestinationPage extends WizardPage {
 		setPageComplete(true);
 	}
 
+	// this is actually just an optimistic heuristic - should be named
+	// isThereHopeThatCanCreateSubdir() as probably there is no 100% reliable
+	// way to check that in Java for Windows
+	private static boolean canCreateSubdir(final File parent) {
+		if (parent == null)
+			return true;
+		if (parent.exists())
+			return parent.isDirectory() && parent.canWrite();
+		return canCreateSubdir(parent.getParentFile());
+	}
+
 	private void revalidate() {
 		if (sourcePage.selectionEquals(validatedRepoSelection)
 				&& branchPage.selectionEquals(validatedSelectedBranches,
-- 
1.5.6.3
