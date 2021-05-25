Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE87C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77046142B
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhEYKtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhEYKti (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:49:38 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA426C061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:07 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so28156772otg.2
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVfA+XzfYuaTMZ3HnvQZ29VZquEKJ3+s/p2eSQyca7U=;
        b=t0qJsLZvgZXxee44YhUyvooEo7giwVwJkwYY28aWMAbqO0JRJTIsp/WzVNv4STetui
         FLvKNUe71Z3GjfenIAepwutXH9BAKeCPMVOE38K6fKLT+FbtLNb42s4dlr8LRpTWcJEf
         MAWYu3s19Y5HGOegOap5gsIlt3qraydpYStoMKz+pcL0G65T33K/h9D0fqKnSxWufkVv
         AON/LvovkxOtWcek2aenD4J0s0IBpukWnKCmXL5Y4viW0FtdKdgUvEZaS9Rs/Q7QKpR4
         yoxdkTnoOSNgkUMZQWER0zVg+DboN6xr3IRpGTUS+2bCYoGFjGhFooyNzObuqwfPvlIr
         4U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVfA+XzfYuaTMZ3HnvQZ29VZquEKJ3+s/p2eSQyca7U=;
        b=NRo/qGqlZ/ffJjrjq2LmYMjJOazmYmzJddze9QIwLhMG8uYCNkJmkheo2E8Rqjvg3K
         I5kB/z2SEkXb5HqMeXOkw/6k+B3KS+7qWB0/Vm/cWJweiPAyz5kppvsIp1Wxk9xGWWcR
         sdCjUMvagufdZorjNdm/uQlNN1QEsipw19HzBW/Xi7V5b2Vn3naoJv1POcZW0CvuKl6m
         K5+vqv2aLbncXYadjUNUMW+Rgvby2wMm99LGfSdSBBx9XyQVwbqos/kVt3zNXQ2KQAGw
         wMTBeGUpiFrTz2Gu3qUaziZwpBGX5F25rYhlFjeKVWd7Apk+k32WInX5mLxejeZsXBGg
         8qPQ==
X-Gm-Message-State: AOAM5339qrN61PEfNamzeI0eK4oOpV0ayMxKfAVZ1sMcHbWvff8JfXgq
        mI3AB6CRai+9TFMM7nAaQYXWB4kftM0N0g==
X-Google-Smtp-Source: ABdhPJwu2e0TTauGXJsccSsp2TEO0dOSo2/4pf3mTY1mXQ0+k47P+S3RHKm9LEf/F6MXZjBL6fOQgQ==
X-Received: by 2002:a9d:4101:: with SMTP id o1mr23174129ote.281.1621939686984;
        Tue, 25 May 2021 03:48:06 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id t39sm3371515ooi.42.2021.05.25.03.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:48:06 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 02/12] doc: use --stringparam in xmlto
Date:   Tue, 25 May 2021 05:47:52 -0500
Message-Id: <20210525104802.158336-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525104802.158336-1-felipe.contreras@gmail.com>
References: <20210525104802.158336-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 50d9bbba92 (Documentation: Avoid use of xmlto --stringparam,
2009-12-04) introduced manpage-base-url.xsl because ancient versions of
xmlto did not have --stringparam.

However, that was more than ten years ago, no need for that complexity
anymore.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/.gitignore              |  1 -
 Documentation/Makefile                |  8 ++------
 Documentation/manpage-base-url.xsl.in | 10 ----------
 3 files changed, 2 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/manpage-base-url.xsl.in

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 9022d48355..e9f8d693b1 100644
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
index bf1f66b3eb..84643a34e9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -176,7 +176,7 @@ endif
 ifndef MAN_BASE_URL
 MAN_BASE_URL = file://$(htmldir)/
 endif
-XMLTO_EXTRA += -m manpage-base-url.xsl
+XMLTO_EXTRA += --stringparam man.base.url.for.relative.links='$(MAN_BASE_URL)'
 
 ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
@@ -342,7 +342,6 @@ clean:
 	$(RM) technical/*.html technical/api-index.txt
 	$(RM) SubmittingPatches.txt
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
-	$(RM) manpage-base-url.xsl
 	$(RM) GIT-ASCIIDOCFLAGS
 
 $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
@@ -351,10 +350,7 @@ $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
 $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
 
-manpage-base-url.xsl: manpage-base-url.xsl.in
-	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
-
-%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
+%.1 %.5 %.7 : %.xml $(wildcard manpage*.xsl)
 	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
 %.xml : %.txt $(ASCIIDOC_DEPS)
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
2.32.0.rc0

