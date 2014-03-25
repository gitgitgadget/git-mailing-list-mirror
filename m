From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 100/144] t9104-git-svn-follow-parent.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:45 -0700
Message-ID: <1395735989-3396-101-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:29:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMjE-0000iP-8N
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbaCYI2x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:53 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:40228 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbaCYI20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:26 -0400
Received: by mail-pa0-f52.google.com with SMTP id rd3so125985pab.39
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JuuXmoIanmHMJuEYhIqVzZsoN7K0bZN3ZcPJqmuOi5o=;
        b=b7L2i09lXiRkQxgvBVAY3XOBAanhQ+mSSZo86KvOyUTzXet+xMuYW0uztL1Uqc1Lz2
         kTzH9GllIcCCxK0hlyc/zKJCuTjeg5ttoADkGWZQ+YeMTC4uFBm6QUdHQS0gAXM9Fo7+
         aInMu6KJVdVstKtlsXl8QTMvvi4Y3gRwQiOcbz4x2f0JluLkaVPTRoj6ubuw2+DeQOv+
         cFPIbPTKkbxzWp6UQ5A7jTrguzgW4cyoFhB3G3ZopAUSaSQiCwqtD8vI/ZycT7aJsNZH
         nN5QjEQ+4845h5F3rOn1tRzsjRM89U0JOhGmX4o005KzFGXVk5fJmQacJW3Sh9Epm/g1
         WGjg==
X-Received: by 10.68.194.65 with SMTP id hu1mr8998536pbc.158.1395736106002;
        Tue, 25 Mar 2014 01:28:26 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244942>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t9104-git-svn-follow-parent.sh |   48 +++++++++++++++++++-----------=
--------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-=
parent.sh
index 13b179e..101f545 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -31,8 +31,8 @@ test_expect_success 'initialize repo' '
 test_expect_success 'init and fetch a moved directory' '
 	git svn init --minimize-url -i thunk "$svnrepo"/thunk &&
 	git svn fetch -i thunk &&
-	test "`git rev-parse --verify refs/remotes/thunk@2`" \
-           =3D "`git rev-parse --verify refs/remotes/thunk~1`" &&
+	test "$(git rev-parse --verify refs/remotes/thunk@2)" \
+           =3D "$(git rev-parse --verify refs/remotes/thunk~1)" &&
         test "`git cat-file blob refs/remotes/thunk:readme |\
                  sed -n -e "3p"`" =3D goodbye &&
 	test -z "`git config --get svn-remote.svn.fetch \
@@ -46,8 +46,8 @@ test_expect_success 'init and fetch from one svn-remo=
te' '
         git config --add svn-remote.svn.fetch \
           thunk:refs/remotes/svn/thunk &&
         git svn fetch -i svn/thunk &&
-	test "`git rev-parse --verify refs/remotes/svn/trunk`" \
-           =3D "`git rev-parse --verify refs/remotes/svn/thunk~1`" &&
+	test "$(git rev-parse --verify refs/remotes/svn/trunk)" \
+           =3D "$(git rev-parse --verify refs/remotes/svn/thunk~1)" &&
         test "`git cat-file blob refs/remotes/svn/thunk:readme |\
                  sed -n -e "3p"`" =3D goodbye
         '
@@ -61,9 +61,9 @@ test_expect_success 'follow deleted parent' '
           junk:refs/remotes/svn/junk &&
         git svn fetch -i svn/thunk &&
         git svn fetch -i svn/junk &&
-        test -z "`git diff svn/junk svn/trunk`" &&
-        test "`git merge-base svn/junk svn/trunk`" \
-           =3D "`git rev-parse svn/trunk`"
+        test -z "$(git diff svn/junk svn/trunk)" &&
+        test "$(git merge-base svn/junk svn/trunk)" \
+           =3D "$(git rev-parse svn/trunk)"
         '
=20
 test_expect_success 'follow larger parent' '
@@ -80,7 +80,7 @@ test_expect_success 'follow larger parent' '
         test "`git merge-base \
                  refs/remotes/larger-parent/trunk/thunk/bump/thud \
                  refs/remotes/larger`" =3D \
