From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 18/31] Refactor/rewrite CloneSourcePage to universal RepositorySelectionPage
Date: Sun, 17 Aug 2008 22:43:59 +0200
Message-ID: <1219005852-21496-19-git-send-email-marek.zawirski@gmail.com>
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
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp9B-00038o-9G
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbYHQUp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753455AbYHQUp2
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:31899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbYHQUpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:45:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489141fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CDI/vCkFY2eYyOfUi286QpmBUSDtQwXlAJSpdioert4=;
        b=KsWfC9TU2V/z7m6rzOhpercuk6Q091NxC/x6RBH8vasZZHJ6gNEfGelrlk/lafeICE
         iaJJ4ONi4xlZ+Y3GFKzLUFVybHJ2Hiqrx4tzP0sH+c1XsM15fJYEiT4h8LvYe9yfZAyo
         LjA6C+xzsoOyw3Q29EeDPjLoHi2S/N4XED9Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qbgtzU2Zvfc5P2JSk/kYgagKZWsA4vQ+V696yW9ACnaUGWFjRhxGnmAhdt6K3GULQI
         /PWHKjy4IDzVaJz0hoi7RrzxIty7RAVDYVDED7aJJQ5oPu/VesY/ePn3CEPuDGA9Xsl2
         l0RkrhmXuRy52ImlHn0G3Xha19zRDsK9elhGc=
Received: by 10.86.68.1 with SMTP id q1mr4061119fga.2.1219005921744;
        Sun, 17 Aug 2008 13:45:21 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 12sm10375220fgg.0.2008.08.17.13.45.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:45:19 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-18-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92652>

CloneSourcePage is refactored to serve as generic wizard page for
repository selection. Selection can be performed now as custom URI or
(optionally - configurable) from preconfigured remote repositories. That
allows us to this wizard page for selection of both source and destination
repository in wizards.

As there was need for code rewrite in few places, some things get fixed or
improved by the way:
- Controls are disabled/enabled recursively, so user get better feedback
  what he/she can type.
- URI panel behaved strange when bad URI was typed, now it's probably more
  obvious what's going on.
- Distinction is introduced between internal URI/RemoteConfig selection
  (possibly invalid) and exposed one - for other pages. Hence, clients of
  this class don't have to handle internal validation issues.
- isPageComplete() logic is moved to checkPage(), as it seems to be
  strange (and hard to follow?) pattern to mix setPageComplete() and
  custom isPageComplete().
