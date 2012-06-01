From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Subject: [PATCH 3/3] Tests file for git-remote-mediawiki
Date: Fri,  1 Jun 2012 12:41:57 +0200
Message-ID: <1338547317-26088-3-git-send-email-guillaume.sasdy@ensimag.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr>
 <1338547317-26088-1-git-send-email-guillaume.sasdy@ensimag.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr,
	Charles Roussel <charles.roussel@ensimag.fr>,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon Cathebras <Simon.Cathebras@ensimag.imag.fr>,
	Simon Perrat <Simon.Perrat@ensimag.imag.fr>,
	Charles Roussel <Charles.Roussel@ensimag.imag.fr>,
	Julien Khayat <Julien.Khayat@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 12:43:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaPK3-00052W-W6
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 12:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759343Ab2FAKnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 06:43:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35063 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759256Ab2FAKnD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 06:43:03 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q51AYcfp032684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Jun 2012 12:34:38 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q51Ah2gr009539;
	Fri, 1 Jun 2012 12:43:02 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q51Ah1L1026412;
	Fri, 1 Jun 2012 12:43:01 +0200
Received: (from sasdygu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q51Ah111026411;
	Fri, 1 Jun 2012 12:43:01 +0200
X-Mailer: git-send-email 1.7.10.2.568.g4c26a3a
In-Reply-To: <1338547317-26088-1-git-send-email-guillaume.sasdy@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 01 Jun 2012 12:34:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q51AYcfp032684
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: guillaume.sasdy@ensimag.imag.fr
MailScanner-NULL-Check: 1339151679.03458@lgBGCHMMUcXursBF8ttipA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198977>

From: Charles Roussel <charles.roussel@ensimag.fr>

Those scripts test the functions of git-remote-mediawiki.
t9360: simple test case for git clone.
t9361: simple test cases for git pull (add page, edit page, delete page) and git push (add file, edit file, delete file).

Signed-off-by: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Signed-off-by: Simon Cathebras <Simon.Cathebras@ensimag.imag.fr>
Signed-off-by: Simon Perrat <Simon.Perrat@ensimag.imag.fr>
Signed-off-by: Charles Roussel <Charles.Roussel@ensimag.imag.fr>
Signed-off-by: Julien Khayat <Julien.Khayat@ensimag.imag.fr>
---
 t/t9360-git-mediawiki.sh |  49 +++++++++++++++
 t/t9361-git-mediawiki.sh | 156 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 205 insertions(+)
 create mode 100755 t/t9360-git-mediawiki.sh
 create mode 100755 t/t9361-git-mediawiki.sh

diff --git a/t/t9360-git-mediawiki.sh b/t/t9360-git-mediawiki.sh
new file mode 100755
index 0000000..57e05d8
--- /dev/null
+++ b/t/t9360-git-mediawiki.sh
@@ -0,0 +1,49 @@
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
+test_description='Test the Git Mediawiki remote helper: git clone'
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
+test_expect_success 'git clone works with page added' '
+	wiki_reset &&
+	wiki_editpage foo "hello_world" false &&
+	wiki_editpage bar "hi everybody !" false &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	wiki_getallpage ref_page &&
+	git_content mw_dir ref_page &&
+	wiki_delete_page foo &&
+	wiki_delete_page bar
+'
+
+test_done
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
