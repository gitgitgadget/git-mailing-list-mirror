From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/3] Add gitmodules(5)
Date: Sat,  9 Jun 2007 23:38:51 +0200
Message-ID: <11814251322779-git-send-email-hjemli@gmail.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 23:36:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8bi-000053-Pd
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 23:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300AbXFIVgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 17:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756241AbXFIVgZ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 17:36:25 -0400
Received: from mail43.e.nsc.no ([193.213.115.43]:53409 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754881AbXFIVgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 17:36:24 -0400
Received: from localhost.localdomain (ti231210a080-7628.bb.online.no [80.213.29.208])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id l59LaKTg006815;
	Sat, 9 Jun 2007 23:36:21 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.1.914.gbd3a7
In-Reply-To: <1181425132239-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49619>

This adds documentation for the .gitmodules file.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/Makefile       |    2 +-
 Documentation/gitmodules.txt |   63 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/gitmodules.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9cef480..2ad18e0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -2,7 +2,7 @@ MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
 	gitk.txt
-MAN5_TXT=gitattributes.txt gitignore.txt
+MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt
 MAN7_TXT=git.txt
 
 DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
new file mode 100644
index 0000000..37888c9
--- /dev/null
+++ b/Documentation/gitmodules.txt
@@ -0,0 +1,63 @@
+gitmodules(5)
+=============
+
+NAME
+----
+gitmodules - defining submodule properties
+
+SYNOPSIS
+--------
+.gitmodules
+
+
+DESCRIPTION
+-----------
+
+The `.gitmodules` file, located in the top-level directory of a
+gitlink:git[7] working tree, is a text file with a layout matching the
+requirements of gitlink:git-config[1].
+
+The file consists of sections named `module`, divided into one subsection
+per submodule. The subsections are named with the logical name of the
+submodule it describes.
+
+Each submodule can contain the following keys.
+
+module.$name.path::
+	Define a path, relative to the top-level directory of the git
+	working tree, where the submodule is expected to be checked out.
+
+module.$name.url::
+	Define a url from where the submodule repository can be cloned.
+
+
+EXAMPLES
+--------
+
+Consider the following .gitmodules file:
+
+	[module 'libfoo']
+		path = include/foo
+		url = git://example1.com/git/libfoo.git
+
+	[module 'libbar']
+		url = git://example2.com/pub/git/libbar.git
+
+
+This defines two submodules, `libfoo` and `libbar`. The former specifies
+both a checkout path and a suggested url, while the latter only specifies
+a url. This file would make gitlink:git-submodule[1] map the path
+`include/foo` to the submodule `libfoo` and the path `libbar` to the
+submodule `libbar`.
+
+SEE ALSO
+--------
+gitlink:git-submodule[1] gitlink:git-config[1]
+
+DOCUMENTATION
+-------------
+Documentation by Lars Hjemli <hjemli@gmail.com>
+
+GIT
+---
+Part of the gitlink:git[7] suite
-- 
1.5.2.1.914.gbd3a7
