From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 04/12] Add getType() method to RevObject hierarchy
Date: Mon,  2 Jun 2008 23:24:35 +0200
Message-ID: <1212441883-12990-5-git-send-email-marek.zawirski@gmail.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-2-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-3-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-4-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 02 23:26:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HXp-0006g0-F4
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbYFBVZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 17:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbYFBVZA
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:25:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:38434 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbYFBVY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:24:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so844322fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DFsd1Vm3qyO4bXFokMPA88wWXa/DqBC169ogMi+Upko=;
        b=AGXhBsBlivotQJYOn9TCzyBao8dN61666GswMiv4vetJnhMVSET6Qn8pKGMfwuoDm00cZ6tZd88GWtbSEih4LnBZhUcK1tMtz1PXOd6hDDvXgEgD7qzcR6eMTIVQbMFU33caxhS88SN1O9pWkshMxxJSx8pHFJXb6Zv6F75HJjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=v/EGkOesorND8rF5Y+iVbZf83IBeKusxmRqNEvFcM8euPqo4D+5GIpovab2uDeTlC1lEcJK414hheidUCYk36AwNti0xlOndqoFw7/bNPZMcHyWq4MPbIfhc29iW6K67jyEdL/GGRFmEwUMoqqoqB15TXdydOBiBCWXAtd2KHCQ=
Received: by 10.86.84.5 with SMTP id h5mr10577fgb.58.1212441898092;
        Mon, 02 Jun 2008 14:24:58 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 3sm5494671fge.3.2008.06.02.14.24.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 14:24:57 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1212441883-12990-4-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83574>

This let us avoid using instanceof.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/revwalk/RevBlob.java      |    6 ++++++
 .../src/org/spearce/jgit/revwalk/RevCommit.java    |    5 +++++
 .../src/org/spearce/jgit/revwalk/RevObject.java    |    8 ++++++++
 .../src/org/spearce/jgit/revwalk/RevTag.java       |    5 +++++
 .../src/org/spearce/jgit/revwalk/RevTree.java      |    6 ++++++
 5 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java
index f6d34f4..66cdc02 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java
@@ -38,6 +38,7 @@
 package org.spearce.jgit.revwalk;
 
 import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Constants;
 
 /** A binary file, or a symbolic link. */
 public class RevBlob extends RevObject {
@@ -55,4 +56,9 @@ public class RevBlob extends RevObject {
 	void parse(final RevWalk walk) {
 		flags |= PARSED;
 	}
+	
+	@Override
+	public int getType() {
+		return Constants.OBJ_BLOB;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
index 0aa7098..77f1d1a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
@@ -135,6 +135,11 @@ public class RevCommit extends RevObject {
 		buffer = raw;
 		flags |= PARSED;
 	}
+	
+	@Override
+	public int getType() {
+		return Constants.OBJ_COMMIT;
+	}
 
 	static void carryFlags(RevCommit c, final int carry) {
 		for (;;) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
index 86c50b5..451205c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
@@ -42,6 +42,7 @@ import java.io.IOException;
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 
 /** Base object type accessed during revision walking. */
@@ -56,6 +57,13 @@ public abstract class RevObject extends ObjectId {
 
 	abstract void parse(RevWalk walk) throws MissingObjectException,
 			IncorrectObjectTypeException, IOException;
+	
+	/**
+	 * Get Git object type. See {@link Constants}.
+	 * 
+	 * @return object type
+	 */
+	public abstract int getType();
 
 	/**
 	 * Get the name of this object.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
index 668819c..bbb18ee 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
@@ -96,6 +96,11 @@ public class RevTag extends RevObject {
 		flags |= PARSED;
 	}
 
+	@Override
+	public int getType() {
+		return Constants.OBJ_TAG;
+	}
+	
 	/**
 	 * Parse this tag buffer for display.
 	 * 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java
index 7ad9be0..e1cd4b5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java
@@ -38,6 +38,7 @@
 package org.spearce.jgit.revwalk;
 
 import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Constants;
 
 /** A reference to a tree of subtrees/files. */
 public class RevTree extends RevObject {
@@ -55,4 +56,9 @@ public class RevTree extends RevObject {
 	void parse(final RevWalk walk) {
 		flags |= PARSED;
 	}
+	
+	@Override
+	public int getType() {
+		return Constants.OBJ_TREE;
+	}
 }
-- 
1.5.5.1
