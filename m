From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] gitk: fix 'can't read "notflag"'
Date: Thu, 4 Dec 2008 15:34:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812041532160.7045@racer>
References: <gh5q1t$qjn$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-814361349-1228401256=:7045"
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Alejandro Riveira <ariveira@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 15:36:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8FJQ-0003tH-Pd
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 15:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232AbYLDOe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 09:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754931AbYLDOe4
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 09:34:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:33860 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751244AbYLDOez (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 09:34:55 -0500
Received: (qmail invoked by alias); 04 Dec 2008 14:34:53 -0000
Received: from pD9EB33F3.dip0.t-ipconnect.de (EHLO noname) [217.235.51.243]
  by mail.gmx.net (mp013) with SMTP; 04 Dec 2008 15:34:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lekhFkImlgjiGRiJKviPW2YOhuz3K8/PovKX9SM
	V7L095XFnJo6Me
X-X-Sender: gene099@racer
In-Reply-To: <gh5q1t$qjn$1@ger.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102339>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-814361349-1228401256=:7045
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


Sometimes, when calling git bisect visualize, parameters including
a "--not" are passed to gitk, triggering an uninitialized-variable bug
introduced in ee66e089(gitk: Make updates go faster).

Noticed by Alejandro Riveira Fernández.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 3 Dec 2008, Alejandro Riveira wrote:

	> $ git bisect visualize                                                                  (03-12 12:16)
	> Error in startup script: can't read "notflag": no such variable

	Alejandro was good enough to test this fix.

 gitk-git/gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 3353f4a..b18bdf0 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -139,6 +139,7 @@ proc parseviewargs {n arglist} {
     set origargs $arglist
     set allknown 1
     set filtered 0
+    set notflag 0
     set i -1
     foreach arg $arglist {
 	incr i
-- 
1.6.0.4.1189.g8876f

--8323329-814361349-1228401256=:7045--
