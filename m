From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: replace anonymous sub ref with a normal sub
Date: Tue, 23 May 2006 00:45:39 +1200
Message-ID: <11483019392683-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon May 22 14:40:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi9hw-0003Rz-U5
	for gcvg-git@gmane.org; Mon, 22 May 2006 14:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWEVMkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 08:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWEVMkW
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 08:40:22 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:39886 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1750795AbWEVMkV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 08:40:21 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1Fi9hr-0004hA-Ll; Tue, 23 May 2006 00:40:19 +1200
Received: from mltest ([127.0.0.1] helo=localhost.localdomain)
	by mltest with esmtp (Exim 3.36 #1 (Debian))
	id 1Fi9n1-0001XA-00; Tue, 23 May 2006 00:45:39 +1200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0.g9927-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20501>

commit() does not need to be an anonymous subreference. Keep it simple.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-cvsimport.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

a0bbc1c2010ca46fc215453d5e4c4853c679f950
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index c1923d1..2ecfe14 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -563,7 +563,7 @@ my $state = 0;
 
 my($patchset,$date,$author_name,$author_email,$branch,$ancestor,$tag,$logmsg);
 my(@old,@new,@skipped);
-my $commit = sub {
+sub commit {
 	my $pid;
 	while(@old) {
 		my @o2;
@@ -853,7 +853,7 @@ #	VERSION:1.96->1.96.2.1
 		if ($opt_L && $commitcount++ >= $opt_L) {
 			last;
 		}
-		&$commit();
+		commit();
 		$state = 1;
 	} elsif($state == 11 and /^-+$/) {
 		$state = 1;
@@ -863,7 +863,7 @@ #	VERSION:1.96->1.96.2.1
 		print "* UNKNOWN LINE * $_\n";
 	}
 }
-&$commit() if $branch and $state != 11;
+commit() if $branch and $state != 11;
 
 unlink($git_index);
 
-- 
1.3.2.g82000
