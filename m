From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/7] gitweb: Restore old git_blame using git-annotate under "annotate"
Date: Sat, 26 Aug 2006 19:14:20 +0200
Message-ID: <11566124661001-git-send-email-jnareb@gmail.com>
References: <1156612392716-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 26 19:14:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH1k9-00041P-Ms
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 19:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422920AbWHZROj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 13:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422916AbWHZROi
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 13:14:38 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:34438 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1030269AbWHZROf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 13:14:35 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7QHDFP0004440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Aug 2006 19:13:15 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7QHEQ2L032723;
	Sat, 26 Aug 2006 19:14:26 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7QHEQDd032722;
	Sat, 26 Aug 2006 19:14:26 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <1156612392716-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26058>

Rename git_blame to git_annotate, and git_blame2 to git_blame.
Link git_annotate under "annotate" action.  Add link to "blame
in git_annotate, and to "annotate" in git_blame.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e00a6ed..abd0f0d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -229,7 +229,8 @@ if (defined $searchtext) {
 
 # dispatch
 my %actions = (
-	"blame" => \&git_blame2,
+	"blame" => \&git_blame,
+	"annotate" => \&git_annotate,
 	"blobdiff" => \&git_blobdiff,
 	"blobdiff_plain" => \&git_blobdiff_plain,
 	"blob" => \&git_blob,
@@ -2166,7 +2167,7 @@ sub git_tag {
 	git_footer_html();
 }
 
-sub git_blame2 {
+sub git_blame {
 	my $fd;
 	my $ftype;
 
@@ -2193,6 +2194,9 @@ sub git_blame2 {
 		$cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
 		        "blob") .
 		" | " .
+		$cgi->a({-href => href(action=>"annotate", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
+		        "annotate") .
+		" | " .
 		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
 		        "head");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
@@ -2236,7 +2240,7 @@ HTML
 	git_footer_html();
 }
 
-sub git_blame {
+sub git_annotate {
 	my $fd;
 
 	if (!gitweb_check_feature('blame')) {
@@ -2258,6 +2262,9 @@ sub git_blame {
 		$cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
 		        "blob") .
 		" | " .
+		$cgi->a({-href => href(action=>"blame", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
+		        "blame") .
+		" | " .
 		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
 		        "head");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-- 
1.4.1.1
