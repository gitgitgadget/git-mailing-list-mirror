From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 06/12] Move PackFile.SIGNATURE to Constants.PACK_SIGNATURE
Date: Mon,  2 Jun 2008 23:24:37 +0200
Message-ID: <1212441883-12990-7-git-send-email-marek.zawirski@gmail.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-2-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-3-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-4-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-5-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-6-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 02 23:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HXq-0006g0-LL
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbYFBVZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 17:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbYFBVZJ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:25:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:39632 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbYFBVZG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:25:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so844313fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 14:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=f2fKu0Ksd54EKmpqAsh8Oe0oIUqOTcVLN5UktRtAr4w=;
        b=uURfGkhYMk7JkckSmlxwTaW940PFR6QeAEVWXzGoRunnqT8ng8TLEmkAVgmkffFkwXPmArOc9GK+BLOr/1e7dN17ckLAp6mdG63B2orJYYT0nXwwgn01jJ8B3M0xNnjCfO0OQV92R+R17Qsi/tALC9HOxwIyczDRK12fxgdnTWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FfOmWcvzDqH639ZqtlkxlkeGPJ9EsfMmQqchVZ6c5f/bIwz9NUC4AMwbmaD7sLHu0K+hQ/Bfi9SCRt5q7CuImChRrWSftBlhmUBKstypK9jfstlnktYheIRubJ0rxq8ge8GYuw270GI/XMJXpqjc+aevzy92nrByeeDoKlORmO8=
Received: by 10.86.54.4 with SMTP id c4mr4219839fga.33.1212441905235;
        Mon, 02 Jun 2008 14:25:05 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id d4sm4340338fga.8.2008.06.02.14.25.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 14:25:04 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1212441883-12990-6-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83569>

Move to avoid redundancy in reading and writing packfiles in 3 places.
It seems to be a better place for format-related constant.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/Constants.java        |    8 ++++++++
 .../src/org/spearce/jgit/lib/PackFile.java         |   12 +++++-------
 .../src/org/spearce/jgit/transport/IndexPack.java  |    8 +++-----
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index d1e8a41..7c2cef9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -188,6 +188,14 @@ public final class Constants {
 	 */
 	public static final int OBJ_REF_DELTA = 7;
 
+	/**
+	 * Pack file signature that occurs at file header - identifies file as Git
+	 * packfile formatted.
+	 * <p>
+	 * <b>This constant is fixed and is defined by the Git packfile format.</b>
+	 */
+	public static final byte[] PACK_SIGNATURE = { 'P', 'A', 'C', 'K' };
+	
 	/** Native character encoding for commit messages, file names... */
 	public static final String CHARACTER_ENCODING = "UTF-8";
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index ccff47d..b1fbc2a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -50,8 +50,6 @@ import org.spearce.jgit.util.NB;
  * objects are similar.
  */
 public class PackFile {
-	private static final byte[] SIGNATURE = { 'P', 'A', 'C', 'K' };
-
 	private final WindowedFile pack;
 
 	private final PackIndex idx;
@@ -165,17 +163,17 @@ public class PackFile {
 	private void readPackHeader() throws IOException {
 		final WindowCursor curs = new WindowCursor();
 		long position = 0;
-		final byte[] sig = new byte[SIGNATURE.length];
+		final byte[] sig = new byte[Constants.PACK_SIGNATURE.length];
 		final byte[] intbuf = new byte[4];
 		final long vers;
 
-		if (pack.read(position, sig, curs) != SIGNATURE.length)
+		if (pack.read(position, sig, curs) != Constants.PACK_SIGNATURE.length)
 			throw new IOException("Not a PACK file.");
-		for (int k = 0; k < SIGNATURE.length; k++) {
-			if (sig[k] != SIGNATURE[k])
+		for (int k = 0; k < Constants.PACK_SIGNATURE.length; k++) {
+			if (sig[k] != Constants.PACK_SIGNATURE[k])
 				throw new IOException("Not a PACK file.");
 		}
-		position += SIGNATURE.length;
+		position += Constants.PACK_SIGNATURE.length;
 
 		pack.readFully(position, intbuf, curs);
 		vers = NB.decodeUInt32(intbuf, 0);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 0b5c962..bec211c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -74,8 +74,6 @@ public class IndexPack {
 	/** Progress message when computing names of delta compressed objects. */
 	public static final String PROGRESS_RESOLVE_DELTA = "Resolving deltas";
 
-	private static final byte[] SIGNATURE = { 'P', 'A', 'C', 'K' };
-
 	private static final int BUFFER_SIZE = 2048;
 
 	/**
@@ -477,10 +475,10 @@ public class IndexPack {
 	}
 
 	private void readPackHeader() throws IOException {
-		final int hdrln = SIGNATURE.length + 4 + 4;
+		final int hdrln = Constants.PACK_SIGNATURE.length + 4 + 4;
 		final int p = fillFromInput(hdrln);
-		for (int k = 0; k < SIGNATURE.length; k++)
-			if (buf[p + k] != SIGNATURE[k])
+		for (int k = 0; k < Constants.PACK_SIGNATURE.length; k++)
+			if (buf[p + k] != Constants.PACK_SIGNATURE[k])
 				throw new IOException("Not a PACK file.");
 
 		final long vers = NB.decodeUInt32(buf, p + 4);
-- 
1.5.5.1
