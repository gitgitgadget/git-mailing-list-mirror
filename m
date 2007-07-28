From: Eric Lesh <eclesh@ucla.edu>
Subject: [PATCH guilt] guilt-rebase: Make fast-forward work
Date: Sat, 28 Jul 2007 05:22:12 -0700
Message-ID: <87d4ycen0r.fsf@hubert.paunchy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Josef Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Sat Jul 28 14:40:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IElat-0003mr-Uy
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 14:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbXG1MkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 08:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbXG1MkY
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 08:40:24 -0400
Received: from smtp-6.smtp.ucla.edu ([169.232.48.137]:52779 "EHLO
	smtp-6.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbXG1MkY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 08:40:24 -0400
X-Greylist: delayed 1080 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Jul 2007 08:40:23 EDT
Received: from mail.ucla.edu (mail.ucla.edu [169.232.46.158])
	by smtp-6.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6SCMFwm020663;
	Sat, 28 Jul 2007 05:22:15 -0700
Received: from localhost (adsl-75-26-164-167.dsl.scrm01.sbcglobal.net [75.26.164.167])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6SCMESV027522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 28 Jul 2007 05:22:15 -0700
Received: by localhost (Postfix, from userid 1000)
	id 397721E80A8; Sat, 28 Jul 2007 05:22:12 -0700 (PDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.48.137
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54028>

Merges created with --no-commit and a blank commit message didn't update
the branch's HEAD in a fast-forward merge. Rebasing didn't actually do
anything in that case.

Also quote the log message when displaying the new HEAD.

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 guilt-rebase |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/guilt-rebase b/guilt-rebase
index cc8dcf6..f7de813 100755
--- a/guilt-rebase
+++ b/guilt-rebase
@@ -49,11 +49,11 @@ cp "$applied" "$rebase_dir/status"
 
 echo "First, poping all patches..."
 pop_all_patches
-git-merge --no-commit "" HEAD $upstream > /dev/null 2> /dev/null
+git-merge --no-commit $upstream > /dev/null 2> /dev/null
 
 echo ""
 log=`git-log -1 --pretty=oneline`
-echo "HEAD is now at `echo $log | cut -c 1-7`... `echo $log | cut -c 41-`"
+echo "HEAD is now at `echo $log | cut -c 1-7`... `echo "$log" | cut -c 41-`"
 
 #
 # For each previously applied patch:
-- 
1.5.2
