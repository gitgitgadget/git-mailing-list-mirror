From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH 4/6] t4012: Break up pipe into serial redirections
Date: Thu, 12 Jul 2012 00:12:56 +0200
Message-ID: <20120711221256.GA21355@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 00:13:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp59r-0004uj-FL
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 00:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418Ab2GKWNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 18:13:04 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:45170 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030415Ab2GKWNB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 18:13:01 -0400
Received: (qmail invoked by alias); 11 Jul 2012 22:12:59 -0000
Received: from p5B06F836.dip.t-dialin.net (EHLO gmx.net) [91.6.248.54]
  by mail.gmx.net (mp039) with SMTP; 12 Jul 2012 00:12:59 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX1+7iyUzhsm7f88X5JmdzN87SbCRmSNPFccUsepbCy
	sVY7nfLhBp5N/a
Received: by gmx.net (sSMTP sendmail emulation); Thu, 12 Jul 2012 00:12:56 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201338>

Do not hide possible git errors by masquerading its process
exit status.

Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
---
 t/t4012-diff-binary.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 60c2f6c..daf8234 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -64,7 +64,8 @@ test_expect_success 'apply --numstat understands diff --binary format' '
 # apply needs to be able to skip the binary material correctly
 # in order to report the line number of a corrupt patch.
 test_expect_success 'apply detecting corrupt patch correctly' '
-	 git diff | sed -e "s/-CIT/xCIT/" >broken &&
+	 git diff >output &&
+	 sed -e "s/-CIT/xCIT/" <output >broken &&
 	 if git apply --stat --summary broken 2>detected
 	 then
 		echo unhappy - should have detected an error
-- 
1.7.10.2.552.gaa3bb87
