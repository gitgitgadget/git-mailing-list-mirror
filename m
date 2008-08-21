From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH] Added forward slash to head/remote/tag prefix Constants
Date: Fri, 22 Aug 2008 06:55:22 +1000
Message-ID: <1219352122-5865-1-git-send-email-charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 22:56:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWHD3-0001y8-JE
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 22:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245AbYHUUzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 16:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbYHUUzj
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 16:55:39 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:18411 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbYHUUzh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 16:55:37 -0400
Received: by yx-out-2324.google.com with SMTP id 8so88407yxm.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:sender;
        bh=/90ql+Ks9VIUHuUtlltegqdLpqplLeHOHITUij3clOU=;
        b=ABQL3/TREP/phXsFBqsMWhWP7fjsTa2l3ud6c+ntiVDWxtiww2BAK3q9CoACvPnMQB
         hVJuBL/xp9Q+FvzxjrsNVg0a1EW10nVT5FIVnZOo7sDVH2ULEEwxlex0nmG9THlPi+8H
         vnif8ENQCEPoBe2fQnqvc3fNHdixxf5gKgNMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:sender;
        b=Dv7oh+BUrFMHkYit6fCktGZWfqXxe1uPnfV3lpLPGAU5mx5YVauv3CESAzckrtEotn
         GvYAlUh1OGisYJsw4+5p5gxxsMUl6GL/KV4bKrAo0tpC9cW7+0LkR95UfuIOsdyrYgaB
         3ewIUDNXUrE89zn+PrggXqwlrkMNWI9RKre7I=
Received: by 10.114.144.1 with SMTP id r1mr349459wad.136.1219352135999;
        Thu, 21 Aug 2008 13:55:35 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.197.247])
        by mx.google.com with ESMTPS id z20sm686399pod.11.2008.08.21.13.55.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Aug 2008 13:55:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.49.gea35
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93204>

eg. Constants.HEADS_PREFIX + "/" ==> Constants.R_HEADS

This was always done by every instance anyway and so this will ensure
it isn't forgotten again.

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../ui/internal/clone/CloneDestinationPage.java    |    8 +++---
 .../egit/ui/internal/clone/GitCloneWizard.java     |   10 ++------
 .../egit/ui/internal/clone/SourceBranchPage.java   |    6 ++--
 .../src/org/spearce/jgit/pgm/Branch.java           |   10 ++++----
 .../src/org/spearce/jgit/pgm/Fetch.java            |    5 ++-
 .../src/org/spearce/jgit/pgm/Push.java             |    3 +-
 .../src/org/spearce/jgit/pgm/Tag.java              |    8 +++---
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |   23 ++++++++-----------
 .../src/org/spearce/jgit/lib/Constants.java        |    6 ++--
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   12 ++++------
 .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
 org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java |    2 +-
 .../spearce/jgit/transport/FetchHeadRecord.java    |   23 ++++++++-----------
 .../org/spearce/jgit/transport/FetchProcess.java   |    2 +-
 .../spearce/jgit/transport/WalkPushConnection.java |    4 +-
 15 files changed, 57 insertions(+), 67 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
