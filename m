From: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
Subject: [EGIT PATCH] Fixed trivial warnings. Mainly parametrized raw types,
 added serialVersionUID, removed unnecessery throws.
Date: Mon, 05 Jan 2009 00:20:19 +0200
Message-ID: <gjrcni$9q$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 04 23:22:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJbMv-0001jx-N7
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 23:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbZADWUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 17:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbZADWUr
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 17:20:47 -0500
Received: from main.gmane.org ([80.91.229.2]:54196 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbZADWUp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 17:20:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LJbKt-0008Rc-6d
	for git@vger.kernel.org; Sun, 04 Jan 2009 22:20:43 +0000
Received: from 91.200.115.178 ([91.200.115.178])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 22:20:43 +0000
Received: from vvavrychuk by 91.200.115.178 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 22:20:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91.200.115.178
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104546>

Also fixed:
1. "The 'Eclipse-LazyStart' header is deprecated, use 'Bundle-ActivationPolicy'" warning.
2. Possible NullPointerException warning.
3. Unnecessery function parameter warning.

Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
---
 org.spearce.egit.core.test/META-INF/MANIFEST.MF    |    2 +-
 org.spearce.egit.core/META-INF/MANIFEST.MF         |    2 +-
 .../egit/core/internal/storage/GitFileHistory.java |    4 +-
 .../spearce/egit/core/project/GitProjectData.java  |   18 +++----
 .../egit/core/project/RepositoryFinder.java        |    5 +-
 org.spearce.egit.ui/META-INF/MANIFEST.MF           |    2 +-
 .../egit/ui/internal/actions/RepositoryAction.java |    2 +-
 .../tst/org/spearce/jgit/lib/T0002_Tree.java       |    4 +-
 org.spearce.jgit/META-INF/MANIFEST.MF              |    2 +-
 .../jgit/errors/InvalidPatternException.java       |    2 +
 .../jgit/errors/NoClosingBracketException.java     |    1 +
 .../jgit/errors/RevisionSyntaxException.java       |    1 +
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |    6 +--
 .../src/org/spearce/jgit/lib/GitIndex.java         |   29 +++++------
 .../src/org/spearce/jgit/lib/ObjectIdMap.java      |    1 -
 .../src/org/spearce/jgit/lib/ObjectWriter.java     |    1 -
 .../src/org/spearce/jgit/lib/TreeIterator.java     |    2 +-
 .../jgit/lib/TreeVisitorWithCurrentDirectory.java  |    5 +-
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |    3 +-
 .../jgit/transport/DefaultSshSessionFactory.java   |    2 +-
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |    5 +-
 .../src/org/spearce/jgit/util/Base64.java          |   52 ++++++++++++--------
 22 files changed, 76 insertions(+), 75 deletions(-)

diff --git a/org.spearce.egit.core.test/META-INF/MANIFEST.MF b/org.spearce.egit.core.test/META-INF/MANIFEST.MF
index ee5f277..e8bcc79 100644
--- a/org.spearce.egit.core.test/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.core.test/META-INF/MANIFEST.MF
@@ -11,7 +11,7 @@ Require-Bundle: org.eclipse.core.runtime,
  org.spearce.egit.ui,
  org.spearce.jgit,
  org.eclipse.core.filesystem
-Eclipse-LazyStart: true
+Bundle-ActivationPolicy: lazy
 Import-Package: org.eclipse.core.resources,
  org.eclipse.jdt.core,
  org.eclipse.jdt.junit,
diff --git a/org.spearce.egit.core/META-INF/MANIFEST.MF b/org.spearce.egit.core/META-INF/MANIFEST.MF
index 6c95084..43fc566 100644
--- a/org.spearce.egit.core/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.core/META-INF/MANIFEST.MF
@@ -16,5 +16,5 @@ Export-Package: org.spearce.egit.core.internal.storage;x-friends:="org.spearce.e
  org.spearce.egit.core,
  org.spearce.egit.core.op,
  org.spearce.egit.core.project
-Eclipse-LazyStart: true
+Bundle-ActivationPolicy: lazy
 Bundle-RequiredExecutionEnvironment: J2SE-1.5
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileHistory.java
index c01c1c3..61c32ce 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileHistory.java
@@ -50,11 +50,11 @@
 	GitFileHistory(final IResource rsrc, final int flags,
 			final IProgressMonitor monitor) {
 		resource = rsrc;
-		walk = buildWalk(flags);
+		walk = buildWalk(/*flags*/);
 		revisions = buildRevisions(monitor, flags);
 	}
 
-	private KidWalk buildWalk(final int flags) {
+	private KidWalk buildWalk(/*final int flags*/) {
 		final RepositoryMapping rm = RepositoryMapping.getMapping(resource);
 		if (rm == null) {
 			Activator.logError("Git not attached to project "
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
index 04130db..db5f20b 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
@@ -48,9 +48,9 @@
  * a Git repository.
  */
 public class GitProjectData {
-	private static final Map projectDataCache = new HashMap();
+	private static final Map<IProject, GitProjectData> projectDataCache = new HashMap<IProject, GitProjectData>();
 
-	private static final Map repositoryCache = new HashMap();
+	private static final Map<File, WeakReference> repositoryCache = new HashMap<File, WeakReference>();
 
 	private static RepositoryChangeListener[] repositoryChangeListeners = {};
 
@@ -193,7 +193,7 @@ private synchronized static void uncache(final IProject p) {
 	}
 
 	private synchronized static GitProjectData lookup(final IProject p) {
-		return (GitProjectData) projectDataCache.get(p);
+		return projectDataCache.get(p);
 	}
 
 	private synchronized static Repository lookupRepository(final File gitDir)
@@ -206,11 +206,11 @@ private synchronized static Repository lookupRepository(final File gitDir)
 			}
 		}
 
-		final Reference r = (Reference) repositoryCache.get(gitDir);
+		final Reference r = repositoryCache.get(gitDir);
 		Repository d = r != null ? (Repository) r.get() : null;
 		if (d == null) {
 			d = new Repository(gitDir);
-			repositoryCache.put(gitDir, new WeakReference(d));
+			repositoryCache.put(gitDir, new WeakReference<Repository>(d));
 		}
 		return d;
 	}
@@ -229,9 +229,9 @@ public static void reconfigureWindowCache() {
 
 	private final IProject project;
 
-	private final Collection mappings;
+	private final Collection<RepositoryMapping> mappings = new ArrayList<RepositoryMapping>();
 
-	private final Set protectedResources;
+	private final Set<IResource> protectedResources = new HashSet<IResource>();
 
 	/**
 	 * Construct a {@link GitProjectData} for the mapping
@@ -241,8 +241,6 @@ public static void reconfigureWindowCache() {
 	 */
 	public GitProjectData(final IProject p) {
 		project = p;
-		mappings = new ArrayList();
-		protectedResources = new HashSet();
 	}
 
 	/**
@@ -257,7 +255,7 @@ public IProject getProject() {
 	 *
 	 * @param newMappings
 	 */
-	public void setRepositoryMappings(final Collection newMappings) {
+	public void setRepositoryMappings(final Collection<RepositoryMapping> newMappings) {
 		mappings.clear();
 		mappings.addAll(newMappings);
 		remapAll();
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryFinder.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryFinder.java
index c33f3a0..2b4b16f 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryFinder.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryFinder.java
@@ -47,7 +47,7 @@
 public class RepositoryFinder {
 	private final IProject proj;
 
-	private final Collection results;
+	private final Collection<RepositoryMapping> results = new ArrayList<RepositoryMapping>();
 
 	/**
 	 * Create a new finder to locate Git repositories for a project.
@@ -58,7 +58,6 @@
 	 */
 	public RepositoryFinder(final IProject p) {
 		proj = p;
-		results = new ArrayList();
 	}
 
 	/**
@@ -72,7 +71,7 @@ public RepositoryFinder(final IProject p) {
 	 *             Eclipse was unable to access its workspace, and threw up on
 	 *             us. We're throwing it back at the caller.
 	 */
-	public Collection find(IProgressMonitor m) throws CoreException {
+	public Collection<RepositoryMapping> find(IProgressMonitor m) throws CoreException {
 		if (m == null) {
 			m = new NullProgressMonitor();
 		}
diff --git a/org.spearce.egit.ui/META-INF/MANIFEST.MF b/org.spearce.egit.ui/META-INF/MANIFEST.MF
index ec1df4d..019ef6e 100644
--- a/org.spearce.egit.ui/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.ui/META-INF/MANIFEST.MF
@@ -20,7 +20,7 @@ Require-Bundle: org.eclipse.core.runtime,
  org.spearce.jgit,
  org.spearce.egit.core,
  org.eclipse.jsch.ui;bundle-version="1.1.100"
-Eclipse-LazyStart: true
+Bundle-ActivationPolicy: lazy
 Bundle-RequiredExecutionEnvironment: J2SE-1.5
 Import-Package: org.eclipse.jsch.core,
  org.eclipse.jsch.internal.core
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/RepositoryAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/RepositoryAction.java
index 8c250ca..362437e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/RepositoryAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/RepositoryAction.java
@@ -100,7 +100,7 @@ protected Repository getRepository(boolean warn) {
 				mapping = repositoryMapping;
 			if (repositoryMapping == null)
 				return null;
-			if (repositoryMapping != null && mapping.getRepository() != repositoryMapping.getRepository()) {
+			if (mapping.getRepository() != repositoryMapping.getRepository()) {
 				if (warn)
 					MessageDialog.openError(getShell(), "Multiple Repositories Selection", "Cannot perform reset on multiple repositories simultaneously.\n\nPlease select items from only one repository.");
 				return null;
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0002_Tree.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0002_Tree.java
index fcb4d96..97f299c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0002_Tree.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0002_Tree.java
@@ -236,7 +236,7 @@ public void test006_addDeepTree() throws IOException {
 
 	public void test007_manyFileLookup() throws IOException {
 		final Tree t = new Tree(db);
-		final List files = new ArrayList(26 * 26);
+		final List<FileTreeEntry> files = new ArrayList<FileTreeEntry>(26 * 26);
 		for (char level1 = 'a'; level1 <= 'z'; level1++) {
 			for (char level2 = 'a'; level2 <= 'z'; level2++) {
 				final String n = "." + level1 + level2 + "9";
@@ -251,7 +251,7 @@ public void test007_manyFileLookup() throws IOException {
 		assertNotNull(ents);
 		assertEquals(files.size(), ents.length);
 		for (int k = 0; k < ents.length; k++) {
-			assertTrue("File " + ((FileTreeEntry) files.get(k)).getName()
+			assertTrue("File " + files.get(k).getName()
 					+ " is at " + k + ".", files.get(k) == ents[k]);
 		}
 	}
diff --git a/org.spearce.jgit/META-INF/MANIFEST.MF b/org.spearce.jgit/META-INF/MANIFEST.MF
index 36f92f2..459e8f3 100644
--- a/org.spearce.jgit/META-INF/MANIFEST.MF
+++ b/org.spearce.jgit/META-INF/MANIFEST.MF
@@ -16,7 +16,7 @@ Export-Package: org.spearce.jgit.dircache,
  org.spearce.jgit.treewalk,
  org.spearce.jgit.treewalk.filter,
  org.spearce.jgit.util
-Eclipse-LazyStart: true
+Bundle-ActivationPolicy: lazy
 Bundle-RequiredExecutionEnvironment: J2SE-1.5
 Bundle-ClassPath: .
 Require-Bundle: com.jcraft.jsch;visibility:=reexport
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidPatternException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidPatternException.java
index 15d159b..e7be0d6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidPatternException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidPatternException.java
@@ -42,6 +42,8 @@
  *
  */
 public class InvalidPatternException extends Exception {
+	private static final long serialVersionUID = 1L;
+
 	private final String pattern;
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/NoClosingBracketException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/NoClosingBracketException.java
index 1a93906..8fe9ab1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/NoClosingBracketException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/NoClosingBracketException.java
@@ -42,6 +42,7 @@
  * side or a character class which is open to the right side.
  */
 public class NoClosingBracketException extends InvalidPatternException {
+	private static final long serialVersionUID = 1L;
 
 	/**
 	 * @param indexOfOpeningBracket
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/RevisionSyntaxException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/RevisionSyntaxException.java
index ac425bb..f943879 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/RevisionSyntaxException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/RevisionSyntaxException.java
@@ -45,6 +45,7 @@
  * properly formatted.
  */
 public class RevisionSyntaxException extends IOException {
+	private static final long serialVersionUID = 1L;
 
 	private final String revstr;
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index a534202..f3e4534 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -52,7 +52,7 @@
  * with this instance can alter at any time, if this instance is modified to
  * represent a different object name.
  */
-public abstract class AnyObjectId implements Comparable {
+public abstract class AnyObjectId implements Comparable<ObjectId> {
 	static final int RAW_LEN = Constants.OBJECT_ID_LENGTH;
 
 	static final int STR_LEN = RAW_LEN * 2;
@@ -178,10 +178,6 @@ public int compareTo(final ObjectId other) {
 		return NB.compareUInt32(w5, other.w5);
 	}
 
-	public int compareTo(final Object other) {
-		return compareTo(((ObjectId) other));
-	}
-
 	int compareTo(final byte[] bs, final int p) {
 		int cmp;
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index bafddef..7c3f1b4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -107,18 +107,16 @@
 
 	private final Repository db;
 
-	private Map entries = new TreeMap(new Comparator() {
-		public int compare(Object arg0, Object arg1) {
-			byte[] a = (byte[]) arg0;
-			byte[] b = (byte[]) arg1;
-			for (int i = 0; i < a.length && i < b.length; ++i) {
-				int c = a[i] - b[i];
+	private Map<byte[], Entry> entries = new TreeMap<byte[], Entry>(new Comparator<byte[]>() {
+		public int compare(byte[] o1, byte[] o2) {
+			for (int i = 0; i < o1.length && i < o2.length; ++i) {
+				int c = o1[i] - o2[i];
 				if (c != 0)
 					return c;
 			}
-			if (a.length < b.length)
+			if (o1.length < o2.length)
 				return -1;
-			else if (a.length > b.length)
+			else if (o1.length > o2.length)
 				return 1;
 			return 0;
 		}
@@ -161,7 +159,7 @@ public void rereadIfNecessary() throws IOException {
 	 */
 	public Entry add(File wd, File f) throws IOException {
 		byte[] key = makeKey(wd, f);
-		Entry e = (Entry) entries.get(key);
+		Entry e = entries.get(key);
 		if (e == null) {
 			e = new Entry(key, f, 0);
 			entries.put(key, e);
@@ -302,7 +300,7 @@ static boolean File_hasExecute() {
 		return FS.INSTANCE.supportsExecute();
 	}
 
-	static byte[] makeKey(File wd, File f) throws IOException {
+	static byte[] makeKey(File wd, File f) {
 		if (!f.getPath().startsWith(wd.getPath()))
 			throw new Error("Path is not in working dir");
 		String relName = Repository.stripWorkDir(wd, f);
@@ -362,8 +360,7 @@ Entry(byte[] key, File f, int stage)
 			flags = (short) ((stage << 12) | name.length); // TODO: fix flags
 		}
 
-		Entry(TreeEntry f, int stage)
-				throws UnsupportedEncodingException {
+		Entry(TreeEntry f, int stage) {
 			ctime = -1; // hmm
 			mtime = -1;
 			dev = -1;
@@ -810,7 +807,7 @@ public ObjectId writeTree() throws IOException {
 		checkWriteOk();
 		ObjectWriter writer = new ObjectWriter(db);
 		Tree current = new Tree(db);
-		Stack trees = new Stack();
+		Stack<Tree> trees = new Stack<Tree>();
 		trees.push(current);
 		String[] prevName = new String[0];
 		for (Iterator i = entries.values().iterator(); i.hasNext();) {
@@ -844,7 +841,7 @@ public ObjectId writeTree() throws IOException {
 			current.setId(writer.writeTree(current));
 			trees.pop();
 			if (!trees.isEmpty())
-				current = (Tree) trees.peek();
+				current = trees.peek();
 		}
 		return current.getTreeId();
 	}
@@ -886,7 +883,7 @@ int longestCommonPath(String[] a, String[] b) {
 	 * @return The index entries sorted
 	 */
 	public Entry[] getMembers() {
-		return (Entry[]) entries.values().toArray(new Entry[entries.size()]);
+		return entries.values().toArray(new Entry[entries.size()]);
 	}
 
 	/**
@@ -897,7 +894,7 @@ int longestCommonPath(String[] a, String[] b) {
 	 * @throws UnsupportedEncodingException
 	 */
 	public Entry getEntry(String path) throws UnsupportedEncodingException {
-		return (Entry) entries.get(Repository.gitInternalSlash(Constants.encode(path)));
+		return entries.get(Repository.gitInternalSlash(Constants.encode(path)));
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
index 600d0f4..d3c7f1d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
@@ -178,7 +178,6 @@ public boolean isEmpty() {
 		return true;
 	}
 
-	@SuppressWarnings("unchecked")
 	public V put(ObjectId key, V value) {
 		return submap(key).put(key, value);
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
index 6c2cd4f..e84798a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
@@ -289,7 +289,6 @@ public ObjectId computeBlobSha1(final long len, final InputStream is)
 		return writeObject(Constants.OBJ_BLOB, len, is, false);
 	}
 
-	@SuppressWarnings("null")
 	ObjectId writeObject(final int type, long len, final InputStream is,
 			boolean store) throws IOException {
 		final File t;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeIterator.java
index 2344a3c..ec52078 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeIterator.java
@@ -76,7 +76,7 @@
 		 * Visit leaves first, then node
 		 */
 		POSTORDER
-	};
+	}
 
 	/**
 	 * Construct a {@link TreeIterator} for visiting all non-tree nodes.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeVisitorWithCurrentDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeVisitorWithCurrentDirectory.java
index 55854b2..e227adb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeVisitorWithCurrentDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeVisitorWithCurrentDirectory.java
@@ -46,12 +46,11 @@
  * Abstract TreeVisitor for visiting all files known by a Tree.
  */
 public abstract class TreeVisitorWithCurrentDirectory implements TreeVisitor {
-	private final ArrayList stack;
+	private final ArrayList<File> stack = new ArrayList<File>(16);
 
 	private File currentDirectory;
 
 	protected TreeVisitorWithCurrentDirectory(final File rootDirectory) {
-		stack = new ArrayList(16);
 		currentDirectory = rootDirectory;
 	}
 
@@ -67,6 +66,6 @@ public void startVisitTree(final Tree t) throws IOException {
 	}
 
 	public void endVisitTree(final Tree t) throws IOException {
-		currentDirectory = (File) stack.remove(stack.size() - 1);
+		currentDirectory = stack.remove(stack.size() - 1);
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index d7e4c58..8d25125 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -1014,8 +1014,7 @@ protected RevCommit createCommit(final AnyObjectId id) {
 		return new RevCommit(id);
 	}
 
-	void carryFlagsImpl(final RevCommit c) throws MissingObjectException,
-			IncorrectObjectTypeException, IOException {
+	void carryFlagsImpl(final RevCommit c) {
 		final int carry = c.flags & carryFlags;
 		if (carry != 0)
 			RevCommit.carryFlags(c, carry);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
index 89beab7..0d522df 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
@@ -153,7 +153,7 @@ private void knownHosts(final JSch sch) throws JSchException {
 		}
 	}
 
-	private void identities() throws JSchException {
+	private void identities() {
 		final File home = FS.userHome();
 		if (home == null)
 			return;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
index dcc53cd..4700510 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
@@ -175,8 +175,9 @@ public void back(int delta) {
 			// space so this prunes our search more quickly.
 			//
 			ptr -= Constants.OBJECT_ID_LENGTH;
-			while (raw[--ptr] != ' ')
-				/* nothing */;
+			while (raw[--ptr] != ' ') {
+				/* nothing */
+			}
 			if (--ptr < Constants.OBJECT_ID_LENGTH) {
 				if (delta != 0)
 					throw new ArrayIndexOutOfBoundsException(delta);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/Base64.java b/org.spearce.jgit/src/org/spearce/jgit/util/Base64.java
index 8c45539..d81867b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/Base64.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/Base64.java
@@ -7,6 +7,9 @@
 
 package org.spearce.jgit.util;
 
+import java.io.Closeable;
+import java.io.IOException;
+
 
 /**
  * Encodes and decodes to and from Base64 notation.
@@ -175,11 +178,20 @@
     private final static byte WHITE_SPACE_ENC = -5; // Indicates white space in encoding
     private final static byte EQUALS_SIGN_ENC = -1; // Indicates equals sign in encoding
 
+    private static void closeStream(Closeable stream) {
+        if (stream != null) {
+            try {
+                stream.close();
+            } catch (IOException e) {
+                e.printStackTrace();
+            }
+        }
+    }
 
     /** Defeats instantiation. */
-    private Base64(){}
-
-
+    private Base64() {
+        //suppress empty block warning
+    }
 
 /* ********  E N C O D I N G   M E T H O D S  ******** */
 
@@ -353,10 +365,10 @@ public static String encodeObject( java.io.Serializable serializableObject, int 
         }   // end catch
         finally
         {
-            try{ oos.close();   } catch( Exception e ){}
-            try{ gzos.close();  } catch( Exception e ){}
-            try{ b64os.close(); } catch( Exception e ){}
-            try{ baos.close();  } catch( Exception e ){}
+            closeStream(oos);
+            closeStream(gzos);
+            closeStream(b64os);
+            closeStream(baos);
         }   // end finally
 
         // Return value according to relevant encoding.
@@ -486,9 +498,9 @@ public static String encodeBytes( byte[] source, int off, int len, int options )
             }   // end catch
             finally
             {
-                try{ gzos.close();  } catch( Exception e ){}
-                try{ b64os.close(); } catch( Exception e ){}
-                try{ baos.close();  } catch( Exception e ){}
+                closeStream(gzos);
+                closeStream(b64os);
+                closeStream(baos);
             }   // end finally
 
             // Return value according to relevant encoding.
@@ -763,9 +775,9 @@ else if( source[ srcOffset + 3 ] == EQUALS_SIGN )
                 }   // end catch
                 finally
                 {
-                    try{ baos.close(); } catch( Exception e ){}
-                    try{ gzis.close(); } catch( Exception e ){}
-                    try{ bais.close(); } catch( Exception e ){}
+                    closeStream(baos);
+                    closeStream(gzis);
+                    closeStream(bais);
                 }   // end finally
 
             }   // end if: gzipped
@@ -804,17 +816,15 @@ public static Object decodeToObject( String encodedObject )
         catch( java.io.IOException e )
         {
             e.printStackTrace();
-            obj = null;
         }   // end catch
         catch( java.lang.ClassNotFoundException e )
         {
             e.printStackTrace();
-            obj = null;
         }   // end catch
         finally
         {
-            try{ bais.close(); } catch( Exception e ){}
-            try{ ois.close();  } catch( Exception e ){}
+            closeStream(bais);
+            closeStream(ois);
         }   // end finally
 
         return obj;
@@ -849,7 +859,7 @@ public static boolean encodeToFile( byte[] dataToEncode, String filename )
         }   // end catch: IOException
         finally
         {
-            try{ bos.close(); } catch( Exception e ){}
+            closeStream(bos);
         }   // end finally
 
         return success;
@@ -882,7 +892,7 @@ public static boolean decodeToFile( String dataToDecode, String filename )
         }   // end catch: IOException
         finally
         {
-                try{ bos.close(); } catch( Exception e ){}
+            closeStream(bos);
         }   // end finally
 
         return success;
@@ -940,7 +950,7 @@ public static boolean decodeToFile( String dataToDecode, String filename )
         }   // end catch: IOException
         finally
         {
-            try{ bis.close(); } catch( Exception e) {}
+            closeStream(bis);
         }   // end finally
 
         return decodedData;
@@ -988,7 +998,7 @@ public static String encodeFromFile( String filename )
         }   // end catch: IOException
         finally
         {
-            try{ bis.close(); } catch( Exception e) {}
+            closeStream(bis);
         }   // end finally
 
         return encodedData;
-- 
1.5.6.1.1071.g76fb
