Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 502FB1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeH2BOw (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:14:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:45867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeH2BOw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:14:52 -0400
Received: from localhost.localdomain ([185.190.160.130]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Ma2Lr-1gDnRu2Sat-00Lj6F; Tue, 28 Aug 2018 23:21:21 +0200
From:   Tim Schumacher <timschumi@gmx.de>
To:     git@vger.kernel.org
Cc:     timschumi@gmx.de
Subject: [PATCH] doc: Don't echo sed command for manpage-base-url.xsl
Date:   Tue, 28 Aug 2018 23:21:04 +0200
Message-Id: <20180828212104.2515-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.0.rc1.1.g093671f86
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uYl5FHqELOx/9k2/vgT93UYDjdFiYciN/sQ3x+q1b/DaSIKqjkU
 YrVHf+z32G+NnovbA81TSrzlyJVAnm8VJFcQRl0vYuAGRehLyAO0IfTXjprOx9WfOpNR6rz
 Y+1hgZy+oh/ueIEAbYRVkyisVftlIMxlh1GIXmBt+7YpDoAx/HCEiqu9w0lAcI95g0F85zJ
 nCynOch0ZZDmN7i/SwabA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fo/hzWQKA64=:01UQohP+fd6kZD3DJbjF2l
 WPptogPSFBsxPSJtf0cLTh3l/km2EMHA7J6DzDyNwWoRCgIkosgBwt3nOjUbJMMTwFvKVmpv+
 4FJdsUJm+kJ+dKvCeRfeVT7GqXiwlmx7x43vDov6j+5BEN56LtVCFaeG4YzSvLxXWltY8TnN/
 nNGYVErcqgQktm8SNMMgn7uvX/W1V9stTyK4n5QuODsSfL9KTi6xkCDMTwFxpnxfVPrce509n
 q4fBoM8K+RrOy8uTpTLRh3+RZq9dgRxMdnVNwM0A93rbzWDR3gQCzAgNxJq31JxcKdc4zDwDV
 t6e6YsoTxuj+nP2PpLT1thNw9tJ6dRB/GNXCXoW18oIkn5UppC+yCw0y1z4o5zJp/MsVFIlAg
 Z52w7ypSm+d2/pZE2fwp6kqqfr3WbhgQ/8fV4lnmvxsQ9gY1nzJT6JkyOuYvsGJH2x3bz5A70
 74hMHtvexwhIs9Qcep5gOLoG2u44IqHsK25enk+dhBjErvOGnZShWgE6mc240glFk7SlN14m/
 W1DfeGE+jExCSwolPxucXLEpCs8+WdS3ClgL3kLbAeLPyqmPX5jsoSarq+52nU9F6FA8dW/VJ
 zGEMTf3lxTI/VEII3IizcA99/zKduqyXiCD9g6nL4703+rGljpVkMdQ7ZZoZQR04QwNrlLj4I
 eT9DWRdqbBQZIx9/OgEqr0fpjMNi2Ce2tIJa65e9yXYmEPNd5+4VbbWmqlavQI57VPZuv26lo
 2thCNyeY4nbwsG8Ux60oN3WbZUI9CVDtLl/6C2C9Tl+EIMtIZr9w4uBKQsY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, the sed command for generating manpage-base-url.xsl
was printed to the console when being run.

For the purpose of silencing it, define a $(QUIET) variable which
contains an '@' if verbose mode isn't enabled and which is empty
otherwise. This just silences the command invocation without doing
anything else.

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
---
 Documentation/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a42dcfc74..45454e9b5 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -217,6 +217,7 @@ endif
 
 ifneq ($(findstring $(MAKEFLAGS),s),s)
 ifndef V
+	QUIET		= @
 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
 	QUIET_XMLTO	= @echo '   ' XMLTO $@;
 	QUIET_DB2TEXI	= @echo '   ' DB2TEXI $@;
@@ -344,7 +345,7 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
 	mv $@+ $@
 
 manpage-base-url.xsl: manpage-base-url.xsl.in
-	sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
+	$(QUIET)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl
 	$(QUIET_XMLTO)$(RM) $@ && \
-- 
2.19.0.rc0

