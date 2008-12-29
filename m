From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH] t7500-commit.sh: do not call test_set_editor unnecessarily, it's confusing
Date: Mon, 29 Dec 2008 10:24:18 +0100
Message-ID: <1230542658-9758-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 29 10:25:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHENa-0008De-EJ
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 10:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbYL2JYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2008 04:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502AbYL2JYX
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 04:24:23 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:2235
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbYL2JYW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 04:24:22 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 849488027934;
	Mon, 29 Dec 2008 10:24:20 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LHEME-0002YR-KP; Mon, 29 Dec 2008 10:24:18 +0100
X-Mailer: git-send-email 1.6.1.307.g07803
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104089>

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---

I was reading this test case, and it took a small bit to figure out the
editor was not being used at all. I hope there was no hidden reason for
it to be there, and it can go away.

Cheers,

 t/t7500-commit.sh |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 6e18a96..5998baf 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -149,10 +149,7 @@ EOF
=20
 test_expect_success '--signoff' '
 	echo "yet another content *narf*" >> foo &&
-	echo "zort" | (
-		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
-		git commit -s -F - foo
-	) &&
+	echo "zort" | git commit -s -F - foo &&
 	git cat-file commit HEAD | sed "1,/^$/d" > output &&
 	test_cmp expect output
 '
--=20
1.6.1.307.g07803
