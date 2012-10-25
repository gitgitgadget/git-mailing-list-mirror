From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] t9401: Use tr to handle TAB
Date: Thu, 25 Oct 2012 15:06:31 +0200
Message-ID: <201210251506.32393.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 15:06:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRN98-0003XS-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 15:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759444Ab2JYNGi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2012 09:06:38 -0400
Received: from mout.web.de ([212.227.15.4]:63754 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759022Ab2JYNGh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2012 09:06:37 -0400
Received: from appes.localnet ([195.67.191.22]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0ML8F7-1TR61l0QRF-000Qvc; Thu, 25 Oct 2012 15:06:36 +0200
X-Provags-ID: V02:K0:q0kaDCXi8hf1lDaYqb+TOfbI96GXWhgQ/rAxv9LzgoW
 /g5OttfLABK5lQzmlCoK7gnGbRWwRf6GCsBU8EAq0qlg1qy+xZ
 ji+9hX4kNgrv4S9lKfCVQLMwvbv/7DcDQ36mQXXXerab/aXf9M
 ubEb+04LjsvPLgqYeM/ZN+VdpwVjAoyhcqFbAlcELvsMf17WrH
 QGTk901TYaMVZcrEDbUFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208398>

Not all sed versions understand \s as whitespace
Use tr to translate '\t' into ' ' before feeding the line into sed

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9401-git-cvsserver-crlf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf=
=2Esh
index cdb8360..f2ec9d2 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -46,7 +46,7 @@ check_status_options() {
 	echo "Error from cvs status: $1 $2" >> "${WORKDIR}/marked.log"
 	return 1;
     fi
-    got=3D"$(sed -n -e 's/^\s*Sticky Options:\s*//p' "${WORKDIR}/statu=
s.out")"
+    got=3D"$(tr '\t' ' ' < "${WORKDIR}/status.out" | sed -n -e 's/^ *S=
ticky Options: *//p')"
     expect=3D"$3"
     if [ x"$expect" =3D x"" ] ; then
 	expect=3D"(none)"
--=20
1.7.12
