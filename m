Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DC7C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 13:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A9F2074A
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 13:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqGtH/8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgC2NSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 09:18:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39844 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgC2NSi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 09:18:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id i20so14958142ljn.6
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aEhTBLzq6Z0uaJe/3d4aCXwFJLNCBnccUnX+9ieUUiw=;
        b=dqGtH/8vHgg0R6TzCrEvpTEE8ZEi1NeUvKx7EXByZEPRsxLqP0VGbQvIhfuQQ39dq9
         2fDPXAvAIR35u/iUgQozLKrtd9nyxRP+jtDRpNNcbF/sjU0txjO25WDlxqnOpYoDh4x/
         W//4TEM8AAdh2haIZkry+QmaOc7rxTQJCYo+zcfKn6bUy8M6AAuSlnwzOt05Ks+yazNy
         O9uxmHJycalmgrF2J9gOdFpstYhOXXZjR8/x6bUI8JgY3lG38aMj4hgg75mA5buoAUZI
         U9mAaFRhtJpyuZRVzPIZIRDZj3DfcKVt1kLzmOdWhSIhnVoAZP1m3qSDkQRqEKKtV0Xw
         iVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aEhTBLzq6Z0uaJe/3d4aCXwFJLNCBnccUnX+9ieUUiw=;
        b=PVG5vp4dJnhJWaLta023EZ/fvenBsrdhmY5eiazXII0SelxTh7XieC4Ri9kgvtr2d7
         Q2v9ngOdOy/p4LmUWM3NNsCNkmhspV+Ste3RAy0oqXu8F1roEGq8+8SHOTO2Rcd4z0S0
         ttjzqQuLfsswsKXOkm1gw5VyIsC0N9dW790DZ8jiL3CMt/JliVgiO50A9gkTNVFrJBgl
         JJ1PBhABDyaEBgJeaugxBSEEFt9so6+rET/85stHCgIdOCn/ArKsHUBPlVCV/n7T/KC1
         NWzpiB4H1G7Jjt0+duE0NXWSeCPqVozNhLu7g47oqaHtWUzFPHkRcA5d7sDA5jrbLkkT
         Gatw==
X-Gm-Message-State: AGi0PuYHRbAVeVu5gtcDijx+3zPt3evj7opEOChUAOt65HCnUMdij0hs
        +68zMFpFxzx5xjfFKcMOWT7I3hiV
X-Google-Smtp-Source: APiQypJcC1FBeemU+6nAt97tn9AJs42yoYl30n7Bqfjwt94zlQltW2Jqw8rTBsTGFkCQ6003+EdVLg==
X-Received: by 2002:a2e:b4f1:: with SMTP id s17mr2176259ljm.283.1585487915309;
        Sun, 29 Mar 2020 06:18:35 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id d16sm1247742lfm.91.2020.03.29.06.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 06:18:34 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 5/6] manpage-normal.xsl: fold in manpage-base.xsl
Date:   Sun, 29 Mar 2020 15:18:09 +0200
Message-Id: <defc062a32307fee8b36cfdd8a60a6843a2f6260.1585486103.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585486103.git.martin.agren@gmail.com>
References: <cover.1585486103.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After an earlier commit, we only include manpage-base.xsl from a single
file, manpage-normal.xsl. Fold the former into the latter.

We only ever needed the "base, normal and non-normal" construct to
support a single non-normal case, namely to work around issues with
docbook-xsl 1.72 handling backslashes and dots. If we ever need
something like this again, we can re-introduce manpage-base.xsl and
friends. Whatever issue we'd be trying to work around, it probably
wouldn't involve dots and backslashes like this, anyway.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/manpage-base.xsl   | 35 --------------------------------
 Documentation/manpage-normal.xsl | 22 ++++++++++++++++----
 2 files changed, 18 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/manpage-base.xsl

diff --git a/Documentation/manpage-base.xsl b/Documentation/manpage-base.xsl
deleted file mode 100644
index a264fa6160..0000000000
--- a/Documentation/manpage-base.xsl
+++ /dev/null
@@ -1,35 +0,0 @@
-<!-- manpage-base.xsl:
-     special formatting for manpages rendered from asciidoc+docbook -->
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
-		version="1.0">
-
-<!-- these params silence some output from xmlto -->
-<xsl:param name="man.output.quietly" select="1"/>
-<xsl:param name="refentry.meta.get.quietly" select="1"/>
-
-<!-- convert asciidoc callouts to man page format;
-     git.docbook.backslash and git.docbook.dot params
-     must be supplied by another XSL file or other means -->
-<xsl:template match="co">
-	<xsl:value-of select="concat(
-			      $git.docbook.backslash,'fB(',
-			      substring-after(@id,'-'),')',
-			      $git.docbook.backslash,'fR')"/>
-</xsl:template>
-<xsl:template match="calloutlist">
-	<xsl:value-of select="$git.docbook.dot"/>
-	<xsl:text>sp&#10;</xsl:text>
-	<xsl:apply-templates/>
-	<xsl:text>&#10;</xsl:text>
-</xsl:template>
-<xsl:template match="callout">
-	<xsl:value-of select="concat(
-			      $git.docbook.backslash,'fB',
-			      substring-after(@arearefs,'-'),
-			      '. ',$git.docbook.backslash,'fR')"/>
-	<xsl:apply-templates/>
-	<xsl:value-of select="$git.docbook.dot"/>
-	<xsl:text>br&#10;</xsl:text>
-</xsl:template>
-
-</xsl:stylesheet>
diff --git a/Documentation/manpage-normal.xsl b/Documentation/manpage-normal.xsl
index c9c68a0542..a9c7ec69f4 100644
--- a/Documentation/manpage-normal.xsl
+++ b/Documentation/manpage-normal.xsl
@@ -3,10 +3,24 @@
 <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 		version="1.0">
 
-<xsl:import href="manpage-base.xsl"/>
 
-<!-- these are the normal values for the roff control characters -->
-<xsl:param name="git.docbook.backslash">\</xsl:param>
-<xsl:param name="git.docbook.dot"	>.</xsl:param>
+<!-- these params silence some output from xmlto -->
+<xsl:param name="man.output.quietly" select="1"/>
+<xsl:param name="refentry.meta.get.quietly" select="1"/>
+
+<!-- convert asciidoc callouts to man page format -->
+<xsl:template match="co">
+	<xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
+</xsl:template>
+<xsl:template match="calloutlist">
+	<xsl:text>.sp&#10;</xsl:text>
+	<xsl:apply-templates/>
+	<xsl:text>&#10;</xsl:text>
+</xsl:template>
+<xsl:template match="callout">
+	<xsl:value-of select="concat('\fB',substring-after(@arearefs,'-'),'. \fR')"/>
+	<xsl:apply-templates/>
+	<xsl:text>.br&#10;</xsl:text>
+</xsl:template>
 
 </xsl:stylesheet>
-- 
2.26.0

