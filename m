From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Tests: use test_cmp instead of diff where possible
Date: Mon, 16 Mar 2009 21:18:42 +0100
Message-ID: <1237234722-19049-1-git-send-email-vmiklos@frugalware.org>
References: <49BD4C28.4030303@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Ren=E9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 21:19:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJHX-0000KI-Le
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142AbZCPUR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:17:56 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755361AbZCPURz
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:17:55 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:34042 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbZCPURy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:17:54 -0400
Received: from vmobile.example.net (dsl5401C7DD.pool.t-online.hu [84.1.199.221])
	by yugo.frugalware.org (Postfix) with ESMTPA id 5DDE4446CF6;
	Mon, 16 Mar 2009 21:17:51 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 185B7186220; Mon, 16 Mar 2009 21:18:42 +0100 (CET)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <49BD4C28.4030303@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113376>

Several old tests were written before test_cmp was introduced, convert
these to test_cmp.

If were are at it, fix the order of the arguments where necessary to
make expected come first, so the command shows how the test result
deviates from the correct output.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sun, Mar 15, 2009 at 07:42:48PM +0100, Ren=E9 Scharfe <rene.scharfe@=
lsrfire.ath.cx> wrote:
> >  t/t5000-tar-tree.sh                 |    2 +-
> >  t/t9001-send-email.sh               |    2 +-
> >  7 files changed, 14 insertions(+), 14 deletions(-)
>
> You _did_ touch t5000, and converted one of the diff calls.  I agree
> that the ones using the option -r should stay, but the rest could be
> switched to test_cmp, too.

OK, changed all occurrences, where no options were used.

I also fixed the order problems.

 t/t0000-basic.sh                    |    8 ++++----
 t/t1100-commit-tree-options.sh      |    2 +-
 t/t1400-update-ref.sh               |    6 +++---
 t/t3000-ls-files-others.sh          |    4 ++--
 t/t3010-ls-files-killed-modified.sh |    4 ++--
 t/t5000-tar-tree.sh                 |   22 +++++++++++-----------
 t/t9001-send-email.sh               |    2 +-
 7 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 70df15c..ddcd5b0 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -127,7 +127,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'validate git ls-files output for a known tree.' \
-    'diff current expected'
+    'test_cmp expected current'
=20
 test_expect_success \
     'writing tree out with git write-tree.' \
@@ -147,7 +147,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'git ls-tree output for a known tree.' \
-    'diff current expected'
+    'test_cmp expected current'
=20
 # This changed in ls-tree pathspec change -- recursive does
 # not show tree nodes anymore.
@@ -166,7 +166,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'git ls-tree -r output for a known tree.' \
-    'diff current expected'
+    'test_cmp expected current'
=20
 # But with -r -t we can have both.
 test_expect_success \
@@ -187,7 +187,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'git ls-tree -r output for a known tree.' \
-    'diff current expected'
+    'test_cmp expected current'
=20
 test_expect_success \
     'writing partial tree out with git write-tree --prefix.' \
diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-optio=
ns.sh
index 7f7fc36..c4414ff 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -40,6 +40,6 @@ test_expect_success \
=20
 test_expect_success \
     'compare commit' \
-    'diff expected commit'
+    'test_cmp expected commit'
=20
 test_done
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index bd58926..54ba3df 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -137,7 +137,7 @@ $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 11=
17150860 +0000
 EOF
 test_expect_success \
 	"verifying $m's log" \
-	"diff expect .git/logs/$m"
+	"test_cmp expect .git/logs/$m"
 rm -rf .git/$m .git/logs expect
=20
 test_expect_success \
@@ -168,7 +168,7 @@ $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 11=
17150980 +0000
 EOF
 test_expect_success \
 	"verifying $m's log" \
-	'diff expect .git/logs/$m'
+	'test_cmp expect .git/logs/$m'
 rm -f .git/$m .git/logs/$m expect
=20
 git update-ref $m $D
@@ -272,7 +272,7 @@ $h_FIXED $h_MERGED $GIT_COMMITTER_NAME <$GIT_COMMIT=
TER_EMAIL> 1117151100 +0000	c
 EOF
 test_expect_success \
 	'git commit logged updates' \
-	"diff expect .git/logs/$m"
+	"test_cmp expect .git/logs/$m"
 unset h_TEST h_OTHER h_FIXED h_MERGED
=20
 test_expect_success \
diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index bc0a351..36eee0f 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -42,7 +42,7 @@ test_expect_success \
=20
 test_expect_success \
     'git ls-files --others should pick up symlinks.' \
