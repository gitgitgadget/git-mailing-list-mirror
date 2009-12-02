From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH 1/5] git-svn: Allow setting the committer and author date separately
Date: Wed,  2 Dec 2009 14:07:50 -0500
Message-ID: <1259780874-14706-2-git-send-email-alex@chmrr.net>
References: <1259780874-14706-1-git-send-email-alex@chmrr.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 20:38:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFv1v-0007t6-5v
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574AbZLBThe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754948AbZLBThe
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:37:34 -0500
Received: from chmrr.net ([209.67.253.66]:56886 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754895AbZLBThd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:37:33 -0500
X-Greylist: delayed 1767 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2009 14:37:33 EST
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1NFuYf-0004Rd-Lx
	for git@vger.kernel.org; Wed, 02 Dec 2009 14:08:17 -0500
X-Mailer: git-send-email 1.6.6.rc0.327.g032bc
In-Reply-To: <1259780874-14706-1-git-send-email-alex@chmrr.net>
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-12-02 14:08:17
X-Connected-IP: 75.147.59.54:47077
X-Message-Linecount: 41
X-Body-Linecount: 32
X-Message-Size: 1386
X-Body-Size: 965
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134383>


Signed-off-by: Alex Vandiver <alex@chmrr.net>
---
 git-svn.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 51f03ad..53bf20c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2491,7 +2491,7 @@ sub set_commit_header_env {
 
 	$ENV{GIT_AUTHOR_NAME} = $log_entry->{name};
 	$ENV{GIT_AUTHOR_EMAIL} = $log_entry->{email};
-	$ENV{GIT_AUTHOR_DATE} = $ENV{GIT_COMMITTER_DATE} = $log_entry->{date};
+	$ENV{GIT_AUTHOR_DATE} = $log_entry->{date};
 
 	$ENV{GIT_COMMITTER_NAME} = (defined $log_entry->{commit_name})
 						? $log_entry->{commit_name}
@@ -2499,6 +2499,9 @@ sub set_commit_header_env {
 	$ENV{GIT_COMMITTER_EMAIL} = (defined $log_entry->{commit_email})
 						? $log_entry->{commit_email}
 						: $log_entry->{email};
+        $ENV{GIT_COMMITTER_DATE} =  (defined $log_entry->{commit_date})
+						? $log_entry->{commit_date}
+						: $log_entry->{date};
 	\%env;
 }
 
-- 
1.6.6.rc0.327.g032bc
