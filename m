From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/12] Mark non-overridable methods of RevObject final
Date: Tue, 17 Mar 2009 18:40:41 -0700
Message-ID: <1237340451-31562-3-git-send-email-spearce@spearce.org>
References: <1237340451-31562-1-git-send-email-spearce@spearce.org>
 <1237340451-31562-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:44:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkpM-00052N-K7
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756647AbZCRBlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756623AbZCRBlM
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:41:12 -0400
Received: from george.spearce.org ([209.20.77.23]:56651 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756489AbZCRBlL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:41:11 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 00071382A4; Wed, 18 Mar 2009 01:41:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3BA73381D3;
	Wed, 18 Mar 2009 01:40:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237340451-31562-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113555>

There isn't a huge benefit to allowing these methods to be overridden,
and subclasses might actually screw them up given that flags is only
visible within our package.  Mark them all final instead.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/RevObject.java    |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
index 8c7cc23..e8fb29f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
@@ -70,17 +70,17 @@ abstract void parse(RevWalk walk) throws MissingObjectException,
 	 * 
 	 * @return unique hash of this object.
 	 */
-	public ObjectId getId() {
+	public final ObjectId getId() {
 		return this;
 	}
 
 	@Override
-	public boolean equals(final ObjectId o) {
+	public final boolean equals(final ObjectId o) {
 		return this == o;
 	}
 
 	@Override
-	public boolean equals(final Object o) {
+	public final boolean equals(final Object o) {
 		return this == o;
 	}
 
@@ -91,7 +91,7 @@ public boolean equals(final Object o) {
 	 *            the flag to test.
 	 * @return true if the flag has been added to this object; false if not.
 	 */
-	public boolean has(final RevFlag flag) {
+	public final boolean has(final RevFlag flag) {
 		return (flags & flag.mask) != 0;
 	}
 
@@ -103,7 +103,7 @@ public boolean has(final RevFlag flag) {
 	 * @return true if any flag in the set has been added to this object; false
 	 *         if not.
 	 */
-	public boolean hasAny(final RevFlagSet set) {
+	public final boolean hasAny(final RevFlagSet set) {
 		return (flags & set.mask) != 0;
 	}
 
@@ -115,7 +115,7 @@ public boolean hasAny(final RevFlagSet set) {
 	 * @return true if all flags of the set have been added to this object;
 	 *         false if some or none have been added.
 	 */
-	public boolean hasAll(final RevFlagSet set) {
+	public final boolean hasAll(final RevFlagSet set) {
 		return (flags & set.mask) == set.mask;
 	}
 
@@ -127,7 +127,7 @@ public boolean hasAll(final RevFlagSet set) {
 	 * @param flag
 	 *            the flag to mark on this object, for later testing.
 	 */
-	public void add(final RevFlag flag) {
+	public final void add(final RevFlag flag) {
 		flags |= flag.mask;
 	}
 
@@ -137,7 +137,7 @@ public void add(final RevFlag flag) {
 	 * @param set
 	 *            the set of flags to mark on this object, for later testing.
 	 */
-	public void add(final RevFlagSet set) {
+	public final void add(final RevFlagSet set) {
 		flags |= set.mask;
 	}
 
@@ -149,7 +149,7 @@ public void add(final RevFlagSet set) {
 	 * @param flag
 	 *            the flag to remove from this object.
 	 */
-	public void remove(final RevFlag flag) {
+	public final void remove(final RevFlag flag) {
 		flags &= ~flag.mask;
 	}
 
@@ -159,7 +159,7 @@ public void remove(final RevFlag flag) {
 	 * @param set
 	 *            the flag to remove from this object.
 	 */
-	public void remove(final RevFlagSet set) {
+	public final void remove(final RevFlagSet set) {
 		flags &= ~set.mask;
 	}
 
-- 
1.6.2.1.286.g8173