-    'diff output expected1'
+    'test_cmp expected1 output'
=20
 test_expect_success \
     'git ls-files --others --directory to show output.' \
@@ -51,6 +51,6 @@ test_expect_success \
=20
 test_expect_success \
     'git ls-files --others --directory should not get confused.' \
-    'diff output expected2'
+    'test_cmp expected2 output'
=20
 test_done
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-kil=
led-modified.sh
index ec14040..e4f02a0 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -75,7 +75,7 @@ EOF
=20
 test_expect_success \
     'validate git ls-files -k output.' \
-    'diff .output .expected'
+    'test_cmp .expected .output'
=20
 test_expect_success \
     'git ls-files -m to show modified files.' \
@@ -91,6 +91,6 @@ EOF
=20
 test_expect_success \
     'validate git ls-files -m output.' \
-    'diff .output .expected'
+    'test_cmp .expected .output'
=20
 test_done
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index b7e3628..e1ed073 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -76,7 +76,7 @@ test_expect_success \
=20
 test_expect_success \
     'git archive vs. git tar-tree' \
-    'diff b.tar b2.tar'
+    'test_cmp b.tar b2.tar'
=20
 test_expect_success \
     'git archive in a bare repo' \
@@ -96,12 +96,12 @@ test_expect_success \
      "$TAR" xf b.tar -C extract a/a &&
      test-chmtime -v +0 extract/a/a |cut -f 1 >b.mtime &&
      echo "1117231200" >expected.mtime &&
-     diff expected.mtime b.mtime'
+     test_cmp expected.mtime b.mtime'
=20
 test_expect_success \
     'git get-tar-commit-id' \
     'git get-tar-commit-id <b.tar >b.commitid &&
-     diff .git/$(git symbolic-ref HEAD) b.commitid'
+     test_cmp .git/$(git symbolic-ref HEAD) b.commitid'
=20
 test_expect_success \
     'extract tar archive' \
@@ -110,7 +110,7 @@ test_expect_success \
 test_expect_success \
     'validate filenames' \
     '(cd b/a && find .) | sort >b.lst &&
-     diff a.lst b.lst'
+     test_cmp a.lst b.lst'
=20
 test_expect_success \
     'validate file contents' \
@@ -127,7 +127,7 @@ test_expect_success \
 test_expect_success \
     'validate filenames with prefix' \
     '(cd c/prefix/a && find .) | sort >c.lst &&
-     diff a.lst c.lst'
+     test_cmp a.lst c.lst'
=20
 test_expect_success \
     'validate file contents with prefix' \
@@ -148,8 +148,8 @@ test_expect_success \
      'validate substfile contents' \
      'git log --max-count=3D1 "--pretty=3Dformat:A${SUBSTFORMAT}O" HEA=
D \
       >f/a/substfile1.expected &&
-      diff f/a/substfile1.expected f/a/substfile1 &&
-      diff a/substfile2 f/a/substfile2
+      test_cmp f/a/substfile1.expected f/a/substfile1 &&
+      test_cmp a/substfile2 f/a/substfile2
 '
=20
 test_expect_success \
@@ -160,8 +160,8 @@ test_expect_success \
      'validate substfile contents from archive with prefix' \
      'git log --max-count=3D1 "--pretty=3Dformat:A${SUBSTFORMAT}O" HEA=
D \
       >g/prefix/a/substfile1.expected &&
-      diff g/prefix/a/substfile1.expected g/prefix/a/substfile1 &&
-      diff a/substfile2 g/prefix/a/substfile2
+      test_cmp g/prefix/a/substfile1.expected g/prefix/a/substfile1 &&
+      test_cmp a/substfile2 g/prefix/a/substfile2
 '
=20
 test_expect_success \
@@ -194,7 +194,7 @@ test_expect_success \
 test_expect_success \
     'validate filenames' \
     '(cd d/a && find .) | sort >d.lst &&
-     diff a.lst d.lst'
+     test_cmp a.lst d.lst'
=20
 test_expect_success \
     'validate file contents' \
@@ -211,7 +211,7 @@ test_expect_success \
 test_expect_success \
     'validate filenames with prefix' \
     '(cd e/prefix/a && find .) | sort >e.lst &&
-     diff a.lst e.lst'
+     test_cmp a.lst e.lst'
=20
 test_expect_success \
     'validate file contents with prefix' \
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 08d5b91..9523305 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -88,7 +88,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'Verify commandline' \
-    'diff commandline1 expected'
+    'test_cmp expected commandline1'
=20
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
--=20
1.6.2
