From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 6/6] Fetch GUI
Date: Wed, 27 Aug 2008 20:41:46 +0200
Message-ID: <1219862506-11075-7-git-send-email-marek.zawirski@gmail.com>
References: <1219862506-11075-1-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-2-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-3-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-4-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-5-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-6-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Aug 27 20:43:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYPzN-0005iW-EV
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 20:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbYH0SmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 14:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756238AbYH0SmV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 14:42:21 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:36375 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858AbYH0SmN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 14:42:13 -0400
Received: by gv-out-0910.google.com with SMTP id e6so522214gvc.37
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GuM3pNIbZd2mloEUdNj/cxDoqol7W129MsrBf5SarKw=;
        b=w2w7uBBbey3IBilYFJMR7/6KToS/y+/XXzkbxJUF5pA9fwDypBxQlmB1n+42N3Tw8V
         ceC2zhuebK2CU1qzD7xdCxcxb2DVdprG71L0Lym6ciqiAgW2/ThQjhxGgyFd8Yuq05rR
         ilOIAx/ltzWt2Qpv/YaJyaoEOgWX2OBR3slwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y8WZUojke2L8GiV0PMTKaAk2rY44SUrQlco+EGfuGXx+gKI+BJgij/8VszeOH76x0N
         HxdJSaEuOmhSwWHVwaTrynApo1VgMSKsGpB49a6QBl2xY60wNqQNKtvWIRt75EqpL2NO
         h+b1vmtn7dIjgmqRe5dhZ5giWmjASNPwN9XdI=
Received: by 10.103.16.16 with SMTP id t16mr174268mui.131.1219862531823;
        Wed, 27 Aug 2008 11:42:11 -0700 (PDT)
Received: from localhost ( [62.21.4.140])
        by mx.google.com with ESMTPS id s10sm11038082muh.12.2008.08.27.11.42.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 11:42:09 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219862506-11075-6-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93919>

Fetch GUI is currently implemented similarly to push GUI - it's a wizard
consisting of 2 pages:
- repository seleciton page (configured remote or custom URI)
- ref specs selection page (ref specs + tag options)

Background fetch job is started upon wizard finish. When operation
completes, simple dialog with fetch results is displayed.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 org.spearce.egit.ui/plugin.properties              |    3 +
 org.spearce.egit.ui/plugin.xml                     |   15 ++
 .../src/org/spearce/egit/ui/UIText.java            |   87 ++++++++
 .../egit/ui/internal/actions/FetchAction.java      |   51 +++++
 .../egit/ui/internal/fetch/FetchResultDialog.java  |   76 +++++++
 .../egit/ui/internal/fetch/FetchResultTable.java   |  213 ++++++++++++++++++++
 .../egit/ui/internal/fetch/FetchWizard.java        |  189 +++++++++++++++++
 .../fetch/TrackingRefUpdateContentProvider.java    |   41 ++++
 .../src/org/spearce/egit/ui/uitext.properties      |   33 +++
 9 files changed, 708 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/FetchAction.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchResultDialog.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchResultTable.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchWizard.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/TrackingRefUpdateContentProvider.java

diff --git a/org.spearce.egit.ui/plugin.properties b/org.spearce.egit.ui/plugin.properties
index 8ac3474..da91e48 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -41,6 +41,9 @@ ResetAction_tooltip=Reset the current branch to the same or another commit
 BranchAction_label=&Branch...
 BranchAction_tooltip=Switch to another branch
 
+FetchAction_label=&Fetch From...
+FetchAction_tooltip=Fetch from another repository
+
 PushAction_label=&Push To...
 PushAction_tooltip=Push to another repository
 
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index 4012f19..55207eb 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -40,6 +40,12 @@
                id="org.spearce.egit.ui.internal.actions.Disconnect">
          </action>
          <action
+               class="org.spearce.egit.ui.internal.actions.FetchAction"
+               id="org.spearce.egit.ui.internal.actions.FetchAction"
+               label="%FetchAction_label"
+               menubarPath="team.main/projectGroup"
+               tooltip="%FetchAction_tooltip"/>
+         <action
                class="org.spearce.egit.ui.internal.actions.PushAction"
                id="org.spearce.egit.ui.internal.actions.PushAction"
                label="%PushAction_label"
@@ -259,6 +265,15 @@
         </separator>
 	    </menu>
 		<action
