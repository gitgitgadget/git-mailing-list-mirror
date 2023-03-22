Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9914C6FD1D
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 00:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjCVAIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 20:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVAIT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 20:08:19 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D617CC2
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 17:08:17 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id d22-20020a9d5e16000000b0069b5252ced7so9509874oti.13
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 17:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679443696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kenCh6b4XiIBij7pxdd65sM059n8fEQF7/9HDTQijOU=;
        b=ic1F2LyPZB4e4hl/U5GD9HgjJcW0ZXNQjOwcHgeHk1e/t9A0DcsTqOoo/yjf93uwGa
         VRL8CZPD/eTbLmE5mZh0a+711p0O2miK3Klt1foM3OHXCyy//MGfalCRpbhmP92iTLwU
         1+AaD7kp9bRgl5wHFwoIxHfx3GYA183lHgoi04nosR4Sv01l1K/6fDVN19UtKEvQnFMj
         3JAg9OE40FObwTWVY6DS/3U0Qgwmps/T0nnE4W0yvKDwo/Rnx+csJYZLVDDbZzJH4yLo
         4010aztGHOvd7XrsI/hYP+mbVT6D4mQy72ZMW/QqiXIwLvs2ZxYtb7Pg6PvJMsVAM16q
         vePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679443696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kenCh6b4XiIBij7pxdd65sM059n8fEQF7/9HDTQijOU=;
        b=gOoyBLf1jpEw7E82n9HVN4Er7OCEQ3Jgg9IvwmgkY6gQ/TiaUXnfTihtA+gqMNn2GQ
         8Yhm3RGYaxlOBsdx/mQxcc+ZBXU0corUnNTMYnQUEvwVl4i06zUdXOf8H1P9dpJTj0jc
         ukeBJQixujaVA0jHpRgLHC9a2QPfRy6uw5zzGVT1YYaGtK8RChfalhQJ9VlruC9oQOSv
         m85iQUTckYjXpBskYg0s5UHoGbGbfOP49PIee3qxstLuzTkqCABQD3fzp32p4ffy7r5a
         LXEx/PJqs3xzxdFSwyCAxagGq7BLrTuyqcNzpde2dVvLX/IBd0Pih40bnMRfT6JpQz+E
         a5hg==
X-Gm-Message-State: AO0yUKWkIXEad/TydnQwx19F34x19WOUWYRzME/Y1Zxg+N6g4ul0ajIL
        e1QGXLNiWM+7Rxf+JeeS0hxnAUnmmtw=
X-Google-Smtp-Source: AK7set9Ci3j5ZnmOf5mHUZTww55GM59IL+isFzwvs0WyCKYyiRpxDYanPAbujEf0DRToJL4zZk6Pcw==
X-Received: by 2002:a05:6830:108f:b0:690:ef1f:6191 with SMTP id y15-20020a056830108f00b00690ef1f6191mr504966oto.32.1679443696464;
        Tue, 21 Mar 2023 17:08:16 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id z18-20020a9d62d2000000b0068d4649bedasm5678514otk.67.2023.03.21.17.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 17:08:15 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] doc: remove manpage-base-url workaround
Date:   Tue, 21 Mar 2023 18:08:15 -0600
Message-Id: <20230322000815.132128-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 50d9bbba92 (Documentation: Avoid use of xmlto --stringparam,
2009-12-04) introduced manpage-base-url.xsl because ancient versions of
xmlto did not have --stringparam.

However, that was more than ten years ago, no need for that complexity
anymore, we can just use --stringparam.

Cc: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/.gitignore              |  1 -
 Documentation/Makefile                |  9 ++-------
 Documentation/manpage-base-url.xsl.in | 10 ----------
 3 files changed, 2 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/manpage-base-url.xsl.in

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 1c3771e7d7..a48448de32 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -10,7 +10,6 @@ howto-index.txt
 doc.dep
 cmds-*.txt
 mergetools-*.txt
-manpage-base-url.xsl
 SubmittingPatches.txt
 tmp-doc-diff/
 GIT-ASCIIDOCFLAGS
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9c67c3a1c5..11a0093709 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -189,7 +189,7 @@ endif
 ifndef MAN_BASE_URL
 MAN_BASE_URL = file://$(htmldir)/
 endif
-XMLTO_EXTRA += -m manpage-base-url.xsl
+XMLTO_EXTRA += --stringparam man.base.url.for.relative.links='$(MAN_BASE_URL)'
 
 # If your target system uses GNU groff, it may try to render
 # apostrophes as a "pretty" apostrophe using unicode.  This breaks
@@ -339,7 +339,6 @@ clean:
 	$(RM) technical/*.html technical/api-index.txt
 	$(RM) SubmittingPatches.txt
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
-	$(RM) manpage-base-url.xsl
 	$(RM) GIT-ASCIIDOCFLAGS
 
 $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
@@ -348,11 +347,7 @@ $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
 $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
 
-manpage-base-url.xsl: manpage-base-url.xsl.in
-	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
-
-
-manpage-prereqs := manpage-base-url.xsl $(wildcard manpage*.xsl)
+manpage-prereqs := $(wildcard manpage*.xsl)
 manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
 %.1 : %.xml $(manpage-prereqs)
diff --git a/Documentation/manpage-base-url.xsl.in b/Documentation/manpage-base-url.xsl.in
deleted file mode 100644
index e800904df3..0000000000
--- a/Documentation/manpage-base-url.xsl.in
+++ /dev/null
@@ -1,10 +0,0 @@
-<!-- manpage-base-url.xsl:
-     special settings for manpages rendered from newer docbook -->
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
-		version="1.0">
-
-<!-- set a base URL for relative links -->
-<xsl:param name="man.base.url.for.relative.links"
-	>@@MAN_BASE_URL@@</xsl:param>
-
-</xsl:stylesheet>
-- 
2.39.2.13.g1fb56cf030

