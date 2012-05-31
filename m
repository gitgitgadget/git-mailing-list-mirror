From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Subject: [PATCH] FIX: Syntax of shell and perl scripts and posix compliant
Date: Thu, 31 May 2012 20:16:07 +0200
Message-ID: <1338488167-1217-1-git-send-email-guillaume.sasdy@ensimag.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr>
Cc: Matthieu.Moy@imag.fr, simon.cathebras@ensimag.imag.fr,
	charles.roussel@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 20:16:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa9vE-0001ii-68
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 20:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758242Ab2EaSQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 14:16:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49073 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388Ab2EaSQV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 14:16:21 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4VI7nrP005050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 May 2012 20:07:49 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4VIGHCa031613;
	Thu, 31 May 2012 20:16:17 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q4VIGHLK001292;
	Thu, 31 May 2012 20:16:17 +0200
Received: (from sasdygu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q4VIGHbU001291;
	Thu, 31 May 2012 20:16:17 +0200
X-Mailer: git-send-email 1.7.10.2.568.g4c26a3a
In-Reply-To: <4FC64B0C.6070507@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 31 May 2012 20:07:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4VI7nrP005050
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: guillaume.sasdy@ensimag.imag.fr
MailScanner-NULL-Check: 1339092471.2583@hdeDt+H81WUQENP5UqTYog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198934>

From: Simon Cathebras <simon.cathebras@ensimag.imag.fr>

t/test-gitmw.pl: no more '\n' in the append of wiki_editpage
t/test-gitmw-lib.sh: grep is now Posix compliant
t/test-gitmw-lib.sh: some "  " were misplaced
---
 t/test-gitmw-lib.sh | 17 ++++++++---------
 t/test-gitmw.pl     |  4 ++--
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/t/test-gitmw-lib.sh b/t/test-gitmw-lib.sh
index b89b45a..d7c7459 100755
--- a/t/test-gitmw-lib.sh
+++ b/t/test-gitmw-lib.sh
@@ -31,14 +31,14 @@ WIKI_PASSW="AdminPass"
 # Fetch a page <page_name> from the wiki and copy its content
 # into directory <dest_path>.
 wiki_getpage () {
-	../test-gitmw.pl "get_page" -p "$1" "$2"
+	../test-gitmw.pl get_page -p "$1" "$2"
 }
 
 # wiki_delete_page <page_name>
 #
 # Delete the page <page_name> on the wiki.
 wiki_delete_page () {
-	../test-gitmw.pl "delete_page" -p "$1"
+	../test-gitmw.pl delete_page -p "$1"
 }
 
 # wiki_edit_page <page_name> <page_content> <page_append>
@@ -47,7 +47,7 @@ wiki_delete_page () {
 # If <wiki_append> == true the content will be appended
 # If the page doesn't exist, it is created.
 wiki_editpage () {
-	../test-gitmw.pl "edit_page" -p "$1" "$2" "$3"
+	../test-gitmw.pl edit_page -p "$1" "$2" "$3"
 }
 
 # git_content <dir_1> <dir_2>
@@ -56,7 +56,7 @@ wiki_editpage () {
 # and exits with error 1 if they do not match. The program will
 # not look into .git in the process.
 git_content () {
-	result=$(diff -r -B -w --exclude=".git" "$1" "$2")
+	result=$(diff -r -b --exclude=".git" "$1" "$2")
 
 	if echo $result | grep -q ">" ; then
 		echo "test failed: files $1 and $2 do not match"
@@ -77,11 +77,11 @@ git_exist () {
 	fi
 }
 
-# wiki_page_content <file_name> <page_name> 
+# wiki_check_content <file_name> <page_name> 
 #
 # Compares the contents of the file <file_name> and the wiki page
 # <page_name> and exits with error 1 if they do not match.
-wiki_page_content () {
+wiki_check_content () {
 	wiki_getpage "$2" .
 
 	if test -f "$2".mw ; then
@@ -120,16 +120,15 @@ wiki_getallpagename () {
 # <dest_dir>.
 wiki_getallpage () {
 	wiki_getallpagename
-	mkdir $1
+	mkdir -p "$1"
 	while read -r line; do
 		wiki_getpage "$line" $1;
 	done < all.txt
-	#rm all.txt
 }
 
 fail()
 {
-    echo $1
+    echo "$1"
     exit 1
 }
 
diff --git a/t/test-gitmw.pl b/t/test-gitmw.pl
index e9c50f9..bf71485 100755
--- a/t/test-gitmw.pl
+++ b/t/test-gitmw.pl
@@ -9,7 +9,7 @@
 # License: GPL v2 or later
 
 # Usage:
-#       ./test-gitmw.pl <function> [argument]*
+#       ./test-gitmw.pl <command> [argument]*
 # Execute in terminal using the name of the function to call as first
 # parameter, and the function's arguments as following parameters
 #
@@ -111,7 +111,7 @@ sub wiki_editpage {
 
 	my $text = $wiki_content;
 	if (defined($previous_text)) {
-		$text="$previous_text\n\n$text";
+		$text="$previous_text$text";
 	}
 	$mw->edit( { action => 'edit', title => $wiki_page, text => "$text"} );
 }
-- 
1.7.10.2.568.g4c26a3a
