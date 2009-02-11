From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH v2 12/12] Implement label decorations for folders and projects
Date: Wed, 11 Feb 2009 19:40:14 +0100
Message-ID: <1234377614-23798-13-git-send-email-torarnv@gmail.com>
References: <1234377614-23798-1-git-send-email-torarnv@gmail.com>
 <1234377614-23798-2-git-send-email-torarnv@gmail.com>
 <1234377614-23798-3-git-send-email-torarnv@gmail.com>
 <1234377614-23798-4-git-send-email-torarnv@gmail.com>
 <1234377614-23798-5-git-send-email-torarnv@gmail.com>
 <1234377614-23798-6-git-send-email-torarnv@gmail.com>
 <1234377614-23798-7-git-send-email-torarnv@gmail.com>
 <1234377614-23798-8-git-send-email-torarnv@gmail.com>
 <1234377614-23798-9-git-send-email-torarnv@gmail.com>
 <1234377614-23798-10-git-send-email-torarnv@gmail.com>
 <1234377614-23798-11-git-send-email-torarnv@gmail.com>
 <1234377614-23798-12-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:42:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK29-0005RI-TW
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757160AbZBKSkc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 13:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757089AbZBKSka
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:40:30 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:1116 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756994AbZBKSkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:40:17 -0500
Received: by fg-out-1718.google.com with SMTP id 16so108715fgg.17
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 10:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=N+DnTlVijGo6AG1H7Bm47syX9eFMEzRvCKtt+gJK86g=;
        b=ksejg9lXCTuyxpuqak6+B93Gi00HGCh4FNIVLlRSzBmXNfSwnrAR6txa6pVI/j+IDu
         t9EloeSam0U2D/3XSHWtuoKFyclRxMIT87waBVJcou7yxUnpFmUGlwzT3VbjNqcEOeQm
         UqHZuxTvbs4GbXwdSK7Q9TKJVeWf7JMBWld9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=l0fj542RplQ2yHsygpwixuxa8a8+hyOmew8pa/pDIqj8dUQ27LANovQiOiI1OhGxkY
         /jBMpc1Hx3mY/NJCbAPb7yrsKDeaBuPFW3QaadG5ml249wu6OufBO8Owaj4+v6f15I99
         PNQzrUUVrMXDcE+EVVF/jYp3zJT6v6zPOr780=
Received: by 10.86.95.8 with SMTP id s8mr842818fgb.79.1234377616715;
        Wed, 11 Feb 2009 10:40:16 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 12sm100730fgg.33.2009.02.11.10.39.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 10:39:42 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id EA24B468009; Wed, 11 Feb 2009 19:40:16 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1234377614-23798-12-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109488>

The option "Re-decorate ancestors..." controls if parents of a
re-decorated resource also should be updated, for example to
to signal that the containing folder is now concidered dirty.

The option "Maximum number of levels..." controls how deep the
container decoration algorithm will recurse when trying to
determine the state (dirty, staged, etc.) of a container.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../egit/ui/PluginPreferenceInitializer.java       |    4 +-
 .../src/org/spearce/egit/ui/UIPreferences.java     |    4 +-
 .../src/org/spearce/egit/ui/UIText.java            |   14 +-
 .../decorators/DecoratableResourceAdapter.java     |  391 ++++++++++++=
++++++++
 .../decorators/GitLightweightDecorator.java        |  300 ++----------=
---
 .../preferences/GitDecoratorPreferencePage.java    |   91 ++++-
 .../src/org/spearce/egit/ui/uitext.properties      |    7 +-
 7 files changed, 528 insertions(+), 283 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/decorators/DecoratableResourceAdapter.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferen=
