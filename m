From: Pavel Roskin <proskin@roinet.com>
Subject: [PATCH] Parametrize installation directory
Date: Tue, 19 Apr 2005 15:43:24 -0400
Organization: Rajant Corporation
Message-ID: <1113939804.3684.3.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 19 21:40:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNyZD-0007pu-18
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 21:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVDSTne (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 15:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVDSTne
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 15:43:34 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:45192
	"HELO roinet.com") by vger.kernel.org with SMTP id S261637AbVDSTn2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 15:43:28 -0400
Received: (qmail 3817 invoked from network); 19 Apr 2005 19:43:25 -0000
Received: from corporate.roinet.com (HELO mail.roinet.com) (192.168.1.2)
  by roinet.com with SMTP; 19 Apr 2005 19:43:25 -0000
Received: by mail.roinet.com (Postfix, from userid 65534)
	id B447945DF1C; Tue, 19 Apr 2005 15:43:25 -0400 (EDT)
Received: from dv (unknown [192.168.1.1])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by mail.roinet.com (Postfix) with ESMTP id 427B345DF08
	for <git@vger.kernel.org>; Tue, 19 Apr 2005 15:43:25 -0400 (EDT)
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
X-Spam-Checker-Version: SpamAssassin 2.64 (2004-01-11) on mail.roinet.com
X-Spam-Level: 
X-Spam-Status: No, hits=-4.8 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=2.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

It shouldn't be necessary to patch Makefile to specify where scripts
should be installed.  This patch introduces a variable bindir for that
purpose.  The name of the variable was chosen for compatibility with
projects using Automake.

For example, to install scripts to /usr/local/bin use:
make install bindir=usr/local/bin

Signed-off-by: Pavel Roskin <proski@gnu.org>

--- a/Makefile
+++ b/Makefile
@@ -12,6 +12,7 @@ CFLAGS=-g -O3 -Wall
 CC=gcc
 AR=ar
 
+bindir = $(HOME)/bin/
 
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
@@ -54,7 +55,7 @@ gitversion.sh: $(VERSION)
 	@chmod +x $@
 
 install: $(PROG) $(GEN_SCRIPT)
-	install $(PROG) $(SCRIPT) $(GEN_SCRIPT) $(HOME)/bin/
+	install $(PROG) $(SCRIPT) $(GEN_SCRIPT) $(bindir)
 
 clean:
 	rm -f *.o $(PROG) $(GEN_SCRIPT) $(LIB_FILE)


-- 
Regards,
Pavel Roskin


