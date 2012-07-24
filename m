From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 3/7] i18n: Rewrite gettext messages start with dash
Date: Tue, 24 Jul 2012 14:59:31 +0800
Message-ID: <441f0613d796c35b6865a1258f074d1ea91e605c.1343112786.git.worldhello.net@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <6fbf2661d428ca4c4227b418368716d903dfd3e3.1343112786.git.worldhello.net@gmail.com>
 <b263c2bcc5dd6d611a1e3a4f6a87042d4cdb50aa.1343112786.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 09:00:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StZ6a-0001nG-71
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 09:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab2GXHAR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jul 2012 03:00:17 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59967 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab2GXHAP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 03:00:15 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so12207178pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=iLwOAB4iHwVZMyhXkU/uSm56TQV4eW0T5L7i2xQBjhM=;
        b=JtkkbcsLANgdtjqTOfk/03HNYKkIhRCjjFJT7WmnQWLinUkGAwti/7VDraa6axwGmM
         +uQhJ5zgxz0mR3V37sRXEiu2UxQynmL5Bgq+RHWznZvkAUuZV/7AxRhDR3M+LVjEoj0n
         HZel30as3yzjchn+0JBI46DGsZ0hfaoI6uJueycUi3pcZPYCXwUw/Tvhwm2s3FT5YwVR
         rhxKOrtLhUnzYgfA4gQ37M26LpB0o+3PtI5+diwqxhLO8aIS8LvYeETQgCPIidPfnzOQ
         lS7mnWQyv8qz8taBS7ZpC/5j07TwUvscwwIS1O6Yg/agWFEGfjBc0WEeDuzzIxVbyf1e
         EPfg==
Received: by 10.68.130.163 with SMTP id of3mr42993122pbb.108.1343113214958;
        Tue, 24 Jul 2012 00:00:14 -0700 (PDT)
Received: from jx.bj.ossxp.com.bj.ossxp.com ([123.116.228.123])
        by mx.google.com with ESMTPS id tj4sm11577579pbc.33.2012.07.24.00.00.08
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 00:00:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.17.gcb766d3
In-Reply-To: <b263c2bcc5dd6d611a1e3a4f6a87042d4cdb50aa.1343112786.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343112786.git.worldhello.net@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202014>

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
index f07269..09a3 100755
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
1.7.12.rc0.17.gcb766d3
