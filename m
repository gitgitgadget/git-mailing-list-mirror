From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] tests: Use skip_all=* to skip tests
Date: Thu,  8 Jul 2010 01:16:06 +0000
Message-ID: <1278551766-27569-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 08 03:16:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWfj5-0004Vz-VZ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 03:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757424Ab0GHBQ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 21:16:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55121 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971Ab0GHBQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 21:16:25 -0400
Received: by eya25 with SMTP id 25so30338eya.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 18:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=tTaSigMXm+XEuVw1krAb7TkYsolf2pe4oyIFqdAg1OA=;
        b=k9mv6KiTuPd6wfApGEGFk/3piI8BSGCqUPJBAm61uam81rKTWLjW8OXUuXDCbGFQaj
         XXR6WxCU4K2mjDOWD1FLYt9tiftT9EN/kS3q3+tmgRYy4/98qeS/AvN7D1Q+BP5oPWL2
         wuVbFn8LPu+isnrVUYKigEZMTBJpDSrmcdS4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=dF+1g9dJTFifjI0ZcbBCpi7JJz6e4YeVw2ZgZl6Os8AsTRBOTs+yzvp5wyzvAeLCwf
         UsffLHL9gBe/PazlF73sltZMJO/o4hTc0/wMFhoRQdweJ/nRzeSwsVcNB0dyMlycnJWc
         hPZ+EWzekAQajPrb4LP2aVcPBXazb1XbCtQcw=
Received: by 10.213.112.144 with SMTP id w16mr6682129ebp.85.1278551783430;
        Wed, 07 Jul 2010 18:16:23 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id x54sm4291725eeh.11.2010.07.07.18.16.21
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 18:16:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150523>

Change tests to skip with skip_all=3D* + test_done instead of using say
+ test_done.

This is a follow-up to "tests: Skip tests in a way that makes sense
under TAP" (fadb5156e4). I missed these cases when prepearing that
patch, hopefully this is all of them.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/gitweb-lib.sh           |    4 ++--
 t/lib-cvs.sh              |    6 +++---
 t/lib-git-svn.sh          |   11 +++++------
 t/lib-httpd.sh            |    8 ++++----
 t/lib-patch-mode.sh       |    2 +-
 t/t5800-remote-helpers.sh |    2 +-
 t/t7005-editor.sh         |    2 +-
 7 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index b70b891..81ef2a0 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -76,12 +76,12 @@ gitweb_run () {
 . ./test-lib.sh
=20
 if ! test_have_prereq PERL; then
-	say 'skipping gitweb tests, perl not available'
+	skip_all=3D'skipping gitweb tests, perl not available'
 	test_done
 fi
=20
 perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 |=
| {
-    say 'skipping gitweb tests, perl version is too old'
+    skip_all=3D'skipping gitweb tests, perl version is too old'
     test_done
 }
=20
diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 4b3b793..648d161 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -9,7 +9,7 @@ export HOME
=20
 if ! type cvs >/dev/null 2>&1
 then
-	say 'skipping cvsimport tests, cvs not found'
+	skip_all=3D'skipping cvsimport tests, cvs not found'
 	test_done
 fi
=20
@@ -21,11 +21,11 @@ case "$cvsps_version" in
 2.1 | 2.2*)
 	;;
 '')
-	say 'skipping cvsimport tests, cvsps not found'
+	skip_all=3D'skipping cvsimport tests, cvsps not found'
 	test_done
 	;;
 *)
-	say 'skipping cvsimport tests, unsupported cvsps version'
+	skip_all=3D'skipping cvsimport tests, unsupported cvsps version'
 	test_done
 	;;
 esac
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 344785d..f62f617 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -21,7 +21,7 @@ PERL=3D${PERL:-perl}
 svn >/dev/null 2>&1
 if test $? -ne 1
 then
-    say 'skipping git svn tests, svn not found'
+    skip_all=3D'skipping git svn tests, svn not found'
     test_done
 fi
=20
@@ -40,13 +40,12 @@ x=3D$?
 if test $x -ne 0
 then
 	if test $x -eq 42; then
-		err=3D'Perl SVN libraries must be >=3D 1.1.0'
+		skip_all=3D'Perl SVN libraries must be >=3D 1.1.0'
 	elif test $x -eq 41; then
-		err=3D'svnadmin failed to create fsfs repository'
+		skip_all=3D'svnadmin failed to create fsfs repository'
 	else
-		err=3D'Perl SVN libraries not found or unusable, skipping test'
+		skip_all=3D'Perl SVN libraries not found or unusable'
 	fi
-	say "$err"
 	test_done
 fi
=20
@@ -159,7 +158,7 @@ EOF
 require_svnserve () {
     if test -z "$SVNSERVE_PORT"
     then
-        say 'skipping svnserve test. (set $SVNSERVE_PORT to enable)'
+        skip_all=3D'skipping svnserve test. (set $SVNSERVE_PORT to ena=
ble)'
         test_done
     fi
 }
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index a0944d6..71effc5 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -45,7 +45,7 @@ HTTPD_DOCUMENT_ROOT_PATH=3D$HTTPD_ROOT_PATH/www
=20
 if ! test -x "$LIB_HTTPD_PATH"
 then
-	say "skipping test, no web server found at '$LIB_HTTPD_PATH'"
+	skip_all=3D"skipping test, no web server found at '$LIB_HTTPD_PATH'"
 	test_done
 fi
=20
@@ -58,12 +58,12 @@ then
 	then
 		if ! test $HTTPD_VERSION -ge 2
 		then
-			say "skipping test, at least Apache version 2 is required"
+			skip_all=3D"skipping test, at least Apache version 2 is required"
 			test_done
 		fi
 		if ! test -d "$DEFAULT_HTTPD_MODULE_PATH"
 		then
-			say "Apache module directory not found.  Skipping tests."
+			skip_all=3D"Apache module directory not found.  Skipping tests."
 			test_done
 		fi
=20
@@ -118,7 +118,7 @@ start_httpd() {
 		>&3 2>&4
 	if test $? -ne 0
 	then
-		say "skipping test, web server setup failed"
+		skip_all=3D"skipping test, web server setup failed"
 		trap 'die' EXIT
 		test_done
 	fi
diff --git a/t/lib-patch-mode.sh b/t/lib-patch-mode.sh
index ce36f34..375e248 100644
--- a/t/lib-patch-mode.sh
+++ b/t/lib-patch-mode.sh
@@ -3,7 +3,7 @@
 . ./test-lib.sh
=20
 if ! test_have_prereq PERL; then
-	say 'skipping --patch tests, perl not available'
+	skip_all=3D'skipping --patch tests, perl not available'
 	test_done
 fi
=20
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 4ee7b65..637d8e9 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -15,7 +15,7 @@ if sys.hexversion < 0x02040000:
 then
 	:
 else
-	say 'skipping git remote-testgit tests: requires Python 2.4 or newer'
+	skip_all=3D'skipping git remote-testgit tests: requires Python 2.4 or=
 newer'
 	test_done
 fi
=20
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index fe60d69..26ddf9d 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -113,7 +113,7 @@ done
=20
 if ! echo 'echo space > "$1"' > "e space.sh"
 then
-	say "Skipping; FS does not support spaces in filenames"
+	skip_all=3D"Skipping; FS does not support spaces in filenames"
 	test_done
 fi
=20
--=20
1.7.0.4
