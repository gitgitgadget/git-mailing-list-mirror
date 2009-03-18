From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 02/10] test suite: Use 'say' to say something instead of 'test_expect_success'
Date: Wed, 18 Mar 2009 22:27:04 +0100
Message-ID: <199f6a5e20f857a53af50872927a8086ce221345.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:30:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3Kp-000574-I2
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbZCRV1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754841AbZCRV1b
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:27:31 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46763 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752381AbZCRV1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:27:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9FEA6CDF92;
	Wed, 18 Mar 2009 22:27:17 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7117B60DD4;
	Wed, 18 Mar 2009 22:27:17 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113675>

Some tests report that some tests will be skipped.  They used
'test_exect_success' with a trivially successful test.  Nowadays we have
the helper function 'say' for this purpose.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/lib-git-svn.sh                       |    6 +++---
 t/t0024-crlf-archive.sh                |    2 +-
 t/t3600-rm.sh                          |    2 +-
 t/t5000-tar-tree.sh                    |    2 +-
 t/t7004-tag.sh                         |    4 ++--
 t/t9200-git-cvsexportcommit.sh         |    2 +-
 t/t9400-git-cvsserver-server.sh        |    4 ++--
 t/t9401-git-cvsserver-crlf.sh          |    4 ++--
 t/t9500-gitweb-standalone-no-errors.sh |    2 +-
 t/t9700-perl-git.sh                    |    2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 67c431d..de384e6 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -5,7 +5,7 @@ git_svn_id=git""-svn-id
 
 if test -n "$NO_SVN_TESTS"
 then
-	test_expect_success 'skipping git svn tests, NO_SVN_TESTS defined' :
+	say 'skipping git svn tests, NO_SVN_TESTS defined'
 	test_done
 	exit
 fi
@@ -17,7 +17,7 @@ SVN_TREE=$GIT_SVN_DIR/svn-tree
 svn >/dev/null 2>&1
 if test $? -ne 1
 then
-    test_expect_success 'skipping git svn tests, svn not found' :
+    say 'skipping git svn tests, svn not found'
     test_done
     exit
 fi
@@ -41,7 +41,7 @@ then
 	else
 		err='Perl SVN libraries not found or unusable, skipping test'
 	fi
-	test_expect_success "$err" :
+	say "$err"
 	test_done
 	exit
 fi
diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index e533039..ae90d34 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -28,7 +28,7 @@ test_expect_success 'tar archive' '
 
 "$UNZIP" -v >/dev/null 2>&1
 if [ $? -eq 127 ]; then
-	echo "Skipping ZIP test, because unzip was not found"
+	say "Skipping ZIP test, because unzip was not found"
 	test_done
 	exit
 fi
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 95542e9..74ea8e0 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -112,7 +112,7 @@ test_expect_success \
     'test_must_fail git rm -f baz'
 chmod 775 .
 else
-    test_expect_success 'skipping removal failure (perhaps running as root?)' :
+    say 'skipping removal failure test (perhaps running as root?)'
 fi
 
 test_expect_success \
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index e1ed073..7a84ab6 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -182,7 +182,7 @@ test_expect_success 'git archive --format=zip with --output' \
 
 $UNZIP -v >/dev/null 2>&1
 if [ $? -eq 127 ]; then
-	echo "Skipping ZIP tests, because unzip was not found"
+	say "Skipping ZIP tests, because unzip was not found"
 	test_done
 	exit
 fi
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 69501e2..06e6e17 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -582,7 +582,7 @@ test_expect_success \
 # subsequent tests require gpg; check if it is available
 gpg --version >/dev/null
 if [ $? -eq 127 ]; then
-	echo "gpg not found - skipping tag signing and verification tests"
+	say "gpg not found - skipping tag signing and verification tests"
 	test_done
 	exit
 fi
@@ -614,7 +614,7 @@ test_expect_success \
 # that version, creation of signed tags using the generated key fails.
 case "$(gpg --version)" in
 'gpg (GnuPG) 1.0.6'*)
-	echo "Skipping signed tag tests, because a bug in 1.0.6 version"
+	say "Skipping signed tag tests, because a bug in 1.0.6 version"
 	test_done
 	exit
 	;;
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 245a7c3..d28b71b 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -9,7 +9,7 @@ test_description='Test export of commits to CVS'
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
-    test_expect_success 'skipping git cvsexportcommit tests, cvs not found' :
+    say 'skipping git cvsexportcommit tests, cvs not found'
     test_done
     exit
 fi
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 9ccb123..466240c 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -13,12 +13,12 @@ cvs CLI client via git-cvsserver server'
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
-    test_expect_success 'skipping git-cvsserver tests, cvs not found' :
+    say 'skipping git-cvsserver tests, cvs not found'
     test_done
     exit
 fi
 perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
-    test_expect_success 'skipping git-cvsserver tests, Perl SQLite interface unavailable' :
+    say 'skipping git-cvsserver tests, Perl SQLite interface unavailable'
     test_done
     exit
 }
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 5d6200c..8882230 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -49,12 +49,12 @@ not_present() {
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
-    test_expect_success 'skipping git-cvsserver tests, cvs not found' :
+    say 'skipping git-cvsserver tests, cvs not found'
     test_done
     exit
 fi
 perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
-    test_expect_success 'skipping git-cvsserver tests, Perl SQLite interface unavailable' :
+    say 'skipping git-cvsserver tests, Perl SQLite interface unavailable'
     test_done
     exit
 }
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 6ed10d0..1b78e28 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -74,7 +74,7 @@ safe_chmod () {
 . ./test-lib.sh
 
 perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
-    test_expect_success 'skipping gitweb tests, perl version is too old' :
+    say 'skipping gitweb tests, perl version is too old'
     test_done
     exit
 }
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index b81d5df..4a501c6 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -7,7 +7,7 @@ test_description='perl interface (Git.pm)'
 . ./test-lib.sh
 
 perl -MTest::More -e 0 2>/dev/null || {
-	say_color skip "Perl Test::More unavailable, skipping test"
+	say "Perl Test::More unavailable, skipping test"
 	test_done
 }
 
-- 
1.6.2.1.224.g2225f
