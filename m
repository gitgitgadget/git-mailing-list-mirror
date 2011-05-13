From: Osamu OKANO <okano.osamu@gmail.com>
Subject: [PATCH 1/7] Add new target pot in Makefile
Date: Fri, 13 May 2011 22:14:12 +0900
Message-ID: <1305292458-3920-2-git-send-email-okano.osamu@gmail.com>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
Cc: Osamu OKANO <okano.osamu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 15:14:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKsCc-0006cz-8q
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 15:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759312Ab1EMNOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 09:14:39 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59800 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759311Ab1EMNOh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 09:14:37 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so1148277pvg.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 06:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=PEr8UqKTKebP4cz+N/FtNbNT67GzbrCaH9Pr0GnOXL4=;
        b=sFKINRuKI8Xhd6wDYtWJ9C9PlvyZVnsqZ4FGhcLmIBprXRdGJlQFhOIk9OhVC41Tno
         q3pD7M6tzbNpQY1ys5+rH3BihjJKjoDK+dMGf5UN+g4u7B1xWunBn0PUAYUFoivIr/jl
         umle9BcqGq7YsjX8jeY0gIygDKpR2aDEB0ThQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ji4eCczTmAEpNgx6F6IC727DxBqLTr+FTdC2rq6aHgZfBZzXOT4fcOm5OYRmKDrwUi
         t63tIwoI0pCl01+0C6bxKOtDynnMfLFKCLdYumeSySJIM/Q7FhrdoAoF9LfHXasbg2ZV
         CZyrpWQ9SiCQ3TBXG3ziKHZZxd/Gb1zEVBpQE=
Received: by 10.68.43.7 with SMTP id s7mr2261237pbl.86.1305292477300;
        Fri, 13 May 2011 06:14:37 -0700 (PDT)
Received: from localhost.localdomain (i118-20-60-90.s04.a013.ap.plala.or.jp [118.20.60.90])
        by mx.google.com with ESMTPS id q20sm1358319pbt.72.2011.05.13.06.14.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 May 2011 06:14:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.169.g505a1.dirty
In-Reply-To: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173531>

---
 Documentation/.gitignore |    1 +
 Documentation/Makefile   |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 1c3a9fe..0d8dc2e 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -3,6 +3,7 @@
 *.[1-8]
 *.made
 *.texi
+*.pot
 git.info
 gitman.info
 howto-index.txt
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 36989b7..ac97d5f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -11,6 +11,7 @@ MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
 MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
+MAN_POT=$(patsubst %.txt,%.pot,$(MAN_TXT))
 
 DOC_HTML=$(MAN_HTML)
 
@@ -41,6 +42,7 @@ man7dir=$(mandir)/man7
 # DESTDIR=
 
 ASCIIDOC=asciidoc
+PO4AG=po4a-gettextize
 ASCIIDOC_EXTRA =
 MANPAGE_XSL = manpage-normal.xsl
 XMLTO_EXTRA =
@@ -151,6 +153,7 @@ ifndef V
 	QUIET_SUBDIR0	= +@subdir=
 	QUIET_SUBDIR1	= ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			  $(MAKE) $(PRINT_DIR) -C $$subdir
+	QUIET_PO4AG	= @echo '   ' PO4AG $@;
 	export V
 endif
 endif
@@ -166,6 +169,8 @@ man1: $(DOC_MAN1)
 man5: $(DOC_MAN5)
 man7: $(DOC_MAN7)
 
+pot: $(MAN_POT)
+
 info: git.info gitman.info
 
 pdf: user-manual.pdf
@@ -230,7 +235,7 @@ cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
 	date >$@
 
 clean:
-	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
+	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7 *.pot
 	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
 	$(RM) howto-index.txt howto/*.html doc.dep
 	$(RM) technical/api-*.html technical/api-index.txt
@@ -256,6 +261,14 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
 	mv $@+ $@
 
+%.pot : %.txt
+	$(QUIET_PO4AG)$(RM) $@+ $@ && \
+	$(PO4AG) --master-charset UTF8 --localized-charset UTF8 \
+		--master `basename $@ .pot`.txt \
+		--format text --option asciidoc \
+		--po $@+ $< && \
+	mv $@+ $@
+
 user-manual.xml: user-manual.txt user-manual.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b docbook -d book -o $@+ $< && \
-- 
1.7.5.1.169.g505a1.dirty
