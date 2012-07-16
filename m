From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH v2 3/8] t4012: Actually quote the sed script
Date: Mon, 16 Jul 2012 22:43:58 +0200
Message-ID: <dac7fe6c66facf9bdecbe4764a7036ec3e6663fa.1342468069.git.eclipse7@gmx.net>
References: <cover.1342468069.git.eclipse7@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 22:44:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqs9M-0001aG-1I
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 22:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab2GPUoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 16:44:06 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:43792 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751736Ab2GPUoE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 16:44:04 -0400
Received: (qmail invoked by alias); 16 Jul 2012 20:44:01 -0000
Received: from p5DC37C42.dip.t-dialin.net (EHLO gmx.net) [93.195.124.66]
  by mail.gmx.net (mp036) with SMTP; 16 Jul 2012 22:44:01 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX19Wx65C5BBWFyJETBIHHwlf4trW25BCz746BTU+GS
	wENdj4hUBiWPmW
Received: by gmx.net (sSMTP sendmail emulation); Mon, 16 Jul 2012 22:43:58 +0200
Content-Disposition: inline
In-Reply-To: <cover.1342468069.git.eclipse7@gmx.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201570>

The nested quoting is not needed in this cases, thus the previous
version did work just fine. Nevertheless the usage is misleading,
so just achieve nested quoting by using double quotes instead. Lower
the probability of breakage in the future and make the code easier
to read.

NOTE: Just dropping the single quotes around the sed arguments would
      have also been possible.

Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
