From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] Fix guilt to work correctly even if the refs are packed
Date: Fri, 06 Jul 2007 10:57:07 -0400
Message-ID: <E1I6pF5-0003V9-2R@candygram.thunk.org>
Cc: git@vger.kernel.org
To: Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Fri Jul 06 16:57:16 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6pFC-00079x-Mo
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 16:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbXGFO5M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 10:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754743AbXGFO5L
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 10:57:11 -0400
Received: from THUNK.ORG ([69.25.196.29]:38252 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754433AbXGFO5K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 10:57:10 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I6pN2-0004RU-00; Fri, 06 Jul 2007 11:05:20 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I6pF5-0003V9-2R; Fri, 06 Jul 2007 10:57:07 -0400
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51757>


Explicitly referencing .git/refs/heads/$branch is bad; use git
show-ref -h instead.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 guilt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/guilt b/guilt
index 814f755..54f9087 100755
--- a/guilt
+++ b/guilt
@@ -247,7 +247,7 @@ head_check()
 	# if the expected hash is empty, just return
 	[ -z "$1" ] && return 0
 
-	if [ "`cat "$GIT_DIR/refs/heads/$branch"`" != "$1" ]; then
+	if [ "`git show-ref -s "refs/heads/$branch"`" != "$1" ]; then
 		echo "Expected HEAD commit $1" >&2
 		echo "                 got `cat "$GIT_DIR/refs/heads/$branch"`" >&2
 		return 1
-- 
1.5.3.rc0.11.ge2b1a
