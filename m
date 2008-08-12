From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 21/26] Add debugging commands to interact with the new DirCache code
Date: Mon, 11 Aug 2008 18:08:08 -0700
Message-ID: <1218503293-14057-22-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
 <1218503293-14057-3-git-send-email-spearce@spearce.org>
 <1218503293-14057-4-git-send-email-spearce@spearce.org>
 <1218503293-14057-5-git-send-email-spearce@spearce.org>
 <1218503293-14057-6-git-send-email-spearce@spearce.org>
 <1218503293-14057-7-git-send-email-spearce@spearce.org>
 <1218503293-14057-8-git-send-email-spearce@spearce.org>
 <1218503293-14057-9-git-send-email-spearce@spearce.org>
 <1218503293-14057-10-git-send-email-spearce@spearce.org>
 <1218503293-14057-11-git-send-email-spearce@spearce.org>
 <1218503293-14057-12-git-send-email-spearce@spearce.org>
 <1218503293-14057-13-git-send-email-spearce@spearce.org>
 <1218503293-14057-14-git-send-email-spearce@spearce.org>
 <1218503293-14057-15-git-send-email-spearce@spearce.org>
 <1218503293-14057-16-git-send-email-spearce@spearce.org>
 <1218503293-14057-17-git-send-email-spearce@spearce.org>
 <1218503293-14057-18-git-send-email-spearce@spearce.org>
 <1218503293-14057-19-git-send-email-spearce@spearce.org>
 <1218503293-14057-20-git-send-email-spearce@spearce.org>
 <1218503293-14057-21-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPb-0006OQ-6Y
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbYHLBJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbYHLBJX
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:09:23 -0400
Received: from george.spearce.org ([209.20.77.23]:38619 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbYHLBIk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:40 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 204CC3841C; Tue, 12 Aug 2008 01:08:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id EC5243838A;
	Tue, 12 Aug 2008 01:08:19 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-21-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92046>

These debug commands allow the command line user to read or write
the dircache, to exercise the code, and test it against C Git.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    5 ++
 .../org/spearce/jgit/pgm/debug/MakeCacheTree.java  |   67 ++++++++++++++++++
 .../org/spearce/jgit/pgm/debug/ReadDirCache.java   |   53 ++++++++++++++
 .../org/spearce/jgit/pgm/debug/ShowCacheTree.java  |   69 +++++++++++++++++++
 .../org/spearce/jgit/pgm/debug/ShowDirCache.java   |   72 ++++++++++++++++++++
 .../org/spearce/jgit/pgm/debug/WriteDirCache.java  |   54 +++++++++++++++
 6 files changed, 320 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/MakeCacheTree.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ReadDirCache.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowCacheTree.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowDirCache.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/WriteDirCache.java

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
index 734de3d..8ff815a 100644
--- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -12,4 +12,9 @@ org.spearce.jgit.pgm.RevList
 org.spearce.jgit.pgm.ShowRev
 org.spearce.jgit.pgm.Tag
 
+org.spearce.jgit.pgm.debug.MakeCacheTree
+org.spearce.jgit.pgm.debug.ReadDirCache
+org.spearce.jgit.pgm.debug.ShowCacheTree
 org.spearce.jgit.pgm.debug.ShowCommands
+org.spearce.jgit.pgm.debug.ShowDirCache
+org.spearce.jgit.pgm.debug.WriteDirCache
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/MakeCacheTree.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/MakeCacheTree.java
new file mode 100644
index 0000000..a7d7438
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/MakeCacheTree.java
@@ -0,0 +1,67 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.pgm.debug;
+
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheTree;
+import org.spearce.jgit.pgm.TextBuiltin;
+
+class MakeCacheTree extends TextBuiltin {
+	@Override
+	protected void run() throws Exception {
+		final DirCache cache = DirCache.read(db);
+		final DirCacheTree tree = cache.getCacheTree(true);
+		show(tree);
+	}
+
+	private void show(final DirCacheTree tree) {
+		out.print("\"");
+		out.print(tree.getPathString());
+		out.print("\"");
+		out.print(":  ");
+		out.print(tree.getEntrySpan());
+		out.print(" entries");
+		out.print(", ");
+		out.print(tree.getChildCount());
+		out.print(" children");
+		out.println();
+
+		for (int i = 0; i < tree.getChildCount(); i++)
+			show(tree.getChild(i));
+	}
+}
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ReadDirCache.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ReadDirCache.java
new file mode 100644
index 0000000..d92a9fd
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ReadDirCache.java
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.pgm.debug;
+
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.pgm.TextBuiltin;
+
+class ReadDirCache extends TextBuiltin {
+	@Override
+	protected void run() throws Exception {
+		final int cnt = 100;
+		final long start = System.currentTimeMillis();
+		for (int i = 0; i < cnt; i++)
+			DirCache.read(db);
+		final long end = System.currentTimeMillis();
+		out.println(" average " + ((end - start) / cnt) + " ms/read");
+	}
+}
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowCacheTree.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowCacheTree.java
new file mode 100644
index 0000000..0683fa7
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowCacheTree.java
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.pgm.debug;
+
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheTree;
+import org.spearce.jgit.pgm.TextBuiltin;
+
+class ShowCacheTree extends TextBuiltin {
+	@Override
+	protected void run() throws Exception {
+		final DirCache cache = DirCache.read(db);
+		final DirCacheTree tree = cache.getCacheTree(false);
+		if (tree == null)
+			throw die("no 'TREE' section in index");
+		show(tree);
+	}
+
+	private void show(final DirCacheTree tree) {
+		out.print("\"");
+		out.print(tree.getPathString());
+		out.print("\"");
+		out.print(":  ");
+		out.print(tree.getEntrySpan());
+		out.print(" entries");
+		out.print(", ");
+		out.print(tree.getChildCount());
+		out.print(" children");
+		out.println();
+
+		for (int i = 0; i < tree.getChildCount(); i++)
+			show(tree.getChild(i));
+	}
+}
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowDirCache.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowDirCache.java
new file mode 100644
index 0000000..0822503
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowDirCache.java
@@ -0,0 +1,72 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.pgm.debug;
+
+import java.text.SimpleDateFormat;
+import java.util.Date;
+
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheEntry;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.pgm.TextBuiltin;
+
+class ShowDirCache extends TextBuiltin {
+	@Override
+	protected void run() throws Exception {
+		final SimpleDateFormat fmt;
+		fmt = new SimpleDateFormat("yyyyMMdd,HHmmss.SSS");
+
+		final DirCache cache = DirCache.read(db);
+		for (int i = 0; i < cache.getEntryCount(); i++) {
+			final DirCacheEntry ent = cache.getEntry(i);
+			final FileMode mode = FileMode.fromBits(ent.getRawMode());
+			final int len = ent.getLength();
+			final Date mtime = new Date(ent.getLastModified());
+
+			out.print(mode);
+			out.format(" %6d", len);
+			out.print(' ');
+			out.print(fmt.format(mtime));
+			out.print(' ');
+			out.print(ent.getObjectId());
+			out.print('\t');
+			out.print(ent.getPathString());
+			out.println();
+		}
+	}
+}
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/WriteDirCache.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/WriteDirCache.java
new file mode 100644
index 0000000..a613cbe
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/WriteDirCache.java
@@ -0,0 +1,54 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.pgm.debug;
+
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.pgm.TextBuiltin;
+
+class WriteDirCache extends TextBuiltin {
+	@Override
+	protected void run() throws Exception {
+		final DirCache cache = DirCache.read(db);
+		if (!cache.lock())
+			throw die("failed to lock index");
+		cache.read();
+		cache.write();
+		if (!cache.commit())
+			throw die("failed to commit index");
+	}
+}
-- 
1.6.0.rc2.22.g71b99
