From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix compile with expat, but an old curl version
Date: Wed, 5 Apr 2006 16:22:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604051621530.6231@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Apr 05 16:23:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR8uC-00072d-B6
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 16:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWDEOWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 10:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWDEOWl
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 10:22:41 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:55448 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750835AbWDEOWl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 10:22:41 -0400
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 6E9F42016;
	Wed,  5 Apr 2006 16:22:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 61A35C23;
	Wed,  5 Apr 2006 16:22:40 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 45B212016;
	Wed,  5 Apr 2006 16:22:40 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18434>


With an old curl version, git-http-push is not compiled. But git-http-fetch
still needs to be linked with expat if NO_EXPAT is not defined.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

57918780ecdff0c767a22b7589ff1025de6cb40f
diff --git a/Makefile b/Makefile
index 3596445..557d322 100644
--- a/Makefile
+++ b/Makefile
@@ -333,9 +333,11 @@ ifndef NO_CURL
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
-			EXPAT_LIBEXPAT = -lexpat
 			PROGRAMS += git-http-push$X
 		endif
+	endif
+	ifndef NO_EXPAT
+		EXPAT_LIBEXPAT = -lexpat
 	endif
 endif
 
-- 
1.3.0.rc2.g4a16-dirty
