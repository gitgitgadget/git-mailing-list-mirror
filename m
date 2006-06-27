From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] cogito: "make clean" fails if make is not GNU make
Date: Tue, 27 Jun 2006 18:58:54 +0200
Message-ID: <20060627165854.G5b420f27@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 18:59:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvGtz-00047h-K0
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 18:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161212AbWF0Q67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 12:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161214AbWF0Q67
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 12:58:59 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:42474 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1161212AbWF0Q66 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 12:58:58 -0400
Received: from leonov.stosberg.net (p213.54.84.32.tisdip.tiscali.de [213.54.84.32])
	by ncs.stosberg.net (Postfix) with ESMTP id 78791AEBA065;
	Tue, 27 Jun 2006 18:58:47 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 9249011141C; Tue, 27 Jun 2006 18:58:54 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Tue, 27 Jun 2006 18:31:06 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22744>

GNU make automatically passes the -w option when -C is used.  On
systems where GNU make is called "gmake", invoking "make" from within
the Makefile will run a make that may not understand that option:

$ gmake -C Documentation/ clean
gmake: Entering directory `/usr/home/dennis/tmp/cogito/Documentation'
make -C tutorial-script clean
make: don't know how to make w. Stop
gmake: *** [clean] Error 2

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 Documentation/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 36295a7..b48e49c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -60,10 +60,10 @@ install-html: html
 	$(INSTALL) $(DOC_HTML) $(DESTDIR)/$(htmldir)
 
 test:
-	make -C tutorial-script test
+	$(MAKE) -C tutorial-script test
 
 clean:
-	make -C tutorial-script clean
+	$(MAKE) -C tutorial-script clean
 	rm -f *.xml *.html *.pdf *.1 *.7 cg*.[17].txt $(PACKAGE).7.txt
 
 .PRECIOUS: cg%.txt introduction.txt
-- 
1.4.1.rc1.ge6b53
