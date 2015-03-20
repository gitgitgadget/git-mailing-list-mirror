From: Thomas Schneider <thosch97@gmail.com>
Subject: [PATCH] Documentation: Add target to build PDF manpages
Date: Fri, 20 Mar 2015 12:23:04 +0100
Message-ID: <1426850584-9951-1-git-send-email-thosch97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Schneider <thosch97@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 12:23:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYv1U-0006HX-St
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 12:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbbCTLXY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2015 07:23:24 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37895 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbbCTLXM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 07:23:12 -0400
Received: by wibgn9 with SMTP id gn9so11142290wib.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 04:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=9CxSE8Kj+GQLlD5FyGE1vyFEdwfPmJtjajmVPUZqaxk=;
        b=dSK9VCmmu4qycHWdZJODCp0VM+quO9unLFKg1zBMyR0iwlLv8jv6HD7gf2WlLcpIE/
         veHtB5pQo6hFgGAtB8oJUSpYOsaziBV4M69jFFxnNzPOFJqa6Az9tlOVeUBUu/75E4bd
         kKxezVanWjFmr87lrFaKy4FIe5Tl3PB9980EGeXRSUsUbVDI2m8GXc9tJ4J86mp5N5c+
         ciK0ZLszKUpYV3YSR3KciYmUSarhuair6+iEt3OdOeTHW0Wi3LU5M6Yg2m/wsUZFNZkT
         rnUpefNw9dZHfd5eibiBc/BgvZsEPfU4pmPJlXMtZ6KkrHNSHTvL01g6j3xHUH1+DP2Q
         DAdw==
X-Received: by 10.194.143.20 with SMTP id sa20mr108379104wjb.75.1426850590995;
        Fri, 20 Mar 2015 04:23:10 -0700 (PDT)
Received: from tatooine.fritz.box (p4FEF8755.dip0.t-ipconnect.de. [79.239.135.85])
        by mx.google.com with ESMTPSA id hl8sm5921832wjb.38.2015.03.20.04.23.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2015 04:23:10 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265902>

Signed-off-by: Thomas Schneider <thosch97@gmail.com>
---
dblatex does print some warnings, but they seem to be irrelevant.
Besides, first patch I submit to git or even to any project using a
mailing list =E2=80=A6 let=E2=80=99s hope I did everything right :)

 Documentation/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3e39e28..158cbd9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -38,6 +38,7 @@ MAN7_TXT +=3D gitworkflows.txt
 MAN_TXT =3D $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML =3D $(patsubst %.txt,%.xml,$(MAN_TXT))
 MAN_HTML =3D $(patsubst %.txt,%.html,$(MAN_TXT))
+MAN_PDF =3D $(patsubst %.txt,%.pdf,$(MAN_TXT))
=20
 OBSOLETE_HTML +=3D everyday.html
 OBSOLETE_HTML +=3D git-remote-helpers.html
@@ -223,7 +224,7 @@ man7: $(DOC_MAN7)
=20
 info: git.info gitman.info
=20
-pdf: user-manual.pdf
+pdf: user-manual.pdf $(MAN_PDF)
=20
 install: install-man
=20
@@ -248,6 +249,7 @@ install-info: info
 install-pdf: pdf
 	$(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir)
 	$(INSTALL) -m 644 user-manual.pdf $(DESTDIR)$(pdfdir)
+	$(INSTALL) -m 644 $(MAN_PDF) $(DESTDIR)$(pdfdir)
=20
 install-html: html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
@@ -328,6 +330,11 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
=20
+%.pdf: %.xml
+	$(QUIET_DBLATEX)$(RM) $@+ $@ && \
+	$(DBLATEX) -o $@+ -p $(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.xsl -s =
$(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.sty $< && \
+	mv $@+ $@
+
 %.xml : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_XML) -d manpage -o $@+ $< && \
--=20
2.1.0
