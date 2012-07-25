From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 3/7] i18n: Rewrite gettext messages start with dash
Date: Wed, 25 Jul 2012 11:53:44 +0800
Message-ID: <79fe36e1c66cec02eb54c48390d59bb1714c4736.1343188013.git.worldhello.net@gmail.com>
References: <cover.1343188013.git.worldhello.net@gmail.com>
 <b4afad7f9c0b8ae32c04f8aa55a21c72b4ae5013.1343188013.git.worldhello.net@gmail.com>
 <915b2821410c2348817a469e7be05be497cf1d06.1343188013.git.worldhello.net@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Jul 25 05:54:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StsgF-00007r-CH
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793Ab2GYDyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jul 2012 23:54:31 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52643 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932763Ab2GYDy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:54:29 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so705020pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=18U/Em8hEumVQQQ5Q5ocaCTefJQ3zepZEEEh1VAg/1o=;
        b=N0k+5F+sTqFfXY5Fa8almrkMCFlCTsnWazGoOMFYbDor75kz2exny0duScn0YU9tsD
         uWYrH1kq0Frkdbghk3BrE9Dd1806J+PZxXltY+3OmKSKLq7etGdD0ULEqRQ/D5TnqVNz
         QdaYbCb8hhSbtfQD6M4pB1IyMsx/IhA/32UwqinR4ZU1jcuuRSbjXU0F6RdSiTdnvPRz
         91l/XiPtyBGrtEI0209ESAKp26+Yyo+f5dTMr6y7UjGKZnR+C6b5QcGWIkvW2XNpQmRq
         w7dyMbirCARUYnj01g4ROHDHTEsw7l+lIXuAaOI/qD7a3Idg1UI/tq+1z8/RBDkoz13X
         NFmA==
Received: by 10.68.221.10 with SMTP id qa10mr49724493pbc.154.1343188468765;
        Tue, 24 Jul 2012 20:54:28 -0700 (PDT)
Received: from localhost.localdomain (li380-141.members.linode.com. [106.187.37.141])
        by mx.google.com with ESMTPS id rg10sm13463345pbc.54.2012.07.24.20.54.24
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 20:54:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <915b2821410c2348817a469e7be05be497cf1d06.1343188013.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343188013.git.worldhello.net@gmail.com>
References: <cover.1343188013.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202112>

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
