From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t5000: skip ZIP tests if unzip was not found
Date: Wed, 6 Jun 2007 19:57:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706061956540.4046@racer.site>
References: <alpine.LFD.0.98.0706050908520.23741@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706051819290.4046@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 21:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw19Z-0007nh-Va
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 21:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464AbXFFT0b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 15:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763926AbXFFT0b
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 15:26:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:38356 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756464AbXFFT0a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 15:26:30 -0400
Received: (qmail invoked by alias); 06 Jun 2007 18:59:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 06 Jun 2007 20:59:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194in1PU4V4GtybpsFnK9SoZJk6sEOyAKC+vq/nMm
	b+8h/DnR2P+PUq
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0706051819290.4046@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49307>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Tue, 5 Jun 2007, Johannes Schindelin wrote:

	> I seem to remember that I patched it already.
	> 
	> http://thread.gmane.org/gmane.comp.version-control.git/46854/focus=46899
	> 
	> Unfortunately, the patch was incorrect, and I forgot to do it 
	> properly. Will try this afternoon.

	So, took me some more time. Sorry.

 t/t5000-tar-tree.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index e223c07..5500505 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -108,6 +108,13 @@ test_expect_success \
     'git-archive --format=zip' \
     'git-archive --format=zip HEAD >d.zip'
 
+$UNZIP -v 2>/dev/null
+if [ $? -eq 127 ]; then
+	echo "Skipping ZIP tests, because unzip was not found"
+	test_done
+	exit
+fi
+
 test_expect_success \
     'extract ZIP archive' \
     '(mkdir d && cd d && $UNZIP ../d.zip)'
