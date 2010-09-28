From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] Makefile: Add help target
Date: Tue, 28 Sep 2010 01:13:58 -0700
Message-ID: <1285661638-27741-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 10:14:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0VKQ-0004JM-86
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 10:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab0I1IOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 04:14:14 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60631 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab0I1ION (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 04:14:13 -0400
Received: by yxp4 with SMTP id 4so1817984yxp.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 01:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=upGRWPK/7dusqvDX0LsQIiySfVAHC8N93iAuY2EHeg0=;
        b=B7BcRGNmTHU3xa2T92H3UbDwu52XtEWE69/aKttxQFPqFHF9v5T0RPV2RpBKSMq0pl
         4L/jgOn5x9KLv4XNOVi8flUef6++qUMwbY1k0S71QaUJkWExjIROd+1dY+xnkEg7lusA
         3fJ0dmTL++NDmjHm+3AX/KiHyKSw6SJ6hB30Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WRUoeIgFqIAMvRA7VuOyCHwfmy2NIfTj/xxodoxxLI49qu56EDk8H0egfRMoOPMxU8
         zACzNywqyP+gk8BglSTOQboZTnkiiX1lJQp1wPSKKdNMnFkrFpuCteqkaTippgcCkW9z
         e+TGSxyA2Gs3Uxdbv5Rj+bKntEo8kMoX07mqk=
Received: by 10.101.176.35 with SMTP id d35mr7132958anp.107.1285661652163;
        Tue, 28 Sep 2010 01:14:12 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id c19sm7856643ana.2.2010.09.28.01.14.07
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 01:14:11 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 28 Sep 2010 01:13:58 -0700
X-Mailer: git-send-email 1.7.3.16.g5d4d9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157394>

Today I forgot whether the target was quick-install-doc or
install-quick-doc and had to open the Makefile again to find out. I'd
rather not do that and just use:

	$ make help

to get a quick summary of the interesting targets when my brain fails to
refresh. Add a help target, but don't add uninteresting things like
strip, install-gitweb, or targets which alias (install-man).

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Makefile |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b7a62cf..8c8fcb0 100644
--- a/Makefile
+++ b/Makefile
@@ -2366,3 +2366,43 @@ cover_db: coverage-report
 
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
+
+help:
+	@echo 'Cleaning targets:'
+	@echo '  clean      - Remove generated files but keep the configure script'
+	@echo '  distclean  - Remove generated files and the configure script'
+	@echo
+	@echo 'Packaging targets:'
+	@echo '  dist       - Build git-$(GIT_VERSION).tar.gz source tarball'
+	@echo '  rpm        - Build source and binary RPM packages'
+	@echo '  dist-doc   - Build $(manpages).tar.gz and $(htmldocs).tar.gz'
+	@echo
+	@echo 'Documentation targets:'
+	@echo '  doc     - Build man pages and HTML docs'
+	@echo '  man     - Build man pages'
+	@echo '  html    - Build HTML docs'
+	@echo '  info    - Build info docs'
+	@echo '  pdf     - Build PDF docs'
+	@echo
+	@echo 'Installation targets:'
+	@echo '  install             - Install the git suite'
+	@echo '  install-doc         - Install man pages'
+	@echo '  install-html        - Install HTML docs'
+	@echo '  install-info        - Install info docs'
+	@echo '  install-pdf         - Install PDF docs'
+	@echo '  quick-install-doc   - Install pregenerated man pages from origin/man'
+	@echo '  quick-install-html  - Install pregenerated HTML pages from origin/html'
+	@echo
+	@echo 'Common targets:'
+	@echo '  all            - Build the git suite'
+	@echo '  test           - Run the git test suite'
+	@echo
+	@echo 'Other targets:'
+	@echo '  tags/TAGS      - Generate tags for editors'
+	@echo '  cscope         - Generate cscope index'
+	@echo '  coverage       - Build git with gcov support and run the test suite'
+	@echo '  cover_db_html  - Generate HTML coverage report of the test suite coverage'
+	@echo '  check          - Check C sources with sparse'
+	@echo
+	@echo '  make V=1 [targets] verbose build'
+	@echo
-- 
1.7.3.16.g5d4d9
