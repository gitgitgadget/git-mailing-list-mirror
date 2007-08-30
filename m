From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Add commands that git-gc runs underneath
Date: Thu, 30 Aug 2007 12:35:11 +0300
Organization: Private
Message-ID: <lkbtwek0.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 11:32:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQgO6-0000ux-MU
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 11:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbXH3JcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 05:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbXH3JcT
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 05:32:19 -0400
Received: from main.gmane.org ([80.91.229.2]:43189 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232AbXH3JcS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 05:32:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IQgNn-0005fA-KQ
	for git@vger.kernel.org; Thu, 30 Aug 2007 11:32:11 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 11:32:11 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 11:32:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:fIo6tSmsH4/RfstOnyYRreaBEaQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57016>

git-gc is a higher level utility to "do the right thing". However
there are many other lower level utilities for the house keeping and
it is not clear what git-gc actually does. Adding the actual lower
level command and their parameters explain "what's going on".x

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-gc.txt |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index c7742ca..c2315bf 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -21,6 +21,24 @@ Users are encouraged to run this task on a regular basis within
 each repository to maintain good disk space utilization and good
 operating performance.
 
+`git-gc` is a front-end to lower level house keeping commands and
+effectively runs these:
+
+--------------------------------
+ # for non-bare repositories only
+ git pack-refs --all --prune
+
+ git reflog expire --all
+
+ # with added --window -f parameters if --aggressive was specified
+ git repack -a -d -l
+
+ # if --prune was specified
+ git prune
+
+ git rerere gc
+--------------------------------
+
 OPTIONS
 -------
 
-- 
1.5.3.rc5



-- 
Welcome to FOSS revolution: we fix and modify until it shines
