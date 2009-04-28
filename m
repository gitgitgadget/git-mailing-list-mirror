From: Eric Blake <ebb9@byu.net>
Subject: [PATCH 2/2] doc: consistently use ASCIIDOC_EXTRA
Date: Tue, 28 Apr 2009 06:28:32 -0600
Message-ID: <1240921712-3100-3-git-send-email-ebb9@byu.net>
References: <1240921712-3100-1-git-send-email-ebb9@byu.net>
 <1240921712-3100-2-git-send-email-ebb9@byu.net>
Cc: Eric Blake <ebb9@byu.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 14:34:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LymWI-0006QG-Tu
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 14:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779AbZD1Mee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 08:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754677AbZD1Mee
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 08:34:34 -0400
Received: from qmta14.emeryville.ca.mail.comcast.net ([76.96.27.212]:35588
	"EHLO QMTA14.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753633AbZD1Mee (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 08:34:34 -0400
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Apr 2009 08:34:33 EDT
Received: from OMTA08.emeryville.ca.mail.comcast.net ([76.96.30.12])
	by QMTA14.emeryville.ca.mail.comcast.net with comcast
	id kz6z1b0010FhH24AE0UqKH; Tue, 28 Apr 2009 12:28:50 +0000
Received: from localhost.localdomain ([24.10.247.15])
	by OMTA08.emeryville.ca.mail.comcast.net with comcast
	id l0UP1b0060Lg2Gw8U0Upmo; Tue, 28 Apr 2009 12:28:49 +0000
X-Mailer: git-send-email 1.6.3.rc3.2.g4b51
In-Reply-To: <1240921712-3100-2-git-send-email-ebb9@byu.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117769>

For all uses of $(ASCIIDOC) in Documentation/Makefile, supply the same
options via $(ASCIIDOC_EXTRA).

Signed-off-by: Eric Blake <ebb9@byu.net>
---

I was using asciidoc 8.4.3, and surprised when some, but not all, of the
asciidoc invocations used -a asciidoc7compatible.

 Documentation/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e18242a..7a8037f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -240,7 +240,7 @@ $(MAN_HTML): %.html : %.txt
 	mv $@+ $@

 user-manual.xml: user-manual.txt user-manual.conf
-	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b docbook -d book $<
+	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b docbook -d book $<

 technical/api-index.txt: technical/api-index-skel.txt \
 	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
@@ -293,13 +293,13 @@ howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	mv $@+ $@

 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
-	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 $*.txt
+	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 $*.txt

 WEBDOC_DEST = /pub/software/scm/git/docs

 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	sed -e '1,/^$$/d' $< | $(ASCIIDOC) -b xhtml11 - >$@+ && \
+	sed -e '1,/^$$/d' $< | $(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 - >$@+ && \
 	mv $@+ $@

 install-webdoc : html
-- 
1.6.3.rc3.2.g4b51
