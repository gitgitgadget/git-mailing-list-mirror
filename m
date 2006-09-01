From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] Documentation: Fix howto/revert-branch-rebase.html generation
Date: Fri,  1 Sep 2006 22:42:59 +0400
Message-ID: <11571361793668-git-send-email-vsu@altlinux.ru>
Cc: GIT mailing list <git@vger.kernel.org>,
	Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Fri Sep 01 20:43:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJDzS-0000XH-Fq
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 20:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWIASnj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 14:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWIASnj
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 14:43:39 -0400
Received: from master.altlinux.org ([62.118.250.235]:26376 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750752AbWIASnj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Sep 2006 14:43:39 -0400
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id 901A7E350E; Fri,  1 Sep 2006 22:43:37 +0400 (MSD)
Received: by procyon.home (Postfix, from userid 500)
	id 04D9EE3CCA2; Fri,  1 Sep 2006 22:42:59 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.g914b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26305>

The rule for howto/*.html used "$?", which expands to the list of all
newer prerequisites, including asciidoc.conf added by another rule.
"$<" should be used instead.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 Documentation/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ed8b886..c00f5f6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -107,7 +107,7 @@ WEBDOC_DEST = /pub/software/scm/git/docs
 
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 	rm -f $@+ $@
-	sed -e '1,/^$$/d' $? | asciidoc -b xhtml11 - >$@+
+	sed -e '1,/^$$/d' $< | asciidoc -b xhtml11 - >$@+
 	mv $@+ $@
 
 install-webdoc : html
-- 
1.4.2.g914b
