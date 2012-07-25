From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 3/7] i18n: Rewrite gettext messages start with dash
Date: Wed, 25 Jul 2012 16:34:08 +0800
Message-ID: <1ddee15de2edd59f870023ea25cefb5846daeba4.1343205009.git.worldhello.net@gmail.com>
References: <cover.1343205009.git.worldhello.net@gmail.com>
 <b4afad7f9c0b8ae32c04f8aa55a21c72b4ae5013.1343205009.git.worldhello.net@gmail.com>
 <a8429a6fed3eb0d83d92f798ebf8241a0eeb49c1.1343205009.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 10:35:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stx3s-0002ew-TL
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 10:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830Ab2GYIfG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jul 2012 04:35:06 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40839 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932802Ab2GYIfB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 04:35:01 -0400
Received: by pbbrp8 with SMTP id rp8so1062095pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 01:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=18U/Em8hEumVQQQ5Q5ocaCTefJQ3zepZEEEh1VAg/1o=;
        b=yDqsOYDmRF3IUoapesXMHHDjsTNj6hlnLFkPiMJzZ+sa69vEEk5DYUhjZepTIuQQJc
         zzE8GJ3OzYKnmKbkrMcigSIXFiSHAGMw3dYQllDb9eT+jRWZjezlOwIqcoj0jZknNX9C
         ndlC9dwOBy1se4SIl28SqBUOdTnY+68oocFQGRYue2iJg/9kcwKZI79LS/a4srkI/++9
         Fl43mppaHZMuSZE/BE/qDz2s6GJywZZFpHEYsCAEVEWyoYJmeKP6bIQzao5mvUh/+F6d
         TIRXWbyLzf8C6d1TWNkbuSFa+Vv4nxu6Hl287zRruZXktot9iO8ES9i9MuoSQIFUWM+2
         3/8w==
Received: by 10.68.203.7 with SMTP id km7mr51480463pbc.7.1343205301189;
        Wed, 25 Jul 2012 01:35:01 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id px1sm1313386pbb.49.2012.07.25.01.34.53
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 01:35:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <a8429a6fed3eb0d83d92f798ebf8241a0eeb49c1.1343205009.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343205009.git.worldhello.net@gmail.com>
References: <cover.1343205009.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202139>

Gettext message in a shell script should not start with '-', one
workaround is adding '--' between gettext and the message, like:

    gettext -- "--exec option ..."

But due to a bug in the xgettext extraction, xgettext can not
extract the actual message for this case. Rewriting the message
is a simpler and better solution.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Reported-by: Vincent van Ravesteijn <vfr@lyx.org>
Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 git-rebase.sh                 | 2 +-
 git-submodule.sh              | 2 +-
 t/t3404-rebase-interactive.sh | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 8710d..705bd 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -317,7 +317,7 @@ test $# -gt 2 && usage
 if test -n "$cmd" &&
    test "$interactive_rebase" !=3D explicit
 then
-	die "$(gettext -- "--exec option must be used with --interactive opti=
on")"
+	die "$(gettext "The --exec option must be used with the --interactive=
 option")"
 fi
=20
 if test -n "$action"
diff --git a/git-submodule.sh b/git-submodule.sh
index dba4d..5b019 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -748,7 +748,7 @@ cmd_summary() {
 	if [ -n "$files" ]
 	then
 		test -n "$cached" &&
-		die "$(gettext -- "--cached cannot be used with --files")"
+		die "$(gettext "The --cached option cannot be used with the --files =
option")"
 		diff_cmd=3Ddiff-files
 		head=3D
 	fi
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 8078..f206a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -858,7 +858,7 @@ test_expect_success 'rebase -ix with --autosquash' =
'
 test_expect_success 'rebase --exec without -i shows error message' '
 	git reset --hard execute &&
 	test_must_fail git rebase --exec "git show HEAD" HEAD~2 2>actual &&
-	echo "--exec option must be used with --interactive option" >expected=
 &&
+	echo "The --exec option must be used with the --interactive option" >=
expected &&
 	test_i18ncmp expected actual
 '
=20
--=20
1.7.12.rc0.16.gf4916ac
