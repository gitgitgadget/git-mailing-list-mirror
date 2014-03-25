From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 009/144] t0001-init.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:14 -0700
Message-ID: <1395735989-3396-10-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:27:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMhL-0006r1-5n
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbaCYI0w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:26:52 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33512 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbaCYI0u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:50 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so128735pad.16
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=D3nehsf8JsXVuFItIdSMiU6GbsiLgZ5fNIRfv6IlhKk=;
        b=Lk3PbMcb9n6Sd3AiN9g32hyjDor28tHx0ApkPR9DrD1gHdOYLPKCMvx04c03PkSTcE
         lQaE8e+WFvdELN3IvUYBB6I2/F0bkumMGKbC5SDo4njiQfhZbP7MdJqbHcJ7MdvS3iyr
         B2awrJMeQCMBoqUjw6IQNznZZWuf7R6hReQvP+TAgx/+FEQZrmS0rUOaQt/dbC//rym6
         4bBP005aVVBv/XJOLUWlwQ5klNcdIX7VPsU5c5FiKQ88Al5MB1LJQyKbY+YYP3YBI1LL
         Yp3G1FCab+Hv2EUGpb9ekBIpy0sgelBb8Dz45/3wEtysZtEr+PuE857m9Npt3bn5j81l
         En0g==
X-Received: by 10.68.90.132 with SMTP id bw4mr14305163pbb.136.1395736009592;
        Tue, 25 Mar 2014 01:26:49 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244913>

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
 t/t0001-init.sh |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 9fb582b..32821fe 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -250,7 +250,7 @@ test_expect_success 'init --bare/--shared overrides=
 system/global config' '
 	) &&
 	check_config init-bare-shared-override true unset &&
 	test x0666 =3D \
-	x`git config -f init-bare-shared-override/config core.sharedRepositor=
y`
+	x$(git config -f init-bare-shared-override/config core.sharedReposito=
ry)
 '
=20
 test_expect_success 'init honors global core.sharedRepository' '
@@ -262,7 +262,7 @@ test_expect_success 'init honors global core.shared=
Repository' '
 		git init
 	) &&
 	test x0666 =3D \
-	x`git config -f shared-honor-global/.git/config core.sharedRepository=
`
+	x$(git config -f shared-honor-global/.git/config core.sharedRepositor=
y)
 '
=20
 test_expect_success 'init rejects insanely long --template' '
@@ -374,7 +374,7 @@ test_expect_success 'init prefers command line to G=
IT_DIR' '
 test_expect_success 'init with separate gitdir' '
 	rm -rf newdir &&
 	git init --separate-git-dir realgitdir newdir &&
-	echo "gitdir: `pwd`/realgitdir" >expected &&
+	echo "gitdir: $(pwd)/realgitdir" >expected &&
 	test_cmp expected newdir/.git &&
 	test -d realgitdir/refs
 '
@@ -388,7 +388,7 @@ test_expect_success 're-init to update git link' '
 	cd newdir &&
 	git init --separate-git-dir ../surrealgitdir
 	) &&
-	echo "gitdir: `pwd`/surrealgitdir" >expected &&
+	echo "gitdir: $(pwd)/surrealgitdir" >expected &&
 	test_cmp expected newdir/.git &&
 	test -d surrealgitdir/refs &&
 	! test -d realgitdir/refs
@@ -401,7 +401,7 @@ test_expect_success 're-init to move gitdir' '
 	cd newdir &&
 	git init --separate-git-dir ../realgitdir
 	) &&
-	echo "gitdir: `pwd`/realgitdir" >expected &&
+	echo "gitdir: $(pwd)/realgitdir" >expected &&
 	test_cmp expected newdir/.git &&
 	test -d realgitdir/refs
 '
@@ -415,7 +415,7 @@ test_expect_success SYMLINKS 're-init to move gitdi=
r symlink' '
 	ln -s here .git &&
 	git init --separate-git-dir ../realgitdir
 	) &&
-	echo "gitdir: `pwd`/realgitdir" >expected &&
+	echo "gitdir: $(pwd)/realgitdir" >expected &&
 	test_cmp expected newdir/.git &&
 	test -d realgitdir/refs &&
 	! test -d newdir/here
--=20
1.7.10.4
