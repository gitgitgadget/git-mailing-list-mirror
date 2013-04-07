From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] remote-helpers/test-bzr.sh: do not use grep \s
Date: Sun, 7 Apr 2013 10:48:30 +0200
Message-ID: <201304071048.31790.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: felipe.contreras@gmail.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 10:48:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOlHG-0001sr-E6
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 10:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932986Ab3DGIsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Apr 2013 04:48:38 -0400
Received: from mout.web.de ([212.227.15.4]:58901 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932978Ab3DGIsh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Apr 2013 04:48:37 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0LqDTc-1V2TkS2cGe-00eBgS; Sun, 07 Apr 2013 10:48:36 +0200
X-Provags-ID: V02:K0:eUjzgnwz5fkBWpdpOkW8LSiYhAFfU0AAm17XXnVRjey
 WSIuS4/yrKC1ZNunPoGF4TnvYifsYnhYL3UqNiFQFzXNpQ1obh
 e2D95p3SBpybBOCTcTqhn5bBg6qc/lwAqeoPzKUlzhpmM9b3UK
 or4uYIbFrPgTATYIusfk4jqMMy9LRsRZHJZ+XotP+rDintWtoE
 xa29h8bCOzD1JfOtMX75w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220298>

Using grep "devel\s\+3:" to find at least one whitspace
is not portable on all grep versions:
Not all grep versions understand "\s" as a "whitespace".

Use a literal TAB followed by SPACE like this [	 ] instead.
The + as a qualifier for "one or more" is not a basic regular expressio=
n:
use egrep instead of grep.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 contrib/remote-helpers/test-hg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers=
/test-hg.sh
index 5f81dfa..7bb81f2 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -115,7 +115,7 @@ test_expect_success 'update bookmark' '
   git push
   ) &&
=20
-  hg -R hgrepo bookmarks | grep "devel\s\+3:"
+  hg -R hgrepo bookmarks | egrep "devel[	 ]+3:"
 '
=20
 test_done
--=20
1.8.2.341.g543621f