-             "`git rev-parse refs/remotes/larger`"
+             "$(git rev-parse refs/remotes/larger)"
         true
         '
=20
@@ -104,8 +104,8 @@ test_expect_success 'follow deleted directory' '
 	svn_cmd rm -m "remove glob" "$svnrepo"/glob &&
 	git svn init --minimize-url -i glob "$svnrepo"/glob &&
 	git svn fetch -i glob &&
-	test "`git cat-file blob refs/remotes/glob:blob/bye`" =3D hi &&
-	test "`git ls-tree refs/remotes/glob | wc -l `" -eq 1
+	test "$(git cat-file blob refs/remotes/glob:blob/bye)" =3D hi &&
+	test "$(git ls-tree refs/remotes/glob | wc -l )" -eq 1
 	'
=20
 # ref: r9270 of the Subversion repository: (http://svn.collab.net/repo=
s/svn)
@@ -140,9 +140,9 @@ test_expect_success 'follow-parent avoids deleting =
relevant info' '
 	git svn init --minimize-url -i r9270-t \
 	  "$svnrepo"/r9270/trunk/subversion/bindings/swig/perl/native/t &&
 	git svn fetch -i r9270-t &&
-	test `git rev-list r9270-t | wc -l` -eq 2 &&
-	test "`git ls-tree --name-only r9270-t~1`" =3D \
-	     "`git ls-tree --name-only r9270-t`"
+	test $(git rev-list r9270-t | wc -l) -eq 2 &&
+	test "$(git ls-tree --name-only r9270-t~1)" =3D \
+	     "$(git ls-tree --name-only r9270-t)"
 	'
=20
 test_expect_success "track initial change if it was only made to paren=
t" '
@@ -150,11 +150,11 @@ test_expect_success "track initial change if it w=
as only made to parent" '
 	git svn init --minimize-url -i r9270-d \
 	  "$svnrepo"/r9270/drunk/subversion/bindings/swig/perl/native/t &&
 	git svn fetch -i r9270-d &&
-	test `git rev-list r9270-d | wc -l` -eq 3 &&
-	test "`git ls-tree --name-only r9270-t`" =3D \
-	     "`git ls-tree --name-only r9270-d`" &&
-	test "`git rev-parse r9270-t`" =3D \
-	     "`git rev-parse r9270-d~1`"
+	test $(git rev-list r9270-d | wc -l) -eq 3 &&
+	test "$(git ls-tree --name-only r9270-t)" =3D \
+	     "$(git ls-tree --name-only r9270-d)" &&
+	test "$(git rev-parse r9270-t)" =3D \
+	     "$(git rev-parse r9270-d~1)"
 	'
=20
 test_expect_success "follow-parent is atomic" '
@@ -191,12 +191,12 @@ test_expect_success "follow-parent is atomic" '
 	git svn fetch -i stunk &&
 	git svn init --minimize-url -i flunked "$svnrepo"/flunked &&
 	git svn fetch -i flunked &&
-	test "`git rev-parse --verify refs/remotes/flunk@18`" \
-	   =3D "`git rev-parse --verify refs/remotes/stunk`" &&
-	test "`git rev-parse --verify refs/remotes/flunk~1`" \
-	   =3D "`git rev-parse --verify refs/remotes/stunk`" &&
-	test "`git rev-parse --verify refs/remotes/flunked~1`" \
-	   =3D "`git rev-parse --verify refs/remotes/stunk~1`"
+	test "$(git rev-parse --verify refs/remotes/flunk@18)" \
+	   =3D "$(git rev-parse --verify refs/remotes/stunk)" &&
+	test "$(git rev-parse --verify refs/remotes/flunk~1)" \
+	   =3D "$(git rev-parse --verify refs/remotes/stunk)" &&
+	test "$(git rev-parse --verify refs/remotes/flunked~1)" \
+	   =3D "$(git rev-parse --verify refs/remotes/stunk~1)"
 	'
=20
 test_expect_success "track multi-parent paths" '
--=20
1.7.10.4
