From: Derek Moore <derek.p.moore@gmail.com>
Subject: DOCBOOK2X_TEXI in Documentation/Makefile invalid on some distributions
Date: Thu, 9 Oct 2014 12:53:33 -0500
Message-ID: <CAMsgyKb-ffkfqRhG-dUkwpnKOcA=3CrZqT57qcqTr+9zm_v2Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 19:53:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcHuF-0007wG-4i
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 19:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbaJIRxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 13:53:35 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:39511 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbaJIRxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 13:53:34 -0400
Received: by mail-oi0-f50.google.com with SMTP id i138so3950410oig.23
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=NpjQ4xUz+4+OeqUORn9vIG5QjEPxV3b35wUya3lDCPQ=;
        b=jr94bfzff2cr2x+qeuGuxm0hKTVfGmM3KNnPJdsBmbwq7Loryo9Rz/RFi7/R/JN1YU
         HLmh7153pQk0lTNYYNWepnZRYzMyxDIWTBldjcIj942TjxvkKcxTLZzyME/0gEiddoUS
         RlUCotxp7Fs4zvuERlB5dy8GxLuZW89TlHrUGmGaBadk3qBA6jm22mUHe7xZH9XuJ5Pn
         hT2psjFjqomH20JBLj79Lg15bhLh6B7PJ/jheFKwCkZG/hcr7n/X2/+fi7X83L/BAVXH
         7Pp/iMbITvkb5J+GiTIaJRqDuqcTWP7oaOhukqSQZe0lmlD4PC01Q16wh3P7RAC0ZI7T
         hfwg==
X-Received: by 10.182.246.2 with SMTP id xs2mr25174959obc.63.1412877213880;
 Thu, 09 Oct 2014 10:53:33 -0700 (PDT)
Received: by 10.76.33.68 with HTTP; Thu, 9 Oct 2014 10:53:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following the INSTALL doc, I was building git with:

make prefix=/usr/local all doc info

Even after installing docbook2X, I couldn't get past the first DB2TEXI
build step until I discovered that 'docbook2x-texi' is named
'db2x_docbook2texi' in Fedora 21 using the latest upstream docbook2X
0.8.8.

To the "everything" build to complete, I had to make this change:

$ git diff
diff --git a/Documentation/Makefile b/Documentation/Makefile
index cea0e7a..0e6c70a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -107,7 +107,7 @@ HTML_REPO = ../../git-htmldocs

 MAKEINFO = makeinfo
 INSTALL_INFO = install-info
-DOCBOOK2X_TEXI = docbook2x-texi
+DOCBOOK2X_TEXI = db2x_docbook2texi
 DBLATEX = dblatex
 ASCIIDOC_DBLATEX_DIR = /etc/asciidoc/dblatex
 ifndef PERL_PATH


I searched the mailing list, but don't see 'db2x_docbook2texi'
mentioned since 2010, so I feel somewhat safe brining it up again.

Not sure if the Makefile should somehow conditionally use one or the
other of these commands. ... Or maybe I should have gone the 'make
configure' route?

Thanks,

Derek
