From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] xdiff/xemit.c (xdl_find_func): Elide trailing white space in a context header.
Date: Mon, 23 Oct 2006 22:22:25 +0200
Message-ID: <87y7r63hq6.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 23 22:22:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc6Ji-00059B-Uu
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 22:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWJWUW1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 16:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWJWUW1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 16:22:27 -0400
Received: from mx.meyering.net ([82.230.74.64]:58757 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1750805AbWJWUW0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 16:22:26 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id A136061AE; Mon, 23 Oct 2006 22:22:25 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29873>

This removes trailing blanks from git-generated diff headers
the same way a similar patch did that for GNU diff:

  http://article.gmane.org/gmane.comp.gnu.utils.bugs/13839

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 xdiff/xemit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 714c563..1bca639 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -92,6 +92,8 @@ static void xdl_find_func(xdfile_t *xf,
 				len = sz;
 			if (len && rec[len - 1] == '\n')
 				len--;
+			while (0 < len && isspace ((unsigned char) rec[len - 1]))
+				len--;
 			memcpy(buf, rec, len);
 			*ll = len;
 			return;
--
1.4.3.1.g178e-dirty