- possibly minor forgotten issues.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |   47 +-
 .../ui/internal/clone/CloneDestinationPage.java    |   24 +-
 .../egit/ui/internal/clone/CloneSourcePage.java    |  460 -------------
 .../egit/ui/internal/clone/GitCloneWizard.java     |   13 +-
 .../egit/ui/internal/clone/SourceBranchPage.java   |   37 +-
 .../ui/internal/clone/URIishChangeListener.java    |   20 -
 .../components/RepositorySelectionListener.java    |   32 +
 .../components/RepositorySelectionPage.java        |  680 ++++++++++++++++++++
 .../src/org/spearce/egit/ui/uitext.properties      |   37 +-
 9 files changed, 798 insertions(+), 552 deletions(-)
 delete mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneSourcePage.java
 delete mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/URIishChangeListener.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionListener.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 4adb99c..0d39440 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -53,52 +53,67 @@ public class UIText extends NLS {
 	public static String GitCloneWizard_failed;
 
 	/** */
-	public static String CloneSourcePage_title;
+	public static String RepositorySelectionPage_sourceSelectionTitle;
 
 	/** */
-	public static String CloneSourcePage_description;
+	public static String RepositorySelectionPage_sourceSelectionDescription;
 
 	/** */
-	public static String CloneSourcePage_groupLocation;
+	public static String RepositorySelectionPage_destinationSelectionTitle;
 
 	/** */
-	public static String CloneSourcePage_groupAuthentication;
+	public static String RepositorySelectionPage_destinationSelectionDescription;
 
 	/** */
-	public static String CloneSourcePage_groupConnection;
+	public static String RepositorySelectionPage_groupLocation;
 
 	/** */
-	public static String CloneSourcePage_promptURI;
+	public static String RepositorySelectionPage_groupAuthentication;
 
 	/** */
-	public static String CloneSourcePage_promptHost;
+	public static String RepositorySelectionPage_groupConnection;
 
 	/** */
-	public static String CloneSourcePage_promptPath;
+	public static String RepositorySelectionPage_promptURI;
 
 	/** */
-	public static String CloneSourcePage_promptUser;
+	public static String RepositorySelectionPage_promptHost;
 
 	/** */
-	public static String CloneSourcePage_promptPassword;
+	public static String RepositorySelectionPage_promptPath;
 
 	/** */
-	public static String CloneSourcePage_promptScheme;
+	public static String RepositorySelectionPage_promptUser;
 
 	/** */
-	public static String CloneSourcePage_promptPort;
+	public static String RepositorySelectionPage_promptPassword;
 
 	/** */
-	public static String CloneSourcePage_fieldRequired;
+	public static String RepositorySelectionPage_promptScheme;
 
 	/** */
-	public static String CloneSourcePage_fieldNotSupported;
+	public static String RepositorySelectionPage_promptPort;
 
 	/** */
-	public static String CloneSourcePage_fileNotFound;
+	public static String RepositorySelectionPage_fieldRequired;
 
 	/** */
-	public static String CloneSourcePage_internalError;
+	public static String RepositorySelectionPage_fieldNotSupported;
+
+	/** */
+	public static String RepositorySelectionPage_fileNotFound;
+
+	/** */
+	public static String RepositorySelectionPage_internalError;
+
+	/** */
+	public static String RepositorySelectionPage_configuredRemoteChoice;
+
+	/** */
+	public static String RepositorySelectionPage_uriChoice;
+
+	/** */
+	public static String SourceBranchPage_title;
 
 	/** */
 	public static String SourceBranchPage_branchList;
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
index 5d5a8ee..249bfd3 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
@@ -9,7 +9,6 @@
 package org.spearce.egit.ui.internal.clone;
 
 import java.io.File;
-import java.net.URISyntaxException;
 
 import org.eclipse.core.resources.ResourcesPlugin;
 import org.eclipse.jface.wizard.WizardPage;
@@ -28,10 +27,12 @@ import org.eclipse.swt.widgets.FileDialog;
 import org.eclipse.swt.widgets.Group;
 import org.eclipse.swt.widgets.Label;
 import org.eclipse.swt.widgets.Text;
-import org.spearce.egit.ui.UIIcons;
 import org.spearce.egit.ui.UIText;
+import org.spearce.egit.ui.internal.components.RepositorySelectionListener;
+import org.spearce.egit.ui.internal.components.RepositorySelectionPage;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.transport.RemoteConfig;
 import org.spearce.jgit.transport.URIish;
 
 /**
@@ -39,7 +40,7 @@ import org.spearce.jgit.transport.URIish;
  * cloned.
  */
 class CloneDestinationPage extends WizardPage {
-	private final CloneSourcePage sourcePage;
+	private final RepositorySelectionPage sourcePage;
 
 	private final SourceBranchPage branchPage;
 
@@ -51,16 +52,17 @@ class CloneDestinationPage extends WizardPage {
 
 	private Text remoteText;
 
-	CloneDestinationPage(final CloneSourcePage sp, final SourceBranchPage bp) {
+	CloneDestinationPage(final RepositorySelectionPage sp,
+			final SourceBranchPage bp) {
 		super(CloneDestinationPage.class.getName());
 		sourcePage = sp;
 		branchPage = bp;
 
 		setTitle(UIText.CloneDestinationPage_title);
-		setImageDescriptor(UIIcons.WIZBAN_IMPORT_REPO);
 
-		sourcePage.addURIishChangeListener(new URIishChangeListener() {
-			public void uriishChanged(final URIish newURI) {
+		sourcePage.addRepositorySelectionListener(new RepositorySelectionListener() {
+			public void selectionChanged(final URIish newURI,
+					final RemoteConfig newConfig) {
 				if (newURI == null || !newURI.equals(validated))
 					setPageComplete(false);
 			}
@@ -221,12 +223,8 @@ class CloneDestinationPage extends WizardPage {
 
 	private void revalidate() {
 		URIish newURI = null;
-		try {
-			newURI = sourcePage.getURI();
-			validated = newURI;
-		} catch (URISyntaxException e) {
-			validated = null;
-		}
+		newURI = sourcePage.getURI();
+		validated = newURI;
 
 		if (newURI == null || !newURI.equals(validated)) {
 			final String n = getSuggestedName();
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneSourcePage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneSourcePage.java
deleted file mode 100644
index 4bdd6af..0000000
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneSourcePage.java
+++ /dev/null
@@ -1,460 +0,0 @@
-/*******************************************************************************
- * Copyright (C) 2007, Robin Rosenberg <robin.rosenberg@dewire.com>
- * Copyright (C) 2008, Roger C. Soares <rogersoares@intelinet.com.br>
- * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
- *
- * All rights reserved. This program and the accompanying materials
- * are made available under the terms of the Eclipse Public License v1.0
- * See LICENSE for the full license text, also available.
- *******************************************************************************/
-package org.spearce.egit.ui.internal.clone;
-
-import java.io.File;
-import java.net.URISyntaxException;
-import java.util.ArrayList;
-import java.util.List;
-import java.util.regex.Pattern;
-
-import org.eclipse.jface.wizard.WizardPage;
-import org.eclipse.osgi.util.NLS;
-import org.eclipse.swt.SWT;
-import org.eclipse.swt.events.ModifyEvent;
-import org.eclipse.swt.events.ModifyListener;
-import org.eclipse.swt.events.SelectionEvent;
-import org.eclipse.swt.events.SelectionListener;
-import org.eclipse.swt.events.VerifyEvent;
-import org.eclipse.swt.events.VerifyListener;
-import org.eclipse.swt.layout.GridData;
-import org.eclipse.swt.layout.GridLayout;
-import org.eclipse.swt.widgets.Combo;
-import org.eclipse.swt.widgets.Composite;
-import org.eclipse.swt.widgets.Group;
-import org.eclipse.swt.widgets.Label;
-import org.eclipse.swt.widgets.Text;
-import org.spearce.egit.ui.Activator;
-import org.spearce.egit.ui.UIIcons;
-import org.spearce.egit.ui.UIText;
-import org.spearce.jgit.transport.URIish;
-import org.spearce.jgit.util.FS;
-
-/**
- * Wizard page that allows the user entering the location of a repository to be
- * cloned.
- */
-class CloneSourcePage extends WizardPage {
-	private static final int S_GIT = 0;
-
-	private static final int S_SSH = 1;
-
-	private static final int S_SFTP = 2;
-
-	private static final int S_HTTP = 3;
-
-	private static final int S_HTTPS = 4;
-
-	private static final int S_FTP = 5;
-
-	private static final int S_FILE = 6;
-
-	private static final String[] DEFAULT_SCHEMES;
-	static {
-		DEFAULT_SCHEMES = new String[7];
-		DEFAULT_SCHEMES[S_GIT] = "git";
-		DEFAULT_SCHEMES[S_SSH] = "git+ssh";
-		DEFAULT_SCHEMES[S_SFTP] = "sftp";
-		DEFAULT_SCHEMES[S_HTTP] = "http";
-		DEFAULT_SCHEMES[S_HTTPS] = "https";
-		DEFAULT_SCHEMES[S_FTP] = "ftp";
-		DEFAULT_SCHEMES[S_FILE] = "file";
-	}
-
-	private final List<URIishChangeListener> uriishChangeListeners;
-
-	private Group authGroup;
-
-	private Text uriText;
-
-	private Text hostText;
-
-	private Text pathText;
-
-	private Text userText;
-
-	private Text passText;
-
-	private Combo scheme;
-
-	private Text portText;
-
-	private int eventDepth;
-
-	private URIish uri = new URIish();
-
-	CloneSourcePage() {
-		super(CloneSourcePage.class.getName());
-		setTitle(UIText.CloneSourcePage_title);
-		setDescription(UIText.CloneSourcePage_description);
-		setImageDescriptor(UIIcons.WIZBAN_IMPORT_REPO);
-		uriishChangeListeners = new ArrayList<URIishChangeListener>(4);
-	}
-
-	void addURIishChangeListener(final URIishChangeListener l) {
-		uriishChangeListeners.add(l);
-	}
-
-	public void createControl(final Composite parent) {
-		final Composite panel = new Composite(parent, SWT.NULL);
-		final GridLayout layout = new GridLayout();
-		layout.numColumns = 1;
-		panel.setLayout(layout);
-
-		createLocationGroup(panel);
-		createConnectionGroup(panel);
-		authGroup = createAuthenticationGroup(panel);
-
-		updateAuthGroup();
-		setControl(panel);
-		setPageComplete(false);
-	}
-
-	private void createLocationGroup(final Composite parent) {
-		final Group g = createGroup(parent,
-				UIText.CloneSourcePage_groupLocation);
-
-		newLabel(g, UIText.CloneSourcePage_promptURI + ":");
-		uriText = new Text(g, SWT.BORDER);
-		uriText.setLayoutData(createFieldGridData());
-		uriText.addModifyListener(new ModifyListener() {
-			public void modifyText(final ModifyEvent e) {
-				try {
-					eventDepth++;
-					if (eventDepth != 1)
-						return;
-
-					final URIish u = new URIish(uriText.getText());
-					safeSet(hostText, u.getHost());
-					safeSet(pathText, u.getPath());
-					safeSet(userText, u.getUser());
-					safeSet(passText, u.getPass());
-
-					if (u.getPort() > 0)
-						portText.setText(Integer.toString(u.getPort()));
-					else
-						portText.setText("");
-
-					if (isFile(u))
-						scheme.select(S_FILE);
-					else if (isSSH(u))
-						scheme.select(S_SSH);
-					else {
-						for (int i = 0; i < DEFAULT_SCHEMES.length; i++) {
-							if (DEFAULT_SCHEMES[i].equals(u.getScheme())) {
-								scheme.select(i);
-								break;
-							}
-						}
-					}
-
-					updateAuthGroup();
-					uri = u;
-					for (final URIishChangeListener l : uriishChangeListeners)
-						l.uriishChanged(u);
-					setPageComplete(isPageComplete());
-				} catch (URISyntaxException err) {
-					uriInvalid();
-					setErrorMessage(err.getMessage());
-					setPageComplete(false);
-				} finally {
-					eventDepth--;
-				}
-			}
-		});
-
-		newLabel(g, UIText.CloneSourcePage_promptHost + ":");
-		hostText = new Text(g, SWT.BORDER);
-		hostText.setLayoutData(createFieldGridData());
-		hostText.addModifyListener(new ModifyListener() {
-			public void modifyText(final ModifyEvent e) {
-				setURI(uri.setHost(nullString(hostText.getText())));
-			}
-		});
-
-		newLabel(g, UIText.CloneSourcePage_promptPath + ":");
-		pathText = new Text(g, SWT.BORDER);
-		pathText.setLayoutData(createFieldGridData());
-		pathText.addModifyListener(new ModifyListener() {
-			public void modifyText(final ModifyEvent e) {
-				setURI(uri.setPath(nullString(pathText.getText())));
-			}
-		});
-	}
-
-	private Group createAuthenticationGroup(final Composite parent) {
-		final Group g = createGroup(parent,
-				UIText.CloneSourcePage_groupAuthentication);
-
-		newLabel(g, UIText.CloneSourcePage_promptUser + ":");
-		userText = new Text(g, SWT.BORDER);
-		userText.setLayoutData(createFieldGridData());
-		userText.addModifyListener(new ModifyListener() {
-			public void modifyText(final ModifyEvent e) {
-				setURI(uri.setUser(nullString(userText.getText())));
-			}
-		});
-
-		newLabel(g, UIText.CloneSourcePage_promptPassword + ":");
-		passText = new Text(g, SWT.BORDER | SWT.PASSWORD);
-		passText.setLayoutData(createFieldGridData());
-		return g;
-	}
-
-	private void createConnectionGroup(final Composite parent) {
-		final Group g = createGroup(parent,
-				UIText.CloneSourcePage_groupConnection);
-
-		newLabel(g, UIText.CloneSourcePage_promptScheme + ":");
-		scheme = new Combo(g, SWT.DROP_DOWN | SWT.READ_ONLY);
-		scheme.setItems(DEFAULT_SCHEMES);
-		scheme.addSelectionListener(new SelectionListener() {
-			public void widgetDefaultSelected(final SelectionEvent e) {
-				// Nothing
-			}
-
-			public void widgetSelected(final SelectionEvent e) {
-				final int idx = scheme.getSelectionIndex();
-				if (idx < 0)
-					setURI(uri.setScheme(null));
-				else
-					setURI(uri.setScheme(nullString(scheme.getItem(idx))));
-				updateAuthGroup();
-			}
-		});
-
-		newLabel(g, UIText.CloneSourcePage_promptPort + ":");
-		portText = new Text(g, SWT.BORDER);
-		portText.addVerifyListener(new VerifyListener() {
-			final Pattern p = Pattern.compile("^(?:[1-9][0-9]*)?$");
-
-			public void verifyText(final VerifyEvent e) {
-				final String v = portText.getText();
-				e.doit = p.matcher(
-						v.substring(0, e.start) + e.text + v.substring(e.end))
-						.matches();
-			}
-		});
-		portText.addModifyListener(new ModifyListener() {
-			public void modifyText(final ModifyEvent e) {
-				final String val = nullString(portText.getText());
-				if (val == null)
-					setURI(uri.setPort(-1));
-				else {
-					try {
-						setURI(uri.setPort(Integer.parseInt(val)));
-					} catch (NumberFormatException err) {
-						// Ignore it for now.
-						uriInvalid();
-					}
-				}
-			}
-		});
-	}
-
-	private static Group createGroup(final Composite parent, final String text) {
-		final Group g = new Group(parent, SWT.NONE);
-		final GridLayout layout = new GridLayout();
-		layout.numColumns = 2;
-		g.setLayout(layout);
-		g.setText(text);
-		final GridData gd = new GridData();
-		gd.grabExcessHorizontalSpace = true;
-		gd.horizontalAlignment = SWT.FILL;
-		g.setLayoutData(gd);
-		return g;
-	}
-
-	private static void newLabel(final Group g, final String text) {
-		new Label(g, SWT.NULL).setText(text);
-	}
-
-	private static GridData createFieldGridData() {
-		return new GridData(SWT.FILL, SWT.DEFAULT, true, false);
-	}
-
-	/**
-	 * Returns the URI entered in the Wizard page.
-	 * 
-	 * @return the URI entered in the Wizard page.
-	 * @throws URISyntaxException
-	 */
-	public URIish getURI() throws URISyntaxException {
-		return new URIish(uriText.getText());
-	}
-
-	@Override
-	public boolean isPageComplete() {
-		if (uriText.getText().length() == 0) {
-			setErrorMessage(null);
-			return false;
-		}
-
-		try {
-			final URIish finalURI = getURI();
-			String proto = finalURI.getScheme();
-			if (proto == null && scheme.getSelectionIndex() >= 0)
-				proto = scheme.getItem(scheme.getSelectionIndex());
-
-			if (uri.getPath() == null) {
-				uriInvalid();
-				setErrorMessage(NLS.bind(UIText.CloneSourcePage_fieldRequired,
-						UIText.CloneSourcePage_promptPath, proto));
-				return false;
-			}
-
-			if (isFile(finalURI)) {
-				String badField = null;
-				if (uri.getHost() != null)
-					badField = UIText.CloneSourcePage_promptHost;
-				else if (uri.getUser() != null)
-					badField = UIText.CloneSourcePage_promptUser;
-				else if (uri.getPass() != null)
-					badField = UIText.CloneSourcePage_promptPassword;
-				if (badField != null) {
-					uriInvalid();
-					setErrorMessage(NLS.bind(
-							UIText.CloneSourcePage_fieldNotSupported, badField,
-							proto));
-					return false;
-				}
-
-				final File d = FS.resolve(new File("."), uri.getPath());
-				if (!d.exists()) {
-					setErrorMessage(NLS.bind(
-							UIText.CloneSourcePage_fileNotFound, d
-									.getAbsolutePath()));
-					return false;
-				}
-				setErrorMessage(null);
-				return true;
-			}
-
-			if (uri.getHost() == null) {
-				uriInvalid();
-				setErrorMessage(NLS.bind(UIText.CloneSourcePage_fieldRequired,
-						UIText.CloneSourcePage_promptHost, proto));
-				return false;
-			}
-
-			if (isGIT(finalURI)) {
-				String badField = null;
-				if (uri.getUser() != null)
-					badField = UIText.CloneSourcePage_promptUser;
-				else if (uri.getPass() != null)
-					badField = UIText.CloneSourcePage_promptPassword;
-				if (badField != null) {
-					uriInvalid();
-					setErrorMessage(NLS.bind(
-							UIText.CloneSourcePage_fieldNotSupported, badField,
-							proto));
-					return false;
-				}
-			}
-
-			setErrorMessage(null);
-			return true;
-		} catch (URISyntaxException e) {
-			uriInvalid();
-			setErrorMessage(e.getReason());
-			return false;
-		} catch (Exception e) {
-			uriInvalid();
-			Activator.logError("Error validating " + getClass().getName(), e);
-			setErrorMessage(UIText.CloneSourcePage_internalError);
-			return false;
-		}
-	}
-
-	private static boolean isGIT(final URIish uri) {
-		return "git".equals(uri.getScheme());
-	}
-
-	private static boolean isFile(final URIish uri) {
-		if ("file".equals(uri.getScheme()))
-			return true;
-		if (uri.getHost() != null || uri.getPort() > 0 || uri.getUser() != null
-				|| uri.getPass() != null || uri.getPath() == null)
-			return false;
-		if (uri.getScheme() == null)
-			return FS.resolve(new File("."), uri.getPath()).isDirectory();
-		return false;
-	}
-
-	private static boolean isSSH(final URIish uri) {
-		if (!uri.isRemote())
-			return false;
-		final String scheme = uri.getScheme();
-		if ("ssh".equals(scheme))
-			return true;
-		if ("ssh+git".equals(scheme))
-			return true;
-		if ("git+ssh".equals(scheme))
-			return true;
-		if (scheme == null && uri.getHost() != null && uri.getPath() != null)
-			return true;
-		return false;
-	}
-
-	private static String nullString(final String value) {
-		if (value == null)
-			return null;
-		final String v = value.trim();
-		return v.length() == 0 ? null : v;
-	}
-
-	private static void safeSet(final Text text, final String value) {
-		text.setText(value != null ? value : "");
-	}
-
-	private void setURI(final URIish u) {
-		try {
-			eventDepth++;
-			if (eventDepth == 1) {
-				for (final URIishChangeListener l : uriishChangeListeners)
-					l.uriishChanged(u);
-				uri = u;
-				uriText.setText(uri.toString());
-				setPageComplete(isPageComplete());
-			}
-		} finally {
-			eventDepth--;
-		}
-	}
-
-	private void updateAuthGroup() {
-		switch (scheme.getSelectionIndex()) {
-		case S_GIT:
-			hostText.setEnabled(true);
-			portText.setEnabled(true);
-			authGroup.setEnabled(false);
-			break;
-		case S_SSH:
-		case S_SFTP:
-		case S_HTTP:
-		case S_HTTPS:
-		case S_FTP:
-			hostText.setEnabled(true);
-			portText.setEnabled(true);
-			authGroup.setEnabled(true);
-			break;
-		case S_FILE:
-			hostText.setEnabled(false);
-			portText.setEnabled(false);
-			authGroup.setEnabled(false);
-			break;
-		}
-	}
-
-	private void uriInvalid() {
-		for (final URIishChangeListener l : uriishChangeListeners)
-			l.uriishChanged(null);
-	}
-}
\ No newline at end of file
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
index 50c2ef9..58c169a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
@@ -25,7 +25,9 @@ import org.eclipse.ui.IImportWizard;
 import org.eclipse.ui.IWorkbench;
 import org.spearce.egit.core.op.CloneOperation;
 import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIIcons;
 import org.spearce.egit.ui.UIText;
+import org.spearce.egit.ui.internal.components.RepositorySelectionPage;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
@@ -42,7 +44,7 @@ public class GitCloneWizard extends Wizard implements IImportWizard {
 	private static final String REMOTES_PREFIX_S = Constants.REMOTES_PREFIX
 			+ "/";
 
-	private CloneSourcePage cloneSource;
+	private RepositorySelectionPage cloneSource;
 
 	private SourceBranchPage validSource;
 
@@ -50,7 +52,8 @@ public class GitCloneWizard extends Wizard implements IImportWizard {
 
 	public void init(IWorkbench arg0, IStructuredSelection arg1) {
 		setWindowTitle(UIText.GitCloneWizard_title);
-		cloneSource = new CloneSourcePage();
+		setDefaultPageImageDescriptor(UIIcons.WIZBAN_IMPORT_REPO);
+		cloneSource = new RepositorySelectionPage(true);
 		validSource = new SourceBranchPage(cloneSource);
 		cloneDestination = new CloneDestinationPage(cloneSource, validSource);
 	}
@@ -68,11 +71,7 @@ public class GitCloneWizard extends Wizard implements IImportWizard {
 		final Repository db;
 		final RemoteConfig origin;
 
-		try {
-			uri = cloneSource.getURI();
-		} catch (URISyntaxException e) {
-			return false;
-		}
+		uri = cloneSource.getURI();
 
 		final File workdir = cloneDestination.getDestinationFile();
 		final String branch = cloneDestination.getInitialBranch();
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
index b0aba1e..1768dbd 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
@@ -10,7 +10,6 @@ package org.spearce.egit.ui.internal.clone;
 
 import java.io.File;
 import java.lang.reflect.InvocationTargetException;
-import java.net.URISyntaxException;
 import java.util.ArrayList;
 import java.util.Collection;
 import java.util.Collections;
@@ -40,19 +39,21 @@ import org.eclipse.swt.widgets.Listener;
 import org.eclipse.swt.widgets.Table;
 import org.eclipse.swt.widgets.TableItem;
 import org.spearce.egit.ui.Activator;
-import org.spearce.egit.ui.UIIcons;
 import org.spearce.egit.ui.UIText;
+import org.spearce.egit.ui.internal.components.RepositorySelectionListener;
+import org.spearce.egit.ui.internal.components.RepositorySelectionPage;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.transport.FetchConnection;
+import org.spearce.jgit.transport.RemoteConfig;
 import org.spearce.jgit.transport.Transport;
 import org.spearce.jgit.transport.URIish;
 
 class SourceBranchPage extends WizardPage {
 	private final List<BranchChangeListener> branchChangeListeners;
 
-	private final CloneSourcePage sourcePage;
+	private final RepositorySelectionPage sourcePage;
 
 	private URIish validated;
 
@@ -68,19 +69,20 @@ class SourceBranchPage extends WizardPage {
 
 	private String transportError;
 
-	SourceBranchPage(final CloneSourcePage sp) {
+	SourceBranchPage(final RepositorySelectionPage sp) {
 		super(SourceBranchPage.class.getName());
 		sourcePage = sp;
-		setTitle(UIText.CloneSourcePage_title);
-		setImageDescriptor(UIIcons.WIZBAN_IMPORT_REPO);
-		sourcePage.addURIishChangeListener(new URIishChangeListener() {
-			public void uriishChanged(final URIish newURI) {
-				if (newURI == null || !newURI.equals(validated)) {
-					validated = null;
-					setPageComplete(false);
-				}
-			}
-		});
+		setTitle(UIText.SourceBranchPage_title);
+		sourcePage
+				.addRepositorySelectionListener(new RepositorySelectionListener() {
+					public void selectionChanged(final URIish newURI,
+							final RemoteConfig newConfig) {
+						if (newURI == null || !newURI.equals(validated)) {
+							validated = null;
+							setPageComplete(false);
+						}
+					}
+				});
 		branchChangeListeners = new ArrayList<BranchChangeListener>(3);
 	}
 
@@ -190,12 +192,7 @@ class SourceBranchPage extends WizardPage {
 
 	private void revalidate() {
 		final URIish newURI;
-		try {
-			newURI = sourcePage.getURI();
-		} catch (URISyntaxException e) {
-			transportError(e.getReason());
-			return;
-		}
+		newURI = sourcePage.getURI();
 
 		label.setText(NLS.bind(UIText.SourceBranchPage_branchList, newURI
 				.toString()));
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/URIishChangeListener.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/URIishChangeListener.java
deleted file mode 100644
index e956e95..0000000
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/URIishChangeListener.java
+++ /dev/null
@@ -1,20 +0,0 @@
-/*******************************************************************************
- * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
- *
- * All rights reserved. This program and the accompanying materials
- * are made available under the terms of the Eclipse Public License v1.0
- * See LICENSE for the full license text, also available.
- *******************************************************************************/
-package org.spearce.egit.ui.internal.clone;
-
-import org.spearce.jgit.transport.URIish;
-
-interface URIishChangeListener {
-	/**
-	 * Notify the receiver that the URI has changed.
-	 * 
-	 * @param newURI
-	 *            the new URI. Null if the new URI is invalid.
-	 */
-	void uriishChanged(URIish newURI);
-}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionListener.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionListener.java
new file mode 100644
index 0000000..ef5c33b
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionListener.java
@@ -0,0 +1,32 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.components;
+
+import org.spearce.jgit.transport.RemoteConfig;
+import org.spearce.jgit.transport.URIish;
+
+/**
+ * Interface for listeners of repository selection events from repository
+ * selection dialogs.
+ */
+public interface RepositorySelectionListener {
+	/**
+	 * Notify the receiver that the repository selection has changed. Each time
+	 * at least one argument of this call is null, which indicates that it has
+	 * illegal value or this form of repository selection is not selected.
+	 * 
+	 * @param newURI
+	 *            the new specified URI. null if the new URI is invalid or user
+	 *            chosen to specify repository as remote config instead of URI.
+	 * @param newConfig
+	 *            the new remote config. null if user chosen to specify
+	 *            repository as URI.
+	 */
+	public void selectionChanged(URIish newURI, RemoteConfig newConfig);
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
new file mode 100644
index 0000000..a487cb1
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
@@ -0,0 +1,680 @@
+/*******************************************************************************
+ * Copyright (C) 2007, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2008, Roger C. Soares <rogersoares@intelinet.com.br>
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.components;
+
+import java.io.File;
+import java.net.URISyntaxException;
+import java.util.Iterator;
+import java.util.LinkedList;
+import java.util.List;
+import java.util.regex.Pattern;
+
+import org.eclipse.jface.wizard.WizardPage;
+import org.eclipse.osgi.util.NLS;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.events.ModifyEvent;
+import org.eclipse.swt.events.ModifyListener;
+import org.eclipse.swt.events.SelectionAdapter;
+import org.eclipse.swt.events.SelectionEvent;
+import org.eclipse.swt.events.VerifyEvent;
+import org.eclipse.swt.events.VerifyListener;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.layout.GridLayout;
+import org.eclipse.swt.widgets.Button;
+import org.eclipse.swt.widgets.Combo;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Control;
+import org.eclipse.swt.widgets.Group;
+import org.eclipse.swt.widgets.Label;
+import org.eclipse.swt.widgets.Text;
+import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIText;
+import org.spearce.jgit.transport.RemoteConfig;
+import org.spearce.jgit.transport.URIish;
+import org.spearce.jgit.util.FS;
+
+/**
+ * Wizard page that allows the user entering the location of a remote repository
+ * by specifying URL manually or selecting a preconfigured remote repository.
+ */
+public class RepositorySelectionPage extends WizardPage {
+	private static final int REMOTE_CONFIG_TEXT_MAX_LENGTH = 80;
+
+	private static final String DEFAULT_REMOTE_NAME = "origin";
+
+	private static final int S_GIT = 0;
+
+	private static final int S_SSH = 1;
+
+	private static final int S_SFTP = 2;
+
+	private static final int S_HTTP = 3;
+
+	private static final int S_HTTPS = 4;
+
+	private static final int S_FTP = 5;
+
+	private static final int S_FILE = 6;
+
+	private static final String[] DEFAULT_SCHEMES;
+	static {
+		DEFAULT_SCHEMES = new String[7];
+		DEFAULT_SCHEMES[S_GIT] = "git";
+		DEFAULT_SCHEMES[S_SSH] = "git+ssh";
+		DEFAULT_SCHEMES[S_SFTP] = "sftp";
+		DEFAULT_SCHEMES[S_HTTP] = "http";
+		DEFAULT_SCHEMES[S_HTTPS] = "https";
+		DEFAULT_SCHEMES[S_FTP] = "ftp";
+		DEFAULT_SCHEMES[S_FILE] = "file";
+	}
+	
+	private static void setEnabledRecursively(final Control control,
+			final boolean enable) {
+		control.setEnabled(enable);
+		if (control instanceof Composite)
+			for (final Control child : ((Composite) control).getChildren())
+				setEnabledRecursively(child, enable);
+	}
+
+	private final List<RepositorySelectionListener> selectionListeners;
+
+	private final List<RemoteConfig> configuredRemotes;
+
+	private Group authGroup;
+
+	private Text uriText;
+
+	private Text hostText;
+
+	private Text pathText;
+
+	private Text userText;
+
+	private Text passText;
+
+	private Combo scheme;
+
+	private Text portText;
+
+	private int eventDepth;
+
+	private URIish uri;
+
+	private RemoteConfig remoteConfig;
+
+	private RemoteConfig exposedRemoteConfig;
+
+	private URIish exposedURI;
+
+	private Composite remotePanel;
+
+	private Button remoteButton;
+
+	private Combo remoteCombo;
+
+	private Composite uriPanel;
+
+	private Button uriButton;
+
+	/**
+	 * Create repository selection page, allowing user specifying URI or
+	 * (optionally) choosing from preconfigured remotes list.
+	 * <p>
+	 * Wizard page is created without image, just with text description.
+	 * 
+	 * @param sourceSelection
+	 *            true if dialog is used for source selection; false otherwise
+	 *            (destination selection). This indicates appropriate text
+	 *            messages.
+	 * @param configuredRemotes
+	 *            list of configured remotes that user may select as an
+	 *            alternative to manual URI specification. Remotes appear in
+	 *            given order in GUI, with {@value #DEFAULT_REMOTE_NAME} as the
+	 *            default choice. List may be null or empty - no remotes
+	 *            configurations appear in this case. Note that the provided
+	 *            list may be changed by this constructor.
+	 */
+	public RepositorySelectionPage(final boolean sourceSelection,
+			final List<RemoteConfig> configuredRemotes) {
+		super(RepositorySelectionPage.class.getName());
+		this.uri = new URIish();
+
+		if (configuredRemotes != null)
+			removeUnusableRemoteConfigs(configuredRemotes);
+		if (configuredRemotes == null || configuredRemotes.isEmpty())
+			this.configuredRemotes = null;
+		else {
+			this.configuredRemotes = configuredRemotes;
+			this.remoteConfig = selectDefaultRemoteConfig();
+		}
+
+		if (sourceSelection) {
+			setTitle(UIText.RepositorySelectionPage_sourceSelectionTitle);
+			setDescription(UIText.RepositorySelectionPage_sourceSelectionDescription);
+		} else {
+			setTitle(UIText.RepositorySelectionPage_destinationSelectionTitle);
+			setDescription(UIText.RepositorySelectionPage_destinationSelectionDescription);
+		}
+		selectionListeners = new LinkedList<RepositorySelectionListener>();
+	}
+
+	/**
+	 * Create repository selection page, allowing user specifying URI, with no
+	 * preconfigured remotes selection.
+	 * 
+	 * @param sourceSelection
+	 *            true if dialog is used for source selection; false otherwise
+	 *            (destination selection). This indicates appropriate text
+	 *            messages.
+	 */
+	public RepositorySelectionPage(final boolean sourceSelection) {
+		this(sourceSelection, null);
+	}
+
+	/**
+	 * Add {@link RepositorySelectionListener} to list of listeners notified on
+	 * repository selection change.
+	 * 
+	 * @param l
+	 *            listener that will be notified about changes
+	 */
+	public void addRepositorySelectionListener(
+			final RepositorySelectionListener l) {
+		selectionListeners.add(l);
+	}
+
+	public void createControl(final Composite parent) {
+		final Composite panel = new Composite(parent, SWT.NULL);
+		panel.setLayout(new GridLayout());
+
+		if (configuredRemotes != null)
+			createRemotePanel(panel);
+		createUriPanel(panel);
+
+		updateRemoteAndURIPanels();
+		setControl(panel);
+		checkPage();
+	}
+
+	private void createRemotePanel(final Composite parent) {
+		remoteButton = new Button(parent, SWT.RADIO);
+		remoteButton
+				.setText(UIText.RepositorySelectionPage_configuredRemoteChoice
+						+ ":");
+		remoteButton.setSelection(true);
+
+		remotePanel = new Composite(parent, SWT.NULL);
+		remotePanel.setLayout(new GridLayout());
+		final GridData gd = new GridData();
+		gd.grabExcessHorizontalSpace = true;
+		gd.horizontalAlignment = SWT.FILL;
+		remotePanel.setLayoutData(gd);
+
+		remoteCombo = new Combo(remotePanel, SWT.READ_ONLY | SWT.DROP_DOWN);
+		final String items[] = new String[configuredRemotes.size()];
+		int i = 0;
+		for (final RemoteConfig rc : configuredRemotes)
+			items[i++] = getTextForRemoteConfig(rc);
+		final int defaultIndex = configuredRemotes.indexOf(remoteConfig);
+		remoteCombo.setItems(items);
+		remoteCombo.select(defaultIndex);
+		remoteCombo.addSelectionListener(new SelectionAdapter() {
+			@Override
+			public void widgetSelected(SelectionEvent e) {
+				final int idx = remoteCombo.getSelectionIndex();
+				remoteConfig = configuredRemotes.get(idx);
+				checkPage();
+			}
+		});
+	}
+
+	private void createUriPanel(final Composite parent) {
+		if (configuredRemotes != null) {
+			uriButton = new Button(parent, SWT.RADIO);
+			uriButton.setText(UIText.RepositorySelectionPage_uriChoice + ":");
+			uriButton.addSelectionListener(new SelectionAdapter() {
+				public void widgetSelected(SelectionEvent e) {
+					// occurs either on selection or unselection event
+					updateRemoteAndURIPanels();
+					checkPage();
+				}
+			});
+		}
+
+		uriPanel = new Composite(parent, SWT.NULL);
+		uriPanel.setLayout(new GridLayout());
+		final GridData gd = new GridData();
+		gd.grabExcessHorizontalSpace = true;
+		gd.horizontalAlignment = SWT.FILL;
+		uriPanel.setLayoutData(gd);
+
+		createLocationGroup(uriPanel);
+		createConnectionGroup(uriPanel);
+		authGroup = createAuthenticationGroup(uriPanel);
+	}
+
+	private void createLocationGroup(final Composite parent) {
+		final Group g = createGroup(parent,
+				UIText.RepositorySelectionPage_groupLocation);
+
+		newLabel(g, UIText.RepositorySelectionPage_promptURI + ":");
+		uriText = new Text(g, SWT.BORDER);
+		uriText.setLayoutData(createFieldGridData());
+		uriText.addModifyListener(new ModifyListener() {
+			public void modifyText(final ModifyEvent e) {
+				try {
+					eventDepth++;
+					if (eventDepth != 1)
+						return;
+
+					final URIish u = new URIish(uriText.getText());
+					safeSet(hostText, u.getHost());
+					safeSet(pathText, u.getPath());
+					safeSet(userText, u.getUser());
+					safeSet(passText, u.getPass());
+
+					if (u.getPort() > 0)
+						portText.setText(Integer.toString(u.getPort()));
+					else
+						portText.setText("");
+
+					if (isFile(u))
+						scheme.select(S_FILE);
+					else if (isSSH(u))
+						scheme.select(S_SSH);
+					else {
+						for (int i = 0; i < DEFAULT_SCHEMES.length; i++) {
+							if (DEFAULT_SCHEMES[i].equals(u.getScheme())) {
+								scheme.select(i);
+								break;
+							}
+						}
+					}
+
+					updateAuthGroup();
+					uri = u;
+				} catch (URISyntaxException err) {
+					// leave uriText as it is, but clean up underlying uri and
+					// decomposed fields
+					uri = new URIish();
+					hostText.setText("");
+					pathText.setText("");
+					userText.setText("");
+					passText.setText("");
+					portText.setText("");
+					scheme.select(0);
+				} finally {
+					eventDepth--;
+				}
+				checkPage();
+			}
+		});
+
+		newLabel(g, UIText.RepositorySelectionPage_promptHost + ":");
+		hostText = new Text(g, SWT.BORDER);
+		hostText.setLayoutData(createFieldGridData());
+		hostText.addModifyListener(new ModifyListener() {
+			public void modifyText(final ModifyEvent e) {
+				setURI(uri.setHost(nullString(hostText.getText())));
+			}
+		});
+
+		newLabel(g, UIText.RepositorySelectionPage_promptPath + ":");
+		pathText = new Text(g, SWT.BORDER);
+		pathText.setLayoutData(createFieldGridData());
+		pathText.addModifyListener(new ModifyListener() {
+			public void modifyText(final ModifyEvent e) {
+				setURI(uri.setPath(nullString(pathText.getText())));
+			}
+		});
+	}
+
+	private Group createAuthenticationGroup(final Composite parent) {
+		final Group g = createGroup(parent,
+				UIText.RepositorySelectionPage_groupAuthentication);
+
+		newLabel(g, UIText.RepositorySelectionPage_promptUser + ":");
+		userText = new Text(g, SWT.BORDER);
+		userText.setLayoutData(createFieldGridData());
+		userText.addModifyListener(new ModifyListener() {
+			public void modifyText(final ModifyEvent e) {
+				setURI(uri.setUser(nullString(userText.getText())));
+			}
+		});
+
+		newLabel(g, UIText.RepositorySelectionPage_promptPassword + ":");
+		passText = new Text(g, SWT.BORDER | SWT.PASSWORD);
+		passText.setLayoutData(createFieldGridData());
+		return g;
+	}
+
+	private void createConnectionGroup(final Composite parent) {
+		final Group g = createGroup(parent,
+				UIText.RepositorySelectionPage_groupConnection);
+
+		newLabel(g, UIText.RepositorySelectionPage_promptScheme + ":");
+		scheme = new Combo(g, SWT.DROP_DOWN | SWT.READ_ONLY);
+		scheme.setItems(DEFAULT_SCHEMES);
+		scheme.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(final SelectionEvent e) {
+				final int idx = scheme.getSelectionIndex();
+				if (idx < 0)
+					setURI(uri.setScheme(null));
+				else
+					setURI(uri.setScheme(nullString(scheme.getItem(idx))));
+				updateAuthGroup();
+			}
+		});
+
+		newLabel(g, UIText.RepositorySelectionPage_promptPort + ":");
+		portText = new Text(g, SWT.BORDER);
+		portText.addVerifyListener(new VerifyListener() {
+			final Pattern p = Pattern.compile("^(?:[1-9][0-9]*)?$");
+
+			public void verifyText(final VerifyEvent e) {
+				final String v = portText.getText();
+				e.doit = p.matcher(
+						v.substring(0, e.start) + e.text + v.substring(e.end))
+						.matches();
+			}
+		});
+		portText.addModifyListener(new ModifyListener() {
+			public void modifyText(final ModifyEvent e) {
+				final String val = nullString(portText.getText());
+				if (val == null)
+					setURI(uri.setPort(-1));
+				else {
+					try {
+						setURI(uri.setPort(Integer.parseInt(val)));
+					} catch (NumberFormatException err) {
+						// Ignore it for now.
+					}
+				}
+			}
+		});
+	}
+
+	private static Group createGroup(final Composite parent, final String text) {
+		final Group g = new Group(parent, SWT.NONE);
+		final GridLayout layout = new GridLayout();
+		layout.numColumns = 2;
+		g.setLayout(layout);
+		g.setText(text);
+		final GridData gd = new GridData();
+		gd.grabExcessHorizontalSpace = true;
+		gd.horizontalAlignment = SWT.FILL;
+		g.setLayoutData(gd);
+		return g;
+	}
+
+	private static void newLabel(final Group g, final String text) {
+		new Label(g, SWT.NULL).setText(text);
+	}
+
+	private static GridData createFieldGridData() {
+		return new GridData(SWT.FILL, SWT.DEFAULT, true, false);
+	}
+
+	/**
+	 * @return the URI entered in the Wizard page. null if URI is invalid or
+	 *         user chosen to select remote config instead of providing direct
+	 *         URI.
+	 */
+	public URIish getURI() {
+		return exposedURI;
+	}
+
+	/**
+	 * @return the selected remote configuration in the Wizard page. null if
+	 *         user chosen to select repository as URI.
+	 */
+	public RemoteConfig getRemoteConfig() {
+		return exposedRemoteConfig;
+	}
+
+	private static boolean isGIT(final URIish uri) {
+		return "git".equals(uri.getScheme());
+	}
+
+	private static boolean isFile(final URIish uri) {
+		if ("file".equals(uri.getScheme()))
+			return true;
+		if (uri.getHost() != null || uri.getPort() > 0 || uri.getUser() != null
+				|| uri.getPass() != null || uri.getPath() == null)
+			return false;
+		if (uri.getScheme() == null)
+			return FS.resolve(new File("."), uri.getPath()).isDirectory();
+		return false;
+	}
+
+	private static boolean isSSH(final URIish uri) {
+		if (!uri.isRemote())
+			return false;
+		final String scheme = uri.getScheme();
+		if ("ssh".equals(scheme))
+			return true;
+		if ("ssh+git".equals(scheme))
+			return true;
+		if ("git+ssh".equals(scheme))
+			return true;
+		if (scheme == null && uri.getHost() != null && uri.getPath() != null)
+			return true;
+		return false;
+	}
+
+	private static String nullString(final String value) {
+		if (value == null)
+			return null;
+		final String v = value.trim();
+		return v.length() == 0 ? null : v;
+	}
+
+	private static void safeSet(final Text text, final String value) {
+		text.setText(value != null ? value : "");
+	}
+
+	private boolean isURISelected() {
+		return configuredRemotes == null || uriButton.getSelection();
+	}
+
+	private void setURI(final URIish u) {
+		try {
+			eventDepth++;
+			if (eventDepth == 1) {
+				uri = u;
+				uriText.setText(uri.toString());
+				checkPage();
+			}
+		} finally {
+			eventDepth--;
+		}
+	}
+
+	private static void removeUnusableRemoteConfigs(
+			final List<RemoteConfig> remotes) {
+		final Iterator<RemoteConfig> iter = remotes.iterator();
+		while (iter.hasNext()) {
+			final RemoteConfig rc = iter.next();
+			if (rc.getURIs().isEmpty())
+				iter.remove();
+		}
+	}
+
+	private RemoteConfig selectDefaultRemoteConfig() {
+		for (final RemoteConfig rc : configuredRemotes)
+			if (getTextForRemoteConfig(rc) == DEFAULT_REMOTE_NAME)
+				return rc;
+		return configuredRemotes.get(0);
+	}
+
+	private static String getTextForRemoteConfig(final RemoteConfig rc) {
+		final StringBuilder sb = new StringBuilder(rc.getName());
+		sb.append(": ");
+		boolean first = true;
+		for (final URIish u : rc.getURIs()) {
+			final String uString = u.toString();
+			if (first)
+				first = false;
+			else {
+				sb.append(", ");
+				if (sb.length() + uString.length() > REMOTE_CONFIG_TEXT_MAX_LENGTH) {
+					sb.append("...");
+					break;
+				}
+			}
+			sb.append(uString);
+		}
+		return sb.toString();
+	}
+
+	private void checkPage() {
+		if (isURISelected()) {
+			assert uri != null;
+			if (uriText.getText().length() == 0) {
+				selectionIncomplete(null);
+				return;
+			}
+
+			try {
+				final URIish finalURI = new URIish(uriText.getText());
+				String proto = finalURI.getScheme();
+				if (proto == null && scheme.getSelectionIndex() >= 0)
+					proto = scheme.getItem(scheme.getSelectionIndex());
+
+				if (uri.getPath() == null) {
+					selectionIncomplete(NLS.bind(
+							UIText.RepositorySelectionPage_fieldRequired,
+							UIText.RepositorySelectionPage_promptPath, proto));
+					return;
+				}
+
+				if (isFile(finalURI)) {
+					String badField = null;
+					if (uri.getHost() != null)
+						badField = UIText.RepositorySelectionPage_promptHost;
+					else if (uri.getUser() != null)
+						badField = UIText.RepositorySelectionPage_promptUser;
+					else if (uri.getPass() != null)
+						badField = UIText.RepositorySelectionPage_promptPassword;
+					if (badField != null) {
+						selectionIncomplete(NLS
+								.bind(
+										UIText.RepositorySelectionPage_fieldNotSupported,
+										badField, proto));
+						return;
+					}
+
+					final File d = FS.resolve(new File("."), uri.getPath());
+					if (!d.exists()) {
+						selectionIncomplete(NLS.bind(
+								UIText.RepositorySelectionPage_fileNotFound, d
+										.getAbsolutePath()));
+						return;
+					}
+
+					selectionComplete(finalURI, null);
+					return;
+				}
+
+				if (uri.getHost() == null) {
+					selectionIncomplete(NLS.bind(
+							UIText.RepositorySelectionPage_fieldRequired,
+							UIText.RepositorySelectionPage_promptHost, proto));
+					return;
+				}
+
+				if (isGIT(finalURI)) {
+					String badField = null;
+					if (uri.getUser() != null)
+						badField = UIText.RepositorySelectionPage_promptUser;
+					else if (uri.getPass() != null)
+						badField = UIText.RepositorySelectionPage_promptPassword;
+					if (badField != null) {
+						selectionIncomplete(NLS
+								.bind(
+										UIText.RepositorySelectionPage_fieldNotSupported,
+										badField, proto));
+						return;
+					}
+				}
+
+				selectionComplete(finalURI, null);
+				return;
+			} catch (URISyntaxException e) {
+				selectionIncomplete(e.getReason());
+				return;
+			} catch (Exception e) {
+				Activator.logError("Error validating " + getClass().getName(),
+						e);
+				selectionIncomplete(UIText.RepositorySelectionPage_internalError);
+				return;
+			}
+		} else {
+			assert remoteButton.getSelection();
+			selectionComplete(null, remoteConfig);
+			return;
+		}
+	}
+
+	private void selectionIncomplete(final String errorMessage) {
+		setExposedSelection(null, null);
+		setErrorMessage(errorMessage);
+		setPageComplete(false);
+	}
+
+	private void selectionComplete(final URIish u, final RemoteConfig rc) {
+		setExposedSelection(u, rc);
+		setErrorMessage(null);
+		setPageComplete(true);
+	}
+
+	private void setExposedSelection(final URIish u, final RemoteConfig rc) {
+		if (u == exposedURI && rc == exposedRemoteConfig) // nothing changed
+			return;
+		this.exposedURI = u;
+		this.exposedRemoteConfig = rc;
+
+		for (final RepositorySelectionListener l : selectionListeners)
+			l.selectionChanged(u, rc);
+	}
+
+	private void updateRemoteAndURIPanels() {
+		setEnabledRecursively(uriPanel, isURISelected());
+		if (uriPanel.getEnabled())
+			updateAuthGroup();
+		if (configuredRemotes != null)
+			setEnabledRecursively(remotePanel, !isURISelected());
+	}
+
+	private void updateAuthGroup() {
+		switch (scheme.getSelectionIndex()) {
+		case S_GIT:
+			hostText.setEnabled(true);
+			portText.setEnabled(true);
+			setEnabledRecursively(authGroup, false);
+			break;
+		case S_SSH:
+		case S_SFTP:
+		case S_HTTP:
+		case S_HTTPS:
+		case S_FTP:
+			hostText.setEnabled(true);
+			portText.setEnabled(true);
+			setEnabledRecursively(authGroup, true);
+			break;
+		case S_FILE:
+			hostText.setEnabled(false);
+			portText.setEnabled(false);
+			setEnabledRecursively(authGroup, false);
+			break;
+		}
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 55b1348..857568a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -31,23 +31,28 @@ GitCloneWizard_title=Import Git Repository
 GitCloneWizard_jobName=Cloning from {0}
 GitCloneWizard_failed=Git repository clone failed.
 
-CloneSourcePage_title=Source Git Repository
-CloneSourcePage_description=Enter the location of the repository to be cloned.
-CloneSourcePage_groupLocation=Location
-CloneSourcePage_groupAuthentication=Authentication
-CloneSourcePage_groupConnection=Connection
-CloneSourcePage_promptURI=URI
-CloneSourcePage_promptHost=Host
-CloneSourcePage_promptPath=Repository path
-CloneSourcePage_promptUser=User
-CloneSourcePage_promptPassword=Password
-CloneSourcePage_promptScheme=Protocol
-CloneSourcePage_promptPort=Port
-CloneSourcePage_fieldRequired={0} required for {1} protocol.
-CloneSourcePage_fieldNotSupported={0} not supported on {1} protocol.
-CloneSourcePage_fileNotFound={0} does not exist.
-CloneSourcePage_internalError=Internal error; consult Eclipse error log.
+RepositorySelectionPage_sourceSelectionTitle=Source Git Repository
+RepositorySelectionPage_sourceSelectionDescription=Enter the location of the source repository.
+RepositorySelectionPage_destinationSelectionTitle=Destination Git Repository
+RepositorySelectionPage_destinationSelectionDescription=Enter the location of the destination repository.
+RepositorySelectionPage_configuredRemoteChoice=Configured remote repository
+RepositorySelectionPage_uriChoice=Custom URI
+RepositorySelectionPage_groupLocation=Location
+RepositorySelectionPage_groupAuthentication=Authentication
+RepositorySelectionPage_groupConnection=Connection
+RepositorySelectionPage_promptURI=URI
+RepositorySelectionPage_promptHost=Host
+RepositorySelectionPage_promptPath=Repository path
+RepositorySelectionPage_promptUser=User
+RepositorySelectionPage_promptPassword=Password
+RepositorySelectionPage_promptScheme=Protocol
+RepositorySelectionPage_promptPort=Port
+RepositorySelectionPage_fieldRequired={0} required for {1} protocol.
+RepositorySelectionPage_fieldNotSupported={0} not supported on {1} protocol.
+RepositorySelectionPage_fileNotFound={0} does not exist.
+RepositorySelectionPage_internalError=Internal error; consult Eclipse error log.
 
+SourceBranchPage_title=Source Git Repository
 SourceBranchPage_branchList=Branches of {0}:
 SourceBranchPage_selectAll=Select All
 SourceBranchPage_selectNone=Deselect All
-- 
1.5.6.3
