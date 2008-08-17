From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 15/31] Add simple abbreviate() method to ObjectId
Date: Sun, 17 Aug 2008 22:43:56 +0200
Message-ID: <1219005852-21496-16-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-14-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-15-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp99-00038o-A6
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbYHQUpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYHQUpM
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:12 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbYHQUpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:45:09 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oepZhYs9Ps0sgemJRcZFicM6T3IEZfAnKHWXkDhd7zw=;
        b=FyLIXp46yzoodKxvGwtglm2DgpC8E02r53NgNqgNWdwGsEc3XSVm5S5nvAEllnMHwD
         bBiCiFM4HsQjc9kn+rNl+nkPo46A2gLAHMzJxU2A+gwwFdH4c18SBvDHlhilHIUK705I
         x6m5qLEsQ2oXSR3jta9UOXMs8x10O0pBlAORk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cOikOE064BE3MOcjWxTy40kYmFYPRj6KeU72xfBKqD5EWLsE5rmfkYNSnc8OdfX/7Q
         0INrfC4zRuMRLKN8bb5aTNLcDm7/LRvJQB1hzG6iEz0Lvib1tgsikgLQhod0nMwkpxKS
         EVTzwJxgmoo/cKizRCVVvBFsw60pzMf0pIgvI=
Received: by 10.102.247.4 with SMTP id u4mr3471421muh.94.1219005908431;
        Sun, 17 Aug 2008 13:45:08 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id y6sm1780789mug.7.2008.08.17.13.45.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:45:07 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-15-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92650>

It's common usage to search for short, but unique abbreviation of
object's SHA-1, so let's have a method for that.

This is a really workaround implementation, but it has been already used
in other places. Let's have other usages pointing here, so we can easily
change only this implementation later.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/pgm/Fetch.java            |   10 +++++-----
 .../src/org/spearce/jgit/pgm/Push.java             |    7 +++----
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |    4 ----
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |   15 +++++++++++++++
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
index 4eff32b..99ed101 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
@@ -93,7 +93,7 @@ class Fetch extends TextBuiltin {
 		}
 	}
 
-	private static String longTypeOf(final TrackingRefUpdate u) {
+	private String longTypeOf(final TrackingRefUpdate u) {
 		final RefUpdate.Result r = u.getResult();
 		if (r == RefUpdate.Result.LOCK_FAILURE)
 			return "[lock fail]";
@@ -110,14 +110,14 @@ class Fetch extends TextBuiltin {
 		}
 
 		if (r == RefUpdate.Result.FORCED) {
-			final String aOld = abbreviateObject(u.getOldObjectId());
-			final String aNew = abbreviateObject(u.getNewObjectId());
+			final String aOld = u.getOldObjectId().abbreviate(db);
+			final String aNew = u.getNewObjectId().abbreviate(db);
 			return aOld + "..." + aNew;
 		}
 
 		if (r == RefUpdate.Result.FAST_FORWARD) {
-			final String aOld = abbreviateObject(u.getOldObjectId());
-			final String aNew = abbreviateObject(u.getNewObjectId());
+			final String aOld = u.getOldObjectId().abbreviate(db);
+			final String aNew = u.getNewObjectId().abbreviate(db);
 			return aOld + ".." + aNew;
 		}
 
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
index f5b24c6..b61071c 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
@@ -173,10 +173,9 @@ class Push extends TextBuiltin {
 				} else {
 					boolean fastForward = rru.isFastForward();
 					final char flag = fastForward ? ' ' : '+';
-					final String summary = abbreviateObject(oldRef
-							.getObjectId())
+					final String summary = oldRef.getObjectId().abbreviate(db)
 							+ (fastForward ? ".." : "...")
-							+ abbreviateObject(rru.getNewObjectId());
+							+ rru.getNewObjectId().abbreviate(db);
 					final String message = fastForward ? null : "forced update";
 					printUpdateLine(flag, summary, srcRef, remoteName, message);
 				}
@@ -199,7 +198,7 @@ class Push extends TextBuiltin {
 
 		case REJECTED_REMOTE_CHANGED:
 			final String message = "remote ref object changed - is not expected one "
-					+ abbreviateObject(rru.getExpectedOldObjectId());
+					+ rru.getExpectedOldObjectId().abbreviate(db);
 			printUpdateLine('!', "[rejected]", srcRef, remoteName, message);
 			break;
 
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
index 5c066cb..23ab92b 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
@@ -179,10 +179,6 @@ public abstract class TextBuiltin {
 		return new Die(why);
 	}
 
-	protected static String abbreviateObject(final ObjectId id) {
-		return id.toString().substring(0, 7);
-	}
-
 	protected String abbreviateRef(String dst, boolean abbreviateRemote) {
 		if (dst.startsWith(REFS_HEADS))
 			dst = dst.substring(REFS_HEADS.length());
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index 7357e57..2c5518a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -411,6 +411,21 @@ public abstract class AnyObjectId implements Comparable {
 	}
 
 	/**
+	 * Return unique abbreviation (prefix) of this object SHA-1.
+	 * <p>
+	 * Current implementation is not guaranteeing uniqueness, it just returns
+	 * fixed-length prefix of SHA-1 string.
+	 * 
+	 * @param repo
+	 *            repository for checking uniqueness within.
+	 * @return SHA-1 abbreviation.
+	 */
+	public String abbreviate(final Repository repo) {
+		// TODO implement checking for uniqueness
+		return toString().substring(0, 7);
+	}
+
+	/**
 	 * Obtain an immutable copy of this current object name value.
 	 * <p>
 	 * Only returns <code>this</code> if this instance is an unsubclassed
-- 
1.5.6.3
