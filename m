From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH] Comment private modifier to improve performace.
Date: Sat,  2 Feb 2008 00:23:38 -0200
Message-ID: <1201919018-10782-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 03:18:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL7xQ-0000QV-3H
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 03:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010AbYBBCR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 21:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756872AbYBBCR2
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 21:17:28 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1934 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756849AbYBBCR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 21:17:27 -0500
Received: (qmail 6274 invoked by uid 0); 2 Feb 2008 00:19:54 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.807256 secs); 02 Feb 2008 02:19:54 -0000
Received: from unknown (HELO localhost.localdomain) (189.5.222.172)
  by cvxbsd.convex.com.br with SMTP; 2 Feb 2008 02:19:53 -0000
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72207>

Changed private modifiers to default to improve perfomance and remove
warnings of the type:
Write access to enclosing field GitHistoryPage.hintShowDiffNow is
emulated by a synthetic accessor method. Increasing its visibility will
improve your performance

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 .../egit/core/internal/mapping/GitFileHistory.java |    2 +-
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |    2 +-
 .../internal/actions/AbstractOperationAction.java  |    2 +-
 .../internal/decorators/GitResourceDecorator.java  |    2 +-
 .../ui/internal/dialogs/BranchSelectionDialog.java |    2 +-
 .../egit/ui/internal/dialogs/CommitDialog.java     |    2 +-
 .../src/org/spearce/jgit/lib/GitIndex.java         |   14 +++++++-------
 .../src/org/spearce/jgit/lib/Walker.java           |   12 ++++++------
 .../src/org/spearce/jgit/lib/WindowedFile.java     |    6 +++---
 .../src/org/spearce/jgit/lib/WorkDirCheckout.java  |    2 +-
 10 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
index 889ca0c..9e683a5 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
@@ -107,7 +107,7 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 
 		IResource resource;
 		private final IProgressMonitor monitor;
-		private Map<ObjectId, IFileRevision> revisions = new HashMap<ObjectId, IFileRevision>();
+		/* private */Map<ObjectId, IFileRevision> revisions = new HashMap<ObjectId, IFileRevision>();
 
 		EclipseWalker(Repository repository, Commit[] starts, String[] relativeResourceName,boolean leafIsBlob,IResource resource,boolean followMainOnly, Boolean merges, ObjectId lastActiveDiffId, boolean returnAll, IProgressMonitor monitor) {
 			super(repository, starts, relativeResourceName, leafIsBlob, followMainOnly, merges, lastActiveDiffId, returnAll);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 812747d..1f154a5 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -137,7 +137,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 
 	/* private */List<IFileRevision> fileRevisions;
 
-	private boolean hintShowDiffNow;
+	/* private */boolean hintShowDiffNow;
 
 	private boolean showAllProjectVersions;
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractOperationAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractOperationAction.java
index c3f347e..d8e1961 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractOperationAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractOperationAction.java
@@ -42,7 +42,7 @@ import org.spearce.egit.ui.UIText;
 public abstract class AbstractOperationAction implements IObjectActionDelegate {
 	private IWorkbenchPart wp;
 
-	private IWorkspaceRunnable op;
+	/* private */IWorkspaceRunnable op;
 
 	public void selectionChanged(final IAction act, final ISelection sel) {
 		final List selection;
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index c13c38a..cc387bc 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -67,7 +67,7 @@ import org.spearce.jgit.lib.Repository.RepositoryState;
 public class GitResourceDecorator extends LabelProvider implements
 		ILightweightLabelDecorator {
 
-	private static final RCL myrcl = new RCL();
+	/* private */static final RCL myrcl = new RCL();
 
 	static class RCL implements RepositoryChangeListener, Runnable {
 		private boolean requested;
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
index 5e30027..2d140a4 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
@@ -215,7 +215,7 @@ public class BranchSelectionDialog extends Dialog {
 		return refName;
 	}
 
-	private ResetType resetType = ResetType.MIXED;
+	/* private */ResetType resetType = ResetType.MIXED;
 	
 	/**
 	 * @return Type of Reset
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index 3778b94..847666f 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -327,7 +327,7 @@ public class CommitDialog extends Dialog {
 	private boolean amendAllowed = true;
 
 	private ArrayList<IFile> selectedItems = new ArrayList<IFile>();
-	private String previousCommitMessage = "";
+	/* private */String previousCommitMessage = "";
 
 	/**
 	 * Pre-select suggested set of resources to commit
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index f49370c..bdcb71a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -64,7 +64,7 @@ public class GitIndex {
 
 	private long lastCacheTime;
 
-	private final Repository db;
+	/* private */final Repository db;
 
 	private Map entries = new TreeMap(new Comparator() {
 		public int compare(Object arg0, Object arg1) {
@@ -311,7 +311,7 @@ public class GitIndex {
 	}
 
 	Boolean filemode;
-	private boolean config_filemode() {
+	/* private */boolean config_filemode() {
 		// temporary til we can actually set parameters. We need to be able
 		// to change this for testing.
 		if (filemode != null)
@@ -322,15 +322,15 @@ public class GitIndex {
 
 	/** An index entry */
 	public class Entry {
-		private long ctime;
+		/* private */long ctime;
 
-		private long mtime;
+		/* private */long mtime;
 
 		private int dev;
 
 		private int ino;
 
-		private int mode;
+		/* private */int mode;
 
 		private int uid;
 
@@ -338,11 +338,11 @@ public class GitIndex {
 
 		private int size;
 
-		private ObjectId sha1;
+		/* private */ObjectId sha1;
 
 		private short flags;
 
-		private byte[] name;
+		/* private */byte[] name;
 
 		Entry(byte[] key, File f, int stage)
 				throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java
index 1f6c531..eb824e0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java
@@ -17,15 +17,15 @@ import java.util.Map;
  * data according to some criteria.
  */
 public abstract class Walker {
-	private String[] relativeResourceName;
-	private boolean leafIsBlob;
-	private boolean followMainOnly;
+	/* private */String[] relativeResourceName;
+	/* private */boolean leafIsBlob;
+	/* private */boolean followMainOnly;
 	protected Repository repository;
 	private ObjectId activeDiffLeafId;
 	protected final Commit[] starts;
-	private final Boolean merges;
-	private Map donewith = new ObjectIdMap();
-	private Collection<Todo> todo = new ArrayList<Todo>(20000);
+	/* private */final Boolean merges;
+	/* private */Map donewith = new ObjectIdMap();
+	/* private */Collection<Todo> todo = new ArrayList<Todo>(20000);
 
 	protected abstract boolean isCancelled();
 	
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index 39f1477..13fecad 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -66,15 +66,15 @@ public class WindowedFile {
 
 	private final WindowCache cache;
 
-	private final int sz;
+	/* private */final int sz;
 
-	private final int szb;
+	/* private */final int szb;
 
 	private final int szm;
 
 	private final Provider wp;
 
-	private final long length;
+	/* private */final long length;
 
 	/**
 	 * Open a file for reading through window caching.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
index 926dac3..6159469 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
@@ -362,7 +362,7 @@ public class WorkDirCheckout {
 		return hasParentBlob(t, parent);
 	}
 
-	private void checkConflictsWithFile(File file) {
+	/* private */void checkConflictsWithFile(File file) {
 		if (file.isDirectory()) {
 			ArrayList<String> childFiles = listFiles(file);
 			conflicts.addAll(childFiles);
-- 
1.5.3.7
