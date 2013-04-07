From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH V2] remote-helpers/test-bzr.sh: do not use grep \s
Date: Sun, 7 Apr 2013 11:23:30 +0200
Message-ID: <201304071123.31602.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: felipe.contreras@gmail.com, sunshine@sunshineco.com
To: git@vger.kernel.org, tboegi@web.de
X-From: git-owner@vger.kernel.org Sun Apr 07 11:24:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOlpZ-0003M8-A1
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 11:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933015Ab3DGJYE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Apr 2013 05:24:04 -0400
Received: from mout.web.de ([212.227.15.4]:61334 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932995Ab3DGJYC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Apr 2013 05:24:02 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0Lhedd-1UtNXV2LIH-00mvkt; Sun, 07 Apr 2013 11:24:00 +0200
Cc: sunshine@sunshineco.com
X-Provags-ID: V02:K0:+hXPGAqrMjg5BmJCBZFqLhp1iQ32Exxyx9B1OUxq2j3
 SbhF6QyZj02dzZxNGhwxN1CQqJUvLl3yjqYJhMfmXMpXAq0qgj
 3r7XaAv/4g0UQ/q6rTPm0uC+kRSD+sssmUmCg6yvIIYP5cbL9V
 J0fdSvI9X/UWo4L5bKbma+rUYYrqD91pPdsUSAoiYpgqrYhYed
 p4DsI1o7sxdjz5ydQjXdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220304>

Using grep "devel\s\+3:" to find at least one whitespace
is not portable on all grep versions:
Not all grep versions understand "\s" as a "whitespace".

The + as a qualifier for "one or more" is not a basic regular expressio=
n:
use egrep instead of grep.
Use a literal TAB followed by SPACE like this [	 ] instead,
which is more portable than [:space:]=20

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