ceInitializer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/Plugin=
PreferenceInitializer.java
index a3196f4..8d617e9 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceIniti=
alizer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceIniti=
alizer.java
@@ -35,7 +35,9 @@ public void initializeDefaultPreferences() {
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_REV_COMMENT, tru=
e);
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_TOOLTIPS, false)=
;
=20
-		prefs.setDefault(UIPreferences.DECORATOR_CALCULATE_DIRTY, true);
+		prefs.setDefault(UIPreferences.DECORATOR_RECOMPUTE_ANCESTORS, true);
+		prefs.setDefault(UIPreferences.DECORATOR_RECURSIVE_LIMIT,
+				Integer.MAX_VALUE);
 		prefs.setDefault(UIPreferences.DECORATOR_FILETEXT_DECORATION,
 				UIText.DecoratorPreferencesPage_fileFormatDefault);
 		prefs.setDefault(UIPreferences.DECORATOR_FOLDERTEXT_DECORATION,
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.=
java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
index e812716..bbc36be 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
@@ -53,7 +53,9 @@
 	public final static String THEME_CommitMessageFont =3D "org.spearce.e=
git.ui.CommitMessageFont";
=20
 	/** */
-	public final static String DECORATOR_CALCULATE_DIRTY =3D "decorator_c=
alculate_dirty";
+	public final static String DECORATOR_RECOMPUTE_ANCESTORS =3D "decorat=
or_recompute_ancestors";
+	/** */
+	public final static String DECORATOR_RECURSIVE_LIMIT =3D "decorator_r=
ecursive_limit";
 	/** */
 	public final static String DECORATOR_FILETEXT_DECORATION =3D "decorat=
or_filetext_decoration";
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/=
org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 7e26337..bd64ca1 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -935,7 +935,19 @@
 	public static String DecoratorPreferencesPage_addVariablesAction;
=20
 	/** */
-	public static String DecoratorPreferencesPage_computeDeep;
+	public static String DecoratorPreferencesPage_recomputeAncestorDecora=
tions;
+
+	/** */
+	public static String DecoratorPreferencesPage_recomputeAncestorDecora=
tionsTooltip;
+
+	/** */
+	public static String DecoratorPreferencesPage_computeRecursiveLimit;
+
+	/** */
+	public static String DecoratorPreferencesPage_computeRecursiveLimitTo=
oltip;
+
+	/** */
+	public static String DecoratorPreferencesPage_invalidInput;
=20
 	/** */
 	public static String DecoratorPreferencesPage_description;
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decor=
ators/DecoratableResourceAdapter.java b/org.spearce.egit.ui/src/org/spe=
arce/egit/ui/internal/decorators/DecoratableResourceAdapter.java
new file mode 100644
index 0000000..e2fe54b
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/D=
ecoratableResourceAdapter.java
@@ -0,0 +1,391 @@
+/*********************************************************************=
**********
+ * Copyright (C) 2007, IBM Corporation and others
+ * Copyright (C) 2007, Dave Watson <dwatson@mimvista.com>
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Google Inc.
+ * Copyright (C) 2008, Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1=
=2E0
+ * See LICENSE for the full license text, also available.
+ *********************************************************************=
**********/
+
+package org.spearce.egit.ui.internal.decorators;
+
+import java.io.IOException;
+import java.util.Collections;
+import java.util.Set;
+
+import org.eclipse.core.resources.IProject;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.resources.IWorkspace;
+import org.eclipse.jface.preference.IPreferenceStore;
+import org.eclipse.team.core.Team;
+import org.spearce.egit.core.ContainerTreeIterator;
+import org.spearce.egit.core.ContainerTreeIterator.ResourceEntry;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIPreferences;
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheEntry;
+import org.spearce.jgit.dircache.DirCacheIterator;
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.revwalk.RevWalk;
+import org.spearce.jgit.treewalk.EmptyTreeIterator;
+import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.treewalk.filter.AndTreeFilter;
+import org.spearce.jgit.treewalk.filter.PathFilterGroup;
+import org.spearce.jgit.treewalk.filter.TreeFilter;
+
+class DecoratableResourceAdapter implements IDecoratableResource {
+
+	private final IResource resource;
+
+	private final RepositoryMapping mapping;
+
+	private final Repository repository;
+
+	private final ObjectId headId;
+
+	private final IPreferenceStore store;
+
+	private String branch =3D "";
+
+	private boolean tracked =3D false;
+
+	private boolean ignored =3D false;
+
+	private boolean dirty =3D false;
+
+	private boolean conflicts =3D false;
+
+	private boolean assumeValid =3D false;
+
+	private Staged staged =3D Staged.NOT_STAGED;
+
+	static final int T_HEAD =3D 0;
+
+	static final int T_INDEX =3D 1;
+
+	static final int T_WORKSPACE =3D 2;
+
+	@SuppressWarnings("fallthrough")
+	public DecoratableResourceAdapter(IResource resourceToWrap)
+			throws IOException {
+		resource =3D resourceToWrap;
+		mapping =3D RepositoryMapping.getMapping(resource);
+		repository =3D mapping.getRepository();
+		headId =3D repository.resolve(Constants.HEAD);
+
+		store =3D Activator.getDefault().getPreferenceStore();
+
+		// TODO: Add option to shorten branch name to 6 chars if it's a SHA
+		branch =3D repository.getBranch();
+
+		TreeWalk treeWalk =3D createThreeWayTreeWalk();
+		if (treeWalk =3D=3D null)
+			return;
+
+		switch (resource.getType()) {
+		case IResource.FILE:
+			if (!treeWalk.next())
+				return;
+			extractResourceProperties(treeWalk);
+			break;
+		case IResource.PROJECT:
+			tracked =3D true;
+		case IResource.FOLDER:
+			extractContainerProperties(treeWalk);
+			break;
+		}
+	}
+
+	private void extractResourceProperties(TreeWalk treeWalk) {
+		final ContainerTreeIterator workspaceIterator =3D treeWalk.getTree(
+				T_WORKSPACE, ContainerTreeIterator.class);
+		final ResourceEntry resourceEntry =3D workspaceIterator !=3D null ? =
workspaceIterator
+				.getResourceEntry() : null;
+
+		if (resourceEntry =3D=3D null)
+			return;
+
+		if (isIgnored(resourceEntry.getResource())) {
+			ignored =3D true;
+			return;
+		}
+
+		final int mHead =3D treeWalk.getRawMode(T_HEAD);
+		final int mIndex =3D treeWalk.getRawMode(T_INDEX);
+
+		if (mHead =3D=3D FileMode.MISSING.getBits()
+				&& mIndex =3D=3D FileMode.MISSING.getBits())
+			return;
+
+		tracked =3D true;
+
+		if (mHead =3D=3D FileMode.MISSING.getBits()) {
+			staged =3D Staged.ADDED;
+		} else if (mIndex =3D=3D FileMode.MISSING.getBits()) {
+			staged =3D Staged.REMOVED;
+		} else if (mHead !=3D mIndex
+				|| (mIndex !=3D FileMode.TREE.getBits() && !treeWalk.idEqual(
+						T_HEAD, T_INDEX))) {
+			staged =3D Staged.MODIFIED;
+		} else {
+			staged =3D Staged.NOT_STAGED;
+		}
+
+		final DirCacheIterator indexIterator =3D treeWalk.getTree(T_INDEX,
+				DirCacheIterator.class);
+		final DirCacheEntry indexEntry =3D indexIterator !=3D null ? indexIt=
erator
+				.getDirCacheEntry() : null;
+
+		if (indexEntry =3D=3D null)
+			return;
+
+		if (indexEntry.getStage() > 0)
+			conflicts =3D true;
+
+		if (indexEntry.isAssumeValid()) {
+			dirty =3D false;
+			assumeValid =3D true;
+		} else {
+			if (!timestampMatches(indexEntry, resourceEntry))
+				dirty =3D true;
+
+			// TODO: Consider doing a content check here, to rule out false
+			// positives, as we might get mismatch between timestamps, even
+			// if the content is the same.
+		}
+	}
+
+	private class RecursiveStateFilter extends TreeFilter {
+
+		private int filesChecked =3D 0;
+
+		private int targetDepth =3D -1;
+
+		private final int recurseLimit;
+
+		public RecursiveStateFilter() {
+			recurseLimit =3D store
+					.getInt(UIPreferences.DECORATOR_RECURSIVE_LIMIT);
+		}
+
+		@Override
+		public boolean include(TreeWalk treeWalk)
+				throws MissingObjectException, IncorrectObjectTypeException,
+				IOException {
+
+			if (treeWalk.getFileMode(T_HEAD) =3D=3D FileMode.MISSING
+					&& treeWalk.getFileMode(T_INDEX) =3D=3D FileMode.MISSING)
+				return false;
+
+			if (FileMode.TREE.equals(treeWalk.getRawMode(T_WORKSPACE)))
+				return shouldRecurse(treeWalk);
+
+			// Backup current state so far
+			Staged wasStaged =3D staged;
+			boolean wasDirty =3D dirty;
+			boolean hadConflicts =3D conflicts;
+
+			extractResourceProperties(treeWalk);
+			filesChecked++;
+
+			// Merge results with old state
+			ignored =3D false;
+			assumeValid =3D false;
+			dirty =3D wasDirty || dirty;
+			conflicts =3D hadConflicts || conflicts;
+			if (staged !=3D wasStaged && filesChecked > 1)
+				staged =3D Staged.MODIFIED;
+
+			return false;
+		}
+
+		private boolean shouldRecurse(TreeWalk treeWalk) {
+			final ContainerTreeIterator workspaceIterator =3D treeWalk.getTree(
+					T_WORKSPACE, ContainerTreeIterator.class);
+			final ResourceEntry resourceEntry =3D workspaceIterator !=3D null ?=
 workspaceIterator
+					.getResourceEntry()
+					: null;
+			IResource visitingResource =3D resourceEntry.getResource();
+
+			if (targetDepth =3D=3D -1) {
+				if (visitingResource.equals(resource)
+						|| visitingResource.getParent().equals(resource))
+					targetDepth =3D treeWalk.getDepth();
+				else
+					return true;
+			}
+
+			if ((treeWalk.getDepth() - targetDepth) >=3D recurseLimit) {
+				if (visitingResource.equals(resource))
+					extractResourceProperties(treeWalk);
+
+				return false;
+			}
+
+			return true;
+		}
+
+		@Override
+		public TreeFilter clone() {
+			RecursiveStateFilter clone =3D new RecursiveStateFilter();
+			clone.filesChecked =3D this.filesChecked;
+			return clone;
+		}
+
+		@Override
+		public boolean shouldBeRecursive() {
+			return true;
+		}
+	}
+
+	private void extractContainerProperties(TreeWalk treeWalk) throws IOE=
xception {
+
+		if (isIgnored(resource)) {
+			ignored =3D true;
+			return;
+		}
+
+		treeWalk.setFilter(AndTreeFilter.create(treeWalk.getFilter(),
+				new RecursiveStateFilter()));
+		treeWalk.setRecursive(true);
+
+		treeWalk.next();
+	}
+
+	/**
+	 * Adds a filter to the specified tree walk limiting the results to o=
nly
+	 * those matching the resource specified by <code>resourceToFilterBy<=
/code>
+	 * <p>
+	 * If the resource does not exists in the current repository, no filt=
er is
+	 * added and the method returns <code>false</code>. If the resource i=
s a
+	 * project, no filter is added, but the operation is considered a suc=
cess.
+	 *
+	 * @param treeWalk
+	 *            the tree walk to add the filter to
+	 * @param resourceToFilterBy
+	 *            the resource to filter by
+	 *
+	 * @return <code>true</code> if the filter could be added,
+	 *         <code>false</code> otherwise
+	 */
+	private boolean addResourceFilter(final TreeWalk treeWalk,
+			final IResource resourceToFilterBy) {
+		Set<String> repositoryPaths =3D Collections.singleton(mapping
+				.getRepoRelativePath(resourceToFilterBy));
+		if (repositoryPaths.isEmpty())
+			return false;
+
+		if (repositoryPaths.contains(""))
+			return true; // Project filter
+
+		treeWalk.setFilter(PathFilterGroup.createFromStrings(repositoryPaths=
));
+		return true;
+	}
+
+	/**
+	 * Helper method to create a new tree walk between the repository, th=
e
+	 * index, and the working tree.
+	 *
+	 * @return the created tree walk, or null if it could not be created
+	 * @throws IOException
+	 *             if there were errors when creating the tree walk
+	 */
+	private TreeWalk createThreeWayTreeWalk() throws IOException {
+		final TreeWalk treeWalk =3D new TreeWalk(repository);
+		if (!addResourceFilter(treeWalk, resource))
+			return null;
+
+		treeWalk.setRecursive(treeWalk.getFilter().shouldBeRecursive());
+		treeWalk.reset();
+
+		// Repository
+		if (headId !=3D null)
+			treeWalk.addTree(new RevWalk(repository).parseTree(headId));
+		else
+			treeWalk.addTree(new EmptyTreeIterator());
+
+		// Index
+		treeWalk.addTree(new DirCacheIterator(DirCache.read(repository)));
+
+		// Working directory
+		IProject project =3D resource.getProject();
+		IWorkspace workspace =3D resource.getWorkspace();
+		if (repository.getWorkDir().equals(project.getLocation().toFile()))
+			treeWalk.addTree(new ContainerTreeIterator(project));
+		else
+			treeWalk.addTree(new ContainerTreeIterator(workspace.getRoot()));
+
+		// TODO: Add fallback for projects with the repository more than
+		// one parent up, for example by using a stack of DummyIterators
+
+		return treeWalk;
+	}
+
+	private static boolean timestampMatches(DirCacheEntry indexEntry,
+			ResourceEntry resourceEntry) {
+		long tIndex =3D indexEntry.getLastModified();
+		long tWorkspaceResource =3D resourceEntry.getLastModified();
+
+
+		// C-Git under Windows stores timestamps with 1-seconds resolution,
+		// so we need to check to see if this is the case here, and possibly
+		// fix the timestamp of the resource to match the resolution of the
+		// index.
+		if (tIndex % 1000 =3D=3D 0) {
+			return tIndex =3D=3D (tWorkspaceResource - (tWorkspaceResource % 10=
00));
+		} else {
+			return tIndex =3D=3D tWorkspaceResource;
+		}
+	}
+
+	private static boolean isIgnored(IResource resource) {
+		// TODO: Also read ignores from .git/info/excludes et al.
+		return Team.isIgnoredHint(resource);
+	}
+
+	public String getName() {
+		return resource.getName();
+	}
+
+	public int getType() {
+		return resource.getType();
+	}
+
+	public String getBranch() {
+		return branch;
+	}
+
+	public boolean isTracked() {
+		return tracked;
+	}
+
+	public boolean isIgnored() {
+		return ignored;
+	}
+
+	public boolean isDirty() {
+		return dirty;
+	}
+
+	public Staged staged() {
+		return staged;
+	}
+
+	public boolean hasConflicts() {
+		return conflicts;
+	}
+
+	public boolean isAssumeValid() {
+		return assumeValid;
+	}
+}
\ No newline at end of file
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decor=
ators/GitLightweightDecorator.java b/org.spearce.egit.ui/src/org/spearc=
e/egit/ui/internal/decorators/GitLightweightDecorator.java
index 1e95369..d9de3a4 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/G=
itLightweightDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/G=
itLightweightDecorator.java
@@ -14,7 +14,6 @@
 package org.spearce.egit.ui.internal.decorators;
=20
 import java.io.IOException;
-import java.util.Collections;
 import java.util.HashMap;
 import java.util.HashSet;
 import java.util.Map;
@@ -42,7 +41,6 @@
 import org.eclipse.osgi.util.TextProcessor;
 import org.eclipse.swt.graphics.ImageData;
 import org.eclipse.swt.widgets.Display;
-import org.eclipse.team.core.Team;
 import org.eclipse.team.ui.ISharedImages;
 import org.eclipse.team.ui.TeamImages;
 import org.eclipse.team.ui.TeamUI;
@@ -58,21 +56,11 @@
 import org.spearce.egit.ui.UIPreferences;
 import org.spearce.egit.ui.UIText;
 import org.spearce.egit.ui.internal.decorators.IDecoratableResource.St=
aged;
-import org.spearce.jgit.dircache.DirCache;
-import org.spearce.jgit.dircache.DirCacheEntry;
-import org.spearce.jgit.dircache.DirCacheIterator;
-import org.spearce.jgit.lib.Constants;
-import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.IndexChangedEvent;
-import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.RefsChangedEvent;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.RepositoryChangedEvent;
 import org.spearce.jgit.lib.RepositoryListener;
-import org.spearce.jgit.revwalk.RevWalk;
-import org.spearce.jgit.treewalk.EmptyTreeIterator;
-import org.spearce.jgit.treewalk.TreeWalk;
-import org.spearce.jgit.treewalk.filter.PathFilterGroup;
=20
 /**
  * Supplies annotations for displayed resources
@@ -151,6 +139,15 @@ public void decorate(Object element, IDecoration d=
ecoration) {
 		if (resource =3D=3D null)
 			return;
=20
+		// Don't decorate if the workbench is not running
+		if (!PlatformUI.isWorkbenchRunning())
+			return;
+
+		// Don't decorate if UI plugin is not running
+		Activator activator =3D Activator.getDefault();
+		if (activator =3D=3D null)
+			return;
+
 		// Don't decorate the workspace root
 		if (resource.getType() =3D=3D IResource.ROOT)
 			return;
@@ -169,11 +166,6 @@ public void decorate(Object element, IDecoration d=
ecoration) {
 		if (mapping.getRepoRelativePath(resource) =3D=3D null)
 			return;
=20
-		// Don't decorate if UI plugin is not running
-		Activator activator =3D Activator.getDefault();
-		if (activator =3D=3D null)
-			return;
-
 		try {
 			DecorationHelper helper =3D new DecorationHelper(activator
 					.getPreferenceStore());
@@ -184,238 +176,6 @@ public void decorate(Object element, IDecoration =
decoration) {
 		}
 	}
=20
-	private class DecoratableResourceAdapter implements IDecoratableResou=
rce {
-
-		private final IResource resource;
-
-		private final RepositoryMapping mapping;
-
-		private final Repository repository;
-
-		private final ObjectId headId;
-
-		private String branch =3D "";
-
-		private boolean tracked =3D false;
-
-		private boolean ignored =3D false;
-
-		private boolean dirty =3D false;
-
-		private boolean conflicts =3D false;
-
-		private boolean assumeValid =3D false;
-
-		private Staged staged =3D Staged.NOT_STAGED;
-
-		static final int T_HEAD =3D 0;
-
-		static final int T_INDEX =3D 1;
-
-		static final int T_WORKSPACE =3D 2;
-
-		public DecoratableResourceAdapter(IResource resourceToWrap)
-				throws IOException {
-			resource =3D resourceToWrap;
-			mapping =3D RepositoryMapping.getMapping(resource);
-			repository =3D mapping.getRepository();
-			headId =3D repository.resolve(Constants.HEAD);
-
-			switch (resource.getType()) {
-			case IResource.FILE:
-				extractFileProperties();
-				break;
-			case IResource.FOLDER:
-				extractContainerProperties();
-				break;
-			case IResource.PROJECT:
-				extractProjectProperties();
-				break;
-			}
-		}
-
-		private void extractFileProperties() throws IOException {
-			TreeWalk treeWalk =3D createHeadVsIndexTreeWalk();
-			if (treeWalk =3D=3D null)
-				return;
-
-			if (treeWalk.next())
-				tracked =3D true;
-			else
-				return;
-
-			// TODO: Also read ignores from .git/info/excludes et al.
-			if (Team.isIgnoredHint(resource)) {
-				ignored =3D true;
-				return;
-			}
-
-			final DirCacheIterator indexIterator =3D treeWalk.getTree(T_INDEX,
-					DirCacheIterator.class);
-			final DirCacheEntry indexEntry =3D indexIterator !=3D null ? indexI=
terator
-					.getDirCacheEntry()
-					: null;
-
-			if (indexEntry =3D=3D null) {
-				staged =3D Staged.REMOVED;
-			} else {
-				if (indexEntry.isAssumeValid()) {
-					dirty =3D false;
-					assumeValid =3D true;
-				} else if (indexEntry.getStage() > 0) {
-					conflicts =3D true;
-				} else if (treeWalk.getRawMode(T_HEAD) =3D=3D FileMode.MISSING
-						.getBits()) {
-					staged =3D Staged.ADDED;
-				} else {
-					long indexEntryLastModified =3D indexEntry.getLastModified();
-					long resourceLastModified =3D resource.getLocalTimeStamp();
-
-					// C-Git under Windows stores timestamps with 1-seconds
-					// resolution, so we need to check to see if this is the
-					// case here, and possibly fix the timestamp of the resource
-					// to match the resolution of the index.
-					if (indexEntryLastModified % 1000 =3D=3D 0) {
-						resourceLastModified -=3D resourceLastModified % 1000;
-					}
-
-					if (resourceLastModified !=3D indexEntryLastModified) {
-						// TODO: Consider doing a content check here, to rule
-						// out false positives, as we might get mismatch between
-						// timestamps, even if the content is the same
-						dirty =3D true;
-					}
-
-					if (treeWalk.getRawMode(T_HEAD) !=3D treeWalk
-							.getRawMode(T_INDEX)
-							|| !treeWalk.idEqual(T_HEAD, T_INDEX)) {
-						staged =3D Staged.MODIFIED;
-					}
-				}
-			}
-
-		}
-
-		private void extractContainerProperties() throws IOException {
-			TreeWalk treeWalk =3D createHeadVsIndexTreeWalk();
-			if (treeWalk =3D=3D null)
-				return;
-
-			if (treeWalk.next())
-				tracked =3D true;
-			else
-				return;
-
-			// TODO: Also read ignores from .git/info/excludes et al.
-			if (Team.isIgnoredHint(resource)) {
-				ignored =3D true;
-				return;
-			}
-
-			// TODO: Compute dirty state for folder, using ContainerTreeIterato=
r
-			// and ContainerDiffFilter
-
-		}
-
-		private void extractProjectProperties() throws IOException {
-			branch =3D repository.getBranch();
-			tracked =3D true;
-
-			// TODO: Compute dirty state for folder, using ContainerTreeIterato=
r
-			// and ContainerDiffFilter
-
-		}
-
-		/**
-		 * Adds a filter to the specified tree walk limiting the results to =
only
-		 * those matching the resource specified by
-		 * <code>resourceToFilterBy</code>
-		 * <p>
-		 * If the resource does not exists in the current repository, or it =
has
-		 * an empty path (it is the project itself), the filter is not added=
,
-		 * and the method returns <code>null</code>.
-		 *=20
-		 * @param treeWalk
-		 *            the tree walk to add the filter to
-		 * @param resourceToFilterBy
-		 *            the resource to filter by
-		 *=20
-		 * @return <code>true</code> if the filter could be added,
-		 *         <code>false</code> otherwise
-		 */
-		private boolean addResourceFilter(final TreeWalk treeWalk,
-				final IResource resourceToFilterBy) {
-			Set<String> repositoryPaths =3D Collections.singleton(mapping
-					.getRepoRelativePath(resourceToFilterBy));
-			if (repositoryPaths.isEmpty() || repositoryPaths.contains(""))
-				return false;
-
-			treeWalk.setFilter(PathFilterGroup
-					.createFromStrings(repositoryPaths));
-			return true;
-		}
-
-		/**
-		 * Helper method to create a new tree walk between HEAD and the inde=
x.
-		 *=20
-		 * @return the created tree walk, or null if it could not be created
-		 * @throws IOException
-		 *             if there were errors when creating the tree walk
-		 */
-		private TreeWalk createHeadVsIndexTreeWalk() throws IOException {
-			final TreeWalk treeWalk =3D new TreeWalk(repository);
-			if (!addResourceFilter(treeWalk, resource))
-				return null;
-
-			treeWalk.setRecursive(treeWalk.getFilter().shouldBeRecursive());
-			treeWalk.reset();
-
-			if (headId !=3D null)
-				treeWalk.addTree(new RevWalk(repository).parseTree(headId));
-			else
-				treeWalk.addTree(new EmptyTreeIterator());
-
-			treeWalk.addTree(new DirCacheIterator(DirCache.read(repository)));
-			return treeWalk;
-		}
-
-		public String getName() {
-			return resource.getName();
-		}
-
-		public int getType() {
-			return resource.getType();
-		}
-
-		public String getBranch() {
-			return branch;
-		}
-
-		public boolean isTracked() {
-			return tracked;
-		}
-
-		public boolean isIgnored() {
-			return ignored;
-		}
-
-		public boolean isDirty() {
-			return dirty;
-		}
-
-		public Staged staged() {
-			return staged;
-		}
-
-		public boolean hasConflicts() {
-			return conflicts;
-		}
-
-		public boolean isAssumeValid() {
-			return assumeValid;
-		}
-	}
-
 	/**
 	 * Helper class for doing resource decoration, based on the given
 	 * preferences
@@ -570,11 +330,13 @@ else if (staged =3D=3D Staged.REMOVED)
 				}
=20
 				// Conflicts override everything
-				if (store.getBoolean(UIPreferences.DECORATOR_SHOW_CONFLICTS_ICON)
+				if (store
+						.getBoolean(UIPreferences.DECORATOR_SHOW_CONFLICTS_ICON)
 						&& resource.hasConflicts())
 					overlay =3D conflictImage;
=20
-			} else if (store.getBoolean(UIPreferences.DECORATOR_SHOW_UNTRACKED_=
ICON)) {
+			} else if (store
+					.getBoolean(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON)) {
 				overlay =3D untrackedImage;
 			}
=20
@@ -714,6 +476,14 @@ public void resourceChanged(IResourceChangeEvent e=
vent) {
 		try { // Compute the changed resources by looking at the delta
 			event.getDelta().accept(new IResourceDeltaVisitor() {
 				public boolean visit(IResourceDelta delta) throws CoreException {
+
+					// If the file has changed but not in a way that we care
+					// about (e.g. marker changes to files) then ignore
+					if (delta.getKind() =3D=3D IResourceDelta.CHANGED
+							&& (delta.getFlags() & INTERESTING_CHANGES) =3D=3D 0) {
+						return true;
+					}
+
 					final IResource resource =3D delta.getResource();
=20
 					// If the resource is not part of a project under Git
@@ -724,6 +494,7 @@ public boolean visit(IResourceDelta delta) throws C=
oreException {
 						// Ignore the change
 						return true;
 					}
+
 					if (resource.getType() =3D=3D IResource.ROOT) {
 						// Continue with the delta
 						return true;
@@ -735,33 +506,32 @@ public boolean visit(IResourceDelta delta) throws=
 CoreException {
 							return false;
 					}
=20
-					// If the file has changed but not in a way that we care
-					// about
-					// (e.g. marker changes to files) then ignore the change
-					if (delta.getKind() =3D=3D IResourceDelta.CHANGED
-							&& (delta.getFlags() & INTERESTING_CHANGES) =3D=3D 0) {
-						return true;
-					}
-
 					// All seems good, schedule the resource for update
 					resourcesToUpdate.add(resource);
-					return true;
+
+					if (delta.getKind() =3D=3D IResourceDelta.CHANGED
+							&& (delta.getFlags() & IResourceDelta.OPEN) > 1)
+						return false; // Don't recurse when opening projects
+					else
+						return true;
 				}
 			}, true /* includePhantoms */);
 		} catch (final CoreException e) {
 			handleException(null, e);
 		}
