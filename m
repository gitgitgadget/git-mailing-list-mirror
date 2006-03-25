From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH]: git-svnimport: if a limit is specified, respect it
Date: Sun, 26 Mar 2006 09:43:46 +1100
Message-ID: <11433266261442-git-send-email-wildfire@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 23:45:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNHVW-000690-0s
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 23:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbWCYWpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 17:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbWCYWpK
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 17:45:10 -0500
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:54949 "EHLO
	giskard.kumria.com") by vger.kernel.org with ESMTP id S1751959AbWCYWpJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 17:45:09 -0500
Received: from eve.kumria.com ([203.7.227.147])
	by giskard.kumria.com with esmtpa (Exim 4.50)
	id 1FNHV6-0004CF-9c; Sun, 26 Mar 2006 08:44:57 +1000
Received: from [127.0.0.1] (helo=eve)
	by eve.kumria.com with smtp (Exim 4.60)
	(envelope-from <wildfire@progsoc.org>)
	id 1FNHU2-0002w9-T8; Sun, 26 Mar 2006 09:43:46 +1100
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
X-SA-Exim-Connect-IP: 203.7.227.147
X-SA-Exim-Mail-From: wildfire@progsoc.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on giskard.kumria.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on giskard.kumria.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18005>


Hi,

git-svnimport will import the same revision over and over again if a
limit (-l <rev>) has been specified. Instead if that revision has already
been processed, exit with an up-to-date message.

Please apply.

Thanks,
Anand

Signed-off-by: Anand Kumria <wildfire@progsoc.org>


---

 git-svnimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

66e05a5854eb269e3e61fcaa9f53a4b2a45b17d8
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 639aa41..114784f 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -851,7 +851,7 @@ sub commit_all {
 
 $opt_l = $svn->{'maxrev'} if not defined $opt_l or $opt_l > $svn->{'maxrev'};
 
-if ($svn->{'maxrev'} < $current_rev) {
+if ($opt_l < $current_rev) {
     print "Up to date: no new revisions to fetch!\n" if $opt_v;
     unlink("$git_dir/SVN2GIT_HEAD");
     exit;
-- 
1.2.4
