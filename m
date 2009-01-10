From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Use text resources for the Commit dialog and add shortcuts.
Date: Sat, 10 Jan 2009 18:21:06 +0100
Message-ID: <1231608066-25921-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jan 10 18:23:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLhXi-0005y7-TI
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 18:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbZAJRVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 12:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbZAJRVM
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 12:21:12 -0500
Received: from mail.dewire.com ([83.140.172.130]:10826 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbZAJRVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 12:21:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BE1A11484F7C;
	Sat, 10 Jan 2009 18:21:08 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RmE3VykWOu47; Sat, 10 Jan 2009 18:21:07 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 5CA531484F72;
	Sat, 10 Jan 2009 18:21:07 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105132>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |   75 ++++++++++++++++++++
 .../egit/ui/internal/dialogs/CommitDialog.java     |   67 +++++++++---------
 .../src/org/spearce/egit/ui/uitext.properties      |   25 +++++++
 3 files changed, 134 insertions(+), 33 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 30122d2..0abb209 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -566,6 +566,81 @@
 	public static String PushWizard_windowTitleWithDestination;
 
 	/** */
+	public static String CommitDialog_AddFileOnDiskToIndex;
+
+	/** */
+	public static String CommitDialog_AddSOB;
+
+	/** */
+	public static String CommitDialog_AmendPreviousCommit;
+
+	/** */
+	public static String CommitDialog_Author;
+
+	/** */
+	public static String CommitDialog_Commit;
+
+	/** */
+	public static String CommitDialog_CommitChanges;
+
+	/** */
+	public static String CommitDialog_CommitMessage;
+
+	/** */
+	public static String CommitDialog_DeselectAll;
+
+	/** */
+	public static String CommitDialog_ErrorInvalidAuthor;
+
+	/** */
+	public static String CommitDialog_ErrorInvalidAuthorSpecified;
+
+	/** */
+	public static String CommitDialog_ErrorMustEnterCommitMessage;
+
+	/** */
+	public static String CommitDialog_ErrorNoItemsSelected;
+
+	/** */
+	public static String CommitDialog_ErrorNoItemsSelectedToBeCommitted;
+
+	/** */
+	public static String CommitDialog_ErrorNoMessage;
+
+	/** */
+	public static String CommitDialog_File;
+
+	/** */
+	public static String CommitDialog_SelectAll;
+
+	/** */
+	public static String CommitDialog_Status;
+
+	/** */
+	public static String CommitDialog_StatusAdded;
+
+	/** */
+	public static String CommitDialog_StatusAddedIndexDiff;
+
+	/** */
+	public static String CommitDialog_StatusModified;
+
+	/** */
+	public static String CommitDialog_StatusModifiedIndexDiff;
+
+	/** */
+	public static String CommitDialog_StatusModifiedNotStaged;
+
+	/** */
+	public static String CommitDialog_StatusRemoved;
+
+	/** */
+	public static String CommitDialog_StatusRemovedNotStaged;
+
+	/** */
+	public static String CommitDialog_StatusUnknown;
+
+	/** */
 	public static String ConfirmationPage_cantConnectToAnyTitle;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index f32112b..fede948 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -52,6 +52,7 @@
 import org.eclipse.swt.widgets.Text;
 import org.eclipse.ui.model.WorkbenchLabelProvider;
 import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.egit.ui.UIText;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.GitIndex;
 import org.spearce.jgit.lib.PersonIdent;
@@ -92,7 +93,7 @@ public String getColumnText(Object obj, int columnIndex) {
 				return item.status;
 
 			case 1:
-				return item.file.getProject().getName() + ": "
+				return item.file.getProject().getName() + ": " //$NON-NLS-1$
 						+ item.file.getProjectRelativePath();
 
 			default:
@@ -118,10 +119,10 @@ public CommitDialog(Shell parentShell) {
 
 	@Override
 	protected void createButtonsForButtonBar(Composite parent) {
-		createButton(parent, IDialogConstants.SELECT_ALL_ID, "Select All", false);
-		createButton(parent, IDialogConstants.DESELECT_ALL_ID, "Deselect All", false);
+		createButton(parent, IDialogConstants.SELECT_ALL_ID, UIText.CommitDialog_SelectAll, false);
+		createButton(parent, IDialogConstants.DESELECT_ALL_ID, UIText.CommitDialog_DeselectAll, false);
 
-		createButton(parent, IDialogConstants.OK_ID, "Commit", true);
+		createButton(parent, IDialogConstants.OK_ID, UIText.CommitDialog_Commit, true);
 		createButton(parent, IDialogConstants.CANCEL_ID,
 				IDialogConstants.CANCEL_LABEL, false);
 	}
@@ -130,19 +131,19 @@ createButton(parent, IDialogConstants.CANCEL_ID,
 	Text authorText;
 	Button amendingButton;
 	Button signedOffButton;
-	
+
 	CheckboxTableViewer filesViewer;
 
 	@Override
 	protected Control createDialogArea(Composite parent) {
 		Composite container = (Composite) super.createDialogArea(parent);
-		parent.getShell().setText("Commit Changes");
+		parent.getShell().setText(UIText.CommitDialog_CommitChanges);
 
 		GridLayout layout = new GridLayout(2, false);
 		container.setLayout(layout);
 
 		Label label = new Label(container, SWT.LEFT);
-		label.setText("Commit Message:");
+		label.setText(UIText.CommitDialog_CommitMessage);
 		label.setLayoutData(GridDataFactory.fillDefaults().span(2, 1).grab(true, false).create());
 
 		commitText = new Text(container, SWT.MULTI | SWT.BORDER | SWT.V_SCROLL);
@@ -163,7 +164,7 @@ public void keyPressed(KeyEvent arg0) {
 			}
 		});
 
-		new Label(container, SWT.LEFT).setText("Author: ");
+		new Label(container, SWT.LEFT).setText(UIText.CommitDialog_Author);
 		authorText = new Text(container, SWT.BORDER);
 		authorText.setLayoutData(GridDataFactory.fillDefaults().grab(true, false).create());
 		if (author != null)
@@ -186,24 +187,24 @@ public void widgetSelected(SelectionEvent arg0) {
 					alreadyAdded = true;
 					String curText = commitText.getText();
 					if (curText.length() > 0)
-						curText += "\n";
+						curText += "\n"; //$NON-NLS-1$
 					commitText.setText(curText + previousCommitMessage);
 				}
 			}
-		
+
 			public void widgetDefaultSelected(SelectionEvent arg0) {
 				// Empty
 			}
 		});
