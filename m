From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] rebase: accept -<number> as another way of saying HEAD~<number>
Date: Sun,  2 Mar 2014 09:53:13 +0700
Message-ID: <1393728794-29566-3-git-send-email-pclouds@gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
 <1393728794-29566-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, philipoakley@iee.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 03:54:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJwXR-0000Om-Is
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 03:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbaCBCx4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 21:53:56 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45555 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbaCBCxj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 21:53:39 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so2286166pab.5
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 18:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6DwBmoryOBT2snxwCyJxXqjFMas6RCfvZymOI9V4Zrg=;
        b=aUFgMbhHEjQZ2X1lieqwFrkws5XlGNJJFOivC/ZVhk5kGtdML9F2A+N/pmNeqt1r2p
         VH6fqwm5ccq2Zh1Mc4GnZjMkIKfui1gkLlvPbicKOOnLbRjdyWM9jR0grGEDNl05IiAD
         9gepavjQTld7F3t1M8XYvk22fFp5hwtC66rD9r8Ect2LcutvgajvtMc4TgKWuhx7Zb4Z
         ljgiUn604kV20jReB1njop8v1jyiuSsDXPv3TMdMic/I20lVUncyPGUa89u9sYxstZL2
         +XmByPSDFtpoAmy+buk0QPOkiUv8bjVzy9sgPDIfkiX2qgmZovptqD66NAIP3u6b68T5
         75rg==
X-Received: by 10.68.254.103 with SMTP id ah7mr91617pbd.159.1393728819130;
        Sat, 01 Mar 2014 18:53:39 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id hc4sm21014151pbc.29.2014.03.01.18.53.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 18:53:38 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 02 Mar 2014 09:54:04 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393728794-29566-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243122>

This is "rev-list style", where people can do "git rev-list -3" in
addition to "git rev-list HEAD~3". A lot of commands are driven by the
revision machinery and also accept this form. This addition to rebase
is just for convenience.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-rebase.txt | 3 +++
 git-rebase.sh                | 9 +++++++++
 t/t3400-rebase.sh            | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 2a93c64..52c3561 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -223,6 +223,9 @@ As a special case, you may use "A\...B" as a shortc=
ut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
=20
+-<number>::
+	Specify <upstream> as "HEAD~<number>".
+
 <upstream>::
 	Upstream branch to compare against.  May be any valid commit,
 	not just an existing branch name. Defaults to the configured
diff --git a/git-rebase.sh b/git-rebase.sh
index 5f6732b..33face1 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -43,6 +43,7 @@ continue!          continue
 abort!             abort and check out the original branch
 skip!              skip current patch and continue
 edit-todo!         edit the todo list during an interactive rebase
+-NUM               equivalent of HEAD~<NUM>
 "
 . git-sh-setup
 . git-sh-i18n
@@ -335,6 +336,9 @@ do
 	--gpg-sign=3D*)
 		gpg_sign_opt=3D"-S${1#--gpg-sign=3D}"
 		;;
+	-NUM=3D*)
+		NUM=3D"${1#-NUM=3D}"
+		;;
 	--)
 		shift
 		break
@@ -342,6 +346,11 @@ do
 	esac
 	shift
 done
+if [ -n "$NUM" ]
+then
+	test $# -gt 0 && usage
+	set -- "$@" "HEAD~$NUM"
+fi
 test $# -gt 2 && usage
=20
 if test -n "$cmd" &&
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 6d94b1f..11db7ea 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -215,4 +215,10 @@ test_expect_success 'rebase commit with an ancient=
 timestamp' '
 	grep "author .* 34567 +0600$" actual
 '
=20
+test_expect_success 'rebase -<number>' '
+	git reset --hard &&
+	test_must_fail git rebase -2 HEAD^^ &&
+	git rebase -2
+'
+
 test_done
--=20
1.9.0.40.gaa8c3ea
