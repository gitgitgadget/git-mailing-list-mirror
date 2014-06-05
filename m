From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH] t5551: fix the 50,000 tag test
Date: Thu, 05 Jun 2014 23:36:21 +0200
Message-ID: <5390E2D5.9070000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 23:36:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsfKl-00082J-VV
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 23:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbaFEVgY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2014 17:36:24 -0400
Received: from mout.web.de ([212.227.15.3]:54347 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbaFEVgX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 17:36:23 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MEmbK-1Wznwa0PJy-00G4gB; Thu, 05 Jun 2014 23:36:22
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Provags-ID: V03:K0:MFPZY6epQKLNUWja9jkOhVkDuCAEMxwxLzd5gru725+q4zR0AHc
 00n3BL1GiSbplc0KYVAfMoj7DhDznJmRCCV83w7O/M7HEvn4Fh7jeYJMrj/mGrD5tLn6O6q
 +VeZ2S8bWkpVJ1VHWuncKc9DhCLzXY6kTEIkLblspvlrE1i0Nu36KZfeny/6Ir8WAaAhVwJ
 lMt2SWaio6seIPtyyW2ag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250864>

The first version of test 23 did simply check that no output was send
to stderr.

Commit 5e2c7cd2 verified that the expected tags were actually cloned.

Since the day "git clone" printed "Cloning into 'too-many-refs'" to std=
err,
the test failed because stderr was not empty.

Remove the check for stderr and make t5551-23 pass again

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t5551-http-fetch-smart.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index e07eaf3..2c49133 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -240,8 +240,7 @@ test_expect_success EXPENSIVE 'create 50,000 tags i=
n the repo' '
 '
=20
 test_expect_success EXPENSIVE 'clone the 50,000 tag repo to check OS c=
ommand line overflow' '
-	git clone $HTTPD_URL/smart/repo.git too-many-refs 2>err &&
-	test_line_count =3D 0 err &&
+	git clone $HTTPD_URL/smart/repo.git too-many-refs &&
 	(
 		cd too-many-refs &&
 		test $(git for-each-ref refs/tags | wc -l) =3D 50000
--=20
2.0.0.553.ged01b91
