From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH 3/6] t4012: Actually quote the sed script
Date: Thu, 12 Jul 2012 00:12:41 +0200
Message-ID: <20120711221241.GA21342@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 00:12:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp59Q-0004Ln-Qt
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 00:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933360Ab2GKWMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 18:12:47 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:51698 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932203Ab2GKWMq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 18:12:46 -0400
Received: (qmail invoked by alias); 11 Jul 2012 22:12:44 -0000
Received: from p5B06F836.dip.t-dialin.net (EHLO gmx.net) [91.6.248.54]
  by mail.gmx.net (mp070) with SMTP; 12 Jul 2012 00:12:44 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX19dbDcJ67pd+IDYIf7+EBqAzWoVI9V/9qzXd90OL7
	DdCChTQOIQBQcL
Received: by gmx.net (sSMTP sendmail emulation); Thu, 12 Jul 2012 00:12:41 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201337>

The nested quoting is not needed in this cases, thus the previous
version did work just fine. Never the less the usage is misleading,
so just achieve nested quoting by using double quotes instead. Lower
the probability of breakage in the future and make the code easier
to read.

NOTE: Just dropping the single quotes around the sed arguments would
      have also been possible.

Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
---
 t/t4012-diff-binary.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 3c54269..60c2f6c 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -64,7 +64,7 @@ test_expect_success 'apply --numstat understands diff --binary format' '
 # apply needs to be able to skip the binary material correctly
 # in order to report the line number of a corrupt patch.
 test_expect_success 'apply detecting corrupt patch correctly' '
-	 git diff | sed -e 's/-CIT/xCIT/' >broken &&
+	 git diff | sed -e "s/-CIT/xCIT/" >broken &&
 	 if git apply --stat --summary broken 2>detected
 	 then
 		echo unhappy - should have detected an error
@@ -79,7 +79,7 @@ test_expect_success 'apply detecting corrupt patch correctly' '
 '
 
 test_expect_success 'apply detecting corrupt patch correctly' '
-	 git diff --binary | sed -e 's/-CIT/xCIT/' >broken &&
+	 git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
 	 if git apply --stat --summary broken 2>detected
 	 then
 		echo unhappy - should have detected an error
-- 
1.7.10.2.552.gaa3bb87
