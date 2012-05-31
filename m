From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Subject: [PATCH 1/2] FIX: t9360. NEW test t9361 for git pull and git push
Date: Thu, 31 May 2012 20:13:11 +0200
Message-ID: <1338487992-305-1-git-send-email-guillaume.sasdy@ensimag.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr>
Cc: Matthieu.Moy@imag.fr, simon.cathebras@ensimag.imag.fr,
	charles.roussel@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 20:31:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaA9E-0004r6-6x
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 20:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758307Ab2EaSa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 14:30:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50979 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754714Ab2EaSaz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 14:30:55 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4VI57p3030272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 May 2012 20:05:07 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4VIDS5P031587;
	Thu, 31 May 2012 20:13:28 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q4VIDSGr000393;
	Thu, 31 May 2012 20:13:28 +0200
Received: (from sasdygu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q4VIDSZD000392;
	Thu, 31 May 2012 20:13:28 +0200
X-Mailer: git-send-email 1.7.10.2.568.g4c26a3a
In-Reply-To: <4FC64B0C.6070507@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 31 May 2012 20:05:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4VI57p3030272
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: guillaume.sasdy@ensimag.imag.fr
MailScanner-NULL-Check: 1339092307.85392@+4MZTV2wIs69fQ5YWFrSKw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198936>

t9360: change the description of the test. Test git clone
t9361: Test git pull (add page, edit page, delete page) and git push on simple test cases (add file, edit file, delete file).
---
 t/t9360-git-mediawiki.sh |   4 +-
 t/t9361-git-mediawiki.sh | 156 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+), 2 deletions(-)
 create mode 100755 t/t9361-git-mediawiki.sh

diff --git a/t/t9360-git-mediawiki.sh b/t/t9360-git-mediawiki.sh
index 8de56c5..57e05d8 100755
--- a/t/t9360-git-mediawiki.sh
+++ b/t/t9360-git-mediawiki.sh
@@ -12,7 +12,7 @@
 
 # tests for git-remote-mediawiki
 
-test_description='Test the Git Mediawiki remote helper'
+test_description='Test the Git Mediawiki remote helper: git clone'
 
 . ./test-gitmw-lib.sh
 . ./test-lib.sh
@@ -36,7 +36,7 @@ then
 fi
 
 test_expect_success 'git clone works with page added' '
-	cmd_reset &&
+	wiki_reset &&
 	wiki_editpage foo "hello_world" false &&
 	wiki_editpage bar "hi everybody !" false &&
 	git clone mediawiki::http://localhost/wiki mw_dir &&
diff --git a/t/t9361-git-mediawiki.sh b/t/t9361-git-mediawiki.sh
new file mode 100755
index 0000000..9dd7274
--- /dev/null
+++ b/t/t9361-git-mediawiki.sh
@@ -0,0 +1,156 @@
+#!/bin/sh
+#
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+#     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
+#
+# License: GPL v2 or later
+
+# tests for git-remote-mediawiki
+
+test_description='Test the Git Mediawiki remote helper: git push and git pull simple test cases'
+
+. ./test-gitmw-lib.sh
+. ./test-lib.sh
+
+if ! test_have_prereq PERL
+then
+	skip_all='skipping gateway git-mw tests, perl not available'
+	test_done
+fi
+
+if [ ! -f /$GIT_BUILD_DIR/git-remote-mediawiki ];
+then
+	skip_all='skipping gateway git-mw tests, no remote mediawiki for git found'
+	test_done
+fi
+
+if [ ! -d "$WIKI_DIR_INST/$WIKI_DIR_NAME" ] ;
+then
+	skip_all='skipping gateway git-mw tests, no mediawiki found'
+	test_done
+fi
+
+# Create a new file foo.mw in a freshly cloned wiki. Commit and push
+# this file and then check that all files of the repository are similar to
+# the wiki pages.
+test_expect_success 'git push works after adding a file .mw' "
+        wiki_reset &&
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+        wiki_getallpage ref_page &&
+
+        cd mw_dir &&
+        test ! -f foo.mw && # foo.mw should not exist after wiki_reset &&
+        touch foo.mw &&
+        echo \"hello world\" >> foo.mw &&
+        git add foo.mw &&
+        git commit -m \"foo\" &&
+        git push &&
+        cd .. &&
+
+        rm -rf ref_page &&
+        wiki_getallpage ref_page &&
+        git_content mw_dir ref_page &&
+        rm -rf ref_page &&
+        rm -rf mw_dir
+"
+
+# Create a new page Foo in an empty wiki. Clone the wiki and edit
+# the file foo.mw corresponding to the page Foo. Commit and push
+# then check that all files of the repository are similar to the wiki
+# pages.
+test_expect_success 'git push works after editing a file .mw' "
+        # clone an empty wiki and add a Foo page
+        wiki_reset &&
+        wiki_editpage \"foo\" \"page just created before the git clone\" false &&
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+
+        cd mw_dir &&
+        echo \"new line added in the file foo.mw\" >> Foo.mw &&
+        git commit -am \"edit file foo.mw\" &&
+        git push &&
+        cd .. &&
+
+        rm -rf ref_page &&
+        wiki_getallpage ref_page &&
+        git_content mw_dir ref_page &&
+        rm -rf ref_page &&
+        rm -rf mw_dir
+"
+
+# Clone a wiki with a page Foo. Remove the corresponding file from the
+# repository. Check that the wiki page has been actually removed.
+test_expect_failure 'git push works after deleting a file' "
+        wiki_reset &&
+        wiki_editpage foo \"wiki page added before git clone\" false &&
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+
+        cd mw_dir &&
+        git rm Foo.mw &&
+        git commit -am \"git rm delete the wiki page Foo.mw\" &&
+        git push &&
+        cd .. &&
+
+        rm -rf mw_dir &&
+        test ! wiki_page_exist Foo
+"
+
+# Clone an empty wiki. Add a page on the wiki and pull. Check 
+# all files of the repository are similar to the wiki pages.
+test_expect_success 'git pull works after adding a new wiki page' "
+        wiki_reset &&
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+        wiki_editpage foo \"page just created after the git clone\" false &&
+
+        cd mw_dir &&
+        git pull &&
+        cd .. &&
+
+        rm -rf ref_page &&
+        wiki_getallpage ref_page &&
+        git_content mw_dir ref_page &&
+        rm -rf ref_page &&
+        rm -rf mw_dir
+"
+
+# Clone a wiki with a page Foo. Edit the page foo on the wiki and pull.
+# Check that all files of the repository are similar to the wiki pages.
+test_expect_success 'git pull works after editing a wiki page' "
+        wiki_reset &&
+        wiki_editpage foo \"page just created before the git clone\" false &&
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+        wiki_editpage foo \"new line added on the wiki\" true &&
+
+        cd mw_dir &&
+        git pull &&
+        cd .. &&
+       
+        rm -rf ref_page &&
+        wiki_getallpage ref_page &&
+        git_content mw_dir ref_page &&
+        rm -rf ref_page
+        rm -rf mw_dir
+"
+
+# Clone a wiki with a page Foo. Remove the wiki page and pull.
+# Check that the corresponding file in the repository has been actually removed.
+test_expect_failure 'git pull works after deleting a wiki page' "
+        wiki_reset &&
+        wiki_editpage foo \"wiki page added before git clone\" false &&
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+
+        cd mw_dir &&
+        wiki_delete_page foo
+        git pull &&
+        test ! -f Foo.mw &&
+        cd .. &&
+
+        rm -rf mw_dir
+"
+
+test_done
+
-- 
1.7.10.2.568.g4c26a3a
