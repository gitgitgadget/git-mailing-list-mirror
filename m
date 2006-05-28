From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] git-fetch: Shell syntax fix for NetBSD
Date: Sun, 28 May 2006 22:45:10 +0200
Message-ID: <20060528204510.G51ab1cf8@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 28 22:45:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkS8b-0003ca-5V
	for gcvg-git@gmane.org; Sun, 28 May 2006 22:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWE1UpW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 16:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWE1UpW
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 16:45:22 -0400
Received: from v345.ncsrv.de ([89.110.145.104]:17341 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1750916AbWE1UpW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 16:45:22 -0400
Received: from leonov.stosberg.net (p213.54.89.85.tisdip.tiscali.de [213.54.89.85])
	by ncs.stosberg.net (Postfix) with ESMTP id CBFE1589000C
	for <git@vger.kernel.org>; Sun, 28 May 2006 22:45:04 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id B5EFC1044AE; Sun, 28 May 2006 22:45:10 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Sun, 28 May 2006 22:27:00 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20893>

NetBSD's default shell does not accept an opening parenthesis in
a case switch.

$ ./git-fetch
./git-fetch: 219: Syntax error: word unexpected (expecting ")")

---
With this change applied to the next branch, all tests complete
successfully on NetBSD 3.0 without having bash installed.

 git-fetch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 280f62e..b8092a6 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -216,7 +216,7 @@ then
 	          while read sha1 name
 		  do
 			case "$name" in
-			(*^*) continue ;;
+			*^*) continue ;;
 			esac
 		  	if git-check-ref-format "$name"
 			then
-- 
1.3.3.g3c38f
