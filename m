From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 3/6] Handle URIs parsing errors in PushAction better
Date: Wed, 20 Aug 2008 04:57:37 +0200
Message-ID: <1219201060-4307-3-git-send-email-marek.zawirski@gmail.com>
References: <48AB84A2.7010905@gmail.com>
 <1219201060-4307-1-git-send-email-marek.zawirski@gmail.com>
 <1219201060-4307-2-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Aug 20 04:59:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVduZ-0001o0-Ap
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 04:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbYHTC55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 22:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbYHTC55
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 22:57:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:15858 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbYHTC54 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 22:57:56 -0400
Received: by ug-out-1314.google.com with SMTP id c2so647198ugf.37
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 19:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ukCVDkQ/to5pG7zylkhEcW2fkLUfN3J7j5l4D1rYps8=;
        b=IpfSSGnOMGvYTmKT6L1cZB2EKj6wOOvKxP1weUlxsmBLZVZq01ryaSpH4MhWUdiMI1
         yRFAJJOfR/UCxqOMiCulgJ/98Vik9dpxjtcoPRI29KpsSg8+P6i+436qzvtUpoSxxvKN
         LrHJUlJzCzv7GrQXiAHGhSYY9L7S3CPBxtbFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PTUo7dlNHvKxTQN5EYILxXSpWK9sR7Q6vsXWduSCqwLOmuE+2waz7W759z3UlpOWLe
         Zxa1+JTHFErs0ISwyh7tOBi+Kj7jHJou2ay8/RPfUYiHECzY4pS3QsrN8tsOUbtc+/kJ
         eXjhCG4A9nKWscZO7A+SNoF8V63/g7RyVZXYE=
Received: by 10.103.240.5 with SMTP id s5mr5330802mur.62.1219201074475;
        Tue, 19 Aug 2008 19:57:54 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id j9sm618539mue.3.2008.08.19.19.57.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 19:57:52 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219201060-4307-2-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92955>

ErrorDialog is used instead of MessageDialog (more information), strings
are externalized.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |    6 ++++++
 .../egit/ui/internal/actions/PushAction.java       |   13 +++++++++----
 .../src/org/spearce/egit/ui/uitext.properties      |    3 +++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index cc785f7..b45d2e9 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -464,6 +464,12 @@
 	public static String HistoryPreferencePage_title;
 
 	/** */
+	public static String PushAction_wrongURIDescription;
+
+	/** */
+	public static String PushAction_wrongURITitle;
+
+	/** */
 	public static String PushWizard_cantConnectToAny;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/PushAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/PushAction.java
index 61833d0..b4af3b5 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/PushAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/PushAction.java
@@ -9,9 +9,13 @@
 
 import java.net.URISyntaxException;
 
+import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.Status;
 import org.eclipse.jface.action.IAction;
-import org.eclipse.jface.dialogs.MessageDialog;
+import org.eclipse.jface.dialogs.ErrorDialog;
 import org.eclipse.jface.wizard.WizardDialog;
+import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIText;
 import org.spearce.egit.ui.internal.push.PushWizard;
 import org.spearce.jgit.lib.Repository;
 
@@ -31,9 +35,10 @@ public void run(IAction action) {
 		try {
 			pushWizard = new PushWizard(repository);
 		} catch (URISyntaxException x) {
-			MessageDialog.openError(getShell(), "Corrupted configuration",
-					"Remote repositories URLs configuration is corrupted: "
-							+ x.getMessage());
+			ErrorDialog.openError(getShell(), UIText.PushAction_wrongURITitle,
+					UIText.PushAction_wrongURIDescription, new Status(
+							IStatus.ERROR, Activator.getPluginId(), x
+									.getMessage(), x));
 			return;
 		}
 		final WizardDialog dialog = new WizardDialog(getShell(), pushWizard);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 4b0aea6..83be622 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -179,6 +179,9 @@ HistoryPage_findbar_notFound=String not found
 
 HistoryPreferencePage_title=Git
 
+PushAction_wrongURIDescription=Remote repositories URIs configuration is corrupted.
+PushAction_wrongURITitle=Corrupted Configuration
+
 PushWizard_cantConnectToAny=Can't connect to any repository: {0}
 PushWizard_cantPrepareUpdatesMessage=Can't resolve ref specifications locally (local refs changed?) or create tracking ref update.
 PushWizard_cantPrepareUpdatesTitle=Preparing Ref Updates Error
-- 
1.5.6.3
