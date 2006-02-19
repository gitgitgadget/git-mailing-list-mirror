From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] git-rev-list --help anywhere
Date: Sun, 19 Feb 2006 12:09:11 +0100
Message-ID: <20060219110911.GA6041@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 12:09:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAmRg-0002t9-CB
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 12:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWBSLJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 06:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWBSLJh
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 06:09:37 -0500
Received: from devrace.com ([198.63.210.113]:64774 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932396AbWBSLJg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2006 06:09:36 -0500
Received: from tigra.home (p54A07517.dip.t-dialin.net [84.160.117.23])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k1JB9Hd7088942;
	Sun, 19 Feb 2006 05:09:19 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FAmRE-000751-00; Sun, 19 Feb 2006 12:09:12 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FAmRD-0002AJ-AO; Sun, 19 Feb 2006 12:09:11 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16430>

Junio C Hamano, Sat, Feb 18, 2006 19:55:02 +0100:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > 	$ git-rev-list --help
> > 	fatal: Not a git repository
> 
> Hmph, true.  Ideas?
> 

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

 rev-list.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

0855207c43a83007e4c060a03c39269f379fed41
diff --git a/rev-list.c b/rev-list.c
index f2d1105..a059e45 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -755,10 +755,16 @@ static void handle_all(struct commit_lis
 
 int main(int argc, const char **argv)
 {
-	const char *prefix = setup_git_directory();
+	const char *prefix;
 	struct commit_list *list = NULL;
 	int i, limited = 0;
 
+	for (i = 1 ; i < argc; i++)
+	    if ( !strcmp(argv[i], "--help") )
+		usage(rev_list_usage);
+
+	prefix = setup_git_directory();
+
 	for (i = 1 ; i < argc; i++) {
 		int flags;
 		const char *arg = argv[i];
-- 
1.2.1.g59a08
