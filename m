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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5E7C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 13:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFBD20714
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 13:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syjPumuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgC2NSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 09:18:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41649 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgC2NSd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 09:18:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id n17so14950148lji.8
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yiryRC6damv7g03Yfa5HVJ0+hEyp+Afk58yvYATnmoE=;
        b=syjPumuQjazl4lq8bcpMF+ZKI4DBljY6zJ72Gcf0WvrYYtcJRAGNOuP71MDI5K7gIU
         oBJOzxJF9dK9dPaAP6qzeXnM6LEYide8fRdRDmeoeJ+XskdDH0tqJu2nYRcTcknMFcLk
         00EE/XogT9+fHal8x0FG1zSrDn8KcgigMMUjT7cfwh+vvR+uDn/aPu+PU+t1exPcVMbo
         bz62Mcnfqox3FbnbiLAsuvSREV3eSPEs7orlRY83j6yB1xntXmqBqTWL82uM2K2vtZ0B
         gf/yQ40XpfZJTbrxk+i7Ko+Kbb0E/72Po25+cg20oDxgdFxhaQa46aukUPeL0hipXNZa
         R3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yiryRC6damv7g03Yfa5HVJ0+hEyp+Afk58yvYATnmoE=;
        b=HjNlGXkkPS6/BruRyWkf5vn8BybGVa1USEXzDJ243Wzh+5bYghElXw3HrLy5eCEfki
         f+Nlu2cQNboj3ICezkkJIPrq4YUrZ8Wsjpxzdvtv7DBlrUaMTb5q16T81jw/rq+nEkDY
         f96IEz92/uRLMTmukPA3AF7xtlxEAE8N5UJsWIuM8NFiQ90FPfPhuRmL6bi8sqDE+PsK
         gEes1GkD4ysRJJALcmHQhSrMT5KInHUEJnV6vX7l9mb1Krvvu+4Nopkmnc3ZIN9e4yin
         /jQXGdI8xtq/yZKZELbIRaiSYeoqgfW0VroWxrHbx8vEi5tXE5tGJkhqh6mNh/fTuLKX
         69Ag==
X-Gm-Message-State: AGi0PuY6WUUyrIBGOKb9b30UkqZMtcs6ZhuBw3quMdU6CBdxpquXrjEh
        NQPN4zFpW0GJz3oXqfnIVovvfz+N
X-Google-Smtp-Source: APiQypKAzRxoQcUmuzaPqN2WiSmxc00XkA2alHci120mMyq8adDxGBRwLnaVw0oBbo+7M+Q6WUfwSg==
X-Received: by 2002:a2e:3309:: with SMTP id d9mr4746677ljc.73.1585487910817;
        Sun, 29 Mar 2020 06:18:30 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id d16sm1247742lfm.91.2020.03.29.06.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 06:18:30 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 3/6] Doc: drop support for docbook-xsl before 1.73.0
Date:   Sun, 29 Mar 2020 15:18:07 +0200
Message-Id: <5256704a10af3869278d198eb3e5c9ef4aa503bd.1585486103.git.martin.agren@gmail.com>
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

Drop the DOCBOOK_XSL_172 config knob, which was needed with docbook-xsl
1.72 (but neither 1.71 nor 1.73). Version 1.73.0 is more than twelve
years old.

Together with the last few commits, we are now at a point where we don't
have any Makefile knobs to cater to old/broken versions of docbook-xsl.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/Makefile           | 10 ----------
 Documentation/manpage-1.72.xsl   | 14 --------------
 Documentation/manpage-normal.xsl |  3 +--
 Makefile                         |  3 ---
 INSTALL                          |  5 ++---
 5 files changed, 3 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/manpage-1.72.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c7a8fc99cf..e235c54344 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -149,16 +149,6 @@ endif
 -include ../config.mak.autogen
 -include ../config.mak
 
-#
-# For docbook-xsl ...
-#	-1.71.1,	not supported
-#	1.72.0,		set DOCBOOK_XSL_172.
-#	1.73.0-,	no extra settings are needed
-#
-
-ifdef DOCBOOK_XSL_172
-MANPAGE_XSL = manpage-1.72.xsl
-endif
 ifndef NO_MAN_BOLD_LITERAL
 XMLTO_EXTRA += -m manpage-bold-literal.xsl
 endif
diff --git a/Documentation/manpage-1.72.xsl b/Documentation/manpage-1.72.xsl
deleted file mode 100644
index b4d315cb8c..0000000000
--- a/Documentation/manpage-1.72.xsl
+++ /dev/null
@@ -1,14 +0,0 @@
-<!-- manpage-1.72.xsl:
-     special settings for manpages rendered from asciidoc+docbook
-     handles peculiarities in docbook-xsl 1.72.0 -->
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
-		version="1.0">
-
-<xsl:import href="manpage-base.xsl"/>
-
-<!-- these are the special values for the roff control characters
-     needed for docbook-xsl 1.72.0 -->
-<xsl:param name="git.docbook.backslash">&#x2593;</xsl:param>
-<xsl:param name="git.docbook.dot"      >&#x2302;</xsl:param>
-
-</xsl:stylesheet>
diff --git a/Documentation/manpage-normal.xsl b/Documentation/manpage-normal.xsl
index a48f5b11f3..c9c68a0542 100644
--- a/Documentation/manpage-normal.xsl
+++ b/Documentation/manpage-normal.xsl
@@ -1,6 +1,5 @@
 <!-- manpage-normal.xsl:
-     special settings for manpages rendered from asciidoc+docbook
-     handles anything we want to keep away from docbook-xsl 1.72.0 -->
+     special settings for manpages rendered from asciidoc+docbook -->
 <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 		version="1.0">
 
diff --git a/Makefile b/Makefile
index 0e0a6badc1..b596691a12 100644
--- a/Makefile
+++ b/Makefile
@@ -282,9 +282,6 @@ all::
 # Define NO_ST_BLOCKS_IN_STRUCT_STAT if your platform does not have st_blocks
 # field that counts the on-disk footprint in 512-byte blocks.
 #
-# Define DOCBOOK_XSL_172 if you want to format man pages with DocBook XSL v1.72
-# (not v1.73 or v1.71).
-#
 # Define GNU_ROFF if your target system uses GNU groff.  This forces
 # apostrophes to be ASCII so that cut&pasting examples to the shell
 # will work.
diff --git a/INSTALL b/INSTALL
index 07a283fcf2..b244949615 100644
--- a/INSTALL
+++ b/INSTALL
@@ -206,9 +206,8 @@ Issues of note:
    clone two separate git-htmldocs and git-manpages repositories next
    to the clone of git itself.
 
-   The minimum supported version of docbook-xsl is 1.72.
-   It has been reported that docbook-xsl version 1.72 and 1.73 are
-   buggy; 1.72 misformats manual pages for callouts, and 1.73 needs
+   The minimum supported version of docbook-xsl is 1.73.
+   It has been reported that docbook-xsl version 1.73 is buggy; it needs
    the patch in contrib/patches/docbook-xsl-manpages-charmap.patch
 
    Users attempting to build the documentation on Cygwin may need to ensure
-- 
2.26.0

