From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 4/6] Fix detection of ipv6 on Solaris
Date: Tue, 15 Aug 2006 11:01:27 +0200
Message-ID: <20060815090127.5223.89277.stgit@leonov.stosberg.net>
References: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Aug 15 11:01:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCunq-0001xX-Ib
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 11:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965307AbWHOJBd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 05:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965304AbWHOJBd
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 05:01:33 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:63167 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S932756AbWHOJB3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 05:01:29 -0400
Received: from leonov.stosberg.net (p213.54.74.221.tisdip.tiscali.de [213.54.74.221])
	by ncs.stosberg.net (Postfix) with ESMTP id 09E81AEBA002
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:01:25 +0200 (CEST)
Received: from leonov.stosberg.net (leonov.stosberg.net [127.0.0.1])
	by leonov.stosberg.net (Postfix) with ESMTP id 9610D12173A
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:01:27 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25451>

The configuration script detects whether linking with -lsocket is
necessary but doesn't add -lsocket to LIBS.  This lets the ipv6 test
fail.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---

 configure.ac |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0321d43..36f9cd9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -154,6 +154,7 @@ AC_CHECK_LIB([c], [socket],
 [NEEDS_SOCKET=],
 [NEEDS_SOCKET=YesPlease])
 AC_SUBST(NEEDS_SOCKET)
+test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"
 
 
 ## Checks for header files.