-		
-		amendingButton.setText("Amend previous commit");
+
+		amendingButton.setText(UIText.CommitDialog_AmendPreviousCommit);
 		amendingButton.setLayoutData(GridDataFactory.fillDefaults().grab(true, false).span(2, 1).create());
 
 		signedOffButton = new Button(container, SWT.CHECK);
 		signedOffButton.setSelection(signedOff);
-		signedOffButton.setText("Add Signed-off-by");
+		signedOffButton.setText(UIText.CommitDialog_AddSOB);
 		signedOffButton.setLayoutData(GridDataFactory.fillDefaults().grab(true, false).span(2, 1).create());
-		
+
 		Table resourcesTable = new Table(container, SWT.H_SCROLL | SWT.V_SCROLL
 				| SWT.FULL_SELECTION | SWT.MULTI | SWT.CHECK | SWT.BORDER);
 		resourcesTable.setLayoutData(GridDataFactory.fillDefaults().hint(600,
@@ -211,12 +212,12 @@ public void widgetDefaultSelected(SelectionEvent arg0) {
 
 		resourcesTable.setHeaderVisible(true);
 		TableColumn statCol = new TableColumn(resourcesTable, SWT.LEFT);
-		statCol.setText("Status");
+		statCol.setText(UIText.CommitDialog_Status);
 		statCol.setWidth(150);
 		statCol.addSelectionListener(new HeaderSelectionListener(CommitItem.Order.ByStatus));
 
 		TableColumn resourceCol = new TableColumn(resourcesTable, SWT.LEFT);
-		resourceCol.setText("File");
+		resourceCol.setText(UIText.CommitDialog_File);
 		resourceCol.setWidth(415);
 		resourceCol.addSelectionListener(new HeaderSelectionListener(CommitItem.Order.ByFile));
 
@@ -234,7 +235,7 @@ public void widgetDefaultSelected(SelectionEvent arg0) {
 	private Menu getContextMenu() {
 		Menu menu = new Menu(filesViewer.getTable());
 		MenuItem item = new MenuItem(menu, SWT.PUSH);
-		item.setText("Add file on disk to index");
+		item.setText(UIText.CommitDialog_AddFileOnDiskToIndex);
 		item.addListener(SWT.Selection, new Listener() {
 			public void handleEvent(Event arg0) {
 				IStructuredSelection sel = (IStructuredSelection) filesViewer.getSelection();
@@ -271,12 +272,12 @@ public void handleEvent(Event arg0) {
 				}
 			}
 		});
-		
+
 		return menu;
 	}
 
 	private static String getFileStatus(IFile file) {
-		String prefix = "Unknown";
+		String prefix = UIText.CommitDialog_StatusUnknown;
 
 		try {
 			RepositoryMapping repositoryMapping = RepositoryMapping
@@ -292,22 +293,22 @@ private static String getFileStatus(IFile file) {
 
 			Entry indexEntry = index.getEntry(repoPath);
 			if (headEntry == null) {
-				prefix = "Added";
+				prefix = UIText.CommitDialog_StatusAdded;
 				if (indexEntry.isModified(repositoryMapping.getWorkDir()))
-					prefix = "Added, index diff";
+					prefix = UIText.CommitDialog_StatusAddedIndexDiff;
 			} else if (indexEntry == null) {
-				prefix = "Removed";
+				prefix = UIText.CommitDialog_StatusRemoved;
 			} else if (headExists
 					&& !headEntry.getId().equals(indexEntry.getObjectId())) {
-				prefix = "Modified";
+				prefix = UIText.CommitDialog_StatusModified;
 
 				if (indexEntry.isModified(repositoryMapping.getWorkDir()))
-					prefix = "Mod., index diff";
+					prefix = UIText.CommitDialog_StatusModifiedIndexDiff;
 			} else if (!new File(repositoryMapping.getWorkDir(), indexEntry
 					.getName()).isFile()) {
-				prefix = "Rem., not staged";
+				prefix = UIText.CommitDialog_StatusRemovedNotStaged;
 			} else if (indexEntry.isModified(repositoryMapping.getWorkDir())) {
-				prefix = "Mod., not staged";
+				prefix = UIText.CommitDialog_StatusModifiedNotStaged;
 			}
 
 		} catch (Exception e) {
@@ -331,14 +332,14 @@ public void setCommitMessage(String s) {
 		this.commitMessage = s;
 	}
 
-	private String commitMessage = "";
+	private String commitMessage = ""; //$NON-NLS-1$
 	private String author = null;
 	private boolean signedOff = false;
 	private boolean amending = false;
 	private boolean amendAllowed = true;
 
 	private ArrayList<IFile> selectedFiles = new ArrayList<IFile>();
-	private String previousCommitMessage = "";
+	private String previousCommitMessage = ""; //$NON-NLS-1$
 
 	/**
 	 * Pre-select suggested set of resources to commit
@@ -398,28 +399,28 @@ protected void okPressed() {
 		author = authorText.getText().trim();
 		signedOff = signedOffButton.getSelection();
 		amending = amendingButton.getSelection();
-		
+
 		Object[] checkedElements = filesViewer.getCheckedElements();
 		selectedFiles.clear();
 		for (Object obj : checkedElements)
 			selectedFiles.add(((CommitItem) obj).file);
 
 		if (commitMessage.trim().length() == 0) {
-			MessageDialog.openWarning(getShell(), "No message", "You must enter a commit message");
+			MessageDialog.openWarning(getShell(), UIText.CommitDialog_ErrorNoMessage, UIText.CommitDialog_ErrorMustEnterCommitMessage);
 			return;
 		}
-		
+
 		if (author.length() > 0) {
 			try {
 				new PersonIdent(author);
 			} catch (IllegalArgumentException e) {
-				MessageDialog.openWarning(getShell(), "Invalid author", "Invalid author specified. Please use the form:\nA U Thor <author@example.com>");
+				MessageDialog.openWarning(getShell(), UIText.CommitDialog_ErrorInvalidAuthor, UIText.CommitDialog_ErrorInvalidAuthorSpecified);
 				return;
 			}
 		} else author = null;
 
 		if (selectedFiles.isEmpty() && !amending) {
-			MessageDialog.openWarning(getShell(), "No items selected", "No items are currently selected to be committed.");
+			MessageDialog.openWarning(getShell(), UIText.CommitDialog_ErrorNoItemsSelected, UIText.CommitDialog_ErrorNoItemsSelectedToBeCommitted);
 			return;
 		}
 		super.okPressed();
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 3819047..3c9a21c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -216,6 +216,31 @@ PushWizard_unexpectedError=Unexpected error occurred.
 PushWizard_windowTitleDefault=Push To Another Repositories
 PushWizard_windowTitleWithDestination=Push To: {0}
 
+CommitDialog_AddFileOnDiskToIndex=Add file on &disk to index
+CommitDialog_AddSOB=Add Signed-off-&by
+CommitDialog_AmendPreviousCommit=A&mend previous commit
+CommitDialog_Author=&Author:
+CommitDialog_Commit=&Commit
+CommitDialog_CommitChanges=Commit Changes
+CommitDialog_CommitMessage=Commit &Message:
+CommitDialog_DeselectAll=&Deselect All
+CommitDialog_ErrorInvalidAuthor=Invalid author
+CommitDialog_ErrorInvalidAuthorSpecified=Invalid author specified. Please use the form:\nA U Thor <author@example.com>
+CommitDialog_ErrorMustEnterCommitMessage=You must enter a commit message
+CommitDialog_ErrorNoItemsSelected=No items selected
+CommitDialog_ErrorNoItemsSelectedToBeCommitted=No items are currently selected to be committed.
+CommitDialog_ErrorNoMessage=No message
+CommitDialog_File=File
+CommitDialog_SelectAll=&Select All
+CommitDialog_Status=Status
+CommitDialog_StatusAdded=Added
+CommitDialog_StatusAddedIndexDiff=Added, index diff
+CommitDialog_StatusModified=Modified
+CommitDialog_StatusModifiedIndexDiff=Mod., index diff
+CommitDialog_StatusModifiedNotStaged=Mod., not staged
+CommitDialog_StatusRemoved=Removed
+CommitDialog_StatusRemovedNotStaged=Rem., not staged
+CommitDialog_StatusUnknown=Unknown
 ConfirmationPage_cantConnectToAnyTitle=Can't Connect
 ConfirmationPage_cantConnectToAny=Can't connect to any URI: {0}
 ConfirmationPage_description=Confirm following expected push result.
-- 
1.6.1.rc3.56.gd0306
