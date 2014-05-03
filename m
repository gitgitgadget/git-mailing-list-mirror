From: James Denholm <nod.helm@gmail.com>
Subject: [PATCH v2 4/5] contrib/subtree/Makefile: Doc-gen rules cleanup
Date: Sat,  3 May 2014 22:49:34 +1000
Message-ID: <1399121375-14727-5-git-send-email-nod.helm@gmail.com>
References: <1399121375-14727-1-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-2-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-3-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-4-git-send-email-nod.helm@gmail.com>
Cc: greend@obbligato.org, apenwarr@gmail.com, gpmcgee@gmail.com,
	peff@peff.net, mmogilvi_git@miniinfo.net,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 14:50:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgZOn-0003hD-13
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 14:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbaECMu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 08:50:28 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:48438 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaECMu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 08:50:27 -0400
Received: by mail-pd0-f173.google.com with SMTP id y10so2278569pdj.18
        for <git@vger.kernel.org>; Sat, 03 May 2014 05:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wHN8q9SsPNpEMF2gjzf5i6kQwrtSLgEUD4n0e6Tw+Z8=;
        b=omz6vISQ5Nj5QFz3XlIQr10YxgDcVB0qEAtDoDWDMED99B3RepyJ63l5yvwgjIEikB
         g3KQtG1+7FwQyN4kOQgm5vDk5ov/b0QvtNvuLXOgb39+5+DngmEb7k4kX05iYw7LZGAX
         KxCKvTj3PLrPvnM7sfL8aeAEtbyb+jXYu38pK5LD6XXWszsjCG0IzxKzrYM8tr+CT0rb
         uhdxqHUa6+CgqFLlAZoO7VYlClyQfPSjquTSI/EeeAY+f96/6lvKc/cU2zdR2d5F7m0R
         IUT7A8EmxDUEgqo3UxK0CxYyHuOGm6dkSlM0AKUrt0gh4Orp8KiCMUEfu2E4tvJnNcbX
         TZyg==
X-Received: by 10.66.192.73 with SMTP id he9mr5175841pac.88.1399121426820;
        Sat, 03 May 2014 05:50:26 -0700 (PDT)
Received: from localhost.localdomain ([101.119.28.56])
        by mx.google.com with ESMTPSA id lr3sm18047379pab.4.2014.05.03.05.50.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 May 2014 05:50:25 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
In-Reply-To: <1399121375-14727-4-git-send-email-nod.helm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248042>

git:Documentation/Makefile establishes asciidoc/xmlto calls as being
handled through their appropriate variables, Hence, change to bring into
congruency with.

Similarly, MANPAGE_XSL exists in git:Documentation/Makefile, while
MANPAGE_NORMAL_XSL does not outside contrib/subtree. Hence, replace
MANPAGE_NORMAL_XSL with MANPAGE_XSL.

Signed-off-by: James Denholm <nod.helm@gmail.com>
---
 contrib/subtree/Makefile | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 579bb51..f3834b5 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -14,8 +14,11 @@ man1dir ?= $(mandir)/man1
 # this should be set to a 'standard' bsd-type install program
 INSTALL ?= install
 
-ASCIIDOC_CONF      = ../../Documentation/asciidoc.conf
-MANPAGE_NORMAL_XSL =  ../../Documentation/manpage-normal.xsl
+ASCIIDOC = asciidoc
+XMLTO    = xmlto
+
+ASCIIDOC_CONF = ../../Documentation/asciidoc.conf
+MANPAGE_XSL   = ../../Documentation/manpage-normal.xsl
 
 GIT_SUBTREE_SH := git-subtree.sh
 GIT_SUBTREE    := git-subtree
@@ -43,14 +46,14 @@ install-man: $(GIT_SUBTREE_DOC)
 	$(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
 
 $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
-	xmlto -m $(MANPAGE_NORMAL_XSL)  man $^
+	$(XMLTO) -m $(MANPAGE_XSL) man $^
 
 $(GIT_SUBTREE_XML): $(GIT_SUBTREE_TXT)
-	asciidoc -b docbook -d manpage -f $(ASCIIDOC_CONF) \
+	$(ASCIIDOC) -b docbook -d manpage -f $(ASCIIDOC_CONF) \
 		-agit_version=$(GIT_VERSION) $^
 
 $(GIT_SUBTREE_HTML): $(GIT_SUBTREE_TXT)
-	asciidoc -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) \
+	$(ASCIIDOC) -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) \
 		-agit_version=$(GIT_VERSION) $^
 
 test:
-- 
1.9.2
