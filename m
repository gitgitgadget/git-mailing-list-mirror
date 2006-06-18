From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Make release tarballs friendlier to older tar versions
Date: Sun, 18 Jun 2006 15:25:33 +0200
Message-ID: <20060618132533.GA31005@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 15:25:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrxHV-0006my-N7
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 15:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWFRNZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 09:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWFRNZe
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 09:25:34 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:63928
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932226AbWFRNZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 09:25:34 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 809151A037; Sun, 18 Jun 2006 15:25:33 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22079>

git-tar-tree adds an extended pax header to archives if its first
parameter points to a commit.  It confuses older tars and isn't
very useful in the case of git anyway, so stop doing it.

Idea: Junio, implementation: Junio.  I just wrote it up. :-)

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/Makefile b/Makefile
index 2a1e639..28517f4 100644
--- a/Makefile
+++ b/Makefile
@@ -667,7 +667,7 @@ git.spec: git.spec.in
 
 GIT_TARNAME=git-$(GIT_VERSION)
 dist: git.spec git-tar-tree
-	./git-tar-tree HEAD $(GIT_TARNAME) > $(GIT_TARNAME).tar
+	./git-tar-tree HEAD^{tree} $(GIT_TARNAME) > $(GIT_TARNAME).tar
 	@mkdir -p $(GIT_TARNAME)
 	@cp git.spec $(GIT_TARNAME)
 	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