+		       class="org.spearce.egit.ui.internal.actions.FetchAction"
+		       id="org.spearce.egit.ui.actionfetch"
+		       label="%FetchAction_label"
+		       style="push"
+		       menubarPath="org.spearce.egit.ui.gitmenu/repo"
+		       toolbarPath="org.spearce.egit.ui"
+		       tooltip="%FetchAction_tooltip">
+		</action>
+		<action
 		       class="org.spearce.egit.ui.internal.actions.PushAction"
 		       id="org.spearce.egit.ui.actionpush"
 		       label="%PushAction_label"
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index ab70048..b2cb340 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -614,6 +614,93 @@
 	public static String ResultDialog_label;
 
 	/** */
+	public static String FetchAction_wrongURITitle;
+
+	/** */
+	public static String FetchAction_wrongURIMessage;
+
+	/** */
+	public static String FetchResultDialog_labelEmptyResult;
+
+	/** */
+	public static String FetchResultDialog_labelNonEmptyResult;
+
+	/** */
+	public static String FetchResultDialog_title;
+
+	/** */
+	public static String FetchResultTable_columnDst;
+
+	/** */
+	public static String FetchResultTable_columnSrc;
+
+	/** */
+	public static String FetchResultTable_columnStatus;
+
+	/** */
+	public static String FetchResultTable_statusDetailCouldntLock;
+
+	/** */
+	public static String FetchResultTable_statusDetailFastForward;
+
+	/** */
+	public static String FetchResultTable_statusDetailIOError;
+
+	/** */
+	public static String FetchResultTable_statusDetailNonFastForward;
+
+	/** */
+	public static String FetchResultTable_statusIOError;
+
+	/** */
+	public static String FetchResultTable_statusLockFailure;
+
+	/** */
+	public static String FetchResultTable_statusNewBranch;
+
+	/** */
+	public static String FetchResultTable_statusNew;
+
+	/** */
+	public static String FetchResultTable_statusNewTag;
+
+	/** */
+	public static String FetchResultTable_statusRejected;
+
+	/** */
+	public static String FetchResultTable_statusUnexpected;
+
+	/** */
+	public static String FetchResultTable_statusUpToDate;
+
+	/** */
+	public static String FetchWizard_cantSaveMessage;
+
+	/** */
+	public static String FetchWizard_cantSaveTitle;
+
+	/** */
+	public static String FetchWizard_fetchNotSupported;
+
+	/** */
+	public static String FetchWizard_jobName;
+
+	/** */
+	public static String FetchWizard_transportError;
+
+	/** */
+	public static String FetchWizard_transportNotSupportedMessage;
+
+	/** */
+	public static String FetchWizard_transportNotSupportedTitle;
+
+	/** */
+	public static String FetchWizard_windowTitleDefault;
+
+	/** */
+	public static String FetchWizard_windowTitleWithSource;
+
+	/** */
 	public static String WindowCachePreferencePage_title;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/FetchAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/FetchAction.java
