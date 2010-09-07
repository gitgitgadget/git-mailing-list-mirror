From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 15/20] gettextize: git-am die messages
Date: Tue,  7 Sep 2010 16:48:29 +0000
Message-ID: <1283878113-19533-6-git-send-email-avarab@gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:51:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1OB-0004K7-E1
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255Ab0IGQtv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:49:51 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47509 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081Ab0IGQtu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:49:50 -0400
Received: by wwj40 with SMTP id 40so8416288wwj.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=g52UFV5TvvuoDLbozBnD1kkyCAYidRHWU14omNaxLBU=;
        b=ZQ4q98x04biw18ttVZ/6aJUi7NkMMv/ZYHkSvHyV+vdPbX/fWpckp+Tdlc514YVE3Z
         aH7A5BaiYTZxCtyWILbxxUfLlq9slGcdfa7GOU/qtEN6O0QYugm9djjnFx80pRJIidcn
         wn89Dp9+UhtRSqbO3E8qFQtjxXbyayNgztLa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FNDzWBG3MCZ/XXIu4QvnVf16EJGbSkSy4PzYfvR2j/ZGcjtrByrf+mIbdQGS2geszs
         a5kQOgbaay6MEOpbAfyTAKjdiB9C4FSaxINOFMXLpEF0PlzJ9vp9h0SesFkhClByzC8I
         ejk0roO3vZXCmRKsnB9uwD/TyT08/M7O1sAME=
Received: by 10.216.155.206 with SMTP id j56mr1805338wek.67.1283878189026;
        Tue, 07 Sep 2010 09:49:49 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k46sm4304936weq.34.2010.09.07.09.49.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:49:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155724>

The die messages in git-am need to use:

    die "$(gettext "string")"

Since gettext(1) emits the message instead of returning it like the C
equivalent, and our die() function in git-sh-setup needs to get a
string as an argument.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 98819e6..4bee325 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -44,7 +44,7 @@ require_work_tree
 cd_to_toplevel
=20
 git var GIT_COMMITTER_IDENT >/dev/null ||
-	die "You need to set your committer info first"
+	die "$(gettext "You need to set your committer info first")"
=20
 if git rev-parse --verify -q HEAD >/dev/null
 then
@@ -337,7 +337,7 @@ do
 	--rebasing)
 		rebasing=3Dt threeway=3Dt keep=3Dt scissors=3Df no_inbody_headers=3D=
t ;;
 	-d|--dotest)
-		die "-d option is no longer supported.  Do not use."
+		die "$(gettext "-d option is no longer supported.  Do not use.")"
 		;;
 	--resolvemsg)
 		shift; resolvemsg=3D$1 ;;
@@ -400,12 +400,12 @@ then
 		false
 		;;
 	esac ||
-	die "previous rebase directory $dotest still exists but mbox given."
+	die "$(eval_gettext "previous rebase directory \$dotest still exists =
but mbox given.")"
 	resume=3Dyes
=20
 	case "$skip,$abort" in
 	t,t)
-		die "Please make up your mind. --skip or --abort?"
+		die "$(gettext "Please make up your mind. --skip or --abort?")"
 		;;
 	t,)
 		git rerere clear
@@ -431,7 +431,7 @@ then
 else
 	# Make sure we are not given --skip, --resolved, nor --abort
 	test "$skip$resolved$abort" =3D "" ||
-		die "Resolve operation not in progress, we are not resuming."
+		die "$(gettext "Resolve operation not in progress, we are not resumi=
ng.")"
=20
 	# Start afresh.
 	mkdir -p "$dotest" || exit
@@ -496,7 +496,7 @@ case "$resolved" in
 	if test "$files"
 	then
 		test -n "$HAS_HEAD" && : >"$dotest/dirtyindex"
-		die "Dirty index: cannot apply patches (dirty: $files)"
+		die "$(eval_gettext "Dirty index: cannot apply patches (dirty: \$fil=
es)")"
 	fi
 esac
=20
@@ -676,7 +676,7 @@ To restore the original branch and stop patching ru=
n \"\$cmdline --abort\"."; ec
 	if test "$interactive" =3D t
 	then
 	    test -t 0 ||
-	    die "cannot be interactive without stdin connected to a terminal.=
"
+	    die "$(gettext "cannot be interactive without stdin connected to =
a terminal.")"
 	    action=3Dagain
 	    while test "$action" =3D again
 	    do
--=20
1.7.2.3.313.gcd15
