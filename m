From: Michael Darling <darlingm@gmail.com>
Subject: [PATCH] Documentation: Alternate name for docbook2x-texi binary
Date: Wed, 13 May 2015 04:28:30 -0400
Message-ID: <CABRuA+icJWgbpFaV=6t1zOaLfrG3i_vSpm1rwOOyp=+0eBL4zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 10:28:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsS1u-00045c-EQ
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 10:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933434AbbEMI2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 04:28:34 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34610 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbbEMI2c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 04:28:32 -0400
Received: by wicmc15 with SMTP id mc15so72579256wic.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=HNiTOsVG9ef099LpIQDxm2rjSfBVRXBu8WKXgAQLFCM=;
        b=s+4rWyFTrMG/d8oFsrJh7dsUQx68dyTybYRepPGYoPnoUxO7x6oK3A0wd2mXOm6xDb
         kfap7vqtSiYLwjXEXtGD6tOZmq7IyKmuQx7/S4/wNMtDepQzFzIOIX24NgtK7yT7UFFs
         g+LmrbOrP5wjt5qXp95+b0zdx6u+bNnr5FMVuAG53XPApC3X6F07MiXLs/i2muJG9uXO
         sapHF2nRwDRnVyCE6o9qDjdvi06RDQ6cRhcrcjK/QnQKzxwJbFM8/jjYJuM5Y7+ax+iO
         XowF0czx5rcsxfCzDDeAkJ75cwANIDBzpLPZh+Lal/FrFekcmnd9CDk8I5pys5aW9cwS
         IPKg==
X-Received: by 10.180.102.74 with SMTP id fm10mr3481333wib.25.1431505710880;
 Wed, 13 May 2015 01:28:30 -0700 (PDT)
Received: by 10.28.167.2 with HTTP; Wed, 13 May 2015 01:28:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268947>

In Fedora 21, docbook2x-texi binary is named db2x_docbook2texi.
If binary docbook2-texi is not found, looks for db2x_docbook2texi.
Also gives an error if neither is found.

Signed-off by: Michael Darling <darlingm@gmail.com>
---
 Documentation/Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3e39e28..f5f9ad5 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -116,7 +116,15 @@ HTML_REPO = ../../git-htmldocs

 MAKEINFO = makeinfo
 INSTALL_INFO = install-info
-DOCBOOK2X_TEXI = docbook2x-texi
+
+DOCBOOK2X_TEXI = $(shell which docbook2x-texi)
+ifeq (, $(DOCBOOK2X_TEXI))
+DOCBOOK2X_TEXI = $(shell which db2x_docbook2texi)
+ifeq (, $(DOCBOOK2X_TEXI))
+$(error Did not find docbook2x-texi or db2x_docbook2texi, required)
+endif
+endif
+
 DBLATEX = dblatex
 ASCIIDOC_DBLATEX_DIR = /etc/asciidoc/dblatex
 ifndef PERL_PATH
-- 
2.4.0.53.g8440f74
