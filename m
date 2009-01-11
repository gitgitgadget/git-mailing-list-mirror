From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/2] Use text resources for branch dialog and add shortcuts.
Date: Sun, 11 Jan 2009 17:18:55 +0100
Message-ID: <1231690736-6452-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jan 11 17:21:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM33S-0004gR-QY
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 17:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbZAKQTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 11:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbZAKQTN
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 11:19:13 -0500
Received: from mail.dewire.com ([83.140.172.130]:14338 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754188AbZAKQTL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 11:19:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B4FA41484F78;
	Sun, 11 Jan 2009 17:19:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u12NJLwpzw52; Sun, 11 Jan 2009 17:19:00 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 6A25280321E;
	Sun, 11 Jan 2009 17:19:00 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105192>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |   72 +++++++++++++++
 .../ui/internal/dialogs/BranchSelectionDialog.java |   92 +++++++++++---------
 .../src/org/spearce/egit/ui/uitext.properties      |   25 ++++++
 3 files changed, 148 insertions(+), 41 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 124d7a0..c9610b0 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -760,6 +760,78 @@
 	/** */
 	public static String WindowCachePreferencePage_packedGitMMAP;
 
+	/** */
+	public static String BranchSelectionDialog_OkReset;
+
+	/** */
+	public static String BranchSelectionDialog_ErrorCouldNotRefreshBranchList;
+
+	/** */
+	public static String BranchSelectionDialog_ErrorCouldNotCreateNewRef;
+
+	/** */
+	public static String BranchSelectionDialog_ErrorCouldNotRefresh;
+
+	/** */
+	public static String BranchSelectionDialog_BranchSuffix_Current;
+
+	/** */
+	public static String BranchSelectionDialog_ResetType;
+
+	/** */
+	public static String BranchSelectionDialog_ResetTypeSoft;
+
+	/** */
+	public static String BranchSelectionDialog_ResetTypeMixed;
+
+	/** */
+	public static String BranchSelectionDialog_ResetTypeHard;
+
+	/** */
+	public static String BranchSelectionDialog_Tags;
+
+	/** */
+	public static String BranchSelectionDialog_RemoteBranches;
+
+	/** */
+	public static String BranchSelectionDialog_LocalBranches;
+
+	/** */
+	public static String BranchSelectionDialog_NoBranchSeletectTitle;
+
+	/** */
+	public static String BranchSelectionDialog_ReallyResetTitle;
+
+	/** */
+	public static String BranchSelectionDialog_ReallyResetMessage;
+
+	/** */
+	public static String BranchSelectionDialog_QuestionNewBranchTitle;
+
+	/** */
+	public static String BranchSelectionDialog_QuestionNewBranchMessage;
+
+	/** */
+	public static String BranchSelectionDialog_NewBranch;
+
+	/** */
+	public static String BranchSelectionDialog_ErrorAlreadyExists;
+
+	/** */
+	public static String BranchSelectionDialog_ErrorCouldNotResolve;
+
+	/** */
+	public static String BranchSelectionDialog_ErrorInvalidRefName;
+
+	/** */
+	public static String BranchSelectionDialog_OkCheckout;
+
+	/** */
+	public static String BranchSelectionDialog_NoBranchSeletectMessage;
+
+	/** */
+	public static String BranchSelectionDialog_Refs;
+
 	static {
 		initializeMessages(UIText.class.getPackage().getName() + ".uitext",
 				UIText.class);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
index 1641840..8859b5d 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
@@ -24,6 +24,7 @@
 import org.eclipse.jface.layout.GridLayoutFactory;
 import org.eclipse.jface.resource.JFaceResources;
 import org.eclipse.jface.window.Window;
+import org.eclipse.osgi.util.NLS;
 import org.eclipse.swt.SWT;
 import org.eclipse.swt.events.DisposeEvent;
 import org.eclipse.swt.events.DisposeListener;
@@ -37,12 +38,14 @@
 import org.eclipse.swt.widgets.Composite;
 import org.eclipse.swt.widgets.Event;
 import org.eclipse.swt.widgets.Group;
+import org.eclipse.swt.widgets.Label;
 import org.eclipse.swt.widgets.Listener;
 import org.eclipse.swt.widgets.Shell;
 import org.eclipse.swt.widgets.Tree;
 import org.eclipse.swt.widgets.TreeItem;
 import org.spearce.egit.core.op.ResetOperation.ResetType;
 import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIText;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.RefUpdate;
@@ -56,7 +59,7 @@
 	private final Repository repo;
 
 	private boolean showResetType = true;
-	
+
 	/**
 	 * Construct a dialog to select a branch to reset to or check out
 	 * @param parentShell
@@ -76,38 +79,38 @@ public void setShowResetType(boolean show) {
 	}
 
 	private Composite parent;
-	
+
 	private Tree branchTree;
-	
+
 	@Override
 	protected Composite createDialogArea(Composite base) {
 		parent = (Composite) super.createDialogArea(base);
 		parent.setLayout(GridLayoutFactory.swtDefaults().create());
-		
+		new Label(parent, SWT.NONE).setText(UIText.BranchSelectionDialog_Refs);
 		branchTree = new Tree(parent, SWT.NONE);
 		branchTree.setLayoutData(GridDataFactory.fillDefaults().grab(true,true).hint(500, 300).create());
-		
+
 		if (showResetType) {
 			buildResetGroup();
 		}
-		
+
 		try {
 			fillTreeWithBranches(null);
 		} catch (IOException e) {
-			Activator.logError("Could not refresh list of branches", e);
+			Activator.logError(UIText.BranchSelectionDialog_ErrorCouldNotRefresh, e);
 		}
-		
+
 		return parent;
 	}
 
 	private void buildResetGroup() {
 		Group g = new Group(parent, SWT.NONE);
-		g.setText("Reset Type");
+		g.setText(UIText.BranchSelectionDialog_ResetType);
 		g.setLayoutData(GridDataFactory.swtDefaults().align(SWT.CENTER, SWT.CENTER).create());
 		g.setLayout(new RowLayout(SWT.VERTICAL));
 
 		Button soft = new Button(g, SWT.RADIO);
-		soft.setText("Soft (Index and working directory unmodified)");
+		soft.setText(UIText.BranchSelectionDialog_ResetTypeSoft);
 		soft.addListener(SWT.Selection, new Listener() {
 			public void handleEvent(Event event) {
 				resetType = ResetType.SOFT;
@@ -116,7 +119,7 @@ public void handleEvent(Event event) {
 
 		Button medium = new Button(g, SWT.RADIO);
 		medium.setSelection(true);
-		medium.setText("Mixed (working directory unmodified)");
+		medium.setText(UIText.BranchSelectionDialog_ResetTypeMixed);
 		medium.addListener(SWT.Selection, new Listener() {
 			public void handleEvent(Event event) {
 				resetType = ResetType.MIXED;
@@ -124,7 +127,7 @@ public void handleEvent(Event event) {
 		});
 
 		Button hard = new Button(g, SWT.RADIO);
-		hard.setText("Hard");
+		hard.setText(UIText.BranchSelectionDialog_ResetTypeHard);
 		hard.addListener(SWT.Selection, new Listener() {
 			public void handleEvent(Event event) {
 				resetType = ResetType.HARD;
@@ -137,12 +140,12 @@ private void fillTreeWithBranches(String select) throws IOException {
 		List<String> branches = new ArrayList<String>(repo.getAllRefs()
 				.keySet());
 		Collections.sort(branches);
-		
+
 		TreeItem curItem = null;
 		TreeItem curSubItem = null;
 		String curPrefix = null;
 		String curSubPrefix = null;
-		
+
 		for (String ref : branches) {
 			String shortName = ref;
 			if (ref.startsWith(Constants.R_HEADS)) {
@@ -152,18 +155,18 @@ private void fillTreeWithBranches(String select) throws IOException {
 					curSubPrefix = null;
 					curSubItem = null;
 					curItem = new TreeItem(branchTree, SWT.NONE);
-					curItem.setText("Local Branches");
+					curItem.setText(UIText.BranchSelectionDialog_LocalBranches);
 				}
 			} else if (ref.startsWith(Constants.R_REMOTES)) {
 				shortName = ref.substring(13);
 				if (!Constants.R_REMOTES.equals(curPrefix)) {
 					curPrefix = Constants.R_REMOTES;
 					curItem = new TreeItem(branchTree, SWT.NONE);
-					curItem.setText("Remote Branches");
+					curItem.setText(UIText.BranchSelectionDialog_RemoteBranches);
 					curSubItem = null;
 					curSubPrefix = null;
-				} 
-				
+				}
+
 				int slashPos = shortName.indexOf("/");
 				if (slashPos > -1) {
 					String remoteName = shortName.substring(0, slashPos);
@@ -184,7 +187,7 @@ private void fillTreeWithBranches(String select) throws IOException {
 					curSubPrefix = null;
 					curSubItem = null;
 					curItem = new TreeItem(branchTree, SWT.NONE);
-					curItem.setText("Tags");
+					curItem.setText(UIText.BranchSelectionDialog_Tags);
 				}
 			}
 			TreeItem item;
@@ -195,7 +198,7 @@ else if (curSubItem == null)
 			else item = new TreeItem(curSubItem, SWT.NONE);
 			item.setData(ref);
 			if (ref.equals(branch)) {
-				item.setText(shortName + " (current)");
+				item.setText(shortName + UIText.BranchSelectionDialog_BranchSuffix_Current);
 				FontData fd = item.getFont().getFontData()[0];
 				fd.setStyle(fd.getStyle() | SWT.BOLD);
 				final Font f = new Font(getShell().getDisplay(), fd);
@@ -212,9 +215,9 @@ public void widgetDisposed(DisposeEvent e) {
 				branchTree.select(item);
 		}
 	}
-	
+
 	private String refName = null;
-	
+
 	/**
 	 * @return Selected ref
 	 */
@@ -223,32 +226,34 @@ public String getRefName() {
 	}
 
 	private ResetType resetType = ResetType.MIXED;
-	
+
 	/**
 	 * @return Type of Reset
 	 */
 	public ResetType getResetType() {
 		return resetType;
 	}
-	
+
 	@Override
 	protected void okPressed() {
 		refNameFromDialog();
 		if (refName == null) {
-			MessageDialog.openWarning(getShell(), "No branch/tag selected", "You must select a valid ref.");
+			MessageDialog.openWarning(getShell(),
+					UIText.BranchSelectionDialog_NoBranchSeletectTitle,
+					UIText.BranchSelectionDialog_NoBranchSeletectMessage);
 			return;
 		}
-		
+
 		if (showResetType) {
 			if (resetType == ResetType.HARD) {
-				if (!MessageDialog.openQuestion(getShell(), "Really reset?", 
-						"Resetting will overwrite any changes in your working directory.\n\n" +
-				"Do you wish to continue?")) {
+				if (!MessageDialog.openQuestion(getShell(),
+						UIText.BranchSelectionDialog_ReallyResetTitle,
+						UIText.BranchSelectionDialog_ReallyResetMessage)) {
 					return;
 				}
 			}
 		}
-		
+
 		super.okPressed();
 	}
 
@@ -266,7 +271,7 @@ protected void createButtonsForButtonBar(Composite parent) {
 		if (!showResetType) {
 			Button newButton = new Button(parent, SWT.PUSH);
 			newButton.setFont(JFaceResources.getDialogFont());
-			newButton.setText("New branch");
+			newButton.setText(UIText.BranchSelectionDialog_NewBranch);
 			((GridLayout)parent.getLayout()).numColumns++;
 			newButton.addSelectionListener(new SelectionListener() {
 
@@ -276,20 +281,20 @@ public void widgetSelected(SelectionEvent e) {
 
 					InputDialog labelDialog = new InputDialog(
 							getShell(),
-							"New branch",
-							"Enter name of new branch. It will branch from the selected branch. refs/heads/ will be prepended to the name you type",
+							UIText.BranchSelectionDialog_QuestionNewBranchTitle,
+							UIText.BranchSelectionDialog_QuestionNewBranchMessage,
 							null, new IInputValidator() {
 								public String isValid(String newText) {
 									String testFor = Constants.R_HEADS + newText;
 									try {
 										if (repo.resolve(testFor) != null)
-											return "Already exists";
+											return UIText.BranchSelectionDialog_ErrorAlreadyExists;
 									} catch (IOException e1) {
-										Activator.logError(String.format(
-												"Could not attempt to resolve %s", testFor), e1);
+										Activator.logError(NLS.bind(
+												UIText.BranchSelectionDialog_ErrorCouldNotResolve, testFor), e1);
 									}
 									if (!Repository.isValidRefName(testFor))
-										return "Invalid ref name";
+										return UIText.BranchSelectionDialog_ErrorInvalidRefName;
 									return null;
 								}
 							});
@@ -307,14 +312,17 @@ public String isValid(String newText) {
 							updateRef.setNewObjectId(startAt);
 							updateRef.update();
 						} catch (IOException e1) {
-							Activator.logError(String.format(
-									"Could not create new ref %s", newRefName), e1);
+							Activator.logError(NLS.bind(
+									UIText.BranchSelectionDialog_ErrorCouldNotCreateNewRef,
+															newRefName), e1);
 						}
 						try {
 							branchTree.removeAll();
 							fillTreeWithBranches(newRefName);
 						} catch (IOException e1) {
-							Activator.logError("Could not refresh list of branches",e1);
+							Activator.logError(
+									UIText.BranchSelectionDialog_ErrorCouldNotRefreshBranchList,
+											e1);
 						}
 					}
 				}
@@ -324,7 +332,9 @@ public void widgetDefaultSelected(SelectionEvent e) {
 				}
 			});
 		}
-		createButton(parent, IDialogConstants.OK_ID, showResetType ? "Reset" : "Checkout", true);
+		createButton(parent, IDialogConstants.OK_ID,
+				showResetType ? UIText.BranchSelectionDialog_OkReset
+						: UIText.BranchSelectionDialog_OkCheckout, true);
 		createButton(parent, IDialogConstants.CANCEL_ID, IDialogConstants.CANCEL_LABEL, false);
 	}
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 98ce80f..0c85378 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -288,3 +288,28 @@ WindowCachePreferencePage_packedGitWindowSize=Window size:
 WindowCachePreferencePage_packedGitLimit=Window cache limit:
 WindowCachePreferencePage_deltaBaseCacheLimit=Delta base cache limit:
 WindowCachePreferencePage_packedGitMMAP=Use virtual memory mapping
+
+BranchSelectionDialog_BranchSuffix_Current=\ (current)
+BranchSelectionDialog_ErrorAlreadyExists=Already exists
+BranchSelectionDialog_ErrorCouldNotCreateNewRef=Could not create new ref {0}
+BranchSelectionDialog_ErrorCouldNotRefresh=Could not refresh list of branches
+BranchSelectionDialog_ErrorCouldNotRefreshBranchList=Could not refresh list of branches
+BranchSelectionDialog_ErrorCouldNotResolve=Could not attempt to resolve {0}
+BranchSelectionDialog_ErrorInvalidRefName=Invalid ref name
+BranchSelectionDialog_LocalBranches=Local Branches
+BranchSelectionDialog_NewBranch=&New branch
+BranchSelectionDialog_NoBranchSeletectMessage=You must select a valid ref.
+BranchSelectionDialog_NoBranchSeletectTitle=No branch/tag selected
+BranchSelectionDialog_OkCheckout=&Checkout
+BranchSelectionDialog_OkReset=&Reset
+BranchSelectionDialog_QuestionNewBranchMessage=Enter name of new branch. It will branch from the selected branch. refs/heads/ will be prepended to the name you type
+BranchSelectionDialog_QuestionNewBranchTitle=New branch
+BranchSelectionDialog_ReallyResetMessage=Resetting will overwrite any changes in your working directory.\n\nDo you wish to continue?
+BranchSelectionDialog_ReallyResetTitle=Really reset?
+BranchSelectionDialog_RemoteBranches=Remote Branches
+BranchSelectionDialog_ResetType=Reset Type
+BranchSelectionDialog_ResetTypeHard=&Hard
+BranchSelectionDialog_ResetTypeMixed=&Mixed (working directory unmodified)
+BranchSelectionDialog_ResetTypeSoft=&Soft (Index and working directory unmodified)
+BranchSelectionDialog_Tags=Tags
+BranchSelectionDialog_Refs=&Refs
-- 
1.6.1.rc3.56.gd0306
