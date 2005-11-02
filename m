From: Yaacov Akiba Slama <ya@slamail.org>
Subject: [PATCH 3/7] Don't output error when there are changes in the nodes /, /tags or /branches
Date: Wed, 02 Nov 2005 23:51:57 +0200
Message-ID: <E1EXQWT-00050C-Td@localhost.localdomain>
X-From: git-owner@vger.kernel.org Wed Nov 02 22:53:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXQWw-0005A5-DJ
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 22:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965277AbVKBVwW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 16:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbVKBVwW
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 16:52:22 -0500
Received: from [195.140.142.33] ([195.140.142.33]:45265 "EHLO
	c1-033.cyaris.net") by vger.kernel.org with ESMTP id S965277AbVKBVwV
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 16:52:21 -0500
Received: from localhost ([127.0.33.1] helo=localhost.localdomain)
	by c1-033.cyaris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1EXQWb-0003cd-Kn; Wed, 02 Nov 2005 22:52:10 +0100
Received: from yaslama by localhost.localdomain with local (Exim 4.54)
	id 1EXQWT-00050C-Td; Wed, 02 Nov 2005 23:51:57 +0200
Signed-off-by: Yaacov Akiba Slama <ya@slamail.org>
X-Spam-Score: -2.8 (--)
X-Spam-Report: Spam detection software, running on the system "c1-033.cyaris.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  --- git-svnimport.perl | 7 ++++++- 1 files changed, 6
	insertions(+), 1 deletions(-) applies-to:
	d711bb120e7c95914069cff4996ddbcfc29c20f6
	e5d8e159e80ead8eef0867a3662a83b3948aaa18 diff --git
	a/git-svnimport.perl b/git-svnimport.perl index 83b70f9..ea5bbdb 100755
	--- a/git-svnimport.perl +++ b/git-svnimport.perl @@ -336,7 +336,12 @@
	sub split_path($$) { } elsif($path =~ s#^/\Q$branch_name\E/([^/]+)/?##)
	{ $branch = $1; } else { - print STDERR "$rev: Unrecognized path:
	$path\n"; + my %no_error = ( + "/" => 1, + "/$tag_name" => 1, +
	"/$branch_name" => 1 + ); + print STDERR "$rev: Unrecognized path:
	$path\n" unless (defined $no_error{$path}); return () } $path = "/" if
	$path eq ""; --- 0.99.9.GIT [...] 
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11048>

---

 git-svnimport.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

applies-to: d711bb120e7c95914069cff4996ddbcfc29c20f6
e5d8e159e80ead8eef0867a3662a83b3948aaa18
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 83b70f9..ea5bbdb 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -336,7 +336,12 @@ sub split_path($$) {
 	} elsif($path =~ s#^/\Q$branch_name\E/([^/]+)/?##) {
 		$branch = $1;
 	} else {
-		print STDERR "$rev: Unrecognized path: $path\n";
+		my %no_error = (
+			"/" => 1,
+			"/$tag_name" => 1,
+			"/$branch_name" => 1
+		);
+		print STDERR "$rev: Unrecognized path: $path\n" unless (defined $no_error{$path});
 		return ()
 	}
 	$path = "/" if $path eq "";
---
0.99.9.GIT
