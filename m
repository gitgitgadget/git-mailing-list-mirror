From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH] Fix ObjectLoader.getBytes to really return the
	created copy
Date: Fri, 10 Oct 2008 00:09:36 +0200
Message-ID: <20081009220932.GA30350@diku.dk>
References: <1222824690-7632-1-git-send-email-spearce@spearce.org> <1222824690-7632-2-git-send-email-spearce@spearce.org> <1222824690-7632-3-git-send-email-spearce@spearce.org> <2c6b72b30810091446y22cb2e00te7a25676ee21ddac@mail.gmail.com> <20081009214926.GA8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <jonas.fonseca@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 00:10:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko3id-0005OF-Go
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 00:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbYJIWJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 18:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbYJIWJk
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 18:09:40 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:49058 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753272AbYJIWJj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 18:09:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 586B619BCB5;
	Fri, 10 Oct 2008 00:09:38 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27291-06; Fri, 10 Oct 2008 00:09:37 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 06B3B19BCB3;
	Fri, 10 Oct 2008 00:09:37 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D2C056DFBB6; Fri, 10 Oct 2008 00:08:40 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id E00081A4001; Fri, 10 Oct 2008 00:09:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081009214926.GA8203@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97897>

The bug was carried over from the original code in PackedObjectLoader by
commit 4c49ab5a4ec8555681ceabf17142a15bf90c2c24.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../src/org/spearce/jgit/lib/ObjectLoader.java     |    2 +-

 Shawn O. Pearce <spearce@spearce.org> wrote Thu, Oct 09, 2008:
 > I think its already committed to master too.  Can you send a patch
 > along to fix, and point out how stupid I am?

 Yes, I noticed it has already been applied. I am lagging behind a bit.
 Anyway, here is a trivial patch.

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
index 87e861f..8d745dd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
@@ -109,7 +109,7 @@ protected void setId(final ObjectId id) {
 		final byte[] data = getCachedBytes();
 		final byte[] copy = new byte[data.length];
 		System.arraycopy(data, 0, copy, 0, data.length);
-		return data;
+		return copy;
 	}
 
 	/**
-- 
1.6.0.2.665.g48ddf


-- 
Jonas Fonseca
