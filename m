From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 4/6] Add tag fetching strategy selection to fetch version of RefSpecPage
Date: Wed, 27 Aug 2008 20:41:44 +0200
Message-ID: <1219862506-11075-5-git-send-email-marek.zawirski@gmail.com>
References: <1219862506-11075-1-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-2-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-3-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-4-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Aug 27 20:44:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYQ0G-0005yt-Ks
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 20:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbYH0Sma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 14:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756277AbYH0Sm3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 14:42:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:41068 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbYH0SmF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 14:42:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so37890fgg.17
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 11:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uHnpF3PladFTnjnaBzjD1rj5inBlFS/v34ruLWNJZYE=;
        b=vWIf1L6tR9Wg4W4alZ6S/Kln9qM85QGdk0voht6SQ6asW05X57TsnhaT/GOElS63Pf
         uS76eOaRkem4L5wbrJefeUZKpR5xNPQTWfgu9rv2CgG/lwkma03lpOOhrYKp8IqRwtC1
         uvBSsFfQW4XpsdkCnAKW/1cWirr6fHP12u9L0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S2GpzrIZvs8v4JI2J4ISqPSSEfBNZdg/HkbY4wofxNL4jLj8c08oQ3jY70JOo/Gdmj
         gBNDzyXdar75qTZbxg3rM9nd+DIzm8CWiYI4sbxCRvXtP/Cb0VwzIBMb9zcBJ4OsPxTl
         /3RrqxiuekRw9hfe/uUHjN9Bfxv9MFbHuhMYg=
Received: by 10.86.52.6 with SMTP id z6mr309967fgz.48.1219862522385;
        Wed, 27 Aug 2008 11:42:02 -0700 (PDT)
Received: from localhost ( [62.21.4.140])
        by mx.google.com with ESMTPS id d4sm136625fga.5.2008.08.27.11.42.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 11:42:01 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219862506-11075-4-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93922>

Tag strategy selection determines tagOpt for Transport, which should be
under user control for fetch operation. RefSpecPage seems to be the best
place for such setting.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |   12 ++++
 .../egit/ui/internal/components/RefSpecPage.java   |   70 ++++++++++++++++++--
 .../src/org/spearce/egit/ui/uitext.properties      |    4 +
 3 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 2bbe218..ab70048 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -386,6 +386,18 @@
 	public static String RefSpecPage_titlePush;
 
 	/** */
+	public static String RefSpecPage_annotatedTagsGroup;
+
+	/** */
+	public static String RefSpecPage_annotatedTagsAutoFollow;
+
+	/** */
+	public static String RefSpecPage_annotatedTagsFetchTags;
+
+	/** */
+	public static String RefSpecPage_annotatedTagsNoTags;
+
+	/** */
 	public static String Decorator_failedLazyLoading;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java
index 45a8505..586e5d9 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java
@@ -23,11 +23,13 @@
 import org.eclipse.swt.layout.GridLayout;
 import org.eclipse.swt.widgets.Button;
 import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Group;
 import org.spearce.egit.core.op.ListRemoteOperation;
 import org.spearce.egit.ui.Activator;
 import org.spearce.egit.ui.UIText;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.transport.RefSpec;
