From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 15:17:18 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806241515460.9925@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 16:22:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB9Ow-000054-6S
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 16:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbYFXOTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 10:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754115AbYFXOTW
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 10:19:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:45637 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753806AbYFXOTV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 10:19:21 -0400
Received: (qmail invoked by alias); 24 Jun 2008 14:19:19 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp006) with SMTP; 24 Jun 2008 16:19:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+pGTkrsn6pvc1RgIM6hBhEmQvaPIVKygZ+5I1qHv
	Ut7XurqQbVXtVk
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86063>


When you look for a fix instead of a regression, it can be quite hard
to twist your brain into choosing the correct bisect command between
'git bisect bad' and 'git bisect good'.

So introduce the commands 'git bisect fixed' and 'git bisect unfixed'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	When Randal talked about this on IRC, I laughed.  But I just had 
	the case where it took me _three_ attempts at a bisection, only
	to give up and write this patchlet.

	May it help someone else, too.

 git-bisect.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 8b11107..d833e21 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -501,6 +501,8 @@ case "$#" in
 *)
     cmd="$1"
     shift
+    test $cmd = fixed && cmd=bad
+    test $cmd = unfixed && cmd=good
     case "$cmd" in
     help)
         git bisect -h ;;
-- 
1.5.6.127.g3fb9f
