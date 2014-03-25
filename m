From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 021/144] t1004-read-tree-m-u-wf.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:26 -0700
Message-ID: <1395735989-3396-22-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:36:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMqS-0001DJ-My
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbaCYI1L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:11 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:48852 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbaCYI1D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:03 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so129442pab.9
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xeMpUb9rEQknFbaaJ4D+KUDuLzVcJT6HgtQnwcwag7c=;
        b=XzfMpf9xXHtBpMeFfdGqb62HbTrYAfO5582wvq29NuhOsC0swLkiG2q2+0iz2sBpeH
         W7eFcBpZseUQMiNcYAYV/W6LtU48JCnr36RIwE+wL/IvloxRg2DhJ0VOHM7pwT67hUq9
         BUvO9yKbBGiji7GPJBbocUk/oszEazEJ0MYyJ3Dv/+oGdxNhBBYvx5Mnnzx13ns8aYhe
         s39IQcCFcNYg0AslgcYqyAa+LodSU95eKB8osEaeiAtP3G4rB6WsDQaaIjkO7hIEgNHQ
         EvZAIM0Wwy/hgIn8/YHvy0HbIS9mD4Glckph2rUY9DpjfpD3v4Jpxiv2sNieuv3DqeCL
         lAJw==
X-Received: by 10.66.231.40 with SMTP id td8mr76980144pac.103.1395736022859;
        Tue, 25 Mar 2014 01:27:02 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244994>

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
 t/t1004-read-tree-m-u-wf.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 3e72aff..c70cf42 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -30,7 +30,7 @@ test_expect_success 'two-way not clobbering' '
=20
 	echo >file2 master creates untracked file2 &&
 	echo >subdir/file2 master creates untracked subdir/file2 &&
-	if err=3D`read_tree_u_must_succeed -m -u master side 2>&1`
+	if err=3D$(read_tree_u_must_succeed -m -u master side 2>&1)
 	then
 		echo should have complained
 		false
@@ -43,7 +43,7 @@ echo file2 >.gitignore
=20
 test_expect_success 'two-way with incorrect --exclude-per-directory (1=
)' '
=20
-	if err=3D`read_tree_u_must_succeed -m --exclude-per-directory=3D.giti=
gnore master side 2>&1`
+	if err=3D$(read_tree_u_must_succeed -m --exclude-per-directory=3D.git=
ignore master side 2>&1)
 	then
 		echo should have complained
 		false
@@ -54,7 +54,7 @@ test_expect_success 'two-way with incorrect --exclude=
-per-directory (1)' '
=20
 test_expect_success 'two-way with incorrect --exclude-per-directory (2=
)' '
=20
-	if err=3D`read_tree_u_must_succeed -m -u --exclude-per-directory=3Dfo=
o --exclude-per-directory=3D.gitignore master side 2>&1`
+	if err=3D$(read_tree_u_must_succeed -m -u --exclude-per-directory=3Df=
oo --exclude-per-directory=3D.gitignore master side 2>&1)
 	then
 		echo should have complained
 		false
@@ -95,7 +95,7 @@ test_expect_success 'three-way not clobbering a worki=
ng tree file' '
 	git checkout master &&
 	echo >file3 file three created in master, untracked &&
 	echo >subdir/file3 file three created in master, untracked &&
-	if err=3D`read_tree_u_must_succeed -m -u branch-point master side 2>&=
1`
+	if err=3D$(read_tree_u_must_succeed -m -u branch-point master side 2>=
&1)
 	then
 		echo should have complained
 		false
--=20
1.7.10.4