+import org.spearce.jgit.transport.TagOpt;
 import org.spearce.jgit.transport.URIish;
 
 /**
@@ -54,6 +56,12 @@
 
 	private Button saveButton;
 
+	private Button tagsAutoFollowButton;
+
+	private Button tagsFetchTagsButton;
+
+	private Button tagsNoTagsButton;
+
 	private String transportError;
 
 	/**
@@ -106,14 +114,35 @@ public void selectionChanged() {
 			}
 		});
 
-		saveButton = new Button(panel, SWT.CHECK);
-		saveButton.setLayoutData(new GridData(SWT.LEFT, SWT.FILL, true, false));
-		saveButton.addSelectionListener(new SelectionAdapter() {
+		final SelectionAdapter changesNotifier = new SelectionAdapter() {
 			@Override
 			public void widgetSelected(SelectionEvent e) {
 				notifySelectionChanged();
 			}
-		});
+		};
+		if (!pushPage) {
+			final Group tagsGroup = new Group(panel, SWT.NULL);
+			tagsGroup.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true,
+					false));
+			tagsGroup.setText(UIText.RefSpecPage_annotatedTagsGroup);
+			tagsGroup.setLayout(new GridLayout());
+			tagsAutoFollowButton = new Button(tagsGroup, SWT.RADIO);
+			tagsAutoFollowButton
+					.setText(UIText.RefSpecPage_annotatedTagsAutoFollow);
+			tagsFetchTagsButton = new Button(tagsGroup, SWT.RADIO);
+			tagsFetchTagsButton
+					.setText(UIText.RefSpecPage_annotatedTagsFetchTags);
+			tagsNoTagsButton = new Button(tagsGroup, SWT.RADIO);
+			tagsNoTagsButton
+					.setText(UIText.RefSpecPage_annotatedTagsNoTags);
+			tagsAutoFollowButton.addSelectionListener(changesNotifier);
+			tagsFetchTagsButton.addSelectionListener(changesNotifier);
+			tagsNoTagsButton.addSelectionListener(changesNotifier);
+		}
+
+		saveButton = new Button(panel, SWT.CHECK);
+		saveButton.setLayoutData(new GridData(SWT.LEFT, SWT.FILL, true, false));
+		saveButton.addSelectionListener(changesNotifier);
 
 		setControl(panel);
 		notifySelectionChanged();
@@ -147,6 +176,18 @@ public boolean isSaveRequested() {
 	}
 
 	/**
+	 * @return selected tag fetching strategy. This result is relevant only for
+	 *         fetch page.
+	 */
+	public TagOpt getTagOpt() {
+		if (tagsAutoFollowButton.getSelection())
+			return TagOpt.AUTO_FOLLOW;
+		if (tagsFetchTagsButton.getSelection())
+			return TagOpt.FETCH_TAGS;
+		return TagOpt.NO_TAGS;
+	}
+
+	/**
 	 * Compare provided specifications to currently selected ones.
 	 *
 	 * @param specs
@@ -206,12 +247,31 @@ private void revalidateImpl(final RepositorySelection newRepoSelection) {
 		final String remoteName = validatedRepoSelection.getConfigName();
 		specsPanel.setAssistanceData(local, listRemotesOp.getRemoteRefs(),
 				remoteName);
+
+		tagsAutoFollowButton.setSelection(false);
+		tagsFetchTagsButton.setSelection(false);
+		tagsNoTagsButton.setSelection(false);
+
 		if (newRepoSelection.isConfigSelected()) {
 			saveButton.setVisible(true);
 			saveButton.setText(NLS.bind(UIText.RefSpecPage_saveSpecifications,
 					remoteName));
 			saveButton.getParent().layout();
-		}
+			final TagOpt tagOpt = newRepoSelection.getConfig().getTagOpt();
+			switch (tagOpt) {
+			case AUTO_FOLLOW:
+				tagsAutoFollowButton.setSelection(true);
+				break;
+			case FETCH_TAGS:
+				tagsFetchTagsButton.setSelection(true);
+				break;
+			case NO_TAGS:
+				tagsNoTagsButton.setSelection(true);
+				break;
+			}
+		} else
+			tagsAutoFollowButton.setSelection(true);
+
 		checkPage();
 	}
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index c2b91f7..2349334 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -147,6 +147,10 @@ RefSpecPage_operationCancelled=Operation cancelled.
 RefSpecPage_saveSpecifications=Save specifications in "{0}" configuration
 RefSpecPage_titleFetch=Fetch Ref Specifications
 RefSpecPage_titlePush=Push Ref Specifications
+RefSpecPage_annotatedTagsGroup=Annotated tags fetching strategy
+RefSpecPage_annotatedTagsAutoFollow=Automatically follow tags if we fetch the thing they point at
+RefSpecPage_annotatedTagsFetchTags=Always fetch tags, even if we do not have the thing it points at
+RefSpecPage_annotatedTagsNoTags=Never fetch tags, even if we have the thing it points at
 
 Decorator_failedLazyLoading=Resource decorator failed to load tree contents on demand.
 QuickDiff_failedLoading=Quick diff failed to obtain file data.
-- 
1.5.6.3