new file mode 100644
index 0000000..582cb46
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/FetchAction.java
@@ -0,0 +1,51 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.actions;
+
+import java.net.URISyntaxException;
+
+import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.Status;
+import org.eclipse.jface.action.IAction;
+import org.eclipse.jface.dialogs.ErrorDialog;
+import org.eclipse.jface.wizard.WizardDialog;
+import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIText;
+import org.spearce.egit.ui.internal.fetch.FetchWizard;
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * Action for displaying fetch wizard - allowing selection of specifications for
+ * fetch, and fetching objects/refs from another repository.
+ */
+public class FetchAction extends RepositoryAction {
+	@Override
+	public void run(IAction action) {
+		final Repository repository = getRepository(true);
+		if (repository == null)
+			return;
+
+		final FetchWizard fetchWizard;
+		try {
+			fetchWizard = new FetchWizard(repository);
+		} catch (URISyntaxException x) {
+			ErrorDialog.openError(getShell(), UIText.FetchAction_wrongURITitle,
+					UIText.FetchAction_wrongURIMessage, new Status(
+							IStatus.ERROR, Activator.getPluginId(), x
+									.getMessage(), x));
+			return;
+		}
+		final WizardDialog dialog = new WizardDialog(getShell(), fetchWizard);
+		dialog.open();
+	}
+
+	@Override
+	public boolean isEnabled() {
+		return getRepository(false) != null;
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchResultDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchResultDialog.java
new file mode 100644
index 0000000..4b52b8d
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchResultDialog.java
@@ -0,0 +1,76 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.fetch;
+
+import org.eclipse.jface.dialogs.Dialog;
+import org.eclipse.jface.dialogs.IDialogConstants;
+import org.eclipse.osgi.util.NLS;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Control;
+import org.eclipse.swt.widgets.Label;
+import org.eclipse.swt.widgets.Shell;
+import org.spearce.egit.ui.UIText;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.transport.FetchResult;
+
+/**
+ * Dialog displaying result of fetch operation.
+ */
+class FetchResultDialog extends Dialog {
+	private final Repository localDb;
+
+	private final FetchResult result;
+
+	private final String sourceString;
+
+	FetchResultDialog(final Shell parentShell, final Repository localDb,
+			final FetchResult result, final String sourceString) {
+		super(parentShell);
+		setShellStyle(getShellStyle() | SWT.RESIZE);
+		this.localDb = localDb;
+		this.result = result;
+		this.sourceString = sourceString;
+	}
+
+	@Override
+	protected void createButtonsForButtonBar(final Composite parent) {
+		createButton(parent, IDialogConstants.OK_ID, IDialogConstants.OK_LABEL,
+				true);
+	}
+
+	@Override
+	protected Control createDialogArea(final Composite parent) {
+		final Composite composite = (Composite) super.createDialogArea(parent);
+
+		final Label label = new Label(composite, SWT.NONE);
+		final String text;
+		if (!result.getTrackingRefUpdates().isEmpty())
+			text = NLS.bind(UIText.FetchResultDialog_labelNonEmptyResult,
+					sourceString);
+		else
+			text = NLS.bind(UIText.FetchResultDialog_labelEmptyResult,
+					sourceString);
+		label.setText(text);
+		label.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, false));
+
+		final FetchResultTable table = new FetchResultTable(composite);
+		table.setData(localDb, result);
+		final Control tableControl = table.getControl();
+		final GridData tableLayout = new GridData(SWT.FILL, SWT.FILL, true,
+				true);
+		tableLayout.widthHint = 600;
+		tableLayout.heightHint = 300;
+		tableControl.setLayoutData(tableLayout);
+
+		getShell().setText(
+				NLS.bind(UIText.FetchResultDialog_title, sourceString));
+		return composite;
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchResultTable.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchResultTable.java
new file mode 100644
index 0000000..868ca94
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchResultTable.java
@@ -0,0 +1,213 @@
+package org.spearce.egit.ui.internal.fetch;
+
+import org.eclipse.jface.layout.TableColumnLayout;
+import org.eclipse.jface.resource.ColorRegistry;
+import org.eclipse.jface.viewers.ColumnLabelProvider;
+import org.eclipse.jface.viewers.ColumnViewerToolTipSupport;
+import org.eclipse.jface.viewers.ColumnWeightData;
+import org.eclipse.jface.viewers.TableViewer;
+import org.eclipse.jface.viewers.TableViewerColumn;
+import org.eclipse.osgi.util.NLS;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.graphics.Color;
+import org.eclipse.swt.graphics.RGB;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.layout.GridLayout;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Control;
+import org.eclipse.swt.widgets.Table;
+import org.eclipse.swt.widgets.TableColumn;
+import org.spearce.egit.ui.UIText;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.RefUpdate;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RefUpdate.Result;
+import org.spearce.jgit.transport.FetchResult;
+import org.spearce.jgit.transport.TrackingRefUpdate;
+
+/**
+ * Component displaying table with results of fetch operation.
+ */
+class FetchResultTable {
+	private static final int TABLE_PREFERRED_HEIGHT = 600;
+
+	private static final int TABLE_PREFERRED_WIDTH = 300;
+
+	private static final int COLUMN_SRC_WEIGHT = 10;
+
+	private static final int COLUMN_DST_WEIGHT = 10;
+
+	private static final int COLUMN_STATUS_WEIGHT = 7;
+
+	private static final String COLOR_REJECTED_KEY = "REJECTED"; //$NON-NLS-1$
+
+	private static final RGB COLOR_REJECTED = new RGB(255, 0, 0);
+
+	private static final String COLOR_UPDATED_KEY = "UPDATED"; //$NON-NLS-1$
+
+	private static final RGB COLOR_UPDATED = new RGB(0, 255, 0);
+
+	private static final String COLOR_UP_TO_DATE_KEY = "UP_TO_DATE"; //$NON-NLS-1$
+
+	private static final RGB COLOR_UP_TO_DATE = new RGB(245, 245, 245);
+
+	private final Composite tablePanel;
+
+	private final TableViewer tableViewer;
+
+	private final ColorRegistry colorRegistry;
+
+	private Repository db;
+
+	FetchResultTable(final Composite parent) {
+		tablePanel = new Composite(parent, SWT.NONE);
+		tablePanel.setLayout(new GridLayout());
+		final GridData layoutData = new GridData(SWT.FILL, SWT.FILL, true, true);
+		layoutData.heightHint = TABLE_PREFERRED_HEIGHT;
+		layoutData.widthHint = TABLE_PREFERRED_WIDTH;
+		tableViewer = new TableViewer(tablePanel);
+		ColumnViewerToolTipSupport.enableFor(tableViewer);
+		final Table table = tableViewer.getTable();
+		table.setLinesVisible(true);
+		table.setHeaderVisible(true);
+
+		colorRegistry = new ColorRegistry(table.getDisplay());
+		colorRegistry.put(COLOR_REJECTED_KEY, COLOR_REJECTED);
+		colorRegistry.put(COLOR_UPDATED_KEY, COLOR_UPDATED);
+		colorRegistry.put(COLOR_UP_TO_DATE_KEY, COLOR_UP_TO_DATE);
+
+		tableViewer.setContentProvider(new TrackingRefUpdateContentProvider());
+		tableViewer.setInput(null);
+
+		createTableColumns();
+	}
+
+	void setData(final Repository db, final FetchResult fetchResult) {
+		tableViewer.setInput(null);
+		this.db = db;
+		tableViewer.setInput(fetchResult);
+	}
+
+	Control getControl() {
+		return tablePanel;
+	}
+
+	private void createTableColumns() {
+		final TableColumnLayout layout = new TableColumnLayout();
+		tablePanel.setLayout(layout);
+
+		final TableViewerColumn srcViewer = createColumn(layout,
+				UIText.FetchResultTable_columnSrc, COLUMN_SRC_WEIGHT, SWT.LEFT);
+		srcViewer.setLabelProvider(new ColumnLabelProvider() {
+			@Override
+			public String getText(Object element) {
+				return ((TrackingRefUpdate) element).getRemoteName();
+			}
+		});
+
+		final TableViewerColumn dstViewer = createColumn(layout,
+				UIText.FetchResultTable_columnDst, COLUMN_DST_WEIGHT, SWT.LEFT);
+		dstViewer.setLabelProvider(new ColumnLabelProvider() {
+			@Override
+			public String getText(Object element) {
+				return ((TrackingRefUpdate) element).getLocalName();
+			}
+		});
+
+		final TableViewerColumn statusViewer = createColumn(layout,
+				UIText.FetchResultTable_columnStatus, COLUMN_STATUS_WEIGHT,
+				SWT.LEFT);
+		statusViewer.setLabelProvider(new ColumnLabelProvider() {
+			@Override
+			public String getText(final Object element) {
+				final TrackingRefUpdate tru = (TrackingRefUpdate) element;
+				final RefUpdate.Result r = tru.getResult();
+				if (r == RefUpdate.Result.LOCK_FAILURE)
+					return UIText.FetchResultTable_statusLockFailure;
+
+				if (r == RefUpdate.Result.IO_FAILURE)
+					return UIText.FetchResultTable_statusIOError;
+
+				if (r == RefUpdate.Result.NEW) {
+					if (tru.getRemoteName().startsWith(Constants.R_HEADS))
+						return UIText.FetchResultTable_statusNewBranch;
+					else if (tru.getLocalName().startsWith(Constants.R_TAGS))
+						return UIText.FetchResultTable_statusNewTag;
+					return UIText.FetchResultTable_statusNew;
+				}
+
+				if (r == RefUpdate.Result.FORCED) {
+					final String aOld = tru.getOldObjectId().abbreviate(db);
+					final String aNew = tru.getNewObjectId().abbreviate(db);
+					return aOld + "..." + aNew; //$NON-NLS-1$
+				}
+
+				if (r == RefUpdate.Result.FAST_FORWARD) {
+					final String aOld = tru.getOldObjectId().abbreviate(db);
+					final String aNew = tru.getNewObjectId().abbreviate(db);
+					return aOld + ".." + aNew; //$NON-NLS-1$
+				}
+
+				if (r == RefUpdate.Result.REJECTED)
+					return UIText.FetchResultTable_statusRejected;
+				if (r == RefUpdate.Result.NO_CHANGE)
+					return UIText.FetchResultTable_statusUpToDate;
+				throw new IllegalArgumentException(NLS.bind(
+						UIText.FetchResultTable_statusUnexpected, r));
+			}
+
+			@Override
+			public String getToolTipText(final Object element) {
+				final Result result = ((TrackingRefUpdate) element).getResult();
+				switch (result) {
+				case FAST_FORWARD:
+					return UIText.FetchResultTable_statusDetailFastForward;
+				case FORCED:
+				case REJECTED:
+					return UIText.FetchResultTable_statusDetailNonFastForward;
+				case NEW:
+				case NO_CHANGE:
+					return null;
+				case IO_FAILURE:
+					return UIText.FetchResultTable_statusDetailIOError;
+				case LOCK_FAILURE:
+					return UIText.FetchResultTable_statusDetailCouldntLock;
+				default:
+					throw new IllegalArgumentException(NLS.bind(
+							UIText.FetchResultTable_statusUnexpected, result));
+				}
+			}
+
+			@Override
+			public Color getBackground(final Object element) {
+				final Result result = ((TrackingRefUpdate) element).getResult();
+				switch (result) {
+				case FAST_FORWARD:
+				case FORCED:
+				case NEW:
+					return colorRegistry.get(COLOR_UPDATED_KEY);
+				case NO_CHANGE:
+					return colorRegistry.get(COLOR_UP_TO_DATE_KEY);
+				case IO_FAILURE:
+				case LOCK_FAILURE:
+				case REJECTED:
+					return colorRegistry.get(COLOR_REJECTED_KEY);
+				default:
+					throw new IllegalArgumentException(NLS.bind(
+							UIText.FetchResultTable_statusUnexpected, result));
+				}
+			}
+		});
+	}
+
+	private TableViewerColumn createColumn(
+			final TableColumnLayout columnLayout, final String text,
+			final int weight, final int style) {
+		final TableViewerColumn viewerColumn = new TableViewerColumn(
+				tableViewer, style);
+		final TableColumn column = viewerColumn.getColumn();
+		column.setText(text);
+		columnLayout.setColumnData(column, new ColumnWeightData(weight));
+		return viewerColumn;
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchWizard.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchWizard.java
new file mode 100644
index 0000000..db383cf
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchWizard.java
@@ -0,0 +1,189 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.fetch;
+
+import java.io.IOException;
+import java.net.URISyntaxException;
+import java.util.List;
+
+import org.eclipse.core.runtime.IProgressMonitor;
+import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.NullProgressMonitor;
+import org.eclipse.core.runtime.Status;
+import org.eclipse.core.runtime.jobs.Job;
+import org.eclipse.jface.dialogs.Dialog;
+import org.eclipse.jface.dialogs.ErrorDialog;
+import org.eclipse.jface.wizard.IWizardPage;
+import org.eclipse.jface.wizard.Wizard;
+import org.eclipse.osgi.util.NLS;
+import org.eclipse.swt.widgets.Shell;
+import org.eclipse.ui.PlatformUI;
+import org.spearce.egit.core.EclipseGitProgressTransformer;
+import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIIcons;
+import org.spearce.egit.ui.UIText;
+import org.spearce.egit.ui.internal.components.RefSpecPage;
+import org.spearce.egit.ui.internal.components.RepositorySelection;
+import org.spearce.egit.ui.internal.components.RepositorySelectionPage;
+import org.spearce.jgit.errors.NotSupportedException;
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryConfig;
+import org.spearce.jgit.transport.FetchResult;
+import org.spearce.jgit.transport.RefSpec;
+import org.spearce.jgit.transport.RemoteConfig;
+import org.spearce.jgit.transport.Transport;
+
+/**
+ * Wizard allowing user to specify all needed data to fetch from another
+ * repository - including selection of remote repository, ref specifications,
+ * annotated tags fetching strategy.
+ * <p>
+ * Fetch operation is performed upon successful completion of this wizard.
+ */
+public class FetchWizard extends Wizard {
+	private final Repository localDb;
+
+	private final RepositorySelectionPage repoPage;
+
+	private final RefSpecPage refSpecPage;
+
+	/**
+	 * Create wizard for provided local repository.
+	 * 
+	 * @param localDb
+	 *            local repository to fetch to.
+	 * @throws URISyntaxException
+	 *             when configuration of this repository contains illegal URIs.
+	 */
+	public FetchWizard(final Repository localDb) throws URISyntaxException {
+		this.localDb = localDb;
+		final List<RemoteConfig> remotes = RemoteConfig
+				.getAllRemoteConfigs(localDb.getConfig());
+		repoPage = new RepositorySelectionPage(true, remotes);
+		refSpecPage = new RefSpecPage(localDb, false, repoPage);
+		// TODO use/create another cool icon
+		setDefaultPageImageDescriptor(UIIcons.WIZBAN_IMPORT_REPO);
+		setNeedsProgressMonitor(true);
+	}
+
+	@Override
+	public void addPages() {
+		addPage(repoPage);
+		addPage(refSpecPage);
+	}
+
+	@Override
+	public boolean performFinish() {
+		if (repoPage.getSelection().isConfigSelected()
+				&& refSpecPage.isSaveRequested())
+			saveConfig();
+
+		final Transport transport;
+		final RepositorySelection repoSelection = repoPage.getSelection();
+		try {
+			if (repoSelection.isConfigSelected())
+				transport = Transport.open(localDb, repoSelection.getConfig());
+			else
+				transport = Transport.open(localDb, repoSelection.getURI());
+		} catch (final NotSupportedException e) {
+			ErrorDialog.openError(getShell(),
+					UIText.FetchWizard_transportNotSupportedTitle,
+					UIText.FetchWizard_transportNotSupportedMessage,
+					new Status(IStatus.ERROR, org.spearce.egit.ui.Activator
+							.getPluginId(), e.getMessage(), e));
+			return false;
+		}
+		transport.setTagOpt(refSpecPage.getTagOpt());
+
+		final Job fetchJob = new FetchJob(transport, refSpecPage.getRefSpecs(),
+				getSourceString());
+		fetchJob.setUser(true);
+		fetchJob.schedule();
+		return true;
+	}
+
+	@Override
+	public String getWindowTitle() {
+		final IWizardPage currentPage = getContainer().getCurrentPage();
+		if (currentPage == repoPage || currentPage == null)
+			return UIText.FetchWizard_windowTitleDefault;
+		return NLS.bind(UIText.FetchWizard_windowTitleWithSource,
+				getSourceString());
+	}
+
+	private void saveConfig() {
+		final RemoteConfig rc = repoPage.getSelection().getConfig();
+		rc.setFetchRefSpecs(refSpecPage.getRefSpecs());
+		rc.setTagOpt(refSpecPage.getTagOpt());
+		final RepositoryConfig config = localDb.getConfig();
+		rc.update(config);
+		try {
+			config.save();
+		} catch (final IOException e) {
+			ErrorDialog.openError(getShell(), UIText.FetchWizard_cantSaveTitle,
+					UIText.FetchWizard_cantSaveMessage, new Status(
+							IStatus.WARNING, Activator.getPluginId(), e
+									.getMessage(), e));
+			// Continue, it's not critical.
+		}
+	}
+
+	private String getSourceString() {
+		final RepositorySelection repoSelection = repoPage.getSelection();
+		if (repoSelection.isConfigSelected())
+			return repoSelection.getConfigName();
+		return repoSelection.getURI().toString();
+	}
+
+	private class FetchJob extends Job {
+		private final Transport transport;
+
+		private final List<RefSpec> refSpecs;
+
+		private final String sourceString;
+
+		public FetchJob(final Transport transport,
+				final List<RefSpec> refSpecs, final String sourceString) {
+			super(NLS.bind(UIText.FetchWizard_jobName, sourceString));
+			this.transport = transport;
+			this.refSpecs = refSpecs;
+			this.sourceString = sourceString;
+		}
+
+		@Override
+		protected IStatus run(IProgressMonitor monitor) {
+			if (monitor == null)
+				monitor = new NullProgressMonitor();
+			final FetchResult result;
+			try {
+				result = transport.fetch(new EclipseGitProgressTransformer(
+						monitor), refSpecs);
+			} catch (final NotSupportedException e) {
+				return new Status(IStatus.ERROR, Activator.getPluginId(),
+						UIText.FetchWizard_fetchNotSupported, e);
+			} catch (final TransportException e) {
+				if (monitor.isCanceled())
+					return Status.CANCEL_STATUS;
+				return new Status(IStatus.ERROR, Activator.getPluginId(),
+						UIText.FetchWizard_transportError, e);
+			}
+
+			PlatformUI.getWorkbench().getDisplay().asyncExec(new Runnable() {
+				public void run() {
+					final Shell shell = PlatformUI.getWorkbench()
+							.getActiveWorkbenchWindow().getShell();
+					final Dialog dialog = new FetchResultDialog(shell, localDb,
+							result, sourceString);
+					dialog.open();
+				}
+			});
+			return Status.OK_STATUS;
+		}
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/TrackingRefUpdateContentProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/TrackingRefUpdateContentProvider.java
new file mode 100644
index 0000000..35d37d0
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/TrackingRefUpdateContentProvider.java
@@ -0,0 +1,41 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.fetch;
+
+import org.eclipse.jface.viewers.IStructuredContentProvider;
+import org.eclipse.jface.viewers.Viewer;
+import org.spearce.jgit.transport.FetchResult;
+import org.spearce.jgit.transport.TrackingRefUpdate;
+
+/**
+ * Content provided for fetch result table viewer.
+ * <p>
+ * Input of this provided must be {@link FetchResult} instance, while returned
+ * elements are instances of {@link TrackingRefUpdate}. Input may be null (no
+ * elements).
+ * 
+ * @see FetchResult
+ * @see TrackingRefUpdate
+ */
+class TrackingRefUpdateContentProvider implements IStructuredContentProvider {
+	public Object[] getElements(final Object inputElement) {
+		if (inputElement == null)
+			return new TrackingRefUpdate[0];
+
+		final FetchResult result = (FetchResult) inputElement;
+		return result.getTrackingRefUpdates().toArray(new TrackingRefUpdate[0]);
+	}
+
+	public void dispose() {
+		// nothing to do
+	}
+
+	public void inputChanged(Viewer viewer, Object oldInput, Object newInput) {
+		// nothing to do
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 2349334..0590e30 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -234,6 +234,39 @@ PushResultTable_statusOkNewTag=[new tag]
 ResultDialog_title=Push Results: {0}
 ResultDialog_label=Pushed to {0}.
 
+FetchAction_wrongURITitle=Corrupted Configuration
+FetchAction_wrongURIMessage=Remote repositories URIs configuration is corrupted.
+
+FetchResultDialog_labelEmptyResult=No ref to fetch from {0} - everything up to date.
+FetchResultDialog_labelNonEmptyResult=Fetched from {0}.
+FetchResultDialog_title=Fetch Results: {0}
+
+FetchResultTable_columnDst=Destination Ref
+FetchResultTable_columnSrc=Source Ref
+FetchResultTable_columnStatus=Status
+FetchResultTable_statusDetailCouldntLock=couldn't lock local tracking ref for update
+FetchResultTable_statusDetailFastForward=fast forward
+FetchResultTable_statusDetailIOError=I/O error occurred during local tracking ref update
+FetchResultTable_statusDetailNonFastForward=non-fast forward
+FetchResultTable_statusIOError=[i/o error]
+FetchResultTable_statusLockFailure=[lock fail]
+FetchResultTable_statusNew=[new]
+FetchResultTable_statusNewBranch=[new branch]
+FetchResultTable_statusNewTag=[new tag]
+FetchResultTable_statusRejected=[rejected]
+FetchResultTable_statusUnexpected=Unexpected update status: {0}
+FetchResultTable_statusUpToDate=[up to date]
+
+FetchWizard_cantSaveMessage=Couldn't save specified specifications in configuration file.
+FetchWizard_cantSaveTitle=Configuration Storage Warning
+FetchWizard_fetchNotSupported=Fetch operation is not supported by this transport.
+FetchWizard_jobName=Fetching from: {0}
+FetchWizard_transportError=Transport error occured during fetch operation.
+FetchWizard_transportNotSupportedMessage=Selected URI is not supported by any transport implementation.
+FetchWizard_transportNotSupportedTitle=Transport Not Supported
+FetchWizard_windowTitleDefault=Fetch From Another Repository
+FetchWizard_windowTitleWithSource=Fetch From: {0}
+
 WindowCachePreferencePage_title=Git Window Cache
 WindowCachePreferencePage_packedGitWindowSize=Window size:
 WindowCachePreferencePage_packedGitLimit=Window cache limit:
-- 
1.5.6.3
