From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH v2 11/12] Expose the underlying resource entries in ContainerTreeIterator
Date: Wed, 11 Feb 2009 19:40:13 +0100
Message-ID: <1234377614-23798-12-git-send-email-torarnv@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:42:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK27-0005RI-VG
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757103AbZBKSkU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 13:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbZBKSkS
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:40:18 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:41899 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756928AbZBKSkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:40:16 -0500
Received: by bwz5 with SMTP id 5so488846bwz.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 10:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=f44xOuHx7EV74ypKRg2Oi3lAM3T2o7usBG0uapMhsrU=;
        b=hV0CmiRmgxwO6RVKteQ9Qes/uG1aBFZj0TYBWRhKuswZ6Ow7kqszzoswsaNqP1GLOC
         CPxJrw/H6MK+HnktretLZMLOGfoks8xIltcmuarVychfOsBVtm84xjeGJYZk5bU32WvP
         WaAgJZKCG6hbex4jiOICwQyNdsgvetwVvsudw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HPIPOTcgGe9Jx2bnjY9+CdAkO3RU0q0qj6kHSQQjhX+xDMEehaeOaPeKRuU1iXoQU2
         CZe58tso3NrDzSqv7EvktOltiVFAo3Rbj3YjBJJXxnyet5h9P2GLsTkrPP83DN1cvqqR
         XqMJj7LYIRae2LSvnhdNJTA7OAQuPoI6w5sfk=
Received: by 10.86.60.14 with SMTP id i14mr870793fga.21.1234377614215;
        Wed, 11 Feb 2009 10:40:14 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id d4sm4916754fga.58.2009.02.11.10.39.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 10:39:41 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id DF739468008; Wed, 11 Feb 2009 19:40:16 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1234377614-23798-11-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109492>

This is needed if interacting with any of the Eclipse platform
methods that take IResources as arguments.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../spearce/egit/core/ContainerTreeIterator.java   |   23 ++++++++++++=
+++++++-
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |    9 +++++++
 2 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ContainerT=
reeIterator.java b/org.spearce.egit.core/src/org/spearce/egit/core/Cont=
ainerTreeIterator.java
index 6d6b72e..2403252 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIter=
ator.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIter=
ator.java
@@ -106,6 +106,15 @@ public AbstractTreeIterator createSubtreeIterator(=
final Repository db)
 					Constants.TYPE_TREE);
 	}
=20
+	/**
+	 * Get the ResourceEntry for the current entry.
+	 *=20
+	 * @return the current entry
+	 */
+	public ResourceEntry getResourceEntry() {
+		return (ResourceEntry) current();
+	}
+
 	private Entry[] entries() {
 		final IResource[] all;
 		try {
@@ -120,7 +129,10 @@ public AbstractTreeIterator createSubtreeIterator(=
final Repository db)
 		return r;
 	}
=20
-	static class ResourceEntry extends Entry {
+	/**
+	 * Wrapper for a resource in the Eclipse workspace
+	 */
+	static public class ResourceEntry extends Entry {
 		final IResource rsrc;
=20
 		private final FileMode mode;
@@ -195,6 +207,15 @@ public InputStream openInputStream() throws IOExce=
ption {
 			throw new IOException("Not a regular file: " + rsrc);
 		}
=20
+		/**
+		 * Get the underlying resource of this entry.
+		 *=20
+		 * @return the underlying resource
+		 */
+		public IResource getResource() {
+			return rsrc;
+		}
+
 		private File asFile() {
 			return ((IFile) rsrc).getLocation().toFile();
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.ja=
va b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 189fc86..ce247f2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -739,6 +739,15 @@ public int isPathPrefix(final byte[] p, final int =
pLen) {
 	}
=20
 	/**
+	 * Get the current subtree depth of this walker.
+	 *=20
+	 * @return the current subtree depth of this walker.
+	 */
+	public int getDepth() {
+		return depth;
+	}
+
+	/**
 	 * Is the current entry a subtree?
 	 * <p>
 	 * This method is faster then testing the raw mode bits of all trees =
to see
--=20
1.6.1.2.309.g2ea3
