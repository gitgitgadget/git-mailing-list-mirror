From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH V2] t0070 "mktemp to unwritable directory" needs SANITY
Date: Sat, 8 Jun 2013 13:57:57 +0200
Message-ID: <201306081357.57978.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 14:18:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlI5o-0001Lr-LM
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 14:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab3FHMR5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 08:17:57 -0400
Received: from mout.web.de ([212.227.15.4]:61326 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941Ab3FHMR4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jun 2013 08:17:56 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb004) with
 ESMTPA (Nemesis) id 0LocJe-1U9VYv02Is-00gUSt for <git@vger.kernel.org>; Sat,
 08 Jun 2013 14:17:55 +0200
X-Provags-ID: V03:K0:UJ1YKKIQTa5/ZYl6jQISDdn9xoo9sWiYWdS9LtzUdzoQzXv+bSz
 iytvbVzIC9XoR7XrwceUbCf5o388QhRlifZpmLf4MYUmBmPWhbQvDFsQgAw5hDr5fVfbKjk
 OrlRJstD1i5j/WowKfnMt3z3+beeMKy+ZQeKE85aaxpFtwhUZp3FQEZOeVYZs2Aq9AAH1uD
 Hqi/jIZZylfTq96etrB3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226809>

Use the SANITY prerequisite when testing if a temp file can
be created in a read only directory.
Skip the test under CYGWIN, or skip it under Unix/Linux when
it is run as root.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0070-fundamental.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index da2c504..986b2a8 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -17,7 +17,7 @@ test_expect_success 'mktemp to nonexistent directory =
prints filename' '
 	grep "doesnotexist/test" err
 '
=20
-test_expect_success POSIXPERM 'mktemp to unwritable directory prints f=
ilename' '
+test_expect_success POSIXPERM,SANITY 'mktemp to unwritable directory p=
rints filename' '
 	mkdir cannotwrite &&
 	chmod -w cannotwrite &&
 	test_when_finished "chmod +w cannotwrite" &&
--=20
1.8.3
