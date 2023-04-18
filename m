Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B434EC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 01:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjDRBSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 21:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDRBSc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 21:18:32 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B2149EE
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 18:18:30 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id bv13-20020a0568201b0d00b0053e3ccf739cso3459214oob.10
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 18:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681780710; x=1684372710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QL3vcHLGL2/hJ1GTkjkt4rjFUJx10zuB5gOnmaVkPTw=;
        b=NjfsDK2vR9XJ5gCnPOzNnFPXnLOr2c0QBZh/6XnbSvKTga1avHds4bgt58z0+wBjTj
         Qi1uiF5NjTKVDNOLUeiSrhkEaFixOx425GqI1Ug2gKJTZkgz82wtGeRf1wbzD33JM0IG
         xrRaGPUsH+lzec7+/MUY9WlMC6xcI2zuI8CIdUmP4VYJaZ4IFYPpwiDDjeQbMz5zbWPs
         gcxSoqlegfmK+PCG1smf4Xh59iCHG+dJ+QuIqPM5+cdUwjjZvcsnWCPCWuAZ1Z6inuwz
         qY432SnBrWQc43zOKime//htNTL+fkZK/f/sr0CXxHAhAfQdAN8VjE+G0u5Yqu5MqmbM
         rMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681780710; x=1684372710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QL3vcHLGL2/hJ1GTkjkt4rjFUJx10zuB5gOnmaVkPTw=;
        b=LauwHvIFztV1QMTjAOuWyEm0bXew4CJyTXeaiEA7VLUMDUZXpgHQDXT0phjGgHvJY8
         GFtWk1LhLFfKzsUGvuHaS9oO4V59YqR+PTucn5d0S7P6bKpFesmaf2HzBik6nT8WPHyL
         xguMOAOSyBtfJuzmTOjyaUyBL/d+8jTI0Za9ILnBNYn9GiZUVoUzNq132bfS2zleBiZL
         unEjGxbtyaiENq2svQc7dTUzz/hDxEtUfdfk1ggqv4tHWHcwO2vRwsoLal58S/bSZTIa
         j2IWOQHKMHT3HxTMnIPwu5i6TYxEK6CrO5MQ+owVnTVdsQDB2zX1GicbwS3lA4Q+/kPN
         v0dg==
X-Gm-Message-State: AAQBX9fkTWaqeXDVZrz0tG1ooFfEpeRWQ77jYFYuMD/p08KVoz+3x1lU
        7z2XoUTile1S4Rj2ZL/BZAIjxhxnAnM=
X-Google-Smtp-Source: AKy350adGvzahF3XaouG5qekk96X4kQf+o8lJAUIUC6ibye8hNNhSheVLC9dbK5OL1w890hZpi7TeQ==
X-Received: by 2002:a4a:4586:0:b0:546:85cf:86ef with SMTP id y128-20020a4a4586000000b0054685cf86efmr2609227ooa.0.1681780709824;
        Mon, 17 Apr 2023 18:18:29 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id n6-20020a4a4006000000b0053b547ebee7sm5329074ooa.1.2023.04.17.18.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 18:18:29 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] doc: remove custom callouts format
Date:   Mon, 17 Apr 2023 19:18:28 -0600
Message-Id: <20230418011828.47851-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code to render callouts for manpages comes from 17 years ago:
776e994af5 (Properly render asciidoc "callouts" in git man pages.,
2006-04-28), and it was needed back then, but DocBook Stylesheets added
support for that in 2008 [1], since 1.74.0 it hasn't been necessary.

What's worse: the format of the upstream callouts is much nicer than our
hacked version.

Compare this:

     $ git diff            (1)
     $ git diff --cached   (2)
     $ git diff HEAD       (3)

  1. Changes in the working tree not yet staged for the next
     commit.
  2. Changes between the index and your last commit; what you
     would be committing if you run git commit without -a
     option.
  3. Changes in the working tree since your last commit; what
     you would be committing if you run git commit -a

To this:

     $ git diff            (1)
     $ git diff --cached   (2)
     $ git diff HEAD       (3)

 1. Changes in the working tree not yet staged for the next commit.
 2. Changes between the index and your last commit; what you would
 be committing if you run git commit without -a option.
 3. Changes in the working tree since your last commit; what you
 would be committing if you run git commit -a

Let's drop our unnecessary inferior custom format and use the official
one.

[1] https://sourceforge.net/p/docbook/code/7842/

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/manpage-normal.xsl | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/manpage-normal.xsl b/Documentation/manpage-normal.xsl
index a9c7ec69f4..e4c5874ed3 100644
--- a/Documentation/manpage-normal.xsl
+++ b/Documentation/manpage-normal.xsl
@@ -8,19 +8,4 @@
 <xsl:param name="man.output.quietly" select="1"/>
 <xsl:param name="refentry.meta.get.quietly" select="1"/>
 
-<!-- convert asciidoc callouts to man page format -->
-<xsl:template match="co">
-	<xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
-</xsl:template>
-<xsl:template match="calloutlist">
-	<xsl:text>.sp&#10;</xsl:text>
-	<xsl:apply-templates/>
-	<xsl:text>&#10;</xsl:text>
-</xsl:template>
-<xsl:template match="callout">
-	<xsl:value-of select="concat('\fB',substring-after(@arearefs,'-'),'. \fR')"/>
-	<xsl:apply-templates/>
-	<xsl:text>.br&#10;</xsl:text>
-</xsl:template>
-
 </xsl:stylesheet>
-- 
2.40.0+fc1

