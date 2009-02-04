From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [JGIT PATCH] Clarify that TreeWalk trees must all have the same root
Date: Wed,  4 Feb 2009 16:48:05 +0100
Message-ID: <1233762485-1520-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 16:49:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUjzy-0007qM-GV
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 16:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbZBDPro convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 10:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbZBDPrn
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 10:47:43 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:39139 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbZBDPrn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 10:47:43 -0500
Received: by ey-out-2122.google.com with SMTP id 25so638165eya.37
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 07:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=hlGC4ZxHHIlUP7nV/ejFudsoKZOkiFhNVzB+QwhGo3Q=;
        b=CC215bMXEXtdpjptl53eNPGnbHJb7PDntTG7cVrgCIKWNQFe0Tb7Ttv7a/xL+A75lY
         0JtcFJyl1qZFohiNwCzpNx0oPHabWsTtxzN54gaNOT3vvaupFXtdNvDH2J1Vl6xKi4QS
         IHz4hMqzPq4Y+8gF78tOq/MV3GawqJJmloWwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=a45Mi2xFngalpQBmJ4n868O0HtTTaM34akSpko/8CTGaj7Z7BD0eX8adXE3wFodcww
         K/MpWASb4Srq37Z0Sxtq9Q7ImZEwmgozU84CD+SJpso9WM02cWoJTUL7GnL9nNJaO9pA
         Ik9cjvRxwU57CsKCwEWgVWSfcNfhYMc6HxOeU=
Received: by 10.210.58.13 with SMTP id g13mr1096315eba.33.1233762460836;
        Wed, 04 Feb 2009 07:47:40 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 7sm1809546eyg.57.2009.02.04.07.47.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 07:47:40 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id CE649468001; Wed,  4 Feb 2009 16:48:05 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108385>

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.ja=
va b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index cbecb05..189fc86 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -61,6 +61,8 @@
  * <p>
  * This class can perform n-way differences across as many trees as ne=
cessary.
  * <p>
+ * Each tree added must have the same root as existing trees in the wa=
lk.
+ * <p>
  * A TreeWalk instance can only be used once to generate results. Runn=
ing a
  * second time requires creating a new TreeWalk instance, or invoking
  * {@link #reset()} and adding new trees before starting again. Resett=
ing an
@@ -87,7 +89,7 @@
 	 * @param path
 	 *            single path to advance the tree walk instance into.
 	 * @param trees
-	 *            one or more trees to walk through.
+	 *            one or more trees to walk through, all with the same ro=
ot.
 	 * @return a new tree walk configured for exactly this one path; null=
 if no
 	 *         path was found in any of the trees.
 	 * @throws IOException
@@ -377,6 +379,8 @@ public void reset(final AnyObjectId[] ids) throws M=
issingObjectException,
 	 * <p>
 	 * The position of this tree is returned to the caller, in case the c=
aller
 	 * has lost track of the order they added the trees into the walker.
+	 * <p>
+	 * The tree must have the same root as existing trees in the walk.
 	 *=20
 	 * @param id
 	 *            identity of the tree object the caller wants walked.
@@ -403,10 +407,16 @@ public int addTree(final ObjectId id) throws Miss=
ingObjectException,
 	 * <p>
 	 * The position of this tree is returned to the caller, in case the c=
aller
 	 * has lost track of the order they added the trees into the walker.
+	 * <p>
+	 * The tree which the iterator operates on must have the same root as
+	 * existing trees in the walk.
 	 *=20
 	 * @param p
 	 *            an iterator to walk over. The iterator should be new, w=
ith no
 	 *            parent, and should still be positioned before the first=
 entry.
+	 *            The tree which the iterator operates on must have the s=
ame root
+	 *            as other trees in the walk.
+	 *
 	 * @return position of this tree within the walker.
 	 * @throws CorruptObjectException
 	 *             the iterator was unable to obtain its first entry, due=
 to
--=20
1.6.1.2.309.g2ea3
