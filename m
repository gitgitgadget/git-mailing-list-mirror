From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 102/144] t9107-git-svn-migrate.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:47 -0700
Message-ID: <1395735989-3396-103-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMiy-0000Pe-T6
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbaCYI2b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:31 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:62911 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaCYI22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:28 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so131321pde.29
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NfAjohjTRtHAh0TlnAEdt95ZFHU1ftZnti3g461ZiJc=;
        b=K4ARxjTlzsg2E48Y7GlgxrUJZlbb7mwxtr8NunL9G+lRFSamn4205eeTes3k4RLsjT
         YNgVLTgBiyzVJQclyAiwgK5oRYOQkhCQqxgec4wlNuYk7WRbxVIcXNrED4dscIzs8NsS
         hlwq4PjLHCZ3ByxspUj/xd0FE6QGLUUz3ryQ1+7w6RBEmv9quTK3Dh3wvdH7WheNy7pe
         4ew4kYqE+lKgevcmA1XjFbxOsLZLTyILDBRqsCQXEgCzxAcUksJUkazDxOOFUV0QJYxu
         NR9jzkfOM8EyGrGkabQCQ3xFlTPGQlWQACUjvJB9iSzdAjC5ZTBXlHu06fy9WfJ8OwUA
         Rg9g==
X-Received: by 10.69.26.103 with SMTP id ix7mr77824536pbd.41.1395736108422;
        Tue, 25 Mar 2014 01:28:28 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244938>

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
 t/t9107-git-svn-migrate.sh |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index ee73013..8cb9c2b 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -24,10 +24,10 @@ test_expect_success 'setup old-looking metadata' '
 	git update-ref -d refs/${remotes_git_svn} refs/${remotes_git_svn}
 	'
=20
-head=3D`git rev-parse --verify refs/heads/git-svn-HEAD^0`
+head=3D$(git rev-parse --verify refs/heads/git-svn-HEAD^0)
 test_expect_success 'git-svn-HEAD is a real HEAD' "test -n '$head'"
=20
-svnrepo_escaped=3D`echo $svnrepo | sed 's/ /%20/'`
+svnrepo_escaped=3D$(echo $svnrepo | sed 's/ /%20/')
=20
 test_expect_success 'initialize old-style (v0) git svn layout' '
 	mkdir -p "$GIT_DIR"/git-svn/info "$GIT_DIR"/svn/info &&
@@ -38,7 +38,7 @@ test_expect_success 'initialize old-style (v0) git sv=
n layout' '
 	git rev-parse --verify refs/${remotes_git_svn}^0 &&
 	git rev-parse --verify refs/remotes/svn^0 &&
 	test "$(git config --get svn-remote.svn.url)" =3D "$svnrepo_escaped" =
&&
-	test `git config --get svn-remote.svn.fetch` =3D \
+	test $(git config --get svn-remote.svn.fetch) =3D \
              ":refs/${remotes_git_svn}"
 	'
=20
@@ -75,7 +75,7 @@ test_expect_success 'multi-fetch works on partial url=
s + paths' "
 	for i in trunk a b tags/0.1 tags/0.2 tags/0.3; do
 		git rev-parse --verify refs/remotes/\$i^0 >> refs.out || exit 1;
 	    done &&
-	test -z \"\`sort < refs.out | uniq -d\`\" &&
+	test -z \"\$(sort < refs.out | uniq -d\)\" &&
 	for i in trunk a b tags/0.1 tags/0.2 tags/0.3; do
 	  for j in trunk a b tags/0.1 tags/0.2 tags/0.3; do
 		if test \$j !=3D \$i; then continue; fi
@@ -87,16 +87,16 @@ test_expect_success 'migrate --minimize on old init=
ed layout' '
 	git config --unset-all svn-remote.svn.fetch &&
 	git config --unset-all svn-remote.svn.url &&
 	rm -rf "$GIT_DIR"/svn &&
-	for i in `cat fetch.out`; do
-		path=3D`expr $i : "\([^:]*\):.*$"`
-		ref=3D`expr $i : "[^:]*:\(refs/remotes/.*\)$"`
+	for i in $(cat fetch.out); do
+		path=3D$(expr $i : "\([^:]*\):.*$")
+		ref=3D$(expr $i : "[^:]*:\(refs/remotes/.*\)$")
 		if test -z "$ref"; then continue; fi
 		if test -n "$path"; then path=3D"/$path"; fi
 		( mkdir -p "$GIT_DIR"/svn/$ref/info/ &&
 		echo "$svnrepo"$path > "$GIT_DIR"/svn/$ref/info/url ) || exit 1;
 	done &&
 	git svn migrate --minimize &&
-	test -z "`git config -l | grep "^svn-remote\.git-svn\."`" &&
+	test -z "$(git config -l | grep "^svn-remote\.git-svn\.")" &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
 	grep "^trunk:refs/remotes/trunk$" fetch.out &&
 	grep "^branches/a:refs/remotes/a$" fetch.out &&
--=20
1.7.10.4
