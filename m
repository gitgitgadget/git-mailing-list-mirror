From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] t0001: test git init when run via an alias
Date: Mon,  8 Nov 2010 17:23:38 +0700
Message-ID: <1289211818-12594-1-git-send-email-pclouds@gmail.com>
References: <627dc7921dc64a16063e77d542cf9edb22631ddd.1289205059.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@drmicha.warpmail.net, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 11:25:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFOuM-0002Or-RB
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 11:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242Ab0KHKYw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 05:24:52 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39328 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab0KHKYv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 05:24:51 -0500
Received: by pzk28 with SMTP id 28so799002pzk.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 02:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=24OnRRw6Jj5P3qb0S1Y4tUyqgnVQqyuk3q3ZZtnx8uQ=;
        b=FP0hwF3+4XSteLr5lLOZWIrQhW5s3jaerWDYUddqT2zcIWRBSklaZb5/O4qQB/o/c2
         qKK/QJPHO6QPhMXL4+vXxXNd9s1+PQim7QfTu8LnCXwgW17yf5i4ir4jMq4Qa+WWADRP
         CF6TreYN7Az6mjIdmLp+RyVaw7crxy/VuFON8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kAqBvnRoZ5zFNdjzNlvzTHQAGea9B5tCREfh6OWgR1zmJ6ZhVlGOb/PHo5Yf3ujvcw
         v5Mpbj4jb/IqDU95veNlSLCWNZsUQmm9cMLiT7YY68IjAJ5P5lJjU18NezV+e/4ttU+5
         Qo/GSAL5hKvaKUWDFvngUvpeu4v1BbePfoeus=
Received: by 10.142.253.21 with SMTP id a21mr4423624wfi.219.1289211890770;
        Mon, 08 Nov 2010 02:24:50 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.139])
        by mx.google.com with ESMTPS id p8sm7838748wff.4.2010.11.08.02.24.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 02:24:49 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 08 Nov 2010 17:23:44 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <627dc7921dc64a16063e77d542cf9edb22631ddd.1289205059.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160918>

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
 >     In fact, we don't really have tests for alias expansion at all, =
but that's a different issue.

 It reminds me of this old patch. Let's push them together.

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
+test_expect_success 'plain nested through aliased command' '
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
