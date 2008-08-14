From: Charles O'Farrell <charleso@charleso.org>
Subject: [PATCH 3/7] Minor refactor of constants, including log and ROOT_DIR
Date: Thu, 14 Aug 2008 20:13:45 +1000
Message-ID: <1218708829-8175-4-git-send-email-charleso@charleso.org>
References: <1218708829-8175-1-git-send-email-charleso@charleso.org>
 <1218708829-8175-2-git-send-email-charleso@charleso.org>
 <1218708829-8175-3-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 12:15:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTZrc-00038Q-6G
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 12:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbYHNKO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 06:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657AbYHNKOZ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 06:14:25 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:59579 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbYHNKOY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 06:14:24 -0400
Received: by py-out-1112.google.com with SMTP id p76so352292pyb.10
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 03:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=ambTbhj9ePA/G6yk6Ml0N1CW6YfhbW+3GIT+fR9Z5QA=;
        b=BtGhfTNcHhtsIflgZcvdTcjQBHCi8c/YR9nyukBzC6oxbqc2pHieKxWhbuyiNrQvvG
         DkQwLzTNr3vzj6yJY0Xg4ilMaysNn31otnrOwZHoIbrmX6PEsYrfO0Jbpq9BuoGMVvTD
         9ZDgbkt/f8RO1+Cda7tOavIDh6aJw/hVRN8qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=FXcRqEMElkFmP78y7+PHOtcycnr+sj/jnyiqaZKnk9W1YBa3lmxNoghzyzIE2dBppA
         XxP8nvfmsgtytrxCMcOPJqOCrD0VCl9BV/T1BhehJKKgjFEyMLZa62qaOVyWq4/DYR1d
         16IqLK2UOOIwWq1W+j8AIDF4o0z3eK2n2Eni8=
