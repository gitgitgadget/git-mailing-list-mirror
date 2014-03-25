From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 002/144] git-am.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:07 -0700
Message-ID: <1395735989-3396-3-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:39:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMtQ-0004q9-7O
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbaCYIj0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:39:26 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:40351 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610AbaCYI0i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:38 -0400
Received: by mail-pa0-f42.google.com with SMTP id fb1so129166pad.15
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zXiENsizmOR2o6EQPfNRYJwncMMWfrTeGlDT+uctwO0=;
        b=gN8e3MC2ednUSJjVBe8h5jAWYEur9aKF6N8oXTfi9c8o30gZXZEOAfLBtr6iz7dIZm
         /jMg+qKXOMYm4uCu+3l4UUsO9ej9Z5/Tb4byd3R83iH6A9e6PLv032iNDPl9wkBhMPAh
         vhb9l1f+/CIKVnB1yXvJ5bh5KzGhVqTq2+NQDnLGOUpjouYqZgf+urZaoRGeN06J+CdY
         dBdi7wfz4LSyWGhgzTy5MPwnoRZOVaStANa3FUvvBtOlGxe1bJ3B5HT8YNzSdtZE5fHX
         gYsVtd7Ukevy+suebckSptLFrJYOMNNj8dcW9NjDCGs02cUTUQOntJTWGslZBZhFFeuV
         xf2w==
X-Received: by 10.66.227.193 with SMTP id sc1mr76380494pac.102.1395735998055;
        Tue, 25 Mar 2014 01:26:38 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245015>

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
 git-am.sh |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 78517f2..1b638e8 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -125,7 +125,7 @@ cannot_fallback () {
 }
=20
 fall_back_3way () {
-    O_OBJECT=3D`cd "$GIT_OBJECT_DIRECTORY" && pwd`
+    O_OBJECT=3D$(cd "$GIT_OBJECT_DIRECTORY" && pwd)
=20
     rm -fr "$dotest"/patch-merge-*
     mkdir "$dotest/patch-merge-tmp-dir"
@@ -275,7 +275,7 @@ split_patches () {
 		then
 			clean_abort "$(gettext "Only one StGIT patch series can be applied =
at once")"
 		fi
-		series_dir=3D`dirname "$1"`
+		series_dir=3D$(dirname "$1")
 		series_file=3D"$1"
 		shift
 		{
@@ -298,8 +298,8 @@ split_patches () {
 		this=3D0
 		for stgit in "$@"
 		do
-			this=3D`expr "$this" + 1`
-			msgnum=3D`printf "%0${prec}d" $this`
+			this=3D$(expr "$this" + 1)
+			msgnum=3D$(printf "%0${prec}d" $this)
 			# Perl version of StGIT parse_patch. The first nonemptyline
 			# not starting with Author, From or Date is the
 			# subject, and the body starts with the next nonempty
@@ -644,26 +644,26 @@ fi
 git_apply_opt=3D$(cat "$dotest/apply-opt")
 if test "$(cat "$dotest/sign")" =3D t
 then
-	SIGNOFF=3D`git var GIT_COMMITTER_IDENT | sed -e '
+	SIGNOFF=3D$(git var GIT_COMMITTER_IDENT | sed -e '
 			s/>.*/>/
 			s/^/Signed-off-by: /'
-		`
+		)
 else
 	SIGNOFF=3D
 fi
=20
-last=3D`cat "$dotest/last"`
-this=3D`cat "$dotest/next"`
+last=3D$(cat "$dotest/last")
+this=3D$(cat "$dotest/next")
 if test "$skip" =3D t
 then
-	this=3D`expr "$this" + 1`
+	this=3D$(expr "$this" + 1)
 	resume=3D
 fi
=20
 while test "$this" -le "$last"
 do
-	msgnum=3D`printf "%0${prec}d" $this`
-	next=3D`expr "$this" + 1`
+	msgnum=3D$(printf "%0${prec}d" $this)
+	next=3D$(expr "$this" + 1)
 	test -f "$dotest/$msgnum" || {
 		resume=3D
 		go_next
@@ -739,16 +739,16 @@ To restore the original branch and stop patching =
run \"\$cmdline --abort\"."
 	'')
 	    if test '' !=3D "$SIGNOFF"
 	    then
-		LAST_SIGNED_OFF_BY=3D`
+		LAST_SIGNED_OFF_BY=3D$(
 		    sed -ne '/^Signed-off-by: /p' \
 		    "$dotest/msg-clean" |
 		    sed -ne '$p'
-		`
-		ADD_SIGNOFF=3D`
+		)
+		ADD_SIGNOFF=3D$(
 		    test "$LAST_SIGNED_OFF_BY" =3D "$SIGNOFF" || {
 		    test '' =3D "$LAST_SIGNED_OFF_BY" && echo
 		    echo "$SIGNOFF"
-		}`
+		})
 	    else
 		ADD_SIGNOFF=3D
 	    fi
--=20
1.7.10.4
