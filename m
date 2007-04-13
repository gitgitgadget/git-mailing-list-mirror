From: Alex Riesen <raa.lkml@gmail.com>
Subject: Fix t4201: accidental arithmetic expansion
Date: Fri, 13 Apr 2007 22:13:10 +0200
Message-ID: <20070413201310.GA750@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 22:13:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcS96-0004jW-D0
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 22:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbXDMUNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 16:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbXDMUNQ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 16:13:16 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:30323 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964988AbXDMUNO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 16:13:14 -0400
Received: from tigra.home (Fcab9.f.strato-dslnet.de [195.4.202.185])
	by post.webmailer.de (klopstock mo51) (RZmta 5.5)
	with ESMTP id C022e3j3DIg8iW ; Fri, 13 Apr 2007 22:13:11 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B3C94277B6;
	Fri, 13 Apr 2007 22:13:11 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 138F9BE85; Fri, 13 Apr 2007 22:13:10 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTv+FXw=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44428>

instead of embedded subshell. It actually breaks here (dash as /bin/sh):

t4201-shortlog.sh: 27: Syntax error: Missing '))'
FATAL: Unexpected exit with code 2

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 t/t4201-shortlog.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 321429c..c27e39c 100644
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -11,7 +11,7 @@ test_description='git-shortlog
 echo 1 > a1
 git add a1
 tree=$(git write-tree)
-commit=$((echo "Test"; echo) | git commit-tree $tree)
+commit=$( (echo "Test"; echo) | git commit-tree $tree )
 git update-ref HEAD $commit
 
 echo 2 > a1
-- 
1.5.1.130.g0ea6d
