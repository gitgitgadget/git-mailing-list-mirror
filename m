From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 6/6] t9400, t9401: use "git cvsserver" without dash
Date: Wed, 10 Sep 2008 06:25:29 +0900
Message-ID: <20080910062529.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:28:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAkk-0007Te-0k
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260AbYIIV0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754180AbYIIV0j
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:26:39 -0400
Received: from karen.lavabit.com ([72.249.41.33]:33452 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754080AbYIIV0i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:26:38 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id E4A27C89DA;
	Tue,  9 Sep 2008 16:26:28 -0500 (CDT)
Received: from 9677.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id LETQ9WDFBMGL; Tue, 09 Sep 2008 16:26:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=2JtK+jSCLUqY4e1utnbFkOrzkqXszZ7wk2OgW9WgnbBgHRw7z3XVCeh8EjZVD0xyNF3i3N+5BGgRxVHIC/dUfDTmC3obRJDtTarfKGLDoqXXLi00il6nh88VNT090nntYxT3LdE523eauO8mkjf/D7rZDSX4zw/vtd7W4V4WPVg=;
  h=From:To:Cc:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95436>

The environment variable CVS_SERVER is still set to "git-cvsserver",
because tests fail with CVS_SERVER='git cvsserver' (or double quotes).

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 t/t9400-git-cvsserver-server.sh |   38 +++++++++++++++++++-------------------
 t/t9401-git-cvsserver-crlf.sh   |    8 ++++----
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index c1850d2..1ef0a06 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -3,22 +3,22 @@
 # Copyright (c) 2007 Frank Lichtenheld
 #
 
-test_description='git-cvsserver access
+test_description='git cvsserver access
 
 tests read access to a git repository with the
-cvs CLI client via git-cvsserver server'
+cvs CLI client via git cvsserver server'
 
 . ./test-lib.sh
 
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
-    test_expect_success 'skipping git-cvsserver tests, cvs not found' :
+    test_expect_success 'skipping git cvsserver tests, cvs not found' :
     test_done
     exit
 fi
 perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
-    test_expect_success 'skipping git-cvsserver tests, Perl SQLite interface unavailable' :
+    test_expect_success 'skipping git cvsserver tests, Perl SQLite interface unavailable' :
     test_done
     exit
 }
@@ -93,11 +93,11 @@ END VERIFICATION REQUEST
 EOF
 
 test_expect_success 'pserver authentication' \
-  'cat request-anonymous | git-cvsserver pserver >log 2>&1 &&
+  'cat request-anonymous | git cvsserver pserver >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'pserver authentication failure (non-anonymous user)' \
-  'if cat request-git | git-cvsserver pserver >log 2>&1
+  'if cat request-git | git cvsserver pserver >log 2>&1
    then
        false
    else
@@ -106,11 +106,11 @@ test_expect_success 'pserver authentication failure (non-anonymous user)' \
    sed -ne \$p log | grep "^I HATE YOU$"'
 
 test_expect_success 'pserver authentication (login)' \
-  'cat login-anonymous | git-cvsserver pserver >log 2>&1 &&
+  'cat login-anonymous | git cvsserver pserver >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'pserver authentication failure (login/non-anonymous user)' \
-  'if cat login-git | git-cvsserver pserver >log 2>&1
+  'if cat login-git | git cvsserver pserver >log 2>&1
    then
        false
    else
@@ -139,7 +139,7 @@ Root $WORKDIR
 EOF
 
 test_expect_success 'req_Root failure (relative pathname)' \
-  'if cat request-relative | git-cvsserver pserver >log 2>&1
+  'if cat request-relative | git cvsserver pserver >log 2>&1
    then
        echo unexpected success
        false
@@ -149,25 +149,25 @@ test_expect_success 'req_Root failure (relative pathname)' \
    tail log | grep "^error 1 Root must be an absolute pathname$"'
 
 test_expect_success 'req_Root failure (conflicting roots)' \
-  'cat request-conflict | git-cvsserver pserver >log 2>&1 &&
+  'cat request-conflict | git cvsserver pserver >log 2>&1 &&
    tail log | grep "^error 1 Conflicting roots specified$"'
 
 test_expect_success 'req_Root (strict paths)' \
-  'cat request-anonymous | git-cvsserver --strict-paths pserver "$SERVERDIR" >log 2>&1 &&
+  'cat request-anonymous | git cvsserver --strict-paths pserver "$SERVERDIR" >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (strict-paths)' '
     ! cat request-anonymous |
-    git-cvsserver --strict-paths pserver "$WORKDIR" >log 2>&1
+    git cvsserver --strict-paths pserver "$WORKDIR" >log 2>&1
 '
 
 test_expect_success 'req_Root (w/o strict-paths)' \
-  'cat request-anonymous | git-cvsserver pserver "$WORKDIR/" >log 2>&1 &&
+  'cat request-anonymous | git cvsserver pserver "$WORKDIR/" >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (w/o strict-paths)' '
     ! cat request-anonymous |
-    git-cvsserver pserver "$WORKDIR/gitcvs" >log 2>&1
+    git cvsserver pserver "$WORKDIR/gitcvs" >log 2>&1
 '
 
 cat >request-base  <<EOF
@@ -180,25 +180,25 @@ Root /gitcvs.git
 EOF
 
 test_expect_success 'req_Root (base-path)' \
-  'cat request-base | git-cvsserver --strict-paths --base-path "$WORKDIR/" pserver "$SERVERDIR" >log 2>&1 &&
+  'cat request-base | git cvsserver --strict-paths --base-path "$WORKDIR/" pserver "$SERVERDIR" >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (base-path)' '
     ! cat request-anonymous |
-    git-cvsserver --strict-paths --base-path "$WORKDIR" pserver "$SERVERDIR" >log 2>&1
+    git cvsserver --strict-paths --base-path "$WORKDIR" pserver "$SERVERDIR" >log 2>&1
 '
 
 GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false || exit 1
 
 test_expect_success 'req_Root (export-all)' \
-  'cat request-anonymous | git-cvsserver --export-all pserver "$WORKDIR" >log 2>&1 &&
+  'cat request-anonymous | git cvsserver --export-all pserver "$WORKDIR" >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (export-all w/o whitelist)' \
-  '! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'
+  '! (cat request-anonymous | git cvsserver --export-all pserver >log 2>&1 || false)'
 
 test_expect_success 'req_Root (everything together)' \
-  'cat request-base | git-cvsserver --export-all --strict-paths --base-path "$WORKDIR/" pserver "$SERVERDIR" >log 2>&1 &&
+  'cat request-base | git cvsserver --export-all --strict-paths --base-path "$WORKDIR/" pserver "$SERVERDIR" >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU$"'
 
 GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true || exit 1
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index e27a1c5..6b47a7a 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -4,10 +4,10 @@
 # Parts adapted from other tests.
 #
 
-test_description='git-cvsserver -kb modes
+test_description='git cvsserver -kb modes
 
 tests -kb mode for binary files when accessing a git
-repository using cvs CLI client via git-cvsserver server'
+repository using cvs CLI client via git cvsserver server'
 
 . ./test-lib.sh
 
@@ -49,12 +49,12 @@ not_present() {
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
-    test_expect_success 'skipping git-cvsserver tests, cvs not found' :
+    test_expect_success 'skipping git cvsserver tests, cvs not found' :
     test_done
     exit
 fi
 perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
-    test_expect_success 'skipping git-cvsserver tests, Perl SQLite interface unavailable' :
+    test_expect_success 'skipping git cvsserver tests, Perl SQLite interface unavailable' :
     test_done
     exit
 }
-- 
1.6.0.1


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