Received: by 10.115.90.1 with SMTP id s1mr945876wal.51.1218708862683;
        Thu, 14 Aug 2008 03:14:22 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.240.102])
        by mx.google.com with ESMTPS id a8sm2909044poa.12.2008.08.14.03.14.18
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 03:14:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.35.g04c6e
In-Reply-To: <1218708829-8175-3-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92346>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/lib/Constants.java        |    3 +++
 .../src/org/spearce/jgit/lib/RefLogWriter.java     |    2 +-
 .../spearce/jgit/transport/TransportAmazonS3.java  |   10 ++++++----
 .../org/spearce/jgit/transport/TransportSftp.java  |    6 +++---
 .../spearce/jgit/transport/WalkPushConnection.java |    8 +++++---
 .../jgit/transport/WalkRemoteObjectDatabase.java   |   16 +++++++++-------
 6 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index 7bbd88e..9ae3c1d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -214,6 +214,9 @@ public final class Constants {
 	/** Prefix for tag refs */
 	public static final String TAGS_PREFIX = "refs/tags";
 
+	/** Logs folder name */
+	public static final String LOGS = "logs";
+
 	/** Info refs folder */
 	public static final String INFO_REFS = "info/refs";
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
index 8256d70..3aecaf2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
@@ -70,7 +70,7 @@ public class RefLogWriter {
 		String entry = buildReflogString(repo, oldCommit, commit, message);
 
 		File directory = repo.getDirectory();
-		File reflogfile = new File(directory, "logs/" + refName);
+		File reflogfile = new File(directory, Constants.LOGS + "/" + refName);
 		File reflogdir = reflogfile.getParentFile();
 		if (!reflogdir.exists())
 			if (!reflogdir.mkdirs())
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
index 9aa2567..f9df36d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
@@ -178,7 +178,7 @@ class TransportAmazonS3 extends WalkTransport {
 			if (subpath.endsWith("/"))
 				subpath = subpath.substring(0, subpath.length() - 1);
 			String k = objectsKey;
-			while (subpath.startsWith("../")) {
+			while (subpath.startsWith(ROOT_DIR)) {
 				k = k.substring(0, k.lastIndexOf('/'));
 				subpath = subpath.substring(3);
 			}
@@ -264,7 +264,8 @@ class TransportAmazonS3 extends WalkTransport {
 		private void readLooseRefs(final TreeMap<String, Ref> avail)
 				throws TransportException {
 			try {
-				for (final String n : s3.list(bucket, resolveKey("../refs")))
+				for (final String n : s3.list(bucket, resolveKey(ROOT_DIR
+						+ "refs")))
 					readRef(avail, "refs/" + n);
 			} catch (IOException e) {
 				throw new TransportException(getURI(), "cannot list refs", e);
@@ -274,8 +275,9 @@ class TransportAmazonS3 extends WalkTransport {
 		private Ref readRef(final TreeMap<String, Ref> avail, final String rn)
 				throws TransportException {
 			final String s;
+			String ref = ROOT_DIR + rn;
 			try {
-				final BufferedReader br = openReader("../" + rn);
+				final BufferedReader br = openReader(ref);
 				try {
 					s = br.readLine();
 				} finally {
@@ -284,7 +286,7 @@ class TransportAmazonS3 extends WalkTransport {
 			} catch (FileNotFoundException noRef) {
 				return null;
 			} catch (IOException err) {
-				throw new TransportException(getURI(), "read ../" + rn, err);
+				throw new TransportException(getURI(), "read " + ref, err);
 			}
 
 			if (s == null)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
index 6a5df07..78f4ad8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
@@ -372,8 +372,8 @@ class TransportSftp extends WalkTransport {
 		Map<String, Ref> readAdvertisedRefs() throws TransportException {
 			final TreeMap<String, Ref> avail = new TreeMap<String, Ref>();
 			readPackedRefs(avail);
-			readRef(avail, "../HEAD", "HEAD");
-			readLooseRefs(avail, "../refs", "refs/");
+			readRef(avail, ROOT_DIR + "HEAD", "HEAD");
+			readLooseRefs(avail, ROOT_DIR + "refs", "refs/");
 			return avail;
 		}
 
@@ -423,7 +423,7 @@ class TransportSftp extends WalkTransport {
 
 			if (line.startsWith("ref: ")) {
 				final String p = line.substring("ref: ".length());
-				Ref r = readRef(avail, "../" + p, p);
+				Ref r = readRef(avail, ROOT_DIR + p, p);
 				if (r == null)
 					r = avail.get(p);
 				if (r != null) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
index 19071d7..39b967c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
@@ -37,6 +37,8 @@
 
 package org.spearce.jgit.transport;
 
+import static org.spearce.jgit.transport.WalkRemoteObjectDatabase.ROOT_DIR;
+
 import java.io.IOException;
 import java.io.OutputStream;
 import java.util.ArrayList;
@@ -163,7 +165,7 @@ class WalkPushConnection extends BaseConnection implements PushConnection {
 			@Override
 			protected void writeFile(String file, byte[] content)
 					throws IOException {
-				dest.writeFile("../" + file, content);
+				dest.writeFile(ROOT_DIR + file, content);
 			}
 		};
 		if (!packedRefUpdates.isEmpty()) {
@@ -334,7 +336,7 @@ class WalkPushConnection extends BaseConnection implements PushConnection {
 		try {
 			final String ref = "ref: " + pickHEAD(updates) + "\n";
 			final byte[] bytes = ref.getBytes(Constants.CHARACTER_ENCODING);
-			dest.writeFile("../HEAD", bytes);
+			dest.writeFile(ROOT_DIR + "HEAD", bytes);
 		} catch (IOException e) {
 			throw new TransportException(uri, "cannot create HEAD", e);
 		}
@@ -343,7 +345,7 @@ class WalkPushConnection extends BaseConnection implements PushConnection {
 			final String config = "[core]\n"
 					+ "\trepositoryformatversion = 0\n";
 			final byte[] bytes = config.getBytes(Constants.CHARACTER_ENCODING);
-			dest.writeFile("../config", bytes);
+			dest.writeFile(ROOT_DIR + "config", bytes);
 		} catch (IOException e) {
 			throw new TransportException(uri, "cannot create config", e);
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
index 25640dc..8fb5e1e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
@@ -66,6 +66,9 @@ import org.spearce.jgit.util.NB;
  * independent {@link WalkFetchConnection}.
  */
 abstract class WalkRemoteObjectDatabase {
+
+	static final String ROOT_DIR = "../";
+
 	static final String CHARENC = Constants.CHARACTER_ENCODING;
 
 	static final String INFO_PACKS = "info/packs";
@@ -74,9 +77,7 @@ abstract class WalkRemoteObjectDatabase {
 
 	static final String INFO_HTTP_ALTERNATES = "info/http-alternates";
 
-	static final String INFO_REFS = "../info/refs";
-
-	static final String PACKED_REFS = "../packed-refs";
+	static final String INFO_REFS = ROOT_DIR + Constants.INFO_REFS;
 
 	abstract URIish getURI();
 
@@ -271,7 +272,7 @@ abstract class WalkRemoteObjectDatabase {
 	 *             deletion is not supported, or deletion failed.
 	 */
 	void deleteRef(final String name) throws IOException {
-		deleteFile("../" + name);
+		deleteFile(ROOT_DIR + name);
 	}
 
 	/**
@@ -284,7 +285,7 @@ abstract class WalkRemoteObjectDatabase {
 	 *             deletion is not supported, or deletion failed.
 	 */
 	void deleteRefLog(final String name) throws IOException {
-		deleteFile("../logs/" + name);
+		deleteFile(ROOT_DIR + Constants.LOGS + "/" + name);
 	}
 
 	/**
@@ -308,7 +309,7 @@ abstract class WalkRemoteObjectDatabase {
 		value.copyTo(b);
 		b.write('\n');
 
-		writeFile("../" + name, b.toByteArray());
+		writeFile(ROOT_DIR + name, b.toByteArray());
 	}
 
 	/**
@@ -411,7 +412,8 @@ abstract class WalkRemoteObjectDatabase {
 	protected void readPackedRefs(final Map<String, Ref> avail)
 			throws TransportException {
 		try {
-			final BufferedReader br = openReader(PACKED_REFS);
+			final BufferedReader br = openReader(ROOT_DIR
+					+ Constants.PACKED_REFS);
 			try {
 				readPackedRefsImpl(avail, br);
 			} finally {
-- 
1.6.0.rc2.35.g04c6e
