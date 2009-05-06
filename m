From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Link to the Sun JVM bug mentioned in OffsetCache
Date: Wed, 6 May 2009 07:15:26 -0700
Message-ID: <20090506141526.GA28164@spearce.org>
References: <1240885572-1755-1-git-send-email-spearce@spearce.org> <1240885572-1755-2-git-send-email-spearce@spearce.org> <200904290120.00039.robin.rosenberg.lists@dewire.com> <20090429171659.GF23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed May 06 16:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1huJ-0008T5-Lp
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 16:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027AbZEFOP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 10:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbZEFOP0
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 10:15:26 -0400
Received: from george.spearce.org ([209.20.77.23]:49068 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbZEFOP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 10:15:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BE450381CE; Wed,  6 May 2009 14:15:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090429171659.GF23604@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118342>

This bug has now been published by Sun.  We should link to the
database entry so we can find more detail later.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  "Shawn O. Pearce" <spearce@spearce.org> wrote:
  > Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
  > > > diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
  > > > +	private void gc() {
  > > > +		R r;
  > > > +		while ((r = (R) queue.poll()) != null) {
  > > > +			// Sun's Java 5 and 6 implementation have a bug where a Reference
  > > > +			// can be enqueued and dequeued twice on the same reference queue
  > > > +			// due to a race condition within ReferenceQueue.enqueue(Reference).
  > > 
  > > Reference to the official Sun bug? Might help if someone wants to
  > > implement a flag to avoid this (if necessary...)
  > 
  > Actually, this is a new bug.  I tried looking through BugParade
  > but nobody has mentioned or discovered this before.
  > 
  > I submitted a bug report yesterday, but they have yet to publish it.

  And here it is.

 .../src/org/spearce/jgit/lib/OffsetCache.java      |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
index a1cd4be..b81c7e0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
@@ -414,6 +414,8 @@ private void gc() {
 			// can be enqueued and dequeued twice on the same reference queue
 			// due to a race condition within ReferenceQueue.enqueue(Reference).
 			//
+			// http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=6837858
+			//
 			// We CANNOT permit a Reference to come through us twice, as it will
 			// skew the resource counters we maintain. Our canClear() check here
 			// provides a way to skip the redundant dequeues, if any.
-- 
1.6.3.rc4.206.g03e16
