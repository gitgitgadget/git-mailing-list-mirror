From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/7] t0001: test git init when run via an alias
Date: Thu, 11 Nov 2010 21:20:46 +0700
Message-ID: <1289485248-8966-6-git-send-email-pclouds@gmail.com>
References: <1289485248-8966-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 15:23:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGY4D-0000uP-Sv
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 15:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774Ab0KKOXx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 09:23:53 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34012 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587Ab0KKOXv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 09:23:51 -0500
Received: by pwi9 with SMTP id 9so185853pwi.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 06:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=o29CSxeGxIDj0X9r1yQVC9n4c/UYlyTDSPRsHKNVbWg=;
        b=qBbhCKtyP3xwCq4cVVMpvKNGKE5Rd/ybX4iOdaYUgztZ0kH7fdH3JFjXB7MkwG8pm7
         uQJPwn9umqrSnKIp4/TAOg5ZVZ7kPOMPZ/85V9h+lALkbjmRXYTDIKquzyIGsf//rfKv
         yi6lWHE/qwL7+PyCxyx9RXLiqqeVl97F3NYwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XVdjKxsBRPRoAbZ5WES+FOG+cb7x8h7eNq5RdKx3kBRD4X16wub+ixSiPB2JmeWa/+
         stON+BtoZSAjrr6vVAoQZ4frZOw9Q95bIGEfrDTghxh4M58eKyML6Iew2A3xWe1ffwl0
         8eNV3+gR3MgBJCQ/Bt2DUCP4FBLOT38VihsUE=
Received: by 10.142.50.20 with SMTP id x20mr592510wfx.221.1289485431516;
        Thu, 11 Nov 2010 06:23:51 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id v19sm2429010wfh.0.2010.11.11.06.23.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 06:23:50 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Nov 2010 21:22:28 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289485248-8966-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161259>

=46rom: Jonathan Nieder <jrnieder@gmail.com>

Add some tests to document the correct behavior of (possibly aliased)
init when run within and outside a git directory.

If I set up a simple git alias =E2=80=9Cquietinit =3D init --quiet=E2=80=
=9D, usually it
will work just like =E2=80=98git init --quiet=E2=80=99.

There are some differences, unfortunately, since in the process of
checking for aliases, git has to look for a .git/config file.  If =E2=80=
=98git
quietinit=E2=80=99 is run from a subdirectory of an existing git reposi=
tory,
that repository=E2=80=99s configuration will affect the configuration o=
f the
new repository.  In particular, the new repository can inherit
bogus values for core.bare and core.worktree.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t0001-init.sh |   56 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 7fe8883..28c1858 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -33,6 +33,62 @@ test_expect_success 'plain' '
 	check_config plain/.git false unset
 '
=20
+test_expect_success 'plain nested in bare' '
+	(
+		unset GIT_DIR GIT_WORK_TREE &&
+		git init --bare bare-ancestor.git &&
+		cd bare-ancestor.git &&
+		mkdir plain-nested &&
+		cd plain-nested &&
+		git init
+	) &&
+	check_config bare-ancestor.git/plain-nested/.git false unset
+'
+
+test_expect_success 'plain through aliased command, outside any git re=
po' '
+	(
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG_NOGLOBAL &&
+		HOME=3D$(pwd)/alias-config &&
+		export HOME &&
+		mkdir alias-config &&
+		echo "[alias] aliasedinit =3D init" >alias-config/.gitconfig &&
+
+		GIT_CEILING_DIRECTORIES=3D$(pwd) &&
+		export GIT_CEILING_DIRECTORIES &&
+
+		mkdir plain-aliased &&
+		cd plain-aliased &&
+		git aliasedinit
+	) &&
+	check_config plain-aliased/.git false unset
+'
+
+test_expect_failure 'plain nested through aliased command' '
+	(
+		unset GIT_DIR GIT_WORK_TREE &&
+		git init plain-ancestor-aliased &&
+		cd plain-ancestor-aliased &&
+		echo "[alias] aliasedinit =3D init" >>.git/config &&
+		mkdir plain-nested &&
+		cd plain-nested &&
+		git aliasedinit
+	) &&
+	check_config plain-ancestor-aliased/plain-nested/.git false unset
+'
+
+test_expect_failure 'plain nested in bare through aliased command' '
+	(
+		unset GIT_DIR GIT_WORK_TREE &&
+		git init --bare bare-ancestor-aliased.git &&
+		cd bare-ancestor-aliased.git &&
+		echo "[alias] aliasedinit =3D init" >>config &&
+		mkdir plain-nested &&
+		cd plain-nested &&
+		git aliasedinit
+	) &&
+	check_config bare-ancestor-aliased.git/plain-nested/.git false unset
+'
+
 test_expect_success 'plain with GIT_WORK_TREE' '
 	if (
 		unset GIT_DIR
--=20
1.7.3.2.210.g045198
