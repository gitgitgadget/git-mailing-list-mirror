From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 104/144] t9109-git-svn-multi-glob.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:49 -0700
Message-ID: <1395735989-3396-105-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMiz-0000Pe-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbaCYI2f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:35 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40835 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbaCYI2a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:30 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so127135pab.24
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=t9+x7yY/uOu1auSrcJNLWXQz9aqKkBWqdhkHS0pupD8=;
        b=JF2W9h3cAL1AV9wWoRB4KvuAhGoQXjRolMBF4ZLIWsuD8inafi3/VZH+K2Sn8fwJi2
         vozyPZZ3xKhPMGHJkHJtQz0L8MD+zy1q9B8845IOsvSmMffrYKZkqgsp+DlwV/+S6GM7
         MnQWdSnvL0FsvZJfR1vKKX8qjy97Rlw2HKPVRyZChWJ9FQhf51AWrJSZj6O4nYXhLqGl
         Vx0vzCWF+5JM7+sszSMKUECaKlfUStWJi/44FE2BtgiKVi0X4gwnTgZSU+/aV7G9NzUV
         8UKC+FD9ph9cTeydR9xVVyX/xs5G5z8JyoY0rACIhuWTnpkUZ5YWtge+oI/LGCA4njM1
         qJog==
X-Received: by 10.68.136.133 with SMTP id qa5mr76817366pbb.63.1395736110419;
        Tue, 25 Mar 2014 01:28:30 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244939>

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
 t/t9109-git-svn-multi-glob.sh |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t9109-git-svn-multi-glob.sh b/t/t9109-git-svn-multi-glob=
=2Esh
index c318f9f..f36b749 100755
--- a/t/t9109-git-svn-multi-glob.sh
+++ b/t/t9109-git-svn-multi-glob.sh
@@ -50,10 +50,10 @@ test_expect_success 'test refspec globbing' '
 	git log --pretty=3Doneline refs/remotes/tags/end | \
 	    sed -e "s/^.\{41\}//" > output.end &&
 	test_cmp expect.end output.end &&
-	test "`git rev-parse refs/remotes/tags/end~1`" =3D \
-		"`git rev-parse refs/remotes/branches/v1/start`" &&
-	test "`git rev-parse refs/remotes/branches/v1/start~2`" =3D \
-		"`git rev-parse refs/remotes/trunk`" &&
+	test "$(git rev-parse refs/remotes/tags/end~1)" =3D \
+		"$(git rev-parse refs/remotes/branches/v1/start)" &&
+	test "$(git rev-parse refs/remotes/branches/v1/start~2)" =3D \
+		"$(git rev-parse refs/remotes/trunk)" &&
 	test_must_fail git rev-parse refs/remotes/tags/end@3
 	'
=20
@@ -75,12 +75,12 @@ test_expect_success 'test left-hand-side only globb=
ing' '
 		svn_cmd commit -m "try to try"
 	) &&
 	git svn fetch two &&
-	test `git rev-list refs/remotes/two/tags/end | wc -l` -eq 6 &&
-	test `git rev-list refs/remotes/two/branches/v1/start | wc -l` -eq 3 =
&&
-	test `git rev-parse refs/remotes/two/branches/v1/start~2` =3D \
-	     `git rev-parse refs/remotes/two/trunk` &&
-	test `git rev-parse refs/remotes/two/tags/end~3` =3D \
-	     `git rev-parse refs/remotes/two/branches/v1/start` &&
+	test $(git rev-list refs/remotes/two/tags/end | wc -l) -eq 6 &&
+	test $(git rev-list refs/remotes/two/branches/v1/start | wc -l) -eq 3=
 &&
+	test $(git rev-parse refs/remotes/two/branches/v1/start~2) =3D \
+	     $(git rev-parse refs/remotes/two/trunk) &&
+	test $(git rev-parse refs/remotes/two/tags/end~3) =3D \
+	     $(git rev-parse refs/remotes/two/branches/v1/start) &&
 	git log --pretty=3Doneline refs/remotes/two/tags/end | \
 	    sed -e "s/^.\{41\}//" > output.two &&
 	test_cmp expect.two output.two
@@ -124,12 +124,12 @@ test_expect_success 'test another branch' '
 	git config --add svn-remote.four.tags \
 	                 "tags/*:refs/remotes/four/tags/*" &&
 	git svn fetch four &&
-	test `git rev-list refs/remotes/four/tags/next | wc -l` -eq 5 &&
-	test `git rev-list refs/remotes/four/branches/v2/start | wc -l` -eq 3=
 &&
-	test `git rev-parse refs/remotes/four/branches/v2/start~2` =3D \
-	     `git rev-parse refs/remotes/four/trunk` &&
-	test `git rev-parse refs/remotes/four/tags/next~2` =3D \
-	     `git rev-parse refs/remotes/four/branches/v2/start` &&
+	test $(git rev-list refs/remotes/four/tags/next | wc -l) -eq 5 &&
+	test $(git rev-list refs/remotes/four/branches/v2/start | wc -l) -eq =
3 &&
+	test $(git rev-parse refs/remotes/four/branches/v2/start~2) =3D \
+	     $(git rev-parse refs/remotes/four/trunk) &&
+	test $(git rev-parse refs/remotes/four/tags/next~2) =3D \
+	     $(git rev-parse refs/remotes/four/branches/v2/start) &&
 	git log --pretty=3Doneline refs/remotes/four/tags/next | \
 	    sed -e "s/^.\{41\}//" > output.four &&
 	test_cmp expect.four output.four
--=20
1.7.10.4
