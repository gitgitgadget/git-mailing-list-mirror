From: mr.gaffo@gmail.com
Subject: [PATCH JGit 15/19] Adding in a InfoDatabase like ObjectDatabase and and implementation based upon a directory.
Date: Sun, 13 Sep 2009 13:44:31 -0500
Message-ID: <1252867475-858-16-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-4-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-6-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-7-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-8-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-9-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-10-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-11-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-12-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-13-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-14-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-15-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:53:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmuCP-0005CB-VU
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbZIMSxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbZIMSxK
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:53:10 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:53562 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815AbZIMSxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:53:09 -0400
Received: by yxe29 with SMTP id 29so3069703yxe.16
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CRZAo5ACGg8s7mYK66PEzdZo92Uj4yku3bDW4hjWKog=;
        b=ePEwgvaastXgqrNUpwPuVV+9dKVIPn/Oj5VePuhnb8tT3OKTHExci3rOSsbYVdWHgE
         U4Xi2Fh/aYzoznFoRCJbNTEub/Tp20aM7pXV13PS8K2NHdVX/vbLN7abz2TxTXB1V0OP
         A+Fil+14ld+ihKzi/UkKhGefXvyrJZ1LJKeKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m+OWg8FcbRzxjB/Q1hEtFf6tqqCMbdnUgvu5r6Iw8bfc3QbkzMJMUDHKRLl8swUFRA
         /ePIygnpmb5LwB83w8dlbdcL2myReHH6/pmUn9LhKKxR3bmjT6IYtInpre09/gIxjlJs
         sr1tnjaOyso/0W6YTS9DmU80Nj1Fu5YC+OpKQ=
Received: by 10.101.83.17 with SMTP id k17mr5638302anl.55.1252867499796;
        Sun, 13 Sep 2009 11:44:59 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-15-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128403>

From: mike.gaffney <mike.gaffney@asolutions.com>

Currently only creates itself.
---
 .../jgit/lib/InfoDirectoryDatabaseTest.java        |   30 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/InfoDatabase.java     |    8 +++++
 .../spearce/jgit/lib/InfoDirectoryDatabase.java    |   18 ++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |   11 +++++++
 .../org/spearce/jgit/transport/ReceivePack.java    |    1 +
 5 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java
new file mode 100644
index 0000000..2b7fb5b
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java
@@ -0,0 +1,30 @@
+package org.spearce.jgit.lib;
+
+import java.io.File;
+
+import org.spearce.jgit.util.JGitTestUtil;
+
+import junit.framework.TestCase;
+
+public class InfoDirectoryDatabaseTest extends TestCase {
+
+	private File testDir;
+
+	@Override
+	protected void setUp() throws Exception {
+		testDir = JGitTestUtil.generateTempDirectoryFileObject();
+	}
+
+	@Override
+	protected void tearDown() throws Exception {
+		if (testDir.exists()){
+			JGitTestUtil.deleteDir(testDir);
+		}
+	}
+	
+	public void testCreateCreatesDirectory() throws Exception {
+		assertFalse(testDir.exists());
+		new InfoDirectoryDatabase(testDir).create();
+		assertTrue(testDir.exists());
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java
new file mode 100644
index 0000000..2f1f398
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java
@@ -0,0 +1,8 @@
+package org.spearce.jgit.lib;
+
+public abstract class InfoDatabase {
+
+	public void create() {
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java
new file mode 100644
index 0000000..20d8a70
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java
@@ -0,0 +1,18 @@
+package org.spearce.jgit.lib;
+
+import java.io.File;
+
+public class InfoDirectoryDatabase extends InfoDatabase {
+
+	private File info;
+
+	public InfoDirectoryDatabase(final File directory) {
+		info = directory;
+	}
+	
+	@Override
+	public void create() {
+		info.mkdirs();
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 46b7804..f658b5c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -97,6 +97,8 @@
 	private final RefDatabase refs;
 
 	private final ObjectDirectory objectDatabase;
+	
+	private final InfoDatabase infoDatabase;
 
 	private GitIndex index;
 
@@ -116,6 +118,7 @@ public Repository(final File d) throws IOException {
 		gitDir = d.getAbsoluteFile();
 		refs = new RefDatabase(this);
 		objectDatabase = new ObjectDirectory(FS.resolve(gitDir, "objects"));
+		infoDatabase = new InfoDirectoryDatabase(FS.resolve(gitDir, "info"));
 
 		final FileBasedConfig userConfig;
 		userConfig = SystemReader.getInstance().openUserConfig();
@@ -177,6 +180,7 @@ public void create(boolean bare) throws IOException {
 		gitDir.mkdirs();
 		refs.create();
 		objectDatabase.create();
+		infoDatabase.create();
 
 		new File(gitDir, "branches").mkdir();
 		new File(gitDir, "remotes").mkdir();
@@ -210,6 +214,13 @@ public File getObjectsDirectory() {
 	public ObjectDatabase getObjectDatabase() {
 		return objectDatabase;
 	}
+	
+	/**
+	 * @return the info database which stores this repository's info
+	 */
+	public InfoDatabase getInfoDatabase() {
+		return infoDatabase;
+	}
 
 	/**
 	 * @return the configuration of this repository
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index 5865736..baa1dec 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -62,6 +62,7 @@
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.RefUpdate;
+import org.spearce.jgit.lib.RefWriter;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.Config.SectionParser;
 import org.spearce.jgit.revwalk.ObjectWalk;
-- 
1.6.4.2