=20
-		// If deep decorator calculation is enabled in the preferences we
-		// walk the ancestor tree of each of the changed resources and add
+		if (resourcesToUpdate.isEmpty())
+			return;
+
+		// If ancestor-decoration is enabled in the preferences we walk
+		// the ancestor tree of each of the changed resources and add
 		// their parents to the update set
 		final IPreferenceStore store =3D Activator.getDefault()
 				.getPreferenceStore();
-		if (store.getBoolean(UIPreferences.DECORATOR_CALCULATE_DIRTY)) {
+		if (store.getBoolean(UIPreferences.DECORATOR_RECOMPUTE_ANCESTORS)) {
 			final IResource[] changedResources =3D resourcesToUpdate
 					.toArray(new IResource[resourcesToUpdate.size()]);
-			for (int i =3D 0; i < changedResources.length; i++) {
-				IResource current =3D changedResources[i];
+			for (IResource current : changedResources) {
 				while (current.getType() !=3D IResource.ROOT) {
 					current =3D current.getParent();
 					resourcesToUpdate.add(current);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/prefe=
rences/GitDecoratorPreferencePage.java b/org.spearce.egit.ui/src/org/sp=
earce/egit/ui/internal/preferences/GitDecoratorPreferencePage.java
index f72ceb7..1c0f82e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/=
GitDecoratorPreferencePage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/=
GitDecoratorPreferencePage.java
@@ -51,12 +51,14 @@
 import org.eclipse.swt.graphics.Font;
 import org.eclipse.swt.graphics.Image;
 import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.layout.GridLayout;
 import org.eclipse.swt.widgets.Button;
 import org.eclipse.swt.widgets.Composite;
 import org.eclipse.swt.widgets.Control;
 import org.eclipse.swt.widgets.Event;
 import org.eclipse.swt.widgets.Label;
 import org.eclipse.swt.widgets.Listener;
+import org.eclipse.swt.widgets.Scale;
 import org.eclipse.swt.widgets.TabFolder;
 import org.eclipse.swt.widgets.TabItem;
 import org.eclipse.swt.widgets.Text;
@@ -76,6 +78,7 @@
 import org.spearce.egit.ui.internal.decorators.GitLightweightDecorator=
=2EDecorationHelper;
 import org.spearce.egit.ui.internal.decorators.IDecoratableResource.St=
aged;
=20
+
 /**
  * Preference page for customizing Git label decorations
  */
@@ -88,7 +91,9 @@
=20
 	private Text projectTextFormat;
=20
-	private Button computeDeepDirtyState;
+	private Button recomputeAncestorDecorations;
+
+	private Scale containerRecurseLimit;
=20
 	private Button showTracked;
=20
@@ -108,11 +113,11 @@
=20
 	static {
 		final PreviewResource project =3D new PreviewResource(
-				"Project", IResource.PROJECT, "master", true, false, false, Staged=
=2ENOT_STAGED, false, false); //$NON-NLS-1$1
+				"Project", IResource.PROJECT, "master", true, false, true, Staged.=
NOT_STAGED, false, false); //$NON-NLS-1$1
 		final ArrayList<PreviewResource> children =3D new ArrayList<PreviewR=
esource>();
=20
 		children.add(new PreviewResource(
-						"folder", IResource.FOLDER, null, true, false, false, Staged.NOT=
_STAGED, false, false)); //$NON-NLS-1$
+						"folder", IResource.FOLDER, null, true, false, true, Staged.NOT_=
STAGED, false, false)); //$NON-NLS-1$
 		children.add(new PreviewResource(
 						"tracked.txt", IResource.FILE, null, true, false, false, Staged.=
NOT_STAGED, false, false)); //$NON-NLS-1$
 		children.add(new PreviewResource(
@@ -194,14 +199,68 @@ public void propertyChange(PropertyChangeEvent ev=
ent) {
=20
 	private Control createGeneralDecoratorPage(Composite parent) {
 		Composite composite =3D SWTUtils.createHVFillComposite(parent,
-				SWTUtils.MARGINS_DEFAULT);
+				SWTUtils.MARGINS_DEFAULT, 1);
=20
-		computeDeepDirtyState =3D SWTUtils.createCheckBox(composite,
-				UIText.DecoratorPreferencesPage_computeDeep);
+		recomputeAncestorDecorations =3D SWTUtils.createCheckBox(composite,
+				UIText.DecoratorPreferencesPage_recomputeAncestorDecorations);
+		recomputeAncestorDecorations
+				.setToolTipText(UIText.DecoratorPreferencesPage_recomputeAncestorD=
ecorationsTooltip);
+
+		SWTUtils.createLabel(composite,
+				UIText.DecoratorPreferencesPage_computeRecursiveLimit);
+		containerRecurseLimit =3D createLabeledScaleControl(composite);
+		containerRecurseLimit
+				.setToolTipText(UIText.DecoratorPreferencesPage_computeRecursiveLi=
mitTooltip);
=20
 		return composite;
 	}
=20
+	private Scale createLabeledScaleControl(Composite parent) {
+
+		final int[] values =3D new int[] { 0, 1, 2, 3, 5, 10, 15, 20, 50, 10=
0,
+				Integer.MAX_VALUE };
+
+		Composite composite =3D SWTUtils.createHVFillComposite(parent,
+				SWTUtils.MARGINS_DEFAULT);
+
+		Composite labels =3D SWTUtils.createHVFillComposite(composite,
+				SWTUtils.MARGINS_NONE, values.length);
+		GridLayout labelsLayout =3D (GridLayout) labels.getLayout();
+		labelsLayout.makeColumnsEqualWidth =3D true;
+		labelsLayout.horizontalSpacing =3D 0;
+		labels.setLayoutData(SWTUtils.createGridData(-1, -1, SWT.FILL,
+				SWT.FILL, false, false));
+
+		for (int i =3D 0; i < values.length; ++i) {
+			Label label =3D SWTUtils.createLabel(labels, "" + values[i]);
+			if (i =3D=3D 0) {
+				label.setAlignment(SWT.LEFT);
+				label.setText("Off");
+			} else if (i =3D=3D values.length - 1) {
+				label.setAlignment(SWT.RIGHT);
+				label.setText("Inf.");
+			} else {
+				label.setAlignment(SWT.CENTER);
+			}
+		}
+
+		final Scale scale =3D new Scale(composite, SWT.HORIZONTAL);
+		scale.setLayoutData(SWTUtils.createHVFillGridData());
+		scale.setMaximum(values.length - 1);
+		scale.setMinimum(0);
+		scale.setIncrement(1);
+		scale.setPageIncrement(1);
+
+		scale.addListener(SWT.Selection, new Listener() {
+			public void handleEvent(Event event) {
+				// Workaround for GTK treating the slider as stepless
+				scale.setSelection(scale.getSelection());
+			}
+		});
+
+		return scale;
+	}
+
 	/**
 	 * Creates the controls for the first tab folder
 	 *=20
@@ -301,8 +360,10 @@ public void handleEvent(Event event) {
 	private void initializeValues() {
 		final IPreferenceStore store =3D getPreferenceStore();
=20
-		computeDeepDirtyState.setSelection(store
-				.getBoolean(UIPreferences.DECORATOR_CALCULATE_DIRTY));
+		recomputeAncestorDecorations.setSelection(store
+				.getBoolean(UIPreferences.DECORATOR_RECOMPUTE_ANCESTORS));
+		containerRecurseLimit.setSelection(store
+				.getInt(UIPreferences.DECORATOR_RECURSIVE_LIMIT));
=20
 		fileTextFormat.setText(store
 				.getString(UIPreferences.DECORATOR_FILETEXT_DECORATION));
@@ -328,7 +389,6 @@ public void widgetSelected(SelectionEvent e) {
 			}
 		};
=20
-		computeDeepDirtyState.addSelectionListener(selectionListener);
 		showTracked.addSelectionListener(selectionListener);
 		showUntracked.addSelectionListener(selectionListener);
 		showStaged.addSelectionListener(selectionListener);
@@ -371,8 +431,10 @@ public boolean performOk() {
 	 */
 	private boolean performOk(IPreferenceStore store) {
=20
-		store.setValue(UIPreferences.DECORATOR_CALCULATE_DIRTY,
-				computeDeepDirtyState.getSelection());
+		store.setValue(UIPreferences.DECORATOR_RECOMPUTE_ANCESTORS,
+				recomputeAncestorDecorations.getSelection());
+		store.setValue(UIPreferences.DECORATOR_RECURSIVE_LIMIT,
+				containerRecurseLimit.getSelection());
=20
 		store.setValue(UIPreferences.DECORATOR_FILETEXT_DECORATION,
 				fileTextFormat.getText());
@@ -403,8 +465,11 @@ protected void performDefaults() {
 		super.performDefaults();
 		IPreferenceStore store =3D getPreferenceStore();
=20
-		computeDeepDirtyState.setSelection(store
-				.getDefaultBoolean(UIPreferences.DECORATOR_CALCULATE_DIRTY));
+		recomputeAncestorDecorations
+				.setSelection(store
+						.getDefaultBoolean(UIPreferences.DECORATOR_RECOMPUTE_ANCESTORS))=
;
+		containerRecurseLimit.setSelection(store
+				.getDefaultInt(UIPreferences.DECORATOR_RECURSIVE_LIMIT));
=20
 		fileTextFormat.setText(store
 				.getDefaultString(UIPreferences.DECORATOR_FILETEXT_DECORATION));
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.propert=
ies b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index e9a2321..847cb2c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -350,9 +350,12 @@ Decorator_exceptionMessage=3DErrors occurred while=
 applying Git decorations to res
=20
 DecoratorPreferencesPage_addVariablesTitle=3DAdd Variables
 DecoratorPreferencesPage_addVariablesAction=3DAdd &Variables...
-DecoratorPreferencesPage_computeDeep=3DInclude &ancestors when re-deco=
rating changed resources
+DecoratorPreferencesPage_recomputeAncestorDecorations=3DRe-decorate &a=
ncestors when decorating changed resources
+DecoratorPreferencesPage_recomputeAncestorDecorationsTooltip=3DEnablin=
g this option will cause the ancestor-tree of any updated resources to =
also be re-decorated (minor performance impact).
+DecoratorPreferencesPage_computeRecursiveLimit=3DMaximum number of lev=
els to recurse for container decoration:
+DecoratorPreferencesPage_computeRecursiveLimitTooltip=3DThis value det=
ermines the maximum number of levels that will be recursed for each con=
tainer decoration before bailing out. Increasing this number will impro=
ve accuracy for container decoration, but has a performance impact for =
large projects.
 DecoratorPreferencesPage_description=3DShows Git specific information =
on resources in projects under version control.
-
+DecoratorPreferencesPage_invalidInput=3D''{0}'' is not a valid input
 DecoratorPreferencesPage_decorationSettings=3DDecoration &settings:
 DecoratorPreferencesPage_preview=3DPreview:
 DecoratorPreferencesPage_fileFormatLabel=3D&Files:
--=20
1.6.1.2.309.g2ea3