index 5d5a8ee..ca37679 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
@@ -180,8 +180,8 @@ public File getDestinationFile() {
 	public String getInitialBranch() {
 		final int ix = initialBranch.getSelectionIndex();
 		if (ix < 0)
-			return Constants.HEADS_PREFIX + "/" + Constants.MASTER;
-		return Constants.HEADS_PREFIX + "/" + initialBranch.getItem(ix);
+			return Constants.R_HEADS + Constants.MASTER;
+		return Constants.R_HEADS + initialBranch.getItem(ix);
 	}
 
 	/**
@@ -245,8 +245,8 @@ setDescription(NLS.bind(UIText.CloneDestinationPage_description,
 		int newix = 0;
 		for (final Ref r : branchPage.getSelectedBranches()) {
 			String name = r.getName();
-			if (name.startsWith(Constants.HEADS_PREFIX + "/"))
-				name = name.substring((Constants.HEADS_PREFIX + "/").length());
+			if (name.startsWith(Constants.R_HEADS))
+				name = name.substring((Constants.R_HEADS).length());
 			if (head != null && head.getName().equals(r.getName()))
 				newix = initialBranch.getItemCount();
 			initialBranch.add(name);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
index 50c2ef9..68b801e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
@@ -37,11 +37,6 @@
  * Import Git Repository Wizard. A front end to a git clone operation.
  */
 public class GitCloneWizard extends Wizard implements IImportWizard {
-	private static final String HEADS_PREFIX = Constants.HEADS_PREFIX;
-
-	private static final String REMOTES_PREFIX_S = Constants.REMOTES_PREFIX
-			+ "/";
-
 	private CloneSourcePage cloneSource;
 
 	private SourceBranchPage validSource;
@@ -86,10 +81,11 @@ public boolean performFinish() {
 			origin = new RemoteConfig(db.getConfig(), rn);
 			origin.addURI(uri);
 
-			final String dst = REMOTES_PREFIX_S + origin.getName();
+			final String dst = Constants.R_REMOTES + origin.getName();
 			RefSpec wcrs = new RefSpec();
 			wcrs = wcrs.setForceUpdate(true);
-			wcrs = wcrs.setSourceDestination(HEADS_PREFIX + "/*", dst + "/*");
+			wcrs = wcrs.setSourceDestination(Constants.R_HEADS + "*", dst
+					+ "/*");
 
 			if (validSource.isAllSelected()) {
 				origin.addFetchRefSpec(wcrs);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
index b0aba1e..8b2ba48 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
@@ -248,7 +248,7 @@ public void run(final IProgressMonitor pm)
 						head = null;
 						for (final Ref r : adv) {
 							final String n = r.getName();
-							if (!n.startsWith(Constants.HEADS_PREFIX + "/"))
+							if (!n.startsWith(Constants.R_HEADS))
 								continue;
 							available.add(r);
 							if (idHEAD == null || head != null)
@@ -294,8 +294,8 @@ public int compare(final Ref o1, final Ref o2) {
 		allSelected = true;
 		for (final Ref r : available) {
 			String n = r.getName();
-			if (n.startsWith(Constants.HEADS_PREFIX + "/"))
-				n = n.substring((Constants.HEADS_PREFIX + "/").length());
+			if (n.startsWith(Constants.R_HEADS))
+				n = n.substring((Constants.R_HEADS).length());
 			final TableItem ti = new TableItem(availTable, SWT.NONE);
 			ti.setText(n);
 			ti.setChecked(true);
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
index 837b672..9b6a7e7 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
@@ -101,8 +101,8 @@ private void list() throws Exception {
 			String current = head.getName();
 			if (current.equals(Constants.HEAD))
 				addRef("(no branch)", head);
-			addRefs(refs, Constants.HEADS_PREFIX + '/', !remote);
-			addRefs(refs, Constants.REMOTES_PREFIX + '/', remote);
+			addRefs(refs, Constants.R_HEADS, !remote);
+			addRefs(refs, Constants.R_REMOTES, remote);
 			for (final Entry<String, Ref> e : printRefs.entrySet()) {
 				final Ref ref = e.getValue();
 				printHead(e.getKey(), current.equals(ref.getName()), ref);
@@ -150,9 +150,9 @@ private void delete(boolean force) throws IOException {
 				String err = "Cannot delete the branch '%s' which you are currently on.";
 				throw die(String.format(err, branch));
 			}
-			RefUpdate update = db.updateRef((remote ? Constants.REMOTES_PREFIX
-					: Constants.HEADS_PREFIX)
-					+ '/' + branch);
+			RefUpdate update = db.updateRef((remote ? Constants.R_REMOTES
+					: Constants.R_HEADS)
+					+ branch);
 			update.setNewObjectId(head);
 			update.setForceUpdate(force || remote);
 			Result result = update.delete();
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
index 4eff32b..8c5b983 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
@@ -41,6 +41,7 @@
 
 import org.kohsuke.args4j.Argument;
 import org.kohsuke.args4j.Option;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.TextProgressMonitor;
 import org.spearce.jgit.transport.FetchResult;
@@ -102,9 +103,9 @@ private static String longTypeOf(final TrackingRefUpdate u) {
 			return "[i/o error]";
 
 		if (r == RefUpdate.Result.NEW) {
-			if (u.getRemoteName().startsWith(REFS_HEADS))
+			if (u.getRemoteName().startsWith(Constants.R_HEADS))
 				return "[new branch]";
-			else if (u.getLocalName().startsWith(REFS_TAGS))
+			else if (u.getLocalName().startsWith(Constants.R_TAGS))
 				return "[new tag]";
 			return "[new]";
 		}
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
index 6b35ab8..aacbdf9 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
@@ -43,6 +43,7 @@
 
 import org.kohsuke.args4j.Argument;
 import org.kohsuke.args4j.Option;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.TextProgressMonitor;
 import org.spearce.jgit.transport.PushResult;
@@ -157,7 +158,7 @@ private void printRefUpdateResult(final PushResult result,
 				final Ref oldRef = result.getAdvertisedRef(remoteName);
 				if (oldRef == null) {
 					final String summary;
-					if (remoteName.startsWith(REFS_TAGS))
+					if (remoteName.startsWith(Constants.R_TAGS))
 						summary = "[new tag]";
 					else
 						summary = "[new branch]";
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
index 6c73552..d119ebb 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
@@ -67,11 +67,11 @@ protected void run() throws Exception {
 				throw die("Cannot resolve " + Constants.HEAD);
 		}
 
-		if (!tagName.startsWith(Constants.TAGS_PREFIX + "/"))
-			tagName = Constants.TAGS_PREFIX + "/" + tagName;
+		if (!tagName.startsWith(Constants.R_TAGS))
+			tagName = Constants.R_TAGS + tagName;
 		if (!force && db.resolve(tagName) != null) {
 			throw die("fatal: tag '"
-					+ tagName.substring(Constants.TAGS_PREFIX.length() + 1)
+					+ tagName.substring(Constants.R_TAGS.length())
 					+ "' exists");
 		}
 
@@ -84,7 +84,7 @@ protected void run() throws Exception {
 		tag.setType(Constants.typeString(ldr.getType()));
 		tag.setTagger(new PersonIdent(db));
 		tag.setMessage(message.replaceAll("\r", ""));
-		tag.setTag(tagName.substring(Constants.TAGS_PREFIX.length() + 1));
+		tag.setTag(tagName.substring(Constants.R_TAGS.length()));
 		tag.tag();
 	}
 }
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
index 5c066cb..50b1620 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
@@ -38,6 +38,10 @@
 
 package org.spearce.jgit.pgm;
 
+import static org.spearce.jgit.lib.Constants.R_HEADS;
+import static org.spearce.jgit.lib.Constants.R_REMOTES;
+import static org.spearce.jgit.lib.Constants.R_TAGS;
+
 import java.io.BufferedWriter;
 import java.io.IOException;
 import java.io.OutputStreamWriter;
@@ -45,7 +49,6 @@
 
 import org.kohsuke.args4j.CmdLineException;
 import org.kohsuke.args4j.Option;
-import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.pgm.opt.CmdLineParser;
@@ -63,12 +66,6 @@
  * even though it was constructed.
  */
 public abstract class TextBuiltin {
-	protected static final String REFS_HEADS = Constants.HEADS_PREFIX + "/";
-
-	protected static final String REFS_REMOTES = Constants.REMOTES_PREFIX + "/";
-
-	protected static final String REFS_TAGS = Constants.TAGS_PREFIX + "/";
-
 	private String commandName;
 
 	@Option(name = "--help", usage = "display this help text", aliases = { "-h" })
@@ -184,12 +181,12 @@ protected static String abbreviateObject(final ObjectId id) {
 	}
 
 	protected String abbreviateRef(String dst, boolean abbreviateRemote) {
-		if (dst.startsWith(REFS_HEADS))
-			dst = dst.substring(REFS_HEADS.length());
-		else if (dst.startsWith(REFS_TAGS))
-			dst = dst.substring(REFS_TAGS.length());
-		else if (abbreviateRemote && dst.startsWith(REFS_REMOTES))
-			dst = dst.substring(REFS_REMOTES.length());
+		if (dst.startsWith(R_HEADS))
+			dst = dst.substring(R_HEADS.length());
+		else if (dst.startsWith(R_TAGS))
+			dst = dst.substring(R_HEADS.length());
+		else if (abbreviateRemote && dst.startsWith(R_REMOTES))
+			dst = dst.substring(R_REMOTES.length());
 		return dst;
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index 331c7dc..f316881 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -208,13 +208,13 @@
 	public static final String MASTER = "master";
 
 	/** Prefix for branch refs */
-	public static final String HEADS_PREFIX = "refs/heads";
+	public static final String R_HEADS = "refs/heads/";
 
 	/** Prefix for remotes refs */
-	public static final String REMOTES_PREFIX = "refs/remotes";
+	public static final String R_REMOTES = "refs/remotes/";
 
 	/** Prefix for tag refs */
-	public static final String TAGS_PREFIX = "refs/tags";
+	public static final String R_TAGS = "refs/tags/";
 
 	/** Logs folder name */
 	public static final String LOGS = "logs";
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index be5a2fe..5c1f060 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -38,6 +38,8 @@
 
 package org.spearce.jgit.lib;
 
+import static org.spearce.jgit.lib.Constants.R_TAGS;
+
 import java.io.BufferedReader;
 import java.io.EOFException;
 import java.io.File;
@@ -55,12 +57,8 @@
 class RefDatabase {
 	private static final String REFS_SLASH = "refs/";
 
-	private static final String HEADS_SLASH = Constants.HEADS_PREFIX + "/";
-
-	private static final String TAGS_SLASH = Constants.TAGS_PREFIX + "/";
-
 	private static final String[] refSearchPaths = { "", REFS_SLASH,
-			TAGS_SLASH, HEADS_SLASH, Constants.REMOTES_PREFIX + "/" };
+			R_TAGS, Constants.R_HEADS, Constants.R_REMOTES };
 
 	private final Repository db;
 
@@ -188,8 +186,8 @@ Ref readRef(final String partialName) throws IOException {
 	Map<String, Ref> getTags() {
 		final Map<String, Ref> tags = new HashMap<String, Ref>();
 		for (final Ref r : readRefs().values()) {
-			if (r.getName().startsWith(TAGS_SLASH))
-				tags.put(r.getName().substring(TAGS_SLASH.length()), r);
+			if (r.getName().startsWith(R_TAGS))
+				tags.put(r.getName().substring(R_TAGS.length()), r);
 		}
 		return tags;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 7679e53..f1a8269 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -170,7 +170,7 @@ public void create() throws IOException {
 
 		new File(gitDir, "branches").mkdir();
 		new File(gitDir, "remotes").mkdir();
-		final String master = Constants.HEADS_PREFIX + "/" + Constants.MASTER;
+		final String master = Constants.R_HEADS + Constants.MASTER;
 		refs.link(Constants.HEAD, master);
 
 		getConfig().create();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java
index b3039f2..aa4baf4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java
@@ -202,7 +202,7 @@ public void tag() throws IOException {
 			id = objId;
 		}
 
-		ru = objdb.updateRef(Constants.TAGS_PREFIX + "/" + getTag());
+		ru = objdb.updateRef(Constants.R_TAGS + getTag());
 		ru.setNewObjectId(id);
 		ru.setRefLogMessage("tagged " + getTag(), false);
 		if (ru.forceUpdate() == RefUpdate.Result.LOCK_FAILURE)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchHeadRecord.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchHeadRecord.java
index ead3892..83a16dc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchHeadRecord.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchHeadRecord.java
@@ -37,18 +37,15 @@
 
 package org.spearce.jgit.transport;
 
+import static org.spearce.jgit.lib.Constants.R_HEADS;
+import static org.spearce.jgit.lib.Constants.R_REMOTES;
+import static org.spearce.jgit.lib.Constants.R_TAGS;
+
 import java.io.PrintWriter;
 
-import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 
 class FetchHeadRecord {
-	private static final String REFS_HEADS = Constants.HEADS_PREFIX + "/";
-
-	private static final String REFS_REMOTES = Constants.REMOTES_PREFIX + "/";
-
-	private static final String REFS_TAGS = Constants.TAGS_PREFIX + "/";
-
 	ObjectId newValue;
 
 	boolean notForMerge;
@@ -60,15 +57,15 @@
 	void write(final PrintWriter pw) {
 		final String type;
 		final String name;
-		if (sourceName.startsWith(REFS_HEADS)) {
+		if (sourceName.startsWith(R_HEADS)) {
 			type = "branch";
-			name = sourceName.substring(REFS_HEADS.length());
-		} else if (sourceName.startsWith(REFS_TAGS)) {
+			name = sourceName.substring(R_HEADS.length());
+		} else if (sourceName.startsWith(R_TAGS)) {
 			type = "tag";
-			name = sourceName.substring(REFS_TAGS.length());
-		} else if (sourceName.startsWith(REFS_REMOTES)) {
+			name = sourceName.substring(R_TAGS.length());
+		} else if (sourceName.startsWith(R_REMOTES)) {
 			type = "remote branch";
-			name = sourceName.substring(REFS_REMOTES.length());
+			name = sourceName.substring(R_REMOTES.length());
 		} else {
 			type = "";
 			name = sourceName;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
index e99869c..654572d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
@@ -361,6 +361,6 @@ private static boolean isTag(final Ref r) {
 	}
 
 	private static boolean isTag(final String name) {
-		return name.startsWith(Constants.TAGS_PREFIX + "/");
+		return name.startsWith(Constants.R_TAGS);
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
index b417b6e..5e80be8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
@@ -358,7 +358,7 @@ private static String pickHEAD(final List<RemoteRefUpdate> updates) {
 		//
 		for (final RemoteRefUpdate u : updates) {
 			final String n = u.getRemoteName();
-			if (n.equals(Constants.HEADS_PREFIX + "/" + Constants.MASTER))
+			if (n.equals(Constants.R_HEADS + Constants.MASTER))
 				return n;
 		}
 
@@ -367,7 +367,7 @@ private static String pickHEAD(final List<RemoteRefUpdate> updates) {
 		//
 		for (final RemoteRefUpdate u : updates) {
 			final String n = u.getRemoteName();
-			if (n.startsWith(Constants.HEADS_PREFIX + "/"))
+			if (n.startsWith(Constants.R_HEADS))
 				return n;
 		}
 		return updates.get(0).getRemoteName();
-- 
1.6.0.49.gea35
