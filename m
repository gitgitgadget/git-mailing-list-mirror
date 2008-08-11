From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Allow jgit to load additional user classes
Date: Mon, 11 Aug 2008 12:54:42 -0700
Message-ID: <20080811195442.GN26363@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:56:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSdUj-00070L-PY
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756343AbYHKTyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 15:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757240AbYHKTyo
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:54:44 -0400
Received: from george.spearce.org ([209.20.77.23]:34229 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757234AbYHKTyn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 15:54:43 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D308238375; Mon, 11 Aug 2008 19:54:42 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91989>

Users may want to develop their own custom programs (implementations
of TextBuiltin) and add them into the jgit runtime for command line
usage.  We now load additional classes from $JGIT_CLASSPATH, if it
was defined when the process started.

To avoid users replacing our own internal commands or classes we
put the user classpath behind our own, ensuring all of our standard
classes and resources are found first.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 jgit.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/jgit.sh b/jgit.sh
index 121beec..6b9b224 100755
--- a/jgit.sh
+++ b/jgit.sh
@@ -15,6 +15,11 @@ else
 	java_args=
 fi
 
+if [ -n "$JGIT_CLASSPATH" ]
+then
+	cp="$cp:$JGIT_CLASSPATH"
+fi
+
 # Cleanup paths for Cygwin.
 #
 case "`uname`" in
-- 
1.5.4.5

-- 
Shawn.
